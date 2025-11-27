module "vpc"{
    source = "./vpc"

}

module "ecs"{
    source = "./ecs"
    private_subnet_ids = module.vpc.private_subnet_ids
    target_group_arn = module.alb.gatus_alb_target_group_arn
    ecs_service_sg_id = module.security_groups.ecs_service_sg_id
    gatus_image = "${module.ecr.gatus_repo_url}"
}
module "alb"{
    source = "./alb"
    vpc_id = module.vpc.vpc_id
    public_subnet_ids = module.vpc.public_subnet_ids
    gatus_alb_sg_id = module.security_groups.alb_sg_id
    certificate_arn = module.acm.certificate_arn
}
module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
}
module "acm"{
    source = "./acm"
}
module "route53"{
    source = "./route53"
    alb_dns_name = module.alb.alb_dns_name
    alb_zone_id = module.alb.alb_zone_id
}
module "ecr"{
    source = "./ecr"
}