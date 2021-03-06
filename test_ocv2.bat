setlocal

if "%MYPVPREFIX%" == "" (
    set MYPVPREFIX=TE:NDW1548:
)

REM set prefix for files created by technique - directory plus start of filename
caput -S %MYPVPREFIX%ECLAB_01:C0:FILEPREFIX:SP "c:/data/eclab"

REM set parameters for OCV technique
REM Format of technique PV is C{channel}:T:{technique}:{index}:{param}:SP
REM index is 0 unless the technique will be specified more than once in the LOADTECH command

REM this sets parameter RTT (rest time T) for technique OCV on channel 0
caput %MYPVPREFIX%ECLAB_01:C0:T:OCV:0:RTT:SP 30
caput %MYPVPREFIX%ECLAB_01:C0:T:OCV:1:REDT:SP 20

caput %MYPVPREFIX%ECLAB_01:C0:T:CA:0:REDT:SP 20
caput -a %MYPVPREFIX%ECLAB_01:C0:T:CA:0:VSTEP:SP 4 1 2 3 4
 
REM after setting parameters, load technique on channel 
REM you cannot start until you have loaded a technique, and if you 
REM stop you need to do LOADTECH again before another start
REM technique name in lowercase
caput %MYPVPREFIX%ECLAB_01:C0:LOADTECH:SP "ocv,ca,ocv"
 
REM now start the channel
REM this opens the data file
caput %MYPVPREFIX%ECLAB_01:C0:START 1

REM check status of channel
caget %MYPVPREFIX%ECLAB_01:C0:STATE

REM other current values 
caget %MYPVPREFIX%ECLAB_01:C0:EWE
caget %MYPVPREFIX%ECLAB_01:C0:ECE
caget %MYPVPREFIX%ECLAB_01:C0:I

pause

REM now stop the channel
REM this closes the data file
caput %MYPVPREFIX%ECLAB_01:C0:STOP 1

