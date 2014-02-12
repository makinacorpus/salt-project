MakinaCorpus salt Drupal project template
=========================================

.. contents::

Salt states to install infrastructure around a Drupal project using:
   - MySQL/PostgreSQL
   - Apache/Nginx
   - php-fpm or mod_phpfpm (last one only available for Apache)
   - drush

USE
===

Install on a computer
---------------------

Install this project (as **root**)::
  
  export PROJECT_URL="https://github.com/makinacorpus/salt-project.git"
  export PROJECT_BRANCH="phpfpm-salt" PROJECT_NAME="drupal-apache-phpfpm-mysql-salt-project"
  wget http://raw.github.com/makinacorpus/makina-states/master/_scripts/boot-salt.sh -O - | bash

Install on a development VM
---------------------------


Use as a template fro you project
---------------------------------

Use theses files as sources for the 'salt' branch of your project.
This 'salt' branch is the base source of project deployment.

TODO
=======



