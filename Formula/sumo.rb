class Sumo < Formula
  desc "Your Mac's processes and apps, wrestling in a sumo arena"
  homepage "https://github.com/vikey89/Sumo"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/vikey89/Sumo/releases/download/v0.1.0/sumo-0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "d048b62aaa805deceb1b3c826659e602222590877fb910be00dae17d72b9b2d0"
  end
  on_intel do
    url "https://github.com/vikey89/Sumo/releases/download/v0.1.0/sumo-0.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "20731bf2a6e4145b0098c56cf8c1bf27807f008658443f424ee5b226f82912e2"
  end

  def install
    bin.install "sumo"
  end

  service do
    run [opt_bin/"sumo", "serve", "--no-open"]
    keep_alive true
    log_path var/"log/sumo.log"
    error_log_path var/"log/sumo.log"
  end

  def caveats
    <<~EOS
      Open the arena in your browser (the engine stops by itself when you close the tab):
        sumo
      Or keep it always on, even at login:
        brew services start sumo
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sumo --version")
  end
end
