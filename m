From: Andrin Brunner <andrin-A44xjXffZa1Ng+MwTxZMZA@public.gmane.org>
Subject: AMDGPU crash with KDE/Plasma
Date: Thu, 6 Apr 2017 19:42:41 +0000
Message-ID: <b5d693bb37924353b51656b944ba32a6@Exch01.acloud.one>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1030968343=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1030968343==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_b5d693bb37924353b51656b944ba32a6Exch01acloudone_"

--_000_b5d693bb37924353b51656b944ba32a6Exch01acloudone_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello

I have an issue with the AMDGPU driver. I am not a developer and I'm not fa=
miliar with the Linux Kernel development. I thought that I'd be best if I'd=
 write here because I think it's an issue with the Kernel. My main problem =
is, that I cannot set my display layout within KDE/Plasma (other DE's are w=
orking) nor can I set my screen's refresh rate (in any DE, for ex. with xra=
ndr). I tried many distro's and Kernel versions and all had the same behavi=
or. The screen goes black and the system freezes completely. I managed to c=
apture the kmsg with netconsole:
_________________
[10615.770351] input: Razer Razer DeathAdder Chroma as /devices/pci0000:00/=
0000:00:14.0/usb3/3-6/3-6:1.0/0003:1532:0043.000A/input/input32
[10615.770471] hid-generic 0003:1532:0043.000A: input,hidraw0: USB HID v1.1=
1 Mouse [Razer Razer DeathAdder Chroma] on usb-0000:00:14.0-6/input0
[10702.041015] Now setting display layout...
[10722.338954] divide error: 0000 [#1] PREEMPT SMP
[10722.340485] Modules linked in: arc4 md4 hmac nls_utf8 cifs dns_resolver =
fscache netconsole pci_stub vboxpci(O) vboxnetflt(O) vboxnetadp(O) vboxdrv(=
O) fuse mousedev joydev input_leds snd_hda_codec_realtek snd_hda_codec_gene=
ric snd_hda_codec_hdmi sch_fq_codel iTCO_wdt uinput iTCO_vendor_support int=
el_rapl edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel =
kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_inte=
l eeepc_wmi nls_iso8859_1 asus_wmi sparse_keymap aesni_intel nls_cp437 aes_=
x86_64 led_class lrw rfkill gf128mul vfat video glue_helper mxm_wmi ablk_he=
lper fat cryptd intel_cstate intel_rapl_perf snd_hda_intel evdev psmouse pc=
spkr mac_hid snd_hda_codec i2c_i801 i2c_smbus snd_hda_core snd_hwdep snd_pc=
m e1000e snd_timer snd mei_me soundcore mei ptp shpchp pps_core lpc_ich fje=
s wmi tpm_tis tpm_tis_core tpm button amdkfd amd_iommu_v2 amdgpu ttm drm_km=
s_helper drm syscopyarea sysfillrect sysimgblt fb_sys_fops i2c_algo_bit ip_=
tables x_tables ext4 crc16 jbd2 fscrypto mbcache sr_mod cdrom hid_generic u=
sbhid hid sd_mod serio_raw atkbd libps2 xhci_pci ahci ehci_pci xhci_hcd ehc=
i_hcd libahci libata usbcore scsi_mod usb_common i8042 serio
[10722.349839] CPU: 2 PID: 5542 Comm: Xorg Tainted: G           O    4.9.20=
-1-MANJARO #1
[10722.351914] Hardware name: ASUS All Series/X99-A, BIOS 3402 08/18/2016
[10722.353849] task: ffff880417c10e40 task.stack: ffffc90004c94000
[10722.355786] RIP: 0010:[<ffffffffa038f5a3>]  [<ffffffffa038f5a3>] dce_v11=
_0_latency_watermark+0x133/0x1a0 [amdgpu]
[10722.357789] RSP: 0018:ffffc90004c977b8  EFLAGS: 00010206
[10722.359764] RAX: 000000d700000000 RBX: ffffc90004c97824 RCX: 00000000000=
00000
[10722.361744] RDX: 0000000000000000 RSI: 00000000000012e7 RDI: 00000000000=
006b7
[10722.363734] RBP: ffffc90004c977d0 R08: 0000000000000004 R09: 00000000000=
012e7
[10722.365724] R10: 0000000000000002 R11: 0000000000004000 R12: 00000000010=
f6001
[10722.367712] R13: 0000000000000000 R14: ffff880442d60000 R15: 00000000000=
02000
[10722.369703] FS:  00007f44b4ad4940(0000) GS:ffff88044f280000(0000) knlGS:=
0000000000000000
[10722.371721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10722.373733] CR2: 00007f449c450000 CR3: 000000043cf53000 CR4: 00000000001=
406e0
[10722.375771] Stack:
[10722.377801]  ffff88044ab90000 0000000000001e50 0000000000000003 ffffc900=
04c97888
[10722.379874]  ffffffffa0390d10 0000c1f100000000 0000000000000002 ffffffff=
a03e1100
[10722.381963]  000000000000c1c4 0000000000000043 0000000000000000 ffff8804=
42e74500
[10722.384042] Call Trace:
[10722.386139]  [<ffffffffa0390d10>] dce_v11_0_program_watermarks+0x120/0x5=
70 [amdgpu]
[10722.388258]  [<ffffffffa0391586>] dce_v11_0_bandwidth_update+0x1c6/0x260=
 [amdgpu]
[10722.390399]  [<ffffffffa032f1ad>] amdgpu_pm_compute_clocks+0x3d/0x5a0 [a=
mdgpu]
[10722.392543]  [<ffffffffa0391ffe>] dce_v11_0_crtc_dpms+0x4e/0x110 [amdgpu=
]
[10722.394688]  [<ffffffffa03923be>] dce_v11_0_crtc_prepare+0x2e/0x40 [amdg=
pu]
[10722.396812]  [<ffffffffa0216906>] drm_crtc_helper_set_mode+0x366/0x530 [=
drm_kms_helper]
[10722.398953]  [<ffffffffa02175c3>] drm_crtc_helper_set_config+0x9b3/0xaf0=
 [drm_kms_helper]
[10722.401129]  [<ffffffffa0325038>] amdgpu_crtc_set_config+0x48/0x120 [amd=
gpu]
[10722.403323]  [<ffffffffa0198d75>] drm_mode_set_config_internal+0x65/0x11=
0 [drm]
[10722.405494]  [<ffffffffa019a2bd>] drm_mode_setcrtc+0x3fd/0x4f0 [drm]
[10722.407660]  [<ffffffffa0190b6b>] drm_ioctl+0x21b/0x4c0 [drm]
[10722.409839]  [<ffffffffa0199ec0>] ? drm_mode_getcrtc+0x140/0x140 [drm]
[10722.412024]  [<ffffffffa030e04f>] amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
[10722.414196]  [<ffffffff81225893>] do_vfs_ioctl+0xa3/0x5f0
[10722.416372]  [<ffffffff81230d07>] ? __fget+0x77/0xb0
[10722.418521]  [<ffffffff81225e59>] SyS_ioctl+0x79/0x90
[10722.420700]  [<ffffffff8161ae77>] entry_SYSCALL_64_fastpath+0x1a/0xa9
[10722.422867] Code: 44 89 ce c1 e2 0c 48 c1 ea 02 48 89 d0 48 f7 e1 8b 43 =
10 41 0f af c0 48 8d 4a 01 31 d2 48 d1 e9 41 0f af c2 c1 e0 0c 48 c1 e0 0d =
<48> f7 f1 8b 53 14 29 d6 48 83 c0 01 48 d1 e8 c1 e8 0c 01 c6 39
[10722.425395] RIP  [<ffffffffa038f5a3>] dce_v11_0_latency_watermark+0x133/=
0x1a0 [amdgpu]
[10722.427773]  RSP <ffffc90004c977b8>
[10722.443936] ---[ end trace 6945c48832b1cfe9 ]---

Here's my system info (I'm running two RX480's):
System:    Kernel: 4.9.20-1-MANJARO x86_64 (64 bit gcc: 6.3.1) Desktop: Cin=
namon 3.2.8 (Gtk 3.22.10)
           Distro: Manjaro Linux
Machine:   Device: desktop System: ASUS product: All Series
           Mobo: ASUSTeK model: X99-A v: Rev 1.xx UEFI: American Megatrends=
 v: 3402 date: 08/18/2016
CPU:       Hexa core Intel Core i7-5820K (-HT-MCP-) cache: 15360 KB
           flags: (lm nx sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx) bmips: 3959=
7
           clock speeds: max: 3600 MHz 1: 1488 MHz 2: 1266 MHz 3: 1305 MHz =
4: 2188 MHz 5: 1203 MHz 6: 1371 MHz
           7: 1503 MHz 8: 1269 MHz 9: 1211 MHz 10: 1763 MHz 11: 1257 MHz 12=
: 1397 MHz
Graphics:  Card-1: Advanced Micro Devices [AMD/ATI] Ellesmere [Radeon RX 47=
0/480] bus-ID: 01:00.0
           Card-2: Advanced Micro Devices [AMD/ATI] Ellesmere [Radeon RX 47=
0/480] bus-ID: 02:00.0
           Display Server: X.Org 1.19.3 driver: amdgpu
           Resolution: 3440x1440-TqAelEbi0UE@public.gmane.org, 2560x1080-qEAkLYPErqw@public.gmane.org, 1920x1080@60.0=
0hz
           GLX Renderer: Gallium 0.4 on AMD POLARIS10 (DRM 3.8.0 / 4.9.20-1=
-MANJARO, LLVM 3.9.1)
           GLX Version: 3.0 Mesa 17.0.2 Direct Rendering: Yes
Audio:     Card-1 Intel C610/X99 series HD Audio Controller driver: snd_hda=
_intel bus-ID: 00:1b.0
           Card-2 2x Advanced Micro Devices [AMD/ATI] Device aaf0
           driver: snd_hda_intelsnd_hda_intel bus-ID: 02:00.1
           Sound: Advanced Linux Sound Architecture v: k4.9.20-1-MANJARO
Network:   Card: Intel Ethernet Connection (2) I218-V driver: e1000e v: 3.2=
.6-k port: f000 bus-ID: 00:19.0
           IF: eno1 state: up speed: 1000 Mbps duplex: full mac: <filter>
Drives:    HDD Total Size: 2250.5GB (2.5% used)
           ID-1: /dev/sda model: Samsung_SSD_850 size: 500.1GB
           ID-2: /dev/sdb model: Samsung_SSD_850 size: 250.1GB
           ID-3: /dev/sdc model: SAMSUNG_HD103SJ size: 1000.2GB
           ID-4: /dev/sdd model: Samsung_SSD_850 size: 500.1GB
Partition: ID-1: / size: 212G used: 36G (18%) fs: ext4 dev: /dev/sdb2
           ID-2: swap-1 size: 18.41GB used: 0.00GB (0%) fs: swap dev: /dev/=
sdb3
Sensors:   System Temperatures: cpu: 41.0C mobo: N/A gpu: 33.0,46.0
           Fan Speeds (in rpm): cpu: 0
Info:      Processes: 270 Uptime: 1:41 Memory: 2210.5/15963.9MB Init: syste=
md Gcc sys: 6.3.1
           Client: Shell (bash 4.4.121) inxi: 2.3.8


I hope you can help me with this issue. Thank you for your time.

Regards
Andrin Brunner

--_000_b5d693bb37924353b51656b944ba32a6Exch01acloudone_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE-CH" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hello<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I have an issue with the AMDGPU=
 driver. I am not a developer and I&#8217;m not familiar with the Linux Ker=
nel development. I thought that I&#8217;d be best if I&#8217;d write here b=
ecause I think it&#8217;s an issue with the Kernel. My main
 problem is, that I cannot set my display layout within KDE/Plasma (other D=
E&#8217;s are working) nor can I set my screen&#8217;s refresh rate (in any=
 DE, for ex. with xrandr). I tried many distro&#8217;s and Kernel versions =
and all had the same behavior. The screen goes black
 and the system freezes completely. I managed to capture the kmsg with netc=
onsole:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">_________________<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10615.770351] input: Razer Raz=
er DeathAdder Chroma as /devices/pci0000:00/0000:00:14.0/usb3/3-6/3-6:1.0/0=
003:1532:0043.000A/input/input32<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10615.770471] hid-generic 0003=
:1532:0043.000A: input,hidraw0: USB HID v1.11 Mouse [Razer Razer DeathAdder=
 Chroma] on usb-0000:00:14.0-6/input0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10702.041015] Now setting disp=
