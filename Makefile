postgres:
	docker run --name postgres12  --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -d postgres:12-alpine
createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simplebank
migrateup:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/simplebank?sslmode=disable" -verbose up
migrateup1:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/simplebank?sslmode=disable" -verbose up 1
migratedown:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/simplebank?sslmode=disable" -verbose down
migratedown1:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/simplebank?sslmode=disable" -verbose down 1
dropdb:
	docker exec -it postgres12 dropdb simplebank
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
server:
	go run main.go
mock:
	mockgen -package mockdb  -destination db/mock/store.go github.com/altamisatmaja/simplebank-go/db/sqlc Store
seed:
	docker exec -i postgres12 psql -U root -d simplebank < db/seed/seeder.sql

.PHONY: postgres createdb dropdb migrateup migratedown test mock seedd migrateup1 migratedown1