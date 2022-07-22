local lsp_installer = require("nvim-lsp-installer")
local user_settings = require("user_settings")
lsp_installer.setup()

for _, server in pairs(lsp_installer.get_installed_servers()) do
  require("lspconfig")[server.name].setup({
    on_attach = function(client, bufnr)
      local lsp_signature_config = {
        hint_prefix = ""
      }

      for k, v in pairs(user_settings.lsp_signature) do
        lsp_signature_config[k] = v
      end


      require("lsp_signature").on_attach(lsp_signature_config)

      local formatters = require("plugins.lsp.utils")
      local client_filetypes = client.config.filetypes or {}
      for _, filetype in ipairs(client_filetypes) do
        if #vim.tbl_keys(formatters.list_registered_formatters(filetype)) > 0 then
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
        end
      end

      if client.name == "clangd" then
        client.offset_encoding = "utf-16"
      end
    end,

    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  })
end
