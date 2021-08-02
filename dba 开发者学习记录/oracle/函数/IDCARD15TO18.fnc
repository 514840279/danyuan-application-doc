create or replace function idcard15to18(card varchar2) return varchar2 is
  type tiarray is table of integer;
  type tcarray is table of char(1);
  results varchar2(18);
  w       tiarray; --数字数组
  a       tcarray; --字符数组
  s       integer;
begin
  if card is null then
    return '';
  end if;
  if length(card) <> 15 then
    return card;
  end if;
  w       := tiarray(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
  a       := tcarray('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
  results := substr(card, 1, 6) || '19' || substr(card, 7, 9);
  s       := 0;
  begin
    for i in 1 .. 17
    loop
      s := s + to_number(substr(results, i, 1)) * w(i);
    end loop;
  exception
    when others then
      return '';
  end;
  s       := s mod 11;
  results := results || a(s + 1);
  return(results);
exception
  when others then
    return '';
end idcard15to18;
/
