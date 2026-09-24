from fastapi import FastAPI
from fastapi.responses import RedirectResponse
from app.schemas.url import URLCreate
from fastapi.middleware.cors import CORSMiddleware
import secrets
import string

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://127.0.0.1:5500"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

urls = {}


@app.get("/")
def root():
    return {
        "message": "URL Shortener API is running"
    }


@app.post("/api/urls")
def create_url(data: URLCreate):
    code = generate_short_code()
    short_url = f'http://localhost:8080/{code}'
    urls[code] = data.original_url

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
def redirect_to_url(short_code: str):
    original_url = urls[short_code]

    return RedirectResponse(url=original_url)

