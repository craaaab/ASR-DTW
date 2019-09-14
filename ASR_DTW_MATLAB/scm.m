clear a
a = arduino();     
writeDigitalPin(a, 'D10', 1);
pause(10);
writeDigitalPin(a, 'D10', 0);
