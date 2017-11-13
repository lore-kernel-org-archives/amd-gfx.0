From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: WARN_ON() on every commit
Date: Mon, 13 Nov 2017 10:56:22 +0000
Message-ID: <BN6PR12MB18263DDA2445C8076C035A71F22B0@BN6PR12MB1826.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0960026819=="
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, brahma_sw_dev <brahma_sw_dev-5C7GfCeVMHo@public.gmane.org>

--===============0960026819==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18263DDA2445C8076C035A71F22B0BN6PR12MB1826namp_"

--_000_BN6PR12MB18263DDA2445C8076C035A71F22B0BN6PR12MB1826namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I find the below WARN_ON() message while rendering on eDP in ST platform wi=
th https://cgit.freedesktop.org/~airlied/linux/log/?h=3Ddrm-next-amd-dc-sta=
ging branch:

WARNING kernel: [  344.159552] WARNING: CPU: 1 PID: 899 at /mnt/host/source=
/src/third_party/kernel/v4.12/drivers/gpu/drm/ttm/ttm_bo_
vm.c:287 ttm_bo_vm_open+0x2b/0x38
[  344.159552] Modules linked in: ccm cmac rfcomm uinput rtsx_pci_sdmmc xt_=
nat lzo lzo_compress ath10k_pci ath10k_co
re i2c_piix4 mac80211 zram bridge designware_i2s stp ath rtsx_pci llc acpi_=
als ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat fu=
se xt_mark cfg8
0211 ip6table_filter iio_trig_sysfs cros_ec_sensors industrialio_triggered_=
buffer kfifo_buf cros_ec_sensors_core industrialio ax88179_178a usbnet mii =
btusb btrtl btb
cm btintel bluetooth ecdh_generic joydev uvcvideo videobuf2_vmalloc videobu=
f2_memops videobuf2_v4l2 videobuf2_core
WARNING kernel: [  344.159594] CPU: 1 PID: 899 Comm: TaskSchedulerSi Tainte=
d: G        W       4.14.0-00021-g4448b9a68413 #467
WARNING kernel: [  344.159595] Hardware name: Google Kahlee/Kahlee, BIOS Go=
ogle_Kahlee.10122.0.0 11/10/2017
WARNING kernel: [  344.159597] task: ffff967e1f750000 task.stack: ffffa4aa0=
0d78000
WARNING kernel: [  344.159600] RIP: 0010:ttm_bo_vm_open+0x2b/0x38
WARNING kernel: [  344.159602] RSP: 0018:ffffa4aa00d7bdb0 EFLAGS: 00010202
WARNING kernel: [  344.159605] RAX: ffff967d6505e858 RBX: ffff967da2415100 =
RCX: ffff967e2a3b2830
WARNING kernel: [  344.159606] RDX: ffff967da679bb40 RSI: ffff967e29f39510 =
RDI: ffff967d653682e0
WARNING kernel: [  344.159608] RBP: ffffa4aa00d7bdb0 R08: ffffffff87932194 =
R09: 0000000000000000
WARNING kernel: [  344.159610] R10: 000000000001e1b1 R11: 000000000001e168 =
R12: ffff967da6789d00
WARNING kernel: [  344.159611] R13: ffff967e274e3b80 R14: ffff967d653682e0 =
R15: 0000000000000000
WARNING kernel: [  344.159614] FS:  00007ddd0559a700(0000) GS:ffff967e2ed00=
000(0000) knlGS:0000000000000000
WARNING kernel: [  344.159616] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
WARNING kernel: [  344.159618] CR2: 0000162eb0bebb18 CR3: 000000012133e000 =
CR4: 00000000001406e0
WARNING kernel: [  344.159619] Call Trace:
WARNING kernel: [  344.159623]  copy_process.part.49+0xf47/0x186e
WARNING kernel: [  344.159627]  _do_fork+0xcd/0x2d1
WARNING kernel: [  344.159631]  ? __might_fault+0x35/0x37
WARNING kernel: [  344.159634]  ? _copy_to_user+0x5e/0x6b
WARNING kernel: [  344.159637]  SyS_clone+0x19/0x1b
WARNING kernel: [  344.159639]  do_syscall_64+0x52/0x61
WARNING kernel: [  344.159642]  entry_SYSCALL64_slow_path+0x25/0x25
WARNING kernel: [  344.159644] RIP: 0033:0x7ddd1224be3a
WARNING kernel: [  344.159646] RSP: 002b:00007ddd05598ce0 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000038
WARNING kernel: [  344.159649] RAX: ffffffffffffffda RBX: 00007ddd05598ce0 =
RCX: 00007ddd1224be3a
WARNING kernel: [  344.159651] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI: 0000000001200011
WARNING kernel: [  344.159652] RBP: 00007ddd05598d50 R08: 00000000000002e0 =
R09: 0000000000000383
WARNING kernel: [  344.159654] R10: 00007ddd0559a9d0 R11: 0000000000000246 =
R12: 0000000000000000
WARNING kernel: [  344.159656] R13: 00007ddd05598d00 R14: 00007ddd05598f01 =
R15: 0000162eb3b438a0
WARNING kernel: [  344.159658] Code: 0f 1f 44 00 00 55 48 8b 87 a8 00 00 00=
 48 8b 97 a0 00 00 00 48 89 e5 48 8b 48 08 48 8b b2 30 01
00 00 48 39 b1 68 08 00 00 74 02 <0f> ff 48 8d 78 30 e8 59 ff ff ff 5d c3 0=
f 1f 44 00 00 55 48 89


Does anybody know the fix for it?

