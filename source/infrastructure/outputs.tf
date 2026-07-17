output "vpc_id" {
  value = aws_vpc.main.id
}

output "alb_dns_name" {
  description = "Public DNS name of the ALB (use for quick testing before DNS propagates)"
  value       = aws_lb.main.dns_name
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "rds_endpoint" {
  value     = aws_db_instance.main.endpoint
  sensitive = true
}

output "application_url" {
  value = "http://${aws_lb.main.dns_name}"
}