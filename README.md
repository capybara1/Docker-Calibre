# Calibre on Docker

The docker image `capybara1/calibre` provides a full installation of calibre on alipine linux.
However, since it is a headless installation, the main intend is to use it as
[content server](https://manual.calibre-ebook.com/server.html).

An example for a `docker-compose` project can be found [here](./docker-compose.yml).

The following environment variables may be used to define username and password of an initial user:

| Variable | Default |
|----------|---------|
| USERNAME | default |
| PASSWORD | default |
