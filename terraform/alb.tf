

# module "alb" {
#   source  = "terraform-aws-modules/alb/aws"
#   version = "6.4.0"

#   name = "scaling-alb"

#   load_balancer_type = "application"

#   vpc_id          = module.vpc.vpc_id
#   security_groups = [module.security_group.security_group_id]
#   subnets         = module.vpc.public_subnets

#   #   # See notes in README (ref: https://github.com/terraform-providers/terraform-provider-aws/issues/7987)
#   #   access_logs = {
#   #     bucket = module.log_bucket.s3_bucket_id
#   #   }

#   http_tcp_listeners = [
#     # Forward action is default, either when defined or undefined
#     {
#       port               = 80
#       protocol           = "HTTP"
#       target_group_index = 0
#       action_type        = "forward"
#     },
#     # {
#     #   port        = 81
#     #   protocol    = "HTTP"
#     #   action_type = "redirect"
#     #   redirect = {
#     #     port        = "443"
#     #     protocol    = "HTTPS"
#     #     status_code = "HTTP_301"
#     #   }
#     # },
#     # {
#     #   port        = 82
#     #   protocol    = "HTTP"
#     #   action_type = "fixed-response"
#     #   fixed_response = {
#     #     content_type = "text/plain"
#     #     message_body = "Fixed message"
#     #     status_code  = "200"
#     #   }
#     # },
#   ]

# #   https_listeners = [
# #     {
# #       port               = 443
# #       protocol           = "HTTPS"
# #       certificate_arn    = module.acm.acm_certificate_arn
# #       target_group_index = 1
# #     },
# #     # Authentication actions only allowed with HTTPS
# #     {
# #       port               = 444
# #       protocol           = "HTTPS"
# #       action_type        = "authenticate-cognito"
# #       target_group_index = 1
# #       certificate_arn    = module.acm.acm_certificate_arn
# #       authenticate_cognito = {
# #         authentication_request_extra_params = {
# #           display = "page"
# #           prompt  = "login"
# #         }
# #         on_unauthenticated_request = "authenticate"
# #         session_cookie_name        = "session-${random_pet.this.id}"
# #         session_timeout            = 3600
# #         user_pool_arn              = aws_cognito_user_pool.this.arn
# #         user_pool_client_id        = aws_cognito_user_pool_client.this.id
# #         user_pool_domain           = aws_cognito_user_pool_domain.this.domain
# #       }
# #     },
# #     {
# #       port               = 445
# #       protocol           = "HTTPS"
# #       action_type        = "authenticate-oidc"
# #       target_group_index = 1
# #       certificate_arn    = module.acm.acm_certificate_arn
# #       authenticate_oidc = {
# #         authentication_request_extra_params = {
# #           display = "page"
# #           prompt  = "login"
# #         }
# #         authorization_endpoint = "https://${local.domain_name}/auth"
# #         client_id              = "client_id"
# #         client_secret          = "client_secret"
# #         issuer                 = "https://${local.domain_name}"
# #         token_endpoint         = "https://${local.domain_name}/token"
# #         user_info_endpoint     = "https://${local.domain_name}/user_info"
# #       }
# #     },
# #   ]

# #   https_listener_rules = [
# #     {
# #       https_listener_index = 0

# #       actions = [
# #         {
# #           type = "authenticate-cognito"

# #           on_unauthenticated_request = "authenticate"
# #           session_cookie_name        = "session-${random_pet.this.id}"
# #           session_timeout            = 3600
# #           user_pool_arn              = aws_cognito_user_pool.this.arn
# #           user_pool_client_id        = aws_cognito_user_pool_client.this.id
# #           user_pool_domain           = aws_cognito_user_pool_domain.this.domain
# #         },
# #         {
# #           type               = "forward"
# #           target_group_index = 0
# #         }
# #       ]

# #       conditions = [{
# #         path_patterns = ["/some/auth/required/route"]
# #       }]
# #     },
# #     {
# #       https_listener_index = 1
# #       priority             = 2

# #       actions = [
# #         {
# #           type = "authenticate-oidc"

# #           authentication_request_extra_params = {
# #             display = "page"
# #             prompt  = "login"
# #           }
# #           authorization_endpoint = "https://${local.domain_name}/auth"
# #           client_id              = "client_id"
# #           client_secret          = "client_secret"
# #           issuer                 = "https://${local.domain_name}"
# #           token_endpoint         = "https://${local.domain_name}/token"
# #           user_info_endpoint     = "https://${local.domain_name}/user_info"
# #         },
# #         {
# #           type               = "forward"
# #           target_group_index = 1
# #         }
# #       ]

