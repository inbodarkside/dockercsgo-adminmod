FROM ubuntu

MAINTAINER inbo 

# Prepare things
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y wget lib32gcc1


# Run as steam user
USER steam
 
# Make the directories and get the steam file
RUN mkdir /home/steamcmd &&\
cd /home/steamcmd &&\
wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
 tar -xvzf steamcmd_linux.tar.gz

# Running the steam automated install
RUN /steamcmd/steamcmd.sh +login anonymous +force_install_dir /steamcmd/csgoserver +app_update 740 validate +quit


# Make server port available to host
EXPOSE 27015

# This container will be executable
WORKDIR /home/steam/csgo
ENTRYPOINT ["./srcds_run"]

