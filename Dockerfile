FROM python:3.9-slim
WORKDIR /app
RUN echo "Flask==2.0.1\nWerkzeug==2.0.1" > requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN echo "from flask import Flask\napp = Flask(__name__)\n@app.route('/')\ndef hello(): return '<h1>HELLO, SUCCESS!</h1>'\nif __name__ == '__main__': app.run(host='0.0.0.0', port=5000)" > app.py
EXPOSE 5000
CMD ["python", "app.py"]
