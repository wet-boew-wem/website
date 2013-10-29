Drupal WxT Documentation Site
=============================
Leverages DocPad to get a quick and easy to maintain documentation site for Drupal WxT.

Getting Started
----------------

1. [Install DocPad][docpad]

2. Clone the project and run the server

	``` bash
	git clone https://github.com/wet-boew-wem/website.git
	cd website
	npm install
	docpad run
	```

3. Open [http://localhost:9778][localhost]

4. Start hacking away by modifying the `src` directory

I'm getting EMFILE errors
-------------------------

[See here for the reason why and the solution][bug_emfile]

<!-- Links Referenced -->

[bootstrap]:    http://twitter.github.com/bootstrap
[bug_emfile]:   http://docpad.org/docs/troubleshoot#i-m-getting-emfile-too-many-open-files
[docpad]:       https://github.com/bevry/docpad
[drupalwxt]:    http://drupal.org/project/wetkit
[localhost]:    http://localhost:9778
