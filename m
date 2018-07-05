From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: BUG: *ERROR* No EDID read
Date: Thu, 5 Jul 2018 16:42:46 +0000
Message-ID: <BN6PR12MB180950F0998981DCEA29C353F7400@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <CAFwJxe7NGsS+3sKXgHRgd9f=2AsMWFP3FVwsO5T+zmN8oYBZ3Q@mail.gmail.com>
 <CADnq5_PXVhgG4NhT4gnseC9wmvLxHm3mmJx32aCmvbW=SOf8YQ@mail.gmail.com>
 <CAFwJxe5O+UorFK58yTddmPzOoOVS=LVLdKb0eCyLnZBRkTo=FA@mail.gmail.com>
 <CADnq5_Owis9hPZkGO1ctcft8zx1eRjyMU-k0FB9ErfboDUwVSA@mail.gmail.com>,
 <CAFwJxe6ky_+8OmibKh+p70BXKLQ439h+cR1d_twQEoJrB8moCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0076609571=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFwJxe6ky_+8OmibKh+p70BXKLQ439h+cR1d_twQEoJrB8moCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Daniel Andersson <engywook-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0076609571==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180950F0998981DCEA29C353F7400BN6PR12MB1809namp_"

--_000_BN6PR12MB180950F0998981DCEA29C353F7400BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

So your vbios has table v3.1 so it should not be affected by that patch.  D=
oes reverting that patch actually fix the issue?


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Daniel A=
ndersson <engywook-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, July 5, 2018 12:22:17 PM
To: Alex Deucher
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: BUG: *ERROR* No EDID read

I have not flashed any GPU BIOS. It's not a reference Vega though,
Sapphire something. Maybe they made changes?

vbios is attached.

// Daniel

