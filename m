From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: drm/amd/powerplay: expose max engine and memory clock info for
 powerplay enabled case
Date: Wed, 12 Oct 2016 05:53:06 +0000
Message-ID: <CY1PR12MB063370D13A0A96E852E569A8E4DD0@CY1PR12MB0633.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY1PR12MB063370D13A0A96E852E569A8E4DD0CY1PR12MB0633namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--_004_CY1PR12MB063370D13A0A96E852E569A8E4DD0CY1PR12MB0633namp_
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB063370D13A0A96E852E569A8E4DD0CY1PR12MB0633namp_"

--_000_CY1PR12MB063370D13A0A96E852E569A8E4DD0CY1PR12MB0633namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

We found the max engine clock and max memory clock are both wrongly reporte=
d as 0(by AMDGPU_INFO_DEV_INFO ioctl).
The attached patch tries to fix it.
Please help to review it.
Any comment is welcomed.

Regards,
Evan

--_000_CY1PR12MB063370D13A0A96E852E569A8E4DD0CY1PR12MB0633namp_
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
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
</body>
</html>

--_000_CY1PR12MB063370D13A0A96E852E569A8E4DD0CY1PR12MB0633namp_--

--_004_CY1PR12MB063370D13A0A96E852E569A8E4DD0CY1PR12MB0633namp_
Content-Type: application/octet-stream;
	name="0001-drm-amd-powerplay-expose-max-engine-memory-clock-inf.patch"
Content-Description: 0001-drm-amd-powerplay-expose-max-engine-memory-clock-inf.patch
Content-Disposition: attachment;
	filename="0001-drm-amd-powerplay-expose-max-engine-memory-clock-inf.patch";
	size=4516; creation-date="Wed, 12 Oct 2016 05:50:41 GMT";
	modification-date="Wed, 12 Oct 2016 05:45:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjZjBhMDBkNGU4ZWE5ZjVmMGM4M2IyYmE3NDgwODM3OGVmNGYxOTIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpEYXRlOiBX
