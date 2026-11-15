class Aisync < Formula
  include Language::Python::Virtualenv

  desc "Advanced context management for all your AI coding tools (shared rules, journal, claims)"
  homepage "https://maxont.github.io/aisync"
  url "https://github.com/MaxonT/aisync/releases/download/v0.2.7/aisync_cli-0.2.7.tar.gz"
  sha256 "8b5e9f9a9742e46e7787b189d46b1df4322762137b3ab5c4c7a6f322389f16e2"
  license "MIT"

  # No depends_on: brew would upgrade a pinned python@3.14. aisync is stdlib-only, so it runs in a
  # venv built from the python@3.14 that is already installed, without touching that formula.
  def install
    odie "python@3.14 must already be installed (it is pinned, so brew will not install it)" unless (Formula["python@3.14"].opt_bin/"python3.14").exist?
    virtualenv_install_with_resources using: "python@3.14"
  end

  test do
    assert_match "aisync 0.2.7", shell_output("#{bin}/aisync --version")
    assert_match "doctor", shell_output("#{bin}/aisync help")
  end
end
