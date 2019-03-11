From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Fix NULL pointer when ta is missing
Date: Mon, 11 Mar 2019 05:41:59 +0000
Message-ID: <BYAPR12MB2632E907DB5F4E566596E395FC480@BYAPR12MB2632.namprd12.prod.outlook.com>
References: <SN6PR12MB28001F806D566FFB2E0699DD87480@SN6PR12MB2800.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0093087347=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB28001F806D566FFB2E0699DD87480-kxOKjb6HO/EqkY47FTA1ogdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Gao,
 Likun" <Likun.Gao-5C7GfCeVMHo@public.gmane.org>

--===============0093087347==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2632E907DB5F4E566596E395FC480BYAPR12MB2632namp_"

--_000_BYAPR12MB2632E907DB5F4E566596E395FC480BYAPR12MB2632namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

V291bGQgaXQgbWFrZSBzZW5zZSB0byBjaGVjayB0YSBmdyBhdmFpbGFiaWxpdHkgYmVmb3JlIGNh
bGwgaW50byBwc3BfcmFzX2luaXRpYWxpemU/IEluIHN1Y2ggd2F5LCB3ZSBjYW4gYXZvaWQgdW5u
ZWNlc3NhcnkgZGV2aWNlIGVycm9yIGtlcm5lbCBtZXNzYWdlIHRoYXQgY29tcGxhaW5zIHJhcyBp
bml0IGZhaWx1cmUgb24gdGhlIEFTSUNzIHRoYXQgYWN0dWFsbHkgZG9uoa90IGhhdmUgUkFTIHN1
cHBvcnQuIEFjY29yZGluZ2x5LCB5b3UgbmVlZCBzaW1pbGFyIGxvZ2ljIGJlZm9yZSBjYWxsIGlu
dG8gcHNwX3Jhc190ZXJtaW5hdGUgaW4gaHdfZmluaSBwaGFzZS4NCg0KUmVnYXJkcywNCkhhd2tp
bmcNCkZyb206IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+DQpTZW50OiAyMDE5xOoz
1MIxMcjVIDEyOjIzDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2lu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgR2FvLCBMaWt1biA8TGlrdW4uR2FvQGFtZC5jb20+
DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBOVUxMIHBvaW50ZXIgd2hlbiB0YSBp
cyBtaXNzaW5nDQoNClRhIGlzIG9wdGlvbmFsLCBzbyBjaGVjayBpZiB0YSBmaXJtd2FyZSBpcyBs
b2FkZWQgb3Igbm90Lg0KDQpTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFt
ZC5jb208bWFpbHRvOnhpbmh1aS5wYW5AYW1kLmNvbT4+DQotLS0NCmRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDMgKysrDQoxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCmluZGV4IDdl
M2UxZDU4OGQ3NC4uMGJkOWRmOWZkMjg5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmMNCkBAIC02NTYsNiArNjU2LDkgQEAgc3RhdGljIGludCBwc3BfcmFzX2luaXRp
YWxpemUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQp7DQogICAgICAgICAgICAgaW50IHJldDsN
Cg0KKyAgICAgICAgICAgIGlmICghcHNwLT5hZGV2LT5wc3AudGFfZncpDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9FTlQ7DQorDQogICAgICAgICAgICAgaWYgKCFwc3At
PnJhcy5yYXNfaW5pdGlhbGl6ZWQpIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQg
PSBwc3BfcmFzX2luaXRfc2hhcmVkX2J1Zihwc3ApOw0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChyZXQpDQotLQ0KMi4xNy4xDQoNCg==

--_000_BYAPR12MB2632E907DB5F4E566596E395FC480BYAPR12MB2632namp_
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
	color:windowtext;}
span.EmailStyle20
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
<p class=3D"MsoNormal"><b>From:</b> Pan, Xinhui &lt;Xinhui.Pan-5C7GfCeVMHo@public.gmane.org&gt; =
<br>
<b>Sent:</b> 2019<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=
=ED=D1=C5=BA=DA&quot;,sans-serif">=C4=EA</span>3<span lang=3D"ZH-CN" style=
=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif">=D4=C2</sp=
an>11<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,sans-serif">=C8=D5</span> 12:23<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Haw=
king &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Gao, Likun &lt;Likun.Gao-5C7GfCeVMHo@public.gmane.org&gt;<br=
>
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

--_000_BYAPR12MB2632E907DB5F4E566596E395FC480BYAPR12MB2632namp_--

--===============0093087347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0093087347==--
