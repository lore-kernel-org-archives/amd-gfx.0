From: Paul Menzel <pmenzel+amd-gfx-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
Subject: Re: randr: Virtual monitor not present with MST display
Date: Wed, 6 Mar 2019 13:41:30 +0100
Message-ID: <1ed0ecfc-3c4a-5f94-9e20-e9c673d01e1e@molgen.mpg.de>
References: <137f10f1-65aa-1a72-5e9f-18b7b7c84217@molgen.mpg.de>
 <CADnq5_Pxk=L45FuWnMpQmpT4JB39OteoDJfHQzxr64wVjnMj-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1379021704=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Pxk=L45FuWnMpQmpT4JB39OteoDJfHQzxr64wVjnMj-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a cryptographically signed message in MIME format.

--===============1379021704==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020509070204030905020501"

This is a cryptographically signed message in MIME format.

--------------ms020509070204030905020501
Content-Type: multipart/mixed;
 boundary="------------3A2DE0F175F3BED3A87CC0AE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3A2DE0F175F3BED3A87CC0AE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Alex,


On 03/05/19 20:07, Alex Deucher wrote:
> On Tue, Mar 5, 2019 at 1:16 PM Paul Menzel wrote:

>> Using the MST display Dell UP3214Q (two panels) with an AMD system,
>> the virtual monitor object is not created. GDM and Xfce consider both
>> panels as separate screens (`xrandr --listmonitors`).
>>
>> [    0.000000] Linux version 4.20.13.mx64.248 (root@holidayincambodia.=
molgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Wed Feb 27 14:10:55 CET 2=
019
>>
>> [   79.494297] [drm] DM_MST: stopping TM on aconnector: 00000000a81093=
31 [id: 56]
>> [   79.494362] [drm] DM_MST: Disabling connector: 00000000776ea22b [id=
: 63] [master: 00000000a8109331]
>> [   79.494406] [drm] DM_MST: Disabling connector: 00000000057ebdbb [id=
: 67] [master: 00000000a8109331]
>> [   79.781882] snd_hda_intel 0000:00:1f.3: spurious response 0x0:0x2, =
last cmd=3D0x201f0500
>> [   86.028806] [drm] DM_MST: starting TM on aconnector: 00000000a81093=
31 [id: 56]
>> [   86.053072] [drm] DM_MST: added connector: 000000001c9b49ed [id: 71=
] [master: 00000000a8109331]
>> [   86.108540] [drm] SADs count is: -2, don't need to read it
>> [   86.386661] [drm:create_stream_for_sink [amdgpu]] *ERROR* Failed to=
 create stream for sink!
>> [   87.237878] [drm] DM_MST: added connector: 00000000c3ffcbbb [id: 80=
] [master: 00000000a8109331]
>> [   87.293028] [drm] SADs count is: -2, don't need to read it
>> [  206.993344] [drm] DM_MST: stopping TM on aconnector: 00000000a81093=
31 [id: 56]
>> [  206.993423] [drm] DM_MST: Disabling connector: 000000001c9b49ed [id=
: 71] [master: 00000000a8109331]
>> [  206.993456] [drm] DM_MST: Disabling connector: 00000000c3ffcbbb [id=
: 80] [master: 00000000a8109331]
>> [  207.548051] [drm:create_stream_for_sink [amdgpu]] *ERROR* Failed to=
 create stream for sink!
>> [  207.603193] [drm:create_stream_for_sink [amdgpu]] *ERROR* Failed to=
 create stream for sink!
>> [  207.762388] traps: xfdesktop[2225] general protection fault ip:7f58=
8981226c sp:7ffee65af370 error:0 in libgobject-2.0.so.0.5800.1[7f58897da0=
00+56000]
>> [  210.320612] [drm] DM_MST: starting TM on aconnector: 00000000b456cd=
59 [id: 62]
>> [  210.343497] [drm] DM_MST: added connector: 00000000735839d5 [id: 73=
] [master: 00000000b456cd59]
>> [  210.399168] [drm] SADs count is: -2, don't need to read it
>> [  210.404454] [drm] DM_MST: added connector: 00000000cccb0c2d [id: 88=
] [master: 00000000b456cd59]
>> [  210.675589] [drm] SADs count is: -2, don't need to read it

I didn=E2=80=99t provide the output of xrandr in my previous message.

    $ xrandr --listmonitors
     Monitors: 2
     0: +DisplayPort-9 1920/698x2160/392+0+0  DisplayPort-9
     1: +DisplayPort-10 1920/698x2160/392+1920+0  DisplayPort-10

Please find the X.Org X Server log attached.

>> With an Intel system, the monitor object is shown.

To clarify, the modesetting driver is used with the Intel hardware.

>>     $ xrandr --listmonitors
>>     Monitors: 1
>>      0: +Auto-Monitor-1 3840/698x2160/392+0+0  DP-1-9 DP-1-8
>>
>> Do you have an idea, what the AMD drivers does differently, and how
>> to fix this?
>=20
> + dri-devel
>=20
> My understanding is that this is handled at the Desktop level rather
> than the driver.  X exposes the tile info via randr 1.5 and the
> desktop environment should handle it as a single monitor.  Mutter
> handles this in GNOME for example.
>=20
> https://cgit.freedesktop.org/xorg/xserver/commit/?id=3D7e1f86d42b54fb7f=
6492875e47a718eaeca3069b
> https://lists.x.org/archives/xorg-announce/2015-May/002605.html
> https://mail.gnome.org/archives/desktop-devel-list/2015-November/msg000=
18.html

As it works with the modesetting driver, it looks to me like Xfce
supports it, and it=E2=80=99s a driver issue. The Linux error messages
also do not look promising. Any idea, if they are related?
Lastly, shouldn=E2=80=99t at least the output of `xrandr` be correct, if
everything is set up correctly?


Kind regards,

Paul

--------------3A2DE0F175F3BED3A87CC0AE
Content-Type: text/x-log;
 name="Xorg.0.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="Xorg.0.log"

[    57.665]=20
X.Org X Server 1.20.4
X Protocol Version 11, Revision 0
[    57.665] Build Operating System: Linux 4.19.19.mx64.244 x86_64=20
[    57.665] Current Operating System: Linux inbetweenmove.molgen.mpg.de =
4.19.19.mx64.244 #1 SMP Tue Feb 5 13:01:13 CET 2019 x86_64
[    57.665] Kernel command line: BOOT_IMAGE=3D/boot/bzImage-4.19.19.mx64=
=2E244 crashkernel=3D256M root=3DLABEL=3Droot ro console=3DttyS1,115200n8=
 console=3Dtty0 init=3D/bin/systemd audit=3D0
[    57.665] Build Date: 27 February 2019  12:32:24PM
[    57.665] =20
[    57.665] Current version of pixman: 0.38.0
[    57.665] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[    57.665] Markers: (--) probed, (**) from config file, (=3D=3D) defaul=
t setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[    57.665] (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Wed Mar  6 1=
3:24:58 2019
[    57.665] (=3D=3D) Using config directory: "/etc/X11/xorg.conf.d"
[    57.665] (=3D=3D) Using system config directory "/usr/share/X11/xorg.=
conf.d"
[    57.665] (=3D=3D) No Layout section.  Using the first Screen section.=

[    57.665] (=3D=3D) No screen section available. Using defaults.
[    57.665] (**) |-->Screen "Default Screen Section" (0)
[    57.665] (**) |   |-->Monitor "<default monitor>"
[    57.665] (=3D=3D) No monitor specified for screen "Default Screen Sec=
tion".
	Using a default monitor configuration.
[    57.665] (**) Option "DRI2" "True"
[    57.665] (**) Option "IndirectGLX" "True"
[    57.665] (=3D=3D) Automatically adding devices
[    57.665] (=3D=3D) Automatically enabling devices
[    57.665] (=3D=3D) Automatically adding GPU devices
[    57.665] (=3D=3D) Max clients allowed: 256, resource mask: 0x1fffff
[    57.665] (=3D=3D) FontPath set to:
	/usr/share/fonts/X11/misc/,
	/usr/share/fonts/X11/TTF/,
	/usr/share/fonts/X11/OTF/,
	/usr/share/fonts/X11/Type1/,
	/usr/share/fonts/X11/100dpi/,
	/usr/share/fonts/X11/75dpi/
[    57.665] (=3D=3D) ModulePath set to "/usr/lib/xorg/modules"
[    57.665] (II) The server relies on udev to provide the list of input =
devices.
	If no devices become available, reconfigure udev or disable AutoAddDevic=
es.
[    57.665] (II) Loader magic: 0x813c40
[    57.665] (II) Module ABI versions:
[    57.665] 	X.Org ANSI C Emulation: 0.4
[    57.665] 	X.Org Video Driver: 24.0
[    57.665] 	X.Org XInput driver : 24.1
[    57.665] 	X.Org Server Extension : 10.0
[    57.665] (II) xfree86: Adding drm device (/dev/dri/card1)
[    57.680] (II) xfree86: Adding drm device (/dev/dri/card0)
[    57.680] (--) PCI: (0@0:2:0) 8086:5912:1028:06b7 rev 4, Mem @ 0xee000=
000/16777216, 0xc0000000/268435456, I/O @ 0x0000f000/64
[    57.680] (--) PCI:*(1@0:0:0) 1002:67c7:1028:0b0d rev 0, Mem @ 0xd0000=
000/268435456, 0xe0000000/2097152, 0xef000000/262144, I/O @ 0x0000e000/25=
6, BIOS @ 0x????????/131072
[    57.680] (WW) Open ACPI failed (/var/run/acpid.socket) (No such file =
or directory)
[    57.680] (II) LoadModule: "glx"
[    57.680] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[    57.682] (II) Module glx: vendor=3D"X.Org Foundation"
[    57.682] 	compiled for 1.20.4, module version =3D 1.0.0
[    57.682] 	ABI class: X.Org Server Extension, version 10.0
[    57.682] (II) Applying OutputClass "AMDgpu" to /dev/dri/card1
[    57.682] 	loading driver: amdgpu
[    57.682] (=3D=3D) Matched amdgpu as autoconfigured driver 0
[    57.682] (=3D=3D) Matched ati as autoconfigured driver 1
[    57.682] (=3D=3D) Matched intel as autoconfigured driver 2
[    57.682] (=3D=3D) Matched modesetting as autoconfigured driver 3
[    57.682] (=3D=3D) Matched fbdev as autoconfigured driver 4
[    57.682] (=3D=3D) Matched vesa as autoconfigured driver 5
[    57.682] (=3D=3D) Assigned the driver to the xf86ConfigLayout
[    57.682] (II) LoadModule: "amdgpu"
[    57.682] (II) Loading /usr/lib/xorg/modules/drivers/amdgpu_drv.so
[    57.683] (II) Module amdgpu: vendor=3D"X.Org Foundation"
[    57.683] 	compiled for 1.20.4, module version =3D 19.0.0
[    57.683] 	Module class: X.Org Video Driver
[    57.683] 	ABI class: X.Org Video Driver, version 24.0
[    57.683] (II) LoadModule: "ati"
[    57.683] (WW) Warning, couldn't open module ati
[    57.683] (EE) Failed to load module "ati" (module does not exist, 0)
[    57.683] (II) LoadModule: "intel"
[    57.683] (WW) Warning, couldn't open module intel
[    57.683] (EE) Failed to load module "intel" (module does not exist, 0=
)
[    57.683] (II) LoadModule: "modesetting"
[    57.683] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.s=
o
[    57.683] (II) Module modesetting: vendor=3D"X.Org Foundation"
[    57.683] 	compiled for 1.20.4, module version =3D 1.20.4
[    57.683] 	Module class: X.Org Video Driver
[    57.683] 	ABI class: X.Org Video Driver, version 24.0
[    57.683] (II) LoadModule: "fbdev"
[    57.683] (WW) Warning, couldn't open module fbdev
[    57.683] (EE) Failed to load module "fbdev" (module does not exist, 0=
)
[    57.683] (II) LoadModule: "vesa"
[    57.683] (WW) Warning, couldn't open module vesa
[    57.683] (EE) Failed to load module "vesa" (module does not exist, 0)=

[    57.683] (II) AMDGPU: Driver for AMD Radeon:
	All GPUs supported by the amdgpu kernel driver
[    57.683] (II) modesetting: Driver for Modesetting Kernel Drivers: kms=

[    57.683] (--) using VT number 3

[    57.706] (II) AMDGPU(0): [KMS] Kernel modesetting enabled.
[    57.706] (WW) Falling back to old probe method for modesetting
[    57.706] (II) modeset(G0): using drv /dev/dri/card0
[    57.706] (II) AMDGPU(0): Creating default Display subsection in Scree=
n section
	"Default Screen Section" for depth/fbbpp 24/32
[    57.706] (=3D=3D) AMDGPU(0): Depth 24, (--) framebuffer bpp 32
[    57.706] (II) AMDGPU(0): Pixel depth =3D 24 bits stored in 4 bytes (3=
2 bpp pixmaps)
[    57.706] (=3D=3D) AMDGPU(0): Default visual is TrueColor
[    57.706] (=3D=3D) AMDGPU(0): RGB weight 888
[    57.706] (II) AMDGPU(0): Using 8 bits per RGB (8 bit DAC)
[    57.706] (--) AMDGPU(0): Chipset: "AMD Radeon (TM) Pro WX 5100 Graphi=
cs" (ChipID =3D 0x67c7)
[    57.706] (II) Loading sub module "fb"
[    57.706] (II) LoadModule: "fb"
[    57.706] (II) Loading /usr/lib/xorg/modules/libfb.so
[    57.706] (II) Module fb: vendor=3D"X.Org Foundation"
[    57.706] 	compiled for 1.20.4, module version =3D 1.0.0
[    57.706] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    57.706] (II) Loading sub module "dri2"
[    57.706] (II) LoadModule: "dri2"
[    57.706] (II) Module "dri2" already built-in
[    57.783] (II) Loading sub module "glamoregl"
[    57.783] (II) LoadModule: "glamoregl"
[    57.783] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[    57.790] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[    57.790] 	compiled for 1.20.4, module version =3D 1.0.1
[    57.790] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    57.795] (II) AMDGPU(0): glamor X acceleration enabled on AMD Radeon =
(TM) Pro WX 5100 Graphics (POLARIS10, DRM 3.27.0, 4.19.19.mx64.244, LLVM =
7.0.1)
[    57.795] (II) AMDGPU(0): glamor detected, initialising EGL layer.
[    57.795] (=3D=3D) AMDGPU(0): TearFree property default: auto
[    57.795] (=3D=3D) AMDGPU(0): VariableRefresh: disabled
[    57.795] (II) AMDGPU(0): KMS Pageflipping: enabled
[    57.795] (II) AMDGPU(0): Output DisplayPort-3 has no monitor section
[    57.795] (II) AMDGPU(0): Output DisplayPort-4 has no monitor section
[    57.795] (II) AMDGPU(0): Output DisplayPort-5 has no monitor section
[    57.795] (II) AMDGPU(0): Output DisplayPort-6 has no monitor section
[    57.795] (II) AMDGPU(0): Output DisplayPort-7 has no monitor section
[    57.795] (II) AMDGPU(0): Output DisplayPort-8 has no monitor section
[    57.830] (II) AMDGPU(0): EDID for output DisplayPort-3
[    57.830] (II) AMDGPU(0): EDID for output DisplayPort-4
[    57.830] (II) AMDGPU(0): EDID for output DisplayPort-5
[    57.830] (II) AMDGPU(0): EDID for output DisplayPort-6
[    57.830] (II) AMDGPU(0): EDID for output DisplayPort-7
[    57.830] (II) AMDGPU(0): Manufacturer: DEL  Model: 4093  Serial#: 808=
858448
[    57.830] (II) AMDGPU(0): Year: 2013  Week: 46
[    57.830] (II) AMDGPU(0): EDID Version: 1.4
[    57.830] (II) AMDGPU(0): Digital Display Input
[    57.830] (II) AMDGPU(0): 10 bits per channel
[    57.830] (II) AMDGPU(0): Digital interface is DisplayPort
[    57.830] (II) AMDGPU(0): Max Image Size [cm]: horiz.: 70  vert.: 39
[    57.830] (II) AMDGPU(0): Gamma: 2.20
[    57.830] (II) AMDGPU(0): DPMS capabilities: Off
[    57.830] (II) AMDGPU(0): Supported color encodings: RGB 4:4:4 YCrCb 4=
:4:4 YCrCb 4:2:2
[    57.830] (II) AMDGPU(0): First detailed timing is preferred mode
[    57.830] (II) AMDGPU(0): Preferred mode is native pixel format and re=
fresh rate
[    57.830] (II) AMDGPU(0): redX: 0.638 redY: 0.327   greenX: 0.211 gree=
nY: 0.714
[    57.830] (II) AMDGPU(0): blueX: 0.151 blueY: 0.053   whiteX: 0.316 wh=
iteY: 0.324
[    57.830] (II) AMDGPU(0): Manufacturer's mask: 0
[    57.830] (II) AMDGPU(0): Supported detailed timing:
[    57.830] (II) AMDGPU(0): clock: 277.2 MHz   Image Size:  698 x 392 mm=

