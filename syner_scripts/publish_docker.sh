#!/bin/bash

# 当任何一行命令执行失败时，脚本将立即退出
set -e

# 定位到 React 项目的根目录
# 假设脚本在项目根目录的 syner_scripts 目录下
cd "$(dirname "$0")/.."

# 让用户输入 sudo 密码
echo "请输入您的 sudo 密码："
read -s sudo_password

# 让用户输入 Docker 镜像的 tag
echo "请输入 asuka08/element-web-syner 镜像的 tag (默认为 latest):"
read tag
if [ -z "$tag" ]; then
    tag="latest"
fi

# 执行 yarn build 打包 React 项目
echo "正在打包 React 项目..."
yarn build

# 删除原有的 Docker 镜像
echo "$sudo_password" | sudo -S docker rmi asuka08/element-web-syner:$tag || true

# 构建新的 Docker 镜像
echo "构建新的 Docker 镜像..."
echo "$sudo_password" | sudo -S docker build --platform linux/amd64 -t asuka08/element-web-syner:$tag .

# 推送镜像到 Docker Hub
echo "推送镜像到 Docker Hub..."
docker push asuka08/element-web-syner:$tag

echo "Docker 镜像发布完成！"
