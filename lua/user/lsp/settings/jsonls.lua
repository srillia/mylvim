return {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
			-- schemas = require'nlspsettings.loaders.json'.get_default_schemas()
		},
	},
}
