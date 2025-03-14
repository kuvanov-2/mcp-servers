# MCP Servers for JIRA and GitHub

VSCode用のJIRAおよびGitHub MCPサーバーです。1Password CLIを使用してシークレットを管理します。



## 前提条件

1. 1Password CLIのインストール
```bash
brew install --cask 1password-cli
```

2. 1Password CLIの認証
```bash
op signin
```

## インストール手順

1. リポジトリをクローン
```bash
git clone https://github.com/[your-org]/mcp-servers.git ~/Documents/Cline/MCP
cd ~/Documents/Cline/MCP
```

2. Python仮想環境のセットアップ（JIRAサーバー用）
```bash
cd mcp-atlassian
python -m venv venv
source venv/bin/activate
pip install -e .
```

3. 実行権限の付与
```bash
chmod +x mcp-atlassian/start-server.sh github-server/start-server.sh
```

4. VSCode設定ファイルの更新
- 設定ファイルの場所:
  - VSCode: `~/Library/Application Support/Code/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json`
  - VSCode Insiders: `~/Library/Application Support/Code - Insiders/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json`
- `cline_mcp_settings.json.example` を参考に編集

## 1Password Vaultの設定

### Vault設定例

1. **JIRA API Token**
   - Item名: `JIRA API Token`
   - 必要なフィールド:
     - `user`: JIRAのユーザー名（メールアドレス）
     - `access token`: JIRAのAPIトークン

2. **GitHub Personal Access Token**
   - Item名: `GitHub PAT for MCP Server`
   - 必要なフィールド:
     - `access token`: GitHubのPersonal Access Token

### 設定ファイルでの参照
```json
{
  "JIRA_USERNAME": "op://vault-name/JIRA API Token/info/user",
  "JIRA_API_TOKEN": "op://vault-name/JIRA API Token/info/access token",
  "GITHUB_PERSONAL_ACCESS_TOKEN": "op://vault-name/GitHub PAT for MCP Server/info/access token"
}
```
※ `vault-name`は各自の1Password Vaultの名前に置き換えてください。

## トラブルシューティング

### 1Password CLIでシークレットが取得できない場合
- `op signin` で1Password CLIにサインインできているか確認
- Vaultの名前が正しいか確認
- 各アイテムのフィールド名が正しいか確認

### パスの問題が発生する場合
- `cline_mcp_settings.json`のパスが環境に合っているか確認
- ラッパースクリプト内の相対パスが正しいか確認

## サポートされている機能

### JIRAサーバー
- `jira_get_issue`: 指定されたキーのissueを取得
- `jira_search`: JQLによるissue検索

### GitHubサーバー
- `get_file_contents`: リポジトリのファイル内容を取得
- `get_issue`: Issue情報を取得

## 貢献

1. Fork it
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create new Pull Request
