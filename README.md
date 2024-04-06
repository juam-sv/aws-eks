# aws-eks

 1. Primeiramente configure o AWS CLI caso vá rodar localmentel, segue a [doc](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
 2. Instale o terraform ou [opentofu](https://opentofu.org/docs/intro/install/)
 3. Altere o [arquivo de configuração do cluster](https://github.com/juam-sv/aws-eks/blob/main/terraform/config.yaml) caso ache necessário, 
 4. Opcionalmente, caso tenha criado novos workspaces no arquivo [config.yaml](https://github.com/juam-sv/aws-eks/blob/main/terraform/config.yaml). crie os correspondentes no terraform.
  ```
$ tofu workspace new dev-produto1-us-east-1
```
 ```
# config.yaml
workspaces:
	default: #workspace default
		region:  "us-east-1"
			eks:
				-  name:  cluster1 #Nome do cluster
			...
				- name: cluster2
			...
	dev-produto1-us-east-1: #workspace referenciado acima
		region:  "us-west-1"
			-  name:  cluster3
			...
```
 5. Faça o deploy do cluster usando o terraform/opentofu
```
cd terraform 
tofu init
tofu apply
``` 
6. Gere o kubeconfig e faça o deploy do manifesto
```
$ aws eks update-kubeconfig --region us-east-1 --name cluster-name
$ kubectl apply -f k8s/app.yaml
deployment.apps/api-labs created
service/external-api-labs-service created
horizontalpodautoscaler.autoscaling/api-labs created
``` 
7. Verifique e teste o endpoint gerado.
```
kubectl describe svc external-api-labs-service
curl http://endpoint:5000/time
``` 
