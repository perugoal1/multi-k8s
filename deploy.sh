docker build -t perugoal1/multi-client:latest -t perugoal1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t perugoal1/multi-server:latest -t perugoal1/multi-server:$SHA -f ./server/Dockerfilev ./server
docker build -t perugoal1/multi-worker:latest -t perugoal1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push perugoal1/multi-client:latest
docker push perugoal1/multi-client:$SHA
docker push perugoal1/multi-server:latest
docker push perugoal1/multi-server:$SHA
docker push perugoal1/multi-worker:latest
docker push perugoal1/multi-worker:$SHA


kubectl apply -f k8s

kubectl set image deployments/server-deployment server=perugoal1/multi-server:$SHA
kubectl set image deployments/client-deployment client=perugoal1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=perugoal1/multi-worker:$SHA