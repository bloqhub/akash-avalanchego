Сборка docker образа avalanchego для akash
```
git clone https://github.com/bloqhub/akash-avalanchego.git
cd akash-avalanchego
docker build -t bloqhub/avalanchego-ssh:0.1 ./
```
помещаем собранный образ в docker hub
```
docker push bloqhub/avalanchego-ssh:0.1
```
