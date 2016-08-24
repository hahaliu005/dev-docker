# 根据当前系统环境初始化的一些变量

# 当前文件夹路径
CURRENT_DIR=`pwd`

# 当前用户ID和用户组ID
USER_NAME=`whoami`
DOCKER_USER_ID=`id -u ${USER_NAME}`
GROUP_NAME=`groups | awk '{print $1}'`
DOCKER_GROUP_ID=`id -g ${GROUP_NAME}`

# docker文件夹路径
DOCKER_DIR="${CURRENT_DIR}/dockers"

myEcho()
{
  echo "==> $1";
}

execCmd()
{
  myEcho "Exec: $1";
  sh -c "$1";
}
