From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Powerplay clock information missing on Polaris 12 (msi RX550 LP
 OC) on armhf
Date: Wed, 19 Dec 2018 18:27:53 +0000
Message-ID: <BN6PR12MB18099C121CF11E5B86D80C1AF7BE0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <CAEzXK1qDWG8mUE2HJOKWAuXVwAtuWZdH6F3T8D5e=McFw3yecQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2097813018=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEzXK1qDWG8mUE2HJOKWAuXVwAtuWZdH6F3T8D5e=McFw3yecQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?iso-8859-1?Q?Lu=EDs_Mendes?= <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2097813018==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18099C121CF11E5B86D80C1AF7BE0BN6PR12MB1809namp_"

--_000_BN6PR12MB18099C121CF11E5B86D80C1AF7BE0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Those messages are harmless and can be ignored.  I think they have been rem=
oved in newer kernels.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Lu=EDs M=
endes <luis.p.mendes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, December 19, 2018 12:31:44 PM
To: Koenig, Christian; amd-gfx list
Subject: Powerplay clock information missing on Polaris 12 (msi RX550 LP OC=
) on armhf

Hi,

Just want to report this issue for the Polaris 12, RX550, with kernel 4.19.=
9
[   20.272719] amdgpu: [powerplay] Failed to retrieve minimum clocks.
[   20.272723] amdgpu: [powerplay] Error in phm_get_clock_info


dmesg excerpt of relevant amdgpu initialization follows below.

Regards,
Lu=EDs Mendes, Researcher, Instituto Superior T=E9cnico
Hardware and Software engineer
https://tecnico.ulisboa.pt/en/



