FROM golang:1.15-alpine AS build-env-plugin
WORKDIR /go/src/app
ENV  GO111MODULE=on
ENV  GOPROXY=https://goproxy.cn
COPY . .
RUN set -x \
    && /bin/sed -i 's,http://dl-cdn.alpinelinux.org,https://mirrors.aliyun.com,g' /etc/apk/repositories \
    && apk update && apk add  build-base \
    && go build -buildmode=plugin -o demoapp.so app.go

FROM golang:1.15-alpine AS build-env
WORKDIR /go/src/app
ENV  GO111MODULE=on
ENV  GOPROXY=https://goproxy.cn
COPY . .
RUN set -x \
    && /bin/sed -i 's,http://dl-cdn.alpinelinux.org,https://mirrors.aliyun.com,g' /etc/apk/repositories \
    && apk update && apk add   build-base\
    && go build

FROM alpine:latest
RUN set -x \
    && /bin/sed -i 's,http://dl-cdn.alpinelinux.org,https://mirrors.aliyun.com,g' /etc/apk/repositories \
    && apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
COPY --from=build-env-plugin /go/src/app/demoapp.so .
COPY --from=build-env /go/src/app/demoapp .
ENTRYPOINT [ "./demoapp" ]