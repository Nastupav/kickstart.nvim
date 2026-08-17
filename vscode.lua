-- Minimal configuration for the VSCode Neovim extension.
-- VS Code owns UI, LSP, completion, diagnostics, files, and splits.
-- Neovim owns motions, operators, text objects, registers, and macros.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 500

-- Use VS Code's clipboard bridge when the extension provides it.
if vim.g.vscode_clipboard then
  vim.g.clipboard = vim.g.vscode_clipboard
else
  vim.opt.clipboard = "unnamedplus"
end

-- Physical J/K/L/; is left/down/up/right in every editing mode where
-- Neovim interprets motions. Insert and command-line typing remain untouched.
local motion_modes = { "n", "x", "o" }
local motion_maps = {
  { "j", "h", "Move left" },
  { "k", "j", "Move down" },
  { "l", "k", "Move up" },
  { ";", "l", "Move right" },
  { "h", ";", "Repeat f/t search forward" },
}

for _, mapping in ipairs(motion_maps) do
  vim.keymap.set(motion_modes, mapping[1], mapping[2], {
    desc = mapping[3],
    remap = false,
    silent = true,
  })
end

-- Format document using VS Code's formatter
vim.keymap.set("n", "<leader>f", function()
  require("vscode").action("editor.action.formatDocument")
end, { desc = "Format Document", silent = true })