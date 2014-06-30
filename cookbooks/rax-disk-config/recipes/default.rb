# Encoding: utf-8
#
# Cookbook Name:: rax-disk-config
# Recipe:: default
#
# Copyright 2014, Rackspace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

volumes = %w()

node['block_device'].each do |k, v|
  if k.include?(node['rax']['disk_config']['disk_prefix']) &&
                    node['rax']['disk_config']['data_disks'].include?(k[-1, 1])
    dev_name = File.join('/dev', "#{k}1")
    unless node['filesystem'][dev_name]
      volumes.push(dev_name)
    end
  end
end

unless volumes.empty?
  include_recipe 'lvm'

  node['rax']['disk_config']['packages'].each do |pkg|
    package pkg
  end

  directory node['rax']['disk_config']['mount_point'] do
    owner 'root'
    group 'root'
    mode 0755
    recursive true
  end

  lvm_volume_group node['rax']['disk_config']['volume_group'] do
    physical_volumes volumes
    logical_volume node['rax']['disk_config']['logical_volume'] do
      size node['rax']['disk_config']['size']
      filesystem node['rax']['disk_config']['filesystem']
      mount_point location: node['rax']['disk_config']['mount_point'],
                  options: node['rax']['disk_config']['mount_options']
      not_if {File.exist?(File.join('/dev',
                          node['rax']['disk_config']['volume_group'],
                          node['rax']['disk_config']['logical_volume']))}
    end
  end
end
