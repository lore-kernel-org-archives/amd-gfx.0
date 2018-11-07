From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: fix frame size of amdgpu_xgmi_add_devices
 excceed 1024 bytes
Date: Wed, 7 Nov 2018 04:23:58 +0000
Message-ID: <BYAPR12MB2632BA31D82C65814331C805FCC40@BYAPR12MB2632.namprd12.prod.outlook.com>
References: <1541561360-6230-1-git-send-email-Hawking.Zhang@amd.com>
 <CY4PR12MB1639EBB0B71AE8BDC8A8B46089C40@CY4PR12MB1639.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0815095659=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1639EBB0B71AE8BDC8A8B46089C40-rpdhrqHFk06fceQzjBI1oAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0815095659==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2632BA31D82C65814331C805FCC40BYAPR12MB2632namp_"

--_000_BYAPR12MB2632BA31D82C65814331C805FCC40BYAPR12MB2632namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

Rml4ZWQgYW5kIHB1c2hlZC4gVGhhbmtzLg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KRnJvbTogWXVh
biwgWGlhb2ppZSA8WGlhb2ppZS5ZdWFuQGFtZC5jb20+DQpTZW50OiAyMDE4xOoxMdTCN8jVIDEx
OjUxDQpUbzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBm
aXggZnJhbWUgc2l6ZSBvZiBhbWRncHVfeGdtaV9hZGRfZGV2aWNlcyBleGNjZWVkIDEwMjQgYnl0
ZXMNCg0KDQpXb3VsZCBiZSBiZXR0ZXIgdG8gYWRkIGEgaXMtbnVsbCBjaGVjayBmb3IgJ3RtcF90
b3BvbG9neScgYWZ0ZXIga3phbGxvYygpLiBXaXRoIHRoYXQgZml4ZWQsIHBhdGNoIGlzDQoNClJl
dmlld2VkLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBhbWQuY29tPG1haWx0bzp4aWFv
amllLnl1YW5AYW1kLmNvbT4+DQoNCg0KDQpSZWdhcmRzLA0KDQpYaWFvamllDQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPj4gb24gYmVoYWxmIG9mIEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1k
LmNvbTxtYWlsdG86SGF3a2luZy5aaGFuZ0BhbWQuY29tPj4NClNlbnQ6IFdlZG5lc2RheSwgTm92
ZW1iZXIgNywgMjAxOCAxMToyOSBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
PG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCkNjOiBaaGFuZywgSGF3a2lu
Zw0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggZnJhbWUgc2l6ZSBvZiBhbWRncHVf
eGdtaV9hZGRfZGV2aWNlcyBleGNjZWVkIDEwMjQgYnl0ZXMNCg0KSW5zdGVhZCBvZiBzdGFjay1h
bGxvY2F0ZWQgcHNwX3hnbWlfdG9wb2xvZ3lfaW5mbyBpbiBmdW5jdGlvbg0KYW1kZ3B1X3hnbWlf
YWRkX2RldmljZSwgZHluYW1pY2FsbHkgYWxsb2NhdGVkIHRoaXMgc3RydWN0dXJlIHRvDQphdm9p
ZCB0aGUgZnJhbWUgc2l6ZSBvZiB0aGlzIGZ1bmN0aW9uIGV4Y2NlZWQgMTAyNCBieXRlcy4NCg0K
U2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPG1haWx0
bzpIYXdraW5nLlpoYW5nQGFtZC5jb20+Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3hnbWkuYyB8IDExICsrKysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfeGdtaS5jDQppbmRleCBlOTJiNDU0Li4xYzBlZDEzIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYw0KQEAgLTYzLDcgKzYzLDcgQEAgc3RhdGljIHN0cnVj
dCBhbWRncHVfaGl2ZV9pbmZvICphbWRncHVfZ2V0X3hnbWlfaGl2ZShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikNCg0KIGludCBhbWRncHVfeGdtaV9hZGRfZGV2aWNlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQ0KIHsNCi0gICAgICAgc3RydWN0IHBzcF94Z21pX3RvcG9sb2d5X2luZm8g
dG1wX3RvcG9sb2d5Ow0KKyAgICAgICBzdHJ1Y3QgcHNwX3hnbWlfdG9wb2xvZ3lfaW5mbyAqdG1w
X3RvcG9sb2d5Ow0KICAgICAgICAgc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmU7DQogICAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X3hnbWkgICAgICAqZW50cnk7DQogICAgICAgICBzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAgICAgKnRtcF9hZGV2Ow0KQEAgLTc2LDcgKzc2LDcgQEAgaW50IGFtZGdwdV94
Z21pX2FkZF9kZXZpY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogICAgICAgICBhZGV2
LT5nbWMueGdtaS5ub2RlX2lkID0gcHNwX3hnbWlfZ2V0X25vZGVfaWQoJmFkZXYtPnBzcCk7DQog
ICAgICAgICBhZGV2LT5nbWMueGdtaS5oaXZlX2lkID0gcHNwX3hnbWlfZ2V0X2hpdmVfaWQoJmFk
ZXYtPnBzcCk7DQoNCi0gICAgICAgbWVtc2V0KCZ0bXBfdG9wb2xvZ3ksIDAsIHNpemVvZih0bXBf
dG9wb2xvZ3kpKTsNCisgICAgICAgdG1wX3RvcG9sb2d5ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0
IHBzcF94Z21pX3RvcG9sb2d5X2luZm8pLCBHRlBfS0VSTkVMKTsNCiAgICAgICAgIG11dGV4X2xv
Y2soJnhnbWlfbXV0ZXgpOw0KICAgICAgICAgaGl2ZSA9IGFtZGdwdV9nZXRfeGdtaV9oaXZlKGFk
ZXYpOw0KICAgICAgICAgaWYgKCFoaXZlKQ0KQEAgLTg0LDkgKzg0LDkgQEAgaW50IGFtZGdwdV94
Z21pX2FkZF9kZXZpY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQoNCiAgICAgICAgIGxp
c3RfYWRkX3RhaWwoJmFkZXYtPmdtYy54Z21pLmhlYWQsICZoaXZlLT5kZXZpY2VfbGlzdCk7DQog
ICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGVudHJ5LCAmaGl2ZS0+ZGV2aWNlX2xpc3QsIGhl
YWQpDQotICAgICAgICAgICAgICAgdG1wX3RvcG9sb2d5Lm5vZGVzW2NvdW50KytdLm5vZGVfaWQg
PSBlbnRyeS0+bm9kZV9pZDsNCisgICAgICAgICAgICAgICB0bXBfdG9wb2xvZ3ktPm5vZGVzW2Nv
dW50KytdLm5vZGVfaWQgPSBlbnRyeS0+bm9kZV9pZDsNCg0KLSAgICAgICByZXQgPSBwc3BfeGdt
aV9nZXRfdG9wb2xvZ3lfaW5mbygmYWRldi0+cHNwLCBjb3VudCwgJnRtcF90b3BvbG9neSk7DQor
ICAgICAgIHJldCA9IHBzcF94Z21pX2dldF90b3BvbG9neV9pbmZvKCZhZGV2LT5wc3AsIGNvdW50
LCB0bXBfdG9wb2xvZ3kpOw0KICAgICAgICAgaWYgKHJldCkgew0KICAgICAgICAgICAgICAgICBk
ZXZfZXJyKGFkZXYtPmRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAiWEdNSTogR2V0IHRv
cG9sb2d5IGZhaWx1cmUgb24gZGV2aWNlICVsbHgsIGhpdmUgJWxseCwgcmV0ICVkIiwNCkBAIC05
Niw3ICs5Niw3IEBAIGludCBhbWRncHVfeGdtaV9hZGRfZGV2aWNlKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQ0KICAgICAgICAgfQ0KICAgICAgICAgLyogRWFjaCBwc3AgbmVlZCB0byBzZXQg
dGhlIGxhdGVzdCB0b3BvbG9neSAqLw0KICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeSh0bXBf
YWRldiwgJmhpdmUtPmRldmljZV9saXN0LCBnbWMueGdtaS5oZWFkKSB7DQotICAgICAgICAgICAg
ICAgcmV0ID0gcHNwX3hnbWlfc2V0X3RvcG9sb2d5X2luZm8oJnRtcF9hZGV2LT5wc3AsIGNvdW50
LCAmdG1wX3RvcG9sb2d5KTsNCisgICAgICAgICAgICAgICByZXQgPSBwc3BfeGdtaV9zZXRfdG9w
b2xvZ3lfaW5mbygmdG1wX2FkZXYtPnBzcCwgY291bnQsIHRtcF90b3BvbG9neSk7DQogICAgICAg
ICAgICAgICAgIGlmIChyZXQpIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKHRt
cF9hZGV2LT5kZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiWEdNSTogU2V0
IHRvcG9sb2d5IGZhaWx1cmUgb24gZGV2aWNlICVsbHgsIGhpdmUgJWxseCwgcmV0ICVkIiwNCkBA
IC0xMTMsNSArMTEzLDYgQEAgaW50IGFtZGdwdV94Z21pX2FkZF9kZXZpY2Uoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQoNCiBleGl0Og0KICAgICAgICAgbXV0ZXhfdW5sb2NrKCZ4Z21pX211
dGV4KTsNCisgICAgICAga2ZyZWUodG1wX3RvcG9sb2d5KTsNCiAgICAgICAgIHJldHVybiByZXQ7
DQogfQ0KLS0NCjIuNy40DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc8bWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQo=

