local M = {}

M.config = function()
  require("tmux").setup({
    copy_sync = { enable = false },
    navigation = {
      cycle_navigation = false,
      enable_default_keybindings = true,
    },
    resize = {
      enable_default_keybindings = true,
      resize_step_x = 1,
      resize_step_y = 1,
    },
  })
end

return M