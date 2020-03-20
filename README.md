# Weatherapp

_This copy holds my solutions to a selective list of tasks/exercises put forward by Eficode on their [Weatherapp][1] repo. Taking on the challenge sounded like a great learning activity to practice concepts like [containerization](#docker), [cloud infrastructure](#cloud) and automated deployments with [Ansible](#ansible). Hence, my solutions will be to the tasks related to these topics._

## Prerequisites

* Sign up/in to [OpenWeatherMap][2], and get an API key.
* Create a `.env` file in the root directory with the following information:
    ```
    APPID=<YOUR_OPENWEATHERMAP_API_KEY>
    ENDPOINT=http://0.0.0.0:9000/api
    ```

## Exercises

The app itself is a backend API that pulls weather data from [OpenWeatherMap][2] before serving it to a simple React frontend which displays a large current weather icon.

The challenge guidelines I am working with in my plan include a few exercises. The first is Docker containerization. Then, setting up the containerized app with a cloud service provider. Finally, a choice of either a CI/CD pipeline, or automated deployments with Ansible.

_The following sections will be updated as I continue going through the tasks._

### Docker

> _Docker containers are central to any modern development initiative. By knowing how to set up your application into containers and make them interact with each other, you have learned a highly useful skill._
> * Add __Dockerfile__-s in the _frontend_ and the _backend_ directories to run them virtually on any environment having [Docker][3] installed. It should work by saying e.g. `docker build -t weatherapp_backend . && docker run --rm -i -p 9000:9000 --name weatherapp_backend -t weatherapp_backend`. If it doesn't, remember to check your api key first.
> * Add a __docker-compose.yml__ -file connecting the frontend and the backend, enabling running the app in a connected set of containers.
> * The developers are still keen to run the app and its pipeline on their own computers. Share the development files for the container by using volumes, and make sure the containers are started with a command enabling hot reload.

The first two requirements were a straightforward Docker image-building and container-running implementation. The challenge is mainly the third point, where we need a development workflow that allows for hot reloads and utilizes shared volumes.

The implementation here involves the use of a lightweight __Node-13__ base image, two new [docker-compose][3] files, and a __Makefile__ to make things easier.
* `docker-compose.dev-build.yml` is used for setting up NPM modules for both, the backend and frontend, on their own external Docker volumes
* `docker-compose.dev-run.yml` is used for starting up the backend in debug mode, and the frontend in a hot reload development mode.

#### Usage
* Clone the repo and `cd weatherapp/`
* On first run, create the necessary Docker volumes with `make init`
* Run `docker volume ls` and you should see the two newly built volumes `weatherapp_backend_node_modules` and `weatherapp_frontend_node_modules`
* From now on, everytime the `packages.json` file is changed, run `make modules` to do the module installations and persist them on the shared modules volumes
* Otherwise, run `make hotrun` to start both sides of the app in a hot/live-reload mode
* When ready for deployment, run `make containers` or `docker-compose up` to build the images via the Dockerfile-s and run the containers
* Check if everything is OK, then kill the containers and push and/or deploy the `weatherapp_backend` and `weatherapp_frontend` images

___
___A Note regarding Node-13:___

_The app ran well on my local Node v13.8.0, but caused some errors within the the v13.10 Docker image. This is why I explicitly selected the `node:13.8.0-alpine3.11` image_
___

### Cloud

> _The biggest trend of recent times is developing, deploying and hosting your applications in cloud. Knowing cloud -related technologies is essential for modern IT specialists._
> * Set up the weather service in a free cloud hosting service, e.g. [AWS][5] or [Google Cloud][6].

_In progress... (I am considering what features this section can add to the Ansible section below)_

### Ansible

> _Automating deployment processes saves a lot of valuable time and reduces chances of costly errors. Infrastructure as Code removes manual steps and allows people to concentrate on core activities._
> * Write [Ansible][7] playbooks for installing [Docker][3] and the app itself.

The whole Ansible deployment workflow is available on the [`weatherapp-ansible`][8] repo


[1]: https://github.com/eficode/weatherapp
[2]: http://openweathermap.org
[3]: https://www.docker.com/
[4]: https://docs.docker.com/compose
[5]: https://aws.amazon.com/free
[6]: https://cloud.google.com/free
[7]: http://docs.ansible.com/ansible/intro.html
[8]: https://github.com/aihaddad/weatherapp-ansible