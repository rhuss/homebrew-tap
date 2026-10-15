cask "agentmeter" do
  version "0.2.2"
  sha256 "e1f600477ea32b0fadc8e1b80caae2ad0b441cfb96d33fe94cd2ccaf4c560836"

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
