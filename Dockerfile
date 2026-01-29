FROM golang:1.25.6 AS builder

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o master .

FROM gcr.io/distroless/base

COPY --from=builder /app/master .

COPY --from=builder /app/static ./static

EXPOSE 8080

CMD [ "./master" ]

