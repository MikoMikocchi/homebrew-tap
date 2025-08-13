class PrettyGit < Formula
  desc "Git repository analytics and reporting CLI"
  homepage "https://github.com/MikoMikocchi/pretty-git"
  url "https://rubygems.org/downloads/pretty-git-0.1.1.gem"
  sha256 "a3bcfc2898e6f1fdc5ed189a8dd7604a614957aadc90fae13f1069f3ca9befd2"
  license "MIT"

  livecheck do
    url "https://rubygems.org/gems/pretty-git"
    strategy :rubygems
  end

  depends_on "ruby"

  resource "csv" do
    url "https://rubygems.org/downloads/csv-3.3.5.gem"
    sha256 "6e5134ac3383ef728b7f02725d9872934f523cb40b961479f69cf3afa6c8e73f"
  end

  resource "rexml" do
    url "https://rubygems.org/downloads/rexml-3.4.1.gem"
    sha256 "c74527a9a0a04b4ec31dbe0dc4ed6004b960af943d8db42e539edde3a871abca"
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
