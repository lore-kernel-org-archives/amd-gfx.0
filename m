From: "Lin, Amber" <Amber.Lin-5C7GfCeVMHo@public.gmane.org>
Subject: code review of amdgpu change
Date: Wed, 4 Jan 2017 19:54:44 +0000
Message-ID: <CY1PR12MB052498D1217DC8E697C5209FE1610@CY1PR12MB0524.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY1PR12MB052498D1217DC8E697C5209FE1610CY1PR12MB0524namp_"
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
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Russell,
 Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>

--_004_CY1PR12MB052498D1217DC8E697C5209FE1610CY1PR12MB0524namp_
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB052498D1217DC8E697C5209FE1610CY1PR12MB0524namp_"

--_000_CY1PR12MB052498D1217DC8E697C5209FE1610CY1PR12MB0524namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Current amdgpu allows to disable PCI IO bar but the dmesg still prints it a=
s an error. It misleads a false alarm to the user and we are receiving thos=
e reports from time to time. Attached patch turns this print from ERROR to =
INFO.


Amber Lin
Vertical Workstation/Compute
x72135
(289)695-2135


--_000_CY1PR12MB052498D1217DC8E697C5209FE1610CY1PR12MB0524namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aparajita;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:Garamond;
	panose-1:2 2 4 4 3 3 1 1 8 3;}
@font-face
	{font-family:"Lucida Handwriting";
	panose-1:3 1 1 1 1 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Current amdgpu allows to disable PCI IO bar but the =
dmesg still prints it as an error. It misleads a false alarm to the user an=
d we are receiving those reports from time to time. Attached patch turns th=
is print from ERROR to INFO.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;font-family:&quot=
;Lucida Handwriting&quot;"><o:p>&nbsp;</o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;font-family:&quot=
;Lucida Handwriting&quot;">Amber Lin<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ga=
ramond&quot;,&quot;serif&quot;">Vertical Workstation/Compute</span><span st=
yle=3D"font-size:12.0pt;font-family:&quot;Garamond&quot;,&quot;serif&quot;"=
><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ga=
ramond&quot;,&quot;serif&quot;">x72135<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ga=
ramond&quot;,&quot;serif&quot;">(289)695-2135<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CY1PR12MB052498D1217DC8E697C5209FE1610CY1PR12MB0524namp_--

--_004_CY1PR12MB052498D1217DC8E697C5209FE1610CY1PR12MB0524namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-PCI-I-O-bar-can-be-disabled.patch"
Content-Description: 0001-drm-amdgpu-PCI-I-O-bar-can-be-disabled.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-PCI-I-O-bar-can-be-disabled.patch"; size=1477;
	creation-date="Wed, 04 Jan 2017 19:38:27 GMT";
	modification-date="Wed, 04 Jan 2017 19:36:18 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5M2I4M2IzOTI3NDFhZDdmOGZlMDcyNDIxZTRiNzU0MjZmZGRmZWY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWJlciBMaW4gPEFtYmVyLkxpbkBhbWQuY29tPgpEYXRlOiBX
ZWQsIDQgSmFuIDIwMTcgMDg6MDY6NTggLTA1MDAKU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1
OiBQQ0kgSS9PIGJhciBjYW4gYmUgZGlzYWJsZWQKClBDSSBJL08gYmFyIGNhbiBiZSBkaXNhYmxl
ZCBpbiBWQklPUyB0byBzYXZlIHRoZSByZXNvdXJjZS4gSXQgaXMgb2Z0ZW4KZGlzYWJsZWQgaW4g
bGFyZ2UgYXBlcnR1cmUgVkJJT1MuIERvbid0IGNhbGwgaXQgYW4gZXJyb3IuCgpDaGFuZ2UtSWQ6
IEliYzNjNDcwZTc2NWQxOWQ3MjU0NTdiYWU3MDZhYzNmNzhiZmJhYWJjClNpZ25lZC1vZmYtYnk6
IEFtYmVyIExpbiA8QW1iZXIuTGluQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYwppbmRleCBkZGMwYzA4Li5jNzc3OTdjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC04NzIsNyArODcyLDcgQEAgc3RhdGljIGludCBh
bWRncHVfYXRvbWJpb3NfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJYXRvbV9j
YXJkX2luZm8tPmlvcmVnX3JlYWQgPSBjYWlsX2lvcmVnX3JlYWQ7CiAJCWF0b21fY2FyZF9pbmZv
LT5pb3JlZ193cml0ZSA9IGNhaWxfaW9yZWdfd3JpdGU7CiAJfSBlbHNlIHsKLQkJRFJNX0VSUk9S
KCJVbmFibGUgdG8gZmluZCBQQ0kgSS9PIEJBUjsgdXNpbmcgTU1JTyBmb3IgQVRPTSBJSU9cbiIp
OworCQlEUk1fSU5GTygiUENJIEkvTyBCQVIgaXMgbm90IGZvdW5kLiBVc2luZyBNTUlPIHRvIGFj
Y2VzcyBBVE9NIEJJT1NcbiIpOwogCQlhdG9tX2NhcmRfaW5mby0+aW9yZWdfcmVhZCA9IGNhaWxf
cmVnX3JlYWQ7CiAJCWF0b21fY2FyZF9pbmZvLT5pb3JlZ193cml0ZSA9IGNhaWxfcmVnX3dyaXRl
OwogCX0KQEAgLTE2MDcsNyArMTYwNyw3IEBAIGludCBhbWRncHVfZGV2aWNlX2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCX0KIAl9CiAJaWYgKGFkZXYtPnJpb19tZW0gPT0gTlVM
TCkKLQkJRFJNX0VSUk9SKCJVbmFibGUgdG8gZmluZCBQQ0kgSS9PIEJBUlxuIik7CisJCURSTV9J
TkZPKCJQQ0kgSS9PIEJBUiBpcyBub3QgZm91bmQuXG4iKTsKIAogCS8qIGVhcmx5IGluaXQgZnVu
Y3Rpb25zICovCiAJciA9IGFtZGdwdV9lYXJseV9pbml0KGFkZXYpOwotLSAKMS45LjEKCg==

--_004_CY1PR12MB052498D1217DC8E697C5209FE1610CY1PR12MB0524namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY1PR12MB052498D1217DC8E697C5209FE1610CY1PR12MB0524namp_--
