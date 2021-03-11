### SwarmMon

###### Install dockers of Grafana, Mysql and go-binary swarmon service to the server
```
cd /root
wget https://github.com/doristeo/SwarmMonitoring/raw/main/docker/instsrv.sh
chmod +x instsrv.sh
./instsrv.sh
```

###### Install a script that sends data to the server for each node
```
cd /root
wget https://github.com/doristeo/SwarmMonitoring/raw/main/send.sh
chmod +x send.sh
crontab -e
```
add this string ``` */10 * * * * /root/send.sh http://public_IP_of_your_server:8080 >> /dev/null 2>&1``` <br>
and restart cron ```systemctl restart cron``` <br>
The node will send data to the monitoring server every 10 minutes.











