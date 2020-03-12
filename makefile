init:
	docker volume create weatherapp_backend_node_modules
	docker volume create weatherapp_frontend_node_modules
modules:
	docker-compose -f docker-compose.dev-build.yml up
hotrun:
	docker-compose -f docker-compose.dev-run.yml up
containers:
	docker-compose up