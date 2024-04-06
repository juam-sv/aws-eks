#####
# Módulo Terraform para Criar um Cluster EKS na AWS

Este módulo do Terraform é utilizado para criar um cluster EKS (Amazon Elastic Kubernetes Service) na AWS.
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.44.0 |

## Inputs
| Nome | Descrição | Tipo | Padrão |
|------|-----------|------|--------|
| vpc_cidr | O CIDR para a VPC. | `string` | `"10.0.0.0/16"` |
| public_subnet_number | O número de sub-redes públicas a serem criadas. | `number` | `3` |
| private_subnet_number | O número de sub-redes privadas a serem criadas. | `number` | `3` |
| tags | Tags adicionais para anexar aos recursos. | `map(string)` | `{}` |
| aws_region | A região da AWS. | `string` | `"us-east-1"` |
| eks_version | A versão do EKS. | `string` | `"1.27"` |
| subnet_ids | Lista de IDs das sub-redes. | `list(string)` | `[]` |
| cluster_security_group_id | Lista de IDs dos grupos de segurança do cluster. | `list(string)` | `[""]` |
| eks_cluster_name | Nome do cluster EKS. | `string` | |
| endpoint_private_access | Indica se o acesso privado ao endpoint do cluster EKS está habilitado. | `bool` | `true` |
| endpoint_public_access | Indica se o acesso público ao endpoint do cluster EKS está habilitado. | `bool` | `true` |
| scale_desire | O número desejado de instâncias no grupo de nós. | `number` | `1` |
| scale_min | O número mínimo de instâncias no grupo de nós. | `number` | `0` |
| scale_max | O número máximo de instâncias no grupo de nós. | `number` | `3` |
| capacity_type | O tipo de capacidade do grupo de nós. | `string` | `"ON_DEMAND"` |
| instance_types | Lista de tipos de instância para o grupo de nós. | `list(string)` | `["t3.small", "t3.medium"]` |
| disk_size | O tamanho do disco em GB para as instâncias do grupo de nós. | `number` | `20` |


## Outputs

| Nome               | Descrição                               |
|--------------------|-----------------------------------------|
| private_subnet_ids | List of private subnet IDs              |
| public_subnet_ids  | List of public subnet IDs               |
| vpc_id             | ID for VPC created                      |
| all_subnet_ids     | List of all subnet IDs                  |
| eks_cluster_name   | Nome do cluster EKS                     |

