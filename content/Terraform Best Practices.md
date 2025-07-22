General Conventions
- Use `_` (underscore) instead of `-` (dash) in naming.
- Use lowercase letters and numbers

Resource and Data Source
- Do not repeat resource type in the resource name. 
	- Example: Prefer `"asw_route_table" "public" {}` over `"aws_route_table" "public_route_table" {}`
- Use the resource name `this` if there is no more descriptive and general name, or if the module creates a single resource of type.
- Singular nouns
- Use `-` in arguments values and places where it will be exposed to a human. 
- 


----

- https://www.terraform-best-practices.com/naming