class Qvm < Formula
  desc "A C++/FFmpeg tool that generates high-quality Quran verse videos."
  homepage "https://github.com/ashaltu/quran-video-maker-ffmpeg"
  url "https://github.com/ashaltu/quran-video-maker-ffmpeg/releases/download/v0.1.0/qvm-v0.1.0.tar.gz"
  sha256 "0c39c6dcbd8f240453db6f59b43d1b60eea4841f7a51a8257c1dc94b656b1084"
  license "GPL-3.0"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "ffmpeg"
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "cpr"
  depends_on "nlohmann-json"
  depends_on "cxxopts"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
