From: Tom Reddish <tom.reddish-UdFiUJb0jaqhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: Linux Kernel 4.4.0-66 Possible DRM connector_status Bug For LG
 Displays
Date: Wed, 31 May 2017 12:43:52 -0400
Message-ID: <E004A7F8-E451-4409-A6CB-F5B7D50B81A7@mediavuesystems.com>
References: <4A782E6D-F40F-41F0-A3C4-A74F460CB1AE@mediavuesystems.com>
 <BN6PR12MB1652303B932BA05D0858FDEDF7F10@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/mixed; boundary="===============1518739682=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652303B932BA05D0858FDEDF7F10-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Brian Kane <brian.kane-UdFiUJb0jaqhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>


--===============1518739682==
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_1B2EFEE6-A14E-4BD7-8840-F96448DBA4D2"


--Apple-Mail=_1B2EFEE6-A14E-4BD7-8840-F96448DBA4D2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

What do you mean by bisect?

My gut is telling me it's something that changed in the kernel. Maybe =
the kernel is correctly parsing the information it is being given from =
the display now and in the older kernel it was handling that information =
differently? With the exact same display and no settings changed on it =
if I use the older kernel it shows up as connected

Tom Reddish=20
Software Engineer
MediaVue Systems
Skype: t.reddish
Tel: +1 781.926.0676
w =
<applewebdata://FF6402AA-2601-418F-BA35-F485629555D0/www.mediavuesystems.c=
om>ww.mediavuesystems.com =
<applewebdata://FF6402AA-2601-418F-BA35-F485629555D0/www.mediavuesystems.c=
om>
> On May 31, 2017, at 12:24 PM, Deucher, Alexander =
<Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> wrote:
>=20
> Can you bisect?  Sounds like the monitor does not keep the EDID =
powered up when the display is off as is required by the vesa spec.
> =20
> Alex
> =20
> From: Tom Reddish [mailto:tom.reddish-UdFiUJb0jaqhEniVeURVKkEOCMrvLtNR@public.gmane.org]=20
> Sent: Wednesday, May 31, 2017 12:20 PM
> To: Deucher, Alexander; Koenig, Christian
> Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Brian Kane
> Subject: Linux Kernel 4.4.0-66 Possible DRM connector_status Bug For =
LG Displays
> =20
> =20
> LG Displays are being reported as "disconnected" when they are powered =
off (currently connected through DVI to mini-displayport adapter)
> =20
> Only seeing this with LG displays (have tested NEC and Samsung =
*limited model types for each manufacturer*). With the LG display =
connected to the graphics card and powered off the system is reporting =
the DisplayPort as disconnected. In any kernel <=3D 4.4.0-31 the system =
would report the DisplayPort as connected even if the LG display was =
off.=20
> =20
> Kernel tested on
> Linux version 4.4.0-66-generic (buildd@lgw01-28) (gcc version 5.4.0 =
20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4) ) #87-Ubuntu
> =20
> Most recent kernel without the bug:=20
> Linux version 4.4.0-31-generic (buildd@lgw01-16) (gcc version 5.3.1 =
20160413 (Ubuntu 5.3.1-14ubuntu2.1) ) #50-Ubuntu
> =20
> "cat /sys/class/drm/card1-DP-1/status" will show the status as =
disconnected if the LG display is powered off
> =20
> Environment
>           Ubuntu 16.04
>           Graphics Card: Cape Verde PRO [Radeon HD 7750/8740 / R7 =
250E]
>           Radeon Graphics Drivers
>           Kernel: 4.4.0-66
> =20
> =20
> Processor
> processor       : 0-3
> vendor_id      : AuthenticAMD
> cpu family     : 21
> model                        : 48
> model name   : AMD A8-7600 Radeon R7, 10 Compute Cores 4C+6G
> stepping         : 1
> microcode      : 0x6003106
> cpu MHz                   : 1400.000
> cache size      : 2048 KB
> physical id     : 0
> siblings          : 4
> core id                       : 0
> cpu cores       : 2
> apicid             : 16
> initial apicid   : 0
> fpu                 : yes
> fpu_exception           : yes
> cpuid level     : 13
> wp                 : yes
> flags               : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr =
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext =
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc =
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16 =
sse4_1 sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic =
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt =
lwp fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb bpext cpb =
hw_pstate vmmcall fsgsbase bmi1 xsaveopt arat npt lbrv svm_lock =
nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter =
pfthreshold
> bugs               : fxsave_leak sysret_ss_attrs
> bogomips       : 6188.48
> TLB size        : 1536 4K pages
> clflush size     : 64
> cache_alignment        : 64
> address sizes  : 48 bits physical, 48 bits virtual
> power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro [13]
> =20
> =20
> Loaded driver and hardware information
> cat /proc/ioports:
> 0000-03af : PCI Bus 0000:00
>   0000-001f : dma1
>   0020-0021 : pic1
>   0040-0043 : timer0
>   0050-0053 : timer1
>   0060-0060 : keyboard
>   0061-0061 : PNP0800:00
>   0064-0064 : keyboard
>   0070-0071 : rtc0
>   0080-008f : dma page reg
>   00a0-00a1 : pic2
>   00c0-00df : dma2
>   00f0-00ff : PNP0C04:00
>     00f0-00ff : fpu
> 03b0-03df : PCI Bus 0000:00
>   03c0-03df : vesafb
> 03e0-0cf7 : PCI Bus 0000:00
>   03f8-03ff : serial
>   040b-040b : pnp 00:08
>   04d0-04d1 : pnp 00:07
>     04d0-04d1 : pnp 00:08
>   04d6-04d6 : pnp 00:08
>   0800-0803 : ACPI PM1a_EVT_BLK
>   0804-0805 : ACPI PM1a_CNT_BLK
>   0808-080b : ACPI PM_TMR
>   0810-0815 : ACPI CPU throttle
>   0820-0827 : ACPI GPE0_BLK
>   0900-090f : pnp 00:08
>   0910-091f : pnp 00:08
>   0a00-0a0f : pnp 00:03
>     0a00-0a07 : f71882fg
>   0a10-0a1f : pnp 00:03
>   0b00-0b07 : piix4_smbus
>   0b20-0b3f : pnp 00:08
>     0b20-0b27 : piix4_smbus
>   0c00-0c01 : pnp 00:08
>   0c14-0c14 : pnp 00:08
>   0c50-0c51 : pnp 00:08
>   0c52-0c52 : pnp 00:08
>   0c6c-0c6c : pnp 00:08
>   0c6f-0c6f : pnp 00:08
>   0cd0-0cd1 : pnp 00:08
>   0cd2-0cd3 : pnp 00:08
>   0cd4-0cd5 : pnp 00:08
>   0cd6-0cd7 : pnp 00:08
>   0cd8-0cdf : pnp 00:08
> 0cf8-0cff : PCI conf1
> 0d00-ffff : PCI Bus 0000:00
>   d000-dfff : PCI Bus 0000:02
>     d000-d0ff : 0000:02:00.0
>       d000-d0ff : r8169
>   e000-efff : PCI Bus 0000:01
>     e000-e0ff : 0000:01:00.0
>   f000-f0ff : 0000:00:01.0
>   f100-f10f : 0000:00:11.0
>     f100-f10f : ahci
>   f110-f113 : 0000:00:11.0
>     f110-f113 : ahci
>   f120-f127 : 0000:00:11.0
>     f120-f127 : ahci
>   f130-f133 : 0000:00:11.0
>     f130-f133 : ahci
>   f140-f147 : 0000:00:11.0
>     f140-f147 : ahci
>   fe00-fefe : pnp 00:08
> =20
> PCI Information
> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. =
[AMD/ATI] Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] (prog-if 00 =
[VGA controller])
>           Subsystem: Hightech Information System Ltd. Cape Verde PRO =
[Radeon HD 7750/8740 / R7 250E]
>           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx+
>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>           Latency: 0, Cache Line Size: 64 bytes
>           Interrupt: pin A routed to IRQ 48
>           Region 0: Memory at c0000000 (64-bit, prefetchable) =
[size=3D256M]
>           Region 2: Memory at fea00000 (64-bit, non-prefetchable) =
[size=3D256K]
>           Region 4: I/O ports at e000 [size=3D256]
>           Expansion ROM at fea40000 [disabled] [size=3D128K]
>           Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
>           Capabilities: [50] Power Management version 3
>                       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1+,D2+,D3hot+,D3cold-)
>                       Status: D0 NoSoftRst- PME-Enable- DSel=3D0 =
DScale=3D0 PME-
>           Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
>                       DevCap:          MaxPayload 256 bytes, PhantFunc =
0, Latency L0s <4us, L1 unlimited
>                                   ExtTag+ AttnBtn- AttnInd- PwrInd- =
RBE+ FLReset-
>                       DevCtl:           Report errors: Correctable- =
Non-Fatal- Fatal- Unsupported-
>                                   RlxdOrd- ExtTag- PhantFunc- AuxPwr- =
NoSnoop+
>                                   MaxPayload 256 bytes, MaxReadReq 512 =
bytes
>                       DevSta:           CorrErr+ UncorrErr- FatalErr- =
UnsuppReq+ AuxPwr- TransPend-
>                       LnkCap:          Port #0, Speed 8GT/s, Width =
x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
>                                   ClockPM- Surprise- LLActRep- BwNot- =
ASPMOptComp+
>                       LnkCtl:            ASPM Disabled; RCB 64 bytes =
Disabled- CommClk+
>                                   ExtSynch- ClockPM- AutWidDis- BWInt- =
AutBWInt-
>                       LnkSta:           Speed 8GT/s, Width x16, TrErr- =
Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                       DevCap2: Completion Timeout: Not Supported, =
TimeoutDis-, LTR-, OBFF Not Supported
>                       DevCtl2: Completion Timeout: 50us to 50ms, =
TimeoutDis-, LTR-, OBFF Disabled
>                       LnkCtl2: Target Link Speed: 8GT/s, =
EnterCompliance- SpeedDis-
>                                    Transmit Margin: Normal Operating =
Range, EnterModifiedCompliance- ComplianceSOS-
>                                    Compliance De-emphasis: -6dB
>                       LnkSta2: Current De-emphasis Level: -6dB, =
EqualizationComplete+, EqualizationPhase1+
>                                    EqualizationPhase2+, =
EqualizationPhase3+, LinkEqualizationRequest-
>           Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>                       Address: 00000000fee00000  Data: 0000
>           Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 =
Rev=3D1 Len=3D010 <?>
>           Capabilities: [150 v2] Advanced Error Reporting
>                       UESta:            DLP- SDES- TLP- FCP- CmpltTO- =
CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                       UEMsk:           DLP- SDES- TLP- FCP- CmpltTO- =
CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                       UESvrt:           DLP+ SDES+ TLP- FCP+ CmpltTO- =
CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                       CESta: RxErr- BadTLP- BadDLLP- Rollover- =
Timeout- NonFatalErr+
>                       CEMsk:           RxErr- BadTLP- BadDLLP- =
Rollover- Timeout- NonFatalErr+
>                       AERCap:        First Error Pointer: 00, GenCap+ =
CGenEn- ChkCap+ ChkEn-
>           Capabilities: [200 v1] #15
>           Capabilities: [270 v1] #19
>           Kernel driver in use: radeon
>           Kernel modules: radeon
> =20
> =20
> =20
> =20
> Tom Reddish=20
> Software Engineer
> MediaVue Systems
> Skype: t.reddish
> Tel: +1 781.926.0676
> w <x-msg://8/www.mediavuesystems.com>ww.mediavuesystems.com =
<x-msg://8/www.mediavuesystems.com>
> =20


