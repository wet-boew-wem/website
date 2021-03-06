```
title: System Requirements
layout: architecture
tags: ['architecture']
```

Drupal WxT can run on a wide range of desktop and server operating systems including Windows, MacOS, Linux and UNIX. However, you will need to configure the environment according to the standard Drupal 7 requirements. This page provides a brief summary of those requirements and recommendations. More information is available from the [system requirements page][system_requirements] at Drupal.org.

## Web server

* Apache 2.x
* Microsoft IIS
* NGINX (Fastest)

## Database server

* PostgreSQL 8.4 or higher with PDO (Recommended)
* MySQL 5.0.15 or higher with PDO
*  SQLite 3.3.7 or higher
* [Microsoft SQL Server][sqlsrv], and [Oracle][oracle] are supported by additional modules

## PHP

* 5.3.4+
* 5.4.4+ (Recommended)

## Tips

Installing a PHP accelerator is highly recommended, especially for production use, such as [APC][apc] for Apache or [WinCache][wincache] for IIS. On all platforms, change the memory_limit variable in php.ini to be at least 256M. If you are still having problems (seeing “white screens” or errors during installation) try setting:

* max_execution_time to around 120
* realpath_cache_size to 512K, 1M or even 2M
* max_input_time to around 120

Additionally, if using MySQL:
* innodb_flush_log_at_trx_commit to 2
* max_allowed_packet to 96


<!-- Links Referenced -->

[system_requirements]:          http://drupal.org/requirements
[sqlsrv]:                       https://drupal.org/project/sqlsrv
[oracle]:                       https://drupal.org/project/oracle
[apc]:                          http://pecl.php.net/package/APC
[wincache]:                     http://www.iis.net/downloads/microsoft/wincache-extension
