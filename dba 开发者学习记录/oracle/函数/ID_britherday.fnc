create or replace function id_britherday(id_card varchar2) return varchar2 is
  v_day varchar2(8);
begin

  if length(id_card) != 15 and length(id_card) != 18 then
    return null;
  end if;

  select decode(length(id_card), 18, substr(id_card, 7, 8), 15,
                '19' || substr(id_card, 7, 6))
    into v_day
    from dual;
  return v_day;
exception
  when others then
    return null;
end id_britherday;
/
