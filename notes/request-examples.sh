$ http http://k8s-traefik.info/pybackend
# HTTP/1.1 403 Forbidden
# ...
# {
#     "detail": "Not authenticated"
# }

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


$ http http://k8s-traefik.info/rbackend "Authorization: Bearer foobar"
# HTTP/1.1 200 OK
# ...
# {
#     "title": "R Backend API"
# }

$ echo '{"gre": 600, "rank": "1"}' \
  | http POST http://k8s-traefik.info/rbackend/admission "Authorization: Bearer foobar"
# HTTP/1.1 200 OK
# ...
# {
#     "result": true
# }

$ echo '{"gre": 600, "rank": "1"}' \
  | http POST http://k8s-traefik.info/pybackend/admission "Authorization: Bearer foobar"
# HTTP/1.1 200 OK
# ...
# {
#     "result": true
# }


while true; do echo '{"gre": 600, "rank": "1"}' \
  | http POST http://k8s-traefik.info/pybackend/admission "Authorization: Bearer foobar"; sleep 1; done