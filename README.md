# Run

```
$ bundle install --binstubs
$ bin/warble
$ java -jar stock-service.war
```


# Run locally on docker

```
$ docker build -t stock-service .
$ docker run --publish 8080:8080 -t stock-service java -jar stock-service.war
```

# Deploy on heroku


```
$ heroku login
$ heroku create
$ heroku plugins:install https://github.com/heroku/heroku-deploy
$ heroku deploy:jar --jar stock-service.war
```

