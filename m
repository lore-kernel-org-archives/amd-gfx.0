From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: Linux Kernel 4.4.0-66 Possible DRM connector_status Bug For LG
 Displays
Date: Wed, 31 May 2017 16:24:30 +0000
Message-ID: <BN6PR12MB1652303B932BA05D0858FDEDF7F10@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <4A782E6D-F40F-41F0-A3C4-A74F460CB1AE@mediavuesystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1870619723=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4A782E6D-F40F-41F0-A3C4-A74F460CB1AE-UdFiUJb0jaqhEniVeURVKkEOCMrvLtNR@public.gmane.org>
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
To: 'Tom Reddish' <tom.reddish-UdFiUJb0jaqhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Brian Kane <brian.kane-UdFiUJb0jaqhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1870619723==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652303B932BA05D0858FDEDF7F10BN6PR12MB1652namp_"

--_000_BN6PR12MB1652303B932BA05D0858FDEDF7F10BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Can you bisect?  Sounds like the monitor does not keep the EDID powered up =
when the display is off as is required by the vesa spec.

Alex

From: Tom Reddish [mailto:tom.reddish-UdFiUJb0jaqhEniVeURVKkEOCMrvLtNR@public.gmane.org]
Sent: Wednesday, May 31, 2017 12:20 PM
To: Deucher, Alexander; Koenig, Christian
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Brian Kane
Subject: Linux Kernel 4.4.0-66 Possible DRM connector_status Bug For LG Dis=
plays


LG Displays are being reported as "disconnected" when they are powered off =
(currently connected through DVI to mini-displayport adapter)

Only seeing this with LG displays (have tested NEC and Samsung *limited mod=
el types for each manufacturer*). With the LG display connected to the grap=
hics card and powered off the system is reporting the DisplayPort as discon=
nected. In any kernel <=3D 4.4.0-31 the system would report the DisplayPort=
 as connected even if the LG display was off.

Kernel tested on
Linux version 4.4.0-66-generic (buildd@lgw01-28) (gcc version 5.4.0 2016060=
9 (Ubuntu 5.4.0-6ubuntu1~16.04.4) ) #87-Ubuntu

Most recent kernel without the bug:
Linux version 4.4.0-31-generic (buildd@lgw01-16) (gcc version 5.3.1 2016041=
3 (Ubuntu 5.3.1-14ubuntu2.1) ) #50-Ubuntu

"cat /sys/class/drm/card1-DP-1/status" will show the status as disconnected=
 if the LG display is powered off

Environment
          Ubuntu 16.04
          Graphics Card: Cape Verde PRO [Radeon HD 7750/8740 / R7 250E]
          Radeon Graphics Drivers
          Kernel: 4.4.0-66


Processor
processor       : 0-3
vendor_id      : AuthenticAMD
cpu family     : 21
model                        : 48
model name   : AMD A8-7600 Radeon R7, 10 Compute Cores 4C+6G
stepping         : 1
microcode      : 0x6003106
cpu MHz                   : 1400.000
cache size      : 2048 KB
physical id     : 0
siblings          : 4
core id                       : 0
cpu cores       : 2
apicid             : 16
initial apicid   : 0
fpu                 : yes
fpu_exception           : yes
cpuid level     : 13
wp                 : yes
flags               : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfm=
perf eagerfpu pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes=
 xsave avx f16c lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalig=
nsse 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topo=
ext perfctr_core perfctr_nb bpext cpb hw_pstate vmmcall fsgsbase bmi1 xsave=
opt arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decod=
eassists pausefilter pfthreshold
bugs               : fxsave_leak sysret_ss_attrs
bogomips       : 6188.48
TLB size        : 1536 4K pages
clflush size     : 64
cache_alignment        : 64
address sizes  : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro [13]


Loaded driver and hardware information
cat /proc/ioports:
0000-03af : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0061-0061 : PNP0800:00
  0064-0064 : keyboard
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : PNP0C04:00
    00f0-00ff : fpu
