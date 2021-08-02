create or replace function fun_substr
(
  str  in varchar2,
  str1 in varchar2,
  str2 in varchar2
) return varchar2 is
  res varchar2(4000);
begin
  if (instr(str, str1) = 0) then
    return null;
  end if;
  if (str2 is null) then
    res := trim(substr(str, instr(str, str1) + length(str1)));
  else
    res := trim(substr(str, instr(str, str1) + length(str1),
                       instr(str, str2) - instr(str, str1) - length(str1)));
  end if;

  return(res);
end fun_substr;
/
