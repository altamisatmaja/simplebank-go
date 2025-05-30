postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -d postgres:12-alpine
createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simplebank
migrateup:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/simplebank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/simplebank?sslmode=disable" -verbose down
dropdb:
	docker exec -it postgres12 dropdb simplebank
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
server:
	go run main.go
.PHONY: postgres createdb dropdb migrateup migratedown test