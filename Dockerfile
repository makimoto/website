FROM buildpack-deps
MAINTAINER Shimpei Makimoto

RUN apt-get update && apt-get install -y cmake
RUN git clone https://github.com/makimoto/makimoto.github.io doc_root
RUN git clone https://github.com/libuv/libuv \
  && cd libuv \
  && ./autogen.sh \
  && ./configure \
  && make \
  && make install
RUN cd / \
  && git clone https://github.com/h2o/h2o \
  && cd h2o \
  && cmake . \
  && make h2o
WORKDIR /h2o
ADD myh2o.conf /
ENTRYPOINT ["./h2o", "-c", "/myh2o.conf"]