On 5 July 2018 at 15:38, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Jul 2, 2018 at 5:39 PM, Daniel Andersson <engywook-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
>> Sure, bisecting gets me 6e65fb862064663ad3a08f964af1e8f3f2abf688 .
>>
>> In drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c,
>> get_firmware_info_v3_1() works but get_firmware_info_v3_2() does not
>> do the right thing for my Vega.
>>
>> Could I break my GPU if I were to set some bad/wrong frequency there?
>
> vega10 should not hit that new path at all.  Have you edited your
> vbios?  Can you send us a copy?  To get a copy of the vbios:
>
> Without the driver loaded:
> (as root)
> (use lspci to get the bus id)
> cd /sys/bus/pci/devices/<pci bus id>
> echo 1 > rom
> cat rom > /tmp/vbios.rom
> echo 0 > rom
>
> If the driver is loaded:
> (as root)
> cat /sys/kernel/debug/dri/0/amdgpu_vbios > /tmp/vbios.rom
>
> Alex
>
>>
>> lspci:
>> 43:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>> [AMD/ATI] Vega 10 XT [Radeon RX Vega 64] (rev c1) (prog-if 00 [VGA
>> controller])
>>   Subsystem: Sapphire Technology Limited Vega 10 XT [Radeon RX Vega
>> 64]
>>   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>>   Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>   Latency: 0, Cache Line Size: 64 bytes
>>   Interrupt: pin A routed to IRQ 85
>>   Region 0: Memory at d0000000 (64-bit, prefetchable) [size=3D256M]
>>   Region 2: Memory at e0000000 (64-bit, prefetchable) [size=3D2M]
>>   Region 4: I/O ports at f000 [size=3D256]
>>   Region 5: Memory at ed400000 (32-bit, non-prefetchable) [size=3D512K]
>>   Expansion ROM at ed480000 [disabled] [size=3D128K]
>>   Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
>>   Capabilities: [50] Power Management version 3
>>     Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
>> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>>     Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
>>   Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
>>     DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1
>> unlimited
>>       ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>>     DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>       RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>       MaxPayload 256 bytes, MaxReadReq 512 bytes
>>     DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
>> TransPend-
>>     LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency
>> L0s <64ns, L1 <1us
>>       ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>>     LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
>>       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>     LnkSta: Speed 8GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
>> BWMgmt- ABWMgmt-
>>     DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+,
>> OBFF Not Supported
>>        AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>     DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF
>> Disabled
>>        AtomicOpsCtl: ReqEn-
>>     LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>>        Transmit Margin: Normal Operating Range,
>> EnterModifiedCompliance- ComplianceSOS-
>>        Compliance De-emphasis: -6dB
>>     LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+,
>> EqualizationPhase1+
>>        EqualizationPhase2+, EqualizationPhase3+,
>> LinkEqualizationRequest-
>>   Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>>     Address: 00000000fee00000  Data: 0000
>>   Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1
>> Len=3D010 <?>
>>   Capabilities: [150 v2] Advanced Error Reporting
>>     UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>     UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
>> MalfTLP- ECRC- UnsupReq- ACSViol-
>>     UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
>> MalfTLP+ ECRC- UnsupReq- ACSViol-
>>     CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>     CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>>     AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
>> ECRCChkCap+ ECRCChkEn-
>>       MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>>     HeaderLog: 00000000 00000000 00000000 00000000
>>   Capabilities: [200 v1] #15
>>   Capabilities: [270 v1] #19
>>   Capabilities: [2a0 v1] Access Control Services
>>     ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
>> EgressCtrl- DirectTrans-
>>     ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
>> EgressCtrl- DirectTrans-
>>   Capabilities: [2b0 v1] Address Translation Service (ATS)
>>     ATSCap: Invalidate Queue Depth: 00
>>     ATSCtl: Enable+, Smallest Translation Unit: 00
>>   Capabilities: [2c0 v1] Page Request Interface (PRI)
>>     PRICtl: Enable- Reset-
>>     PRISta: RF- UPRGI- Stopped+
>>     Page Request Capacity: 00000020, Page Request Allocation: 00000000
>>   Capabilities: [2d0 v1] Process Address Space ID (PASID)
>>     PASIDCap: Exec+ Priv+, Max PASID Width: 10
>>     PASIDCtl: Enable- Exec- Priv-
>>   Capabilities: [320 v1] Latency Tolerance Reporting
>>     Max snoop latency: 0ns
>>     Max no snoop latency: 0ns
>>   Kernel driver in use: amdgpu
>>   Kernel modules: amdgpu
>>
>> // Daniel
>>
>> On 2 July 2018 at 21:29, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> On Mon, Jul 2, 2018 at 3:21 PM, Daniel Andersson <engywook-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
>>>> I get:
>>>> [drm:dc_link_detect [amdgpu]] *ERROR* No EDID read.
>>>> on boot. This started happening on 4.17 and is still an issue on 4.18-=
rc2.
>>>>
>>>> I have a Vega64 connected on Display Port to a monitor(1440p). The mon=
itor
>>>> doesn't have any additional ports so I can't test HDMI.
>>>>
>>>> xrandr:
>>>> Screen 0: minimum 320 x 200, current 1024 x 768, maximum 16384 x 16384
>>>> DisplayPort-0 connected 1024x768+0+0 (normal left inverted right x axi=
s y
>>>> axis) 0mm x 0mm
>>>>    1024x768      60.00*
>>>>    800x600       60.32    56.25
>>>>    848x480       60.00
>>>>    640x480       59.94
>>>> DisplayPort-1 disconnected (normal left inverted right x axis y axis)
>>>> HDMI-A-0 disconnected (normal left inverted right x axis y axis)
>>>> HDMI-A-1 disconnected (normal left inverted right x axis y axis)
>>>>
>>>> The 1440p resolution worked on 4.16.
>>>
>>> Can you use git to bisect?
>>>
>>> Alex

