# abgnydn/tap

Homebrew tap for [MarkView](https://markview.ai) — a local-first markdown
editor, viewer, and presenter.

## Install

```sh
brew install --cask abgnydn/tap/markview
```

That's it — the app lands in `/Applications` and opens normally.

## Why install this way?

The MarkView desktop builds are **ad-hoc signed**: the project doesn't have
an Apple Developer ID ($99/yr), so the app carries no notarization ticket.
Since macOS 15, Apple removed the right-click → Open bypass, so a DMG
downloaded in a browser is blocked outright with:

> "Apple could not verify 'MarkView' is free of malware that may harm your
> Mac or compromise your privacy."

Homebrew *applies* the quarantine attribute on install (and no longer offers
`--no-quarantine`), so this cask removes it in a `postflight` step. That is
what makes `brew install` a working install path rather than the same dead
end as a browser download.

What that trade means, plainly: you are choosing to trust MarkView builds on
the strength of the checksum in [`Casks/markview.rb`](Casks/markview.rb) and
the fact that they are built in public by
[this GitHub Actions workflow](https://github.com/abgnydn/markview/blob/main/.github/workflows/release-desktop.yml)
from [this source](https://github.com/abgnydn/markview), rather than on an
Apple notarization ticket. If you'd rather not make that trade,
[markview.ai](https://markview.ai) is the same editor in the browser and
needs no install at all.

The `postflight` block goes away the day the builds are properly signed and
notarized.

## Updating

```sh
brew update && brew upgrade --cask markview
```

## Uninstall

```sh
brew uninstall --cask markview          # remove the app
brew uninstall --zap --cask markview    # also remove its local data
```

Note that `--zap` deletes your MarkView workspaces (they live in the app's
local storage, not on a server).
