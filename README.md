# 🍺 MikoMikocchi Homebrew Tap

[![CI](https://github.com/MikoMikocchi/homebrew-tap/actions/workflows/ci.yml/badge.svg)](https://github.com/MikoMikocchi/homebrew-tap/actions/workflows/ci.yml)
[![Auto Bump](https://github.com/MikoMikocchi/homebrew-tap/actions/workflows/auto-bump.yml/badge.svg)](https://github.com/MikoMikocchi/homebrew-tap/actions/workflows/auto-bump.yml)

<p align="center">
  <img src="docs/images/Homebrew_logo.png" alt="Homebrew" width="220" />
</p>

This is a Homebrew tap with curated CLI tools. Focus on reproducible, offline-ready installs and CI-driven maintenance.

## Install

```bash
brew tap MikoMikocchi/homebrew-tap
brew install pretty-git
```

Upgrade:
```bash
brew upgrade pretty-git
```

## Requirements
- macOS or Linux with Homebrew
- Other dependencies are resolved via Homebrew automatically

## What’s inside
- Formulae live in `Formula/`
- Casks (if added later) live in `Casks/`
- CI
  - `ci.yml`: style, audit, install and test for all formulas (auto-detected)
  - `auto-bump.yml`: daily livecheck and PR with version bumps

## Packages
- [`pretty-git`](https://github.com/MikoMikocchi/pretty-git) — Git repository analytics and reporting CLI.

## Troubleshooting
- Update Homebrew: `brew update`
- Reinstall formula: `brew reinstall <formula>`
- Show logs: `brew gist-logs <formula>`
- Retap: `brew untap MikoMikocchi/homebrew-tap && brew tap MikoMikocchi/homebrew-tap`

## Contributing
See `CONTRIBUTING.md`. Issues and PRs are welcome.

## License
MIT — see `LICENSE`.
