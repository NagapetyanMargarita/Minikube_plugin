#!/bin/bash

source my_vars.env

echo "Начало установки"

if [ -z "$IP_SSH" ]; then
  echo "Вы не передали IP_SSH, происходит автоматическая подстановка"
  IP=$(minikube ip)
  PRIVATE_KEY=$(cat ~/.minikube/machines/minikube/id_rsa)
  IP_SSH=$(echo -n "{\"$IP\": \"$(echo "$PRIVATE_KEY" | sed ':a;N;s/\n/\\n/g;ta')\"}>  export IP_SSH
  echo "export IP_SSH=\"$IP_SSH\"" >> my_vars.env
  echo "Переменная IP_SSH добавлена."
fi

echo "----------------------Установка необходимых библиотек и зависимостей---------->
pip install -r requirements.txt
echo "-------------------------------------Установка завершена---------------------->
echo ""
echo ""
echo "Запуск программы:"
python3 -m kuard