MakinaCorpus salt states project templates collection
=============================================================

.. contents::

This repository contains pair collections of:

    - A project around a technology (plone, django, drupal, etc)
    - A salt stack state tree to install this project

The naming scheme is:

    :PROJECTNAME-project: the project
    :PROJECTNAME-salt: the saltstack states tree

Use
===

Three environment variable may change the behavior of the bootstrap script:

    :PROJECT_URL: Your project url
    :PROJECT_NAME: Your project name
    :PROJECT_BRANCH: The salt stack states tree branch in your repo (default: salt)
    :PROJECT_TOPSTATE: The salt state highstate to use (state.highstate as default)
    :SALT_BOOT: The makina-states bootstrap to use

        - :SALT_BOOT="": salt is installed
        - :SALT_BOOT="server":  install makina salt and requisites
        - :SALT_BOOT="vm": install makina salt and requisites for a VM (lxc, virtualbox, etc)
        - :SALT_BOOT="mastersalt":  install makina salt and requisites and also a mastersalt minion for mastersalt wiring

Install a project::

    export PROJECT_URL=https://github.com/makinacorpus/salt-project PROJECT_NAME="<foo>" PROJECT_BRANCH="<foo-salt>"
    wget http://raw.github.com/makinacorpus/makina-states/master/_scripts/boot-salt.sh -O - | bash


Collection
================

    :sample: (obsolete) The most basic bash based project example
    :ckan: (obsolete) A ckan installation
    :apache: A basic apache+vhost installation
    :modphp: A basic modphp installation
    :phpfpm: A basic phpfpm installation


TODO:

    - backport zope generic into salt-project
    - backport lizmap into salt-project
    

