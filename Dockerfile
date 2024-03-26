FROM python:3.10.12

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

#COPY .kube/config /root/.kube/config

#RUN chmod 644 /root/.kube/config

#COPY .minikube /root/.minikube

COPY . .

CMD make run
