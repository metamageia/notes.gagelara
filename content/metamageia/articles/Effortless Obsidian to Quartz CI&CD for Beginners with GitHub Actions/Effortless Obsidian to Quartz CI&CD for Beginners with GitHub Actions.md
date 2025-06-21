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
	- Quartz Deploy Workflow
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

> Note: If you'd prefer to create your Quartz from scratch follow the steps outlined in the official docs starting with the [setup](https://quartz.jzhao.xyz/), [build](https://quartz.jzhao.xyz/build), and the [GitHub repository](https://quartz.jzhao.xyz/setting-up-your-GitHub-repository) then follow along with the next step.

![[Create Repo from Template.png]]

Once you've created your website's Quartz repository you'll need to set up GitHub Pages. On your Quartz repo page click on the Settings tab, open the Pages section under Code and Automation, and set the Build and Deployment source to GitHub Actions. 

![[Github-Pages.png]]

Now that we have two separate repositories for your source (Obsidian) and your website (Quartz), it's time to link them together and set up some automation.

## Creating the CI/CD Workflow

GitHub Actions is GitHub's built-in automation platform that allows you to easily trigger many parts software development process, including your CI/CD pipeline, all from right within your repository. This is done by including YAML scripts called Workflows in your repository's `.github/workflows/` directory. Each Workflow consists of one or more Jobs, and each job runs in a virtual environment provided by GitHub executing a sequence of user defined shell commands or reusable "Actions" from the GitHub Marketplace. 

Our CICD pipeline will live in two Workflow scripts, which we will create step by step:
1. `push-quartz-content.yml` will live in the `.github/workflows/` folder of your Obsidian repository. It will copy the contents of the designated source folder, filter out any unwanted files & folders you define (without affecting your source repository), run a basic test checking for a valid `index.md` file, then push the files to the destination Quartz repo overwriting its `content` folder.
2. `deploy.yml` will live in the `.github/workflows/` folder of your Quartz repository, and will automatically build and deploy the Quartz website each time a commit is pushed to the `main` branch. 

Here you can start to see the CI/CD pipeline come into view: 
`Push Obsidian Vault to Repo > Copy Website Content > Filter Files > Check Index.md > Push to Quartz Repo > Build Quartz > Deploy Website`

For this project, we'll start with the deploy workflow in your Quartz vault first and get preview the website. For these steps you can either work in your code editor of choice, or create/edit files directly on the GitHub website. 

### Quartz Deploy Workflow

In your Quartz repo, create a file named `deploy.yml` in `.github/workflows/` with the following contents: 
```
name: Deploy Quartz site to GitHub Pages
 
on:
  push:
    branches:
      - main
 
permissions:
  contents: read
  pages: write
  id-token: write
 
concurrency:
  group: "pages"
  cancel-in-progress: false
 
jobs:
  build:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0 # Fetch all history for git info
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - name: Install Dependencies
        run: npm ci
      - name: Build Quartz
        run: npx quartz build
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: public
 
  deploy:
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

Everything in this workflow can be left as is. Breaking down what this workflow does piece by piece:
- `name: Deploy Quartz site to GitHub Pages` Sets a human friendly name for the workflow as it will be displayed in the GitHub UI.
- `on: push: branches: [ main ]` Defines the trigger for the workflow - in this case, the workflow run each time a commit is pushed to the branch `main`.
- `permissions:` Sets the specific permissions the workflow has when interacting with the GitHub API or other GitHub features.
- `concurrency:` Helps to manage overlapping processes and prevents workflows from interfering with each other. By setting `group: "pages"` and `cancel-in-progress: false`, GitHub actions knows to delay subsequent workflows in the `pages` group until after this workflow finishes. The is useful for situations where you push an update to the website before the workflow finishes, guaranteeing that changes occur in order. 
- `jobs:` Defines two jobs to be run, `build` and `deploy`:
	- `build` Sets up a virtual Ubuntu environment and runs through the process of installing dependencies, building the Quartz site, and uploading the completed artifact to GitHub Pages.
	- 'deploy' Waits for `build` to finish by setting `needs: build`, targets GitHub's built-in `github-pages` environment, then deploys the built artifact using the built in `deploy-pages` action.

After you've created your workflow, commit and push your changes to the Quartz repository, at which point the workflow will execute the build & deploy process. You can view the current status of your workflow(s) in the Actions tab of your GitHub repo.

![[github-actions.png]]

> Note: Here we see the workflow has comleted sucessfully. A yellow icon indicates a workflow in progress. A red `x` icon indicates a failed workflow/error, click on the workflow for more information. 
> 
> If you don't see your workflow at all, check to make sure the workflow file extension is correct, and that you've set your GitHub Pages source to Actions.

After a successful deployment, you can preview your website at `https://<YOUR-USERNAME>.github.io/<QUARTZ-REPO-NAME>/`. To start you'll only see the default Quartz placeholder website, which means it's time to connect your repositories and add some content. 

![[default-site.png]]

### Setting up a PAT & Secrets Management

