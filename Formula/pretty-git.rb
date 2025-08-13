class PrettyGit < Formula
  desc "Git repository analytics and reporting CLI"
  homepage "https://github.com/MikoMikocchi/pretty-git"
  url "https://rubygems.org/downloads/pretty-git-0.1.0.gem"
  sha256 "5caebad53d746b711a07b9a190d0a5cbc2910c60447a759effae5eb9a4cd6def"
  license "MIT"
  revision 1

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = buildpath/"gemhome"
    ENV["GEM_PATH"] = ""
    system "gem", "install", cached_download, "--no-document",
           "--install-dir", ENV["GEM_HOME"], "--ignore-dependencies"

    rm_rf libexec
    libexec.install Dir[buildpath/"gemhome/*"]

    bin.install_symlink Dir[libexec/"bin/*"]
    bin.env_script_all_files libexec/"bin", GEM_HOME: libexec
  end

  test do
    system "#{bin}/pretty-git", "--help"
  end
end