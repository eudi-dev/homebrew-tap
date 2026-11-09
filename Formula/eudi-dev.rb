# typed: strict
# frozen_string_literal: true

# Homebrew formula for eudi-dev, published to the eudi-dev/homebrew-tap
# repository by the release workflow. 3.9.0 (without the leading v) and
# 02a59ec9f465cdae2c7c2c92338108603af958cafe5852c22e24be8aa4736df8 are filled in per release.
class EudiDev < Formula
  desc "Test Wallet and Developer toolkit for the EUDI ecosystem"
  homepage "https://github.com/eudi-dev/eudi-dev"
  url "https://github.com/eudi-dev/eudi-dev/archive/refs/tags/v3.9.0.tar.gz"
  sha256 "02a59ec9f465cdae2c7c2c92338108603af958cafe5852c22e24be8aa4736df8"
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
