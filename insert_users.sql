-- Register brown.joseph user
insert into "user" (user_id, alias, email, email_verified, password)
values ('df6e4253-0121-4d2f-a228-f3259e5c30a0', 'brown.joseph', 'brown.joseph@salesforce.com', true, '$2a$10$bmKBt.y4zyIXSu/gCaCUJOa02kd6YvK1cYjBpY9yb.QizUW7irF4u')
on conflict (user_id) do nothing;

-- Register jdodson user
insert into "user" (user_id, alias, email, email_verified, password)
values ('1eed4abd-c30c-4764-85d6-0a74502fd52c', 'jdodson', 'jdodson@salesforce.com', true, '$2a$10$bmKBt.y4zyIXSu/gCaCUJOa02kd6YvK1cYjBpY9yb.QizUW7irF4u')
on conflict (user_id) do nothing;
