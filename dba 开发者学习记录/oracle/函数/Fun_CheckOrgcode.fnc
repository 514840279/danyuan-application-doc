create or replace function fun_checkorgcode(organizationcode varchar2)
/*
    organizationCode��Ҫ��֤��ͳһ������ô���
  */
 return varchar2 is
  codesum  number(10) := 0;
  code     varchar(100);
  n_length number(2);
  code_jy  varchar(1);
  code_end varchar(1);
  jycode   number(2);
  /*�ַ����ַ���ֵ��ÿ���ַ�����λΪ���ַ����ַ���ֵ*/
  ci char(35) := '0123456789ABCDEFGHJKLMNPQRTUWXY';
  /*�ַ��ļ�Ȩ����*/
  --����û�ã���Ȩ����ͨ����ʽ�������
  type v_ar is varray(18) of number;
  wi v_ar := v_ar(1, 3, 9, 27, 19, 26, 16, 17, 20, 29, 25, 13, 8, 24, 10, 30,
                  28);
begin
  /*�ж��Ƿ�Ϊnull*/
  if (organizationcode is null) then
    begin
      return 'Ϊ�գ�';
    end;
  end if;
  code     := rtrim(ltrim(replace(organizationcode, '-', ''))); /*��-,ǰ��ո�ȥ��*/
  n_length := lengthb(code);
  /*��֤�����Ƿ���ȷ*/
  /*��֤���������������ֺʹ�д��ĸ���*/
  if not
      regexp_like(code, '^[1-9A-GY]{1}[1239]{1}[1-5]{1}[0-9]{5}[0-9A-Z]{10}$') then
    return '���Ȳ���ȷ���ʽ����';
  end if;
  /*�ַ����ַ���ֵ�ֱ���ڸ�λ�ļ�Ȩ���ӣ�Ȼ�����*/
  for i in 1 .. (n_length - 1)
  loop
    codesum := codesum + mod(power(3, (i - 1)), 31) *
               (to_number(instr(ci, substr(code, i, 1))) - 1);
  end loop;
  /* ����У����jycode*/
  jycode := 31 - mod(codesum, 31);
  if (jycode = 31) then
    jycode := 0;
  end if;
  code_jy := substr(ci, to_number(jycode + 1), 1);
  --��ȡ���һλУ����
  code_end := substr(code, -1);
  /*��֤У����code_end*/
  /*��֤�������У����*/
  if (code_jy <> to_char(code_end)) then
    return 'У��Ϸ���ʧ��';
  end if;
  return '1';
exception
  when others then
    raise;
end fun_checkorgcode;
/
