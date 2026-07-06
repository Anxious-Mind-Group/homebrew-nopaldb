class Nopaldb < Formula
  desc "High-performance graph database with TUI explorer and MCP server"
  homepage "https://github.com/sharop/nopaldb"
  url "https://github.com/sharop/nopaldb/archive/refs/tags/v0.4.30.tar.gz"
  sha256 "e86d573a98e86d9a2ec46f56a5d7ad6df4386d139cc98464fb66a5b9be6d7c78"
  license "AGPL-3.0-only"
  head "https://github.com/sharop/nopaldb.git", branch: "main"

  depends_on "rust" => :build

  def install
    %w[ndbstudio nopaldb-mcp].each do |crate|
      cd crate do
        system "cargo", "install", *std_cargo_args
      end
    end
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
