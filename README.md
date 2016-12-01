# claroline-docker-compose

```
docker-compose up -d --build
docker-compose exec web php app/console claroline:user:create -a Jhon Doe admin pass admin@mydomain.com 
```
For the moment this line needs to be changed manualy to your URL before deploying
https://github.com/claroline/claroline-docker-compose/blob/master/prosody/config/prosody.cfg.lua#L42
