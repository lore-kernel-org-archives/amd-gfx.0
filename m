From: "Tao, Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>
Subject: remove static integer at uvd power gate to fix two gpu core boot up
Date: Wed, 21 Dec 2016 07:31:22 +0000
Message-ID: <CY1PR12MB08399D7CE3500C4373CF023EE5930@CY1PR12MB0839.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY1PR12MB08399D7CE3500C4373CF023EE5930CY1PR12MB0839namp_"
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--_004_CY1PR12MB08399D7CE3500C4373CF023EE5930CY1PR12MB0839namp_
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB08399D7CE3500C4373CF023EE5930CY1PR12MB0839namp_"

--_000_CY1PR12MB08399D7CE3500C4373CF023EE5930CY1PR12MB0839namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi  Alex


Please help have a review. Thanks a lot.


Best Regards
Yintian Tao

--_000_CY1PR12MB08399D7CE3500C4373CF023EE5930CY1PR12MB0839namp_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
<p class=3D"MsoNormal">Hi&nbsp; Alex<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please help have a review. Thanks a lot.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Yintian Tao<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY1PR12MB08399D7CE3500C4373CF023EE5930CY1PR12MB0839namp_--

--_004_CY1PR12MB08399D7CE3500C4373CF023EE5930CY1PR12MB0839namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-remove-static-integer-for-uvd-pp-state.patch"
Content-Description: 0001-drm-amdgpu-remove-static-integer-for-uvd-pp-state.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-remove-static-integer-for-uvd-pp-state.patch";
	size=1211; creation-date="Wed, 21 Dec 2016 07:20:17 GMT";
	modification-date="Wed, 21 Dec 2016 07:14:56 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0ZGM1MDZiMDRiZjJjMjczMjZiMjBhNTQ1MzljZjM3MTdjNzU0M2MxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZaW50aWFuIFRhbyA8eXR0YW9AYW1kLmNvbT4KRGF0ZTogV2Vk
LCAyMSBEZWMgMjAxNiAxNDozMjoyMSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6
IHJlbW92ZSBzdGF0aWMgaW50ZWdlciBmb3IgdXZkIHBwIHN0YXRlCgpBdCB0d28gZ3B1IGNvcmUg
Y29uZGl0aW9uLCBzdGF0aWMgaW50ZWdlciB3aWxsIGNhdXNlIHRoYXQgc2Vjb25kIGdwdQpjb3Jl
IHV2ZCBzdGF0ZSBzZXR0aW5nIHdpbGwgYmUgZGlyZWN0bHkgc2tpcHBlZCBkdWUgdG8gdGhlIGZp
cnN0IG9uZQpzZXR0aW5nCgpDaGFuZ2UtSWQ6IEk3MWViN2JkODQyYjk1NTFiYTQxZTlhNDQ4ZTVi
NzliZWY0MmE1NWFlClNpZ25lZC1vZmYtYnk6IFlpbnRpYW4gVGFvIDx5dHRhb0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmMgfCA1IC0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS91dmRfdjVfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1
XzAuYwppbmRleCBhNzllMjgzLi42ZGU2YmVjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS91dmRfdjVfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2
ZF92NV8wLmMKQEAgLTc5MSwxNSArNzkxLDEwIEBAIHN0YXRpYyBpbnQgdXZkX3Y1XzBfc2V0X2Ns
b2NrZ2F0aW5nX3N0YXRlKHZvaWQgKmhhbmRsZSwKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKIAlib29sIGVuYWJsZSA9IChz
dGF0ZSA9PSBBTURfQ0dfU1RBVEVfR0FURSkgPyB0cnVlIDogZmFsc2U7Ci0Jc3RhdGljIGludCBj
dXJzdGF0ZSA9IC0xOwogCiAJaWYgKCEoYWRldi0+Y2dfZmxhZ3MgJiBBTURfQ0dfU1VQUE9SVF9V
VkRfTUdDRykpCiAJCXJldHVybiAwOwogCi0JaWYgKGN1cnN0YXRlID09IHN0YXRlKQotCQlyZXR1
cm4gMDsKLQotCWN1cnN0YXRlID0gc3RhdGU7CiAJaWYgKGVuYWJsZSkgewogCQkvKiB3YWl0IGZv
ciBTVEFUVVMgdG8gY2xlYXIgKi8KIAkJaWYgKHV2ZF92NV8wX3dhaXRfZm9yX2lkbGUoaGFuZGxl
KSkKLS0gCjEuOS4xCgo=

--_004_CY1PR12MB08399D7CE3500C4373CF023EE5930CY1PR12MB0839namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY1PR12MB08399D7CE3500C4373CF023EE5930CY1PR12MB0839namp_--
