FROM ubuntu

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    apt-get update --fix-missing && \
    apt-get -y upgrade && \
    apt-get install -y software-properties-common && \
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main" && \
    apt-get update --fix-missing && \
    apt-get install -y make clang-5.0 && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && wget https://cmake.org/files/v3.11/cmake-3.11.0.tar.gz \
    && tar xf cmake-3.11.0.tar.gz \
    && cd cmake-3.11.0 \
    && ./bootstrap \
    && make \
    && make install \
    && cd .. \
    && rm -rf cmake*

RUN mkdir /app
WORKDIR /app
