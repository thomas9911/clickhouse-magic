mysql:
    docker-compose exec mysql mysql -u username --password=example my_database

postgres:
    docker-compose exec -e PGPASSWORD=example postgres psql --username=postgres my_database

clickhouse:
    docker-compose exec clickhouse clickhouse-client -d my_database
