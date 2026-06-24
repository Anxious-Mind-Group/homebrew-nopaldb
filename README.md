# homebrew-nopaldb

Homebrew tap for [NopalDB](https://github.com/sharop/nopaldb) — a high-performance embedded graph database with ACID transactions, MVCC time-travel, and Apache Arrow analytics.

## Installation

```bash
brew tap sharop/nopaldb
brew install nopaldb
```

This installs two binaries:

| Binary | Description |
|--------|-------------|
| `ndbstudio` | Interactive TUI explorer & web workbench for NopalDB |
| `nopaldb-mcp` | MCP server — exposes graph queries as tools for Claude Desktop and AI agents |

## Usage

### NDStudio (TUI)

```bash
ndbstudio /path/to/your/graph.db
```

### NDStudio Web Workbench

```bash
ndbstudio --web /path/to/your/graph.db
# Opens at http://127.0.0.1:3737
```

### NopalDB MCP Server

Add to your Claude Desktop configuration (`~/.config/claude/claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "nopaldb": {
      "command": "nopaldb-mcp",
      "args": ["--db", "/path/to/graph.db", "--readonly"]
    }
  }
}
```

## Building from Source

The formula compiles both binaries from source using the Rust toolchain. Build time is typically 3–5 minutes depending on your machine.

## Updating

```bash
brew update
brew upgrade nopaldb
```

## License

NopalDB is licensed under [AGPL-3.0](https://github.com/sharop/nopaldb/blob/main/LICENSE).
