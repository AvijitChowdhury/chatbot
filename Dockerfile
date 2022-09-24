# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.8-slim



# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements


COPY requirements.txt .
RUN python -m pip install -r requirements.txt
RUN python -c "import nltk;nltk.download('omw-1.4');"
RUN python -c "import nltk;nltk.download('wordnet');"
RUN python -c "import nltk;nltk.download('punkt');"
WORKDIR /app
COPY . .

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers


# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug

CMD ["python","app.py"]
