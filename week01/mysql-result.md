\# MySQL SQL 运行结果



\## 运行命令



Get-Content .\\week01\\first-sql-mysql.sql | mysql -h localhost -P 3306 -u root -p



\## 结果



成功创建并使用数据库 db\_course\_week01。



脚本创建了 users 表，插入两条数据，并按 id 查询。结果为：



\- Ada，角色为 student

\- Grace，角色为 teacher



\## 证据



运行截图见 images/mysql-result.png。

