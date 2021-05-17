CMD="sqoop import --connect jdbc:sqlserver://[HOSTNAME];database=[DBNAME] \
  --username [USERNAME] \
  --password [PASSWORD] \
  --table [TABLENAME] \
  --num-mappers [MAPPERS] \
  --hive-delims-replacement "anything" \
  --fields-terminated-by '^' \
  --hive-overwrite \
  --hive-import \
  --hive-database [HDATABASE] \
  --hive-table [TABLENAME]"


STARTDATE=`date +'%Y%m%d%H:%M'`
HOSTNAME=`grep HOSTNAME db.properties|cut -d= -f2`
DBNAME=`grep DATABASE db.properties|cut -d= -f2`
USERNAME=`grep USERNAME db.properties|cut -d= -f2`
PASSWORD=`grep PASSWORD db.properties|cut -d= -f2`
HDATABASE=`grep HDATABASE hive.properties|cut -d= -f2`
LOCATION=`grep LOCATION hive.properties|cut -d= -f2`

for LINE in `cat ${1}`;
do
  TABLE=`echo ${LINE}|cut -d: -f1`
  MAPPERS=`echo ${LINE}|cut -d: -f2`
  SPLITBY=`echo ${LINE}|cut -d: -f3`
  TABLENAME_H=`echo ${LINE}|cut -d: -f5`

  SQOOPCMD=`echo $CMD | sed -e "s/\[TABLENAME\]/${TABLE}/g"`
  SQOOPCMD=`echo $SQOOPCMD | sed -e "s/\[MAPPERS\]/${MAPPERS}/g"`
  SQOOPCMD=`echo $SQOOPCMD | sed -e "s/\[HOSTNAME\]/${HOSTNAME}/g"`
  SQOOPCMD=`echo $SQOOPCMD | sed -e "s/\[DBNAME\]/${DBNAME}/g"`
  SQOOPCMD=`echo $SQOOPCMD | sed -e "s/\[USERNAME\]/${USERNAME}/g"`
  SQOOPCMD=`echo $SQOOPCMD | sed -e "s/\[PASSWORD\]/${PASSWORD}/g"`
  SQOOPCMD=`echo $SQOOPCMD | sed -e "s/\[HDATABASE\]/${HDATABASE}/g"`
  SQOOPCMD=`echo $SQOOPCMD | sed -e "s/\[LOCATION\]/${LOCATION}/g"`
  SQOOPCMD=`echo $SQOOPCMD | sed -e "s/\[TABLENAME_H\]/${TABLENAME_H}/g"`


 if [ "${SPLITBY}" != "NA" ]; then
    SQOOPCMD="${SQOOPCMD} --split-by ${SPLITBY}"
  else
    SQOOPCMD="${SQOOPCMD} --autoreset-to-one-mapper"
  fi
  echo "Loading ${TABLENAME} using ${SQOOPCMD}"
  `${SQOOPCMD} 2>sqoop_${STARTDATE}_${TABLE}.err 1>sqoop_${STARTDATE}_${TABLE}.out`
  NOOFRECORDS=`grep "Retrieved .* records" sqoop_${STARTDATE}_${TABLE}.err|cut -d" " -f6`
  echo ${STARTDATE}:${TABLE}:${NOOFRECORDS} >> sqoop_livedemo.log
done

