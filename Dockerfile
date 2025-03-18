FROM golang:1.24.1-bookworm

WORKDIR /app

COPY . .
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build

FROM gcr.io/distroless/static-debian12:nonroot
WORKDIR /app
COPY --from=0 /app .

EXPOSE 9447
ENTRYPOINT ["./resque-exporter"]
