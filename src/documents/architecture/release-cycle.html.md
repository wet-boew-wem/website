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

There will be no more new features integrated into the 7.x-1.x unless those requested to
be merged back into it to provide stability and a focus on production quality for this
branch.

The Drupal WxT 7.x-1.x will be where the new work on the Bootstrap integration will
begin. The whole process will be outlined in the [roadmap][roadmap] section.

Updates
-------

* First as is standard Drupal procedure backup your database. (e.x. `drush arb`)
* Backup your sites folder by moving it from the virtual host path to a backup location
* Extract the latest release into your virtual host path
* Copy back your sites directory
* Run `drush updatedb`
* Ensure all of the WetKit Features are in a reverted state (WetKit Widgets + WetKit Images have a known overridden status due to: [Media Overridden][media_overriden])

  * a) [WetKit Widgets][wetkit_widgets] + [WetKit Images][wetkit_images] have a known overridden status due to a bug with: [Media + File Entity][media_overriden]
  * b) For customization of default WetKit features so they remain in a reverted state use: [Features Override][features_override]

* Run `drush cc all`
* You have now successfully updated!

IMPORTANT FILES
---------------

More then anything please consistently check both the [README.md][readme] and [CHANGELOG.md][readme] files for up-to-date information on the Drupal WxT releases.

<!-- Links Referenced -->

[features_override]:  https://drupal.org/project/features_override
[media_overriden]:    https://drupal.org/node/2104193
[roadmap]:            /pages/roadmap
[wetkit_widgets]:     /wxt/widgets
[wetkit_images]:      /wxt/images
[changelog]:          https://github.com/wet-boew/wet-boew-drupal/blob/7.x-1.x/CHANGELOG.md
[readme]:             https://github.com/wet-boew/wet-boew-drupal/blob/7.x-1.x/README.md
