# GitHub SSH Setup

GitHub 操作用に SSH 認証を利用する。
HTTPS より認証操作が少なく、`git clone` / `push` が快適になる。

利用方式は `ed25519` を使用する。

---

## 1. SSH key 作成

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

以下を聞かれる:

```text
Enter file in which to save the key
```

通常は Enter を押してデフォルトを利用:

```text
~/.ssh/id_ed25519
```

次にパスフレーズ入力:

```text
Enter passphrase
```

必要に応じて設定する。

生成されるファイル:

```text
~/.ssh/id_ed25519
~/.ssh/id_ed25519.pub
```

---

## 2. ssh-agent 起動

```bash
eval "$(ssh-agent -s)"
```

---

## 3. SSH key 登録

```bash
ssh-add ~/.ssh/id_ed25519
```

---

## 4. 公開鍵をクリップボードへコピー

macOS:

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

---

## 5. GitHub に公開鍵登録

GitHub の以下画面へ移動:

* Settings
* SSH and GPG keys
* New SSH key

コピーした公開鍵を貼り付ける。

---

## 6. 接続確認

```bash
ssh -T git@github.com
```

成功例:

```text
Hi HisakeyT! You've successfully authenticated...
```

---

## 7. dotfiles clone

```bash
git clone git@github.com:HisakeyT/dotfiles.git ~/dotfiles
```

---

## 8. Remote URL 確認

```bash
git remote -v
```

SSH になっていることを確認:

```text
git@github.com:HisakeyT/dotfiles.git
```

HTTPS の場合は変更:

```bash
git remote set-url origin git@github.com:HisakeyT/dotfiles.git
```

---

## Notes

### Why ed25519?

* 高速
* 鍵が短い
* 現代的な標準方式
* GitHub 推奨

古い環境のみ RSA fallback を利用する。

---

## Troubleshooting

### Permission denied (publickey)

SSH key が登録されていない可能性がある。

確認:

```bash
ssh-add -l
```

未登録の場合:

```bash
ssh-add ~/.ssh/id_ed25519
```

---

### 接続確認

```bash
ssh -T git@github.com
```


### config追加(optional)

```bash
Host github github.com
  HostName github.com
  IdentityFile ~/.ssh/id_ed25519 #ここに自分の鍵のファイル名
  User git
```

