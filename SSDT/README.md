# SSDT METHOD: softPowerPlayTable inside SSDT file

* [SSDTs vs. DeviceProperties](https://github.com/5T33Z0/OC-Little-Translated/tree/main/11_Graphics/GPU/AMD_Radeon_Tweaks#method-2-selecting-specific-amd-framebuffers-via-deviceproperties)
* [Creating Custom PowerPlay Tables for AMD Polaris Cards](https://github.com/5T33Z0/OC-Little-Translated/blob/main/11_Graphics/GPU/AMD_Radeon_Tweaks/Polaris_PowerPlay_Tables.md)

Use GPU-Z to export roms from your graphics card.
In macOS we install the following packages:

---

Download this tool [upp](https://github.com/sibradzic/upp) and go to the inside of the folder

```shell
git clone https://github.com/sibradzic/upp.git && cd upp
python3 setup.py build
sudo python3 setup.py install
sudo python3 -m pip install click
upp --pp-file=extracted.pp_table extract -r <rom_file>.rom
```
---

After extracting data, an `extracted.pp_table` file will be created and we copy it to the folder where we have the `to-hex.sh` script.
Give it permissions to run: `chmod +x ./to-hex.sh`.
Launch the script `./to-hex.sh`.

The result should look something like this:

***Result:***
```text
PP_PhmSoftPowerPlayTable,
		Buffer (0x9A6)
		{
			/* 0000 */  0xA6 , 0x09 , 0x0F , 0x00 , 0x02 , 0x22 , 0x03 , 0xAF , 0x09 , 0x00 , 0x00 , 0x77 , 0x40 , 0x00 , 0x00 , 0x80 , // .....".....w@...
			/* 0010 */  0x00 , 0x18 , 0x00 , 0x00 , 0x00 , 0x1C , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x76 , 0x00 , 0x00 , 0x00 , // ............v...
            ... / ...
        	/* 09A0 */  0x00 , 0x00 , 0x00 , 0x00 , 0x1E , 0x06 , // <- on the end remove last extra comma 
		},
```

***There are two possible values:***
```
PP_PhmSoftPowerPlayTable
PP_PhmSoftWTTable
```

Now copy all the contents by replacing inside the `Sample.dsl` file from line 39 to 52. `Sample.dsl` can be renamed to something more specific like `SSDT-GFX-PPT.dsl` or `SSDT-BR0.dsl`. 
Remember that you can fill in the file with the name of your graphics card, manufactor or other values, also remember to put the PCI path of your real card.

````
	External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.PEG0, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP, DeviceObj)
```

Then do not forget to compile and save the file in AML format.
(***Note:***) Remember important step! By default script places an extra comma at the end of the hexidecimal string, so we remove it.


Place it in the APCI folder and reboot macOS to reload OpenCore. To check that everything is correct it should look like this image:

![ioreg](./iorex_pp_ppt.png)

How we modify the value of `Buffer(<value>)`? It is the number of letters + 1 in hexadecimal.

***Online Converter:*** https://www.rapidtables.com/convert/number/decimal-to-hex.html

All of that is added as in the example file: `Sample.dsl`
For the rest the file is an original iMacPro1,1 dump of course each user has to modify it according to his hardware. 
It may be that it detects everything correctly and we just want to add the PPT to the system. 
In this case we delete everything unnecessary.