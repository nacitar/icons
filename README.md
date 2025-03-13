# Icons
Custom icons for anything that seems to need them.

# kitty
I use a fluxbox theme with a 20px titlebar heigh, meaning 18x18 icons.  I
needed an icon that looks good at this size, so I made a SVG of a simple
terminal icon.

The file is located in `terminal/nacitar_shell.svg` and rendered versions for
the kitty terminal are provided in `terminal/kitty/` along with the script I
used to render the PNGs, as well as a script to copy them from the CWD and
install them for kitty.

I generated these with the command:
```bash
    ./render_kitty_icons.sh --fluxbox ../nacitar_shell.svg
```
this is equivalent to:
```bash
    ./render_kitty_icons.sh --alpha-multiplier=5 ../nacitar_shell.svg
```

I did this because at small icon sizes, the ~1px black borders blend so much
with the transparency that surrounds it that the contrast is poor.  This
darkens them to more acceptable levels.

As long as the kitty icons are in your CWD, you can install them with:
```bash
    ./install_kitty_icons.sh
```

Zero effort was put into making this work for anything other than Linux.
