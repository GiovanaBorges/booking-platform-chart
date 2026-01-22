{{- define "rabbitmq.enabled" -}}
{{ include "values.has" (list . (list "global" "rabbitmq")) }}
{{- end -}}

{{- define "rabbitmq.host" -}}
{{ include "values.get" (list . "" (list "global" "rabbitmq" "host")) | quote }}
{{- end -}}

{{- define "rabbitmq.port" -}}
{{ include "values.get" (list . "" (list "global" "rabbitmq" "port")) }}
{{- end -}}

{{- define "rabbitmq.username" -}}
{{ include "values.get" (list . "" (list "global" "rabbitmq" "username")) | quote }}
{{- end -}}


{{- define "rabbitmq.password" -}}
{{ include "values.get" (list . "" (list "global" "rabbitmq" "auth" "password")) | quote }}
{{- end -}}