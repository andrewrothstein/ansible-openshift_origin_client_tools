andrewrothstein.openshift-origin-client-tools
=========
![Build Status](https://github.com/andrewrothstein/ansible-openshift_origin_client_tools/actions/workflows/build.yml/badge.svg)

Installs [OpenShift Origin Client Tools](https://github.com/openshift/origin) include the oc CLI.

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.openshift-origin-client-tools
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
