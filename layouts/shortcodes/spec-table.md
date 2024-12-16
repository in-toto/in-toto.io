{{ $specs := site.Data.specs }}

| Version | Description |
| ------- | ----------- |
{{ range $specs -}}
| [{{ .version }}]({{ .url }}) | {{ .description }} |
{{ end }}
