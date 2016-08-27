# 根据当前系统环境初始化的一些变量

# 当前文件夹路径
CURRENT_DIR=`pwd`

# 当前用户ID和用户组ID
if [ `uname` == 'Darwin' ]
then
  # for mac system
  USER_NAME=`whoami`
  DOCKER_USER_ID=`id -u`
  GROUP_NAME=$USER_NAME
  # mac的用户组ID太小了(20), 与很多系统的用户组重复, 只能与用户ID相同了
  DOCKER_GROUP_ID=$DOCKER_USER_ID
else
  # for other linux system
  USER_NAME=`whoami`
  DOCKER_USER_ID=`id -u ${USER_NAME}`
  GROUP_NAME=`groups | awk '{print $1}'`
  DOCKER_GROUP_ID=`id -g ${GROUP_NAME}`
fi

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
