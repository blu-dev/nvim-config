local M = {}

M.dap = {
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle breakpoint"
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets')
        local sidebar = widgets.sidebar(widgets.scope)
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  }
}

return M
