\# Web App 到数据库的数据链路



\## 1. 架构图



```mermaid

flowchart LR

&#x20;   U\[用户：手机 / 浏览器] --> DNS\[DNS]

&#x20;   DNS --> CDN\[CDN]

&#x20;   CDN --> WAF\[WAF]

&#x20;   WAF --> LB\[负载均衡]



&#x20;   LB --> APP1\[App 1]

&#x20;   LB --> APP2\[App 2]



&#x20;   APP1 --> Redis\[(Redis 缓存)]

&#x20;   APP2 --> Redis

&#x20;   APP1 --> DB1\[(MySQL 主库)]

&#x20;   APP2 --> DB1

&#x20;   DB1 --> DB2\[(MySQL 从库)]



&#x20;   APP1 --> MQ\[消息队列]

&#x20;   APP2 --> MQ

&#x20;   MQ --> Worker\[后台 Worker]

&#x20;   Worker --> DB1



&#x20;   APP1 --> Obs\[日志 / 指标 / 链路追踪]

&#x20;   APP2 --> Obs

&#x20;   Worker --> Obs

```mermaid

flowchart TB

&#x20;   subgraph 用户侧

&#x20;       Phone\[手机]

&#x20;       Browser\[浏览器]

&#x20;   end



&#x20;   subgraph 边缘层

&#x20;       DNS2\[DNS]

&#x20;       CDN2\[CDN]

&#x20;       WAF2\[WAF]

&#x20;       LB2\[负载均衡]

&#x20;   end



&#x20;   subgraph 应用层

&#x20;       A1\[App 1]

&#x20;       A2\[App 2]

&#x20;   end



&#x20;   subgraph 数据层

&#x20;       R\[(Redis)]

&#x20;       M\[(MySQL 主库)]

&#x20;       S\[(MySQL 从库)]

&#x20;       Q\[消息队列]

&#x20;       W\[Worker]

&#x20;   end



&#x20;   Phone --> DNS2

&#x20;   Browser --> DNS2

&#x20;   DNS2 --> CDN2 --> WAF2 --> LB2

&#x20;   LB2 --> A1

&#x20;   LB2 --> A2

&#x20;   A1 --> R

&#x20;   A2 --> R

&#x20;   A1 --> M

&#x20;   A2 --> M

&#x20;   M --> S

&#x20;   A1 --> Q

&#x20;   A2 --> Q

&#x20;   Q --> W

&#x20;   W --> M

```

```mermaid

sequenceDiagram

&#x20;   participant U as 用户

&#x20;   participant CDN as CDN/WAF

&#x20;   participant LB as 负载均衡

&#x20;   participant App as App

&#x20;   participant Redis as Redis

&#x20;   participant DB as MySQL

&#x20;   participant MQ as 消息队列

&#x20;   participant Worker as Worker



&#x20;   U->>CDN: 提交订单 HTTPS 请求

&#x20;   CDN->>LB: 转发 API 请求

&#x20;   LB->>App: 分配到一个 App 实例

&#x20;   App->>Redis: 查询商品或用户缓存

&#x20;   Redis-->>App: 返回缓存结果

&#x20;   App->>DB: 写入订单并执行事务

&#x20;   DB-->>App: COMMIT 成功

&#x20;   App->>MQ: 发送订单后续任务

&#x20;   App-->>U: 返回下单成功

&#x20;   MQ->>Worker: 消费任务

&#x20;   Worker->>DB: 更新后续处理结果

```

11\. SQL 从 Web App 进入 RDBMS 的过程

SQL 先被 Parser 解析为数据库能理解的结构；Binder 检查表名、字段名和类型是否正确；Planner 选择执行方案；Executor 按计划执行。执行过程中会通过 Buffer Pool 读取数据页，使用 B+ 树查找数据，并通过事务和 WAL 保证数据可靠，最后把数据页写入磁盘。

12\. 为什么 COMMIT 成功才算结果可信

COMMIT 成功表示这次事务已经提交。数据库会保证事务的修改按规则完成，并在发生异常时能够依靠日志恢复，因此不能只看程序是否执行到一半。

13\. 为什么 Redis 不能代替数据库

Redis 主要用于缓存，速度快，但不适合代替需要长期可靠保存的数据。订单、用户等核心数据仍要保存到 MySQL；缓存失效或丢失后，可以再从数据库读取。

14\. 为什么耗时任务要异步处理

缩略图生成、推荐、报表、风控等任务可能很耗时。如果用户请求一直等待它们完成，页面会变慢。把任务放到消息队列，让 Worker 在后台处理，用户可以先得到响应。

15\. Worker 如何分工

可以让不同 Worker 处理不同类型的任务。例如，一个 Worker 发送订单通知，另一个 Worker 生成报表。消息队列负责分发任务，Worker 完成后再把结果写回数据库。

