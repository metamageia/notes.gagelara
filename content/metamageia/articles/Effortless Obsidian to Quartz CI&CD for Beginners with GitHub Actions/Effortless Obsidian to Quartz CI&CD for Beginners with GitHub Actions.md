
1. Setup Obsidian Repo
	1. Obsidian Vault and Github Repo - assumes basic obsidian proficiency and existing vault, provide screenshots. Can be private or public. 
		1. Create a folder in your vault for the site contents 
		2. include a note tiled "index" to serve as your home page
2. Create Quartz Website per [the docs](https://quartz.jzhao.xyz/)
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
	- quote and explain action to add to the obsidian vault, referencing the PAT created and making the destination ./content. Explain the index.md test.
	- optional section below for excluding files or directories, such as when using your root as the content and you want to exclude private or dotfiles
- Maintaining multiple sites from the same vault
	- Just create multiple folders, each with their own contents.
	- Follow step 3 again and customize configuration and layout (or if starting with the same settings, save time by duplicating an existing repo by going to GitHub import the repo to a new repo) to create a new site. Remember to set github pages setting to actions
	- Add a new job for each site OR separate workflows for each site, including the new sources and destinations and PAT key
	- every site will be updated simultaneously everytime you push your main vault 
- Conclusion 
	- Benefits, why I do it, example use cases
	- Call to action to share
	- Link NVDH video on quartz, how I found out about it. Link again to quartz documentation for issues
	- link to github actions docs
	- link to the example file push action by [DataLbry](https://github.com/datalbry)
		- https://github.com/marketplace/actions/push-a-directory-to-another-repository 
	- link to example file check action by [andstor](https://github.com/marketplace/actions/file-existence)
		- https://github.com/marketplace/actions/file-existence
	- Template Repository
		- https://github.com/metamageia/Quartz-Template
# Effortless Obsidian to Quartz CI/CD for Beginners with GitHub Actions

## Table of Contents
- Introduction
	- Why I use Obsidian
	- Why Quartz over Obsidian Publish 
	- Who This Is For
	- Goal & Scope
- What is CI/CD?
	- Continuous Integration
	- Continuous Deployment
	- Workflow Overview
- Preparing your Obsidian Vault
	- Prerequisites
	- Initializing the Repository
	- Creating the Website Folder & Contents
- Setting up and Hosting the Quartz Static Site
	- Creating a new Repository from Template
	- GitHub Pages Setup
- CI/CD Pipeline
	- Automating Quartz Site Build & Deployment
		- Setting Source and Destination paths in both the Test and the Copy stages
	- Setting up your PAT and Secrets Management
	- Automating Quartz Site Content Updates
- Maintaining Multiple Sites from the same Vault
- Conclusion

## Introduction

For a few years now I've run my life in [Obsidian](https://obsidian.md/). Everything - including research, project management, TTRPG notes, and this post you're reading now - lives in my personal Obsidian vault. I recently refactored this "second brain" of mine and begin sharing my notes online as an exercise in "learning in public".

There's a number of tools for sharing your markdown notes online, including Obsidian's own great [publish service](https://obsidian.md/publish). However, given my own enthusiasm for DIY approaches I decided it'd be better (and more fun) to host my own solution: enter [Quartz](https://quartz.jzhao.xyz/), a fast and easy to use static site generator purpose built for publishing markdown notes that I could host on GitHub Pages *for free*. 

Setting up Quartz is a straight forward task; however, the process of manually copying the markdown notes from my vault, building, then deploying the website on a regular basis introduced a lot of friction that got in the way of the work I'd rather be doing. My goal: automate getting notes from my vault to a live site with a single Git push so I could easily backup my notes *and* publish my updated website with a single command.

In this post, I'll walk you through the steps of how you can easily set up a fully automated notes-to-published-website pipeline using GitHub Actions. This simple tutorial will assume you already have some notes in Obsidian you'd like to publish, and that you have a basic understanding of Git - enough to create a repository, make commits, and push to GitHub. 

Rather than configuring Quartz entirely from scratch, I provide a template repository so you can get started fast. For a detailed overview of setting up and customizing Quartz from scratch, check out [the official documentation](https://quartz.jzhao.xyz/).

By following this process, you’ll quickly set up a maintainable and scalable publishing workflow, freeing you to focus on writing. We’ll walk through preparing your vault, configuring GitHub Actions to automatically build and deploy your Quartz website, and extending this to easily updating multiple sites from within a single vault. 

With that out of the way, let’s dive into the CI/CD basics that power this workflow. 

## What is CI/CD?

Continuous Integration (CI) is a software development practice in which developers regularly push code changes to a repository, triggering automated builds and tests. This approach keeps the codebase up to date and surfaces potential problems early. Automating the process of copying notes from your vault to the Quartz repository, filtering out unwanted directories, validating essential files, and building the website reduces what could become an hour-long chore to mere seconds.

Continuous Deployment (CD) is a software delivery strategy where code changes that have passed integration are automatically released to production. Every step of the delivery process after your commit is handled by automated tools and scripts, with no need for manual intervention. That means from the moment you push your updated notes to your repository, the transformation from plain Markdown to a published website happens quickly and effortlessly.

Put together, embracing a CI/CD workflow to publishing your vault means you can spend your valuable time and energy working on your notes rather than the repetitive and time consuming tasks of testing, building, and deployment. 

## Preparing your Obsidian Vault
The first step is to set up your content folder. This can be the root folder of your vault if you intend to publish most/all of your notes, or it can be any folder in your vault. You will need to create a file named index.md in the folder you'd like to publish to serve as the homepage of your website. 

By default, each page of your Quartz site will display the name of the file as its title. You can optionally set the yaml property 'title' to display a page title different than the file name, such as I've done here for my homepage. 

![[Example-Vault.png]]

The next step is to create a GitHub repository with the contents of your Obsidian vault. If you have one already, that's great - you won't need to make a new one. This repo can be either public or private, that's entirely up to you. Your website will be hosted in a separate repository and the CI/CD workflow we'll be building will allow you to selectively choose which folders in your vault get published, allowing you to maintain complete control over what is public and what is private. Once you're done setting up your Obsidian vault repository, you're to create your Quartz repo. 

## Setting up the Quartz Static Site

Because this tutorial is focused on basic CI/CD principles for beginners, we won't be building a Quartz website from scratch - so no Node.js knowledge or dependency installation required! Instead, go to the [Quartz template repository](https://github.com/metamageia/Quartz-Template) I've provided and create a new repository from this template. Give your website repo an appropriate name and keep all other settings as their defaults. 

![[Create Repo from Template.png]]

## The CI/CD Workflow
## Maintaining Multiple Sites from a Single Vault
## Conclusion
