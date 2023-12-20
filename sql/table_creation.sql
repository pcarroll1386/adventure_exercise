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
    name VARCHAR(50) NOT NULL,
    times_per_week int,
    notes TEXT
);


create table measurement_units(
    unit_id BIGSerial PRIMARY KEY,
    name varchar(50)
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
    team_user_id BIGINT,
    routine_id BIGINT,
    PRIMARY Key(team_user_id, routine_id),
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
    name VARCHAR(50) NOT NULL,
    fluid_intake int
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
    day_id BIGINT,
    workout_id BIGINT,
    PRIMARY KEY(day_id, workout_id),
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
    timestamp timestamp not null DEFAULT now(),
    is_log BOOLEAN not null DEFAULT false,
    instructional_link varchar(255),
    has_weight BOOLEAN not null DEFAULT false,
    CONSTRAINT fk_type FOREIGN KEY(type_id) REFERENCES type(type_id)
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


create table "set"(
    set_id BIGSERIAL PRIMARY KEY,
    exercise_id BIGSERIAL,
    duration INT,
    distance INT,
    max_reps INT,
    min_reps INT,
    reps INT,
    "weight" INT,
    "timestamp" TIMESTAMP,
    CONSTRAINT fk_exercise FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id)
);