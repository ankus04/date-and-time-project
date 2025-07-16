###########################
##       BASE IMAGE      ##
###########################

FROM golang AS builder

WORKDIR /app

COPY . .

RUN go build -o main .

EXPOSE 8085

##################################
##       MULTI STAGE BUILD      ##
##################################

FROM scratch

COPY --from=builder /app/main .

CMD ["/main"]