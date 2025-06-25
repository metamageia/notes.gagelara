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

- Create Frontend Repo with AWS Secrets management and update s3 bucket with GitOps


- JS Visitor Counter
- Database to retrieve and update the database with dynamo db
- create an API for DDB with AWS API Gateway and Lambda python functions, including tests


---
- [Cloud Resume Challenge](https://cloudresumechallenge.dev/docs/the-challenge/aws/)
- [Terraform Your Cloud Resume Challenge](https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/)
- [DevOps Roadmap](https://roadmap.sh/devops)