[    57.830] (II) AMDGPU(0): h_active: 1920  h_sync: 1968  h_sync_end 200=
0 h_blank_end 2080 h_border: 0
[    57.830] (II) AMDGPU(0): v_active: 2160  v_sync: 2163  v_sync_end 217=
3 v_blanking: 2222 v_border: 0
[    57.830] (II) AMDGPU(0): Serial No: K3R903BG063P
[    57.830] (II) AMDGPU(0): Monitor name: DELL UP3214Q
[    57.830] (II) AMDGPU(0): Ranges: V min: 29 V max: 75 Hz, H min: 31 H =
max: 140 kHz, PixClock max 305 MHz
[    57.830] (II) AMDGPU(0): Number of EDID sections to follow: 1
[    57.830] (II) AMDGPU(0): EDID (in hex):
[    57.830] (II) AMDGPU(0): 	00ffffffffffff0010ac934050333630
[    57.830] (II) AMDGPU(0): 	2e170104b54627783a73e0a35336b626
[    57.830] (II) AMDGPU(0): 	0d515300000001010101010101010101
[    57.830] (II) AMDGPU(0): 	0101010101014d6c80a070703e803020
[    57.830] (II) AMDGPU(0): 	3a00ba882100001a000000ff004b3352
[    57.830] (II) AMDGPU(0): 	3930334247303633500a000000fc0044
[    57.830] (II) AMDGPU(0): 	454c4c20555033323134510a000000fd
[    57.830] (II) AMDGPU(0): 	001d4b1f8c1e000a20202020202001ef
[    57.830] (II) AMDGPU(0): 	7012790000120016821010007f076f08
[    57.830] (II) AMDGPU(0): 	000000000044454c9340503336300000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000000000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000000000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000000000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000000000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000000000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000001d90
[    57.830] (II) AMDGPU(0): Printing probed modes for output DisplayPort=
-7
[    57.830] (II) AMDGPU(0): Modeline "1920x2160"x60.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[    57.830] (II) AMDGPU(0): EDID for output DisplayPort-8
[    57.830] (II) AMDGPU(0): Manufacturer: DEL  Model: 4093  Serial#: 808=
858448
[    57.830] (II) AMDGPU(0): Year: 2013  Week: 46
[    57.830] (II) AMDGPU(0): EDID Version: 1.4
[    57.830] (II) AMDGPU(0): Digital Display Input
[    57.830] (II) AMDGPU(0): 10 bits per channel
[    57.830] (II) AMDGPU(0): Digital interface is DisplayPort
[    57.830] (II) AMDGPU(0): Max Image Size [cm]: horiz.: 70  vert.: 39
[    57.830] (II) AMDGPU(0): Gamma: 2.20
[    57.830] (II) AMDGPU(0): DPMS capabilities: Off
[    57.830] (II) AMDGPU(0): Supported color encodings: RGB 4:4:4 YCrCb 4=
:4:4 YCrCb 4:2:2
[    57.830] (II) AMDGPU(0): First detailed timing is preferred mode
[    57.830] (II) AMDGPU(0): Preferred mode is native pixel format and re=
fresh rate
[    57.830] (II) AMDGPU(0): redX: 0.638 redY: 0.327   greenX: 0.211 gree=
nY: 0.714
[    57.830] (II) AMDGPU(0): blueX: 0.151 blueY: 0.053   whiteX: 0.316 wh=
iteY: 0.324
[    57.830] (II) AMDGPU(0): Supported established timings:
[    57.830] (II) AMDGPU(0): 720x400@70Hz
[    57.830] (II) AMDGPU(0): 640x480@60Hz
[    57.830] (II) AMDGPU(0): 640x480@75Hz
[    57.830] (II) AMDGPU(0): 800x600@60Hz
[    57.830] (II) AMDGPU(0): 800x600@75Hz
[    57.830] (II) AMDGPU(0): 1024x768@60Hz
[    57.830] (II) AMDGPU(0): 1024x768@75Hz
[    57.830] (II) AMDGPU(0): 1280x1024@75Hz
[    57.830] (II) AMDGPU(0): Manufacturer's mask: 0
[    57.830] (II) AMDGPU(0): Supported standard timings:
[    57.830] (II) AMDGPU(0): #0: hsize: 1280  vsize 800  refresh: 60  vid=
: 129
[    57.830] (II) AMDGPU(0): #1: hsize: 1680  vsize 1050  refresh: 60  vi=
d: 179
[    57.830] (II) AMDGPU(0): #2: hsize: 1920  vsize 1200  refresh: 60  vi=
d: 209
[    57.830] (II) AMDGPU(0): #3: hsize: 1152  vsize 864  refresh: 75  vid=
: 20337
[    57.830] (II) AMDGPU(0): #4: hsize: 1600  vsize 1200  refresh: 60  vi=
d: 16553
[    57.830] (II) AMDGPU(0): #5: hsize: 1280  vsize 1024  refresh: 60  vi=
d: 32897
[    57.830] (II) AMDGPU(0): #6: hsize: 1920  vsize 1080  refresh: 60  vi=
d: 49361
[    57.830] (II) AMDGPU(0): Supported detailed timing:
[    57.830] (II) AMDGPU(0): clock: 277.2 MHz   Image Size:  698 x 392 mm=