--_000_BYAPR12MB2632BA31D82C65814331C805FCC40BYAPR12MB2632namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
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
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CE=A2=C8=ED=D1=C5=BA=DA";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Fixed and pushed. Thanks.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Yuan, Xiaojie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&=
gt; <br>
<b>Sent:</b> 2018<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=
=ED=D1=C5=BA=DA&quot;,sans-serif">=C4=EA</span>11<span lang=3D"ZH-CN" style=
=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif">=D4=C2</sp=
an>7<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,sans-serif">=C8=D5</span> 11:51<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix frame size of amdgpu_xgmi_add_d=
evices excceed 1024 bytes<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Would be better to add a is=
-null check for 'tmp_topology' after kzalloc(). With that fixed, patch is<o=
:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">Reviewed-by: Xiaojie Yuan &=
lt;<a href=3D"mailto:xiaojie.yuan-5C7GfCeVMHo@public.gmane.org">xiaojie.yuan-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p=
></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Regards,<o:p></o:p></span><=
/p>
<p><span style=3D"font-size:12.0pt;color:black">Xiaojie<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-size:12.0pt;color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Hawking Zhang &lt;<a href=3D"mailto:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org">Hawking.Zhang@=
amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, November 7, 2018 11:29 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Zhang, Hawking<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix frame size of amdgpu_xgmi_add_devic=
es excceed 1024 bytes</span><span style=3D"font-size:12.0pt;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Instead of stack-allocat=
ed psp_xgmi_topology_info in function<br>
amdgpu_xgmi_add_device, dynamically allocated this structure to<br>
avoid the frame size of this function excceed 1024 bytes.<br>
<br>
Signed-off-by: Hawking Zhang &lt;<a href=3D"mailto:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org">H=
awking.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 11 &#43;&#43;&#43;&#43;&#4=
3;&#43;-----<br>
&nbsp;1 file changed, 6 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index e92b454..1c0ed13 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -63,7 &#43;63,7 @@ static struct amdgpu_hive_info *amdgpu_get_xgmi_hive(=
struct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;int amdgpu_xgmi_add_device(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_xgmi_topology_info tmp_top=
ology;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_xgmi_topology_info *tm=
p_topology;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *h=
ive;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_xgmi&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *entry;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device&nbsp;=
&nbsp;&nbsp;&nbsp; *tmp_adev;<br>
@@ -76,7 &#43;76,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.node_id =
=3D psp_xgmi_get_node_id(&amp;adev-&gt;psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.hive_id =
=3D psp_xgmi_get_hive_id(&amp;adev-&gt;psp);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;tmp_topology, 0, sizeof(t=
mp_topology));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_topology =3D kzalloc(sizeof(s=
truct psp_xgmi_topology_info), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;xgmi_mutex=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive =3D amdgpu_get_xgmi_h=
ive(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive)<br>
@@ -84,9 &#43;84,9 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;adev-&g=
t;gmc.xgmi.head, &amp;hive-&gt;device_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(entry,=
 &amp;hive-&gt;device_list, head)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp_topology.nodes[count&#43;&#43;].node_id =3D entry-&gt;node_i=
d;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; tmp_topology-&gt;nodes[count&#43;&#43;].node_id =3D entry-&g=
t;node_id;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_xgmi_get_topology_info(&a=
mp;adev-&gt;psp, count, &amp;tmp_topology);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_xgmi_get_topology_inf=
o(&amp;adev-&gt;psp, count, tmp_topology);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;XGMI: Get topology failure on device %llx, hive %llx, ret %d&quot;,<br>
@@ -96,7 &#43;96,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Each psp need to set th=
e latest topology */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_ad=
ev, &amp;hive-&gt;device_list, gmc.xgmi.head) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_xgmi_set_topology_info(&amp;tmp_adev-&gt;psp, count,=
 &amp;tmp_topology);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D psp_xgmi_set_topology_info(&amp;tmp_adev-&gt;psp, co=
unt, tmp_topology);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(tmp_adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;XGMI: Set topology failure=
 on device %llx, hive %llx, ret %d&quot;,<br>
@@ -113,5 &#43;113,6 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *ad=
ev)<br>
&nbsp;<br>
&nbsp;exit:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;xgmi_mut=
ex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(tmp_topology);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2632BA31D82C65814331C805FCC40BYAPR12MB2632namp_--

--===============0815095659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0815095659==--
