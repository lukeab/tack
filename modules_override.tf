# # Overrides the vpc module in the modules.tf, just loads the variables defined for the existing vpc and reuses those
# #
# # Uncomment to enable the override
# module "vpc" {
#   source = "./modules/vpc-existing"
#   azs = "${ var.aws["azs"] }"
#   cidr = "${ var.cidr["vpc"] }"
#   name = "${ var.name }"
#   region = "${ var.aws["region"] }"
#   id = "${ var.vpc-existing["id"] }"
#   gateway-id = "${ var.vpc-existing["gateway-id"] }"
#   subnet-ids-public = "${ var.vpc-existing["subnet-ids-public"] }"
#   subnet-ids-private = "${ var.vpc-existing["subnet-ids-private"] }"
# }
# 
module "worker" {
  source = "./modules/worker"
  depends-id = "${ module.route53.depends-id }"

  ami-id = "${ var.coreos-aws["ami"] }"
  bucket-prefix = "${ var.s3-bucket }"
  capacity = {
    desired = 1
    max = 3
    min = 1
  }
  cluster-domain = "${ var.cluster-domain }"
  hyperkube-image = "${ var.k8s["hyperkube-image"] }"
  hyperkube-tag = "${ var.k8s["hyperkube-tag"] }"
  dns-service-ip = "${ var.dns-service-ip }"
  instance-profile-name = "${ module.iam.instance-profile-name-worker }"
  instance-type = "${ var.instance-type["worker"] }"
  internal-tld = "${ var.internal-tld }"
  key-name = "${ var.aws["key-name"] }"
  name = "${ var.name }"
  region = "${ var.aws["region"] }"
  security-group-id = "${ module.security.worker-id }"
  subnet-ids = "${ module.vpc.subnet-ids-private }"
  volume_size = {
    ebs = 250
    root = 52
  }
  vpc-id = "${ module.vpc.id }"
  worker-name = "general"
}