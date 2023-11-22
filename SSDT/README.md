# SSDT METHOD

* https://github.com/5T33Z0/OC-Little-Translated/tree/main/11_Graphics/GPU/AMD_Radeon_Tweaks#method-2-selecting-specific-amd-framebuffers-via-deviceproperties
* https://github.com/5T33Z0/OC-Little-Translated/blob/main/11_Graphics/GPU/AMD_Radeon_Tweaks/Polaris_PowerPlay_Tables.md


Use GPU-Z to export roms from your graphics card or use this page to find one in https://www.techpowerup.com/gpu-specs/

Once the `rom` file is obtained, we will extract the PPT file if it is the factory default file, please note that it will not be modified with respect to the Zero RPM!

----

## OSX Extracting PPT from ROM
In Osx we install the following packages:
Download this tool  [upp](https://github.com/sibradzic/upp) and go to the insede of the folder

```shell
git clone https://github.com/sibradzic/upp.git && cd upp
python3 setup.py build
sudo python3 setup.py install
sudo python3 -m pip install click
upp --pp-file=extracted.pp_table extract -r <rom_file>.rom
```


After extracting data an `extracted.pp_table` file will be created and we copy it to the folder where we have the `to-hex` script.
Give it permissions to run: `chmod +x ./to-hex.sh`.
Launch the script `./to-hex.sh`.

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

For an example we will preview the real NAVI21 dump file of an iMacPro1,1 : `Original-iMacPro11.dsl` and then modify our DSL `Sample-Navi21.dsl`. 
We copy from terminal the result and insert it right between the comments:

```
// Insert here your code

// End mark
```

---

### Cleanup

for better and quicker identification rename the final file to `ssdt-br0.dsl` and don`t forget to compile to `AML` format that later has to be put in ACPI in your `config.plist` file.

---

Place it in the APCI folder and reload OpenCore. To check that everything is correct it should look like this image:

![ioreg](./iorex_pp_ppt.png)

---

#### Tools
	***Online Converter:*** https://www.rapidtables.com/convert/number/decimal-to-hex.html
