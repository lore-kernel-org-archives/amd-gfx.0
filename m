From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Screen flicckering due to "drm/amdgpu: enable gfxoff again on
 raven series"
Date: Fri, 5 Apr 2019 17:11:00 +0000
Message-ID: <BN6PR12MB18097CCE08BC1ABE85276B64F7510@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190405162423.6ykp3v54tt4v233h@zizala>,
 <BN6PR12MB1809F0A406BDD769D980D0A5F7510@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1742183135=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809F0A406BDD769D980D0A5F7510-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: Pinky <j-pi-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1742183135==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18097CCE08BC1ABE85276B64F7510BN6PR12MB1809namp_"

--_000_BN6PR12MB18097CCE08BC1ABE85276B64F7510BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Kernel command line in grub.
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, April 5, 2019 1:07 PM
To: Pinky; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: Screen flicckering due to "drm/amdgpu: enable gfxoff again on =
raven series"

This may be related to stutter mode rather than gfxoff.  If so, there is a =
fix in the pipeline for that.  Does setting appending amdgpu.ppfeaturemask=
=3D0xfffdbfff on the kernel command line fix it?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Pinky <j=
-pi-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org>
Sent: Friday, April 5, 2019 12:24 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Screen flicckering due to "drm/amdgpu: enable gfxoff again on rave=
n series"

Hello,

I have today compiled the drm-next kernel from (1) and find out the screen =
is
flickering and shows various artifacts. By bissecting I found the cause
is commit 005440066f929ba0dca8f4e0aebfbf8daac592cc. By reverting it the
problem went out.

I does not have idea about what to do next. Sorry if this should be posted =
to
some bugzilla instead, I have got a bit lost. If so, would You please
point my out what to do?

With best regards,
    Pinkava J.


lspci (partial)

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models =
00h-0fh) PCIe Dummy Host Bridge
06:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] R=
aven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] (rev d1)
06:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Raven/Raven2/F=
enghuang HDMI/DP Audio Controller




(1) git://people.freedesktop.org/~agd5f/linux
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18097CCE08BC1ABE85276B64F7510BN6PR12MB1809namp_
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
Kernel command line in grub.<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deucher, Alexander &lt;Alexan=
der.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, April 5, 2019 1:07 PM<br>
<b>To:</b> Pinky; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: Screen flicckering due to &quot;drm/amdgpu: enable gfxo=
ff again on raven series&quot;</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
This may be related to stutter mode rather than gfxoff.&nbsp; If so, there =
is a fix in the pipeline for that.&nbsp; Does setting appending amdgpu.ppfe=
aturemask=3D0xfffdbfff on the kernel command line fix it?</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Pinky &lt;j-pi-9Vj9tDbzfuSlVyrhU4qvOw@public.gmane.org&gt=
;<br>
<b>Sent:</b> Friday, April 5, 2019 12:24 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Screen flicckering due to &quot;drm/amdgpu: enable gfxoff a=
gain on raven series&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Hello,<br>
<br>
I have today compiled the drm-next kernel from (1) and find out the screen =
is<br>
flickering and shows various artifacts. By bissecting I found the cause<br>
is commit 005440066f929ba0dca8f4e0aebfbf8daac592cc. By reverting it the<br>
problem went out.<br>
<br>
I does not have idea about what to do next. Sorry if this should be posted =
to<br>
some bugzilla instead, I have got a bit lost. If so, would You please<br>
point my out what to do?<br>
<br>
With best regards,<br>
&nbsp;&nbsp;&nbsp; Pinkava J.<br>
<br>
<br>
lspci (partial)<br>
<br>
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 IOMMU<br>
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models =
00h-0fh) PCIe Dummy Host Bridge<br>
06:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] R=
aven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] (rev d1)<br>
06:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Raven/Raven2/F=
enghuang HDMI/DP Audio Controller<br>
<br>
<br>
<br>
<br>
(1) git://people.freedesktop.org/~agd5f/linux<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB18097CCE08BC1ABE85276B64F7510BN6PR12MB1809namp_--

--===============1742183135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1742183135==--
