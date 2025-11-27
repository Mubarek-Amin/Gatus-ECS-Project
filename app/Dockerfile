FROM golang:1.25-alpine AS build

WORKDIR /app

COPY . .

RUN go mod download 

#static binary(c dependenies disabled), ensure linux executable ,building main go file and tagging with name = gatus
RUN CGO_ENABLED=0 GOOS=linux go build -o gatus main.go

FROM scratch

WORKDIR /app

COPY --from=build /app/gatus .

COPY --from=build  /app/config.yaml ./config.yaml

EXPOSE 8080

# path to config.yaml must be stated in in this env
ENV GATUS_CONFIG_PATH=/app/config.yaml

ENTRYPOINT [ "./gatus" ]

CMD ["-config", "/app/config.yaml"]
