# 获取我们的基础Docker镜像
FROM ubuntu:16.04

# 在镜像中安装一些软件包
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        gcc \
        cmake \
        g++ \
        wget \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 安装anaconda3
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/Anaconda3-5.2.0-Linux-x86_64.sh && \
    /bin/bash ~/Anaconda3-5.2.0-Linux-x86_64.sh -b -p /opt/anaconda3 && \
    rm ~/Anaconda3-5.2.0-Linux-x86_64.sh && \
    echo "export PATH=/opt/anaconda3/bin:$PATH" >> ~/.bashrc

# 安装依赖
RUN /opt/anaconda3/bin/pip install tensorflow pandas
# 运行jupyter
# 打开端口，放射端口
EXPOSE 6006
EXPOSE 8888
EXPOSE 8080
EXPOSE 7999
# 定义工作目录
# create工作目录
RUN mkdir /notebooks/
# 打开工作目录
WORKDIR /notebooks/
# 运行
COPY run_jupyter.sh /run_jupyter.sh
RUN chmod 755 /run_jupyter.sh
CMD ["/bin/bash /run_jupyter.sh", "--allow-root"]