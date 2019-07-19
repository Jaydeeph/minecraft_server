#!/bin/sh

RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
DEFAULT="\e[39m"
userinput="0"

server_version_link

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
                echo -e "${CYAN} Installing and downloading updates, needed packages${DEFAULT}"
                install_updates_packages()
                echo -e "${GREEN} Finished gettings updates. ${DEFAULT}"
                ;;
            2)
                echo -e "${CYAN} Installing minecraft server...${DEFAULT}"
                install_minecraft()
                echo -e "${GREEN} Finished installing minecraft server. ${DEFAULT}"
                ;;
            3)
                echo -e "${CYAN} Starting minecraft server...${DEFAULT}"
                start_minecraft()
                echo -e "${GREEN} Minecraft server started. ${DEFAULT}"
                ;;
            4)
                enable_minecraft_startup
                echo -e "${GREEN} Minecraft enabled on startup. ${DEFAULT}"
                ;;
            5)
                disable_minecraft_startup
                echo -e "${GREEN} Minecraft disabled on startup ${DEFAULT}"
                ;;
            6)
                delete_minecraft
                echo -e "${GREEN} Deleted Minecraft. ${DEFAULT}"
                ;;
            7)
                echo -e "${GREEN} Cya."
                exit ;;
        esac
done

install_updates_packages() {
    sudo apt update && sudo apt upgrade
}

select_minecraft_version() {
    echo -e "Whata server version would you like to download?"
    echo -e "1) 1.14.3"
    echo -e "2) 1.14.2"
    echo -e "3) 1.14.1"
    echo -e "4) 1.14"
    echo -e "5) 1.13.2"
    echo -e "6) 1.13.1"
    echo -e "7) 1.13"
    echo -e "8) 1.12.2"
    echo -e "9) 1.12.1"
    echo -e "10) 1.12"
    echo -e "11) 1.11.2"
    echo -e "12) 1.11.1"
    echo -e "13) 1.11"
    echo -e "14) 1.10.2"
    echo -e "15) 1.10.1"
    echo -e "16) 1.10"

    read userinput_version

    case $userinput_version in
        1) server_version_link="https://launcher.mojang.com/v1/objects/d0d0fe2b1dc6ab4c65554cb734270872b72dadd6/server.jar" ;;
        2) server_version_link="https://launcher.mojang.com/v1/objects/808be3869e2ca6b62378f9f4b33c946621620019/server.jar" ;;
        3) server_version_link="https://launcher.mojang.com/v1/objects/ed76d597a44c5266be2a7fcd77a8270f1f0bc118/server.jar" ;;
        4) server_version_link="https://launcher.mojang.com/v1/objects/f1a0073671057f01aa843443fef34330281333ce/server.jar" ;;
        5) server_version_link="https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar" ;;
        6) server_version_link="https://launcher.mojang.com/v1/objects/fe123682e9cb30031eae351764f653500b7396c9/server.jar" ;;
        7) server_version_link="https://launcher.mojang.com/v1/objects/d0caafb8438ebd206f99930cfaecfa6c9a13dca0/server.jar" ;;
        8) server_version_link="https://launcher.mojang.com/v1/objects/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar" ;;
        9) server_version_link="https://launcher.mojang.com/v1/objects/561c7b2d54bae80cc06b05d950633a9ac95da816/server.jar" ;;
        10) server_version_link="https://launcher.mojang.com/v1/objects/8494e844e911ea0d63878f64da9dcc21f53a3463/server.jar" ;;
        11) server_version_link="https://launcher.mojang.com/v1/objects/f00c294a1576e03fddcac777c3cf4c7d404c4ba4/server.jar" ;;
        12) server_version_link="https://launcher.mojang.com/v1/objects/1f97bd101e508d7b52b3d6a7879223b000b5eba0/server.jar" ;;
        13) server_version_link="https://launcher.mojang.com/v1/objects/48820c84cb1ed502cb5b2fe23b8153d5e4fa61c0/server.jar" ;;
        14) server_version_link="https://launcher.mojang.com/v1/objects/3d501b23df53c548254f5e3f66492d178a48db63/server.jar" ;;
        15) server_version_link="https://launcher.mojang.com/v1/objects/cb4c6f9f51a845b09a8861cdbe0eea3ff6996dee/server.jar" ;;
        16) server_version_link="https://launcher.mojang.com/v1/objects/a96617ffdf5dabbb718ab11a9a68e50545fc5bee/server.jar" ;;
    esac

}

install_minecraft() {

    sudo cp ./minecraft.service /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo apt-get install default-jre -y
    sudo curl -O $server_version_link
    sudo mkdir minecraft
    sudo mv server.jar minecraft/
    sudo mv minecraft/ /home/$(whoami)
    sudo java -jar server.jar
    sudo sed -i 's/eula=false/eula=true/g' eula.txt
}

add_custom_seed() {

}

start_minecraft() {
    sudo systemctl start minecraft
}

enable_minecraft_startup() {
    sudo systemctl enable minecraft
}

disable_minecraft_startup() {
    sudo systemctl disable minecraft
}

delete_minecraft() {
    sudo systemctl disable minecraft
    sudo systemctl stop minecraft
    sudo rm -fR minecraft
    sudo rm -fR /etc/systemd/minecraft.service
}