--Apple-Mail=_1B2EFEE6-A14E-4BD7-8840-F96448DBA4D2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">What do you mean by bisect?<div class=3D""><br =
class=3D""></div><div class=3D"">My gut is telling me it's something =
that changed in the kernel. Maybe the kernel is correctly parsing the =
information it is being given from the display now and in the older =
kernel it was handling that information differently? With the exact same =
display and no settings changed on it if I use the older kernel it shows =
up as connected</div><div class=3D""><br class=3D""></div><div class=3D"">=

<div style=3D"letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><div style=3D"color: rgb(0, 0, 0); =
font-family: Arial, sans-serif; margin: 0in 0in 0.0001pt; line-height: =
normal; widows: 1; background-color: rgb(255, 255, 255);" class=3D""><span=
 style=3D"color: rgb(94, 94, 94); font-family: Arial; font-size: small;" =
class=3D"">Tom Reddish&nbsp;</span></div><div style=3D"color: rgb(0, 0, =
0); font-family: Arial, sans-serif; font-size: 11px; margin: 0in 0in =
0.0001pt; line-height: normal; widows: 1;" class=3D""><font face=3D"Arial"=
 size=3D"2" color=3D"#5e5e5e" class=3D""><span class=3D"" =
style=3D"line-height: normal;"><span style=3D"background-color: rgb(255, =
254, 254);" class=3D"">Software Engineer</span><br class=3D""></span><span=
 class=3D"" style=3D"background-color: rgb(255, 255, 255); line-height: =
