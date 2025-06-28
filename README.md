# ClickhouseMagic

do odd stuff with clickhouse



## migrations

load the mysql and postgres tables and then run

```
mix migrate_clickhouse 
```


take a look after at spooky.sql

## delete clickhouse tables

```
mix rollback_clickhouse
```