03b0-03df : PCI Bus 0000:00
  03c0-03df : vesafb
03e0-0cf7 : PCI Bus 0000:00
  03f8-03ff : serial
  040b-040b : pnp 00:08
  04d0-04d1 : pnp 00:07
    04d0-04d1 : pnp 00:08
  04d6-04d6 : pnp 00:08
  0800-0803 : ACPI PM1a_EVT_BLK
  0804-0805 : ACPI PM1a_CNT_BLK
  0808-080b : ACPI PM_TMR
  0810-0815 : ACPI CPU throttle
  0820-0827 : ACPI GPE0_BLK
  0900-090f : pnp 00:08
  0910-091f : pnp 00:08
  0a00-0a0f : pnp 00:03
    0a00-0a07 : f71882fg
  0a10-0a1f : pnp 00:03
  0b00-0b07 : piix4_smbus
  0b20-0b3f : pnp 00:08
    0b20-0b27 : piix4_smbus
  0c00-0c01 : pnp 00:08
  0c14-0c14 : pnp 00:08
  0c50-0c51 : pnp 00:08
  0c52-0c52 : pnp 00:08
  0c6c-0c6c : pnp 00:08
  0c6f-0c6f : pnp 00:08
  0cd0-0cd1 : pnp 00:08
  0cd2-0cd3 : pnp 00:08
  0cd4-0cd5 : pnp 00:08
  0cd6-0cd7 : pnp 00:08
  0cd8-0cdf : pnp 00:08
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  d000-dfff : PCI Bus 0000:02
    d000-d0ff : 0000:02:00.0
      d000-d0ff : r8169
  e000-efff : PCI Bus 0000:01
    e000-e0ff : 0000:01:00.0
  f000-f0ff : 0000:00:01.0
  f100-f10f : 0000:00:11.0
    f100-f10f : ahci
  f110-f113 : 0000:00:11.0
    f110-f113 : ahci
  f120-f127 : 0000:00:11.0
    f120-f127 : ahci
  f130-f133 : 0000:00:11.0
    f130-f133 : ahci
  f140-f147 : 0000:00:11.0
    f140-f147 : ahci
  fe00-fefe : pnp 00:08

PCI Information
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] C=
ape Verde PRO [Radeon HD 7750/8740 / R7 250E] (prog-if 00 [VGA controller])
          Subsystem: Hightech Information System Ltd. Cape Verde PRO [Radeo=
n HD 7750/8740 / R7 250E]
          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+
          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
          Latency: 0, Cache Line Size: 64 bytes
          Interrupt: pin A routed to IRQ 48
          Region 0: Memory at c0000000 (64-bit, prefetchable) [size=3D256M]
          Region 2: Memory at fea00000 (64-bit, non-prefetchable) [size=3D2=
56K]
          Region 4: I/O ports at e000 [size=3D256]
          Expansion ROM at fea40000 [disabled] [size=3D128K]
          Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
          Capabilities: [50] Power Management version 3
                      Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,=
D1+,D2+,D3hot+,D3cold-)
                      Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0=
 PME-
          Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
                      DevCap:          MaxPayload 256 bytes, PhantFunc 0, L=
atency L0s <4us, L1 unlimited
                                  ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FL=
Reset-
                      DevCtl:           Report errors: Correctable- Non-Fat=
al- Fatal- Unsupported-
                                  RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSno=
op+
                                  MaxPayload 256 bytes, MaxReadReq 512 byte=
s
                      DevSta:           CorrErr+ UncorrErr- FatalErr- Unsup=
pReq+ AuxPwr- TransPend-
                      LnkCap:          Port #0, Speed 8GT/s, Width x16, ASP=
M L0s L1, Exit Latency L0s <64ns, L1 <1us
                                  ClockPM- Surprise- LLActRep- BwNot- ASPMO=
ptComp+
                      LnkCtl:            ASPM Disabled; RCB 64 bytes Disabl=
ed- CommClk+
                                  ExtSynch- ClockPM- AutWidDis- BWInt- AutB=
WInt-
                      LnkSta:           Speed 8GT/s, Width x16, TrErr- Trai=
n- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                      DevCap2: Completion Timeout: Not Supported, TimeoutDi=
s-, LTR-, OBFF Not Supported
                      DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis=
-, LTR-, OBFF Disabled
                      LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- S=
peedDis-
                                   Transmit Margin: Normal Operating Range,=
 EnterModifiedCompliance- ComplianceSOS-
                                   Compliance De-emphasis: -6dB
                      LnkSta2: Current De-emphasis Level: -6dB, Equalizatio=
nComplete+, EqualizationPhase1+
                                   EqualizationPhase2+, EqualizationPhase3+=
, LinkEqualizationRequest-
          Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                      Address: 00000000fee00000  Data: 0000
          Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=
=3D1 Len=3D010 <?>
          Capabilities: [150 v2] Advanced Error Reporting
                      UESta:            DLP- SDES- TLP- FCP- CmpltTO- Cmplt=
Abrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                      UEMsk:           DLP- SDES- TLP- FCP- CmpltTO- CmpltA=
brt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                      UESvrt:           DLP+ SDES+ TLP- FCP+ CmpltTO- Cmplt=
Abrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                      CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- Non=
FatalErr+
                      CEMsk:           RxErr- BadTLP- BadDLLP- Rollover- Ti=
meout- NonFatalErr+
                      AERCap:        First Error Pointer: 00, GenCap+ CGenE=
n- ChkCap+ ChkEn-
          Capabilities: [200 v1] #15
          Capabilities: [270 v1] #19
          Kernel driver in use: radeon
          Kernel modules: radeon




Tom Reddish
Software Engineer
MediaVue Systems
Skype: t.reddish
Tel: +1 781.926.0676
w<www.mediavuesystems.com>ww.mediavuesystems.com<www.mediavuesystems.com>


--_000_BN6PR12MB1652303B932BA05D0858FDEDF7F10BN6PR12MB1652namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
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
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Can you bisect?&nbsp; Sou=
nds like the monitor does not keep the EDID powered up when the display is =
off as is required by the vesa spec.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Tom Redd=
ish [mailto:tom.reddish-UdFiUJb0jaqhEniVeURVKkEOCMrvLtNR@public.gmane.org]
<br>
<b>Sent:</b> Wednesday, May 31, 2017 12:20 PM<br>
<b>To:</b> Deucher, Alexander; Koenig, Christian<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Brian Kane<br>
<b>Subject:</b> Linux Kernel 4.4.0-66 Possible DRM connector_status Bug For=
 LG Displays<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">LG Displays are being reported as &quot;disconnected&quot; wh=
en they are powered off (currently connected through DVI to mini-displaypor=
t adapter)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">Only seeing this with LG displays (have tested NEC and Samsun=
g *limited model types for each manufacturer*). With the LG display connect=
ed to the graphics card and powered off the system is reporting
 the DisplayPort as disconnected. In any kernel &lt;=3D 4.4.0-31 the system=
 would report the DisplayPort as connected even if the LG display was off.&=
nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:13.5pt;font-family:&quot=
;ArialMT&quot;,&quot;serif&quot;">Kernel tested on</span></b><span style=3D=
"font-family:&quot;ArialMT&quot;,&quot;serif&quot;"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">Linux version 4.4.0-66-generic (buildd@lgw01-28) (gcc version=
 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4) ) #87-Ubuntu<o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:13.5pt;font-family:&quot=
