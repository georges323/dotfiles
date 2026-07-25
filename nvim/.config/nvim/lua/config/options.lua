-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Left-align LSP CodeLens.
-- Core renders CodeLens as a virtual line above the code, left-padded with
-- `range.start_col` spaces (see runtime/lua/vim/lsp/codelens.lua), so the lens
-- floats above the annotated symbol instead of the line start. There's no
-- option for this, so we blank that leading-pad chunk (tagged
-- "LspCodeLensSeparator") for the codelens namespace only.
do
  local set_extmark = vim.api.nvim_buf_set_extmark
  local cl_ns ---@type integer?
  vim.api.nvim_buf_set_extmark = function(buffer, ns, line, col, opts)
    if opts and opts.virt_lines then
      cl_ns = cl_ns or vim.api.nvim_get_namespaces()["nvim.lsp.codelens"]
      if ns == cl_ns then
        for _, vline in ipairs(opts.virt_lines) do
          local first = vline[1]
          if first and first[2] == "LspCodeLensSeparator" and first[1]:match("^%s*$") then
            first[1] = ""
          end
        end
      end
    end
    return set_extmark(buffer, ns, line, col, opts)
  end
end
