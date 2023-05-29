# CONTRIBUTING

Any contribution to this project is welcome. 

Here are some recommendations for those interested in creating Pull Requests.

## Conventional commits

In order to make commits history more readable, usage of conventional commits notation is recommended.

>The [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification is a lightweight convention on 
>top of commit messages. It provides an easy set of rules for creating an explicit commit history; which makes it easier 
>to write automated tools on top of. This convention dovetails with [SemVer](http://semver.org/), by describing the 
>features, fixes, and breaking changes made in commit messages.

## Git Hooks

We recommend using the Git Hooks, provided in the `.githooks` folder. 

To use them, simply configure the git config hooks path:

```shell
git config core.hooksPath .githooks/
```