;ArialMT&quot;,&quot;serif&quot;">Most recent kernel without the bug:&nbsp;=
</span></b><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">Linux version 4.4.0-31-generic (buildd@lgw01-16) (gcc version=
 5.3.1 20160413 (Ubuntu 5.3.1-14ubuntu2.1) ) #50-Ubuntu<o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&quot;cat /sys/class/drm/card1-DP-1/status&quot; will show th=
e status as disconnected if the LG display is powered off<o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:13.5pt;font-family:&quot=
;ArialMT&quot;,&quot;serif&quot;">Environment</span></b><span style=3D"font=
-family:&quot;ArialMT&quot;,&quot;serif&quot;"><o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Ubuntu 16.04<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><b><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif=
&quot;">Graphics Card:</span></b><span style=3D"font-family:&quot;ArialMT&q=
uot;,&quot;serif&quot;">&nbsp;Cape Verde PRO [Radeon HD 7750/8740 / R7 250E=
]<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Radeon Graphics Drivers<o:p></o:p></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><b><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif=
&quot;">Kernel:&nbsp;</span></b><span style=3D"font-family:&quot;ArialMT&qu=
ot;,&quot;serif&quot;">4.4.0-66<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:13.5pt;font-family:&quot=
;ArialMT&quot;,&quot;serif&quot;">Processor</span></b><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;"><o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">processor<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
</span>: 0-3<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">vendor_id<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
</span>: AuthenticAMD<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">cpu family<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&n=
bsp;
</span>: 21<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">model<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 48<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">model name<span class=3D"apple-tab-span">&nbsp;&nbsp;
</span>: AMD A8-7600 Radeon R7, 10 Compute Cores 4C&#43;6G<o:p></o:p></span=
></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">stepping<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 1<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">microcode<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
</span>: 0x6003106<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">cpu MHz<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
</span>: 1400.000<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">cache size<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
</span>: 2048 KB<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">physical id<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&=
nbsp;
</span>: 0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">siblings<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 4<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">core id<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">cpu cores<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
</span>: 2<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">apicid<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 16<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">initial apicid<span class=3D"apple-tab-span">&nbsp;&nbsp;
</span>: 0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">fpu<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: yes<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">fpu_exception<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: yes<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">cpuid level<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&=
nbsp;
</span>: 13<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">wp<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: yes<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">flags<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtsc=
p lm constant_tsc rep_good nopl nonstop_tsc extd_apicid aperfmperf eagerfpu=
 pni pclmulqdq monitor ssse3 fma
 cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapi=
c cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt lw=
p fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb bpext cpb hw_psta=
te vmmcall fsgsbase bmi1 xsaveopt
 arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeas=
