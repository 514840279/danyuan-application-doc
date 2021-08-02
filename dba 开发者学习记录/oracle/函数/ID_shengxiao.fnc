create or replace function id_shengxiao(id_card varchar2) return varchar2 is
  v_shengxiao varchar2(8);
  v_nian      number;
begin

  if length(id_card) != 15 and length(id_card) != 18 then
    return null;
  end if;

  select to_number(decode(length(id_card), 18, substr(id_card, 7, 4), 15,
                          '19' || substr(id_card, 7, 2)))
    into v_nian
    from dual;

  select decode(mod(v_nian - 1900, 12),
                
                0, '��', 1, 'ţ', 2, '��', 3, '��', 4, '��', 5, '��', 6, '��', 7,
                '��', 8, '��', 9, '��', 10, '��', 11, '��')
    into v_shengxiao
    from dual;
  return v_shengxiao;
exception
  when others then
    return null;
end id_shengxiao;
/
