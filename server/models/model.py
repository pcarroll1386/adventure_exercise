from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, BigInteger, Table, datetime
from sqlalchemy.orm import relationship, Mapped

from models.base import Base

user_role = Table(
    "user_role",
    Column("user_id", ForeignKey("user.user_id")),
    Column("role_id", ForeignKey("role.role_id"))
)

team_routine = Table(
    "team_routine",
    Column("team_id", ForeignKey("team.team_id")),
    Column("routine_id", ForeignKey("routine_id"))
)

user_routine = Table(
    "user_routine",
    Column("team_user_id", ForeignKey("team_user.team_user_id")),
    Column("routine_id", ForeignKey("routine.routine_id"))
)

workout_routine = Table(
    "workout_routine",
    Column("workout_id", ForeignKey("workout.workout_id")),
    Column("routine_id", ForeignKey("routine.routine_id"))
)

workout_exercise = Table(
    Column("workout_id", ForeignKey("workout.workout_id")),
    Column("exercise_id", ForeignKey("exercise.exercise_id"))
)

workout_days = Table(
    "workout_days",
    Column("day_id", ForeignKey("day.day_id")),
    Column("workout_id", ForeignKey("workout.workout_id"))
)

exercise_equipment = Table(
    "exercise_equipment",
    Column("exercise_id", ForeignKey("exercise.exercise_id")),
    Column("equipment_id",ForeignKey("equipment.equipment_id"))
)


class Role(Base):
    __tablename__ = "role"

    role_id = Column(BigInteger, primary_key=True)
    role = Column(String, index=True, nullable=False)

    users = relationship("User", secondary=user_role, back_populates="roles")


class User(Base):
    __tablename__ = "user"

    user_id = Column(BigInteger, primary_key=True)
    password = Column(String, nullable=False)
    username = Column(String, index=True, nullable=False)
    weight = Column(Integer, nullable=False)
    height = Column(Integer, nullable=False)

    roles = relationship("Role", secondary=user_role, back_populates="users")
    team_users = relationship("TeamUser")


class TeamUser(Base):
    __tablename__ = "team_user"

    team_user_id = Column(BigInteger, primary_key=True)
    nickname = Column(String, nullable=False)
    user_id = Column(BigInteger, ForeignKey("user.user_id"))
    team_id = Column(BigInteger, ForeignKey("team.team_id"))

    user = relationship("User", back_populates="team_users")
    team = relationship("Team", back_populates="team_users")
    user_routines = relationship("Routines", secondary=user_routine, back_populates="users")
    

class Team(Base):
    __tablename__ = "team"

    team_id = Column(BigInteger, primary_key=True)
    name = Column(String, nullable=False)
    slogan = Column(String, nullable=False)

    team_users = relationship("TeamUser")
    routines = relationship("Routine", secondary=team_routine, back_populates="teams")

class Routine(Base):
    __tablename__ = "routine"
    
    routine_id = Column(BigInteger, primary_key=True)
    name = Column(String, nullable=False)
    times_per_week = Column(Integer)
    notes = Column(String)

    teams = relationship("Team", secondary=team_routine, back_populates="routines")
    team_users = relationship("TeamUser", secondary=user_routine, back_populates="routines")

class MeasurementUnits(Base):
    __tablename__ = "measurement_units"

    unit_id = Column(BigInteger, primary_key=True)
    name = Column (String)

class Workout(Base):
    __tablename__ = "workout"

    workout_id = Column(BigInteger, primary_key=True)
    name = Column(String, nullable=False)
    fluid_intake = Column(Integer)

class Day(Base):
    __tablename__ = "day"

    day_id = Column(BigInteger, primary_key=True)
    name = Column(String, nullable=False)

class Type(Base):
    __tablename__ = "type"
    
    type_id = Column(BigInteger, primary_key=True)
    type = Column(String, nullable=False)

class Equipment(Base):
    __tablename__ = "equipment"

    equipment_id = Column(BigInteger, primary_key=True)
    name = Column(String, nullable=False)

class Exercise(Base):
    __tablename__ = "exercise"

    exercise_id = Column(BigInteger, primary_key=True)
    name = Column(String, nullable=False)
    timestamp = Column(datetime.DateTime(timezone=True), default=datetime.datetime.utcnow)
    is_log = Column(Boolean, default=False)
    instructional_link = Column(String)
    has_weight = Column(Boolean, default=False)



