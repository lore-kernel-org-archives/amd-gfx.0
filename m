From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Screen flicckering due to "drm/amdgpu: enable gfxoff again on
 raven series"
Date: Fri, 5 Apr 2019 18:44:52 +0000
Message-ID: <BN6PR12MB1809F35D7E08B17EE0362C15F7510@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190405162423.6ykp3v54tt4v233h@zizala>
 <BN6PR12MB1809F0A406BDD769D980D0A5F7510@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20190405175351.ojtmakydncnaopkp@zizala>
 <BN6PR12MB1809FBE905B4348595FBC9F7F7510@BN6PR12MB1809.namprd12.prod.outlook.com>,
 <20190405183839.q6nd6wy6brnxfoqx@zizala>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1554773399=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190405183839.q6nd6wy6brnxfoqx@zizala>
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
To: Pinky <j-pi-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1554773399==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F35D7E08B17EE0362C15F7510BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F35D7E08B17EE0362C15F7510BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Make sure you have this patch as well:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-5.2-wip&id=
=3D083d022913f2f8c3bc1183a13874ad777b9f5bdd

Alex
________________________________
From: Pinky <j-pi-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Sent: Friday, April 5, 2019 2:38 PM
To: Deucher, Alexander
Cc: Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: Screen flicckering due to "drm/amdgpu: enable gfxoff again on =
raven series"


cat /sys/kernel/debug/dri/0/amdgpu_firmware_info
VCE feature version: 0, firmware version: 0x00000000
UVD feature version: 0, firmware version: 0x00000000
MC feature version: 0, firmware version: 0x00000000
ME feature version: 40, firmware version: 0x00000099
PFP feature version: 40, firmware version: 0x000000ae
CE feature version: 40, firmware version: 0x0000004d
RLC feature version: 1, firmware version: 0x0000d237
RLC SRLC feature version: 1, firmware version: 0x00000001
RLC SRLG feature version: 1, firmware version: 0x00000001
RLC SRLS feature version: 1, firmware version: 0x00000001
MEC feature version: 40, firmware version: 0x0000018b
MEC2 feature version: 40, firmware version: 0x0000018b
SOS feature version: 0, firmware version: 0x00000000
ASD feature version: 0, firmware version: 0x0017ba78
TA XGMI feature version: 0, firmware version: 0x00000000
TA RAS feature version: 0, firmware version: 0x00000000
SMC feature version: 0, firmware version: 0x00001e44
SDMA0 feature version: 41, firmware version: 0x000000a9
VCN feature version: 0, firmware version: 0x01004912
DMCU feature version: 0, firmware version: 0x00000001
VBIOS version: 113-RAVEN-110



* Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> [2019-04-05 18:33:23 +0000=
]:

>+ Ray
>
>Ray, any ideas?
>
>Pinkava,
>
>can you provide the output of:
>sudo cat /sys/kernel/debug/dri/0/amdgpu_firmware_info
>
>Thanks,
>
>Alex
>________________________________
>From: Pinky <j-pi-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
>Sent: Friday, April 5, 2019 1:53 PM
>To: Deucher, Alexander
>Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>Subject: Re: Screen flicckering due to "drm/amdgpu: enable gfxoff again on=
 raven series"
>
>No, this does no do anything, the bug is still present.
>
>
>* Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> [2019-04-05 17:07:21 +000=
0]:
>
>>This may be related to stutter mode rather than gfxoff.  If so, there is =
a fix in the pipeline for that.  Does setting appending amdgpu.ppfeaturemas=
k=3D0xfffdbfff on the kernel command line fix it?
>>
>>Alex
>>________________________________
>>From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Pinky =
<j-pi-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
>>Sent: Friday, April 5, 2019 12:24 PM
>>To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>Subject: Screen flicckering due to "drm/amdgpu: enable gfxoff again on ra=
ven series"
>>
>>Hello,
>>
>>I have today compiled the drm-next kernel from (1) and find out the scree=
n is
>>flickering and shows various artifacts. By bissecting I found the cause
>>is commit 005440066f929ba0dca8f4e0aebfbf8daac592cc. By reverting it the
>>problem went out.
>>
>>I does not have idea about what to do next. Sorry if this should be poste=
d to
>>some bugzilla instead, I have got a bit lost. If so, would You please
>>point my out what to do?
>>
>>With best regards,
>>    Pinkava J.
>>
>>
>>lspci (partial)
>>
>>00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 IOMMU
>>00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Model=
s 00h-0fh) PCIe Dummy Host Bridge
>>06:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]=
 Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] (rev d1)
