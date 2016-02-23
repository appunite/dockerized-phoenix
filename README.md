## Dockerized-Phoenix: Alpine-based, Phoenix-ready, Docker-image

This is an [Alpine Linux]-based image, containing the following:

- erlang
  - erlang-asn1
  - erlang-crypto
  - erlang-dev
  - erlang-erl-interface
  - erlang-eunit
  - erlang-inets
  - erlang-parsetools
  - erlang-public-key
  - erlang-sasl
  - erlang-ssl
  - erlang-syntax-tools
- elixir
- nodejs

The images include the latest versions (at build-time) of Erlang and NodeJS, are available on [Docker Hub], and weigh around 85mb.


#### Docker Image

To pull down the latest image, run:

```sh
docker pull meskyanichi/phoenix
```

You can optionally specify the Elixir version using [Docker Tags]:

```sh
docker pull meskyanichi/phoenix:ELIXIR_VERSION
```

Where `ELIXIR_VERSION` is the actual version number (i.e. `1.2.3`). 


#### Docker Commands

```sh
docker run --rm -v $(pwd):/app -w /app -ti meskyanichi/phoenix [command]
```

If no command is provided, it'll open a shell (`/bin/sh`). Provide a command to invoke it directly, for example:

```sh
docker run --rm -v $(pwd):/app -w /app -ti meskyanichi/phoenix mix phoenix.new my_new_app
```


#### Extending Docker Image

If you need to extend this image you can easily do so by creating your own `Dockerfile`. For example, if your program depends on PostgreSQL, you'll need to install the PostgreSQL client like so:

```Dockerfile
FROM meskyanichi/phoenix:latest
RUN apk --update add postgresql-client && rm -rf /var/cache/apk/*
```


#### Author / License

Released under the [MIT License] by [Michael van Rooijen].


[Docker Tags]: https://hub.docker.com/r/meskyanichi/phoenix/tags/
[Docker Hub]: https://hub.docker.com/r/meskyanichi/phoenix/
[Phoenix]: http://www.phoenixframework.org
[Alpine Linux]: http://www.alpinelinux.org
[MIT License]: https://github.com/meskyanichi/dockerized-phoenix/blob/master/LICENSE
[Michael van Rooijen]: https://twitter.com/meskyanichi