[   18.679841] [drm] initializing kernel modesetting (POLARIS12
0x1002:0x699F 0x1462:0x8A90 0xC7).
[   18.679854] [drm] register mmio base: 0xE0200000
[   18.679856] [drm] register mmio size: 262144
[   18.679898] [drm] add ip block number 0 <vi_common>
[   18.679900] [drm] add ip block number 1 <gmc_v8_0>
[   18.679902] [drm] add ip block number 2 <tonga_ih>
[   18.679903] [drm] add ip block number 3 <powerplay>
[   18.679906] [drm] add ip block number 4 <dm>
[   18.679907] [drm] add ip block number 5 <gfx_v8_0>
[   18.679909] [drm] add ip block number 6 <sdma_v3_0>
[   18.679911] [drm] add ip block number 7 <uvd_v6_0>
[   18.679913] [drm] add ip block number 8 <vce_v3_0>
[   18.679937] [drm] UVD is enabled in VM mode
[   18.679938] [drm] UVD ENC is enabled in VM mode
[   18.679942] [drm] VCE enabled in VM mode
[   18.890422] ATOM BIOS: 113-D090LP-M11
[   18.890467] [drm] GPU posting now...
[   18.945707] snd_hda_intel 0000:01:00.1: enabling device (0140 -> 0142)
[   18.945718] snd_hda_intel 0000:01:00.1: Force to snoop mode by module op=
tion
[   19.027723] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
fragment size is 9-bit
[   19.052235] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as
/devices/platform/soc/soc:pcie/pci0000:00/0000:00:01.0/0000:01:00.1/sound/c=
ard0/input2
[   19.491128] amdgpu 0000:01:00.0: VRAM: 4096M 0x000000F400000000 -
0x000000F4FFFFFFFF (4096M used)
[   19.491136] amdgpu 0000:01:00.0: GART: 256M 0x0000000000000000 -
0x000000000FFFFFFF
[   19.491141] [drm] Detected VRAM RAM=3D4096M, BAR=3D256M
[   19.491143] [drm] RAM width 128bits GDDR5
[   19.491286] [TTM] Zone  kernel: Available graphics memory: 375104 kiB
[   19.491289] [TTM] Zone highmem: Available graphics memory: 1030464 kiB
[   19.491291] [TTM] Initializing pool allocator
[   19.491311] [drm] amdgpu: 4096M of VRAM memory ready
[   19.491314] [drm] amdgpu: 1509M of GTT memory ready.
[   19.491352] [drm] GART: num cpu pages 65536, num gpu pages 65536
[   19.492115] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000=
).
[   19.633585] [drm] Chained IB support enabled!
[   20.075528] [drm] Found UVD firmware Version: 1.130 Family ID: 16
[   20.135798] [drm] Found VCE firmware Version: 53.26 Binary ID: 3
[   20.272719] amdgpu: [powerplay] Failed to retrieve minimum clocks.
[   20.272723] amdgpu: [powerplay] Error in phm_get_clock_info
[   20.272854] [drm] DM_PPLIB: values for Engine clock
[   20.272858] [drm] DM_PPLIB:     214000
[   20.272859] [drm] DM_PPLIB:     551000
[   20.272860] [drm] DM_PPLIB:     746000
[   20.272862] [drm] DM_PPLIB:     995000
[   20.272863] [drm] DM_PPLIB:     1063000
[   20.272864] [drm] DM_PPLIB:     1116000
[   20.272866] [drm] DM_PPLIB:     1142000
[   20.272867] [drm] DM_PPLIB:     1203000
[   20.272869] [drm] DM_PPLIB: Validation clocks:
[   20.272871] [drm] DM_PPLIB:    engine_max_clock: 120300
[   20.272873] [drm] DM_PPLIB:    memory_max_clock: 175000
[   20.272874] [drm] DM_PPLIB:    level           : 8
[   20.272879] [drm] DM_PPLIB: values for Memory clock
[   20.272880] [drm] DM_PPLIB:     300000
[   20.272881] [drm] DM_PPLIB:     625000
[   20.272883] [drm] DM_PPLIB:     1750000
[   20.272884] [drm] DM_PPLIB: Validation clocks:
[   20.272886] [drm] DM_PPLIB:    engine_max_clock: 120300
[   20.272887] [drm] DM_PPLIB:    memory_max_clock: 175000
[   20.272888] [drm] DM_PPLIB:    level           : 8
[   20.276533] [drm] Display Core initialized with v3.1.59!
[   20.291991] [drm] SADs count is: -2, don't need to read it
[   20.292825] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   20.292827] [drm] Driver supports precise vblank timestamp query.
[   20.340483] [drm] UVD and UVD ENC initialized successfully.
[   20.420775] Adding 19450708k swap on /dev/sda3.  Priority:-2
extents:1 across:19450708k FS
[   20.441642] [drm] VCE initialized successfully.
[   20.447024] [drm] fb mappable at 0xD0528000
[   20.447028] [drm] vram apper at 0xD0000000
[   20.447030] [drm] size 5242880
[   20.447032] [drm] fb depth is 24
[   20.447033] [drm]    pitch is 5120
[   20.474428] Console: switching to colour frame buffer device 160x64
[   20.620688] amdgpu 0000:01:00.0: fb0: amdgpudrmfb frame buffer device
[   20.663591] [drm] Initialized amdgpu 3.27.0 20150101 for
0000:01:00.0 on minor 0
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18099C121CF11E5B86D80C1AF7BE0BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Those messages are harmless and c=
an be ignored.&nbsp; I think they have been removed in newer kernels.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Lu=EDs Mendes &lt;luis.p.mend=
es-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, December 19, 2018 12:31:44 PM<br>
<b>To:</b> Koenig, Christian; amd-gfx list<br>
<b>Subject:</b> Powerplay clock information missing on Polaris 12 (msi RX55=
0 LP OC) on armhf</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi,<br>
<br>
Just want to report this issue for the Polaris 12, RX550, with kernel 4.19.=
9<br>
[&nbsp;&nbsp; 20.272719] amdgpu: [powerplay] Failed to retrieve minimum clo=
cks.<br>
[&nbsp;&nbsp; 20.272723] amdgpu: [powerplay] Error in phm_get_clock_info<br=
>
<br>
<br>
dmesg excerpt of relevant amdgpu initialization follows below.<br>
<br>
Regards,<br>
Lu=EDs Mendes, Researcher, Instituto Superior T=E9cnico<br>
Hardware and Software engineer<br>
<a href=3D"https://tecnico.ulisboa.pt/en/">https://tecnico.ulisboa.pt/en/</=
a><br>
<br>
<br>
<br>
[&nbsp;&nbsp; 18.679841] [drm] initializing kernel modesetting (POLARIS12<b=
r>
0x1002:0x699F 0x1462:0x8A90 0xC7).<br>
[&nbsp;&nbsp; 18.679854] [drm] register mmio base: 0xE0200000<br>
[&nbsp;&nbsp; 18.679856] [drm] register mmio size: 262144<br>
[&nbsp;&nbsp; 18.679898] [drm] add ip block number 0 &lt;vi_common&gt;<br>
[&nbsp;&nbsp; 18.679900] [drm] add ip block number 1 &lt;gmc_v8_0&gt;<br>
[&nbsp;&nbsp; 18.679902] [drm] add ip block number 2 &lt;tonga_ih&gt;<br>
[&nbsp;&nbsp; 18.679903] [drm] add ip block number 3 &lt;powerplay&gt;<br>
[&nbsp;&nbsp; 18.679906] [drm] add ip block number 4 &lt;dm&gt;<br>
[&nbsp;&nbsp; 18.679907] [drm] add ip block number 5 &lt;gfx_v8_0&gt;<br>
[&nbsp;&nbsp; 18.679909] [drm] add ip block number 6 &lt;sdma_v3_0&gt;<br>
[&nbsp;&nbsp; 18.679911] [drm] add ip block number 7 &lt;uvd_v6_0&gt;<br>
[&nbsp;&nbsp; 18.679913] [drm] add ip block number 8 &lt;vce_v3_0&gt;<br>
[&nbsp;&nbsp; 18.679937] [drm] UVD is enabled in VM mode<br>
[&nbsp;&nbsp; 18.679938] [drm] UVD ENC is enabled in VM mode<br>
[&nbsp;&nbsp; 18.679942] [drm] VCE enabled in VM mode<br>
[&nbsp;&nbsp; 18.890422] ATOM BIOS: 113-D090LP-M11<br>
[&nbsp;&nbsp; 18.890467] [drm] GPU posting now...<br>
[&nbsp;&nbsp; 18.945707] snd_hda_intel 0000:01:00.1: enabling device (0140 =
-&gt; 0142)<br>
[&nbsp;&nbsp; 18.945718] snd_hda_intel 0000:01:00.1: Force to snoop mode by=
 module option<br>
