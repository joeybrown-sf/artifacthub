-- Register demo user
insert into "user" (user_id, alias, email, email_verified, password)
values ('00000000-0000-0000-0000-000000000001', 'demo', 'demo@artifacthub.io', true, '$2a$10$FRAFMqDgJYgKEIrW8Y3Pqu7m5uFjtGxNAjlOtXA1iiFGGH7NycLIO');

-- Register brown.joseph user
insert into "user" (user_id, alias, email, email_verified, password)
values ('df6e4253-0121-4d2f-a228-f3259e5c30a0', 'brown.joseph', 'brown.joseph@salesforce.com', true, '$2a$10$bmKBt.y4zyIXSu/gCaCUJOa02kd6YvK1cYjBpY9yb.QizUW7irF4u');

-- Register jdodson user
insert into "user" (user_id, alias, email, email_verified, password)
values ('1eed4abd-c30c-4764-85d6-0a74502fd52c', 'jdodson', 'jdodson@salesforce.com', true, '$2a$10$bmKBt.y4zyIXSu/gCaCUJOa02kd6YvK1cYjBpY9yb.QizUW7irF4u');

-- Register some repositories
insert into repository (name, url, repository_kind_id, user_id)
values ('artifact-hub','https://artifacthub.github.io/helm-charts/', 0, '00000000-0000-0000-0000-000000000001');

insert into repository (repository_id, name, url, repository_kind_id, user_id, branch)
values ('293fe94f-b561-4cff-85c8-adbe336dcbee', 'heroku-buildpacks', 'https://github.com/joeybrown-sf/h-buildpacks/catalog/buildpacks', 29, '00000000-0000-0000-0000-000000000001', 'main');

insert into repository (repository_id, name, url, repository_kind_id, user_id, branch)
values ('3285665e-ccdc-407b-8a2f-77bcb528c4a8', 'heroku-builders', 'https://github.com/joeybrown-sf/h-buildpacks/catalog/builders', 30, '00000000-0000-0000-0000-000000000001', 'main');
