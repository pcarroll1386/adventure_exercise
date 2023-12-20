INSERT INTO "role" ("role")
VALUES 
('ADMIN'),
('USER');


INSERT INTO "user" ("username", "password", "weight", "height")
VALUES
('pfcarroll1386@gmail.com', 'Password123', 275, 185),
('lucius.carroll.476@gmail.com', 'password', 180, 175);

INSERT INTO "user_role"("user_id", "role_id")
VALUES
(1,1),
(1,2),
(2,1),
(2,2);


INSERT INTO "team"("name", "slogan")
VALUES
('Bears', 'We eat exersize for breakfast.'),
('Jack Rabbits', 'Jumping into fitness.'),
('Battle Mages', 'I cast exersize on us!'),
('Runny Noses', 'Yeah, we do not get our name either.'),
('Beer League', 'Chugging brews, and squatting glutes.'),
('The Jumping Jacks', 'Jacks for fitness!'),
('Dad bods', 'Why did the hamberger go to the gym? To get better buns!');


INSERT INTO "team_user"("user_id", "team_id", "nickname")
VALUES
(1, 1, 'The Beast'),
(2, 1, 'Pappa Bear'),
(2, 5, 'Jimmy Long Legs');


INSERT INTO "routine" ("name", "times_per_week", "notes")
VALUES
('Weight Lifting', 4, 'Weight Lifting Excersies 4 times a week'),
('Hybrid Calisthenics', 6, 'Calisthenics for varying skills'),
('Run a Mile', 1, 'Mile Fun Run'),
('Weight Lifing For Paul', 4, 'These are my goals'),
('Hybrid Calisthenics for Paul', 6, 'Goals'),
('Weight Lifting for Lucius', 5, 'Goals'),
('Mile Run for Lucius', 2, 'Goals');


INSERT INTO "team_routine"("team_id", "routine_id")
VALUES
(1,1),
(1,2),
(2,2),
(2,3),
(3,1),
(3,3),
(4,1),
(5,1),
(6,1),
(6,2),
(6,3),
(7,2);


INSERT INTO "user_routine"("team_user_id", "routine_id")
VALUES
(1, 4),
(1, 5),
(2, 7),
(3, 6);