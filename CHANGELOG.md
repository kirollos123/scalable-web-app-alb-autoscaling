# Changelog

## [1.0.0] - 2026-07-17
### Added
- Initial Terraform infrastructure: VPC (2 AZs, public/private/db subnets), ALB + WAF, Auto Scaling Group with target-tracking policy, RDS Multi-AZ, CloudFront, Route 53, CloudWatch dashboard + alarms with SNS notifications.
- Deployment scripts (`deployment/run-unit-tests.sh`, `deployment/deploy.sh`).
- Architecture diagram and documentation.
