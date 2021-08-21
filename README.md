# Docker image for `yamllint`


Alpine-based dockerized version of [yamllint](https://github.com/adrienverge/yamllint).


## Documentation

https://yamllint.readthedocs.io/


## Available Docker image versions

| Docker tag | Build from |
|------------|------------|
| `latest`   | Latest stable yamllint version    |
| `1.26`     | Latest `v1.26.x` yamllint version |
| `1.25`     | Latest `v1.25.x` yamllint version |
| `1.24`     | Latest `v1.24.x` yamllint version |
| `1.23`     | Latest `v1.23.x` yamllint version |
| `1.22`     | Latest `v1.22.x` yamllint version |
| `1.21`     | Latest `v1.21.x` yamllint version |
| `1.20`     | Latest `v1.20.x` yamllint version |


## Docker mounts path

The working directory inside the Docker container is **`/opt/data/`** and should be mounted locally to
the root of your project where your `.yamllint` file is located.

## Usage

### GitLab CI
```yaml
stages:
 - lint

lint-yaml:
  stage: lint
  image:
    name: romanbergman/docker-yamllint
    entrypoint: ["/bin/ash", "-c"]
  script:
    - yamllint -f colored .
```