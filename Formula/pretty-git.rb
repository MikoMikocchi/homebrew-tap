class PrettyGit < Formula
    desc "Git repository analytics and reporting CLI"
    homepage "https://github.com/MikoMikocchi/pretty-git"
    license "MIT"
  
    depends_on "ruby"
  
    def install
      ENV["GEM_HOME"] = libexec
      system "gem", "install", "pretty-git", "--version", "0.1.0", "--no-document", "--install-dir", libexec
      bin.install_symlink Dir[libexec/"bin/*"]
      bin.env_script_all_files libexec/"bin", GEM_HOME: libexec
    end
  
    test do
      system "#{bin}/pretty-git", "--help"
    end
  end