ZWQsIDEyIE9jdCAyMDE2IDEzOjM1OjIyICswODAwClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9w
b3dlcnBsYXk6IGV4cG9zZSBtYXggZW5naW5lL21lbW9yeSBjbG9jayBpbmZvIGZvcgogcG93ZXJw
bGF5IGVuYWJsZWQgY2FzZQoKQ2hhbmdlLUlkOiBJMzA2NGY5NWE4YjllY2YwMzFmOTdhOWNhZjNh
YmYyZmVlOGU4OThmMgpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jZ3MuYyAgICAgICAgICB8
IDI5ICsrKysrKysrKysrKysrKysrKysrKysrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRl
L2Nnc19jb21tb24uaCAgICAgICAgIHwgMTQgKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMgfCAxMyArKysrKysrKysrKwogMyBmaWxl
cyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nncy5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Nncy5jCmluZGV4IDM0MDQ5ZDYuLmNmZWQ2MzggMTAwNzU1Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jZ3MuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY2dzLmMKQEAgLTExODUsNiArMTE4NSwzMiBAQCBz
dGF0aWMgaW50IGFtZGdwdV9jZ3NfY2FsbF9hY3BpX21ldGhvZChzdHJ1Y3QgY2dzX2RldmljZSAq
Y2dzX2RldmljZSwKIAlyZXR1cm4gYW1kZ3B1X2Nnc19hY3BpX2V2YWxfb2JqZWN0KGNnc19kZXZp
Y2UsICZpbmZvKTsKIH0KIAorc3RhdGljIGludCBhbWRncHVfY2dzX3BtX3NldF9tYXhfY2xrX3Zv
bF9vbl9hYyhzdHJ1Y3QgY2dzX2RldmljZSAqY2dzX2RldmljZSwKKwkJCQkJZW51bSBjZ3NfcG1f
Y2xvY2tfdm9sdGFnZV9vbl9hYyBjbGtfdm9sLAorCQkJCQl1MzIgdmFsKQoreworCUNHU19GVU5D
X0FERVY7CisKKwlzd2l0Y2ggKGNsa192b2wpIHsKKwkJY2FzZSBDR1NfUE1fQ0xPQ0tfU0NMS19B
QzoKKwkJCWFkZXYtPnBtLmRwbS5keW5fc3RhdGUubWF4X2Nsb2NrX3ZvbHRhZ2Vfb25fYWMuc2Ns
ayA9IHZhbDsKKwkJCWJyZWFrOworCQljYXNlIENHU19QTV9DTE9DS19NQ0xLX0FDOgorCQkJYWRl
di0+cG0uZHBtLmR5bl9zdGF0ZS5tYXhfY2xvY2tfdm9sdGFnZV9vbl9hYy5tY2xrID0gdmFsOwor
CQkJYnJlYWs7CisJCWNhc2UgQ0dTX1BNX1ZPTFRBR0VfVkREQ19BQzoKKwkJCWFkZXYtPnBtLmRw
bS5keW5fc3RhdGUubWF4X2Nsb2NrX3ZvbHRhZ2Vfb25fYWMudmRkYyA9IHZhbDsKKwkJCWJyZWFr
OworCQljYXNlIENHU19QTV9WT0xUQUdFX1ZERENJX0FDOgorCQkJYWRldi0+cG0uZHBtLmR5bl9z
dGF0ZS5tYXhfY2xvY2tfdm9sdGFnZV9vbl9hYy52ZGRjaSA9IHZhbDsKKwkJCWJyZWFrOworCQlk
ZWZhdWx0OgorCQkJcmV0dXJuIC1FSU5WQUw7CisJfQorCisJcmV0dXJuIDA7Cit9CisKIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgY2dzX29wcyBhbWRncHVfY2dzX29wcyA9IHsKIAlhbWRncHVfY2dzX2dw
dV9tZW1faW5mbywKIAlhbWRncHVfY2dzX2dtYXBfa21lbSwKQEAgLTEyMjQsNyArMTI1MCw4IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2dzX29wcyBhbWRncHVfY2dzX29wcyA9IHsKIAlhbWRncHVf
Y2dzX25vdGlmeV9kcG1fZW5hYmxlZCwKIAlhbWRncHVfY2dzX2NhbGxfYWNwaV9tZXRob2QsCiAJ
YW1kZ3B1X2Nnc19xdWVyeV9zeXN0ZW1faW5mbywKLQlhbWRncHVfY2dzX2lzX3ZpcnR1YWxpemF0
aW9uX2VuYWJsZWQKKwlhbWRncHVfY2dzX2lzX3ZpcnR1YWxpemF0aW9uX2VuYWJsZWQsCisJYW1k
Z3B1X2Nnc19wbV9zZXRfbWF4X2Nsa192b2xfb25fYWMsCiB9OwogCiBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGNnc19vc19vcHMgYW1kZ3B1X2Nnc19vc19vcHMgPSB7CmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUvY2dzX2NvbW1vbi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9p
bmNsdWRlL2Nnc19jb21tb24uaAppbmRleCBlNGExNjk3Li4wNmM2NzdkIDEwMDc1NQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvY2dzX2NvbW1vbi5oCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvaW5jbHVkZS9jZ3NfY29tbW9uLmgKQEAgLTYyMiw2ICs2MjIsMTcgQEAgdHlwZWRl
ZiBpbnQgKCpjZ3NfcXVlcnlfc3lzdGVtX2luZm8pKHN0cnVjdCBjZ3NfZGV2aWNlICpjZ3NfZGV2
aWNlLAogCiB0eXBlZGVmIGludCAoKmNnc19pc192aXJ0dWFsaXphdGlvbl9lbmFibGVkX3QpKHZv
aWQgKmNnc19kZXZpY2UpOwogCitlbnVtIGNnc19wbV9jbG9ja192b2x0YWdlX29uX2FjIHsKKwlD
R1NfUE1fQ0xPQ0tfU0NMS19BQywKKwlDR1NfUE1fQ0xPQ0tfTUNMS19BQywKKwlDR1NfUE1fVk9M
VEFHRV9WRERDX0FDLAorCUNHU19QTV9WT0xUQUdFX1ZERENJX0FDLAorfTsKKwordHlwZWRlZiBp
bnQgKCpjZ3NfcG1fc2V0X21heF9jbGtfdm9sX29uX2FjKShzdHJ1Y3QgY2dzX2RldmljZSAqY2dz
X2RldmljZSwKKwkJCQkJCWVudW0gY2dzX3BtX2Nsb2NrX3ZvbHRhZ2Vfb25fYWMgY2xrX3ZvbCwK
KwkJCQkJCXUzMiB2YWwpOworCiBzdHJ1Y3QgY2dzX29wcyB7CiAJLyogbWVtb3J5IG1hbmFnZW1l
bnQgY2FsbHMgKHNpbWlsYXIgdG8gS0ZEIGludGVyZmFjZSkgKi8KIAljZ3NfZ3B1X21lbV9pbmZv
X3QgZ3B1X21lbV9pbmZvOwpAQCAtNjc0LDYgKzY4NSw3IEBAIHN0cnVjdCBjZ3Nfb3BzIHsKIAkv
KiBnZXQgc3lzdGVtIGluZm8gKi8KIAljZ3NfcXVlcnlfc3lzdGVtX2luZm8gcXVlcnlfc3lzdGVt
X2luZm87CiAJY2dzX2lzX3ZpcnR1YWxpemF0aW9uX2VuYWJsZWRfdCBpc192aXJ0dWFsaXphdGlv
bl9lbmFibGVkOworCWNnc19wbV9zZXRfbWF4X2Nsa192b2xfb25fYWMgcG1fc2V0X21heF9jbGtf
dm9sX29uX2FjOwogfTsKIAogc3RydWN0IGNnc19vc19vcHM7IC8qIFRvIGJlIGRlZmluZSBpbiBP
Uy1zcGVjaWZpYyBDR1MgaGVhZGVyICovCkBAIC03NzksNCArNzkxLDYgQEAgc3RydWN0IGNnc19k
ZXZpY2UKIAogI2RlZmluZSBjZ3NfaXNfdmlydHVhbGl6YXRpb25fZW5hYmxlZChjZ3NfZGV2aWNl
KSBcCiAJCUNHU19DQUxMKGlzX3ZpcnR1YWxpemF0aW9uX2VuYWJsZWQsIGNnc19kZXZpY2UpCisj
ZGVmaW5lIGNnc19wbV9zZXRfbWF4X2Nsa192b2xfb25fYWMoZGV2LCBjbGtfdm9sLCB2YWwpIFwK
KwlDR1NfQ0FMTChwbV9zZXRfbWF4X2Nsa192b2xfb25fYWMsIGRldiwgY2xrX3ZvbCwgdmFsKQog
I2VuZGlmIC8qIF9DR1NfQ09NTU9OX0ggKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYwppbmRleCBmNmFmYTZhLi4wYjBjNmRlIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCkBAIC0x
ODY1LDYgKzE4NjUsMTkgQEAgc3RhdGljIGludCBzbXU3X3NldF9wcml2YXRlX2RhdGFfYmFzZWRf
b25fcHB0YWJsZV92MShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogCWh3bWdyLT5keW5fc3RhdGUu
bWF4X2Nsb2NrX3ZvbHRhZ2Vfb25fYWMudmRkYyA9IHRhYmxlX2luZm8tPm1heF9jbG9ja192b2x0
YWdlX29uX2FjLnZkZGM7CiAJaHdtZ3ItPmR5bl9zdGF0ZS5tYXhfY2xvY2tfdm9sdGFnZV9vbl9h
Yy52ZGRjaSA9IHRhYmxlX2luZm8tPm1heF9jbG9ja192b2x0YWdlX29uX2FjLnZkZGNpOwogCisJ
Y2dzX3BtX3NldF9tYXhfY2xrX3ZvbF9vbl9hYyhod21nci0+ZGV2aWNlLAorCQkJCQlDR1NfUE1f
Q0xPQ0tfU0NMS19BQywKKwkJCQkJdGFibGVfaW5mby0+bWF4X2Nsb2NrX3ZvbHRhZ2Vfb25fYWMu
c2Nsayk7CisJY2dzX3BtX3NldF9tYXhfY2xrX3ZvbF9vbl9hYyhod21nci0+ZGV2aWNlLAorCQkJ
CQlDR1NfUE1fQ0xPQ0tfTUNMS19BQywKKwkJCQkJdGFibGVfaW5mby0+bWF4X2Nsb2NrX3ZvbHRh
Z2Vfb25fYWMubWNsayk7CisJY2dzX3BtX3NldF9tYXhfY2xrX3ZvbF9vbl9hYyhod21nci0+ZGV2
aWNlLAorCQkJCQlDR1NfUE1fVk9MVEFHRV9WRERDX0FDLAorCQkJCQl0YWJsZV9pbmZvLT5tYXhf
Y2xvY2tfdm9sdGFnZV9vbl9hYy52ZGRjKTsKKwljZ3NfcG1fc2V0X21heF9jbGtfdm9sX29uX2Fj
KGh3bWdyLT5kZXZpY2UsCisJCQkJCUNHU19QTV9WT0xUQUdFX1ZERENJX0FDLAorCQkJCQl0YWJs
ZV9pbmZvLT5tYXhfY2xvY2tfdm9sdGFnZV9vbl9hYy52ZGRjaSk7CisKIAlyZXR1cm4gMDsKIH0K
IAotLSAKMi43LjQKCg==

--_004_CY1PR12MB063370D13A0A96E852E569A8E4DD0CY1PR12MB0633namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY1PR12MB063370D13A0A96E852E569A8E4DD0CY1PR12MB0633namp_--
