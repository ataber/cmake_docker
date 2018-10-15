FROM ubuntu

RUN apt-get update --fix-missing \
&&  apt-get upgrade -y \
&&  apt-get install -y wget software-properties-common make build-essential clang-tidy iwyu \
&&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-5.0 main" && \
    apt-get update --fix-missing && \
    apt-get install -y clang-5.0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG CMAKE_VERSION=3.12.3
RUN cd /tmp \
    && wget https://cmake.org/files/v3.11/cmake-$CMAKE_VERSION.tar.gz \
    && tar xf cmake-$CMAKE_VERSION.tar.gz \
    && cd cmake-$CMAKE_VERSION \
    && ./bootstrap \
    && make \
    && make install \
    && cd .. \
    && rm -rf cmake*

ENV CC clang-5.0
ENV CXX clang++-5.0

RUN mkdir /app
WORKDIR /app