>>06:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Raven/Raven2=
/Fenghuang HDMI/DP Audio Controller
>>
>>
>>
>>
>>(1) git://people.freedesktop.org/~agd5f/linux
>>_______________________________________________
>>amd-gfx mailing list
>>amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>>_______________________________________________
>>amd-gfx mailing list
>>amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--_000_BN6PR12MB1809F35D7E08B17EE0362C15F7510BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Make sure you have this patch as well:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-5=
.2-wip&amp;id=3D083d022913f2f8c3bc1183a13874ad777b9f5bdd" id=3D"LPlnk185511=
">https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-5.2-wip&am=
p;id=3D083d022913f2f8c3bc1183a13874ad777b9f5bdd</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Pinky &lt;j-pi@seznam=
.cz&gt;<br>
<b>Sent:</b> Friday, April 5, 2019 2:38 PM<br>
<b>To:</b> Deucher, Alexander<br>
<b>Cc:</b> Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: Screen flicckering due to &quot;drm/amdgpu: enable gfxo=
ff again on raven series&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
cat /sys/kernel/debug/dri/0/amdgpu_firmware_info<br>
VCE feature version: 0, firmware version: 0x00000000<br>
UVD feature version: 0, firmware version: 0x00000000<br>
MC feature version: 0, firmware version: 0x00000000<br>
ME feature version: 40, firmware version: 0x00000099<br>
PFP feature version: 40, firmware version: 0x000000ae<br>
CE feature version: 40, firmware version: 0x0000004d<br>
RLC feature version: 1, firmware version: 0x0000d237<br>
RLC SRLC feature version: 1, firmware version: 0x00000001<br>
RLC SRLG feature version: 1, firmware version: 0x00000001<br>
RLC SRLS feature version: 1, firmware version: 0x00000001<br>
MEC feature version: 40, firmware version: 0x0000018b<br>
MEC2 feature version: 40, firmware version: 0x0000018b<br>
SOS feature version: 0, firmware version: 0x00000000<br>
ASD feature version: 0, firmware version: 0x0017ba78<br>
TA XGMI feature version: 0, firmware version: 0x00000000<br>
TA RAS feature version: 0, firmware version: 0x00000000<br>
SMC feature version: 0, firmware version: 0x00001e44<br>
SDMA0 feature version: 41, firmware version: 0x000000a9<br>
VCN feature version: 0, firmware version: 0x01004912<br>
DMCU feature version: 0, firmware version: 0x00000001<br>
VBIOS version: 113-RAVEN-110<br>
<br>
<br>
<br>
* Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt; [2019-04-05 18:33:23=
 &#43;0000]:<br>
<br>
&gt;&#43; Ray<br>
&gt;<br>
&gt;Ray, any ideas?<br>
&gt;<br>
&gt;Pinkava,<br>
&gt;<br>
&gt;can you provide the output of:<br>
&gt;sudo cat /sys/kernel/debug/dri/0/amdgpu_firmware_info<br>
&gt;<br>
&gt;Thanks,<br>
&gt;<br>
&gt;Alex<br>
&gt;________________________________<br>
&gt;From: Pinky &lt;j-pi-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org&gt;<br>
&gt;Sent: Friday, April 5, 2019 1:53 PM<br>
&gt;To: Deucher, Alexander<br>
&gt;Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;Subject: Re: Screen flicckering due to &quot;drm/amdgpu: enable gfxoff =
again on raven series&quot;<br>
&gt;<br>
&gt;No, this does no do anything, the bug is still present.<br>
&gt;<br>
&gt;<br>
&gt;* Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt; [2019-04-05 17:0=
7:21 &#43;0000]:<br>
&gt;<br>
&gt;&gt;This may be related to stutter mode rather than gfxoff.&nbsp; If so=
, there is a fix in the pipeline for that.&nbsp; Does setting appending amd=
gpu.ppfeaturemask=3D0xfffdbfff on the kernel command line fix it?<br>
&gt;&gt;<br>
&gt;&gt;Alex<br>
&gt;&gt;________________________________<br>
&gt;&gt;From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on beha=
lf of Pinky &lt;j-pi-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org&gt;<br>
&gt;&gt;Sent: Friday, April 5, 2019 12:24 PM<br>
&gt;&gt;To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;Subject: Screen flicckering due to &quot;drm/amdgpu: enable gfxoff =
again on raven series&quot;<br>
&gt;&gt;<br>
&gt;&gt;Hello,<br>
&gt;&gt;<br>
&gt;&gt;I have today compiled the drm-next kernel from (1) and find out the=
 screen is<br>
&gt;&gt;flickering and shows various artifacts. By bissecting I found the c=
ause<br>
&gt;&gt;is commit 005440066f929ba0dca8f4e0aebfbf8daac592cc. By reverting it=
 the<br>
&gt;&gt;problem went out.<br>
&gt;&gt;<br>
&gt;&gt;I does not have idea about what to do next. Sorry if this should be=
 posted to<br>
&gt;&gt;some bugzilla instead, I have got a bit lost. If so, would You plea=
se<br>
&gt;&gt;point my out what to do?<br>
&gt;&gt;<br>
&gt;&gt;With best regards,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; Pinkava J.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;lspci (partial)<br>
&gt;&gt;<br>
&gt;&gt;00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 IOMM=
U<br>
&gt;&gt;00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) PCIe Dummy Host Bridge<br>
&gt;&gt;06:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AM=
D/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] (rev d1=
)<br>
&gt;&gt;06:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Raven/=
Raven2/Fenghuang HDMI/DP Audio Controller<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;(1) git://people.freedesktop.org/~agd5f/linux<br>
&gt;&gt;_______________________________________________<br>
&gt;&gt;amd-gfx mailing list<br>
&gt;&gt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">=
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;<br>
&gt;&gt;_______________________________________________<br>
&gt;&gt;amd-gfx mailing list<br>
&gt;&gt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">=
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809F35D7E08B17EE0362C15F7510BN6PR12MB1809namp_--

--===============1554773399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1554773399==--