normal;">MediaVue Systems</span><br class=3D""></font></div><div =
style=3D"color: rgb(0, 0, 0); font-family: Arial, sans-serif; font-size: =
11px; margin: 0in 0in 0.0001pt; line-height: normal; widows: 1; =
background-color: rgb(255, 255, 255);" class=3D""><span class=3D"" =
style=3D"color: rgb(94, 94, 94); font-family: Arial; line-height: =
normal;"><span style=3D"font-size: small;" class=3D"">Skype: =
t.reddish</span></span></div><div style=3D"color: rgb(0, 0, 0); =
font-family: Arial, sans-serif; font-size: 11px; margin: 0in 0in =
0.0001pt; line-height: normal; widows: 1; background-color: rgb(255, =
255, 255);" class=3D""><span class=3D"" style=3D"color: rgb(94, 94, 94); =
font-family: Arial; line-height: normal;"><span style=3D"font-size: =
small;" class=3D"">Tel: +1 781.926.0676</span></span></div><div =
style=3D"color: rgb(0, 0, 0); font-family: Arial, sans-serif; font-size: =
11px; margin: 0in 0in 0.0001pt; line-height: normal; widows: 1; =
background-color: rgb(255, 255, 255);" class=3D""><font face=3D"Arial" =
size=3D"2" color=3D"#5e5e5e" class=3D""><a =
href=3D"www.mediavuesystems.com" class=3D"">w</a><span class=3D"" =
style=3D"line-height: normal;"><a href=3D"www.mediavuesystems.com" =
class=3D"">ww.mediavuesystems.com</a></span></font></div></div>
</div>
<br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On May 31, 2017, at 12:24 PM, Deucher, Alexander &lt;<a =
href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" =
class=3D"">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D"">

<meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii" class=3D"">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)" =
class=3D"">
<style class=3D""><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:ArialMT;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.apple-tab-span
	{mso-style-name:apple-tab-span;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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

<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple" class=3D"">
<div class=3D"WordSection1"><p class=3D"MsoNormal"><span =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif=
&quot;;color:#1F497D" class=3D"">Can you bisect?&nbsp; Sounds like the =
monitor does not keep the EDID powered up when the display is off as is =
required by the vesa spec.<o:p class=3D""></o:p></span></p><p =
class=3D"MsoNormal"><span =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif=
&quot;;color:#1F497D" class=3D""><o:p class=3D"">&nbsp;</o:p></span></p><p=
 class=3D"MsoNormal"><span =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif=
&quot;;color:#1F497D" class=3D"">Alex<o:p class=3D""></o:p></span></p><p =
class=3D"MsoNormal"><span =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif=
&quot;;color:#1F497D" class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in =
0in 4.0pt" class=3D"">
<div class=3D"">
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0in 0in 0in" class=3D""><p class=3D"MsoNormal"><b class=3D""><span =
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&=
quot;" class=3D"">From:</span></b><span =
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&=
quot;" class=3D""> Tom Reddish [<a =
href=3D"mailto:tom.reddish-UdFiUJb0jaqhEniVeURVKkEOCMrvLtNR@public.gmane.org" =
class=3D"">mailto:tom.reddish-UdFiUJb0jaqhEniVeURVKkEOCMrvLtNR@public.gmane.org</a>]
<br class=3D"">
<b class=3D"">Sent:</b> Wednesday, May 31, 2017 12:20 PM<br class=3D"">
<b class=3D"">To:</b> Deucher, Alexander; Koenig, Christian<br class=3D"">=

