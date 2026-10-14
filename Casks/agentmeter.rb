cask "agentmeter" do
  version "0.1.0"
  sha256 "e15a6c5210c8d5bd8ec781fa9d75f102ea1328c93c4de3b6f54c79d2bc1e6c39"

  url "https://github.com/rhuss/agentmeter/releases/download/v#{version}/AgentMeter-#{version}.dmg"
  name "AgentMeter"
  desc "Menu bar meter for coding-agent usage limits and budgets"
  homepage "https://github.com/rhuss/agentmeter"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "AgentMeter.app"

  uninstall quit: "dev.rhuss.agentmeter"

  zap trash: [
    "~/.config/llm-usage-menubar",
    "~/Library/Logs/llm-usage-menubar",
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
