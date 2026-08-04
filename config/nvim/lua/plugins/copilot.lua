return {
  "zbirenbaum/copilot.lua",
  init = function()
    -- リポジトリ側で node バージョンが固定されていても copilot は mise の latest node を使う
    vim.env.MISE_NODE_VERSION = "latest"
  end,
  opts = {
    copilot_node_command = vim.fn.expand("~/.local/share/mise/shims/node"),
  },
}