lay layout...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.338954] divide error: 00=
00 [#1] PREEMPT SMP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.340485] Modules linked i=
n: arc4 md4 hmac nls_utf8 cifs dns_resolver fscache netconsole pci_stub vbo=
xpci(O) vboxnetflt(O) vboxnetadp(O) vboxdrv(O) fuse mousedev joydev input_l=
eds snd_hda_codec_realtek snd_hda_codec_generic
 snd_hda_codec_hdmi sch_fq_codel iTCO_wdt uinput iTCO_vendor_support intel_=
rapl edac_core x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm=
 irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel e=
eepc_wmi nls_iso8859_1 asus_wmi
 sparse_keymap aesni_intel nls_cp437 aes_x86_64 led_class lrw rfkill gf128m=
ul vfat video glue_helper mxm_wmi ablk_helper fat cryptd intel_cstate intel=
_rapl_perf snd_hda_intel evdev psmouse pcspkr mac_hid snd_hda_codec i2c_i80=
1 i2c_smbus snd_hda_core snd_hwdep
 snd_pcm e1000e snd_timer snd mei_me soundcore mei ptp shpchp pps_core lpc_=
ich fjes wmi tpm_tis tpm_tis_core tpm button amdkfd amd_iommu_v2 amdgpu ttm=
 drm_kms_helper drm syscopyarea sysfillrect sysimgblt fb_sys_fops i2c_algo_=
bit ip_tables x_tables ext4 crc16
 jbd2 fscrypto mbcache sr_mod cdrom hid_generic usbhid hid sd_mod serio_raw=
 atkbd libps2 xhci_pci ahci ehci_pci xhci_hcd ehci_hcd libahci libata usbco=
re scsi_mod usb_common i8042 serio<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.349839] CPU: 2 PID: 5542=
 Comm: Xorg Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; O&nbsp;&nbsp;&nbsp; 4.9.20-1-MANJARO #1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.351914] Hardware name: A=
