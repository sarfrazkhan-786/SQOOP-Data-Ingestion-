#!/bin/bash
function getimportalltables() {
cat tables_1_115|while read LINE
do
  DBTABLE=${LINE}
  sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
  --connect 'jdbc:sqlserver://HOSTNAME;database=DATABASE_NAME' \
  --username lims_user_ro \
  --password-file /user/reach_sakhan/dcl_labware/labware.passwrd \
  --table ${LINE} \
  --hive-delims-replacement "anything" \
  --null-string '\\N' --null-non-string '\\N' \
  --autoreset-to-one-mapper \
  --fields-terminated-by '^' \
  --hive-overwrite \
  --hive-import \
  --hive-table dm_labware_live_db.${LINE}_stg 
 done
}
setProperties
getimportalltables
