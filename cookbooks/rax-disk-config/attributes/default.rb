default['rax']['disk_config']['volume_group'] = 'vg00'

default['rax']['disk_config']['disk_prefix'] = 'xvd'
default['rax']['disk_config']['data_disks'] = ('e'..'z')

default['rax']['disk_config']['logical_volume'] = 'data'
default['rax']['disk_config']['size'] = '100%VG'
default['rax']['disk_config']['filesystem'] = 'xfs'
default['rax']['disk_config']['mount_point'] = '/mnt/volume'
default['rax']['disk_config']['mount_options'] = 'rw,noatime,nodiratime'
case node['platform_family']
when 'debian'
  default['rax']['disk_config']['packages'] = ['xfsprogs']
end
