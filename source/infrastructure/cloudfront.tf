resource "aws_cloudfront_distribution" "main" {
  enabled     = true
  comment     = "${var.project_name} CDN in front of the ALB"
  price_class = "PriceClass_100"

  origin {
    domain_name = aws_lb.main.dns_name
    origin_id   = "${var.project_name}-alb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "${var.project_name}-alb-origin"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = true
      headers      = ["Host", "Authorization"]
      cookies {
        forward = "all"
      }
    }

    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
   # cloudfront_default_certificate = true
    # For a custom domain, replace with an ACM certificate in us-east-1:
    # acm_certificate_arn = aws_acm_certificate.cdn.arn
    # ssl_support_method  = "sni-only"
  }

  tags = merge(var.tags, { Name = "${var.project_name}-cdn" })
}
