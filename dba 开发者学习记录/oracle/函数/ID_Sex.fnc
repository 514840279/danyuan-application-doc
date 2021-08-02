create or replace function id_sex(id_card varchar2) return varchar2 is
  v_sex varchar2(8);
begin

  if length(id_card) != 15 and length(id_card) != 18 then
    return null;
  end if;

  if length(id_card) = 18 then
    select decode(mod(to_number(substr(id_card, 17, 1)), 2), 0, 'Å®', 'ÄÐ')
      into v_sex
      from dual;
  end if;

  if length(id_card) = 15 then
    select decode(mod(to_number(substr(id_card, 15, 1)), 2), 0, 'Å®', 'ÄÐ')
      into v_sex
      from dual;
  end if;
  return v_sex;
exception
  when others then
    return null;
end id_sex;
/
