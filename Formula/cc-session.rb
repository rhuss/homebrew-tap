class CcSession < Formula
  desc "Fast CLI tool for finding and resuming Claude Code sessions"
  homepage "https://github.com/rhuss/cc-session"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rhuss/cc-session/releases/download/v0.5.0/cc-session-aarch64-apple-darwin.tar.xz"
      sha256 "027c69c40b0f93f6c1823f53b1596d47f31a4f63ea44a199a901641f66a1d224"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rhuss/cc-session/releases/download/v0.5.0/cc-session-x86_64-apple-darwin.tar.xz"
      sha256 "dd0298e057872d47f8920f75be569c6f4a8e6649f9c2dff6949a0fc8d8a2a6aa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rhuss/cc-session/releases/download/v0.5.0/cc-session-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "17d5fbbe3586cec50ef7b199b79f01345f43e8b7b2a5810157b399597e376096"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rhuss/cc-session/releases/download/v0.5.0/cc-session-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "721b085ab60ed7ec56a6e108218a72d72faf223659f8e6e6a41261bdba0eecb9"
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
