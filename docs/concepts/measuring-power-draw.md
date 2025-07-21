# Measuring Power Draw

![](led-strip-power-draw.jpg)

We can purchase a low cost

## Power Draw Test on an LED Strip

We can check how much power an LED strip draws by setting the pixels to various
colors and then measuring the total current being drawn

```python
# Power Test
# Draw all the pixels a specific color and intensity and then watch the current
# Use a USB current meter
from machine import Pin
from neopixel import NeoPixel
from utime import sleep
# get the configuration information
import config

np = config.NUMBER_PIXELS
strip = NeoPixel(Pin(config.NEOPIXEL_PIN), np)

# give enough time for the current meter to stabilize
sleep_time = 5
while True:
    
    # make the strip red
    for i in range(0,np):
        strip[i] = (255,0,0)
        strip.write()
    sleep(sleep_time)
   
    # make the strip green
    for i in range(0,np):
        strip[i] = (0,255,0)
        strip.write()
    sleep(sleep_time)
    
    # make the strip blue
    for i in range(0,np):
        strip[i] = (0,0,255)
        strip.write()
    sleep(sleep_time)
    
    # make the strip white
    for i in range(0,np):
        strip[i] = (255,255,255)
        strip.write()
    sleep(sleep_time)
    
    # turn off the strip
    for i in range(0,np):
        strip[i] = (0,0,0)
        strip.write()
        sleep(.05)
    sleep(sleep_time)
```