#!/usr/bin/env sh

# Check if Java is installed
if ! which java > /dev/null 2>&1; then
    echo "Java not found. Installing Java..."
    sudo apt update
    sudo apt install -y default-jdk
else
    echo "Java is already installed."
fi

# Check for a valid server jar and rename it to server.jar
if [ ! -f server.jar ]; then
    for file in *.jar; do
        if echo "$file" | grep -i "paper\|minecraft\|fabric\|server"; then
            mv "$file" server.jar
            break
        fi
    done
fi

# Run Minecraft server with allocated memory and performance flags
java -Xms6144M -Xmx6144M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui
