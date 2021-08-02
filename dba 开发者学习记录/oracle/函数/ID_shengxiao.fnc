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
                
                0, ' Û', 1, '≈£', 2, 'ª¢', 3, 'Õ√', 4, '¡˙', 5, '…ﬂ', 6, '¬Ì', 7,
                '—Ú', 8, '∫Ô', 9, 'º¶', 10, 'π∑', 11, '÷Ì')
    into v_shengxiao
    from dual;
  return v_shengxiao;
exception
  when others then
    return null;
end id_shengxiao;
/
