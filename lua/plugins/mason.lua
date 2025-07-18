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
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "prettier",
        -- php
        "php-cs-fixer",
        "phpstan",
        -- go
        "golangci-lint",
        -- c
        "cpplint",
        "clang-format",
        -- tex
        "vale",
        "latexindent",
        -- ts
        "biome",
        -- add more arguments for adding more null-ls sources
      },
    },
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
