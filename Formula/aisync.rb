class Aisync < Formula
  include Language::Python::Virtualenv

  desc "Multi-Agent Context Management, Coordination & Observability for AI coding tools"
  homepage "https://maxont.github.io/aisync"
  url "https://github.com/MaxonT/aisync/releases/download/v0.2.10/aisync_cli-0.2.10.tar.gz"
  sha256 "e9a7aebd173873bd050665e67ec2cf3b59c23ae247e6bc71e0e6edaa1cf3a49f"
  license "MIT"

  # No depends_on: brew would upgrade a pinned python@3.14. aisync is stdlib-only, so it runs in a
  # venv built from the python@3.14 that is already installed, without touching that formula.
  def install
    odie "python@3.14 must already be installed (it is pinned, so brew will not install it)" unless (Formula["python@3.14"].opt_bin/"python3.14").exist?
    # Use the python@3.14 binary by its full path: without a depends_on it is not on PATH.
    python = Formula["python@3.14"].opt_bin/"python3.14"
    venv = virtualenv_create(libexec, python)
    venv.pip_install_and_link buildpath
  end

  test do
    assert_match "aisync 0.2.10", shell_output("#{bin}/aisync --version")
    assert_match "doctor", shell_output("#{bin}/aisync help")
  end
end
