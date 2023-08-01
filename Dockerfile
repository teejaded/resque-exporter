FROM golang:1.20.6-bookworm AS builder

COPY . $GOPATH/src/github.com/basecamp/resque-exporter
WORKDIR $GOPATH/src/github.com/basecamp/resque-exporter

RUN go mod init github.com/basecamp/resque-exporter/v2
RUN go get github.com/basecamp/resque-exporter/v2
RUN go build -o /go/bin/resque-exporter

FROM scratch

COPY --from=builder /go/bin/resque-exporter /go/bin/resque-exporter

USER nobody:nogroup

EXPOSE 9447
ENTRYPOINT ["/go/bin/resque-exporter"]
