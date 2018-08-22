FROM alpine:3.8

LABEL maintainer="<zhaoyijun1987@hotmail.com>"

ENV TZ 'Asia/Shanghai'

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata git go make musl-dev && \
    mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    rm -rf /var/cache/apk/*

RUN git clone https://github.com/flike/kingshard.git $GOPATH/src/github.com/flike/kingshard
WORKDIR /src/github.com/flike/kingshard
RUN ls -alh
RUN source ./dev.sh
ENV GOPATH /
RUN export
RUN make
EXPOSE 9696
EXPOSE 9797

CMD ["./bin/kingshard", "-config=etc/ks.yaml"]
