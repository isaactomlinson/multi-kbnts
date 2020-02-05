docker build -t isaactomlinson/multi-client:latest -t isaactomlinson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t isaactomlinson/multi-server:latest -t isaactomlinson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t isaactomlinson/multi-worker:latest -t isaactomlinson/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push isaactomlinson/multi-client:latest
docker push isaactomlinson/multi-server:latest
docker push isaactomlinson/multi-worker:latest

docker push isaactomlinson/multi-client:$SHA
docker push isaactomlinson/multi-server:$SHA
docker push isaactomlinson/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=isaactomlinson/multi-server:$SHA
kubectl set image deployments/client-deployment client=isaactomlinson/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=isaactomlinson/multi-worker:$SHA