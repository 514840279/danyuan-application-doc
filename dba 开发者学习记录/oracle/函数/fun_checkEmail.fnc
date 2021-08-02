create or replace function fun_checkemail(v_mail varchar2) return varchar2 as
  r_result varchar(50);
  p_email  varchar(50);
begin
  r_result := '1';

  select 1
    into p_email
    from dual
   where regexp_like(trim(v_mail),
                     '^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$');
  if p_email is null then
    r_result := '0';
  end if;
  return r_result;
end fun_checkemail;
/
