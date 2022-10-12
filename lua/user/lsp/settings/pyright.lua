return {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
			},
			pythonPath = require("user.lsp.utils").python_path(),
		},
	},
}
