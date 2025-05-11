FROM golang:1.17-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod downloadqq

COPY . .

RUN CGO_ENABLED=0 go build -ldflags="-w -s -extldflags '-static'" -o /fizzbuzz

FROM scratch

COPY --from=builder /fizzbuzz /fizzbuzz
COPY --from=builder /app/templates /templates

CMD ["/fizzbuzz", "serve"]