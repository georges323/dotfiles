-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = LazyVim.root.git() })
end, { desc = "Lazygit (Root Dir)" })

vim.keymap.set("n", "<leader>gG", function()
  Snacks.lazygit()
end, { desc = "Lazygit (cwd)" })

vim.keymap.set({ "n", "t" }, "<leader>wr", function()
  local b = vim.api.nvim_get_current_buf()
  vim.cmd("tabclose")
  vim.cmd("vert botright sb " .. b)
end, { desc = "Window back to right split" })
