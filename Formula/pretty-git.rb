class PrettyGit < Formula
  desc "Git repository analytics and reporting CLI"
  homepage "https://github.com/MikoMikocchi/pretty-git"
  url "https://rubygems.org/downloads/pretty-git-0.1.2.gem"
  sha256 ""
  license "MIT"
  revision 1

  livecheck do
  url "https://rubygems.org/downloads/pretty-git-0.1.2.gem"
    strategy :rubygems
  end

  depends_on "ruby"

  resource "csv" do
  url "https://rubygems.org/downloads/pretty-git-0.1.2.gem"
  sha256 ""
  end

  resource "rexml" do
  url "https://rubygems.org/downloads/pretty-git-0.1.2.gem"
  sha256 ""
  end

  def install
    rm_r libexec if libexec.exist?

    vendor = libexec/"vendor"
    vendor.mkpath
    ENV["GEM_HOME"] = vendor
    ENV["GEM_PATH"] = ""

    resources.each do |r|
      r.fetch
      system "gem", "install", r.cached_download, "--no-document",
             "--install-dir", vendor
    end

    system "gem", "install", cached_download, "--no-document",
           "--install-dir", vendor

    (bin/"pretty-git").write <<~SH
      #!/bin/bash
      export GEM_HOME="#{vendor}"
      exec "#{vendor}/bin/pretty-git" "$@"
    SH
    (bin/"pretty-git").chmod 0755
  end

  test do
    # Basic invocation should work
    system bin/"pretty-git", "--help"

    # Prefer version check when available
    exe = bin/"pretty-git"
    output = shell_output("#{exe} --version")
    assert_match version.to_s, output
  end
end
