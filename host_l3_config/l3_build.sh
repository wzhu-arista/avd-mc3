#!/bin/bash


CMD1='cat /etc/hostname; \
sudo vconfig add eth1 101; \
sudo ifconfig eth1.101 10.10.101.101 netmask 255.255.255.0;\
sudo ip link set up eth1.101; \
sudo ip route add 10.0.0.0/8 via 10.10.101.1 dev eth1.101; \
sudo ip route add 224/4 via 10.10.101.1 dev eth1.101; \
sudo ifconfig eth1.101; \
sudo route -n'

CMD2='cat /etc/hostname; \
sudo vconfig add team0 102; \
sudo ifconfig team0.102 10.10.102.102 netmask 255.255.255.0; \
sudo ip link set up team0.102; \
sudo ip route add 10.0.0.0/8 via 10.10.102.1 dev team0.102; \
sudo ip route add 224/4 via 10.10.102.1 dev team0.102; \
sudo ifconfig team0.102; \
sudo route -n'

CMD3='cat /etc/hostname; \
sudo vconfig add eth1 201; \
sudo ifconfig eth1.201 10.10.201.201 netmask 255.255.255.0; \
sudo ip link set up eth1.201; \
sudo ip route add 10.0.0.0/8 via 10.10.201.1 dev eth1.201; \
sudo ip route add 224/4 via 10.10.201.1 dev eth1.201; \
sudo ifconfig eth1.201; \
sudo route -n
'

CMD4='cat /etc/hostname; \
sudo vconfig add team0 202; \
sudo ifconfig team0.202 10.10.202.202 netmask 255.255.255.0; \
sudo ip link set up team0.202; \
sudo ip route add 10.0.0.0/8 via 10.10.202.1 dev team0.202; \
sudo ip route add 224/4 via 10.10.202.1 dev team0.202; \
sudo ifconfig team0.202; \
sudo route -n'

echo "[INFO] Configuring clab-mc3-dc1-server1"
docker exec -it  clab-mc3-dc1-server1 /bin/sh -c "$CMD1"

echo "[INFO] Configuring clab-mc3-dc1-server2"
docker exec -it  clab-mc3-dc1-server2 /bin/sh -c "$CMD2"

echo "[INFO] Configuring clab-mc3-dc2-server1"
docker exec -it  clab-mc3-dc2-server1 /bin/sh -c "$CMD3"

echo "[INFO] Configuring clab-mc3-dc2-server2"
docker exec -it  clab-mc3-dc2-server2 /bin/sh -c "$CMD4"

echo "[INFO] Completed"

echo "Use [ docker exec -it clab-mc3-dc<x>-Server<x> /bin/sh ] to login in host."