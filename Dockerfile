# Build Stage
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .
COPY templates ./templates

RUN CGO_ENABLED=0 go build -o app .

# Final Stage
FROM scratch

COPY --from=builder /app/app /app
COPY --from=builder /app/templates ./templates

CMD ["/app"]