Regards,
Shirish S


--_000_BN6PR12MB18263DDA2445C8076C035A71F22B0BN6PR12MB1826namp_
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
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi All,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I find the below WARN_ON() message while rendering o=
n eDP in ST platform with
<a href=3D"https://cgit.freedesktop.org/~airlied/linux/log/?h=3Ddrm-next-am=
d-dc-staging">
https://cgit.freedesktop.org/~airlied/linux/log/?h=3Ddrm-next-amd-dc-stagin=
g</a> branch:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159552] WARNING: CPU: 1 =
PID: 899 at /mnt/host/source/src/third_party/kernel/v4.12/drivers/gpu/drm/t=
tm/ttm_bo_<o:p></o:p></p>
<p class=3D"MsoNormal">vm.c:287 ttm_bo_vm_open&#43;0x2b/0x38<o:p></o:p></p>
<p class=3D"MsoNormal">[&nbsp; 344.159552] Modules linked in: ccm cmac rfco=
mm uinput rtsx_pci_sdmmc xt_nat lzo lzo_compress ath10k_pci ath10k_co<o:p><=
/o:p></p>
<p class=3D"MsoNormal">re i2c_piix4 mac80211 zram bridge designware_i2s stp=
 ath rtsx_pci llc acpi_als ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_na=
t nf_nat_ipv4 nf_nat fuse xt_mark cfg8<o:p></o:p></p>
<p class=3D"MsoNormal">0211 ip6table_filter iio_trig_sysfs cros_ec_sensors =
industrialio_triggered_buffer kfifo_buf cros_ec_sensors_core industrialio a=
x88179_178a usbnet mii btusb btrtl btb<o:p></o:p></p>
<p class=3D"MsoNormal">cm btintel bluetooth ecdh_generic joydev uvcvideo vi=
deobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core<o:p></o:p></=
p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159594] CPU: 1 PID: 899 =
Comm: TaskSchedulerSi Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
W&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.14.0-00021-g4448b9a68413 #467<o:p><=
/o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159595] Hardware name: G=
oogle Kahlee/Kahlee, BIOS Google_Kahlee.10122.0.0 11/10/2017<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159597] task: ffff967e1f=
750000 task.stack: ffffa4aa00d78000<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159600] RIP: 0010:ttm_bo=
_vm_open&#43;0x2b/0x38<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159602] RSP: 0018:ffffa4=
aa00d7bdb0 EFLAGS: 00010202<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159605] RAX: ffff967d650=
5e858 RBX: ffff967da2415100 RCX: ffff967e2a3b2830<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159606] RDX: ffff967da67=
9bb40 RSI: ffff967e29f39510 RDI: ffff967d653682e0<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159608] RBP: ffffa4aa00d=
7bdb0 R08: ffffffff87932194 R09: 0000000000000000<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159610] R10: 00000000000=
1e1b1 R11: 000000000001e168 R12: ffff967da6789d00<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159611] R13: ffff967e274=
e3b80 R14: ffff967d653682e0 R15: 0000000000000000<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159614] FS:&nbsp; 00007d=
dd0559a700(0000) GS:ffff967e2ed00000(0000) knlGS:0000000000000000<o:p></o:p=
></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159616] CS:&nbsp; 0010 D=
S: 0000 ES: 0000 CR0: 0000000080050033<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159618] CR2: 0000162eb0b=
ebb18 CR3: 000000012133e000 CR4: 00000000001406e0<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159619] Call Trace:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159623]&nbsp; copy_proce=
ss.part.49&#43;0xf47/0x186e<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159627]&nbsp; _do_fork&#=
43;0xcd/0x2d1<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159631]&nbsp; ? __might_=
fault&#43;0x35/0x37<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159634]&nbsp; ? _copy_to=
_user&#43;0x5e/0x6b<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159637]&nbsp; SyS_clone&=
#43;0x19/0x1b<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159639]&nbsp; do_syscall=
_64&#43;0x52/0x61<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159642]&nbsp; entry_SYSC=
ALL64_slow_path&#43;0x25/0x25<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159644] RIP: 0033:0x7ddd=
1224be3a<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159646] RSP: 002b:00007d=
dd05598ce0 EFLAGS: 00000246 ORIG_RAX: 0000000000000038<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159649] RAX: fffffffffff=
fffda RBX: 00007ddd05598ce0 RCX: 00007ddd1224be3a<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159651] RDX: 00000000000=
00000 RSI: 0000000000000000 RDI: 0000000001200011<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159652] RBP: 00007ddd055=
98d50 R08: 00000000000002e0 R09: 0000000000000383<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159654] R10: 00007ddd055=
9a9d0 R11: 0000000000000246 R12: 0000000000000000<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159656] R13: 00007ddd055=
98d00 R14: 00007ddd05598f01 R15: 0000162eb3b438a0<o:p></o:p></p>
<p class=3D"MsoNormal">WARNING kernel: [&nbsp; 344.159658] Code: 0f 1f 44 0=
0 00 55 48 8b 87 a8 00 00 00 48 8b 97 a0 00 00 00 48 89 e5 48 8b 48 08 48 8=
b b2 30 01<o:p></o:p></p>
<p class=3D"MsoNormal">00 00 48 39 b1 68 08 00 00 74 02 &lt;0f&gt; ff 48 8d=
 78 30 e8 59 ff ff ff 5d c3 0f 1f 44 00 00 55 48 89<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Does anybody know the fix for it?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Shirish S<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BN6PR12MB18263DDA2445C8076C035A71F22B0BN6PR12MB1826namp_--

--===============0960026819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0960026819==--
