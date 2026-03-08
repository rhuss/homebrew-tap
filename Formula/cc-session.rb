class CcSession < Formula
  desc "Fast CLI tool for finding and resuming Claude Code sessions"
  homepage "https://github.com/rhuss/cc-session"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rhuss/cc-session/releases/download/v0.7.1/cc-session-aarch64-apple-darwin.tar.xz"
      sha256 "b8ffb1f3c10d2608552fc87a42b102829e7879e79feffb615e23b96318f78749"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rhuss/cc-session/releases/download/v0.7.1/cc-session-x86_64-apple-darwin.tar.xz"
      sha256 "3864d0743835872093596197d732d1f4cbe174db4637c122fc1c81ff3e2d11f0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rhuss/cc-session/releases/download/v0.7.1/cc-session-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "64d308cd5dbd43f827c3590b2a4864a6a46c490a9d8cc5ad2d01e9cd54b9c7fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rhuss/cc-session/releases/download/v0.7.1/cc-session-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1837848fc9d9a72ee064678668d29be5ffeb7dc3309a76b95db54cc67f2a529d"
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
