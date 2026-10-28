import secrets
import string

from app.database import get_db
from app.models import URL
from app.schemas.url import URLCreate
from fastapi import Depends, FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import RedirectResponse
from sqlalchemy.orm import Session

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://127.0.0.1:5500"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def root():
    return {
        "message": "URL Shortener API is running successfully..."
    }


@app.post("/api/urls")
def create_url(data: URLCreate, db: Session = Depends(get_db)):
    code = generate_short_code()
    short_url = f'http://localhost:8080/{code}'

    new_url = URL(
        original_url = data.original_url,
        short_code = code
    )

    db.add(new_url)
    db.commit()

    return {
        "original_url": data.original_url,
        "short_code": code,
        "short_url": short_url
    }


def generate_short_code():
    alphabet = string.ascii_letters + string.digits
    code = ''.join(secrets.choice(alphabet) for i in range(8))
    return code

@app.get("/{short_code}")
def redirect_to_url(short_code: str, db: Session = Depends(get_db)):
    url_record = db.query(URL).filter(
        URL.short_code == short_code).first()

    if url_record is None:
        return{"error": "Short URL not Found"}
    
    return RedirectResponse(url=url_record.original_url)

