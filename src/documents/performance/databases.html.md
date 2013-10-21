```
title: Databases
layout: performance
tags: ['databases','performance']
```

There are a variety of Databases you can use with Drupal WxT each with there own set of caveats and use cases.

The following is a curated and best practice list of the databases we recommend you consider when using Drupal WxT in order of preference.

Note: Drupal can support other databases such as Microsoft SQL Server and Oracle but these have not been extensively tested with Drupal WxT.

## PostgreSQL

[PostgreSQL][postgresql], often simply Postgres, is an open source object-relational database management system (ORDBMS) with an emphasis on extensibility and standards compliance. It is released under the PostgreSQL License, a free/open source software license, similar to the MIT License. PostgreSQL is developed by the PostgreSQL Global Development Group, consisting of a handful of volunteers employed and supervised by companies such as Red Hat and EnterpriseDB. It implements the majority of the SQL:2011 standard, is ACID-compliant, is fully transactional (including all DDL statements), has extensible data types, operators, index methods, functions, aggregates, procedural languages, and has a large number of extensions written by third parties. PostgreSQL is available for many platforms including Linux, FreeBSD, Solaris, Microsoft Windows and Mac OS X.

## Percona

A free open source solution, Percona Server is a MySQL alternative which offers breakthrough performance, scalability, features, and instrumentation. Self-tuning algorithms and support for extremely high-performance hardware make it the clear choice for organizations that demand excellent performance and reliability from their MySQL database server. [Find out how][percona_how] or [compare Percona Server to MySQL][percona_compare].

## MySQL

[MySQL][mysql] is the one of the three most commonly used relational database management systems in use on the Internet and powers well known sites such as Flick, Youtube, Wikipedia, Google, Facebook, and Twitter. MySQL is an open-source solution that can be compiled or installed from a binary package and is available for multiple operating systems.

MySQL was acquired by Oracle Corporation in 2008, and Oracle now offers several versions. There is a community open-source edition, as well as a licensed Enterprise Edition and a Cluster Edition that offer the same capabilities as the community edition, but with additional features and support. The Enterprise Edition includes additional features such as replication, additional thread scaling, and external security authentication for Windows Active Directory. The Cluster Edition offers database partitioning across servers for scalability and failover capabilities for high availability.

<!-- Links Referenced -->

[percona]:          http://percona.com
[percona_how]:      http://www.percona.com/software/percona-server#find-out-how
[percona_compare]:  http://www.percona.com/software/percona-server/feature-comparison
[postgresql]:       http://postgresql.org
[mysql]:            https://mysql.com
