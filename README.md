# projektowanie-vapor
Music related Data Base


In order to run program on docker container, it is needed to run command:

$ vapor run serve --hostname 0.0.0.0
If there was exposure on 11225 for 8080 port in docker run commands (-p 11225:8080)
for instance docker run -it -u root -v /home/zuz/Pulpit/ProjObj:/home/kprzystalski/data/ -p 11223:8000 -p 11224:38351 -p 11225:8080 -p 11226:5000 kprzystalski/projobj2:latest /bin/bash
Then app will be exposed on 11225 port:

http://0.0.0.0:11225/artists

http://0.0.0.0:11225/songs

http://0.0.0.0:11225/studios


In order to create song in DB, there needs to be valid artist ID used.
