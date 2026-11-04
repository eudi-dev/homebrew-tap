# typed: strict
# frozen_string_literal: true

# Homebrew formula for eudi-dev, published to the eudi-dev/homebrew-tap
# repository by the release workflow. 3.7.3 (without the leading v) and
# 3357a97f76c5bf56abcb279151963033304ccd37132428d6a35568d8f6af0652 are filled in per release.
class EudiDev < Formula
  desc "Test Wallet and Developer toolkit for the EUDI ecosystem"
  homepage "https://github.com/eudi-dev/eudi-dev"
  url "https://github.com/eudi-dev/eudi-dev/archive/refs/tags/v3.7.3.tar.gz"
  sha256 "3357a97f76c5bf56abcb279151963033304ccd37132428d6a35568d8f6af0652"
  license "Apache-2.0"
  head "https://github.com/eudi-dev/eudi-dev.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/eudi-dev/eudi-dev/v3/cmd.Version=v#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"eudi")
    generate_completions_from_executable(bin/"eudi", "completion")
  end

  test do
    assert_match "eudi", shell_output("#{bin}/eudi version")
    assert_match "german-pid-sdjwt", shell_output("#{bin}/eudi templates list --wallet-dir #{testpath}")
  end
end
