class KaggleSwitch < Formula
  desc "Manage multiple Kaggle API accounts and switch between them"
  homepage "https://github.com/ridh21/kaggle-switch"
  url "https://github.com/ridh21/kaggle-switch/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_WITH_RELEASE_SHA256"
  license "MIT"
  head "https://github.com/ridh21/kaggle-switch.git", branch: "main"

  def install
    bin.install "bin/kgs"
  end

  def caveats
    <<~EOS
      To let `kgs use <name>` switch your current shell, add this to ~/.zshrc:
        eval "$(kgs shell-init)"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kgs --version")
  end
end
