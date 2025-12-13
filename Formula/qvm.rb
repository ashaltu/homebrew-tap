class Qvm < Formula
  desc "C++/FFmpeg tool that generates high-quality Quran verse videos"
  homepage "https://github.com/ashaltu/quran-video-maker-ffmpeg"
  url "https://github.com/ashaltu/quran-video-maker-ffmpeg/releases/download/v0.2.0/qvm-v0.2.0.tar.gz"
  sha256 "0dc5b1b2a3e340e777c107e032f19c03cc808dcfc8137ddba0d1a9c63625289a"
  license "GPL-3.0"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "cpr"
  depends_on "curl"
  depends_on "cxxopts"
  depends_on "ffmpeg"
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "nlohmann-json"
  depends_on "openssl"

  resource "data" do
    url "https://qvm-r2-storage.tawbah.app/data.tar"
    sha256 "f75ba5c184a0e88574c137773c1a19e66ecffd3295cfc7a3ed9dd179cefd74ff"
  end

  resource "aws-sdk-cpp" do
    url "https://github.com/aws/aws-sdk-cpp/archive/refs/tags/1.11.710.tar.gz"
    sha256 "29d1c0a4c848289d89d392e40429ddffc497ffb6d3b6902e7a6c5c64ead99f9f"
  end

  def install
    # Build AWS SDK first with only S3
    resource("aws-sdk-cpp").stage do
      system "cmake", "-S", ".", "-B", "build",
                      "-DBUILD_ONLY=s3",
                      "-DENABLE_TESTING=OFF",
                      "-DAUTORUN_UNIT_TESTS=OFF",
                      "-DBUILD_SHARED_LIBS=ON",
                      "-DCMAKE_INSTALL_PREFIX=#{buildpath}/aws-sdk",
                      *std_cmake_args
      system "cmake", "--build", "build"
      system "cmake", "--install", "build"
    end

    # Now build qvm with the AWS SDK we just built
    ENV.prepend_path "PKG_CONFIG_PATH", "#{buildpath}/aws-sdk/lib/pkgconfig"

    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_PREFIX_PATH=#{buildpath}/aws-sdk",
                    "-DAWSSDK_ROOT_DIR=#{buildpath}/aws-sdk",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # Stage data into the shared path for runtime access
    resource("data").stage do
      (share/"quran-video-maker/data").install Dir["*"]
    end
  end
end
