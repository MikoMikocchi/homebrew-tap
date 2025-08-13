# Contributing

Thanks for contributing!

## Development setup
- Install Homebrew.
- Fork and clone this repo.
- Make changes on a branch.

## Checks
- Run:
  - `brew style --fix` (from repo root)
  - `brew audit --strict --online --tap=MikoMikocchi/homebrew-tap`
  - `brew install --build-from-source pretty-git && brew test pretty-git`

## Pull Requests
- Describe the change and motivation.
- Update docs/README if needed.
- Ensure CI is green.

## Release bumps
- Prefer using the auto-bump workflow or `brew bump-formula-pr --tap MikoMikocchi/homebrew-tap --url <new_url> --sha256 <new_sha>`.
