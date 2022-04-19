FROM alpine:3.14

COPY . /app

RUN apk add bash octave

WORKDIR /app

RUN chmod +x /app/dlogToCsv.sh

RUN mkdir -p /app/output

ENTRYPOINT [ "./dlogToCsv.sh"] 
