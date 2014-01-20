```
title: Drush Make
description: Drush all the things!
layout: architecture
tags: ['architecture']
```

Drupal WxT uses Drush Make for a rapid built-out of the Drupal codebase. A drush make file is similar to an "ant script" and allows us to host just the code that we are developing (Installation Profile and Custom Modules, Features, and Themes) on GitHub. Any user who has Drush installed can then perform a build-out of both the Drupal Core package and various contributed modules hosted on Drupal.org.

1. Ensure you have the appropriate base requirements setup for Drupal as per the [System Requirements][system_requirements] documentation.

2. Install Drush 5.8 or higher (inlcudes Drush Make):
  * a) Linux, Mac OSX: Follow instructions at [drupal.org][drush_server_install]
  * b) Windows: [Installer][drush_win_install]

3. Install Git 1.7.10 or higher (Some lower versions of git do not apply patches from the make file with Drush Make):
  * a) Linux, Mac OSX: [Installer][git_osx_install]
  * b) Windows: [Installer][git_win_install]

4. Clone this repository into a directory using the following commands on the Git Bash command prompt:

  ``` bash
  git clone https://github.com/wet-boew/wet-boew-drupal.git wet-boew-drupal
  ```

5. Build the Drupal installation profile

  * a) On a Unix-like system:
  ``` bash
  drush make --prepare-install --no-gitinfofile --working-copy wet-boew-drupal/build-wetkit-github.make /var/www/html --yes
  ```

  * b) On Windows:
  ``` bash
  drush make --prepare-install --no-gitinfofile --working-copy wet-boew-drupal/build-wetkit-github.make C:\inetpub\wwwroot\Website1\ --yes
  ```

6. Quickly install using the Drush CLI (Password must not be simple or won't install)

  * a) For example, on a MySQL database:
  ``` bash
  drush si wetkit wetkit_theme_selection_form.theme=wetkit_omega install_configure_form.demo_content=TRUE --sites-subdir=default --db-url=mysql://root:@127.0.0.1:3306/wetkit_db --account-name=admin --account-pass=WetKit@2013 --site-mail=admin@example.com --site-name='Web Experience Toolkit' --yes
  ```

  * b) For a PostgreSQL database, change the --db-url option to:
  ``` bash
  --db-url=pgsql://drupalusr:drupalpass@127.0.0.1/wetkit_db
  ```

  * c) For a Microsoft SQL Server database, change the --db-url option to:
  ``` bash
  --db-url=sqlsrv://drupalusr:drupalpass@127.0.0.1:1433/wetkit_db
  ```

7. Fix Permissions

  Depending on your server set-up you will have to make sure that the /sites/default/files or /sites/&lt;domain&gt;/files directory has the correct owner (webserver):

  * a) On a Unix-like system:
  ``` bash
  chown -R apache:apache /sites/domain/files
  ```
  Note that on Ubuntu Linux the apache user is 'www-data';

  * b) On Windows:
  <!-- icacls sites\default\settings.php /grant BUILTIN\IIS_IUSRS:(W)-->
  ``` bash
  icacls sites\default\files /grant BUILTIN\IIS_IUSRS:(OI)(CI)(M)
  ```

<!-- Links Referenced -->

[drush_server_install]:         http://drupal.org/node/477684
[drush_win_install]:            http://drush.ws/drush_windows_installer
[git_osx_install]:              http://code.google.com/p/git-osx-installer
[git_win_install]:              http://msysgit.github.com
[system_requirements]:          /architecture/system-requirements
