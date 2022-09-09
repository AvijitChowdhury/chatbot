FROM python:3.10
COPY requirements.txt .

RUN pip install -r requirements.txt
RUN python -c "import nltk;nltk.download('omw-1.4');nltk.download('wordnet');nltk.download('punkt')"
COPY . /chatbot
WORKDIR . /chatbot
RUN python chatbot.py
COPY . .
WORKDIR ./app
EXPOSE $PORT
CMD gunicorn --workers=4 --bind 0.0.0.0:$PORT app:app