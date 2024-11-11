@echo off

:: Check for files that likely contain the server jar and rename the first valid one
IF NOT EXIST server.jar (
    for %%f in (*.jar) do (
        echo %%f | findstr /i "paper minecraft fabric server" >nul
        if %errorlevel%==0 (
            if "%%f" neq "server.jar" ren "%%f" server.jar
            goto done
        )
    )
)

:done
java -Xms12288M -Xmx12288M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui

pause
