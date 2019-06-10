# SUBURI8-ruby

- ruby2.5.1
- golang1.10.3~8

## Setup

### mariadb

```sh
# Use docker
$ docker-compose up --no-start
$ docker-compose start
$ ./db/init.sh

# Use Native
$ MYSQL_HOME=$PWD/docker/mariadb mysql.server start
$ ./db/init-user.sh
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
# Use docker
$ docker-compose start

# Use all
$ ./run_local.sh
# Access localhost:8080
```

## Bench

```sh
$ cd bench
$ ./bin._OS_/bench
```

### Retry

```sh
$ ./db/init.sh
$ cd bench
$ ./bin._OS_/bench
```

## Cleanup

```sh
# Use docker
$ docker-compose down -v

# Use Native
mysql.server stop
```
