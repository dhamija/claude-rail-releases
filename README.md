# Claude Rail — releases

Ready-to-install builds of [Claude Rail](https://github.com/dhamija/claude-rail): a side rail,
session grid and companion skills for Claude Code on macOS. Each release is a tarball of the
runtime (app, skills, commands, installer); the source lives in a private repo.

## Install

```bash
# Homebrew
brew tap dhamija/claude-rail
brew trust --tap dhamija/claude-rail        # Homebrew 6 loads third-party taps only once trusted
brew install claude-rail && claude-rail-app --grid   # the first launch finishes the setup

# or the one-liner
curl -fsSL https://raw.githubusercontent.com/dhamija/claude-rail-releases/main/install.sh | bash
```

Needs macOS, Node.js 18+ and python3. The first launch deploys `~/.claude-rail`, builds the app's
dependencies there (about a minute: Electron is downloaded), installs the skills and commands into
`~/.claude`, enables the hooks and creates the "Claude Rail" app in ~/Applications. Later,
`claude-rail update` installs the next release.
