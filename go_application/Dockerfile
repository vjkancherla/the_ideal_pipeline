##
## Build
##
FROM golang:1.10-alpine AS build-stage

WORKDIR /go/src/app

COPY ./src .

RUN go install -v

##
## Deploy
##
FROM alpine:latest AS build-release-stage

WORKDIR /

COPY --from=build-stage /go/bin /go/bin

ENTRYPOINT ["/go/bin/app"]
