create or replace function fun_checkidcard(p_idcard in varchar2) return int is
  v_regstr    varchar2(2000);
  v_sum       number;
  v_mod       number;
  v_checkcode char(11) := '10X98765432';
  v_checkbit  char(1);
  v_areacode  varchar2(2000) := '11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91,';
begin
  case lengthb(p_idcard)
    when 15 then
      -- 15位
      if instrb(v_areacode, substr(p_idcard, 1, 2) || ',') = 0 then
        return 0;
      end if;
    
      if mod(to_number(substrb(p_idcard, 7, 2)) + 1900, 400) = 0 or
         (mod(to_number(substrb(p_idcard, 7, 2)) + 1900, 100) <> 0 and
          mod(to_number(substrb(p_idcard, 7, 2)) + 1900, 4) = 0) then
        -- 闰年
        v_regstr := '^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$';
      else
        v_regstr := '^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$';
      end if;
    
      if regexp_like(p_idcard, v_regstr) then
        return 1;
      else
        return 0;
      end if;
    when 18 then
      -- 18位
      if instrb(v_areacode, substrb(p_idcard, 1, 2) || ',') = 0 then
        return 0;
      end if;
    
      if mod(to_number(substrb(p_idcard, 7, 4)), 400) = 0 or
         (mod(to_number(substrb(p_idcard, 7, 4)), 100) <> 0 and
          mod(to_number(substrb(p_idcard, 7, 4)), 4) = 0) then
        -- 闰年
        v_regstr := '^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$';
      else
        v_regstr := '^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$';
      end if;
    
      if regexp_like(p_idcard, v_regstr) then
        v_sum      := (to_number(substrb(p_idcard, 1, 1)) +
                      to_number(substrb(p_idcard, 11, 1))) * 7 +
                      (to_number(substrb(p_idcard, 2, 1)) +
                      to_number(substrb(p_idcard, 12, 1))) * 9 +
                      (to_number(substrb(p_idcard, 3, 1)) +
                      to_number(substrb(p_idcard, 13, 1))) * 10 +
                      (to_number(substrb(p_idcard, 4, 1)) +
                      to_number(substrb(p_idcard, 14, 1))) * 5 +
                      (to_number(substrb(p_idcard, 5, 1)) +
                      to_number(substrb(p_idcard, 15, 1))) * 8 +
                      (to_number(substrb(p_idcard, 6, 1)) +
                      to_number(substrb(p_idcard, 16, 1))) * 4 +
                      (to_number(substrb(p_idcard, 7, 1)) +
                      to_number(substrb(p_idcard, 17, 1))) * 2 +
                      to_number(substrb(p_idcard, 8, 1)) * 1 +
                      to_number(substrb(p_idcard, 9, 1)) * 6 +
                      to_number(substrb(p_idcard, 10, 1)) * 3;
        v_mod      := mod(v_sum, 11);
        v_checkbit := substrb(v_checkcode, v_mod + 1, 1);
      
        if v_checkbit = upper(substrb(p_idcard, 18, 1)) then
          return 1;
        else
          return 0;
        end if;
      else
        return 0;
      end if;
    else
      return 0; -- 身份证号码位数不对
  end case;
exception
  when others then
    return 0;
end fun_checkidcard;
/
