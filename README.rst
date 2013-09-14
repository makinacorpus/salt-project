MakinaCorpus salt states project templates collection
=============================================================

.. contents::

This repository contains pair collections of:

    - A project around a technology (plone, django, drupal, etc)
    - A salt stack state tree to install this project

The naming scheme is:

    - :PROJECTNAME-project: : the project
    - :PROJECTNAME-salt: : the saltstack states tree

Use
====
Optionnaly edit pillar::

    mkdir /srv/pillar
    touch /srv/pillar/top.sls


Three environment variable may change the behavior of the bootstrap script:

    - :PROJECT_URL: : Your project url
    - :PROJECT_BRANCH: : The salt stack states tree branch in your repo

Install the project::

    export PROJECT_URL=https://github.com/makinacorpus/salt-project PROJECT_BRANCH=bash
    wget http://raw.github.com/makinacorpus/makina-states/master/_scripts/boot-salt.sh -O - | bash


Collection
================

    - :sample: : The most basic bash based project example

