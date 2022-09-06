canary: {
	annotations: {}
	attributes: {
		appliesToWorkloads: ["*"]
		workloadRefPath: ""
	}
	labels: {}
	type: "trait"
}

template: {
	#metrics: {
		name:     *"test" | string
		interval: *"1" | string
		thresholdRange: max: *5 | int
		query: *"select" | string
	}
	outputs: {
		mycanary: {
			kind: "Canary"
			metadata: name: context.name
			spec: {
				analysis: {
					interval:   parameter.analysisInterval
					iterations: parameter.iterationsIteration
					threshold:  2
					metrics: [
						for i in parameter.metrics {
							name:    i.name
							iterval: i.interval
							templateRef: {
								name:      i.name
								namespace: "monitoring"
							}
							thresholdRange: i.thresholdRange
						},
					]
				}
				autoscalerRef: {
					name:       context.name
					apiVersion: "autoscaling/v2beta2"
					kind:       "HorizontalPodAutoscaler"
				}
				progressDeadlineSeconds: "1800s"
				service: {
					gateways: parameter.gateways
					hosts:    parameter.hosts
					port:     parameter.port
					trafficPolicy: tls: mode: "DISABLE"
				}
				targetRef: {
					name:       context.name
					apiVersion: "apps/v1"
					kind:       "Deployment"
				}
			}
		}
	}
	outputs: {
		for metric in parameter.metrics {
			metricTeamplate: {
				apiVersion: "flagger.app/v1beta1"
				kind:       "MetricTemplate"
				metadata:
					name: metric.name
				namespace: "monitoring"
				spec: {
					provider: {
						type:    "datadog"
						address: "https://api.datadoghq.com"
						secretRef: name: "datadog-flagger"
					}
					query: metric.query
				}
			}
		}
	}
	parameter: {
		gateways: [string]
		hosts: [string]
		port: int
		metrics: [#metrics]
		analysisInterval:    *"1m" | string
		iterationsIteration: *1 | int
	}
}
