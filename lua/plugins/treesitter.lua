-- treesitter is a programming language parser that provides syntax highlighting and indenting
  return {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",

    config = function()

      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })

    end
  }
