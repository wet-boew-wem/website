```
title: Menu System
layout: feature
tags: ['feature']
```

## Introduction

In this area we will learn about how to leverage the Drupal WxT menu system to support different contextual displays.

Currently we provide WxT markup support via [Menu Block][menu_block] + [Panels][panels] integration in the following regions:

* **MegaMenu**
* **MidFooter**
* **Sidebar**

### Hierarchy

The following menu hierarchy will be used for all of our scenarios below:

```rb
  SideBar
  --Chat with an expert
  ----Instructions
  ----Rules of engagement
  ----Disclaimer
  ----Privacy notice
  ——--Proactive disclosure
  —-Previous chat sessions
  ----Transcripts
  —-My Department
  ——--My Settings
  ——--My email notifications
  ——--About My Account
  ——--Help
  ——--Logout
  —-Admin Portal
  ——--Create a new chat room
  ——--Existing chat rooms
  ——--Users
  ——--Chat moderation
```

## Scenario 1: Sidebar

Lets look at an example of how we can configure a Menu to render with the proper Sidebar markup that WxT expects.

### Business Requirements

  * For this example the menu will consist of the defined menu hierarchy above.
  * We can only show the "My Parent" and "Admin Portal" menus when the user has the correct role.
  * Must align to WxT Sidebar Markup and render as a secondary menu in mobile.

### Panel Layouts

Panel Layouts / Mini Panels are the lifeblood for how menus get displayed with Drupal WxT. The following will discuss a Panel Layout menu workflow.

* We proceed to the correct panel layout variant for our content type. For example the node_view page variant.
* Proceed to the 'add content' gear widget in the content section and select the 'menus' content type in the rendered ctools modal window.
* Locate the name of your menu in the displayed elements ensuring that it is the menu block derived menu which usually has a 'menu tree' suffix.

<div class="panel-group" id="accordion">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          Expected Result
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in">
      <div class="panel-body">
        <p align="center">
          <img alt="Panels Layout Screen" src="https://dl.dropboxusercontent.com/u/38413195/drupalwxt/features/menu/scenario_1b_backend.png" class="img-responsive">
        </p>
      </div>
    </div>
  </div>
</div>

### Menu Block Configuration

When configuring Menu Blocks you have to take into account the context in how the menu will be appeared.

Sane Defaults to get the Menu Block to properly work with the Sidebar is as follows:

* Ensure the override default title is on and text is empty.
* Check that Block title embedded in menu option is enabled.
* Select the appropriate theme function override.

  * Default
  * Megamenu
  * **Sidebar**

* Ensure that the expanded menu option is enabled.
* Select the appropriate top parent menu item, in our case the "Chat with an Expert" menu item.

<div class="panel-group" id="accordion">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
          Menu Block: Chat with an Expert
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse in">
      <div class="panel-body">
        <p align="center">
          <img alt="Configuration Screen for Menu Block" src="https://dl.dropboxusercontent.com/u/38413195/drupalwxt/features/menu/scenario_1a_menublock_1b.png" class="img-responsive">
        </p>
      </div>
    </div>
  </div>
</div>

## Scenario 2: MegaMenu

Lets look at an example of how we can configure a Menu to render with the proper MegaMenu markup that WxT expects.

### Business Requirements

  * For this example the menu will consist of the defined menu hierarchy above.
  * Must align to WxT MegaMenu Markup and render properly in mobile context.

<div class="bs-callout bs-callout-info">
  <h4>More Information</h4>
  <p>For more information on the menu system and integration with menu block consider the following resources:</p>
  <ul>
    <li>The WetKit Menu module [README.md][wetkit_menu] file</li>
  </ul>
</div>

<!-- Links Referenced -->

[menu_block]:       http://drupal.org/project/menu_block
[panels]:           http://drupal.org/project/panels
[wetkit_menu]:      http://wiki.drupalwxt.org/wxt/menu/
