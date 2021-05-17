sqoop job --create INC_SAMPLE_APPEND \
--meta-connect jdbc:hsqldb:hsql://metaconnect.host.name:16000/sqoop \
-- import  --connect 'jdbc:sqlserver://HOSTNAME;database=DATABASE_NAME' \
--username 'lims_user_ro' --password-file '/user/reach_sakhan/dcl_labware/labware.passwrd' \
--table 'SAMPLE' \
--target-dir 'hdfs://nameservice1/user/hive/warehouse/hive_database_db.db/sample_stg/' \
--hive-delims-replacement "anything" \
--null-string '\\N' --null-non-string '\\N' \
--fields-terminated-by "^" \
--incremental lastmodified \
--check-column 'CHANGED_ON' \
--last-value '2021-04-27 00:00:00' \
--append \
-m 10 \
--verbose

#-	TEST


sqoop job --create INC_TEST_APPEND \
--meta-connect jdbc:hsqldb:hsql://metaconnect.host.name:16000/sqoop \
-- import  --connect 'jdbc:sqlserver://HOSTNAME;database=DATABASE_NAME' \
--username 'lims_user_ro' --password-file '/user/reach_sakhan/dcl_labware/labware.passwrd' \
--table ‘TEST’ \
--target-dir 'hdfs://nameservice1/user/hive/warehouse/hive_db.db/sample_stg/' \
--hive-delims-replacement "anything" \
--null-string '\\N' --null-non-string '\\N' \
--fields-terminated-by "^" \
--incremental lastmodified \
--check-column 'CHANGED_ON' \
--last-value '2021-04-27 00:00:00' \
--append \
-m 10 \
--verbose

#           - RESULT 
sqoop job --create INC_TEST_APPEND \
--meta-connect jdbc:hsqldb:hsql://metaconnect.host.name:16000/sqoop \
-- import  --connect 'jdbc:sqlserver://HOSTNAME;database=DATABASE_NAME' \
--username 'lims_user_ro' --password-file '/user/reach_sakhan/dcl_labware/labware.passwrd' \
--table ‘RESULT \
--target-dir 'hdfs://nameservice1/user/hive/warehouse/hive_db.db/sample_stg/' \
--hive-delims-replacement "anything" \
--null-string '\\N' --null-non-string '\\N' \
--fields-terminated-by "^" \
--incremental lastmodified \
--check-column 'CHANGED_ON' \
--last-value '2021-04-27 00:00:00' \
--append \
-m 10 \
--verbose

