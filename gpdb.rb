# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Gpdb < Formula
  desc "Greenplum Database"
  homepage "http://greenplum.org"
  url "https://github.com/greenplum-db/gpdb/archive/5.0.0-beta.2.tar.gz"
  sha256 "d43e62cf99cd1d2ee9b1e00ad80e4e491defe1cb7cfeecf142ecd60f88bffa29"

  depends_on "cmake" => :build # orca build
  depends_on "ninja" => :build # orca build
  depends_on "libyaml" => :build # --enable-mapreduce
  depends_on "libevent" => :build # gpfdist
  depends_on "apr" => :build # gpperfmon
  depends_on "apr-util" => :build #gppermon
  #depends_on "go" => :build
  depends_on "python" => :run
  depends_on "gdb" => :optional

  def install
    # additional pip dependencies to run
    system "pip", "install", "lockfile",
                             "psi",
                             "paramiko",
                             "pysql",
                             "psutil",
                             "setuptools",
                             "unittest2",
                             "parse",
                             "pexpect",
                             "mock",
                             "pyyaml",
                             "git+https://github.com/behave/behave@v1.2.4",
                             "pylint"

    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-orca",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
    system "mkdir", "#{prefix}/demo"
    system "cp", "gpAux/gpdemo/demo_cluster.sh", "#{prefix}/demo"
    system "cp", "gpAux/gpdemo/lalshell", "#{prefix}/demo"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test gpdb`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
