class QvmAT012 < Formula
  desc "C++/FFmpeg tool that generates high-quality Quran verse videos"
  homepage "https://github.com/ashaltu/quran-video-maker-ffmpeg"
  url "https://github.com/ashaltu/quran-video-maker-ffmpeg/releases/download/v0.1.2/qvm-v0.1.2.tar.gz"
  sha256 "e804057a3d00fd50661f1d23836ea3e87a8bf0d4f6059d6f2b0e83732062a072"
  license "GPL-3.0"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "cpr"
  depends_on "cxxopts"
  depends_on "ffmpeg"
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "nlohmann-json"

  resource "data" do
    url "https://qvm-r2-storage.tawbah.app/data.tar"
    sha256 "f75ba5c184a0e88574c137773c1a19e66ecffd3295cfc7a3ed9dd179cefd74ff"
  end

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # Stage data into the shared path for runtime access
    resource("data").stage do
      (share/"quran-video-maker/data").install Dir["*"]
    end
  end
end
