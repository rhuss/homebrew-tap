class CcSession < Formula
  desc "Fast CLI tool for finding and resuming Claude Code sessions"
  homepage "https://github.com/rhuss/cc-session"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rhuss/cc-session/releases/download/v0.5.1/cc-session-aarch64-apple-darwin.tar.xz"
      sha256 "43e82c8b560039ef83a53a90b5ec896d969de7ac6c0c598519b570b1558f0c7e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rhuss/cc-session/releases/download/v0.5.1/cc-session-x86_64-apple-darwin.tar.xz"
      sha256 "a4fd5a86b337207de673b4d105cdef6078cf76e378881e06e186ecab662e2e5b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rhuss/cc-session/releases/download/v0.5.1/cc-session-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fee80162a031eefb3d285789614f88f7a433665664751e4b4797989c993b7962"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rhuss/cc-session/releases/download/v0.5.1/cc-session-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "08a0e87ae311e2632cdfacedfaf2626f4722cb44b54a30a1a86a82cd124498cf"
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
