# docker image for cpuminer-opt

This image build [cpuminer-opt] from GitHub at *RUNTIME*.
It means everytime the container starts, latest code is pulled from GitHub
and rebuilt with -march=native for maximum optimization.
`/root/start.sh` is a wrapper script in charge of building cpuminer-opt and
then passing all arguments to the cpuminer binary.

## Build images

```
git clone https://github.com/EarthLab-Luxembourg/docker-cpuminer-opt
cd docker-cpuminer-opt
docker build -t cpuminer-opt .
```

## Test it locally

```
docker run -it --rm cpuminer-opt /root/start.sh --help
```

If it works correctly, you'll see cpuminer building and then it's --help.


## Publish it somewhere

```
docker tag cpuminer-opt docker.domain.com/mining/cpuminer-opt
docker push docker.domain.com/mining/cpuminer-opt
```

## Use it with Mesos/Marathon

Edit `mesos_marathon.json` to replace ethermine.org by something else (not necessary), set your mining key and change application path as well as docker image address.
Then simply run (adapt application name here too):

```
curl -X PUT -u marathon\_username:marathon\_password --header 'Content-Type: application/json' "http://marathon.domain.com:8080/v2/apps/mining/cpuminer-opt?force=true" -d@./mesos\_marathon.json
```

[cpuminer-opt]: https://github.com/JayDDee/cpuminer-opt
[Mesos]: http://mesos.apache.org/documentation/latest/gpu-support/

## Example command lines

Myriadcoin (XMY) on miners-pool.eu (4 cores) (keep -p close to actual number of threads):
```
/root/start.sh --no-color -a yescrypt -o stratum+tcp://stratum.eu.miners-pool.eu:8428 -u <your_myriadcoin_address> -p 4 -t 4
```

Myriadcoin (XMY) on miningpoolhub.com
```
/root/start.sh --no-color -a yescrypt -o stratum+tcp://hub.miningpoolhub.com:20577 -u <login>.<worker_name> -t 4
```

Monero (XMR) on supportxmr.com (4 cores) with automatic payment to an exchange
```
/root/start.sh --no-color -a cryptonight -o stratum+tcp://pool.supportxmr.com:5555 -t 4 --api-bind 0.0.0.0:$PORT0 -u <address>.<payement_id> -p rig0:email@domain.com
```