<b class=3D"">Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" =
class=3D"">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Brian Kane<br class=3D"">
<b class=3D"">Subject:</b> Linux Kernel 4.4.0-66 Possible DRM =
connector_status Bug For LG Displays<o:p class=3D""></o:p></span></p>
</div>
</div><p class=3D"MsoNormal"><o:p class=3D"">&nbsp;</o:p></p>
<div class=3D"">
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" class=3D"">LG =
Displays are being reported as "disconnected" when they are powered off =
(currently connected through DVI to mini-displayport adapter)<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Only seeing this with LG displays (have tested NEC and =
Samsung *limited model types for each manufacturer*). With the LG =
display connected to the graphics card and powered off the system is =
reporting
 the DisplayPort as disconnected. In any kernel &lt;=3D 4.4.0-31 the =
system would report the DisplayPort as connected even if the LG display =
was off.&nbsp;<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><b class=3D""><span =
style=3D"font-size:13.5pt;font-family:&quot;ArialMT&quot;,&quot;serif&quot=
;" class=3D"">Kernel tested on</span></b><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Linux version 4.4.0-66-generic (buildd@lgw01-28) (gcc version =
5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4) ) #87-Ubuntu<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><b class=3D""><span =
style=3D"font-size:13.5pt;font-family:&quot;ArialMT&quot;,&quot;serif&quot=
;" class=3D"">Most recent kernel without the bug:&nbsp;</span></b><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Linux version 4.4.0-31-generic (buildd@lgw01-16) (gcc version =
5.3.1 20160413 (Ubuntu 5.3.1-14ubuntu2.1) ) #50-Ubuntu<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">"cat /sys/class/drm/card1-DP-1/status" will show the status =
as disconnected if the LG display is powered off<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><b class=3D""><span =
style=3D"font-size:13.5pt;font-family:&quot;ArialMT&quot;,&quot;serif&quot=
;" class=3D"">Environment</span></b><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D""></o:p></span></p>
</div>
<div class=3D"">
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Ubuntu 16.04<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><b class=3D""><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Graphics Card:</span></b><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;Cape Verde PRO [Radeon HD 7750/8740 / R7 250E]<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Radeon Graphics Drivers<o:p class=3D""></o:p></span></p>
</div>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><b class=3D""><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Kernel:&nbsp;</span></b><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">4.4.0-66<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><b class=3D""><span =
style=3D"font-size:13.5pt;font-family:&quot;ArialMT&quot;,&quot;serif&quot=
;" class=3D"">Processor</span></b><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D""></o:p></span></p>
</div>
<div class=3D"">
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">processor<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 0-3<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">vendor_id<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: AuthenticAMD<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" class=3D"">cpu=
 family<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 21<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">model<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
</span>: 48<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">model name<span class=3D"apple-tab-span">&nbsp;&nbsp;
</span>: AMD A8-7600 Radeon R7, 10 Compute Cores 4C+6G<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">stepping<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 1<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">microcode<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 0x6003106<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" class=3D"">cpu=
 MHz<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 1400.000<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">cache size<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 2048 KB<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">physical id<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 0<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">siblings<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span>: 4<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">core id<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
</span>: 0<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" class=3D"">cpu=
 cores<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 2<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">apicid<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span>: 16<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">initial apicid<span class=3D"apple-tab-span">&nbsp;&nbsp;
</span>: 0<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">fpu<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: yes<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">fpu_exception<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span>: yes<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">cpuid level<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 13<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">wp<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: yes<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">flags<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid =
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma
 cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm =
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop =
skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb =
bpext cpb hw_pstate vmmcall fsgsbase bmi1 xsaveopt
 arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid =
decodeassists pausefilter pfthreshold<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">bugs<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: fxsave_leak sysret_ss_attrs<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">bogomips<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 6188.48<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" class=3D"">TLB=
 size<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 1536 4K pages<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">clflush size<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 64<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">cache_alignment<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 64<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">address sizes<span class=3D"apple-tab-span">&nbsp;
