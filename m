From: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Fix NULL pointer when ta is missing
Date: Mon, 11 Mar 2019 05:46:17 +0000
Message-ID: <SN6PR12MB280040D56501182DED29DB8687480@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <SN6PR12MB28001F806D566FFB2E0699DD87480@SN6PR12MB2800.namprd12.prod.outlook.com>
 <BYAPR12MB2632E907DB5F4E566596E395FC480@BYAPR12MB2632.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0429546786=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB2632E907DB5F4E566596E395FC480-ZGDeBxoHBPk+ukJnzp2+RQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Gao,
 Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>

--===============0429546786==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB280040D56501182DED29DB8687480SN6PR12MB2800namp_"

--_000_SN6PR12MB280040D56501182DED29DB8687480SN6PR12MB2800namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

TWFrZSBzZW5zZS4gSSBhbSBmaXhpbmcgc29tZSBvdGhlciByYXMgcHJvYmxlbXMuIFdpbGwgc2Vu
ZCB0aGVtIG91dCBsYXRlci4NCg0KRnJvbTogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT4NClNlbnQ6IDIwMTnE6jPUwjExyNUgMTM6NDINClRvOiBQYW4sIFhpbmh1aSA8WGlu
aHVpLlBhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBHYW8sIExpa3VuIDxM
aWt1bi5HYW9AYW1kLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBO
VUxMIHBvaW50ZXIgd2hlbiB0YSBpcyBtaXNzaW5nDQoNCldvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8g
Y2hlY2sgdGEgZncgYXZhaWxhYmlsaXR5IGJlZm9yZSBjYWxsIGludG8gcHNwX3Jhc19pbml0aWFs
aXplPyBJbiBzdWNoIHdheSwgd2UgY2FuIGF2b2lkIHVubmVjZXNzYXJ5IGRldmljZSBlcnJvciBr
ZXJuZWwgbWVzc2FnZSB0aGF0IGNvbXBsYWlucyByYXMgaW5pdCBmYWlsdXJlIG9uIHRoZSBBU0lD
cyB0aGF0IGFjdHVhbGx5IGRvbqGvdCBoYXZlIFJBUyBzdXBwb3J0LiBBY2NvcmRpbmdseSwgeW91
IG5lZWQgc2ltaWxhciBsb2dpYyBiZWZvcmUgY2FsbCBpbnRvIHBzcF9yYXNfdGVybWluYXRlIGlu
IGh3X2ZpbmkgcGhhc2UuDQoNClJlZ2FyZHMsDQpIYXdraW5nDQpGcm9tOiBQYW4sIFhpbmh1aSA8
WGluaHVpLlBhbkBhbWQuY29tPG1haWx0bzpYaW5odWkuUGFuQGFtZC5jb20+Pg0KU2VudDogMjAx
OcTqM9TCMTHI1SAxMjoyMw0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0
bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb208bWFpbHRvOkFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+PjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbTxtYWlsdG86SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPj47IEdhbywgTGlrdW4gPExpa3VuLkdhb0BhbWQuY29tPG1haWx0bzpM
aWt1bi5HYW9AYW1kLmNvbT4+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBOVUxM
IHBvaW50ZXIgd2hlbiB0YSBpcyBtaXNzaW5nDQoNClRhIGlzIG9wdGlvbmFsLCBzbyBjaGVjayBp
ZiB0YSBmaXJtd2FyZSBpcyBsb2FkZWQgb3Igbm90Lg0KDQpTaWduZWQtb2ZmLWJ5OiB4aW5odWkg
cGFuIDx4aW5odWkucGFuQGFtZC5jb208bWFpbHRvOnhpbmh1aS5wYW5AYW1kLmNvbT4+DQotLS0N
CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDMgKysrDQoxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMNCmluZGV4IDdlM2UxZDU4OGQ3NC4uMGJkOWRmOWZkMjg5IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCkBAIC02NTYsNiArNjU2LDkgQEAgc3RhdGlj
IGludCBwc3BfcmFzX2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQp7DQogICAg
ICAgICAgICAgaW50IHJldDsNCg0KKyAgICAgICAgICAgIGlmICghcHNwLT5hZGV2LT5wc3AudGFf
ZncpDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9FTlQ7DQorDQogICAg
ICAgICAgICAgaWYgKCFwc3AtPnJhcy5yYXNfaW5pdGlhbGl6ZWQpIHsNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZXQgPSBwc3BfcmFzX2luaXRfc2hhcmVkX2J1Zihwc3ApOw0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpDQotLQ0KMi4xNy4xDQoNCg==

--_000_SN6PR12MB280040D56501182DED29DB8687480SN6PR12MB2800namp_
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
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
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
@font-face
	{font-family:"\@=CB=CE=CC=E5";
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
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle21
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
<p class=3D"MsoNormal">Make sense. I am fixing some other ras problems. Wil=
l send them out later.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;Hawking.Zhang-urvtwAKJhsc@public.gmane.org=
m&gt; <br>
<b>Sent:</b> 2019<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=
=C4=EA</span>3<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=D4=
=C2</span>11<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=C8=D5<=
/span> 13:42<br>
<b>To:</b> Pan, Xinhui &lt;Xinhui.Pan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Gao, Likun=
 &lt;Likun.Gao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Fix NULL pointer when ta is missing=
<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Would it make sense to check ta fw availability befo=
re call into psp_ras_initialize? In such way, we can avoid unnecessary devi=
ce error kernel message that complains ras init failure on the ASICs that a=
ctually don=A1=AFt have RAS support. Accordingly,
 you need similar logic before call into psp_ras_terminate in hw_fini phase=
.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Pan, Xinhui &lt;<a href=3D"mailto:Xinhu=
i.Pan-5C7GfCeVMHo@public.gmane.org">Xinhui.Pan-5C7GfCeVMHo@public.gmane.org</a>&gt;
<br>
<b>Sent:</b> 2019<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=
=ED=D1=C5=BA=DA&quot;,sans-serif">=C4=EA</span>3<span lang=3D"ZH-CN" style=
=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif">=D4=C2</sp=
an>11<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,sans-serif">=C8=D5</span> 12:23<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto=
:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org">Hawking.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt;; Gao, Likun &lt;<a hr=
ef=3D"mailto:Likun.Gao-5C7GfCeVMHo@public.gmane.org">Likun.Gao-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix NULL pointer when ta is missing<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Ta is optional, so check if ta firmware is loaded or=
 not.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: xinhui pan &lt;<a href=3D"mailto:xinh=
ui.pan-5C7GfCeVMHo@public.gmane.org">xinhui.pan-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 &#43;&#4=
3;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 3 insertions(&#43;)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 7e3e1d588d74..0bd9df9fd289 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
psp.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -656,6 &#43;656,9 @@ static int psp_ras_initializ=
e(struct psp_context *psp)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_fw)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOENT;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (!psp-&gt;ras.ras_initialized) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ras_init_shared_buf(psp);<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_SN6PR12MB280040D56501182DED29DB8687480SN6PR12MB2800namp_--

--===============0429546786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0429546786==--
