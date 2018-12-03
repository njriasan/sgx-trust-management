## Summary

We are running the sgx-trust-management for remote attestation from IBM in a docker container. All steps are run in the same docker container but this will be removed pending some port forwarding change. We are also running in simulation mode because I am issue #49576 in the process of getting regestered to run applications in hardware mode.

## Setup

(Note all docker commands on the server require prepending sudo. For best practice we should change this.)

This should already have been done in njriasan on the server. If you reach problems in running a later step try redoing this.

```
git clone https://github.com/njriasan/sgx-trust-management.git

cd cwd/sgx-trust-management

docker build -t njriasan/trust-demo-image .
```

If the container is not already running, you *may* need to do this step.

```
docker run -d --device /dev/isgx --device /dev/mei0 --name sgx-trust-demo-1 njriasan/trust-demo-image
```

## Launching Docker

You will always have to do these steps.
(Reminder docker commands need sudo right now.)

You will need 3 separate connections to the server (either 3 connections or by using t-mux). Run these in order in each terminal

### Terminal 1:

```
docker exec -t -i sgx-trust-demo-1 bash

./sgx-trust/service-provider/truce_server
```

### Terminal 2:

```
docker exec -t -i sgx-trust-demo-1 bash

cd sgx-trust/application/

./launch.sh
```

### Terminal 3:

```
docker exec -t -i sgx-trust-demo-1 bash

cd sgx-trust/client

./launch.sh
```

(Note this will send each person's name to the enclave via the truce server. By default we have simulated user's who know the contents and those who don't. Those who don't reject sending the secret.)

## Future Work

- Run in hardware mode (waiting on intel)

- Separate the docker into two containers (1 for server and 1 for client)

- Run the client remotely and connect to the server (may need to do some configuration or route over ssh)

## Possible Problems

Hash of file has changed before. I think I editted it but currently I just print it to update. I should figure out the exact hashing process and add a step to do that before runtime.

We run everything in the same docker container to avoid any port issues. I was having some trouble trying to run part of it in docker and part of it from outside. It should be possible to forward the ports from docker and run the client from your local computer but I haven't gotten it to work. I may have to route it over ssh or at least make changes to the server.

