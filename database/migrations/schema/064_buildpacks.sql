insert into repository_kind values (29, 'CNB Buildpacks'), (30, 'CNB Builders');

{{ if eq .loadSampleData "true" }}
{{ template "data/sample.sql" }}
{{ end }}

---- create above / drop below ----

delete from repository_kind where repository_kind_id in (29, 30);
