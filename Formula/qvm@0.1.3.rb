class QvmAT013 < Formula
  desc "C++/FFmpeg tool that generates high-quality Quran verse videos"
  homepage "https://github.com/ashaltu/quran-video-maker-ffmpeg"
  url "https://github.com/ashaltu/quran-video-maker-ffmpeg/releases/download/v0.1.3/qvm-v0.1.3.tar.gz"
  sha256 "dcb9fb9e6016cec1c8925fc58c08331f437e023b8beadb109ebbcbcd385e28ad"
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
