insert into repository_kind values
  (29, 'CNB Buildpacks'),
  (30, 'CNB Builders');

---- create above / drop below ----

delete from repository_kind where repository_kind_id in (29, 30);
