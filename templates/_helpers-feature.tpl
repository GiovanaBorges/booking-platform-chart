{{/*
Generic feature flag checker
Usage:
  include "feature.enabled" (list . (list "global" "rabbitmq"))
*/}}
{{- define "feature.enabled" -}}
{{ include "values.has" . }}
{{- end -}}
