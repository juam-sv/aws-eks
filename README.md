# aws-eks

 1. Primeiramente configure as credenciais e/ou o AWS CLI caso vá rodar localmentel, segue a [doc](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
 2. Instale o [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) ou [opentofu](https://opentofu.org/docs/intro/install/)
 3. Altere o [arquivo de configuração do cluster](https://github.com/juam-sv/aws-eks/blob/main/terraform/config.yaml) caso ache necessário, 
 4. Opcionalmente, caso tenha criado novos workspaces no arquivo [config.yaml](https://github.com/juam-sv/aws-eks/blob/main/terraform/config.yaml). crie os correspondentes no terraform.
  ```bash
$ tofu workspace new dev-produto1-us-east-1
$ tofu workspace select dev-produto1-us-east-1
```
 ```yaml
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
```bash
$ cd terraform 
$ tofu init
$ tofu apply
``` 
6. Gere o kubeconfig e faça o deploy do manifesto
```bash
$ aws eks update-kubeconfig --region us-east-1 --name cluster-name
$ kubectl apply -f k8s/app.yaml
deployment.apps/api-labs created
service/external-api-labs-service created
horizontalpodautoscaler.autoscaling/api-labs created
``` 
7. Verifique e teste o endpoint gerado.
```bash
$ kubecolor get svc
NAME                        TYPE           CLUSTER-IP      EXTERNAL-IP                                                                     PORT(S)          AGE
external-api-labs-service   LoadBalancer   123.456.789.123   endpoint.elb.us-east-1.amazonaws.com   5000:30808/TCP   69m
kubernetes                  ClusterIP      123.20.0.1      <none>                                                                          443/TCP          83m

$ curl http://endpoint.elb.us-east-1.amazonaws.com:5000/time
``` 
 8. Para rodar o pipeline configure as seguinte secrets no github e faça algum commit ou rode a pipe manualmente.
 - AWS_ACCESS_KEY_ID
 - AWS_SECRET_ACCESS_KEY
 - DOCKER_PASSWORD
 - DOCKER_USERNAME

9. Links Adicionais
 - Doc da API de teste [https://github.com/juam-sv/aws-eks/tree/main/api-labs](https://github.com/juam-sv/aws-eks/tree/main/api-labs) 
 - Doc do Modulo criado de EKS/VPC- [https://github.com/juam-sv/aws-eks/tree/main/terraform/eks_vpc](https://github.com/juam-sv/aws-eks/tree/main/terraform/eks_vpc)