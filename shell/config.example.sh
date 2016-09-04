# mysql配置 (可保持默认)
MYSQL_DATA_DIR="${CURRENT_DIR}/data/mysql"
MYSQL_DATABASE="base_framework"
MYSQL_PASSWORD="111"

# 服务对外暴露的端口的偏移量, 如mysql端口3306, 设置为1000时对外暴露的端口就为4306
PORT_OFFSET="1000"

# web服务的路径
PORTAL_DIR="${CURRENT_DIR}/html"
ADMIN_DIR="${CURRENT_DIR}/html"
TRANS_DIR="${CURRENT_DIR}/html"

# web服务共享数据的路径
WEB_DATA_DIR="${DATA_DIR}/data"
