# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.8-slim



# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
RUN mkdir /app
WORKDIR /app
COPY . .
RUN python -m pip install --upgrade pip 

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN python -c "import nltk;nltk.download('omw-1.4');"
RUN python -c "import nltk;nltk.download('wordnet');"
RUN python -c "import nltk;nltk.download('punkt');"


# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers


# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug

CMD exec gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 --timeout 0 app:app
