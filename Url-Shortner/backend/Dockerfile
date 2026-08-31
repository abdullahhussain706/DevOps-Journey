FROM python:3.12-alpine3.23

WORKDIR /app

COPY . .

EXPOSE 8000

RUN pip install -r requirements.txt

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]