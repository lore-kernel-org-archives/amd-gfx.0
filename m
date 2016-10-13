From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: drm/amd/powerplay: expose max engine and memory clock info for
 powerplay enabled case
Date: Thu, 13 Oct 2016 08:24:50 +0000
Message-ID: <CY1PR12MB06331A0838154A671573DFDFE4DC0@CY1PR12MB0633.namprd12.prod.outlook.com>
References: <CY1PR12MB063370D13A0A96E852E569A8E4DD0@CY1PR12MB0633.namprd12.prod.outlook.com>
 <MWHPR12MB169404C5213FB6A0F7BE904BF7DD0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY1PR12MB06331A0838154A671573DFDFE4DC0CY1PR12MB0633namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB169404C5213FB6A0F7BE904BF7DD0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--_004_CY1PR12MB06331A0838154A671573DFDFE4DC0CY1PR12MB0633namp_
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB06331A0838154A671573DFDFE4DC0CY1PR12MB0633namp_"

--_000_CY1PR12MB06331A0838154A671573DFDFE4DC0CY1PR12MB0633namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for your information.
I updated the patch using the amdgpu_dpm_get_sclk/mclk APIs which make the =
patch much simpler.

Regards,
Evan

From: Deucher, Alexander
Sent: Thursday, October 13, 2016 6:04 AM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhang, Jerry <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>; Huan, Alvin <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>; Q=
uan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: drm/amd/powerplay: expose max engine and memory clock info for=
 powerplay enabled case

I don't know if we need to add a cgs call to fill in the max_clock_voltage_=
limits structure.  That's mostly just leftover from radeon.  A better solut=
ion would be use the existing amdgpu_dpm_get_sclk and amdgpu_dpm_get_mclk m=
acros.  Maybe something like the attached patch? Unless there is a specific=
 need for the max clocks on AC.  I think in most cases the results will be =
the same.

Alex

From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of Q=
uan, Evan
Sent: Wednesday, October 12, 2016 1:53 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Zhang, Jerry; Huan, Alvin; Quan, Evan; Huang, Ray
Subject: drm/amd/powerplay: expose max engine and memory clock info for pow=
erplay enabled case

Hi All,

We found the max engine clock and max memory clock are both wrongly reporte=
d as 0(by AMDGPU_INFO_DEV_INFO ioctl).
The attached patch tries to fix it.
Please help to review it.
Any comment is welcomed.

Regards,
Evan

--_000_CY1PR12MB06331A0838154A671573DFDFE4DC0CY1PR12MB0633namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Hi Alex,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Thanks for your inform=
ation. <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I updated the patch us=
ing the amdgpu_dpm_get_sclk/mclk APIs which make the patch much simpler.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Regards,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Evan<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander <br>
<b>Sent:</b> Thursday, October 13, 2016 6:04 AM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<b>Cc:</b> Zhang, Jerry &lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Huan, Alvin &lt;Alvin.=
Huan-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.=
Huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: drm/amd/powerplay: expose max engine and memory clock i=
nfo for powerplay enabled case<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">I don't know if we nee=
d to add a cgs call to fill in the max_clock_voltage_limits structure.&nbsp=
; That's mostly just leftover from radeon.&nbsp; A better solution would be=
 use the existing amdgpu_dpm_get_sclk and amdgpu_dpm_get_mclk
 macros.&nbsp; Maybe something like the attached patch? Unless there is a s=
pecific need for the max clocks on AC.&nbsp; I think in most cases the resu=
lts will be the same.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Alex<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,sans-serif">From:</span></b><span style=3D"font-size:10.0pt;f=
ont-family:&quot;Tahoma&quot;,sans-serif"> amd-gfx [<a href=3D"mailto:amd-g=
fx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a>]
<b>On Behalf Of </b>Quan, Evan<br>
<b>Sent:</b> Wednesday, October 12, 2016 1:53 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Zhang, Jerry; Huan, Alvin; Quan, Evan; Huang, Ray<br>
<b>Subject:</b> drm/amd/powerplay: expose max engine and memory clock info =
for powerplay enabled case<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi All,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We found the max engine clock and max memory clock a=
re both wrongly reported as 0(by AMDGPU_INFO_DEV_INFO ioctl).<o:p></o:p></p=
>
<p class=3D"MsoNormal">The attached patch tries to fix it.<o:p></o:p></p>
<p class=3D"MsoNormal">Please help to review it.<o:p></o:p></p>
<p class=3D"MsoNormal">Any comment is welcomed.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_CY1PR12MB06331A0838154A671573DFDFE4DC0CY1PR12MB0633namp_--

