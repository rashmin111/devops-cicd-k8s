{{- define "devops-cicd-k8s.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "devops-cicd-k8s.fullname" -}}
{{- printf "%s" (include "devops-cicd-k8s.name" .) -}}
{{- end -}}
