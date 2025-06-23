
## Useful Commands

- `git blame <file>` annotates each line of a file with the commit hash, author, and timestamp of the last change to that line.
- `git log` displays the commit history of a repository in reverse chronological order—showing the most recent commits first.
- `git config alias.<alias-name> <git commands>` lets you combine commands & options into a singe alias. Only configures in the repo by default, add `--global` for all repos. Can be used to run scrips by using a bang e.g. `git config alias.<alias-name> !<shell-script>.sh`.
- `git config --global rerere.enabled true` Reuse Recorded Resolution. Allows git to "remember" how specific merge conflicts are resolved and automatically reuse that solution in the future. 
- `git branch` Lists all of the branches in a repo. 
- `git force push --with-lease`
- `git maintenance start` 

---

## Videos

- [So You Think You Know Git - FOSDEM 2024](https://www.youtube.com/watch?v=aolI_Rz0ZqY&t) 