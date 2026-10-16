cask "agentmeter" do
  version "0.4.0"
  sha256 "4079e07283ac86ae4c13f3b38e8a5df094b11f053cbfe87839a319285d867859"

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
