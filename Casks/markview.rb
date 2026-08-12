cask "markview" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.1"
  sha256 arm:   "45930f3744ffc7014026276d667207c3dd2a29b948fdcc864a3a13f2d74e0390",
         intel: "a2d1b3ae56a580d8b7f3a626e75ab18c4987cd4edc1014ef86bddcb3f3e2a99e"

  url "https://github.com/abgnydn/markview/releases/download/desktop-v#{version}/MarkView_#{version}_#{arch}.dmg"
  name "MarkView"
  desc "Local-first markdown editor, viewer, and presenter"
  homepage "https://markview.ai/"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^desktop[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on macos: :monterey

  app "MarkView.app"

  # These builds are ad-hoc signed (no Apple Developer ID, not notarized),
  # and macOS 15+ removed the right-click → Open bypass. Homebrew APPLIES
  # the quarantine attribute on install and no longer offers
  # --no-quarantine, so without this the app would be just as blocked as a
  # browser download. Stripping it here is what makes `brew install` a
  # working install path.
  #
  # This is the project's own signed-by-nobody build fetched over TLS from
  # its own GitHub release and checksum-verified above — remove this block
  # the moment the builds are properly signed and notarized.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/MarkView.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.markview.desktop",
    "~/Library/Caches/com.markview.desktop",
    "~/Library/HTTPStorages/com.markview.desktop",
    "~/Library/Preferences/com.markview.desktop.plist",
    "~/Library/Saved Application State/com.markview.desktop.savedState",
    "~/Library/WebKit/com.markview.desktop",
  ]
end
