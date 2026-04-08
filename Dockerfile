FROM golang:1.25 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod tidy

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main main.go

FROM debian:bullseye-slim

WORKDIR /app

COPY --from=builder /main .

CMD ["/main"]
