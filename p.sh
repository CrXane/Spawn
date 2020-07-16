#!/bin/bash

# Mass server launch

exists () {
	test -e $1
}

if ! exists mass-servers; then
	mkdir mass-servers; fi; cd mass-servers
if ! exists hlds.zip; then
	echo "You need mass-servers/hlds.zip to start launching servers"; exit 1; fi

create_server () {
	mkdir $1
	mv hlds.zip $1
	cd $1
	unzip -qq hlds.zip
	mv hlds.zip ..
	chmod +x hlds_run
	chmod +x hlds_linux
	screen -A -m -d -S hlds$1 ./hlds_run -console -game cstrike +ip $3 +port $port +maxplayers 16 +map de_dust2 +hostname Server$2
	cd ..
	echo $2") ("$1") "$3":"$port
	((port++))
}

port=27015
counter=1

while [ $counter -le $1 ]; do
	create_server $RANDOM $counter $2
	((counter++))
done
