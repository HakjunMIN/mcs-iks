kubectl create secret generic mysecret --from-literal=ftpuser=<user-name> --from-literal=ftppassword=<user-password>


kubectl apply -f ftp-deployment.yaml -f ftp-service.yaml