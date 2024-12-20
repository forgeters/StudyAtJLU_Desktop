#!/bin/bash

# 获取最新的提交短哈希
SHORT_COMMIT_HASH=$(git rev-parse --short HEAD)

# 将短哈希从十六进制字符串转换为十进制数，并限制最大值为 65535
NUMERIC_COMMIT_HASH=$((16#$SHORT_COMMIT_HASH % 65536))

# 替换 build.gradle.kts 文件中的 {commit-hash} 占位符

# 检测操作系统以选择正确的 sed 语法
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS/BSD sed 需要提供空字符串作为备份后缀
  sed -i '' "s/{commit-hash}/$NUMERIC_COMMIT_HASH/g" build.gradle.kts
else
  # Linux/GNU sed 可以直接使用 -i 选项
  sed -i "s/{commit-hash}/$NUMERIC_COMMIT_HASH/g" build.gradle.kts
fi

echo "Replaced {commit-hash} with numeric hash $NUMERIC_COMMIT_HASH in build.gradle.kts"