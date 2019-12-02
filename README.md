## Dynamic Routing and Centralized Auth with Traefik, Python and R Example

![](/notes/traefik-overview.png)

* Dynamic route configuration with [Traefik](https://docs.traefik.io/v1.7/)
* See [this post](https://jaehyeon.me/blog/2019-11-29-Dynamic-Routing-and-Centralized-Auth-with-Traefik-Python-and-R-Example) for more details

### Initialize Traefik

```bash
docker-compose up -d traefik
```

![](/notes/traefik-providers-01.png)

### Start other services

```bash
docker-compose up -d pybackend
```

![](/notes/traefik-providers-00.png)