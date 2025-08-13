class PrettyGit < Formula
  desc "Git repository analytics and reporting CLI"
  homepage "https://github.com/MikoMikocchi/pretty-git"
  url "https://rubygems.org/downloads/pretty-git-0.1.0.gem"
  sha256 "5caebad53d746b711a07b9a190d0a5cbc2910c60447a759effae5eb9a4cd6def"
  license "MIT"
  revision 2

  depends_on "ruby"

  def install
    rm_rf libexec

    vendor = libexec/"vendor"
    vendor.mkpath
    ENV["GEM_HOME"] = vendor
    ENV["GEM_PATH"] = ""

    system "gem", "install", cached_download, "--no-document",
           "--install-dir", vendor, "--ignore-dependencies"

    (bin/"pretty-git").write <<~SH
      #!/bin/bash
      export GEM_HOME="#{vendor}"
      exec "#{vendor}/bin/pretty-git" "$@"
    SH
    (bin/"pretty-git").chmod 0755
  end

  test do
    system "#{bin}/pretty-git", "--help"
  end
end