--_004_CY1PR12MB06331A0838154A671573DFDFE4DC0CY1PR12MB0633namp_
Content-Type: application/octet-stream;
	name="0001-drm-amd-amdgpu-expose-max-engine-and-memory-clock-fo.patch"
Content-Description: 0001-drm-amd-amdgpu-expose-max-engine-and-memory-clock-fo.patch
Content-Disposition: attachment;
	filename="0001-drm-amd-amdgpu-expose-max-engine-and-memory-clock-fo.patch";
	size=1621; creation-date="Thu, 13 Oct 2016 08:20:48 GMT";
	modification-date="Thu, 13 Oct 2016 08:17:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjYmMyOWNkODE4OTllOGQ4OTQ0ZDdmYzdmOTkxYjFiZDg5Y2UxYjk3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpEYXRlOiBU
aHUsIDEzIE9jdCAyMDE2IDE2OjE1OjI5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9h
bWRncHU6IGV4cG9zZSBtYXggZW5naW5lIGFuZCBtZW1vcnkgY2xvY2sgZm9yCiBwb3dlcnBsYXkg
ZW5hYmxlZCBjYXNlCgpDaGFuZ2UtSWQ6IEk2MGYwZDhhNzkyMjc3N2Q1NGY4NWEyOGQ3MmQ0ZjY5
Mzg4MmJhN2YwClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgMTMgKysrKysrKysr
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKaW5kZXggYjMxZmIzZS4uZjhkNTlj
MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwpAQCAtNDg5LDEwICs0
ODksMTUgQEAgc3RhdGljIGludCBhbWRncHVfaW5mb19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUKIAkJLyogcmV0dXJuIGFsbCBjbG9ja3Mg
aW4gS0h6ICovCiAJCWRldl9pbmZvLmdwdV9jb3VudGVyX2ZyZXEgPSBhbWRncHVfYXNpY19nZXRf
eGNsayhhZGV2KSAqIDEwOwogCQlpZiAoYWRldi0+cG0uZHBtX2VuYWJsZWQpIHsKLQkJCWRldl9p
bmZvLm1heF9lbmdpbmVfY2xvY2sgPQotCQkJCWFkZXYtPnBtLmRwbS5keW5fc3RhdGUubWF4X2Ns
b2NrX3ZvbHRhZ2Vfb25fYWMuc2NsayAqIDEwOwotCQkJZGV2X2luZm8ubWF4X21lbW9yeV9jbG9j
ayA9Ci0JCQkJYWRldi0+cG0uZHBtLmR5bl9zdGF0ZS5tYXhfY2xvY2tfdm9sdGFnZV9vbl9hYy5t
Y2xrICogMTA7CisJCQlpZiAoYWRldi0+cHBfZW5hYmxlZCkgeworCQkJCWRldl9pbmZvLm1heF9l
bmdpbmVfY2xvY2sgPSBhbWRncHVfZHBtX2dldF9zY2xrKGFkZXYsIGZhbHNlKSAqIDEwOworCQkJ
CWRldl9pbmZvLm1heF9tZW1vcnlfY2xvY2sgPSBhbWRncHVfZHBtX2dldF9tY2xrKGFkZXYsIGZh
bHNlKSAqIDEwOworCQkJfSBlbHNlIHsKKwkJCQlkZXZfaW5mby5tYXhfZW5naW5lX2Nsb2NrID0K
KwkJCQkJYWRldi0+cG0uZHBtLmR5bl9zdGF0ZS5tYXhfY2xvY2tfdm9sdGFnZV9vbl9hYy5zY2xr
ICogMTA7CisJCQkJZGV2X2luZm8ubWF4X21lbW9yeV9jbG9jayA9CisJCQkJCWFkZXYtPnBtLmRw
bS5keW5fc3RhdGUubWF4X2Nsb2NrX3ZvbHRhZ2Vfb25fYWMubWNsayAqIDEwOworCQkJfQogCQl9
IGVsc2UgewogCQkJZGV2X2luZm8ubWF4X2VuZ2luZV9jbG9jayA9IGFkZXYtPnBtLmRlZmF1bHRf
c2NsayAqIDEwOwogCQkJZGV2X2luZm8ubWF4X21lbW9yeV9jbG9jayA9IGFkZXYtPnBtLmRlZmF1
bHRfbWNsayAqIDEwOwotLSAKMi43LjQKCg==

--_004_CY1PR12MB06331A0838154A671573DFDFE4DC0CY1PR12MB0633namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY1PR12MB06331A0838154A671573DFDFE4DC0CY1PR12MB0633namp_--
