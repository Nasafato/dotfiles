function format_prettier()
  return {
    exe = "npx prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

require("formatter").setup(
  {
    logging = false,
    filetype = {
      typescript = {format_prettier},
      javascript = {format_prettier},
      json = {format_prettier},
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

-- local root_pattern = require('lspconfig').util.root_pattern
-- require('lspconfig').tsserver.setup{
--   cmd = { "typescript-language-server", "--stdio" },
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
--   init_options = {
--     hostInfo = "neovim"
--   },
--   root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")
-- }

-- require('lspconfig').prismals.setup{
--   cmd = { "prisma-language-server", "--stdio" },
--   filetypes = { "prisma" },
--   root_dir = root_pattern(".git", "package.json"),
--   settings = {
--     prisma = {
--       prismaFmtBinPath = ""
--     }
--   }
-- }

-- require('lspconfig').graphql.setup{
--     cmd = { "graphql-lsp", "server", "-m", "stream" },
--     filetypes = { "graphql" },
--     root_dir = root_pattern('.git', '.graphqlrc*', '.graphql.config.*')
-- }

local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  local opts = {noremap = true, silent = true}

  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
  buf_set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
end

local servers = {"tsserver", "prismals", "graphql"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150
    }
  }
end

local efm_config = os.getenv("HOME") .. "/.config/nvim/lua/efm-config.yaml"
nvim_lsp.efm.setup {
  cmd = {"efm-langserver", "-c", efm_config},
  filetypes = {
    "javascript",
    "typescript"
  },
  on_attach = on_attach,
  init_options = {documentFormatting = false}
}
