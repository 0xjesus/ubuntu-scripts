
# Ubuntu Scripts

Some useful scripts for Ubuntu 22 LTS that actually work.

## What's included

### chrome-guardian.sh
Monitors Chrome and automatically restarts it when it crashes. Because Chrome crashes a lot.

Run it in background:
```

nohup ./chrome-guardian.sh > chrome-guardian.log 2>&1 &

```

### chrome-indestructible.sh  
Restarts Chrome with settings that make it less likely to crash. Kills all Chrome processes first and cleans cache.
```

./chrome-indestructible.sh

```

### fix-screen-share.sh
Fixes screen sharing in Ubuntu 22 when it stops working (especially in Wayland). Doesn't close your apps.
```

./fix-screen-share.sh

```

## Installation
```

git clone [https://github.com/YOURUSERNAME/ubuntu-scripts.git](https://github.com/0xjesus/ubuntu-scripts.git) cd ubuntu-scripts chmod +x *.sh

```

## How we use them

- Run the guardian in background to keep Chrome alive
- Use the screen share fix when Zoom/Teams screen sharing breaks
- The indestructible script when Chrome gets really messed up

Works on Ubuntu 22 LTS. Your mileage may vary.