sists pausefilter pfthreshold<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">bugs<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: fxsave_leak sysret_ss_attrs<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">bogomips<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
</span>: 6188.48<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">TLB size<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
</span>: 1536 4K pages<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">clflush size<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;=
&nbsp;
</span>: 64<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">cache_alignment<span class=3D"apple-tab-span">&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>: 64<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">address sizes<span class=3D"apple-tab-span">&nbsp;
</span>: 48 bits physical, 48 bits virtual<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq=
_ro [13]<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;ArialMT&quot;,&q=
uot;serif&quot;"><o:p>&nbsp;</o:p></span></b></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;ArialMT&quot;,&q=
uot;serif&quot;"><o:p>&nbsp;</o:p></span></b></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:13.5pt;font-family:&quot=
;ArialMT&quot;,&quot;serif&quot;">Loaded driver and hardware information</s=
pan></b><b><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;=
"><o:p></o:p></span></b></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.5pt;font-family:&quot=
;ArialMT&quot;,&quot;serif&quot;">cat /proc/ioports:</span></b><b><span sty=
le=3D"font-family:&quot;ArialMT&quot;,&quot;serif&quot;"><o:p></o:p></span>=
</b></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">0000-03af : PCI Bus 0000:00<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0000-001f : dma1<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0020-0021 : pic1<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0040-0043 : timer0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0050-0053 : timer1<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0060-0060 : keyboard<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0061-0061 : PNP0800:00<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0064-0064 : keyboard<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0070-0071 : rtc0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0080-008f : dma page reg<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 00a0-00a1 : pic2<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 00c0-00df : dma2<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 00f0-00ff : PNP0C04:00<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; 00f0-00ff : fpu<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">03b0-03df : PCI Bus 0000:00<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 03c0-03df : vesafb<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">03e0-0cf7 : PCI Bus 0000:00<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 03f8-03ff : serial<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 040b-040b : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 04d0-04d1 : pnp 00:07<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; 04d0-04d1 : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 04d6-04d6 : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0800-0803 : ACPI PM1a_EVT_BLK<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0804-0805 : ACPI PM1a_CNT_BLK<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0808-080b : ACPI PM_TMR<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0810-0815 : ACPI CPU throttle<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0820-0827 : ACPI GPE0_BLK<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0900-090f : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0910-091f : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0a00-0a0f : pnp 00:03<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; 0a00-0a07 : f71882fg<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0a10-0a1f : pnp 00:03<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0b00-0b07 : piix4_smbus<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0b20-0b3f : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; 0b20-0b27 : piix4_smbus<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0c00-0c01 : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0c14-0c14 : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0c50-0c51 : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0c52-0c52 : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0c6c-0c6c : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0c6f-0c6f : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0cd0-0cd1 : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0cd2-0cd3 : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0cd4-0cd5 : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0cd6-0cd7 : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; 0cd8-0cdf : pnp 00:08<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">0cf8-0cff : PCI conf1<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">0d00-ffff : PCI Bus 0000:00<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; d000-dfff : PCI Bus 0000:02<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; d000-d0ff : 0000:02:00.0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; &nbsp; d000-d0ff : r8169<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; e000-efff : PCI Bus 0000:01<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; e000-e0ff : 0000:01:00.0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; f000-f0ff : 0000:00:01.0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; f100-f10f : 0000:00:11.0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; f100-f10f : ahci<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; f110-f113 : 0000:00:11.0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; f110-f113 : ahci<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; f120-f127 : 0000:00:11.0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; f120-f127 : ahci<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; f130-f133 : 0000:00:11.0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; f130-f133 : ahci<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; f140-f147 : 0000:00:11.0<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; &nbsp; f140-f147 : ahci<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">&nbsp; fe00-fefe : pnp 00:08<o:p></o:p></span></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:13.5pt;font-family:&quot=
;ArialMT&quot;,&quot;serif&quot;">PCI Information</span></b><span style=3D"=
font-family:&quot;ArialMT&quot;,&quot;serif&quot;"><o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;">01:00.0 VGA compatible controller: Advanced Micro Devices, In=
c. [AMD/ATI] Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] (prog-if 00 [VG=
A controller])<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Subsystem: Hightech Information System Ltd. Cape Verde PRO [Radeon HD =
7750/8740 / R7 250E]<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Control: I/O&#43; Mem&#43; BusMaster&#43; SpecCycle- MemWINV- VGASnoop=
- ParErr- Stepping- SERR- FastB2B- DisINTx&#43;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Status: Cap&#43; 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast &gt;TAbort=
- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Latency: 0, Cache Line Size: 64 bytes<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Interrupt: pin A routed to IRQ 48<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Region 0: Memory at c0000000 (64-bit, prefetchable) [size=3D256M]<o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Region 2: Memory at fea00000 (64-bit, non-prefetchable) [size=3D256K]<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Region 4: I/O ports at e000 [size=3D256]<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Expansion ROM at fea40000 [disabled] [size=3D128K]<o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Capabilities: [48] Vendor Specific Information: Len=3D08 &lt;?&gt;<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Capabilities: [50] Power Management version 3<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Flags: PMEClk- DSI- D1&#43; D2&#43; AuxCurrent=3D0mA PME(D0-,D1&#43;,D=
2&#43;,D3hot&#43;,D3cold-)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-<o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00<o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">DevCap:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
</span>MaxPayload 256 bytes, PhantFunc 0, Latency L0s &lt;4us, L1 unlimited=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">ExtTag&#43; AttnBtn- AttnInd- PwrInd- RBE&#43; FLReset-<o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">DevCtl:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Report errors: Correctable- Non-Fatal- Fatal- Unsupported-<o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop&#43;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">MaxPayload 256 bytes, MaxReadReq 512 bytes<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">DevSta:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>CorrErr&#43; UncorrErr- FatalErr- UnsuppReq&#43; AuxPwr- TransPend-<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">LnkCap:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;
</span>Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s &lt;6=
4ns, L1 &lt;1us<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp&#43;<o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">LnkCtl:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>ASPM Disabled; RCB 64 bytes Disabled- CommClk&#43;<o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">LnkSta:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>Speed 8GT/s, Width x16, TrErr- Train- SlotClk&#43; DLActive- BWMgmt-=
 ABWMgmt-<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF No=
