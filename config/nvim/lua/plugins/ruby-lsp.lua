return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          cmd = function(dispatchers, config)
            local dir = config and config.root_dir or vim.fn.getcwd()
            return vim.lsp.rpc.start(
              { "mise", "exec", "-C", dir, "--", "ruby-lsp" },
              dispatchers
            )
          end,
        },
        rubocop = {
          cmd = function(dispatchers, config)
            local dir = config and config.root_dir or vim.fn.getcwd()
            return vim.lsp.rpc.start(
              { "mise", "exec", "-C", dir, "--", "bundle", "exec", "rubocop", "--lsp" },
              dispatchers
            )
          end,
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
          args = { "exec", "--", "bundle", "exec", "rubocop", "--server", "-a", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" },
        },
      },
    },
  },
}
