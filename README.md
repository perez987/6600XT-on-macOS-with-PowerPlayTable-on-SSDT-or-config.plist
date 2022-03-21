# XFX RX 6600 XT graphics card in macOS Monterey 12.2.1

**XFX Speedster QICK 308 AMD Radeon RX 6600 XT Black 8GB GDDR6**

![RX 6600 XT](xfx-6600xt.png?raw=true)

### Preface

Although graphics cards assembled by XFX have negative comments in Hackintosh forums by having custom BIOS that can be more problematic for macOS that of other brands, I have installed a XFX QICK 308 AMD Radeon RX 6600 XT 8GB in Monterey 12.2.1 and the result has been excellent, installation was very simple and performance is much higher than that of the previous card, RX580 8GB.

This card is one of the 6600 XT cheapest even though it can still be considered expensive compared to what would be logical in other circumstances (shortage of components and mined cryptocurrencies).

The main components of my computer are Z390 Aorus Elite board and Intel i9-9900K CPU.

### Current macOS status of AMD 6000 series graphics cards is:

Working on macOS
- Family Navi 21: 6800, 6800 XT and 6900 XT (since Big Sur 11.4)
- Family Navi 23: 6600 and 6600 XT (since Monterey 12.1).

NOT working on macOS
- Family Navi 22: 6700 XT
- Family Navi 24: 6400, 6500 and 6500 XT.

Of course 6800 and 6900 series are clearly more powerful than the 6600 but their current market price is very high. The 6600 XT has higher performance than the 6600 and this model of XFX can now be found for a price of around 500-550 €.

The card is long size but no longer than the XFX RX580 it will replace. Surprisingly, it's even slightly lighter, probably because of the metal housing that the RX580 incorporates. Requires 8 pin power connector and recommended power supply is at least 600-650W. It has 4 DisplayPort ports and 1 HDMI port.

### Installation

Physical placement of the card does not deserve comment, it's like any other PCI-e slot card.

Installation on macOS is very simple. The same EFI with OpenCore 0.7.8 (Lilu and WhateverGreen included) that worked with the RX580 works for the 6600XT with a single change: add `agdpmod=pikera` in boot-args to prevent the screen from going black on the desktop.

The card is well recognized as seen in System profile.

![System Profiler](sysprof.png?raw=true)

### Working on macOS

Overall performance is very good, smooth, with 2560x1440 resolution at 60Hz on a 4K monitor. The score in the GeekBench 5 test is around 60% higher than the RX580 (78000 - 80000 vs 48000 - 5000).

### Working on Windows

Many Hackintosh users have double booting with Windows. Here the impressions are also very good, system has kept the same AMD drivers without requiring update.

The score in the Geeks3D FurMark test is double with the RX 6600 XT (approx. 6100) than with the RX580 (approx. 3000).
