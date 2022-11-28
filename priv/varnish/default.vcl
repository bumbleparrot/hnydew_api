# specify the VCL syntax version to use
vcl 4.1;

# import vmod_dynamic for better backend name resolution
import dynamic;

# we won't use any static backend, but Varnish still need a default one
backend api {
    .host = "nginx";
    .port = "8080";
}

# set up a dynamic director
# for more info, see https://github.com/nigoroll/libvmod-dynamic/blob/master/src/vmod_dynamic.vcc
sub vcl_init {
        new d = dynamic.director(port = "80");
}

sub vcl_recv {
	# force the host header to match the backend (not all backends need it,
	# but example.com does)
	set req.http.host = "nginx";
	# set the backend
	# set req.backend_hint = d.backend("nginx");
}

sub vcl_backend_response {

  # When errors above 500 occur it's generally caused by a backlog on the
  # backend server we use. In this case we return(retry), which due to the
  # round-robin directors or haproxy will try the next backend.

  # Don't cache 500 responses
    if (beresp.status == 500) {
        return(deliver);
    }

    if (beresp.http.Set-Cookie) {
      unset beresp.http.Set-Cookie;
    }

    # Add the response TTL for informational purposes
    set beresp.http.X-Varnish-TTL = beresp.ttl;

  set beresp.http.X-Served-By = beresp.backend.name;

  return(deliver);
}