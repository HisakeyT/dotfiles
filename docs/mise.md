
# mise の使い方

## mise とは

`mise` は、開発ツールや言語ランタイムのバージョン管理ツールです。

例えば以下を管理できます。

* Ruby
* Node.js
* Python
* Terraform
* AWS CLI

プロジェクトごとに使用バージョンを固定できるため、
チーム全員で同じ開発環境を再現しやすくなります。

---

# インストール

## macOS

```bash id="n2r6qm"
brew install mise
```

---

# シェル設定

## zsh

`~/.zshrc` に追加します。

```bash id="w6i0yv"
eval "$(mise activate zsh)"
```

反映します。

```bash id="8i2xnh"
source ~/.zshrc
```

---

# 動作確認

```bash id="1vxsm6"
mise --version
```

---

# 基本的な使い方

## ツールインストール

### Ruby

```bash id="g5wq13"
mise install ruby@3.3
```

### Node.js

```bash id="u9n0bw"
mise install node@22
```

---

# グローバル設定

PC 全体で使うバージョンを設定します。

```bash id="5ix1q0"
mise use -g ruby@3.3
```

---

# ローカル設定（重要）

プロジェクト単位でバージョンを固定します。

```bash id="m3m7jo"
mise use ruby@3.3
```

実行すると `.mise.toml` が生成されます。

---

# `.mise.toml`

例:

```toml id="sxkk0x"
[tools]
ruby = "3.3"
node = "22"
```

このファイルを Git 管理することで、
チーム全体で同じバージョンを利用できます。

---

# 現在のバージョン確認

```bash id="rjlwm4"
mise current
```

---

# 既存プロダクトでの使い方

既存プロダクトでは、
まず「現在使っているバージョン」を `mise` に移行します。

---

# パターン1: `.ruby-version` が存在する場合

例:

```txt id="0o9m3v"
.ruby-version
```

中身:

```txt id="cv87p8"
3.3.0
```

この場合、以下設定を有効化すると `mise` が自動で読み取ります。

`~/.config/mise/config.toml`

```toml id="33o3rw"
[settings]
idiomatic_version_file_enable_tools = ["ruby", "node", "python"]
```

これだけで既存プロジェクトをそのまま利用できます。

---

# パターン2: `.mise.toml` へ移行する

既存プロジェクトで:

```bash id="6v1uvj"
mise use ruby@3.3
mise use node@22
```

すると:

```toml id="k9l1l8"
[tools]
ruby = "3.3"
node = "22"
```

が生成されます。

これをコミットします。

---

# 既存プロダクトでの実際の流れ

## 初回

リポジトリ clone 後:

```bash id="tb74zw"
mise install
```

これだけで必要ツールがインストールされます。

---

# 開発開始

プロジェクトディレクトリへ移動すると、
`mise` が自動でバージョンを切り替えます。

例:

```bash id="6m2g8i"
cd myapp
ruby -v
node -v
```

---

# バージョン更新

例えば Ruby を更新したい場合:

```bash id="9iwvmd"
mise use ruby@3.4
```

`.mise.toml` が更新されます。

変更をコミットします。

---

# 推奨運用

## 個人設定

`~/.config/mise/config.toml`

* `mise` 自体の設定
* version file 読み込み設定

## プロジェクト設定

`.mise.toml`

* プロジェクトごとのツールバージョン
* Git 管理対象

---

# dotfiles 管理

推奨:

```txt id="ozmxwz"
~/dotfiles/
└── mise/
    └── config.toml
```

シンボリックリンク:

```bash id="d81r1k"
ln -sfn ~/dotfiles/mise/config.toml \
  ~/.config/mise/config.toml
```

---

# よく使うコマンド

## インストール

```bash id="mj05vc"
mise install
```

## 現在のバージョン確認

```bash id="5j98vb"
mise current
```

## 利用可能バージョン確認

```bash id="63j8c7"
mise ls-remote ruby
```

## キャッシュ削除

```bash id="x4x8lm"
mise cache clear
```

---

# まとめ

* `mise` は開発環境のバージョン管理ツール
* `.mise.toml` を Git 管理する
* `mise install` で環境再現できる
* 既存 `.ruby-version` も利用可能
* dotfiles で `config.toml` を管理すると便利
