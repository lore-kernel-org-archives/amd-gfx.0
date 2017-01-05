From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PART1 PATCH 0/8] Introduce a method to get clock gating status
 dynamically
Date: Thu, 5 Jan 2017 15:51:48 +0000
Message-ID: <CY4PR12MB17686EC2FEE291EF2A874F90F7600@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1483624193-20897-1-git-send-email-ray.huang@amd.com>,
 <BN6PR12MB1652B0E3AD8F9252CE089FA0F7600@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0506138490=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652B0E3AD8F9252CE089FA0F7600-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Fu,
 Ping" <Ping.Fu-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0506138490==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17686EC2FEE291EF2A874F90F7600CY4PR12MB1768namp_"

--_000_CY4PR12MB17686EC2FEE291EF2A874F90F7600CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Some of them are part of AON tiles but are unstable during PM switches.  Th=
at's why the debugfs mmio entry supports a PM lock.


So they might be readable while powered off but unstable if the firmware is=
 in the middle of a PM switch.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, January 5, 2017 10:40
To: Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang, Ray; Zhang, Hawking; Zhu, Rex; Fu, Ping; Mao, David
Subject: RE: [PART1 PATCH 0/8] Introduce a method to get clock gating statu=
s dynamically

> -----Original Message-----
> From: Huang Rui [mailto:ray.huang-5C7GfCeVMHo@public.gmane.org]
> Sent: Thursday, January 05, 2017 8:50 AM
> To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Zhu, Rex; Mao, David; Fu, Ping; Zhang, Hawking; Huang, Ray
> Subject: [PART1 PATCH 0/8] Introduce a method to get clock gating status
> dynamically
>
> This series patches implement to get the clock gating status
> dynamically into debugfs. User will enter profiling mode to runtime
> disable clockgating, so it needs an interface to expose clock gating
> states. Part 1 works for VI, I will implement it on CI/SI in following
> days.

Patches 1-6:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Patches 7, 8:
I'm not sure if the UVD and VCE status registers are available if the block=
s are powergated.  Reading them back while powergated can cause a hang.  Mi=
ght want to check the PG sw state before reading back the registers.

Alex

>
> Here is the example on Fiji:
>
> root@jenkins-All-Series:/home/jenkins# cat
> /sys/kernel/debug/dri/64/amdgpu_pm_info
> Clock Gating Flags Mask: 0x3dfff
>         Medium Grain Clock Gating: On
>         Medium Grain memory Light Sleep: On
>         Coarse Grain Clock Gating: On
>         Coarse Grain memory Light Sleep: On
>         Coarse Grain Tree Shader: On
>         Coarse Grain Tree Shader Light Sleep: On
>         Command Processor Light Sleep: On
>         Run List Controller Light Sleep: On
>         Memory Controller Light Sleep: On
>         Memory Controller Medium Grain Clock Gating: On
>         System Direct Memory Access Light Sleep: On
>         System Direct Memory Access Medium Grain Clock Gating: On
>         Bus Interface Light Sleep: On
>         Universal Video Decoder Medium Grain Clock Gating: Off
>         Video Coding Engine Medium Grain Clock Gating: On
>         Host Data Path Light Sleep: On
>         Host Data Path Medium Grain Clock Gating: On
>         Rom Medium Grain Clock Gating: On
> ...
>
> Thanks,
> Rui
>
> Huang Rui (8):
>   drm/amdgpu: introduce an interface to get clock gating status
>     dynamically
>   drm/amdgpu: add parse clock gating state
>   drm/amdgpu: add clockgating_state method for gfx v8
>   drm/amdgpu: add clockgating_state method for gmc v8
>   drm/amdgpu: add clockgating_state method for sdma v3
>   drm/amdgpu: add clockgating_state method for vi common
>   drm/amdgpu: add clockgating_state method for uvd v5&v6
>   drm/amdgpu: add clockgating_state method for vce v3
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c     | 99
> ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 40 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 16 +++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     | 17 +++++
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c      | 12 ++++
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      | 12 ++++
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      | 18 ++++++
>  drivers/gpu/drm/amd/amdgpu/vi.c            | 27 ++++++++
>  drivers/gpu/drm/amd/include/amd_shared.h   |  2 +
>  11 files changed, 256 insertions(+)
>
> --
> 2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB17686EC2FEE291EF2A874F90F7600CY4PR12MB1768namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Some of them are part of AON tiles but are unstable during PM switches. =
&nbsp;That's why the debugfs mmio&nbsp;entry supports a PM lock.</p>
<p><br>
</p>
<p>So they might be readable while powered off but unstable if the firmware=
 is in the middle of a PM switch.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deucher, Alexander &lt;Alex=
