create or replace function fun_checkorgcode(organizationcode varchar2)
/*
    organizationCode：要验证的统一社会信用代码
  */
 return varchar2 is
  codesum  number(10) := 0;
  code     varchar(100);
  n_length number(2);
  code_jy  varchar(1);
  code_end varchar(1);
  jycode   number(2);
  /*字符与字符的值，每个字符后两位为该字符的字符数值*/
  ci char(35) := '0123456789ABCDEFGHJKLMNPQRTUWXY';
  /*字符的加权因子*/
  --后面没用，加权因子通过算式算出来了
  type v_ar is varray(18) of number;
  wi v_ar := v_ar(1, 3, 9, 27, 19, 26, 16, 17, 20, 29, 25, 13, 8, 24, 10, 30,
                  28);
begin
  /*判断是否为null*/
  if (organizationcode is null) then
    begin
      return '为空！';
    end;
  end if;
  code     := rtrim(ltrim(replace(organizationcode, '-', ''))); /*把-,前后空格去掉*/
  n_length := lengthb(code);
  /*验证长度是否正确*/
  /*验证机构代码是由数字和大写字母组成*/
  if not
      regexp_like(code, '^[1-9A-GY]{1}[1239]{1}[1-5]{1}[0-9]{5}[0-9A-Z]{10}$') then
    return '长度不正确或格式不对';
  end if;
  /*字符的字符数值分别乘于该位的加权因子，然后求和*/
  for i in 1 .. (n_length - 1)
  loop
    codesum := codesum + mod(power(3, (i - 1)), 31) *
               (to_number(instr(ci, substr(code, i, 1))) - 1);
  end loop;
  /* 计算校验码jycode*/
  jycode := 31 - mod(codesum, 31);
  if (jycode = 31) then
    jycode := 0;
  end if;
  code_jy := substr(ci, to_number(jycode + 1), 1);
  --获取最后一位校验码
  code_end := substr(code, -1);
  /*验证校验码code_end*/
  /*验证计算出的校验结果*/
  if (code_jy <> to_char(code_end)) then
    return '校验合法性失败';
  end if;
  return '1';
exception
  when others then
    raise;
end fun_checkorgcode;
/
