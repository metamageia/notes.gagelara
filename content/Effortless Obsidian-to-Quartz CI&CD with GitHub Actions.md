Decide whether to write with the assumption of git knowledge?
1. Introduction
	1. Why I use obsidian, and why quartz over publish
	2. Brief intro to Quartz and static sites. Link to examples with TMV and TGGH
	3. Brief intro to GHA and [[Continuous Integration and Continuous Delivery (CI/CD)]] 
	4. Why automate the process and the value of managing one or multiple sites with a single push 
2. Setup Obsidian Repo
	1. Obsidian Vault and Github Repo - assumes basic obsidian proficiency and existing vault, provide screenshots. Can be private or public. 
		1. Create a folder in your vault for the site contents 
		2. include a note tiled "index" to serve as your home page
3. Create Quartz Website per [the docs](https://quartz.jzhao.xyz/)
	Method 1:
	1. Install at least Node v22 and npm v10.9.2
	2. In the terminal run:
```
git clone https://github.com/jackyzha0/quartz.git
cd quartz
npm i
npx quartz create
```
Note: Start with the defaults, creating an empty Quartz site. Create the repository on github, then summarize [the instructions](https://quartz.jzhao.xyz/setting-up-your-GitHub-repository) for pushing to the repo explain the basics of setting up [GitHub Pages with actions](https://quartz.jzhao.xyz/hosting#github-pages) including the default action. Explain the basics of how the action automatically builds and deploys on a push 
	Method 2 using Nix:
	Add optional nix-flake and instructions

Test deploy and check actions 

-  Tying it together
	- Explain that just like how the Quartz example action automates the build and deployment of the website, we can easily automate pushing updates to the Quartz repo each time we push our central vault repo, and that push will trigger the deploy action on the destination vault
	- include diagram
	- Create PAT and add it to the Obsidian vault repo with scope repo write / push (include the token name from the example actions for the tutorial). Restrict to specific repos you know you'll be managing as quartz sites, create a new PAT for each new site, and rotate PAT periodically. If you'll be creating a lot of personal sites, you can scope the PAT to all repos but this is very insecure and not recomended
	- quote and explain action to add to the obsidian vault, referencing the PAT created and making the destination ./content
	- optional section below for excluding files or directories, such as when using your root as the content and you want to exclude private or dotfiles
- Maintaining multiple sites from the same vault
	- Just create multiple folders, each with their own contents.
	- Follow step 3 again (or in GitHub import the repo to a new repo) to create a new site. Remember to set github pages setting to actions
	- Add a new job for each site OR separate workflows for each site, including the new sources and destinations and PAT key
	- every site will be updated simultaneously everytime you push your main vault 
- Conclusion 
	- Benefits, why I do it, example use cases
	- Call to action to share
	- Link NVDH video on quartz, how I found out about it. Link again to quartz documentation for issues
	- link to github actions docs
	- link to the example file push action by [DataLbry](https://github.com/datalbry)
		- https://github.com/marketplace/actions/push-a-directory-to-another-repository 