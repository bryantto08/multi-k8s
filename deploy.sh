docker build -t bryantto08/multi-client:latest -t bryantto08/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bryantto08/multi-server:latest -t bryantto08/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bryantto08/mutli-worker:latest -t bryantto08/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bryantto08/multi-client:latest
docker push bryantto08/multi-server:latest
docker push bryantto08/multi-worker:latest
docker push bryantto08/multi-client:$SHA
docker push bryantto08/multi-server:$SHA
docker push bryantto08/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=bryantto08/multi-server:$SHA
kubectl set image deployments/client-deployment client=bryantto08/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bryantto08/multi-worker:$SHA