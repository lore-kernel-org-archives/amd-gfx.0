From: "Lin, Amber" <Amber.Lin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: print firmware versions on amdgpu sysfs
Date: Mon, 29 Apr 2019 13:35:32 +0000
Message-ID: <940a48aa-33c1-55a6-2bf1-a794aa0e746b@amd.com>
References: <355c6cb6-ccf7-ef6f-4f34-0e978b9effe2@amd.com>
 <CY4PR12MB18136C9A3F7719CFD0C50D60F73E0@CY4PR12MB1813.namprd12.prod.outlook.com>
 <BN6PR12MB1618CE8C21ED572094D9BB10853E0@BN6PR12MB1618.namprd12.prod.outlook.com>
 <d6c60e91-4311-069b-0612-03337830481d@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0432631378=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d6c60e91-4311-069b-0612-03337830481d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Messinger,
 Ori" <Ori.Messinger-5C7GfCeVMHo@public.gmane.org>
Cc: "Freehill, Chris" <Chris.Freehill-5C7GfCeVMHo@public.gmane.org>

--===============0432631378==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_940a48aa33c155a62bf1a794aa0e746bamdcom_"

--_000_940a48aa33c155a62bf1a794aa0e746bamdcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Thank you Alex and Christian for the feedback. Ori will try to add ioctl in=
to SMI CLI to retrieve firmware versions.

Amber

On 2019-04-29 8:22 a.m., Christian K=F6nig wrote:
We just need to keep in mind that sysfs has more restrictions than debugfs.

E.g. one value per file, backward compatibility etc...

Apart from that I don't see any reason to not do it in sysfs.

Christian.

Am 26.04.19 um 20:35 schrieb Russell, Kent:
The main reasoning and use case for sysfs would be the SMI CLI, since unfor=
tunately there is no ioctl support in there.

Kent

KENT RUSSELL
Sr. Software Engineer | Linux Compute Kernel
1 Commerce Valley Drive East
Markham, ON L3T 7X6
O +(1) 289-695-2122 | Ext 72122
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Deucher, Alexander <Alexander.Deucher=
@amd.com><mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, April 26, 2019 12:18:22 PM
To: Lin, Amber; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org>
Cc: Freehill, Chris
Subject: Re: print firmware versions on amdgpu sysfs

We also expose the firmware versions via ioctl which is what the UMDs uses.=
  If you'd prefer it in sysfs, we could do that too.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Lin, Amber <Amber.Lin-5C7GfCeVMHo@public.gmane.org><mailto=
:Amber.Lin-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, April 26, 2019 10:14 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_940a48aa33c155a62bf1a794aa0e746bamdcom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <69B9F77A6402CB44B0D2879DBDA24030-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
Thank you Alex and Christian for the feedback. Ori will try to add ioctl in=
to SMI CLI to retrieve firmware versions.<br>
<br>
Amber<br>
<br>
<div class=3D"moz-cite-prefix">On 2019-04-29 8:22 a.m., Christian K=F6nig w=
rote:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:d6c60e91-4311-069b-0612-03337830481d@=
gmail.com">
<div class=3D"moz-cite-prefix">We just need to keep in mind that sysfs has =
more restrictions than debugfs.<br>
<br>
E.g. one value per file, backward compatibility etc...<br>
<br>
Apart from that I don't see any reason to not do it in sysfs.<br>
<br>
Christian. <br>
<br>
Am 26.04.19 um 20:35 schrieb Russell, Kent:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:BN6PR12MB1618CE8C21ED572094D9BB10853E=
0@BN6PR12MB1618.namprd12.prod.outlook.com">
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
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org" moz-do-not-send=3D"true">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Deucher, Ale=
xander <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher@=
amd.com" moz-do-not-send=3D"true">
&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Friday, April 26, 2019 12:18:22 PM<br>
<b>To:</b> Lin, Amber; <a class=3D"moz-txt-link-abbreviated" href=3D"mailto=
:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
We also expose the firmware versions via ioctl which is what the UMDs uses.=
&nbsp; If you'd prefer it in sysfs, we could do that too.<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;
            font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org" moz-do-not-send=3D"true">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Lin, Amber <=
a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Amber.Lin-5C7GfCeVMHo@public.gmane.org" moz-do-=
not-send=3D"true">
&lt;Amber.Lin-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Friday, April 26, 2019 10:14 AM<br>
<b>To:</b> <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org" moz-do-not-send=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
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
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org" moz-do-not-send=3D"true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-n=
ot-send=3D"true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>=
</div>
</span></font></div>
</div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset>
<pre class=3D"moz-quote-pre" wrap=3D"">____________________________________=
___________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org" moz-do-not-send=3D"true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx" moz-do-not-send=3D"true">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a></pre>
</blockquote>
<br>
</blockquote>
<br>
</body>
</html>

--_000_940a48aa33c155a62bf1a794aa0e746bamdcom_--

--===============0432631378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0432631378==--
