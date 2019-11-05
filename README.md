* If running docker on linux, run `sudo chown -R $USER:$USER .` first.

## Build App
`docker-compose build`

## Start App
`docker-compose up`

## Create DB
`docker-compose run web rake db:create`

## Run Test Suite
With live app started, `docker-compose run web bundle exec rspec`

## Kill App
`docker-compose down`

## Insert Record
### TODO

## Retrieve Records
### TODO