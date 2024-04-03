## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | Região para realizar o deploy da  VPC | `string` | `"us-east-1"` | yes |
| vpc\_cidr | CIDR Range para a VPC. | `string` | `"10.0.0.0/16"` | yes |
| public_subnet_number | Numero de subnetes publicas | `Int` | `3` | no |
| private_subnet_number | Numero de subnetes privads  | `Int` | `3` | no |

## Outputs

No output.