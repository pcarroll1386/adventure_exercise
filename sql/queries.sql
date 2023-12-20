select * from "user"
inner join "user_role" on "user".user_id  = "user_role".user_id 
where "user_role".role_id = 1; 

select * from "user" where user_id = 1;