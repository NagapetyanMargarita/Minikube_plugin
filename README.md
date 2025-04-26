
## Требования
* Наличие развернутого кластера Minikube
* Helm
* Kubectl
* Docker
* pip3

## Работа с программой
1. Склонируйте репозиторий в домашнюю деррикторию:
```
git clone https://github.com/NagapetyanMargarita/Minikube_plugin.git
```
2. Проверьте, что Minikube запущен, в противном случае выполните:
```
minikube start --driver=docker
```

3. Для подключения к нодам и отправки уведомлений в Telegram добавьте собственные значения в my_vars.env.

5.	Запустить программу. Она автоматическиу становит все необходимые зависисмости и запсутит код:
```
chmod +x run.sh
./run.sh
```

>В случае проблем с открытием кода можно обратиться к https://github.com/NagapetyanMargarita/Minikube_plugin