# #       conditions = [{
# #         host_headers = ["foobar.com"]
# #       }]
# #     },
# #     {
# #       https_listener_index = 0
# #       priority             = 3
# #       actions = [{
# #         type         = "fixed-response"
# #         content_type = "text/plain"
# #         status_code  = 200
# #         message_body = "This is a fixed response"
# #       }]

# #       conditions = [{
# #         http_headers = [{
# #           http_header_name = "x-Gimme-Fixed-Response"
# #           values           = ["yes", "please", "right now"]
# #         }]
# #       }]
# #     },
# #     {
# #       https_listener_index = 0
# #       priority             = 5000
# #       actions = [{
# #         type        = "redirect"
# #         status_code = "HTTP_302"
# #         host        = "www.youtube.com"
# #         path        = "/watch"
# #         query       = "v=dQw4w9WgXcQ"
# #         protocol    = "HTTPS"
# #       }]

# #       conditions = [{
# #         query_strings = [{
# #           key   = "video"
# #           value = "random"
# #         }]
# #       }]
# #     },
# #   ]

# #   http_tcp_listener_rules = [
# #     {
# #       http_tcp_listener_index = 0
# #       priority                = 3
# #       actions = [{
# #         type         = "fixed-response"
# #         content_type = "text/plain"
# #         status_code  = 200
# #         message_body = "This is a fixed response"
# #       }]

# #       conditions = [{
# #         http_headers = [{
# #           http_header_name = "x-Gimme-Fixed-Response"
# #           values           = ["yes", "please", "right now"]
# #         }]
# #       }]
# #     },
# #     {
# #       http_tcp_listener_index = 0
# #       priority                = 5000
# #       actions = [{
# #         type        = "redirect"
# #         status_code = "HTTP_302"
# #         host        = "www.youtube.com"
# #         path        = "/watch"
# #         query       = "v=dQw4w9WgXcQ"
# #         protocol    = "HTTPS"
# #       }]

# #       conditions = [{
# #         query_strings = [{
# #           key   = "video"
# #           value = "random"
# #         }]
# #       }]
# #     },
# #   ]

# #   target_groups = [
# #     {
# #       name_prefix          = "h1"
# #       backend_protocol     = "HTTP"
# #       backend_port         = 80
# #       target_type          = "instance"
# #       deregistration_delay = 10
# #       health_check = {
# #         enabled             = true
# #         interval            = 30
# #         path                = "/healthz"
# #         port                = "traffic-port"
# #         healthy_threshold   = 3
# #         unhealthy_threshold = 3
# #         timeout             = 6
# #         protocol            = "HTTP"
# #         matcher             = "200-399"
# #       }
# #       protocol_version = "HTTP1"
# #       targets = {
# #         my_ec2 = {
# #           target_id = aws_instance.this.id
# #           port      = 80
# #         },
# #         my_ec2_again = {
# #           target_id = aws_instance.this.id
# #           port      = 8080
# #         }
# #       }
# #       tags = {
# #         InstanceTargetGroupTag = "baz"
# #       }
# #     },
# #     # {
# #     #   name_prefix                        = "l1-"
# #     #   target_type                        = "lambda"
# #     #   lambda_multi_value_headers_enabled = true
# #     #   targets = {
# #     #     # Lambda function permission should be granted before
# #     #     # it is used. There can be an error:
# #     #     # NB: Error registering targets with target group:
# #     #     # AccessDenied: elasticloadbalancing principal does not
# #     #     # have permission to invoke ... from target group ...
# #     #     my_lambda = {
# #     #       target_id = module.lambda_function.lambda_function_arn
# #     #     }
# #     #   }
# #     # },
# #   ]

#   tags = {
#     Project = "auto-scaling"
#   }

#   lb_tags = {
#     MyLoadBalancer = "auto-scaling"
#   }

# #   target_group_tags = {
# #     MyGlobalTargetGroupTag = "bar"
# #   }

#   https_listener_rules_tags = {
#     MyLoadBalancerHTTPSListenerRule = "auto-scaling"
#   }

#   https_listeners_tags = {
#     MyLoadBalancerHTTPSListener = "auto-scaling"
#   }

#   http_tcp_listeners_tags = {
#     MyLoadBalancerTCPListener = "auto-scaling"
#   }
# }




