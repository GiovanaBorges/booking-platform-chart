{{- define "keycloak.enabled" -}}
{{ include "values.has" (list . (list "global" "keycloak")) }}
{{- end -}}

{{- define "keycloak.adminUser" -}}
{{ include "values.get" (list . "" (list "global" "keycloak" "auth" "adminUser")) | quote }}
{{- end -}}

{{- define "keycloak.adminPassword" -}}
{{ include "values.get" (list . "" (list "global" "keycloak" "auth" "adminPassword")) | quote }}
{{- end -}}

{{- define "keycloak.db.vendor" -}}
{{ include "values.get" (list . "" (list "global" "keycloak" "database" "vendor")) | quote }}
{{- end -}}

{{- define "keycloak.db.hostname" -}}
{{ include "values.get" (list . "" (list "global" "keycloak" "database" "hostname")) | quote }}
{{- end -}}

{{- define "keycloak.db.name" -}}
{{ include "values.get" (list . "" (list "global" "keycloak" "database" "database")) | quote }}
{{- end -}}

{{- define "keycloak.db.port" -}}
{{ include "values.get" (list . "" (list "global" "keycloak" "database" "port")) | quote }}
{{- end -}}

{{- define "keycloak.db.username" -}}
{{ include "values.get" (list . "" (list "global" "keycloak" "database" "username")) | quote }}
{{- end -}}