ander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, January 5, 2017 10:40<br>
<b>To:</b> Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Huang, Ray; Zhang, Hawking; Zhu, Rex; Fu, Ping; Mao, David<br>
<b>Subject:</b> RE: [PART1 PATCH 0/8] Introduce a method to get clock gatin=
g status dynamically</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: Huang Rui [<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">mailto:ray.huang=
@amd.com</a>]<br>
&gt; Sent: Thursday, January 05, 2017 8:50 AM<br>
&gt; To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Zhu, Rex; Mao, David; Fu, Ping; Zhang, Hawking; Huang, Ray<br>
&gt; Subject: [PART1 PATCH 0/8] Introduce a method to get clock gating stat=
us<br>
&gt; dynamically<br>
&gt; <br>
&gt; This series patches implement to get the clock gating status<br>
&gt; dynamically into debugfs. User will enter profiling mode to runtime<br=
>
&gt; disable clockgating, so it needs an interface to expose clock gating<b=
r>
&gt; states. Part 1 works for VI, I will implement it on CI/SI in following=
<br>
&gt; days.<br>
<br>
Patches 1-6:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Patches 7, 8:<br>
I'm not sure if the UVD and VCE status registers are available if the block=
s are powergated.&nbsp; Reading them back while powergated can cause a hang=
.&nbsp; Might want to check the PG sw state before reading back the registe=
rs.<br>
<br>
Alex<br>
<br>
&gt; <br>
&gt; Here is the example on Fiji:<br>
&gt; <br>
&gt; root@jenkins-All-Series:/home/jenkins# cat<br>
&gt; /sys/kernel/debug/dri/64/amdgpu_pm_info<br>
&gt; Clock Gating Flags Mask: 0x3dfff<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Medium Grain Clock Gat=
ing: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Medium Grain memory Li=
ght Sleep: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Coarse Grain Clock Gat=
ing: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Coarse Grain memory Li=
ght Sleep: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Coarse Grain Tree Shad=
er: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Coarse Grain Tree Shad=
er Light Sleep: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Command Processor Ligh=
t Sleep: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Run List Controller Li=
ght Sleep: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory Controller Ligh=
t Sleep: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory Controller Medi=
um Grain Clock Gating: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; System Direct Memory A=
ccess Light Sleep: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; System Direct Memory A=
ccess Medium Grain Clock Gating: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus Interface Light Sl=
eep: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Universal Video Decode=
r Medium Grain Clock Gating: Off<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Video Coding Engine Me=
dium Grain Clock Gating: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Host Data Path Light S=
leep: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Host Data Path Medium =
Grain Clock Gating: On<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rom Medium Grain Clock=
 Gating: On<br>
&gt; ...<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Rui<br>
&gt; <br>
&gt; Huang Rui (8):<br>
&gt;&nbsp;&nbsp; drm/amdgpu: introduce an interface to get clock gating sta=
tus<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; dynamically<br>
&gt;&nbsp;&nbsp; drm/amdgpu: add parse clock gating state<br>
&gt;&nbsp;&nbsp; drm/amdgpu: add clockgating_state method for gfx v8<br>
&gt;&nbsp;&nbsp; drm/amdgpu: add clockgating_state method for gmc v8<br>
&gt;&nbsp;&nbsp; drm/amdgpu: add clockgating_state method for sdma v3<br>
&gt;&nbsp;&nbsp; drm/amdgpu: add clockgating_state method for vi common<br>
&gt;&nbsp;&nbsp; drm/amdgpu: add clockgating_state method for uvd v5&amp;v6=
<br>
&gt;&nbsp;&nbsp; drm/amdgpu: add clockgating_state method for vce v3<br>
&gt; <br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 1 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 &#43;&#43;&#43;&=
#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp; |=
 99<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 40 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 16 &#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c&nbsp;&nbsp;&nbsp;&nbsp; |=
 17 &#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 12 &#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 12 &#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 18 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 27 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/include/amd_shared.h&nbsp;&nbsp; |&nbsp; 2 &=
#43;<br>
&gt;&nbsp; 11 files changed, 256 insertions(&#43;)<br>
&gt; <br>
&gt; --<br>
&gt; 2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB17686EC2FEE291EF2A874F90F7600CY4PR12MB1768namp_--

--===============0506138490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0506138490==--
