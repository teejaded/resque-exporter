FROM golang:1.20.6-bookworm

WORKDIR /app

COPY . .
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build 

FROM alpine:latest
WORKDIR /app
COPY --from=0 /app .

# USER nobody:nogroup

EXPOSE 9447
ENTRYPOINT ["./resque-exporter"]
