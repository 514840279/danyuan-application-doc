create or replace function parsejson
(
  p_jsonstr varchar2,
  p_key     varchar2
) return varchar2 as
  rtnval    varchar2(1000);
  i         number(2);
  jsonkey   varchar2(500);
  jsonvalue varchar2(1000);
  json      varchar2(3000);
begin
  if p_jsonstr is not null then
    json := replace(p_jsonstr, '{', '');
    json := replace(json, '}', '');
    json := replace(json, '"', '');
    for temprow in (select strvalue as value from table(fn_split(json, ',')))
    loop
      if temprow.value is not null then
        i         := 0;
        jsonkey   := '';
        jsonvalue := '';
        for tem2 in (select strvalue as value
                       from table(fn_split(temprow.value, ':')))
        loop
          if i = 0 then
            jsonkey := tem2.value;
          end if;
          if i = 1 then
            jsonvalue := tem2.value;
          end if;
        
          i := i + 1;
        end loop;
      
        if (jsonkey = p_key) then
          rtnval := jsonvalue;
        end if;
      end if;
    end loop;
  end if;
  return rtnval;
end parsejson;
/