</span>: 48 bits physical, 48 bits virtual<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">power management: ts ttp tm 100mhzsteps hwpstate cpb =
eff_freq_ro [13]<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><b class=3D""><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></b></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><b class=3D""><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></b></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><b class=3D""><span =
style=3D"font-size:13.5pt;font-family:&quot;ArialMT&quot;,&quot;serif&quot=
;" class=3D"">Loaded driver and hardware information</span></b><b =
class=3D""><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D""></o:p></span></b></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><b class=3D""><span =
style=3D"font-size:10.5pt;font-family:&quot;ArialMT&quot;,&quot;serif&quot=
;" class=3D"">cat /proc/ioports:</span></b><b class=3D""><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D""></o:p></span></b></p>
</div>
<div class=3D"">
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">0000-03af : PCI Bus 0000:00<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0000-001f : dma1<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0020-0021 : pic1<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0040-0043 : timer0<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0050-0053 : timer1<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0060-0060 : keyboard<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0061-0061 : PNP0800:00<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0064-0064 : keyboard<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0070-0071 : rtc0<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0080-008f : dma page reg<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 00a0-00a1 : pic2<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 00c0-00df : dma2<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 00f0-00ff : PNP0C04:00<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; 00f0-00ff : fpu<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">03b0-03df : PCI Bus 0000:00<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 03c0-03df : vesafb<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">03e0-0cf7 : PCI Bus 0000:00<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 03f8-03ff : serial<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 040b-040b : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 04d0-04d1 : pnp 00:07<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; 04d0-04d1 : pnp 00:08<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 04d6-04d6 : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0800-0803 : ACPI PM1a_EVT_BLK<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0804-0805 : ACPI PM1a_CNT_BLK<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0808-080b : ACPI PM_TMR<o:p class=3D""></o:p></span></p>=

</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0810-0815 : ACPI CPU throttle<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0820-0827 : ACPI GPE0_BLK<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0900-090f : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0910-091f : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0a00-0a0f : pnp 00:03<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; 0a00-0a07 : f71882fg<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0a10-0a1f : pnp 00:03<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0b00-0b07 : piix4_smbus<o:p class=3D""></o:p></span></p>=

</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0b20-0b3f : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; 0b20-0b27 : piix4_smbus<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0c00-0c01 : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0c14-0c14 : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0c50-0c51 : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0c52-0c52 : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0c6c-0c6c : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0c6f-0c6f : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0cd0-0cd1 : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0cd2-0cd3 : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0cd4-0cd5 : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0cd6-0cd7 : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; 0cd8-0cdf : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">0cf8-0cff : PCI conf1<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">0d00-ffff : PCI Bus 0000:00<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; d000-dfff : PCI Bus 0000:02<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; d000-d0ff : 0000:02:00.0<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; &nbsp; d000-d0ff : r8169<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; e000-efff : PCI Bus 0000:01<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; e000-e0ff : 0000:01:00.0<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; f000-f0ff : 0000:00:01.0<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; f100-f10f : 0000:00:11.0<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; f100-f10f : ahci<o:p class=3D""></o:p></span></p>=

</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; f110-f113 : 0000:00:11.0<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; f110-f113 : ahci<o:p class=3D""></o:p></span></p>=

</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; f120-f127 : 0000:00:11.0<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; f120-f127 : ahci<o:p class=3D""></o:p></span></p>=

</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; f130-f133 : 0000:00:11.0<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; f130-f133 : ahci<o:p class=3D""></o:p></span></p>=

</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; f140-f147 : 0000:00:11.0<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; &nbsp; f140-f147 : ahci<o:p class=3D""></o:p></span></p>=

</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp; fe00-fefe : pnp 00:08<o:p class=3D""></o:p></span></p>
</div>
</div>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><b class=3D""><span =
style=3D"font-size:13.5pt;font-family:&quot;ArialMT&quot;,&quot;serif&quot=
;" class=3D"">PCI Information</span></b><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D""></o:p></span></p>
</div>
<div class=3D"">
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">01:00.0 VGA compatible controller: Advanced Micro Devices, =
Inc. [AMD/ATI] Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] (prog-if =
00 [VGA controller])<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Subsystem: Hightech Information System Ltd. Cape Verde PRO =
[Radeon HD 7750/8740 / R7 250E]<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx+<o:p class=3D""></o:p></span></p>=

