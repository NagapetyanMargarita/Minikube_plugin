
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
3. Далее необходимо установить необходимые зависимости с использованием Makefile. Запустите:
```
eval $(minikube -p minikube docker-env)
pip install -r requirements.txt
```

4. Для подключения к нодам и отправки уведомлений в Telegram добавьте собственные значения в .env по шаблону .env_template.

5.	Остается только запустить программу. Это можно сдлеать 2-я способами:
* 5.1. С помощью Makefile. Для этого необходимо перейти в корень проекта, после чего запустить команду make run (для запуска всей программы).
* 5.2.	С помощью команды: helm upgrade --install kuard ./kuard-0.1.0.tgz --set tag=0.1.1 --set ip_ssh="mZsRGR…=" --set config="VDI4e…=" --set schedule="22 * * * *". 

>В случае проблем с открытием кода можно обратиться к https://github.com/NagapetyanMargarita/Minikube_plugin

