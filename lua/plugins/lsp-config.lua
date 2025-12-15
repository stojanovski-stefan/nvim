-- Langauge Server Protocos (LSPs) is a standard that allows communication
-- between text editors and langauge servers (running on your machine) that
-- give "langauge intelligence features"

return {
  -- manages and installs LSPs on system
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },

  -- bridges gap between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {"lua_ls", "clangd", "pyright"}
      })
    end
  },

  -- configures neovim to use LSPs, set up communication between nvim and LSPs
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config["pyright"] = {
        capabilities = capabilities,
        filetypes = {"python"}
      }

      vim.lsp.config["clang"] = {
        capabilities = capabilities
      }

      vim.lsp.config["lua_ls"] = {
        capabilities = capabilities,

        settings = {
          Lua = { diagnostics = { globals = { 'vim' } } }
        }
      }

      vim.lsp.enable('lua_ls')
      vim.lsp.enable('clangd')
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>K', vim.diagnostic.open_float, {})
      vim.keymap.set('n', '<leader>gf', function()
        vim.lsp.buf.format({
          async = true,
          filter = function(client)
            return client.name == "null-ls"  -- Prefer none-ls/clang-format over clangd
          end
        })
      end, {})

      -- format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          vim.lsp.buf.format({
          async = true,
          filter = function(client)
            return client.name == "null-ls"  -- Prefer none-ls/clang-format over clangd
          end
        })
        end
      })

      vim.diagnostic.config({
        virtual_text = true,  -- Show message inline at end of line
        signs = true,         -- Show icons (E, W) in the gutter
        underline = true,     -- Underline the error in the code
        update_in_insert = false, -- Don't update while typing (less distracting)
      })


    end  -- end config
  }
}

