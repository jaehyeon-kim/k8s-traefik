### Local domain names

Add an IP and domain to `hosts` file as _admin/root_.

For example,

```bash
172.17.120.149    k8s-traefik.info
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