cask "agentmeter" do
  version "0.3.1"
  sha256 "af43d5ae907d889d3b2c1c5996d9549539382d989c4559fc36a0d6059c68b4ce"

  url "https://github.com/rhuss/agentmeter/releases/download/v#{version}/AgentMeter-#{version}.dmg"
  name "AgentMeter"
  desc "Menu bar meter for coding-agent usage limits and budgets"
  homepage "https://github.com/rhuss/agentmeter"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "AgentMeter.app"

  uninstall quit: "dev.rhuss.agentmeter"

  zap trash: [
    "~/.config/agentmeter",
    "~/Library/Logs/agentmeter",
    "~/Library/Preferences/dev.rhuss.agentmeter.plist",
  ]

  caveats <<~EOS
    Homebrew quits AgentMeter before an upgrade and opens it
    again afterwards.
  EOS
end
