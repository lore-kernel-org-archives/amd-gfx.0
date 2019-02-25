From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: use BACO reset on vega20 if platform
Date: Mon, 25 Feb 2019 03:20:43 +0000
Message-ID: <DM6PR12MB2635FA9BEF18591F784A2BC3FC7A0@DM6PR12MB2635.namprd12.prod.outlook.com>
References: <DM6PR12MB2603A151C5256DAC80C8469C917A0@DM6PR12MB2603.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0288185292=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM6PR12MB2603A151C5256DAC80C8469C917A0-lmeGfMZKVrHxlWl8GjgjngdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Li, Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>, "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: brahma_sw_dev <brahma_sw_dev-5C7GfCeVMHo@public.gmane.org>

--===============0288185292==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2635FA9BEF18591F784A2BC3FC7A0DM6PR12MB2635namp_"

--_000_DM6PR12MB2635FA9BEF18591F784A2BC3FC7A0DM6PR12MB2635namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

QWRkIGFtZC1nZnguIFRoYW5rcyBDYW5kaWNlLiBQbGVhc2UgY2hlY2sgeW91ciBjb2RlIGFsaWdu
bWVudCBiZWZvcmUgY29tbWl0dGVkIHRoZSBwYXRjaC4NCg0KUmV2aWV3ZWQtYnk6IEhhd2tpbmcg
WmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCkZyb206
IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+DQpTZW50OiAyMDE5xOoy1MIyNcjVIDEx
OjA5DQpUbzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFh1LCBGZWlm
ZWkgPEZlaWZlaS5YdUBhbWQuY29tPg0KQ2M6IGJyYWhtYV9zd19kZXYgPGJyYWhtYV9zd19kZXZA
YW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gUmV2ZXJ0ICJkcm0vYW1kZ3B1OiB1c2UgQkFDTyBy
ZXNldCBvbiB2ZWdhMjAgaWYgcGxhdGZvcm0NCg0KRGlzYWJsZSBCQUNPIG9uIFZlZ2EyMCBhdCB0
aGUgbW9tZW50IGR1ZSB0byB0aGUgZXhpc3RpbmcgSFcgaXNzdWUgc3RpbGwgY2F1c2luZyBoYW5n
cyBvbiBCQUNPIGV4aXQuDQoNClNpZ25lZC1vZmYtYnk6IENhbmRpY2UgTGkgPGNhbmRpY2UubGlA
YW1kLmNvbTxtYWlsdG86Y2FuZGljZS5saUBhbWQuY29tPj4NCi0tLQ0KZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc29jMTUuYyB8IDEgLQ0KMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQppbmRleCBiMmNiZTRiLi4zNjE1OGRiIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KQEAgLTQ2Miw3ICs0NjIsNiBAQCBzdGF0
aWMgaW50IHNvYzE1X2FzaWNfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogICAg
ICAgICAgICAgIHN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7DQogICAgICAgICAgICAgIGNhc2Ug
Q0hJUF9WRUdBMTA6DQogICAgICAgICAgICAgIGNhc2UgQ0hJUF9WRUdBMTI6DQotICAgICAgICAg
ICAgICBjYXNlIENISVBfVkVHQTIwOg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzb2Mx
NV9hc2ljX2dldF9iYWNvX2NhcGFiaWxpdHkoYWRldiwgJmJhY29fcmVzZXQpOw0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgICAgICAgZGVmYXVsdDoNCi0tDQoy
LjcuNA0KDQoNCg0KVGhhbmtzLA0KQ2FuZGljZSBMaQ0KDQo=

--_000_DM6PR12MB2635FA9BEF18591F784A2BC3FC7A0DM6PR12MB2635namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:=CE=A2=C8=ED=D1=C5=BA=DA;
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@=CE=A2=C8=ED=D1=C5=BA=DA";}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
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
<p class=3D"MsoNormal">Add amd-gfx. Thanks Candice. Please check your code =
alignment before committed the patch.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Li, Candice &lt;Candice.Li-5C7GfCeVMHo@public.gmane.org&gt; =
<br>
<b>Sent:</b> 2019<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=
=ED=D1=C5=BA=DA&quot;,sans-serif">=C4=EA</span>2<span lang=3D"ZH-CN" style=
=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif">=D4=C2</sp=
an>25<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,sans-serif">=C8=D5</span> 11:09<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Xu, Feifei &lt;Fei=
fei.Xu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> brahma_sw_dev &lt;brahma_sw_dev-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] Revert &quot;drm/amdgpu: use BACO reset on vega20 i=
f platform<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Disable BACO on Vega20 at the moment due to the exis=
ting HW issue still causing hangs on BACO exit.&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Candice Li &lt;<a href=3D"mailto:cand=
ice.li-5C7GfCeVMHo@public.gmane.org">candice.li-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/soc15.c | 1 -<o:p></o:p><=
/p>
<p class=3D"MsoNormal">1 file changed, 1 deletion(-)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/dr=
ivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p></p>
<p class=3D"MsoNormal">index b2cbe4b..36158db 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -462,7 &#43;462,6 @@ static int soc15_asic_reset(=
struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA10:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA12:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_asic_get_baco_capability(ad=
ev, &amp;baco_reset);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.7.4<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#00B050">Thanks,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#00B050">Candice Li<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB2635FA9BEF18591F784A2BC3FC7A0DM6PR12MB2635namp_--

--===============0288185292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0288185292==--
