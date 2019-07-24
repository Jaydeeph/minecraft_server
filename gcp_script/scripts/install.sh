#!/bin/sh

RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
DEFAULT="\e[39m"
userinput="0"

minecraft_forge_version_link="https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2768/forge-1.12.2-14.23.5.2768-installer.jar"
minecraft_forge_filename="forge-1.12.2-14.23.5.2768-universal.jar"
minecraft_seed="-8631165658496819045"


echo -e "${CYAN} Installing and downloading updates, needed packages. ${DEFAULT}"
echo -e "${CYAN} Installing update and upgrade. ${DEFAULT}"
sudo apt-get update -y
sudo apt-get upgrade -y

echo -e "${CYAN} Installing openjdk-8-jre-headless. ${DEFAULT}"
sudo apt install -y openjdk-8-jre-headless

echo -e "${CYAN} Installing openjdk-8-jdk ${DEFAULT}"
sudo apt install -y openjdk-8-jdk-headless

echo -e "${CYAN} Installing curl. ${DEFAULT}"
sudo apt install -y curl
echo -e "${GREEN} Finished gettings updates. ${DEFAULT}"


echo -e "${CYAN} Installing minecraft server...${DEFAULT}"

echo -e "${CYAN} Installing minecraft.service ${DEFAULT}"
sudo cp ~/minecraft.service /etc/systemd/system/
sudo systemctl daemon-reload

echo -e "${CYAN} Downloading minecraft forge. ${DEFAULT}"
cd ./minecraft-server/
sudo curl -o forge.jar $minecraft_forge_version_link

echo -e "${CYAN} Installing forge.jar ${DEFAULT}"
sudo java -jar forge.jar --installServer

echo -e "${CYAN} Removing forge.jar ${DEFAULT}"
sudo rm -fR forge.jar

echo -e "${CYAN} Starting server for the first time $minecraft_forge_filename ${DEFAULT}"
sudo java -Xms1024M -Xmx2048M -jar $minecraft_forge_filename nogui

echo -e "${CYAN} Editing EULA.TXT. ${DEFAULT}"
sudo sed -i 's/eula=false/eula=true/g' eula.txt

echo -e "${CYAN} Changing minecraft server seed. ${DEFAULT}"
sudo systemctl start minecraft
sleep 20
sudo systemctl stop minecraft
sudo sed -i 's/level-seed=/level-seed=-8631165658496819045/g' server.properties
sudo sed -i 's/level-name=world/level-name=Jays-World/g' server.properties
sudo sed -i 's/view-distance=10/view-distance=20/g' server.properties
echo -e "${GREEN} Finished installing minecraft server. ${DEFAULT}"

echo -e "${CYAN} Starting minecraft server...${DEFAULT}"
sudo systemctl start minecraft
echo -e "${GREEN} Minecraft server started. ${DEFAULT}"