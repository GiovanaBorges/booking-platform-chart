{{/*
Safely check if a nested values path exists
Usage:
  include "values.has" (list . (list "global" "rabbitmq" "auth"))
*/}}
{{- define "values.has" -}}
{{- $root := index . 0 -}}
{{- $keys := index . 1 -}}
{{- $current := $root.Values -}}
{{- $exists := true -}}

{{- range $keys }}
  {{- if and $exists (kindIs "map" $current) (hasKey $current .) -}}
    {{- $current = index $current . -}}
  {{- else -}}
    {{- $exists = false -}}
  {{- end -}}
{{- end -}}

{{- if $exists }}true{{ else }}false{{ end }}
{{- end -}}


{{/*
Safely get a nested value with default
Usage:
  include "values.get" (list . "" (list "global" "rabbitmq" "host"))
*/}}
{{- define "values.get" -}}
{{- $root := index . 0 -}}
{{- $default := index . 1 -}}
{{- $keys := index . 2 -}}
{{- $current := $root.Values -}}

{{- range $keys }}
  {{- if and (kindIs "map" $current) (hasKey $current .) -}}
    {{- $current = index $current . -}}
  {{- else -}}
    {{- $current = $default -}}
  {{- end -}}
{{- end -}}

{{- $current -}}
{{- end -}}
