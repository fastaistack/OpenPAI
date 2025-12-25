#!/bin/bash
###############################################################################
# 替换 Kubernetes 部署文件中的变量
# 将 llm-serving_config.yml 中的变量值替换到 llm-serving.yml 中
# 修复：保留引号、处理特殊字符转义、兼容行内注释
###############################################################################

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 文件路径
CONFIG_FILE="llm-serving_config.yml"
TARGET_FILE="llm-serving.yml"
BACKUP_FILE="${TARGET_FILE}.bak"

# 0. 检查参数
if [ "$#" -lt 2 ]; then
    echo -e "${YELLOW}Usage: $0 <IP_ADDRESS> <CACHE_PATH>${NC}"
    echo -e "${YELLOW}Example: $0 172.16.0.128 /home/docker-build/cache${NC}"
    exit 1
fi

INPUT_IP="$1"
INPUT_PATH="$2"

# 1. 检查文件是否存在
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}Error: Config file $CONFIG_FILE does not exist${NC}"
    exit 1
fi

if [ ! -f "$TARGET_FILE" ]; then
    echo -e "${RED}Error: Target file $TARGET_FILE does not exist${NC}"
    exit 1
fi

# 2. 创建备份 (Config & Target)
CONFIG_BACKUP="${CONFIG_FILE}.bak"

# 备份 Config 文件 (如果不存在则备份)
if [ ! -f "$CONFIG_BACKUP" ]; then
    echo "Creating config backup: $CONFIG_BACKUP"
    cp "$CONFIG_FILE" "$CONFIG_BACKUP"
else
    echo "Config backup already exists: $CONFIG_BACKUP (skipping backup)"
fi

# 备份 Target 文件
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Creating target backup: $BACKUP_FILE"
    cp "$TARGET_FILE" "$BACKUP_FILE"
    echo -e "${GREEN}✓ Backups created successfully${NC}"
else
    echo "Target backup already exists: $BACKUP_FILE (skipping backup)"
fi

echo ""
echo "Reading config file: $CONFIG_FILE"
echo "Target file: $TARGET_FILE"
echo "Using IP: $INPUT_IP"
echo "Using Path: $INPUT_PATH"

# 创建临时文件
TEMP_VARS=$(mktemp)
trap "rm -f $TEMP_VARS" EXIT

# 3. 预处理 Config 文件 (直接修改原文件)
echo "Pre-processing config file (in-place modification)..."
# 转义路径中的斜杠，防止 sed 报错
ESCAPED_PATH=$(echo "$INPUT_PATH" | sed 's/\//\\\//g')

# 全局替换 {{HOST_IP}} 和 {{HOST_PATH}} 到原配置文件
sed -i "s/{{HOST_IP}}/$INPUT_IP/g; s/{{HOST_PATH}}/$ESCAPED_PATH/g" "$CONFIG_FILE"


# 4. 解析 YAML (增强版逻辑)
# 逐行读取，处理行内注释，保留引号
while IFS= read -r line || [[ -n "$line" ]]; do
    # 去除行内注释 (从第一个 # 开始切除)
    clean_line=${line%%#*}
    
    # 跳过空行或没有冒号的行
    if [[ -z "$clean_line" || "$clean_line" != *:* ]]; then
        continue
    fi

    # 提取 Key (冒号左边)，去除首尾空格
    key=$(echo "$clean_line" | awk -F: '{print $1}' | xargs)

    # 提取 Value (冒号右边)，去除首尾空格
    # 注意：这里不再去除引号 (sed 's/^"//' 等被移除了)，完全遵照原文件
    value=$(echo "$clean_line" | cut -d: -f2- | sed 's/^[ \t]*//;s/[ \t]*$//' | tr -d '\r')

    # 只有当 key 非空时才写入
    if [ -n "$key" ]; then
        # 将 key=value 写入临时文件，使用特殊分隔符避免值中包含 = 号导致的问题
        # 这里我们直接存两行：一行key，一行value，方便后续读取
        echo "KEY:$key" >> "$TEMP_VARS"
        echo "VAL:$value" >> "$TEMP_VARS"
    fi
done < "$CONFIG_FILE"

echo "Replacing variables..."

# 统计变量
declare -A replacement_count
total_replacements=0

# 4. 执行替换
current_key=""
while read -r line; do
    if [[ "$line" == KEY:* ]]; then
        current_key="${line#KEY:}"
    elif [[ "$line" == VAL:* ]]; then
        value="${line#VAL:}"
        key="$current_key"

        pattern="{{$key}}"
        
        # 检查文件中是否存在该变量
        if grep -q "$pattern" "$TARGET_FILE"; then
            # 统计出现次数
            count=$(grep -o "$pattern" "$TARGET_FILE" | wc -l)
            replacement_count["$key"]=$count
            total_replacements=$((total_replacements + count))
            
            # 【重要】对 Value 进行转义，防止 sed 报错
            # 1. 转义反斜杠 \ -> \\
            # 2. 转义分隔符 | -> \| (我们下面sed用 | 做分隔符)
            # 3. 转义 & -> \& (sed中 & 代表匹配项)
            safe_value=$(echo "$value" | sed 's/\\/\\\\/g' | sed 's/|/\\|/g' | sed 's/&/\\&/g')

            # 执行替换 (使用 | 作为分隔符，比 @ 更通用，且已转义)
            # Linux下直接用 -i，如果是MacOS可能需要 sed -i ''
            sed -i "s|$pattern|$safe_value|g" "$TARGET_FILE"
        fi
    fi
done < "$TEMP_VARS"

echo -e "${GREEN}✓ Replacement completed! File updated: $TARGET_FILE${NC}"
echo ""
echo "Total replaced ${#replacement_count[@]} variables, $total_replacements occurrences:"
echo ""

# 按字母顺序显示统计信息
if [ ${#replacement_count[@]} -gt 0 ]; then
    for key in $(echo "${!replacement_count[@]}" | tr ' ' '\n' | sort); do
        printf "  - %-40s : %d occurrence(s)\n" "$key" "${replacement_count[$key]}"
    done
else
    echo -e "${YELLOW}  No variables were replaced.${NC}"
fi

# 5. 检查未解析的变量
echo ""
echo "Checking for unresolved variables..."

# 排除 hostvars 这种 Ansible/Jinja2 自身的变量，避免误报
# 如果你想看所有的，去掉 | grep -v "hostvars"
unresolved=$(grep -oE '\{\{[^}]+\}\}' "$TARGET_FILE" | sort -u || true)

if [ -n "$unresolved" ]; then
    echo -e "${YELLOW}⚠ Warning: Some variables remain unresolved (Check if these are intentional, e.g., Ansible vars):${NC}"
    echo "$unresolved" | while read -r var; do
        count=$(grep -o "$var" "$TARGET_FILE" | wc -l)
        # 去掉花括号显示名字
        var_name=$(echo "$var") 
        printf "  - %-40s : %d occurrence(s)\n" "$var_name" "$count"
    done
else
    echo -e "${GREEN}✓ All variables successfully replaced!${NC}"
fi

echo ""
echo "Done!"