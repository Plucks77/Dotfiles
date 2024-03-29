local status_ok, lspconfig = pcall(require, "lspconfig")
if status_ok then
  local user_plugin_opts = require("core.utils").user_plugin_opts
  local user_registration = user_plugin_opts("lsp.server_registration", nil, false)
  local handlers = require "configs.lsp.handlers"
  handlers.setup()
  require("lsp-format").setup {}
  require "lspconfig".gopls.setup { on_attach = require "lsp-format".on_attach }

  local servers = user_plugin_opts("lsp.servers", {})
  local installer_avail, lsp_installer = pcall(require, "nvim-lsp-installer")
  if installer_avail then
    for _, server in ipairs(lsp_installer.get_installed_servers()) do
      table.insert(servers, server.name)
    end
  end
  for _, server in ipairs(servers) do
    local old_on_attach = lspconfig[server].on_attach
    local opts = {
      on_attach = function(client, bufnr)
        if old_on_attach then
          old_on_attach(client, bufnr)
        end
        handlers.on_attach(client, bufnr)
      end,
      capabilities = vim.tbl_deep_extend("force", handlers.capabilities, lspconfig[server].capabilities or {}),
    }
    local present, av_overrides = pcall(require, "configs.lsp.server-settings." .. server)
    if present then
      opts = vim.tbl_deep_extend("force", av_overrides, opts)
    end
    opts = user_plugin_opts("lsp.server-settings." .. server, opts)

    if type(user_registration) == "function" then
      user_registration(server, opts)
    else
      lspconfig[server].setup(opts)
    end
  end
end
