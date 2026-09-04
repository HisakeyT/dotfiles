return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- mise shims を PATH に載せておく（GUI 起動時など shell の mise activate を経由しない場合の対策)
      vim.env.PATH = vim.fn.expand("~/.local/share/mise/shims") .. ":" .. vim.env.PATH
      -- リポジトリ側の .go-version が未インストールでも解決できるように固定
      vim.env.MISE_GO_VERSION = "latest"
    end,
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              staticcheck = false,
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "gofmt" },
      },
    },
  },
}
