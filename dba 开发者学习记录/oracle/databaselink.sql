-- Create database link 
create database link dblink_172_16_3_2
  connect to zhcx identified by zhcx
  using '(DESCRIPTION =
          (ADDRESS_LIST =
            (ADDRESS = (PROTOCOL = TCP)(HOST = 172.16.3.2)(PORT = 1521))
          )
          (CONNECT_DATA =
            (SERVER = DEDICATED)
            (SERVICE_NAME = orcl)
          )
        )';