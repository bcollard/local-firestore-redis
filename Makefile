export REDIS_HOST=localhost
export REDIS_PORT=6379

.ONESHELL:
.PHONY: deploy call-local-get-claps dev call-get-claps notes local-firestore
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


local-firestore: ## run a local firestore
	firebase emulators:start --only firestore --import firestore-dump-personal-218506/2020-05-03T21:43:11_41000

start-local-redis: ## run a local redis store (docker)
	docker run -d -p 6379:6379 --name redis-rate-limiter redis

stop-local-redis: ## stop the local redis (docker)
	docker stop redis-rate-limiter

rm-local-redis: ## rm the local redis (docker)
	docker rm redis-rate-limiter