Before we can set up a workflow connecting our two repositories, we need to talk about secrets management and Personal Access Tokens (PATs). If you're new to managing secrets, you can think of this as a PAT as a "robot password" that allows automated processes to authenticate to GitHub on your behalf. While workflows can be directly granted some permissions for working within the scope of its own repository, they require additional authentication to perform more volatile tasks such as interacting with other repositories. By creating and assigning a PAT, you can grant workflows specific permissions they otherwise wouldn't have - such as committing files from one repo to another, which is what we'll be doing here. 

To create a PAT, you will need to go to your GitHub account settings. In the sidebar, go to Developer settings → Personal access tokens → Tokens (classic) create a new token. Note down what the token is for, set an expiration, and select the `repo` scope.

![[PAT.png]]

> IMPORTANT: Once you generate the token, keep it open in another tab or stored in a *secure place* - you will need it for the next step, and won't be able to view it again once you close the tab.

Next, we need to add the PAT to our Obsidian repository so it will have the permissions necessary to copy notes over to your website repo. In a separate tab open your Obsidian vault repository page, to the settings tab, then in the sidebar go to Secrets and variables → Actions. Click New Repository Secret. Name the secret `QUARTZ_REPO_PAT` and paste the PAT you generated in the previous step. Once you successfully add the secret, you can safely close the other tab. 

![[Repository Secrets.png]]

With the PAT added to your Obsidian vault repository, we can move on to the final piece of your CI/CD pipeline. 

### Push Quartz Content Workflow

In your Obsidian vault repo, create a file named `push-quartz-content.yml` in `.github/workflows/` with the following contents: 

```
name: Push Content to Quartz Vaults

on: push

jobs:
  update-quartz-content:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v2

    - name: Check if Index.md exists
      id: check_files
      uses: andstor/file-existence-action@v3
      with:
        files: "./index.md"

    - name: Index exists
      if: steps.check_files.outputs.files_exists == 'true'
      run: echo "index.md check passed!"

    - name: Index does not exist
      if: steps.check_files.outputs.files_exists == 'false'
      run: |
        echo "index.md does not exist! Please provide an index.md file - aborting"
        exit 1

    - name: Push Obsidan Content Folder
      uses: datalbry/copy_folder_to_another_repo_action@1.0.0
      env:
        API_TOKEN_GITHUB: ${{ secrets.QUARTZ_REPO_PAT }}
      with:
        source_folder: '<PATH_TO_YOUR_SOURCE_FOLDER>'
        destination_repo: '<YOUR_USERNAME>/<QUARTZ-REPO-NAME>'
        destination_folder: 'content'
        destination_branch: 'main'
        user_email: '<YOUR_EMAIL>'
        user_name: '<YOUR_USERNAME>'
        commit_msg: 'Update Quartz Website Content'
```

Before we break it down, pay special care to edit these specific lines:
- `API_TOKEN_GITHUB: ${{ secrets.QUARTZ_REPO_PAT }}` If you named your PAT your repository secrets `QUARTZ_REPO_PAT` this can remain the same. If you gave it a different name, update it here. 
- `source_folder: '<PATH_TO_YOUR_SOURCE_FOLDER>'` Sets the path to the specific folder in your Obsidian vault repository created `index.md` in to be copied and pushed to the other repo.
- `destination_repo: '<YOUR_USERNAME>/<QUARTZ-REPO-NAME>'` Should be updated to point at your Quartz repository so the workflow pushes the content to the correct location. 
- `user_email: '<YOUR_EMAIL>'`, `user_name: '<YOUR_USERNAME>'`, and `commit_msg: 'Update Quartz Website Content'` will set your identity and commit message when the workflow pushes to the destination repo.

The structure is the same as the `deploy.yml` workflow we created earlier. As for what the job steps do:
- `Checkout` Sets up the virtual Ubuntu environment
- `Check if Index.md exists` does a quick test to see if `index.md` exists in the content folder's root, and aborting the job if it doesn't exist. This prevents the workflow from pushing content without a valid index and breaking the website at deployment. 
- `Push Obsidan Content Folder` Then commits the verified (and optionally, filtered - see below) contents and pushes them to the destination Quartz repository, completely overwriting its `./content` folder.

>Optional: You can remove specific files and folders by placing an `rm -rf` step *after* `Checkout` but *before* `Push Obsidian Content Folder`. This is especially useful if you're publishing your vault's root folder and want to filter out dotfiles or private folders:
```
- name: Remove .obsidian and .github folders
  run: rm -rf .obsidian .github
```

That final `Push Obsidan Content Folder` step is where these workflows finally click together and the CI/CD pipeline is finally complete. When you push your updated Obsidian notes to the Obsidian vault repository it immediately run the `push-quartz-content.yml` workflow, which by finishing with a push to the main branch of your Quartz repository then triggers the `on: push:` condition of the `deploy.yml` workflow, fully automating the integration and deployment process. 

After pushing the changes to your Obsidian vault repo, the workflows in both vaults will run and if you open the rebuild & redeployed site at `https://<YOUR-USERNAME>.github.io/<QUARTZ-REPO-NAME>/` you will now see the site's been updated with the content from your Obsidian vault. 

![[Final-Website.png]]

## Maintaining Multiple Sites from a Single Vault
## Conclusion
