FROM ubuntu

MAINTAINER inbo 

# Prepare things
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y wget lib32gcc1

 
# Make the directories and get the steam file
RUN mkdir /home/steamcmd &&\
cd /home/steamcmd &&\
wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
 tar -xvzf steamcmd_linux.tar.gz

# Running the steam automated install
RUN /steamcmd/steamcmd.sh +login anonymous +force_install_dir /steamcmd/csgoserver +app_update 740 validate +quit

# To do: get the mirror.pointysoftware.net/alliedmodders/mmsource-1.10.4-linux.tar.gz
#to do : get the http://sourcemod.gameconnect.net/files/sourcemod-1.7.0-linux.tar.gz

# Make server port available to host
EXPOSE 27015

# This container will be executable
WORKDIR /steamcmd
ENTRYPOINT ["./srcds_run"]
# ./srcds_run -game csgo -console -usercon +game_type 0 +game_mode 0 +mapgroup mg_bomb +map de_dust

