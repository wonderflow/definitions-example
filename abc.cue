output: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "abc"
	spec: {
		template: {
			metadata: {
				spec: {
					containers: [{
						image: paramter.image
					}]
				}
				env: {}
			}
		}
	}
}

paramter: image: string

paramter: image: "nginx"
