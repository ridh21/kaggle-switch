class KaggleSwitch < Formula
  desc "Manage multiple Kaggle API accounts and switch between them"
  homepage "https://github.com/ridh21/kaggle-switch"
  url "https://github.com/ridh21/kaggle-switch/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "239939fde38a6416a1743daa685c28d9725a0ef17b11223d81752cf99dba64bd"
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
