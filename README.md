#### Install dockers of Grafana, Mysql and go-binary swarmon service to the SERVER
```
cd /root
wget https://github.com/doristeo/SwarmMonitoring/raw/main/docker/instsrv.sh
chmod +x instsrv.sh
./instsrv.sh
```


#### Install a script that sends data to the server for EACH NODE
```
cd /root
wget https://github.com/doristeo/SwarmMonitoring/raw/main/send.sh
chmod +x send.sh
```
test all ```/root/send.sh http://public_IP_of_your_server:8080```, if ok you will see the data in the Grafana on your server http://public_IP_of_your_server:3000.
```
crontab -e
```
add this string ``` */10 * * * * /root/send.sh http://public_IP_of_your_server:8080 >> /dev/null 2>&1``` <br>
and restart cron ```systemctl restart cron``` <br>
The node will send data to the monitoring server every 10 minutes.











