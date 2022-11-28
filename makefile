# Makefile

all: 
	@echo "We are building all containers and then running them via docker-compose"
	@$(MAKE) clean
	@$(MAKE) build-containers
	@$(MAKE) compose-containers

local:
	@echo "We are building all containers and then running them via docker-compose"
	@echo "The pheonix instance will be local so you can debug."
	@$(MAKE) clean
	@$(MAKE) build-containers-local
	@$(MAKE) compose-containers-local
	@$(MAKE) run-local-phoenix


build-containers:
	@echo "Build all the containers in sequence."
	@$(MAKE) postgres
	@$(MAKE) phoenix
	@$(MAKE) nginx
	@$(MAKE) varnish

build-containers-local:
	@echo "Build just the needed local containers for phoenix dev."
	@$(MAKE) postgres

compose-containers:
	docker-compose --profile all-containers -f docker-compose.yml up -d

compose-containers-local:
	DOCKER_COMPOSE_NETWORK=default docker-compose --profile local-dev -f docker-compose.yml up -d

run-local-phoenix:
# Ensure the local instance of the phoneix serve is killed before starting a new one.
	@$(MAKE) stop-phoenix-server
	mix ecto.create
	mix ecto.migrate
	iex -S mix phx.server

postgres:
	@echo "We are building the postgres container."
	docker build -t postgres -f dockerfile-postgres .

phoenix:
	@echo "We are building the phoenix elixir container."
	docker build -t phoenix -f dockerfile-phoenix .

nginx:
	@echo "We are building the nginx container."
	docker build -t nginx -f dockerfile-nginx .

varnish:
	@echo "We are building the varnish container."
	docker build -t varnish -f dockerfile-varnish .

clean:
	@echo "Bring docker down and delete all docker images in prep for new build."
	docker-compose down --rmi local
	docker image prune -f

stop-phoenix-server:
	lsof -i tcp:4000 | awk 'FNR == 2 {print $$2}' | xargs kill