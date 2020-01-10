#!/bin/sh
# データを DB にロードしなおすスクリプト
 
PGHOME='/usr/local/pgsql'
PGPORT=5432                                                                                                                                                                                                                                                                                                                                                
DBNAME=$1
DIR='~'
 
echo '... start ...'
echo ''
 
echo '[1/2] reinitialize database';
$PGHOME/bin/dropdb -p $PGPORT $DBNAME
$PGHOME/bin/createdb -p $PGPORT $DBNAME -E EUC_JP -T template0
$PGHOME/bin/psql -p $PGPORT $DBNAME < $DIR/$1.sql
 
echo ''
 
# VACUUM ANALYZE
echo '[2/2] vacuum and analyze'
$PGHOME/bin/vacuumdb -z -p $PGPORT $DBNAME
echo ''
 
echo '... end ...'
