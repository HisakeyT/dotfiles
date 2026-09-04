return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          -- miseが入っている環境ではmise管理のRubyのみを使う（下のcmdを
          -- 参照）ため、mason-lspconfigによる自動インストール/更新は
          -- 無効化する。Masonに任せると、その時PATH上にあるruby/gem
          -- （例: macOS標準の古いシステムRuby）でgem installが実行されて
          -- しまい失敗する上、今回の調査の原因になったような「バージョンが
          -- 古いまま固まったバイナリ」を再び生み出すリスクがある。
          -- miseが入っていない他PC等では、Mason管理のruby-lspにフォール
          -- バックできるよう自動インストールを許可する。
          mason = vim.fn.executable("mise") == 0,
          cmd = function(dispatchers, config)
            local dir = config and config.root_dir or vim.fn.getcwd()

            -- miseが無い環境（別PC、miseを使わない構成など）では、PATH上の
            -- ruby-lsp（Mason管理やrbenv/システムRubyのgemなど）をそのまま
            -- 使う。root_dirが取れない単体のRubyファイルでも同様。
            if vim.fn.executable("mise") == 0 then
              return vim.lsp.rpc.start({ "ruby-lsp" }, dispatchers, { cwd = dir })
            end

            -- mason.nvimはvim.env.PATHの先頭に自身のbin/を追加するため、
            -- "ruby-lsp"という名前がMason版（インストール当時アクティブ
            -- だったRuby向けにビルドされており、そのRubyバージョンをmiseで
            -- 削除すると静かに壊れる）に解決されてしまうことがある。ここで
            -- 明示的に除外し、読み込み順に関係なく常にmise管理のRubyの
            -- ruby-lspに解決されるようにする。
            local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
            local filtered_paths = vim.tbl_filter(function(p)
              return p ~= mason_bin
            end, vim.split(vim.env.PATH or "", ":", { plain = true }))

            return vim.lsp.rpc.start({ "mise", "exec", "-C", dir, "--", "ruby-lsp" }, dispatchers, {
              cwd = dir,
              env = { PATH = table.concat(filtered_paths, ":") },
            })
          end,
        },
        -- LazyVimの lang.ruby extra はこれを単体のLSPサーバーとして
        -- 有効化するが、Masonのグローバルインストールで動くため
        -- プロジェクトのGemfile（rubocop-railsなど）を無視してしまう。
        -- 診断は代わりに ruby_lsp / 下の conform.nvim フォーマッタから得る。
        rubocop = {
          enabled = false,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        rubocop = {
          command = "mise",
          args = function(self, ctx)
            local has_gemfile = vim.fn.filereadable(ctx.dirname .. "/Gemfile") == 1
            if has_gemfile then
              return {
                "exec",
                "--",
                "bundle",
                "exec",
                "rubocop",
                "--server",
                "-a",
                "-f",
                "quiet",
                "--stderr",
                "--stdin",
                "$FILENAME",
              }
            else
              return { "exec", "--", "rubocop", "-a", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" }
            end
          end,
        },
      },
    },
  },
}
