FROM python:3.10
COPY . /chatbot
WORKDIR /chatbot
RUN pip install -r requirements.txt
RUN python chatbot.py
COPY . /app
WORKDIR /app
EXPOSE $PORT
CMD gunicorn --workers=4 --bind 0.0.0.0:$PORT app:app