# syntax=docker/dockerfile:1

# Alpine is chosen for its small footprint
# compared to Ubuntu
FROM golang:1.17.8-alpine as build

WORKDIR /usr/src/app

COPY go.mod hello.go ./

# Download necessary Go modules
RUN go mod download && go mod verify
COPY *.go ./

RUN go build -o ./code-education

FROM hello-world as release

COPY --from=build /usr/src/app/code-education ./

CMD ["./code-education"]