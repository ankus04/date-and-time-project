FROM golang AS builder
WORKDIR /app
COPY . .
RUN go build -o main .
EXPOSE 8085
CMD ["./main"]