[    57.830] (II) AMDGPU(0): h_active: 1920  h_sync: 1968  h_sync_end 200=
0 h_blank_end 2080 h_border: 0
[    57.830] (II) AMDGPU(0): v_active: 2160  v_sync: 2163  v_sync_end 217=
3 v_blanking: 2222 v_border: 0
[    57.830] (II) AMDGPU(0): Serial No: K3R903BG063P
[    57.830] (II) AMDGPU(0): Monitor name: DELL UP3214Q
[    57.830] (II) AMDGPU(0): Ranges: V min: 29 V max: 75 Hz, H min: 31 H =
max: 140 kHz, PixClock max 305 MHz
[    57.830] (II) AMDGPU(0): Number of EDID sections to follow: 1
[    57.830] (II) AMDGPU(0): EDID (in hex):
[    57.830] (II) AMDGPU(0): 	00ffffffffffff0010ac934050333630
[    57.830] (II) AMDGPU(0): 	2e170104b54627783a73e0a35336b626
[    57.830] (II) AMDGPU(0): 	0d5153a54b008100b300d100714fa940
[    57.830] (II) AMDGPU(0): 	8180d1c001014d6c80a070703e803020
[    57.830] (II) AMDGPU(0): 	3a00ba882100001a000000ff004b3352
[    57.830] (II) AMDGPU(0): 	3930334247303633500a000000fc0044
[    57.830] (II) AMDGPU(0): 	454c4c20555033323134510a000000fd
[    57.830] (II) AMDGPU(0): 	001d4b1f8c1e000a20202020202001cd
[    57.830] (II) AMDGPU(0): 	7012790000120016821000007f076f08
[    57.830] (II) AMDGPU(0): 	000000000044454c9340503336300000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000000000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000000000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000000000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000000000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000000000
[    57.830] (II) AMDGPU(0): 	00000000000000000000000000002d90
[    57.830] (II) AMDGPU(0): Printing probed modes for output DisplayPort=
-8
[    57.830] (II) AMDGPU(0): Modeline "1920x2160"x60.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[    57.830] (II) AMDGPU(0): Modeline "1920x1200"x59.9  193.25  1920 2056=
 2256 2592  1200 1203 1209 1245 -hsync +vsync (74.6 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "1920x1080"x60.0  148.50  1920 2008=
 2052 2200  1080 1084 1089 1125 -hsync -vsync (67.5 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "1600x1200"x60.0  162.00  1600 1664=
 1856 2160  1200 1201 1204 1250 +hsync +vsync (75.0 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "1680x1050"x60.0  146.25  1680 1784=
 1960 2240  1050 1053 1059 1089 -hsync +vsync (65.3 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "1280x1024"x75.0  135.00  1280 1296=
 1440 1688  1024 1025 1028 1066 +hsync +vsync (80.0 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "1280x1024"x60.0  108.00  1280 1328=
 1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "1280x800"x59.8   83.50  1280 1352 =
1480 1680  800 803 809 831 -hsync +vsync (49.7 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "1152x864"x75.0  108.00  1152 1216 =
1344 1600  864 865 868 900 +hsync +vsync (67.5 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "1024x768"x75.0   78.75  1024 1040 =
1136 1312  768 769 772 800 +hsync +vsync (60.0 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "1024x768"x60.0   65.00  1024 1048 =
1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "800x600"x75.0   49.50  800 816 896=
 1056  600 601 604 625 +hsync +vsync (46.9 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "800x600"x60.3   40.00  800 840 968=
 1056  600 601 605 628 +hsync +vsync (37.9 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "640x480"x75.0   31.50  640 656 720=
 840  480 481 484 500 -hsync -vsync (37.5 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "640x480"x59.9   25.18  640 656 752=
 800  480 490 492 525 -hsync -vsync (31.5 kHz e)
[    57.830] (II) AMDGPU(0): Modeline "720x400"x70.1   28.32  720 738 846=
 900  400 412 414 449 -hsync +vsync (31.5 kHz e)
[    57.830] (II) AMDGPU(0): Output DisplayPort-3 disconnected
[    57.830] (II) AMDGPU(0): Output DisplayPort-4 disconnected
[    57.830] (II) AMDGPU(0): Output DisplayPort-5 disconnected
[    57.830] (II) AMDGPU(0): Output DisplayPort-6 disconnected
[    57.830] (II) AMDGPU(0): Output DisplayPort-7 connected
[    57.830] (II) AMDGPU(0): Output DisplayPort-8 connected
[    57.830] (II) AMDGPU(0): Using spanning desktop for initial modes
[    57.830] (II) AMDGPU(0): Output DisplayPort-7 using initial mode 1920=
x2160 +0+0
[    57.830] (II) AMDGPU(0): Output DisplayPort-8 using initial mode 1920=
x2160 +1920+0
[    57.830] (II) AMDGPU(0): mem size init: gart size :1ffd39000 vram siz=
e: s:1fdb34000 visible:db34000
[    57.830] (=3D=3D) AMDGPU(0): DPI set to (96, 96)
[    57.830] (=3D=3D) AMDGPU(0): Using gamma correction (1.0, 1.0, 1.0)
[    57.830] (II) Loading sub module "ramdac"
[    57.830] (II) LoadModule: "ramdac"
[    57.830] (II) Module "ramdac" already built-in
[    57.830] (=3D=3D) modeset(G0): Depth 24, (=3D=3D) framebuffer bpp 32
[    57.830] (=3D=3D) modeset(G0): RGB weight 888
[    57.830] (=3D=3D) modeset(G0): Default visual is TrueColor
[    57.830] (II) Loading sub module "glamoregl"
[    57.830] (II) LoadModule: "glamoregl"
[    57.830] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[    57.830] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[    57.830] 	compiled for 1.20.4, module version =3D 1.0.1
[    57.830] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    57.835] (II) modeset(G0): glamor X acceleration enabled on Mesa DRI =
Intel(R) HD Graphics 630 (Kaby Lake GT2)=20
[    57.835] (II) modeset(G0): glamor initialized
[    57.840] (II) modeset(G0): Output HDMI-1-1 has no monitor section
[    57.841] (II) modeset(G0): Output DP-1-1 has no monitor section
[    57.845] (II) modeset(G0): Output HDMI-1-2 has no monitor section
[    57.845] (II) modeset(G0): Output DP-1-2 has no monitor section
[    57.851] (II) modeset(G0): Output HDMI-1-3 has no monitor section
[    57.851] (II) modeset(G0): Output DP-1-3 has no monitor section
[    57.856] (II) modeset(G0): EDID for output HDMI-1-1
[    57.858] (II) modeset(G0): EDID for output DP-1-1
[    57.863] (II) modeset(G0): EDID for output HDMI-1-2
[    57.863] (II) modeset(G0): EDID for output DP-1-2
[    57.868] (II) modeset(G0): EDID for output HDMI-1-3
[    57.868] (II) modeset(G0): EDID for output DP-1-3
[    57.868] (=3D=3D) modeset(G0): Using gamma correction (1.0, 1.0, 1.0)=

[    57.868] (=3D=3D) modeset(G0): DPI set to (96, 96)
[    57.868] (II) Loading sub module "fb"
[    57.868] (II) LoadModule: "fb"
[    57.868] (II) Loading /usr/lib/xorg/modules/libfb.so
[    57.868] (II) Module fb: vendor=3D"X.Org Foundation"
[    57.868] 	compiled for 1.20.4, module version =3D 1.0.0
[    57.868] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    57.869] (=3D=3D) modeset(G0): Backing store enabled
[    57.869] (=3D=3D) modeset(G0): Silken mouse enabled
[    57.869] (II) modeset(G0): Initializing kms color map for depth 24, 8=
 bpc.
[    57.869] (=3D=3D) modeset(G0): DPMS enabled
[    57.869] (II) modeset(G0): [DRI2] Setup complete
[    57.869] (II) modeset(G0): [DRI2]   DRI driver: i965
[    57.869] (II) modeset(G0): [DRI2]   VDPAU driver: i965
[    57.869] (II) AMDGPU(0): [DRI2] Setup complete
[    57.869] (II) AMDGPU(0): [DRI2]   DRI driver: radeonsi
[    57.869] (II) AMDGPU(0): [DRI2]   VDPAU driver: radeonsi
[    57.870] (II) AMDGPU(0): Front buffer pitch: 15360 bytes
[    57.870] (II) AMDGPU(0): SYNC extension fences enabled
[    57.870] (II) AMDGPU(0): Present extension enabled
[    57.870] (=3D=3D) AMDGPU(0): DRI3 enabled
[    57.870] (=3D=3D) AMDGPU(0): Backing store enabled
[    57.870] (II) AMDGPU(0): Direct rendering enabled
[    57.872] (II) AMDGPU(0): Use GLAMOR acceleration.
[    57.872] (II) AMDGPU(0): Acceleration enabled
[    57.872] (=3D=3D) AMDGPU(0): DPMS enabled
[    57.872] (=3D=3D) AMDGPU(0): Silken mouse enabled
[    57.872] (II) AMDGPU(0): Set up textured video (glamor)
[    57.897] (II) Initializing extension Generic Event Extension
[    57.897] (II) Initializing extension SHAPE
[    57.897] (II) Initializing extension MIT-SHM
[    57.897] (II) Initializing extension XInputExtension
[    57.897] (II) Initializing extension XTEST
[    57.897] (II) Initializing extension BIG-REQUESTS
[    57.897] (II) Initializing extension SYNC
[    57.897] (II) Initializing extension XKEYBOARD
[    57.897] (II) Initializing extension XC-MISC
[    57.897] (II) Initializing extension XFIXES
[    57.897] (II) Initializing extension RENDER
[    57.897] (II) Initializing extension RANDR
[    57.897] (II) Initializing extension COMPOSITE
[    57.897] (II) Initializing extension DAMAGE
[    57.897] (II) Initializing extension MIT-SCREEN-SAVER
[    57.897] (II) Initializing extension DOUBLE-BUFFER
[    57.897] (II) Initializing extension RECORD
[    57.897] (II) Initializing extension DPMS
[    57.897] (II) Initializing extension Present
[    57.897] (II) Initializing extension DRI3
[    57.897] (II) Initializing extension X-Resource
[    57.897] (II) Initializing extension XVideo
[    57.897] (II) Initializing extension XVideo-MotionCompensation
[    57.897] (II) Initializing extension GLX
[    57.900] (II) AIGLX: Loaded and initialized radeonsi
[    57.900] (II) GLX: Initialized DRI2 GL provider for screen 0
[    57.900] (II) Initializing extension XFree86-VidModeExtension
[    57.900] (II) Initializing extension XFree86-DGA
[    57.900] (II) Initializing extension XFree86-DRI
[    57.900] (II) Initializing extension DRI2
[    57.900] (II) modeset(G0): Damage tracking initialized
[    57.901] (II) AMDGPU(0): Setting screen physical size to 1016 x 571
[    57.962] (II) config/udev: Adding input device Power Button (/dev/inp=
ut/event2)
[    57.962] (**) Power Button: Applying InputClass "evdev keyboard catch=
all"
[    57.962] (II) LoadModule: "evdev"
[    57.962] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[    57.963] (II) Module evdev: vendor=3D"X.Org Foundation"
[    57.963] 	compiled for 1.19.6, module version =3D 2.10.5
[    57.963] 	Module class: X.Org XInput Driver
[    57.963] 	ABI class: X.Org XInput driver, version 24.1
[    57.963] (II) Using input driver 'evdev' for 'Power Button'
[    57.963] (**) Power Button: always reports core events
[    57.963] (**) evdev: Power Button: Device: "/dev/input/event2"
[    57.963] (--) evdev: Power Button: Vendor 0 Product 0x1
[    57.963] (--) evdev: Power Button: Found keys
[    57.963] (II) evdev: Power Button: Configuring as keyboard
[    57.963] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
PWRBN:00/input/input2/event2"
[    57.963] (II) XINPUT: Adding extended input device "Power Button" (ty=
pe: KEYBOARD, id 6)
[    57.963] (**) Option "xkb_rules" "evdev"
[    57.963] (II) config/udev: Adding input device Video Bus (/dev/input/=
event11)
[    57.963] (**) Video Bus: Applying InputClass "evdev keyboard catchall=
"
[    57.963] (II) Using input driver 'evdev' for 'Video Bus'
[    57.963] (**) Video Bus: always reports core events
[    57.963] (**) evdev: Video Bus: Device: "/dev/input/event11"
[    57.963] (--) evdev: Video Bus: Vendor 0 Product 0x6
[    57.963] (--) evdev: Video Bus: Found keys
[    57.963] (II) evdev: Video Bus: Configuring as keyboard
[    57.963] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input14/event11"
[    57.963] (II) XINPUT: Adding extended input device "Video Bus" (type:=
 KEYBOARD, id 7)
[    57.963] (**) Option "xkb_rules" "evdev"
[    57.963] (II) config/udev: Adding input device Power Button (/dev/inp=
ut/event1)
[    57.963] (**) Power Button: Applying InputClass "evdev keyboard catch=
all"
[    57.963] (II) Using input driver 'evdev' for 'Power Button'
[    57.963] (**) Power Button: always reports core events
[    57.963] (**) evdev: Power Button: Device: "/dev/input/event1"
[    57.963] (--) evdev: Power Button: Vendor 0 Product 0x1
[    57.963] (--) evdev: Power Button: Found keys
[    57.963] (II) evdev: Power Button: Configuring as keyboard
[    57.963] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0C0C:00/input/input1/event1"
[    57.963] (II) XINPUT: Adding extended input device "Power Button" (ty=
pe: KEYBOARD, id 8)
[    57.963] (**) Option "xkb_rules" "evdev"
[    57.964] (II) config/udev: Adding input device Sleep Button (/dev/inp=
ut/event0)
[    57.964] (**) Sleep Button: Applying InputClass "evdev keyboard catch=
all"
[    57.964] (II) Using input driver 'evdev' for 'Sleep Button'
[    57.964] (**) Sleep Button: always reports core events
[    57.964] (**) evdev: Sleep Button: Device: "/dev/input/event0"
[    57.964] (--) evdev: Sleep Button: Vendor 0 Product 0x3
[    57.964] (--) evdev: Sleep Button: Found keys
[    57.964] (II) evdev: Sleep Button: Configuring as keyboard
[    57.964] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0C0E:00/input/input0/event0"
[    57.964] (II) XINPUT: Adding extended input device "Sleep Button" (ty=
pe: KEYBOARD, id 9)
[    57.964] (**) Option "xkb_rules" "evdev"
[    57.964] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D3 (/dev/input/event3)
[    57.964] (II) No input driver specified, ignoring this device.
[    57.964] (II) This device may have been added with another device fil=
e.
[    57.964] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D7 (/dev/input/event4)
[    57.964] (II) No input driver specified, ignoring this device.
[    57.964] (II) This device may have been added with another device fil=
e.
[    57.965] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D8 (/dev/input/event5)
[    57.965] (II) No input driver specified, ignoring this device.
[    57.965] (II) This device may have been added with another device fil=
e.
[    57.965] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D9 (/dev/input/event6)
[    57.965] (II) No input driver specified, ignoring this device.
[    57.965] (II) This device may have been added with another device fil=
e.
[    57.965] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D10 (/dev/input/event7)
[    57.965] (II) No input driver specified, ignoring this device.
[    57.965] (II) This device may have been added with another device fil=
e.
[    57.965] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D11 (/dev/input/event8)
[    57.965] (II) No input driver specified, ignoring this device.
[    57.965] (II) This device may have been added with another device fil=
e.
[    57.966] (II) config/udev: Adding input device Dell Dell USB Entry Ke=
yboard (/dev/input/event9)
[    57.966] (**) Dell Dell USB Entry Keyboard: Applying InputClass "evde=
v keyboard catchall"
[    57.966] (II) Using input driver 'evdev' for 'Dell Dell USB Entry Key=
board'
[    57.966] (**) Dell Dell USB Entry Keyboard: always reports core event=
s
[    57.966] (**) evdev: Dell Dell USB Entry Keyboard: Device: "/dev/inpu=
t/event9"
[    57.966] (--) evdev: Dell Dell USB Entry Keyboard: Vendor 0x413c Prod=
uct 0x2107
[    57.966] (--) evdev: Dell Dell USB Entry Keyboard: Found keys
[    57.966] (II) evdev: Dell Dell USB Entry Keyboard: Configuring as key=
board
[    57.966] (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000=
:00:14.0/usb1/1-4/1-4:1.0/0003:413C:2107.0002/input/input12/event9"
[    57.966] (II) XINPUT: Adding extended input device "Dell Dell USB Ent=
ry Keyboard" (type: KEYBOARD, id 10)
[    57.966] (**) Option "xkb_rules" "evdev"
[    57.966] (II) config/udev: Adding input device Logitech USB Optical M=
ouse (/dev/input/event10)
[    57.966] (**) Logitech USB Optical Mouse: Applying InputClass "evdev =
pointer catchall"
[    57.966] (II) Using input driver 'evdev' for 'Logitech USB Optical Mo=
use'
[    57.966] (**) Logitech USB Optical Mouse: always reports core events
[    57.966] (**) evdev: Logitech USB Optical Mouse: Device: "/dev/input/=
event10"
[    57.966] (--) evdev: Logitech USB Optical Mouse: Vendor 0x46d Product=
 0xc05a
[    57.966] (--) evdev: Logitech USB Optical Mouse: Found 12 mouse butto=
ns
[    57.966] (--) evdev: Logitech USB Optical Mouse: Found scroll wheel(s=
)
[    57.966] (--) evdev: Logitech USB Optical Mouse: Found relative axes
[    57.966] (--) evdev: Logitech USB Optical Mouse: Found x and y relati=
ve axes
[    57.966] (II) evdev: Logitech USB Optical Mouse: Configuring as mouse=

[    57.966] (II) evdev: Logitech USB Optical Mouse: Adding scrollwheel s=
upport
[    57.966] (**) evdev: Logitech USB Optical Mouse: YAxisMapping: button=
s 4 and 5
[    57.966] (**) evdev: Logitech USB Optical Mouse: EmulateWheelButton: =
4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    57.966] (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000=
:00:14.0/usb1/1-5/1-5:1.0/0003:046D:C05A.0003/input/input13/event10"
[    57.966] (II) XINPUT: Adding extended input device "Logitech USB Opti=
cal Mouse" (type: MOUSE, id 11)
[    57.966] (II) evdev: Logitech USB Optical Mouse: initialized for rela=
tive axes.
[    57.966] (**) Logitech USB Optical Mouse: (accel) keeping acceleratio=
n scheme 1
[    57.966] (**) Logitech USB Optical Mouse: (accel) acceleration profil=
e 0
[    57.966] (**) Logitech USB Optical Mouse: (accel) acceleration factor=
: 2.000
[    57.966] (**) Logitech USB Optical Mouse: (accel) acceleration thresh=
old: 4
[    57.966] (II) config/udev: Adding input device HDA Intel PCH Front Mi=
c (/dev/input/event12)
[    57.966] (II) No input driver specified, ignoring this device.
[    57.966] (II) This device may have been added with another device fil=
e.
[    57.967] (II) config/udev: Adding input device HDA Intel PCH Rear Mic=
 (/dev/input/event13)
[    57.967] (II) No input driver specified, ignoring this device.
[    57.967] (II) This device may have been added with another device fil=
e.
[    57.967] (II) config/udev: Adding input device HDA Intel PCH Line Out=
 (/dev/input/event14)
[    57.967] (II) No input driver specified, ignoring this device.
[    57.967] (II) This device may have been added with another device fil=
e.
[    57.967] (II) config/udev: Adding input device HDA Intel PCH Front He=
adphone (/dev/input/event15)
[    57.967] (II) No input driver specified, ignoring this device.
[    57.967] (II) This device may have been added with another device fil=
e.
[    57.970] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[    57.970] (II) AMDGPU(0): Using EDID range info for horizontal sync
[    57.970] (II) AMDGPU(0): Using EDID range info for vertical refresh
[    57.970] (II) AMDGPU(0): Printing DDC gathered Modelines:
[    57.970] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[    58.248] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[    58.248] (II) AMDGPU(0): Using hsync ranges from config file
[    58.248] (II) AMDGPU(0): Using vrefresh ranges from config file
[    58.248] (II) AMDGPU(0): Printing DDC gathered Modelines:
[    58.248] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   739.635] (EE) AMDGPU(0): failed to set mode: Invalid argument
[   739.636] (EE) AMDGPU(0): failed to set mode: Invalid argument
[   741.745] (II) AMDGPU(0): Output DisplayPort-9 has no monitor section
[   741.779] (EE) AMDGPU(0): drmmode_do_crtc_dpms cannot get last vblank =
counter
[   741.780] (II) AMDGPU(0): Allocate new frame buffer 1920x2160
[   741.780] (II) AMDGPU(0):  =3D> pitch 8192 bytes
[   741.781] (EE) AMDGPU(0): failed to set mode: Invalid argument
[   742.144] (II) AMDGPU(0): Output DisplayPort-10 has no monitor section=

[   742.175] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   742.175] (II) AMDGPU(0): Using hsync ranges from config file
[   742.175] (II) AMDGPU(0): Using vrefresh ranges from config file
[   742.175] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   742.175] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   742.177] (II) AMDGPU(0): Allocate new frame buffer 3840x2160
[   742.178] (II) AMDGPU(0):  =3D> pitch 15360 bytes
[   749.082] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.084] (II) AMDGPU(0): Using hsync ranges from config file
[   749.084] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.084] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.084] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.093] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.093] (II) AMDGPU(0): Using hsync ranges from config file
[   749.093] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.093] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.093] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.094] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.094] (II) AMDGPU(0): Using hsync ranges from config file
[   749.094] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.094] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.094] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.209] (EE) AMDGPU(0): drmmode_do_crtc_dpms cannot get last vblank =
counter
[   749.360] (EE) AMDGPU(0): drmmode_do_crtc_dpms cannot get last vblank =
counter
[   749.867] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.867] (II) AMDGPU(0): Using hsync ranges from config file
[   749.867] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.867] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.867] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.867] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.867] (II) AMDGPU(0): Using hsync ranges from config file
[   749.867] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.867] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.867] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.869] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.870] (II) AMDGPU(0): Using hsync ranges from config file
[   749.870] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.870] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.870] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.870] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.870] (II) AMDGPU(0): Using hsync ranges from config file
[   749.870] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.870] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.870] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.871] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.871] (II) AMDGPU(0): Using hsync ranges from config file
[   749.871] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.871] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.871] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.871] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.871] (II) AMDGPU(0): Using hsync ranges from config file
[   749.871] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.871] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.871] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.872] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.872] (II) AMDGPU(0): Using hsync ranges from config file
[   749.872] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.872] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.872] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.872] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.872] (II) AMDGPU(0): Using hsync ranges from config file
[   749.872] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.872] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.872] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.873] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.873] (II) AMDGPU(0): Using hsync ranges from config file
[   749.873] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.873] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.873] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   749.874] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   749.874] (II) AMDGPU(0): Using hsync ranges from config file
[   749.874] (II) AMDGPU(0): Using vrefresh ranges from config file
[   749.874] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   749.874] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   756.252] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   756.252] (II) AMDGPU(0): Using hsync ranges from config file
[   756.252] (II) AMDGPU(0): Using vrefresh ranges from config file
[   756.252] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   756.252] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   756.253] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[   756.253] (II) AMDGPU(0): Using hsync ranges from config file
[   756.253] (II) AMDGPU(0): Using vrefresh ranges from config file
[   756.253] (II) AMDGPU(0): Printing DDC gathered Modelines:
[   756.253] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   811.164] (II) evdev: Logitech USB Optical Mouse: Close
[   811.164] (II) UnloadModule: "evdev"
[   811.164] (II) evdev: Dell Dell USB Entry Keyboard: Close
[   811.164] (II) UnloadModule: "evdev"
[   811.164] (II) evdev: Sleep Button: Close
[   811.164] (II) UnloadModule: "evdev"
[   811.164] (II) evdev: Power Button: Close
[   811.164] (II) UnloadModule: "evdev"
[   811.164] (II) evdev: Video Bus: Close
[   811.164] (II) UnloadModule: "evdev"
[   811.164] (II) evdev: Power Button: Close
[   811.164] (II) UnloadModule: "evdev"
[   811.236] (II) Server terminated successfully (0). Closing log file.

--------------3A2DE0F175F3BED3A87CC0AE--

--------------ms020509070204030905020501
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTAzMDYxMjQxMzBaMC8GCSqGSIb3DQEJBDEiBCAAV708gLlhoVOV6+GV
ye1UPv7YJd5kS+ly+vMtrAjhJzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBABKj
4fPWkpJ+QVX6qo9OYR1xQ9TY8Tk9gXm6S1OhF/rUCkVQy7u5Y30v1R/mA1tId61EnYOdUUKn
FsJLqNzpW2x2yNqWgEuFyb+nm8vN+yFjXn+zZCmku5LpgXYTnLWz0JQQOTWzNq0e2ULIkOF2
+G7LKNjgAftmXfS+ELsh3CagNvgNJFXp0FcllwU+LHvjqbpeiuqX48y3lUyZ7MmP/zrHcc9h
SWfkitXd010Cn0IFhRhe16Gm8ov6KkpszsGZsbb7BA52XQOwGL1PvMoycdMIbuXUjIUd6xxq
kYGYaBq8K1B+yfyXwu0qnFdqfdtQAj4LRvO5WQ3AnwBx+BJEfe8AAAAAAAA=
--------------ms020509070204030905020501--

--===============1379021704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1379021704==--