</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast =
&gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Latency: 0, Cache Line Size: 64 bytes<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Interrupt: pin A routed to IRQ 48<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Region 0: Memory at c0000000 (64-bit, prefetchable) =
[size=3D256M]<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Region 2: Memory at fea00000 (64-bit, non-prefetchable) =
[size=3D256K]<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Region 4: I/O ports at e000 [size=3D256]<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Expansion ROM at fea40000 [disabled] [size=3D128K]<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Capabilities: [48] Vendor Specific Information: Len=3D08 =
&lt;?&gt;<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Capabilities: [50] Power Management version 3<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1+,D2+,D3hot+,D3cold-)<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 =
PME-<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">DevCap:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span>MaxPayload 256 bytes, PhantFunc 0, Latency L0s &lt;4us, L1 =
unlimited<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">DevCtl:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span>Report errors: Correctable- Non-Fatal- Fatal- Unsupported-<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">MaxPayload 256 bytes, MaxReadReq 512 bytes<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">DevSta:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span>CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">LnkCap:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span>Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s =
&lt;64ns, L1 &lt;1us<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">LnkCtl:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span>ASPM Disabled; RCB 64 bytes Disabled- CommClk+<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">LnkSta:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span>Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- =
ABWMgmt-<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">DevCap2: Completion Timeout: Not Supported, TimeoutDis-, =
LTR-, OBFF Not Supported<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, =
OBFF Disabled<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- =
SpeedDis-<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;Transmit Margin: Normal Operating Range, =
EnterModifiedCompliance- ComplianceSOS-<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;Compliance De-emphasis: -6dB<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">LnkSta2: Current De-emphasis Level: -6dB, =
EqualizationComplete+, EqualizationPhase1+<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;EqualizationPhase2+, EqualizationPhase3+, =
LinkEqualizationRequest-<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- =
64bit+<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Address: 00000000fee00000 &nbsp;Data: 0000<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 =
Rev=3D1 Len=3D010 &lt;?&gt;<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Capabilities: [150 v2] Advanced Error Reporting<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">UESta:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span>DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">UEMsk:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span>DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- =
ECRC- UnsupReq- ACSViol-<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">UESvrt:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span>DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ =
ECRC- UnsupReq- ACSViol-<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">CESta:<span class=3D"apple-tab-span">
</span>RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">CEMsk:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span>RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">AERCap:<span =
class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-<o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Capabilities: [200 v1] #15<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Capabilities: [270 v1] #19<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Kernel driver in use: radeon<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
class=3D"apple-tab-span"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D"">Kernel modules: radeon<o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;" =
class=3D""><o:p class=3D"">&nbsp;</o:p></span></p>
</div>
</div>
</div>
<div class=3D""><p class=3D"MsoNormal"><o:p class=3D"">&nbsp;</o:p></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><o:p class=3D"">&nbsp;</o:p></p>
</div><p class=3D"MsoNormal"><o:p class=3D"">&nbsp;</o:p></p>
<div class=3D"">
<div class=3D"">
<div class=3D""><p class=3D"MsoNormal" style=3D"background:white"><span =
style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#5E5E5=
E" class=3D"">Tom Reddish&nbsp;</span><span style=3D"font-family: Arial, =
sans-serif;" class=3D""><o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal"><span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&q=
uot;;color:#5E5E5E;background:#FFFEFE" class=3D"">Software =
Engineer</span><span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&q=
uot;;color:#5E5E5E" class=3D""><br class=3D"">
<span style=3D"background:white" class=3D"">MediaVue =
Systems</span></span><span style=3D"font-size: 8.5pt; font-family: =
Arial, sans-serif;" class=3D""><o:p class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal" style=3D"background:white"><span =
style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#5E5E5=
E" class=3D"">Skype: t.reddish</span><span style=3D"font-size: 8.5pt; =
font-family: Arial, sans-serif;" class=3D""><o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal" style=3D"background:white"><span =
style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#5E5E5=
E" class=3D"">Tel: +1 781.926.0676</span><span style=3D"font-size: =
8.5pt; font-family: Arial, sans-serif;" class=3D""><o:p =
class=3D""></o:p></span></p>
</div>
<div class=3D""><p class=3D"MsoNormal" style=3D"background:white"><span =
style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&q=
uot;;color:#5E5E5E" class=3D""><a =
href=3D"x-msg://8/www.mediavuesystems.com" class=3D"">w</a><a =
href=3D"x-msg://8/www.mediavuesystems.com" =
class=3D"">ww.mediavuesystems.com</a></span><span style=3D"font-size: =
8.5pt; font-family: Arial, sans-serif;" class=3D""><o:p =
class=3D""></o:p></span></p>
</div>
</div>
</div><p class=3D"MsoNormal"><o:p class=3D"">&nbsp;</o:p></p>
</div>
</div>
</div>

</div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_1B2EFEE6-A14E-4BD7-8840-F96448DBA4D2--

--===============1518739682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1518739682==--