[&nbsp;&nbsp; 19.027723] [drm] vm size is 64 GB, 2 levels, block size is 10=
-bit,<br>
fragment size is 9-bit<br>
[&nbsp;&nbsp; 19.052235] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as<br>
/devices/platform/soc/soc:pcie/pci0000:00/0000:00:01.0/0000:01:00.1/sound/c=
ard0/input2<br>
[&nbsp;&nbsp; 19.491128] amdgpu 0000:01:00.0: VRAM: 4096M 0x000000F40000000=
0 -<br>
0x000000F4FFFFFFFF (4096M used)<br>
[&nbsp;&nbsp; 19.491136] amdgpu 0000:01:00.0: GART: 256M 0x0000000000000000=
 -<br>
0x000000000FFFFFFF<br>
[&nbsp;&nbsp; 19.491141] [drm] Detected VRAM RAM=3D4096M, BAR=3D256M<br>
[&nbsp;&nbsp; 19.491143] [drm] RAM width 128bits GDDR5<br>
[&nbsp;&nbsp; 19.491286] [TTM] Zone&nbsp; kernel: Available graphics memory=
: 375104 kiB<br>
[&nbsp;&nbsp; 19.491289] [TTM] Zone highmem: Available graphics memory: 103=
0464 kiB<br>
[&nbsp;&nbsp; 19.491291] [TTM] Initializing pool allocator<br>
[&nbsp;&nbsp; 19.491311] [drm] amdgpu: 4096M of VRAM memory ready<br>
[&nbsp;&nbsp; 19.491314] [drm] amdgpu: 1509M of GTT memory ready.<br>
[&nbsp;&nbsp; 19.491352] [drm] GART: num cpu pages 65536, num gpu pages 655=
36<br>
[&nbsp;&nbsp; 19.492115] [drm] PCIE GART of 256M enabled (table at 0x000000=
F400000000).<br>
[&nbsp;&nbsp; 19.633585] [drm] Chained IB support enabled!<br>
[&nbsp;&nbsp; 20.075528] [drm] Found UVD firmware Version: 1.130 Family ID:=
 16<br>
