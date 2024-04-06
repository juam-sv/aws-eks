# aws-eks

aws eks update-kubeconfig --name teste-tmp

for name in dev hml prod; do terraform workspace new "${name}-produto2-us-east-1"; done

kubecolor describe svc external-nginx-service