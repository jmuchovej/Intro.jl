# Intro.jl

An introduction to Julia, Gen.jl, and a few other machine-learning libraries.

## Setting up

- Clone (using `git`) or download (via the "Download ZIP" button under "Code")
  this repository.
- Make sure you have Docker installed locally. (However, if you have Julia
  1.6, then use the `Project.toml` file here.)
- Run the `setup.sh` script by opening a Terminal and running `./setup.sh`.
- Then you should use that same Terminal to run `docker-compose up`.
- Wait a few seconds for JupyterLab to start, then head over to port: `46876`
  (or [this link](http://localhost:46876/lab)).

### Installing Docker &amp; Docker Compose

**NOTE:** watch for OS-specific caveats.

- Follow along [Docker's "Getting Started" page][docker-get-started] until the
  "Docker Dashboard" heading. (For **Windows** and **MacOS** users, I recommend
  installing Docker Desktop.)
- Ensure that you have Git installed. [This guide should walk you through
  everything][git-started]. I recommend using the either pure `git` or the
  GitHub CLI for GitHub projects (like this one); however, GitHub Desktop is
  also a perfectly good solution.

#### Windows caveats
- In the past, you needed Windows 10 Pro / Education. I'm not sure if this
  requirement still stands. You may need to upgrade to these editions if Docker
  fails to start.

#### Linux caveats
- The Linux installation doesn't provide Docker Compose (a toolchain atop
  Docker). Follow [these steps][linux-compose] to install Docker Compose.
- To avoid using `sudo docker <blah>`, add yourself to the docker group using
  the following command: `sudo usermod -aG docker $(whoami)`.
- Linux must use `git` (or the GitHub CLI) through the command-line.

[docker-get-started]: https://docs.docker.com/get-started/
[git-started]: https://docs.github.com/en/github/getting-started-with-github/quickstart/set-up-git
[linux-compose]: https://docs.docker.com/compose/install/