SUS All Series/X99-A, BIOS 3402 08/18/2016<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.353849] task: ffff880417=
c10e40 task.stack: ffffc90004c94000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.355786] RIP: 0010:[&lt;f=
fffffffa038f5a3&gt;]&nbsp; [&lt;ffffffffa038f5a3&gt;] dce_v11_0_latency_wat=
ermark&#43;0x133/0x1a0 [amdgpu]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.357789] RSP: 0018:ffffc9=
0004c977b8&nbsp; EFLAGS: 00010206<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.359764] RAX: 000000d7000=
00000 RBX: ffffc90004c97824 RCX: 0000000000000000<o:p></o:p></span></p>
<p class=3D"MsoNormal">[10722.361744] RDX: 0000000000000000 RSI: 0000000000=
0012e7 RDI: 00000000000006b7<o:p></o:p></p>
<p class=3D"MsoNormal">[10722.363734] RBP: ffffc90004c977d0 R08: 0000000000=
000004 R09: 00000000000012e7<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.365724] R10: 00000000000=
00002 R11: 0000000000004000 R12: 00000000010f6001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.367712] R13: 00000000000=
00000 R14: ffff880442d60000 R15: 0000000000002000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.369703] FS:&nbsp; 00007f=
44b4ad4940(0000) GS:ffff88044f280000(0000) knlGS:0000000000000000<o:p></o:p=
></span></p>
<p class=3D"MsoNormal">[10722.371721] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0:=
 0000000080050033<o:p></o:p></p>
