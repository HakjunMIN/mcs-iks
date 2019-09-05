#!/bin/bash
echo "Running entrypoint script."

ARTIFACT=spigot-1.8.8-R0.1-SNAPSHOT-latest.jar

echo "Downloading $ARTIFACT"
wget -q https://cdn.getbukkit.org/spigot/$ARTIFACT -P /home/minecraft/

mv /home/minecraft/$ARTIFACT /home/minecraft/server.jar
echo "Accepting eula..."
echo "# Generated via Docker on $(date)" > /minecraft-data/eula.txt
echo "eula=$EULA" >> /minecraft-data/eula.txt
if [ $? != 0 ]; then
  echo "ERROR: unable to write eula to /data. Please make sure attached directory is writable by uid=${UID}"
  exit 2
fi

exec "$@"
