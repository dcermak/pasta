ARG ARCH=

FROM ${ARCH}golang:buster AS build-env
WORKDIR /app
ADD . /app
#RUN apt-get update && apt-get upgrade -y
RUN cd /app && make requirements && make pastad-static

FROM scratch
#RUN mkdir /app
#RUN mkdir /data
WORKDIR /data
COPY --from=build-env /app/pastad /app/pastad
COPY --from=build-env /app/mime.types /app/mime.types
ENTRYPOINT ["/app/pastad", "-m", "/app/mime.types", "-c", "/data/pastad.toml"]
VOLUME ["/data"]
