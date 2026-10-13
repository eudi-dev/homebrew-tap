# typed: strict
# frozen_string_literal: true

# Homebrew formula for eudi-dev, published to the eudi-dev/homebrew-tap
# repository by the release workflow. 3.0.2 (without the leading v) and
# 2d5488ae2187dc8d7d5dbe910d71d5df80a6fe46e5a18f22bcff49f630d24677 are filled in per release.
class EudiDev < Formula
  desc "Developer toolkit for the EUDI and OpenID4VC ecosystem"
  homepage "https://github.com/eudi-dev/eudi-dev"
  url "https://github.com/eudi-dev/eudi-dev/archive/refs/tags/v3.0.2.tar.gz"
  sha256 "2d5488ae2187dc8d7d5dbe910d71d5df80a6fe46e5a18f22bcff49f630d24677"
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
