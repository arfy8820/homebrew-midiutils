class Pmml < Formula
  desc "This is  the PMML(Practical Music Macro Language) compiler. The PMML compiler generates a MIDI file from MML(Music Macro Language) source code."
  homepage "https://github.com/arfy8820/pmml"
  url "https://github.com/arfy8820/pmml/archive/refs/tags/v0.3.tar.gz"
  sha256 "72c6a80b153e04eeb1203a09cb425f7ea7d287854858f7f6664c656b980d57f0"
  license "GPL-2.0"

    depends_on "texinfo" => :build

	def install
    system "make", "BINDIR=#{bin}", "LIBDIR=#{lib}"
	# temporarily rename INSTALL to INSTALL.eng so that make install runs.
	mv "INSTALL", "INSTALL.eng"
	system "make", "BINDIR=#{bin}", "LIBDIR=#{lib}", "install"
	mv "INSTALL.eng", "INSTALL"
	cd "manual/eng"
	system "#{HOMEBREW_PREFIX}/opt/texinfo/bin/texi2any", "-o", "pmml.info", "--no-split", "pmml.texi"
	info.install "pmml.info"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test pmml`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/pmml", "-e", "c d e f g a b ^c", "-o", "c_scale.mid"
  end
end
