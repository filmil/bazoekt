# Gemini CLI Workspace Rules

## Git Commit Rules (Semantic Commits)

This repository follows the Conventional Commits specification. All commits must adhere to the following semantic structure:

### Format
`<type>[optional scope]: <description>`

### Allowed Types
* **feat**: A new feature
* **fix**: A bug fix
* **docs**: Documentation only changes
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
* **refactor**: A code change that neither fixes a bug nor adds a feature
* **perf**: A code change that improves performance
* **test**: Adding missing tests or correcting existing tests
* **build**: Changes that affect the build system or external dependencies (e.g., Bazel, Go modules)
* **ci**: Changes to CI configuration files and scripts (e.g., GitHub Actions)
* **chore**: Other changes that don't modify src or test files
* **revert**: Reverts a previous commit

### Rules for the Description
* Use the imperative, present tense: "change" not "changed" nor "changes".
* Do not capitalize the first letter.
* No dot (.) at the end.

### Body (Optional)
* Provide context, motivation for the change, and contrast it with previous behavior.
* Use the imperative, present tense.

### Footer (Optional)
* Reference related issues (e.g., `Fixes #123`).
* Note any **BREAKING CHANGES**.
