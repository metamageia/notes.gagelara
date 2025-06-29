- Created an IAM User and Account Alias
- Created an [[AWS S3]] bucket, enabled static web hosting in the properties, and added a placeholder `index.html`
- Created an [[AWS CloudFront]] distribution with my S3 Bucket as the origin. 
	- Note: Do not enable the static website option, make sure the CloudFront distribution has a root object set 
- Registered new domain with Namecheap
- Create [[AWS Route 53]] Hosted Zone
	- Add the four nameservers under `Value/Route traffic to` to the Namecheap Custom DNS name servers
- Setup SSL/TLS cert in [[AWS Certificate Manager (ACM)]] 
	- Use DNS Verification by created a Route 53 Record
- In CloudFront distribution add alternative domain names, add the custom SSL certificate
- In route 53 create alias records pointing to the CloudFront distributions for any subdomains

Recap: Learned how to configure S3 Buckets and add content. Set up CloudFront distribution for selectively exposing bucket contents to the web. Configured domain name with Route 53, created SSL/TLS Certificate using ACM, and directed custom domain traffic to CloudFront Distribution. 

---

- Set up AWS CLI and Installed [[Terraform]] 
- Initialized `infra.resume.gagelara`, created a basic `main.tf` that sets a budget and creates an S3 bucket. 
- Connecting AWS to Github Actions
	- Set Up an [[Open ID Connect (OIDC)]] Identity Provider in AWS
	- Create a properly permissioned role in IAM
- Created a terraform bootstrap with a [[AWS DynamoDB]] table & S3 bucket for 
- Terraformed CloudFront and OAC

Recap: Managed to get pretty comfortable with the Terraform workflow and starting to learn HCL. Set up a basic GitOps workflow for deploying to AWS 

---

- Refactored the resume.gagelara repo
- developed the frontend
- set up a gitops pipeline for updating the frontend content
- separated infra and frontend workflows to maintain separation of concerns 

---

Todo
- Terraform Route53 as a child host zone, 
- JS Visitor Counter
- Database to retrieve and update the database with dynamo db
- create an API for DDB with AWS API Gateway and Lambda python functions, including tests


---
- [Cloud Resume Challenge](https://cloudresumechallenge.dev/docs/the-challenge/aws/)
- [Terraform Your Cloud Resume Challenge](https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/)
- [DevOps Roadmap](https://roadmap.sh/devops)

