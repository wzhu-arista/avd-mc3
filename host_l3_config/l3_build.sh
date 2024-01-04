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

# CMD3='cat /etc/hostname; \
# sudo vconfig add team0 112; \
# sudo ifconfig team0.112 10.1.12.103 netmask 255.255.255.0; \
# sudo ip link set up team0.112; \
# sudo ip route add 10.1.0.0/16 via 10.1.12.1 dev team0.112; \
# sudo ifconfig team0.112; \
# sudo route -n
# '

# CMD4='cat /etc/hostname; \
# sudo vconfig add team0 113; \
# sudo ifconfig team0.113 10.1.13.104 netmask 255.255.255.0; \
# sudo ip link set up team0.113; \
# sudo ip route add 10.1.0.0/16 via 10.1.13.1 dev team0.113; \
# sudo ifconfig team0.113; \
# sudo route -n'

echo "[INFO] Configuring clab-mc2-client1"
docker exec -it  clab-dci-mc3-server1 /bin/sh -c "$CMD1"

echo "[INFO] Configuring clab-mc2-client2"
docker exec -it  clab-dci-mc3-server2 /bin/sh -c "$CMD2"

# echo "[INFO] Configuring clab-avdirb-client3"
# docker exec -it  clab-avdirb-client3 /bin/sh -c "$CMD3"

# echo "[INFO] Configuring clab-avdirb-client4"
# docker exec -it  clab-avdirb-client4 /bin/sh -c "$CMD4"

echo "[INFO] Completed"

echo "Use [ docker exec -it clab-dci-dc<x>-Server<x> /bin/sh ] to login in host."