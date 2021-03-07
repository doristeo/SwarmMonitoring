### SwarmMon

#### 1. Установим Grafana на VPS. Это может быть сервер с нодой или отдельный. Отдельный лучше, но не факт.

1.1 Установка Grafana в docker.

1.1.1 Установка Docker
Сначала установим сам docker по инструкции отсюда https://docs.docker.com/engine/install/debian/

Выжимка оттуда:
```
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```
Проверим, что docker установился нормально командой `sudo docker run hello-world`
Если среди вывода есть строки <br>**Hello from Docker!
This message shows that your installation appears to be working correctly.**, значит, всё в порядке.<br>
Установка Docker завершена. Переходим к установке Grafana.

1.1.2 Установка Grafana.
Инструкция описана здесь https://grafana.com/grafana/download?platform=docker
Хотя, там только одна команда:<br>
`docker run -d --name=grafana -p 3000:3000 grafana/grafana:7.4.3-ubuntu`<br>
Проверьте успешность установки `http://имя_или_IP_VPS:3000/`, вас должно встретить окно авторизации.<br> Вход по-умолчанию **admin/admin**. <br>Обязательно смените пароль!<br>Далее вас встретит интерфейс Grafana, но тут пока ничего делать не надо.

#### 2. Установка MySQL server в docker.
Инструкция тут https://dev.mysql.com/doc/mysql-installation-excerpt/8.0/en/docker-mysql-getting-started.html,<br> но нам нужна одна команда:
`docker pull mysql/mysql-server:latest`<br>
Запустим контейнер с mysql-server<br>
`docker run --name=mysql  --restart on-failure -d mysql/mysql-server:latest`

Проверим, какие контейнеры запущены:<br>
`docker ps`
![dockerps](https://user-images.githubusercontent.com/3895507/110248513-a96e8280-7f82-11eb-9051-112c19a53d0a.png)
Получим пароль для root, сгенерированный нам конейнером:
`docker logs mysql 2>&1 | grep GENERATED`

СОХРАНИМ ЕГО В НАДЁЖНОЕ МЕСТО!



