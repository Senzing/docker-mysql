FROM gliderlabs/alpine:3.6

ENV REFRESHED_AT=2018-10-09

RUN apk-install mysql-client

ENTRYPOINT ["mysql"]