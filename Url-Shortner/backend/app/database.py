
import os

from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import declarative_base, sessionmaker

DATABASE_URL = (
    f"postgresql+psycopg://"
    f"{os.environ['POSTGRES_USER']}:"
    f"{os.environ['POSTGRES_PASSWORD']}@"
    f"db:5432/"
    f"{os.environ['POSTGRES_DB']}"
)

Base = declarative_base()

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(
    bind=engine,
    autoflush=False,
    autocommit=False,
)


def verify_database_connection():
    try:
        with engine.connect() as connection:
            result = connection.execute(text("SELECT 1"))
            return result.scalar_one() == 1
        
    except SQLAlchemyError as error:
        print(f"Database connection failed: {error}")
        return False

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()