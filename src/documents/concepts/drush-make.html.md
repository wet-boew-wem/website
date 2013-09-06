```
title: Drush Make
layout: concept
tags: ['intro','concept']
```


The WET Distribution now uses Drush Make for rapid built out of the Drupal codebase. A drush make file is similar to "ant script" which allows for us to just host the code that we are developing (Installation Profile and Custom Modules, Features, and Themes) on GitHub. Any user who has Drush installed can then can then perform a build out of both the Drupal Core package + and various contributed modules hosted on Drupal.org.

1. Ensure you have the appropriate base requirements setup for Drupal as per the [System Requirements](https://github.com/wet-boew/wet-boew-drupal/wiki/System-Requirements) documentation.

2. Install Drush 5.8 or higher (inlcudes Drush Make):
  * a) Linux, Mac OSX: Follow instructions at http://drupal.org/node/477684
  * b) Windows: http://drush.ws/drush_windows_installer

3. Install Git 1.7.10 or higher (Some lower versions of git do not apply patches from the make file with Drush Make):
  * a) Linux, Mac OSX: http://code.google.com/p/git-osx-installer/
  * b) Windows: http://msysgit.github.com/

4. Clone this repository into a directory using the following commands on the Git Bash command prompt.

  ``` bash
  git clone https://github.com/wet-boew/wet-boew-drupal.git wet-boew-drupal;
  ```

4. Build the Drupal installation profile

  ``` bash
  drush make --prepare-install --no-gitinfofile --working-copy wet-boew-drupal/build-wetkit.make /var/www/html --yes
  ```

5. Quickly install using the Drush CLI (Password must not be simple or won't install)

  ``` bash
  drush si wetkit wetkit_theme_selection_form.theme=wetkit_omega install_configure_form.demo_content=TRUE --sites-subdir=default --db-url=mysql://root:@127.0.0.1:3306/wetkit_db --account-name=admin --account-pass=WetKit@2013 --site-mail=admin@example.com --site-name='Web Experience Toolkit' --yes
  ```

6. Fix Permissions

  Depending on your server set-up you will have to make sure that the /sites/default/files or /sites/&lt;domain&gt;/files directory has the correct owner (webserver):

  ``` bash
  chown -R apache:apache /sites/domain/files
  ```