<p class=3D"MsoNormal">[10722.373733] CR2: 00007f449c450000 CR3: 000000043c=
f53000 CR4: 00000000001406e0<o:p></o:p></p>
<p class=3D"MsoNormal">[10722.375771] Stack:<o:p></o:p></p>
<p class=3D"MsoNormal">[10722.377801]&nbsp; ffff88044ab90000 0000000000001e=
50 0000000000000003 ffffc90004c97888<o:p></o:p></p>
<p class=3D"MsoNormal">[10722.379874]&nbsp; ffffffffa0390d10 0000c1f1000000=
00 0000000000000002 ffffffffa03e1100<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.381963]&nbsp; 0000000000=
00c1c4 0000000000000043 0000000000000000 ffff880442e74500<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.384042] Call Trace:<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.386139]&nbsp; [&lt;fffff=
fffa0390d10&gt;] dce_v11_0_program_watermarks&#43;0x120/0x570 [amdgpu]<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal">[10722.388258]&nbsp; [&lt;ffffffffa0391586&gt;] dce_=
v11_0_bandwidth_update&#43;0x1c6/0x260 [amdgpu]<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.390399]&nbsp; [&lt;fffff=
fffa032f1ad&gt;] amdgpu_pm_compute_clocks&#43;0x3d/0x5a0 [amdgpu]<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.392543]&nbsp; [&lt;fffff=
fffa0391ffe&gt;] dce_v11_0_crtc_dpms&#43;0x4e/0x110 [amdgpu]<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.394688]&nbsp; [&lt;fffff=
fffa03923be&gt;] dce_v11_0_crtc_prepare&#43;0x2e/0x40 [amdgpu]<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.396812]&nbsp; [&lt;fffff=
fffa0216906&gt;] drm_crtc_helper_set_mode&#43;0x366/0x530 [drm_kms_helper]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.398953]&nbsp; [&lt;fffff=
fffa02175c3&gt;] drm_crtc_helper_set_config&#43;0x9b3/0xaf0 [drm_kms_helper=
]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.401129]&nbsp; [&lt;fffff=
fffa0325038&gt;] amdgpu_crtc_set_config&#43;0x48/0x120 [amdgpu]<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.403323]&nbsp; [&lt;fffff=
fffa0198d75&gt;] drm_mode_set_config_internal&#43;0x65/0x110 [drm]<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.405494]&nbsp; [&lt;fffff=
fffa019a2bd&gt;] drm_mode_setcrtc&#43;0x3fd/0x4f0 [drm]<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.407660]&nbsp; [&lt;fffff=
fffa0190b6b&gt;] drm_ioctl&#43;0x21b/0x4c0 [drm]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.409839]&nbsp; [&lt;fffff=
fffa0199ec0&gt;] ? drm_mode_getcrtc&#43;0x140/0x140 [drm]<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.412024]&nbsp; [&lt;fffff=
fffa030e04f&gt;] amdgpu_drm_ioctl&#43;0x4f/0x90 [amdgpu]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.414196]&nbsp; [&lt;fffff=
fff81225893&gt;] do_vfs_ioctl&#43;0xa3/0x5f0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.416372]&nbsp; [&lt;fffff=
fff81230d07&gt;] ? __fget&#43;0x77/0xb0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.418521]&nbsp; [&lt;fffff=
fff81225e59&gt;] SyS_ioctl&#43;0x79/0x90<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.420700]&nbsp; [&lt;fffff=
fff8161ae77&gt;] entry_SYSCALL_64_fastpath&#43;0x1a/0xa9<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal">[10722.422867] Code: 44 89 ce c1 e2 0c 48 c1 ea 02 4=
8 89 d0 48 f7 e1 8b 43 10 41 0f af c0 48 8d 4a 01 31 d2 48 d1 e9 41 0f af c=
2 c1 e0 0c 48 c1 e0 0d &lt;48&gt; f7 f1 8b 53 14 29 d6 48 83 c0 01 48 d1 e8=
 c1 e8 0c 01 c6 39<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.425395] RIP&nbsp; [&lt;f=
fffffffa038f5a3&gt;] dce_v11_0_latency_watermark&#43;0x133/0x1a0 [amdgpu]<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[10722.427773]&nbsp; RSP &lt;ff=
ffc90004c977b8&gt;<o:p></o:p></span></p>
<div style=3D"mso-element:para-border-div;border:none;border-bottom:solid w=
indowtext 1.5pt;padding:0cm 0cm 1.0pt 0cm">
<p class=3D"MsoNormal" style=3D"border:none;padding:0cm"><span lang=3D"EN-U=
S">[10722.443936] ---[ end trace 6945c48832b1cfe9 ]---<o:p></o:p></span></p=
>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Here&#8217;s my system info (I&=
#8217;m running two RX480&#8217;s):<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">System:&nbsp;&nbsp;&nbsp; Kerne=
l: 4.9.20-1-MANJARO x86_64 (64 bit gcc: 6.3.1) Desktop: Cinnamon 3.2.8 (Gtk=
 3.22.10)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp;Distro: Manjaro Linux<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Machine:&nbsp;&nbsp; Device: de=
