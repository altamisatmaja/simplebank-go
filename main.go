package main

import (
	"database/sql"
	"log"

	"github.com/altamisatmaja/simplebank-go/api"
	db "github.com/altamisatmaja/simplebank-go/db/sqlc"
	"github.com/altamisatmaja/simplebank-go/util"
	_ "github.com/lib/pq"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("Cannot load config: ", err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)

	if err != nil {
		log.Fatal("Cannot read database: ", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("Cannot start server:  ", err)
	}

}
