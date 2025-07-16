FROM golang

WORKDIR /app

COPY . .

RUN go build -o bin .

CMD ["./bin"]