from app.main import app
from fastapi.testclient import TestClient


client = TestClient(app)


def test_create_short_url():
    response = client.post(
        "/api/urls",
        json={"original_url": "https://www.google.com"},
    )

    print(response.json())

    assert response.status_code == 200

    data = response.json()

    assert "short_code" in data
    assert len(data["short_code"]) == 8


def test_redirect_to_original_url():
    create_response = client.post(
        "/api/urls",
        json={"original_url": "https://www.google.com"},
    )

    print(create_response.json())

    assert create_response.status_code == 200

    short_code = create_response.json()["short_code"]

    redirect_response = client.get(
        f"/{short_code}",
        follow_redirects=False,
    )

    assert redirect_response.status_code == 307
    assert redirect_response.headers["location"] == "https://www.google.com"
