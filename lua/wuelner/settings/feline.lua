local M = {}

M.config = function()
  vim.opt.ruler = false
  vim.opt.laststatus = 2

  local components = { active = {}, inactive = {} }
  local components_active = components.active
  local table_insert = table.insert

  table_insert(components_active, {})
  table_insert(components_active, {})
  table_insert(components_active, {})

  local highlighter = function(name, fg, style)
    local mode_color = require("feline.providers.vi_mode").get_mode_color

    if mode_color() ~= "darkgray" then
      return { name = name, fg = fg, style = style }
    end

    return { name = name, fg = mode_color(), style = style }
  end

  components_active[1][1] = {
    provider = "diagnostic_errors",
    icon = " E:",
    hl = function()
      return highlighter("FelineErrors", "red", "bold")
    end,
    priority = -6,
    truncate_hide = true,
  }

  components_active[1][2] = {
    provider = "diagnostic_warnings",
    icon = " W:",
    hl = function()
      return highlighter("FelineWarns", "orange", "bold")
    end,
    priority = -6,
    truncate_hide = true,
  }

  components_active[1][3] = {
    provider = "diagnostic_info",
    icon = " I:",
    hl = function()
      return highlighter("FelineInfo", "yellow", "bold")
    end,
    priority = -6,
    truncate_hide = true,
  }

  components_active[1][4] = {
    provider = "diagnostic_hints",
    icon = " H:",
    hl = function()
      return highlighter("FelineHints", "skyblue", "bold")
    end,
    priority = -6,
    truncate_hide = true,
  }

  components_active[1][5] = {
    enabled = function()
      return require("feline.providers.lsp").diagnostics_exist()
    end,
    provider = " ",
    hl = { name = "FelineDiagnosticsSeparator", fg = "bg" },
    priority = -5,
  }

  components_active[1][6] = {
    provider = "▊",
    hl = function()
      return highlighter("FelineIndicator", "cyan", "NONE")
    end,
    priority = 1,
  }

  components_active[1][7] = {
    provider = {
      name = "position",
      opts = { padding = { line = 3, col = 2 } },
    },
    left_sep = " ",
    right_sep = " ",
    hl = function()
      return highlighter("FelinePosition", "fg", "NONE")
    end,
    truncate_hide = true,
  }

  components_active[1][8] = {
    provider = "%P/%L",
    right_sep = " ",
    hl = function()
      return highlighter("FelineLines", "fg", "NONE")
    end,
    priority = -2,
    truncate_hide = true,
  }

  components_active[1][9] = {
    provider = function()
      return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    end,
    left_sep = " ",
    right_sep = " ",
    hl = function()
      return highlighter("FelineCWD", "skyblue", "bold")
    end,
    priority = -8,
    truncate_hide = true,
  }

  components_active[2][1] = {
    provider = "git_branch",
    icon = " ",
    hl = function()
      return highlighter("FelineBranch", "orange", "NONE")
    end,
    priority = -7,
    truncate_hide = true,
  }

  components_active[2][2] = {
    provider = "git_diff_added",
    icon = "  ",
    hl = function()
      return highlighter("FelineAdded", "darkgreen", "NONE")
    end,
    priority = -9,
    truncate_hide = true,
  }

  components_active[2][3] = {
    provider = "git_diff_removed",
    icon = "  ",
    hl = function()
      return highlighter("FelineRemoved", "darkred", "NONE")
    end,
    priority = -9,
    truncate_hide = true,
  }

  components_active[2][4] = {
    provider = "git_diff_changed",
    icon = "  ",
    right_sep = " ",
    hl = function()
      return highlighter("FelineChanged", "darkyellow", "NONE")
    end,
    priority = -9,
    truncate_hide = true,
  }

  components_active[3][1] = {
    provider = "file_type",
    left_sep = " ",
    right_sep = " ",
    hl = function()
      return highlighter("FelineFiletype", "fg", "NONE")
    end,
    priority = -4,
    truncate_hide = true,
  }

  components_active[3][2] = {
    provider = "file_encoding",
    right_sep = " ",
    hl = function()
      return highlighter("FelineEncoding", "fg", "NONE")
    end,
    priority = -1,
    truncate_hide = true,
  }

  components_active[3][3] = {
    provider = function()
      return string.upper(vim.fn.SleuthIndicator())
    end,
    right_sep = " ",
    hl = function()
      return highlighter("FelineSleuth", "fg", "NONE")
    end,
    priority = -3,
    truncate_hide = true,
  }

  components_active[3][4] = {
    provider = "file_format",
    right_sep = " ",
    hl = function()
      return highlighter("FelineFormat", "fg", "NONE")
    end,
    priority = -1,
    truncate_hide = true,
  }

  local components_inactive = components.inactive

  table_insert(components_inactive, {})

  components_inactive[1][1] = {
    provider = "▊",
    hl = { name = "FelineIndicatorInactive", fg = "bg" },
    priority = 1,
  }

  components_inactive[1][2] = {
    provider = {
      name = "position",
      opts = { padding = { line = 2, col = 2 } },
    },
    left_sep = " ",
    right_sep = " ",
    hl = function()
      return highlighter("FelinePositionInactive", "gray", "NONE")
    end,
    truncate_hide = true,
  }

  components_inactive[1][3] = {
    provider = {
      name = "file_info",
      opts = {
        file_readonly_icon = " ",
      },
    },
    icon = "",
    left_sep = " ",
    hl = function()
      return highlighter("FelineFilenameInactive", "gray", "NONE")
    end,
    priority = -1,
    truncate_hide = true,
  }

  local enfocado_colors = vim.fn["enfocado#getColorScheme"]()

  require("feline").setup({
    theme = {
      bg = enfocado_colors.bg_0[1],
      fg = enfocado_colors.fg_0[1],
      black = enfocado_colors.bg_1[1],
      darkred = enfocado_colors.red[1],
      darkgreen = enfocado_colors.green[1],
      darkyellow = enfocado_colors.yellow[1],
      oceanblue = enfocado_colors.blue[1],
      darkmagenta = enfocado_colors.magenta[1],
      darkcyan = enfocado_colors.cyan[1],
      darkorange = enfocado_colors.orange[1],
      darkviolet = enfocado_colors.violet[1],
      gray = enfocado_colors.dim_0[1],
      darkgray = enfocado_colors.bg_2[1],
      red = enfocado_colors.br_red[1],
      green = enfocado_colors.br_green[1],
      yellow = enfocado_colors.br_yellow[1],
      skyblue = enfocado_colors.br_blue[1],
      magenta = enfocado_colors.br_magenta[1],
      cyan = enfocado_colors.br_cyan[1],
      orange = enfocado_colors.br_orange[1],
      violet = enfocado_colors.br_violet[1],
      white = enfocado_colors.fg_1[1],
    },
    vi_mode_colors = {
      ["COMMAND"] = "darkgray",
      ["NONE"] = "darkgray",
      ["SHELL"] = "darkgray",
      ["TERM"] = "darkgray",
    },
    components = components,
    force_inactive = {
      filetypes = {},
      buftypes = {
        "^help$",
        "^loclist$",
        "^nofile$",
        "^nowrite$",
        "^prompt$",
        "^quickfix$",
        "^terminal$",
      },
    },
    disable = { filetypes = { "^aerial$", "^fern$" }, buftypes = {} },
  })

  local aerial_breadcrumbs = require("wuelner.utils").aerial_breadcrumbs

  require("feline").winbar.setup({
    components = {
      active = {
        {
          {
            provider = function()
              return aerial_breadcrumbs()
            end,
            left_sep = " ",
            right_sep = " ",
            hl = { name = "FelineWinbar", fg = "fg" },
          },
        },
      },
      inactive = {
        {
          {
            provider = function()
              return aerial_breadcrumbs()
            end,
            left_sep = " ",
            right_sep = " ",
            hl = { name = "FelineInactiveWinbar", fg = "gray" },
          },
        },
      },
    },
    disable = {
      buftypes = {
        "^help$",
        "^loclist$",
        "^nofile$",
        "^nowrite$",
        "^prompt$",
        "^quickfix$",
        "^terminal$",
      },
    },
  })
end

return M
