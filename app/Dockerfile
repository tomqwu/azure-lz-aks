FROM golang:1.20-alpine AS builder

WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o demo-app .

FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/demo-app .
ENV PORT=8080
EXPOSE 8080
CMD ["./demo-app"]
