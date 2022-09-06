# The result of the template execution by:
```
cue export canary-flagger-wrong.cue
```

```json
{
	"canary": {
		"annotations": {}
		"attributes": {
			"appliesToWorkloads": [
				"*",
			]
			"workloadRefPath": ""
		}
		"labels": {}
		"type": "trait"
	}
	"template": {
		"outputs": {
			"kind": "Canary"
			"metadata": {
				"name": "test"
			}
			"metricTeamplate": {
				"apiVersion": "flagger.app/v1beta1"
				"kind":       "MetricTemplate"
				"metadata": {
					"name": "sampleappy-test"
				}
				"namespace": "monitoring"
				"spec": {
					"provider": {
						"type":    "datadog"
						"address": "https://api.datadoghq.com"
						"secretRef": {
							"name": "datadog-flagger"
						}
					}
					"query": "ajhcbjshdbcks"
				}
			}
			"spec": {
				"analysis": {
					"interval":   "1m"
					"iterations": 1
					"threshold":  2
					"metrics": [
						{
							"name":    "sampleappy-test"
							"iterval": "1"
							"templateRef": {
								"name":      "sampleappy-test"
								"namespace": "monitoring"
							}
							"thresholdRange": {
								"max": 5
							}
						},
					]
				}
				"autoscalerRef": {
					"name":       "test"
					"apiVersion": "autoscaling/v2beta2"
					"kind":       "HorizontalPodAutoscaler"
				}
				"progressDeadlineSeconds": "1800s"
				"service": {
					"gateways": [
						"sampleappy",
					]
					"hosts": [
						"xxxxxxx.local",
					]
					"port": 80
					"trafficPolicy": {
						"tls": {
							"mode": "DISABLE"
						}
					}
				}
				"targetRef": {
					"name":       "test"
					"apiVersion": "apps/v1"
					"kind":       "Deployment"
				}
			}
		}
		"parameter": {
			"gateways": [
				"sampleappy",
			]
			"hosts": [
				"xxxxxxx.local",
			]
			"port": 80
			"metrics": [
				{
					"name":     "sampleappy-test"
					"interval": "1"
					"thresholdRange": {
						"max": 5
					}
					"query": "ajhcbjshdbcks"
				},
			]
			"analysisInterval":    "1m"
			"iterationsIteration": 1
		}
	}
	"context": {
		"name": "test"
	}
}
```

It seems the outputs not right, you need to wrap canary K8s object inside a key, check the `canary-flagger.md` file.


