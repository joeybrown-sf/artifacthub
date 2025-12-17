-- Register demo user
insert into "user" (user_id, alias, email, email_verified, password)
values ('00000000-0000-0000-0000-000000000001', 'demo', 'demo@artifacthub.io', true, '$2a$10$FRAFMqDgJYgKEIrW8Y3Pqu7m5uFjtGxNAjlOtXA1iiFGGH7NycLIO');

-- Register some repositories
insert into repository (name, url, repository_kind_id, user_id)
values ('artifact-hub','https://artifacthub.github.io/helm-charts/', 0, '00000000-0000-0000-0000-000000000001');

insert into repository (repository_id, name, url, repository_kind_id, user_id, branch)
values ('293fe94f-b561-4cff-85c8-adbe336dcbee', 'heroku-buildpacks', 'https://github.com/joeybrown-sf/h-buildpacks/catalog/buildpacks', 29, '00000000-0000-0000-0000-000000000001', 'main');

insert into repository (repository_id, name, url, repository_kind_id, user_id, branch)
values ('3285665e-ccdc-407b-8a2f-77bcb528c4a8', 'heroku-builders', 'https://github.com/joeybrown-sf/h-buildpacks/catalog/builders', 30, '00000000-0000-0000-0000-000000000001', 'main');
