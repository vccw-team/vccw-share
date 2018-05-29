var http = require('http'),
    httpProxy = require('http-proxy'),
    modifyResponse = require('http-proxy-response-rewrite'),
    execSync = require('child_process').execSync;

var origin = 'http://' + execSync('hostname -f').toString().trim();

var proxy = httpProxy.createProxyServer({
  target: origin,
  changeOrigin: true,
});

proxy.on('proxyRes', function (proxyRes, req, res) {
  if (proxyRes.headers['content-type'] && proxyRes.headers['content-type'].match(/text\/html/i)) {
    delete proxyRes.headers['content-length'];
    modifyResponse(res, proxyRes.headers['content-encoding'], function (body) {
      if (body) {
        body = body.replace(new RegExp(origin, 'ig'), '');
      }
      return body;
    });
  }
});

var server = http.createServer(function (req, res) {
  proxy.web(req, res);
}).listen(5000);
