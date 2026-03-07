class CcSession < Formula
  desc "Fast CLI tool for finding and resuming Claude Code sessions"
  homepage "https://github.com/rhuss/cc-session"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rhuss/cc-session/releases/download/v0.3.0/cc-session-aarch64-apple-darwin.tar.xz"
      sha256 "7f3f0999bdcc1ddfa5b3ffabdf223d3099a25379e4ae580d27711ce03723cd6d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rhuss/cc-session/releases/download/v0.3.0/cc-session-x86_64-apple-darwin.tar.xz"
      sha256 "8292a3cc858ca25e51100a6a9386564ed0899cc7ce989d47a16e08a43c8d058c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rhuss/cc-session/releases/download/v0.3.0/cc-session-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8064c87af8ae3f021207dec2c25cf2f9a39b5072b1b61dd9aa16e6dd2327e317"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rhuss/cc-session/releases/download/v0.3.0/cc-session-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "56bddbe9bf3c5ab006d0eb6f858a35738bccb16dbe2de000adbfdbb28502af16"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "cc-session" if OS.mac? && Hardware::CPU.arm?
    bin.install "cc-session" if OS.mac? && Hardware::CPU.intel?
    bin.install "cc-session" if OS.linux? && Hardware::CPU.arm?
    bin.install "cc-session" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
