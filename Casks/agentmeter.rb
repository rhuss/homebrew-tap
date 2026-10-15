cask "agentmeter" do
  version "0.3.0"
  sha256 "fe493a08a54cf6b638e931b06b74de3bdd368496799d7a785f654e7ae720da6d"

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
