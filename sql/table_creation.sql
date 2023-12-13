use postgres;

create table role(
    role_id BIGSERIAL PRIMARY KEY,
    role VARCHAR(50) NOT NULL
);


create table "user"(
    user_id BIGSERIAL PRIMARY KEY,
    password VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    weight INT NOT NULL,
    height INT NOT NUll
);


create table user_role(
    user_id BIGINT,
    role_id BIGINT,
    PRIMARY KEY(user_id, role_id),
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES "user"(user_id),
    CONSTRAINT fk_role FOREIGN KEY(role_id) REFERENCES role(role_id)
);


create table team(
    team_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    slogan VARCHAR(255) NOT NULL
);


create table routine(
    routine_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);


create table team_user(
    team_user_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    team_id BIGINT NOT NULL,
    nickname VARCHAR(50) NOT NULL,
    CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES "user"(user_id),
    CONSTRAINT fk_team_id FOREIGN KEY(team_id) REFERENCES team(team_id) 
);


create table user_routine(
    user_routine_id BIGSERIAL PRIMARY KEY,
    team_user_id BIGINT not null,
    routine_id BIGINT not null,
    number_of_times_a_week INT not null DEFAULT 1,
    CONSTRAINT fk_team_user FOREIGN KEY(team_user_id) REFERENCES team_user(team_user_id),
    CONSTRAINT fk_routine FOREIGN KEY(routine_id) REFERENCES routine(routine_id)
);


create table team_routine(
    team_id BIGINT,
    routine_id BIGINT,
    PRIMARY KEY(team_id, routine_id),
    CONSTRAINT fk_team FOREIGN KEY(team_id) REFERENCES team(team_id),
    CONSTRAINT fk_routine FOREIGN KEY(routine_id) REFERENCES routine(routine_id)
);


create table workout(
    workout_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);


create table workout_routine(
    workout_id BIGINT,
    routine_id BIGINT,
    PRIMARY KEY(workout_id, routine_id),
    CONSTRAINT fk_workout FOREIGN KEY(workout_id) REFERENCES workout(workout_id),
    CONSTRAINT fk_routine FOREIGN KEY(routine_id) REFERENCES routine(routine_id)
);


create table team_workout(
    team_id BIGINT,
    workout_id BIGINT,
    PRIMARY KEY(team_id, workout_id),
    CONSTRAINT fk_team FOREIGN KEY(team_id) REFERENCES team(team_id),
    CONSTRAINT fk_workout FOREIGN KEY(workout_id) REFERENCES workout(workout_id)
);


create table day(
    day_id BIGSERIAL PRIMARY KEY,
    name varchar(50) not null
);


create table workout_day(
    user_routine_id BIGINT,
    day_id BIGINT,
    workout_id BIGINT,
    PRIMARY KEY(user_routine_id, day_id, workout_id),
    CONSTRAINT fk_user_routine FOREIGN KEY(user_routine_id) REFERENCES user_routine(user_routine_id),
    CONSTRAINT fk_day FOREIGN KEY(day_id) REFERENCES day(day_id),
    CONSTRAINT fk_workout FOREIGN KEY(workout_id) REFERENCES workout(workout_id)
);


create table type(
    type_id BIGSERIAL PRIMARY KEY,
    type varchar(50) not null 
);


create table exercise(
    exercise_id BIGSERIAL PRIMARY KEY,
    type_id BIGINT not null,
    name varchar not null,
    time timestamp not null DEFAULT now(),
    instructional_link varchar(255),
    duration int,
    min_reps int,
    max_reps int,
    has_weight BOOLEAN not null DEFAULT false,
    CONSTRAINT fk_type FOREIGN KEY(type_id) REFERENCES type(type_id)
);


create table user_routine_exercise_target(
    user_routine_exercise_target_id BIGSERIAL PRIMARY KEY,
    time INT,
    set_number INT,
    min_reps INT,
    max_reps INT,
    distance INT,
    duration INT,
    weight INT,
    notes TEXT,
    user_routine_id BIGINT NOT NULL,
    exercise_id BIGINT NOT NULL,
    CONSTRAINT fk_user_routine FOREIGN KEY(user_routine_id) REFERENCES user_routine(user_routine_id),
    CONSTRAINT fk_exercise FOREIGN KEY(exercise_id) REFERENCES exercise(exercise_id)
);


create table log_entry(
    log_entry_id BIGSERIAL PRIMARY KEY,
    exercise_workout_targets_id BIGINT not null,
    reps INT,
    distance VARCHAR(255),
    weight VARCHAR(255),
    notes TEXT,
    timestamp TIMESTAMP NOT NULL DEFAULT NOW(),
    sets INT,
    time INT,
    fluid_intake INT,
    CONSTRAINT fk_exercise_workout_target FOREIGN KEY(exercise_workout_targets_id) REFERENCES user_routine_exercise_target(user_routine_exercise_target_id)
);


create table equipment(
    equipment_id BIGSERIAL PRIMARY KEY,
    name varchar not null
);


create table workout_exercise(
    workout_id BIGSERIAL,
    exercise_id BIGSERIAL,
    PRIMARY KEY(workout_id, exercise_id),
    CONSTRAINT fk_workout FOREIGN KEY(workout_id) REFERENCES workout(workout_id),
    CONSTRAINT fk_exercise FOREIGN KEY(exercise_id) REFERENCES exercise(exercise_id)
);


create table exercise_equipment(
    exercise_id BIGSERIAL,
    equipment_id BIGSERIAL,
    PRIMARY KEY(exercise_id, equipment_id),
    CONSTRAINT fk_exercise FOREIGN KEY(exercise_id) REFERENCES exercise(exercise_id),
    CONSTRAINT fk_equipment FOREIGN KEY(equipment_id) REFERENCES equipment(equipment_id)
);