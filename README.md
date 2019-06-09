# SUBURI8-ruby

- ruby2.5.1
- golang1.10.3~8

## Setup

### mariadb

```sh
$ docker-compose up --no-start
$ docker-compose start
$ ./db/init.sh
```

### ruby

```sh
$ gem install bundler -v 1.16.4
$ bundle install --path vendor/bundle
```

### bench

```sh
$ cd bench
$ make deps
$ make
```

## Run

```sh
$ docker-compose start
$ ./run_local.sh
# Access localhost:8080
```

## Bench

```sh
$ cd bench
$ ./bin/bench
```

### Retry

```sh
$ ./db/init.sh
$ cd bench
$ ./bin/bench
```

## Cleanup

```sh
$ docker-compose down -v
```
