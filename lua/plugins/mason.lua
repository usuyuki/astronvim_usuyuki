-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "terraformls",
        "lua_ls",
        -- php
        "intelephense",
        -- go
        "gopls",
        -- c
        "clangd",
        -- tex
        -- ltex-lsもあるが、texlabのほうが更新多めでrust製なのでtexlab採用。とはいえltex-lsもkotilin製で気になる
        "texlab",
        -- markdown 色々LSPはあるが一番更新が盛んなものを使用
        "marksman",
        -- rust
        "rust_analyzer",
        -- protobuf
        "buf_ls",
        -- ts
        "biome",
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  -- none-ls.nvim is incompatible with Neovim 0.12+ (lsp._request_name_to_capability removed)
  {
    "jay-babu/mason-null-ls.nvim",
    enabled = false,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        "php",
        -- add more arguments for adding more debuggers
      },
    },
  },
}
