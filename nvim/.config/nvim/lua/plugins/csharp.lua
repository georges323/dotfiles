-- C# via roslyn.nvim (Microsoft's Roslyn LSP), replacing the OmniSharp the
-- LazyVim `lang.dotnet` extra sets up by default. Requires Neovim >= 0.12.
return {
  -- 1. Install the Roslyn language server through Mason. It lives in a custom
  --    registry, so we add it alongside the default one (don't drop the default).
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.registries = opts.registries or { "github:mason-org/mason-registry" }
      table.insert(opts.registries, "github:Crashdummyy/mason-registry")
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "roslyn")
    end,
  },

  -- 2. roslyn.nvim manages the LSP client itself. Plugin behaviour goes in
  --    `opts`; C# server settings go through `vim.lsp.config("roslyn", ...)`,
  --    which roslyn.nvim merges into the client config at attach time.
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      filewatching = "auto",
    },
    init = function()
      vim.lsp.config("roslyn", {
        settings = {
          -- Inlay hints: types of implicit vars, lambda/param types, etc.
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
          },
          -- CodeLens: "N references" / test runners above members.
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          -- Completion: suggest + auto-add `using` for unimported namespaces.
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          -- Organize `using`s when formatting.
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
          },
          -- Resolve symbols/go-to-def into reference assemblies (replaces the
          -- old omnisharp-extended decompilation workaround).
          ["csharp|symbol_search"] = {
            dotnet_search_reference_assemblies = true,
          },
        },
      })
    end,
  },

  -- 3. Turn off the OmniSharp server the dotnet extra configures. Replacing the
  --    whole table (not merging) drops its `gd`/omnisharp_extended keymap too.
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.omnisharp = { enabled = false }
      -- csharp-language-server (csharp_ls) is a leftover Mason install; keep it
      -- from attaching as a second C# server alongside Roslyn.
      opts.servers.csharp_ls = { enabled = false }
      -- LazyVim ships CodeLens off by default; enable so references show.
      opts.codelens = opts.codelens or {}
      opts.codelens.enabled = true
    end,
  },

  -- 4. omnisharp-extended is redundant now (Roslyn handles metadata go-to-def).
  { "Hoffs/omnisharp-extended-lsp.nvim", enabled = false },
}
