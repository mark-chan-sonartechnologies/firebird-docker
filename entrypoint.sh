#!/bin/bash

chown -R firebird:firebird /home/firebird

cd /opt/firebird
if [ ! -L security2.fdb ]
then

  mv security2.fdb security2.fdb.bak
  ln -s ${FIREBIRD_DATA_PATH}/config/security2.fdb security2.fdb
  chmod 640 ${FIREBIRD_DATA_PATH}/config/security2.fdb security2.fdb
fi

if [ ! -L aliases.conf ]
then
  mv aliases.conf aliases.conf.bak
  ln -s ${FIREBIRD_DATA_PATH}/config/aliases.conf aliases.conf
  chmod 666 ${FIREBIRD_DATA_PATH}/config/aliases.conf aliases.conf
fi

/etc/init.d/xinetd start
echo "[`date`] --> Firebird running..."
exec tail -f /dev/null
