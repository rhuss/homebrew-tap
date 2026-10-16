cask "agentmeter" do
  version "0.4.1"
  sha256 "35b1b9e5e2d9dc5cf17a3491002e48cc2b4d66290a82c96c3795ac9a16172fc1"

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
