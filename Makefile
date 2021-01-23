.PHONY: list

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

up-build:
	docker-compose up -d && sleep 5
	docker-compose exec app composer install
	docker-compose exec app npm install
	docker-compose exec app chmod 777 -R bootstrap/cache
	docker-compose exec app chmod 777 -R storage
	$(MAKE) cache

up:
	docker-compose up -d && sleep 5
	$(MAKE) cache

down:
	docker-compose stop

clean:
	$(MAKE) down
	docker-compose rm -fv

npm-install:
	docker-compose exec app npm install
	$(MAKE) cache

cache:
	docker-compose exec app php artisan cache:clear
	docker-compose exec app php artisan view:clear
	docker-compose exec app php artisan route:clear
	docker-compose exec app php artisan config:clear

npm:
	docker-compose exec app npm run watch

ssh:
	docker-compose exec app bash