sktop System: ASUS product: All Series<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mobo: ASUSTeK model: X99-A v: Rev 1.xx UEFI: =
American Megatrends v: 3402 date: 08/18/2016<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">CPU:&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; Hexa core Intel Core i7-5820K (-HT-MCP-) cache: 15360 KB<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>flags: (lm nx sse sse2 sse3 sse4_1 sse=
4_2 ssse3 vmx) bmips: 39597<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; clock speeds: max: 3600 MHz 1: 1488 MHz 2: 1266 MHz 3: 1305 MHz 4:=
 2188 MHz 5: 1203 MHz 6: 1371 MHz<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 7: 1503 MHz 8: 1269 MHz 9: 1211 MHz 10: 1763 MHz 11: 1257 MHz 12: =
1397 MHz<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Graphics:&nbsp; Card-1: Advance=
d Micro Devices [AMD/ATI] Ellesmere [Radeon RX 470/480] bus-ID: 01:00.0<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Card-2: Advanced Micro Devices [AMD/ATI] Elle=
smere [Radeon RX 470/480] bus-ID: 02:00.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Display Server: X.Org 1.19.3 driver: amdgpu<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Resolution: 3440x1440-TqAelEbi0UE@public.gmane.org, 2560x1080@60.0=
0hz, 1920x1080-qEAkLYPErqw@public.gmane.org<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GLX Renderer: Gallium 0.4 on AMD POLARIS10 (D=
RM 3.8.0 / 4.9.20-1-MANJARO, LLVM 3.9.1)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GLX Version: 3.0 Mesa 17.0.2 Direct Rendering=
: Yes<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Audio:&nbsp;&nbsp;&nbsp;&nbsp; =
Card-1 Intel C610/X99 series HD Audio Controller driver: snd_hda_intel bus-=
ID: 00:1b.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Card-2 2x Advanced Micro Devices [AMD/ATI] De=
vice aaf0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; driver: snd_hda_intelsnd_hda_intel bus-ID: 02=
:00.1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sound: Advanced Linux Sound Architecture v: k=
4.9.20-1-MANJARO<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Network:&nbsp;&nbsp; Card: Inte=
l Ethernet Connection (2) I218-V driver: e1000e v: 3.2.6-k port: f000 bus-I=
D: 00:19.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF: eno1 state: up speed: 1000 Mbps duplex: f=
ull mac: &lt;filter&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Drives:&nbsp;&nbsp;&nbsp; HDD T=
otal Size: 2250.5GB (2.5% used)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID-1: /dev/sda model: Samsung_SSD_850 size: 5=
00.1GB<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID-2: /dev/sdb model: Samsung_SSD_850 size: 2=
50.1GB<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID-3: /dev/sdc model: SAMSUNG_HD103SJ size: 1=
000.2GB<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID-4: /dev/sdd model: Samsung_SSD_850 size: 5=
00.1GB<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Partition: ID-1: / size: 212G u=
sed: 36G (18%) fs: ext4 dev: /dev/sdb2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID-2: swap-1 size: 18.41GB used: 0.00GB (0%) =
fs: swap dev: /dev/sdb3<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sensors:&nbsp;&nbsp; System Tem=
peratures: cpu: 41.0C mobo: N/A gpu: 33.0,46.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fan Speeds (in rpm): cpu: 0<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Info:&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; Processes: 270 Uptime: 1:41 Memory: 2210.5/15963.9MB Init: systemd Gcc=
 sys: 6.3.1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Client: Shell (bash 4.4.121) inxi: 2.3.8<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I hope you can help me with thi=
s issue. Thank you for your time.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Andrin Brunner<o:p></o:p></span=
></p>
</div>
</body>
</html>

--_000_b5d693bb37924353b51656b944ba32a6Exch01acloudone_--

--===============1030968343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1030968343==--
