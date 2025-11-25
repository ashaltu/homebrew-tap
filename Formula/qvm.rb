class Qvm < Formula
  desc "C++/FFmpeg tool that generates high-quality Quran verse videos"
  homepage "https://github.com/ashaltu/quran-video-maker-ffmpeg"
  url "https://github.com/ashaltu/quran-video-maker-ffmpeg/releases/download/v0.1.2/qvm-v0.1.2.tar.gz"
  sha256 "4090245f47aa9c3e8aa3dc7dccb3314fb3289ae3fc2146ca0f47960746e1077b"
  license "GPL-3.0"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "cpr"
  depends_on "cxxopts"
  depends_on "ffmpeg"
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "nlohmann-json"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