--_000_BN6PR12MB180950F0998981DCEA29C353F7400BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">So your vbios has table v3.1 so i=
t should not be affected by that patch.&nbsp; Does reverting that patch act=
ually fix the issue?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Daniel Andersson &lt;engywook=
@gmail.com&gt;<br>
<b>Sent:</b> Thursday, July 5, 2018 12:22:17 PM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: BUG: *ERROR* No EDID read</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I have not flashed any GPU BIOS. It's not a refere=
nce Vega though,<br>
Sapphire something. Maybe they made changes?<br>
<br>
vbios is attached.<br>
<br>
// Daniel<br>
<br>
On 5 July 2018 at 15:38, Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<=
br>
&gt; On Mon, Jul 2, 2018 at 5:39 PM, Daniel Andersson &lt;engywook-Re5JQEeQqe8@public.gmane.org=
m&gt; wrote:<br>
&gt;&gt; Sure, bisecting gets me 6e65fb862064663ad3a08f964af1e8f3f2abf688 .=
<br>
&gt;&gt;<br>
&gt;&gt; In drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c,<br>
&gt;&gt; get_firmware_info_v3_1() works but get_firmware_info_v3_2() does n=
ot<br>
&gt;&gt; do the right thing for my Vega.<br>
&gt;&gt;<br>
&gt;&gt; Could I break my GPU if I were to set some bad/wrong frequency the=
re?<br>
&gt;<br>
&gt; vega10 should not hit that new path at all.&nbsp; Have you edited your=
<br>
&gt; vbios?&nbsp; Can you send us a copy?&nbsp; To get a copy of the vbios:=
<br>
&gt;<br>
&gt; Without the driver loaded:<br>
&gt; (as root)<br>
&gt; (use lspci to get the bus id)<br>
&gt; cd /sys/bus/pci/devices/&lt;pci bus id&gt;<br>
&gt; echo 1 &gt; rom<br>
&gt; cat rom &gt; /tmp/vbios.rom<br>
&gt; echo 0 &gt; rom<br>
&gt;<br>
&gt; If the driver is loaded:<br>
&gt; (as root)<br>
&gt; cat /sys/kernel/debug/dri/0/amdgpu_vbios &gt; /tmp/vbios.rom<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; lspci:<br>
&gt;&gt; 43:00.0 VGA compatible controller: Advanced Micro Devices, Inc.<br=
>
&gt;&gt; [AMD/ATI] Vega 10 XT [Radeon RX Vega 64] (rev c1) (prog-if 00 [VGA=
<br>
&gt;&gt; controller])<br>
&gt;&gt;&nbsp;&nbsp; Subsystem: Sapphire Technology Limited Vega 10 XT [Rad=
eon RX Vega<br>
&gt;&gt; 64]<br>
&gt;&gt;&nbsp;&nbsp; Control: I/O&#43; Mem&#43; BusMaster&#43; SpecCycle- M=
emWINV- VGASnoop- ParErr-<br>
&gt;&gt; Stepping- SERR- FastB2B- DisINTx&#43;<br>
&gt;&gt;&nbsp;&nbsp; Status: Cap&#43; 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast &gt;TAbort-<br>
&gt;&gt; &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
&gt;&gt;&nbsp;&nbsp; Latency: 0, Cache Line Size: 64 bytes<br>
&gt;&gt;&nbsp;&nbsp; Interrupt: pin A routed to IRQ 85<br>
&gt;&gt;&nbsp;&nbsp; Region 0: Memory at d0000000 (64-bit, prefetchable) [s=
ize=3D256M]<br>
&gt;&gt;&nbsp;&nbsp; Region 2: Memory at e0000000 (64-bit, prefetchable) [s=
ize=3D2M]<br>
&gt;&gt;&nbsp;&nbsp; Region 4: I/O ports at f000 [size=3D256]<br>
&gt;&gt;&nbsp;&nbsp; Region 5: Memory at ed400000 (32-bit, non-prefetchable=
) [size=3D512K]<br>
&gt;&gt;&nbsp;&nbsp; Expansion ROM at ed480000 [disabled] [size=3D128K]<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [48] Vendor Specific Information: Len=3D=
08 &lt;?&gt;<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [50] Power Management version 3<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0=
mA<br>
&gt;&gt; PME(D0-,D1&#43;,D2&#43;,D3hot&#43;,D3cold&#43;)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Status: D0 NoSoftRst&#43; PME-Enable- DSel=
=3D0 DScale=3D0 PME-<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [64] Express (v2) Legacy Endpoint, MSI 0=
0<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; DevCap: MaxPayload 256 bytes, PhantFunc 0,=
 Latency L0s &lt;4us, L1<br>
&gt;&gt; unlimited<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ExtTag&#43; AttnBtn- AttnInd- =
PwrInd- RBE&#43; FLReset-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; DevCtl: Report errors: Correctable- Non-Fa=
tal- Fatal- Unsupported-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RlxdOrd&#43; ExtTag&#43; Phant=
Func- AuxPwr- NoSnoop&#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MaxPayload 256 bytes, MaxReadR=
eq 512 bytes<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; DevSta: CorrErr&#43; UncorrErr- FatalErr- =
UnsuppReq&#43; AuxPwr-<br>
&gt;&gt; TransPend-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; LnkCap: Port #0, Speed 8GT/s, Width x16, A=
SPM L0s L1, Exit Latency<br>
&gt;&gt; L0s &lt;64ns, L1 &lt;1us<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ClockPM- Surprise- LLActRep- B=
wNot- ASPMOptComp&#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes =
Disabled- CommClk&#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ExtSynch- ClockPM- AutWidDis- =
BWInt- AutBWInt-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; LnkSta: Speed 8GT/s, Width x16, TrErr- Tra=
in- SlotClk&#43; DLActive-<br>
&gt;&gt; BWMgmt- ABWMgmt-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; DevCap2: Completion Timeout: Not Supported=
, TimeoutDis-, LTR&#43;,<br>
&gt;&gt; OBFF Not Supported<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AtomicOpsCap: 32bit- 64b=
it- 128bitCAS-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; DevCtl2: Completion Timeout: 50us to 50ms,=
 TimeoutDis-, LTR-, OBFF<br>
&gt;&gt; Disabled<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AtomicOpsCtl: ReqEn-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; LnkCtl2: Target Link Speed: 8GT/s, EnterCo=
mpliance- SpeedDis-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Transmit Margin: Normal =
Operating Range,<br>
&gt;&gt; EnterModifiedCompliance- ComplianceSOS-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Compliance De-emphasis: =
-6dB<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; LnkSta2: Current De-emphasis Level: -3.5dB=
, EqualizationComplete&#43;,<br>
&gt;&gt; EqualizationPhase1&#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EqualizationPhase2&#43;,=
 EqualizationPhase3&#43;,<br>
&gt;&gt; LinkEqualizationRequest-<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [a0] MSI: Enable&#43; Count=3D1/1 Maskab=
le- 64bit&#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Address: 00000000fee00000&nbsp; Data: 0000=
<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [100 v1] Vendor Specific Information: ID=
=3D0001 Rev=3D1<br>
&gt;&gt; Len=3D010 &lt;?&gt;<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [150 v2] Advanced Error Reporting<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; UESta:&nbsp; DLP- SDES- TLP- FCP- CmpltTO-=
 CmpltAbrt- UnxCmplt- RxOF-<br>
&gt;&gt; MalfTLP- ECRC- UnsupReq- ACSViol-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; UEMsk:&nbsp; DLP- SDES- TLP- FCP- CmpltTO-=
 CmpltAbrt- UnxCmplt- RxOF-<br>
&gt;&gt; MalfTLP- ECRC- UnsupReq- ACSViol-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; UESvrt: DLP&#43; SDES&#43; TLP- FCP&#43; C=
mpltTO- CmpltAbrt- UnxCmplt- RxOF&#43;<br>
&gt;&gt; MalfTLP&#43; ECRC- UnsupReq- ACSViol-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; CESta:&nbsp; RxErr- BadTLP- BadDLLP- Rollo=
ver- Timeout- NonFatalErr&#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; CEMsk:&nbsp; RxErr- BadTLP- BadDLLP- Rollo=
ver- Timeout- NonFatalErr&#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; AERCap: First Error Pointer: 00, ECRCGenCa=
p&#43; ECRCGenEn-<br>
&gt;&gt; ECRCChkCap&#43; ECRCChkEn-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MultHdrRecCap- MultHdrRecEn- T=
LPPfxPres- HdrLogCap-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; HeaderLog: 00000000 00000000 00000000 0000=
0000<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [200 v1] #15<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [270 v1] #19<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [2a0 v1] Access Control Services<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; ACSCap: SrcValid- TransBlk- ReqRedir- Cmpl=
tRedir- UpstreamFwd-<br>
&gt;&gt; EgressCtrl- DirectTrans-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; ACSCtl: SrcValid- TransBlk- ReqRedir- Cmpl=
tRedir- UpstreamFwd-<br>
&gt;&gt; EgressCtrl- DirectTrans-<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [2b0 v1] Address Translation Service (AT=
S)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; ATSCap: Invalidate Queue Depth: 00<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; ATSCtl: Enable&#43;, Smallest Translation =
Unit: 00<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [2c0 v1] Page Request Interface (PRI)<br=
>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; PRICtl: Enable- Reset-<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; PRISta: RF- UPRGI- Stopped&#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Page Request Capacity: 00000020, Page Requ=
est Allocation: 00000000<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [2d0 v1] Process Address Space ID (PASID=
)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; PASIDCap: Exec&#43; Priv&#43;, Max PASID W=
idth: 10<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; PASIDCtl: Enable- Exec- Priv-<br>
&gt;&gt;&nbsp;&nbsp; Capabilities: [320 v1] Latency Tolerance Reporting<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Max snoop latency: 0ns<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Max no snoop latency: 0ns<br>
&gt;&gt;&nbsp;&nbsp; Kernel driver in use: amdgpu<br>
&gt;&gt;&nbsp;&nbsp; Kernel modules: amdgpu<br>
&gt;&gt;<br>
&gt;&gt; // Daniel<br>
&gt;&gt;<br>
&gt;&gt; On 2 July 2018 at 21:29, Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt=
; wrote:<br>
&gt;&gt;&gt; On Mon, Jul 2, 2018 at 3:21 PM, Daniel Andersson &lt;engywook@=
gmail.com&gt; wrote:<br>
&gt;&gt;&gt;&gt; I get:<br>
&gt;&gt;&gt;&gt; [drm:dc_link_detect [amdgpu]] *ERROR* No EDID read.<br>
&gt;&gt;&gt;&gt; on boot. This started happening on 4.17 and is still an is=
sue on 4.18-rc2.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I have a Vega64 connected on Display Port to a monitor(144=
0p). The monitor<br>
&gt;&gt;&gt;&gt; doesn't have any additional ports so I can't test HDMI.<br=
>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; xrandr:<br>
&gt;&gt;&gt;&gt; Screen 0: minimum 320 x 200, current 1024 x 768, maximum 1=
6384 x 16384<br>
&gt;&gt;&gt;&gt; DisplayPort-0 connected 1024x768&#43;0&#43;0 (normal left =
inverted right x axis y<br>
&gt;&gt;&gt;&gt; axis) 0mm x 0mm<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 1024x768&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6=
0.00*<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 800x600&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 60.32&nbsp;&nbsp;&nbsp; 56.25<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 848x480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 60.00<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 640x480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 59.94<br>
&gt;&gt;&gt;&gt; DisplayPort-1 disconnected (normal left inverted right x a=
xis y axis)<br>
&gt;&gt;&gt;&gt; HDMI-A-0 disconnected (normal left inverted right x axis y=
 axis)<br>
&gt;&gt;&gt;&gt; HDMI-A-1 disconnected (normal left inverted right x axis y=
 axis)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The 1440p resolution worked on 4.16.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Can you use git to bisect?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Alex<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180950F0998981DCEA29C353F7400BN6PR12MB1809namp_--

--===============0076609571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0076609571==--
