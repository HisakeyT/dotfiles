return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          cmd = function(dispatchers, config)
            local dir = config and config.root_dir or vim.fn.getcwd()
            return vim.lsp.rpc.start({ "mise", "exec", "-C", dir, "--", "ruby-lsp" }, dispatchers)
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
