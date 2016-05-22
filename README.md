### Dockerized-Phoenix: Alpine-based, Phoenix-ready, Docker images

[Alpine Linux]-based images, containing the following:

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

These images include the latest versions (at build-time) of Phoenix, Erlang and NodeJS. The Elixir version can be specified using [Docker Tags].

The included Phoenix version is useful when starting new Phoenix projects. You aren't, however, required to use the preinstalled version. If a newer version of Phoenix is available, you can install- and use that instead.


#### Docker Commands

Run any command like so:

```sh
docker run --rm -v $(pwd):/cwd -ti meskyanichi/phoenix [command]
```

*When leaving out the command, it'll default to `/bin/sh`.*

To generate a new Phoenix project, execute the following command:

```sh
docker run --rm -v $(pwd):/cwd -ti meskyanichi/phoenix mix phoenix.new my_new_app
```

If you want to use a version of Phoenix newer than the one provided in this image, you can install it manually prior to generating a new project:

```sh
docker run --rm -v $(pwd):/cwd -ti meskyanichi/phoenix
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
mix phoenix.new my_new_app
```

When working on an existing project, simply use `mix deps.get` to pull in all dependencies, including the Phoenix version that your application is using.


#### Extending Docker Image

If you need to extend this image you can easily do so by creating your own `Dockerfile`. For example, if your program depends on PostgreSQL, you'll need to install the PostgreSQL client like so:

```Dockerfile
FROM meskyanichi/phoenix:latest
RUN apk --no-cache add postgresql-client 
```


#### Development Environment

Use [Docker Compose] to setup a development environment. Here's a typical Phoenix configuration:

Add `docker-compose.yml`:

```yml
web:
  build: .
  dockerfile: Dockerfile.local
  command: mix phoenix.server
  ports:
    - 4000:4000
  volumes:
    - .:/cwd
  links:
    - db

db:
  image: postgres
```

Add `Dockerfile.local`:

```Dockerfile
FROM meskyanichi/phoenix
RUN apk --no-cache add postgresql-client 
```

Update `config/dev.exs` and `config/test.exs` and change the Repo's `hostname` from `localhost` to `db`, which'll resolve to the private ip associated with the linked `db`.

Then, before anything else, install the deps and create the database:

```sh
docker-compose run web mix deps.get
docker-compose run web mix ecto.create
```

Run tests with:

```sh
docker-compose run web mix test
```

Boot the stack with:

```sh
docker-compose up
```

Whenever you make changes to `Dockerfile.local` you'll have rebuild using:

```sh
docker-compose build
```

If using [Docker] in production, create a separate `Dockerfile`.


#### Author / License

Released under the [MIT License] by [Michael van Rooijen].


[Docker]: https://www.docker.com/
[Docker Compose]: https://docs.docker.com/compose/
[Docker Tags]: https://hub.docker.com/r/meskyanichi/phoenix/tags/
[Phoenix]: http://www.phoenixframework.org
[Alpine Linux]: http://www.alpinelinux.org
[MIT License]: https://github.com/mrrooijen/dockerized-phoenix/blob/master/LICENSE
[Michael van Rooijen]: https://twitter.com/mrrooijen
