From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: regression on RV1
Date: Wed, 17 Oct 2018 16:43:15 +0000
Message-ID: <6b9b5bdc-2e66-c00c-9ff8-6c5540375052@amd.com>
References: <fa0c1c22-5dce-e97f-3e17-59f08bd96f4f@amd.com>
 <BN6PR12MB180952142479156B7C607F3FF7FF0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB1809568E93126A0C8B259F81F7FF0@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0057082135=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809568E93126A0C8B259F81F7FF0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--===============0057082135==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_6b9b5bdc2e66c00c9ff86c5540375052amdcom_"

--_000_6b9b5bdc2e66c00c9ff86c5540375052amdcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Sorry for the noise, didn't thought about the issue that this SDMA code is =
used on RV as well.

Feel free to add my rb to the patch,
Christian.

Am 17.10.18 um 18:40 schrieb Deucher, Alexander:

I think something like this should fix it.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Deucher, Alexander <Alexander.Deucher=
@amd.com><mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 17, 2018 12:15:21 PM
To: StDenis, Tom; Koenig, Christian; amd-gfx mailing list
Cc: Huang, Ray
Subject: Re: regression on RV1


IIRC, APUs do not have a paging queue.  Only dGPUs have it.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org><ma=
ilto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 17, 2018 11:54:33 AM
To: Koenig, Christian; amd-gfx mailing list
Cc: Huang, Ray
Subject: regression on RV1

This commit:

commit 6cbd074831a423e0d30b386fc056d6c2c3559147 (HEAD, refs/bisect/bad)
Author: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christian.koeni=
g@amd.com>
Date:   Mon Oct 8 14:38:22 2018 +0200

     drm/amdgpu: activate paging queue on SDMA v4

     Implement all the necessary stuff to get those extra rings working.

     Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:chr=
istian.koenig-5C7GfCeVMHo@public.gmane.org>
     Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org><mailto:ray.huang-5C7GfCeVMHo@public.gmane.org>

Breaks my RV1 init.

Tom


--_000_6b9b5bdc2e66c00c9ff86c5540375052amdcom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <49E01DC6811A6649B9A600378986AF7D-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
<div class=3D"moz-cite-prefix">Sorry for the noise, didn't thought about th=
e issue that this SDMA code is used on RV as well.<br>
<br>
Feel free to add my rb to the patch,<br>
Christian.<br>
<br>
Am 17.10.18 um 18:40 schrieb Deucher, Alexander:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:BN6PR12MB1809568E93126A0C8B259F81F7FF=
0@BN6PR12MB1809.namprd12.prod.outlook.com">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">I think something like this shoul=
d fix it.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Deucher, Ale=
xander <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher@=
amd.com">
&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Wednesday, October 17, 2018 12:15:21 PM<br>
<b>To:</b> StDenis, Tom; Koenig, Christian; amd-gfx mailing list<br>
<b>Cc:</b> Huang, Ray<br>
<b>Subject:</b> Re: regression on RV1</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Diso-8859-1">
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000;
          font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">IIRC, APUs do not have a paging =
queue.&nbsp; Only dGPUs have it.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Alex<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of StDenis, Tom=
 <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org">
&lt;Tom.StDenis-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Wednesday, October 17, 2018 11:54:33 AM<br>
<b>To:</b> Koenig, Christian; amd-gfx mailing list<br>
<b>Cc:</b> Huang, Ray<br>
<b>Subject:</b> regression on RV1</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">This commit:<br>
<br>
commit 6cbd074831a423e0d30b386fc056d6c2c3559147 (HEAD, refs/bisect/bad)<br>
Author: Christian K=F6nig <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto=
:christian.koenig-5C7GfCeVMHo@public.gmane.org">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
Date:&nbsp;&nbsp; Mon Oct 8 14:38:22 2018 &#43;0200<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/amdgpu: activate paging queue on SDMA v4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Implement all the necessary stuff to get those ext=
ra rings working.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Christian K=F6nig <a class=3D"moz-t=
xt-link-rfc2396E" href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Huang Rui <a class=3D"moz-txt-link-rf=
c2396E" href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">
&lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
Breaks my RV1 init.<br>
<br>
Tom<br>
</div>
</span></font></div>
</div>
</blockquote>
<br>
</body>
</html>

--_000_6b9b5bdc2e66c00c9ff86c5540375052amdcom_--

--===============0057082135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0057082135==--
