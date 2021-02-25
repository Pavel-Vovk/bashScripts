#!/bin/bash
server=35.211.146.42
file=specs/environments/default/docker-compose.yml
password=SandBoxPV
while getopts "s:f:p:h" opt; do
  case $opt in
  s) server="$OPTARG"
  ;;
  f) file="$OPTARG"
  ;;
  p) password="$OPTARG"
  ;;
  h) echo """The Script up and runing docker compose
	-s: Server of ClodBees CD
	-f: File of docker compose for up and running
	-p: password for changing on CB SDA
	"""
	exit;
	;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

echo "up and running the docker-compose based on file:"
echo ${file}
sudo docker-compose -f ${file} up -d
echo "waiting 2 minutes for up and running"
sleep 120
echo "connect to CB SDA Server: ${server}"
ectool --server ${server} login admin changeme
echo "chnage password"
ectool modifyUser admin --sessionPassword changeme --password ${password}
echo "check connection"
ectool --server ${server} login admin ${password}
