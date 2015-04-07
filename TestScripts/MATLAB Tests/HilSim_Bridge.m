%%

import XPlaneConnect.*
fromXPLANE = openUDP(49005);
fromGCS = openUDP(49100);
toXPLANE = openUDP(49000);
toGCS = openUDP(49105);

%%
while 1
    result = readUDP(fromXPLANE);
    sendUDP(result,'127.0.0.1',toGCS);
    result = readUDP(fromGCS);
    sendUDP(result,'127.0.0.1',toXPLANE);
end

%%
DREF = single(result(6));
idx = 10;
val1 = typecast(uint8(result(idx:idx+3)),'single'); idx = idx+4;
val2 = typecast(uint8(result(idx:idx+3)),'single'); idx = idx+4;
val3 = typecast(uint8(result(idx:idx+3)),'single'); idx = idx+4;
val4 = typecast(uint8(result(idx:idx+3)),'single'); idx = idx+4;
val5 = typecast(uint8(result(idx:idx+3)),'single'); idx = idx+4;
val6 = typecast(uint8(result(idx:idx+3)),'single'); idx = idx+4;
val7 = typecast(uint8(result(idx:idx+3)),'single'); idx = idx+4;
val8 = typecast(uint8(result(idx:idx+3)),'single'); idx = idx+4;
switch DREF
    case 3
    case 4
        
    case 20
        lat = val1;
        lon = val2;
        alt = val3;
    default
end

        
%%
closeUDP(fromXPLANE);
closeUDP(fromGCS);
closeUDP(toXPLANE);
closeUDP(toGCS);
