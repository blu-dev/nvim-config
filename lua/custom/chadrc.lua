---@type ChadrcConfig
local M = {}

M.ui = { theme = 'catppuccin', transparency = true }
M.plugins = 'custom.plugin'
M.mappings = require "custom.mappings"

return M
