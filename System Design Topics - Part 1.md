# System Design Topics

## Reverse Proxy vs API Gateway vs Load Balancer

- *Reverse Proxy* - Intermediate server between webservers for return response to the client. Benefits : Hiding identities of backend servers (increased security), Load distribution, SSL termination, Compression, Caching, Managing requests efficiently 
- *API Gateway* - Single entry point for request. Routing request, Authentication, Authorization, Monitoring, Rate limiting. API gateways provides a unified interface for managing complexity of handling multiple services, efficient communication between clients and services.
- *Load Balancer* - Distributes incoming network requests across a group of backend servers and ensures high availability and reliability by directing requests only to healthy servers. It can dynamically add or remove servers as request volumes fluctuate. Load balancers use various algorithms like round robin, least connections, and IP hash to efficiently distribute client requests and network load.

In conclusion, reverse proxies, API gateways, and load balancers are essential for managing traffic, services, and security in web-scale applications. They work together to enable applications to handle large volumes of traffic reliably and securely.

## File Descriptor

A file descriptor represents an open file. It is a unique number assigned by the operating system to each file. It is an abstraction for working with files. Each process maintains its own file descriptor table. 

- *In User Space* - Open a file "fileA.txt" in process 1234, we get file descriptor fd1 equal to 3. Pass the file descriptor to other functions to write data to the file.
- *In Kernel Space* - There is a **process table** to maintain the data for the processes. Each process has an entry in the table. Each process maintains a file descriptor table, with file descriptors as its indices. 

The file pointer points to an entry in the **open file table**, which has information about open files across all processes. Multiple file descriptors can point to the same file table entry. 

In each file table entry, there is a vnode pointer, which points to an entry in **vnode table**. The static information includes file type, function pointers, reference counts, inode etc. inode describes a physical object in the filesystem.

- *In Filesystem* - The inode array element stores the actual file information, including permission mode, owners, timestamps, etc. inode also points to the data blocks stored in the filesystem.


## ACID Properties

- Atomicity - The transaction is an all-or-nothing deal. If any part of the transaction fails, the whole thing gets rolled back like it never happened.

  Ex: A banking app that transfers $100 from Alice to Bob. This means updating two things: subtracting $100 from Alice's balance and adding $100 to Bob's balance. Atomicity ensures that both updates either happen together or not at all.

- Consistency - A transaction must follow all the rules and leave the database in a good state. Any data written during a transaction must be valid according to constraints, triggers, and other rules we set up. The database system itself enforces consistency by automatically checking for constraint violations during transactions.

  Ex: We have a rule that user account balances can't go negative. If a transaction tries to withdraw more money than a user has, the database system will detect this consistency violation and cancel the transaction to keep the database consistent. 

- Isolation - All about how concurrent transactions interact with each other. Even if many transactions are running at the same time, isolation makes it seem like each transaction has the database all to itself. The highest level of isolation is called serializable (It makes transactions run one after another as if they were in a single line). The lower levels of isolation can sometimes lead to inconsistencies like dirty reads, non-repeatable reads, and phantom reads.

  - Dirty read - When a transaction sees data that was changed by another transaction that's not been commited yet. Read commited isolation level prevents dirty reads by making sure a transaction can only see committed data. Ex - T1 withdraws ₹20 but doesn't commit. Another transaction T2 reads before T1 commits and will see ₹100.
  - Non-repeatable read - When a transaction reads the same data twice and gets different results because another transaction changed the data in between. Ex - T1 check balance and see ₹100. T2 withdraws ₹20 and commits. If same transaction T1 reads, it sees balance ₹80.
  - Phantom read - When a transaction reruns a query and gets different results because another transaction added or deleted rows that match the search criteria. Ex - T1 lists all bank transfers under ₹100. Another transaction T2 adds a ₹50 transfer and commits. If T1 reruns its query, see the ₹50 transfer that wasn't there before.

- Durability - Once a transaction is committed, it's permanent even if database crashes or loses power right after. Usually achieved by writing transaction logs or using write-ahead logging to persist changes to disk before confirming the commit. Distributed databases maintains durability by replicating data across multiple nodes so if one node goes down, other doesn't lose any commited transactions.

## Client Architecture Patterns

- Model View Controller (MVC)
- MVP
- MVVM
- MVVM-C


## 10 Coding Principles

- Consistent Coding Style
- Comments
- Robustness

Single Responsibility Principle (SRP)
Open/Closed Principle (OCP)
Liskov Substitution Principle (LSP)
Interface Segregation Principle (ISP)
Dependency Inversion Principle (DIP)

- Make Testing Easy
- Abstraction
- Utilize Design Patterns, but don't over design

MVC

- Reduce Global Dependencies
- Continous Refractoring
- Security is a Top Priority

## KISS, SOLID, CAP, BASE

CAP stands for:
- Consistency - Every read gets the most recent write or returns an error.
- Availability - Every request gets a response even if it's not the latest data.
- Partition Tolerance

PACEL stands for Partition Tolerance, Availability, Consistency, Latency, and eventually Consistency. It states that if a partition happens you must choose between availability and consistency, just like in CAP. But when there's no partition, you still have to choose between latency and consistency.

BASE stands for
- Basically Available means the system appears available most of the time even if some parts fail. 
- Soft State implies that data might change over time. 
- Eventual Consistency means that the database doesn't guarantee that all transactions are seen by all users immediately, but eventually all reads will return the latest value.

SOLID stands for
- Single Responsibility Principle: A class should only have one reason to change.
- Open/Closed Principle: Classes should be open for extension but closed for modification.
- Liskov Substitution Principle: Objects of a superclass should be replaceable with objects of its subclasses without affecting the program's correctness.
- Interface Segregation Principle: Clients shouldn't be forced to depend on methods they do not use.
- Dependency Inversion Principle: High-level modules should not depend on low-level modules. Both should depend on abstractions.

KISS => Keep It Simple Stupid, emphasizes that simple designs are usually better.
