saltstates makina tree
===========================

.. contents::

Salt states to install the bash project ckan

Use
====
Optionnaly edit pillar::

    mkdir /srv/pillar
    touch /srv/pillar/top.sls


Install this project (as **root**)::

    export PROJECT_URL="https://github.com/makinacorpus/salt-project" PROJECT_BRANCH="ckan-salt"
    wget http://raw.github.com/makinacorpus/makina-states/master/_scripts/boot-salt.sh -O - | bash

