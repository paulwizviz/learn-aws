
all: auth hello

auth: ./cmd/restapi/auth/main.go
	rm -rf ./build/restapi/auth/auth
	GOOS=linux go build -o ./build/restapi/auth/auth ./cmd/restapi/auth

hello: ./cmd/restapi/hello/main.go
	rm -rf ./build/restapi/hello/hello
	GOOS=linux go build -o ./build/restapi/hello/hello ./cmd/restapi/hello

clean:
	rm -rf ./build/restapi
	mkdir -p ./build/restapi