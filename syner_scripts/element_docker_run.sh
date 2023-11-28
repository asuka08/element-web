#!/bin/bash

# 让用户输入 Docker 镜像的 tag，如果没有输入则默认为 latest
echo "请输入 asuka08/element-web-syner  镜像的 tag (默认为 latest):"
read tag
if [ -z "$tag" ]; then
    tag="latest"
fi

# 停止名为 element-web-syner 的容器
echo "停止容器 element-web-syner..."
sudo docker stop element-web-syner || true

# 删除名为 element-web-syner 的容器
echo "删除容器 element-web-syner..."
sudo docker rm element-web-syner || true

# 删除 asuka08/element-web-syner 的镜像
echo "删除镜像 asuka08/element-web-syner:$tag..."
sudo docker rmi asuka08/element-web-syner:$tag || true

# 从 Docker Hub 拉取新的镜像
echo "从 Docker Hub 拉取镜像 asuka08/element-web-syner:$tag..."
sudo docker pull asuka08/element-web-syner:$tag

# 启动新的容器
echo "启动容器 element-web-syner..."
sudo docker run -d -p 8000:80 --name element-web-syner asuka08/element-web-syner:$tag

echo "操作完成！"
