# vccw-share

It allows you to share your WordPress on the VCCW via ngrok + reverse proxy.

## How to install

SSH into Vagrant:

```
$ vagrant ssh
```

Install:

```
$ curl https://raw.githubusercontent.com/vccw-team/vccw-share/master/setup.sh | bash
```

## How to share

Run `vccw-share` command on your VCCW machine.

```
$ vccw-share
```

Then you can see the output like following.

```
ngrok by @inconshreveable                                                 (Ctrl+C to quit)

Session Status                online                                                      
Session Expires               7 hours, 59 minutes                                         
Version                       2.2.8                                                       
Region                        United States (us)                                          
Web Interface                 http://127.0.0.1:4041                                       
Forwarding                    http://xxxx.ngrok.io -> localhost:5000                  
Forwarding                    https://xxxx.ngrok.io -> localhost:5000                 

Connections                   ttl     opn     rt1     rt5     p50     p90                 
                              0       0       0.00    0.00    0.00    0.00
```

For this example, you can visit `https://xxxx.ngrok.io`.

To stop sharing, press `[Ctrl+C]`.

## Customizing

You can edit configuration file for the `ngrok` at `~/.ngrok2/ngrok.yml`.
See for more details on documentation for ngrok.

https://dashboard.ngrok.com/get-started

## How it works

1. `vccw-share` will launch a node based proxy server that waits request on port `5000`. The source code of this proxy server is contained in this repository.
2. This proxy server will replace all URLs in the contents from WordPress.
3. launch a `ngrok` to share port `5000`.

## Known problems

* You can't visit `wp-admin` from ngrok's URL. You should edit `wp-config.php`. But I guess that if you upload media from ngrok's URL, the URL of the media will have incorrect URL.