[&nbsp;&nbsp; 20.135798] [drm] Found VCE firmware Version: 53.26 Binary ID:=
 3<br>
[&nbsp;&nbsp; 20.272719] amdgpu: [powerplay] Failed to retrieve minimum clo=
cks.<br>
[&nbsp;&nbsp; 20.272723] amdgpu: [powerplay] Error in phm_get_clock_info<br=
>
[&nbsp;&nbsp; 20.272854] [drm] DM_PPLIB: values for Engine clock<br>
[&nbsp;&nbsp; 20.272858] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 214000<br>
[&nbsp;&nbsp; 20.272859] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 551000<br>
[&nbsp;&nbsp; 20.272860] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 746000<br>
[&nbsp;&nbsp; 20.272862] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 995000<br>
[&nbsp;&nbsp; 20.272863] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 1063000<br=
>
[&nbsp;&nbsp; 20.272864] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 1116000<br=
>
[&nbsp;&nbsp; 20.272866] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 1142000<br=
>
[&nbsp;&nbsp; 20.272867] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 1203000<br=
>
[&nbsp;&nbsp; 20.272869] [drm] DM_PPLIB: Validation clocks:<br>
[&nbsp;&nbsp; 20.272871] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp; engine_max_clock=
: 120300<br>
[&nbsp;&nbsp; 20.272873] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp; memory_max_clock=
: 175000<br>
[&nbsp;&nbsp; 20.272874] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp; level&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 8<br>
[&nbsp;&nbsp; 20.272879] [drm] DM_PPLIB: values for Memory clock<br>
[&nbsp;&nbsp; 20.272880] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 300000<br>
[&nbsp;&nbsp; 20.272881] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 625000<br>
[&nbsp;&nbsp; 20.272883] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp;&nbsp; 1750000<br=
>
[&nbsp;&nbsp; 20.272884] [drm] DM_PPLIB: Validation clocks:<br>
[&nbsp;&nbsp; 20.272886] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp; engine_max_clock=
: 120300<br>
[&nbsp;&nbsp; 20.272887] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp; memory_max_clock=
: 175000<br>
[&nbsp;&nbsp; 20.272888] [drm] DM_PPLIB:&nbsp;&nbsp;&nbsp; level&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 8<br>
[&nbsp;&nbsp; 20.276533] [drm] Display Core initialized with v3.1.59!<br>
[&nbsp;&nbsp; 20.291991] [drm] SADs count is: -2, don't need to read it<br>
[&nbsp;&nbsp; 20.292825] [drm] Supports vblank timestamp caching Rev 2 (21.=
10.2013).<br>
[&nbsp;&nbsp; 20.292827] [drm] Driver supports precise vblank timestamp que=
ry.<br>
[&nbsp;&nbsp; 20.340483] [drm] UVD and UVD ENC initialized successfully.<br=
>
[&nbsp;&nbsp; 20.420775] Adding 19450708k swap on /dev/sda3.&nbsp; Priority=
:-2<br>
extents:1 across:19450708k FS<br>
[&nbsp;&nbsp; 20.441642] [drm] VCE initialized successfully.<br>
[&nbsp;&nbsp; 20.447024] [drm] fb mappable at 0xD0528000<br>
[&nbsp;&nbsp; 20.447028] [drm] vram apper at 0xD0000000<br>
[&nbsp;&nbsp; 20.447030] [drm] size 5242880<br>
[&nbsp;&nbsp; 20.447032] [drm] fb depth is 24<br>
[&nbsp;&nbsp; 20.447033] [drm]&nbsp;&nbsp;&nbsp; pitch is 5120<br>
[&nbsp;&nbsp; 20.474428] Console: switching to colour frame buffer device 1=
60x64<br>
[&nbsp;&nbsp; 20.620688] amdgpu 0000:01:00.0: fb0: amdgpudrmfb frame buffer=
 device<br>
[&nbsp;&nbsp; 20.663591] [drm] Initialized amdgpu 3.27.0 20150101 for<br>
0000:01:00.0 on minor 0<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18099C121CF11E5B86D80C1AF7BE0BN6PR12MB1809namp_--

--===============2097813018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2097813018==--
