# SSDT METHOD: softPowerPlayTable inside SSDT file

* [AMD tweaks: SSDTs vs. DeviceProperties](https://github.com/5T33Z0/OC-Little-Translated/tree/main/11_Graphics/GPU/AMD_Radeon_Tweaks#method-2-selecting-specific-amd-framebuffers-via-deviceproperties)
* [Creating Custom PowerPlay Tables for AMD Polaris Cards](https://github.com/5T33Z0/OC-Little-Translated/blob/main/11_Graphics/GPU/AMD_Radeon_Tweaks/Polaris_PowerPlay_Tables.md)
________________________________
1. Use GPU-Z to export your graphics card's ROM.
________________________________
2. In macOS:

* Download this tool [upp](https://github.com/sibradzic/upp) and run it next to the ROM file.

```shell
git clone https://github.com/sibradzic/upp.git && cd upp
python3 setup.py build
sudo python3 setup.py install
sudo python3 -m pip install click
upp --pp-file=extracted.pp_table extract -r <rom_file>.rom
```

* After extracting data, an `extracted.pp_table` file will be created and we copy it to the folder where we have the `to-hex.sh` script (included into the `SSDT/script` folder).
* Give it permissions to run: `chmod +x ./to-hex.sh`.
* Launch the script `./to-hex.sh` to see the output within Terminal window. You can also get the output as a text file running `./to-hex.sh >> PhmSoftPowerPlayTable.txt`.

	The result should look something like this:

	```c++
	PP_PhmSoftPowerPlayTable,
	Buffer (0x9A6)
	{
		/* 0000 */  0xA6 , 0x09 , 0x0F , 0x00 , 0x02 , 0x22 , 0x03 , 0xAF , 0x09 , 0x00 , 0x00 , 0x77 , 0x40 , 0x00 , 0x00 , 0x80 , // .....".....w@...
		/* 0010 */  0x00 , 0x18 , 0x00 , 0x00 , 0x00 , 0x1C , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x76 , 0x00 , 0x00 , 0x00 , // ............v...
            ... / ...
		/* 09A0 */  0x00 , 0x00 , 0x00 , 0x00 , 0x1E , 0x06 , // <- on the end remove last extra comma 
	},
	```

* Copy the whole string by replacing text inside the `Sample.dsl` file from line 39 to 52 (between `//Put your hex code here` and `//END mark`). `Sample.dsl` can be renamed to something more specific like `SSDT-GFX-PPT.dsl`. 
* Remember that you can fill in the file with the name of your graphics card (cosmetic), manufacturer or any other required property.
* Important: check the IOReg path of your graphic card, it may be different from the one in `Sample.dsl`.

```
	External (_SB_.PCI0, DeviceObj)
    	External (_SB_.PCI0.GFX0, DeviceObj)
    	External (_SB_.PCI0.PEG0, DeviceObj)
    	External (_SB_.PCI0.PEG0.PEGP, DeviceObj)
```

* Then do not forget to compile and save the file in AML format.

	***Note:*** Remember important step! By default script places an extra comma at the end of the hexadecimal string, so we remove it.

* Place it in the APCI folder and reboot macOS to reload OpenCore.
________________________________
To check that everything is correct, it should look like this image:

![ioreg](./iorex_pp_ppt.png)
________________________________
How we modify the value of `Buffer(<value>)` in the DSL code? It is the count (in hexadecimal) of hex numbers.

You can use this [***Online decimal to hex converter:***](https://www.rapidtables.com/convert/number/decimal-to-hex.html).

Note: When compiling DSL to AML, compiler writes the right value if the DSL has no value, e.g. `Buffer()` in DSL -> `Buffer (0x9A6)` in AML.
________________________________
All is added as in the example file: `Sample.dsl`.\
For the rest, the file is an original iMacPro1,1 dump, of course each user has to modify it according to his hardware.\
Maybe everything is correctly detected and we just want to add the PPT string to the system. In this case we can delete all the unnecessary properties.
