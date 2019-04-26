From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: Re: print firmware versions on amdgpu sysfs
Date: Fri, 26 Apr 2019 18:35:50 +0000
Message-ID: <BN6PR12MB1618CE8C21ED572094D9BB10853E0@BN6PR12MB1618.namprd12.prod.outlook.com>
References: <355c6cb6-ccf7-ef6f-4f34-0e978b9effe2@amd.com>,
 <CY4PR12MB18136C9A3F7719CFD0C50D60F73E0@CY4PR12MB1813.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2113871736=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB18136C9A3F7719CFD0C50D60F73E0-rpdhrqHFk05Nhq0cRkx5WwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Lin, Amber" <Amber.Lin-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Freehill, Chris" <Chris.Freehill-5C7GfCeVMHo@public.gmane.org>

--===============2113871736==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1618CE8C21ED572094D9BB10853E0BN6PR12MB1618namp_"

--_000_BN6PR12MB1618CE8C21ED572094D9BB10853E0BN6PR12MB1618namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The main reasoning and use case for sysfs would be the SMI CLI, since unfor=
tunately there is no ioctl support in there.

Kent

KENT RUSSELL
Sr. Software Engineer | Linux Compute Kernel
1 Commerce Valley Drive East
Markham, ON L3T 7X6
O +(1) 289-695-2122 | Ext 72122
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, April 26, 2019 12:18:22 PM
To: Lin, Amber; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Freehill, Chris
Subject: Re: print firmware versions on amdgpu sysfs

We also expose the firmware versions via ioctl which is what the UMDs uses.=
  If you'd prefer it in sysfs, we could do that too.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Lin, Amb=
er <Amber.Lin-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, April 26, 2019 10:14 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Freehill, Chris
Subject: print firmware versions on amdgpu sysfs

Hi Alex,

Currently we retrieve firmware versions from /sys/kernel/debug but this
requires debugfs being enabled and superuser privilege. Do you see a
concern we add firmware versions to amdgpu sysfs at
/sys/class/drm/cardX/device like vbios_version?

Regards,
Amber
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1618CE8C21ED572094D9BB10853E0BN6PR12MB1618namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
The main reasoning and use case for sysfs would be the SMI CLI, since unfor=
tunately there is no ioctl support in there.
<br>
<br>
Kent<br>
<br>
KENT RUSSELL<br>
Sr. Software Engineer | Linux Compute Kernel<br>
1 Commerce Valley Drive East<br>
Markham, ON L3T 7X6<br>
O &#43;(1) 289-695-2122 | Ext 72122<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deucher, Alexander &lt;Alexan=
der.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, April 26, 2019 12:18:22 PM<br>
<b>To:</b> Lin, Amber; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Freehill, Chris<br>
<b>Subject:</b> Re: print firmware versions on amdgpu sysfs</font>
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
We also expose the firmware versions via ioctl which is what the UMDs uses.=
&nbsp; If you'd prefer it in sysfs, we could do that too.<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Lin, Amber &lt;Amber.Lin@am=
d.com&gt;<br>
<b>Sent:</b> Friday, April 26, 2019 10:14 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Freehill, Chris<br>
<b>Subject:</b> print firmware versions on amdgpu sysfs</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Hi Alex,<br>
<br>
Currently we retrieve firmware versions from /sys/kernel/debug but this <br=
>
requires debugfs being enabled and superuser privilege. Do you see a <br>
concern we add firmware versions to amdgpu sysfs at <br>
/sys/class/drm/cardX/device like vbios_version?<br>
<br>
Regards,<br>
Amber<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB1618CE8C21ED572094D9BB10853E0BN6PR12MB1618namp_--

--===============2113871736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2113871736==--
