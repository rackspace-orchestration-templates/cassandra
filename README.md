[![Circle CI](https://circleci.com/gh/rackspace-orchestration-templates/cassandra/tree/master.png?style=shield)](https://circleci.com/gh/rackspace-orchestration-templates/cassandra)
Description
===========

This is a template to deploy [Cassandra](http://cassandra.apache.org/) across
multiple servers. This template is leveraging
[chef-solo](http://docs.opscode.com/chef_solo.html) to setup the server.

Requirements
============
* A Heat provider that supports the Rackspace `OS::Heat::ChefSolo` plugin.
* An OpenStack username, password, and tenant id.
* [python-heatclient](https://github.com/openstack/python-heatclient)
`>= v0.2.8`:

```bash
pip install python-heatclient
```

We recommend installing the client within a [Python virtual
environment](http://www.virtualenv.org/).

Example Usage
=============
Here is an example of how to deploy this template using the
[python-heatclient](https://github.com/openstack/python-heatclient):

```
heat --os-username <OS-USERNAME> --os-password <OS-PASSWORD> --os-tenant-id \
  <TENANT-ID> --os-auth-url https://identity.api.rackspacecloud.com/v2.0/ \
  stack-create Cassandra -f cassandra.yaml -P node_count=5
```

* For UK customers, use `https://lon.identity.api.rackspacecloud.com/v2.0/` as
the `--os-auth-url`.

Optionally, set environmental variables to avoid needing to provide these
values every time a call is made:

```
export OS_USERNAME=<USERNAME>
export OS_PASSWORD=<PASSWORD>
export OS_TENANT_ID=<TENANT-ID>
export OS_AUTH_URL=<AUTH-URL>
```

Parameters
==========
Parameters can be replaced with your own values when standing up a stack. Use
the `-P` flag to specify a custom parameter.

* `seed_hostname`: Hostname to use for the seed node (Default: cassandra-seed)
* `node_hostnames`: Hostname to use for all other nodes (Default:
  cassandra-node)
* `node_count`: Number of nodes to deploy in addition to the seed, minium 2.
  (Default: 2)
* `image`: Operating system to use on all servers in this deployment (Default:
  Ubuntu 14.04 LTS (Trusty Tahr) (PVHVM))
* `flavor`: Server size to use for all servers in this deployment (Default: 2
  GB Performance)

Outputs
=======
Once a stack comes online, use `heat output-list` to see all available outputs.
Use `heat output-show <OUTPUT NAME>` to get the value fo a specific output.

* `private_key`: SSH private that can be used to login as root to all servers.
* `seed_node_public_ip`: Public IP of node that is configured first.
* `seed_node_private_ip`: Private IP of node that is configured first.
* `node_public_ips`: Array of Public IP's for all other Cassandra nodes.
* `node_private_ips`: Array of Private IP's for all other Cassandra nodes.

For multi-line values, the response will come in an escaped form. To get rid of
the escapes, use `echo -e '<STRING>' > file.txt`. For vim users, a substitution
can be done within a file using `%s/\\n/\r/g`.

Stack Details
=============
If you're new to Cassandra, check out the [Cassandra Getting
Started](http://wiki.apache.org/cassandra/GettingStarted) guide. This document
covers the basics for starting to use your new Cassandra multinode cluster.
Client connections should be made to the IP address associated with the
eth1/ServiceNet interface of each server.

This stack will format the data disk (if it exists) and mount it to
`/var/lib/cassandra`.

The `private_key` provided in the outputs section can be used to login as root
via SSH. We have an article on how to use these keys with [Mac OS X and
Linux](http://www.rackspace.com/knowledge_center/article/logging-in-with-a-ssh-private-key-on-linuxmac)
as well as [Windows using
PuTTY](http://www.rackspace.com/knowledge_center/article/logging-in-with-a-ssh-private-key-on-windows).

Contributing
============
There are substantial changes still happening within the [OpenStack
Heat](https://wiki.openstack.org/wiki/Heat) project. Template contribution
guidelines will be drafted in the near future.

License
=======
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
