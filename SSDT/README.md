# SSDT METHOD: softPowerPlayTable inside SSDT file

Use GPU-Z to export ROM from your graphics card or go to [techpowerup](https://www.techpowerup.com/gpu-specs/) to find one.

Once the ROM file is obtained, `upp` will extract the PPT key as `extracted.pp_table` file.\
It is the factory default file.\
Please note that it will not be modified as far as ***Zero RPM*** feature is concerned!

----

## Extracting sPPT from ROM on macOS

Install `upp`: download the tool [upp](https://github.com/sibradzic/upp) and run it next to the ROM file.

```
git clone https://github.com/sibradzic/upp.git && cd upp
python3 setup.py build
sudo python3 setup.py install
sudo python3 -m pip install click
upp --pp-file=extracted.pp_table extract -r <rom_file>.rom
```

After running `upp`, an `extracted.pp_table` file will be created. Copy it to the folder where the `pp_table-to-hex-dsl.sh` script is.\
Give it permissions to run: `chmod +x ./pp_table-to-hex-dsl.sh`.\
Launch the script `./pp_table-to-hex-dsl.sh`.

***Result:***

```text
	"PP_PhmSoftPowerPlayTable"
	Buffer ()
	{
		/* 0000 */  0xA6 , 0x09 , 0x0F , 0x00 , 0x02 , 0x22 , 0x03 , 0xAF , 0x09 , 0x00 , 0x00 , 0x77 , 0x40 , 0x00 , 0x00 , 0x80 , // .....".....w@...
		/* 0010 */  0x00 , 0x18 , 0x00 , 0x00 , 0x00 , 0x1C , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x76 , 0x00 , 0x00 , 0x00 , // ............v...

		...

		/* 09A0 */  0x00 , 0x00 , 0x00 , 0x00 , 0x1E , 0x06 // ......
	}
```

In the `SSDT/samples`folder you can find `SAMPLE-NAVI.dsl`, it is a quite common file, you can use it as a reference.\
Copy the result from the Terminal window and paste it right between the comments:

```
// Insert here your code

// End mark
```

For better identification, rename the final file to `SSDT-BR0.dsl` and don't forget to compile to AML format that later has to be put in ACPI folder and in `config.plist` file.

Important! Remember to check your IOReg device path according to your system.

### Test

Place the SSDT in APCI folder and config.plist. Reboot to reload OpenCore. To check that everything is correct open IORegistryExplorer, go to GFX0 and check if it looks like this image:

![IOReg](img/IOreg-gfx0-ppt.png)

### Windows REG file to DSL-friendly string

In addition to the PPT table extracted with `upp` directly from the GPU ROM, there are 2 other sources of the data to be converted to DSL-friendly hexadecimal string:

1. Windows Registry key exported as REG file: `script/win-reg-to-hex-dsl.sh`
```
win-reg-to-hex-dsl.sh ../samples/sPPT.reg
```

2. Windows Registry key exported as TXT file: `script/win-reg-dump-txt-to-hex-dsl.sh`
```
win-reg-txt-to-hex-dsl.sh ../samples/sPPT-reg.txt
```

Both methods allow you to modify sPPT with MorePower Tools in Windows to adjust Zero RPM and load the key with custom settings into the SSDT file.

### Tool

[***Decimal to Hexadecimal converter***](https://www.rapidtables.com/convert/number/decimal-to-hex.html)

### Docs:

   * [AMD tweaks: SSDTs vs. DeviceProperties](https://github.com/5T33Z0/OC-Little-Translated/tree/main/11_Graphics/GPU/AMD_Radeon_Tweaks#method-2-selecting-specific-amd-framebuffers-via-deviceproperties)
   * [Creating Custom PowerPlay Tables for AMD Polaris Cards](https://github.com/5T33Z0/OC-Little-Translated/blob/main/11_Graphics/GPU/AMD_Radeon_Tweaks/Polaris_PowerPlay_Tables.md)
