
# 发布项目到azure服务器的步骤


1. 将项目打包成docker镜像, 并推送到hub.doker  
在当先目录下执行  
./publish_docker.sh  

2. 登录到azure服务器  
ssh -i ~/work/cert/azure/element-serv_key.pem syner@20.25.149.32  

3. 在azure服务器执行  
cd matrix-project/scripts/  
./server_run_docker_element.sh   


# 将 server_run_docker.sh 复制到azure服务器
在当前目录使用如下命令  
scp -i ~/work/cert/azure/element-serv_key.pem ./server_run_docker_element.sh syner@20.25.149.32:/home/syner/matrix-project/scripts  
