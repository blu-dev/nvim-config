require "core"


nvimide = {
    debug_restart = false,
    debug = true,
    log_fh = nil,
    log = function(...)
        if nvimide.debug then
            local objects = {}
            for i = 1, select('#', ...) do
                local v = select(i, ...)
                table.insert(objects, vim.inspect(v))
            end
            nvimide.log_fh:write(table.concat(objects, '\n') .. '\n')
            nvimide.log_fh:flush()
        end
    end,
    script_path = function()
        return debug.getinfo(2, "S").source:sub(2)
    end,
}
if nvimide.debug then
    nvimide.log_fh = io.open("/tmp/nvim." .. os.getenv("USER") .. ".nvimide.log", nvimide.debug_restart and 'w' or 'a')
end

nvimide.log("Leave " .. nvimide.script_path())

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

vim.o.foldcolum = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds" })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds" })
vim.keymap.set('n', 'zK', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "Peek Fold" })

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'lsp' }
  end
})
