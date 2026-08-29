\# SQLite SQL 运行结果



\## 运行命令



Get-Content .\\week01\\first-sql-sqlite.sql | sqlite3 -header -column .\\week01\\week01.db



\## 结果



成功创建了 users 表，并插入两条数据：



\- Ada，角色为 student

\- Grace，角色为 teacher



最后按 id 从小到大的顺序查询，结果正确显示了两条数据。



\## 证据



运行截图见 images/sqlite-result.png。

