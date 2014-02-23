```
title: Release Cycle / Updates
description: Information about the release and how to update the Drupal WxT Distribution between versions.
layout: architecture
tags: ['architecture']
```

Release Cycle
-------------

The Drupal WxT 7.x-1.x branch will be updated with a stable release approximately
once a month roughly around the 18th. The reason for this is to follow as closely
the Drupal security and core release cycle which is usually the 15th of every month.

There will be no more new features integrated into the 7.x-1.x branch unless those requested
to be merged back into it to provide stability and a focus on production quality for this
branch.

The Drupal WxT 7.x-2.x will be where the new work on the Bootstrap integration will
begin. The whole process will be outlined in the [roadmap][roadmap] section. This branch
should not be used in production environments at this point.

Update Process
--------------

It is important to mention that you should only ever upgrade from one version to the next sequential
version. It is inadvisable to skip versions as certain update hooks expect the existence of certain
files that might not exist in subsequent releases. Additionally do not manually update modules within
distributions! Drupal Distributions contain a carefully selected set of module versions along with
specific patches. You should never update individual modules within a distribution unless you are an
experienced developer. In the end just stick to the release cycle as it will save you a lot of headache.

* First and most importantly backup your database. (e.x. `drush arb`)
* Additionally copy your sites folder by moving it from the virtual host path to a backup location
* Extract the latest stable release of Drupal WxT into your virtual host path
* Copy your sites directory into the new folder
* Run `drush updatedb`
* Run `drush cc all`
* Ensure all of the WetKit Features are in a reverted state

  * a) For customization of default WetKit features so they remain in a reverted state please use: [Features Override][features_override]

* You have now successfully updated!

IMPORTANT FILES
---------------

More then anything please consistently check both the [README.md][readme] and [CHANGELOG.md][changelog] files for up-to-date information on the Drupal WxT releases.

<!-- Links Referenced -->

[features_override]:  https://drupal.org/project/features_override
[media_overriden]:    https://drupal.org/node/2104193
[roadmap]:            /pages/roadmap
[wetkit_widgets]:     /wxt/widgets
[wetkit_images]:      /wxt/images
[changelog]:          https://github.com/wet-boew/wet-boew-drupal/blob/7.x-1.x/CHANGELOG.md
[readme]:             https://github.com/wet-boew/wet-boew-drupal/blob/7.x-1.x/README.md
