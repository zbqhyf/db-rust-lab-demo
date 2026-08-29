\# 课程仓库代码地图



\## 6. 四个仓库分别解决什么问题



\- mini-db：用 Rust 实现的小型数据库管理系统，用于学习数据库内部原理，例如 B+ 树。

\- sqlrustgo：用 Rust 实现的 SQL 执行引擎，包含 SQL 执行、查询优化和事务等更完整的功能。

\- BustuX-EDU：目前无法下载，课程提供的链接返回 HTTP 403，等待教师提供可访问地址。

\- bustux：目前无法下载，课程提供的链接返回 HTTP 403，等待教师提供可访问地址。



\## 7. Planner、Executor、Catalog



目前缺少 BustuX-EDU 和 bustux 的源码，不能确认课程指定实现中的实际目录。拿到可访问仓库后，再通过目录名和 README 查找 parser、planner、executor、catalog 等模块。



\## 8. Buffer Pool、B+ Tree、事务



mini-db 的 README 明确说明项目包含 B+ 树。其他模块的具体目录需要在可访问的课程仓库中确认，不能凭空判断。



\## 9. sqlrustgo 的编程风格



sqlrustgo 使用 Rust 编写，功能按模块组织。项目不仅实现 SQL 执行，还包含查询优化、事务、行存储和列存储等数据库组件，属于较完整的工程化实现。



\## 10. 我最感兴趣的模块



我最感兴趣的是查询优化器。因为同一条 SQL 可以有不同的执行方法，优化器会选择成本更合适的方案，这会直接影响查询速度。

