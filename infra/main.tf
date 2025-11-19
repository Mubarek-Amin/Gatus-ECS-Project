
module "vpc"{
    source = "./vpc"
}

module "ecs"{
    source = "./ecs"
}
module "alb"{
    source = "./alb"
}
module "acm"{
    source = "./acm"
}
module "route53"{
    source = "./route53"
}