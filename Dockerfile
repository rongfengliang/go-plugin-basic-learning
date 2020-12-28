FROM golang:1.15-alpine AS build-env-plugin
WORKDIR /go/src/app
ENV  GO111MODULE=on
ENV  GOPROXY=https://goproxy.cn
COPY . .
RUN set -x \
    && /bin/sed -i 's,http://dl-cdn.alpinelinux.org,https://mirrors.aliyun.com,g' /etc/apk/repositories \
    && apk update && apk add  build-base \
    && go build -buildmode=plugin -o shortid.so pkg/shortid/shortid.go \
    && go build -buildmode=plugin -o uuid.so pkg/uuid/uuid.go

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
COPY --from=build-env-plugin /go/src/app/shortid.so .
COPY --from=build-env-plugin /go/src/app/uuid.so .
COPY --from=build-env /go/src/app/demoapp .
# change with diffent link will see diffrent result
RUN ln -s shortid.so id.so
ENTRYPOINT [ "./demoapp" ]