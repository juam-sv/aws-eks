
# aws-eks

## Diagrama.

![Alt text](./eks.drawio.svg)
<!-- <img src="./eks.drawio.svg)"> -->

### Instruções.
1. Primeiramente configure as credenciais e/ou o AWS CLI caso vá rodar localmentel, segue a [doc](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

2. Instale o [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) ou [opentofu](https://opentofu.org/docs/intro/install/)
3. Faça um clone do projeto com 
```bash
git clone --recursive git@github.com:juam-sv/aws-eks.git
```

4. Altere o [arquivo de configuração do cluster](https://github.com/juam-sv/aws-eks/blob/main/terraform/config.yaml) caso ache necessário,

5. Opcionalmente, caso tenha criado novos workspaces no arquivo [config.yaml](https://github.com/juam-sv/aws-eks/blob/main/terraform/config.yaml). crie os correspondentes no terraform.

```bash
$ tofu workspace new dev-produto1-us-east-1
$ tofu workspace select dev-produto1-us-east-1
```

```yaml
# config.yaml
workspaces:
  default: #workspace default
    region: "us-east-1"
    eks:
      - name: cluster1 #Nome do cluster
...
      - name: cluster2
...
  workspace1:
    region: "us-west-1"
    eks:
      - name: cluster3
...

```

5. Faça o deploy do cluster usando o terraform/opentofu

```bash
$  cd  terraform
$  tofu  init
$  tofu  apply
```

6. Opcionalmente, Gere o kubeconfig e faça o deploy do manifesto localmente, se não rode direto a pipe que ela também faz o deploy da aplicação.

```bash
$  aws eks update-kubeconfig --region us-east-1 --name cluster1
$  kubectl apply -f k8s/app.yaml
deployment.apps/api-labs  created
service/external-api-labs-service  created
horizontalpodautoscaler.autoscaling/api-labs  created
```

7. Verifique e teste o endpoint gerado.

```bash
$  kubectl  get  svc
NAME  TYPE  CLUSTER-IP  EXTERNAL-IP  PORT(S)  AGE
external-api-labs-service  LoadBalancer  123.456.789.123  endpoint.elb.us-east-1.amazonaws.com  5000:30808/TCP  69m
kubernetes  ClusterIP  123.20.0.1  <none>  443/TCP  83m

$  curl  http://endpoint.elb.us-east-1.amazonaws.com:5000/time
```

8. Para rodar o pipeline configure as seguinte secrets no github e faça algum commit ou rode a pipe manualmente (Actions > Workflows > build-and-deploy > Run Workflow), também é possivel alterar as ENVs.

- AWS_ACCESS_KEY_ID

- AWS_SECRET_ACCESS_KEY

- DOCKER_PASSWORD

- DOCKER_USERNAME

9. Verifique a tag do deploy.
```bash
kubectl describe deployments api-labs
```

10. Para deletar o ambiente.
```bash
kubectl delete -f k8s/app.yaml
cd terraform
tofu destroy -auto-approve
```

11. Links Adicionais

- Doc da API de teste [https://github.com/juam-sv/api-labs](https://github.com/juam-sv/api-labs/tree/f2f4fbf0294cb56a61284eb2802163b49fcf659e)

- Doc do Modulo criado de EKS/VPC- [README](./terraform/eks_vpc/README.md)