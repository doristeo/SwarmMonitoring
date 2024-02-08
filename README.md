![2021-03-11_09-59-38](https://user-images.githubusercontent.com/3895507/110748305-98f32c00-8250-11eb-9098-75f2c5b89597.png)
<br><br><br>
## The nodes names must be different, otherwise it won't work!<br>
<br>


#### Install dockers of Grafana, Mysql and go-binary swarmon service to the SERVER
wewwew
**Debian:**
```
cd /root
wget https://github.com/doristeo/SwarmMonitoring/raw/main/docker/instdeb.sh
chmod +x instdeb.sh
./instdeb.sh
```

**Ubuntu:**
```
cd /root
wget https://github.com/doristeo/SwarmMonitoring/raw/main/docker/instubu.sh
chmod +x instubu.sh
./instubu.sh
```
**Centos:**<br>
Maybe later.

**Raspberry Pi**<br>
Never.

Default login/password to Grafana is admin/admin. 

#### Install a script that sends data to the server for EACH NODE
```
cd /root
wget https://github.com/doristeo/SwarmMonitoring/raw/main/send.sh
chmod +x send.sh
```
test all ```/root/send.sh http://public_IP_of_your_server:8080```, if ok you will see the data on your Grafana-server http://public_IP_of_your_server:3000.
```
crontab -e
```
add this string ``` */10 * * * * /root/send.sh http://public_IP_of_your_server:8080 > /dev/null 2>&1``` <br>
and restart cron ```systemctl restart cron``` <br>
The node will send data to the monitoring server every 10 minutes.<br>











