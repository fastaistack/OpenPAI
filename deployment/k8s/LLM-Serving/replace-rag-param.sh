#!/bin/bash
###############################################################################
# 替换 Kubernetes 部署文件中的变量
# 将 Param-rag.yaml和Param-unoin.json 中的变量值替换
###############################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

INPUT_PATH="$1"


# 文件路径
RAG_PARAM_YAML_FILE="Param-rag.yaml"
# RAG_PARAM_JSON_FILE="Param-unoin.json"
RAG_YAML_BACKUP_FILE="${RAG_PARAM_YAML_FILE}.bak"
# RAG_JSON_BACKUP_FILE="${RAG_PARAM_JSON_FILE}.bak"

# 0. 检查参数
if [ "$#" -lt 1 ]; then
    echo -e "${YELLOW}Usage: $0 <CACHE_PATH>${NC}"
    echo -e "${YELLOW}Example: $0 /path/to/cache${NC}"
    exit 1
fi



# 1. 检查文件是否存在
if [ ! -f "$RAG_PARAM_YAML_FILE" ]; then
    echo -e "${RED}Error: Config file $RAG_PARAM_YAML_FILE does not exist${NC}"
    exit 1
fi


# 备份 Config 文件 (如果不存在则备份)
if [ ! -f "$RAG_YAML_BACKUP_FILE" ]; then
    echo "Creating config backup: $RAG_YAML_BACKUP_FILE"
    cp "$RAG_PARAM_YAML_FILE" "$RAG_YAML_BACKUP_FILE"
else
    echo "Config backup already exists: $RAG_YAML_BACKUP_FILE (skipping backup)"
fi

echo ""
echo "Reading config file"
echo "Using Path: $INPUT_PATH"


# 3. 预处理 Config 文件 (直接修改原文件)
echo "Pre-processing config file (in-place modification)..."

# 全局替换{{HOST_PATH}} 到原配置文件
sed -i "s|{{HOST_PATH}}|$INPUT_PATH|g" "$RAG_PARAM_YAML_FILE"
# sed -i "s|{{HOST_PATH}}|$INPUT_PATH|g" "$RAG_PARAM_JSON_FILE"

echo ""
echo "Done!"