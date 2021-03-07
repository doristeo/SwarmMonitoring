package main

import (
	"database/sql"
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"net/http"
	"strconv"

	_ "github.com/go-sql-driver/mysql"
	"github.com/gorilla/mux"
)

var mysqlUserptr *string
var mysqlPassptr *string

//---------------------------------------------------------------------------------------------------------------------------------
func CreateDatabase() (*sql.DB, error) {
	serverName := "localhost:3306"
	user := *mysqlUserptr
	password := *mysqlPassptr
	dbName := "swarms"

	connectionString := fmt.Sprintf("%s:%s@tcp(%s)/%s?charset=utf8mb4&collation=utf8mb4_unicode_ci&parseTime=true&multiStatements=true", user, password, serverName, dbName)
	db, err := sql.Open("mysql", connectionString)
	if err != nil {
		return nil, err
	}

	return db, nil
}

//---------------------------------------------------------------------------------------------------------------------------------
type Logdata struct {
	Name      string `json:"name"`
	Peers     int    `json:"peers"`
	Diskavail int    `json:"diskavail"`
	Diskfree  int    `json:"diskfree"`
}

//---------------------------------------------------------------------------------------------------------------------------------
func postFunction(w http.ResponseWriter, r *http.Request) {

	database, err := CreateDatabase()
	if err != nil {
		log.Fatal("Database connection failed")
	}

	var logdata Logdata
	json.NewDecoder(r.Body).Decode(&logdata)

	s := "INSERT nodes(name, peers, diskavail, diskfree) VALUES ('" + logdata.Name + "', " + strconv.Itoa(logdata.Peers) + ", " +
		strconv.Itoa(logdata.Diskavail) + ", " + strconv.Itoa(logdata.Diskfree) + ")"
	//fmt.Println(s)
	_, err = database.Exec(s)
	if err != nil {
		log.Println("Database INSERT failed --->>  \n" + s)
	}
}

//---------------------------------------------------------------------------------------------------------------------------------
func main() {

	mysqlUserptr = flag.String("user", "root", "MySQL user")
	mysqlPassptr = flag.String("pass", "root", "MySQL password")
	flag.Parse()

	database, err := CreateDatabase()
	if err != nil {
		log.Fatal("Database connection failed")
	}
	defer database.Close()

	router := mux.NewRouter()
	router.HandleFunc("/", postFunction).Methods("POST")

	srv := &http.Server{
		Handler: router,
		Addr:    ":8080",
	}
	log.Fatal(srv.ListenAndServe())

}
