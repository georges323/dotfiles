return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gdm", "<cmd>DiffviewOpen main...HEAD<cr>", desc = "Diff vs main (merge-base)" },
      { "<leader>gdM", "<cmd>DiffviewOpen origin/main...HEAD<cr>", desc = "Diff vs origin/main" },
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diff working tree" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Diff close" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "Branch file history" },
      { "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history" },
    },
  },
}
