from fabric.api import env, task
from envassert import detect, file, group, package, port, process, service, \
    user
from hot.utils.test import get_artifacts


@task
def check():
    env.platform_family = detect.detect()

    assert package.installed("cassandra")
    assert file.exists("/etc/cassandra/cassandra.yaml")
    assert port.is_listening(7000)
    assert user.exists("cassandra")
    assert group.is_exists("cassandra")
    assert user.is_belonging_group("cassandra", "cassandra")
    assert process.is_up("java")
    assert service.is_enabled("cassandra")


@task
def artifacts():
    env.platform_family = detect.detect()
    get_artifacts()
