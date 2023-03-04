FROM python:3.10-slim-buster

RUN apt-get update && apt-get install -y curl
RUN python -m pip install --upgrade pip build

RUN curl -sSL https://install.python-poetry.org | python3 -

# Add poetry to PATH
ENV PATH "/root/.local/bin:$PATH"

RUN mkdir /opt/blog-search
WORKDIR /opt/blog-search

COPY ./blog_search_api ./
COPY pyproject.toml poetry.lock ./

RUN poetry config virtualenvs.create false

RUN poetry install

EXPOSE 5000
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]