t Supported<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Dis=
abled<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-<o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">&nbsp;Transmit Margin: Normal Operating Range, EnterModifiedCompliance=
- ComplianceSOS-<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">&nbsp;Compliance De-emphasis: -6dB<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete&#43;, E=
qualizationPhase1&#43;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">&nbsp;EqualizationPhase2&#43;, EqualizationPhase3&#43;, LinkEqualizati=
onRequest-<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Capabilities: [a0] MSI: Enable&#43; Count=3D1/1 Maskable- 64bit&#43;<o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Address: 00000000fee00000 &nbsp;Data: 0000<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 =
Len=3D010 &lt;?&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Capabilities: [150 v2] Advanced Error Reporting<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">UESta:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- EC=
RC- UnsupReq- ACSViol-<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">UEMsk:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- EC=
RC- UnsupReq- ACSViol-<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">UESvrt:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>DLP&#43; SDES&#43; TLP- FCP&#43; CmpltTO- CmpltAbrt- UnxCmplt- RxOF&=
#43; MalfTLP&#43; ECRC- UnsupReq- ACSViol-<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">CESta:<span class=3D"apple-tab-span">
</span>RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr&#43;<o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">CEMsk:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr&#43;<o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">AERCap:<span class=3D"apple-tab-span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;
</span>First Error Pointer: 00, GenCap&#43; CGenEn- ChkCap&#43; ChkEn-<o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Capabilities: [200 v1] #15<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Capabilities: [270 v1] #19<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Kernel driver in use: radeon<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"apple-tab-span"><span style=3D"font-f=
amily:&quot;ArialMT&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span style=3D"font-family:&quot;ArialMT&quot;,&quot;serif&qu=
ot;">Kernel modules: radeon<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;ArialMT&quot;,&quot=
;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#5E5E5E">Tom Reddish&nbsp;=
</span><span style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;=
color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;;color:#5E5E5E;background:#FFFEFE">Software=
 Engineer</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quo=
t;,&quot;sans-serif&quot;;color:#5E5E5E"><br>
<span style=3D"background:white">MediaVue Systems</span></span><span style=
=3D"font-size:8.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#5E5E5E">Skype: t.reddish<=
/span><span style=3D"font-size:8.5pt;font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#5E5E5E">Tel: &#43;1 781.9=
26.0676</span><span style=3D"font-size:8.5pt;font-family:&quot;Arial&quot;,=
&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#5E5E5E">=
<a href=3D"www.mediavuesystems.com">w</a><a href=3D"www.mediavuesystems.com=
">ww.mediavuesystems.com</a></span><span style=3D"font-size:8.5pt;font-fami=
ly:&quot;Arial&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span>=
</p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652303B932BA05D0858FDEDF7F10BN6PR12MB1652namp_--

--===============1870619723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1870619723==--
