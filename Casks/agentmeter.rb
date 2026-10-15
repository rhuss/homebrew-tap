cask "agentmeter" do
  version "0.2.0"
  sha256 "b15e3731575f950f5b623eae5c3a3658f4a0b950b736269025cf7b8d8629ce7b"

  url "https://github.com/rhuss/agentmeter/releases/download/v#{version}/AgentMeter-#{version}.dmg"
  name "AgentMeter"
  desc "Menu bar meter for coding-agent usage limits and budgets"
  homepage "https://github.com/rhuss/agentmeter"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "AgentMeter.app"

  uninstall quit: "dev.rhuss.agentmeter"

  zap trash: [
    "~/.config/agentmeter",
    "~/Library/Logs/agentmeter",
    "~/Library/Preferences/dev.rhuss.agentmeter.plist",
  ]

  caveats <<~EOS
    AgentMeter is not notarized by Apple. After each install or upgrade,
    allow it once before it starts:
      macOS 14:          Control-click AgentMeter in Applications and choose Open.
      macOS 15 or later: open AgentMeter, then choose "Open Anyway" in
                         System Settings > Privacy & Security.
    Or run: xattr -dr com.apple.quarantine /Applications/AgentMeter.app

    Homebrew quits AgentMeter before an upgrade and opens it
    again afterwards.
  EOS
end
