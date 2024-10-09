xhost +si:localuser:root

sudo docker build -t warthog_ps4 .

sudo docker run --runtime=nvidia --net=host --gpus all -ti --privileged --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix warthog_ps4