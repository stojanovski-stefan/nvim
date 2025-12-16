--  extends LSP functionality by allowing formatters and linters to integrate 
--  through the LSP protocol, even if they weren't originally designed as 
--  language servers. This unified approach means all diagnostics, formatting,
--  and code actions appear through the same LSP interface.
return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim", -- Critical: cpplint is now in "extras"
		"jay-babu/mason-null-ls.nvim",   -- Bridges Mason and none-ls
	},
	config = function()
		local null_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")

		-- Ensure the tools are installed via Mason
		mason_null_ls.setup({
			ensure_installed = {
				"cpplint",      -- Linter
				"clang_format", -- Formatter
			},
			automatic_installation = true,
		})

		-- Setup none-ls sources
		null_ls.setup({
			sources = {
				-- C++ Linter (Requires none-ls-extras.nvim)
				require("none-ls.diagnostics.cpplint"),

				-- C++ Formatter
				null_ls.builtins.formatting.clang_format,
			},
		})
	end,
}

