https://rogerwelin.github.io/traefik/reverse/proxy/micro/services/2018/09/17/traefik-tutorial.html
https://rogerwelin.github.io/traefik/api/go/auth/2019/08/19/build-external-api-with-trafik-go.html
https://sysadmins.co.za/integrating-google-oauth-with-traefik/
https://docs.traefik.io/v1.7/configuration/backends/docker/


http http://localhost/pybackend "Authorization: Bearer foobar"



$ http http://k8s-traefik.info/pybackend "Authorization: Bearer foo"
# HTTP/1.1 401 Unauthorized
# ...
# {
#     "detail": "Invalid Token"
# }

$ http http://k8s-traefik.info/pybackend "Authorization: Bearer foobar"
# HTTP/1.1 200 OK
# ...
# {
#     "title": "Python Backend API"
# }

$ http http://k8s-traefik.info/pybackend/foobar "Authorization: Bearer foobar"
# HTTP/1.1 200 OK
# ...
# {
#     "path": "foobar",
#     "title": "Python Backend API"
# }


http http://k8s-traefik.info/rbackend/whoami

http http://k8s-traefik.info/rbackend/whoami?foo=bar

echo '{"foo": "bar"}' \
  | http POST http://k8s-traefik.info/rbackend/whoami