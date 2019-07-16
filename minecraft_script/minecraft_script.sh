#!/bin/sh

RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
DEFAULT="\e[39m"

userinput="0"

while [ "$userinput" != "7" ]
do
    echo -e "${GREEN} What would you like to do? ${DEFAULT}"
    echo -e "${CYAN} 1) Update and Upgrade ${DEFAULT}"
	echo -e "${CYAN} 2) Download Minecraft Server ${DEFAULT}"
	echo -e "${CYAN} 3) Start Minecraft Server ${DEFAULT}"
    echo -e "${CYAN} 4) Enable Minecraft On System Start up ${DEFAULT}"
    echo -e "${CYAN} 5) Disable Minecraft On System Start up ${DEFAULT}"
    echo -e "${CYAN} 6) Delete Minecraft ${DEFAULT}"
    echo -e "${RED} 7) Exit ${DEFAULT}"

        read userinput

        case $userinput in

            1)
                sudo apt update && sudo apt upgrade
                echo -e "${GREEN} Finished gettings updates. ${DEFAULT}"
                ;;
            2)
                sudo cp ./minecraft.service /etc/systemd/system/
                sudo systemctl daemon-reload
                sudo apt-get install default-jre -y
                sudo curl -O https://launcher.mojang.com/v1/objects/d0d0fe2b1dc6ab4c65554cb734270872b72dadd6/server.jar
                sudo mkdir minecraft
                sudo mv server.jar minecraft/
                sudo mv minecraft/ /home/$(whoami)
                sudo java -jar server.jar
                sudo sed -i 's/eula=false/eula=true/g' eula.txt
                echo -e "${GREEN} Finished installing minecraft server. ${DEFAULT}"
                ;;
            3)
                sudo systemctl start minecraft
                echo -e "${GREEN} Minecraft server started. ${DEFAULT}"
                ;;
            4)
                sudo systemctl enable minecraft
                echo -e "${GREEN} Minecraft enabled on startup. ${DEFAULT}"
                ;;
            5)
                sudo systemctl disable minecraft
                echo -e "${GREEN} Minecraft disabled on startup ${DEFAULT}"
                ;;
            6)
                sudo systemctl disable minecraft
                sudo systemctl stop minecraft
                sudo rm -fR minecraft
                sudo rm -fR /etc/systemd/minecraft.service
                echo -e "${GREEN} Deleted Minecraft. ${DEFAULT}"
                ;;
            7)
                echo -e "${GREEN} Cya."
                exit ;;
        esac
done
