# omp-docker

Run [Oh My Pi](https://github.com/can1357/oh-my-pi) (`omp`), a terminal-based AI coding agent, in a Docker container.

- `src/oh-my-pi/` — vendored Oh My Pi source with a multi-stage `Dockerfile` (Rust napi addon → Python wheel → runtime). The build compiles `pi-natives`, so the first build is slow.
- `bin/omp.bat` — launcher: runs the `omp` image against the current directory, with `data/` mounted as the container's `/root` (agent config, history, models).
- `build.bat` — builds the `omp` image.

## Prerequisites

- Docker (with the BuildKit buildx cache for the Rust stage)
- Windows batch scripts; on Linux/macOS use the equivalent `docker` commands below

## Build

```bat
build.bat
```

Equivalent manual command:

```sh
cd src/oh-my-pi
docker build -t omp .
```

## Run

Open a terminal in the project directory you want the agent to work in, then:

```bat
..\omp-docker\bin\omp.bat
```

or, manually:

```sh
docker run -v <omp-docker>/data:/root \
           -v "$PWD":/projects/<name> -w /projects/<name> \
           --rm omp
```

- The workspace (your current directory) is mounted at `/projects/<name>` inside the container — files the agent edits are written to the host directory.
- `data/` persists the agent home (`.omp/`: config, history, model cache) across runs. Delete it to reset the agent state.

## Updating

Re-fetch/update the source in `src/oh-my-pi/`, then re-run `build.bat` (cached stages make rebuilds much faster than the first).
