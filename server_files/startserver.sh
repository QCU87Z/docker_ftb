#!/bin/bash
set -euo pipefail

# check for serverstarter jar
if [[ -f serverstarter-2.0.1.jar ]]; then
    echo "Skipping download. Using existing serverstarter-2.0.1.jar"
    java -jar serverstarter-2.0.1.jar
    exit 0
else
    # download missing serverstarter jar
    URL="https://github.com/AllTheMods/alltheservers/releases/download/2.0.1/serverstarter-2.0.1.jar"

    if command -v wget &> /dev/null; then
        echo "DEBUG: (wget) Downloading ${URL}"
        wget -O serverstarter-2.0.1.jar "${URL}"
    elif command -v curl &> /dev/null; then
        echo "DEBUG: (curl) Downloading ${URL}"
        curl -o serverstarter-2.0.1.jar "${URL}"
    else
        echo "Neither wget or curl were found on your system. Please install one and try again"
        exit 1
    fi
fi

# java -jar serverstarter-2.0.1.jar
java -Xmx"8G" \
          -Xms"4G" \
          -XX:+UseG1GC \
          -XX:+ParallelRefProcEnabled \
          -XX:MaxGCPauseMillis=200 \
          -XX:+UnlockExperimentalVMOptions \
          -XX:+DisableExplicitGC \
          -XX:-OmitStackTraceInFastThrow \
          -XX:+AlwaysPreTouch \
          -XX:G1NewSizePercent=30 \
          -XX:G1MaxNewSizePercent=40 \
          -XX:G1HeapRegionSize=8M \
          -XX:G1ReservePercent=20 \
          -XX:G1HeapWastePercent=5 \
          -XX:G1MixedGCCountTarget=8 \
          -XX:InitiatingHeapOccupancyPercent=15 \
          -XX:G1MixedGCLiveThresholdPercent=90 \
          -XX:G1RSetUpdatingPauseTimePercent=5 \
          -XX:SurvivorRatio=32 \
          -XX:MaxTenuringThreshold=1 \
          -Dusing.aikars.flags=true \
          -Daikars.new.flags=true \
          -jar "forge-1.16.5-36.1.2.jar" \
          --nogui \
          --universe ./data \
          --port ${SERVER_PORT:-25565} \
          --world ${WORLD_NAME:-world}