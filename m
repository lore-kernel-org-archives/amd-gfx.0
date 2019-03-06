From: Paul Menzel <pmenzel+amd-gfx-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
Subject: Re: randr: Virtual monitor not present with MST display
Date: Wed, 6 Mar 2019 17:35:14 +0100
Message-ID: <22b28b6e-3087-e467-abc4-db267d596007@molgen.mpg.de>
References: <137f10f1-65aa-1a72-5e9f-18b7b7c84217@molgen.mpg.de>
 <CADnq5_Pxk=L45FuWnMpQmpT4JB39OteoDJfHQzxr64wVjnMj-w@mail.gmail.com>
 <1ed0ecfc-3c4a-5f94-9e20-e9c673d01e1e@molgen.mpg.de>
 <adf69ac0-ac0f-b44c-cdcd-38ce45b1ec0b@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0639990330=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <adf69ac0-ac0f-b44c-cdcd-38ce45b1ec0b-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a cryptographically signed message in MIME format.

--===============0639990330==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080709010905030208090605"

This is a cryptographically signed message in MIME format.

--------------ms080709010905030208090605
Content-Type: multipart/mixed;
 boundary="------------B96CA39EC077B3A65E8E965D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B96CA39EC077B3A65E8E965D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Michel,


On 03/06/19 15:55, Michel D=C3=A4nzer wrote:
> On 2019-03-06 1:41 p.m., Paul Menzel wrote:
>> On 03/05/19 20:07, Alex Deucher wrote:
>>> On Tue, Mar 5, 2019 at 1:16 PM Paul Menzel wrote:
>>
>>>> Using the MST display Dell UP3214Q (two panels) with an AMD system,
>>>> the virtual monitor object is not created. GDM and Xfce consider bot=
h
>>>> panels as separate screens (`xrandr --listmonitors`).
>>>>
>>>> [    0.000000] Linux version 4.20.13.mx64.248 (root@holidayincambodi=
a.molgen.mpg.de) (gcc version 7.3.0 (GCC)) #1 SMP Wed Feb 27 14:10:55 CET=
 2019
>>>>
>>>> [   79.494297] [drm] DM_MST: stopping TM on aconnector: 00000000a810=
9331 [id: 56]
>>>> [   79.494362] [drm] DM_MST: Disabling connector: 00000000776ea22b [=
id: 63] [master: 00000000a8109331]
>>>> [   79.494406] [drm] DM_MST: Disabling connector: 00000000057ebdbb [=
id: 67] [master: 00000000a8109331]
>>>> [   79.781882] snd_hda_intel 0000:00:1f.3: spurious response 0x0:0x2=
, last cmd=3D0x201f0500
>>>> [   86.028806] [drm] DM_MST: starting TM on aconnector: 00000000a810=
9331 [id: 56]
>>>> [   86.053072] [drm] DM_MST: added connector: 000000001c9b49ed [id: =
71] [master: 00000000a8109331]
>>>> [   86.108540] [drm] SADs count is: -2, don't need to read it
>>>> [   86.386661] [drm:create_stream_for_sink [amdgpu]] *ERROR* Failed =
to create stream for sink!
>>>> [   87.237878] [drm] DM_MST: added connector: 00000000c3ffcbbb [id: =
80] [master: 00000000a8109331]
>>>> [   87.293028] [drm] SADs count is: -2, don't need to read it
>>>> [  206.993344] [drm] DM_MST: stopping TM on aconnector: 00000000a810=
9331 [id: 56]
>>>> [  206.993423] [drm] DM_MST: Disabling connector: 000000001c9b49ed [=
id: 71] [master: 00000000a8109331]
>>>> [  206.993456] [drm] DM_MST: Disabling connector: 00000000c3ffcbbb [=
id: 80] [master: 00000000a8109331]
>>>> [  207.548051] [drm:create_stream_for_sink [amdgpu]] *ERROR* Failed =
to create stream for sink!
>>>> [  207.603193] [drm:create_stream_for_sink [amdgpu]] *ERROR* Failed =
to create stream for sink!
>>>> [  207.762388] traps: xfdesktop[2225] general protection fault ip:7f=
588981226c sp:7ffee65af370 error:0 in libgobject-2.0.so.0.5800.1[7f58897d=
a000+56000]
>>>> [  210.320612] [drm] DM_MST: starting TM on aconnector: 00000000b456=
cd59 [id: 62]
>>>> [  210.343497] [drm] DM_MST: added connector: 00000000735839d5 [id: =
73] [master: 00000000b456cd59]
>>>> [  210.399168] [drm] SADs count is: -2, don't need to read it
>>>> [  210.404454] [drm] DM_MST: added connector: 00000000cccb0c2d [id: =
88] [master: 00000000b456cd59]
>>>> [  210.675589] [drm] SADs count is: -2, don't need to read it
>>
>> I didn=E2=80=99t provide the output of xrandr in my previous message.
>>
>>     $ xrandr --listmonitors
>>      Monitors: 2
>>      0: +DisplayPort-9 1920/698x2160/392+0+0  DisplayPort-9
>>      1: +DisplayPort-10 1920/698x2160/392+1920+0  DisplayPort-10
>>
>> Please find the X.Org X Server log attached.
>>
>>>> With an Intel system, the monitor object is shown.
>>
>> To clarify, the modesetting driver is used with the Intel hardware.
>=20
> Does this work better with the modesetting driver on the AMD system?

With Linux 4.19.19, there was the same problem with the modesetting drive=
r
during my limited testing.

Updating to Linux 4.20.13, it worked with the modesetting driver, but the=

AMDGPU driver still failed to properly utilize the MST monitor.

Please find all the logs attached.


Kind regards,

Paul

--------------B96CA39EC077B3A65E8E965D
Content-Type: text/x-log;
 name="Xorg-modesetting-4.20.13.0.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="Xorg-modesetting-4.20.13.0.log"

[   132.131]=20
X.Org X Server 1.20.4
X Protocol Version 11, Revision 0
[   132.131] Build Operating System: Linux 4.19.19.mx64.244 x86_64=20
[   132.131] Current Operating System: Linux inbetweenmove.molgen.mpg.de =
4.20.13.mx64.248 #1 SMP Wed Feb 27 14:10:55 CET 2019 x86_64
[   132.131] Kernel command line: BOOT_IMAGE=3D/boot/bzImage-4.20.13.mx64=
=2E248 crashkernel=3D256M root=3DLABEL=3Droot ro console=3DttyS1,115200n8=
 console=3Dtty0 init=3D/bin/systemd audit=3D0
[   132.132] Build Date: 27 February 2019  12:32:24PM
[   132.132] =20
[   132.132] Current version of pixman: 0.38.0
[   132.132] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[   132.132] Markers: (--) probed, (**) from config file, (=3D=3D) defaul=
t setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[   132.132] (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Wed Mar  6 1=
7:22:46 2019
[   132.132] (=3D=3D) Using config directory: "/etc/X11/xorg.conf.d"
[   132.132] (=3D=3D) Using system config directory "/usr/share/X11/xorg.=
conf.d"
[   132.132] (=3D=3D) No Layout section.  Using the first Screen section.=

[   132.132] (=3D=3D) No screen section available. Using defaults.
[   132.132] (**) |-->Screen "Default Screen Section" (0)
[   132.132] (**) |   |-->Monitor "<default monitor>"
[   132.132] (=3D=3D) No monitor specified for screen "Default Screen Sec=
tion".
	Using a default monitor configuration.
[   132.132] (**) Option "DRI2" "True"
[   132.132] (**) Option "IndirectGLX" "True"
[   132.132] (=3D=3D) Automatically adding devices
[   132.132] (=3D=3D) Automatically enabling devices
[   132.132] (=3D=3D) Automatically adding GPU devices
[   132.132] (=3D=3D) Max clients allowed: 256, resource mask: 0x1fffff
[   132.132] (=3D=3D) FontPath set to:
	/usr/share/fonts/X11/misc/,
	/usr/share/fonts/X11/TTF/,
	/usr/share/fonts/X11/OTF/,
	/usr/share/fonts/X11/Type1/,
	/usr/share/fonts/X11/100dpi/,
	/usr/share/fonts/X11/75dpi/
[   132.132] (=3D=3D) ModulePath set to "/usr/lib/xorg/modules"
[   132.132] (II) The server relies on udev to provide the list of input =
devices.
	If no devices become available, reconfigure udev or disable AutoAddDevic=
es.
[   132.132] (II) Loader magic: 0x813c40
[   132.132] (II) Module ABI versions:
[   132.132] 	X.Org ANSI C Emulation: 0.4
[   132.132] 	X.Org Video Driver: 24.0
[   132.132] 	X.Org XInput driver : 24.1
[   132.132] 	X.Org Server Extension : 10.0
[   132.132] (II) xfree86: Adding drm device (/dev/dri/card0)
[   132.147] (II) xfree86: Adding drm device (/dev/dri/card1)
[   132.147] (--) PCI: (0@0:2:0) 8086:5912:1028:06b7 rev 4, Mem @ 0xee000=
000/16777216, 0xc0000000/268435456, I/O @ 0x0000f000/64
[   132.148] (--) PCI:*(1@0:0:0) 1002:67c7:1028:0b0d rev 0, Mem @ 0xd0000=
000/268435456, 0xe0000000/2097152, 0xef000000/262144, I/O @ 0x0000e000/25=
6, BIOS @ 0x????????/131072
[   132.148] (WW) Open ACPI failed (/var/run/acpid.socket) (No such file =
or directory)
[   132.148] (II) LoadModule: "glx"
[   132.148] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[   132.149] (II) Module glx: vendor=3D"X.Org Foundation"
[   132.149] 	compiled for 1.20.4, module version =3D 1.0.0
[   132.149] 	ABI class: X.Org Server Extension, version 10.0
[   132.149] (II) Applying OutputClass "AMDgpu" to /dev/dri/card0
[   132.149] 	loading driver: modesetting
[   132.149] (=3D=3D) Matched modesetting as autoconfigured driver 0
[   132.149] (=3D=3D) Matched ati as autoconfigured driver 1
[   132.149] (=3D=3D) Matched intel as autoconfigured driver 2
[   132.149] (=3D=3D) Matched fbdev as autoconfigured driver 3
[   132.149] (=3D=3D) Matched vesa as autoconfigured driver 4
[   132.149] (=3D=3D) Assigned the driver to the xf86ConfigLayout
[   132.149] (II) LoadModule: "modesetting"
[   132.149] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.s=
o
[   132.149] (II) Module modesetting: vendor=3D"X.Org Foundation"
[   132.149] 	compiled for 1.20.4, module version =3D 1.20.4
[   132.149] 	Module class: X.Org Video Driver
[   132.149] 	ABI class: X.Org Video Driver, version 24.0
[   132.149] (II) LoadModule: "ati"
[   132.149] (WW) Warning, couldn't open module ati
[   132.149] (EE) Failed to load module "ati" (module does not exist, 0)
[   132.149] (II) LoadModule: "intel"
[   132.149] (WW) Warning, couldn't open module intel
[   132.149] (EE) Failed to load module "intel" (module does not exist, 0=
)
[   132.149] (II) LoadModule: "fbdev"
[   132.149] (WW) Warning, couldn't open module fbdev
[   132.149] (EE) Failed to load module "fbdev" (module does not exist, 0=
)
[   132.149] (II) LoadModule: "vesa"
[   132.149] (WW) Warning, couldn't open module vesa
[   132.149] (EE) Failed to load module "vesa" (module does not exist, 0)=

[   132.149] (II) modesetting: Driver for Modesetting Kernel Drivers: kms=

[   132.149] (--) using VT number 4

[   132.180] (II) modeset(0): using drv /dev/dri/card0
[   132.180] (II) modeset(G0): using drv /dev/dri/card1
[   132.180] (II) modeset(0): Creating default Display subsection in Scre=
en section
	"Default Screen Section" for depth/fbbpp 24/32
[   132.180] (=3D=3D) modeset(0): Depth 24, (=3D=3D) framebuffer bpp 32
[   132.180] (=3D=3D) modeset(0): RGB weight 888
[   132.180] (=3D=3D) modeset(0): Default visual is TrueColor
[   132.180] (II) Loading sub module "glamoregl"
[   132.180] (II) LoadModule: "glamoregl"
[   132.180] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[   132.186] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[   132.186] 	compiled for 1.20.4, module version =3D 1.0.1
[   132.186] 	ABI class: X.Org ANSI C Emulation, version 0.4
[   132.265] (II) modeset(0): glamor X acceleration enabled on AMD Radeon=
 (TM) Pro WX 5100 Graphics (POLARIS10, DRM 3.27.0, 4.20.13.mx64.248, LLVM=
 7.0.1)
[   132.265] (II) modeset(0): glamor initialized
[   132.265] (II) modeset(0): Output DP-4 has no monitor section
[   132.265] (II) modeset(0): Output DP-5 has no monitor section
[   132.265] (II) modeset(0): Output DP-6 has no monitor section
[   132.265] (II) modeset(0): Output DP-7 has no monitor section
[   132.265] (II) modeset(0): Output DP-8 has no monitor section
[   132.265] (II) modeset(0): Output DP-9 has no monitor section
[   132.266] (II) modeset(0): EDID for output DP-4
[   132.266] (II) modeset(0): EDID for output DP-5
[   132.266] (II) modeset(0): EDID for output DP-6
[   132.266] (II) modeset(0): EDID for output DP-7
[   132.266] (II) modeset(0): EDID for output DP-8
[   132.266] (II) modeset(0): Manufacturer: DEL  Model: 4093  Serial#: 80=
8858448
[   132.266] (II) modeset(0): Year: 2013  Week: 46
[   132.266] (II) modeset(0): EDID Version: 1.4
[   132.266] (II) modeset(0): Digital Display Input
[   132.266] (II) modeset(0): 10 bits per channel
[   132.266] (II) modeset(0): Digital interface is DisplayPort
[   132.266] (II) modeset(0): Max Image Size [cm]: horiz.: 70  vert.: 39
[   132.266] (II) modeset(0): Gamma: 2.20
[   132.266] (II) modeset(0): DPMS capabilities: Off
[   132.266] (II) modeset(0): Supported color encodings: RGB 4:4:4 YCrCb =
4:4:4 YCrCb 4:2:2
[   132.266] (II) modeset(0): First detailed timing is preferred mode
[   132.266] (II) modeset(0): Preferred mode is native pixel format and r=
efresh rate
[   132.266] (II) modeset(0): redX: 0.638 redY: 0.327   greenX: 0.211 gre=
enY: 0.714
[   132.266] (II) modeset(0): blueX: 0.151 blueY: 0.053   whiteX: 0.316 w=
hiteY: 0.324
[   132.266] (II) modeset(0): Manufacturer's mask: 0
[   132.266] (II) modeset(0): Supported detailed timing:
[   132.266] (II) modeset(0): clock: 277.2 MHz   Image Size:  698 x 392 m=
m
[   132.266] (II) modeset(0): h_active: 1920  h_sync: 1968  h_sync_end 20=
00 h_blank_end 2080 h_border: 0
[   132.266] (II) modeset(0): v_active: 2160  v_sync: 2163  v_sync_end 21=
73 v_blanking: 2222 v_border: 0
[   132.266] (II) modeset(0): Serial No: K3R903BG063P
[   132.266] (II) modeset(0): Monitor name: DELL UP3214Q
[   132.266] (II) modeset(0): Ranges: V min: 29 V max: 75 Hz, H min: 31 H=
 max: 140 kHz, PixClock max 305 MHz
[   132.266] (II) modeset(0): Number of EDID sections to follow: 1
[   132.266] (II) modeset(0): EDID (in hex):
[   132.266] (II) modeset(0): 	00ffffffffffff0010ac934050333630
[   132.266] (II) modeset(0): 	2e170104b54627783a73e0a35336b626
[   132.266] (II) modeset(0): 	0d515300000001010101010101010101
[   132.266] (II) modeset(0): 	0101010101014d6c80a070703e803020
[   132.266] (II) modeset(0): 	3a00ba882100001a000000ff004b3352
[   132.266] (II) modeset(0): 	3930334247303633500a000000fc0044
[   132.266] (II) modeset(0): 	454c4c20555033323134510a000000fd
[   132.266] (II) modeset(0): 	001d4b1f8c1e000a20202020202001ef
[   132.266] (II) modeset(0): 	7012790000120016821010007f076f08
[   132.266] (II) modeset(0): 	000000000044454c9340503336300000
[   132.266] (II) modeset(0): 	00000000000000000000000000000000
[   132.266] (II) modeset(0): 	00000000000000000000000000000000
[   132.266] (II) modeset(0): 	00000000000000000000000000000000
[   132.266] (II) modeset(0): 	00000000000000000000000000000000
[   132.266] (II) modeset(0): 	00000000000000000000000000000000
[   132.266] (II) modeset(0): 	00000000000000000000000000001d90
[   132.266] (II) modeset(0): Not using default mode "1920x1080" (bad mod=
e clock/interlace/doublescan)
[   132.266] (II) modeset(0): Not using default mode "2048x1152" (bad mod=
e clock/interlace/doublescan)
[   132.266] (II) modeset(0): Printing probed modes for output DP-8
[   132.266] (II) modeset(0): Modeline "1920x2160"x60.0  277.25  1920 196=
8 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   132.266] (II) modeset(0): Modeline "2048x1536"x60.0  266.95  2048 220=
0 2424 2800  1536 1537 1540 1589 -hsync +vsync (95.3 kHz d)
[   132.266] (II) modeset(0): Modeline "1920x1440"x60.0  234.00  1920 204=
8 2256 2600  1440 1441 1444 1500 -hsync +vsync (90.0 kHz d)
[   132.266] (II) modeset(0): Modeline "1856x1392"x60.0  218.30  1856 195=
2 2176 2528  1392 1393 1396 1439 -hsync +vsync (86.4 kHz d)
[   132.266] (II) modeset(0): Modeline "1792x1344"x60.0  204.80  1792 192=
0 2120 2448  1344 1345 1348 1394 -hsync +vsync (83.7 kHz d)
[   132.266] (II) modeset(0): Modeline "2048x1152"x60.0  302.50  2048 207=
2 2088 2128  1152 1153 1156 1185 doublescan +hsync -vsync (142.2 kHz d)
[   132.266] (II) modeset(0): Modeline "2048x1152"x59.9  197.00  2048 218=
4 2400 2752  1152 1155 1160 1195 -hsync +vsync (71.6 kHz d)
[   132.266] (II) modeset(0): Modeline "2048x1152"x59.9  156.75  2048 209=
6 2128 2208  1152 1155 1160 1185 +hsync -vsync (71.0 kHz d)
[   132.266] (II) modeset(0): Modeline "1920x1200"x59.9  193.25  1920 205=
6 2256 2592  1200 1203 1209 1245 -hsync +vsync (74.6 kHz d)
[   132.266] (II) modeset(0): Modeline "1920x1200"x60.0  154.00  1920 196=
8 2000 2080  1200 1203 1209 1235 +hsync -vsync (74.0 kHz d)
[   132.266] (II) modeset(0): Modeline "1920x1080"x60.0  266.50  1920 194=
4 1960 2000  1080 1081 1084 1111 doublescan +hsync -vsync (133.2 kHz d)
[   132.266] (II) modeset(0): Modeline "1920x1080"x60.0  173.00  1920 204=
8 2248 2576  1080 1083 1088 1120 -hsync +vsync (67.2 kHz d)
[   132.266] (II) modeset(0): Modeline "1920x1080"x59.9  138.50  1920 196=
8 2000 2080  1080 1083 1088 1111 +hsync -vsync (66.6 kHz d)
[   132.266] (II) modeset(0): Modeline "1600x1200"x60.0  162.00  1600 166=
4 1856 2160  1200 1201 1204 1250 +hsync +vsync (75.0 kHz d)
[   132.266] (II) modeset(0): Modeline "1680x1050"x60.0  146.25  1680 178=
4 1960 2240  1050 1053 1059 1089 -hsync +vsync (65.3 kHz d)
[   132.266] (II) modeset(0): Modeline "1680x1050"x59.9  119.00  1680 172=
8 1760 1840  1050 1053 1059 1080 +hsync -vsync (64.7 kHz d)
[   132.266] (II) modeset(0): Modeline "1400x1050"x60.0  122.00  1400 148=
8 1640 1880  1050 1052 1064 1082 +hsync +vsync (64.9 kHz d)
[   132.266] (II) modeset(0): Modeline "1600x900"x60.0  246.00  1600 1728=
 1900 2200  900 901 904 932 doublescan -hsync +vsync (111.8 kHz d)
[   132.266] (II) modeset(0): Modeline "1600x900"x59.9  186.50  1600 1624=
 1640 1680  900 901 904 926 doublescan +hsync -vsync (111.0 kHz d)
[   132.266] (II) modeset(0): Modeline "1600x900"x59.9  118.25  1600 1696=
 1856 2112  900 903 908 934 -hsync +vsync (56.0 kHz d)
[   132.266] (II) modeset(0): Modeline "1600x900"x59.8   97.50  1600 1648=
 1680 1760  900 903 908 926 +hsync -vsync (55.4 kHz d)
[   132.266] (II) modeset(0): Modeline "1280x1024"x60.0  108.00  1280 132=
8 1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz d)
[   132.266] (II) modeset(0): Modeline "1400x900"x60.0  103.50  1400 1480=
 1624 1848  900 903 913 934 -hsync +vsync (56.0 kHz d)
[   132.266] (II) modeset(0): Modeline "1400x900"x59.9   86.50  1400 1448=
 1480 1560  900 903 913 926 +hsync -vsync (55.4 kHz d)
[   132.266] (II) modeset(0): Modeline "1280x960"x60.0  108.00  1280 1376=
 1488 1800  960 961 964 1000 +hsync +vsync (60.0 kHz d)
[   132.266] (II) modeset(0): Modeline "1440x810"x60.0  198.12  1440 1548=
 1704 1968  810 811 814 839 doublescan -hsync +vsync (100.7 kHz d)
[   132.266] (II) modeset(0): Modeline "1440x810"x60.0  151.88  1440 1464=
 1480 1520  810 811 814 833 doublescan +hsync -vsync (99.9 kHz d)
[   132.266] (II) modeset(0): Modeline "1368x768"x59.9   85.25  1368 1440=
 1576 1784  768 771 781 798 -hsync +vsync (47.8 kHz d)
[   132.266] (II) modeset(0): Modeline "1368x768"x59.9   72.25  1368 1416=
 1448 1528  768 771 781 790 +hsync -vsync (47.3 kHz d)
[   132.266] (II) modeset(0): Modeline "1280x800"x60.0  174.25  1280 1380=
 1516 1752  800 801 804 829 doublescan -hsync +vsync (99.5 kHz d)
[   132.266] (II) modeset(0): Modeline "1280x800"x60.0  134.25  1280 1304=
 1320 1360  800 801 804 823 doublescan +hsync -vsync (98.7 kHz d)
[   132.266] (II) modeset(0): Modeline "1280x800"x59.8   83.50  1280 1352=
 1480 1680  800 803 809 831 -hsync +vsync (49.7 kHz d)
[   132.266] (II) modeset(0): Modeline "1280x800"x59.9   71.00  1280 1328=
 1360 1440  800 803 809 823 +hsync -vsync (49.3 kHz d)
[   132.266] (II) modeset(0): Modeline "1280x720"x60.0  156.12  1280 1376=
 1512 1744  720 721 724 746 doublescan -hsync +vsync (89.5 kHz d)
[   132.266] (II) modeset(0): Modeline "1280x720"x60.0  120.75  1280 1304=
 1320 1360  720 721 724 740 doublescan +hsync -vsync (88.8 kHz d)
[   132.266] (II) modeset(0): Modeline "1280x720"x59.9   74.50  1280 1344=
 1472 1664  720 723 728 748 -hsync +vsync (44.8 kHz d)
[   132.266] (II) modeset(0): Modeline "1280x720"x59.7   63.75  1280 1328=
 1360 1440  720 723 728 741 +hsync -vsync (44.3 kHz d)
[   132.266] (II) modeset(0): Modeline "1024x768"x60.0  133.47  1024 1100=
 1212 1400  768 768 770 794 doublescan -hsync +vsync (95.3 kHz d)
[   132.266] (II) modeset(0): Modeline "1024x768"x60.0   65.00  1024 1048=
 1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz d)
[   132.266] (II) modeset(0): Modeline "960x720"x60.0  117.00  960 1024 1=
128 1300  720 720 722 750 doublescan -hsync +vsync (90.0 kHz d)
[   132.266] (II) modeset(0): Modeline "928x696"x60.1  109.15  928 976 10=
88 1264  696 696 698 719 doublescan -hsync +vsync (86.4 kHz d)
[   132.266] (II) modeset(0): Modeline "896x672"x60.0  102.40  896 960 10=
60 1224  672 672 674 697 doublescan -hsync +vsync (83.7 kHz d)
[   132.266] (II) modeset(0): Modeline "1024x576"x60.0   98.50  1024 1092=
 1200 1376  576 577 580 597 doublescan -hsync +vsync (71.6 kHz d)
[   132.266] (II) modeset(0): Modeline "1024x576"x60.0   78.38  1024 1048=
 1064 1104  576 577 580 592 doublescan +hsync -vsync (71.0 kHz d)
[   132.266] (II) modeset(0): Modeline "1024x576"x59.9   46.50  1024 1064=
 1160 1296  576 579 584 599 -hsync +vsync (35.9 kHz d)
[   132.266] (II) modeset(0): Modeline "1024x576"x59.8   42.00  1024 1072=
 1104 1184  576 579 584 593 +hsync -vsync (35.5 kHz d)
[   132.266] (II) modeset(0): Modeline "960x600"x59.9   96.62  960 1028 1=
128 1296  600 601 604 622 doublescan -hsync +vsync (74.6 kHz d)
[   132.266] (II) modeset(0): Modeline "960x600"x60.0   77.00  960 984 10=
00 1040  600 601 604 617 doublescan +hsync -vsync (74.0 kHz d)
[   132.266] (II) modeset(0): Modeline "960x540"x60.0   86.50  960 1024 1=
124 1288  540 541 544 560 doublescan -hsync +vsync (67.2 kHz d)
[   132.266] (II) modeset(0): Modeline "960x540"x60.0   69.25  960 984 10=
00 1040  540 541 544 555 doublescan +hsync -vsync (66.6 kHz d)
[   132.266] (II) modeset(0): Modeline "960x540"x59.6   40.75  960 992 10=
88 1216  540 543 548 562 -hsync +vsync (33.5 kHz d)
[   132.266] (II) modeset(0): Modeline "960x540"x59.8   37.25  960 1008 1=
040 1120  540 543 548 556 +hsync -vsync (33.3 kHz d)
[   132.266] (II) modeset(0): Modeline "800x600"x60.0   81.00  800 832 92=
8 1080  600 600 602 625 doublescan +hsync +vsync (75.0 kHz d)
[   132.266] (II) modeset(0): Modeline "800x600"x60.3   40.00  800 840 96=
8 1056  600 601 605 628 +hsync +vsync (37.9 kHz d)
[   132.266] (II) modeset(0): Modeline "800x600"x56.2   36.00  800 824 89=
6 1024  600 601 603 625 +hsync +vsync (35.2 kHz d)
[   132.266] (II) modeset(0): Modeline "840x525"x60.0   73.12  840 892 98=
0 1120  525 526 529 544 doublescan -hsync +vsync (65.3 kHz d)
[   132.266] (II) modeset(0): Modeline "840x525"x59.9   59.50  840 864 88=
0 920  525 526 529 540 doublescan +hsync -vsync (64.7 kHz d)
[   132.266] (II) modeset(0): Modeline "864x486"x59.9   32.50  864 888 96=
8 1072  486 489 494 506 -hsync +vsync (30.3 kHz d)
[   132.266] (II) modeset(0): Modeline "864x486"x59.6   30.50  864 912 94=
4 1024  486 489 494 500 +hsync -vsync (29.8 kHz d)
[   132.266] (II) modeset(0): Modeline "700x525"x60.0   61.00  700 744 82=
0 940  525 526 532 541 doublescan +hsync +vsync (64.9 kHz d)
[   132.266] (II) modeset(0): Modeline "800x450"x59.9   59.12  800 848 92=
8 1056  450 451 454 467 doublescan -hsync +vsync (56.0 kHz d)
[   132.266] (II) modeset(0): Modeline "800x450"x59.8   48.75  800 824 84=
0 880  450 451 454 463 doublescan +hsync -vsync (55.4 kHz d)
[   132.266] (II) modeset(0): Modeline "640x512"x60.0   54.00  640 664 72=
0 844  512 512 514 533 doublescan +hsync +vsync (64.0 kHz d)
[   132.266] (II) modeset(0): Modeline "700x450"x60.0   51.75  700 740 81=
2 924  450 451 456 467 doublescan -hsync +vsync (56.0 kHz d)
[   132.266] (II) modeset(0): Modeline "700x450"x59.9   43.25  700 724 74=
0 780  450 451 456 463 doublescan +hsync -vsync (55.4 kHz d)
[   132.266] (II) modeset(0): Modeline "640x480"x60.0   54.00  640 688 74=
4 900  480 480 482 500 doublescan +hsync +vsync (60.0 kHz d)
[   132.266] (II) modeset(0): Modeline "640x480"x59.9   25.18  640 656 75=
2 800  480 490 492 525 -hsync -vsync (31.5 kHz d)
[   132.266] (II) modeset(0): Modeline "720x405"x59.5   22.50  720 744 80=
8 896  405 408 413 422 -hsync +vsync (25.1 kHz d)
[   132.266] (II) modeset(0): Modeline "720x405"x59.0   21.75  720 768 80=
0 880  405 408 413 419 +hsync -vsync (24.7 kHz d)
[   132.266] (II) modeset(0): Modeline "684x384"x59.9   42.62  684 720 78=
8 892  384 385 390 399 doublescan -hsync +vsync (47.8 kHz d)
[   132.266] (II) modeset(0): Modeline "684x384"x59.9   36.12  684 708 72=
4 764  384 385 390 395 doublescan +hsync -vsync (47.3 kHz d)
[   132.266] (II) modeset(0): Modeline "640x400"x59.9   41.75  640 676 74=
0 840  400 401 404 415 doublescan -hsync +vsync (49.7 kHz d)
[   132.266] (II) modeset(0): Modeline "640x400"x60.0   35.50  640 664 68=
0 720  400 401 404 411 doublescan +hsync -vsync (49.3 kHz d)
[   132.266] (II) modeset(0): Modeline "640x360"x59.9   37.25  640 672 73=
6 832  360 361 364 374 doublescan -hsync +vsync (44.8 kHz d)
[   132.266] (II) modeset(0): Modeline "640x360"x59.8   31.88  640 664 68=
0 720  360 361 364 370 doublescan +hsync -vsync (44.3 kHz d)
[   132.266] (II) modeset(0): Modeline "640x360"x59.8   18.00  640 664 72=
0 800  360 363 368 376 -hsync +vsync (22.5 kHz d)
[   132.266] (II) modeset(0): Modeline "640x360"x59.3   17.75  640 688 72=
0 800  360 363 368 374 +hsync -vsync (22.2 kHz d)
[   132.266] (II) modeset(0): Modeline "512x384"x60.0   32.50  512 524 59=
2 672  384 385 388 403 doublescan -hsync -vsync (48.4 kHz d)
[   132.266] (II) modeset(0): Modeline "512x288"x60.0   23.25  512 532 58=
0 648  288 289 292 299 doublescan -hsync +vsync (35.9 kHz d)
[   132.266] (II) modeset(0): Modeline "512x288"x59.9   21.00  512 536 55=
2 592  288 289 292 296 doublescan +hsync -vsync (35.5 kHz d)
[   132.266] (II) modeset(0): Modeline "480x270"x59.6   20.38  480 496 54=
4 608  270 271 274 281 doublescan -hsync +vsync (33.5 kHz d)
[   132.266] (II) modeset(0): Modeline "480x270"x59.8   18.62  480 504 52=
0 560  270 271 274 278 doublescan +hsync -vsync (33.3 kHz d)
[   132.266] (II) modeset(0): Modeline "400x300"x60.3   20.00  400 420 48=
4 528  300 300 302 314 doublescan +hsync +vsync (37.9 kHz d)
[   132.266] (II) modeset(0): Modeline "400x300"x56.3   18.00  400 412 44=
8 512  300 300 301 312 doublescan +hsync +vsync (35.2 kHz d)
[   132.266] (II) modeset(0): Modeline "432x243"x59.9   16.25  432 444 48=
4 536  243 244 247 253 doublescan -hsync +vsync (30.3 kHz d)
[   132.266] (II) modeset(0): Modeline "432x243"x59.6   15.25  432 456 47=
2 512  243 244 247 250 doublescan +hsync -vsync (29.8 kHz d)
[   132.266] (II) modeset(0): Modeline "320x240"x60.1   12.59  320 328 37=
6 400  240 245 246 262 doublescan -hsync -vsync (31.5 kHz d)
[   132.266] (II) modeset(0): Modeline "360x202"x59.5   11.25  360 372 40=
4 448  202 204 206 211 doublescan -hsync +vsync (25.1 kHz d)
[   132.266] (II) modeset(0): Modeline "360x202"x59.1   10.88  360 384 40=
0 440  202 204 206 209 doublescan +hsync -vsync (24.7 kHz d)
[   132.266] (II) modeset(0): Modeline "320x180"x59.8    9.00  320 332 36=
0 400  180 181 184 188 doublescan -hsync +vsync (22.5 kHz d)
[   132.266] (II) modeset(0): Modeline "320x180"x59.3    8.88  320 344 36=
0 400  180 181 184 187 doublescan +hsync -vsync (22.2 kHz d)
[   132.266] (II) modeset(0): EDID for output DP-9
[   132.266] (II) modeset(0): Manufacturer: DEL  Model: 4093  Serial#: 80=
8858448
[   132.266] (II) modeset(0): Year: 2013  Week: 46
[   132.266] (II) modeset(0): EDID Version: 1.4
[   132.266] (II) modeset(0): Digital Display Input
[   132.267] (II) modeset(0): 10 bits per channel
[   132.267] (II) modeset(0): Digital interface is DisplayPort
[   132.267] (II) modeset(0): Max Image Size [cm]: horiz.: 70  vert.: 39
[   132.267] (II) modeset(0): Gamma: 2.20
[   132.267] (II) modeset(0): DPMS capabilities: Off
[   132.267] (II) modeset(0): Supported color encodings: RGB 4:4:4 YCrCb =
4:4:4 YCrCb 4:2:2
[   132.267] (II) modeset(0): First detailed timing is preferred mode
[   132.267] (II) modeset(0): Preferred mode is native pixel format and r=
efresh rate
[   132.267] (II) modeset(0): redX: 0.638 redY: 0.327   greenX: 0.211 gre=
enY: 0.714
[   132.267] (II) modeset(0): blueX: 0.151 blueY: 0.053   whiteX: 0.316 w=
hiteY: 0.324
[   132.267] (II) modeset(0): Supported established timings:
[   132.267] (II) modeset(0): 720x400@70Hz
[   132.267] (II) modeset(0): 640x480@60Hz
[   132.267] (II) modeset(0): 640x480@75Hz
[   132.267] (II) modeset(0): 800x600@60Hz
[   132.267] (II) modeset(0): 800x600@75Hz
[   132.267] (II) modeset(0): 1024x768@60Hz
[   132.267] (II) modeset(0): 1024x768@75Hz
[   132.267] (II) modeset(0): 1280x1024@75Hz
[   132.267] (II) modeset(0): Manufacturer's mask: 0
[   132.267] (II) modeset(0): Supported standard timings:
[   132.267] (II) modeset(0): #0: hsize: 1280  vsize 800  refresh: 60  vi=
d: 129
[   132.267] (II) modeset(0): #1: hsize: 1680  vsize 1050  refresh: 60  v=
id: 179
[   132.267] (II) modeset(0): #2: hsize: 1920  vsize 1200  refresh: 60  v=
id: 209
[   132.267] (II) modeset(0): #3: hsize: 1152  vsize 864  refresh: 75  vi=
d: 20337
[   132.267] (II) modeset(0): #4: hsize: 1600  vsize 1200  refresh: 60  v=
id: 16553
[   132.267] (II) modeset(0): #5: hsize: 1280  vsize 1024  refresh: 60  v=
id: 32897
[   132.267] (II) modeset(0): #6: hsize: 1920  vsize 1080  refresh: 60  v=
id: 49361
[   132.267] (II) modeset(0): Supported detailed timing:
[   132.267] (II) modeset(0): clock: 277.2 MHz   Image Size:  698 x 392 m=
m
[   132.267] (II) modeset(0): h_active: 1920  h_sync: 1968  h_sync_end 20=
00 h_blank_end 2080 h_border: 0
[   132.267] (II) modeset(0): v_active: 2160  v_sync: 2163  v_sync_end 21=
73 v_blanking: 2222 v_border: 0
[   132.267] (II) modeset(0): Serial No: K3R903BG063P
[   132.267] (II) modeset(0): Monitor name: DELL UP3214Q
[   132.267] (II) modeset(0): Ranges: V min: 29 V max: 75 Hz, H min: 31 H=
 max: 140 kHz, PixClock max 305 MHz
[   132.267] (II) modeset(0): Number of EDID sections to follow: 1
[   132.267] (II) modeset(0): EDID (in hex):
[   132.267] (II) modeset(0): 	00ffffffffffff0010ac934050333630
[   132.267] (II) modeset(0): 	2e170104b54627783a73e0a35336b626
[   132.267] (II) modeset(0): 	0d5153a54b008100b300d100714fa940
[   132.267] (II) modeset(0): 	8180d1c001014d6c80a070703e803020
[   132.267] (II) modeset(0): 	3a00ba882100001a000000ff004b3352
[   132.267] (II) modeset(0): 	3930334247303633500a000000fc0044
[   132.267] (II) modeset(0): 	454c4c20555033323134510a000000fd
[   132.267] (II) modeset(0): 	001d4b1f8c1e000a20202020202001cd
[   132.267] (II) modeset(0): 	7012790000120016821000007f076f08
[   132.267] (II) modeset(0): 	000000000044454c9340503336300000
[   132.267] (II) modeset(0): 	00000000000000000000000000000000
[   132.267] (II) modeset(0): 	00000000000000000000000000000000
[   132.267] (II) modeset(0): 	00000000000000000000000000000000
[   132.267] (II) modeset(0): 	00000000000000000000000000000000
[   132.267] (II) modeset(0): 	00000000000000000000000000000000
[   132.267] (II) modeset(0): 	00000000000000000000000000002d90
[   132.267] (II) modeset(0): Not using default mode "2048x1536" (bad mod=
e clock/interlace/doublescan)
[   132.267] (II) modeset(0): Not using default mode "1920x1080" (bad mod=
e clock/interlace/doublescan)
[   132.267] (II) modeset(0): Not using default mode "2048x1152" (bad mod=
e clock/interlace/doublescan)
[   132.267] (II) modeset(0): Printing probed modes for output DP-9
[   132.267] (II) modeset(0): Modeline "1920x2160"x60.0  277.25  1920 196=
8 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   132.267] (II) modeset(0): Modeline "2048x1536"x60.0  266.95  2048 220=
0 2424 2800  1536 1537 1540 1589 -hsync +vsync (95.3 kHz d)
[   132.267] (II) modeset(0): Modeline "1920x1440"x75.0  297.00  1920 206=
4 2288 2640  1440 1441 1444 1500 -hsync +vsync (112.5 kHz d)
[   132.267] (II) modeset(0): Modeline "1920x1440"x60.0  234.00  1920 204=
8 2256 2600  1440 1441 1444 1500 -hsync +vsync (90.0 kHz d)
[   132.267] (II) modeset(0): Modeline "1856x1392"x75.0  288.00  1856 198=
4 2208 2560  1392 1393 1396 1500 -hsync +vsync (112.5 kHz d)
[   132.267] (II) modeset(0): Modeline "1856x1392"x60.0  218.30  1856 195=
2 2176 2528  1392 1393 1396 1439 -hsync +vsync (86.4 kHz d)
[   132.267] (II) modeset(0): Modeline "1792x1344"x75.0  261.00  1792 188=
8 2104 2456  1344 1345 1348 1417 -hsync +vsync (106.3 kHz d)
[   132.267] (II) modeset(0): Modeline "1792x1344"x60.0  204.80  1792 192=
0 2120 2448  1344 1345 1348 1394 -hsync +vsync (83.7 kHz d)
[   132.267] (II) modeset(0): Modeline "2048x1152"x60.0  302.50  2048 207=
2 2088 2128  1152 1153 1156 1185 doublescan +hsync -vsync (142.2 kHz d)
[   132.267] (II) modeset(0): Modeline "2048x1152"x59.9  197.00  2048 218=
4 2400 2752  1152 1155 1160 1195 -hsync +vsync (71.6 kHz d)
[   132.267] (II) modeset(0): Modeline "2048x1152"x59.9  156.75  2048 209=
6 2128 2208  1152 1155 1160 1185 +hsync -vsync (71.0 kHz d)
[   132.267] (II) modeset(0): Modeline "1920x1200"x59.9  193.25  1920 205=
6 2256 2592  1200 1203 1209 1245 -hsync +vsync (74.6 kHz e)
[   132.267] (II) modeset(0): Modeline "1920x1200"x60.0  154.00  1920 196=
8 2000 2080  1200 1203 1209 1235 +hsync -vsync (74.0 kHz d)
[   132.267] (II) modeset(0): Modeline "1920x1080"x60.0  266.50  1920 194=
4 1960 2000  1080 1081 1084 1111 doublescan +hsync -vsync (133.2 kHz d)
[   132.267] (II) modeset(0): Modeline "1920x1080"x60.0  173.00  1920 204=
8 2248 2576  1080 1083 1088 1120 -hsync +vsync (67.2 kHz d)
[   132.267] (II) modeset(0): Modeline "1920x1080"x60.0  148.50  1920 200=
8 2052 2200  1080 1084 1089 1125 -hsync -vsync (67.5 kHz e)
[   132.267] (II) modeset(0): Modeline "1920x1080"x59.9  138.50  1920 196=
8 2000 2080  1080 1083 1088 1111 +hsync -vsync (66.6 kHz d)
[   132.267] (II) modeset(0): Modeline "1600x1200"x75.0  202.50  1600 166=
4 1856 2160  1200 1201 1204 1250 +hsync +vsync (93.8 kHz d)
[   132.267] (II) modeset(0): Modeline "1600x1200"x70.0  189.00  1600 166=
4 1856 2160  1200 1201 1204 1250 +hsync +vsync (87.5 kHz d)
[   132.267] (II) modeset(0): Modeline "1600x1200"x65.0  175.50  1600 166=
4 1856 2160  1200 1201 1204 1250 +hsync +vsync (81.2 kHz d)
[   132.267] (II) modeset(0): Modeline "1600x1200"x60.0  162.00  1600 166=
4 1856 2160  1200 1201 1204 1250 +hsync +vsync (75.0 kHz e)
[   132.267] (II) modeset(0): Modeline "1680x1050"x60.0  146.25  1680 178=
4 1960 2240  1050 1053 1059 1089 -hsync +vsync (65.3 kHz e)
[   132.267] (II) modeset(0): Modeline "1680x1050"x59.9  119.00  1680 172=
8 1760 1840  1050 1053 1059 1080 +hsync -vsync (64.7 kHz d)
[   132.267] (II) modeset(0): Modeline "1400x1050"x74.8  155.80  1400 146=
4 1784 1912  1050 1052 1064 1090 +hsync +vsync (81.5 kHz d)
[   132.267] (II) modeset(0): Modeline "1400x1050"x60.0  122.00  1400 148=
8 1640 1880  1050 1052 1064 1082 +hsync +vsync (64.9 kHz d)
[   132.267] (II) modeset(0): Modeline "1600x900"x60.0  246.00  1600 1728=
 1900 2200  900 901 904 932 doublescan -hsync +vsync (111.8 kHz d)
[   132.267] (II) modeset(0): Modeline "1600x900"x59.9  186.50  1600 1624=
 1640 1680  900 901 904 926 doublescan +hsync -vsync (111.0 kHz d)
[   132.267] (II) modeset(0): Modeline "1600x900"x59.9  118.25  1600 1696=
 1856 2112  900 903 908 934 -hsync +vsync (56.0 kHz d)
[   132.267] (II) modeset(0): Modeline "1600x900"x59.8   97.50  1600 1648=
 1680 1760  900 903 908 926 +hsync -vsync (55.4 kHz d)
[   132.267] (II) modeset(0): Modeline "1280x1024"x75.0  135.00  1280 129=
6 1440 1688  1024 1025 1028 1066 +hsync +vsync (80.0 kHz e)
[   132.267] (II) modeset(0): Modeline "1280x1024"x60.0  108.00  1280 132=
8 1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz e)
[   132.267] (II) modeset(0): Modeline "1400x900"x60.0  103.50  1400 1480=
 1624 1848  900 903 913 934 -hsync +vsync (56.0 kHz d)
[   132.267] (II) modeset(0): Modeline "1400x900"x59.9   86.50  1400 1448=
 1480 1560  900 903 913 926 +hsync -vsync (55.4 kHz d)
[   132.267] (II) modeset(0): Modeline "1280x960"x60.0  108.00  1280 1376=
 1488 1800  960 961 964 1000 +hsync +vsync (60.0 kHz d)
[   132.267] (II) modeset(0): Modeline "1440x810"x60.0  198.12  1440 1548=
 1704 1968  810 811 814 839 doublescan -hsync +vsync (100.7 kHz d)
[   132.267] (II) modeset(0): Modeline "1440x810"x60.0  151.88  1440 1464=
 1480 1520  810 811 814 833 doublescan +hsync -vsync (99.9 kHz d)
[   132.267] (II) modeset(0): Modeline "1368x768"x59.9   85.25  1368 1440=
 1576 1784  768 771 781 798 -hsync +vsync (47.8 kHz d)
[   132.267] (II) modeset(0): Modeline "1368x768"x59.9   72.25  1368 1416=
 1448 1528  768 771 781 790 +hsync -vsync (47.3 kHz d)
[   132.267] (II) modeset(0): Modeline "1280x800"x60.0  174.25  1280 1380=
 1516 1752  800 801 804 829 doublescan -hsync +vsync (99.5 kHz d)
[   132.267] (II) modeset(0): Modeline "1280x800"x60.0  134.25  1280 1304=
 1320 1360  800 801 804 823 doublescan +hsync -vsync (98.7 kHz d)
[   132.267] (II) modeset(0): Modeline "1280x800"x59.8   83.50  1280 1352=
 1480 1680  800 803 809 831 -hsync +vsync (49.7 kHz e)
[   132.267] (II) modeset(0): Modeline "1280x800"x59.9   71.00  1280 1328=
 1360 1440  800 803 809 823 +hsync -vsync (49.3 kHz d)
[   132.267] (II) modeset(0): Modeline "1152x864"x75.0  108.00  1152 1216=
 1344 1600  864 865 868 900 +hsync +vsync (67.5 kHz e)
[   132.267] (II) modeset(0): Modeline "1280x720"x60.0  156.12  1280 1376=
 1512 1744  720 721 724 746 doublescan -hsync +vsync (89.5 kHz d)
[   132.267] (II) modeset(0): Modeline "1280x720"x60.0  120.75  1280 1304=
 1320 1360  720 721 724 740 doublescan +hsync -vsync (88.8 kHz d)
[   132.267] (II) modeset(0): Modeline "1280x720"x59.9   74.50  1280 1344=
 1472 1664  720 723 728 748 -hsync +vsync (44.8 kHz d)
[   132.267] (II) modeset(0): Modeline "1280x720"x59.7   63.75  1280 1328=
 1360 1440  720 723 728 741 +hsync -vsync (44.3 kHz d)
[   132.267] (II) modeset(0): Modeline "1024x768"x75.0  170.24  1024 1108=
 1220 1416  768 768 770 801 doublescan -hsync +vsync (120.2 kHz d)
[   132.267] (II) modeset(0): Modeline "1024x768"x60.0  133.47  1024 1100=
 1212 1400  768 768 770 794 doublescan -hsync +vsync (95.3 kHz d)
[   132.267] (II) modeset(0): Modeline "1024x768"x75.0   78.75  1024 1040=
 1136 1312  768 769 772 800 +hsync +vsync (60.0 kHz e)
[   132.267] (II) modeset(0): Modeline "1024x768"x70.1   75.00  1024 1048=
 1184 1328  768 771 777 806 -hsync -vsync (56.5 kHz d)
[   132.267] (II) modeset(0): Modeline "1024x768"x60.0   65.00  1024 1048=
 1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz e)
[   132.267] (II) modeset(0): Modeline "960x720"x75.0  148.50  960 1032 1=
144 1320  720 720 722 750 doublescan -hsync +vsync (112.5 kHz d)
[   132.267] (II) modeset(0): Modeline "960x720"x60.0  117.00  960 1024 1=
128 1300  720 720 722 750 doublescan -hsync +vsync (90.0 kHz d)
[   132.267] (II) modeset(0): Modeline "928x696"x75.0  144.00  928 992 11=
04 1280  696 696 698 750 doublescan -hsync +vsync (112.5 kHz d)
[   132.267] (II) modeset(0): Modeline "928x696"x60.1  109.15  928 976 10=
88 1264  696 696 698 719 doublescan -hsync +vsync (86.4 kHz d)
[   132.267] (II) modeset(0): Modeline "896x672"x75.0  130.50  896 944 10=
52 1228  672 672 674 708 doublescan -hsync +vsync (106.3 kHz d)
[   132.267] (II) modeset(0): Modeline "896x672"x60.0  102.40  896 960 10=
60 1224  672 672 674 697 doublescan -hsync +vsync (83.7 kHz d)
[   132.267] (II) modeset(0): Modeline "1024x576"x60.0   98.50  1024 1092=
 1200 1376  576 577 580 597 doublescan -hsync +vsync (71.6 kHz d)
[   132.267] (II) modeset(0): Modeline "1024x576"x60.0   78.38  1024 1048=
 1064 1104  576 577 580 592 doublescan +hsync -vsync (71.0 kHz d)
[   132.267] (II) modeset(0): Modeline "1024x576"x59.9   46.50  1024 1064=
 1160 1296  576 579 584 599 -hsync +vsync (35.9 kHz d)
[   132.267] (II) modeset(0): Modeline "1024x576"x59.8   42.00  1024 1072=
 1104 1184  576 579 584 593 +hsync -vsync (35.5 kHz d)
[   132.267] (II) modeset(0): Modeline "960x600"x59.9   96.62  960 1028 1=
128 1296  600 601 604 622 doublescan -hsync +vsync (74.6 kHz d)
[   132.267] (II) modeset(0): Modeline "960x600"x60.0   77.00  960 984 10=
00 1040  600 601 604 617 doublescan +hsync -vsync (74.0 kHz d)
[   132.267] (II) modeset(0): Modeline "832x624"x74.6   57.28  832 864 92=
8 1152  624 625 628 667 -hsync -vsync (49.7 kHz d)
[   132.267] (II) modeset(0): Modeline "960x540"x60.0   86.50  960 1024 1=
124 1288  540 541 544 560 doublescan -hsync +vsync (67.2 kHz d)
[   132.267] (II) modeset(0): Modeline "960x540"x60.0   69.25  960 984 10=
00 1040  540 541 544 555 doublescan +hsync -vsync (66.6 kHz d)
[   132.267] (II) modeset(0): Modeline "960x540"x59.6   40.75  960 992 10=
88 1216  540 543 548 562 -hsync +vsync (33.5 kHz d)
[   132.267] (II) modeset(0): Modeline "960x540"x59.8   37.25  960 1008 1=
040 1120  540 543 548 556 +hsync -vsync (33.3 kHz d)
[   132.267] (II) modeset(0): Modeline "800x600"x75.0  101.25  800 832 92=
8 1080  600 600 602 625 doublescan +hsync +vsync (93.8 kHz d)
[   132.267] (II) modeset(0): Modeline "800x600"x70.0   94.50  800 832 92=
8 1080  600 600 602 625 doublescan +hsync +vsync (87.5 kHz d)
[   132.267] (II) modeset(0): Modeline "800x600"x65.0   87.75  800 832 92=
8 1080  600 600 602 625 doublescan +hsync +vsync (81.2 kHz d)
[   132.267] (II) modeset(0): Modeline "800x600"x60.0   81.00  800 832 92=
8 1080  600 600 602 625 doublescan +hsync +vsync (75.0 kHz d)
[   132.267] (II) modeset(0): Modeline "800x600"x72.2   50.00  800 856 97=
6 1040  600 637 643 666 +hsync +vsync (48.1 kHz d)
[   132.267] (II) modeset(0): Modeline "800x600"x75.0   49.50  800 816 89=
6 1056  600 601 604 625 +hsync +vsync (46.9 kHz e)
[   132.267] (II) modeset(0): Modeline "800x600"x60.3   40.00  800 840 96=
8 1056  600 601 605 628 +hsync +vsync (37.9 kHz e)
[   132.267] (II) modeset(0): Modeline "800x600"x56.2   36.00  800 824 89=
6 1024  600 601 603 625 +hsync +vsync (35.2 kHz d)
[   132.267] (II) modeset(0): Modeline "840x525"x60.0   73.12  840 892 98=
0 1120  525 526 529 544 doublescan -hsync +vsync (65.3 kHz d)
[   132.267] (II) modeset(0): Modeline "840x525"x59.9   59.50  840 864 88=
0 920  525 526 529 540 doublescan +hsync -vsync (64.7 kHz d)
[   132.267] (II) modeset(0): Modeline "864x486"x59.9   32.50  864 888 96=
8 1072  486 489 494 506 -hsync +vsync (30.3 kHz d)
[   132.267] (II) modeset(0): Modeline "864x486"x59.6   30.50  864 912 94=
4 1024  486 489 494 500 +hsync -vsync (29.8 kHz d)
[   132.267] (II) modeset(0): Modeline "700x525"x74.8   77.90  700 732 89=
2 956  525 526 532 545 doublescan +hsync +vsync (81.5 kHz d)
[   132.267] (II) modeset(0): Modeline "700x525"x60.0   61.00  700 744 82=
0 940  525 526 532 541 doublescan +hsync +vsync (64.9 kHz d)
[   132.267] (II) modeset(0): Modeline "800x450"x59.9   59.12  800 848 92=
8 1056  450 451 454 467 doublescan -hsync +vsync (56.0 kHz d)
[   132.267] (II) modeset(0): Modeline "800x450"x59.8   48.75  800 824 84=
0 880  450 451 454 463 doublescan +hsync -vsync (55.4 kHz d)
[   132.267] (II) modeset(0): Modeline "640x512"x75.0   67.50  640 648 72=
0 844  512 512 514 533 doublescan +hsync +vsync (80.0 kHz d)
[   132.267] (II) modeset(0): Modeline "640x512"x60.0   54.00  640 664 72=
0 844  512 512 514 533 doublescan +hsync +vsync (64.0 kHz d)
[   132.267] (II) modeset(0): Modeline "700x450"x60.0   51.75  700 740 81=
2 924  450 451 456 467 doublescan -hsync +vsync (56.0 kHz d)
[   132.267] (II) modeset(0): Modeline "700x450"x59.9   43.25  700 724 74=
0 780  450 451 456 463 doublescan +hsync -vsync (55.4 kHz d)
[   132.267] (II) modeset(0): Modeline "640x480"x60.0   54.00  640 688 74=
4 900  480 480 482 500 doublescan +hsync +vsync (60.0 kHz d)
[   132.267] (II) modeset(0): Modeline "640x480"x75.0   31.50  640 656 72=
0 840  480 481 484 500 -hsync -vsync (37.5 kHz e)
[   132.267] (II) modeset(0): Modeline "640x480"x72.8   31.50  640 664 70=
4 832  480 489 492 520 -hsync -vsync (37.9 kHz d)
[   132.267] (II) modeset(0): Modeline "640x480"x75.0   31.50  640 656 72=
0 840  480 481 484 500 -hsync -vsync (37.5 kHz d)
[   132.267] (II) modeset(0): Modeline "640x480"x59.9   25.18  640 656 75=
2 800  480 490 492 525 -hsync -vsync (31.5 kHz e)
[   132.267] (II) modeset(0): Modeline "720x405"x59.5   22.50  720 744 80=
8 896  405 408 413 422 -hsync +vsync (25.1 kHz d)
[   132.267] (II) modeset(0): Modeline "720x405"x59.0   21.75  720 768 80=
0 880  405 408 413 419 +hsync -vsync (24.7 kHz d)
[   132.267] (II) modeset(0): Modeline "720x400"x70.1   28.32  720 738 84=
6 900  400 412 414 449 -hsync +vsync (31.5 kHz e)
[   132.267] (II) modeset(0): Modeline "684x384"x59.9   42.62  684 720 78=
8 892  384 385 390 399 doublescan -hsync +vsync (47.8 kHz d)
[   132.267] (II) modeset(0): Modeline "684x384"x59.9   36.12  684 708 72=
4 764  384 385 390 395 doublescan +hsync -vsync (47.3 kHz d)
[   132.267] (II) modeset(0): Modeline "640x400"x59.9   41.75  640 676 74=
0 840  400 401 404 415 doublescan -hsync +vsync (49.7 kHz d)
[   132.267] (II) modeset(0): Modeline "640x400"x60.0   35.50  640 664 68=
0 720  400 401 404 411 doublescan +hsync -vsync (49.3 kHz d)
[   132.267] (II) modeset(0): Modeline "576x432"x75.0   54.00  576 608 67=
2 800  432 432 434 450 doublescan +hsync +vsync (67.5 kHz d)
[   132.267] (II) modeset(0): Modeline "640x360"x59.9   37.25  640 672 73=
6 832  360 361 364 374 doublescan -hsync +vsync (44.8 kHz d)
[   132.267] (II) modeset(0): Modeline "640x360"x59.8   31.88  640 664 68=
0 720  360 361 364 370 doublescan +hsync -vsync (44.3 kHz d)
[   132.267] (II) modeset(0): Modeline "640x360"x59.8   18.00  640 664 72=
0 800  360 363 368 376 -hsync +vsync (22.5 kHz d)
[   132.267] (II) modeset(0): Modeline "640x360"x59.3   17.75  640 688 72=
0 800  360 363 368 374 +hsync -vsync (22.2 kHz d)
[   132.267] (II) modeset(0): Modeline "512x384"x75.0   39.38  512 520 56=
8 656  384 384 386 400 doublescan +hsync +vsync (60.0 kHz d)
[   132.267] (II) modeset(0): Modeline "512x384"x70.1   37.50  512 524 59=
2 664  384 385 388 403 doublescan -hsync -vsync (56.5 kHz d)
[   132.267] (II) modeset(0): Modeline "512x384"x60.0   32.50  512 524 59=
2 672  384 385 388 403 doublescan -hsync -vsync (48.4 kHz d)
[   132.267] (II) modeset(0): Modeline "512x288"x60.0   23.25  512 532 58=
0 648  288 289 292 299 doublescan -hsync +vsync (35.9 kHz d)
[   132.267] (II) modeset(0): Modeline "512x288"x59.9   21.00  512 536 55=
2 592  288 289 292 296 doublescan +hsync -vsync (35.5 kHz d)
[   132.267] (II) modeset(0): Modeline "416x312"x74.7   28.64  416 432 46=
4 576  312 312 314 333 doublescan -hsync -vsync (49.7 kHz d)
[   132.267] (II) modeset(0): Modeline "480x270"x59.6   20.38  480 496 54=
4 608  270 271 274 281 doublescan -hsync +vsync (33.5 kHz d)
[   132.267] (II) modeset(0): Modeline "480x270"x59.8   18.62  480 504 52=
0 560  270 271 274 278 doublescan +hsync -vsync (33.3 kHz d)
[   132.267] (II) modeset(0): Modeline "400x300"x72.2   25.00  400 428 48=
8 520  300 318 321 333 doublescan +hsync +vsync (48.1 kHz d)
[   132.267] (II) modeset(0): Modeline "400x300"x75.1   24.75  400 408 44=
8 528  300 300 302 312 doublescan +hsync +vsync (46.9 kHz d)
[   132.267] (II) modeset(0): Modeline "400x300"x60.3   20.00  400 420 48=
4 528  300 300 302 314 doublescan +hsync +vsync (37.9 kHz d)
[   132.267] (II) modeset(0): Modeline "400x300"x56.3   18.00  400 412 44=
8 512  300 300 301 312 doublescan +hsync +vsync (35.2 kHz d)
[   132.267] (II) modeset(0): Modeline "432x243"x59.9   16.25  432 444 48=
4 536  243 244 247 253 doublescan -hsync +vsync (30.3 kHz d)
[   132.267] (II) modeset(0): Modeline "432x243"x59.6   15.25  432 456 47=
2 512  243 244 247 250 doublescan +hsync -vsync (29.8 kHz d)
[   132.267] (II) modeset(0): Modeline "320x240"x72.8   15.75  320 332 35=
2 416  240 244 246 260 doublescan -hsync -vsync (37.9 kHz d)
[   132.267] (II) modeset(0): Modeline "320x240"x75.0   15.75  320 328 36=
0 420  240 240 242 250 doublescan -hsync -vsync (37.5 kHz d)
[   132.267] (II) modeset(0): Modeline "320x240"x60.1   12.59  320 328 37=
6 400  240 245 246 262 doublescan -hsync -vsync (31.5 kHz d)
[   132.267] (II) modeset(0): Modeline "360x202"x59.5   11.25  360 372 40=
4 448  202 204 206 211 doublescan -hsync +vsync (25.1 kHz d)
[   132.267] (II) modeset(0): Modeline "360x202"x59.1   10.88  360 384 40=
0 440  202 204 206 209 doublescan +hsync -vsync (24.7 kHz d)
[   132.267] (II) modeset(0): Modeline "320x180"x59.8    9.00  320 332 36=
0 400  180 181 184 188 doublescan -hsync +vsync (22.5 kHz d)
[   132.267] (II) modeset(0): Modeline "320x180"x59.3    8.88  320 344 36=
0 400  180 181 184 187 doublescan +hsync -vsync (22.2 kHz d)
[   132.267] (II) modeset(0): Output DP-4 disconnected
[   132.267] (II) modeset(0): Output DP-5 disconnected
[   132.267] (II) modeset(0): Output DP-6 disconnected
[   132.267] (II) modeset(0): Output DP-7 disconnected
[   132.267] (II) modeset(0): Output DP-8 connected
[   132.267] (II) modeset(0): Output DP-9 connected
[   132.267] (II) modeset(0): Using spanning desktop for initial modes
[   132.267] (II) modeset(0): Output DP-8 using initial mode 1920x2160 +1=
920+0
[   132.267] (II) modeset(0): Output DP-9 using initial mode 1920x2160 +0=
+0
[   132.267] (=3D=3D) modeset(0): Using gamma correction (1.0, 1.0, 1.0)
[   132.267] (=3D=3D) modeset(0): DPI set to (96, 96)
[   132.267] (II) Loading sub module "fb"
[   132.267] (II) LoadModule: "fb"
[   132.267] (II) Loading /usr/lib/xorg/modules/libfb.so
[   132.268] (II) Module fb: vendor=3D"X.Org Foundation"
[   132.268] 	compiled for 1.20.4, module version =3D 1.0.0
[   132.268] 	ABI class: X.Org ANSI C Emulation, version 0.4
[   132.268] (=3D=3D) modeset(G0): Depth 24, (=3D=3D) framebuffer bpp 32
[   132.268] (=3D=3D) modeset(G0): RGB weight 888
[   132.268] (=3D=3D) modeset(G0): Default visual is TrueColor
[   132.268] (II) Loading sub module "glamoregl"
[   132.268] (II) LoadModule: "glamoregl"
[   132.268] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[   132.268] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[   132.268] 	compiled for 1.20.4, module version =3D 1.0.1
[   132.268] 	ABI class: X.Org ANSI C Emulation, version 0.4
[   132.272] (II) modeset(G0): glamor X acceleration enabled on Mesa DRI =
Intel(R) HD Graphics 630 (Kaby Lake GT2)=20
[   132.272] (II) modeset(G0): glamor initialized
[   132.277] (II) modeset(G0): Output HDMI-1-1 has no monitor section
[   132.277] (II) modeset(G0): Output DP-1-1 has no monitor section
[   132.281] (II) modeset(G0): Output HDMI-1-2 has no monitor section
[   132.282] (II) modeset(G0): Output DP-1-2 has no monitor section
[   132.287] (II) modeset(G0): Output HDMI-1-3 has no monitor section
[   132.287] (II) modeset(G0): Output DP-1-3 has no monitor section
[   132.292] (II) modeset(G0): EDID for output HDMI-1-1
[   132.292] (II) modeset(G0): EDID for output DP-1-1
[   132.297] (II) modeset(G0): EDID for output HDMI-1-2
[   132.298] (II) modeset(G0): EDID for output DP-1-2
[   132.302] (II) modeset(G0): EDID for output HDMI-1-3
[   132.303] (II) modeset(G0): EDID for output DP-1-3
[   132.303] (=3D=3D) modeset(G0): Using gamma correction (1.0, 1.0, 1.0)=

[   132.303] (=3D=3D) modeset(G0): DPI set to (96, 96)
[   132.303] (II) Loading sub module "fb"
[   132.303] (II) LoadModule: "fb"
[   132.303] (II) Loading /usr/lib/xorg/modules/libfb.so
[   132.303] (II) Module fb: vendor=3D"X.Org Foundation"
[   132.303] 	compiled for 1.20.4, module version =3D 1.0.0
[   132.303] 	ABI class: X.Org ANSI C Emulation, version 0.4
[   132.305] (=3D=3D) modeset(G0): Backing store enabled
[   132.305] (=3D=3D) modeset(G0): Silken mouse enabled
[   132.305] (II) modeset(G0): Initializing kms color map for depth 24, 8=
 bpc.
[   132.305] (=3D=3D) modeset(G0): DPMS enabled
[   132.305] (II) modeset(G0): [DRI2] Setup complete
[   132.305] (II) modeset(G0): [DRI2]   DRI driver: i965
[   132.305] (II) modeset(G0): [DRI2]   VDPAU driver: i965
[   132.306] (=3D=3D) modeset(0): Backing store enabled
[   132.306] (=3D=3D) modeset(0): Silken mouse enabled
[   132.307] (II) modeset(0): Initializing kms color map for depth 24, 8 =
bpc.
[   132.307] (=3D=3D) modeset(0): DPMS enabled
[   132.307] (II) modeset(0): [DRI2] Setup complete
[   132.307] (II) modeset(0): [DRI2]   DRI driver: radeonsi
[   132.307] (II) modeset(0): [DRI2]   VDPAU driver: radeonsi
[   132.307] (II) Initializing extension Generic Event Extension
[   132.307] (II) Initializing extension SHAPE
[   132.307] (II) Initializing extension MIT-SHM
[   132.307] (II) Initializing extension XInputExtension
[   132.307] (II) Initializing extension XTEST
[   132.307] (II) Initializing extension BIG-REQUESTS
[   132.307] (II) Initializing extension SYNC
[   132.307] (II) Initializing extension XKEYBOARD
[   132.307] (II) Initializing extension XC-MISC
[   132.307] (II) Initializing extension XFIXES
[   132.307] (II) Initializing extension RENDER
[   132.307] (II) Initializing extension RANDR
[   132.307] (II) Initializing extension COMPOSITE
[   132.307] (II) Initializing extension DAMAGE
[   132.307] (II) Initializing extension MIT-SCREEN-SAVER
[   132.307] (II) Initializing extension DOUBLE-BUFFER
[   132.307] (II) Initializing extension RECORD
[   132.307] (II) Initializing extension DPMS
[   132.307] (II) Initializing extension Present
[   132.307] (II) Initializing extension DRI3
[   132.307] (II) Initializing extension X-Resource
[   132.307] (II) Initializing extension XVideo
[   132.307] (II) Initializing extension XVideo-MotionCompensation
[   132.307] (II) Initializing extension GLX
[   132.310] (II) AIGLX: Loaded and initialized radeonsi
[   132.310] (II) GLX: Initialized DRI2 GL provider for screen 0
[   132.310] (II) Initializing extension XFree86-VidModeExtension
[   132.310] (II) Initializing extension XFree86-DGA
[   132.310] (II) Initializing extension XFree86-DRI
[   132.310] (II) Initializing extension DRI2
[   132.311] (II) modeset(G0): Damage tracking initialized
[   132.312] (II) modeset(0): Damage tracking initialized
[   132.312] (II) modeset(0): Setting screen physical size to 1016 x 571
[   132.352] (II) config/udev: Adding input device Power Button (/dev/inp=
ut/event2)
[   132.352] (**) Power Button: Applying InputClass "evdev keyboard catch=
all"
[   132.352] (II) LoadModule: "evdev"
[   132.352] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[   132.352] (II) Module evdev: vendor=3D"X.Org Foundation"
[   132.352] 	compiled for 1.19.6, module version =3D 2.10.5
[   132.352] 	Module class: X.Org XInput Driver
[   132.352] 	ABI class: X.Org XInput driver, version 24.1
[   132.352] (II) Using input driver 'evdev' for 'Power Button'
[   132.352] (**) Power Button: always reports core events
[   132.352] (**) evdev: Power Button: Device: "/dev/input/event2"
[   132.352] (--) evdev: Power Button: Vendor 0 Product 0x1
[   132.352] (--) evdev: Power Button: Found keys
[   132.352] (II) evdev: Power Button: Configuring as keyboard
[   132.352] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
PWRBN:00/input/input2/event2"
[   132.352] (II) XINPUT: Adding extended input device "Power Button" (ty=
pe: KEYBOARD, id 6)
[   132.352] (**) Option "xkb_rules" "evdev"
[   132.353] (II) config/udev: Adding input device Video Bus (/dev/input/=
event5)
[   132.353] (**) Video Bus: Applying InputClass "evdev keyboard catchall=
"
[   132.353] (II) Using input driver 'evdev' for 'Video Bus'
[   132.353] (**) Video Bus: always reports core events
[   132.353] (**) evdev: Video Bus: Device: "/dev/input/event5"
[   132.353] (--) evdev: Video Bus: Vendor 0 Product 0x6
[   132.353] (--) evdev: Video Bus: Found keys
[   132.353] (II) evdev: Video Bus: Configuring as keyboard
[   132.353] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input8/event5"
[   132.353] (II) XINPUT: Adding extended input device "Video Bus" (type:=
 KEYBOARD, id 7)
[   132.353] (**) Option "xkb_rules" "evdev"
[   132.353] (II) config/udev: Adding input device Power Button (/dev/inp=
ut/event1)
[   132.353] (**) Power Button: Applying InputClass "evdev keyboard catch=
all"
[   132.353] (II) Using input driver 'evdev' for 'Power Button'
[   132.353] (**) Power Button: always reports core events
[   132.353] (**) evdev: Power Button: Device: "/dev/input/event1"
[   132.353] (--) evdev: Power Button: Vendor 0 Product 0x1
[   132.353] (--) evdev: Power Button: Found keys
[   132.353] (II) evdev: Power Button: Configuring as keyboard
[   132.353] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0C0C:00/input/input1/event1"
[   132.353] (II) XINPUT: Adding extended input device "Power Button" (ty=
pe: KEYBOARD, id 8)
[   132.353] (**) Option "xkb_rules" "evdev"
[   132.353] (II) config/udev: Adding input device Sleep Button (/dev/inp=
ut/event0)
[   132.353] (**) Sleep Button: Applying InputClass "evdev keyboard catch=
all"
[   132.353] (II) Using input driver 'evdev' for 'Sleep Button'
[   132.353] (**) Sleep Button: always reports core events
[   132.353] (**) evdev: Sleep Button: Device: "/dev/input/event0"
[   132.354] (--) evdev: Sleep Button: Vendor 0 Product 0x3
[   132.354] (--) evdev: Sleep Button: Found keys
[   132.354] (II) evdev: Sleep Button: Configuring as keyboard
[   132.354] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0C0E:00/input/input0/event0"
[   132.354] (II) XINPUT: Adding extended input device "Sleep Button" (ty=
pe: KEYBOARD, id 9)
[   132.354] (**) Option "xkb_rules" "evdev"
[   132.354] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D7 (/dev/input/event7)
[   132.354] (II) No input driver specified, ignoring this device.
[   132.354] (II) This device may have been added with another device fil=
e.
[   132.354] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D8 (/dev/input/event8)
[   132.354] (II) No input driver specified, ignoring this device.
[   132.354] (II) This device may have been added with another device fil=
e.
[   132.354] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D9 (/dev/input/event9)
[   132.354] (II) No input driver specified, ignoring this device.
[   132.354] (II) This device may have been added with another device fil=
e.
[   132.355] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D10 (/dev/input/event10)
[   132.355] (II) No input driver specified, ignoring this device.
[   132.355] (II) This device may have been added with another device fil=
e.
[   132.355] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D11 (/dev/input/event11)
[   132.355] (II) No input driver specified, ignoring this device.
[   132.355] (II) This device may have been added with another device fil=
e.
[   132.355] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D3 (/dev/input/event6)
[   132.355] (II) No input driver specified, ignoring this device.
[   132.355] (II) This device may have been added with another device fil=
e.
[   132.355] (II) config/udev: Adding input device Dell Dell USB Entry Ke=
yboard (/dev/input/event3)
[   132.355] (**) Dell Dell USB Entry Keyboard: Applying InputClass "evde=
v keyboard catchall"
[   132.355] (II) Using input driver 'evdev' for 'Dell Dell USB Entry Key=
board'
[   132.355] (**) Dell Dell USB Entry Keyboard: always reports core event=
s
[   132.355] (**) evdev: Dell Dell USB Entry Keyboard: Device: "/dev/inpu=
t/event3"
[   132.355] (--) evdev: Dell Dell USB Entry Keyboard: Vendor 0x413c Prod=
uct 0x2107
[   132.355] (--) evdev: Dell Dell USB Entry Keyboard: Found keys
[   132.355] (II) evdev: Dell Dell USB Entry Keyboard: Configuring as key=
board
[   132.355] (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000=
:00:14.0/usb1/1-4/1-4:1.0/0003:413C:2107.0002/input/input6/event3"
[   132.355] (II) XINPUT: Adding extended input device "Dell Dell USB Ent=
ry Keyboard" (type: KEYBOARD, id 10)
[   132.355] (**) Option "xkb_rules" "evdev"
[   132.356] (II) config/udev: Adding input device Logitech USB Optical M=
ouse (/dev/input/event4)
[   132.356] (**) Logitech USB Optical Mouse: Applying InputClass "evdev =
pointer catchall"
[   132.356] (II) Using input driver 'evdev' for 'Logitech USB Optical Mo=
use'
[   132.356] (**) Logitech USB Optical Mouse: always reports core events
[   132.356] (**) evdev: Logitech USB Optical Mouse: Device: "/dev/input/=
event4"
[   132.356] (--) evdev: Logitech USB Optical Mouse: Vendor 0x46d Product=
 0xc05a
[   132.356] (--) evdev: Logitech USB Optical Mouse: Found 12 mouse butto=
ns
[   132.356] (--) evdev: Logitech USB Optical Mouse: Found scroll wheel(s=
)
[   132.356] (--) evdev: Logitech USB Optical Mouse: Found relative axes
[   132.356] (--) evdev: Logitech USB Optical Mouse: Found x and y relati=
ve axes
[   132.356] (II) evdev: Logitech USB Optical Mouse: Configuring as mouse=

[   132.356] (II) evdev: Logitech USB Optical Mouse: Adding scrollwheel s=
upport
[   132.356] (**) evdev: Logitech USB Optical Mouse: YAxisMapping: button=
s 4 and 5
[   132.356] (**) evdev: Logitech USB Optical Mouse: EmulateWheelButton: =
4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[   132.356] (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000=
:00:14.0/usb1/1-5/1-5:1.0/0003:046D:C05A.0003/input/input7/event4"
[   132.356] (II) XINPUT: Adding extended input device "Logitech USB Opti=
cal Mouse" (type: MOUSE, id 11)
[   132.356] (II) evdev: Logitech USB Optical Mouse: initialized for rela=
tive axes.
[   132.356] (**) Logitech USB Optical Mouse: (accel) keeping acceleratio=
n scheme 1
[   132.356] (**) Logitech USB Optical Mouse: (accel) acceleration profil=
e 0
[   132.356] (**) Logitech USB Optical Mouse: (accel) acceleration factor=
: 2.000
[   132.356] (**) Logitech USB Optical Mouse: (accel) acceleration thresh=
old: 4
[   132.356] (II) config/udev: Adding input device HDA Intel PCH Front Mi=
c (/dev/input/event12)
[   132.356] (II) No input driver specified, ignoring this device.
[   132.356] (II) This device may have been added with another device fil=
e.
[   132.356] (II) config/udev: Adding input device HDA Intel PCH Rear Mic=
 (/dev/input/event13)
[   132.356] (II) No input driver specified, ignoring this device.
[   132.356] (II) This device may have been added with another device fil=
e.
[   132.356] (II) config/udev: Adding input device HDA Intel PCH Line Out=
 (/dev/input/event14)
[   132.356] (II) No input driver specified, ignoring this device.
[   132.356] (II) This device may have been added with another device fil=
e.
[   132.357] (II) config/udev: Adding input device HDA Intel PCH Front He=
adphone (/dev/input/event15)
[   132.357] (II) No input driver specified, ignoring this device.
[   132.357] (II) This device may have been added with another device fil=
e.
[   132.357] (II) config/udev: Adding input device HDA Intel PCH HDMI/DP,=
pcm=3D3 (/dev/input/event16)
[   132.357] (II) No input driver specified, ignoring this device.
[   132.357] (II) This device may have been added with another device fil=
e.
[   132.357] (II) config/udev: Adding input device HDA Intel PCH HDMI/DP,=
pcm=3D7 (/dev/input/event17)
[   132.357] (II) No input driver specified, ignoring this device.
[   132.357] (II) This device may have been added with another device fil=
e.
[   132.357] (II) config/udev: Adding input device HDA Intel PCH HDMI/DP,=
pcm=3D8 (/dev/input/event18)
[   132.357] (II) No input driver specified, ignoring this device.
[   132.357] (II) This device may have been added with another device fil=
e.
[   132.357] (II) config/udev: Adding input device HDA Intel PCH HDMI/DP,=
pcm=3D9 (/dev/input/event19)
[   132.357] (II) No input driver specified, ignoring this device.
[   132.357] (II) This device may have been added with another device fil=
e.
[   132.357] (II) config/udev: Adding input device HDA Intel PCH HDMI/DP,=
pcm=3D10 (/dev/input/event20)
[   132.357] (II) No input driver specified, ignoring this device.
[   132.357] (II) This device may have been added with another device fil=
e.
[   132.430] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   132.430] (II) modeset(0): Using EDID range info for horizontal sync
[   132.430] (II) modeset(0): Using EDID range info for vertical refresh
[   132.430] (II) modeset(0): Printing DDC gathered Modelines:
[   132.430] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   132.705] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   132.705] (II) modeset(0): Using hsync ranges from config file
[   132.705] (II) modeset(0): Using vrefresh ranges from config file
[   132.705] (II) modeset(0): Printing DDC gathered Modelines:
[   132.705] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   132.818] (II) modeset(0): Disabling kernel dirty updates, not require=
d.
[   138.191] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.191] (II) modeset(0): Using hsync ranges from config file
[   138.191] (II) modeset(0): Using vrefresh ranges from config file
[   138.191] (II) modeset(0): Printing DDC gathered Modelines:
[   138.191] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.192] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.192] (II) modeset(0): Using hsync ranges from config file
[   138.192] (II) modeset(0): Using vrefresh ranges from config file
[   138.192] (II) modeset(0): Printing DDC gathered Modelines:
[   138.192] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.193] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.193] (II) modeset(0): Using hsync ranges from config file
[   138.193] (II) modeset(0): Using vrefresh ranges from config file
[   138.193] (II) modeset(0): Printing DDC gathered Modelines:
[   138.193] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.990] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.990] (II) modeset(0): Using hsync ranges from config file
[   138.990] (II) modeset(0): Using vrefresh ranges from config file
[   138.990] (II) modeset(0): Printing DDC gathered Modelines:
[   138.990] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.991] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.991] (II) modeset(0): Using hsync ranges from config file
[   138.991] (II) modeset(0): Using vrefresh ranges from config file
[   138.991] (II) modeset(0): Printing DDC gathered Modelines:
[   138.991] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.993] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.993] (II) modeset(0): Using hsync ranges from config file
[   138.993] (II) modeset(0): Using vrefresh ranges from config file
[   138.993] (II) modeset(0): Printing DDC gathered Modelines:
[   138.993] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.994] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.994] (II) modeset(0): Using hsync ranges from config file
[   138.994] (II) modeset(0): Using vrefresh ranges from config file
[   138.994] (II) modeset(0): Printing DDC gathered Modelines:
[   138.994] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.995] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.995] (II) modeset(0): Using hsync ranges from config file
[   138.995] (II) modeset(0): Using vrefresh ranges from config file
[   138.995] (II) modeset(0): Printing DDC gathered Modelines:
[   138.995] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.996] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.996] (II) modeset(0): Using hsync ranges from config file
[   138.996] (II) modeset(0): Using vrefresh ranges from config file
[   138.996] (II) modeset(0): Printing DDC gathered Modelines:
[   138.996] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.997] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.997] (II) modeset(0): Using hsync ranges from config file
[   138.997] (II) modeset(0): Using vrefresh ranges from config file
[   138.997] (II) modeset(0): Printing DDC gathered Modelines:
[   138.997] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.998] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.998] (II) modeset(0): Using hsync ranges from config file
[   138.998] (II) modeset(0): Using vrefresh ranges from config file
[   138.998] (II) modeset(0): Printing DDC gathered Modelines:
[   138.998] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   138.999] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   138.999] (II) modeset(0): Using hsync ranges from config file
[   138.999] (II) modeset(0): Using vrefresh ranges from config file
[   138.999] (II) modeset(0): Printing DDC gathered Modelines:
[   138.999] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   139.000] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   139.000] (II) modeset(0): Using hsync ranges from config file
[   139.000] (II) modeset(0): Using vrefresh ranges from config file
[   139.000] (II) modeset(0): Printing DDC gathered Modelines:
[   139.000] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   139.113] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.113] (EE) modeset(0): present flip failed
[   139.125] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.125] (EE) modeset(0): present flip failed
[   139.158] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.158] (EE) modeset(0): present flip failed
[   139.184] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.184] (EE) modeset(0): present flip failed
[   139.209] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.209] (EE) modeset(0): present flip failed
[   139.230] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.230] (EE) modeset(0): present flip failed
[   139.245] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.245] (EE) modeset(0): present flip failed
[   139.261] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.261] (EE) modeset(0): present flip failed
[   139.296] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.296] (EE) modeset(0): present flip failed
[   139.308] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.308] (EE) modeset(0): present flip failed
[   139.496] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.496] (EE) modeset(0): present flip failed
[   139.539] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.539] (EE) modeset(0): present flip failed
[   139.562] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.562] (EE) modeset(0): present flip failed
[   139.611] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.611] (EE) modeset(0): present flip failed
[   139.630] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.630] (EE) modeset(0): present flip failed
[   139.652] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.652] (EE) modeset(0): present flip failed
[   139.669] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.669] (EE) modeset(0): present flip failed
[   139.686] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.686] (EE) modeset(0): present flip failed
[   139.702] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.702] (EE) modeset(0): present flip failed
[   139.718] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.718] (EE) modeset(0): present flip failed
[   139.735] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.735] (EE) modeset(0): present flip failed
[   139.753] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.753] (EE) modeset(0): present flip failed
[   139.768] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.768] (EE) modeset(0): present flip failed
[   139.785] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.785] (EE) modeset(0): present flip failed
[   139.802] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.802] (EE) modeset(0): present flip failed
[   139.819] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   139.819] (EE) modeset(0): present flip failed
[   143.102] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   143.102] (EE) modeset(0): present flip failed
[   143.120] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   143.120] (EE) modeset(0): present flip failed
[   143.140] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   143.140] (EE) modeset(0): present flip failed
[   143.157] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   143.157] (EE) modeset(0): present flip failed
[   145.964] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   145.964] (EE) modeset(0): present flip failed
[   146.187] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   146.187] (EE) modeset(0): present flip failed
[   146.379] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   146.379] (EE) modeset(0): present flip failed
[   146.443] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   146.443] (EE) modeset(0): present flip failed
[   146.474] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   146.474] (EE) modeset(0): present flip failed
[   146.787] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   146.787] (EE) modeset(0): present flip failed
[   146.993] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   146.993] (II) modeset(0): Using hsync ranges from config file
[   146.993] (II) modeset(0): Using vrefresh ranges from config file
[   146.993] (II) modeset(0): Printing DDC gathered Modelines:
[   146.993] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   146.994] (II) modeset(0): EDID vendor "DEL", prod id 16531
[   146.994] (II) modeset(0): Using hsync ranges from config file
[   146.994] (II) modeset(0): Using vrefresh ranges from config file
[   146.994] (II) modeset(0): Printing DDC gathered Modelines:
[   146.994] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[   147.013] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   147.013] (EE) modeset(0): present flip failed
[   147.029] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   147.029] (EE) modeset(0): present flip failed
[   149.235] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   149.236] (EE) modeset(0): present flip failed
[   151.493] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   151.493] (EE) modeset(0): present flip failed
[   151.509] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   151.509] (EE) modeset(0): present flip failed
[   151.891] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   151.891] (EE) modeset(0): present flip failed
[   152.067] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   152.067] (EE) modeset(0): present flip failed
[   152.179] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   152.179] (EE) modeset(0): present flip failed
[   152.260] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   152.260] (EE) modeset(0): present flip failed
[   152.291] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   152.291] (EE) modeset(0): present flip failed
[   152.791] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   152.791] (EE) modeset(0): present flip failed
[   152.818] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   152.818] (EE) modeset(0): present flip failed
[   154.347] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   154.347] (EE) modeset(0): present flip failed
[   154.368] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   154.368] (EE) modeset(0): present flip failed
[   154.426] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   154.426] (EE) modeset(0): present flip failed
[   156.380] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   156.380] (EE) modeset(0): present flip failed
[   156.555] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   156.555] (EE) modeset(0): present flip failed
[   156.635] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   156.635] (EE) modeset(0): present flip failed
[   156.787] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   156.787] (EE) modeset(0): present flip failed
[   156.859] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   156.859] (EE) modeset(0): present flip failed
[   156.931] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   156.931] (EE) modeset(0): present flip failed
[   156.962] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   156.962] (EE) modeset(0): present flip failed
[   157.148] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   157.148] (EE) modeset(0): present flip failed
[   157.892] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   157.892] (EE) modeset(0): present flip failed
[   158.123] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   158.123] (EE) modeset(0): present flip failed
[   158.623] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   158.623] (EE) modeset(0): present flip failed
[   158.654] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   158.654] (EE) modeset(0): present flip failed
[   158.723] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   158.723] (EE) modeset(0): present flip failed
[   158.754] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   158.754] (EE) modeset(0): present flip failed
[   158.823] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   158.823] (EE) modeset(0): present flip failed
[   158.854] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   158.854] (EE) modeset(0): present flip failed
[   158.923] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   158.923] (EE) modeset(0): present flip failed
[   158.953] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   158.953] (EE) modeset(0): present flip failed
[   159.024] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   159.024] (EE) modeset(0): present flip failed
[   159.054] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   159.054] (EE) modeset(0): present flip failed
[   159.125] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   159.125] (EE) modeset(0): present flip failed
[   159.155] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   159.155] (EE) modeset(0): present flip failed
[   159.225] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   159.225] (EE) modeset(0): present flip failed
[   159.256] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   159.256] (EE) modeset(0): present flip failed
[   159.467] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   159.467] (EE) modeset(0): present flip failed
[   159.924] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   159.924] (EE) modeset(0): present flip failed
[   160.044] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   160.044] (EE) modeset(0): present flip failed
[   160.235] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   160.235] (EE) modeset(0): present flip failed
[   160.331] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   160.331] (EE) modeset(0): present flip failed
[   160.643] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   160.643] (EE) modeset(0): present flip failed
[   160.835] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   160.835] (EE) modeset(0): present flip failed
[   161.459] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   161.459] (EE) modeset(0): present flip failed
[   161.764] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   161.764] (EE) modeset(0): present flip failed
[   161.940] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   161.940] (EE) modeset(0): present flip failed
[   162.179] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   162.179] (EE) modeset(0): present flip failed
[   162.259] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   162.259] (EE) modeset(0): present flip failed
[   162.494] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   162.495] (EE) modeset(0): present flip failed
[   162.517] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   162.517] (EE) modeset(0): present flip failed
[   166.188] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   166.188] (EE) modeset(0): present flip failed
[   167.179] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   167.179] (EE) modeset(0): present flip failed
[   169.539] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   169.539] (EE) modeset(0): present flip failed
[   169.636] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   169.636] (EE) modeset(0): present flip failed
[   171.395] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   171.395] (EE) modeset(0): present flip failed
[   171.923] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   171.923] (EE) modeset(0): present flip failed
[   172.131] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   172.131] (EE) modeset(0): present flip failed
[   172.291] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   172.291] (EE) modeset(0): present flip failed
[   172.443] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   172.443] (EE) modeset(0): present flip failed
[   172.595] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   172.595] (EE) modeset(0): present flip failed
[   173.095] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   173.095] (EE) modeset(0): present flip failed
[   173.125] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   173.125] (EE) modeset(0): present flip failed
[   173.194] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   173.194] (EE) modeset(0): present flip failed
[   173.225] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   173.225] (EE) modeset(0): present flip failed
[   173.296] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   173.296] (EE) modeset(0): present flip failed
[   173.326] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   173.326] (EE) modeset(0): present flip failed
[   173.396] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   173.396] (EE) modeset(0): present flip failed
[   173.667] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   173.667] (EE) modeset(0): present flip failed
[   173.859] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   173.859] (EE) modeset(0): present flip failed
[   174.139] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   174.139] (EE) modeset(0): present flip failed
[   174.332] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   174.332] (EE) modeset(0): present flip failed
[   174.484] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   174.484] (EE) modeset(0): present flip failed
[   174.644] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   174.644] (EE) modeset(0): present flip failed
[   174.803] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   174.803] (EE) modeset(0): present flip failed
[   174.956] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   174.956] (EE) modeset(0): present flip failed
[   175.275] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   175.275] (EE) modeset(0): present flip failed
[   175.379] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   175.379] (EE) modeset(0): present flip failed
[   175.484] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   175.484] (EE) modeset(0): present flip failed
[   175.595] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   175.595] (EE) modeset(0): present flip failed
[   175.811] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   175.811] (EE) modeset(0): present flip failed
[   175.955] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   175.955] (EE) modeset(0): present flip failed
[   176.044] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   176.044] (EE) modeset(0): present flip failed
[   176.187] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   176.187] (EE) modeset(0): present flip failed
[   176.252] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   176.252] (EE) modeset(0): present flip failed
[   176.355] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   176.355] (EE) modeset(0): present flip failed
[   176.443] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[   176.443] (EE) modeset(0): present flip failed

--------------B96CA39EC077B3A65E8E965D
Content-Type: text/plain; charset=UTF-8;
 name="=?UTF-8?Q?20190306=e2=80=93linux-4.20.13=e2=80=93messages.txt?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0*=utf-8''%32%30%31%39%30%33%30%36%E2%80%93%6C%69%6E%75%78%2D%34;
 filename*1*=%2E%32%30%2E%31%33%E2%80%93%6D%65%73%73%61%67%65%73%2E%74%78;
 filename*2*=%74

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA0LjIwLjEzLm14NjQuMjQ4IChyb290QGhv
bGlkYXlpbmNhbWJvZGlhLm1vbGdlbi5tcGcuZGUpIChnY2MgdmVyc2lvbiA3LjMuMCAoR0ND
KSkgIzEgU01QIFdlZCBGZWIgMjcgMTQ6MTA6NTUgQ0VUIDIwMTkKWyAgICAwLjAwMDAwMF0g
Q29tbWFuZCBsaW5lOiBCT09UX0lNQUdFPS9ib290L2J6SW1hZ2UtNC4yMC4xMy5teDY0LjI0
OCBjcmFzaGtlcm5lbD0yNTZNIHJvb3Q9TEFCRUw9cm9vdCBybyBjb25zb2xlPXR0eVMxLDEx
NTIwMG44IGNvbnNvbGU9dHR5MCBpbml0PS9iaW4vc3lzdGVtZCBhdWRpdD0wClsgICAgMC4w
MDAwMDBdIHg4Ni9mcHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwMTogJ3g4NyBm
bG9hdGluZyBwb2ludCByZWdpc3RlcnMnClsgICAgMC4wMDAwMDBdIHg4Ni9mcHU6IFN1cHBv
cnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwMjogJ1NTRSByZWdpc3RlcnMnClsgICAgMC4wMDAw
MDBdIHg4Ni9mcHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVhdHVyZSAweDAwNDogJ0FWWCByZWdp
c3RlcnMnClsgICAgMC4wMDAwMDBdIHg4Ni9mcHU6IFN1cHBvcnRpbmcgWFNBVkUgZmVhdHVy
ZSAweDAwODogJ01QWCBib3VuZHMgcmVnaXN0ZXJzJwpbICAgIDAuMDAwMDAwXSB4ODYvZnB1
OiBTdXBwb3J0aW5nIFhTQVZFIGZlYXR1cmUgMHgwMTA6ICdNUFggQ1NSJwpbICAgIDAuMDAw
MDAwXSB4ODYvZnB1OiB4c3RhdGVfb2Zmc2V0WzJdOiAgNTc2LCB4c3RhdGVfc2l6ZXNbMl06
ICAyNTYKWyAgICAwLjAwMDAwMF0geDg2L2ZwdTogeHN0YXRlX29mZnNldFszXTogIDgzMiwg
eHN0YXRlX3NpemVzWzNdOiAgIDY0ClsgICAgMC4wMDAwMDBdIHg4Ni9mcHU6IHhzdGF0ZV9v
ZmZzZXRbNF06ICA4OTYsIHhzdGF0ZV9zaXplc1s0XTogICA2NApbICAgIDAuMDAwMDAwXSB4
ODYvZnB1OiBFbmFibGVkIHhzdGF0ZSBmZWF0dXJlcyAweDFmLCBjb250ZXh0IHNpemUgaXMg
OTYwIGJ5dGVzLCB1c2luZyAnY29tcGFjdGVkJyBmb3JtYXQuClsgICAgMC4wMDAwMDBdIEJJ
T1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoKWyAgICAwLjAwMDAwMF0gQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDAwMDAwMDAwMC0weDAwMDAwMDAwMDAwOTAzZmZdIHVzYWJsZQpb
ICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMDkwNDAwLTB4MDAw
MDAwMDAwMDA5ZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVt
IDB4MDAwMDAwMDAwMDBlMDAwMC0weDAwMDAwMDAwMDAwZmZmZmZdIHJlc2VydmVkClsgICAg
MC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwMDAxMDAwMDAtMHgwMDAwMDAw
MGFiYzY3ZmZmXSB1c2FibGUKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAw
MDAwMDBhYmM2ODAwMC0weDAwMDAwMDAwYWJjNjhmZmZdIEFDUEkgTlZTClsgICAgMC4wMDAw
MDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwYWJjNjkwMDAtMHgwMDAwMDAwMGFiYzY5
ZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAw
MGFiYzZhMDAwLTB4MDAwMDAwMDBiYTAwZGZmZl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIEJJ
T1MtZTgyMDogW21lbSAweDAwMDAwMDAwYmEwMGUwMDAtMHgwMDAwMDAwMGJiNjdmZmZmXSBy
ZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGJiNjgw
MDAwLTB4MDAwMDAwMDBiYjZkNWZmZl0gQUNQSSBkYXRhClsgICAgMC4wMDAwMDBdIEJJT1Mt
ZTgyMDogW21lbSAweDAwMDAwMDAwYmI2ZDYwMDAtMHgwMDAwMDAwMGJjMDA5ZmZmXSBBQ1BJ
IE5WUwpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGJjMDBhMDAw
LTB4MDAwMDAwMDBiYzVmZWZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDBiYzVmZjAwMC0weDAwMDAwMDAwYmM1ZmZmZmZdIHVzYWJsZQpb
ICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGJjNjAwMDAwLTB4MDAw
MDAwMDBiZmZmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVt
IDB4MDAwMDAwMDBmMDAwMDAwMC0weDAwMDAwMDAwZjdmZmZmZmZdIHJlc2VydmVkClsgICAg
MC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwZmUwMDAwMDAtMHgwMDAwMDAw
MGZlMDEwZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgw
MDAwMDAwMGZlYzAwMDAwLTB4MDAwMDAwMDBmZWMwMGZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAw
MDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZWUwMDAwMC0weDAwMDAwMDAwZmVl
MDBmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAw
MDAwZmYwMDAwMDAtMHgwMDAwMDAwMGZmZmZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAw
XSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4MDAwMDAwMDgzZGZmZmZm
Zl0gdXNhYmxlClsgICAgMC4wMDAwMDBdIE5YIChFeGVjdXRlIERpc2FibGUpIHByb3RlY3Rp
b246IGFjdGl2ZQpbICAgIDAuMDAwMDAwXSBTTUJJT1MgMy4wLjAgcHJlc2VudC4KWyAgICAw
LjAwMDAwMF0gRE1JOiBEZWxsIEluYy4gUHJlY2lzaW9uIFRvd2VyIDM2MjAvME1XWVBULCBC
SU9TIDIuMTEuMCAwNy8xOC8yMDE4ClsgICAgMC4wMDAwMDBdIHRzYzogRGV0ZWN0ZWQgMzYw
MC4wMDAgTUh6IHByb2Nlc3NvcgpbICAgIDAuMDAxNjYxXSBlODIwOiB1cGRhdGUgW21lbSAw
eDAwMDAwMDAwLTB4MDAwMDBmZmZdIHVzYWJsZSA9PT4gcmVzZXJ2ZWQKWyAgICAwLjAwMTY2
Ml0gZTgyMDogcmVtb3ZlIFttZW0gMHgwMDBhMDAwMC0weDAwMGZmZmZmXSB1c2FibGUKWyAg
ICAwLjAwMTY2Nl0gbGFzdF9wZm4gPSAweDgzZTAwMCBtYXhfYXJjaF9wZm4gPSAweDQwMDAw
MDAwMApbICAgIDAuMDAxNjY4XSBNVFJSIGRlZmF1bHQgdHlwZTogd3JpdGUtYmFjawpbICAg
IDAuMDAxNjY5XSBNVFJSIGZpeGVkIHJhbmdlcyBlbmFibGVkOgpbICAgIDAuMDAxNjY5XSAg
IDAwMDAwLTlGRkZGIHdyaXRlLWJhY2sKWyAgICAwLjAwMTY3MF0gICBBMDAwMC1CRkZGRiB1
bmNhY2hhYmxlClsgICAgMC4wMDE2NzBdICAgQzAwMDAtRkZGRkYgd3JpdGUtcHJvdGVjdApb
ICAgIDAuMDAxNjcxXSBNVFJSIHZhcmlhYmxlIHJhbmdlcyBlbmFibGVkOgpbICAgIDAuMDAx
NjcyXSAgIDAgYmFzZSAwMEMwMDAwMDAwIG1hc2sgN0ZDMDAwMDAwMCB1bmNhY2hhYmxlClsg
ICAgMC4wMDE2NzJdICAgMSBiYXNlIDAwQkUwMDAwMDAgbWFzayA3RkZFMDAwMDAwIHVuY2Fj
aGFibGUKWyAgICAwLjAwMTY3Ml0gICAyIGJhc2UgMDBCRDgwMDAwMCBtYXNrIDdGRkY4MDAw
MDAgdW5jYWNoYWJsZQpbICAgIDAuMDAxNjczXSAgIDMgZGlzYWJsZWQKWyAgICAwLjAwMTY3
M10gICA0IGRpc2FibGVkClsgICAgMC4wMDE2NzNdICAgNSBkaXNhYmxlZApbICAgIDAuMDAx
NjczXSAgIDYgZGlzYWJsZWQKWyAgICAwLjAwMTY3NF0gICA3IGRpc2FibGVkClsgICAgMC4w
MDE2NzRdICAgOCBkaXNhYmxlZApbICAgIDAuMDAxNjc0XSAgIDkgZGlzYWJsZWQKWyAgICAw
LjAwMjU0N10geDg2L1BBVDogQ29uZmlndXJhdGlvbiBbMC03XTogV0IgIFdDICBVQy0gVUMg
IFdCICBXUCAgVUMtIFdUICAKWyAgICAwLjAwMzA3MF0gbGFzdF9wZm4gPSAweGJjNjAwIG1h
eF9hcmNoX3BmbiA9IDB4NDAwMDAwMDAwClsgICAgMC4wMDgwNThdIGZvdW5kIFNNUCBNUC10
YWJsZSBhdCBbbWVtIDB4MDAwZmNlODAtMHgwMDBmY2U4Zl0gbWFwcGVkIGF0IFsoX19fX3B0
cnZhbF9fX18pXQpbICAgIDAuMDA4MDY0XSBCYXNlIG1lbW9yeSB0cmFtcG9saW5lIGF0IFso
X19fX3B0cnZhbF9fX18pXSA4YTAwMCBzaXplIDI0NTc2ClsgICAgMC4wMDgwNjddIFVzaW5n
IEdCIHBhZ2VzIGZvciBkaXJlY3QgbWFwcGluZwpbICAgIDAuMDA4MDY4XSBCUksgWzB4MDJj
MDEwMDAsIDB4MDJjMDFmZmZdIFBHVEFCTEUKWyAgICAwLjAwODA3MF0gQlJLIFsweDAyYzAy
MDAwLCAweDAyYzAyZmZmXSBQR1RBQkxFClsgICAgMC4wMDgwNzBdIEJSSyBbMHgwMmMwMzAw
MCwgMHgwMmMwM2ZmZl0gUEdUQUJMRQpbICAgIDAuMDA4MDk2XSBCUksgWzB4MDJjMDQwMDAs
IDB4MDJjMDRmZmZdIFBHVEFCTEUKWyAgICAwLjAwODMwN10gQlJLIFsweDAyYzA1MDAwLCAw
eDAyYzA1ZmZmXSBQR1RBQkxFClsgICAgMC4wMDgzNDRdIEJSSyBbMHgwMmMwNjAwMCwgMHgw
MmMwNmZmZl0gUEdUQUJMRQpbICAgIDAuMDA4MzgxXSBSQU1ESVNLOiBbbWVtIDB4Mzc1ZTcw
MDAtMHgzN2FlYWZmZl0KWyAgICAwLjAwODM4NV0gQUNQSTogRWFybHkgdGFibGUgY2hlY2tz
dW0gdmVyaWZpY2F0aW9uIGRpc2FibGVkClsgICAgMC4wMDg0MTFdIEFDUEk6IFJTRFAgMHgw
MDAwMDAwMDAwMEYwNUIwIDAwMDAyNCAodjAyIERFTEwgICkKWyAgICAwLjAwODQxNF0gQUNQ
STogWFNEVCAweDAwMDAwMDAwQkI2QTAwQzggMDAwMTBDICh2MDEgREVMTCAgIENCWDMgICAg
IDAxMDcyMDA5IEFNSSAgMDAwMTAwMTMpClsgICAgMC4wMDg0MTddIEFDUEk6IEZBQ1AgMHgw
MDAwMDAwMEJCNkM5M0MwIDAwMDEwQyAodjA1IERFTEwgICBDQlgzICAgICAwMTA3MjAwOSBB
TUkgIDAwMDEwMDEzKQpbICAgIDAuMDA4NDIwXSBBQ1BJOiBEU0RUIDB4MDAwMDAwMDBCQjZB
MDI2MCAwMjkxNTkgKHYwMiBERUxMICAgQ0JYMyAgICAgMDEwNzIwMDkgSU5UTCAyMDE2MDQy
MikKWyAgICAwLjAwODQyMl0gQUNQSTogRkFDUyAweDAwMDAwMDAwQkMwMDhGODAgMDAwMDQw
ClsgICAgMC4wMDg0MjRdIEFDUEk6IEFQSUMgMHgwMDAwMDAwMEJCNkM5NEQwIDAwMDBCQyAo
djAzIERFTEwgICBDQlgzICAgICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQpbICAgIDAuMDA4
NDI2XSBBQ1BJOiBGUERUIDB4MDAwMDAwMDBCQjZDOTU5MCAwMDAwNDQgKHYwMSBERUxMICAg
Q0JYMyAgICAgMDEwNzIwMDkgQU1JICAwMDAxMDAxMykKWyAgICAwLjAwODQyN10gQUNQSTog
RklEVCAweDAwMDAwMDAwQkI2Qzk1RDggMDAwMEFDICh2MDEgREVMTCAgIENCWDMgICAgIDAx
MDcyMDA5IEFNSSAgMDAwMTAwMTMpClsgICAgMC4wMDg0MjldIEFDUEk6IE1DRkcgMHgwMDAw
MDAwMEJCNkM5Njg4IDAwMDAzQyAodjAxIERFTEwgICBDQlgzICAgICAwMTA3MjAwOSBNU0ZU
IDAwMDAwMDk3KQpbICAgIDAuMDA4NDMxXSBBQ1BJOiBIUEVUIDB4MDAwMDAwMDBCQjZDOTZD
OCAwMDAwMzggKHYwMSBERUxMICAgQ0JYMyAgICAgMDEwNzIwMDkgQU1JLiAwMDA1MDAwQikK
WyAgICAwLjAwODQzMl0gQUNQSTogU1NEVCAweDAwMDAwMDAwQkI2Qzk3MDAgMDAzMTc2ICh2
MDIgU2FTc2R0IFNhU3NkdCAgIDAwMDAzMDAwIElOVEwgMjAxNjA0MjIpClsgICAgMC4wMDg0
MzRdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMEJCNkNDODc4IDAwMjVBNSAodjAyIFBlZ1NzZCBQ
ZWdTc2R0ICAwMDAwMTAwMCBJTlRMIDIwMTYwNDIyKQpbICAgIDAuMDA4NDM2XSBBQ1BJOiBI
UEVUIDB4MDAwMDAwMDBCQjZDRUUyMCAwMDAwMzggKHYwMSBJTlRFTCAgS0JMICAgICAgMDAw
MDAwMDEgTVNGVCAwMDAwMDA1RikKWyAgICAwLjAwODQzN10gQUNQSTogU1NEVCAweDAwMDAw
MDAwQkI2Q0VFNTggMDAwREU1ICh2MDIgSU5URUwgIFRoZXJfUnZwIDAwMDAxMDAwIElOVEwg
MjAxNjA0MjIpClsgICAgMC4wMDg0MzldIEFDUEk6IFNTRFQgMHgwMDAwMDAwMEJCNkNGQzQw
IDAwMDhEMiAodjAyIElOVEVMICBERUxMX19NVCAwMDAwMDAwMCBJTlRMIDIwMTYwNDIyKQpb
ICAgIDAuMDA4NDQxXSBBQ1BJOiBVRUZJIDB4MDAwMDAwMDBCQjZEMDUxOCAwMDAwNDIgKHYw
MSAgICAgICAgICAgICAgICAgMDAwMDAwMDAgICAgICAwMDAwMDAwMCkKWyAgICAwLjAwODQ0
M10gQUNQSTogU1NEVCAweDAwMDAwMDAwQkI2RDA1NjAgMDAwRURFICh2MDIgQ3B1UmVmIENw
dVNzZHQgIDAwMDAzMDAwIElOVEwgMjAxNjA0MjIpClsgICAgMC4wMDg0NDRdIEFDUEk6IExQ
SVQgMHgwMDAwMDAwMEJCNkQxNDQwIDAwMDA5NCAodjAxIElOVEVMICBLQkwgICAgICAwMDAw
MDAwMCBNU0ZUIDAwMDAwMDVGKQpbICAgIDAuMDA4NDQ2XSBBQ1BJOiBTU0RUIDB4MDAwMDAw
MDBCQjZEMTREOCAwMDAxNDEgKHYwMiBJTlRFTCAgSGRhRHNwICAgMDAwMDAwMDAgSU5UTCAy
MDE2MDQyMikKWyAgICAwLjAwODQ0OF0gQUNQSTogU1NEVCAweDAwMDAwMDAwQkI2RDE2MjAg
MDAwMjlGICh2MDIgSU5URUwgIHNlbnNyaHViIDAwMDAwMDAwIElOVEwgMjAxNjA0MjIpClsg
ICAgMC4wMDg0NDldIEFDUEk6IFNTRFQgMHgwMDAwMDAwMEJCNkQxOEMwIDAwMzAwMiAodjAy
IElOVEVMICBQdGlkRGV2YyAwMDAwMTAwMCBJTlRMIDIwMTYwNDIyKQpbICAgIDAuMDA4NDUx
XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDBCQjZENDhDOCAwMDAyMTUgKHYwMiBJTlRFTCAgVGJ0
VHlwZUMgMDAwMDAwMDAgSU5UTCAyMDE2MDQyMikKWyAgICAwLjAwODQ1M10gQUNQSTogREJH
UCAweDAwMDAwMDAwQkI2RDRBRTAgMDAwMDM0ICh2MDEgSU5URUwgICAgICAgICAgIDAwMDAw
MDAyIE1TRlQgMDAwMDAwNUYpClsgICAgMC4wMDg0NTRdIEFDUEk6IERCRzIgMHgwMDAwMDAw
MEJCNkQ0QjE4IDAwMDA1NCAodjAwIElOVEVMICAgICAgICAgICAwMDAwMDAwMiBNU0ZUIDAw
MDAwMDVGKQpbICAgIDAuMDA4NDU2XSBBQ1BJOiBNU0RNIDB4MDAwMDAwMDBCQjZENEI3MCAw
MDAwNTUgKHYwMyBERUxMICAgQ0JYMyAgICAgMDYyMjIwMDQgQU1JICAwMDAxMDAxMykKWyAg
ICAwLjAwODQ1OF0gQUNQSTogU0xJQyAweDAwMDAwMDAwQkI2RDRCQzggMDAwMTc2ICh2MDMg
REVMTCAgIENCWDMgICAgIDAxMDcyMDA5IE1TRlQgMDAwMTAwMTMpClsgICAgMC4wMDg0NTld
IEFDUEk6IERNQVIgMHgwMDAwMDAwMEJCNkQ0RDQwIDAwMDBBOCAodjAxIElOVEVMICBLQkwg
ICAgICAwMDAwMDAwMSBJTlRMIDAwMDAwMDAxKQpbICAgIDAuMDA4NDYxXSBBQ1BJOiBUUE0y
IDB4MDAwMDAwMDBCQjZENERFOCAwMDAwMzQgKHYwMyAgICAgICAgVHBtMlRhYmwgMDAwMDAw
MDEgQU1JICAwMDAwMDAwMCkKWyAgICAwLjAwODQ2M10gQUNQSTogQVNGISAweDAwMDAwMDAw
QkI2RDRFMjAgMDAwMEEwICh2MzIgSU5URUwgICBIQ0cgICAgIDAwMDAwMDAxIFRGU00gMDAw
RjQyNDApClsgICAgMC4wMDg0NjRdIEFDUEk6IEVJTkogMHgwMDAwMDAwMEJCNkQ0RUMwIDAw
MDEzMCAodjAxIEFNSSAgICBBTUkuRUlOSiAwMDAwMDAwMCBBTUkuIDAwMDAwMDAwKQpbICAg
IDAuMDA4NDY2XSBBQ1BJOiBFUlNUIDB4MDAwMDAwMDBCQjZENEZGMCAwMDAyMzAgKHYwMSBB
TUlFUiAgQU1JLkVSU1QgMDAwMDAwMDAgQU1JLiAwMDAwMDAwMCkKWyAgICAwLjAwODQ2OF0g
QUNQSTogQkVSVCAweDAwMDAwMDAwQkI2RDUyMjAgMDAwMDMwICh2MDEgQU1JICAgIEFNSS5C
RVJUIDAwMDAwMDAwIEFNSS4gMDAwMDAwMDApClsgICAgMC4wMDg0NzBdIEFDUEk6IEhFU1Qg
MHgwMDAwMDAwMEJCNkQ1MjUwIDAwMDBBOCAodjAxIEFNSSAgICBBTUkuSEVTVCAwMDAwMDAw
MCBBTUkuIDAwMDAwMDAwKQpbICAgIDAuMDA4NDc1XSBBQ1BJOiBMb2NhbCBBUElDIGFkZHJl
c3MgMHhmZWUwMDAwMApbICAgIDAuMDA4NjE3XSBObyBOVU1BIGNvbmZpZ3VyYXRpb24gZm91
bmQKWyAgICAwLjAwODYxOF0gRmFraW5nIGEgbm9kZSBhdCBbbWVtIDB4MDAwMDAwMDAwMDAw
MDAwMC0weDAwMDAwMDA4M2RmZmZmZmZdClsgICAgMC4wMDg2MjBdIE5PREVfREFUQSgwKSBh
bGxvY2F0ZWQgW21lbSAweDgzZGZmYTAwMC0weDgzZGZmZGZmZl0KWyAgICAwLjAwODYyNl0g
UmVzZXJ2aW5nIDI1Nk1CIG9mIG1lbW9yeSBhdCA2MjRNQiBmb3IgY3Jhc2hrZXJuZWwgKFN5
c3RlbSBSQU06IDMyNjM5TUIpClsgICAgMC4wMDg2NDBdIFpvbmUgcmFuZ2VzOgpbICAgIDAu
MDA4NjQxXSAgIERNQSAgICAgIFttZW0gMHgwMDAwMDAwMDAwMDAxMDAwLTB4MDAwMDAwMDAw
MGZmZmZmZl0KWyAgICAwLjAwODY0Ml0gICBETUEzMiAgICBbbWVtIDB4MDAwMDAwMDAwMTAw
MDAwMC0weDAwMDAwMDAwZmZmZmZmZmZdClsgICAgMC4wMDg2NDNdICAgTm9ybWFsICAgW21l
bSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwODNkZmZmZmZmXQpbICAgIDAuMDA4NjQ0
XSBNb3ZhYmxlIHpvbmUgc3RhcnQgZm9yIGVhY2ggbm9kZQpbICAgIDAuMDA4NjQ0XSBFYXJs
eSBtZW1vcnkgbm9kZSByYW5nZXMKWyAgICAwLjAwODY0NV0gICBub2RlICAgMDogW21lbSAw
eDAwMDAwMDAwMDAwMDEwMDAtMHgwMDAwMDAwMDAwMDhmZmZmXQpbICAgIDAuMDA4NjQ2XSAg
IG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDAwMDEwMDAwMC0weDAwMDAwMDAwYWJjNjdmZmZd
ClsgICAgMC4wMDg2NDZdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMGFiYzZhMDAwLTB4
MDAwMDAwMDBiYTAwZGZmZl0KWyAgICAwLjAwODY0N10gICBub2RlICAgMDogW21lbSAweDAw
MDAwMDAwYmM1ZmYwMDAtMHgwMDAwMDAwMGJjNWZmZmZmXQpbICAgIDAuMDA4NjQ3XSAgIG5v
ZGUgICAwOiBbbWVtIDB4MDAwMDAwMDEwMDAwMDAwMC0weDAwMDAwMDA4M2RmZmZmZmZdClsg
ICAgMC4wMDg4OTBdIFplcm9lZCBzdHJ1Y3QgcGFnZSBpbiB1bmF2YWlsYWJsZSByYW5nZXM6
IDI0Njc2IHBhZ2VzClsgICAgMC4wMDg4OTFdIEluaXRtZW0gc2V0dXAgbm9kZSAwIFttZW0g
MHgwMDAwMDAwMDAwMDAxMDAwLTB4MDAwMDAwMDgzZGZmZmZmZl0KWyAgICAwLjAwODg5Ml0g
T24gbm9kZSAwIHRvdGFscGFnZXM6IDgzNTU3NDAKWyAgICAwLjAwODg5M10gICBETUEgem9u
ZTogNjQgcGFnZXMgdXNlZCBmb3IgbWVtbWFwClsgICAgMC4wMDg4OTNdICAgRE1BIHpvbmU6
IDIxIHBhZ2VzIHJlc2VydmVkClsgICAgMC4wMDg4OTRdICAgRE1BIHpvbmU6IDM5ODMgcGFn
ZXMsIExJRk8gYmF0Y2g6MApbICAgIDAuMDA4OTUwXSAgIERNQTMyIHpvbmU6IDExODQxIHBh
Z2VzIHVzZWQgZm9yIG1lbW1hcApbICAgIDAuMDA4OTUxXSAgIERNQTMyIHpvbmU6IDc1Nzc3
MyBwYWdlcywgTElGTyBiYXRjaDo2MwpbICAgIDAuMDIwMDk4XSAgIE5vcm1hbCB6b25lOiAx
MTg2NTYgcGFnZXMgdXNlZCBmb3IgbWVtbWFwClsgICAgMC4wMjAwOThdICAgTm9ybWFsIHpv
bmU6IDc1OTM5ODQgcGFnZXMsIExJRk8gYmF0Y2g6NjMKWyAgICAwLjEyMjYwOF0gQUNQSTog
UE0tVGltZXIgSU8gUG9ydDogMHgxODA4ClsgICAgMC4xMjI2MTBdIEFDUEk6IExvY2FsIEFQ
SUMgYWRkcmVzcyAweGZlZTAwMDAwClsgICAgMC4xMjI2MTNdIEFDUEk6IExBUElDX05NSSAo
YWNwaV9pZFsweDAxXSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMTIyNjE0XSBBQ1BJ
OiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwMl0gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAw
LjEyMjYxNV0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDNdIGhpZ2ggZWRnZSBsaW50
WzB4MV0pClsgICAgMC4xMjI2MTVdIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDA0XSBo
aWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMTIyNjE2XSBBQ1BJOiBMQVBJQ19OTUkgKGFj
cGlfaWRbMHgwNV0gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjEyMjYxNl0gQUNQSTog
TEFQSUNfTk1JIChhY3BpX2lkWzB4MDZdIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAgMC4x
MjI2MTddIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDA3XSBoaWdoIGVkZ2UgbGludFsw
eDFdKQpbICAgIDAuMTIyNjE3XSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwOF0gaGln
aCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjEyMjY0NF0gSU9BUElDWzBdOiBhcGljX2lkIDIs
IHZlcnNpb24gMzIsIGFkZHJlc3MgMHhmZWMwMDAwMCwgR1NJIDAtMTE5ClsgICAgMC4xMjI2
NDVdIEFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNfaXJxIDAgZ2xvYmFsX2lycSAyIGRm
bCBkZmwpClsgICAgMC4xMjI2NDZdIEFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNfaXJx
IDkgZ2xvYmFsX2lycSA5IGhpZ2ggbGV2ZWwpClsgICAgMC4xMjI2NDddIEFDUEk6IElSUTAg
dXNlZCBieSBvdmVycmlkZS4KWyAgICAwLjEyMjY0OF0gQUNQSTogSVJROSB1c2VkIGJ5IG92
ZXJyaWRlLgpbICAgIDAuMTIyNjQ5XSBVc2luZyBBQ1BJIChNQURUKSBmb3IgU01QIGNvbmZp
Z3VyYXRpb24gaW5mb3JtYXRpb24KWyAgICAwLjEyMjY1MF0gQUNQSTogSFBFVCBpZDogMHg4
MDg2YTcwMSBiYXNlOiAweGZlZDAwMDAwClsgICAgMC4xMjI2NTJdIHNtcGJvb3Q6IEFsbG93
aW5nIDggQ1BVcywgMCBob3RwbHVnIENQVXMKWyAgICAwLjEyMjY2Ml0gW21lbSAweGMwMDAw
MDAwLTB4ZWZmZmZmZmZdIGF2YWlsYWJsZSBmb3IgUENJIGRldmljZXMKWyAgICAwLjEyMjY2
NF0gY2xvY2tzb3VyY2U6IHJlZmluZWQtamlmZmllczogbWFzazogMHhmZmZmZmZmZiBtYXhf
Y3ljbGVzOiAweGZmZmZmZmZmLCBtYXhfaWRsZV9uczogMTkxMDk2OTk0MDM5MTQxOSBucwpb
ICAgIDAuMjA5MjA5XSByYW5kb206IGdldF9yYW5kb21fYnl0ZXMgY2FsbGVkIGZyb20gc3Rh
cnRfa2VybmVsKzB4OTAvMHg0YjAgd2l0aCBjcm5nX2luaXQ9MApbICAgIDAuMjA5MjE0XSBz
ZXR1cF9wZXJjcHU6IE5SX0NQVVM6MjU2IG5yX2NwdW1hc2tfYml0czoyNTYgbnJfY3B1X2lk
czo4IG5yX25vZGVfaWRzOjEKWyAgICAwLjIwOTMxNl0gcGVyY3B1OiBFbWJlZGRlZCA0MiBw
YWdlcy9jcHUgQChfX19fcHRydmFsX19fXykgczEzMzc4NCByODE5MiBkMzAwNTYgdTI2MjE0
NApbICAgIDAuMjA5MzE5XSBwY3B1LWFsbG9jOiBzMTMzNzg0IHI4MTkyIGQzMDA1NiB1MjYy
MTQ0IGFsbG9jPTEqMjA5NzE1MgpbICAgIDAuMjA5MzIwXSBwY3B1LWFsbG9jOiBbMF0gMCAx
IDIgMyA0IDUgNiA3IApbICAgIDAuMjA5MzMxXSBCdWlsdCAxIHpvbmVsaXN0cywgbW9iaWxp
dHkgZ3JvdXBpbmcgb24uICBUb3RhbCBwYWdlczogODIyNTE1OApbICAgIDAuMjA5MzMyXSBQ
b2xpY3kgem9uZTogTm9ybWFsClsgICAgMC4yMDkzMzNdIEtlcm5lbCBjb21tYW5kIGxpbmU6
IEJPT1RfSU1BR0U9L2Jvb3QvYnpJbWFnZS00LjIwLjEzLm14NjQuMjQ4IGNyYXNoa2VybmVs
PTI1Nk0gcm9vdD1MQUJFTD1yb290IHJvIGNvbnNvbGU9dHR5UzEsMTE1MjAwbjggY29uc29s
ZT10dHkwIGluaXQ9L2Jpbi9zeXN0ZW1kIGF1ZGl0PTAKWyAgICAwLjIwOTQwNV0gYXVkaXQ6
IGRpc2FibGVkICh1bnRpbCByZWJvb3QpClsgICAgMC4yNTk3NThdIE1lbW9yeTogMzI1MzUy
MDBLLzMzNDIyOTYwSyBhdmFpbGFibGUgKDE0MzQxSyBrZXJuZWwgY29kZSwgMTMyMUsgcndk
YXRhLCAzMjQwSyByb2RhdGEsIDE1NDBLIGluaXQsIDE1MDRLIGJzcywgODg3NzYwSyByZXNl
cnZlZCwgMEsgY21hLXJlc2VydmVkKQpbICAgIDAuMjU5ODEyXSBLZXJuZWwvVXNlciBwYWdl
IHRhYmxlcyBpc29sYXRpb246IGVuYWJsZWQKWyAgICAwLjI1OTgyMV0gZnRyYWNlOiBhbGxv
Y2F0aW5nIDM4NzY3IGVudHJpZXMgaW4gMTUyIHBhZ2VzClsgICAgMC4yNzAyMjBdIHJjdTog
SGllcmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4KWyAgICAwLjI3MDIyMV0gcmN1OiAJ
UkNVIGV2ZW50IHRyYWNpbmcgaXMgZW5hYmxlZC4KWyAgICAwLjI3MDIyMl0gcmN1OiAJUkNV
IHJlc3RyaWN0aW5nIENQVXMgZnJvbSBOUl9DUFVTPTI1NiB0byBucl9jcHVfaWRzPTguClsg
ICAgMC4yNzAyMjNdIHJjdTogUkNVIGNhbGN1bGF0ZWQgdmFsdWUgb2Ygc2NoZWR1bGVyLWVu
bGlzdG1lbnQgZGVsYXkgaXMgMTAwIGppZmZpZXMuClsgICAgMC4yNzAyMjRdIHJjdTogQWRq
dXN0aW5nIGdlb21ldHJ5IGZvciByY3VfZmFub3V0X2xlYWY9MTYsIG5yX2NwdV9pZHM9OApb
ICAgIDAuMjcxMjI4XSBOUl9JUlFTOiAxNjY0MCwgbnJfaXJxczogMjA0OCwgcHJlYWxsb2Nh
dGVkIGlycXM6IDE2ClsgICAgMC4yNzE1MjZdIHNwdXJpb3VzIDgyNTlBIGludGVycnVwdDog
SVJRNy4KWyAgICAwLjI3NDgyM10gQ29uc29sZTogY29sb3VyIFZHQSsgODB4MjUKWyAgICAw
LjI5NDUwMF0gcHJpbnRrOiBjb25zb2xlIFt0dHkwXSBlbmFibGVkClsgICAgMC4zODk3MzJd
IHByaW50azogY29uc29sZSBbdHR5UzFdIGVuYWJsZWQKWyAgICAwLjM5MDIzMF0gQUNQSTog
Q29yZSByZXZpc2lvbiAyMDE4MTAwMwpbICAgIDAuMzkwOTg2XSBjbG9ja3NvdXJjZTogaHBl
dDogbWFzazogMHhmZmZmZmZmZiBtYXhfY3ljbGVzOiAweGZmZmZmZmZmLCBtYXhfaWRsZV9u
czogNzk2MzU4NTUyNDUgbnMKWyAgICAwLjM5MTk0M10gaHBldCBjbG9ja2V2ZW50IHJlZ2lz
dGVyZWQKWyAgICAwLjM5MjAxM10gQVBJQzogU3dpdGNoIHRvIHN5bW1ldHJpYyBJL08gbW9k
ZSBzZXR1cApbICAgIDAuMzk1Mzk1XSAuLlRJTUVSOiB2ZWN0b3I9MHgzMCBhcGljMT0wIHBp
bjE9MiBhcGljMj0wIHBpbjI9MApbICAgIDAuNDAwOTUyXSBjbG9ja3NvdXJjZTogdHNjLWVh
cmx5OiBtYXNrOiAweGZmZmZmZmZmZmZmZmZmZmYgbWF4X2N5Y2xlczogMHgzM2U0NTJmYmIy
ZiwgbWF4X2lkbGVfbnM6IDQ0MDc5NTIzNjU5MyBucwpbICAgIDAuNDAyMDAyXSBDYWxpYnJh
dGluZyBkZWxheSBsb29wIChza2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0aW1l
ciBmcmVxdWVuY3kuLiA3MjAwLjAwIEJvZ29NSVBTIChscGo9MzYwMDAwMCkKWyAgICAwLjQw
MzAwM10gcGlkX21heDogZGVmYXVsdDogMzI3NjggbWluaW11bTogMzAxClsgICAgMC40MDYx
MTNdIERlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDQxOTQzMDQgKG9yZGVyOiAx
MywgMzM1NTQ0MzIgYnl0ZXMpClsgICAgMC40MDgxMzJdIElub2RlLWNhY2hlIGhhc2ggdGFi
bGUgZW50cmllczogMjA5NzE1MiAob3JkZXI6IDEyLCAxNjc3NzIxNiBieXRlcykKWyAgICAw
LjQwODk2Nl0gTW91bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6
IDcsIDUyNDI4OCBieXRlcykKWyAgICAwLjQwOTA0M10gTW91bnRwb2ludC1jYWNoZSBoYXNo
IHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzKQpbICAgIDAu
NDEwMTE5XSBFTkVSR1lfUEVSRl9CSUFTOiBTZXQgdG8gJ25vcm1hbCcsIHdhcyAncGVyZm9y
bWFuY2UnClsgICAgMC40MTEwMDNdIEVORVJHWV9QRVJGX0JJQVM6IFZpZXcgYW5kIHVwZGF0
ZSB3aXRoIHg4Nl9lbmVyZ3lfcGVyZl9wb2xpY3koOCkKWyAgICAwLjQxMTcyNl0gbWNlOiBD
UFUgc3VwcG9ydHMgMTAgTUNFIGJhbmtzClsgICAgMC40MTIwMDhdIENQVTA6IFRoZXJtYWwg
bW9uaXRvcmluZyBlbmFibGVkIChUTTEpClsgICAgMC40MTMwMTVdIHByb2Nlc3M6IHVzaW5n
IG13YWl0IGluIGlkbGUgdGhyZWFkcwpbICAgIDAuNDEzNTQyXSBMYXN0IGxldmVsIGlUTEIg
ZW50cmllczogNEtCIDY0LCAyTUIgOCwgNE1CIDgKWyAgICAwLjQxNDAwMl0gTGFzdCBsZXZl
bCBkVExCIGVudHJpZXM6IDRLQiA2NCwgMk1CIDAsIDRNQiAwLCAxR0IgNApbICAgIDAuNDE0
ODQ0XSBTcGVjdHJlIFYyIDogTWl0aWdhdGlvbjogRnVsbCBnZW5lcmljIHJldHBvbGluZQpb
ICAgIDAuNDE1MDAyXSBTcGVjdHJlIFYyIDogU3BlY3RyZSB2MiAvIFNwZWN0cmVSU0IgbWl0
aWdhdGlvbjogRmlsbGluZyBSU0Igb24gY29udGV4dCBzd2l0Y2gKWyAgICAwLjQxNjAwMl0g
U3BlY3RyZSBWMiA6IEVuYWJsaW5nIFJlc3RyaWN0ZWQgU3BlY3VsYXRpb24gZm9yIGZpcm13
YXJlIGNhbGxzClsgICAgMC40MTcwMDNdIFNwZWN0cmUgVjIgOiBtaXRpZ2F0aW9uOiBFbmFi
bGluZyBjb25kaXRpb25hbCBJbmRpcmVjdCBCcmFuY2ggUHJlZGljdGlvbiBCYXJyaWVyClsg
ICAgMC40MTgwMDJdIFNwZWN0cmUgVjIgOiBVc2VyIHNwYWNlOiBNaXRpZ2F0aW9uOiBTVElC
UCB2aWEgc2VjY29tcCBhbmQgcHJjdGwKWyAgICAwLjQxODcyNV0gU3BlY3VsYXRpdmUgU3Rv
cmUgQnlwYXNzOiBNaXRpZ2F0aW9uOiBTcGVjdWxhdGl2ZSBTdG9yZSBCeXBhc3MgZGlzYWJs
ZWQgdmlhIHByY3RsIGFuZCBzZWNjb21wClsgICAgMC40MTkxNjddIEZyZWVpbmcgU01QIGFs
dGVybmF0aXZlcyBtZW1vcnk6IDQ0SwpbICAgIDAuNDIxMDM5XSBUU0MgZGVhZGxpbmUgdGlt
ZXIgZW5hYmxlZApbICAgIDAuNDIxMDQ0XSBzbXBib290OiBDUFUwOiBJbnRlbChSKSBDb3Jl
KFRNKSBpNy03NzAwIENQVSBAIDMuNjBHSHogKGZhbWlseTogMHg2LCBtb2RlbDogMHg5ZSwg
c3RlcHBpbmc6IDB4OSkKWyAgICAwLjQyMjA1MV0gUGVyZm9ybWFuY2UgRXZlbnRzOiBQRUJT
IGZtdDMrLCBTa3lsYWtlIGV2ZW50cywgMzItZGVlcCBMQlIsIGZ1bGwtd2lkdGggY291bnRl
cnMsIEludGVsIFBNVSBkcml2ZXIuClsgICAgMC40MjMwMDRdIC4uLiB2ZXJzaW9uOiAgICAg
ICAgICAgICAgICA0ClsgICAgMC40MjM1NDddIC4uLiBiaXQgd2lkdGg6ICAgICAgICAgICAg
ICA0OApbICAgIDAuNDI0MDAzXSAuLi4gZ2VuZXJpYyByZWdpc3RlcnM6ICAgICAgNApbICAg
IDAuNDI0NTQ3XSAuLi4gdmFsdWUgbWFzazogICAgICAgICAgICAgMDAwMGZmZmZmZmZmZmZm
ZgpbICAgIDAuNDI1MDAzXSAuLi4gbWF4IHBlcmlvZDogICAgICAgICAgICAgMDAwMDdmZmZm
ZmZmZmZmZgpbICAgIDAuNDI1NjUzXSAuLi4gZml4ZWQtcHVycG9zZSBldmVudHM6ICAgMwpb
ICAgIDAuNDI2MDAzXSAuLi4gZXZlbnQgbWFzazogICAgICAgICAgICAgMDAwMDAwMDcwMDAw
MDAwZgpbICAgIDAuNDI2Njc3XSByY3U6IEhpZXJhcmNoaWNhbCBTUkNVIGltcGxlbWVudGF0
aW9uLgpbICAgIDAuNDI3MDg2XSBzbXA6IEJyaW5naW5nIHVwIHNlY29uZGFyeSBDUFVzIC4u
LgpbICAgIDAuNDI3NzIxXSB4ODY6IEJvb3RpbmcgU01QIGNvbmZpZ3VyYXRpb246ClsgICAg
MC40MjgwMDNdIC4uLi4gbm9kZSAgIzAsIENQVXM6ICAgICAgIzEgIzIgIzMgIzQgIzUgIzYg
IzcKWyAgICAwLjQzMTE3OV0gc21wOiBCcm91Z2h0IHVwIDEgbm9kZSwgOCBDUFVzClsgICAg
MC40MzIwMDNdIHNtcGJvb3Q6IE1heCBsb2dpY2FsIHBhY2thZ2VzOiAxClsgICAgMC40MzI1
NzFdIHNtcGJvb3Q6IFRvdGFsIG9mIDggcHJvY2Vzc29ycyBhY3RpdmF0ZWQgKDU3NjAwLjAw
IEJvZ29NSVBTKQpbICAgIDAuNDM0NTYwXSBkZXZ0bXBmczogaW5pdGlhbGl6ZWQKWyAgICAw
LjQzNTE2Nl0gUE06IFJlZ2lzdGVyaW5nIEFDUEkgTlZTIHJlZ2lvbiBbbWVtIDB4YWJjNjgw
MDAtMHhhYmM2OGZmZl0gKDQwOTYgYnl0ZXMpClsgICAgMC40MzYwMDRdIFBNOiBSZWdpc3Rl
cmluZyBBQ1BJIE5WUyByZWdpb24gW21lbSAweGJiNmQ2MDAwLTB4YmMwMDlmZmZdICg5NjUw
MTc2IGJ5dGVzKQpbICAgIDAuNDM3MTIwXSBjbG9ja3NvdXJjZTogamlmZmllczogbWFzazog
MHhmZmZmZmZmZiBtYXhfY3ljbGVzOiAweGZmZmZmZmZmLCBtYXhfaWRsZV9uczogMTkxMTI2
MDQ0NjI3NTAwMCBucwpbICAgIDAuNDM4MDEwXSBmdXRleCBoYXNoIHRhYmxlIGVudHJpZXM6
IDIwNDggKG9yZGVyOiA1LCAxMzEwNzIgYnl0ZXMpClsgICAgMC40Mzg3NzNdIHhvcjogYXV0
b21hdGljYWxseSB1c2luZyBiZXN0IGNoZWNrc3VtbWluZyBmdW5jdGlvbiAgIGF2eCAgICAg
ICAKWyAgICAwLjQzOTA3Ml0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNgpb
ICAgIDAuNDM5Nzc4XSBjcHVpZGxlOiB1c2luZyBnb3Zlcm5vciBsYWRkZXIKWyAgICAwLjQ0
MDM3Ml0gQUNQSSBGQURUIGRlY2xhcmVzIHRoZSBzeXN0ZW0gZG9lc24ndCBzdXBwb3J0IFBD
SWUgQVNQTSwgc28gZGlzYWJsZSBpdApbICAgIDAuNDQxMDAzXSBBQ1BJOiBidXMgdHlwZSBQ
Q0kgcmVnaXN0ZXJlZApbICAgIDAuNDQxNTgxXSBQQ0k6IE1NQ09ORklHIGZvciBkb21haW4g
MDAwMCBbYnVzIDAwLTdmXSBhdCBbbWVtIDB4ZjAwMDAwMDAtMHhmN2ZmZmZmZl0gKGJhc2Ug
MHhmMDAwMDAwMCkKWyAgICAwLjQ0MzAwNF0gUENJOiBNTUNPTkZJRyBhdCBbbWVtIDB4ZjAw
MDAwMDAtMHhmN2ZmZmZmZl0gcmVzZXJ2ZWQgaW4gRTgyMApbICAgIDAuNDQzNzgwXSBQQ0k6
IFVzaW5nIGNvbmZpZ3VyYXRpb24gdHlwZSAxIGZvciBiYXNlIGFjY2VzcwpbICAgIDAuNDQ1
NjIwXSBIdWdlVExCIHJlZ2lzdGVyZWQgMi4wMCBNaUIgcGFnZSBzaXplLCBwcmUtYWxsb2Nh
dGVkIDAgcGFnZXMKWyAgICAwLjQ2MjYxNF0gcmFpZDY6IHNzZTJ4MSAgIGdlbigpIDEyOTQx
IE1CL3MKWyAgICAwLjQ3OTQzOV0gcmFpZDY6IHNzZTJ4MSAgIHhvcigpICA5NzU3IE1CL3MK
WyAgICAwLjQ5NjQzOF0gcmFpZDY6IHNzZTJ4MiAgIGdlbigpIDE2NDYwIE1CL3MKWyAgICAw
LjUxMzQ0MV0gcmFpZDY6IHNzZTJ4MiAgIHhvcigpIDExNDQ1IE1CL3MKWyAgICAwLjUzMDQ0
MV0gcmFpZDY6IHNzZTJ4NCAgIGdlbigpIDE5MTk5IE1CL3MKWyAgICAwLjU0NzQzOV0gcmFp
ZDY6IHNzZTJ4NCAgIHhvcigpIDExOTk2IE1CL3MKWyAgICAwLjU2NDQ0MV0gcmFpZDY6IGF2
eDJ4MSAgIGdlbigpIDI2NDE0IE1CL3MKWyAgICAwLjU4MTQzOV0gcmFpZDY6IGF2eDJ4MSAg
IHhvcigpIDE5MTg5IE1CL3MKWyAgICAwLjU5ODQ0MF0gcmFpZDY6IGF2eDJ4MiAgIGdlbigp
IDMyNjQ4IE1CL3MKWyAgICAwLjYxNTQzOV0gcmFpZDY6IGF2eDJ4MiAgIHhvcigpIDIwNzEw
IE1CL3MKWyAgICAwLjYzMjQzOV0gcmFpZDY6IGF2eDJ4NCAgIGdlbigpIDM4MDc0IE1CL3MK
WyAgICAwLjY0OTQ0MF0gcmFpZDY6IGF2eDJ4NCAgIHhvcigpIDIzNTY4IE1CL3MKWyAgICAw
LjY1MDAwM10gcmFpZDY6IHVzaW5nIGFsZ29yaXRobSBhdngyeDQgZ2VuKCkgMzgwNzQgTUIv
cwpbICAgIDAuNjUwNjY4XSByYWlkNjogLi4uLiB4b3IoKSAyMzU2OCBNQi9zLCBybXcgZW5h
YmxlZApbICAgIDAuNjUxMDAzXSByYWlkNjogdXNpbmcgYXZ4MngyIHJlY292ZXJ5IGFsZ29y
aXRobQpbICAgIDAuNjUyNDg4XSBBQ1BJOiBBZGRlZCBfT1NJKE1vZHVsZSBEZXZpY2UpClsg
ICAgMC42NTMwMDRdIEFDUEk6IEFkZGVkIF9PU0koUHJvY2Vzc29yIERldmljZSkKWyAgICAw
LjY1MzU4NV0gQUNQSTogQWRkZWQgX09TSSgzLjAgX1NDUCBFeHRlbnNpb25zKQpbICAgIDAu
NjU0MDAzXSBBQ1BJOiBBZGRlZCBfT1NJKFByb2Nlc3NvciBBZ2dyZWdhdG9yIERldmljZSkK
WyAgICAwLjY1NDY2Ml0gQUNQSTogQWRkZWQgX09TSShMaW51eC1EZWxsLVZpZGVvKQpbICAg
IDAuNjU1MDAzXSBBQ1BJOiBBZGRlZCBfT1NJKExpbnV4LUxlbm92by1OVi1IRE1JLUF1ZGlv
KQpbICAgIDAuNjgxNzkzXSBBQ1BJOiAxMCBBQ1BJIEFNTCB0YWJsZXMgc3VjY2Vzc2Z1bGx5
IGFjcXVpcmVkIGFuZCBsb2FkZWQKWyAgICAwLjY4ODE4OV0gQUNQSTogRHluYW1pYyBPRU0g
VGFibGUgTG9hZDoKWyAgICAwLjY4ODczOV0gQUNQSTogU1NEVCAweEZGRkY4ODg4MTlGRDYw
MDAgMDAwNzU5ICh2MDIgUG1SZWYgIENwdTBJc3QgIDAwMDAzMDAwIElOVEwgMjAxNjA0MjIp
ClsgICAgMC42ODkzNTBdIEFDUEk6IFxfUFJfLkNQVTA6IF9PU0MgbmF0aXZlIHRoZXJtYWwg
TFZUIEFja2VkClsgICAgMC42OTA4OTddIEFDUEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6
ClsgICAgMC42OTIwMDZdIEFDUEk6IFNTRFQgMHhGRkZGODg4ODE5RjJFNDAwIDAwMDNGRiAo
djAyIFBtUmVmICBDcHUwQ3N0ICAwMDAwMzAwMSBJTlRMIDIwMTYwNDIyKQpbICAgIDAuNjkz
MjkzXSBBQ1BJOiBEeW5hbWljIE9FTSBUYWJsZSBMb2FkOgpbICAgIDAuNjkzODQyXSBBQ1BJ
OiBTU0RUIDB4RkZGRjg4ODgxOUVFNkUwMCAwMDAxMTUgKHYwMiBQbVJlZiAgQ3B1MEh3cCAg
MDAwMDMwMDAgSU5UTCAyMDE2MDQyMikKWyAgICAwLjY5NTIwN10gQUNQSTogRHluYW1pYyBP
RU0gVGFibGUgTG9hZDoKWyAgICAwLjY5NTc1NV0gQUNQSTogU1NEVCAweEZGRkY4ODg4MTlF
RTZDMDAgMDAwMUE0ICh2MDIgUG1SZWYgIEh3cEx2dCAgIDAwMDAzMDAwIElOVEwgMjAxNjA0
MjIpClsgICAgMC42OTY0MDNdIEFDUEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAg
MC42OTY5NTJdIEFDUEk6IFNTRFQgMHhGRkZGODg4ODE5RUU3ODAwIDAwMDY1QyAodjAyIFBt
UmVmICBBcElzdCAgICAwMDAwMzAwMCBJTlRMIDIwMTYwNDIyKQpbICAgIDAuNjk4NDUwXSBB
Q1BJOiBEeW5hbWljIE9FTSBUYWJsZSBMb2FkOgpbICAgIDAuNjk4OTk4XSBBQ1BJOiBTU0RU
IDB4RkZGRjg4ODgxOUVFNkEwMCAwMDAxOTcgKHYwMiBQbVJlZiAgQXBId3AgICAgMDAwMDMw
MDAgSU5UTCAyMDE2MDQyMikKWyAgICAwLjcwMDI3Ml0gQUNQSTogRHluYW1pYyBPRU0gVGFi
bGUgTG9hZDoKWyAgICAwLjcwMDgxOV0gQUNQSTogU1NEVCAweEZGRkY4ODg4MTlFRTY4MDAg
MDAwMThBICh2MDIgUG1SZWYgIEFwQ3N0ICAgIDAwMDAzMDAwIElOVEwgMjAxNjA0MjIpClsg
ICAgMC43MDQ2MTRdIEFDUEk6IEludGVycHJldGVyIGVuYWJsZWQKWyAgICAwLjcwNTAyNF0g
QUNQSTogKHN1cHBvcnRzIFMwIFMzIFM1KQpbICAgIDAuNzA1NTQzXSBBQ1BJOiBVc2luZyBJ
T0FQSUMgZm9yIGludGVycnVwdCByb3V0aW5nClsgICAgMC43MDcwMjddIFBDSTogVXNpbmcg
aG9zdCBicmlkZ2Ugd2luZG93cyBmcm9tIEFDUEk7IGlmIG5lY2Vzc2FyeSwgdXNlICJwY2k9
bm9jcnMiIGFuZCByZXBvcnQgYSBidWcKWyAgICAwLjcwODY3MV0gQUNQSTogRW5hYmxlZCA2
IEdQRXMgaW4gYmxvY2sgMDAgdG8gN0YKWyAgICAwLjcxMDY0NF0gQUNQSTogUG93ZXIgUmVz
b3VyY2UgW1BHMDBdIChvbikKWyAgICAwLjcxMTIzNF0gQUNQSTogUG93ZXIgUmVzb3VyY2Ug
W1BHMDFdIChvbikKWyAgICAwLjcxMjAyN10gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1BHMDJd
IChvbikKWyAgICAwLjcxNDMxM10gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikK
WyAgICAwLjcxNTExMF0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAw
LjcxNTkwM10gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAwLjcxNzIy
OV0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAwLjcxODAyMl0gQUNQ
STogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAwLjcxODgyMV0gQUNQSTogUG93
ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAwLjcxOTIyOF0gQUNQSTogUG93ZXIgUmVz
b3VyY2UgW1dSU1RdIChvbikKWyAgICAwLjcyMDAyMF0gQUNQSTogUG93ZXIgUmVzb3VyY2Ug
W1dSU1RdIChvbikKWyAgICAwLjcyMDgxMl0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1Rd
IChvbikKWyAgICAwLjcyMTIyOF0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikK
WyAgICAwLjcyMjAyMl0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAw
LjcyMjgxNF0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAwLjcyNDIy
OF0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAwLjcyNTAyM10gQUNQ
STogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAwLjcyNTgxNl0gQUNQSTogUG93
ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAwLjcyNjIyOV0gQUNQSTogUG93ZXIgUmVz
b3VyY2UgW1dSU1RdIChvbikKWyAgICAwLjcyNzY1NV0gQUNQSTogUG93ZXIgUmVzb3VyY2Ug
W1dSU1RdIChvbikKWyAgICAwLjcyODIyOF0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1Rd
IChvbikKWyAgICAwLjcyOTAyMV0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikK
WyAgICAwLjcyOTgxNF0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW1dSU1RdIChvbikKWyAgICAw
Ljc0MDcxNl0gQUNQSTogUG93ZXIgUmVzb3VyY2UgW0ZOMDBdIChvZmYpClsgICAgMC43NDEw
NjFdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtGTjAxXSAob2ZmKQpbICAgIDAuNzQxNjkxXSBB
Q1BJOiBQb3dlciBSZXNvdXJjZSBbRk4wMl0gKG9mZikKWyAgICAwLjc0MjA1OF0gQUNQSTog
UG93ZXIgUmVzb3VyY2UgW0ZOMDNdIChvZmYpClsgICAgMC43NDI2ODZdIEFDUEk6IFBvd2Vy
IFJlc291cmNlIFtGTjA0XSAob2ZmKQpbICAgIDAuNzQzODAzXSBBQ1BJOiBQQ0kgUm9vdCBC
cmlkZ2UgW1BDSTBdIChkb21haW4gMDAwMCBbYnVzIDAwLTdlXSkKWyAgICAwLjc0NTAwNl0g
YWNwaSBQTlAwQTA4OjAwOiBfT1NDOiBPUyBzdXBwb3J0cyBbRXh0ZW5kZWRDb25maWcgQVNQ
TSBDbG9ja1BNIFNlZ21lbnRzIE1TSV0KWyAgICAwLjc0NjEzMF0gYWNwaSBQTlAwQTA4OjAw
OiBfT1NDOiBwbGF0Zm9ybSBkb2VzIG5vdCBzdXBwb3J0IFtQTUVdClsgICAgMC43NDY5NzFd
IGFjcGkgUE5QMEEwODowMDogX09TQzogT1Mgbm93IGNvbnRyb2xzIFtBRVIgUENJZUNhcGFi
aWxpdHkgTFRSXQpbICAgIDAuNzQ4MDAzXSBhY3BpIFBOUDBBMDg6MDA6IEZBRFQgaW5kaWNh
dGVzIEFTUE0gaXMgdW5zdXBwb3J0ZWQsIHVzaW5nIEJJT1MgY29uZmlndXJhdGlvbgpbICAg
IDAuNzQ5MjQ4XSBQQ0kgaG9zdCBicmlkZ2UgdG8gYnVzIDAwMDA6MDAKWyAgICAwLjc0OTgw
Ml0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4MDAwMC0weDBj
Zjcgd2luZG93XQpbICAgIDAuNzUwMDAzXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJl
c291cmNlIFtpbyAgMHgwZDAwLTB4ZmZmZiB3aW5kb3ddClsgICAgMC43NTA3NzRdIHBjaV9i
dXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweDAwMGEwMDAwLTB4MDAwYmZm
ZmYgd2luZG93XQpbICAgIDAuNzUyMDAzXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJl
c291cmNlIFttZW0gMHhjMDAwMDAwMC0weGVmZmZmZmZmIHdpbmRvd10KWyAgICAwLjc1Mjk0
NF0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4ZmQwMDAwMDAt
MHhmZTdmZmZmZiB3aW5kb3ddClsgICAgMC43NTQwMDNdIHBjaV9idXMgMDAwMDowMDogcm9v
dCBidXMgcmVzb3VyY2UgW2J1cyAwMC03ZV0KWyAgICAwLjc1NDY3NF0gcGNpIDAwMDA6MDA6
MDAuMDogWzgwODY6NTkxZl0gdHlwZSAwMCBjbGFzcyAweDA2MDAwMApbICAgIDAuNzU0OTA1
XSBwY2kgMDAwMDowMDowMS4wOiBbODA4NjoxOTAxXSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAw
ClsgICAgMC43NTQ5MzVdIHBjaSAwMDAwOjAwOjAxLjA6IFBNRSMgc3VwcG9ydGVkIGZyb20g
RDAgRDNob3QgRDNjb2xkClsgICAgMC43NTUwNzBdIHBjaSAwMDAwOjAwOjAyLjA6IFs4MDg2
OjU5MTJdIHR5cGUgMDAgY2xhc3MgMHgwMzgwMDAKWyAgICAwLjc1NTA3N10gcGNpIDAwMDA6
MDA6MDIuMDogcmVnIDB4MTA6IFttZW0gMHhlZTAwMDAwMC0weGVlZmZmZmZmIDY0Yml0XQpb
ICAgIDAuNzU1MDgxXSBwY2kgMDAwMDowMDowMi4wOiByZWcgMHgxODogW21lbSAweGMwMDAw
MDAwLTB4Y2ZmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjc1NTA4NF0gcGNpIDAwMDA6MDA6
MDIuMDogcmVnIDB4MjA6IFtpbyAgMHhmMDAwLTB4ZjAzZl0KWyAgICAwLjc1NTI0MV0gcGNp
IDAwMDA6MDA6MTQuMDogWzgwODY6YTEyZl0gdHlwZSAwMCBjbGFzcyAweDBjMDMzMApbICAg
IDAuNzU1Mjc0XSBwY2kgMDAwMDowMDoxNC4wOiByZWcgMHgxMDogW21lbSAweGVmMTMwMDAw
LTB4ZWYxM2ZmZmYgNjRiaXRdClsgICAgMC43NTUzNzBdIHBjaSAwMDAwOjAwOjE0LjA6IFBN
RSMgc3VwcG9ydGVkIGZyb20gRDNob3QgRDNjb2xkClsgICAgMC43NTU1MzFdIHBjaSAwMDAw
OjAwOjE0LjI6IFs4MDg2OmExMzFdIHR5cGUgMDAgY2xhc3MgMHgxMTgwMDAKWyAgICAwLjc1
NTU2M10gcGNpIDAwMDA6MDA6MTQuMjogcmVnIDB4MTA6IFttZW0gMHhlZjE0ZTAwMC0weGVm
MTRlZmZmIDY0Yml0XQpbICAgIDAuNzU1NzYwXSBwY2kgMDAwMDowMDoxNi4wOiBbODA4Njph
MTNhXSB0eXBlIDAwIGNsYXNzIDB4MDc4MDAwClsgICAgMC43NTU3ODldIHBjaSAwMDAwOjAw
OjE2LjA6IHJlZyAweDEwOiBbbWVtIDB4ZWYxNGQwMDAtMHhlZjE0ZGZmZiA2NGJpdF0KWyAg
ICAwLjc1NTg3MV0gcGNpIDAwMDA6MDA6MTYuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEM2hv
dApbICAgIDAuNzU2MDE2XSBwY2kgMDAwMDowMDoxNy4wOiBbODA4NjoyODIyXSB0eXBlIDAw
IGNsYXNzIDB4MDEwNDAwClsgICAgMC43NTYwNDRdIHBjaSAwMDAwOjAwOjE3LjA6IHJlZyAw
eDEwOiBbbWVtIDB4ZWYxNDgwMDAtMHhlZjE0OWZmZl0KWyAgICAwLjc1NjA1NV0gcGNpIDAw
MDA6MDA6MTcuMDogcmVnIDB4MTQ6IFttZW0gMHhlZjE0YzAwMC0weGVmMTRjMGZmXQpbICAg
IDAuNzU2MDY2XSBwY2kgMDAwMDowMDoxNy4wOiByZWcgMHgxODogW2lvICAweGYwOTAtMHhm
MDk3XQpbICAgIDAuNzU2MDc3XSBwY2kgMDAwMDowMDoxNy4wOiByZWcgMHgxYzogW2lvICAw
eGYwODAtMHhmMDgzXQpbICAgIDAuNzU2MDg4XSBwY2kgMDAwMDowMDoxNy4wOiByZWcgMHgy
MDogW2lvICAweGYwNjAtMHhmMDdmXQpbICAgIDAuNzU2MDk5XSBwY2kgMDAwMDowMDoxNy4w
OiByZWcgMHgyNDogW21lbSAweGVmMTRiMDAwLTB4ZWYxNGI3ZmZdClsgICAgMC43NTYxNjBd
IHBjaSAwMDAwOjAwOjE3LjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDNob3QKWyAgICAwLjc1
NjI4M10gcGNpIDAwMDA6MDA6MWMuMDogWzgwODY6YTExMF0gdHlwZSAwMSBjbGFzcyAweDA2
MDQwMApbICAgIDAuNzU2MzkyXSBwY2kgMDAwMDowMDoxYy4wOiBQTUUjIHN1cHBvcnRlZCBm
cm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAuNzU2NTYxXSBwY2kgMDAwMDowMDoxZi4wOiBb
ODA4NjphMTQ5XSB0eXBlIDAwIGNsYXNzIDB4MDYwMTAwClsgICAgMC43NTY3NTRdIHBjaSAw
MDAwOjAwOjFmLjI6IFs4MDg2OmExMjFdIHR5cGUgMDAgY2xhc3MgMHgwNTgwMDAKWyAgICAw
Ljc1Njc3NV0gcGNpIDAwMDA6MDA6MWYuMjogcmVnIDB4MTA6IFttZW0gMHhlZjE0NDAwMC0w
eGVmMTQ3ZmZmXQpbICAgIDAuNzU2OTY1XSBwY2kgMDAwMDowMDoxZi4zOiBbODA4NjphMTcw
XSB0eXBlIDAwIGNsYXNzIDB4MDQwMzAwClsgICAgMC43NTcwMDZdIHBjaSAwMDAwOjAwOjFm
LjM6IHJlZyAweDEwOiBbbWVtIDB4ZWYxNDAwMDAtMHhlZjE0M2ZmZiA2NGJpdF0KWyAgICAw
Ljc1NzA1N10gcGNpIDAwMDA6MDA6MWYuMzogcmVnIDB4MjA6IFttZW0gMHhlZjEyMDAwMC0w
eGVmMTJmZmZmIDY0Yml0XQpbICAgIDAuNzU3MTI1XSBwY2kgMDAwMDowMDoxZi4zOiBQTUUj
IHN1cHBvcnRlZCBmcm9tIEQzaG90IEQzY29sZApbICAgIDAuNzU3Mjk1XSBwY2kgMDAwMDow
MDoxZi40OiBbODA4NjphMTIzXSB0eXBlIDAwIGNsYXNzIDB4MGMwNTAwClsgICAgMC43NTcz
NTRdIHBjaSAwMDAwOjAwOjFmLjQ6IHJlZyAweDEwOiBbbWVtIDB4ZWYxNGEwMDAtMHhlZjE0
YTBmZiA2NGJpdF0KWyAgICAwLjc1NzQyNF0gcGNpIDAwMDA6MDA6MWYuNDogcmVnIDB4MjA6
IFtpbyAgMHhmMDQwLTB4ZjA1Zl0KWyAgICAwLjc1NzYwMV0gcGNpIDAwMDA6MDA6MWYuNjog
WzgwODY6MTViN10gdHlwZSAwMCBjbGFzcyAweDAyMDAwMApbICAgIDAuNzU3NjM5XSBwY2kg
MDAwMDowMDoxZi42OiByZWcgMHgxMDogW21lbSAweGVmMTAwMDAwLTB4ZWYxMWZmZmZdClsg
ICAgMC43NTc3OTZdIHBjaSAwMDAwOjAwOjFmLjY6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAg
RDNob3QgRDNjb2xkClsgICAgMC43NTc5MjddIHBjaSAwMDAwOjAxOjAwLjA6IFsxMDAyOjY3
YzddIHR5cGUgMDAgY2xhc3MgMHgwMzAwMDAKWyAgICAwLjc1Nzk0NF0gcGNpIDAwMDA6MDE6
MDAuMDogcmVnIDB4MTA6IFttZW0gMHhkMDAwMDAwMC0weGRmZmZmZmZmIDY0Yml0IHByZWZd
ClsgICAgMC43NTc5NTFdIHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDE4OiBbbWVtIDB4ZTAw
MDAwMDAtMHhlMDFmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNzU3OTU2XSBwY2kgMDAwMDow
MTowMC4wOiByZWcgMHgyMDogW2lvICAweGUwMDAtMHhlMGZmXQpbICAgIDAuNzU3OTYwXSBw
Y2kgMDAwMDowMTowMC4wOiByZWcgMHgyNDogW21lbSAweGVmMDAwMDAwLTB4ZWYwM2ZmZmZd
ClsgICAgMC43NTc5NjVdIHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDMwOiBbbWVtIDB4ZWYw
NDAwMDAtMHhlZjA1ZmZmZiBwcmVmXQpbICAgIDAuNzU4MDA4XSBwY2kgMDAwMDowMTowMC4w
OiBzdXBwb3J0cyBEMSBEMgpbICAgIDAuNzU4MDA5XSBwY2kgMDAwMDowMTowMC4wOiBQTUUj
IHN1cHBvcnRlZCBmcm9tIEQxIEQyIEQzaG90IEQzY29sZApbICAgIDAuNzU4MDU0XSBwY2kg
MDAwMDowMTowMC4xOiBbMTAwMjphYWYwXSB0eXBlIDAwIGNsYXNzIDB4MDQwMzAwClsgICAg
MC43NTgwNjhdIHBjaSAwMDAwOjAxOjAwLjE6IHJlZyAweDEwOiBbbWVtIDB4ZWYwNjAwMDAt
MHhlZjA2M2ZmZiA2NGJpdF0KWyAgICAwLjc1ODEyMF0gcGNpIDAwMDA6MDE6MDAuMTogc3Vw
cG9ydHMgRDEgRDIKWyAgICAwLjc1ODE3MF0gcGNpIDAwMDA6MDA6MDEuMDogUENJIGJyaWRn
ZSB0byBbYnVzIDAxXQpbICAgIDAuNzU4Nzk0XSBwY2kgMDAwMDowMDowMS4wOiAgIGJyaWRn
ZSB3aW5kb3cgW2lvICAweGUwMDAtMHhlZmZmXQpbICAgIDAuNzU4Nzk1XSBwY2kgMDAwMDow
MDowMS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGVmMDAwMDAwLTB4ZWYwZmZmZmZdClsg
ICAgMC43NTg3OThdIHBjaSAwMDAwOjAwOjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4
ZDAwMDAwMDAtMHhlMDFmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNzU4ODYwXSBwY2kgMDAw
MDowMjowMC4wOiBbMTA0Yzo4MjQwXSB0eXBlIDAxIGNsYXNzIDB4MDYwNDAwClsgICAgMC43
NTg5ODddIHBjaSAwMDAwOjAyOjAwLjA6IHN1cHBvcnRzIEQxIEQyClsgICAgMC43NTkwODld
IHBjaSAwMDAwOjAwOjFjLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMi0wM10KWyAgICAwLjc1
OTc5MV0gcGNpX2J1cyAwMDAwOjAzOiBleHRlbmRlZCBjb25maWcgc3BhY2Ugbm90IGFjY2Vz
c2libGUKWyAgICAwLjc2MDA2N10gcGNpIDAwMDA6MDI6MDAuMDogUENJIGJyaWRnZSB0byBb
YnVzIDAzXQpbICAgIDAuNzYyMDU5XSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0Fd
IChJUlFzIDMgNCA1IDYgMTAgKjExIDEyIDE0IDE1KQpbICAgIDAuNzYyODc2XSBBQ1BJOiBQ
Q0kgSW50ZXJydXB0IExpbmsgW0xOS0JdIChJUlFzIDMgNCA1IDYgKjEwIDExIDEyIDE0IDE1
KQpbICAgIDAuNzY0MDQwXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0NdIChJUlFz
IDMgNCA1IDYgMTAgKjExIDEyIDE0IDE1KQpbICAgIDAuNzY0ODU1XSBBQ1BJOiBQQ0kgSW50
ZXJydXB0IExpbmsgW0xOS0RdIChJUlFzIDMgNCA1IDYgMTAgKjExIDEyIDE0IDE1KQpbICAg
IDAuNzY2MDM5XSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0VdIChJUlFzIDMgNCA1
IDYgMTAgKjExIDEyIDE0IDE1KQpbICAgIDAuNzY2ODU1XSBBQ1BJOiBQQ0kgSW50ZXJydXB0
IExpbmsgW0xOS0ZdIChJUlFzIDMgNCA1IDYgMTAgKjExIDEyIDE0IDE1KQpbICAgIDAuNzY3
MDM4XSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0ddIChJUlFzIDMgNCA1IDYgMTAg
KjExIDEyIDE0IDE1KQpbICAgIDAuNzY3ODUzXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsg
W0xOS0hdIChJUlFzIDMgNCA1IDYgMTAgKjExIDEyIDE0IDE1KQpbICAgIDAuNzY5NTEyXSBw
Y2kgMDAwMDowMTowMC4wOiB2Z2FhcmI6IHNldHRpbmcgYXMgYm9vdCBWR0EgZGV2aWNlClsg
ICAgMC43NzAwMDJdIHBjaSAwMDAwOjAxOjAwLjA6IHZnYWFyYjogVkdBIGRldmljZSBhZGRl
ZDogZGVjb2Rlcz1pbyttZW0sb3ducz1pbyttZW0sbG9ja3M9bm9uZQpbICAgIDAuNzcxMDA0
XSBwY2kgMDAwMDowMTowMC4wOiB2Z2FhcmI6IGJyaWRnZSBjb250cm9sIHBvc3NpYmxlClsg
ICAgMC43NzE2OTBdIHZnYWFyYjogbG9hZGVkClsgICAgMC43NzIwMzldIFNDU0kgc3Vic3lz
dGVtIGluaXRpYWxpemVkClsgICAgMC43NzMyMjNdIGxpYmF0YSB2ZXJzaW9uIDMuMDAgbG9h
ZGVkLgpbICAgIDAuNzczMjIzXSBBQ1BJOiBidXMgdHlwZSBVU0IgcmVnaXN0ZXJlZApbICAg
IDAuNzczMjIzXSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVz
YmZzClsgICAgMC43NzM2ODBdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBk
cml2ZXIgaHViClsgICAgMC43NzUxMjddIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGRldmlj
ZSBkcml2ZXIgdXNiClsgICAgMC43NzU2NTRdIHBwc19jb3JlOiBMaW51eFBQUyBBUEkgdmVy
LiAxIHJlZ2lzdGVyZWQKWyAgICAwLjc3NjAwM10gcHBzX2NvcmU6IFNvZnR3YXJlIHZlci4g
NS4zLjYgLSBDb3B5cmlnaHQgMjAwNS0yMDA3IFJvZG9sZm8gR2lvbWV0dGkgPGdpb21ldHRp
QGxpbnV4Lml0PgpbICAgIDAuNzc3MDA0XSBQVFAgY2xvY2sgc3VwcG9ydCByZWdpc3RlcmVk
ClsgICAgMC43NzgwMjldIEVEQUMgTUM6IFZlcjogMy4wLjAKWyAgICAwLjc3ODU3Nl0gUENJ
OiBVc2luZyBBQ1BJIGZvciBJUlEgcm91dGluZwpbICAgIDAuNzkyNDE2XSBQQ0k6IHBjaV9j
YWNoZV9saW5lX3NpemUgc2V0IHRvIDY0IGJ5dGVzClsgICAgMC43OTI0NjJdIGU4MjA6IHJl
c2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4MDAwOTA0MDAtMHgwMDA5ZmZmZl0KWyAgICAwLjc5
MjQ2M10gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHhhYmM2ODAwMC0weGFiZmZm
ZmZmXQpbICAgIDAuNzkyNDY0XSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweGJh
MDBlMDAwLTB4YmJmZmZmZmZdClsgICAgMC43OTI0NjRdIGU4MjA6IHJlc2VydmUgUkFNIGJ1
ZmZlciBbbWVtIDB4YmM2MDAwMDAtMHhiZmZmZmZmZl0KWyAgICAwLjc5MjQ2NV0gZTgyMDog
cmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHg4M2UwMDAwMDAtMHg4M2ZmZmZmZmZdClsgICAg
MC43OTMwNDFdIGhwZXQwOiBhdCBNTUlPIDB4ZmVkMDAwMDAsIElSUXMgMiwgOCwgMCwgMCwg
MCwgMCwgMCwgMApbICAgIDAuNzkzMDQxXSBocGV0MDogOCBjb21wYXJhdG9ycywgNjQtYml0
IDI0LjAwMDAwMCBNSHogY291bnRlcgpbICAgIDAuNzk2MDEyXSBjbG9ja3NvdXJjZTogU3dp
dGNoZWQgdG8gY2xvY2tzb3VyY2UgdHNjLWVhcmx5ClsgICAgMC44MDM5NTFdIFZGUzogRGlz
ayBxdW90YXMgZHF1b3RfNi42LjAKWyAgICAwLjgwNDUwMF0gVkZTOiBEcXVvdC1jYWNoZSBo
YXNoIHRhYmxlIGVudHJpZXM6IDUxMiAob3JkZXIgMCwgNDA5NiBieXRlcykKWyAgICAwLjgw
NTMwMF0gRlMtQ2FjaGU6IExvYWRlZApbICAgIDAuODA1Nzc2XSBDYWNoZUZpbGVzOiBMb2Fk
ZWQKWyAgICAwLjgwNjI1MV0gcG5wOiBQblAgQUNQSSBpbml0ClsgICAgMC44MDY4NTRdIHN5
c3RlbSAwMDowMDogW2lvICAweDBhMDAtMHgwYTNmXSBoYXMgYmVlbiByZXNlcnZlZApbICAg
IDAuODA3NTU3XSBzeXN0ZW0gMDA6MDA6IFtpbyAgMHgwYTQwLTB4MGE3Zl0gaGFzIGJlZW4g
cmVzZXJ2ZWQKWyAgICAwLjgwODI2MV0gc3lzdGVtIDAwOjAwOiBQbHVnIGFuZCBQbGF5IEFD
UEkgZGV2aWNlLCBJRHMgUE5QMGMwMiAoYWN0aXZlKQpbICAgIDAuODA4NzUxXSBwbnAgMDA6
MDE6IFtkbWEgMCBkaXNhYmxlZF0KWyAgICAwLjgwODc4MF0gcG5wIDAwOjAxOiBQbHVnIGFu
ZCBQbGF5IEFDUEkgZGV2aWNlLCBJRHMgUE5QMDUwMSAoYWN0aXZlKQpbICAgIDAuODA4ODA3
XSBwbnAgMDA6MDI6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwMzAzIFBO
UDAzMGIgKGFjdGl2ZSkKWyAgICAwLjgwODgzNl0gcG5wIDAwOjAzOiBQbHVnIGFuZCBQbGF5
IEFDUEkgZGV2aWNlLCBJRHMgUE5QMGYwMyBQTlAwZjEzIChhY3RpdmUpClsgICAgMC44MDg5
MTddIHN5c3RlbSAwMDowNDogW2lvICAweDA2ODAtMHgwNjlmXSBoYXMgYmVlbiByZXNlcnZl
ZApbICAgIDAuODEyODY3XSBzeXN0ZW0gMDA6MDQ6IFtpbyAgMHhmZmZmXSBoYXMgYmVlbiBy
ZXNlcnZlZApbICAgIDAuODEzNTE5XSBzeXN0ZW0gMDA6MDQ6IFtpbyAgMHhmZmZmXSBoYXMg
YmVlbiByZXNlcnZlZApbICAgIDAuODE0MTcxXSBzeXN0ZW0gMDA6MDQ6IFtpbyAgMHhmZmZm
XSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuODE0ODIyXSBzeXN0ZW0gMDA6MDQ6IFtpbyAg
MHgxODAwLTB4MThmZV0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjgxNTUyMl0gc3lzdGVt
IDAwOjA0OiBbaW8gIDB4MTY0ZS0weDE2NGZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC44
MTYyMjVdIHN5c3RlbSAwMDowNDogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBO
UDBjMDIgKGFjdGl2ZSkKWyAgICAwLjgxNjI4M10gc3lzdGVtIDAwOjA1OiBbaW8gIDB4MDgw
MC0weDA4N2ZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC44MTY5ODVdIHN5c3RlbSAwMDow
NTogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBjMDIgKGFjdGl2ZSkKWyAg
ICAwLjgxNjk5Nl0gcG5wIDAwOjA2OiBQbHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNlLCBJRHMg
UE5QMGIwMCAoYWN0aXZlKQpbICAgIDAuODE3MDIwXSBzeXN0ZW0gMDA6MDc6IFtpbyAgMHgx
ODU0LTB4MTg1N10gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjgxNzcyMV0gc3lzdGVtIDAw
OjA3OiBQbHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNlLCBJRHMgSU5UM2YwZCBQTlAwYzAyIChh
Y3RpdmUpClsgICAgMC44MTc4NjNdIHN5c3RlbSAwMDowODogW21lbSAweGZlZDEwMDAwLTB4
ZmVkMTdmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC44MTg2MjJdIHN5c3RlbSAwMDow
ODogW21lbSAweGZlZDE4MDAwLTB4ZmVkMThmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAg
MC44MTkzODBdIHN5c3RlbSAwMDowODogW21lbSAweGZlZDE5MDAwLTB4ZmVkMTlmZmZdIGhh
cyBiZWVuIHJlc2VydmVkClsgICAgMC44MjAxMzhdIHN5c3RlbSAwMDowODogW21lbSAweGYw
MDAwMDAwLTB4ZjdmZmZmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC44MjA4OTZdIHN5
c3RlbSAwMDowODogW21lbSAweGZlZDIwMDAwLTB4ZmVkM2ZmZmZdIGhhcyBiZWVuIHJlc2Vy
dmVkClsgICAgMC44MjE2NTVdIHN5c3RlbSAwMDowODogW21lbSAweGZlZDkwMDAwLTB4ZmVk
OTNmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC44MjI0MTNdIHN5c3RlbSAwMDowODog
W21lbSAweGZlZDQ1MDAwLTB4ZmVkOGZmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC44
MjMxNzFdIHN5c3RlbSAwMDowODogW21lbSAweGZmMDAwMDAwLTB4ZmZmZmZmZmZdIGhhcyBi
ZWVuIHJlc2VydmVkClsgICAgMC44MjM5MzBdIHN5c3RlbSAwMDowODogW21lbSAweGZlZTAw
MDAwLTB4ZmVlZmZmZmZdIGNvdWxkIG5vdCBiZSByZXNlcnZlZApbICAgIDAuODI0NzE4XSBz
eXN0ZW0gMDA6MDg6IFttZW0gMHhlZmZlMDAwMC0weGVmZmZmZmZmXSBoYXMgYmVlbiByZXNl
cnZlZApbICAgIDAuODI1NDc3XSBzeXN0ZW0gMDA6MDg6IFBsdWcgYW5kIFBsYXkgQUNQSSBk
ZXZpY2UsIElEcyBQTlAwYzAyIChhY3RpdmUpClsgICAgMC44MjU1MDNdIHN5c3RlbSAwMDow
OTogW21lbSAweGZkMDAwMDAwLTB4ZmRhYmZmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAg
MC44MjYyNjJdIHN5c3RlbSAwMDowOTogW21lbSAweGZkYWQwMDAwLTB4ZmRhZGZmZmZdIGhh
cyBiZWVuIHJlc2VydmVkClsgICAgMC44MjcwMjBdIHN5c3RlbSAwMDowOTogW21lbSAweGZk
YjAwMDAwLTB4ZmRmZmZmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC44Mjc3NzhdIHN5
c3RlbSAwMDowOTogW21lbSAweGZlMDAwMDAwLTB4ZmUwMWZmZmZdIGNvdWxkIG5vdCBiZSBy
ZXNlcnZlZApbICAgIDAuODI4NTYzXSBzeXN0ZW0gMDA6MDk6IFttZW0gMHhmZTAzNjAwMC0w
eGZlMDNiZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuODI5MzIxXSBzeXN0ZW0gMDA6
MDk6IFttZW0gMHhmZTAzZDAwMC0weGZlM2ZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAg
IDAuODMwMDc3XSBzeXN0ZW0gMDA6MDk6IFttZW0gMHhmZTQxMDAwMC0weGZlN2ZmZmZmXSBo
YXMgYmVlbiByZXNlcnZlZApbICAgIDAuODMwODM0XSBzeXN0ZW0gMDA6MDk6IFBsdWcgYW5k
IFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwYzAyIChhY3RpdmUpClsgICAgMC44MzEwMzJd
IHN5c3RlbSAwMDowYTogW2lvICAweGZmMDAtMHhmZmZlXSBoYXMgYmVlbiByZXNlcnZlZApb
ICAgIDAuODMxNzM3XSBzeXN0ZW0gMDA6MGE6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2Us
IElEcyBQTlAwYzAyIChhY3RpdmUpClsgICAgMC44MzI1MDZdIHN5c3RlbSAwMDowYjogW21l
bSAweGZkYWYwMDAwLTB4ZmRhZmZmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC44MzMy
NjNdIHN5c3RlbSAwMDowYjogW21lbSAweGZkYWUwMDAwLTB4ZmRhZWZmZmZdIGhhcyBiZWVu
IHJlc2VydmVkClsgICAgMC44MzQwMThdIHN5c3RlbSAwMDowYjogW21lbSAweGZkYWMwMDAw
LTB4ZmRhY2ZmZmZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC44MzQ3NzVdIHN5c3RlbSAw
MDowYjogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBjMDIgKGFjdGl2ZSkK
WyAgICAwLjgzNTM2Nl0gcG5wOiBQblAgQUNQSTogZm91bmQgMTIgZGV2aWNlcwpbICAgIDAu
ODQxMTE4XSBjbG9ja3NvdXJjZTogYWNwaV9wbTogbWFzazogMHhmZmZmZmYgbWF4X2N5Y2xl
czogMHhmZmZmZmYsIG1heF9pZGxlX25zOiAyMDg1NzAxMDI0IG5zClsgICAgMC44NDIxOTld
IHBjaSAwMDAwOjAwOjAxLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMV0KWyAgICAwLjg0Mjgy
M10gcGNpIDAwMDA6MDA6MDEuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHhlMDAwLTB4ZWZm
Zl0KWyAgICAwLjg0MzUzOV0gcGNpIDAwMDA6MDA6MDEuMDogICBicmlkZ2Ugd2luZG93IFtt
ZW0gMHhlZjAwMDAwMC0weGVmMGZmZmZmXQpbICAgIDAuODQ0MzEyXSBwY2kgMDAwMDowMDow
MS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGQwMDAwMDAwLTB4ZTAxZmZmZmYgNjRiaXQg
cHJlZl0KWyAgICAwLjg0NTI3N10gcGNpIDAwMDA6MDI6MDAuMDogUENJIGJyaWRnZSB0byBb
YnVzIDAzXQpbICAgIDAuODQ1OTEzXSBwY2kgMDAwMDowMDoxYy4wOiBQQ0kgYnJpZGdlIHRv
IFtidXMgMDItMDNdClsgICAgMC44NDY1NzNdIHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2Ug
NCBbaW8gIDB4MDAwMC0weDBjZjcgd2luZG93XQpbICAgIDAuODQ2NTc0XSBwY2lfYnVzIDAw
MDA6MDA6IHJlc291cmNlIDUgW2lvICAweDBkMDAtMHhmZmZmIHdpbmRvd10KWyAgICAwLjg0
NjU3NV0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA2IFttZW0gMHgwMDBhMDAwMC0weDAw
MGJmZmZmIHdpbmRvd10KWyAgICAwLjg0NjU3Nl0gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJj
ZSA3IFttZW0gMHhjMDAwMDAwMC0weGVmZmZmZmZmIHdpbmRvd10KWyAgICAwLjg0NjU3Nl0g
cGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA4IFttZW0gMHhmZDAwMDAwMC0weGZlN2ZmZmZm
IHdpbmRvd10KWyAgICAwLjg0NjU3N10gcGNpX2J1cyAwMDAwOjAxOiByZXNvdXJjZSAwIFtp
byAgMHhlMDAwLTB4ZWZmZl0KWyAgICAwLjg0NjU3OF0gcGNpX2J1cyAwMDAwOjAxOiByZXNv
dXJjZSAxIFttZW0gMHhlZjAwMDAwMC0weGVmMGZmZmZmXQpbICAgIDAuODQ2NTc5XSBwY2lf
YnVzIDAwMDA6MDE6IHJlc291cmNlIDIgW21lbSAweGQwMDAwMDAwLTB4ZTAxZmZmZmYgNjRi
aXQgcHJlZl0KWyAgICAwLjg0NjY3NF0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWls
eSAyClsgICAgMC44NDczMjhdIHRjcF9saXN0ZW5fcG9ydGFkZHJfaGFzaCBoYXNoIHRhYmxl
IGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzKQpbICAgIDAuODQ4Mzcx
XSBUQ1AgZXN0YWJsaXNoZWQgaGFzaCB0YWJsZSBlbnRyaWVzOiAyNjIxNDQgKG9yZGVyOiA5
LCAyMDk3MTUyIGJ5dGVzKQpbICAgIDAuODQ5NTAyXSBUQ1AgYmluZCBoYXNoIHRhYmxlIGVu
dHJpZXM6IDY1NTM2IChvcmRlcjogOCwgMTA0ODU3NiBieXRlcykKWyAgICAwLjg1MDM0MV0g
VENQOiBIYXNoIHRhYmxlcyBjb25maWd1cmVkIChlc3RhYmxpc2hlZCAyNjIxNDQgYmluZCA2
NTUzNikKWyAgICAwLjg1MTEyMF0gVURQIGhhc2ggdGFibGUgZW50cmllczogMTYzODQgKG9y
ZGVyOiA3LCA1MjQyODggYnl0ZXMpClsgICAgMC44NTE4ODldIFVEUC1MaXRlIGhhc2ggdGFi
bGUgZW50cmllczogMTYzODQgKG9yZGVyOiA3LCA1MjQyODggYnl0ZXMpClsgICAgMC44NTM2
NjJdIHBjaSAwMDAwOjAxOjAwLjA6IFZpZGVvIGRldmljZSB3aXRoIHNoYWRvd2VkIFJPTSBh
dCBbbWVtIDB4MDAwYzAwMDAtMHgwMDBkZmZmZl0KWyAgICAwLjg1NDY3OV0gcGNpIDAwMDA6
MDE6MDAuMTogTGlua2VkIGFzIGEgY29uc3VtZXIgdG8gMDAwMDowMTowMC4wClsgICAgMC44
NTU0MDZdIFBDSTogQ0xTIDAgYnl0ZXMsIGRlZmF1bHQgNjQKWyAgICAwLjg1NTQ0NF0gVHJ5
aW5nIHRvIHVucGFjayByb290ZnMgaW1hZ2UgYXMgaW5pdHJhbWZzLi4uClsgICAgMC45MTMw
MjFdIEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogNTEzNksKWyAgICAwLjkxMzU2M10gUENJLURN
QTogVXNpbmcgc29mdHdhcmUgYm91bmNlIGJ1ZmZlcmluZyBmb3IgSU8gKFNXSU9UTEIpClsg
ICAgMC45MTQzMDldIHNvZnR3YXJlIElPIFRMQjogbWFwcGVkIFttZW0gMHhiNjAwZTAwMC0w
eGJhMDBlMDAwXSAoNjRNQikKWyAgICAwLjkxNTE0MF0gUkFQTCBQTVU6IEFQSSB1bml0IGlz
IDJeLTMyIEpvdWxlcywgNSBmaXhlZCBjb3VudGVycywgNjU1MzYwIG1zIG92ZmwgdGltZXIK
WyAgICAwLjkxNjEyMF0gUkFQTCBQTVU6IGh3IHVuaXQgb2YgZG9tYWluIHBwMC1jb3JlIDJe
LTE0IEpvdWxlcwpbICAgIDAuOTE2ODA3XSBSQVBMIFBNVTogaHcgdW5pdCBvZiBkb21haW4g
cGFja2FnZSAyXi0xNCBKb3VsZXMKWyAgICAwLjkxNzQ4OV0gUkFQTCBQTVU6IGh3IHVuaXQg
b2YgZG9tYWluIGRyYW0gMl4tMTQgSm91bGVzClsgICAgMC45MTgxNDhdIFJBUEwgUE1VOiBo
dyB1bml0IG9mIGRvbWFpbiBwcDEtZ3B1IDJeLTE0IEpvdWxlcwpbICAgIDAuOTE4ODI4XSBS
QVBMIFBNVTogaHcgdW5pdCBvZiBkb21haW4gcHN5cyAyXi0xNCBKb3VsZXMKWyAgICAwLjkx
OTU5Nl0gY2xvY2tzb3VyY2U6IHRzYzogbWFzazogMHhmZmZmZmZmZmZmZmZmZmZmIG1heF9j
eWNsZXM6IDB4MzNlNDUyZmJiMmYsIG1heF9pZGxlX25zOiA0NDA3OTUyMzY1OTMgbnMKWyAg
ICAwLjkyMDc1NV0gY2xvY2tzb3VyY2U6IFN3aXRjaGVkIHRvIGNsb2Nrc291cmNlIHRzYwpb
ICAgIDAuOTIxNzczXSB3b3JraW5nc2V0OiB0aW1lc3RhbXBfYml0cz00MCBtYXhfb3JkZXI9
MjMgYnVja2V0X29yZGVyPTAKWyAgICAwLjkyMjY1NF0gU0dJIFhGUyB3aXRoIEFDTHMsIHNl
Y3VyaXR5IGF0dHJpYnV0ZXMsIHJlYWx0aW1lLCBubyBkZWJ1ZyBlbmFibGVkClsgICAgMC45
MjQxNDNdIEJsb2NrIGxheWVyIFNDU0kgZ2VuZXJpYyAoYnNnKSBkcml2ZXIgdmVyc2lvbiAw
LjQgbG9hZGVkIChtYWpvciAyNDkpClsgICAgMC45MjUwOTldIGlvIHNjaGVkdWxlciBub29w
IHJlZ2lzdGVyZWQKWyAgICAwLjkyNTYzOF0gaW8gc2NoZWR1bGVyIGRlYWRsaW5lIHJlZ2lz
dGVyZWQKWyAgICAwLjkyNjIxMV0gaW8gc2NoZWR1bGVyIGNmcSByZWdpc3RlcmVkIChkZWZh
dWx0KQpbICAgIDAuOTI2ODEzXSBpbyBzY2hlZHVsZXIgbXEtZGVhZGxpbmUgcmVnaXN0ZXJl
ZApbICAgIDAuOTI3NDAzXSBpbyBzY2hlZHVsZXIga3liZXIgcmVnaXN0ZXJlZApbICAgIDAu
OTI4MjQ4XSBhZXIgMDAwMDowMDoxYy4wOnBjaWUwMDI6IEFFUiBlbmFibGVkIHdpdGggSVJR
IDEyMApbICAgIDAuOTI4OTk1XSBJUE1JIG1lc3NhZ2UgaGFuZGxlcjogdmVyc2lvbiAzOS4y
ClsgICAgMC45Mjk1ODBdIGlwbWkgZGV2aWNlIGludGVyZmFjZQpbICAgIDAuOTMwMDc0XSBp
cG1pX3NpOiBJUE1JIFN5c3RlbSBJbnRlcmZhY2UgZHJpdmVyClsgICAgMC45MzA2ODldIGlw
bWlfc2k6IFVuYWJsZSB0byBmaW5kIGFueSBTeXN0ZW0gSW50ZXJmYWNlKHMpClsgICAgMC45
MzEzNjJdIElQTUkgV2F0Y2hkb2c6IGRyaXZlciBpbml0aWFsaXplZApbICAgIDAuOTMxOTM0
XSBJUE1JIHBvd2Vyb2ZmOiBDb3B5cmlnaHQgKEMpIDIwMDQgTW9udGFWaXN0YSBTb2Z0d2Fy
ZSAtIElQTUkgUG93ZXJkb3duIHZpYSBzeXNfcmVib290ClsgICAgMC45MzMwNDFdIGlucHV0
OiBTbGVlcCBCdXR0b24gYXMgL2RldmljZXMvTE5YU1lTVE06MDAvTE5YU1lCVVM6MDAvUE5Q
MEMwRTowMC9pbnB1dC9pbnB1dDAKWyAgICAwLjkzNDA1N10gQUNQSTogU2xlZXAgQnV0dG9u
IFtTTFBCXQpbICAgIDAuOTM0NTg3XSBpbnB1dDogUG93ZXIgQnV0dG9uIGFzIC9kZXZpY2Vz
L0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBDMEM6MDAvaW5wdXQvaW5wdXQxClsgICAg
MC45MzU2MDFdIEFDUEk6IFBvd2VyIEJ1dHRvbiBbUFdSQl0KWyAgICAwLjkzNjEzOF0gaW5w
dXQ6IFBvd2VyIEJ1dHRvbiBhcyAvZGV2aWNlcy9MTlhTWVNUTTowMC9MTlhQV1JCTjowMC9p
bnB1dC9pbnB1dDIKWyAgICAwLjkzNzA4M10gQUNQSTogUG93ZXIgQnV0dG9uIFtQV1JGXQpb
ICAgIDAuOTY5MzU4XSBNb25pdG9yLU13YWl0IHdpbGwgYmUgdXNlZCB0byBlbnRlciBDLTEg
c3RhdGUKWyAgICAwLjk2OTM2Ml0gTW9uaXRvci1Nd2FpdCB3aWxsIGJlIHVzZWQgdG8gZW50
ZXIgQy0yIHN0YXRlClsgICAgMC45NjkzNjZdIE1vbml0b3ItTXdhaXQgd2lsbCBiZSB1c2Vk
IHRvIGVudGVyIEMtMyBzdGF0ZQpbICAgIDEuMDAwMzQwXSB0aGVybWFsIExOWFRIRVJNOjAw
OiByZWdpc3RlcmVkIGFzIHRoZXJtYWxfem9uZTAKWyAgICAxLjAwMTAyNl0gQUNQSTogVGhl
cm1hbCBab25lIFtUWjAwXSAoMjggQykKWyAgICAxLjAwMTcwMl0gdGhlcm1hbCBMTlhUSEVS
TTowMTogcmVnaXN0ZXJlZCBhcyB0aGVybWFsX3pvbmUxClsgICAgMS4wMDIzODNdIEFDUEk6
IFRoZXJtYWwgWm9uZSBbVFowMV0gKDMwIEMpClsgICAgMS4wMDMwNjhdIFNlcmlhbDogODI1
MC8xNjU1MCBkcml2ZXIsIDQgcG9ydHMsIElSUSBzaGFyaW5nIGRpc2FibGVkClsgICAgMS4w
MjQ4NDRdIDAwOjAxOiB0dHlTMCBhdCBJL08gMHgzZjggKGlycSA9IDQsIGJhc2VfYmF1ZCA9
IDExNTIwMCkgaXMgYSAxNjU1MEEKWyAgICAxLjAyNjI5NV0gbHA6IGRyaXZlciBsb2FkZWQg
YnV0IG5vIGRldmljZXMgZm91bmQKWyAgICAxLjAyNzA2MV0gTGludXggYWdwZ2FydCBpbnRl
cmZhY2UgdjAuMTAzClsgICAgMS4wMzAxMDJdIGJyZDogbW9kdWxlIGxvYWRlZApbICAgIDEu
MDMxODAwXSBsb29wOiBtb2R1bGUgbG9hZGVkClsgICAgMS4wMzYwOTZdIGRyYmQ6IGluaXRp
YWxpemVkLiBWZXJzaW9uOiA4LjQuMTAgKGFwaToxL3Byb3RvOjg2LTEwMSkKWyAgICAxLjAz
NjgyN10gZHJiZDogYnVpbHQtaW4KWyAgICAxLjAzNzI2OV0gZHJiZDogcmVnaXN0ZXJlZCBh
cyBibG9jayBkZXZpY2UgbWFqb3IgMTQ3ClsgICAgMS4wMzc5MzBdIFVuaWZvcm0gTXVsdGkt
UGxhdGZvcm0gRS1JREUgZHJpdmVyClsgICAgMS4wMzg5OTddIGlkZV9nZW5lcmljOiBwbGVh
c2UgdXNlICJwcm9iZV9tYXNrPTB4M2YiIG1vZHVsZSBwYXJhbWV0ZXIgZm9yIHByb2Jpbmcg
YWxsIGxlZ2FjeSBJU0EgSURFIHBvcnRzClsgICAgMS4wNDAxNTRdIFByb2JpbmcgSURFIGlu
dGVyZmFjZSBpZGUwLi4uClsgICAgMS41NjMyNDZdIGlkZTAgYXQgMHgxZjAtMHgxZjcsMHgz
ZjYgb24gaXJxIDE0ClsgICAgMS41NjM4NDRdIFByb2JpbmcgSURFIGludGVyZmFjZSBpZGUx
Li4uClsgICAgMi4wODYyNDRdIGlkZTEgYXQgMHgxNzAtMHgxNzcsMHgzNzYgb24gaXJxIDE1
ClsgICAgMi4wODY4MzldIGlkZS1nZCBkcml2ZXIgMS4xOApbICAgIDIuMDg3MzE0XSBpZGUt
Y2QgZHJpdmVyIDUuMDAKWyAgICAyLjA4NzkxMF0gbWVnYXJhaWQgY21tOiAyLjIwLjIuNyAo
UmVsZWFzZSBEYXRlOiBTdW4gSnVsIDE2IDAwOjAxOjAzIEVTVCAyMDA2KQpbICAgIDIuMDg4
ODk2XSBtZWdhcmFpZDogMi4yMC41LjEgKFJlbGVhc2UgRGF0ZTogVGh1IE5vdiAxNiAxNToz
MjozNSBFU1QgMjAwNikKWyAgICAyLjA4OTY5MF0gbWVnYXNhczogMDcuNzA2LjAzLjAwLXJj
MQpbICAgIDIuMDkwMjE3XSBtcHQzc2FzIHZlcnNpb24gMjYuMTAwLjAwLjAwIGxvYWRlZApb
ICAgIDIuMDkxMTA1XSBhaGNpIDAwMDA6MDA6MTcuMDogdmVyc2lvbiAzLjAKWyAgICAyLjA5
MTIxNV0gYWhjaSAwMDAwOjAwOjE3LjA6IGNvbnRyb2xsZXIgY2FuJ3QgZG8gU05URiwgdHVy
bmluZyBvZmYgQ0FQX1NOVEYKWyAgICAyLjEwMjIyM10gYWhjaSAwMDAwOjAwOjE3LjA6IEFI
Q0kgMDAwMS4wMzAxIDMyIHNsb3RzIDQgcG9ydHMgNiBHYnBzIDB4ZiBpbXBsIFJBSUQgbW9k
ZQpbICAgIDIuMTAzMjIwXSBhaGNpIDAwMDA6MDA6MTcuMDogZmxhZ3M6IDY0Yml0IG5jcSBw
bSBsZWQgY2xvIG9ubHkgcGlvIHNsdW0gcGFydCBlbXMgZGVzbyBzYWRtIHNkcyBhcHN0IApb
ICAgIDIuMTEzNjI0XSBzY3NpIGhvc3QwOiBhaGNpClsgICAgMi4xMTQyODhdIHNjc2kgaG9z
dDE6IGFoY2kKWyAgICAyLjExNDg5NV0gc2NzaSBob3N0MjogYWhjaQpbICAgIDIuMTE1NjAy
XSBzY3NpIGhvc3QzOiBhaGNpClsgICAgMi4xMTYwOTNdIGF0YTE6IFNBVEEgbWF4IFVETUEv
MTMzIGFiYXIgbTIwNDhAMHhlZjE0YjAwMCBwb3J0IDB4ZWYxNGIxMDAgaXJxIDEyMQpbICAg
IDIuMTE3MDM4XSBhdGEyOiBTQVRBIG1heCBVRE1BLzEzMyBhYmFyIG0yMDQ4QDB4ZWYxNGIw
MDAgcG9ydCAweGVmMTRiMTgwIGlycSAxMjEKWyAgICAyLjExNzk4MF0gYXRhMzogU0FUQSBt
YXggVURNQS8xMzMgYWJhciBtMjA0OEAweGVmMTRiMDAwIHBvcnQgMHhlZjE0YjIwMCBpcnEg
MTIxClsgICAgMi4xMTg5MjJdIGF0YTQ6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTIwNDhA
MHhlZjE0YjAwMCBwb3J0IDB4ZWYxNGIyODAgaXJxIDEyMQpbICAgIDIuMTIwMDM2XSB0dW46
IFVuaXZlcnNhbCBUVU4vVEFQIGRldmljZSBkcml2ZXIsIDEuNgpbICAgIDIuMTIwNzc3XSBi
bngyeDogUUxvZ2ljIDU3NzF4LzU3OHh4IDEwLzIwLUdpZ2FiaXQgRXRoZXJuZXQgRHJpdmVy
IGJueDJ4IDEuNzEyLjMwLTAgKDIwMTQvMDIvMTApClsgICAgMi4xMjE5NjhdIGUxMDA6IElu
dGVsKFIpIFBSTy8xMDAgTmV0d29yayBEcml2ZXIsIDMuNS4yNC1rMi1OQVBJClsgICAgMi4x
MjI2ODhdIGUxMDA6IENvcHlyaWdodChjKSAxOTk5LTIwMDYgSW50ZWwgQ29ycG9yYXRpb24K
WyAgICAyLjEyMzM2MF0gZTEwMDA6IEludGVsKFIpIFBSTy8xMDAwIE5ldHdvcmsgRHJpdmVy
IC0gdmVyc2lvbiA3LjMuMjEtazgtTkFQSQpbICAgIDIuMTI0MTU0XSBlMTAwMDogQ29weXJp
Z2h0IChjKSAxOTk5LTIwMDYgSW50ZWwgQ29ycG9yYXRpb24uClsgICAgMi4xMjQ4NDVdIGUx
MDAwZTogSW50ZWwoUikgUFJPLzEwMDAgTmV0d29yayBEcml2ZXIgLSAzLjIuNi1rClsgICAg
Mi4xMjU1NDBdIGUxMDAwZTogQ29weXJpZ2h0KGMpIDE5OTkgLSAyMDE1IEludGVsIENvcnBv
cmF0aW9uLgpbICAgIDIuMTI2MzgyXSBlMTAwMGUgMDAwMDowMDoxZi42OiBJbnRlcnJ1cHQg
VGhyb3R0bGluZyBSYXRlIChpbnRzL3NlYykgc2V0IHRvIGR5bmFtaWMgY29uc2VydmF0aXZl
IG1vZGUKWyAgICAyLjQzMDMyOF0gYXRhMTogU0FUQSBsaW5rIHVwIDYuMCBHYnBzIChTU3Rh
dHVzIDEzMyBTQ29udHJvbCAzMDApClsgICAgMi40MzEwNjldIGF0YTQ6IFNBVEEgbGluayBk
b3duIChTU3RhdHVzIDQgU0NvbnRyb2wgMzAwKQpbICAgIDIuNDMxNzQ2XSBhdGEyOiBTQVRB
IGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEzIFNDb250cm9sIDMwMCkKWyAgICAyLjQz
MjQ4M10gYXRhMzogU0FUQSBsaW5rIGRvd24gKFNTdGF0dXMgNCBTQ29udHJvbCAzMDApClsg
ICAgMi40MzM2MjNdIGF0YTEuMDA6IEFUQS04OiBUT1NISUJBIERUMDFBQ0EwNTAsIE1TMU9B
ODEwLCBtYXggVURNQS8xMzMKWyAgICAyLjQzNDM4MF0gYXRhMS4wMDogOTc2NzczMTY4IHNl
Y3RvcnMsIG11bHRpIDE2OiBMQkE0OCBOQ1EgKGRlcHRoIDMyKSwgQUEKWyAgICAyLjQzNTE3
MV0gYXRhMi4wMDogQVRBUEk6IEhMLURULVNUIERWRCsvLVJXIEdIQjBOLCBBMUMwLCBtYXgg
VURNQS8xMDAKWyAgICAyLjQzNjY4MF0gYXRhMS4wMDogY29uZmlndXJlZCBmb3IgVURNQS8x
MzMKWyAgICAyLjQzNzM1M10gYXRhMi4wMDogY29uZmlndXJlZCBmb3IgVURNQS8xMDAKWyAg
ICAyLjUzNjA5N10gZTEwMDBlIDAwMDA6MDA6MWYuNiAwMDAwOjAwOjFmLjYgKHVuaW5pdGlh
bGl6ZWQpOiByZWdpc3RlcmVkIFBIQyBjbG9jawpbICAgIDIuNjE4Mzk1XSBlMTAwMGUgMDAw
MDowMDoxZi42IGV0aDA6IChQQ0kgRXhwcmVzczoyLjVHVC9zOldpZHRoIHgxKSBkODo5ZTpm
MzozNzoxNzozYwpbICAgIDIuNjE5Mzc3XSBlMTAwMGUgMDAwMDowMDoxZi42IGV0aDA6IElu
dGVsKFIpIFBSTy8xMDAwIE5ldHdvcmsgQ29ubmVjdGlvbgpbICAgIDIuNjIwMjIwXSBlMTAw
MGUgMDAwMDowMDoxZi42IGV0aDA6IE1BQzogMTIsIFBIWTogMTIsIFBCQSBObzogRkZGRkZG
LTBGRgpbICAgIDIuNjIxMDE1XSBpZ2I6IEludGVsKFIpIEdpZ2FiaXQgRXRoZXJuZXQgTmV0
d29yayBEcml2ZXIgLSB2ZXJzaW9uIDUuNC4wLWsKWyAgICAyLjYyMTc5OV0gaWdiOiBDb3B5
cmlnaHQgKGMpIDIwMDctMjAxNCBJbnRlbCBDb3Jwb3JhdGlvbi4KWyAgICAyLjYyMjQ4NF0g
aWdidmY6IEludGVsKFIpIEdpZ2FiaXQgVmlydHVhbCBGdW5jdGlvbiBOZXR3b3JrIERyaXZl
ciAtIHZlcnNpb24gMi40LjAtawpbICAgIDIuNjIzNDU0XSBpZ2J2ZjogQ29weXJpZ2h0IChj
KSAyMDA5IC0gMjAxMiBJbnRlbCBDb3Jwb3JhdGlvbi4KWyAgICAyLjYyNDE2OV0gc2t5Mjog
ZHJpdmVyIHZlcnNpb24gMS4zMApbICAgIDIuNjI0NzU0XSBGdXNpb24gTVBUIGJhc2UgZHJp
dmVyIDMuMDQuMjAKWyAgICAyLjYyNTMwOV0gQ29weXJpZ2h0IChjKSAxOTk5LTIwMDggTFNJ
IENvcnBvcmF0aW9uClsgICAgMi42MjU5MjhdIEZ1c2lvbiBNUFQgU1BJIEhvc3QgZHJpdmVy
IDMuMDQuMjAKWyAgICAyLjYyNjUxN10gRnVzaW9uIE1QVCBGQyBIb3N0IGRyaXZlciAzLjA0
LjIwClsgICAgMi42MjcwOThdIEZ1c2lvbiBNUFQgU0FTIEhvc3QgZHJpdmVyIDMuMDQuMjAK
WyAgICAyLjYyNzY4NV0gRnVzaW9uIE1QVCBtaXNjIGRldmljZSAoaW9jdGwpIGRyaXZlciAz
LjA0LjIwClsgICAgMi42Mjg0MjNdIG1wdGN0bDogUmVnaXN0ZXJlZCB3aXRoIEZ1c2lvbiBN
UFQgYmFzZSBkcml2ZXIKWyAgICAyLjYyOTA5MF0gbXB0Y3RsOiAvZGV2L21wdGN0bCBAICht
YWpvcixtaW5vcj0xMCwyMjApClsgICAgMi42Mjk3MzBdIGVoY2lfaGNkOiBVU0IgMi4wICdF
bmhhbmNlZCcgSG9zdCBDb250cm9sbGVyIChFSENJKSBEcml2ZXIKWyAgICAyLjYzMDQ4MF0g
ZWhjaS1wY2k6IEVIQ0kgUENJIHBsYXRmb3JtIGRyaXZlcgpbICAgIDIuNjMxMDY3XSBvaGNp
X2hjZDogVVNCIDEuMSAnT3BlbicgSG9zdCBDb250cm9sbGVyIChPSENJKSBEcml2ZXIKWyAg
ICAyLjYzMTc5Ml0gb2hjaS1wY2k6IE9IQ0kgUENJIHBsYXRmb3JtIGRyaXZlcgpbICAgIDIu
NjMyMzc5XSB1aGNpX2hjZDogVVNCIFVuaXZlcnNhbCBIb3N0IENvbnRyb2xsZXIgSW50ZXJm
YWNlIGRyaXZlcgpbICAgIDIuNjMzMjUyXSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IHhIQ0kg
SG9zdCBDb250cm9sbGVyClsgICAgMi42MzcxMzBdIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDog
bmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAxClsgICAgMi42
MzkxNzhdIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDogaGNjIHBhcmFtcyAweDIwMDA3N2MxIGhj
aSB2ZXJzaW9uIDB4MTAwIHF1aXJrcyAweDAwMDAwMDAwMDExMDk4MTAKWyAgICAyLjY0MDI2
Ml0geGhjaV9oY2QgMDAwMDowMDoxNC4wOiBjYWNoZSBsaW5lIHNpemUgb2YgNjQgaXMgbm90
IHN1cHBvcnRlZApbICAgIDIuNjQwNTY5XSBodWIgMS0wOjEuMDogVVNCIGh1YiBmb3VuZApb
ICAgIDIuNjQxMTI4XSBodWIgMS0wOjEuMDogMTYgcG9ydHMgZGV0ZWN0ZWQKWyAgICAyLjY0
MjYxMF0geGhjaV9oY2QgMDAwMDowMDoxNC4wOiB4SENJIEhvc3QgQ29udHJvbGxlcgpbICAg
IDIuNjQzMjU4XSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IG5ldyBVU0IgYnVzIHJlZ2lzdGVy
ZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMgpbICAgIDIuNjQ0MTk2XSB4aGNpX2hjZCAwMDAw
OjAwOjE0LjA6IEhvc3Qgc3VwcG9ydHMgVVNCIDMuMCAgU3VwZXJTcGVlZApbICAgIDIuNjQ1
MDkzXSBodWIgMi0wOjEuMDogVVNCIGh1YiBmb3VuZApbICAgIDIuNjQ1NjM4XSBodWIgMi0w
OjEuMDogMTAgcG9ydHMgZGV0ZWN0ZWQKWyAgICAyLjY0NjU3N10gdXNiOiBwb3J0IHBvd2Vy
IG1hbmFnZW1lbnQgbWF5IGJlIHVucmVsaWFibGUKWyAgICAyLjY0NzUzN10gdXNiY29yZTog
cmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2Itc3RvcmFnZQpbICAgIDIuNjQ4
MjU1XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIGZ0ZGlfc2lv
ClsgICAgMi42NDg5NDRdIHVzYnNlcmlhbDogVVNCIFNlcmlhbCBzdXBwb3J0IHJlZ2lzdGVy
ZWQgZm9yIEZUREkgVVNCIFNlcmlhbCBEZXZpY2UKWyAgICAyLjY0OTg4MF0gdXNiY29yZTog
cmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBvbW5pbmV0ClsgICAgMi42NTA1NjJd
IHVzYnNlcmlhbDogVVNCIFNlcmlhbCBzdXBwb3J0IHJlZ2lzdGVyZWQgZm9yIFp5WEVMIC0g
b21uaS5uZXQgbGNkIHBsdXMgdXNiClsgICAgMi42NTE1NTddIGk4MDQyOiBQTlA6IFBTLzIg
Q29udHJvbGxlciBbUE5QMDMwMzpQUzJLLFBOUDBmMDM6UFMyTV0gYXQgMHg2MCwweDY0IGly
cSAxLDEyClsgICAgMi42NTUyNTddIHNlcmlvOiBpODA0MiBLQkQgcG9ydCBhdCAweDYwLDB4
NjQgaXJxIDEKWyAgICAyLjY1NTg4M10gc2VyaW86IGk4MDQyIEFVWCBwb3J0IGF0IDB4NjAs
MHg2NCBpcnEgMTIKWyAgICAyLjY1NjgzN10gcnRjX2Ntb3MgMDA6MDY6IFJUQyBjYW4gd2Fr
ZSBmcm9tIFM0ClsgICAgMi42NTc4OThdIHJ0Y19jbW9zIDAwOjA2OiByZWdpc3RlcmVkIGFz
IHJ0YzAKWyAgICAyLjY1ODQ5MF0gcnRjX2Ntb3MgMDA6MDY6IGFsYXJtcyB1cCB0byBvbmUg
bW9udGgsIHkzaywgMjQyIGJ5dGVzIG52cmFtLCBocGV0IGlycXMKWyAgICAyLjY1OTYxNl0g
aTgwMV9zbWJ1cyAwMDAwOjAwOjFmLjQ6IFNQRCBXcml0ZSBEaXNhYmxlIGlzIHNldApbICAg
IDIuNjYwMzQzXSBpODAxX3NtYnVzIDAwMDA6MDA6MWYuNDogU01CdXMgdXNpbmcgUENJIGlu
dGVycnVwdApbICAgIDIuNjYyNDA2XSBpVENPX3dkdDogSW50ZWwgVENPIFdhdGNoRG9nIFRp
bWVyIERyaXZlciB2MS4xMQpbICAgIDIuNjYzMTczXSBpVENPX3dkdDogRm91bmQgYSBJbnRl
bCBQQ0ggVENPIGRldmljZSAoVmVyc2lvbj00LCBUQ09CQVNFPTB4MDQwMCkKWyAgICAyLjY2
NDI4OF0gaVRDT193ZHQ6IGluaXRpYWxpemVkLiBoZWFydGJlYXQ9MzAgc2VjIChub3dheW91
dD0wKQpbICAgIDIuNjY1MDA4XSBpVENPX3ZlbmRvcl9zdXBwb3J0OiB2ZW5kb3Itc3VwcG9y
dD0wClsgICAgMi42NjU2MTddIG52X3RjbzogTlYgVENPIFdhdGNoRG9nIFRpbWVyIERyaXZl
ciB2MC4wMQpbICAgIDIuNjY2NDgwXSBpbnRlbF9wc3RhdGU6IEludGVsIFAtc3RhdGUgZHJp
dmVyIGluaXRpYWxpemluZwpbICAgIDIuNjY3MTkzXSBpbnRlbF9wc3RhdGU6IERpc2FibGlu
ZyBlbmVyZ3kgZWZmaWNpZW5jeSBvcHRpbWl6YXRpb24KWyAgICAyLjY2OTE4MV0gaW50ZWxf
cHN0YXRlOiBIV1AgZW5hYmxlZApbICAgIDIuNjY5NzE0XSBoaWRyYXc6IHJhdyBISUQgZXZl
bnRzIGRyaXZlciAoQykgSmlyaSBLb3NpbmEKWyAgICAyLjY3MDUwNl0gdXNiY29yZTogcmVn
aXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2JoaWQKWyAgICAyLjY3MTIxOF0gdXNi
aGlkOiBVU0IgSElEIGNvcmUgZHJpdmVyClsgICAgMi42NzE4MzFdIEtleSB0eXBlIGRuc19y
ZXNvbHZlciByZWdpc3RlcmVkClsgICAgMi42NzI5NjVdIG1pY3JvY29kZTogc2lnPTB4OTA2
ZTksIHBmPTB4MiwgcmV2aXNpb249MHg4ZQpbICAgIDIuNjczODA0XSBtaWNyb2NvZGU6IE1p
Y3JvY29kZSBVcGRhdGUgRHJpdmVyOiB2Mi4yLgpbICAgIDIuNjczODEwXSBzY2hlZF9jbG9j
azogTWFya2luZyBzdGFibGUgKDI1NTMyOTc2OTksIDEyMDUwMjc4MCktPigyNjgzNTc0NzU2
LCAtOTc3NDI3NykKWyAgICAyLjY3NTc3OF0gcmVnaXN0ZXJlZCB0YXNrc3RhdHMgdmVyc2lv
biAxClsgICAgMi42NzcwMTddIHJ0Y19jbW9zIDAwOjA2OiBzZXR0aW5nIHN5c3RlbSBjbG9j
ayB0byAyMDE5LTAzLTA2IDE2OjIwOjM2IFVUQyAoMTU1MTg4OTIzNikKWyAgICAyLjk2MjIx
NF0gdXNiIDEtMjogbmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyB4
aGNpX2hjZApbICAgIDMuMDkwODY5XSB1c2IgMS0yOiBjb25maWcgMSBpbnRlcmZhY2UgMCBh
bHRzZXR0aW5nIDAgaGFzIDIgZW5kcG9pbnQgZGVzY3JpcHRvcnMsIGRpZmZlcmVudCBmcm9t
IHRoZSBpbnRlcmZhY2UgZGVzY3JpcHRvcidzIHZhbHVlOiAxClsgICAgMy4yMDkyMjZdIHVz
YiAxLTQ6IG5ldyBsb3ctc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMyB1c2luZyB4aGNpX2hj
ZApbICAgIDMuMzQ5MzI4XSBpbnB1dDogRGVsbCBEZWxsIFVTQiBFbnRyeSBLZXlib2FyZCBh
cyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTQuMC91c2IxLzEtNC8xLTQ6MS4wLzAw
MDM6NDEzQzoyMTA3LjAwMDIvaW5wdXQvaW5wdXQ2ClsgICAgMy40MDI0MzddIGhpZC1nZW5l
cmljIDAwMDM6NDEzQzoyMTA3LjAwMDI6IGlucHV0LGhpZHJhdzA6IFVTQiBISUQgdjEuMTAg
S2V5Ym9hcmQgW0RlbGwgRGVsbCBVU0IgRW50cnkgS2V5Ym9hcmRdIG9uIHVzYi0wMDAwOjAw
OjE0LjAtNC9pbnB1dDAKWyAgICAzLjUxNzIxMl0gdXNiIDEtNTogbmV3IGxvdy1zcGVlZCBV
U0IgZGV2aWNlIG51bWJlciA0IHVzaW5nIHhoY2lfaGNkClsgICAgMy42NTIwNDJdIGlucHV0
OiBMb2dpdGVjaCBVU0IgT3B0aWNhbCBNb3VzZSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAw
MDA6MDA6MTQuMC91c2IxLzEtNS8xLTU6MS4wLzAwMDM6MDQ2RDpDMDVBLjAwMDMvaW5wdXQv
aW5wdXQ3ClsgICAgMy42NTM1ODZdIGhpZC1nZW5lcmljIDAwMDM6MDQ2RDpDMDVBLjAwMDM6
IGlucHV0LGhpZHJhdzE6IFVTQiBISUQgdjEuMTEgTW91c2UgW0xvZ2l0ZWNoIFVTQiBPcHRp
Y2FsIE1vdXNlXSBvbiB1c2ItMDAwMDowMDoxNC4wLTUvaW5wdXQwClsgICAgNC4wNzIzNzhd
IGZsb3BweTA6IG5vIGZsb3BweSBjb250cm9sbGVycyBmb3VuZApbICAgIDQuMDczMzQ0XSBz
Y3NpIDA6MDowOjA6IERpcmVjdC1BY2Nlc3MgICAgIEFUQSAgICAgIFRPU0hJQkEgRFQwMUFD
QTAgQTgxMCBQUTogMCBBTlNJOiA1ClsgICAgNC4wNzQ2NjNdIHNkIDA6MDowOjA6IEF0dGFj
aGVkIHNjc2kgZ2VuZXJpYyBzZzAgdHlwZSAwClsgICAgNC4wNzQ4MDNdIHNkIDA6MDowOjA6
IFtzZGFdIDk3Njc3MzE2OCA1MTItYnl0ZSBsb2dpY2FsIGJsb2NrczogKDUwMCBHQi80NjYg
R2lCKQpbICAgIDQuMDc2MjEyXSBzY3NpIDE6MDowOjA6IENELVJPTSAgICAgICAgICAgIEhM
LURULVNUIERWRCstUlcgR0hCME4gICAgQTFDMCBQUTogMCBBTlNJOiA1ClsgICAgNC4wNzYz
ODldIHNkIDA6MDowOjA6IFtzZGFdIDQwOTYtYnl0ZSBwaHlzaWNhbCBibG9ja3MKWyAgICA0
LjA3ODEwM10gc2QgMDowOjA6MDogW3NkYV0gV3JpdGUgUHJvdGVjdCBpcyBvZmYKWyAgICA0
LjA3ODcwOV0gc2QgMDowOjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAgMDAKWyAg
ICA0LjA3ODcxNF0gc2QgMDowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJl
YWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBClsgICAgNC4x
MDY4NjhdICBzZGE6IHNkYTEgc2RhMiBzZGEzClsgICAgNC4xMDc1NzhdIHNkIDA6MDowOjA6
IFtzZGFdIEF0dGFjaGVkIFNDU0kgZGlzawpbICAgIDQuMTIwMTczXSBzciAxOjA6MDowOiBb
c3IwXSBzY3NpMy1tbWMgZHJpdmU6IDQ4eC8xMnggd3JpdGVyIGR2ZC1yYW0gY2QvcncgeGEv
Zm9ybTIgY2RkYSB0cmF5ClsgICAgNC4xMjEyMzddIGNkcm9tOiBVbmlmb3JtIENELVJPTSBk
cml2ZXIgUmV2aXNpb246IDMuMjAKWyAgICA0LjEyMjAxNV0gc3IgMTowOjA6MDogQXR0YWNo
ZWQgc2NzaSBDRC1ST00gc3IwClsgICAgNC4xMjIxMzZdIHNyIDE6MDowOjA6IEF0dGFjaGVk
IHNjc2kgZ2VuZXJpYyBzZzEgdHlwZSA1ClsgICAgNC4xMjM1MzRdIEZyZWVpbmcgdW51c2Vk
IGtlcm5lbCBpbWFnZSBtZW1vcnk6IDE1NDBLClsgICAgNC4xMzIxNDJdIFdyaXRlIHByb3Rl
Y3RpbmcgdGhlIGtlcm5lbCByZWFkLW9ubHkgZGF0YTogMjA0ODBrClsgICAgNC4xMzMwOThd
IEZyZWVpbmcgdW51c2VkIGtlcm5lbCBpbWFnZSBtZW1vcnk6IDIwMTZLClsgICAgNC4xMzM5
MThdIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBpbWFnZSBtZW1vcnk6IDg1NksKWyAgICA0LjEz
NDU5NV0gUnVuIC9pbml0IGFzIGluaXQgcHJvY2VzcwpbICAgIDQuMzE3NzE4XSByYW5kb206
IGZhc3QgaW5pdCBkb25lClsgICAgNC40MTQ2OTJdIFhGUyAoc2RhMSk6IE1vdW50aW5nIFY1
IEZpbGVzeXN0ZW0KWyAgICA0LjU3OTcwMl0gWEZTIChzZGExKTogRW5kaW5nIGNsZWFuIG1v
dW50ClsgICAgNS4xNTQ1OTldIHJhbmRvbTogY3JuZyBpbml0IGRvbmUKWyAgICA2LjA5OTI1
NF0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxMApbICAgIDYuMTAwMDEwXSBT
ZWdtZW50IFJvdXRpbmcgd2l0aCBJUHY2ClsgICAgNi4xMjg2MjNdIE5FVDogUmVnaXN0ZXJl
ZCBwcm90b2NvbCBmYW1pbHkgMQpbICAgIDYuMzA5ODY4XSBzeXN0ZW1kWzFdOiBzeXN0ZW1k
IDIzOSBydW5uaW5nIGluIHN5c3RlbSBtb2RlLiAoK1BBTSAtQVVESVQgLVNFTElOVVggK0lN
QSAtQVBQQVJNT1IgK1NNQUNLICtTWVNWSU5JVCArVVRNUCAtTElCQ1JZUFRTRVRVUCArR0NS
WVBUICtHTlVUTFMgK0FDTCArWFogK0xaNCAtU0VDQ09NUCArQkxLSUQgK0VMRlVUSUxTICtL
TU9EIC1JRE4yICtJRE4gLVBDUkUyIGRlZmF1bHQtaGllcmFyY2h5PWh5YnJpZCkKWyAgICA2
LjMyNDYyNV0gc3lzdGVtZFsxXTogRGV0ZWN0ZWQgYXJjaGl0ZWN0dXJlIHg4Ni02NC4KWyAg
ICA2LjM2NTI3NV0gc3lzdGVtZFsxXTogU2V0IGhvc3RuYW1lIHRvIDxpbmJldHdlZW5tb3Zl
Lm1vbGdlbi5tcGcuZGU+LgpbICAgIDYuOTEwODQzXSBzeXN0ZW1kWzFdOiBGaWxlIC9saWIv
c3lzdGVtZC9zeXN0ZW0vc3lzdGVtZC1qb3VybmFsZC5zZXJ2aWNlOjM2IGNvbmZpZ3VyZXMg
YW4gSVAgZmlyZXdhbGwgKElQQWRkcmVzc0Rlbnk9YW55KSwgYnV0IHRoZSBsb2NhbCBzeXN0
ZW0gZG9lcyBub3Qgc3VwcG9ydCBCUEYvY2dyb3VwIGJhc2VkIGZpcmV3YWxsaW5nLgpbICAg
IDYuOTEyNzYzXSBzeXN0ZW1kWzFdOiBQcm9jZWVkaW5nIFdJVEhPVVQgZmlyZXdhbGxpbmcg
aW4gZWZmZWN0ISAoVGhpcyB3YXJuaW5nIGlzIG9ubHkgc2hvd24gZm9yIHRoZSBmaXJzdCBs
b2FkZWQgdW5pdCB1c2luZyBJUCBmaXJld2FsbGluZy4pClsgICAgNy4zMjY2OTldIHN5c3Rl
bWRbMV06IFN0YXJ0ZWQgRm9yd2FyZCBQYXNzd29yZCBSZXF1ZXN0cyB0byBXYWxsIERpcmVj
dG9yeSBXYXRjaC4KWyAgICA3LjMyODUyN10gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIHVk
ZXYgQ29udHJvbCBTb2NrZXQuClsgICAgNy4zMjk5MjRdIHN5c3RlbWRbMV06IFJlYWNoZWQg
dGFyZ2V0IFN3YXAuClsgICAgNy4zMzEyOTVdIHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiBp
bml0Y3RsIENvbXBhdGliaWxpdHkgTmFtZWQgUGlwZS4KWyAgICA3LjMzMjc4MF0gc3lzdGVt
ZFsxXTogUmVhY2hlZCB0YXJnZXQgUmVtb3RlIEZpbGUgU3lzdGVtcy4KWyAgICA3Ljk5OTY3
M10gUlBDOiBSZWdpc3RlcmVkIG5hbWVkIFVOSVggc29ja2V0IHRyYW5zcG9ydCBtb2R1bGUu
ClsgICAgOC4wMDA0MzBdIFJQQzogUmVnaXN0ZXJlZCB1ZHAgdHJhbnNwb3J0IG1vZHVsZS4K
WyAgICA4LjAwMTEwMl0gUlBDOiBSZWdpc3RlcmVkIHRjcCB0cmFuc3BvcnQgbW9kdWxlLgpb
ICAgIDguMDAxNzI3XSBSUEM6IFJlZ2lzdGVyZWQgdGNwIE5GU3Y0LjEgYmFja2NoYW5uZWwg
dHJhbnNwb3J0IG1vZHVsZS4KWyAgICA4LjU5MTgzM10gSW5zdGFsbGluZyBrbmZzZCAoY29w
eXJpZ2h0IChDKSAxOTk2IG9raXJAbW9uYWQuc3diLmRlKS4KWyAgICA5LjE3Mjc1N10gc3lz
dGVtZC1qb3VybmFsZFsxNjZdOiBSZWNlaXZlZCByZXF1ZXN0IHRvIGZsdXNoIHJ1bnRpbWUg
am91cm5hbCBmcm9tIFBJRCAxClsgICAgOS43Mjc5NjJdIHdtaV9idXMgd21pX2J1cy1QTlAw
QzE0OjAxOiBXUUJDIGRhdGEgYmxvY2sgcXVlcnkgY29udHJvbCBtZXRob2Qgbm90IGZvdW5k
ClsgICAgOS43NTc2NDVdIEFDUEk6IFZpZGVvIERldmljZSBbR0ZYMF0gKG11bHRpLWhlYWQ6
IHllcyAgcm9tOiBubyAgcG9zdDogbm8pClsgICAgOS43NTg2NTNdIGlucHV0OiBWaWRlbyBC
dXMgYXMgL2RldmljZXMvTE5YU1lTVE06MDAvTE5YU1lCVVM6MDAvUE5QMEEwODowMC9MTlhW
SURFTzowMC9pbnB1dC9pbnB1dDgKWyAgIDEwLjYwMTc4NV0gc25kX2hkYV9pbnRlbCAwMDAw
OjAxOjAwLjE6IEhhbmRsZSB2Z2Ffc3dpdGNoZXJvbyBhdWRpbyBjbGllbnQKWyAgIDEwLjYw
MjU5N10gc25kX2hkYV9pbnRlbCAwMDAwOjAxOjAwLjE6IEZvcmNlIHRvIG5vbi1zbm9vcCBt
b2RlClsgICAxMC42Mzk2MDNdIGlucHV0OiBIREEgQVRJIEhETUkgSERNSS9EUCxwY209MyBh
cyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDEuMC8wMDAwOjAxOjAwLjEvc291bmQv
Y2FyZDEvaW5wdXQ5ClsgICAxMC42NDA4ODNdIGlucHV0OiBIREEgQVRJIEhETUkgSERNSS9E
UCxwY209NyBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDEuMC8wMDAwOjAxOjAw
LjEvc291bmQvY2FyZDEvaW5wdXQxMApbICAgMTAuNjQyMTY1XSBpbnB1dDogSERBIEFUSSBI
RE1JIEhETUkvRFAscGNtPTggYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjAxLjAv
MDAwMDowMTowMC4xL3NvdW5kL2NhcmQxL2lucHV0MTEKWyAgIDEwLjY0MzQwMl0gaW5wdXQ6
IEhEQSBBVEkgSERNSSBIRE1JL0RQLHBjbT05IGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAw
MDowMDowMS4wLzAwMDA6MDE6MDAuMS9zb3VuZC9jYXJkMS9pbnB1dDEyClsgICAxMC42NDQ2
NDRdIGlucHV0OiBIREEgQVRJIEhETUkgSERNSS9EUCxwY209MTAgYXMgL2RldmljZXMvcGNp
MDAwMDowMC8wMDAwOjAwOjAxLjAvMDAwMDowMTowMC4xL3NvdW5kL2NhcmQxL2lucHV0MTMK
WyAgIDEwLjY0NTk2OF0gaW5wdXQ6IEhEQSBBVEkgSERNSSBIRE1JL0RQLHBjbT0xMSBhcyAv
ZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDEuMC8wMDAwOjAxOjAwLjEvc291bmQvY2Fy
ZDEvaW5wdXQxNApbICAgMTEuMjk4MzUwXSBoaWQtbGVkIDAwMDM6MjdCODowMUVELjAwMDE6
IGhpZHJhdzI6IFVTQiBISUQgdjEuMDEgRGV2aWNlIFtUaGluZ00gYmxpbmsoMSkgbWsyXSBv
biB1c2ItMDAwMDowMDoxNC4wLTIvaW5wdXQwClsgICAxMS4yOTk2NDNdIGhpZC1sZWQgMDAw
MzoyN0I4OjAxRUQuMDAwMTogVGhpbmdNIGJsaW5rKDEpIGluaXRpYWxpemVkClsgICAxNS44
NzA3ODJdIFtkcm1dIGFtZGdwdSBrZXJuZWwgbW9kZXNldHRpbmcgZW5hYmxlZC4KWyAgIDE1
Ljg3MTc1NV0gW2RybV0gaW5pdGlhbGl6aW5nIGtlcm5lbCBtb2Rlc2V0dGluZyAoUE9MQVJJ
UzEwIDB4MTAwMjoweDY3QzcgMHgxMDI4OjB4MEIwRCAweDAwKS4KWyAgIDE1Ljg3Mjg5MF0g
W2RybV0gcmVnaXN0ZXIgbW1pbyBiYXNlOiAweEVGMDAwMDAwClsgICAxNS44NzM1MjVdIFtk
cm1dIHJlZ2lzdGVyIG1taW8gc2l6ZTogMjYyMTQ0ClsgICAxNS44NzQxNDhdIFtkcm1dIGFk
ZCBpcCBibG9jayBudW1iZXIgMCA8dmlfY29tbW9uPgpbICAgMTUuODc0Nzg3XSBbZHJtXSBh
ZGQgaXAgYmxvY2sgbnVtYmVyIDEgPGdtY192OF8wPgpbICAgMTUuODc1NDM0XSBbZHJtXSBh
ZGQgaXAgYmxvY2sgbnVtYmVyIDIgPHRvbmdhX2loPgpbICAgMTUuODc2MTA4XSBbZHJtXSBh
ZGQgaXAgYmxvY2sgbnVtYmVyIDMgPGdmeF92OF8wPgpbICAgMTUuODc2NzUxXSBbZHJtXSBh
ZGQgaXAgYmxvY2sgbnVtYmVyIDQgPHNkbWFfdjNfMD4KWyAgIDE1Ljg3NzM5NV0gW2RybV0g
YWRkIGlwIGJsb2NrIG51bWJlciA1IDxwb3dlcnBsYXk+ClsgICAxNS44NzgwMDhdIFtkcm1d
IGFkZCBpcCBibG9jayBudW1iZXIgNiA8ZG0+ClsgICAxNS44Nzg2MDFdIFtkcm1dIGFkZCBp
cCBibG9jayBudW1iZXIgNyA8dXZkX3Y2XzA+ClsgICAxNS44NzkyMzldIFtkcm1dIGFkZCBp
cCBibG9jayBudW1iZXIgOCA8dmNlX3YzXzA+ClsgICAxNS44Nzk4NDhdIFtkcm1dIFVWRCBp
cyBlbmFibGVkIGluIFZNIG1vZGUKWyAgIDE1Ljg4MDQzM10gW2RybV0gVVZEIEVOQyBpcyBl
bmFibGVkIGluIFZNIG1vZGUKWyAgIDE1Ljg4MTAzOF0gW2RybV0gVkNFIGVuYWJsZWQgaW4g
Vk0gbW9kZQpbICAgMTUuODgxNzU5XSBhbWRncHUgMDAwMDowMTowMC4wOiBObyBtb3JlIGlt
YWdlIGluIHRoZSBQQ0kgUk9NClsgICAxNS44ODI0OTVdIEFUT00gQklPUzogMTEzLUM5NTQx
NzAwLTEwMQpbICAgMTUuODgzMDY1XSBbZHJtXSB2bSBzaXplIGlzIDEyOCBHQiwgMiBsZXZl
bHMsIGJsb2NrIHNpemUgaXMgMTAtYml0LCBmcmFnbWVudCBzaXplIGlzIDktYml0ClsgICAx
Ni4wODE4MzldIGFtZGdwdSAwMDAwOjAxOjAwLjA6IFZSQU06IDgxOTJNIDB4MDAwMDAwRjQw
MDAwMDAwMCAtIDB4MDAwMDAwRjVGRkZGRkZGRiAoODE5Mk0gdXNlZCkKWyAgIDE2LjA4Mjky
M10gYW1kZ3B1IDAwMDA6MDE6MDAuMDogR0FSVDogMjU2TSAweDAwMDAwMEZGMDAwMDAwMDAg
LSAweDAwMDAwMEZGMEZGRkZGRkYKWyAgIDE2LjA4MzkxNF0gW2RybV0gRGV0ZWN0ZWQgVlJB
TSBSQU09ODE5Mk0sIEJBUj0yNTZNClsgICAxNi4wODQ1NTldIFtkcm1dIFJBTSB3aWR0aCAy
NTZiaXRzIEdERFI1ClsgICAxNi4wODUyNDBdIFtUVE1dIFpvbmUgIGtlcm5lbDogQXZhaWxh
YmxlIGdyYXBoaWNzIG1lbW9yeTogMTYyNzIzOTYga2lCClsgICAxNi4wODU5OTVdIFtUVE1d
IFpvbmUgICBkbWEzMjogQXZhaWxhYmxlIGdyYXBoaWNzIG1lbW9yeTogMjA5NzE1MiBraUIK
WyAgIDE2LjA4NjgwM10gW1RUTV0gSW5pdGlhbGl6aW5nIHBvb2wgYWxsb2NhdG9yClsgICAx
Ni4wODc0MTBdIFtUVE1dIEluaXRpYWxpemluZyBETUEgcG9vbCBhbGxvY2F0b3IKWyAgIDE2
LjA4ODE0Nl0gW2RybV0gYW1kZ3B1OiA4MTkyTSBvZiBWUkFNIG1lbW9yeSByZWFkeQpbICAg
MTYuMDg4ODA5XSBbZHJtXSBhbWRncHU6IDgxOTJNIG9mIEdUVCBtZW1vcnkgcmVhZHkuClsg
ICAxNi4wODk0NzZdIFtkcm1dIEdBUlQ6IG51bSBjcHUgcGFnZXMgNjU1MzYsIG51bSBncHUg
cGFnZXMgNjU1MzYKWyAgIDE2LjA5MDgxMl0gW2RybV0gUENJRSBHQVJUIG9mIDI1Nk0gZW5h
YmxlZCAodGFibGUgYXQgMHgwMDAwMDBGNDAwOTAwMDAwKS4KWyAgIDE2LjA5MTk5Nl0gW2Ry
bV0gUmVwbGFjaW5nIFZHQSBjb25zb2xlIGRyaXZlcgpbICAgMTYuMDk0NzgxXSBDb25zb2xl
OiBzd2l0Y2hpbmcgdG8gY29sb3VyIGR1bW15IGRldmljZSA4MHgyNQpbICAgMTYuMDk2NTg5
XSBbZHJtXSBTdXBwb3J0cyB2YmxhbmsgdGltZXN0YW1wIGNhY2hpbmcgUmV2IDIgKDIxLjEw
LjIwMTMpLgpbICAgMTYuMDk3MTgwXSBbZHJtXSBEcml2ZXIgc3VwcG9ydHMgcHJlY2lzZSB2
YmxhbmsgdGltZXN0YW1wIHF1ZXJ5LgpbICAgMTYuMDk4Mjk2XSBhbWRncHUgMDAwMDowMTow
MC4wOiB2Z2FhcmI6IGNoYW5nZWQgVkdBIGRlY29kZXM6IG9sZGRlY29kZXM9aW8rbWVtLGRl
Y29kZXM9aW8rbWVtOm93bnM9aW8rbWVtClsgICAxNi4xNjg5MTZdIFtkcm1dIEZpbmlzaGVk
IGxvYWRpbmcgRE1DIGZpcm13YXJlIGk5MTUva2JsX2RtY192ZXIxXzA0LmJpbiAodjEuNCkK
WyAgIDE2LjI0OTY5Nl0gW2RybV0gQ2hhaW5lZCBJQiBzdXBwb3J0IGVuYWJsZWQhClsgICAx
Ni41MzkxNzRdIFtkcm1dIEZvdW5kIFVWRCBmaXJtd2FyZSBWZXJzaW9uOiAxLjEzMCBGYW1p
bHkgSUQ6IDE2ClsgICAxNi42MTEzNzddIFtkcm1dIEZvdW5kIFZDRSBmaXJtd2FyZSBWZXJz
aW9uOiA1My4yNiBCaW5hcnkgSUQ6IDMKWyAgIDE2LjY3OTU0OF0gW2RybV0gRE1fUFBMSUI6
IHZhbHVlcyBmb3IgRW5naW5lIGNsb2NrClsgICAxNi42Nzk5NTVdIFtkcm1dIERNX1BQTElC
OgkgMzAwMDAwClsgICAxNi42ODAzMDNdIFtkcm1dIERNX1BQTElCOgkgNDI2MDAwClsgICAx
Ni42ODA2MjddIFtkcm1dIERNX1BQTElCOgkgNTgxMDAwClsgICAxNi42ODA5MjFdIFtkcm1d
IERNX1BQTElCOgkgNzI2MDAwClsgICAxNi42ODEyNjddIFtkcm1dIERNX1BQTElCOgkgODc1
MDAwClsgICAxNi42ODE1NzddIFtkcm1dIERNX1BQTElCOgkgOTIyMDAwClsgICAxNi42ODE4
NzFdIFtkcm1dIERNX1BQTElCOgkgMTAwNDAwMApbICAgMTYuNjgyMjA3XSBbZHJtXSBETV9Q
UExJQjoJIDEwODYwMDAKWyAgIDE2LjY4MjUwOF0gW2RybV0gRE1fUFBMSUI6IFZhbGlkYXRp
b24gY2xvY2tzOgpbICAgMTYuNjgyODc4XSBbZHJtXSBETV9QUExJQjogICAgZW5naW5lX21h
eF9jbG9jazogMTA4NjAwClsgICAxNi42ODMzNDddIFtkcm1dIERNX1BQTElCOiAgICBtZW1v
cnlfbWF4X2Nsb2NrOiAxMjUwMDAKWyAgIDE2LjY4Mzc5NV0gW2RybV0gRE1fUFBMSUI6ICAg
IGxldmVsICAgICAgICAgICA6IDgKWyAgIDE2LjY4NDI0Nl0gW2RybV0gRE1fUFBMSUI6IHZh
bHVlcyBmb3IgTWVtb3J5IGNsb2NrClsgICAxNi42ODQ2NjddIFtkcm1dIERNX1BQTElCOgkg
MzAwMDAwClsgICAxNi42ODQ5NjFdIFtkcm1dIERNX1BQTElCOgkgMTI1MDAwMApbICAgMTYu
Njg1Mjk2XSBbZHJtXSBETV9QUExJQjogVmFsaWRhdGlvbiBjbG9ja3M6ClsgICAxNi42ODU2
NjZdIFtkcm1dIERNX1BQTElCOiAgICBlbmdpbmVfbWF4X2Nsb2NrOiAxMDg2MDAKWyAgIDE2
LjY4NjEzNV0gW2RybV0gRE1fUFBMSUI6ICAgIG1lbW9yeV9tYXhfY2xvY2s6IDEyNTAwMApb
ICAgMTYuNjg2NTgzXSBbZHJtXSBETV9QUExJQjogICAgbGV2ZWwgICAgICAgICAgIDogOApb
ICAgMTYuNjg3NDIzXSBbZHJtXSBEaXNwbGF5IENvcmUgaW5pdGlhbGl6ZWQgd2l0aCB2My4x
LjY4IQpbICAgMTYuNjk2OTUzXSBbZHJtXSBETV9NU1Q6IERpZmZlcmluZyBNU1Qgc3RhcnQg
b24gYWNvbm5lY3RvcjogMDAwMDAwMDA5M2NhZDJmMSBbaWQ6IDYyXQpbICAgMTYuNjk3NjYw
XSBbZHJtXSBTdXBwb3J0cyB2YmxhbmsgdGltZXN0YW1wIGNhY2hpbmcgUmV2IDIgKDIxLjEw
LjIwMTMpLgpbICAgMTYuNjk4MjU4XSBbZHJtXSBEcml2ZXIgc3VwcG9ydHMgcHJlY2lzZSB2
YmxhbmsgdGltZXN0YW1wIHF1ZXJ5LgpbICAgMTYuNzI3MDYxXSBbZHJtXSBVVkQgYW5kIFVW
RCBFTkMgaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgMTYuODI4MDE0XSBbZHJtXSBW
Q0UgaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgMTYuODI4NDk5XSBbZHJtXSBDYW5u
b3QgZmluZCBhbnkgY3J0YyBvciBzaXplcwpbICAgMTYuODM0NjQxXSBbZHJtXSBJbml0aWFs
aXplZCBhbWRncHUgMy4yNy4wIDIwMTUwMTAxIGZvciAwMDAwOjAxOjAwLjAgb24gbWlub3Ig
MApbICAgMTYuODM1NjczXSBbZHJtXSBJbml0aWFsaXplZCBpOTE1IDEuNi4wIDIwMTgwOTIx
IGZvciAwMDAwOjAwOjAyLjAgb24gbWlub3IgMQpbICAgMTYuODM2NDA0XSBzbmRfaGRhX2lu
dGVsIDAwMDA6MDA6MWYuMzogYm91bmQgMDAwMDowMDowMi4wIChvcHMgaTkxNV9hdWRpb19j
b21wb25lbnRfYmluZF9vcHMgW2k5MTVdKQpbICAgMTYuODUyNzU3XSBbZHJtXSBDYW5ub3Qg
ZmluZCBhbnkgY3J0YyBvciBzaXplcwpbICAgMTYuODY1NjYzXSBbZHJtXSBDYW5ub3QgZmlu
ZCBhbnkgY3J0YyBvciBzaXplcwpbICAgMTYuODc3OTgyXSBbZHJtXSBDYW5ub3QgZmluZCBh
bnkgY3J0YyBvciBzaXplcwpbICAgMTYuOTM4NTk0XSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsg
aGRhdWRpb0MwRDA6IGF1dG9jb25maWcgZm9yIEFMQzM4NjE6IGxpbmVfb3V0cz0xICgweDE0
LzB4MC8weDAvMHgwLzB4MCkgdHlwZTpsaW5lClsgICAxNi45Mzk0ODVdIHNuZF9oZGFfY29k
ZWNfcmVhbHRlayBoZGF1ZGlvQzBEMDogICAgc3BlYWtlcl9vdXRzPTEgKDB4MTUvMHgwLzB4
MC8weDAvMHgwKQpbICAgMTYuOTQwMTc5XSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgaGRhdWRp
b0MwRDA6ICAgIGhwX291dHM9MSAoMHgxYi8weDAvMHgwLzB4MC8weDApClsgICAxNi45NDA4
MDJdIHNuZF9oZGFfY29kZWNfcmVhbHRlayBoZGF1ZGlvQzBEMDogICAgbW9ubzogbW9ub19v
dXQ9MHgwClsgICAxNi45NDEzNzZdIHNuZF9oZGFfY29kZWNfcmVhbHRlayBoZGF1ZGlvQzBE
MDogICAgaW5wdXRzOgpbICAgMTYuOTQxODU1XSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgaGRh
dWRpb0MwRDA6ICAgICAgRnJvbnQgTWljPTB4MTkKWyAgIDE2Ljk0MjQxOV0gc25kX2hkYV9j
b2RlY19yZWFsdGVrIGhkYXVkaW9DMEQwOiAgICAgIFJlYXIgTWljPTB4MTgKWyAgIDE2Ljk1
NTQ3NF0gaW5wdXQ6IEhEQSBJbnRlbCBQQ0ggRnJvbnQgTWljIGFzIC9kZXZpY2VzL3BjaTAw
MDA6MDAvMDAwMDowMDoxZi4zL3NvdW5kL2NhcmQwL2lucHV0MTUKWyAgIDE2Ljk1NjM2MV0g
aW5wdXQ6IEhEQSBJbnRlbCBQQ0ggUmVhciBNaWMgYXMgL2RldmljZXMvcGNpMDAwMDowMC8w
MDAwOjAwOjFmLjMvc291bmQvY2FyZDAvaW5wdXQxNgpbICAgMTYuOTU3MjExXSBpbnB1dDog
SERBIEludGVsIFBDSCBMaW5lIE91dCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6
MWYuMy9zb3VuZC9jYXJkMC9pbnB1dDE3ClsgICAxNi45NTgwMDBdIGlucHV0OiBIREEgSW50
ZWwgUENIIEZyb250IEhlYWRwaG9uZSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6
MWYuMy9zb3VuZC9jYXJkMC9pbnB1dDE4ClsgICAxNi45NTg5MTJdIGlucHV0OiBIREEgSW50
ZWwgUENIIEhETUkvRFAscGNtPTMgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFm
LjMvc291bmQvY2FyZDAvaW5wdXQxOQpbICAgMTYuOTU5ODA2XSBpbnB1dDogSERBIEludGVs
IFBDSCBIRE1JL0RQLHBjbT03IGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZi4z
L3NvdW5kL2NhcmQwL2lucHV0MjAKWyAgIDE2Ljk2MDY3OV0gaW5wdXQ6IEhEQSBJbnRlbCBQ
Q0ggSERNSS9EUCxwY209OCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMy9z
b3VuZC9jYXJkMC9pbnB1dDIxClsgICAxNi45NjE1NDhdIGlucHV0OiBIREEgSW50ZWwgUENI
IEhETUkvRFAscGNtPTkgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFmLjMvc291
bmQvY2FyZDAvaW5wdXQyMgpbICAgMTYuOTYyNDE2XSBpbnB1dDogSERBIEludGVsIFBDSCBI
RE1JL0RQLHBjbT0xMCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMy9zb3Vu
ZC9jYXJkMC9pbnB1dDIzClsgICAyMC4zMDM3ODNdIGUxMDAwZSAwMDAwOjAwOjFmLjYgbmV0
MDA6IHJlbmFtZWQgZnJvbSBldGgwClsgICAyMS44MjU3MzNdIDgwMjFxOiA4MDIuMVEgVkxB
TiBTdXBwb3J0IHYxLjgKWyAgIDIyLjk3MzE0N10gTkZTRDogc3RhcnRpbmcgOTAtc2Vjb25k
IGdyYWNlIHBlcmlvZCAobmV0IGYwMDAwMDk4KQpbICAgMjMuOTY1MjIwXSBYRlMgKHNkYTIp
OiBNb3VudGluZyBWNSBGaWxlc3lzdGVtClsgICAyNC4xNDc0MzJdIGUxMDAwZTogbmV0MDAg
TklDIExpbmsgaXMgVXAgMTAwMCBNYnBzIEZ1bGwgRHVwbGV4LCBGbG93IENvbnRyb2w6IFJ4
L1R4ClsgICAyNC40ODc3MThdIFhGUyAoc2RhMik6IEVuZGluZyBjbGVhbiBtb3VudApbICAg
MjguODY0NDI4XSBGUy1DYWNoZTogTmV0ZnMgJ25mcycgcmVnaXN0ZXJlZCBmb3IgY2FjaGlu
ZwpbICAgMjguOTU4Mzc1XSBORlM6IFJlZ2lzdGVyaW5nIHRoZSBpZF9yZXNvbHZlciBrZXkg
dHlwZQpbICAgMjguOTU4Mzc5XSBLZXkgdHlwZSBpZF9yZXNvbHZlciByZWdpc3RlcmVkClsg
ICAyOC45NTgzNzldIEtleSB0eXBlIGlkX2xlZ2FjeSByZWdpc3RlcmVkClsgICA0Mi42NzU3
OTNdIFtkcm1dIERNX01TVDogc3RvcHBpbmcgVE0gb24gYWNvbm5lY3RvcjogMDAwMDAwMDA5
M2NhZDJmMSBbaWQ6IDYyXQpbICAgNDIuNjc1ODgyXSBbZHJtXSBDYW5ub3QgZmluZCBhbnkg
Y3J0YyBvciBzaXplcwpbICAgNDYuMzgxNTM3XSBbZHJtXSBETV9NU1Q6IHN0YXJ0aW5nIFRN
IG9uIGFjb25uZWN0b3I6IDAwMDAwMDAwOTNjYWQyZjEgW2lkOiA2Ml0KWyAgIDQ2LjQwNTYx
N10gW2RybV0gRE1fTVNUOiBhZGRlZCBjb25uZWN0b3I6IDAwMDAwMDAwYjE5NThiNjkgW2lk
OiA3NV0gW21hc3RlcjogMDAwMDAwMDA5M2NhZDJmMV0KWyAgIDQ2LjQ2MDU1MV0gW2RybV0g
U0FEcyBjb3VudCBpczogLTIsIGRvbid0IG5lZWQgdG8gcmVhZCBpdApbICAgNDYuODAzNzI4
XSBbZHJtXSBETV9NU1Q6IGFkZGVkIGNvbm5lY3RvcjogMDAwMDAwMDBhMjcxZDdlYiBbaWQ6
IDg0XSBbbWFzdGVyOiAwMDAwMDAwMDkzY2FkMmYxXQpbICAgNDYuODY3NzA3XSBbZHJtXSBT
QURzIGNvdW50IGlzOiAtMiwgZG9uJ3QgbmVlZCB0byByZWFkIGl0ClsgICA0Ni44Njk5Mjhd
IFtkcm1dIGZiIG1hcHBhYmxlIGF0IDB4RDBFMjgwMDAKWyAgIDQ2Ljg2OTkyOV0gW2RybV0g
dnJhbSBhcHBlciBhdCAweEQwMDAwMDAwClsgICA0Ni44Njk5MjldIFtkcm1dIHNpemUgMzMx
Nzc2MDAKWyAgIDQ2Ljg2OTkzMF0gW2RybV0gZmIgZGVwdGggaXMgMjQKWyAgIDQ2Ljg2OTkz
MF0gW2RybV0gICAgcGl0Y2ggaXMgMTUzNjAKWyAgIDQ2Ljg3MDExNV0gZmJjb246IGFtZGdw
dWRybWZiIChmYjApIGlzIHByaW1hcnkgZGV2aWNlClsgICA0Ni44NzAyMDJdIENvbnNvbGU6
IHN3aXRjaGluZyB0byBjb2xvdXIgZnJhbWUgYnVmZmVyIGRldmljZSA0ODB4MTM1ClsgICA0
Ni44NzAyMDVdIGFtZGdwdSAwMDAwOjAxOjAwLjA6IGZiMDogYW1kZ3B1ZHJtZmIgZnJhbWUg
YnVmZmVyIGRldmljZQpbICAgNTYuOTI1ODY2XSBmdXNlIGluaXQgKEFQSSB2ZXJzaW9uIDcu
MjgpCg==
--------------B96CA39EC077B3A65E8E965D
Content-Type: text/x-log;
 name="Xorg-amdgpu-4.20.13.0.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="Xorg-amdgpu-4.20.13.0.log"

[    23.564]=20
X.Org X Server 1.20.4
X Protocol Version 11, Revision 0
[    23.564] Build Operating System: Linux 4.19.19.mx64.244 x86_64=20
[    23.564] Current Operating System: Linux inbetweenmove.molgen.mpg.de =
4.20.13.mx64.248 #1 SMP Wed Feb 27 14:10:55 CET 2019 x86_64
[    23.564] Kernel command line: BOOT_IMAGE=3D/boot/bzImage-4.20.13.mx64=
=2E248 crashkernel=3D256M root=3DLABEL=3Droot ro console=3DttyS1,115200n8=
 console=3Dtty0 init=3D/bin/systemd audit=3D0
[    23.564] Build Date: 27 February 2019  12:32:24PM
[    23.564] =20
[    23.564] Current version of pixman: 0.38.0
[    23.564] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[    23.564] Markers: (--) probed, (**) from config file, (=3D=3D) defaul=
t setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[    23.564] (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Wed Mar  6 1=
7:20:57 2019
[    23.661] (=3D=3D) Using config directory: "/etc/X11/xorg.conf.d"
[    23.661] (=3D=3D) Using system config directory "/usr/share/X11/xorg.=
conf.d"
[    23.818] (=3D=3D) No Layout section.  Using the first Screen section.=

[    23.818] (=3D=3D) No screen section available. Using defaults.
[    23.818] (**) |-->Screen "Default Screen Section" (0)
[    23.818] (**) |   |-->Monitor "<default monitor>"
[    23.818] (=3D=3D) No monitor specified for screen "Default Screen Sec=
tion".
	Using a default monitor configuration.
[    23.818] (**) Option "DRI2" "True"
[    23.818] (**) Option "IndirectGLX" "True"
[    23.818] (=3D=3D) Automatically adding devices
[    23.818] (=3D=3D) Automatically enabling devices
[    23.818] (=3D=3D) Automatically adding GPU devices
[    23.818] (=3D=3D) Max clients allowed: 256, resource mask: 0x1fffff
[    24.234] (=3D=3D) FontPath set to:
	/usr/share/fonts/X11/misc/,
	/usr/share/fonts/X11/TTF/,
	/usr/share/fonts/X11/OTF/,
	/usr/share/fonts/X11/Type1/,
	/usr/share/fonts/X11/100dpi/,
	/usr/share/fonts/X11/75dpi/
[    24.234] (=3D=3D) ModulePath set to "/usr/lib/xorg/modules"
[    24.234] (II) The server relies on udev to provide the list of input =
devices.
	If no devices become available, reconfigure udev or disable AutoAddDevic=
es.
[    24.234] (II) Loader magic: 0x813c40
[    24.234] (II) Module ABI versions:
[    24.234] 	X.Org ANSI C Emulation: 0.4
[    24.234] 	X.Org Video Driver: 24.0
[    24.234] 	X.Org XInput driver : 24.1
[    24.234] 	X.Org Server Extension : 10.0
[    24.234] (II) xfree86: Adding drm device (/dev/dri/card0)
[    24.234] (II) xfree86: Adding drm device (/dev/dri/card1)
[    24.236] (--) PCI: (0@0:2:0) 8086:5912:1028:06b7 rev 4, Mem @ 0xee000=
000/16777216, 0xc0000000/268435456, I/O @ 0x0000f000/64
[    24.236] (--) PCI:*(1@0:0:0) 1002:67c7:1028:0b0d rev 0, Mem @ 0xd0000=
000/268435456, 0xe0000000/2097152, 0xef000000/262144, I/O @ 0x0000e000/25=
6, BIOS @ 0x????????/131072
[    24.236] (WW) Open ACPI failed (/var/run/acpid.socket) (No such file =
or directory)
[    24.236] (II) LoadModule: "glx"
[    24.464] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[    25.284] (II) Module glx: vendor=3D"X.Org Foundation"
[    25.284] 	compiled for 1.20.4, module version =3D 1.0.0
[    25.284] 	ABI class: X.Org Server Extension, version 10.0
[    25.284] (II) Applying OutputClass "AMDgpu" to /dev/dri/card0
[    25.284] 	loading driver: amdgpu
[    25.284] (=3D=3D) Matched amdgpu as autoconfigured driver 0
[    25.284] (=3D=3D) Matched ati as autoconfigured driver 1
[    25.284] (=3D=3D) Matched intel as autoconfigured driver 2
[    25.284] (=3D=3D) Matched modesetting as autoconfigured driver 3
[    25.284] (=3D=3D) Matched fbdev as autoconfigured driver 4
[    25.284] (=3D=3D) Matched vesa as autoconfigured driver 5
[    25.284] (=3D=3D) Assigned the driver to the xf86ConfigLayout
[    25.284] (II) LoadModule: "amdgpu"
[    25.284] (II) Loading /usr/lib/xorg/modules/drivers/amdgpu_drv.so
[    25.450] (II) Module amdgpu: vendor=3D"X.Org Foundation"
[    25.450] 	compiled for 1.20.4, module version =3D 19.0.0
[    25.450] 	Module class: X.Org Video Driver
[    25.450] 	ABI class: X.Org Video Driver, version 24.0
[    25.450] (II) LoadModule: "ati"
[    25.512] (WW) Warning, couldn't open module ati
[    25.512] (EE) Failed to load module "ati" (module does not exist, 0)
[    25.512] (II) LoadModule: "intel"
[    25.512] (WW) Warning, couldn't open module intel
[    25.512] (EE) Failed to load module "intel" (module does not exist, 0=
)
[    25.512] (II) LoadModule: "modesetting"
[    25.512] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.s=
o
[    25.552] (II) Module modesetting: vendor=3D"X.Org Foundation"
[    25.552] 	compiled for 1.20.4, module version =3D 1.20.4
[    25.552] 	Module class: X.Org Video Driver
[    25.552] 	ABI class: X.Org Video Driver, version 24.0
[    25.552] (II) LoadModule: "fbdev"
[    25.552] (WW) Warning, couldn't open module fbdev
[    25.552] (EE) Failed to load module "fbdev" (module does not exist, 0=
)
[    25.552] (II) LoadModule: "vesa"
[    25.552] (WW) Warning, couldn't open module vesa
[    25.552] (EE) Failed to load module "vesa" (module does not exist, 0)=

[    25.552] (II) AMDGPU: Driver for AMD Radeon:
	All GPUs supported by the amdgpu kernel driver
[    25.552] (II) modesetting: Driver for Modesetting Kernel Drivers: kms=

[    25.552] (--) using VT number 2

[    25.552] (II) AMDGPU(0): [KMS] Kernel modesetting enabled.
[    25.562] (WW) Falling back to old probe method for modesetting
[    25.562] (II) modeset(G0): using drv /dev/dri/card1
[    25.562] (II) AMDGPU(0): Creating default Display subsection in Scree=
n section
	"Default Screen Section" for depth/fbbpp 24/32
[    25.562] (=3D=3D) AMDGPU(0): Depth 24, (--) framebuffer bpp 32
[    25.562] (II) AMDGPU(0): Pixel depth =3D 24 bits stored in 4 bytes (3=
2 bpp pixmaps)
[    25.562] (=3D=3D) AMDGPU(0): Default visual is TrueColor
[    25.562] (=3D=3D) AMDGPU(0): RGB weight 888
[    25.562] (II) AMDGPU(0): Using 8 bits per RGB (8 bit DAC)
[    25.562] (--) AMDGPU(0): Chipset: "AMD Radeon (TM) Pro WX 5100 Graphi=
cs" (ChipID =3D 0x67c7)
[    25.562] (II) Loading sub module "fb"
[    25.562] (II) LoadModule: "fb"
[    25.562] (II) Loading /usr/lib/xorg/modules/libfb.so
[    25.579] (II) Module fb: vendor=3D"X.Org Foundation"
[    25.579] 	compiled for 1.20.4, module version =3D 1.0.0
[    25.579] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    25.579] (II) Loading sub module "dri2"
[    25.579] (II) LoadModule: "dri2"
[    25.579] (II) Module "dri2" already built-in
[    26.969] (II) Loading sub module "glamoregl"
[    26.969] (II) LoadModule: "glamoregl"
[    26.969] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[    27.010] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[    27.010] 	compiled for 1.20.4, module version =3D 1.0.1
[    27.010] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    27.106] (II) AMDGPU(0): glamor X acceleration enabled on AMD Radeon =
(TM) Pro WX 5100 Graphics (POLARIS10, DRM 3.27.0, 4.20.13.mx64.248, LLVM =
7.0.1)
[    27.106] (II) AMDGPU(0): glamor detected, initialising EGL layer.
[    27.106] (=3D=3D) AMDGPU(0): TearFree property default: auto
[    27.106] (=3D=3D) AMDGPU(0): VariableRefresh: disabled
[    27.106] (II) AMDGPU(0): KMS Pageflipping: enabled
[    27.106] (II) AMDGPU(0): Output DisplayPort-3 has no monitor section
[    27.106] (II) AMDGPU(0): Output DisplayPort-4 has no monitor section
[    27.107] (II) AMDGPU(0): Output DisplayPort-5 has no monitor section
[    27.107] (II) AMDGPU(0): Output DisplayPort-6 has no monitor section
[    27.107] (II) AMDGPU(0): EDID for output DisplayPort-3
[    27.107] (II) AMDGPU(0): EDID for output DisplayPort-4
[    27.107] (II) AMDGPU(0): EDID for output DisplayPort-5
[    27.107] (II) AMDGPU(0): EDID for output DisplayPort-6
[    27.107] (II) AMDGPU(0): Output DisplayPort-3 disconnected
[    27.107] (II) AMDGPU(0): Output DisplayPort-4 disconnected
[    27.107] (II) AMDGPU(0): Output DisplayPort-5 disconnected
[    27.107] (II) AMDGPU(0): Output DisplayPort-6 disconnected
[    27.107] (WW) AMDGPU(0): No outputs definitely connected, trying agai=
n...
[    27.107] (II) AMDGPU(0): Output DisplayPort-3 disconnected
[    27.107] (II) AMDGPU(0): Output DisplayPort-4 disconnected
[    27.107] (II) AMDGPU(0): Output DisplayPort-5 disconnected
[    27.107] (II) AMDGPU(0): Output DisplayPort-6 disconnected
[    27.107] (WW) AMDGPU(0): Unable to find connected outputs - setting 1=
024x768 initial framebuffer
[    27.107] (II) AMDGPU(0): mem size init: gart size :1ffd39000 vram siz=
e: s:1ffad8000 visible:fad8000
[    27.107] (=3D=3D) AMDGPU(0): DPI set to (96, 96)
[    27.107] (=3D=3D) AMDGPU(0): Using gamma correction (1.0, 1.0, 1.0)
[    27.107] (II) Loading sub module "ramdac"
[    27.107] (II) LoadModule: "ramdac"
[    27.107] (II) Module "ramdac" already built-in
[    27.107] (=3D=3D) modeset(G0): Depth 24, (=3D=3D) framebuffer bpp 32
[    27.107] (=3D=3D) modeset(G0): RGB weight 888
[    27.107] (=3D=3D) modeset(G0): Default visual is TrueColor
[    27.107] (II) Loading sub module "glamoregl"
[    27.107] (II) LoadModule: "glamoregl"
[    27.107] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[    27.107] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[    27.107] 	compiled for 1.20.4, module version =3D 1.0.1
[    27.107] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    27.262] (II) modeset(G0): glamor X acceleration enabled on Mesa DRI =
Intel(R) HD Graphics 630 (Kaby Lake GT2)=20
[    27.262] (II) modeset(G0): glamor initialized
[    27.267] (II) modeset(G0): Output HDMI-1-1 has no monitor section
[    27.267] (II) modeset(G0): Output DP-1-1 has no monitor section
[    27.272] (II) modeset(G0): Output HDMI-1-2 has no monitor section
[    27.272] (II) modeset(G0): Output DP-1-2 has no monitor section
[    27.277] (II) modeset(G0): Output HDMI-1-3 has no monitor section
[    27.278] (II) modeset(G0): Output DP-1-3 has no monitor section
[    27.283] (II) modeset(G0): EDID for output HDMI-1-1
[    27.283] (II) modeset(G0): EDID for output DP-1-1
[    27.288] (II) modeset(G0): EDID for output HDMI-1-2
[    27.288] (II) modeset(G0): EDID for output DP-1-2
[    27.293] (II) modeset(G0): EDID for output HDMI-1-3
[    27.293] (II) modeset(G0): EDID for output DP-1-3
[    27.293] (=3D=3D) modeset(G0): Using gamma correction (1.0, 1.0, 1.0)=

[    27.293] (=3D=3D) modeset(G0): DPI set to (96, 96)
[    27.293] (II) Loading sub module "fb"
[    27.293] (II) LoadModule: "fb"
[    27.293] (II) Loading /usr/lib/xorg/modules/libfb.so
[    27.293] (II) Module fb: vendor=3D"X.Org Foundation"
[    27.293] 	compiled for 1.20.4, module version =3D 1.0.0
[    27.293] 	ABI class: X.Org ANSI C Emulation, version 0.4
[    27.560] (=3D=3D) modeset(G0): Backing store enabled
[    27.560] (=3D=3D) modeset(G0): Silken mouse enabled
[    27.561] (II) modeset(G0): Initializing kms color map for depth 24, 8=
 bpc.
[    27.561] (=3D=3D) modeset(G0): DPMS enabled
[    27.561] (II) modeset(G0): [DRI2] Setup complete
[    27.561] (II) modeset(G0): [DRI2]   DRI driver: i965
[    27.561] (II) modeset(G0): [DRI2]   VDPAU driver: i965
[    27.561] (II) AMDGPU(0): [DRI2] Setup complete
[    27.561] (II) AMDGPU(0): [DRI2]   DRI driver: radeonsi
[    27.561] (II) AMDGPU(0): [DRI2]   VDPAU driver: radeonsi
[    27.561] (II) AMDGPU(0): Front buffer pitch: 4096 bytes
[    27.561] (II) AMDGPU(0): SYNC extension fences enabled
[    27.561] (II) AMDGPU(0): Present extension enabled
[    27.561] (=3D=3D) AMDGPU(0): DRI3 enabled
[    27.561] (=3D=3D) AMDGPU(0): Backing store enabled
[    27.561] (II) AMDGPU(0): Direct rendering enabled
[    27.660] (II) AMDGPU(0): Use GLAMOR acceleration.
[    27.660] (II) AMDGPU(0): Acceleration enabled
[    27.660] (=3D=3D) AMDGPU(0): DPMS enabled
[    27.660] (=3D=3D) AMDGPU(0): Silken mouse enabled
[    27.660] (II) AMDGPU(0): Set up textured video (glamor)
[    27.661] (II) Initializing extension Generic Event Extension
[    27.661] (II) Initializing extension SHAPE
[    27.661] (II) Initializing extension MIT-SHM
[    27.661] (II) Initializing extension XInputExtension
[    27.702] (II) Initializing extension XTEST
[    27.702] (II) Initializing extension BIG-REQUESTS
[    27.702] (II) Initializing extension SYNC
[    27.702] (II) Initializing extension XKEYBOARD
[    27.702] (II) Initializing extension XC-MISC
[    27.702] (II) Initializing extension XFIXES
[    27.702] (II) Initializing extension RENDER
[    27.702] (II) Initializing extension RANDR
[    27.702] (II) Initializing extension COMPOSITE
[    27.702] (II) Initializing extension DAMAGE
[    27.702] (II) Initializing extension MIT-SCREEN-SAVER
[    27.702] (II) Initializing extension DOUBLE-BUFFER
[    27.702] (II) Initializing extension RECORD
[    27.702] (II) Initializing extension DPMS
[    27.702] (II) Initializing extension Present
[    27.702] (II) Initializing extension DRI3
[    27.702] (II) Initializing extension X-Resource
[    27.702] (II) Initializing extension XVideo
[    27.702] (II) Initializing extension XVideo-MotionCompensation
[    27.702] (II) Initializing extension GLX
[    27.708] (II) AIGLX: Loaded and initialized radeonsi
[    27.708] (II) GLX: Initialized DRI2 GL provider for screen 0
[    27.708] (II) Initializing extension XFree86-VidModeExtension
[    27.708] (II) Initializing extension XFree86-DGA
[    27.708] (II) Initializing extension XFree86-DRI
[    27.708] (II) Initializing extension DRI2
[    27.804] (II) modeset(G0): Damage tracking initialized
[    29.040] (II) config/udev: Adding input device Power Button (/dev/inp=
ut/event2)
[    29.040] (**) Power Button: Applying InputClass "evdev keyboard catch=
all"
[    29.040] (II) LoadModule: "evdev"
[    29.040] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[    29.183] (II) Module evdev: vendor=3D"X.Org Foundation"
[    29.183] 	compiled for 1.19.6, module version =3D 2.10.5
[    29.183] 	Module class: X.Org XInput Driver
[    29.183] 	ABI class: X.Org XInput driver, version 24.1
[    29.183] (II) Using input driver 'evdev' for 'Power Button'
[    29.183] (**) Power Button: always reports core events
[    29.183] (**) evdev: Power Button: Device: "/dev/input/event2"
[    29.183] (--) evdev: Power Button: Vendor 0 Product 0x1
[    29.183] (--) evdev: Power Button: Found keys
[    29.183] (II) evdev: Power Button: Configuring as keyboard
[    29.183] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
PWRBN:00/input/input2/event2"
[    29.183] (II) XINPUT: Adding extended input device "Power Button" (ty=
pe: KEYBOARD, id 6)
[    29.183] (**) Option "xkb_rules" "evdev"
[    29.183] (II) config/udev: Adding input device Video Bus (/dev/input/=
event5)
[    29.183] (**) Video Bus: Applying InputClass "evdev keyboard catchall=
"
[    29.183] (II) Using input driver 'evdev' for 'Video Bus'
[    29.183] (**) Video Bus: always reports core events
[    29.183] (**) evdev: Video Bus: Device: "/dev/input/event5"
[    29.183] (--) evdev: Video Bus: Vendor 0 Product 0x6
[    29.183] (--) evdev: Video Bus: Found keys
[    29.183] (II) evdev: Video Bus: Configuring as keyboard
[    29.183] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input8/event5"
[    29.183] (II) XINPUT: Adding extended input device "Video Bus" (type:=
 KEYBOARD, id 7)
[    29.183] (**) Option "xkb_rules" "evdev"
[    29.183] (II) config/udev: Adding input device Power Button (/dev/inp=
ut/event1)
[    29.183] (**) Power Button: Applying InputClass "evdev keyboard catch=
all"
[    29.183] (II) Using input driver 'evdev' for 'Power Button'
[    29.183] (**) Power Button: always reports core events
[    29.183] (**) evdev: Power Button: Device: "/dev/input/event1"
[    29.183] (--) evdev: Power Button: Vendor 0 Product 0x1
[    29.183] (--) evdev: Power Button: Found keys
[    29.183] (II) evdev: Power Button: Configuring as keyboard
[    29.183] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0C0C:00/input/input1/event1"
[    29.183] (II) XINPUT: Adding extended input device "Power Button" (ty=
pe: KEYBOARD, id 8)
[    29.183] (**) Option "xkb_rules" "evdev"
[    29.184] (II) config/udev: Adding input device Sleep Button (/dev/inp=
ut/event0)
[    29.184] (**) Sleep Button: Applying InputClass "evdev keyboard catch=
all"
[    29.184] (II) Using input driver 'evdev' for 'Sleep Button'
[    29.184] (**) Sleep Button: always reports core events
[    29.184] (**) evdev: Sleep Button: Device: "/dev/input/event0"
[    29.184] (--) evdev: Sleep Button: Vendor 0 Product 0x3
[    29.184] (--) evdev: Sleep Button: Found keys
[    29.184] (II) evdev: Sleep Button: Configuring as keyboard
[    29.184] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0C0E:00/input/input0/event0"
[    29.184] (II) XINPUT: Adding extended input device "Sleep Button" (ty=
pe: KEYBOARD, id 9)
[    29.184] (**) Option "xkb_rules" "evdev"
[    29.184] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D7 (/dev/input/event7)
[    29.184] (II) No input driver specified, ignoring this device.
[    29.184] (II) This device may have been added with another device fil=
e.
[    29.184] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D8 (/dev/input/event8)
[    29.184] (II) No input driver specified, ignoring this device.
[    29.184] (II) This device may have been added with another device fil=
e.
[    29.184] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D9 (/dev/input/event9)
[    29.184] (II) No input driver specified, ignoring this device.
[    29.184] (II) This device may have been added with another device fil=
e.
[    29.185] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D10 (/dev/input/event10)
[    29.185] (II) No input driver specified, ignoring this device.
[    29.185] (II) This device may have been added with another device fil=
e.
[    29.185] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D11 (/dev/input/event11)
[    29.185] (II) No input driver specified, ignoring this device.
[    29.185] (II) This device may have been added with another device fil=
e.
[    29.185] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D3 (/dev/input/event6)
[    29.185] (II) No input driver specified, ignoring this device.
[    29.185] (II) This device may have been added with another device fil=
e.
[    29.185] (II) config/udev: Adding input device Dell Dell USB Entry Ke=
yboard (/dev/input/event3)
[    29.185] (**) Dell Dell USB Entry Keyboard: Applying InputClass "evde=
v keyboard catchall"
[    29.185] (II) Using input driver 'evdev' for 'Dell Dell USB Entry Key=
board'
[    29.185] (**) Dell Dell USB Entry Keyboard: always reports core event=
s
[    29.185] (**) evdev: Dell Dell USB Entry Keyboard: Device: "/dev/inpu=
t/event3"
[    29.185] (--) evdev: Dell Dell USB Entry Keyboard: Vendor 0x413c Prod=
uct 0x2107
[    29.185] (--) evdev: Dell Dell USB Entry Keyboard: Found keys
[    29.185] (II) evdev: Dell Dell USB Entry Keyboard: Configuring as key=
board
[    29.185] (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000=
:00:14.0/usb1/1-4/1-4:1.0/0003:413C:2107.0002/input/input6/event3"
[    29.185] (II) XINPUT: Adding extended input device "Dell Dell USB Ent=
ry Keyboard" (type: KEYBOARD, id 10)
[    29.185] (**) Option "xkb_rules" "evdev"
[    29.186] (II) config/udev: Adding input device Logitech USB Optical M=
ouse (/dev/input/event4)
[    29.186] (**) Logitech USB Optical Mouse: Applying InputClass "evdev =
pointer catchall"
[    29.186] (II) Using input driver 'evdev' for 'Logitech USB Optical Mo=
use'
[    29.186] (**) Logitech USB Optical Mouse: always reports core events
[    29.186] (**) evdev: Logitech USB Optical Mouse: Device: "/dev/input/=
event4"
[    29.186] (--) evdev: Logitech USB Optical Mouse: Vendor 0x46d Product=
 0xc05a
[    29.186] (--) evdev: Logitech USB Optical Mouse: Found 12 mouse butto=
ns
[    29.186] (--) evdev: Logitech USB Optical Mouse: Found scroll wheel(s=
)
[    29.186] (--) evdev: Logitech USB Optical Mouse: Found relative axes
[    29.186] (--) evdev: Logitech USB Optical Mouse: Found x and y relati=
ve axes
[    29.186] (II) evdev: Logitech USB Optical Mouse: Configuring as mouse=

[    29.186] (II) evdev: Logitech USB Optical Mouse: Adding scrollwheel s=
upport
[    29.186] (**) evdev: Logitech USB Optical Mouse: YAxisMapping: button=
s 4 and 5
[    29.186] (**) evdev: Logitech USB Optical Mouse: EmulateWheelButton: =
4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    29.186] (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000=
:00:14.0/usb1/1-5/1-5:1.0/0003:046D:C05A.0003/input/input7/event4"
[    29.186] (II) XINPUT: Adding extended input device "Logitech USB Opti=
cal Mouse" (type: MOUSE, id 11)
[    29.186] (II) evdev: Logitech USB Optical Mouse: initialized for rela=
tive axes.
[    29.186] (**) Logitech USB Optical Mouse: (accel) keeping acceleratio=
n scheme 1
[    29.186] (**) Logitech USB Optical Mouse: (accel) acceleration profil=
e 0
[    29.186] (**) Logitech USB Optical Mouse: (accel) acceleration factor=
: 2.000
[    29.186] (**) Logitech USB Optical Mouse: (accel) acceleration thresh=
old: 4
[    29.186] (II) config/udev: Adding input device HDA Intel PCH Front Mi=
c (/dev/input/event12)
[    29.186] (II) No input driver specified, ignoring this device.
[    29.186] (II) This device may have been added with another device fil=
e.
[    29.186] (II) config/udev: Adding input device HDA Intel PCH Rear Mic=
 (/dev/input/event13)
[    29.186] (II) No input driver specified, ignoring this device.
[    29.186] (II) This device may have been added with another device fil=
e.
[    29.186] (II) config/udev: Adding input device HDA Intel PCH Line Out=
 (/dev/input/event14)
[    29.186] (II) No input driver specified, ignoring this device.
[    29.186] (II) This device may have been added with another device fil=
e.
[    29.187] (II) config/udev: Adding input device HDA Intel PCH Front He=
adphone (/dev/input/event15)
[    29.187] (II) No input driver specified, ignoring this device.
[    29.187] (II) This device may have been added with another device fil=
e.
[    29.187] (II) config/udev: Adding input device HDA Intel PCH HDMI/DP,=
pcm=3D3 (/dev/input/event16)
[    29.187] (II) No input driver specified, ignoring this device.
[    29.187] (II) This device may have been added with another device fil=
e.
[    29.187] (II) config/udev: Adding input device HDA Intel PCH HDMI/DP,=
pcm=3D7 (/dev/input/event17)
[    29.187] (II) No input driver specified, ignoring this device.
[    29.187] (II) This device may have been added with another device fil=
e.
[    29.187] (II) config/udev: Adding input device HDA Intel PCH HDMI/DP,=
pcm=3D8 (/dev/input/event18)
[    29.187] (II) No input driver specified, ignoring this device.
[    29.187] (II) This device may have been added with another device fil=
e.
[    29.187] (II) config/udev: Adding input device HDA Intel PCH HDMI/DP,=
pcm=3D9 (/dev/input/event19)
[    29.187] (II) No input driver specified, ignoring this device.
[    29.187] (II) This device may have been added with another device fil=
e.
[    29.187] (II) config/udev: Adding input device HDA Intel PCH HDMI/DP,=
pcm=3D10 (/dev/input/event20)
[    29.187] (II) No input driver specified, ignoring this device.
[    29.187] (II) This device may have been added with another device fil=
e.
[    46.339] (II) AMDGPU(0): Output DisplayPort-7 has no monitor section
[    46.400] (II) AMDGPU(0): Allocate new frame buffer 1920x2160
[    46.401] (II) AMDGPU(0):  =3D> pitch 8192 bytes
[    46.748] (II) AMDGPU(0): Output DisplayPort-8 has no monitor section
[    46.779] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[    46.779] (II) AMDGPU(0): Using EDID range info for horizontal sync
[    46.779] (II) AMDGPU(0): Using EDID range info for vertical refresh
[    46.779] (II) AMDGPU(0): Printing DDC gathered Modelines:
[    46.779] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[    46.782] (II) AMDGPU(0): Allocate new frame buffer 3840x2160
[    46.782] (II) AMDGPU(0):  =3D> pitch 15360 bytes
[    47.099] (II) AIGLX: Suspending AIGLX clients for VT switch
[    47.871] (II) AIGLX: Resuming AIGLX clients after VT switch
[    47.931] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[    47.931] (II) AMDGPU(0): Using hsync ranges from config file
[    47.931] (II) AMDGPU(0): Using vrefresh ranges from config file
[    47.931] (II) AMDGPU(0): Printing DDC gathered Modelines:
[    47.931] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[    48.189] (II) AIGLX: Suspending AIGLX clients for VT switch
[    50.471] (II) AIGLX: Resuming AIGLX clients after VT switch
[    50.531] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[    50.531] (II) AMDGPU(0): Using hsync ranges from config file
[    50.531] (II) AMDGPU(0): Using vrefresh ranges from config file
[    50.531] (II) AMDGPU(0): Printing DDC gathered Modelines:
[    50.531] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[    57.359] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[    57.359] (II) AMDGPU(0): Using hsync ranges from config file
[    57.359] (II) AMDGPU(0): Using vrefresh ranges from config file
[    57.359] (II) AMDGPU(0): Printing DDC gathered Modelines:
[    57.359] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[    57.553] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[    57.553] (II) AMDGPU(0): Using hsync ranges from config file
[    57.553] (II) AMDGPU(0): Using vrefresh ranges from config file
[    57.553] (II) AMDGPU(0): Printing DDC gathered Modelines:
[    57.553] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[    57.553] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[    57.553] (II) AMDGPU(0): Using hsync ranges from config file
[    57.553] (II) AMDGPU(0): Using vrefresh ranges from config file
[    57.553] (II) AMDGPU(0): Printing DDC gathered Modelines:
[    57.553] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[    85.116] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[    85.116] (II) AMDGPU(0): Using hsync ranges from config file
[    85.116] (II) AMDGPU(0): Using vrefresh ranges from config file
[    85.116] (II) AMDGPU(0): Printing DDC gathered Modelines:
[    85.116] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[    85.117] (II) AMDGPU(0): EDID vendor "DEL", prod id 16531
[    85.117] (II) AMDGPU(0): Using hsync ranges from config file
[    85.117] (II) AMDGPU(0): Using vrefresh ranges from config file
[    85.117] (II) AMDGPU(0): Printing DDC gathered Modelines:
[    85.117] (II) AMDGPU(0): Modeline "1920x2160"x0.0  277.25  1920 1968 =
2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)

--------------B96CA39EC077B3A65E8E965D
Content-Type: text/plain; charset=UTF-8;
 name="=?UTF-8?Q?20190306=e2=80=93linux-4.19.19=e2=80=93messages.txt?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0*=utf-8''%32%30%31%39%30%33%30%36%E2%80%93%6C%69%6E%75%78%2D%34;
 filename*1*=%2E%31%39%2E%31%39%E2%80%93%6D%65%73%73%61%67%65%73%2E%74%78;
 filename*2*=%74

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA0LjE5LjE5Lm14NjQuMjQ0IChyb290QHRo
ZWludGVybmV0Lm1vbGdlbi5tcGcuZGUpIChnY2MgdmVyc2lvbiA3LjMuMCAoR0NDKSkgIzEg
U01QIFR1ZSBGZWIgNSAxMzowMToxMyBDRVQgMjAxOQpbICAgIDAuMDAwMDAwXSBDb21tYW5k
IGxpbmU6IEJPT1RfSU1BR0U9L2Jvb3QvYnpJbWFnZS00LjE5LjE5Lm14NjQuMjQ0IGNyYXNo
a2VybmVsPTI1Nk0gcm9vdD1MQUJFTD1yb290IHJvIGNvbnNvbGU9dHR5UzEsMTE1MjAwbjgg
Y29uc29sZT10dHkwIGluaXQ9L2Jpbi9zeXN0ZW1kIGF1ZGl0PTAKWyAgICAwLjAwMDAwMF0g
eDg2L2ZwdTogU3VwcG9ydGluZyBYU0FWRSBmZWF0dXJlIDB4MDAxOiAneDg3IGZsb2F0aW5n
IHBvaW50IHJlZ2lzdGVycycKWyAgICAwLjAwMDAwMF0geDg2L2ZwdTogU3VwcG9ydGluZyBY
U0FWRSBmZWF0dXJlIDB4MDAyOiAnU1NFIHJlZ2lzdGVycycKWyAgICAwLjAwMDAwMF0geDg2
L2ZwdTogU3VwcG9ydGluZyBYU0FWRSBmZWF0dXJlIDB4MDA0OiAnQVZYIHJlZ2lzdGVycycK
WyAgICAwLjAwMDAwMF0geDg2L2ZwdTogU3VwcG9ydGluZyBYU0FWRSBmZWF0dXJlIDB4MDA4
OiAnTVBYIGJvdW5kcyByZWdpc3RlcnMnClsgICAgMC4wMDAwMDBdIHg4Ni9mcHU6IFN1cHBv
cnRpbmcgWFNBVkUgZmVhdHVyZSAweDAxMDogJ01QWCBDU1InClsgICAgMC4wMDAwMDBdIHg4
Ni9mcHU6IHhzdGF0ZV9vZmZzZXRbMl06ICA1NzYsIHhzdGF0ZV9zaXplc1syXTogIDI1Ngpb
ICAgIDAuMDAwMDAwXSB4ODYvZnB1OiB4c3RhdGVfb2Zmc2V0WzNdOiAgODMyLCB4c3RhdGVf
c2l6ZXNbM106ICAgNjQKWyAgICAwLjAwMDAwMF0geDg2L2ZwdTogeHN0YXRlX29mZnNldFs0
XTogIDg5NiwgeHN0YXRlX3NpemVzWzRdOiAgIDY0ClsgICAgMC4wMDAwMDBdIHg4Ni9mcHU6
IEVuYWJsZWQgeHN0YXRlIGZlYXR1cmVzIDB4MWYsIGNvbnRleHQgc2l6ZSBpcyA5NjAgYnl0
ZXMsIHVzaW5nICdjb21wYWN0ZWQnIGZvcm1hdC4KWyAgICAwLjAwMDAwMF0gQklPUy1wcm92
aWRlZCBwaHlzaWNhbCBSQU0gbWFwOgpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0g
MHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDAwMDA5MDNmZl0gdXNhYmxlClsgICAgMC4w
MDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwMDAwOTA0MDAtMHgwMDAwMDAwMDAw
MDlmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAw
MDAwMDAwMGUwMDAwLTB4MDAwMDAwMDAwMDBmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAw
MF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDEwMDAwMC0weDAwMDAwMDAwYWJjNjdm
ZmZdIHVzYWJsZQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGFi
YzY4MDAwLTB4MDAwMDAwMDBhYmM2OGZmZl0gQUNQSSBOVlMKWyAgICAwLjAwMDAwMF0gQklP
Uy1lODIwOiBbbWVtIDB4MDAwMDAwMDBhYmM2OTAwMC0weDAwMDAwMDAwYWJjNjlmZmZdIHJl
c2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwYWJjNmEw
MDAtMHgwMDAwMDAwMGJhMDBkZmZmXSB1c2FibGUKWyAgICAwLjAwMDAwMF0gQklPUy1lODIw
OiBbbWVtIDB4MDAwMDAwMDBiYTAwZTAwMC0weDAwMDAwMDAwYmI2N2ZmZmZdIHJlc2VydmVk
ClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwYmI2ODAwMDAtMHgw
MDAwMDAwMGJiNmQ1ZmZmXSBBQ1BJIGRhdGEKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBb
bWVtIDB4MDAwMDAwMDBiYjZkNjAwMC0weDAwMDAwMDAwYmMwMDlmZmZdIEFDUEkgTlZTClsg
ICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwYmMwMGEwMDAtMHgwMDAw
MDAwMGJjNWZlZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0g
MHgwMDAwMDAwMGJjNWZmMDAwLTB4MDAwMDAwMDBiYzVmZmZmZl0gdXNhYmxlClsgICAgMC4w
MDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwYmM2MDAwMDAtMHgwMDAwMDAwMGJm
ZmZmZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAw
MDAwMGYwMDAwMDAwLTB4MDAwMDAwMDBmN2ZmZmZmZl0gcmVzZXJ2ZWQKWyAgICAwLjAwMDAw
MF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZTAwMDAwMC0weDAwMDAwMDAwZmUwMTBm
ZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAw
ZmVjMDAwMDAtMHgwMDAwMDAwMGZlYzAwZmZmXSByZXNlcnZlZApbICAgIDAuMDAwMDAwXSBC
SU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMGZlZTAwMDAwLTB4MDAwMDAwMDBmZWUwMGZmZl0g
cmVzZXJ2ZWQKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZjAw
MDAwMC0weDAwMDAwMDAwZmZmZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1Mt
ZTgyMDogW21lbSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwODNkZmZmZmZmXSB1c2Fi
bGUKWyAgICAwLjAwMDAwMF0gTlggKEV4ZWN1dGUgRGlzYWJsZSkgcHJvdGVjdGlvbjogYWN0
aXZlClsgICAgMC4wMDAwMDBdIFNNQklPUyAzLjAuMCBwcmVzZW50LgpbICAgIDAuMDAwMDAw
XSBETUk6IERlbGwgSW5jLiBQcmVjaXNpb24gVG93ZXIgMzYyMC8wTVdZUFQsIEJJT1MgMi4x
MS4wIDA3LzE4LzIwMTgKWyAgICAwLjAwMDAwMF0gdHNjOiBEZXRlY3RlZCAzNjAwLjAwMCBN
SHogcHJvY2Vzc29yClsgICAgMC4wMDE2MzFdIGU4MjA6IHVwZGF0ZSBbbWVtIDB4MDAwMDAw
MDAtMHgwMDAwMGZmZl0gdXNhYmxlID09PiByZXNlcnZlZApbICAgIDAuMDAxNjMzXSBlODIw
OiByZW1vdmUgW21lbSAweDAwMGEwMDAwLTB4MDAwZmZmZmZdIHVzYWJsZQpbICAgIDAuMDAx
NjM3XSBsYXN0X3BmbiA9IDB4ODNlMDAwIG1heF9hcmNoX3BmbiA9IDB4NDAwMDAwMDAwClsg
ICAgMC4wMDE2NDBdIE1UUlIgZGVmYXVsdCB0eXBlOiB3cml0ZS1iYWNrClsgICAgMC4wMDE2
NDBdIE1UUlIgZml4ZWQgcmFuZ2VzIGVuYWJsZWQ6ClsgICAgMC4wMDE2NDFdICAgMDAwMDAt
OUZGRkYgd3JpdGUtYmFjawpbICAgIDAuMDAxNjQxXSAgIEEwMDAwLUJGRkZGIHVuY2FjaGFi
bGUKWyAgICAwLjAwMTY0MV0gICBDMDAwMC1GRkZGRiB3cml0ZS1wcm90ZWN0ClsgICAgMC4w
MDE2NDJdIE1UUlIgdmFyaWFibGUgcmFuZ2VzIGVuYWJsZWQ6ClsgICAgMC4wMDE2NDNdICAg
MCBiYXNlIDAwQzAwMDAwMDAgbWFzayA3RkMwMDAwMDAwIHVuY2FjaGFibGUKWyAgICAwLjAw
MTY0M10gICAxIGJhc2UgMDBCRTAwMDAwMCBtYXNrIDdGRkUwMDAwMDAgdW5jYWNoYWJsZQpb
ICAgIDAuMDAxNjQ0XSAgIDIgYmFzZSAwMEJEODAwMDAwIG1hc2sgN0ZGRjgwMDAwMCB1bmNh
Y2hhYmxlClsgICAgMC4wMDE2NDRdICAgMyBkaXNhYmxlZApbICAgIDAuMDAxNjQ0XSAgIDQg
ZGlzYWJsZWQKWyAgICAwLjAwMTY0NF0gICA1IGRpc2FibGVkClsgICAgMC4wMDE2NDRdICAg
NiBkaXNhYmxlZApbICAgIDAuMDAxNjQ1XSAgIDcgZGlzYWJsZWQKWyAgICAwLjAwMTY0NV0g
ICA4IGRpc2FibGVkClsgICAgMC4wMDE2NDVdICAgOSBkaXNhYmxlZApbICAgIDAuMDAyNTMw
XSB4ODYvUEFUOiBDb25maWd1cmF0aW9uIFswLTddOiBXQiAgV0MgIFVDLSBVQyAgV0IgIFdQ
ICBVQy0gV1QgIApbICAgIDAuMDAzMDUwXSBsYXN0X3BmbiA9IDB4YmM2MDAgbWF4X2FyY2hf
cGZuID0gMHg0MDAwMDAwMDAKWyAgICAwLjAwODAzOF0gZm91bmQgU01QIE1QLXRhYmxlIGF0
IFttZW0gMHgwMDBmY2U4MC0weDAwMGZjZThmXSBtYXBwZWQgYXQgWyhfX19fcHRydmFsX19f
XyldClsgICAgMC4wMDgwNDRdIEJhc2UgbWVtb3J5IHRyYW1wb2xpbmUgYXQgWyhfX19fcHRy
dmFsX19fXyldIDhhMDAwIHNpemUgMjQ1NzYKWyAgICAwLjAwODA0Nl0gVXNpbmcgR0IgcGFn
ZXMgZm9yIGRpcmVjdCBtYXBwaW5nClsgICAgMC4wMDgwNDhdIEJSSyBbMHgwMmMwMTAwMCwg
MHgwMmMwMWZmZl0gUEdUQUJMRQpbICAgIDAuMDA4MDQ5XSBCUksgWzB4MDJjMDIwMDAsIDB4
MDJjMDJmZmZdIFBHVEFCTEUKWyAgICAwLjAwODA1MF0gQlJLIFsweDAyYzAzMDAwLCAweDAy
YzAzZmZmXSBQR1RBQkxFClsgICAgMC4wMDgwNzRdIEJSSyBbMHgwMmMwNDAwMCwgMHgwMmMw
NGZmZl0gUEdUQUJMRQpbICAgIDAuMDA4MjczXSBCUksgWzB4MDJjMDUwMDAsIDB4MDJjMDVm
ZmZdIFBHVEFCTEUKWyAgICAwLjAwODMwN10gQlJLIFsweDAyYzA2MDAwLCAweDAyYzA2ZmZm
XSBQR1RBQkxFClsgICAgMC4wMDgzNDNdIFJBTURJU0s6IFttZW0gMHgzNzVlNzAwMC0weDM3
YWVhZmZmXQpbICAgIDAuMDA4MzQ3XSBBQ1BJOiBFYXJseSB0YWJsZSBjaGVja3N1bSB2ZXJp
ZmljYXRpb24gZGlzYWJsZWQKWyAgICAwLjAwODM3M10gQUNQSTogUlNEUCAweDAwMDAwMDAw
MDAwRjA1QjAgMDAwMDI0ICh2MDIgREVMTCAgKQpbICAgIDAuMDA4Mzc2XSBBQ1BJOiBYU0RU
IDB4MDAwMDAwMDBCQjZBMDBDOCAwMDAxMEMgKHYwMSBERUxMICAgQ0JYMyAgICAgMDEwNzIw
MDkgQU1JICAwMDAxMDAxMykKWyAgICAwLjAwODM3OV0gQUNQSTogRkFDUCAweDAwMDAwMDAw
QkI2QzkzQzAgMDAwMTBDICh2MDUgREVMTCAgIENCWDMgICAgIDAxMDcyMDA5IEFNSSAgMDAw
MTAwMTMpClsgICAgMC4wMDgzODJdIEFDUEk6IERTRFQgMHgwMDAwMDAwMEJCNkEwMjYwIDAy
OTE1OSAodjAyIERFTEwgICBDQlgzICAgICAwMTA3MjAwOSBJTlRMIDIwMTYwNDIyKQpbICAg
IDAuMDA4Mzg1XSBBQ1BJOiBGQUNTIDB4MDAwMDAwMDBCQzAwOEY4MCAwMDAwNDAKWyAgICAw
LjAwODM4Nl0gQUNQSTogQVBJQyAweDAwMDAwMDAwQkI2Qzk0RDAgMDAwMEJDICh2MDMgREVM
TCAgIENCWDMgICAgIDAxMDcyMDA5IEFNSSAgMDAwMTAwMTMpClsgICAgMC4wMDgzODhdIEFD
UEk6IEZQRFQgMHgwMDAwMDAwMEJCNkM5NTkwIDAwMDA0NCAodjAxIERFTEwgICBDQlgzICAg
ICAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQpbICAgIDAuMDA4MzkwXSBBQ1BJOiBGSURUIDB4
MDAwMDAwMDBCQjZDOTVEOCAwMDAwQUMgKHYwMSBERUxMICAgQ0JYMyAgICAgMDEwNzIwMDkg
QU1JICAwMDAxMDAxMykKWyAgICAwLjAwODM5Ml0gQUNQSTogTUNGRyAweDAwMDAwMDAwQkI2
Qzk2ODggMDAwMDNDICh2MDEgREVMTCAgIENCWDMgICAgIDAxMDcyMDA5IE1TRlQgMDAwMDAw
OTcpClsgICAgMC4wMDgzOTRdIEFDUEk6IEhQRVQgMHgwMDAwMDAwMEJCNkM5NkM4IDAwMDAz
OCAodjAxIERFTEwgICBDQlgzICAgICAwMTA3MjAwOSBBTUkuIDAwMDUwMDBCKQpbICAgIDAu
MDA4Mzk1XSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDBCQjZDOTcwMCAwMDMxNzYgKHYwMiBTYVNz
ZHQgU2FTc2R0ICAgMDAwMDMwMDAgSU5UTCAyMDE2MDQyMikKWyAgICAwLjAwODM5N10gQUNQ
STogU1NEVCAweDAwMDAwMDAwQkI2Q0M4NzggMDAyNUE1ICh2MDIgUGVnU3NkIFBlZ1NzZHQg
IDAwMDAxMDAwIElOVEwgMjAxNjA0MjIpClsgICAgMC4wMDgzOTldIEFDUEk6IEhQRVQgMHgw
MDAwMDAwMEJCNkNFRTIwIDAwMDAzOCAodjAxIElOVEVMICBLQkwgICAgICAwMDAwMDAwMSBN
U0ZUIDAwMDAwMDVGKQpbICAgIDAuMDA4NDAxXSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDBCQjZD
RUU1OCAwMDBERTUgKHYwMiBJTlRFTCAgVGhlcl9SdnAgMDAwMDEwMDAgSU5UTCAyMDE2MDQy
MikKWyAgICAwLjAwODQwM10gQUNQSTogU1NEVCAweDAwMDAwMDAwQkI2Q0ZDNDAgMDAwOEQy
ICh2MDIgSU5URUwgIERFTExfX01UIDAwMDAwMDAwIElOVEwgMjAxNjA0MjIpClsgICAgMC4w
MDg0MDVdIEFDUEk6IFVFRkkgMHgwMDAwMDAwMEJCNkQwNTE4IDAwMDA0MiAodjAxICAgICAg
ICAgICAgICAgICAwMDAwMDAwMCAgICAgIDAwMDAwMDAwKQpbICAgIDAuMDA4NDA3XSBBQ1BJ
OiBTU0RUIDB4MDAwMDAwMDBCQjZEMDU2MCAwMDBFREUgKHYwMiBDcHVSZWYgQ3B1U3NkdCAg
MDAwMDMwMDAgSU5UTCAyMDE2MDQyMikKWyAgICAwLjAwODQwOV0gQUNQSTogTFBJVCAweDAw
MDAwMDAwQkI2RDE0NDAgMDAwMDk0ICh2MDEgSU5URUwgIEtCTCAgICAgIDAwMDAwMDAwIE1T
RlQgMDAwMDAwNUYpClsgICAgMC4wMDg0MTFdIEFDUEk6IFNTRFQgMHgwMDAwMDAwMEJCNkQx
NEQ4IDAwMDE0MSAodjAyIElOVEVMICBIZGFEc3AgICAwMDAwMDAwMCBJTlRMIDIwMTYwNDIy
KQpbICAgIDAuMDA4NDEyXSBBQ1BJOiBTU0RUIDB4MDAwMDAwMDBCQjZEMTYyMCAwMDAyOUYg
KHYwMiBJTlRFTCAgc2Vuc3JodWIgMDAwMDAwMDAgSU5UTCAyMDE2MDQyMikKWyAgICAwLjAw
ODQxNF0gQUNQSTogU1NEVCAweDAwMDAwMDAwQkI2RDE4QzAgMDAzMDAyICh2MDIgSU5URUwg
IFB0aWREZXZjIDAwMDAxMDAwIElOVEwgMjAxNjA0MjIpClsgICAgMC4wMDg0MTZdIEFDUEk6
IFNTRFQgMHgwMDAwMDAwMEJCNkQ0OEM4IDAwMDIxNSAodjAyIElOVEVMICBUYnRUeXBlQyAw
MDAwMDAwMCBJTlRMIDIwMTYwNDIyKQpbICAgIDAuMDA4NDE4XSBBQ1BJOiBEQkdQIDB4MDAw
MDAwMDBCQjZENEFFMCAwMDAwMzQgKHYwMSBJTlRFTCAgICAgICAgICAgMDAwMDAwMDIgTVNG
VCAwMDAwMDA1RikKWyAgICAwLjAwODQyMF0gQUNQSTogREJHMiAweDAwMDAwMDAwQkI2RDRC
MTggMDAwMDU0ICh2MDAgSU5URUwgICAgICAgICAgIDAwMDAwMDAyIE1TRlQgMDAwMDAwNUYp
ClsgICAgMC4wMDg0MjFdIEFDUEk6IE1TRE0gMHgwMDAwMDAwMEJCNkQ0QjcwIDAwMDA1NSAo
djAzIERFTEwgICBDQlgzICAgICAwNjIyMjAwNCBBTUkgIDAwMDEwMDEzKQpbICAgIDAuMDA4
NDIzXSBBQ1BJOiBTTElDIDB4MDAwMDAwMDBCQjZENEJDOCAwMDAxNzYgKHYwMyBERUxMICAg
Q0JYMyAgICAgMDEwNzIwMDkgTVNGVCAwMDAxMDAxMykKWyAgICAwLjAwODQyNV0gQUNQSTog
RE1BUiAweDAwMDAwMDAwQkI2RDRENDAgMDAwMEE4ICh2MDEgSU5URUwgIEtCTCAgICAgIDAw
MDAwMDAxIElOVEwgMDAwMDAwMDEpClsgICAgMC4wMDg0MjddIEFDUEk6IFRQTTIgMHgwMDAw
MDAwMEJCNkQ0REU4IDAwMDAzNCAodjAzICAgICAgICBUcG0yVGFibCAwMDAwMDAwMSBBTUkg
IDAwMDAwMDAwKQpbICAgIDAuMDA4NDI5XSBBQ1BJOiBBU0YhIDB4MDAwMDAwMDBCQjZENEUy
MCAwMDAwQTAgKHYzMiBJTlRFTCAgIEhDRyAgICAgMDAwMDAwMDEgVEZTTSAwMDBGNDI0MCkK
WyAgICAwLjAwODQzMV0gQUNQSTogRUlOSiAweDAwMDAwMDAwQkI2RDRFQzAgMDAwMTMwICh2
MDEgQU1JICAgIEFNSS5FSU5KIDAwMDAwMDAwIEFNSS4gMDAwMDAwMDApClsgICAgMC4wMDg0
MzNdIEFDUEk6IEVSU1QgMHgwMDAwMDAwMEJCNkQ0RkYwIDAwMDIzMCAodjAxIEFNSUVSICBB
TUkuRVJTVCAwMDAwMDAwMCBBTUkuIDAwMDAwMDAwKQpbICAgIDAuMDA4NDM1XSBBQ1BJOiBC
RVJUIDB4MDAwMDAwMDBCQjZENTIyMCAwMDAwMzAgKHYwMSBBTUkgICAgQU1JLkJFUlQgMDAw
MDAwMDAgQU1JLiAwMDAwMDAwMCkKWyAgICAwLjAwODQzNl0gQUNQSTogSEVTVCAweDAwMDAw
MDAwQkI2RDUyNTAgMDAwMEE4ICh2MDEgQU1JICAgIEFNSS5IRVNUIDAwMDAwMDAwIEFNSS4g
MDAwMDAwMDApClsgICAgMC4wMDg0NDFdIEFDUEk6IExvY2FsIEFQSUMgYWRkcmVzcyAweGZl
ZTAwMDAwClsgICAgMC4wMDg1ODNdIE5vIE5VTUEgY29uZmlndXJhdGlvbiBmb3VuZApbICAg
IDAuMDA4NTg0XSBGYWtpbmcgYSBub2RlIGF0IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4
MDAwMDAwMDgzZGZmZmZmZl0KWyAgICAwLjAwODU4Nl0gTk9ERV9EQVRBKDApIGFsbG9jYXRl
ZCBbbWVtIDB4ODNkZmZhMDAwLTB4ODNkZmZkZmZmXQpbICAgIDAuMDA4NTkyXSBSZXNlcnZp
bmcgMjU2TUIgb2YgbWVtb3J5IGF0IDYyNE1CIGZvciBjcmFzaGtlcm5lbCAoU3lzdGVtIFJB
TTogMzI2MzlNQikKWyAgICAwLjAwODYwNl0gWm9uZSByYW5nZXM6ClsgICAgMC4wMDg2MDdd
ICAgRE1BICAgICAgW21lbSAweDAwMDAwMDAwMDAwMDEwMDAtMHgwMDAwMDAwMDAwZmZmZmZm
XQpbICAgIDAuMDA4NjA4XSAgIERNQTMyICAgIFttZW0gMHgwMDAwMDAwMDAxMDAwMDAwLTB4
MDAwMDAwMDBmZmZmZmZmZl0KWyAgICAwLjAwODYwOV0gICBOb3JtYWwgICBbbWVtIDB4MDAw
MDAwMDEwMDAwMDAwMC0weDAwMDAwMDA4M2RmZmZmZmZdClsgICAgMC4wMDg2MTBdIE1vdmFi
bGUgem9uZSBzdGFydCBmb3IgZWFjaCBub2RlClsgICAgMC4wMDg2MTBdIEVhcmx5IG1lbW9y
eSBub2RlIHJhbmdlcwpbICAgIDAuMDA4NjExXSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAw
MDAwMDAwMTAwMC0weDAwMDAwMDAwMDAwOGZmZmZdClsgICAgMC4wMDg2MTJdICAgbm9kZSAg
IDA6IFttZW0gMHgwMDAwMDAwMDAwMTAwMDAwLTB4MDAwMDAwMDBhYmM2N2ZmZl0KWyAgICAw
LjAwODYxMl0gICBub2RlICAgMDogW21lbSAweDAwMDAwMDAwYWJjNmEwMDAtMHgwMDAwMDAw
MGJhMDBkZmZmXQpbICAgIDAuMDA4NjEzXSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDBi
YzVmZjAwMC0weDAwMDAwMDAwYmM1ZmZmZmZdClsgICAgMC4wMDg2MTNdICAgbm9kZSAgIDA6
IFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4MDAwMDAwMDgzZGZmZmZmZl0KWyAgICAwLjAw
ODYxNl0gUmVzZXJ2ZWQgYnV0IHVuYXZhaWxhYmxlOiAxMTMgcGFnZXMKWyAgICAwLjAwODYx
Nl0gSW5pdG1lbSBzZXR1cCBub2RlIDAgW21lbSAweDAwMDAwMDAwMDAwMDEwMDAtMHgwMDAw
MDAwODNkZmZmZmZmXQpbICAgIDAuMDA4NjE4XSBPbiBub2RlIDAgdG90YWxwYWdlczogODM1
NTc0MApbICAgIDAuMDA4NjE4XSAgIERNQSB6b25lOiA2NCBwYWdlcyB1c2VkIGZvciBtZW1t
YXAKWyAgICAwLjAwODYxOV0gICBETUEgem9uZTogMjEgcGFnZXMgcmVzZXJ2ZWQKWyAgICAw
LjAwODYxOV0gICBETUEgem9uZTogMzk4MyBwYWdlcywgTElGTyBiYXRjaDowClsgICAgMC4w
MDg2NzVdICAgRE1BMzIgem9uZTogMTE4NDEgcGFnZXMgdXNlZCBmb3IgbWVtbWFwClsgICAg
MC4wMDg2NzZdICAgRE1BMzIgem9uZTogNzU3NzczIHBhZ2VzLCBMSUZPIGJhdGNoOjYzClsg
ICAgMC4wMTk4NTFdICAgTm9ybWFsIHpvbmU6IDExODY1NiBwYWdlcyB1c2VkIGZvciBtZW1t
YXAKWyAgICAwLjAxOTg1Ml0gICBOb3JtYWwgem9uZTogNzU5Mzk4NCBwYWdlcywgTElGTyBi
YXRjaDo2MwpbICAgIDAuMTIyOTE3XSBBQ1BJOiBQTS1UaW1lciBJTyBQb3J0OiAweDE4MDgK
WyAgICAwLjEyMjkxOF0gQUNQSTogTG9jYWwgQVBJQyBhZGRyZXNzIDB4ZmVlMDAwMDAKWyAg
ICAwLjEyMjkyMV0gQUNQSTogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDFdIGhpZ2ggZWRnZSBs
aW50WzB4MV0pClsgICAgMC4xMjI5MjJdIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDAy
XSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMTIyOTIzXSBBQ1BJOiBMQVBJQ19OTUkg
KGFjcGlfaWRbMHgwM10gaGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjEyMjkyM10gQUNQ
STogTEFQSUNfTk1JIChhY3BpX2lkWzB4MDRdIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAg
MC4xMjI5MjRdIEFDUEk6IExBUElDX05NSSAoYWNwaV9pZFsweDA1XSBoaWdoIGVkZ2UgbGlu
dFsweDFdKQpbICAgIDAuMTIyOTI0XSBBQ1BJOiBMQVBJQ19OTUkgKGFjcGlfaWRbMHgwNl0g
aGlnaCBlZGdlIGxpbnRbMHgxXSkKWyAgICAwLjEyMjkyNV0gQUNQSTogTEFQSUNfTk1JIChh
Y3BpX2lkWzB4MDddIGhpZ2ggZWRnZSBsaW50WzB4MV0pClsgICAgMC4xMjI5MjVdIEFDUEk6
IExBUElDX05NSSAoYWNwaV9pZFsweDA4XSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAu
MTIyOTUyXSBJT0FQSUNbMF06IGFwaWNfaWQgMiwgdmVyc2lvbiAzMiwgYWRkcmVzcyAweGZl
YzAwMDAwLCBHU0kgMC0xMTkKWyAgICAwLjEyMjk1M10gQUNQSTogSU5UX1NSQ19PVlIgKGJ1
cyAwIGJ1c19pcnEgMCBnbG9iYWxfaXJxIDIgZGZsIGRmbCkKWyAgICAwLjEyMjk1NF0gQUNQ
STogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEgOSBnbG9iYWxfaXJxIDkgaGlnaCBsZXZl
bCkKWyAgICAwLjEyMjk1NV0gQUNQSTogSVJRMCB1c2VkIGJ5IG92ZXJyaWRlLgpbICAgIDAu
MTIyOTU2XSBBQ1BJOiBJUlE5IHVzZWQgYnkgb3ZlcnJpZGUuClsgICAgMC4xMjI5NTddIFVz
aW5nIEFDUEkgKE1BRFQpIGZvciBTTVAgY29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbgpbICAg
IDAuMTIyOTU4XSBBQ1BJOiBIUEVUIGlkOiAweDgwODZhNzAxIGJhc2U6IDB4ZmVkMDAwMDAK
WyAgICAwLjEyMjk2MF0gc21wYm9vdDogQWxsb3dpbmcgOCBDUFVzLCAwIGhvdHBsdWcgQ1BV
cwpbICAgIDAuMTIyOTcwXSBbbWVtIDB4YzAwMDAwMDAtMHhlZmZmZmZmZl0gYXZhaWxhYmxl
IGZvciBQQ0kgZGV2aWNlcwpbICAgIDAuMTIyOTcyXSBjbG9ja3NvdXJjZTogcmVmaW5lZC1q
aWZmaWVzOiBtYXNrOiAweGZmZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9p
ZGxlX25zOiAxOTEwOTY5OTQwMzkxNDE5IG5zClsgICAgMC4yMDkyMzZdIHJhbmRvbTogZ2V0
X3JhbmRvbV9ieXRlcyBjYWxsZWQgZnJvbSBzdGFydF9rZXJuZWwrMHg5MC8weDRhNyB3aXRo
IGNybmdfaW5pdD0wClsgICAgMC4yMDkyNDBdIHNldHVwX3BlcmNwdTogTlJfQ1BVUzoyNTYg
bnJfY3B1bWFza19iaXRzOjI1NiBucl9jcHVfaWRzOjggbnJfbm9kZV9pZHM6MQpbICAgIDAu
MjA5MzQyXSBwZXJjcHU6IEVtYmVkZGVkIDQyIHBhZ2VzL2NwdSBAKF9fX19wdHJ2YWxfX19f
KSBzMTM0MTA0IHI4MTkyIGQyOTczNiB1MjYyMTQ0ClsgICAgMC4yMDkzNDZdIHBjcHUtYWxs
b2M6IHMxMzQxMDQgcjgxOTIgZDI5NzM2IHUyNjIxNDQgYWxsb2M9MSoyMDk3MTUyClsgICAg
MC4yMDkzNDZdIHBjcHUtYWxsb2M6IFswXSAwIDEgMiAzIDQgNSA2IDcgClsgICAgMC4yMDkz
NThdIEJ1aWx0IDEgem9uZWxpc3RzLCBtb2JpbGl0eSBncm91cGluZyBvbi4gIFRvdGFsIHBh
Z2VzOiA4MjI1MTU4ClsgICAgMC4yMDkzNTldIFBvbGljeSB6b25lOiBOb3JtYWwKWyAgICAw
LjIwOTM2MF0gS2VybmVsIGNvbW1hbmQgbGluZTogQk9PVF9JTUFHRT0vYm9vdC9iekltYWdl
LTQuMTkuMTkubXg2NC4yNDQgY3Jhc2hrZXJuZWw9MjU2TSByb290PUxBQkVMPXJvb3Qgcm8g
Y29uc29sZT10dHlTMSwxMTUyMDBuOCBjb25zb2xlPXR0eTAgaW5pdD0vYmluL3N5c3RlbWQg
YXVkaXQ9MApbICAgIDAuMjA5NDM0XSBhdWRpdDogZGlzYWJsZWQgKHVudGlsIHJlYm9vdCkK
WyAgICAwLjI2MDg4OF0gTWVtb3J5OiAzMjUzNTE2OEsvMzM0MjI5NjBLIGF2YWlsYWJsZSAo
MTQzNDhLIGtlcm5lbCBjb2RlLCAxMzc5SyByd2RhdGEsIDM1MjBLIHJvZGF0YSwgMTU2NEsg
aW5pdCwgMTIwMEsgYnNzLCA4ODc3OTJLIHJlc2VydmVkLCAwSyBjbWEtcmVzZXJ2ZWQpClsg
ICAgMC4yNjA5MjVdIEtlcm5lbC9Vc2VyIHBhZ2UgdGFibGVzIGlzb2xhdGlvbjogZW5hYmxl
ZApbICAgIDAuMjYwOTYwXSBmdHJhY2U6IGFsbG9jYXRpbmcgNDE4MDkgZW50cmllcyBpbiAx
NjQgcGFnZXMKWyAgICAwLjI3MjAwOV0gcmN1OiBIaWVyYXJjaGljYWwgUkNVIGltcGxlbWVu
dGF0aW9uLgpbICAgIDAuMjcyMDExXSByY3U6IAlSQ1UgZXZlbnQgdHJhY2luZyBpcyBlbmFi
bGVkLgpbICAgIDAuMjcyMDEyXSByY3U6IAlSQ1UgcmVzdHJpY3RpbmcgQ1BVcyBmcm9tIE5S
X0NQVVM9MjU2IHRvIG5yX2NwdV9pZHM9OC4KWyAgICAwLjI3MjAxM10gcmN1OiBBZGp1c3Rp
bmcgZ2VvbWV0cnkgZm9yIHJjdV9mYW5vdXRfbGVhZj0xNiwgbnJfY3B1X2lkcz04ClsgICAg
MC4yNzMwNDhdIE5SX0lSUVM6IDE2NjQwLCBucl9pcnFzOiAyMDQ4LCBwcmVhbGxvY2F0ZWQg
aXJxczogMTYKWyAgICAwLjI3MzM0OF0gc3B1cmlvdXMgODI1OUEgaW50ZXJydXB0OiBJUlE3
LgpbICAgIDAuMjc2NjE5XSBDb25zb2xlOiBjb2xvdXIgVkdBKyA4MHgyNQpbICAgIDAuMjk2
MzA0XSBjb25zb2xlIFt0dHkwXSBlbmFibGVkClsgICAgMC4zNjkwMjFdIGNvbnNvbGUgW3R0
eVMxXSBlbmFibGVkClsgICAgMC4zNjk0NjNdIEFDUEk6IENvcmUgcmV2aXNpb24gMjAxODA4
MTAKWyAgICAwLjM3MDE5OV0gY2xvY2tzb3VyY2U6IGhwZXQ6IG1hc2s6IDB4ZmZmZmZmZmYg
bWF4X2N5Y2xlczogMHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDc5NjM1ODU1MjQ1IG5zClsg
ICAgMC4zNzExNTldIGhwZXQgY2xvY2tldmVudCByZWdpc3RlcmVkClsgICAgMC4zNzEyMjhd
IEFQSUM6IFN3aXRjaCB0byBzeW1tZXRyaWMgSS9PIG1vZGUgc2V0dXAKWyAgICAwLjM3NDYx
MF0gLi5USU1FUjogdmVjdG9yPTB4MzAgYXBpYzE9MCBwaW4xPTIgYXBpYzI9MCBwaW4yPTAK
WyAgICAwLjM4MDE2N10gY2xvY2tzb3VyY2U6IHRzYy1lYXJseTogbWFzazogMHhmZmZmZmZm
ZmZmZmZmZmZmIG1heF9jeWNsZXM6IDB4MzNlNDUyZmJiMmYsIG1heF9pZGxlX25zOiA0NDA3
OTUyMzY1OTMgbnMKWyAgICAwLjM4MTIyMF0gQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcCAoc2tp
cHBlZCksIHZhbHVlIGNhbGN1bGF0ZWQgdXNpbmcgdGltZXIgZnJlcXVlbmN5Li4gNzIwMC4w
MCBCb2dvTUlQUyAobHBqPTM2MDAwMDApClsgICAgMC4zODIyMjBdIHBpZF9tYXg6IGRlZmF1
bHQ6IDMyNzY4IG1pbmltdW06IDMwMQpbICAgIDAuMzg1NjIzXSBEZW50cnkgY2FjaGUgaGFz
aCB0YWJsZSBlbnRyaWVzOiA0MTk0MzA0IChvcmRlcjogMTMsIDMzNTU0NDMyIGJ5dGVzKQpb
ICAgIDAuMzg3NzgyXSBJbm9kZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDIwOTcxNTIg
KG9yZGVyOiAxMiwgMTY3NzcyMTYgYnl0ZXMpClsgICAgMC4zODgyNjVdIE1vdW50LWNhY2hl
IGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9yZGVyOiA3LCA1MjQyODggYnl0ZXMpClsg
ICAgMC4zODkyNjZdIE1vdW50cG9pbnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUz
NiAob3JkZXI6IDcsIDUyNDI4OCBieXRlcykKWyAgICAwLjM5MDI3OV0gRU5FUkdZX1BFUkZf
QklBUzogU2V0IHRvICdub3JtYWwnLCB3YXMgJ3BlcmZvcm1hbmNlJwpbICAgIDAuMzkwOTE3
XSBFTkVSR1lfUEVSRl9CSUFTOiBWaWV3IGFuZCB1cGRhdGUgd2l0aCB4ODZfZW5lcmd5X3Bl
cmZfcG9saWN5KDgpClsgICAgMC4zOTEyMjNdIG1jZTogQ1BVIHN1cHBvcnRzIDEwIE1DRSBi
YW5rcwpbICAgIDAuMzkxNzExXSBDUFUwOiBUaGVybWFsIG1vbml0b3JpbmcgZW5hYmxlZCAo
VE0xKQpbICAgIDAuMzkyMjMzXSBwcm9jZXNzOiB1c2luZyBtd2FpdCBpbiBpZGxlIHRocmVh
ZHMKWyAgICAwLjM5MzIyMV0gTGFzdCBsZXZlbCBpVExCIGVudHJpZXM6IDRLQiA2NCwgMk1C
IDgsIDRNQiA4ClsgICAgMC4zOTM4MDldIExhc3QgbGV2ZWwgZFRMQiBlbnRyaWVzOiA0S0Ig
NjQsIDJNQiAwLCA0TUIgMCwgMUdCIDQKWyAgICAwLjM5NDIyMV0gU3BlY3RyZSBWMiA6IE1p
dGlnYXRpb246IEZ1bGwgZ2VuZXJpYyByZXRwb2xpbmUKWyAgICAwLjM5NTIyMF0gU3BlY3Ry
ZSBWMiA6IFNwZWN0cmUgdjIgLyBTcGVjdHJlUlNCIG1pdGlnYXRpb246IEZpbGxpbmcgUlNC
IG9uIGNvbnRleHQgc3dpdGNoClsgICAgMC4zOTYwODRdIFNwZWN0cmUgVjIgOiBFbmFibGlu
ZyBSZXN0cmljdGVkIFNwZWN1bGF0aW9uIGZvciBmaXJtd2FyZSBjYWxscwpbICAgIDAuMzk2
MjIwXSBTcGVjdHJlIFYyIDogbWl0aWdhdGlvbjogRW5hYmxpbmcgY29uZGl0aW9uYWwgSW5k
aXJlY3QgQnJhbmNoIFByZWRpY3Rpb24gQmFycmllcgpbICAgIDAuMzk3MjIwXSBTcGVjdHJl
IFYyIDogVXNlciBzcGFjZTogTWl0aWdhdGlvbjogU1RJQlAgdmlhIHNlY2NvbXAgYW5kIHBy
Y3RsClsgICAgMC4zOTgyMjBdIFNwZWN1bGF0aXZlIFN0b3JlIEJ5cGFzczogTWl0aWdhdGlv
bjogU3BlY3VsYXRpdmUgU3RvcmUgQnlwYXNzIGRpc2FibGVkIHZpYSBwcmN0bCBhbmQgc2Vj
Y29tcApbICAgIDAuMzk5Mzk3XSBGcmVlaW5nIFNNUCBhbHRlcm5hdGl2ZXMgbWVtb3J5OiA0
NEsKWyAgICAwLjQwMDI1NV0gVFNDIGRlYWRsaW5lIHRpbWVyIGVuYWJsZWQKWyAgICAwLjQw
MDI2MF0gc21wYm9vdDogQ1BVMDogSW50ZWwoUikgQ29yZShUTSkgaTctNzcwMCBDUFUgQCAz
LjYwR0h6IChmYW1pbHk6IDB4NiwgbW9kZWw6IDB4OWUsIHN0ZXBwaW5nOiAweDkpClsgICAg
MC40MDEyNjddIFBlcmZvcm1hbmNlIEV2ZW50czogUEVCUyBmbXQzKywgU2t5bGFrZSBldmVu
dHMsIDMyLWRlZXAgTEJSLCBmdWxsLXdpZHRoIGNvdW50ZXJzLCBJbnRlbCBQTVUgZHJpdmVy
LgpbICAgIDAuNDAyMjIyXSAuLi4gdmVyc2lvbjogICAgICAgICAgICAgICAgNApbICAgIDAu
NDAyNzY4XSAuLi4gYml0IHdpZHRoOiAgICAgICAgICAgICAgNDgKWyAgICAwLjQwMzIyMF0g
Li4uIGdlbmVyaWMgcmVnaXN0ZXJzOiAgICAgIDQKWyAgICAwLjQwMzc2NF0gLi4uIHZhbHVl
IG1hc2s6ICAgICAgICAgICAgIDAwMDBmZmZmZmZmZmZmZmYKWyAgICAwLjQwNDIyMF0gLi4u
IG1heCBwZXJpb2Q6ICAgICAgICAgICAgIDAwMDA3ZmZmZmZmZmZmZmYKWyAgICAwLjQwNDg3
MF0gLi4uIGZpeGVkLXB1cnBvc2UgZXZlbnRzOiAgIDMKWyAgICAwLjQwNTIyMF0gLi4uIGV2
ZW50IG1hc2s6ICAgICAgICAgICAgIDAwMDAwMDA3MDAwMDAwMGYKWyAgICAwLjQwNTg5Nl0g
cmN1OiBIaWVyYXJjaGljYWwgU1JDVSBpbXBsZW1lbnRhdGlvbi4KWyAgICAwLjQwNjMwN10g
c21wOiBCcmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAuLi4KWyAgICAwLjQwNjk0MF0geDg2
OiBCb290aW5nIFNNUCBjb25maWd1cmF0aW9uOgpbICAgIDAuNDA3MjIwXSAuLi4uIG5vZGUg
ICMwLCBDUFVzOiAgICAgICMxICMyICMzICM0ICM1ICM2ICM3ClsgICAgMC40MTAxMDJdIHNt
cDogQnJvdWdodCB1cCAxIG5vZGUsIDggQ1BVcwpbICAgIDAuNDEwNzc0XSBzbXBib290OiBN
YXggbG9naWNhbCBwYWNrYWdlczogMQpbICAgIDAuNDExMjIwXSBzbXBib290OiBUb3RhbCBv
ZiA4IHByb2Nlc3NvcnMgYWN0aXZhdGVkICg1NzYwMC4wMCBCb2dvTUlQUykKWyAgICAwLjQx
Mjc0MV0gZGV2dG1wZnM6IGluaXRpYWxpemVkClsgICAgMC40MTMzODNdIFBNOiBSZWdpc3Rl
cmluZyBBQ1BJIE5WUyByZWdpb24gW21lbSAweGFiYzY4MDAwLTB4YWJjNjhmZmZdICg0MDk2
IGJ5dGVzKQpbICAgIDAuNDE0MjIxXSBQTTogUmVnaXN0ZXJpbmcgQUNQSSBOVlMgcmVnaW9u
IFttZW0gMHhiYjZkNjAwMC0weGJjMDA5ZmZmXSAoOTY1MDE3NiBieXRlcykKWyAgICAwLjQx
NTMzNV0gY2xvY2tzb3VyY2U6IGppZmZpZXM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4X2N5Y2xl
czogMHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDE5MTEyNjA0NDYyNzUwMDAgbnMKWyAgICAw
LjQxNjIyN10gZnV0ZXggaGFzaCB0YWJsZSBlbnRyaWVzOiAyMDQ4IChvcmRlcjogNSwgMTMx
MDcyIGJ5dGVzKQpbICAgIDAuNDE2OTg2XSB4b3I6IGF1dG9tYXRpY2FsbHkgdXNpbmcgYmVz
dCBjaGVja3N1bW1pbmcgZnVuY3Rpb24gICBhdnggICAgICAgClsgICAgMC40MTcyOTBdIE5F
VDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYKWyAgICAwLjQxNzk5OV0gY3B1aWRs
ZTogdXNpbmcgZ292ZXJub3IgbGFkZGVyClsgICAgMC40MTg1OTVdIEFDUEkgRkFEVCBkZWNs
YXJlcyB0aGUgc3lzdGVtIGRvZXNuJ3Qgc3VwcG9ydCBQQ0llIEFTUE0sIHNvIGRpc2FibGUg
aXQKWyAgICAwLjQxOTIyMV0gQUNQSTogYnVzIHR5cGUgUENJIHJlZ2lzdGVyZWQKWyAgICAw
LjQxOTc5OF0gUENJOiBNTUNPTkZJRyBmb3IgZG9tYWluIDAwMDAgW2J1cyAwMC03Zl0gYXQg
W21lbSAweGYwMDAwMDAwLTB4ZjdmZmZmZmZdIChiYXNlIDB4ZjAwMDAwMDApClsgICAgMC40
MjEyMjFdIFBDSTogTU1DT05GSUcgYXQgW21lbSAweGYwMDAwMDAwLTB4ZjdmZmZmZmZdIHJl
c2VydmVkIGluIEU4MjAKWyAgICAwLjQyMTk5OV0gUENJOiBVc2luZyBjb25maWd1cmF0aW9u
IHR5cGUgMSBmb3IgYmFzZSBhY2Nlc3MKWyAgICAwLjQyNDIyNl0gSHVnZVRMQiByZWdpc3Rl
cmVkIDIuMDAgTWlCIHBhZ2Ugc2l6ZSwgcHJlLWFsbG9jYXRlZCAwIHBhZ2VzClsgICAgMC40
NDA0MzddIHJhaWQ2OiBzc2UyeDEgICBnZW4oKSAxMzIxMCBNQi9zClsgICAgMC40NTc0NDFd
IHJhaWQ2OiBzc2UyeDEgICB4b3IoKSAgOTc1MSBNQi9zClsgICAgMC40NzQ0NDRdIHJhaWQ2
OiBzc2UyeDIgICBnZW4oKSAxNjM0MyBNQi9zClsgICAgMC40OTE0NDldIHJhaWQ2OiBzc2Uy
eDIgICB4b3IoKSAxMTIyNCBNQi9zClsgICAgMC41MDg0NTNdIHJhaWQ2OiBzc2UyeDQgICBn
ZW4oKSAxOTE0MCBNQi9zClsgICAgMC41MjU0NTZdIHJhaWQ2OiBzc2UyeDQgICB4b3IoKSAx
MjAwMSBNQi9zClsgICAgMC41NDI0NThdIHJhaWQ2OiBhdngyeDEgICBnZW4oKSAyNjc5NiBN
Qi9zClsgICAgMC41NTk0NjFdIHJhaWQ2OiBhdngyeDEgICB4b3IoKSAxODk2MiBNQi9zClsg
ICAgMC41NzY0NjZdIHJhaWQ2OiBhdngyeDIgICBnZW4oKSAzMjM3NSBNQi9zClsgICAgMC41
OTM0NjldIHJhaWQ2OiBhdngyeDIgICB4b3IoKSAyMTAzMSBNQi9zClsgICAgMC42MTA0NzNd
IHJhaWQ2OiBhdngyeDQgICBnZW4oKSAzNzg5OCBNQi9zClsgICAgMC42Mjc0NzZdIHJhaWQ2
OiBhdngyeDQgICB4b3IoKSAyMjUwMyBNQi9zClsgICAgMC42MjgwNDNdIHJhaWQ2OiB1c2lu
ZyBhbGdvcml0aG0gYXZ4Mng0IGdlbigpIDM3ODk4IE1CL3MKWyAgICAwLjYyOTIyMF0gcmFp
ZDY6IC4uLi4geG9yKCkgMjI1MDMgTUIvcywgcm13IGVuYWJsZWQKWyAgICAwLjYyOTg0OV0g
cmFpZDY6IHVzaW5nIGF2eDJ4MiByZWNvdmVyeSBhbGdvcml0aG0KWyAgICAwLjYzMDcwNl0g
QUNQSTogQWRkZWQgX09TSShNb2R1bGUgRGV2aWNlKQpbICAgIDAuNjMwODA3XSBBQ1BJOiBB
ZGRlZCBfT1NJKFByb2Nlc3NvciBEZXZpY2UpClsgICAgMC42MzEyMjFdIEFDUEk6IEFkZGVk
IF9PU0koMy4wIF9TQ1AgRXh0ZW5zaW9ucykKWyAgICAwLjYzMTgyMl0gQUNQSTogQWRkZWQg
X09TSShQcm9jZXNzb3IgQWdncmVnYXRvciBEZXZpY2UpClsgICAgMC42MzIyMjBdIEFDUEk6
IEFkZGVkIF9PU0koTGludXgtRGVsbC1WaWRlbykKWyAgICAwLjYzMjgwMV0gQUNQSTogQWRk
ZWQgX09TSShMaW51eC1MZW5vdm8tTlYtSERNSS1BdWRpbykKWyAgICAwLjY2MDM5NV0gQUNQ
STogMTAgQUNQSSBBTUwgdGFibGVzIHN1Y2Nlc3NmdWxseSBhY3F1aXJlZCBhbmQgbG9hZGVk
ClsgICAgMC42NjgxMDldIEFDUEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAgMC42
NjgyMjRdIEFDUEk6IFNTRFQgMHhGRkZGODg4ODE5ODNGMDAwIDAwMDc1OSAodjAyIFBtUmVm
ICBDcHUwSXN0ICAwMDAwMzAwMCBJTlRMIDIwMTYwNDIyKQpbICAgIDAuNjY5NTU4XSBBQ1BJ
OiBcX1BSXy5DUFUwOiBfT1NDIG5hdGl2ZSB0aGVybWFsIExWVCBBY2tlZApbICAgIDAuNjcx
MTE4XSBBQ1BJOiBEeW5hbWljIE9FTSBUYWJsZSBMb2FkOgpbICAgIDAuNjcyMjIzXSBBQ1BJ
OiBTU0RUIDB4RkZGRjg4ODgxOUY5NzQwMCAwMDAzRkYgKHYwMiBQbVJlZiAgQ3B1MENzdCAg
MDAwMDMwMDEgSU5UTCAyMDE2MDQyMikKWyAgICAwLjY3MzUwNV0gQUNQSTogRHluYW1pYyBP
RU0gVGFibGUgTG9hZDoKWyAgICAwLjY3NDA1NF0gQUNQSTogU1NEVCAweEZGRkY4ODg4MTlG
NEZFMDAgMDAwMTE1ICh2MDIgUG1SZWYgIENwdTBId3AgIDAwMDAzMDAwIElOVEwgMjAxNjA0
MjIpClsgICAgMC42NzQ0MThdIEFDUEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAg
MC42NzQ5NjddIEFDUEk6IFNTRFQgMHhGRkZGODg4ODE5RjRGQzAwIDAwMDFBNCAodjAyIFBt
UmVmICBId3BMdnQgICAwMDAwMzAwMCBJTlRMIDIwMTYwNDIyKQpbICAgIDAuNjc2NjE5XSBB
Q1BJOiBEeW5hbWljIE9FTSBUYWJsZSBMb2FkOgpbICAgIDAuNjc3MTY5XSBBQ1BJOiBTU0RU
IDB4RkZGRjg4ODgxOUY1MDgwMCAwMDA2NUMgKHYwMiBQbVJlZiAgQXBJc3QgICAgMDAwMDMw
MDAgSU5UTCAyMDE2MDQyMikKWyAgICAwLjY3ODY2MV0gQUNQSTogRHluYW1pYyBPRU0gVGFi
bGUgTG9hZDoKWyAgICAwLjY3OTIxMF0gQUNQSTogU1NEVCAweEZGRkY4ODg4MTlGNEZBMDAg
MDAwMTk3ICh2MDIgUG1SZWYgIEFwSHdwICAgIDAwMDAzMDAwIElOVEwgMjAxNjA0MjIpClsg
ICAgMC42ODA0ODBdIEFDUEk6IER5bmFtaWMgT0VNIFRhYmxlIExvYWQ6ClsgICAgMC42ODEw
MjddIEFDUEk6IFNTRFQgMHhGRkZGODg4ODE5RjRGODAwIDAwMDE4QSAodjAyIFBtUmVmICBB
cENzdCAgICAwMDAwMzAwMCBJTlRMIDIwMTYwNDIyKQpbICAgIDAuNjg0ODMyXSBBQ1BJOiBJ
bnRlcnByZXRlciBlbmFibGVkClsgICAgMC42ODUyNDJdIEFDUEk6IChzdXBwb3J0cyBTMCBT
MyBTNSkKWyAgICAwLjY4NTc1OV0gQUNQSTogVXNpbmcgSU9BUElDIGZvciBpbnRlcnJ1cHQg
cm91dGluZwpbICAgIDAuNjg2MjQ0XSBQQ0k6IFVzaW5nIGhvc3QgYnJpZGdlIHdpbmRvd3Mg
ZnJvbSBBQ1BJOyBpZiBuZWNlc3NhcnksIHVzZSAicGNpPW5vY3JzIiBhbmQgcmVwb3J0IGEg
YnVnClsgICAgMC42ODc4ODldIEFDUEk6IEVuYWJsZWQgNiBHUEVzIGluIGJsb2NrIDAwIHRv
IDdGClsgICAgMC42OTA4NTFdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtQRzAwXSAob24pClsg
ICAgMC42OTE0NDldIEFDUEk6IFBvd2VyIFJlc291cmNlIFtQRzAxXSAob24pClsgICAgMC42
OTIyNDJdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtQRzAyXSAob24pClsgICAgMC42OTQ1MTdd
IEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC42OTUzMTNdIEFDUEk6
IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC42OTYxMDZdIEFDUEk6IFBvd2Vy
IFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC42OTY0NDVdIEFDUEk6IFBvd2VyIFJlc291
cmNlIFtXUlNUXSAob24pClsgICAgMC42OTcyMzZdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtX
UlNUXSAob24pClsgICAgMC42OTgwMzVdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAo
b24pClsgICAgMC42OTk0NDRdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsg
ICAgMC43MDAyMzZdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC43
MDEwMjZdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC43MDE0NDRd
IEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC43MDIyMzVdIEFDUEk6
IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC43MDMwMjZdIEFDUEk6IFBvd2Vy
IFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC43MDM0NDVdIEFDUEk6IFBvd2VyIFJlc291
cmNlIFtXUlNUXSAob24pClsgICAgMC43MDQyMzVdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtX
UlNUXSAob24pClsgICAgMC43MDUwMjddIEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAo
b24pClsgICAgMC43MDY0NDVdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsg
ICAgMC43MDc4NjRdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC43
MDg0NDVdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC43MDkyMzdd
IEFDUEk6IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC43MTAwMzFdIEFDUEk6
IFBvd2VyIFJlc291cmNlIFtXUlNUXSAob24pClsgICAgMC43MTk5MThdIEFDUEk6IFBvd2Vy
IFJlc291cmNlIFtGTjAwXSAob2ZmKQpbICAgIDAuNzIxMjc5XSBBQ1BJOiBQb3dlciBSZXNv
dXJjZSBbRk4wMV0gKG9mZikKWyAgICAwLjcyMTkwOF0gQUNQSTogUG93ZXIgUmVzb3VyY2Ug
W0ZOMDJdIChvZmYpClsgICAgMC43MjIyNzVdIEFDUEk6IFBvd2VyIFJlc291cmNlIFtGTjAz
XSAob2ZmKQpbICAgIDAuNzIyOTA0XSBBQ1BJOiBQb3dlciBSZXNvdXJjZSBbRk4wNF0gKG9m
ZikKWyAgICAwLjcyNDAxOF0gQUNQSTogUENJIFJvb3QgQnJpZGdlIFtQQ0kwXSAoZG9tYWlu
IDAwMDAgW2J1cyAwMC03ZV0pClsgICAgMC43MjUyMjRdIGFjcGkgUE5QMEEwODowMDogX09T
QzogT1Mgc3VwcG9ydHMgW0V4dGVuZGVkQ29uZmlnIEFTUE0gQ2xvY2tQTSBTZWdtZW50cyBN
U0ldClsgICAgMC43MjYzNDddIGFjcGkgUE5QMEEwODowMDogX09TQzogcGxhdGZvcm0gZG9l
cyBub3Qgc3VwcG9ydCBbUE1FXQpbICAgIDAuNzI3MTg5XSBhY3BpIFBOUDBBMDg6MDA6IF9P
U0M6IE9TIG5vdyBjb250cm9scyBbQUVSIFBDSWVDYXBhYmlsaXR5IExUUl0KWyAgICAwLjcy
ODIyMV0gYWNwaSBQTlAwQTA4OjAwOiBGQURUIGluZGljYXRlcyBBU1BNIGlzIHVuc3VwcG9y
dGVkLCB1c2luZyBCSU9TIGNvbmZpZ3VyYXRpb24KWyAgICAwLjcyOTQ2OV0gUENJIGhvc3Qg
YnJpZGdlIHRvIGJ1cyAwMDAwOjAwClsgICAgMC43MzAwMjNdIHBjaV9idXMgMDAwMDowMDog
cm9vdCBidXMgcmVzb3VyY2UgW2lvICAweDAwMDAtMHgwY2Y3IHdpbmRvd10KWyAgICAwLjcz
MDIyMV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4MGQwMC0w
eGZmZmYgd2luZG93XQpbICAgIDAuNzMwOTkxXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVz
IHJlc291cmNlIFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZmIHdpbmRvd10KWyAgICAwLjcz
MjIyMV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4YzAwMDAw
MDAtMHhlZmZmZmZmZiB3aW5kb3ddClsgICAgMC43MzMxNjJdIHBjaV9idXMgMDAwMDowMDog
cm9vdCBidXMgcmVzb3VyY2UgW21lbSAweGZkMDAwMDAwLTB4ZmU3ZmZmZmYgd2luZG93XQpb
ICAgIDAuNzM0MjIxXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMg
MDAtN2VdClsgICAgMC43MzQ4OTBdIHBjaSAwMDAwOjAwOjAwLjA6IFs4MDg2OjU5MWZdIHR5
cGUgMDAgY2xhc3MgMHgwNjAwMDAKWyAgICAwLjczNTExOV0gcGNpIDAwMDA6MDA6MDEuMDog
WzgwODY6MTkwMV0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMApbICAgIDAuNzM1MTUwXSBwY2kg
MDAwMDowMDowMS4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAg
IDAuNzM1Mjg0XSBwY2kgMDAwMDowMDowMi4wOiBbODA4Njo1OTEyXSB0eXBlIDAwIGNsYXNz
IDB4MDM4MDAwClsgICAgMC43MzUyOTFdIHBjaSAwMDAwOjAwOjAyLjA6IHJlZyAweDEwOiBb
bWVtIDB4ZWUwMDAwMDAtMHhlZWZmZmZmZiA2NGJpdF0KWyAgICAwLjczNTI5NV0gcGNpIDAw
MDA6MDA6MDIuMDogcmVnIDB4MTg6IFttZW0gMHhjMDAwMDAwMC0weGNmZmZmZmZmIDY0Yml0
IHByZWZdClsgICAgMC43MzUyOThdIHBjaSAwMDAwOjAwOjAyLjA6IHJlZyAweDIwOiBbaW8g
IDB4ZjAwMC0weGYwM2ZdClsgICAgMC43MzU0NTVdIHBjaSAwMDAwOjAwOjE0LjA6IFs4MDg2
OmExMmZdIHR5cGUgMDAgY2xhc3MgMHgwYzAzMzAKWyAgICAwLjczNTQ4N10gcGNpIDAwMDA6
MDA6MTQuMDogcmVnIDB4MTA6IFttZW0gMHhlZjEzMDAwMC0weGVmMTNmZmZmIDY0Yml0XQpb
ICAgIDAuNzM1NTg0XSBwY2kgMDAwMDowMDoxNC4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQz
aG90IEQzY29sZApbICAgIDAuNzM1NzQzXSBwY2kgMDAwMDowMDoxNC4yOiBbODA4NjphMTMx
XSB0eXBlIDAwIGNsYXNzIDB4MTE4MDAwClsgICAgMC43MzU3NzVdIHBjaSAwMDAwOjAwOjE0
LjI6IHJlZyAweDEwOiBbbWVtIDB4ZWYxNGUwMDAtMHhlZjE0ZWZmZiA2NGJpdF0KWyAgICAw
LjczNTk3MF0gcGNpIDAwMDA6MDA6MTYuMDogWzgwODY6YTEzYV0gdHlwZSAwMCBjbGFzcyAw
eDA3ODAwMApbICAgIDAuNzM1OTk5XSBwY2kgMDAwMDowMDoxNi4wOiByZWcgMHgxMDogW21l
bSAweGVmMTRkMDAwLTB4ZWYxNGRmZmYgNjRiaXRdClsgICAgMC43MzYwODFdIHBjaSAwMDAw
OjAwOjE2LjA6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDNob3QKWyAgICAwLjczNjIyM10gcGNp
IDAwMDA6MDA6MTcuMDogWzgwODY6MjgyMl0gdHlwZSAwMCBjbGFzcyAweDAxMDQwMApbICAg
IDAuNzM2MjUxXSBwY2kgMDAwMDowMDoxNy4wOiByZWcgMHgxMDogW21lbSAweGVmMTQ4MDAw
LTB4ZWYxNDlmZmZdClsgICAgMC43MzYyNjJdIHBjaSAwMDAwOjAwOjE3LjA6IHJlZyAweDE0
OiBbbWVtIDB4ZWYxNGMwMDAtMHhlZjE0YzBmZl0KWyAgICAwLjczNjI3M10gcGNpIDAwMDA6
MDA6MTcuMDogcmVnIDB4MTg6IFtpbyAgMHhmMDkwLTB4ZjA5N10KWyAgICAwLjczNjI4NF0g
cGNpIDAwMDA6MDA6MTcuMDogcmVnIDB4MWM6IFtpbyAgMHhmMDgwLTB4ZjA4M10KWyAgICAw
LjczNjI5NV0gcGNpIDAwMDA6MDA6MTcuMDogcmVnIDB4MjA6IFtpbyAgMHhmMDYwLTB4ZjA3
Zl0KWyAgICAwLjczNjMwNl0gcGNpIDAwMDA6MDA6MTcuMDogcmVnIDB4MjQ6IFttZW0gMHhl
ZjE0YjAwMC0weGVmMTRiN2ZmXQpbICAgIDAuNzM2MzY4XSBwY2kgMDAwMDowMDoxNy4wOiBQ
TUUjIHN1cHBvcnRlZCBmcm9tIEQzaG90ClsgICAgMC43MzY0ODhdIHBjaSAwMDAwOjAwOjFj
LjA6IFs4MDg2OmExMTBdIHR5cGUgMDEgY2xhc3MgMHgwNjA0MDAKWyAgICAwLjczNjU5NV0g
cGNpIDAwMDA6MDA6MWMuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQK
WyAgICAwLjczNjc2MV0gcGNpIDAwMDA6MDA6MWYuMDogWzgwODY6YTE0OV0gdHlwZSAwMCBj
bGFzcyAweDA2MDEwMApbICAgIDAuNzM2OTUwXSBwY2kgMDAwMDowMDoxZi4yOiBbODA4Njph
MTIxXSB0eXBlIDAwIGNsYXNzIDB4MDU4MDAwClsgICAgMC43MzY5NzBdIHBjaSAwMDAwOjAw
OjFmLjI6IHJlZyAweDEwOiBbbWVtIDB4ZWYxNDQwMDAtMHhlZjE0N2ZmZl0KWyAgICAwLjcz
NzE2MF0gcGNpIDAwMDA6MDA6MWYuMzogWzgwODY6YTE3MF0gdHlwZSAwMCBjbGFzcyAweDA0
MDMwMApbICAgIDAuNzM3MjAyXSBwY2kgMDAwMDowMDoxZi4zOiByZWcgMHgxMDogW21lbSAw
eGVmMTQwMDAwLTB4ZWYxNDNmZmYgNjRiaXRdClsgICAgMC43MzcyNTBdIHBjaSAwMDAwOjAw
OjFmLjM6IHJlZyAweDIwOiBbbWVtIDB4ZWYxMjAwMDAtMHhlZjEyZmZmZiA2NGJpdF0KWyAg
ICAwLjczNzMxOF0gcGNpIDAwMDA6MDA6MWYuMzogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEM2hv
dCBEM2NvbGQKWyAgICAwLjczNzQ4NV0gcGNpIDAwMDA6MDA6MWYuNDogWzgwODY6YTEyM10g
dHlwZSAwMCBjbGFzcyAweDBjMDUwMApbICAgIDAuNzM3NTQ0XSBwY2kgMDAwMDowMDoxZi40
OiByZWcgMHgxMDogW21lbSAweGVmMTRhMDAwLTB4ZWYxNGEwZmYgNjRiaXRdClsgICAgMC43
Mzc2MTRdIHBjaSAwMDAwOjAwOjFmLjQ6IHJlZyAweDIwOiBbaW8gIDB4ZjA0MC0weGYwNWZd
ClsgICAgMC43Mzc3ODhdIHBjaSAwMDAwOjAwOjFmLjY6IFs4MDg2OjE1YjddIHR5cGUgMDAg
Y2xhc3MgMHgwMjAwMDAKWyAgICAwLjczNzgyNl0gcGNpIDAwMDA6MDA6MWYuNjogcmVnIDB4
MTA6IFttZW0gMHhlZjEwMDAwMC0weGVmMTFmZmZmXQpbICAgIDAuNzM3OTg0XSBwY2kgMDAw
MDowMDoxZi42OiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAu
NzM4MTEzXSBwY2kgMDAwMDowMTowMC4wOiBbMTAwMjo2N2M3XSB0eXBlIDAwIGNsYXNzIDB4
MDMwMDAwClsgICAgMC43MzgxMzBdIHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDEwOiBbbWVt
IDB4ZDAwMDAwMDAtMHhkZmZmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNzM4MTM3XSBwY2kg
MDAwMDowMTowMC4wOiByZWcgMHgxODogW21lbSAweGUwMDAwMDAwLTB4ZTAxZmZmZmYgNjRi
aXQgcHJlZl0KWyAgICAwLjczODE0Ml0gcGNpIDAwMDA6MDE6MDAuMDogcmVnIDB4MjA6IFtp
byAgMHhlMDAwLTB4ZTBmZl0KWyAgICAwLjczODE0Nl0gcGNpIDAwMDA6MDE6MDAuMDogcmVn
IDB4MjQ6IFttZW0gMHhlZjAwMDAwMC0weGVmMDNmZmZmXQpbICAgIDAuNzM4MTUxXSBwY2kg
MDAwMDowMTowMC4wOiByZWcgMHgzMDogW21lbSAweGVmMDQwMDAwLTB4ZWYwNWZmZmYgcHJl
Zl0KWyAgICAwLjczODE5M10gcGNpIDAwMDA6MDE6MDAuMDogc3VwcG9ydHMgRDEgRDIKWyAg
ICAwLjczODE5NF0gcGNpIDAwMDA6MDE6MDAuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMSBE
MiBEM2hvdCBEM2NvbGQKWyAgICAwLjczODI0MV0gcGNpIDAwMDA6MDE6MDAuMTogWzEwMDI6
YWFmMF0gdHlwZSAwMCBjbGFzcyAweDA0MDMwMApbICAgIDAuNzM4MjU0XSBwY2kgMDAwMDow
MTowMC4xOiByZWcgMHgxMDogW21lbSAweGVmMDYwMDAwLTB4ZWYwNjNmZmYgNjRiaXRdClsg
ICAgMC43MzgzMDddIHBjaSAwMDAwOjAxOjAwLjE6IHN1cHBvcnRzIEQxIEQyClsgICAgMC43
MzgzNTZdIHBjaSAwMDAwOjAwOjAxLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMV0KWyAgICAw
LjczODk4MF0gcGNpIDAwMDA6MDA6MDEuMDogICBicmlkZ2Ugd2luZG93IFtpbyAgMHhlMDAw
LTB4ZWZmZl0KWyAgICAwLjczODk4MV0gcGNpIDAwMDA6MDA6MDEuMDogICBicmlkZ2Ugd2lu
ZG93IFttZW0gMHhlZjAwMDAwMC0weGVmMGZmZmZmXQpbICAgIDAuNzM4OTg0XSBwY2kgMDAw
MDowMDowMS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGQwMDAwMDAwLTB4ZTAxZmZmZmYg
NjRiaXQgcHJlZl0KWyAgICAwLjczOTA0NV0gcGNpIDAwMDA6MDI6MDAuMDogWzEwNGM6ODI0
MF0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMApbICAgIDAuNzM5MTc1XSBwY2kgMDAwMDowMjow
MC4wOiBzdXBwb3J0cyBEMSBEMgpbICAgIDAuNzM5MjcyXSBwY2kgMDAwMDowMDoxYy4wOiBQ
Q0kgYnJpZGdlIHRvIFtidXMgMDItMDNdClsgICAgMC43Mzk5NjVdIHBjaV9idXMgMDAwMDow
MzogZXh0ZW5kZWQgY29uZmlnIHNwYWNlIG5vdCBhY2Nlc3NpYmxlClsgICAgMC43NDAyODNd
IHBjaSAwMDAwOjAyOjAwLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAwM10KWyAgICAwLjc0MjI3
OV0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktBXSAoSVJRcyAzIDQgNSA2IDEwICox
MSAxMiAxNCAxNSkKWyAgICAwLjc0MzA5OV0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtM
TktCXSAoSVJRcyAzIDQgNSA2ICoxMCAxMSAxMiAxNCAxNSkKWyAgICAwLjc0NDI1N10gQUNQ
STogUENJIEludGVycnVwdCBMaW5rIFtMTktDXSAoSVJRcyAzIDQgNSA2IDEwICoxMSAxMiAx
NCAxNSkKWyAgICAwLjc0NTA3NF0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktEXSAo
SVJRcyAzIDQgNSA2IDEwICoxMSAxMiAxNCAxNSkKWyAgICAwLjc0NTI1Nl0gQUNQSTogUENJ
IEludGVycnVwdCBMaW5rIFtMTktFXSAoSVJRcyAzIDQgNSA2IDEwICoxMSAxMiAxNCAxNSkK
WyAgICAwLjc0NjA3Ml0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktGXSAoSVJRcyAz
IDQgNSA2IDEwICoxMSAxMiAxNCAxNSkKWyAgICAwLjc0NzI1NV0gQUNQSTogUENJIEludGVy
cnVwdCBMaW5rIFtMTktHXSAoSVJRcyAzIDQgNSA2IDEwICoxMSAxMiAxNCAxNSkKWyAgICAw
Ljc0ODA3MV0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktIXSAoSVJRcyAzIDQgNSA2
IDEwICoxMSAxMiAxNCAxNSkKWyAgICAwLjc0OTc5M10gcGNpIDAwMDA6MDE6MDAuMDogdmdh
YXJiOiBzZXR0aW5nIGFzIGJvb3QgVkdBIGRldmljZQpbICAgIDAuNzUwMjE5XSBwY2kgMDAw
MDowMTowMC4wOiB2Z2FhcmI6IFZHQSBkZXZpY2UgYWRkZWQ6IGRlY29kZXM9aW8rbWVtLG93
bnM9aW8rbWVtLGxvY2tzPW5vbmUKWyAgICAwLjc1MTIyMV0gcGNpIDAwMDA6MDE6MDAuMDog
dmdhYXJiOiBicmlkZ2UgY29udHJvbCBwb3NzaWJsZQpbICAgIDAuNzUxOTA1XSB2Z2FhcmI6
IGxvYWRlZApbICAgIDAuNzUyMjU2XSBTQ1NJIHN1YnN5c3RlbSBpbml0aWFsaXplZApbICAg
IDAuNzUzMjgyXSBsaWJhdGEgdmVyc2lvbiAzLjAwIGxvYWRlZC4KWyAgICAwLjc1MzI4Ml0g
QUNQSTogYnVzIHR5cGUgVVNCIHJlZ2lzdGVyZWQKWyAgICAwLjc1MzI4Ml0gdXNiY29yZTog
cmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2JmcwpbICAgIDAuNzUzODk5XSB1
c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIGh1YgpbICAgIDAuNzU1
MTc3XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBkZXZpY2UgZHJpdmVyIHVzYgpbICAgIDAu
NzU1MTc3XSBwcHNfY29yZTogTGludXhQUFMgQVBJIHZlci4gMSByZWdpc3RlcmVkClsgICAg
MC43NTYyMjBdIHBwc19jb3JlOiBTb2Z0d2FyZSB2ZXIuIDUuMy42IC0gQ29weXJpZ2h0IDIw
MDUtMjAwNyBSb2RvbGZvIEdpb21ldHRpIDxnaW9tZXR0aUBsaW51eC5pdD4KWyAgICAwLjc1
NzIyMV0gUFRQIGNsb2NrIHN1cHBvcnQgcmVnaXN0ZXJlZApbICAgIDAuNzU4MDc4XSBFREFD
IE1DOiBWZXI6IDMuMC4wClsgICAgMC43NTg2MzFdIEFkdmFuY2VkIExpbnV4IFNvdW5kIEFy
Y2hpdGVjdHVyZSBEcml2ZXIgSW5pdGlhbGl6ZWQuClsgICAgMC43NTkwMjBdIFBDSTogVXNp
bmcgQUNQSSBmb3IgSVJRIHJvdXRpbmcKWyAgICAwLjc3Mjk5OF0gUENJOiBwY2lfY2FjaGVf
bGluZV9zaXplIHNldCB0byA2NCBieXRlcwpbICAgIDAuNzczMDQ1XSBlODIwOiByZXNlcnZl
IFJBTSBidWZmZXIgW21lbSAweDAwMDkwNDAwLTB4MDAwOWZmZmZdClsgICAgMC43NzMwNDZd
IGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4YWJjNjgwMDAtMHhhYmZmZmZmZl0K
WyAgICAwLjc3MzA0N10gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHhiYTAwZTAw
MC0weGJiZmZmZmZmXQpbICAgIDAuNzczMDQ3XSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIg
W21lbSAweGJjNjAwMDAwLTB4YmZmZmZmZmZdClsgICAgMC43NzMwNDhdIGU4MjA6IHJlc2Vy
dmUgUkFNIGJ1ZmZlciBbbWVtIDB4ODNlMDAwMDAwLTB4ODNmZmZmZmZmXQpbICAgIDAuNzcz
ODIyXSBocGV0MDogYXQgTU1JTyAweGZlZDAwMDAwLCBJUlFzIDIsIDgsIDAsIDAsIDAsIDAs
IDAsIDAKWyAgICAwLjc3NDIyMV0gaHBldDA6IDggY29tcGFyYXRvcnMsIDY0LWJpdCAyNC4w
MDAwMDAgTUh6IGNvdW50ZXIKWyAgICAwLjc3NzIzMF0gY2xvY2tzb3VyY2U6IFN3aXRjaGVk
IHRvIGNsb2Nrc291cmNlIHRzYy1lYXJseQpbICAgIDAuNzg1MTI1XSBWRlM6IERpc2sgcXVv
dGFzIGRxdW90XzYuNi4wClsgICAgMC43ODU2NzNdIFZGUzogRHF1b3QtY2FjaGUgaGFzaCB0
YWJsZSBlbnRyaWVzOiA1MTIgKG9yZGVyIDAsIDQwOTYgYnl0ZXMpClsgICAgMC43ODY0Njld
IEZTLUNhY2hlOiBMb2FkZWQKWyAgICAwLjc5MDIyNV0gQ2FjaGVGaWxlczogTG9hZGVkClsg
ICAgMC43OTA2OTldIHBucDogUG5QIEFDUEkgaW5pdApbICAgIDAuNzkxMzA2XSBzeXN0ZW0g
MDA6MDA6IFtpbyAgMHgwYTAwLTB4MGEzZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjc5
MjAwOF0gc3lzdGVtIDAwOjAwOiBbaW8gIDB4MGE0MC0weDBhN2ZdIGhhcyBiZWVuIHJlc2Vy
dmVkClsgICAgMC43OTI3MTJdIHN5c3RlbSAwMDowMDogUGx1ZyBhbmQgUGxheSBBQ1BJIGRl
dmljZSwgSURzIFBOUDBjMDIgKGFjdGl2ZSkKWyAgICAwLjc5MzE5OF0gcG5wIDAwOjAxOiBb
ZG1hIDAgZGlzYWJsZWRdClsgICAgMC43OTMyMjhdIHBucCAwMDowMTogUGx1ZyBhbmQgUGxh
eSBBQ1BJIGRldmljZSwgSURzIFBOUDA1MDEgKGFjdGl2ZSkKWyAgICAwLjc5MzI1Nl0gcG5w
IDAwOjAyOiBQbHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNlLCBJRHMgUE5QMDMwMyBQTlAwMzBi
IChhY3RpdmUpClsgICAgMC43OTMyODRdIHBucCAwMDowMzogUGx1ZyBhbmQgUGxheSBBQ1BJ
IGRldmljZSwgSURzIFBOUDBmMDMgUE5QMGYxMyAoYWN0aXZlKQpbICAgIDAuNzkzMzY1XSBz
eXN0ZW0gMDA6MDQ6IFtpbyAgMHgwNjgwLTB4MDY5Zl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAg
ICAwLjc5NDA2OF0gc3lzdGVtIDAwOjA0OiBbaW8gIDB4ZmZmZl0gaGFzIGJlZW4gcmVzZXJ2
ZWQKWyAgICAwLjc5NDcyMl0gc3lzdGVtIDAwOjA0OiBbaW8gIDB4ZmZmZl0gaGFzIGJlZW4g
cmVzZXJ2ZWQKWyAgICAwLjc5NTM3NV0gc3lzdGVtIDAwOjA0OiBbaW8gIDB4ZmZmZl0gaGFz
IGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjc5NjAyNV0gc3lzdGVtIDAwOjA0OiBbaW8gIDB4MTgw
MC0weDE4ZmVdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC43OTY3MjddIHN5c3RlbSAwMDow
NDogW2lvICAweDE2NGUtMHgxNjRmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNzk3NDMw
XSBzeXN0ZW0gMDA6MDQ6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwYzAy
IChhY3RpdmUpClsgICAgMC43OTc0ODldIHN5c3RlbSAwMDowNTogW2lvICAweDA4MDAtMHgw
ODdmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNzk4MTg5XSBzeXN0ZW0gMDA6MDU6IFBs
dWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwYzAyIChhY3RpdmUpClsgICAgMC43
OTgyMDFdIHBucCAwMDowNjogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBi
MDAgKGFjdGl2ZSkKWyAgICAwLjc5ODIyNF0gc3lzdGVtIDAwOjA3OiBbaW8gIDB4MTg1NC0w
eDE4NTddIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC43OTg5MjddIHN5c3RlbSAwMDowNzog
UGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIElOVDNmMGQgUE5QMGMwMiAoYWN0aXZl
KQpbICAgIDAuNzk5MDcwXSBzeXN0ZW0gMDA6MDg6IFttZW0gMHhmZWQxMDAwMC0weGZlZDE3
ZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNzk5ODI4XSBzeXN0ZW0gMDA6MDg6IFtt
ZW0gMHhmZWQxODAwMC0weGZlZDE4ZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuODAw
NTg0XSBzeXN0ZW0gMDA6MDg6IFttZW0gMHhmZWQxOTAwMC0weGZlZDE5ZmZmXSBoYXMgYmVl
biByZXNlcnZlZApbICAgIDAuODAxMzQxXSBzeXN0ZW0gMDA6MDg6IFttZW0gMHhmMDAwMDAw
MC0weGY3ZmZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuODAyMDk5XSBzeXN0ZW0g
MDA6MDg6IFttZW0gMHhmZWQyMDAwMC0weGZlZDNmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApb
ICAgIDAuODAyODU3XSBzeXN0ZW0gMDA6MDg6IFttZW0gMHhmZWQ5MDAwMC0weGZlZDkzZmZm
XSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuODAzNjE0XSBzeXN0ZW0gMDA6MDg6IFttZW0g
MHhmZWQ0NTAwMC0weGZlZDhmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuODA0Mzc0
XSBzeXN0ZW0gMDA6MDg6IFttZW0gMHhmZjAwMDAwMC0weGZmZmZmZmZmXSBoYXMgYmVlbiBy
ZXNlcnZlZApbICAgIDAuODA1MTMxXSBzeXN0ZW0gMDA6MDg6IFttZW0gMHhmZWUwMDAwMC0w
eGZlZWZmZmZmXSBjb3VsZCBub3QgYmUgcmVzZXJ2ZWQKWyAgICAwLjgwNTkxOF0gc3lzdGVt
IDAwOjA4OiBbbWVtIDB4ZWZmZTAwMDAtMHhlZmZmZmZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQK
WyAgICAwLjgwNjY4MF0gc3lzdGVtIDAwOjA4OiBQbHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNl
LCBJRHMgUE5QMGMwMiAoYWN0aXZlKQpbICAgIDAuODA2NzA2XSBzeXN0ZW0gMDA6MDk6IFtt
ZW0gMHhmZDAwMDAwMC0weGZkYWJmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuODA3
NDY2XSBzeXN0ZW0gMDA6MDk6IFttZW0gMHhmZGFkMDAwMC0weGZkYWRmZmZmXSBoYXMgYmVl
biByZXNlcnZlZApbICAgIDAuODA4MjI0XSBzeXN0ZW0gMDA6MDk6IFttZW0gMHhmZGIwMDAw
MC0weGZkZmZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuODA4OTgyXSBzeXN0ZW0g
MDA6MDk6IFttZW0gMHhmZTAwMDAwMC0weGZlMDFmZmZmXSBjb3VsZCBub3QgYmUgcmVzZXJ2
ZWQKWyAgICAwLjgwOTc2OV0gc3lzdGVtIDAwOjA5OiBbbWVtIDB4ZmUwMzYwMDAtMHhmZTAz
YmZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjgxMDUyN10gc3lzdGVtIDAwOjA5OiBb
bWVtIDB4ZmUwM2QwMDAtMHhmZTNmZmZmZl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjgx
MTI4Nl0gc3lzdGVtIDAwOjA5OiBbbWVtIDB4ZmU0MTAwMDAtMHhmZTdmZmZmZl0gaGFzIGJl
ZW4gcmVzZXJ2ZWQKWyAgICAwLjgxMjA0NF0gc3lzdGVtIDAwOjA5OiBQbHVnIGFuZCBQbGF5
IEFDUEkgZGV2aWNlLCBJRHMgUE5QMGMwMiAoYWN0aXZlKQpbICAgIDAuODEyMjQzXSBzeXN0
ZW0gMDA6MGE6IFtpbyAgMHhmZjAwLTB4ZmZmZV0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAw
LjgxMjk0M10gc3lzdGVtIDAwOjBhOiBQbHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNlLCBJRHMg
UE5QMGMwMiAoYWN0aXZlKQpbICAgIDAuODEzNzE4XSBzeXN0ZW0gMDA6MGI6IFttZW0gMHhm
ZGFmMDAwMC0weGZkYWZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuODE0NDc2XSBz
eXN0ZW0gMDA6MGI6IFttZW0gMHhmZGFlMDAwMC0weGZkYWVmZmZmXSBoYXMgYmVlbiByZXNl
cnZlZApbICAgIDAuODE1MjMxXSBzeXN0ZW0gMDA6MGI6IFttZW0gMHhmZGFjMDAwMC0weGZk
YWNmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuODE1OTg4XSBzeXN0ZW0gMDA6MGI6
IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwYzAyIChhY3RpdmUpClsgICAg
MC44MTY1NzRdIHBucDogUG5QIEFDUEk6IGZvdW5kIDEyIGRldmljZXMKWyAgICAwLjgyMjMx
NV0gY2xvY2tzb3VyY2U6IGFjcGlfcG06IG1hc2s6IDB4ZmZmZmZmIG1heF9jeWNsZXM6IDB4
ZmZmZmZmLCBtYXhfaWRsZV9uczogMjA4NTcwMTAyNCBucwpbICAgIDAuODIzMzk1XSBwY2kg
MDAwMDowMDowMS4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDFdClsgICAgMC44MjQwMjBdIHBj
aSAwMDAwOjAwOjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4ZTAwMC0weGVmZmZdClsg
ICAgMC44MjQ3MzZdIHBjaSAwMDAwOjAwOjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4
ZWYwMDAwMDAtMHhlZjBmZmZmZl0KWyAgICAwLjgyNTUxMF0gcGNpIDAwMDA6MDA6MDEuMDog
ICBicmlkZ2Ugd2luZG93IFttZW0gMHhkMDAwMDAwMC0weGUwMWZmZmZmIDY0Yml0IHByZWZd
ClsgICAgMC44MjY0NzddIHBjaSAwMDAwOjAyOjAwLjA6IFBDSSBicmlkZ2UgdG8gW2J1cyAw
M10KWyAgICAwLjgyNzExNF0gcGNpIDAwMDA6MDA6MWMuMDogUENJIGJyaWRnZSB0byBbYnVz
IDAyLTAzXQpbICAgIDAuODI3Nzc0XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDQgW2lv
ICAweDAwMDAtMHgwY2Y3IHdpbmRvd10KWyAgICAwLjgyNzc3NV0gcGNpX2J1cyAwMDAwOjAw
OiByZXNvdXJjZSA1IFtpbyAgMHgwZDAwLTB4ZmZmZiB3aW5kb3ddClsgICAgMC44Mjc3NzZd
IHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgNiBbbWVtIDB4MDAwYTAwMDAtMHgwMDBiZmZm
ZiB3aW5kb3ddClsgICAgMC44Mjc3NzddIHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgNyBb
bWVtIDB4YzAwMDAwMDAtMHhlZmZmZmZmZiB3aW5kb3ddClsgICAgMC44Mjc3NzhdIHBjaV9i
dXMgMDAwMDowMDogcmVzb3VyY2UgOCBbbWVtIDB4ZmQwMDAwMDAtMHhmZTdmZmZmZiB3aW5k
b3ddClsgICAgMC44Mjc3NzldIHBjaV9idXMgMDAwMDowMTogcmVzb3VyY2UgMCBbaW8gIDB4
ZTAwMC0weGVmZmZdClsgICAgMC44Mjc3NzldIHBjaV9idXMgMDAwMDowMTogcmVzb3VyY2Ug
MSBbbWVtIDB4ZWYwMDAwMDAtMHhlZjBmZmZmZl0KWyAgICAwLjgyNzc4MF0gcGNpX2J1cyAw
MDAwOjAxOiByZXNvdXJjZSAyIFttZW0gMHhkMDAwMDAwMC0weGUwMWZmZmZmIDY0Yml0IHBy
ZWZdClsgICAgMC44Mjc4NzZdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMgpb
ICAgIDAuODI4NTMwXSB0Y3BfbGlzdGVuX3BvcnRhZGRyX2hhc2ggaGFzaCB0YWJsZSBlbnRy
aWVzOiAxNjM4NCAob3JkZXI6IDYsIDI2MjE0NCBieXRlcykKWyAgICAwLjgyOTU2OV0gVENQ
IGVzdGFibGlzaGVkIGhhc2ggdGFibGUgZW50cmllczogMjYyMTQ0IChvcmRlcjogOSwgMjA5
NzE1MiBieXRlcykKWyAgICAwLjgzMDcwMV0gVENQIGJpbmQgaGFzaCB0YWJsZSBlbnRyaWVz
OiA2NTUzNiAob3JkZXI6IDgsIDEwNDg1NzYgYnl0ZXMpClsgICAgMC44MzE1MzhdIFRDUDog
SGFzaCB0YWJsZXMgY29uZmlndXJlZCAoZXN0YWJsaXNoZWQgMjYyMTQ0IGJpbmQgNjU1MzYp
ClsgICAgMC44MzIzMTldIFVEUCBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjog
NywgNTI0Mjg4IGJ5dGVzKQpbICAgIDAuODMzMDg3XSBVRFAtTGl0ZSBoYXNoIHRhYmxlIGVu
dHJpZXM6IDE2Mzg0IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzKQpbICAgIDAuODM0ODcyXSBw
Y2kgMDAwMDowMTowMC4wOiBWaWRlbyBkZXZpY2Ugd2l0aCBzaGFkb3dlZCBST00gYXQgW21l
bSAweDAwMGMwMDAwLTB4MDAwZGZmZmZdClsgICAgMC44MzU4ODddIHBjaSAwMDAwOjAxOjAw
LjE6IExpbmtlZCBhcyBhIGNvbnN1bWVyIHRvIDAwMDA6MDE6MDAuMApbICAgIDAuODM2NjEx
XSBQQ0k6IENMUyAwIGJ5dGVzLCBkZWZhdWx0IDY0ClsgICAgMC44MzY2NDldIFRyeWluZyB0
byB1bnBhY2sgcm9vdGZzIGltYWdlIGFzIGluaXRyYW1mcy4uLgpbICAgIDAuODk0MTI2XSBG
cmVlaW5nIGluaXRyZCBtZW1vcnk6IDUxMzZLClsgICAgMC44OTQ2NzJdIFBDSS1ETUE6IFVz
aW5nIHNvZnR3YXJlIGJvdW5jZSBidWZmZXJpbmcgZm9yIElPIChTV0lPVExCKQpbICAgIDAu
ODk1NDE3XSBzb2Z0d2FyZSBJTyBUTEI6IG1hcHBlZCBbbWVtIDB4YjYwMGUwMDAtMHhiYTAw
ZTAwMF0gKDY0TUIpClsgICAgMC44OTYyNDldIFJBUEwgUE1VOiBBUEkgdW5pdCBpcyAyXi0z
MiBKb3VsZXMsIDUgZml4ZWQgY291bnRlcnMsIDY1NTM2MCBtcyBvdmZsIHRpbWVyClsgICAg
MC44OTcyMjhdIFJBUEwgUE1VOiBodyB1bml0IG9mIGRvbWFpbiBwcDAtY29yZSAyXi0xNCBK
b3VsZXMKWyAgICAwLjg5NzkxNF0gUkFQTCBQTVU6IGh3IHVuaXQgb2YgZG9tYWluIHBhY2th
Z2UgMl4tMTQgSm91bGVzClsgICAgMC44OTg1OTNdIFJBUEwgUE1VOiBodyB1bml0IG9mIGRv
bWFpbiBkcmFtIDJeLTE0IEpvdWxlcwpbICAgIDAuODk5MjUxXSBSQVBMIFBNVTogaHcgdW5p
dCBvZiBkb21haW4gcHAxLWdwdSAyXi0xNCBKb3VsZXMKWyAgICAwLjg5OTkzMF0gUkFQTCBQ
TVU6IGh3IHVuaXQgb2YgZG9tYWluIHBzeXMgMl4tMTQgSm91bGVzClsgICAgMC45MDA2OTld
IGNsb2Nrc291cmNlOiB0c2M6IG1hc2s6IDB4ZmZmZmZmZmZmZmZmZmZmZiBtYXhfY3ljbGVz
OiAweDMzZTQ1MmZiYjJmLCBtYXhfaWRsZV9uczogNDQwNzk1MjM2NTkzIG5zClsgICAgMC45
MDE4NTRdIGNsb2Nrc291cmNlOiBTd2l0Y2hlZCB0byBjbG9ja3NvdXJjZSB0c2MKWyAgICAw
LjkwMjg2OV0gd29ya2luZ3NldDogdGltZXN0YW1wX2JpdHM9NDAgbWF4X29yZGVyPTIzIGJ1
Y2tldF9vcmRlcj0wClsgICAgMC45MDM4MDBdIFNHSSBYRlMgd2l0aCBBQ0xzLCBzZWN1cml0
eSBhdHRyaWJ1dGVzLCByZWFsdGltZSwgbm8gZGVidWcgZW5hYmxlZApbICAgIDAuOTA1MDE4
XSBCbG9jayBsYXllciBTQ1NJIGdlbmVyaWMgKGJzZykgZHJpdmVyIHZlcnNpb24gMC40IGxv
YWRlZCAobWFqb3IgMjQ5KQpbICAgIDAuOTA1OTczXSBpbyBzY2hlZHVsZXIgbm9vcCByZWdp
c3RlcmVkClsgICAgMC45MDY1MTNdIGlvIHNjaGVkdWxlciBkZWFkbGluZSByZWdpc3RlcmVk
ClsgICAgMC45MDcwODRdIGlvIHNjaGVkdWxlciBjZnEgcmVnaXN0ZXJlZCAoZGVmYXVsdCkK
WyAgICAwLjkwNzY4OF0gaW8gc2NoZWR1bGVyIG1xLWRlYWRsaW5lIHJlZ2lzdGVyZWQKWyAg
ICAwLjkwODI3N10gaW8gc2NoZWR1bGVyIGt5YmVyIHJlZ2lzdGVyZWQKWyAgICAwLjkwOTE1
Nl0gcGNpZXBvcnQgMDAwMDowMDoxYy4wOiBBRVIgZW5hYmxlZCB3aXRoIElSUSAxMjAKWyAg
ICAwLjkwOTg0NF0gdmVyc2lvbiAzOS4yClsgICAgMC45MTAyNzNdIGlwbWkgZGV2aWNlIGlu
dGVyZmFjZQpbICAgIDAuOTEwNzY2XSBJUE1JIFN5c3RlbSBJbnRlcmZhY2UgZHJpdmVyLgpb
ICAgIDAuOTExMzMyXSBpcG1pX3NpOiBVbmFibGUgdG8gZmluZCBhbnkgU3lzdGVtIEludGVy
ZmFjZShzKQpbICAgIDAuOTEyMDAzXSBJUE1JIFdhdGNoZG9nOiBkcml2ZXIgaW5pdGlhbGl6
ZWQKWyAgICAwLjkxMjU3NV0gQ29weXJpZ2h0IChDKSAyMDA0IE1vbnRhVmlzdGEgU29mdHdh
cmUgLSBJUE1JIFBvd2VyZG93biB2aWEgc3lzX3JlYm9vdC4KWyAgICAwLjkxMzU4NF0gaW5w
dXQ6IFNsZWVwIEJ1dHRvbiBhcyAvZGV2aWNlcy9MTlhTWVNUTTowMC9MTlhTWUJVUzowMC9Q
TlAwQzBFOjAwL2lucHV0L2lucHV0MApbICAgIDAuOTE0NjAxXSBBQ1BJOiBTbGVlcCBCdXR0
b24gW1NMUEJdClsgICAgMC45MTUxMzRdIGlucHV0OiBQb3dlciBCdXR0b24gYXMgL2Rldmlj
ZXMvTE5YU1lTVE06MDAvTE5YU1lCVVM6MDAvUE5QMEMwQzowMC9pbnB1dC9pbnB1dDEKWyAg
ICAwLjkxNjE0OF0gQUNQSTogUG93ZXIgQnV0dG9uIFtQV1JCXQpbICAgIDAuOTE2Njg0XSBp
bnB1dDogUG93ZXIgQnV0dG9uIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFBXUkJOOjAw
L2lucHV0L2lucHV0MgpbICAgIDAuOTE3NjI1XSBBQ1BJOiBQb3dlciBCdXR0b24gW1BXUkZd
ClsgICAgMC45NDk1NzFdIE1vbml0b3ItTXdhaXQgd2lsbCBiZSB1c2VkIHRvIGVudGVyIEMt
MSBzdGF0ZQpbICAgIDAuOTQ5NTc0XSBNb25pdG9yLU13YWl0IHdpbGwgYmUgdXNlZCB0byBl
bnRlciBDLTIgc3RhdGUKWyAgICAwLjk0OTU3OF0gTW9uaXRvci1Nd2FpdCB3aWxsIGJlIHVz
ZWQgdG8gZW50ZXIgQy0zIHN0YXRlClsgICAgMC45ODA1NTJdIHRoZXJtYWwgTE5YVEhFUk06
MDA6IHJlZ2lzdGVyZWQgYXMgdGhlcm1hbF96b25lMApbICAgIDAuOTgxMjM3XSBBQ1BJOiBU
aGVybWFsIFpvbmUgW1RaMDBdICgyOCBDKQpbICAgIDAuOTgxOTEzXSB0aGVybWFsIExOWFRI
RVJNOjAxOiByZWdpc3RlcmVkIGFzIHRoZXJtYWxfem9uZTEKWyAgICAwLjk4MjU5NV0gQUNQ
STogVGhlcm1hbCBab25lIFtUWjAxXSAoMzAgQykKWyAgICAwLjk4MzI4OF0gU2VyaWFsOiA4
MjUwLzE2NTUwIGRyaXZlciwgNCBwb3J0cywgSVJRIHNoYXJpbmcgZGlzYWJsZWQKWyAgICAx
LjAwNTA2M10gMDA6MDE6IHR0eVMwIGF0IEkvTyAweDNmOCAoaXJxID0gNCwgYmFzZV9iYXVk
ID0gMTE1MjAwKSBpcyBhIDE2NTUwQQpbICAgIDEuMDA2NTk1XSBscDogZHJpdmVyIGxvYWRl
ZCBidXQgbm8gZGV2aWNlcyBmb3VuZApbICAgIDEuMDA3Mzk0XSBMaW51eCBhZ3BnYXJ0IGlu
dGVyZmFjZSB2MC4xMDMKWyAgICAxLjAxMDQyM10gYnJkOiBtb2R1bGUgbG9hZGVkClsgICAg
MS4wMTIxMDFdIGxvb3A6IG1vZHVsZSBsb2FkZWQKWyAgICAxLjAxNTgxOV0gZHJiZDogaW5p
dGlhbGl6ZWQuIFZlcnNpb246IDguNC4xMCAoYXBpOjEvcHJvdG86ODYtMTAxKQpbICAgIDEu
MDE2NTUxXSBkcmJkOiBidWlsdC1pbgpbICAgIDEuMDE2OTkwXSBkcmJkOiByZWdpc3RlcmVk
IGFzIGJsb2NrIGRldmljZSBtYWpvciAxNDcKWyAgICAxLjAxNzY1MF0gVW5pZm9ybSBNdWx0
aS1QbGF0Zm9ybSBFLUlERSBkcml2ZXIKWyAgICAxLjAxODcxN10gaWRlX2dlbmVyaWM6IHBs
ZWFzZSB1c2UgInByb2JlX21hc2s9MHgzZiIgbW9kdWxlIHBhcmFtZXRlciBmb3IgcHJvYmlu
ZyBhbGwgbGVnYWN5IElTQSBJREUgcG9ydHMKWyAgICAxLjAxOTg0M10gUHJvYmluZyBJREUg
aW50ZXJmYWNlIGlkZTAuLi4KWyAgICAxLjU0MjQ2M10gaWRlMCBhdCAweDFmMC0weDFmNyww
eDNmNiBvbiBpcnEgMTQKWyAgICAxLjU0MzA2MF0gUHJvYmluZyBJREUgaW50ZXJmYWNlIGlk
ZTEuLi4KWyAgICAyLjA2NTQ2MV0gaWRlMSBhdCAweDE3MC0weDE3NywweDM3NiBvbiBpcnEg
MTUKWyAgICAyLjA2NjA1N10gaWRlLWdkIGRyaXZlciAxLjE4ClsgICAgMi4wNjY1MzFdIGlk
ZS1jZCBkcml2ZXIgNS4wMApbICAgIDIuMDY3MTI4XSBtZWdhcmFpZCBjbW06IDIuMjAuMi43
IChSZWxlYXNlIERhdGU6IFN1biBKdWwgMTYgMDA6MDE6MDMgRVNUIDIwMDYpClsgICAgMi4w
NjgxMTRdIG1lZ2FyYWlkOiAyLjIwLjUuMSAoUmVsZWFzZSBEYXRlOiBUaHUgTm92IDE2IDE1
OjMyOjM1IEVTVCAyMDA2KQpbICAgIDIuMDY4OTA5XSBtZWdhc2FzOiAwNy43MDYuMDMuMDAt
cmMxClsgICAgMi4wNjk0MzVdIG1wdDNzYXMgdmVyc2lvbiAyNi4xMDAuMDAuMDAgbG9hZGVk
ClsgICAgMi4wNzAzMTFdIGFoY2kgMDAwMDowMDoxNy4wOiB2ZXJzaW9uIDMuMApbICAgIDIu
MDcwNDE4XSBhaGNpIDAwMDA6MDA6MTcuMDogY29udHJvbGxlciBjYW4ndCBkbyBTTlRGLCB0
dXJuaW5nIG9mZiBDQVBfU05URgpbICAgIDIuMDgxNDM5XSBhaGNpIDAwMDA6MDA6MTcuMDog
QUhDSSAwMDAxLjAzMDEgMzIgc2xvdHMgNCBwb3J0cyA2IEdicHMgMHhmIGltcGwgUkFJRCBt
b2RlClsgICAgMi4wODI0MzZdIGFoY2kgMDAwMDowMDoxNy4wOiBmbGFnczogNjRiaXQgbmNx
IHBtIGxlZCBjbG8gb25seSBwaW8gc2x1bSBwYXJ0IGVtcyBkZXNvIHNhZG0gc2RzIGFwc3Qg
ClsgICAgMi4wOTI3MjVdIHNjc2kgaG9zdDA6IGFoY2kKWyAgICAyLjA5MzQ0Nl0gc2NzaSBo
b3N0MTogYWhjaQpbICAgIDIuMDk0MTEwXSBzY3NpIGhvc3QyOiBhaGNpClsgICAgMi4wOTQ4
MjRdIHNjc2kgaG9zdDM6IGFoY2kKWyAgICAyLjA5NTMxN10gYXRhMTogU0FUQSBtYXggVURN
QS8xMzMgYWJhciBtMjA0OEAweGVmMTRiMDAwIHBvcnQgMHhlZjE0YjEwMCBpcnEgMTIxClsg
ICAgMi4wOTYyNjBdIGF0YTI6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTIwNDhAMHhlZjE0
YjAwMCBwb3J0IDB4ZWYxNGIxODAgaXJxIDEyMQpbICAgIDIuMDk3MjAzXSBhdGEzOiBTQVRB
IG1heCBVRE1BLzEzMyBhYmFyIG0yMDQ4QDB4ZWYxNGIwMDAgcG9ydCAweGVmMTRiMjAwIGly
cSAxMjEKWyAgICAyLjA5ODE0N10gYXRhNDogU0FUQSBtYXggVURNQS8xMzMgYWJhciBtMjA0
OEAweGVmMTRiMDAwIHBvcnQgMHhlZjE0YjI4MCBpcnEgMTIxClsgICAgMi4wOTkyNjJdIHR1
bjogVW5pdmVyc2FsIFRVTi9UQVAgZGV2aWNlIGRyaXZlciwgMS42ClsgICAgMi4xMDAwMDJd
IGJueDJ4OiBRTG9naWMgNTc3MXgvNTc4eHggMTAvMjAtR2lnYWJpdCBFdGhlcm5ldCBEcml2
ZXIgYm54MnggMS43MTIuMzAtMCAoMjAxNC8wMi8xMCkKWyAgICAyLjEwMTIxM10gZTEwMDog
SW50ZWwoUikgUFJPLzEwMCBOZXR3b3JrIERyaXZlciwgMy41LjI0LWsyLU5BUEkKWyAgICAy
LjEwMTkzMl0gZTEwMDogQ29weXJpZ2h0KGMpIDE5OTktMjAwNiBJbnRlbCBDb3Jwb3JhdGlv
bgpbICAgIDIuMTAyNjA1XSBlMTAwMDogSW50ZWwoUikgUFJPLzEwMDAgTmV0d29yayBEcml2
ZXIgLSB2ZXJzaW9uIDcuMy4yMS1rOC1OQVBJClsgICAgMi4xMDMzOTddIGUxMDAwOiBDb3B5
cmlnaHQgKGMpIDE5OTktMjAwNiBJbnRlbCBDb3Jwb3JhdGlvbi4KWyAgICAyLjEwNDA5MF0g
ZTEwMDBlOiBJbnRlbChSKSBQUk8vMTAwMCBOZXR3b3JrIERyaXZlciAtIDMuMi42LWsKWyAg
ICAyLjEwNDc4Nl0gZTEwMDBlOiBDb3B5cmlnaHQoYykgMTk5OSAtIDIwMTUgSW50ZWwgQ29y
cG9yYXRpb24uClsgICAgMi4xMDU2MjddIGUxMDAwZSAwMDAwOjAwOjFmLjY6IEludGVycnVw
dCBUaHJvdHRsaW5nIFJhdGUgKGludHMvc2VjKSBzZXQgdG8gZHluYW1pYyBjb25zZXJ2YXRp
dmUgbW9kZQpbICAgIDIuNDA5NTQyXSBhdGEzOiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyA0
IFNDb250cm9sIDMwMCkKWyAgICAyLjQxMDIxOV0gYXRhNDogU0FUQSBsaW5rIGRvd24gKFNT
dGF0dXMgNCBTQ29udHJvbCAzMDApClsgICAgMi40MTA4OTddIGF0YTE6IFNBVEEgbGluayB1
cCA2LjAgR2JwcyAoU1N0YXR1cyAxMzMgU0NvbnRyb2wgMzAwKQpbICAgIDIuNDExNjMyXSBh
dGEyOiBTQVRBIGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEzIFNDb250cm9sIDMwMCkK
WyAgICAyLjQxMjcxOF0gYXRhMS4wMDogQVRBLTg6IFRPU0hJQkEgRFQwMUFDQTA1MCwgTVMx
T0E4MTAsIG1heCBVRE1BLzEzMwpbICAgIDIuNDEzNDcxXSBhdGExLjAwOiA5NzY3NzMxNjgg
c2VjdG9ycywgbXVsdGkgMTY6IExCQTQ4IE5DUSAoZGVwdGggMzIpLCBBQQpbICAgIDIuNDE0
MjU3XSBhdGEyLjAwOiBBVEFQSTogSEwtRFQtU1QgRFZEKy8tUlcgR0hCME4sIEExQzAsIG1h
eCBVRE1BLzEwMApbICAgIDIuNDE1NzIwXSBhdGExLjAwOiBjb25maWd1cmVkIGZvciBVRE1B
LzEzMwpbICAgIDIuNDE2Mjk1XSBhdGEyLjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEwMApb
ICAgIDIuNTE0MzA3XSBlMTAwMGUgMDAwMDowMDoxZi42IDAwMDA6MDA6MWYuNiAodW5pbml0
aWFsaXplZCk6IHJlZ2lzdGVyZWQgUEhDIGNsb2NrClsgICAgMi41OTY2MTBdIGUxMDAwZSAw
MDAwOjAwOjFmLjYgZXRoMDogKFBDSSBFeHByZXNzOjIuNUdUL3M6V2lkdGggeDEpIGQ4Ojll
OmYzOjM3OjE3OjNjClsgICAgMi41OTc1OTJdIGUxMDAwZSAwMDAwOjAwOjFmLjYgZXRoMDog
SW50ZWwoUikgUFJPLzEwMDAgTmV0d29yayBDb25uZWN0aW9uClsgICAgMi41OTg0MzNdIGUx
MDAwZSAwMDAwOjAwOjFmLjYgZXRoMDogTUFDOiAxMiwgUEhZOiAxMiwgUEJBIE5vOiBGRkZG
RkYtMEZGClsgICAgMi41OTkyMjddIGlnYjogSW50ZWwoUikgR2lnYWJpdCBFdGhlcm5ldCBO
ZXR3b3JrIERyaXZlciAtIHZlcnNpb24gNS40LjAtawpbICAgIDIuNjAwMDEyXSBpZ2I6IENv
cHlyaWdodCAoYykgMjAwNy0yMDE0IEludGVsIENvcnBvcmF0aW9uLgpbICAgIDIuNjAwNjk4
XSBpZ2J2ZjogSW50ZWwoUikgR2lnYWJpdCBWaXJ0dWFsIEZ1bmN0aW9uIE5ldHdvcmsgRHJp
dmVyIC0gdmVyc2lvbiAyLjQuMC1rClsgICAgMi42MDE2NzBdIGlnYnZmOiBDb3B5cmlnaHQg
KGMpIDIwMDkgLSAyMDEyIEludGVsIENvcnBvcmF0aW9uLgpbICAgIDIuNjAyMzg0XSBza3ky
OiBkcml2ZXIgdmVyc2lvbiAxLjMwClsgICAgMi42MDI5NjZdIEZ1c2lvbiBNUFQgYmFzZSBk
cml2ZXIgMy4wNC4yMApbICAgIDIuNjAzNTIwXSBDb3B5cmlnaHQgKGMpIDE5OTktMjAwOCBM
U0kgQ29ycG9yYXRpb24KWyAgICAyLjYwNDEzOF0gRnVzaW9uIE1QVCBTUEkgSG9zdCBkcml2
ZXIgMy4wNC4yMApbICAgIDIuNjA0NzI3XSBGdXNpb24gTVBUIEZDIEhvc3QgZHJpdmVyIDMu
MDQuMjAKWyAgICAyLjYwNTMxMF0gRnVzaW9uIE1QVCBTQVMgSG9zdCBkcml2ZXIgMy4wNC4y
MApbICAgIDIuNjA1ODk3XSBGdXNpb24gTVBUIG1pc2MgZGV2aWNlIChpb2N0bCkgZHJpdmVy
IDMuMDQuMjAKWyAgICAyLjYwNjYzOF0gbXB0Y3RsOiBSZWdpc3RlcmVkIHdpdGggRnVzaW9u
IE1QVCBiYXNlIGRyaXZlcgpbICAgIDIuNjA3MzA3XSBtcHRjdGw6IC9kZXYvbXB0Y3RsIEAg
KG1ham9yLG1pbm9yPTEwLDIyMCkKWyAgICAyLjYwNzk0N10gZWhjaV9oY2Q6IFVTQiAyLjAg
J0VuaGFuY2VkJyBIb3N0IENvbnRyb2xsZXIgKEVIQ0kpIERyaXZlcgpbICAgIDIuNjExOTU0
XSBlaGNpLXBjaTogRUhDSSBQQ0kgcGxhdGZvcm0gZHJpdmVyClsgICAgMi42MTI1NDRdIG9o
Y2lfaGNkOiBVU0IgMS4xICdPcGVuJyBIb3N0IENvbnRyb2xsZXIgKE9IQ0kpIERyaXZlcgpb
ICAgIDIuNjEzMjY4XSBvaGNpLXBjaTogT0hDSSBQQ0kgcGxhdGZvcm0gZHJpdmVyClsgICAg
Mi42MTM4NTRdIHVoY2lfaGNkOiBVU0IgVW5pdmVyc2FsIEhvc3QgQ29udHJvbGxlciBJbnRl
cmZhY2UgZHJpdmVyClsgICAgMi42MTQ3MjVdIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDogeEhD
SSBIb3N0IENvbnRyb2xsZXIKWyAgICAyLjYxNTM3M10geGhjaV9oY2QgMDAwMDowMDoxNC4w
OiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDEKWyAgICAy
LjYxNzQxOV0geGhjaV9oY2QgMDAwMDowMDoxNC4wOiBoY2MgcGFyYW1zIDB4MjAwMDc3YzEg
aGNpIHZlcnNpb24gMHgxMDAgcXVpcmtzIDB4MDAwMDAwMDAwMTEwOTgxMApbICAgIDIuNjE4
NTAwXSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IGNhY2hlIGxpbmUgc2l6ZSBvZiA2NCBpcyBu
b3Qgc3VwcG9ydGVkClsgICAgMi42MTg4MDFdIGh1YiAxLTA6MS4wOiBVU0IgaHViIGZvdW5k
ClsgICAgMi42MTkzNjFdIGh1YiAxLTA6MS4wOiAxNiBwb3J0cyBkZXRlY3RlZApbICAgIDIu
NjIwODMzXSB4aGNpX2hjZCAwMDAwOjAwOjE0LjA6IHhIQ0kgSG9zdCBDb250cm9sbGVyClsg
ICAgMi42MjE0ODJdIHhoY2lfaGNkIDAwMDA6MDA6MTQuMDogbmV3IFVTQiBidXMgcmVnaXN0
ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAyClsgICAgMi42MjI0MThdIHhoY2lfaGNkIDAw
MDA6MDA6MTQuMDogSG9zdCBzdXBwb3J0cyBVU0IgMy4wICBTdXBlclNwZWVkClsgICAgMi42
MjMzMDNdIGh1YiAyLTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgMi42MjM4NTBdIGh1YiAy
LTA6MS4wOiAxMCBwb3J0cyBkZXRlY3RlZApbICAgIDIuNjI0Nzg2XSB1c2I6IHBvcnQgcG93
ZXIgbWFuYWdlbWVudCBtYXkgYmUgdW5yZWxpYWJsZQpbICAgIDIuNjI1NzQ5XSB1c2Jjb3Jl
OiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYi1zdG9yYWdlClsgICAgMi42
MjY0NjldIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgZnRkaV9z
aW8KWyAgICAyLjYyNzE1N10gdXNic2VyaWFsOiBVU0IgU2VyaWFsIHN1cHBvcnQgcmVnaXN0
ZXJlZCBmb3IgRlRESSBVU0IgU2VyaWFsIERldmljZQpbICAgIDIuNjI4MDk5XSB1c2Jjb3Jl
OiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIG9tbmluZXQKWyAgICAyLjYyODc4
MF0gdXNic2VyaWFsOiBVU0IgU2VyaWFsIHN1cHBvcnQgcmVnaXN0ZXJlZCBmb3IgWnlYRUwg
LSBvbW5pLm5ldCBsY2QgcGx1cyB1c2IKWyAgICAyLjYyOTc3NV0gaTgwNDI6IFBOUDogUFMv
MiBDb250cm9sbGVyIFtQTlAwMzAzOlBTMkssUE5QMGYwMzpQUzJNXSBhdCAweDYwLDB4NjQg
aXJxIDEsMTIKWyAgICAyLjYzMzQ2OV0gc2VyaW86IGk4MDQyIEtCRCBwb3J0IGF0IDB4NjAs
MHg2NCBpcnEgMQpbICAgIDIuNjM0MDk1XSBzZXJpbzogaTgwNDIgQVVYIHBvcnQgYXQgMHg2
MCwweDY0IGlycSAxMgpbICAgIDIuNjM1MDQ5XSBydGNfY21vcyAwMDowNjogUlRDIGNhbiB3
YWtlIGZyb20gUzQKWyAgICAyLjYzNjExMF0gcnRjX2Ntb3MgMDA6MDY6IHJlZ2lzdGVyZWQg
YXMgcnRjMApbICAgIDIuNjM2NzAxXSBydGNfY21vcyAwMDowNjogYWxhcm1zIHVwIHRvIG9u
ZSBtb250aCwgeTNrLCAyNDIgYnl0ZXMgbnZyYW0sIGhwZXQgaXJxcwpbICAgIDIuNjM3ODIz
XSBpODAxX3NtYnVzIDAwMDA6MDA6MWYuNDogU1BEIFdyaXRlIERpc2FibGUgaXMgc2V0Clsg
ICAgMi42Mzg1NTBdIGk4MDFfc21idXMgMDAwMDowMDoxZi40OiBTTUJ1cyB1c2luZyBQQ0kg
aW50ZXJydXB0ClsgICAgMi42NDA2MTFdIGlUQ09fd2R0OiBJbnRlbCBUQ08gV2F0Y2hEb2cg
VGltZXIgRHJpdmVyIHYxLjExClsgICAgMi42NDEzODBdIGlUQ09fd2R0OiBGb3VuZCBhIElu
dGVsIFBDSCBUQ08gZGV2aWNlIChWZXJzaW9uPTQsIFRDT0JBU0U9MHgwNDAwKQpbICAgIDIu
NjQyNDg5XSBpVENPX3dkdDogaW5pdGlhbGl6ZWQuIGhlYXJ0YmVhdD0zMCBzZWMgKG5vd2F5
b3V0PTApClsgICAgMi42NDMyMDVdIGlUQ09fdmVuZG9yX3N1cHBvcnQ6IHZlbmRvci1zdXBw
b3J0PTAKWyAgICAyLjY0MzgxOF0gbnZfdGNvOiBOViBUQ08gV2F0Y2hEb2cgVGltZXIgRHJp
dmVyIHYwLjAxClsgICAgMi42NDQ2ODRdIGludGVsX3BzdGF0ZTogSW50ZWwgUC1zdGF0ZSBk
cml2ZXIgaW5pdGlhbGl6aW5nClsgICAgMi42NDUzOTZdIGludGVsX3BzdGF0ZTogRGlzYWJs
aW5nIGVuZXJneSBlZmZpY2llbmN5IG9wdGltaXphdGlvbgpbICAgIDIuNjQ3NzA3XSBpbnRl
bF9wc3RhdGU6IEhXUCBlbmFibGVkClsgICAgMi42NDgyNTldIGhpZHJhdzogcmF3IEhJRCBl
dmVudHMgZHJpdmVyIChDKSBKaXJpIEtvc2luYQpbICAgIDIuNjQ5MDMyXSB1c2Jjb3JlOiBy
ZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYmhpZApbICAgIDIuNjQ5NzQwXSB1
c2JoaWQ6IFVTQiBISUQgY29yZSBkcml2ZXIKWyAgICAyLjY1MDYzNF0gc25kX2hkYV9pbnRl
bCAwMDAwOjAxOjAwLjE6IEhhbmRsZSB2Z2Ffc3dpdGNoZXJvbyBhdWRpbyBjbGllbnQKWyAg
ICAyLjY1MTUwMl0gc25kX2hkYV9pbnRlbCAwMDAwOjAxOjAwLjE6IEZvcmNlIHRvIG5vbi1z
bm9vcCBtb2RlClsgICAgMi42NTI5MjNdIEtleSB0eXBlIGRuc19yZXNvbHZlciByZWdpc3Rl
cmVkClsgICAgMi42NTQxODFdIG1pY3JvY29kZTogc2lnPTB4OTA2ZTksIHBmPTB4MiwgcmV2
aXNpb249MHg4ZQpbICAgIDIuNjU1MzMzXSBtaWNyb2NvZGU6IE1pY3JvY29kZSBVcGRhdGUg
RHJpdmVyOiB2Mi4yLgpbICAgIDIuNjU1MzQxXSBzY2hlZF9jbG9jazogTWFya2luZyBzdGFi
bGUgKDI1NTc0MjkwMzgsIDk3OTAwOTc3KS0+KDI2NjU1NTYzOTUsIC0xMDIyNjM4MCkKWyAg
ICAyLjY1NzEwN10gcmVnaXN0ZXJlZCB0YXNrc3RhdHMgdmVyc2lvbiAxClsgICAgMi42NTg1
NDFdIHJ0Y19jbW9zIDAwOjA2OiBzZXR0aW5nIHN5c3RlbSBjbG9jayB0byAyMDE5LTAzLTA2
IDEyOjI0OjAyIFVUQyAoMTU1MTg3NTA0MikKWyAgICAyLjY1OTYwM10gQUxTQSBkZXZpY2Ug
bGlzdDoKWyAgICAyLjY2MDA2Nl0gICBObyBzb3VuZGNhcmRzIGZvdW5kLgpbICAgIDIuNjYx
MTA1XSBpbnB1dDogSERBIEFUSSBIRE1JIEhETUkvRFAscGNtPTMgYXMgL2RldmljZXMvcGNp
MDAwMDowMC8wMDAwOjAwOjAxLjAvMDAwMDowMTowMC4xL3NvdW5kL2NhcmQxL2lucHV0NApb
ICAgIDIuNjYyNDEwXSBpbnB1dDogSERBIEFUSSBIRE1JIEhETUkvRFAscGNtPTcgYXMgL2Rl
dmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjAxLjAvMDAwMDowMTowMC4xL3NvdW5kL2NhcmQx
L2lucHV0NQpbICAgIDIuNjYzNjc5XSBpbnB1dDogSERBIEFUSSBIRE1JIEhETUkvRFAscGNt
PTggYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjAxLjAvMDAwMDowMTowMC4xL3Nv
dW5kL2NhcmQxL2lucHV0NgpbICAgIDIuNjY0OTQ3XSBpbnB1dDogSERBIEFUSSBIRE1JIEhE
TUkvRFAscGNtPTkgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjAxLjAvMDAwMDow
MTowMC4xL3NvdW5kL2NhcmQxL2lucHV0NwpbICAgIDIuNjY2MTg1XSBpbnB1dDogSERBIEFU
SSBIRE1JIEhETUkvRFAscGNtPTEwIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDow
MS4wLzAwMDA6MDE6MDAuMS9zb3VuZC9jYXJkMS9pbnB1dDgKWyAgICAyLjY2NzQ5NF0gaW5w
dXQ6IEhEQSBBVEkgSERNSSBIRE1JL0RQLHBjbT0xMSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAw
LzAwMDA6MDA6MDEuMC8wMDAwOjAxOjAwLjEvc291bmQvY2FyZDEvaW5wdXQ5ClsgICAgMi45
NDE0MzFdIHVzYiAxLTI6IG5ldyBmdWxsLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDIgdXNp
bmcgeGhjaV9oY2QKWyAgICAzLjA3MDE5OF0gdXNiIDEtMjogY29uZmlnIDEgaW50ZXJmYWNl
IDAgYWx0c2V0dGluZyAwIGhhcyAyIGVuZHBvaW50IGRlc2NyaXB0b3JzLCBkaWZmZXJlbnQg
ZnJvbSB0aGUgaW50ZXJmYWNlIGRlc2NyaXB0b3IncyB2YWx1ZTogMQpbICAgIDMuMTg4NDMz
XSB1c2IgMS00OiBuZXcgbG93LXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDMgdXNpbmcgeGhj
aV9oY2QKWyAgICAzLjMyODU5N10gaW5wdXQ6IERlbGwgRGVsbCBVU0IgRW50cnkgS2V5Ym9h
cmQgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjE0LjAvdXNiMS8xLTQvMS00OjEu
MC8wMDAzOjQxM0M6MjEwNy4wMDAyL2lucHV0L2lucHV0MTIKWyAgICAzLjM4MTY1NV0gaGlk
LWdlbmVyaWMgMDAwMzo0MTNDOjIxMDcuMDAwMjogaW5wdXQsaGlkcmF3MDogVVNCIEhJRCB2
MS4xMCBLZXlib2FyZCBbRGVsbCBEZWxsIFVTQiBFbnRyeSBLZXlib2FyZF0gb24gdXNiLTAw
MDA6MDA6MTQuMC00L2lucHV0MApbICAgIDMuNDk2NDMwXSB1c2IgMS01OiBuZXcgbG93LXNw
ZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDQgdXNpbmcgeGhjaV9oY2QKWyAgICAzLjYzMTM4OF0g
aW5wdXQ6IExvZ2l0ZWNoIFVTQiBPcHRpY2FsIE1vdXNlIGFzIC9kZXZpY2VzL3BjaTAwMDA6
MDAvMDAwMDowMDoxNC4wL3VzYjEvMS01LzEtNToxLjAvMDAwMzowNDZEOkMwNUEuMDAwMy9p
bnB1dC9pbnB1dDEzClsgICAgMy42MzI5MTZdIGhpZC1nZW5lcmljIDAwMDM6MDQ2RDpDMDVB
LjAwMDM6IGlucHV0LGhpZHJhdzE6IFVTQiBISUQgdjEuMTEgTW91c2UgW0xvZ2l0ZWNoIFVT
QiBPcHRpY2FsIE1vdXNlXSBvbiB1c2ItMDAwMDowMDoxNC4wLTUvaW5wdXQwClsgICAgNC4w
NTE0ODhdIGZsb3BweTA6IG5vIGZsb3BweSBjb250cm9sbGVycyBmb3VuZApbICAgIDQuMDUy
MzE1XSBzY3NpIDA6MDowOjA6IERpcmVjdC1BY2Nlc3MgICAgIEFUQSAgICAgIFRPU0hJQkEg
RFQwMUFDQTAgQTgxMCBQUTogMCBBTlNJOiA1ClsgICAgNC4wNTM0MjldIHNkIDA6MDowOjA6
IFtzZGFdIDk3Njc3MzE2OCA1MTItYnl0ZSBsb2dpY2FsIGJsb2NrczogKDUwMCBHQi80NjYg
R2lCKQpbICAgIDQuMDUzNDkyXSBzZCAwOjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMg
c2cwIHR5cGUgMApbICAgIDQuMDU0Mzk4XSBzZCAwOjA6MDowOiBbc2RhXSA0MDk2LWJ5dGUg
cGh5c2ljYWwgYmxvY2tzClsgICAgNC4wNTU3NTZdIHNkIDA6MDowOjA6IFtzZGFdIFdyaXRl
IFByb3RlY3QgaXMgb2ZmClsgICAgNC4wNTYyMzFdIHNjc2kgMTowOjA6MDogQ0QtUk9NICAg
ICAgICAgICAgSEwtRFQtU1QgRFZEKy1SVyBHSEIwTiAgICBBMUMwIFBROiAwIEFOU0k6IDUK
WyAgICA0LjA1NjQwNV0gc2QgMDowOjA6MDogW3NkYV0gTW9kZSBTZW5zZTogMDAgM2EgMDAg
MDAKWyAgICA0LjA1NzQyM10gc2QgMDowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJs
ZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBClsg
ICAgNC4wODEyMDhdICBzZGE6IHNkYTEgc2RhMiBzZGEzClsgICAgNC4wODIxMzZdIHNkIDA6
MDowOjA6IFtzZGFdIEF0dGFjaGVkIFNDU0kgZGlzawpbICAgIDQuMTA1Mzk3XSBzciAxOjA6
MDowOiBbc3IwXSBzY3NpMy1tbWMgZHJpdmU6IDQ4eC8xMnggd3JpdGVyIGR2ZC1yYW0gY2Qv
cncgeGEvZm9ybTIgY2RkYSB0cmF5ClsgICAgNC4xMDY0NzNdIGNkcm9tOiBVbmlmb3JtIENE
LVJPTSBkcml2ZXIgUmV2aXNpb246IDMuMjAKWyAgICA0LjEwNzI3N10gc3IgMTowOjA6MDog
QXR0YWNoZWQgc2NzaSBDRC1ST00gc3IwClsgICAgNC4xMDczNzNdIHNyIDE6MDowOjA6IEF0
dGFjaGVkIHNjc2kgZ2VuZXJpYyBzZzEgdHlwZSA1ClsgICAgNC4xMDkwNTVdIEZyZWVpbmcg
dW51c2VkIGtlcm5lbCBpbWFnZSBtZW1vcnk6IDE1NjRLClsgICAgNC4xMjA0MzBdIFdyaXRl
IHByb3RlY3RpbmcgdGhlIGtlcm5lbCByZWFkLW9ubHkgZGF0YTogMjA0ODBrClsgICAgNC4x
MjE1NzBdIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBpbWFnZSBtZW1vcnk6IDIwMDhLClsgICAg
NC4xMjIzNzVdIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBpbWFnZSBtZW1vcnk6IDU3NksKWyAg
ICA0LjEyMzA0NV0gUnVuIC9pbml0IGFzIGluaXQgcHJvY2VzcwpbICAgIDQuMTc4MDY5XSBy
YW5kb206IGZhc3QgaW5pdCBkb25lClsgICAgNC40MDg4ODZdIFhGUyAoc2RhMSk6IE1vdW50
aW5nIFY1IEZpbGVzeXN0ZW0KWyAgICA0LjU3MDY4NV0gWEZTIChzZGExKTogRW5kaW5nIGNs
ZWFuIG1vdW50ClsgICAgNS4wNjkzODZdIHJhbmRvbTogY3JuZyBpbml0IGRvbmUKWyAgICA2
LjA3NDU4NV0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxMApbICAgIDYuMDc1
NDM5XSBTZWdtZW50IFJvdXRpbmcgd2l0aCBJUHY2ClsgICAgNi4wODgyMjZdIE5FVDogUmVn
aXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMQpbICAgIDYuMzA5MzE2XSBzeXN0ZW1kWzFdOiBz
eXN0ZW1kIDIzOSBydW5uaW5nIGluIHN5c3RlbSBtb2RlLiAoK1BBTSAtQVVESVQgLVNFTElO
VVggK0lNQSAtQVBQQVJNT1IgK1NNQUNLICtTWVNWSU5JVCArVVRNUCAtTElCQ1JZUFRTRVRV
UCArR0NSWVBUICtHTlVUTFMgK0FDTCArWFogK0xaNCAtU0VDQ09NUCArQkxLSUQgK0VMRlVU
SUxTICtLTU9EIC1JRE4yICtJRE4gLVBDUkUyIGRlZmF1bHQtaGllcmFyY2h5PWh5YnJpZCkK
WyAgICA2LjMyMzgzNF0gc3lzdGVtZFsxXTogRGV0ZWN0ZWQgYXJjaGl0ZWN0dXJlIHg4Ni02
NC4KWyAgICA2LjM2NDUyMl0gc3lzdGVtZFsxXTogU2V0IGhvc3RuYW1lIHRvIDxpbmJldHdl
ZW5tb3ZlLm1vbGdlbi5tcGcuZGU+LgpbICAgIDYuODY4NTgwXSBzeXN0ZW1kWzFdOiBGaWxl
IC9saWIvc3lzdGVtZC9zeXN0ZW0vc3lzdGVtZC1qb3VybmFsZC5zZXJ2aWNlOjM2IGNvbmZp
Z3VyZXMgYW4gSVAgZmlyZXdhbGwgKElQQWRkcmVzc0Rlbnk9YW55KSwgYnV0IHRoZSBsb2Nh
bCBzeXN0ZW0gZG9lcyBub3Qgc3VwcG9ydCBCUEYvY2dyb3VwIGJhc2VkIGZpcmV3YWxsaW5n
LgpbICAgIDYuODcwNDgzXSBzeXN0ZW1kWzFdOiBQcm9jZWVkaW5nIFdJVEhPVVQgZmlyZXdh
bGxpbmcgaW4gZWZmZWN0ISAoVGhpcyB3YXJuaW5nIGlzIG9ubHkgc2hvd24gZm9yIHRoZSBm
aXJzdCBsb2FkZWQgdW5pdCB1c2luZyBJUCBmaXJld2FsbGluZy4pClsgICAgNy4yODQ0MDld
IHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiBQcm9jZXNzIENvcmUgRHVtcCBTb2NrZXQuClsg
ICAgNy4yODU5MDJdIHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiBpbml0Y3RsIENvbXBhdGli
aWxpdHkgTmFtZWQgUGlwZS4KWyAgICA3LjI4NzQzNF0gc3lzdGVtZFsxXTogUmVhY2hlZCB0
YXJnZXQgUmVtb3RlIEZpbGUgU3lzdGVtcy4KWyAgICA3LjI4ODkxM10gc3lzdGVtZFsxXTog
U3RhcnRlZCBEaXNwYXRjaCBQYXNzd29yZCBSZXF1ZXN0cyB0byBDb25zb2xlIERpcmVjdG9y
eSBXYXRjaC4KWyAgICA3LjI5MDcwNF0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIEpvdXJu
YWwgU29ja2V0ICgvZGV2L2xvZykuClsgICAgOC4wNTI4NzRdIFJQQzogUmVnaXN0ZXJlZCBu
YW1lZCBVTklYIHNvY2tldCB0cmFuc3BvcnQgbW9kdWxlLgpbICAgIDguMDU2OTQ4XSBSUEM6
IFJlZ2lzdGVyZWQgdWRwIHRyYW5zcG9ydCBtb2R1bGUuClsgICAgOC4wNTc1ODBdIFJQQzog
UmVnaXN0ZXJlZCB0Y3AgdHJhbnNwb3J0IG1vZHVsZS4KWyAgICA4LjA1ODIwNl0gUlBDOiBS
ZWdpc3RlcmVkIHRjcCBORlN2NC4xIGJhY2tjaGFubmVsIHRyYW5zcG9ydCBtb2R1bGUuClsg
ICAgOC41MzE1NjBdIEluc3RhbGxpbmcga25mc2QgKGNvcHlyaWdodCAoQykgMTk5NiBva2ly
QG1vbmFkLnN3Yi5kZSkuClsgICAgOS4xMDA4ODFdIHN5c3RlbWQtam91cm5hbGRbMTYxXTog
UmVjZWl2ZWQgcmVxdWVzdCB0byBmbHVzaCBydW50aW1lIGpvdXJuYWwgZnJvbSBQSUQgMQpb
ICAgIDkuOTQ0MDUzXSB3bWlfYnVzIHdtaV9idXMtUE5QMEMxNDowMTogV1FCQyBkYXRhIGJs
b2NrIHF1ZXJ5IGNvbnRyb2wgbWV0aG9kIG5vdCBmb3VuZApbICAgMTAuMDMzMzc2XSBBQ1BJ
OiBWaWRlbyBEZXZpY2UgW0dGWDBdIChtdWx0aS1oZWFkOiB5ZXMgIHJvbTogbm8gIHBvc3Q6
IG5vKQpbICAgMTAuMDM0MzkzXSBpbnB1dDogVmlkZW8gQnVzIGFzIC9kZXZpY2VzL0xOWFNZ
U1RNOjAwL0xOWFNZQlVTOjAwL1BOUDBBMDg6MDAvTE5YVklERU86MDAvaW5wdXQvaW5wdXQx
NApbICAgMTEuMTg5ODk4XSBoaWQtbGVkIDAwMDM6MjdCODowMUVELjAwMDE6IGhpZHJhdzI6
IFVTQiBISUQgdjEuMDEgRGV2aWNlIFtUaGluZ00gYmxpbmsoMSkgbWsyXSBvbiB1c2ItMDAw
MDowMDoxNC4wLTIvaW5wdXQwClsgICAxMS4xOTEyMDZdIGhpZC1sZWQgMDAwMzoyN0I4OjAx
RUQuMDAwMTogVGhpbmdNIGJsaW5rKDEpIGluaXRpYWxpemVkClsgICAxMy4xMzk0MjldIHNu
ZF9oZGFfaW50ZWwgMDAwMDowMDoxZi4zOiBjb3VsZG4ndCBiaW5kIHdpdGggYXVkaW8gY29t
cG9uZW50ClsgICAxMy4xNTAxNjldIHNuZF9oZGFfY29kZWNfcmVhbHRlayBoZGF1ZGlvQzBE
MDogYXV0b2NvbmZpZyBmb3IgQUxDMzg2MTogbGluZV9vdXRzPTEgKDB4MTQvMHgwLzB4MC8w
eDAvMHgwKSB0eXBlOmxpbmUKWyAgIDEzLjE1MTQwNl0gc25kX2hkYV9jb2RlY19yZWFsdGVr
IGhkYXVkaW9DMEQwOiAgICBzcGVha2VyX291dHM9MSAoMHgxNS8weDAvMHgwLzB4MC8weDAp
ClsgICAxMy4xNTI0MTZdIHNuZF9oZGFfY29kZWNfcmVhbHRlayBoZGF1ZGlvQzBEMDogICAg
aHBfb3V0cz0xICgweDFiLzB4MC8weDAvMHgwLzB4MCkKWyAgIDEzLjE1MzQzMF0gc25kX2hk
YV9jb2RlY19yZWFsdGVrIGhkYXVkaW9DMEQwOiAgICBtb25vOiBtb25vX291dD0weDAKWyAg
IDEzLjE1NDE3N10gc25kX2hkYV9jb2RlY19yZWFsdGVrIGhkYXVkaW9DMEQwOiAgICBpbnB1
dHM6ClsgICAxMy4xNTQ4NjRdIHNuZF9oZGFfY29kZWNfcmVhbHRlayBoZGF1ZGlvQzBEMDog
ICAgICBGcm9udCBNaWM9MHgxOQpbICAgMTMuMTU1NjEyXSBzbmRfaGRhX2NvZGVjX3JlYWx0
ZWsgaGRhdWRpb0MwRDA6ICAgICAgUmVhciBNaWM9MHgxOApbICAgMTMuMTY0NzgyXSBzbmRf
aGRhX2NvZGVjX2hkbWkgaGRhdWRpb0MwRDI6IE5vIGk5MTUgYmluZGluZyBmb3IgSW50ZWwg
SERNSS9EUCBjb2RlYwpbICAgMTMuMTY1NzgwXSBoZGF1ZGlvIGhkYXVkaW9DMEQyOiBVbmFi
bGUgdG8gYmluZCB0aGUgY29kZWMKWyAgIDEzLjE2NzE0Nl0gaW5wdXQ6IEhEQSBJbnRlbCBQ
Q0ggRnJvbnQgTWljIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZi4zL3NvdW5k
L2NhcmQwL2lucHV0MTUKWyAgIDEzLjE2ODI5OF0gaW5wdXQ6IEhEQSBJbnRlbCBQQ0ggUmVh
ciBNaWMgYXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFmLjMvc291bmQvY2FyZDAv
aW5wdXQxNgpbICAgMTMuMTY5NDkwXSBpbnB1dDogSERBIEludGVsIFBDSCBMaW5lIE91dCBh
cyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMy9zb3VuZC9jYXJkMC9pbnB1dDE3
ClsgICAxMy4xNzA2NjZdIGlucHV0OiBIREEgSW50ZWwgUENIIEZyb250IEhlYWRwaG9uZSBh
cyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMy9zb3VuZC9jYXJkMC9pbnB1dDE4
ClsgICAxMy44MzA1MDJdIFtkcm1dIFJlcGxhY2luZyBWR0EgY29uc29sZSBkcml2ZXIKWyAg
IDEzLjgzMzk5OV0gQ29uc29sZTogc3dpdGNoaW5nIHRvIGNvbG91ciBkdW1teSBkZXZpY2Ug
ODB4MjUKWyAgIDEzLjgzNTYwNF0gW2RybV0gU3VwcG9ydHMgdmJsYW5rIHRpbWVzdGFtcCBj
YWNoaW5nIFJldiAyICgyMS4xMC4yMDEzKS4KWyAgIDEzLjgzNjE0OV0gW2RybV0gRHJpdmVy
IHN1cHBvcnRzIHByZWNpc2UgdmJsYW5rIHRpbWVzdGFtcCBxdWVyeS4KWyAgIDEzLjgzOTc4
Ml0gW2RybV0gSW5pdGlhbGl6ZWQgaTkxNSAxLjYuMCAyMDE4MDcxOSBmb3IgMDAwMDowMDow
Mi4wIG9uIG1pbm9yIDAKWyAgIDEzLjg1MTYxNF0gW2RybV0gQ2Fubm90IGZpbmQgYW55IGNy
dGMgb3Igc2l6ZXMKWyAgIDEzLjg2MzM5NV0gW2RybV0gQ2Fubm90IGZpbmQgYW55IGNydGMg
b3Igc2l6ZXMKWyAgIDEzLjg3NTE2OV0gW2RybV0gQ2Fubm90IGZpbmQgYW55IGNydGMgb3Ig
c2l6ZXMKWyAgIDEzLjk3Njc5Ml0gW2RybV0gRmluaXNoZWQgbG9hZGluZyBETUMgZmlybXdh
cmUgaTkxNS9rYmxfZG1jX3ZlcjFfMDQuYmluICh2MS40KQpbICAgMTQuODg2NzYxXSBbZHJt
XSBhbWRncHUga2VybmVsIG1vZGVzZXR0aW5nIGVuYWJsZWQuClsgICAxNC44ODc0OTddIFtk
cm1dIGluaXRpYWxpemluZyBrZXJuZWwgbW9kZXNldHRpbmcgKFBPTEFSSVMxMCAweDEwMDI6
MHg2N0M3IDB4MTAyODoweDBCMEQgMHgwMCkuClsgICAxNC44ODgyNTldIFtkcm1dIHJlZ2lz
dGVyIG1taW8gYmFzZTogMHhFRjAwMDAwMApbICAgMTQuODg4Njc0XSBbZHJtXSByZWdpc3Rl
ciBtbWlvIHNpemU6IDI2MjE0NApbICAgMTQuODg5MDM2XSBbZHJtXSBhZGQgaXAgYmxvY2sg
bnVtYmVyIDAgPHZpX2NvbW1vbj4KWyAgIDE0Ljg4OTQ5NV0gW2RybV0gYWRkIGlwIGJsb2Nr
IG51bWJlciAxIDxnbWNfdjhfMD4KWyAgIDE0Ljg4OTkyNl0gW2RybV0gYWRkIGlwIGJsb2Nr
IG51bWJlciAyIDx0b25nYV9paD4KWyAgIDE0Ljg5MDM3N10gW2RybV0gYWRkIGlwIGJsb2Nr
IG51bWJlciAzIDxwb3dlcnBsYXk+ClsgICAxNC44OTA4MTRdIFtkcm1dIGFkZCBpcCBibG9j
ayBudW1iZXIgNCA8ZG0+ClsgICAxNC44OTExNzFdIFtkcm1dIGFkZCBpcCBibG9jayBudW1i
ZXIgNSA8Z2Z4X3Y4XzA+ClsgICAxNC44OTE2MjNdIFtkcm1dIGFkZCBpcCBibG9jayBudW1i
ZXIgNiA8c2RtYV92M18wPgpbICAgMTQuODkyMDYwXSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVt
YmVyIDcgPHV2ZF92Nl8wPgpbICAgMTQuODkyNTEyXSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVt
YmVyIDggPHZjZV92M18wPgpbICAgMTQuODkyOTQ2XSBbZHJtXSBVVkQgaXMgZW5hYmxlZCBp
biBWTSBtb2RlClsgICAxNC44OTMzNDldIFtkcm1dIFVWRCBFTkMgaXMgZW5hYmxlZCBpbiBW
TSBtb2RlClsgICAxNC44OTM3NDNdIFtkcm1dIFZDRSBlbmFibGVkIGluIFZNIG1vZGUKWyAg
IDE0Ljg5NDI3M10gYW1kZ3B1IDAwMDA6MDE6MDAuMDogTm8gbW9yZSBpbWFnZSBpbiB0aGUg
UENJIFJPTQpbICAgMTQuODk0Nzg0XSBBVE9NIEJJT1M6IDExMy1DOTU0MTcwMC0xMDEKWyAg
IDE0Ljg5NTEyMl0gW2RybV0gdm0gc2l6ZSBpcyAxMjggR0IsIDIgbGV2ZWxzLCBibG9jayBz
aXplIGlzIDEwLWJpdCwgZnJhZ21lbnQgc2l6ZSBpcyA5LWJpdApbICAgMTQuOTM5NzQxXSBh
bWRncHUgMDAwMDowMTowMC4wOiBWUkFNOiA4MTkyTSAweDAwMDAwMEY0MDAwMDAwMDAgLSAw
eDAwMDAwMEY1RkZGRkZGRkYgKDgxOTJNIHVzZWQpClsgICAxNC45NDA1MjNdIGFtZGdwdSAw
MDAwOjAxOjAwLjA6IEdBUlQ6IDI1Nk0gMHgwMDAwMDAwMDAwMDAwMDAwIC0gMHgwMDAwMDAw
MDBGRkZGRkZGClsgICAxNC45NDExNTRdIFtkcm1dIERldGVjdGVkIFZSQU0gUkFNPTgxOTJN
LCBCQVI9MjU2TQpbICAgMTQuOTQxNjE0XSBbZHJtXSBSQU0gd2lkdGggMjU2Yml0cyBHRERS
NQpbICAgMTQuOTQyMTE4XSBbVFRNXSBab25lICBrZXJuZWw6IEF2YWlsYWJsZSBncmFwaGlj
cyBtZW1vcnk6IDE2MjcyMjQ4IGtpQgpbICAgMTQuOTQyNzAxXSBbVFRNXSBab25lICAgZG1h
MzI6IEF2YWlsYWJsZSBncmFwaGljcyBtZW1vcnk6IDIwOTcxNTIga2lCClsgICAxNC45NDMy
NjBdIFtUVE1dIEluaXRpYWxpemluZyBwb29sIGFsbG9jYXRvcgpbICAgMTQuOTQzNjU2XSBb
VFRNXSBJbml0aWFsaXppbmcgRE1BIHBvb2wgYWxsb2NhdG9yClsgICAxNC45NDQwNjBdIFtk
cm1dIGFtZGdwdTogODE5Mk0gb2YgVlJBTSBtZW1vcnkgcmVhZHkKWyAgIDE0Ljk0NDUyNl0g
W2RybV0gYW1kZ3B1OiA4MTkyTSBvZiBHVFQgbWVtb3J5IHJlYWR5LgpbICAgMTQuOTQ0OTYw
XSBbZHJtXSBHQVJUOiBudW0gY3B1IHBhZ2VzIDY1NTM2LCBudW0gZ3B1IHBhZ2VzIDY1NTM2
ClsgICAxNC45NDU5NzBdIFtkcm1dIFBDSUUgR0FSVCBvZiAyNTZNIGVuYWJsZWQgKHRhYmxl
IGF0IDB4MDAwMDAwRjQwMDkwMDAwMCkuClsgICAxNC45NjU4NjldIFtkcm1dIENoYWluZWQg
SUIgc3VwcG9ydCBlbmFibGVkIQpbICAgMTQuOTg4NjQ1XSBbZHJtXSBGb3VuZCBVVkQgZmly
bXdhcmUgVmVyc2lvbjogMS4xMzAgRmFtaWx5IElEOiAxNgpbICAgMTQuOTk0Mjg1XSBbZHJt
XSBGb3VuZCBWQ0UgZmlybXdhcmUgVmVyc2lvbjogNTMuMjYgQmluYXJ5IElEOiAzClsgICAx
NS4wNTE5ODldIGFtZGdwdTogW3Bvd2VycGxheV0gRmFpbGVkIHRvIHJldHJpZXZlIG1pbmlt
dW0gY2xvY2tzLgpbICAgMTUuMDUyNTU0XSBhbWRncHU6IFtwb3dlcnBsYXldIEVycm9yIGlu
IHBobV9nZXRfY2xvY2tfaW5mbyAKWyAgIDE1LjA1MzA1Ml0gW2RybV0gRE1fUFBMSUI6IHZh
bHVlcyBmb3IgRW5naW5lIGNsb2NrClsgICAxNS4wNTM1MTJdIFtkcm1dIERNX1BQTElCOgkg
MzAwMDAwClsgICAxNS4wNTM4MzddIFtkcm1dIERNX1BQTElCOgkgNDI2MDAwClsgICAxNS4w
NTQxMzBdIFtkcm1dIERNX1BQTElCOgkgNTgxMDAwClsgICAxNS4wNTQ0NzddIFtkcm1dIERN
X1BQTElCOgkgNzI2MDAwClsgICAxNS4wNTQ3ODZdIFtkcm1dIERNX1BQTElCOgkgODc1MDAw
ClsgICAxNS4wNTUwODBdIFtkcm1dIERNX1BQTElCOgkgOTIyMDAwClsgICAxNS4wNTU0MDhd
IFtkcm1dIERNX1BQTElCOgkgMTAwNDAwMApbICAgMTUuMDU1NzA5XSBbZHJtXSBETV9QUExJ
QjoJIDEwODYwMDAKWyAgIDE1LjA1NjAxMF0gW2RybV0gRE1fUFBMSUI6IFZhbGlkYXRpb24g
Y2xvY2tzOgpbICAgMTUuMDU2NDE2XSBbZHJtXSBETV9QUExJQjogICAgZW5naW5lX21heF9j
bG9jazogMTA4NjAwClsgICAxNS4wNTY4NjVdIFtkcm1dIERNX1BQTElCOiAgICBtZW1vcnlf
bWF4X2Nsb2NrOiAxMjUwMDAKWyAgIDE1LjA1NzM1Ml0gW2RybV0gRE1fUFBMSUI6ICAgIGxl
dmVsICAgICAgICAgICA6IDgKWyAgIDE1LjA1Nzc4Ml0gW2RybV0gRE1fUFBMSUI6IHZhbHVl
cyBmb3IgTWVtb3J5IGNsb2NrClsgICAxNS4wNTgxODddIFtkcm1dIERNX1BQTElCOgkgMzAw
MDAwClsgICAxNS4wNTg1MzRdIFtkcm1dIERNX1BQTElCOgkgMTI1MDAwMApbICAgMTUuMDU4
ODY2XSBbZHJtXSBETV9QUExJQjogVmFsaWRhdGlvbiBjbG9ja3M6ClsgICAxNS4wNTkyMzdd
IFtkcm1dIERNX1BQTElCOiAgICBlbmdpbmVfbWF4X2Nsb2NrOiAxMDg2MDAKWyAgIDE1LjA1
OTcyM10gW2RybV0gRE1fUFBMSUI6ICAgIG1lbW9yeV9tYXhfY2xvY2s6IDEyNTAwMApbICAg
MTUuMDYwMTU1XSBbZHJtXSBETV9QUExJQjogICAgbGV2ZWwgICAgICAgICAgIDogOApbICAg
MTUuMDYxMDIzXSBbZHJtXSBEaXNwbGF5IENvcmUgaW5pdGlhbGl6ZWQgd2l0aCB2My4xLjU5
IQpbICAgMTUuMDcwMjA0XSBbZHJtXSBETV9NU1Q6IERpZmZlcmluZyBNU1Qgc3RhcnQgb24g
YWNvbm5lY3RvcjogMDAwMDAwMDA3NDMyZjgwNSBbaWQ6IDYyXQpbICAgMTUuMDcwOTEzXSBb
ZHJtXSBTdXBwb3J0cyB2YmxhbmsgdGltZXN0YW1wIGNhY2hpbmcgUmV2IDIgKDIxLjEwLjIw
MTMpLgpbICAgMTUuMDcxNTEyXSBbZHJtXSBEcml2ZXIgc3VwcG9ydHMgcHJlY2lzZSB2Ymxh
bmsgdGltZXN0YW1wIHF1ZXJ5LgpbICAgMTUuMTEwNTQ2XSBbZHJtXSBVVkQgYW5kIFVWRCBF
TkMgaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgMTUuMjExNDkxXSBbZHJtXSBWQ0Ug
aW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5LgpbICAgMTUuMjExOTQyXSBbZHJtXSBDYW5ub3Qg
ZmluZCBhbnkgY3J0YyBvciBzaXplcwpbICAgMTUuMjE3ODE4XSBbZHJtXSBJbml0aWFsaXpl
ZCBhbWRncHUgMy4yNy4wIDIwMTUwMTAxIGZvciAwMDAwOjAxOjAwLjAgb24gbWlub3IgMQpb
ICAgMTUuNTI1Mzg3XSBbZHJtXSBETV9NU1Q6IGFkZGVkIGNvbm5lY3RvcjogMDAwMDAwMDAy
ODI3NjIxYyBbaWQ6IDYzXSBbbWFzdGVyOiAwMDAwMDAwMDc0MzJmODA1XQpbICAgMTUuNTg0
NzMzXSBbZHJtXSBETV9NU1Q6IGFkZGVkIGNvbm5lY3RvcjogMDAwMDAwMDAzYzMxYjBjNCBb
aWQ6IDY3XSBbbWFzdGVyOiAwMDAwMDAwMDc0MzJmODA1XQpbICAgMTUuNjM4Nzc2XSBbZHJt
XSBTQURzIGNvdW50IGlzOiAtMiwgZG9uJ3QgbmVlZCB0byByZWFkIGl0ClsgICAxNS42Mzkz
MDNdIFtkcm1dIFNBRHMgY291bnQgaXM6IC0yLCBkb24ndCBuZWVkIHRvIHJlYWQgaXQKWyAg
IDE1LjY0Mjg5NF0gW2RybV0gZmIgbWFwcGFibGUgYXQgMHhEMEUyODAwMApbICAgMTUuNjQz
MjgzXSBbZHJtXSB2cmFtIGFwcGVyIGF0IDB4RDAwMDAwMDAKWyAgIDE1LjY0MzY3Ml0gW2Ry
bV0gc2l6ZSAzMzE3NzYwMApbICAgMTUuNjQzOTM4XSBbZHJtXSBmYiBkZXB0aCBpcyAyNApb
ICAgMTUuNjQ0MjEwXSBbZHJtXSAgICBwaXRjaCBpcyAxNTM2MApbICAgMTUuNjQ0NjMzXSBm
YmNvbjogYW1kZ3B1ZHJtZmIgKGZiMCkgaXMgcHJpbWFyeSBkZXZpY2UKWyAgIDE2LjIwNDA2
N10gQ29uc29sZTogc3dpdGNoaW5nIHRvIGNvbG91ciBmcmFtZSBidWZmZXIgZGV2aWNlIDQ4
MHgxMzUKWyAgIDE2LjIzMDk5OF0gYW1kZ3B1IDAwMDA6MDE6MDAuMDogZmIwOiBhbWRncHVk
cm1mYiBmcmFtZSBidWZmZXIgZGV2aWNlClsgICAxOC41Njk5MzRdIGUxMDAwZSAwMDAwOjAw
OjFmLjYgbmV0MDA6IHJlbmFtZWQgZnJvbSBldGgwClsgICAxOS44MDkxNjNdIDgwMjFxOiA4
MDIuMVEgVkxBTiBTdXBwb3J0IHYxLjgKWyAgIDIxLjI4NTYyMV0gTkZTRDogc3RhcnRpbmcg
OTAtc2Vjb25kIGdyYWNlIHBlcmlvZCAobmV0IGYwMDAwMDk4KQpbICAgMjIuMTg1MTEyXSBY
RlMgKHNkYTIpOiBNb3VudGluZyBWNSBGaWxlc3lzdGVtClsgICAyMi42Nzc2NTJdIGUxMDAw
ZTogbmV0MDAgTklDIExpbmsgaXMgVXAgMTAwMCBNYnBzIEZ1bGwgRHVwbGV4LCBGbG93IENv
bnRyb2w6IFJ4L1R4ClsgICAyMi44MDM5NDddIFhGUyAoc2RhMik6IEVuZGluZyBjbGVhbiBt
b3VudApbICAgMjcuNTAwNjI2XSBGUy1DYWNoZTogTmV0ZnMgJ25mcycgcmVnaXN0ZXJlZCBm
b3IgY2FjaGluZwpbICAgMjcuNzE1NTU0XSBORlM6IFJlZ2lzdGVyaW5nIHRoZSBpZF9yZXNv
bHZlciBrZXkgdHlwZQpbICAgMjcuNzE1NTU4XSBLZXkgdHlwZSBpZF9yZXNvbHZlciByZWdp
c3RlcmVkClsgICAyNy43MTU1NThdIEtleSB0eXBlIGlkX2xlZ2FjeSByZWdpc3RlcmVkClsg
ICA0Mi40NjUwNzRdIGZ1c2UgaW5pdCAoQVBJIHZlcnNpb24gNy4yNykKWyAgIDY3LjQ5NzUz
Ml0gW2RybV0gRE1fTVNUOiBzdG9wcGluZyBUTSBvbiBhY29ubmVjdG9yOiAwMDAwMDAwMDc0
MzJmODA1IFtpZDogNjJdClsgICA2Ny40OTc1OTJdIFtkcm1dIERNX01TVDogRGlzYWJsaW5n
IGNvbm5lY3RvcjogMDAwMDAwMDAyODI3NjIxYyBbaWQ6IDYzXSBbbWFzdGVyOiAwMDAwMDAw
MDc0MzJmODA1XQpbICAgNjcuNDk3NjM5XSBbZHJtXSBETV9NU1Q6IERpc2FibGluZyBjb25u
ZWN0b3I6IDAwMDAwMDAwM2MzMWIwYzQgW2lkOiA2N10gW21hc3RlcjogMDAwMDAwMDA3NDMy
ZjgwNV0KWyAgNzM5LjczMTE5M10gV0FSTklORzogQ1BVOiA2IFBJRDogMTAyMiBhdCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
YzozMTAzIGRtX2NydGNfaGVscGVyX2F0b21pY19jaGVjaysweDQxLzB4NTAgW2FtZGdwdV0K
WyAgNzM5LjczMTE5NF0gTW9kdWxlcyBsaW5rZWQgaW46IGZ1c2UgcnBjc2VjX2dzc19rcmI1
IG5mc3Y0IG5mcyA4MDIxcSBnYXJwIG1ycCBzdHAgbGxjIGFtZGdwdSBpOTE1IGNoYXNoIGdw
dV9zY2hlZCB0dG0gaW9zZl9tYmkgZHJtX2ttc19oZWxwZXIgZHJtIHg4Nl9wa2dfdGVtcF90
aGVybWFsIGt2bV9pbnRlbCBoaWRfbGVkIGt2bSBpbnRlbF9ndHQgaW5wdXRfbGVkcyBmYl9z
eXNfZm9wcyBsZWRfY2xhc3Mgc3lzY29weWFyZWEgc3lzZmlsbHJlY3QgaXJxYnlwYXNzIHN5
c2ltZ2JsdCBjcmMzMmNfaW50ZWwgd21pX2Jtb2YgdmlkZW8gd21pIG5mc2QgYXV0aF9ycGNn
c3Mgb2lkX3JlZ2lzdHJ5IG5mc19hY2wgbG9ja2QgZ3JhY2Ugc3VucnBjIGlwX3RhYmxlcyB4
X3RhYmxlcyB1bml4IGlwdjYgYXV0b2ZzNApbICA3MzkuNzMxMjA5XSBDUFU6IDYgUElEOiAx
MDIyIENvbW06IFhvcmcgS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRlZCA0LjE5LjE5Lm14NjQu
MjQ0ICMxClsgIDczOS43MzEyMTBdIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQcmVjaXNp
b24gVG93ZXIgMzYyMC8wTVdZUFQsIEJJT1MgMi4xMS4wIDA3LzE4LzIwMTgKWyAgNzM5Ljcz
MTIyNV0gUklQOiAwMDEwOmRtX2NydGNfaGVscGVyX2F0b21pY19jaGVjaysweDQxLzB4NTAg
W2FtZGdwdV0KWyAgNzM5LjczMTIyNl0gQ29kZTogNDggOGIgNTIgMjggNDggOGIgYmEgNTgg
YTMgMDAgMDAgZTggMDkgZDYgMDcgMDAgODMgZjggMDEgNzUgMWQgMzEgYzAgYzMgZjYgNDYg
MGEgMGUgNzQgZjcgODAgN2UgMDggMDAgNzQgZjEgODAgN2UgMDkgMDAgNzQgZWIgPDBmPiAw
YiBiOCBlYSBmZiBmZiBmZiBjMyBiOCBlYSBmZiBmZiBmZiBjMyA5MCAwZiAxZiA0NCAwMCAw
MCA0MSA1NwpbICA3MzkuNzMxMjI3XSBSU1A6IDAwMTg6ZmZmZmM5MDAwNWJjM2FkMCBFRkxB
R1M6IDAwMDEwMjAyClsgIDczOS43MzEyMjhdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6
IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiBmZmZmZmZmZmEwN2JlYjAwClsgIDczOS43MzEyMjhd
IFJEWDogZmZmZjg4ODgwOWYxNTAwMCBSU0k6IGZmZmY4ODg3ZmVhNTJjMDAgUkRJOiBmZmZm
ODg4ODAzZmRmMDAwClsgIDczOS43MzEyMjhdIFJCUDogZmZmZjg4ODgwM2ZkZjAwMCBSMDg6
IDAwMDAwMDAwMDAwMDAwMGMgUjA5OiBmZmZmODg4ODAzY2ZlOTAwClsgIDczOS43MzEyMjld
IFIxMDogZmZmZmM5MDAwNWJjM2E5OCBSMTE6IDAwMDAwMDAwMDAwMDAwMDYgUjEyOiBmZmZm
ODg4N2ZlNmQzMjgwClsgIDczOS43MzEyMjldIFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6
IGZmZmY4ODg3ZmU2ZDMyODAgUjE1OiBmZmZmODg4N2ZlNmQzMjgwClsgIDczOS43MzEyMzBd
IEZTOiAgMDAwMDdmMjE4NTc2ZTljMCgwMDAwKSBHUzpmZmZmODg4ODFkYjgwMDAwKDAwMDAp
IGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWyAgNzM5LjczMTIzMV0gQ1M6ICAwMDEwIERTOiAw
MDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbICA3MzkuNzMxMjMxXSBDUjI6
IDAwMDA3ZjdlYmNjMzVlMDAgQ1IzOiAwMDAwMDAwODA3ZWFhMDA1IENSNDogMDAwMDAwMDAw
MDM2MDZlMApbICA3MzkuNzMxMjMyXSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAw
MDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMApbICA3MzkuNzMxMjMyXSBEUjM6
IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAw
MDAwMDQwMApbICA3MzkuNzMxMjMyXSBDYWxsIFRyYWNlOgpbICA3MzkuNzMxMjM3XSAgZHJt
X2F0b21pY19oZWxwZXJfY2hlY2tfcGxhbmVzKzB4MTQzLzB4MWQwIFtkcm1fa21zX2hlbHBl
cl0KWyAgNzM5LjczMTI1Ml0gIGFtZGdwdV9kbV9hdG9taWNfY2hlY2srMHgxYmQvMHgzYzAg
W2FtZGdwdV0KWyAgNzM5LjczMTI1OF0gIGRybV9hdG9taWNfY2hlY2tfb25seSsweDQxNi8w
eDY1MCBbZHJtXQpbICA3MzkuNzMxMjYyXSAgZHJtX2F0b21pY19jb21taXQrMHgxMy8weDUw
IFtkcm1dClsgIDczOS43MzEyNjRdICBkcm1fYXRvbWljX2hlbHBlcl9zZXRfY29uZmlnKzB4
ODAvMHg5MCBbZHJtX2ttc19oZWxwZXJdClsgIDczOS43MzEyNjhdICBkcm1fbW9kZV9zZXRj
cnRjKzB4MTZiLzB4NjkwIFtkcm1dClsgIDczOS43MzEyNzJdICA/IGRybV9tb2RlX2dldGNy
dGMrMHgxODAvMHgxODAgW2RybV0KWyAgNzM5LjczMTI3NV0gIGRybV9pb2N0bF9rZXJuZWwr
MHg4MS8weGYwIFtkcm1dClsgIDczOS43MzEyNzhdICBkcm1faW9jdGwrMHgzMDAvMHgzYzAg
W2RybV0KWyAgNzM5LjczMTI4MV0gID8gZHJtX21vZGVfZ2V0Y3J0YysweDE4MC8weDE4MCBb
ZHJtXQpbICA3MzkuNzMxMjkwXSAgYW1kZ3B1X2RybV9pb2N0bCsweDQ5LzB4ODAgW2FtZGdw
dV0KWyAgNzM5LjczMTI5Ml0gIGRvX3Zmc19pb2N0bCsweGE0LzB4NjMwClsgIDczOS43MzEy
OTRdICA/IHZmc19yZWFkKzB4MTE5LzB4MTMwClsgIDczOS43MzEyOTVdICBrc3lzX2lvY3Rs
KzB4M2EvMHg3MApbICA3MzkuNzMxMjk2XSAgX194NjRfc3lzX2lvY3RsKzB4MTYvMHgyMApb
ICA3MzkuNzMxMjk4XSAgZG9fc3lzY2FsbF82NCsweDQ4LzB4MTAwClsgIDczOS43MzEzMDBd
ICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5ClsgIDczOS43MzEz
MDFdIFJJUDogMDAzMzoweDdmMjE4MzJlNzY0NwpbICA3MzkuNzMxMzAyXSBDb2RlOiAwMCAw
MCAwMCA0OCA4YiAwNSA0MSA1OCAyYyAwMCA2NCBjNyAwMCAyNiAwMCAwMCAwMCA0OCBjNyBj
MCBmZiBmZiBmZiBmZiBjMyA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCBiOCAxMCAw
MCAwMCAwMCAwZiAwNSA8NDg+IDNkIDAxIGYwIGZmIGZmIDczIDAxIGMzIDQ4IDhiIDBkIDEx
IDU4IDJjIDAwIGY3IGQ4IDY0IDg5IDAxIDQ4ClsgIDczOS43MzEzMDJdIFJTUDogMDAyYjow
MDAwN2ZmZjRkY2Q2MTI4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAw
MDAwMTAKWyAgNzM5LjczMTMwM10gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDdm
ZmY0ZGNkNjE2MCBSQ1g6IDAwMDA3ZjIxODMyZTc2NDcKWyAgNzM5LjczMTMwM10gUkRYOiAw
MDAwN2ZmZjRkY2Q2MTYwIFJTSTogMDAwMDAwMDBjMDY4NjRhMiBSREk6IDAwMDAwMDAwMDAw
MDAwMGIKWyAgNzM5LjczMTMwNF0gUkJQOiAwMDAwN2ZmZjRkY2Q2MTYwIFIwODogMDAwMDAw
MDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDEzZWY1ZDAKWyAgNzM5LjczMTMwNF0gUjEwOiAw
MDAwN2ZmZjRkY2Q2MjIwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwYzA2
ODY0YTIKWyAgNzM5LjczMTMwNV0gUjEzOiAwMDAwMDAwMDAwMDAwMDBiIFIxNDogMDAwMDAw
MDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDEzZWY1ZDAKWyAgNzM5LjczMTMwNl0gLS0tWyBl
bmQgdHJhY2UgNmE2YjBmZTczYTY2YjYzYSBdLS0tClsgIDczOS43MzEzNzVdIFdBUk5JTkc6
IENQVTogNiBQSUQ6IDEwMjIgYXQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmM6MzEwMyBkbV9jcnRjX2hlbHBlcl9hdG9taWNf
Y2hlY2srMHg0MS8weDUwIFthbWRncHVdClsgIDczOS43MzEzNzZdIE1vZHVsZXMgbGlua2Vk
IGluOiBmdXNlIHJwY3NlY19nc3Nfa3JiNSBuZnN2NCBuZnMgODAyMXEgZ2FycCBtcnAgc3Rw
IGxsYyBhbWRncHUgaTkxNSBjaGFzaCBncHVfc2NoZWQgdHRtIGlvc2ZfbWJpIGRybV9rbXNf
aGVscGVyIGRybSB4ODZfcGtnX3RlbXBfdGhlcm1hbCBrdm1faW50ZWwgaGlkX2xlZCBrdm0g
aW50ZWxfZ3R0IGlucHV0X2xlZHMgZmJfc3lzX2ZvcHMgbGVkX2NsYXNzIHN5c2NvcHlhcmVh
IHN5c2ZpbGxyZWN0IGlycWJ5cGFzcyBzeXNpbWdibHQgY3JjMzJjX2ludGVsIHdtaV9ibW9m
IHZpZGVvIHdtaSBuZnNkIGF1dGhfcnBjZ3NzIG9pZF9yZWdpc3RyeSBuZnNfYWNsIGxvY2tk
IGdyYWNlIHN1bnJwYyBpcF90YWJsZXMgeF90YWJsZXMgdW5peCBpcHY2IGF1dG9mczQKWyAg
NzM5LjczMTQxMF0gQ1BVOiA2IFBJRDogMTAyMiBDb21tOiBYb3JnIEtkdW1wOiBsb2FkZWQg
VGFpbnRlZDogRyAgICAgICAgVyAgICAgICAgIDQuMTkuMTkubXg2NC4yNDQgIzEKWyAgNzM5
LjczMTQxMF0gSGFyZHdhcmUgbmFtZTogRGVsbCBJbmMuIFByZWNpc2lvbiBUb3dlciAzNjIw
LzBNV1lQVCwgQklPUyAyLjExLjAgMDcvMTgvMjAxOApbICA3MzkuNzMxNDI1XSBSSVA6IDAw
MTA6ZG1fY3J0Y19oZWxwZXJfYXRvbWljX2NoZWNrKzB4NDEvMHg1MCBbYW1kZ3B1XQpbICA3
MzkuNzMxNDI2XSBDb2RlOiA0OCA4YiA1MiAyOCA0OCA4YiBiYSA1OCBhMyAwMCAwMCBlOCAw
OSBkNiAwNyAwMCA4MyBmOCAwMSA3NSAxZCAzMSBjMCBjMyBmNiA0NiAwYSAwZSA3NCBmNyA4
MCA3ZSAwOCAwMCA3NCBmMSA4MCA3ZSAwOSAwMCA3NCBlYiA8MGY+IDBiIGI4IGVhIGZmIGZm
IGZmIGMzIGI4IGVhIGZmIGZmIGZmIGMzIDkwIDBmIDFmIDQ0IDAwIDAwIDQxIDU3ClsgIDcz
OS43MzE0MjZdIFJTUDogMDAxODpmZmZmYzkwMDA1YmMzYWQwIEVGTEFHUzogMDAwMTAyMDIK
WyAgNzM5LjczMTQyN10gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAw
MDAwMSBSQ1g6IGZmZmZmZmZmYTA3YmViMDAKWyAgNzM5LjczMTQyN10gUkRYOiBmZmZmODg4
ODA5ZjE1MDAwIFJTSTogZmZmZjg4ODdmZWE1MmMwMCBSREk6IGZmZmY4ODg4MDRkMmQwMDAK
WyAgNzM5LjczMTQyOF0gUkJQOiBmZmZmODg4ODA0ZDJkMDAwIFIwODogMDAwMDAwMDAwMDAw
MDAwYyBSMDk6IGZmZmY4ODg4MDNjZmU5MDAKWyAgNzM5LjczMTQyOF0gUjEwOiBmZmZmYzkw
MDA1YmMzYTk4IFIxMTogMDAwMDAwMDAwMDAwMDAwNiBSMTI6IGZmZmY4ODg3ZmU2ZDMyODAK
WyAgNzM5LjczMTQyOV0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZjg4ODdmZTZk
MzI4MCBSMTU6IGZmZmY4ODg3ZmU2ZDMyODAKWyAgNzM5LjczMTQyOV0gRlM6ICAwMDAwN2Yy
MTg1NzZlOWMwKDAwMDApIEdTOmZmZmY4ODg4MWRiODAwMDAoMDAwMCkga25sR1M6MDAwMDAw
MDAwMDAwMDAwMApbICA3MzkuNzMxNDMwXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAg
Q1IwOiAwMDAwMDAwMDgwMDUwMDMzClsgIDczOS43MzE0MzFdIENSMjogMDAwMDdmN2ViY2Mz
NWUwMCBDUjM6IDAwMDAwMDA4MDdlYWEwMDUgQ1I0OiAwMDAwMDAwMDAwMzYwNmUwClsgIDcz
OS43MzE0MzFdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAg
RFIyOiAwMDAwMDAwMDAwMDAwMDAwClsgIDczOS43MzE0MzFdIERSMzogMDAwMDAwMDAwMDAw
MDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwClsgIDcz
OS43MzE0MzJdIENhbGwgVHJhY2U6ClsgIDczOS43MzE0NTBdICBkcm1fYXRvbWljX2hlbHBl
cl9jaGVja19wbGFuZXMrMHgxNDMvMHgxZDAgW2RybV9rbXNfaGVscGVyXQpbICA3MzkuNzMx
NDgxXSAgYW1kZ3B1X2RtX2F0b21pY19jaGVjaysweDFiZC8weDNjMCBbYW1kZ3B1XQpbICA3
MzkuNzMxNDg1XSAgZHJtX2F0b21pY19jaGVja19vbmx5KzB4NDE2LzB4NjUwIFtkcm1dClsg
IDczOS43MzE0ODhdICBkcm1fYXRvbWljX2NvbW1pdCsweDEzLzB4NTAgW2RybV0KWyAgNzM5
LjczMTQ5MF0gIGRybV9hdG9taWNfaGVscGVyX3NldF9jb25maWcrMHg4MC8weDkwIFtkcm1f
a21zX2hlbHBlcl0KWyAgNzM5LjczMTQ5NF0gIGRybV9tb2RlX3NldGNydGMrMHgxNmIvMHg2
OTAgW2RybV0KWyAgNzM5LjczMTQ5N10gID8gZHJtX21vZGVfZ2V0Y3J0YysweDE4MC8weDE4
MCBbZHJtXQpbICA3MzkuNzMxNTAwXSAgZHJtX2lvY3RsX2tlcm5lbCsweDgxLzB4ZjAgW2Ry
bV0KWyAgNzM5LjczMTUwM10gIGRybV9pb2N0bCsweDMwMC8weDNjMCBbZHJtXQpbICA3Mzku
NzMxNTA2XSAgPyBkcm1fbW9kZV9nZXRjcnRjKzB4MTgwLzB4MTgwIFtkcm1dClsgIDczOS43
MzE1MTNdICBhbWRncHVfZHJtX2lvY3RsKzB4NDkvMHg4MCBbYW1kZ3B1XQpbICA3MzkuNzMx
NTE0XSAgZG9fdmZzX2lvY3RsKzB4YTQvMHg2MzAKWyAgNzM5LjczMTUxNV0gID8gdmZzX3dy
aXRlKzB4MTVlLzB4MTkwClsgIDczOS43MzE1MTZdICBrc3lzX2lvY3RsKzB4M2EvMHg3MApb
ICA3MzkuNzMxNTE3XSAgX194NjRfc3lzX2lvY3RsKzB4MTYvMHgyMApbICA3MzkuNzMxNTE4
XSAgZG9fc3lzY2FsbF82NCsweDQ4LzB4MTAwClsgIDczOS43MzE1MTldICBlbnRyeV9TWVND
QUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5ClsgIDczOS43MzE1MjBdIFJJUDogMDAz
MzoweDdmMjE4MzJlNzY0NwpbICA3MzkuNzMxNTIxXSBDb2RlOiAwMCAwMCAwMCA0OCA4YiAw
NSA0MSA1OCAyYyAwMCA2NCBjNyAwMCAyNiAwMCAwMCAwMCA0OCBjNyBjMCBmZiBmZiBmZiBm
ZiBjMyA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCBiOCAxMCAwMCAwMCAwMCAwZiAw
NSA8NDg+IDNkIDAxIGYwIGZmIGZmIDczIDAxIGMzIDQ4IDhiIDBkIDExIDU4IDJjIDAwIGY3
IGQ4IDY0IDg5IDAxIDQ4ClsgIDczOS43MzE1MjFdIFJTUDogMDAyYjowMDAwN2ZmZjRkY2Q2
MTI4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMTAKWyAgNzM5
LjczMTUyMl0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDdmZmY0ZGNkNjE2MCBS
Q1g6IDAwMDA3ZjIxODMyZTc2NDcKWyAgNzM5LjczMTUyMl0gUkRYOiAwMDAwN2ZmZjRkY2Q2
MTYwIFJTSTogMDAwMDAwMDBjMDY4NjRhMiBSREk6IDAwMDAwMDAwMDAwMDAwMGIKWyAgNzM5
LjczMTUyM10gUkJQOiAwMDAwN2ZmZjRkY2Q2MTYwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBS
MDk6IDAwMDAwMDAwMDEzZWY1ZDAKWyAgNzM5LjczMTUyM10gUjEwOiAwMDAwN2ZmZjRkY2Q2
MjIwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwYzA2ODY0YTIKWyAgNzM5
LjczMTUyNF0gUjEzOiAwMDAwMDAwMDAwMDAwMDBiIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBS
MTU6IDAwMDAwMDAwMDEzZWY1ZDAKWyAgNzM5LjczMTUyNF0gLS0tWyBlbmQgdHJhY2UgNmE2
YjBmZTczYTY2YjYzYiBdLS0tClsgIDc0MS43NjA0MTFdIFtkcm1dIERNX01TVDogc3RhcnRp
bmcgVE0gb24gYWNvbm5lY3RvcjogMDAwMDAwMDA3NDMyZjgwNSBbaWQ6IDYyXQpbICA3NDEu
Nzg2ODU5XSBbZHJtXSBETV9NU1Q6IGFkZGVkIGNvbm5lY3RvcjogMDAwMDAwMDA5ZDA2Mzhk
OSBbaWQ6IDcyXSBbbWFzdGVyOiAwMDAwMDAwMDc0MzJmODA1XQpbICA3NDEuODQwMzg0XSBb
ZHJtXSBTQURzIGNvdW50IGlzOiAtMiwgZG9uJ3QgbmVlZCB0byByZWFkIGl0ClsgIDc0MS44
NzY1ODFdIFdBUk5JTkc6IENQVTogMiBQSUQ6IDEwMjIgYXQgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmM6MzEwMyBkbV9jcnRj
X2hlbHBlcl9hdG9taWNfY2hlY2srMHg0MS8weDUwIFthbWRncHVdClsgIDc0MS44NzY1ODFd
IE1vZHVsZXMgbGlua2VkIGluOiBmdXNlIHJwY3NlY19nc3Nfa3JiNSBuZnN2NCBuZnMgODAy
MXEgZ2FycCBtcnAgc3RwIGxsYyBhbWRncHUgaTkxNSBjaGFzaCBncHVfc2NoZWQgdHRtIGlv
c2ZfbWJpIGRybV9rbXNfaGVscGVyIGRybSB4ODZfcGtnX3RlbXBfdGhlcm1hbCBrdm1faW50
ZWwgaGlkX2xlZCBrdm0gaW50ZWxfZ3R0IGlucHV0X2xlZHMgZmJfc3lzX2ZvcHMgbGVkX2Ns
YXNzIHN5c2NvcHlhcmVhIHN5c2ZpbGxyZWN0IGlycWJ5cGFzcyBzeXNpbWdibHQgY3JjMzJj
X2ludGVsIHdtaV9ibW9mIHZpZGVvIHdtaSBuZnNkIGF1dGhfcnBjZ3NzIG9pZF9yZWdpc3Ry
eSBuZnNfYWNsIGxvY2tkIGdyYWNlIHN1bnJwYyBpcF90YWJsZXMgeF90YWJsZXMgdW5peCBp
cHY2IGF1dG9mczQKWyAgNzQxLjg3NjU5Nl0gQ1BVOiAyIFBJRDogMTAyMiBDb21tOiBYb3Jn
IEtkdW1wOiBsb2FkZWQgVGFpbnRlZDogRyAgICAgICAgVyAgICAgICAgIDQuMTkuMTkubXg2
NC4yNDQgIzEKWyAgNzQxLjg3NjU5N10gSGFyZHdhcmUgbmFtZTogRGVsbCBJbmMuIFByZWNp
c2lvbiBUb3dlciAzNjIwLzBNV1lQVCwgQklPUyAyLjExLjAgMDcvMTgvMjAxOApbICA3NDEu
ODc2NjEyXSBSSVA6IDAwMTA6ZG1fY3J0Y19oZWxwZXJfYXRvbWljX2NoZWNrKzB4NDEvMHg1
MCBbYW1kZ3B1XQpbICA3NDEuODc2NjEzXSBDb2RlOiA0OCA4YiA1MiAyOCA0OCA4YiBiYSA1
OCBhMyAwMCAwMCBlOCAwOSBkNiAwNyAwMCA4MyBmOCAwMSA3NSAxZCAzMSBjMCBjMyBmNiA0
NiAwYSAwZSA3NCBmNyA4MCA3ZSAwOCAwMCA3NCBmMSA4MCA3ZSAwOSAwMCA3NCBlYiA8MGY+
IDBiIGI4IGVhIGZmIGZmIGZmIGMzIGI4IGVhIGZmIGZmIGZmIGMzIDkwIDBmIDFmIDQ0IDAw
IDAwIDQxIDU3ClsgIDc0MS44NzY2MTRdIFJTUDogMDAxODpmZmZmYzkwMDA1YmMzYWQwIEVG
TEFHUzogMDAwMTAyMDIKWyAgNzQxLjg3NjYxNV0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJC
WDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IGZmZmZmZmZmYTA3YmViMDAKWyAgNzQxLjg3NjYx
NV0gUkRYOiBmZmZmODg4ODA5ZjE1MDAwIFJTSTogZmZmZjg4ODgwM2M3ZGMwMCBSREk6IGZm
ZmY4ODg4MDNmZGYwMDAKWyAgNzQxLjg3NjYxNV0gUkJQOiBmZmZmODg4ODAzZmRmMDAwIFIw
ODogMDAwMDAwMDAwMDAwMDAwYyBSMDk6IGZmZmY4ODg4MTM4ZmI2MDAKWyAgNzQxLjg3NjYx
Nl0gUjEwOiBmZmZmYzkwMDA1YmMzYTk4IFIxMTogMDAwMDAwMDAwMDAwMDAwNyBSMTI6IGZm
ZmY4ODg3ZmU1MjZiODAKWyAgNzQxLjg3NjYxNl0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIx
NDogZmZmZjg4ODdmZTUyNmI4MCBSMTU6IGZmZmY4ODg3ZmU1MjZiODAKWyAgNzQxLjg3NjYx
N10gRlM6ICAwMDAwN2YyMTg1NzZlOWMwKDAwMDApIEdTOmZmZmY4ODg4MWRhODAwMDAoMDAw
MCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApbICA3NDEuODc2NjE4XSBDUzogIDAwMTAgRFM6
IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzClsgIDc0MS44NzY2MThdIENS
MjogMDAwMDAwMDAwMDhiY2RhMCBDUjM6IDAwMDAwMDA4MDdlYWEwMDIgQ1I0OiAwMDAwMDAw
MDAwMzYwNmUwClsgIDc0MS44NzY2MTldIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAw
MDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwClsgIDc0MS44NzY2MTldIERS
MzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAw
MDAwMDAwNDAwClsgIDc0MS44NzY2MTldIENhbGwgVHJhY2U6ClsgIDc0MS44NzY2MjNdICBk
cm1fYXRvbWljX2hlbHBlcl9jaGVja19wbGFuZXMrMHgxNDMvMHgxZDAgW2RybV9rbXNfaGVs
cGVyXQpbICA3NDEuODc2NjM5XSAgYW1kZ3B1X2RtX2F0b21pY19jaGVjaysweDFiZC8weDNj
MCBbYW1kZ3B1XQpbICA3NDEuODc2NjQ0XSAgZHJtX2F0b21pY19jaGVja19vbmx5KzB4NDE2
LzB4NjUwIFtkcm1dClsgIDc0MS44NzY2NDhdICBkcm1fYXRvbWljX2NvbW1pdCsweDEzLzB4
NTAgW2RybV0KWyAgNzQxLjg3NjY1MF0gIGRybV9hdG9taWNfaGVscGVyX3NldF9jb25maWcr
MHg4MC8weDkwIFtkcm1fa21zX2hlbHBlcl0KWyAgNzQxLjg3NjY1NF0gIGRybV9tb2RlX3Nl
dGNydGMrMHgxNmIvMHg2OTAgW2RybV0KWyAgNzQxLjg3NjY1OF0gID8gZHJtX21vZGVfZ2V0
Y3J0YysweDE4MC8weDE4MCBbZHJtXQpbICA3NDEuODc2NjYxXSAgZHJtX2lvY3RsX2tlcm5l
bCsweDgxLzB4ZjAgW2RybV0KWyAgNzQxLjg3NjY2NF0gIGRybV9pb2N0bCsweDMwMC8weDNj
MCBbZHJtXQpbICA3NDEuODc2NjY3XSAgPyBkcm1fbW9kZV9nZXRjcnRjKzB4MTgwLzB4MTgw
IFtkcm1dClsgIDc0MS44NzY2NzRdICBhbWRncHVfZHJtX2lvY3RsKzB4NDkvMHg4MCBbYW1k
Z3B1XQpbICA3NDEuODc2Njc2XSAgZG9fdmZzX2lvY3RsKzB4YTQvMHg2MzAKWyAgNzQxLjg3
NjY3OF0gID8gX19zZV9zeXNfZnV0ZXgrMHgxMmQvMHgxODAKWyAgNzQxLjg3NjY3OV0gIGtz
eXNfaW9jdGwrMHgzYS8weDcwClsgIDc0MS44NzY2ODBdICBfX3g2NF9zeXNfaW9jdGwrMHgx
Ni8weDIwClsgIDc0MS44NzY2ODFdICBkb19zeXNjYWxsXzY0KzB4NDgvMHgxMDAKWyAgNzQx
Ljg3NjY4M10gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkKWyAg
NzQxLjg3NjY4NF0gUklQOiAwMDMzOjB4N2YyMTgzMmU3NjQ3ClsgIDc0MS44NzY2ODVdIENv
ZGU6IDAwIDAwIDAwIDQ4IDhiIDA1IDQxIDU4IDJjIDAwIDY0IGM3IDAwIDI2IDAwIDAwIDAw
IDQ4IGM3IGMwIGZmIGZmIGZmIGZmIGMzIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAw
IGI4IDEwIDAwIDAwIDAwIDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDgg
OGIgMGQgMTEgNTggMmMgMDAgZjcgZDggNjQgODkgMDEgNDgKWyAgNzQxLjg3NjY4Nl0gUlNQ
OiAwMDJiOjAwMDA3ZmZmNGRjZDZkMDggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAw
MDAwMDAwMDAwMDAxMApbICA3NDEuODc2Njg3XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJY
OiAwMDAwN2ZmZjRkY2Q2ZDQwIFJDWDogMDAwMDdmMjE4MzJlNzY0NwpbICA3NDEuODc2Njg3
XSBSRFg6IDAwMDA3ZmZmNGRjZDZkNDAgUlNJOiAwMDAwMDAwMGMwNjg2NGEyIFJESTogMDAw
MDAwMDAwMDAwMDAwYgpbICA3NDEuODc2Njg3XSBSQlA6IDAwMDA3ZmZmNGRjZDZkNDAgUjA4
OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMGY0NjJiMApbICA3NDEuODc2Njg4
XSBSMTA6IDAwMDA3ZmZmNGRjZDZlMDAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAw
MDAwMDBjMDY4NjRhMgpbICA3NDEuODc2Njg4XSBSMTM6IDAwMDAwMDAwMDAwMDAwMGIgUjE0
OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMGY0NjJiMApbICA3NDEuODc2Njg5
XSAtLS1bIGVuZCB0cmFjZSA2YTZiMGZlNzNhNjZiNjNjIF0tLS0KWyAgNzQyLjE4MDE5Ml0g
W2RybV0gRE1fTVNUOiBhZGRlZCBjb25uZWN0b3I6IDAwMDAwMDAwZmU0MGE5OGQgW2lkOiA4
M10gW21hc3RlcjogMDAwMDAwMDA3NDMyZjgwNV0KWyAgNzQyLjIzOTIzNl0gW2RybV0gU0FE
cyBjb3VudCBpczogLTIsIGRvbid0IG5lZWQgdG8gcmVhZCBpdApbICA4MTEuMjYwNDIwXSBX
QVJOSU5HOiBDUFU6IDEgUElEOiAxMDIyIGF0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jOjMxMDMgZG1fY3J0Y19oZWxwZXJf
YXRvbWljX2NoZWNrKzB4NDEvMHg1MCBbYW1kZ3B1XQpbICA4MTEuMjYwNDIxXSBNb2R1bGVz
IGxpbmtlZCBpbjogZnVzZSBycGNzZWNfZ3NzX2tyYjUgbmZzdjQgbmZzIDgwMjFxIGdhcnAg
bXJwIHN0cCBsbGMgYW1kZ3B1IGk5MTUgY2hhc2ggZ3B1X3NjaGVkIHR0bSBpb3NmX21iaSBk
cm1fa21zX2hlbHBlciBkcm0geDg2X3BrZ190ZW1wX3RoZXJtYWwga3ZtX2ludGVsIGhpZF9s
ZWQga3ZtIGludGVsX2d0dCBpbnB1dF9sZWRzIGZiX3N5c19mb3BzIGxlZF9jbGFzcyBzeXNj
b3B5YXJlYSBzeXNmaWxscmVjdCBpcnFieXBhc3Mgc3lzaW1nYmx0IGNyYzMyY19pbnRlbCB3
bWlfYm1vZiB2aWRlbyB3bWkgbmZzZCBhdXRoX3JwY2dzcyBvaWRfcmVnaXN0cnkgbmZzX2Fj
bCBsb2NrZCBncmFjZSBzdW5ycGMgaXBfdGFibGVzIHhfdGFibGVzIHVuaXggaXB2NiBhdXRv
ZnM0ClsgIDgxMS4yNjA0MzRdIENQVTogMSBQSUQ6IDEwMjIgQ29tbTogWG9yZyBLZHVtcDog
bG9hZGVkIFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICA0LjE5LjE5Lm14NjQuMjQ0ICMx
ClsgIDgxMS4yNjA0MzVdIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQcmVjaXNpb24gVG93
ZXIgMzYyMC8wTVdZUFQsIEJJT1MgMi4xMS4wIDA3LzE4LzIwMTgKWyAgODExLjI2MDQ1MV0g
UklQOiAwMDEwOmRtX2NydGNfaGVscGVyX2F0b21pY19jaGVjaysweDQxLzB4NTAgW2FtZGdw
dV0KWyAgODExLjI2MDQ1Ml0gQ29kZTogNDggOGIgNTIgMjggNDggOGIgYmEgNTggYTMgMDAg
MDAgZTggMDkgZDYgMDcgMDAgODMgZjggMDEgNzUgMWQgMzEgYzAgYzMgZjYgNDYgMGEgMGUg
NzQgZjcgODAgN2UgMDggMDAgNzQgZjEgODAgN2UgMDkgMDAgNzQgZWIgPDBmPiAwYiBiOCBl
YSBmZiBmZiBmZiBjMyBiOCBlYSBmZiBmZiBmZiBjMyA5MCAwZiAxZiA0NCAwMCAwMCA0MSA1
NwpbICA4MTEuMjYwNDUyXSBSU1A6IDAwMTg6ZmZmZmM5MDAwNWJjMzkzMCBFRkxBR1M6IDAw
MDEwMjAyClsgIDgxMS4yNjA0NTNdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAw
MDAwMDAwMDAwMDAgUkNYOiBmZmZmZmZmZmEwN2JlYjAwClsgIDgxMS4yNjA0NTNdIFJEWDog
ZmZmZjg4ODgwOWYxNTAwMCBSU0k6IGZmZmY4ODg3ZmY3ZGM0MDAgUkRJOiBmZmZmODg4ODAz
ZmRmMDAwClsgIDgxMS4yNjA0NTRdIFJCUDogZmZmZjg4ODgwM2ZkZjAwMCBSMDg6IDAwMDAw
MDAwMDAwMDAwMGMgUjA5OiBmZmZmODg4ODE0NDFlYTAwClsgIDgxMS4yNjA0NTRdIFIxMDog
ZmZmZmM5MDAwNWJjMzhmOCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiBmZmZmODg4N2Zk
ZWRmODgwClsgIDgxMS4yNjA0NTRdIFIxMzogZmZmZjg4ODgwNjA0MzAwMCBSMTQ6IGZmZmY4
ODg3ZmRlZGY4ODAgUjE1OiBmZmZmODg4N2ZkZWRmODgwClsgIDgxMS4yNjA0NTVdIEZTOiAg
MDAwMDdmMjE4NTc2ZTljMCgwMDAwKSBHUzpmZmZmODg4ODFkYTQwMDAwKDAwMDApIGtubEdT
OjAwMDAwMDAwMDAwMDAwMDAKWyAgODExLjI2MDQ1Nl0gQ1M6ICAwMDEwIERTOiAwMDAwIEVT
OiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbICA4MTEuMjYwNDU2XSBDUjI6IDAwMDAw
MDAwMDA4NGVkYTAgQ1IzOiAwMDAwMDAwODA3ZWFhMDAzIENSNDogMDAwMDAwMDAwMDM2MDZl
MApbICA4MTEuMjYwNDU3XSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAw
MDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMApbICA4MTEuMjYwNDc0XSBEUjM6IDAwMDAw
MDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQw
MApbICA4MTEuMjYwNDc1XSBDYWxsIFRyYWNlOgpbICA4MTEuMjYwNDc5XSAgZHJtX2F0b21p
Y19oZWxwZXJfY2hlY2tfcGxhbmVzKzB4MTQzLzB4MWQwIFtkcm1fa21zX2hlbHBlcl0KWyAg
ODExLjI2MDQ5NV0gIGFtZGdwdV9kbV9hdG9taWNfY2hlY2srMHgxYmQvMHgzYzAgW2FtZGdw
dV0KWyAgODExLjI2MDUwMF0gIGRybV9hdG9taWNfY2hlY2tfb25seSsweDQxNi8weDY1MCBb
ZHJtXQpbICA4MTEuMjYwNTA0XSAgZHJtX2F0b21pY19jb21taXQrMHgxMy8weDUwIFtkcm1d
ClsgIDgxMS4yNjA1MDZdICByZXN0b3JlX2ZiZGV2X21vZGVfYXRvbWljKzB4MWQzLzB4MWYw
IFtkcm1fa21zX2hlbHBlcl0KWyAgODExLjI2MDUwOF0gIGRybV9mYl9oZWxwZXJfcmVzdG9y
ZV9mYmRldl9tb2RlX3VubG9ja2VkKzB4NDUvMHg5MCBbZHJtX2ttc19oZWxwZXJdClsgIDgx
MS4yNjA1MTBdICBkcm1fZmJfaGVscGVyX3NldF9wYXIrMHgyOS8weDUwIFtkcm1fa21zX2hl
bHBlcl0KWyAgODExLjI2MDUyOV0gIGZiX3NldF92YXIrMHgxNzkvMHgzZTAKWyAgODExLjI2
MDUzMV0gID8gX2NvbmRfcmVzY2hlZCsweDE1LzB4NDAKWyAgODExLjI2MDUzM10gID8ga21l
bV9jYWNoZV9hbGxvYysweGQ4LzB4MWYwClsgIDgxMS4yNjA1MzRdICBmYmNvbl9ibGFuaysw
eDFmNC8weDMxMApbICA4MTEuMjYwNTM2XSAgZG9fdW5ibGFua19zY3JlZW4rMHhhOC8weDFj
MApbICA4MTEuMjYwNTM4XSAgdnRfaW9jdGwrMHg0ZDcvMHgxMTQwClsgIDgxMS4yNjA1NDBd
ICA/IHhmc19sb2dfY29tbWl0X2NpbCsweDRhOS8weDVlMApbICA4MTEuMjYwNTQyXSAgdHR5
X2lvY3RsKzB4ZjMvMHg4ODAKWyAgODExLjI2MDU0M10gID8geGZzX2luYWN0aXZlX2lmcmVl
KzB4MTRjLzB4MWMwClsgIDgxMS4yNjA1NDRdICA/IF9feGZzX3RyYW5zX2NvbW1pdCsweGRh
LzB4MzUwClsgIDgxMS4yNjA1NDZdICBkb192ZnNfaW9jdGwrMHhhNC8weDYzMApbICA4MTEu
MjYwNTQ3XSAgPyBfX2ZwdXQrMHgxMTYvMHgxZTAKWyAgODExLjI2MDU0OF0gIGtzeXNfaW9j
dGwrMHgzYS8weDcwClsgIDgxMS4yNjA1NDldICBfX3g2NF9zeXNfaW9jdGwrMHgxNi8weDIw
ClsgIDgxMS4yNjA1NTBdICBkb19zeXNjYWxsXzY0KzB4NDgvMHgxMDAKWyAgODExLjI2MDU1
Ml0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkKWyAgODExLjI2
MDU1M10gUklQOiAwMDMzOjB4N2YyMTgzMmU3NjQ3ClsgIDgxMS4yNjA1NTRdIENvZGU6IDAw
IDAwIDAwIDQ4IDhiIDA1IDQxIDU4IDJjIDAwIDY0IGM3IDAwIDI2IDAwIDAwIDAwIDQ4IGM3
IGMwIGZmIGZmIGZmIGZmIGMzIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIGI4IDEw
IDAwIDAwIDAwIDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggOGIgMGQg
MTEgNTggMmMgMDAgZjcgZDggNjQgODkgMDEgNDgKWyAgODExLjI2MDU1NF0gUlNQOiAwMDJi
OjAwMDA3ZmZmNGRjZDcxNTggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAw
MDAwMDAxMApbICA4MTEuMjYwNTU1XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAw
MDAwMDAwODFhNTIwIFJDWDogMDAwMDdmMjE4MzJlNzY0NwpbICA4MTEuMjYwNTU2XSBSRFg6
IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAwMDA0YjNhIFJESTogMDAwMDAwMDAw
MDAwMDAwYQpbICA4MTEuMjYwNTU2XSBSQlA6IDAwMDAwMDAwZmZmZmZmZmYgUjA4OiAwMDAw
MDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApbICA4MTEuMjYwNTU2XSBSMTA6
IDAwMDAwMDAwMDAwMDAwNTUgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDAw
MDgzYmVhMApbICA4MTEuMjYwNTU3XSBSMTM6IGZmZmZmZmZmZmZmZmZmZmYgUjE0OiAwMDAw
MDAwMDAwODM3ZTQ4IFIxNTogZmZmZmZmZmZmZmZmZmZmZgpbICA4MTEuMjYwNTU4XSAtLS1b
IGVuZCB0cmFjZSA2YTZiMGZlNzNhNjZiNjNkIF0tLS0KWyAgODE1LjIwODA4Nl0gW2RybV0g
RE1fTVNUOiBzdG9wcGluZyBUTSBvbiBhY29ubmVjdG9yOiAwMDAwMDAwMDc0MzJmODA1IFtp
ZDogNjJdClsgIDgxNS4yMDgxNDZdIFtkcm1dIERNX01TVDogRGlzYWJsaW5nIGNvbm5lY3Rv
cjogMDAwMDAwMDA5ZDA2MzhkOSBbaWQ6IDcyXSBbbWFzdGVyOiAwMDAwMDAwMDc0MzJmODA1
XQpbICA4MTUuMjA4MTk1XSBbZHJtXSBETV9NU1Q6IERpc2FibGluZyBjb25uZWN0b3I6IDAw
MDAwMDAwZmU0MGE5OGQgW2lkOiA4M10gW21hc3RlcjogMDAwMDAwMDA3NDMyZjgwNV0KWzEx
MDkyLjQ4ODc3Ml0gV0FSTklORzogQ1BVOiA3IFBJRDogMTY0MiBhdCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYzozMTAzIGRt
X2NydGNfaGVscGVyX2F0b21pY19jaGVjaysweDQxLzB4NTAgW2FtZGdwdV0KWzExMDkyLjQ4
ODc3Ml0gTW9kdWxlcyBsaW5rZWQgaW46IGZ1c2UgcnBjc2VjX2dzc19rcmI1IG5mc3Y0IG5m
cyA4MDIxcSBnYXJwIG1ycCBzdHAgbGxjIGFtZGdwdSBpOTE1IGNoYXNoIGdwdV9zY2hlZCB0
dG0gaW9zZl9tYmkgZHJtX2ttc19oZWxwZXIgZHJtIHg4Nl9wa2dfdGVtcF90aGVybWFsIGt2
bV9pbnRlbCBoaWRfbGVkIGt2bSBpbnRlbF9ndHQgaW5wdXRfbGVkcyBmYl9zeXNfZm9wcyBs
ZWRfY2xhc3Mgc3lzY29weWFyZWEgc3lzZmlsbHJlY3QgaXJxYnlwYXNzIHN5c2ltZ2JsdCBj
cmMzMmNfaW50ZWwgd21pX2Jtb2YgdmlkZW8gd21pIG5mc2QgYXV0aF9ycGNnc3Mgb2lkX3Jl
Z2lzdHJ5IG5mc19hY2wgbG9ja2QgZ3JhY2Ugc3VucnBjIGlwX3RhYmxlcyB4X3RhYmxlcyB1
bml4IGlwdjYgYXV0b2ZzNApbMTEwOTIuNDg4Nzg3XSBDUFU6IDcgUElEOiAxNjQyIENvbW06
IFhvcmcgS2R1bXA6IGxvYWRlZCBUYWludGVkOiBHICAgICAgICBXICAgICAgICAgNC4xOS4x
OS5teDY0LjI0NCAjMQpbMTEwOTIuNDg4Nzg4XSBIYXJkd2FyZSBuYW1lOiBEZWxsIEluYy4g
UHJlY2lzaW9uIFRvd2VyIDM2MjAvME1XWVBULCBCSU9TIDIuMTEuMCAwNy8xOC8yMDE4Clsx
MTA5Mi40ODg4MDNdIFJJUDogMDAxMDpkbV9jcnRjX2hlbHBlcl9hdG9taWNfY2hlY2srMHg0
MS8weDUwIFthbWRncHVdClsxMTA5Mi40ODg4MDRdIENvZGU6IDQ4IDhiIDUyIDI4IDQ4IDhi
IGJhIDU4IGEzIDAwIDAwIGU4IDA5IGQ2IDA3IDAwIDgzIGY4IDAxIDc1IDFkIDMxIGMwIGMz
IGY2IDQ2IDBhIDBlIDc0IGY3IDgwIDdlIDA4IDAwIDc0IGYxIDgwIDdlIDA5IDAwIDc0IGVi
IDwwZj4gMGIgYjggZWEgZmYgZmYgZmYgYzMgYjggZWEgZmYgZmYgZmYgYzMgOTAgMGYgMWYg
NDQgMDAgMDAgNDEgNTcKWzExMDkyLjQ4ODgwNF0gUlNQOiAwMDE4OmZmZmZjOTAwMDVhZDNh
ZDAgRUZMQUdTOiAwMDAxMDIwMgpbMTEwOTIuNDg4ODA1XSBSQVg6IDAwMDAwMDAwMDAwMDAw
MDAgUkJYOiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogZmZmZmZmZmZhMDdiZWIwMApbMTEwOTIu
NDg4ODA2XSBSRFg6IGZmZmY4ODg4MDlmMTUwMDAgUlNJOiBmZmZmODg4ODE4ZjliMDAwIFJE
STogZmZmZjg4ODgwM2ZkZjAwMApbMTEwOTIuNDg4ODA2XSBSQlA6IGZmZmY4ODg4MDNmZGYw
MDAgUjA4OiAwMDAwMDAwMDAwMDAwMDBjIFIwOTogZmZmZjg4ODgxODY0OGEwMApbMTEwOTIu
NDg4ODA3XSBSMTA6IGZmZmZjOTAwMDVhZDNhOTggUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIx
MjogZmZmZjg4ODgxOGIyMjU4MApbMTEwOTIuNDg4ODA3XSBSMTM6IDAwMDAwMDAwMDAwMDAw
MDAgUjE0OiBmZmZmODg4ODE4YjIyNTgwIFIxNTogZmZmZjg4ODgxOGIyMjU4MApbMTEwOTIu
NDg4ODA4XSBGUzogIDAwMDA3ZjIyNmYxZjI5YzAoMDAwMCkgR1M6ZmZmZjg4ODgxZGJjMDAw
MCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwClsxMTA5Mi40ODg4MDhdIENTOiAgMDAx
MCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKWzExMDkyLjQ4ODgw
OV0gQ1IyOiAwMDAwNTVhMDNkN2NhODBjIENSMzogMDAwMDAwMDdmZGY0MDAwMSBDUjQ6IDAw
MDAwMDAwMDAzNjA2ZTAKWzExMDkyLjQ4ODgwOV0gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERS
MTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAKWzExMDkyLjQ4ODgx
MF0gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAw
MDAwMDAwMDAwMDA0MDAKWzExMDkyLjQ4ODgxMF0gQ2FsbCBUcmFjZToKWzExMDkyLjQ4ODgx
NF0gIGRybV9hdG9taWNfaGVscGVyX2NoZWNrX3BsYW5lcysweDE0My8weDFkMCBbZHJtX2tt
c19oZWxwZXJdClsxMTA5Mi40ODg4MjldICBhbWRncHVfZG1fYXRvbWljX2NoZWNrKzB4MWJk
LzB4M2MwIFthbWRncHVdClsxMTA5Mi40ODg4MzRdICBkcm1fYXRvbWljX2NoZWNrX29ubHkr
MHg0MTYvMHg2NTAgW2RybV0KWzExMDkyLjQ4ODgzOF0gIGRybV9hdG9taWNfY29tbWl0KzB4
MTMvMHg1MCBbZHJtXQpbMTEwOTIuNDg4ODQwXSAgZHJtX2F0b21pY19oZWxwZXJfc2V0X2Nv
bmZpZysweDgwLzB4OTAgW2RybV9rbXNfaGVscGVyXQpbMTEwOTIuNDg4ODQ0XSAgZHJtX21v
ZGVfc2V0Y3J0YysweDE2Yi8weDY5MCBbZHJtXQpbMTEwOTIuNDg4ODQ4XSAgPyBkcm1fbW9k
ZV9nZXRjcnRjKzB4MTgwLzB4MTgwIFtkcm1dClsxMTA5Mi40ODg4NTBdICBkcm1faW9jdGxf
a2VybmVsKzB4ODEvMHhmMCBbZHJtXQpbMTEwOTIuNDg4ODUzXSAgZHJtX2lvY3RsKzB4MzAw
LzB4M2MwIFtkcm1dClsxMTA5Mi40ODg4NTZdICA/IGRybV9tb2RlX2dldGNydGMrMHgxODAv
MHgxODAgW2RybV0KWzExMDkyLjQ4ODg2M10gIGFtZGdwdV9kcm1faW9jdGwrMHg0OS8weDgw
IFthbWRncHVdClsxMTA5Mi40ODg4NjVdICBkb192ZnNfaW9jdGwrMHhhNC8weDYzMApbMTEw
OTIuNDg4ODY3XSAgPyBfX3NlX3N5c19mdXRleCsweDEyZC8weDE4MApbMTEwOTIuNDg4ODY4
XSAga3N5c19pb2N0bCsweDNhLzB4NzAKWzExMDkyLjQ4ODg2OV0gIF9feDY0X3N5c19pb2N0
bCsweDE2LzB4MjAKWzExMDkyLjQ4ODg3MF0gIGRvX3N5c2NhbGxfNjQrMHg0OC8weDEwMApb
MTEwOTIuNDg4ODcyXSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhh
OQpbMTEwOTIuNDg4ODc0XSBSSVA6IDAwMzM6MHg3ZjIyNmNkNmI2NDcKWzExMDkyLjQ4ODg3
NF0gQ29kZTogMDAgMDAgMDAgNDggOGIgMDUgNDEgNTggMmMgMDAgNjQgYzcgMDAgMjYgMDAg
MDAgMDAgNDggYzcgYzAgZmYgZmYgZmYgZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAg
MDAgMDAgYjggMTAgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBj
MyA0OCA4YiAwZCAxMSA1OCAyYyAwMCBmNyBkOCA2NCA4OSAwMSA0OApbMTEwOTIuNDg4ODc1
XSBSU1A6IDAwMmI6MDAwMDdmZmMzNjk0MjA2OCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFY
OiAwMDAwMDAwMDAwMDAwMDEwClsxMTA5Mi40ODg4NzZdIFJBWDogZmZmZmZmZmZmZmZmZmZk
YSBSQlg6IDAwMDA3ZmZjMzY5NDIwYTAgUkNYOiAwMDAwN2YyMjZjZDZiNjQ3ClsxMTA5Mi40
ODg4NzZdIFJEWDogMDAwMDdmZmMzNjk0MjBhMCBSU0k6IDAwMDAwMDAwYzA2ODY0YTIgUkRJ
OiAwMDAwMDAwMDAwMDAwMDBiClsxMTA5Mi40ODg4NzddIFJCUDogMDAwMDdmZmMzNjk0MjBh
MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAxM2VmZjUwClsxMTA5Mi40
ODg4NzddIFIxMDogMDAwMDdmZmMzNjk0MjE2MCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEy
OiAwMDAwMDAwMGMwNjg2NGEyClsxMTA5Mi40ODg4NzhdIFIxMzogMDAwMDAwMDAwMDAwMDAw
YiBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAxM2VmZjUwClsxMTA5Mi40
ODg4NzhdIC0tLVsgZW5kIHRyYWNlIDZhNmIwZmU3M2E2NmI2M2UgXS0tLQpbMTEwOTIuNDg4
OTczXSBXQVJOSU5HOiBDUFU6IDcgUElEOiAxNjQyIGF0IGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jOjMxMDMgZG1fY3J0Y19o
ZWxwZXJfYXRvbWljX2NoZWNrKzB4NDEvMHg1MCBbYW1kZ3B1XQpbMTEwOTIuNDg4OTc0XSBN
b2R1bGVzIGxpbmtlZCBpbjogZnVzZSBycGNzZWNfZ3NzX2tyYjUgbmZzdjQgbmZzIDgwMjFx
IGdhcnAgbXJwIHN0cCBsbGMgYW1kZ3B1IGk5MTUgY2hhc2ggZ3B1X3NjaGVkIHR0bSBpb3Nm
X21iaSBkcm1fa21zX2hlbHBlciBkcm0geDg2X3BrZ190ZW1wX3RoZXJtYWwga3ZtX2ludGVs
IGhpZF9sZWQga3ZtIGludGVsX2d0dCBpbnB1dF9sZWRzIGZiX3N5c19mb3BzIGxlZF9jbGFz
cyBzeXNjb3B5YXJlYSBzeXNmaWxscmVjdCBpcnFieXBhc3Mgc3lzaW1nYmx0IGNyYzMyY19p
bnRlbCB3bWlfYm1vZiB2aWRlbyB3bWkgbmZzZCBhdXRoX3JwY2dzcyBvaWRfcmVnaXN0cnkg
bmZzX2FjbCBsb2NrZCBncmFjZSBzdW5ycGMgaXBfdGFibGVzIHhfdGFibGVzIHVuaXggaXB2
NiBhdXRvZnM0ClsxMTA5Mi40ODg5ODVdIENQVTogNyBQSUQ6IDE2NDIgQ29tbTogWG9yZyBL
ZHVtcDogbG9hZGVkIFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICA0LjE5LjE5Lm14NjQu
MjQ0ICMxClsxMTA5Mi40ODg5ODVdIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQcmVjaXNp
b24gVG93ZXIgMzYyMC8wTVdZUFQsIEJJT1MgMi4xMS4wIDA3LzE4LzIwMTgKWzExMDkyLjQ4
ODk5OV0gUklQOiAwMDEwOmRtX2NydGNfaGVscGVyX2F0b21pY19jaGVjaysweDQxLzB4NTAg
W2FtZGdwdV0KWzExMDkyLjQ4OTAwMF0gQ29kZTogNDggOGIgNTIgMjggNDggOGIgYmEgNTgg
YTMgMDAgMDAgZTggMDkgZDYgMDcgMDAgODMgZjggMDEgNzUgMWQgMzEgYzAgYzMgZjYgNDYg
MGEgMGUgNzQgZjcgODAgN2UgMDggMDAgNzQgZjEgODAgN2UgMDkgMDAgNzQgZWIgPDBmPiAw
YiBiOCBlYSBmZiBmZiBmZiBjMyBiOCBlYSBmZiBmZiBmZiBjMyA5MCAwZiAxZiA0NCAwMCAw
MCA0MSA1NwpbMTEwOTIuNDg5MDAwXSBSU1A6IDAwMTg6ZmZmZmM5MDAwNWFkM2FkMCBFRkxB
R1M6IDAwMDEwMjAyClsxMTA5Mi40ODkwMDFdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6
IDAwMDAwMDAwMDAwMDAwMDEgUkNYOiBmZmZmZmZmZmEwN2JlYjAwClsxMTA5Mi40ODkwMDFd
IFJEWDogZmZmZjg4ODgwOWYxNTAwMCBSU0k6IGZmZmY4ODg4MThmOWIwMDAgUkRJOiBmZmZm
ODg4ODA0ZDJkMDAwClsxMTA5Mi40ODkwMDJdIFJCUDogZmZmZjg4ODgwNGQyZDAwMCBSMDg6
IDAwMDAwMDAwMDAwMDAwMGMgUjA5OiBmZmZmODg4ODE4NjQ4YTAwClsxMTA5Mi40ODkwMDJd
IFIxMDogZmZmZmM5MDAwNWFkM2E5OCBSMTE6IDAwMDAwMDAwMDAwMDAwMDggUjEyOiBmZmZm
ODg4ODE4YjIyNTgwClsxMTA5Mi40ODkwMDNdIFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6
IGZmZmY4ODg4MThiMjI1ODAgUjE1OiBmZmZmODg4ODE4YjIyNTgwClsxMTA5Mi40ODkwMDNd
IEZTOiAgMDAwMDdmMjI2ZjFmMjljMCgwMDAwKSBHUzpmZmZmODg4ODFkYmMwMDAwKDAwMDAp
IGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWzExMDkyLjQ4OTAwNF0gQ1M6ICAwMDEwIERTOiAw
MDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbMTEwOTIuNDg5MDA0XSBDUjI6
IDAwMDA1NWEwM2Q3Y2E4MGMgQ1IzOiAwMDAwMDAwN2ZkZjQwMDAxIENSNDogMDAwMDAwMDAw
MDM2MDZlMApbMTEwOTIuNDg5MDA1XSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAw
MDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMApbMTEwOTIuNDg5MDA1XSBEUjM6
IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAw
MDAwMDQwMApbMTEwOTIuNDg5MDA2XSBDYWxsIFRyYWNlOgpbMTEwOTIuNDg5MDA4XSAgZHJt
X2F0b21pY19oZWxwZXJfY2hlY2tfcGxhbmVzKzB4MTQzLzB4MWQwIFtkcm1fa21zX2hlbHBl
cl0KWzExMDkyLjQ4OTAyMl0gIGFtZGdwdV9kbV9hdG9taWNfY2hlY2srMHgxYmQvMHgzYzAg
W2FtZGdwdV0KWzExMDkyLjQ4OTAyN10gIGRybV9hdG9taWNfY2hlY2tfb25seSsweDQxNi8w
eDY1MCBbZHJtXQpbMTEwOTIuNDg5MDMwXSAgZHJtX2F0b21pY19jb21taXQrMHgxMy8weDUw
IFtkcm1dClsxMTA5Mi40ODkwMzNdICBkcm1fYXRvbWljX2hlbHBlcl9zZXRfY29uZmlnKzB4
ODAvMHg5MCBbZHJtX2ttc19oZWxwZXJdClsxMTA5Mi40ODkwMzZdICBkcm1fbW9kZV9zZXRj
cnRjKzB4MTZiLzB4NjkwIFtkcm1dClsxMTA5Mi40ODkwNDBdICA/IGRybV9tb2RlX2dldGNy
dGMrMHgxODAvMHgxODAgW2RybV0KWzExMDkyLjQ4OTA0Ml0gIGRybV9pb2N0bF9rZXJuZWwr
MHg4MS8weGYwIFtkcm1dClsxMTA5Mi40ODkwNDVdICBkcm1faW9jdGwrMHgzMDAvMHgzYzAg
W2RybV0KWzExMDkyLjQ4OTA0OF0gID8gZHJtX21vZGVfZ2V0Y3J0YysweDE4MC8weDE4MCBb
ZHJtXQpbMTEwOTIuNDg5MDU1XSAgYW1kZ3B1X2RybV9pb2N0bCsweDQ5LzB4ODAgW2FtZGdw
dV0KWzExMDkyLjQ4OTA1Nl0gIGRvX3Zmc19pb2N0bCsweGE0LzB4NjMwClsxMTA5Mi40ODkw
NThdICA/IHZmc193cml0ZSsweDE1ZS8weDE5MApbMTEwOTIuNDg5MDU5XSAga3N5c19pb2N0
bCsweDNhLzB4NzAKWzExMDkyLjQ4OTA2MF0gIF9feDY0X3N5c19pb2N0bCsweDE2LzB4MjAK
WzExMDkyLjQ4OTA2MV0gIGRvX3N5c2NhbGxfNjQrMHg0OC8weDEwMApbMTEwOTIuNDg5MDYy
XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQpbMTEwOTIuNDg5
MDYzXSBSSVA6IDAwMzM6MHg3ZjIyNmNkNmI2NDcKWzExMDkyLjQ4OTA2M10gQ29kZTogMDAg
MDAgMDAgNDggOGIgMDUgNDEgNTggMmMgMDAgNjQgYzcgMDAgMjYgMDAgMDAgMDAgNDggYzcg
YzAgZmYgZmYgZmYgZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgYjggMTAg
MDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4YiAwZCAx
MSA1OCAyYyAwMCBmNyBkOCA2NCA4OSAwMSA0OApbMTEwOTIuNDg5MDY0XSBSU1A6IDAwMmI6
MDAwMDdmZmMzNjk0MjA2OCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAw
MDAwMDEwClsxMTA5Mi40ODkwNjRdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3
ZmZjMzY5NDIwYTAgUkNYOiAwMDAwN2YyMjZjZDZiNjQ3ClsxMTA5Mi40ODkwNjVdIFJEWDog
MDAwMDdmZmMzNjk0MjBhMCBSU0k6IDAwMDAwMDAwYzA2ODY0YTIgUkRJOiAwMDAwMDAwMDAw
MDAwMDBiClsxMTA5Mi40ODkwNjVdIFJCUDogMDAwMDdmZmMzNjk0MjBhMCBSMDg6IDAwMDAw
MDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAxM2VmZjUwClsxMTA5Mi40ODkwNjZdIFIxMDog
MDAwMDdmZmMzNjk0MjE2MCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMGMw
Njg2NGEyClsxMTA5Mi40ODkwNjZdIFIxMzogMDAwMDAwMDAwMDAwMDAwYiBSMTQ6IDAwMDAw
MDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAxM2VmZjUwClsxMTA5Mi40ODkwNjddIC0tLVsg
ZW5kIHRyYWNlIDZhNmIwZmU3M2E2NmI2M2YgXS0tLQpbMTEwOTIuNDkwNzE3XSBXQVJOSU5H
OiBDUFU6IDcgUElEOiAxNjQyIGF0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jOjMxMDMgZG1fY3J0Y19oZWxwZXJfYXRvbWlj
X2NoZWNrKzB4NDEvMHg1MCBbYW1kZ3B1XQpbMTEwOTIuNDkwNzE3XSBNb2R1bGVzIGxpbmtl
ZCBpbjogZnVzZSBycGNzZWNfZ3NzX2tyYjUgbmZzdjQgbmZzIDgwMjFxIGdhcnAgbXJwIHN0
cCBsbGMgYW1kZ3B1IGk5MTUgY2hhc2ggZ3B1X3NjaGVkIHR0bSBpb3NmX21iaSBkcm1fa21z
X2hlbHBlciBkcm0geDg2X3BrZ190ZW1wX3RoZXJtYWwga3ZtX2ludGVsIGhpZF9sZWQga3Zt
IGludGVsX2d0dCBpbnB1dF9sZWRzIGZiX3N5c19mb3BzIGxlZF9jbGFzcyBzeXNjb3B5YXJl
YSBzeXNmaWxscmVjdCBpcnFieXBhc3Mgc3lzaW1nYmx0IGNyYzMyY19pbnRlbCB3bWlfYm1v
ZiB2aWRlbyB3bWkgbmZzZCBhdXRoX3JwY2dzcyBvaWRfcmVnaXN0cnkgbmZzX2FjbCBsb2Nr
ZCBncmFjZSBzdW5ycGMgaXBfdGFibGVzIHhfdGFibGVzIHVuaXggaXB2NiBhdXRvZnM0Clsx
MTA5Mi40OTA3MjhdIENQVTogNyBQSUQ6IDE2NDIgQ29tbTogWG9yZyBLZHVtcDogbG9hZGVk
IFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICA0LjE5LjE5Lm14NjQuMjQ0ICMxClsxMTA5
Mi40OTA3MjhdIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQcmVjaXNpb24gVG93ZXIgMzYy
MC8wTVdZUFQsIEJJT1MgMi4xMS4wIDA3LzE4LzIwMTgKWzExMDkyLjQ5MDc0NF0gUklQOiAw
MDEwOmRtX2NydGNfaGVscGVyX2F0b21pY19jaGVjaysweDQxLzB4NTAgW2FtZGdwdV0KWzEx
MDkyLjQ5MDc0NF0gQ29kZTogNDggOGIgNTIgMjggNDggOGIgYmEgNTggYTMgMDAgMDAgZTgg
MDkgZDYgMDcgMDAgODMgZjggMDEgNzUgMWQgMzEgYzAgYzMgZjYgNDYgMGEgMGUgNzQgZjcg
ODAgN2UgMDggMDAgNzQgZjEgODAgN2UgMDkgMDAgNzQgZWIgPDBmPiAwYiBiOCBlYSBmZiBm
ZiBmZiBjMyBiOCBlYSBmZiBmZiBmZiBjMyA5MCAwZiAxZiA0NCAwMCAwMCA0MSA1NwpbMTEw
OTIuNDkwNzQ1XSBSU1A6IDAwMTg6ZmZmZmM5MDAwNWFkMzkzMCBFRkxBR1M6IDAwMDEwMjAy
ClsxMTA5Mi40OTA3NDZdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAw
MDAwMDAgUkNYOiBmZmZmZmZmZmEwN2JlYjAwClsxMTA5Mi40OTA3NDZdIFJEWDogZmZmZjg4
ODgwOWYxNTAwMCBSU0k6IGZmZmY4ODg4MDRmMTI0MDAgUkRJOiBmZmZmODg4ODAzZmRmMDAw
ClsxMTA5Mi40OTA3NDddIFJCUDogZmZmZjg4ODgwM2ZkZjAwMCBSMDg6IDAwMDAwMDAwMDAw
MDAwMGMgUjA5OiBmZmZmODg4ODE4NjQ4ZTAwClsxMTA5Mi40OTA3NDddIFIxMDogZmZmZmM5
MDAwNWFkMzhmOCBSMTE6IDAwMDAwMDAwMDAwMDAwMDggUjEyOiBmZmZmODg4ODBhN2NmNDgw
ClsxMTA5Mi40OTA3NDddIFIxMzogZmZmZjg4ODgwNjA0MzAwMCBSMTQ6IGZmZmY4ODg4MGE3
Y2Y0ODAgUjE1OiBmZmZmODg4ODBhN2NmNDgwClsxMTA5Mi40OTA3NDhdIEZTOiAgMDAwMDdm
MjI2ZjFmMjljMCgwMDAwKSBHUzpmZmZmODg4ODFkYmMwMDAwKDAwMDApIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDAKWzExMDkyLjQ5MDc0OV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAw
IENSMDogMDAwMDAwMDA4MDA1MDAzMwpbMTEwOTIuNDkwNzQ5XSBDUjI6IDAwMDAwMDAwMDA4
NGVkYTAgQ1IzOiAwMDAwMDAwN2ZkZjQwMDAxIENSNDogMDAwMDAwMDAwMDM2MDZlMApbMTEw
OTIuNDkwNzUwXSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAw
IERSMjogMDAwMDAwMDAwMDAwMDAwMApbMTEwOTIuNDkwNzUwXSBEUjM6IDAwMDAwMDAwMDAw
MDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMApbMTEw
OTIuNDkwNzUwXSBDYWxsIFRyYWNlOgpbMTEwOTIuNDkwNzUzXSAgZHJtX2F0b21pY19oZWxw
ZXJfY2hlY2tfcGxhbmVzKzB4MTQzLzB4MWQwIFtkcm1fa21zX2hlbHBlcl0KWzExMDkyLjQ5
MDc3MF0gIGFtZGdwdV9kbV9hdG9taWNfY2hlY2srMHgxYmQvMHgzYzAgW2FtZGdwdV0KWzEx
MDkyLjQ5MDc5NV0gIGRybV9hdG9taWNfY2hlY2tfb25seSsweDQxNi8weDY1MCBbZHJtXQpb
MTEwOTIuNDkwNzk5XSAgZHJtX2F0b21pY19jb21taXQrMHgxMy8weDUwIFtkcm1dClsxMTA5
Mi40OTA4MDJdICByZXN0b3JlX2ZiZGV2X21vZGVfYXRvbWljKzB4MWQzLzB4MWYwIFtkcm1f
a21zX2hlbHBlcl0KWzExMDkyLjQ5MDgwNV0gIGRybV9mYl9oZWxwZXJfcmVzdG9yZV9mYmRl
dl9tb2RlX3VubG9ja2VkKzB4NDUvMHg5MCBbZHJtX2ttc19oZWxwZXJdClsxMTA5Mi40OTA4
MDhdICBkcm1fZmJfaGVscGVyX3NldF9wYXIrMHgyOS8weDUwIFtkcm1fa21zX2hlbHBlcl0K
WzExMDkyLjQ5MDgxMF0gIGZiX3NldF92YXIrMHgxNzkvMHgzZTAKWzExMDkyLjQ5MDgxM10g
ID8geGZzX2J1Zl9nZXRfbWFwKzB4NDAvMHgyMTAKWzExMDkyLjQ5MDgxNV0gIGZiY29uX2Js
YW5rKzB4MWY0LzB4MzEwClsxMTA5Mi40OTA4MTddICBkb191bmJsYW5rX3NjcmVlbisweGE4
LzB4MWMwClsxMTA5Mi40OTA4MTldICB2dF9pb2N0bCsweDRkNy8weDExNDAKWzExMDkyLjQ5
MDgyMV0gID8geGZzX2xvZ19jb21taXRfY2lsKzB4NGE5LzB4NWUwClsxMTA5Mi40OTA4MjJd
ICB0dHlfaW9jdGwrMHhmMy8weDg4MApbMTEwOTIuNDkwODI0XSAgPyB4ZnNfaW5hY3RpdmVf
aWZyZWUrMHgxNGMvMHgxYzAKWzExMDkyLjQ5MDgyNV0gID8gX194ZnNfdHJhbnNfY29tbWl0
KzB4ZGEvMHgzNTAKWzExMDkyLjQ5MDgyNl0gIGRvX3Zmc19pb2N0bCsweGE0LzB4NjMwClsx
MTA5Mi40OTA4MjddICA/IF9fZnB1dCsweDExNi8weDFlMApbMTEwOTIuNDkwODI4XSAga3N5
c19pb2N0bCsweDNhLzB4NzAKWzExMDkyLjQ5MDgyOV0gIF9feDY0X3N5c19pb2N0bCsweDE2
LzB4MjAKWzExMDkyLjQ5MDgzMF0gIGRvX3N5c2NhbGxfNjQrMHg0OC8weDEwMApbMTEwOTIu
NDkwODQ4XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQpbMTEw
OTIuNDkwODQ5XSBSSVA6IDAwMzM6MHg3ZjIyNmNkNmI2NDcKWzExMDkyLjQ5MDg1MF0gQ29k
ZTogMDAgMDAgMDAgNDggOGIgMDUgNDEgNTggMmMgMDAgNjQgYzcgMDAgMjYgMDAgMDAgMDAg
NDggYzcgYzAgZmYgZmYgZmYgZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAg
YjggMTAgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4
YiAwZCAxMSA1OCAyYyAwMCBmNyBkOCA2NCA4OSAwMSA0OApbMTEwOTIuNDkwODUwXSBSU1A6
IDAwMmI6MDAwMDdmZmMzNjk0MjNkOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAw
MDAwMDAwMDAwMDEwClsxMTA5Mi40OTA4NTFdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6
IDAwMDAwMDAwMDA4MWE1MjAgUkNYOiAwMDAwN2YyMjZjZDZiNjQ3ClsxMTA5Mi40OTA4NTFd
IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDRiM2EgUkRJOiAwMDAw
MDAwMDAwMDAwMDBhClsxMTA5Mi40OTA4NTJdIFJCUDogMDAwMDAwMDBmZmZmZmZmZiBSMDg6
IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwClsxMTA5Mi40OTA4NTJd
IFIxMDogMDAwMDAwMDAwMDAwMDA1NSBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAw
MDAwMDAwODNiZWEwClsxMTA5Mi40OTA4NTNdIFIxMzogZmZmZmZmZmZmZmZmZmZmZiBSMTQ6
IDAwMDAwMDAwMDA4MzdlNDggUjE1OiBmZmZmZmZmZmZmZmZmZmZmClsxMTA5Mi40OTA4NTNd
IC0tLVsgZW5kIHRyYWNlIDZhNmIwZmU3M2E2NmI2NDAgXS0tLQpbMTM3NDMuNzA3MDM4XSBb
ZHJtXSBETV9NU1Q6IHN0YXJ0aW5nIFRNIG9uIGFjb25uZWN0b3I6IDAwMDAwMDAwNzQzMmY4
MDUgW2lkOiA2Ml0KWzEzNzQzLjczMjQ1MV0gW2RybV0gRE1fTVNUOiBhZGRlZCBjb25uZWN0
b3I6IDAwMDAwMDAwMzdhY2RhMzIgW2lkOiA2M10gW21hc3RlcjogMDAwMDAwMDA3NDMyZjgw
NV0KWzEzNzQzLjc4NjMwOF0gW2RybV0gU0FEcyBjb3VudCBpczogLTIsIGRvbid0IG5lZWQg
dG8gcmVhZCBpdApbMTM3NDQuMTMxMjAzXSBbZHJtXSBETV9NU1Q6IGFkZGVkIGNvbm5lY3Rv
cjogMDAwMDAwMDA2M2MxNzdjMCBbaWQ6IDgzXSBbbWFzdGVyOiAwMDAwMDAwMDc0MzJmODA1
XQpbMTM3NDQuMTkyNDY0XSBbZHJtXSBTQURzIGNvdW50IGlzOiAtMiwgZG9uJ3QgbmVlZCB0
byByZWFkIGl0Cg==
--------------B96CA39EC077B3A65E8E965D
Content-Type: text/x-log;
 name="Xorg-modesetting.0.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="Xorg-modesetting.0.log"

[ 11092.503]=20
X.Org X Server 1.20.4
X Protocol Version 11, Revision 0
[ 11092.503] Build Operating System: Linux 4.19.19.mx64.244 x86_64=20
[ 11092.503] Current Operating System: Linux inbetweenmove.molgen.mpg.de =
4.19.19.mx64.244 #1 SMP Tue Feb 5 13:01:13 CET 2019 x86_64
[ 11092.503] Kernel command line: BOOT_IMAGE=3D/boot/bzImage-4.19.19.mx64=
=2E244 crashkernel=3D256M root=3DLABEL=3Droot ro console=3DttyS1,115200n8=
 console=3Dtty0 init=3D/bin/systemd audit=3D0
[ 11092.503] Build Date: 27 February 2019  12:32:24PM
[ 11092.503] =20
[ 11092.503] Current version of pixman: 0.38.0
[ 11092.503] 	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
[ 11092.503] Markers: (--) probed, (**) from config file, (=3D=3D) defaul=
t setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
[ 11092.503] (=3D=3D) Log file: "/var/log/Xorg.0.log", Time: Wed Mar  6 1=
6:28:52 2019
[ 11092.503] (=3D=3D) Using config directory: "/etc/X11/xorg.conf.d"
[ 11092.503] (=3D=3D) Using system config directory "/usr/share/X11/xorg.=
conf.d"
[ 11092.503] (=3D=3D) No Layout section.  Using the first Screen section.=

[ 11092.503] (=3D=3D) No screen section available. Using defaults.
[ 11092.503] (**) |-->Screen "Default Screen Section" (0)
[ 11092.503] (**) |   |-->Monitor "<default monitor>"
[ 11092.503] (=3D=3D) No monitor specified for screen "Default Screen Sec=
tion".
	Using a default monitor configuration.
[ 11092.503] (**) Option "DRI2" "True"
[ 11092.503] (**) Option "IndirectGLX" "True"
[ 11092.503] (=3D=3D) Automatically adding devices
[ 11092.503] (=3D=3D) Automatically enabling devices
[ 11092.503] (=3D=3D) Automatically adding GPU devices
[ 11092.503] (=3D=3D) Max clients allowed: 256, resource mask: 0x1fffff
[ 11092.503] (=3D=3D) FontPath set to:
	/usr/share/fonts/X11/misc/,
	/usr/share/fonts/X11/TTF/,
	/usr/share/fonts/X11/OTF/,
	/usr/share/fonts/X11/Type1/,
	/usr/share/fonts/X11/100dpi/,
	/usr/share/fonts/X11/75dpi/
[ 11092.503] (=3D=3D) ModulePath set to "/usr/lib/xorg/modules"
[ 11092.503] (II) The server relies on udev to provide the list of input =
devices.
	If no devices become available, reconfigure udev or disable AutoAddDevic=
es.
[ 11092.503] (II) Loader magic: 0x813c40
[ 11092.503] (II) Module ABI versions:
[ 11092.503] 	X.Org ANSI C Emulation: 0.4
[ 11092.503] 	X.Org Video Driver: 24.0
[ 11092.503] 	X.Org XInput driver : 24.1
[ 11092.503] 	X.Org Server Extension : 10.0
[ 11092.504] (II) xfree86: Adding drm device (/dev/dri/card1)
[ 11092.504] (II) xfree86: Adding drm device (/dev/dri/card0)
[ 11092.505] (--) PCI: (0@0:2:0) 8086:5912:1028:06b7 rev 4, Mem @ 0xee000=
000/16777216, 0xc0000000/268435456, I/O @ 0x0000f000/64
[ 11092.505] (--) PCI:*(1@0:0:0) 1002:67c7:1028:0b0d rev 0, Mem @ 0xd0000=
000/268435456, 0xe0000000/2097152, 0xef000000/262144, I/O @ 0x0000e000/25=
6, BIOS @ 0x????????/131072
[ 11092.505] (WW) Open ACPI failed (/var/run/acpid.socket) (No such file =
or directory)
[ 11092.505] (II) LoadModule: "glx"
[ 11092.505] (II) Loading /usr/lib/xorg/modules/extensions/libglx.so
[ 11092.506] (II) Module glx: vendor=3D"X.Org Foundation"
[ 11092.506] 	compiled for 1.20.4, module version =3D 1.0.0
[ 11092.506] 	ABI class: X.Org Server Extension, version 10.0
[ 11092.506] (II) Applying OutputClass "AMDgpu" to /dev/dri/card1
[ 11092.506] 	loading driver: modesetting
[ 11092.506] (=3D=3D) Matched modesetting as autoconfigured driver 0
[ 11092.506] (=3D=3D) Matched ati as autoconfigured driver 1
[ 11092.506] (=3D=3D) Matched intel as autoconfigured driver 2
[ 11092.506] (=3D=3D) Matched fbdev as autoconfigured driver 3
[ 11092.506] (=3D=3D) Matched vesa as autoconfigured driver 4
[ 11092.506] (=3D=3D) Assigned the driver to the xf86ConfigLayout
[ 11092.506] (II) LoadModule: "modesetting"
[ 11092.506] (II) Loading /usr/lib/xorg/modules/drivers/modesetting_drv.s=
o
[ 11092.506] (II) Module modesetting: vendor=3D"X.Org Foundation"
[ 11092.506] 	compiled for 1.20.4, module version =3D 1.20.4
[ 11092.506] 	Module class: X.Org Video Driver
[ 11092.506] 	ABI class: X.Org Video Driver, version 24.0
[ 11092.506] (II) LoadModule: "ati"
[ 11092.506] (WW) Warning, couldn't open module ati
[ 11092.506] (EE) Failed to load module "ati" (module does not exist, 0)
[ 11092.506] (II) LoadModule: "intel"
[ 11092.506] (WW) Warning, couldn't open module intel
[ 11092.506] (EE) Failed to load module "intel" (module does not exist, 0=
)
[ 11092.506] (II) LoadModule: "fbdev"
[ 11092.507] (WW) Warning, couldn't open module fbdev
[ 11092.507] (EE) Failed to load module "fbdev" (module does not exist, 0=
)
[ 11092.507] (II) LoadModule: "vesa"
[ 11092.507] (WW) Warning, couldn't open module vesa
[ 11092.507] (EE) Failed to load module "vesa" (module does not exist, 0)=

[ 11092.507] (II) modesetting: Driver for Modesetting Kernel Drivers: kms=

[ 11092.507] (--) using VT number 3

[ 11092.516] (II) modeset(0): using drv /dev/dri/card1
[ 11092.516] (II) modeset(G0): using drv /dev/dri/card0
[ 11092.516] (II) modeset(0): Creating default Display subsection in Scre=
en section
	"Default Screen Section" for depth/fbbpp 24/32
[ 11092.516] (=3D=3D) modeset(0): Depth 24, (=3D=3D) framebuffer bpp 32
[ 11092.516] (=3D=3D) modeset(0): RGB weight 888
[ 11092.516] (=3D=3D) modeset(0): Default visual is TrueColor
[ 11092.516] (II) Loading sub module "glamoregl"
[ 11092.516] (II) LoadModule: "glamoregl"
[ 11092.516] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[ 11092.522] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[ 11092.522] 	compiled for 1.20.4, module version =3D 1.0.1
[ 11092.522] 	ABI class: X.Org ANSI C Emulation, version 0.4
[ 11092.602] (II) modeset(0): glamor X acceleration enabled on AMD Radeon=
 (TM) Pro WX 5100 Graphics (POLARIS10, DRM 3.27.0, 4.19.19.mx64.244, LLVM=
 7.0.1)
[ 11092.602] (II) modeset(0): glamor initialized
[ 11092.602] (II) modeset(0): Output DP-4 has no monitor section
[ 11092.602] (II) modeset(0): Output DP-5 has no monitor section
[ 11092.602] (II) modeset(0): Output DP-6 has no monitor section
[ 11092.602] (II) modeset(0): Output DP-7 has no monitor section
[ 11092.602] (II) modeset(0): EDID for output DP-4
[ 11092.602] (II) modeset(0): EDID for output DP-5
[ 11092.602] (II) modeset(0): EDID for output DP-6
[ 11092.603] (II) modeset(0): EDID for output DP-7
[ 11092.603] (II) modeset(0): Output DP-4 disconnected
[ 11092.603] (II) modeset(0): Output DP-5 disconnected
[ 11092.603] (II) modeset(0): Output DP-6 disconnected
[ 11092.603] (II) modeset(0): Output DP-7 disconnected
[ 11092.603] (WW) modeset(0): No outputs definitely connected, trying aga=
in...
[ 11092.603] (II) modeset(0): Output DP-4 disconnected
[ 11092.603] (II) modeset(0): Output DP-5 disconnected
[ 11092.603] (II) modeset(0): Output DP-6 disconnected
[ 11092.603] (II) modeset(0): Output DP-7 disconnected
[ 11092.603] (WW) modeset(0): Unable to find connected outputs - setting =
1024x768 initial framebuffer
[ 11092.603] (=3D=3D) modeset(0): Using gamma correction (1.0, 1.0, 1.0)
[ 11092.603] (=3D=3D) modeset(0): DPI set to (96, 96)
[ 11092.603] (II) Loading sub module "fb"
[ 11092.603] (II) LoadModule: "fb"
[ 11092.603] (II) Loading /usr/lib/xorg/modules/libfb.so
[ 11092.603] (II) Module fb: vendor=3D"X.Org Foundation"
[ 11092.603] 	compiled for 1.20.4, module version =3D 1.0.0
[ 11092.603] 	ABI class: X.Org ANSI C Emulation, version 0.4
[ 11092.603] (=3D=3D) modeset(G0): Depth 24, (=3D=3D) framebuffer bpp 32
[ 11092.603] (=3D=3D) modeset(G0): RGB weight 888
[ 11092.603] (=3D=3D) modeset(G0): Default visual is TrueColor
[ 11092.603] (II) Loading sub module "glamoregl"
[ 11092.603] (II) LoadModule: "glamoregl"
[ 11092.603] (II) Loading /usr/lib/xorg/modules/libglamoregl.so
[ 11092.603] (II) Module glamoregl: vendor=3D"X.Org Foundation"
[ 11092.603] 	compiled for 1.20.4, module version =3D 1.0.1
[ 11092.603] 	ABI class: X.Org ANSI C Emulation, version 0.4
[ 11092.608] (II) modeset(G0): glamor X acceleration enabled on Mesa DRI =
Intel(R) HD Graphics 630 (Kaby Lake GT2)=20
[ 11092.608] (II) modeset(G0): glamor initialized
[ 11092.613] (II) modeset(G0): Output HDMI-1-1 has no monitor section
[ 11092.614] (II) modeset(G0): Output DP-1-1 has no monitor section
[ 11092.618] (II) modeset(G0): Output HDMI-1-2 has no monitor section
[ 11092.618] (II) modeset(G0): Output DP-1-2 has no monitor section
[ 11092.624] (II) modeset(G0): Output HDMI-1-3 has no monitor section
[ 11092.624] (II) modeset(G0): Output DP-1-3 has no monitor section
[ 11092.629] (II) modeset(G0): EDID for output HDMI-1-1
[ 11092.629] (II) modeset(G0): EDID for output DP-1-1
[ 11092.635] (II) modeset(G0): EDID for output HDMI-1-2
[ 11092.635] (II) modeset(G0): EDID for output DP-1-2
[ 11092.640] (II) modeset(G0): EDID for output HDMI-1-3
[ 11092.640] (II) modeset(G0): EDID for output DP-1-3
[ 11092.640] (=3D=3D) modeset(G0): Using gamma correction (1.0, 1.0, 1.0)=

[ 11092.640] (=3D=3D) modeset(G0): DPI set to (96, 96)
[ 11092.640] (II) Loading sub module "fb"
[ 11092.640] (II) LoadModule: "fb"
[ 11092.640] (II) Loading /usr/lib/xorg/modules/libfb.so
[ 11092.640] (II) Module fb: vendor=3D"X.Org Foundation"
[ 11092.640] 	compiled for 1.20.4, module version =3D 1.0.0
[ 11092.640] 	ABI class: X.Org ANSI C Emulation, version 0.4
[ 11092.641] (=3D=3D) modeset(G0): Backing store enabled
[ 11092.641] (=3D=3D) modeset(G0): Silken mouse enabled
[ 11092.641] (II) modeset(G0): Initializing kms color map for depth 24, 8=
 bpc.
[ 11092.641] (=3D=3D) modeset(G0): DPMS enabled
[ 11092.641] (II) modeset(G0): [DRI2] Setup complete
[ 11092.641] (II) modeset(G0): [DRI2]   DRI driver: i965
[ 11092.641] (II) modeset(G0): [DRI2]   VDPAU driver: i965
[ 11092.643] (=3D=3D) modeset(0): Backing store enabled
[ 11092.643] (=3D=3D) modeset(0): Silken mouse enabled
[ 11092.643] (II) modeset(0): Initializing kms color map for depth 24, 8 =
bpc.
[ 11092.643] (=3D=3D) modeset(0): DPMS enabled
[ 11092.643] (II) modeset(0): [DRI2] Setup complete
[ 11092.643] (II) modeset(0): [DRI2]   DRI driver: radeonsi
[ 11092.643] (II) modeset(0): [DRI2]   VDPAU driver: radeonsi
[ 11092.643] (II) Initializing extension Generic Event Extension
[ 11092.643] (II) Initializing extension SHAPE
[ 11092.643] (II) Initializing extension MIT-SHM
[ 11092.643] (II) Initializing extension XInputExtension
[ 11092.643] (II) Initializing extension XTEST
[ 11092.643] (II) Initializing extension BIG-REQUESTS
[ 11092.643] (II) Initializing extension SYNC
[ 11092.643] (II) Initializing extension XKEYBOARD
[ 11092.643] (II) Initializing extension XC-MISC
[ 11092.643] (II) Initializing extension XFIXES
[ 11092.643] (II) Initializing extension RENDER
[ 11092.643] (II) Initializing extension RANDR
[ 11092.643] (II) Initializing extension COMPOSITE
[ 11092.643] (II) Initializing extension DAMAGE
[ 11092.643] (II) Initializing extension MIT-SCREEN-SAVER
[ 11092.643] (II) Initializing extension DOUBLE-BUFFER
[ 11092.643] (II) Initializing extension RECORD
[ 11092.643] (II) Initializing extension DPMS
[ 11092.643] (II) Initializing extension Present
[ 11092.643] (II) Initializing extension DRI3
[ 11092.643] (II) Initializing extension X-Resource
[ 11092.643] (II) Initializing extension XVideo
[ 11092.643] (II) Initializing extension XVideo-MotionCompensation
[ 11092.643] (II) Initializing extension GLX
[ 11092.646] (II) AIGLX: Loaded and initialized radeonsi
[ 11092.646] (II) GLX: Initialized DRI2 GL provider for screen 0
[ 11092.646] (II) Initializing extension XFree86-VidModeExtension
[ 11092.646] (II) Initializing extension XFree86-DGA
[ 11092.646] (II) Initializing extension XFree86-DRI
[ 11092.646] (II) Initializing extension DRI2
[ 11092.647] (II) modeset(G0): Damage tracking initialized
[ 11092.648] (II) modeset(0): Damage tracking initialized
[ 11092.688] (II) config/udev: Adding input device Power Button (/dev/inp=
ut/event2)
[ 11092.688] (**) Power Button: Applying InputClass "evdev keyboard catch=
all"
[ 11092.688] (II) LoadModule: "evdev"
[ 11092.688] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[ 11092.688] (II) Module evdev: vendor=3D"X.Org Foundation"
[ 11092.688] 	compiled for 1.19.6, module version =3D 2.10.5
[ 11092.688] 	Module class: X.Org XInput Driver
[ 11092.688] 	ABI class: X.Org XInput driver, version 24.1
[ 11092.688] (II) Using input driver 'evdev' for 'Power Button'
[ 11092.688] (**) Power Button: always reports core events
[ 11092.688] (**) evdev: Power Button: Device: "/dev/input/event2"
[ 11092.688] (--) evdev: Power Button: Vendor 0 Product 0x1
[ 11092.688] (--) evdev: Power Button: Found keys
[ 11092.688] (II) evdev: Power Button: Configuring as keyboard
[ 11092.688] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
PWRBN:00/input/input2/event2"
[ 11092.688] (II) XINPUT: Adding extended input device "Power Button" (ty=
pe: KEYBOARD, id 6)
[ 11092.688] (**) Option "xkb_rules" "evdev"
[ 11092.688] (II) config/udev: Adding input device Video Bus (/dev/input/=
event11)
[ 11092.688] (**) Video Bus: Applying InputClass "evdev keyboard catchall=
"
[ 11092.689] (II) Using input driver 'evdev' for 'Video Bus'
[ 11092.689] (**) Video Bus: always reports core events
[ 11092.689] (**) evdev: Video Bus: Device: "/dev/input/event11"
[ 11092.689] (--) evdev: Video Bus: Vendor 0 Product 0x6
[ 11092.689] (--) evdev: Video Bus: Found keys
[ 11092.689] (II) evdev: Video Bus: Configuring as keyboard
[ 11092.689] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input14/event11"
[ 11092.689] (II) XINPUT: Adding extended input device "Video Bus" (type:=
 KEYBOARD, id 7)
[ 11092.689] (**) Option "xkb_rules" "evdev"
[ 11092.689] (II) config/udev: Adding input device Power Button (/dev/inp=
ut/event1)
[ 11092.689] (**) Power Button: Applying InputClass "evdev keyboard catch=
all"
[ 11092.689] (II) Using input driver 'evdev' for 'Power Button'
[ 11092.689] (**) Power Button: always reports core events
[ 11092.689] (**) evdev: Power Button: Device: "/dev/input/event1"
[ 11092.689] (--) evdev: Power Button: Vendor 0 Product 0x1
[ 11092.689] (--) evdev: Power Button: Found keys
[ 11092.689] (II) evdev: Power Button: Configuring as keyboard
[ 11092.689] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0C0C:00/input/input1/event1"
[ 11092.689] (II) XINPUT: Adding extended input device "Power Button" (ty=
pe: KEYBOARD, id 8)
[ 11092.689] (**) Option "xkb_rules" "evdev"
[ 11092.689] (II) config/udev: Adding input device Sleep Button (/dev/inp=
ut/event0)
[ 11092.689] (**) Sleep Button: Applying InputClass "evdev keyboard catch=
all"
[ 11092.689] (II) Using input driver 'evdev' for 'Sleep Button'
[ 11092.689] (**) Sleep Button: always reports core events
[ 11092.689] (**) evdev: Sleep Button: Device: "/dev/input/event0"
[ 11092.689] (--) evdev: Sleep Button: Vendor 0 Product 0x3
[ 11092.689] (--) evdev: Sleep Button: Found keys
[ 11092.689] (II) evdev: Sleep Button: Configuring as keyboard
[ 11092.689] (**) Option "config_info" "udev:/sys/devices/LNXSYSTM:00/LNX=
SYBUS:00/PNP0C0E:00/input/input0/event0"
[ 11092.689] (II) XINPUT: Adding extended input device "Sleep Button" (ty=
pe: KEYBOARD, id 9)
[ 11092.689] (**) Option "xkb_rules" "evdev"
[ 11092.690] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D3 (/dev/input/event3)
[ 11092.690] (II) No input driver specified, ignoring this device.
[ 11092.690] (II) This device may have been added with another device fil=
e.
[ 11092.690] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D7 (/dev/input/event4)
[ 11092.690] (II) No input driver specified, ignoring this device.
[ 11092.690] (II) This device may have been added with another device fil=
e.
[ 11092.690] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D8 (/dev/input/event5)
[ 11092.690] (II) No input driver specified, ignoring this device.
[ 11092.690] (II) This device may have been added with another device fil=
e.
[ 11092.690] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D9 (/dev/input/event6)
[ 11092.690] (II) No input driver specified, ignoring this device.
[ 11092.690] (II) This device may have been added with another device fil=
e.
[ 11092.690] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D10 (/dev/input/event7)
[ 11092.690] (II) No input driver specified, ignoring this device.
[ 11092.690] (II) This device may have been added with another device fil=
e.
[ 11092.690] (II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,p=
cm=3D11 (/dev/input/event8)
[ 11092.690] (II) No input driver specified, ignoring this device.
[ 11092.691] (II) This device may have been added with another device fil=
e.
[ 11092.691] (II) config/udev: Adding input device Dell Dell USB Entry Ke=
yboard (/dev/input/event9)
[ 11092.691] (**) Dell Dell USB Entry Keyboard: Applying InputClass "evde=
v keyboard catchall"
[ 11092.691] (II) Using input driver 'evdev' for 'Dell Dell USB Entry Key=
board'
[ 11092.691] (**) Dell Dell USB Entry Keyboard: always reports core event=
s
[ 11092.691] (**) evdev: Dell Dell USB Entry Keyboard: Device: "/dev/inpu=
t/event9"
[ 11092.691] (--) evdev: Dell Dell USB Entry Keyboard: Vendor 0x413c Prod=
uct 0x2107
[ 11092.691] (--) evdev: Dell Dell USB Entry Keyboard: Found keys
[ 11092.691] (II) evdev: Dell Dell USB Entry Keyboard: Configuring as key=
board
[ 11092.691] (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000=
:00:14.0/usb1/1-4/1-4:1.0/0003:413C:2107.0002/input/input12/event9"
[ 11092.691] (II) XINPUT: Adding extended input device "Dell Dell USB Ent=
ry Keyboard" (type: KEYBOARD, id 10)
[ 11092.691] (**) Option "xkb_rules" "evdev"
[ 11092.691] (II) config/udev: Adding input device Logitech USB Optical M=
ouse (/dev/input/event10)
[ 11092.691] (**) Logitech USB Optical Mouse: Applying InputClass "evdev =
pointer catchall"
[ 11092.691] (II) Using input driver 'evdev' for 'Logitech USB Optical Mo=
use'
[ 11092.691] (**) Logitech USB Optical Mouse: always reports core events
[ 11092.691] (**) evdev: Logitech USB Optical Mouse: Device: "/dev/input/=
event10"
[ 11092.691] (--) evdev: Logitech USB Optical Mouse: Vendor 0x46d Product=
 0xc05a
[ 11092.691] (--) evdev: Logitech USB Optical Mouse: Found 12 mouse butto=
ns
[ 11092.691] (--) evdev: Logitech USB Optical Mouse: Found scroll wheel(s=
)
[ 11092.691] (--) evdev: Logitech USB Optical Mouse: Found relative axes
[ 11092.691] (--) evdev: Logitech USB Optical Mouse: Found x and y relati=
ve axes
[ 11092.691] (II) evdev: Logitech USB Optical Mouse: Configuring as mouse=

[ 11092.691] (II) evdev: Logitech USB Optical Mouse: Adding scrollwheel s=
upport
[ 11092.691] (**) evdev: Logitech USB Optical Mouse: YAxisMapping: button=
s 4 and 5
[ 11092.691] (**) evdev: Logitech USB Optical Mouse: EmulateWheelButton: =
4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[ 11092.691] (**) Option "config_info" "udev:/sys/devices/pci0000:00/0000=
:00:14.0/usb1/1-5/1-5:1.0/0003:046D:C05A.0003/input/input13/event10"
[ 11092.691] (II) XINPUT: Adding extended input device "Logitech USB Opti=
cal Mouse" (type: MOUSE, id 11)
[ 11092.692] (II) evdev: Logitech USB Optical Mouse: initialized for rela=
tive axes.
[ 11092.692] (**) Logitech USB Optical Mouse: (accel) keeping acceleratio=
n scheme 1
[ 11092.692] (**) Logitech USB Optical Mouse: (accel) acceleration profil=
e 0
[ 11092.692] (**) Logitech USB Optical Mouse: (accel) acceleration factor=
: 2.000
[ 11092.692] (**) Logitech USB Optical Mouse: (accel) acceleration thresh=
old: 4
[ 11092.692] (II) config/udev: Adding input device HDA Intel PCH Front Mi=
c (/dev/input/event12)
[ 11092.692] (II) No input driver specified, ignoring this device.
[ 11092.692] (II) This device may have been added with another device fil=
e.
[ 11092.692] (II) config/udev: Adding input device HDA Intel PCH Rear Mic=
 (/dev/input/event13)
[ 11092.692] (II) No input driver specified, ignoring this device.
[ 11092.692] (II) This device may have been added with another device fil=
e.
[ 11092.692] (II) config/udev: Adding input device HDA Intel PCH Line Out=
 (/dev/input/event14)
[ 11092.692] (II) No input driver specified, ignoring this device.
[ 11092.692] (II) This device may have been added with another device fil=
e.
[ 11092.692] (II) config/udev: Adding input device HDA Intel PCH Front He=
adphone (/dev/input/event15)
[ 11092.692] (II) No input driver specified, ignoring this device.
[ 11092.692] (II) This device may have been added with another device fil=
e.
[ 13743.777] (II) modeset(0): Output DP-8 has no monitor section
[ 13743.810] (II) modeset(0): Allocate new frame buffer 1920x2160 stride
[ 13744.067] (II) modeset(0): Disabling kernel dirty updates, not require=
d.
[ 13744.183] (II) modeset(0): Output DP-9 has no monitor section
[ 13744.215] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13744.215] (II) modeset(0): Using EDID range info for horizontal sync
[ 13744.215] (II) modeset(0): Using EDID range info for vertical refresh
[ 13744.215] (II) modeset(0): Printing DDC gathered Modelines:
[ 13744.215] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13744.217] (II) modeset(0): Allocate new frame buffer 3840x2160 stride
[ 13862.632] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13862.632] (II) modeset(0): Using hsync ranges from config file
[ 13862.632] (II) modeset(0): Using vrefresh ranges from config file
[ 13862.632] (II) modeset(0): Printing DDC gathered Modelines:
[ 13862.632] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13862.644] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13862.644] (II) modeset(0): Using hsync ranges from config file
[ 13862.644] (II) modeset(0): Using vrefresh ranges from config file
[ 13862.644] (II) modeset(0): Printing DDC gathered Modelines:
[ 13862.644] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13862.645] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13862.645] (II) modeset(0): Using hsync ranges from config file
[ 13862.645] (II) modeset(0): Using vrefresh ranges from config file
[ 13862.645] (II) modeset(0): Printing DDC gathered Modelines:
[ 13862.645] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.415] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13863.415] (II) modeset(0): Using hsync ranges from config file
[ 13863.415] (II) modeset(0): Using vrefresh ranges from config file
[ 13863.415] (II) modeset(0): Printing DDC gathered Modelines:
[ 13863.415] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.416] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13863.416] (II) modeset(0): Using hsync ranges from config file
[ 13863.416] (II) modeset(0): Using vrefresh ranges from config file
[ 13863.416] (II) modeset(0): Printing DDC gathered Modelines:
[ 13863.416] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.417] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13863.418] (II) modeset(0): Using hsync ranges from config file
[ 13863.418] (II) modeset(0): Using vrefresh ranges from config file
[ 13863.418] (II) modeset(0): Printing DDC gathered Modelines:
[ 13863.418] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.418] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13863.418] (II) modeset(0): Using hsync ranges from config file
[ 13863.418] (II) modeset(0): Using vrefresh ranges from config file
[ 13863.418] (II) modeset(0): Printing DDC gathered Modelines:
[ 13863.418] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.420] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13863.420] (II) modeset(0): Using hsync ranges from config file
[ 13863.420] (II) modeset(0): Using vrefresh ranges from config file
[ 13863.420] (II) modeset(0): Printing DDC gathered Modelines:
[ 13863.420] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.420] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13863.420] (II) modeset(0): Using hsync ranges from config file
[ 13863.420] (II) modeset(0): Using vrefresh ranges from config file
[ 13863.420] (II) modeset(0): Printing DDC gathered Modelines:
[ 13863.420] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.421] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13863.422] (II) modeset(0): Using hsync ranges from config file
[ 13863.422] (II) modeset(0): Using vrefresh ranges from config file
[ 13863.422] (II) modeset(0): Printing DDC gathered Modelines:
[ 13863.422] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.423] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13863.423] (II) modeset(0): Using hsync ranges from config file
[ 13863.423] (II) modeset(0): Using vrefresh ranges from config file
[ 13863.423] (II) modeset(0): Printing DDC gathered Modelines:
[ 13863.423] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.424] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13863.424] (II) modeset(0): Using hsync ranges from config file
[ 13863.424] (II) modeset(0): Using vrefresh ranges from config file
[ 13863.424] (II) modeset(0): Printing DDC gathered Modelines:
[ 13863.424] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.425] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13863.425] (II) modeset(0): Using hsync ranges from config file
[ 13863.425] (II) modeset(0): Using vrefresh ranges from config file
[ 13863.425] (II) modeset(0): Printing DDC gathered Modelines:
[ 13863.425] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13863.540] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.540] (EE) modeset(0): present flip failed
[ 13863.551] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.551] (EE) modeset(0): present flip failed
[ 13863.585] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.585] (EE) modeset(0): present flip failed
[ 13863.613] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.613] (EE) modeset(0): present flip failed
[ 13863.638] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.638] (EE) modeset(0): present flip failed
[ 13863.657] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.657] (EE) modeset(0): present flip failed
[ 13863.674] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.674] (EE) modeset(0): present flip failed
[ 13863.689] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.690] (EE) modeset(0): present flip failed
[ 13863.715] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.715] (EE) modeset(0): present flip failed
[ 13863.741] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.742] (EE) modeset(0): present flip failed
[ 13863.765] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.765] (EE) modeset(0): present flip failed
[ 13863.839] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.839] (EE) modeset(0): present flip failed
[ 13863.865] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.865] (EE) modeset(0): present flip failed
[ 13863.882] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.882] (EE) modeset(0): present flip failed
[ 13863.898] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.898] (EE) modeset(0): present flip failed
[ 13863.915] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.915] (EE) modeset(0): present flip failed
[ 13863.932] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.932] (EE) modeset(0): present flip failed
[ 13863.949] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.949] (EE) modeset(0): present flip failed
[ 13863.964] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.964] (EE) modeset(0): present flip failed
[ 13863.982] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.982] (EE) modeset(0): present flip failed
[ 13863.999] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13863.999] (EE) modeset(0): present flip failed
[ 13864.015] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.015] (EE) modeset(0): present flip failed
[ 13864.032] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.032] (EE) modeset(0): present flip failed
[ 13864.049] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.049] (EE) modeset(0): present flip failed
[ 13864.065] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.065] (EE) modeset(0): present flip failed
[ 13864.081] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.081] (EE) modeset(0): present flip failed
[ 13864.099] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.099] (EE) modeset(0): present flip failed
[ 13864.115] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.115] (EE) modeset(0): present flip failed
[ 13864.132] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.132] (EE) modeset(0): present flip failed
[ 13864.149] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.149] (EE) modeset(0): present flip failed
[ 13864.176] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.176] (EE) modeset(0): present flip failed
[ 13864.211] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.211] (EE) modeset(0): present flip failed
[ 13864.222] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.222] (EE) modeset(0): present flip failed
[ 13864.239] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.239] (EE) modeset(0): present flip failed
[ 13864.302] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.302] (EE) modeset(0): present flip failed
[ 13864.320] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.320] (EE) modeset(0): present flip failed
[ 13864.336] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.336] (EE) modeset(0): present flip failed
[ 13864.353] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.353] (EE) modeset(0): present flip failed
[ 13864.370] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.370] (EE) modeset(0): present flip failed
[ 13864.385] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.385] (EE) modeset(0): present flip failed
[ 13864.403] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.403] (EE) modeset(0): present flip failed
[ 13864.419] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.419] (EE) modeset(0): present flip failed
[ 13864.435] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13864.435] (EE) modeset(0): present flip failed
[ 13872.567] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13872.567] (EE) modeset(0): present flip failed
[ 13872.585] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13872.585] (EE) modeset(0): present flip failed
[ 13872.606] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13872.606] (EE) modeset(0): present flip failed
[ 13872.621] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13872.621] (EE) modeset(0): present flip failed
[ 13873.520] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13873.520] (EE) modeset(0): present flip failed
[ 13873.798] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13873.798] (EE) modeset(0): present flip failed
[ 13873.918] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13873.918] (EE) modeset(0): present flip failed
[ 13874.095] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13874.095] (EE) modeset(0): present flip failed
[ 13874.158] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13874.158] (EE) modeset(0): present flip failed
[ 13874.247] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13874.247] (EE) modeset(0): present flip failed
[ 13874.277] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13874.277] (EE) modeset(0): present flip failed
[ 13874.948] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13874.948] (II) modeset(0): Using hsync ranges from config file
[ 13874.948] (II) modeset(0): Using vrefresh ranges from config file
[ 13874.948] (II) modeset(0): Printing DDC gathered Modelines:
[ 13874.948] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13874.950] (II) modeset(0): EDID vendor "DEL", prod id 16531
[ 13874.950] (II) modeset(0): Using hsync ranges from config file
[ 13874.950] (II) modeset(0): Using vrefresh ranges from config file
[ 13874.950] (II) modeset(0): Printing DDC gathered Modelines:
[ 13874.950] (II) modeset(0): Modeline "1920x2160"x0.0  277.25  1920 1968=
 2000 2080  2160 2163 2173 2222 +hsync -vsync (133.3 kHz eP)
[ 13874.968] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13874.968] (EE) modeset(0): present flip failed
[ 13874.984] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13874.984] (EE) modeset(0): present flip failed
[ 13883.463] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13883.463] (EE) modeset(0): present flip failed
[ 13883.927] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13883.927] (EE) modeset(0): present flip failed
[ 13884.039] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13884.039] (EE) modeset(0): present flip failed
[ 13884.103] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13884.103] (EE) modeset(0): present flip failed
[ 13884.183] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13884.183] (EE) modeset(0): present flip failed
[ 13884.335] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13884.335] (EE) modeset(0): present flip failed
[ 13884.887] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13884.887] (EE) modeset(0): present flip failed
[ 13884.918] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13884.918] (EE) modeset(0): present flip failed
[ 13885.047] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13885.047] (EE) modeset(0): present flip failed
[ 13885.808] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13885.808] (EE) modeset(0): present flip failed
[ 13885.824] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13885.824] (EE) modeset(0): present flip failed
[ 13886.583] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13886.583] (EE) modeset(0): present flip failed
[ 13887.791] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13887.791] (EE) modeset(0): present flip failed
[ 13887.943] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13887.943] (EE) modeset(0): present flip failed
[ 13888.063] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13888.063] (EE) modeset(0): present flip failed
[ 13888.199] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13888.199] (EE) modeset(0): present flip failed
[ 13888.343] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13888.343] (EE) modeset(0): present flip failed
[ 13888.479] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13888.479] (EE) modeset(0): present flip failed
[ 13888.623] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13888.623] (EE) modeset(0): present flip failed
[ 13888.759] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13888.759] (EE) modeset(0): present flip failed
[ 13889.103] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13889.103] (EE) modeset(0): present flip failed
[ 13889.332] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13889.332] (EE) modeset(0): present flip failed
[ 13889.928] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13889.929] (EE) modeset(0): present flip failed
[ 13889.944] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13889.944] (EE) modeset(0): present flip failed
[ 13891.354] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13891.354] (EE) modeset(0): present flip failed
[ 13891.370] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13891.370] (EE) modeset(0): present flip failed
[ 13891.395] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13891.395] (EE) modeset(0): present flip failed
[ 13891.453] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13891.453] (EE) modeset(0): present flip failed
[ 13892.177] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.177] (EE) modeset(0): present flip failed
[ 13892.192] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.192] (EE) modeset(0): present flip failed
[ 13892.361] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.361] (EE) modeset(0): present flip failed
[ 13892.377] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.377] (EE) modeset(0): present flip failed
[ 13892.496] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.496] (EE) modeset(0): present flip failed
[ 13892.512] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.512] (EE) modeset(0): present flip failed
[ 13892.633] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.633] (EE) modeset(0): present flip failed
[ 13892.648] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.648] (EE) modeset(0): present flip failed
[ 13892.785] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.785] (EE) modeset(0): present flip failed
[ 13892.800] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.800] (EE) modeset(0): present flip failed
[ 13892.929] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.929] (EE) modeset(0): present flip failed
[ 13892.945] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13892.945] (EE) modeset(0): present flip failed
[ 13893.073] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.073] (EE) modeset(0): present flip failed
[ 13893.089] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.089] (EE) modeset(0): present flip failed
[ 13893.217] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.217] (EE) modeset(0): present flip failed
[ 13893.232] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.232] (EE) modeset(0): present flip failed
[ 13893.369] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.369] (EE) modeset(0): present flip failed
[ 13893.395] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.395] (EE) modeset(0): present flip failed
[ 13893.529] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.529] (EE) modeset(0): present flip failed
[ 13893.545] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.545] (EE) modeset(0): present flip failed
[ 13893.673] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.673] (EE) modeset(0): present flip failed
[ 13893.689] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.689] (EE) modeset(0): present flip failed
[ 13893.848] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.848] (EE) modeset(0): present flip failed
[ 13893.864] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13893.864] (EE) modeset(0): present flip failed
[ 13894.423] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13894.423] (EE) modeset(0): present flip failed
[ 13894.924] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13894.924] (EE) modeset(0): present flip failed
[ 13894.955] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13894.955] (EE) modeset(0): present flip failed
[ 13897.025] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13897.025] (EE) modeset(0): present flip failed
[ 13897.456] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13897.456] (EE) modeset(0): present flip failed
[ 13898.017] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13898.017] (EE) modeset(0): present flip failed
[ 13898.032] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13898.032] (EE) modeset(0): present flip failed
[ 13899.240] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13899.240] (EE) modeset(0): present flip failed
[ 13899.448] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13899.448] (EE) modeset(0): present flip failed
[ 13899.592] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13899.592] (EE) modeset(0): present flip failed
[ 13899.744] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13899.744] (EE) modeset(0): present flip failed
[ 13900.249] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13900.249] (EE) modeset(0): present flip failed
[ 13900.264] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13900.264] (EE) modeset(0): present flip failed
[ 13901.128] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13901.128] (EE) modeset(0): present flip failed
[ 13901.776] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13901.776] (EE) modeset(0): present flip failed
[ 13901.960] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13901.960] (EE) modeset(0): present flip failed
[ 13902.112] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13902.112] (EE) modeset(0): present flip failed
[ 13902.280] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13902.280] (EE) modeset(0): present flip failed
[ 13902.448] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13902.448] (EE) modeset(0): present flip failed
[ 13902.600] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13902.600] (EE) modeset(0): present flip failed
[ 13902.752] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13902.752] (EE) modeset(0): present flip failed
[ 13902.919] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13902.919] (EE) modeset(0): present flip failed
[ 13903.079] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13903.079] (EE) modeset(0): present flip failed
[ 13903.239] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13903.239] (EE) modeset(0): present flip failed
[ 13903.391] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13903.391] (EE) modeset(0): present flip failed
[ 13920.705] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13920.705] (EE) modeset(0): present flip failed
[ 13927.641] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13927.641] (EE) modeset(0): present flip failed
[ 13927.656] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13927.656] (EE) modeset(0): present flip failed
[ 13927.927] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13927.927] (EE) modeset(0): present flip failed
[ 13928.751] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13928.751] (EE) modeset(0): present flip failed
[ 13929.151] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13929.151] (EE) modeset(0): present flip failed
[ 13929.463] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13929.463] (EE) modeset(0): present flip failed
[ 13929.719] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13929.719] (EE) modeset(0): present flip failed
[ 13929.791] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13929.791] (EE) modeset(0): present flip failed
[ 13930.224] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13930.225] (EE) modeset(0): present flip failed
[ 13931.296] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13931.296] (EE) modeset(0): present flip failed
[ 13931.584] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13931.584] (EE) modeset(0): present flip failed
[ 13931.808] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13931.808] (EE) modeset(0): present flip failed
[ 13931.968] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13931.968] (EE) modeset(0): present flip failed
[ 13932.376] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13932.376] (EE) modeset(0): present flip failed
[ 13932.472] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13932.472] (EE) modeset(0): present flip failed
[ 13932.899] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13932.899] (EE) modeset(0): present flip failed
[ 13932.915] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13932.915] (EE) modeset(0): present flip failed
[ 13933.729] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13933.729] (EE) modeset(0): present flip failed
[ 13934.744] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13934.744] (EE) modeset(0): present flip failed
[ 13935.008] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13935.008] (EE) modeset(0): present flip failed
[ 13935.168] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13935.168] (EE) modeset(0): present flip failed
[ 13935.257] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13935.257] (EE) modeset(0): present flip failed
[ 13935.329] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13935.329] (EE) modeset(0): present flip failed
[ 13935.890] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13935.890] (EE) modeset(0): present flip failed
[ 13940.440] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13940.440] (EE) modeset(0): present flip failed
[ 13940.690] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13940.690] (EE) modeset(0): present flip failed
[ 13940.706] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13940.706] (EE) modeset(0): present flip failed
[ 13940.874] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13940.874] (EE) modeset(0): present flip failed
[ 13940.890] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13940.890] (EE) modeset(0): present flip failed
[ 13941.082] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13941.082] (EE) modeset(0): present flip failed
[ 13941.098] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13941.098] (EE) modeset(0): present flip failed
[ 13941.258] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13941.258] (EE) modeset(0): present flip failed
[ 13941.273] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13941.273] (EE) modeset(0): present flip failed
[ 13941.458] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13941.458] (EE) modeset(0): present flip failed
[ 13941.473] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13941.473] (EE) modeset(0): present flip failed
[ 13941.958] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13941.958] (EE) modeset(0): present flip failed
[ 13941.973] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13941.973] (EE) modeset(0): present flip failed
[ 13942.006] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.006] (EE) modeset(0): present flip failed
[ 13942.058] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.058] (EE) modeset(0): present flip failed
[ 13942.073] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.073] (EE) modeset(0): present flip failed
[ 13942.104] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.104] (EE) modeset(0): present flip failed
[ 13942.172] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.172] (EE) modeset(0): present flip failed
[ 13942.203] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.203] (EE) modeset(0): present flip failed
[ 13942.272] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.272] (EE) modeset(0): present flip failed
[ 13942.303] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.303] (EE) modeset(0): present flip failed
[ 13942.372] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.372] (EE) modeset(0): present flip failed
[ 13942.403] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.403] (EE) modeset(0): present flip failed
[ 13942.473] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.473] (EE) modeset(0): present flip failed
[ 13942.504] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.504] (EE) modeset(0): present flip failed
[ 13942.574] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13942.574] (EE) modeset(0): present flip failed
[ 13943.322] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13943.322] (EE) modeset(0): present flip failed
[ 13943.338] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13943.338] (EE) modeset(0): present flip failed
[ 13944.680] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13944.680] (EE) modeset(0): present flip failed
[ 13945.000] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13945.000] (EE) modeset(0): present flip failed
[ 13945.137] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13945.137] (EE) modeset(0): present flip failed
[ 13945.224] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13945.224] (EE) modeset(0): present flip failed
[ 13945.345] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13945.345] (EE) modeset(0): present flip failed
[ 13945.616] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13945.616] (EE) modeset(0): present flip failed
[ 13945.987] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13945.987] (EE) modeset(0): present flip failed
[ 13946.003] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13946.003] (EE) modeset(0): present flip failed
[ 13960.082] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13960.082] (EE) modeset(0): present flip failed
[ 13960.108] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13960.108] (EE) modeset(0): present flip failed
[ 13962.965] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13962.965] (EE) modeset(0): present flip failed
[ 13962.981] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13962.981] (EE) modeset(0): present flip failed
[ 13962.995] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13962.995] (EE) modeset(0): present flip failed
[ 13963.840] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13963.840] (EE) modeset(0): present flip failed
[ 13964.120] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13964.120] (EE) modeset(0): present flip failed
[ 13964.360] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13964.360] (EE) modeset(0): present flip failed
[ 13964.544] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13964.544] (EE) modeset(0): present flip failed
[ 13964.688] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13964.688] (EE) modeset(0): present flip failed
[ 13964.840] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13964.840] (EE) modeset(0): present flip failed
[ 13964.992] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13964.992] (EE) modeset(0): present flip failed
[ 13965.344] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13965.344] (EE) modeset(0): present flip failed
[ 13965.568] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13965.568] (EE) modeset(0): present flip failed
[ 13965.673] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13965.673] (EE) modeset(0): present flip failed
[ 13965.888] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13965.888] (EE) modeset(0): present flip failed
[ 13966.024] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13966.024] (EE) modeset(0): present flip failed
[ 13966.440] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13966.440] (EE) modeset(0): present flip failed
[ 13967.400] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13967.400] (EE) modeset(0): present flip failed
[ 13968.440] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13968.440] (EE) modeset(0): present flip failed
[ 13969.075] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13969.075] (EE) modeset(0): present flip failed
[ 13970.536] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13970.536] (EE) modeset(0): present flip failed
[ 13970.688] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13970.688] (EE) modeset(0): present flip failed
[ 13970.883] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13970.883] (EE) modeset(0): present flip failed
[ 13971.592] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13971.592] (EE) modeset(0): present flip failed
[ 13971.787] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13971.787] (EE) modeset(0): present flip failed
[ 13973.688] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13973.688] (EE) modeset(0): present flip failed
[ 13974.188] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13974.188] (EE) modeset(0): present flip failed
[ 13974.219] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13974.219] (EE) modeset(0): present flip failed
[ 13974.288] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13974.288] (EE) modeset(0): present flip failed
[ 13974.319] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13974.319] (EE) modeset(0): present flip failed
[ 13974.388] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13974.388] (EE) modeset(0): present flip failed
[ 13974.419] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13974.419] (EE) modeset(0): present flip failed
[ 13974.488] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13974.488] (EE) modeset(0): present flip failed
[ 13975.096] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13975.096] (EE) modeset(0): present flip failed
[ 13975.488] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13975.488] (EE) modeset(0): present flip failed
[ 13975.696] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13975.696] (EE) modeset(0): present flip failed
[ 13975.793] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13975.793] (EE) modeset(0): present flip failed
[ 13975.905] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13975.905] (EE) modeset(0): present flip failed
[ 13976.001] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13976.001] (EE) modeset(0): present flip failed
[ 13976.113] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13976.113] (EE) modeset(0): present flip failed
[ 13976.288] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13976.288] (EE) modeset(0): present flip failed
[ 13976.401] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13976.401] (EE) modeset(0): present flip failed
[ 13976.552] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13976.552] (EE) modeset(0): present flip failed
[ 13976.641] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13976.641] (EE) modeset(0): present flip failed
[ 13976.720] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13976.720] (EE) modeset(0): present flip failed
[ 13976.824] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13976.824] (EE) modeset(0): present flip failed
[ 13978.320] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13978.320] (EE) modeset(0): present flip failed
[ 13979.064] (EE) modeset(0): Failed to get GBM bo for flip to new front.=

[ 13979.064] (EE) modeset(0): present flip failed

--------------B96CA39EC077B3A65E8E965D--

--------------ms080709010905030208090605
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
SIb3DQEJBTEPFw0xOTAzMDYxNjM1MTRaMC8GCSqGSIb3DQEJBDEiBCBUP9ycr/3D3lNhHcUC
DzNDlOi4W4XJDrSnnmcvuk++SjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAKEj
vhWGn4KJC71N+5sWQ9p/9CWcCCDmliCQN8/+BGyq3I119c2RJESEbmyZ4V2HDPa33ViVZ3bR
EFYTIlRfnXhZmFSOj7J1KQeAlZaUDAxpU57jVzCv3gzeuCXsXK7hOUfpkjxp39B70Nw0egL8
F1M5usLeg6QD1k1tCusvhaW2rYeLUZuF8uFJpnT3PkL3SozZbvt4ab9kjJewuD3bfxQCSgA7
1tDTKyK3PH1PiqHtXkS+q7R5aVzQWtk5REKOgwvGxtt9hxOFULeSBwLBpDQp0qD0r4QATeW6
4FIeCEeNx1gdtGScke5En2fyPm7X5BYC6aWdBm15Pdn6V2aF6zUAAAAAAAA=
--------------ms080709010905030208090605--

--===============0639990330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0639990330==--
