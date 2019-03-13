FROM golang:1.10.2 AS builder

RUN go version

COPY . "/go/src/github.com/tinhan/go-restful-api-example"
WORKDIR "/go/src/github.com/tinhan/go-restful-api-example"

#RUN go get -v -t  .
RUN set -x && \
    go get github.com/gorilla/mux && \  
    go get github.com/kkamdooong/go-restful-api-example
 

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build  -o /go-restful-api-example

CMD ["/go-restful-api-example"]

EXPOSE 8000



#########
# second stage to obtain a very small image
FROM scratch

COPY --from=builder /go-restful-api-example .

EXPOSE 8000

CMD ["/go-restful-api-example"]
