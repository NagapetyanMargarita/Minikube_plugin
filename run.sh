#!/bin/bash

source my_vars.env

echo "Начало установки"

if [ -z "$IP_SSH" ]; then
  echo "Вы не передали IP_SSH, происходит автоматическая подстановка"
  IP=$(minikube ip)
  PRIVATE_KEY=$(cat ~/.minikube/machines/minikube/id_rsa)
  IP_SSH=$(echo -n "{\"$IP\": \"$(echo "$PRIVATE_KEY" | sed ':a;N;s/\n/\\n/g;ta')\"}" | base64)
  export IP_SSH
  echo "export IP_SSH=\"$IP_SSH\"" >> my_vars.env
  echo "Переменная IP_SSH добавлена."
fi

echo "----------------------Установка необходимых библиотек и зависимостей--------------------------"
pip install -r requirements.txt
echo "-------------------------------------Установка завершена--------------------------------------"

echo ""
echo ""

NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
SSH_KEY="$HOME/.minikube/machines/minikube/id_rsa"
SSH_USER="docker"


read -p "Желаете использовать сторонний анализатор Trivy? (Да/Нет): " tryvy_accept
tryvy_accept_standart=$(echo "$tryvy_accept" | awk '{print tolower($0)}' | tr -d '[:space:]')
accept=$(echo "Да" | awk '{print tolower($0)}' | tr -d '[:space:]')
if [ "$tryvy_accept_standart" == "$accept" ];then
  export enable_trivy=true
  if ! ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" ${SSH_USER}@${NODE_IP} "command -v trivy" &> /dev/null; then
    #curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | \
    #  sh -s -- -b /usr/local/bin latest
    ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" $SSH_USER@$NODE_IP \
      "curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | \
      sudo sh -s -- -b /usr/local/bin latest"

  # Проверка установки
    if ! ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" $SSH_USER@$NODE_IP "command -v trivy" &> /dev/null; then
      echo "Ошибка: Trivy не установился!"
      exit 1
    else
      VERSION=$(ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" $SSH_USER@$NODE_IP "trivy --version | head -n 1")
     echo "Tryvy $VERSION установлен"
    fi
  fi
else
 export enable_trivy=false
fi
echo ""
echo "Запуск программы:"
python3 -m kuard "$enable_trivy"