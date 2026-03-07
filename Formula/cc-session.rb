class CcSession < Formula
  desc "Fast CLI tool for finding and resuming Claude Code sessions"
  homepage "https://github.com/rhuss/cc-session"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rhuss/cc-session/releases/download/v0.4.0/cc-session-aarch64-apple-darwin.tar.xz"
      sha256 "cbb492e42044a02ca8d43b78d8e57c078f626270d4ded89d064489049c67e135"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rhuss/cc-session/releases/download/v0.4.0/cc-session-x86_64-apple-darwin.tar.xz"
      sha256 "65077ac1240316d2ed8446c2c4947faf7a89ed8e440ec41298c5d6456550ada9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rhuss/cc-session/releases/download/v0.4.0/cc-session-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "02d7b9b8356529ec342555dbf7bac684c9ff954db219a8c19e4149f94cc35b8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rhuss/cc-session/releases/download/v0.4.0/cc-session-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5c7d33bd49066fbff18cb551d832a1cae879a6f503108e7841967d56768194e7"
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
