FROM ubuntu

RUN apt-get update --fix-missing \
&&  apt-get upgrade -y \
&&  apt-get install -y wget software-properties-common make build-essential clang-tidy \
&&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main" && \
    apt-get update --fix-missing && \
    apt-get install -y clang-5.0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && wget https://cmake.org/files/v3.11/cmake-3.11.0.tar.gz \
    && tar xf cmake-3.11.0.tar.gz \
    && cd cmake-3.11.0 \
    && ./bootstrap \
    && make \
    && make install \
    && cd .. \
    && rm -rf cmake*

ENV CC clang-5.0
ENV CXX clang++-5.0

RUN mkdir /app
WORKDIR /app
