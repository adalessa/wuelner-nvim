local M = {}

M.setup = function()
  local set_var = vim.api.nvim_set_var

  set_var("enfocado_style", "nature")
  set_var("enfocado_plugins", {
    "aerial",
    "bufferline",
    "cmp",
    "dap-ui",
    "fern",
    "gitsigns",
    "glyph-palette",
    "illuminate",
    "indent-blankline",
    "lspconfig",
    "matchup",
    "noice",
    "notify",
    "null-ls",
    "packer",
    "smoothcursor",
    "telescope",
    "treesitter",
    "visual-multi",
  })
end

M.config = function()
  local create_autocmd = vim.api.nvim_create_autocmd
  local command = vim.api.nvim_command

  create_autocmd("ColorScheme", {
    pattern = "enfocado",
    callback = function()
      command("highlight NormalNC guibg=#1e1e1e")
      command("highlight! link FloatTitle NormalFloat")
      command("highlight! link Whitespace DiagnosticError")
      command("highlight NormalSB guibg=#000000 guifg=#b9b9b9")
      command("highlight WinbarSB guibg=#000000 guifg=#000000")

      local get_option_value = vim.api.nvim_get_option_value
      local set_option_value = vim.api.nvim_set_option_value
      local option_opts = {}

      if
        vim.api.nvim_call_function("has", { "termguicolors" }) == 1
        and get_option_value("termguicolors", option_opts) == true
      then
        set_option_value("winblend", 10, option_opts)
        set_option_value("pumblend", 10, option_opts)
      end

      local fillchars = get_option_value("fillchars", option_opts)

      set_option_value(
        "fillchars",
        fillchars == "" and "vert: ,horiz: ,verthoriz: ,vertleft: ,horizdown: ,horizup: ,vertright: "
          or fillchars .. ",vert: ,horiz: ,verthoriz: ,vertleft: ,horizdown: ,horizup: ,vertright: ",
        option_opts
      )

      local loaded_sidebar_bufs = {}

      setmetatable(loaded_sidebar_bufs, { __mode = "kv" })

      create_autocmd("FileType", {
        pattern = "fern,aerial,nerdterm,qf",
        callback = function(ev)
          local bufnr = ev.buf

          if loaded_sidebar_bufs[bufnr] then
            return
          else
            set_option_value(
              "winhighlight",
              "Normal:NormalSB,NormalNC:NormalSB,Winbar:WinbarSB,WinbarNC:WinbarSB",
              { buf = bufnr }
            )

            loaded_sidebar_bufs[bufnr] = true
          end
        end,
      })
    end,
  })

  create_autocmd("UIEnter", {
    callback = function()
      command("colorscheme enfocado")

      return true
    end,
    once = true,
    nested = true,
  })
end

return M
