### Local domain names

Add an IP and domain to `hosts` file as _admin/root_.

For example,

```bash
172.17.120.149    k8s-traefik.info
```

If in the same location,

```bash
0.0.0.0         k8s-traefik.info
```

`hosts` file location

* Windows - `%WINDIR%\System32\drivers\etc\hosts` or `C:\Windows\System32\drivers\etc\hosts`
* Linux - `/etc/hosts`

Note that a custom domain including the following is refused.

```bash
.dev
.localhost
.test
.example
.app
```

### Certificates for localhost

* [Certificates for localhost](https://letsencrypt.org/docs/certificates-for-localhost/)
* [jsha/minica](https://github.com/jsha/minica)
* [Local HTTPS development in Python with Mkcert](https://woile.github.io/posts/local-https-development-in-python-with-mkcert/)

### Traefik resources

* [Traefik tutorial - dynamic routing for microservices](https://rogerwelin.github.io/traefik/reverse/proxy/micro/services/2018/09/17/traefik-tutorial.html)
* [https://rogerwelin.github.io/traefik/api/go/auth/2019/08/19/build-external-api-with-trafik-go.html](https://rogerwelin.github.io/traefik/api/go/auth/2019/08/19/build-external-api-with-trafik-go.html)
* [Integrating Google OAuth with Traefik](https://sysadmins.co.za/integrating-google-oauth-with-traefik/)
* [Traefik 1.7 - Docker Provider](https://docs.traefik.io/v1.7/configuration/backends/docker/)


### Containo blog
* [Traefik 2.0 - The Wait Is Over!](https://blog.containo.us/traefik-2-0-6531ec5196c2)
* [Traefik 2.0 & Docker 101 - Tips & Tricks the Documentation Doesn’t Tell You](https://blog.containo.us/traefik-2-0-docker-101-fc2893944b9d)
* [Traefik 2 & TLS 101 - HTTPS (& TCP over TLS) for everyone!](https://blog.containo.us/traefik-2-tls-101-23b4fbee81f1)