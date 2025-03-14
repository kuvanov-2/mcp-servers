#!/bin/bash

# カレントディレクトリをスクリプトの場所に変更
cd "$(dirname "$0")"

# 環境変数を1Password CLIで解決
for var in $(env | cut -d= -f1); do
  value=$(eval echo \$$var)
  if [[ $value == op://* ]]; then
    resolved_value=$(op read "$value")
    if [ $? -eq 0 ]; then
      export $var="$resolved_value"
    else
      echo "Error: Failed to read secret for $var from 1Password" >&2
      exit 1
    fi
  fi
done

# 本来のサーバー起動コマンド（相対パスで実行）
exec "./venv/bin/python" -m mcp_atlassian.server
