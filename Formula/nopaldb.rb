class Nopaldb < Formula
  desc "High-performance graph database with TUI explorer and MCP server"
  homepage "https://github.com/sharop/nopaldb"
  url "https://github.com/sharop/nopaldb/archive/refs/tags/v0.4.27.tar.gz"
  sha256 "245f2f8e4b6a6a98b446bc2c460766a8841c6044e22b26817fe93106c1ad95da"
  license "AGPL-3.0-only"
  head "https://github.com/sharop/nopaldb.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--locked", "--features", "nopaldb/core",
           "-p", "ndbstudio", "-p", "nopaldb-mcp"

    bin.install "target/release/ndbstudio"
    bin.install "target/release/nopaldb-mcp"
  end

  def caveats
    <<~EOS
      NDStudio (TUI explorer):
        ndbstudio /path/to/your/graph.db

      NDStudio Web workbench:
        ndbstudio --web /path/to/your/graph.db

      NopalDB MCP server (for Claude Desktop):
        Add to your Claude Desktop config:
        {
          "mcpServers": {
            "nopaldb": {
              "command": "#{opt_bin}/nopaldb-mcp",
              "args": ["--db", "/path/to/graph.db", "--readonly"]
            }
          }
        }
    EOS
  end

  test do
    # Verify nopaldb-mcp binary exists and reports its version
    assert_match version.to_s, shell_output("#{bin}/nopaldb-mcp --version")

    # Verify ndbstudio binary exists and prints usage
    output = shell_output("#{bin}/ndbstudio --help 2>&1")
    assert_match "NDStudio", output
  end
end
