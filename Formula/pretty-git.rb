class PrettyGit < Formula
  desc "Git repository analytics and reporting CLI"
  homepage "https://github.com/MikoMikocchi/pretty-git"
  url "https://rubygems.org/downloads/pretty-git-0.1.0.gem"
  sha256 "b4f66c251f6384c686f0ee074376a1a1bf74a219fab33d82bc7fbee6a4d7c707"
  license "MIT"

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