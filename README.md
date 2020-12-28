# go plugin learning

## build

```code

with shortid:
go build -buildmode=plugin -o shortid.so pkg/shortid/shortid.go

or with uuid:
go build -buildmode=plugin -o uuid.so pkg/uuid/uuid.go

```

## running


```code
go build
ln -s shortid.so id.so  or  ln -s uuid.so id.so
./demoapp
```

## docker running

```code
docker build -t dalongrong/go-plugin-demo .
```