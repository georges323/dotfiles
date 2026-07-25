return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      picker = "telescope",
    },
    keys = {
      { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List Issues (Octo)" },
      { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "List PRs (Octo)" },
      { "<leader>gP", "<cmd>Octo pr search<cr>", desc = "Search PRs (Octo)" },
      { "<leader>gr", "<cmd>Octo repo list<cr>", desc = "List Repos (Octo)" },
      { "<leader>gs", "<cmd>Octo search<cr>", desc = "Search (Octo)" },
    },
  },
}
