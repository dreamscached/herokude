# HerokuDE

This project is an attempt to run a (more or less) fully-featured desktop
environment in Heroku to be able to run applications in it.

Note however, even though this image was designed to work on Heroku, it also
works as standalone Docker image that you can run locally yourself.

## How does it work

Since Heroku [allows deployment of Docker images](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#heroku-yml-overview),
one could create an image with minimal window manager, VNC server
software and NoVNC as a way to use VNC in browser (due to Heroku restricting
open ports to HTTP/HTTPS only.)

Here, the following components are used:

* Xvfb for virtual display initialization
* Fluxbox as window manager
* X11VNC as VNC server


## Things to note

This project is *an experiment, Proof-of-Concept* only intended to show that the
implementation of an idea described above is possible. By using this project
you may or may not be violating Heroku Terms of Service, and creators, contributors
or maintainers of this repository are not liable for any sort of damage dealt
as result of usage of this repository.

Besides, using this image on Free dynos is troublesome due to soft memory
limitations that let dyno stay up for a while even with quota exceeded, which
may lead to unexpected process kills.


## Usage

**NOTE:** This repository has three different branches with different 'presets' for deployment:
* [`master`](https://github.com/dreamscached/herokude/tree/master) is a completely blank template with just WM installed
* [`minimal`](https://github.com/dreamscached/herokude/tree/minimal) provides minimal viable desktop environment with browser, file manager, etc.
* [`xterm`](https://github.com/dreamscached/herokude/tree/xterm) provides ultra-minimal desktop environment with only `xterm` installed atop of WM

### Deploying to Heroku

#### With Heroku CLI

```shell
$ heroku container:push -a <app-name> web
$ heroku container:release -a <app-name> web
```


#### With Heroku template

| Blank (only WM)                 | Minimal (minimal DE)            | XTerm (WM + XTerm)              |
|---------------------------------|---------------------------------|---------------------------------|
| [![Heroku Deploy button][1]][2] | [![Heroku Deploy button][1]][3] | [![Heroku Deploy button][1]][4] |

[1]: https://www.herokucdn.com/deploy/button.svg
[2]: https://heroku.com/deploy?template=https://github.com/dreamscached/herokude/tree/master
[3]: https://heroku.com/deploy?template=https://github.com/dreamscached/herokude/tree/minimal
[4]: https://heroku.com/deploy?template=https://github.com/dreamscached/herokude/tree/xterm


### Running locally

```shell
$ git clone https://github.com/dreamscached/herokude HerokuDE
$ docker build --rm -t herokude:ubuntu20.04 .
$ docker run --rm -d --name herokude -e PORT=80 -p 80:80 herokude:ubuntu20.04
```


## Configuration

Image has few environment variables you can use to somehow customize your
instance.

| Variable    | Default value        | Description                                                              |
|-------------|----------------------|--------------------------------------------------------------------------|
| GEOMETRY    | 1920x1080x16         | Defines screen geometry in format WIDTHxHEIGHTxDEPTH                     |
| PORT        | 8080                 | Defines port that NoVNC will listen to                                   |
| COMMANDLINE | bash /data/launch.sh | Defines command line to run upon initial setup of window manager and VNC |
| PASSWORD    | herokude             | Defines password used to log in VNC session                              |
