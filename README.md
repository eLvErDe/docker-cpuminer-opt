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
