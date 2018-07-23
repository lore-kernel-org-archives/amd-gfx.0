From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 3/3] drm/amd/powerplay: disallow slow switch if NBPState
 is disabled
Date: Mon, 23 Jul 2018 06:38:28 +0000
Message-ID: <SN6PR12MB265672B224B5B1CB2BC15DEEE4560@SN6PR12MB2656.namprd12.prod.outlook.com>
References: <20180720023505.25239-1-evan.quan@amd.com>,
 <20180720023505.25239-3-evan.quan@amd.com>,
 <CY4PR12MB168739D42A1638743A55AF34FB510@CY4PR12MB1687.namprd12.prod.outlook.com>
 <CY4PR12MB16876A0FBFDBF6FC8EA5C8C2FB510@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0166487513=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16876A0FBFDBF6FC8EA5C8C2FB510-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0166487513==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB265672B224B5B1CB2BC15DEEE4560SN6PR12MB2656namp_"

--_000_SN6PR12MB265672B224B5B1CB2BC15DEEE4560SN6PR12MB2656namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

U2VudCBvdXQgdGhlIHJldmlzZWQgcGF0Y2guDQoNClJlZ2FyZHMsDQpFdmFuDQpGcm9tOiBaaHUs
IFJleA0KU2VudDogRnJpZGF5LCBKdWx5IDIwLCAyMDE4IDY6MDggUE0NClRvOiBRdWFuLCBFdmFu
IDxFdmFuLlF1YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJq
ZWN0OiBSZTogW1BBVENIIDMvM10gZHJtL2FtZC9wb3dlcnBsYXk6IGRpc2FsbG93IHNsb3cgc3dp
dGNoIGlmIE5CUFN0YXRlIGlzIGRpc2FibGVkDQoNCg0KSGkgRXZhbqOsDQoNCg0KDQpDaGFuZ2lu
ZyB0aGUgdGl0bGUgdG8gIk9ubHkgYWxsb3cgc2xvdyBzd2l0Y2ggaWYgTkIgcHN0YXRlIHN3aXRj
aCBpcyBlbmFibGVkIiAgIGNhbiBtYWtlIHBhdGNoIG1vcmUNCg0KdW5kZXJzdGFuZGFibGUuDQoN
Cg0KDQoNCg0KQmVzdCBSZWdhcmRzDQoNClJleA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzxtYWlsdG86YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4+IG9uIGJl
aGFsZiBvZiBaaHUsIFJleCA8UmV4LlpodUBhbWQuY29tPG1haWx0bzpSZXguWmh1QGFtZC5jb20+
Pg0KU2VudDogRnJpZGF5LCBKdWx5IDIwLCAyMDE4IDQ6NDMgUE0NClRvOiBRdWFuLCBFdmFuOyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gZHJtL2FtZC9wb3dlcnBsYXk6IGRp
c2FsbG93IHNsb3cgc3dpdGNoIGlmIE5CUFN0YXRlIGlzIGRpc2FibGVkDQoNCg0KKyAgICAgICBi
b29sIHVjbGtfc3dpdGNoaW5nX2Rpc2FibGVkID0NCisoYm9vbClod21nci0+ZGlzcGxheV9jb25m
aWctPm5iX3BzdGF0ZV9zd2l0Y2hfZGlzYWJsZTsNCg0KDQoNCkRvbid0IG5lZWQgdHlwZSBjb252
ZXJ0Lg0KDQoNCg0KQmVzdCBSZWdhcmRzDQoNClJleA0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzxtYWlsdG86YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4+IG9u
IGJlaGFsZiBvZiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPG1haWx0bzpldmFuLnF1YW5A
YW1kLmNvbT4+DQpTZW50OiBGcmlkYXksIEp1bHkgMjAsIDIwMTggMTA6MzUgQU0NClRvOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc+DQpDYzogUXVhbiwgRXZhbjsgWmh1LCBSZXgNClN1YmplY3Q6IFtQQVRDSCAzLzNdIGRy
bS9hbWQvcG93ZXJwbGF5OiBkaXNhbGxvdyBzbG93IHN3aXRjaCBpZiBOQlBTdGF0ZSBpcyBkaXNh
YmxlZA0KDQpPdGhlcndpc2UgdGhlcmUgbWF5IGJlIHBvdGVudGlhbCBTTVUgcGVyZm9ybWFuY2Ug
aXNzdWVzLg0KDQpDaGFuZ2UtSWQ6IEkwNWEwOWJiMDU0MDdmN2IzNzA1ZDc5YTFkMmM2NjI4Mzg1
YzgwNDYxDQpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPG1haWx0
bzpldmFuLnF1YW5AYW1kLmNvbT4+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9od21nci92ZWdhMTBfaHdtZ3IuYyB8IDUgKysrKy0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9od21nci92ZWdhMTJfaHdtZ3IuYyB8IDUgKysrKy0NCiAyIGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMNCmluZGV4IDAwMmVkNzdhNTI2
OC4uY2NiNTg3NjA3YjAzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jDQpAQCAtMzc3OSw5ICszNzc5LDEyIEBAIHN0YXRpYyBp
bnQgdmVnYTEwX25vdGlmeV9zbWNfZGlzcGxheV9jb25maWdfYWZ0ZXJfcHNfYWRqdXN0bWVudCgN
CiAgICAgICAgIHN0cnVjdCBQUF9DbG9ja3MgbWluX2Nsb2NrcyA9IHswfTsNCiAgICAgICAgIHVp
bnQzMl90IGk7DQogICAgICAgICBzdHJ1Y3QgcHBfZGlzcGxheV9jbG9ja19yZXF1ZXN0IGNsb2Nr
X3JlcTsNCisgICAgICAgYm9vbCB1Y2xrX3N3aXRjaGluZ19kaXNhYmxlZCA9DQorICAgICAgICAg
ICAgICAgICAgICAgICAoYm9vbClod21nci0+ZGlzcGxheV9jb25maWctPm5iX3BzdGF0ZV9zd2l0
Y2hfZGlzYWJsZTsNCg0KICAgICAgICAgaWYgKChod21nci0+ZGlzcGxheV9jb25maWctPm51bV9k
aXNwbGF5ID4gMSkgJiYNCi0gICAgICAgICAgICAhaHdtZ3ItPmRpc3BsYXlfY29uZmlnLT5tdWx0
aV9tb25pdG9yX2luX3N5bmMpDQorICAgICAgICAgICAgIWh3bWdyLT5kaXNwbGF5X2NvbmZpZy0+
bXVsdGlfbW9uaXRvcl9pbl9zeW5jICYmDQorICAgICAgICAgICAgIXVjbGtfc3dpdGNoaW5nX2Rp
c2FibGVkKQ0KICAgICAgICAgICAgICAgICB2ZWdhMTBfbm90aWZ5X3NtY19kaXNwbGF5X2NoYW5n
ZShod21nciwgZmFsc2UpOw0KICAgICAgICAgZWxzZQ0KICAgICAgICAgICAgICAgICB2ZWdhMTBf
bm90aWZ5X3NtY19kaXNwbGF5X2NoYW5nZShod21nciwgdHJ1ZSk7DQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdyLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTJfaHdtZ3IuYw0KaW5kZXggMzVmOTZk
YWNiNTBhLi5lM2IxMWFlOGZkYjggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9od21nci92ZWdhMTJfaHdtZ3IuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdyLmMNCkBAIC0xMzg3LDkgKzEzODcsMTIgQEAgc3Rh
dGljIGludCB2ZWdhMTJfbm90aWZ5X3NtY19kaXNwbGF5X2NvbmZpZ19hZnRlcl9wc19hZGp1c3Rt
ZW50KA0KICAgICAgICAgICAgICAgICAgICAgICAgIChzdHJ1Y3QgdmVnYTEyX2h3bWdyICopKGh3
bWdyLT5iYWNrZW5kKTsNCiAgICAgICAgIHN0cnVjdCBQUF9DbG9ja3MgbWluX2Nsb2NrcyA9IHsw
fTsNCiAgICAgICAgIHN0cnVjdCBwcF9kaXNwbGF5X2Nsb2NrX3JlcXVlc3QgY2xvY2tfcmVxOw0K
KyAgICAgICBib29sIHVjbGtfc3dpdGNoaW5nX2Rpc2FibGVkID0NCisgICAgICAgICAgICAgICAg
ICAgICAgIChib29sKWh3bWdyLT5kaXNwbGF5X2NvbmZpZy0+bmJfcHN0YXRlX3N3aXRjaF9kaXNh
YmxlOw0KDQogICAgICAgICBpZiAoKGh3bWdyLT5kaXNwbGF5X2NvbmZpZy0+bnVtX2Rpc3BsYXkg
PiAxKSAmJg0KLSAgICAgICAgICAgICAgICFod21nci0+ZGlzcGxheV9jb25maWctPm11bHRpX21v
bml0b3JfaW5fc3luYykNCisgICAgICAgICAgICAhaHdtZ3ItPmRpc3BsYXlfY29uZmlnLT5tdWx0
aV9tb25pdG9yX2luX3N5bmMgJiYNCisgICAgICAgICAgICAhdWNsa19zd2l0Y2hpbmdfZGlzYWJs
ZWQpDQogICAgICAgICAgICAgICAgIHZlZ2ExMl9ub3RpZnlfc21jX2Rpc3BsYXlfY2hhbmdlKGh3
bWdyLCBmYWxzZSk7DQogICAgICAgICBlbHNlDQogICAgICAgICAgICAgICAgIHZlZ2ExMl9ub3Rp
Znlfc21jX2Rpc3BsYXlfY2hhbmdlKGh3bWdyLCB0cnVlKTsNCi0tDQoyLjE4LjANCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGlu
ZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc+DQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngNCmFtZC1nZnggSW5mbyBQYWdlIC0gZnJlZWRlc2t0b3Aub3JnPGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeD4NCmxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KU3Vic2NyaWJpbmcgdG8gYW1kLWdmeDogU3Vic2NyaWJlIHRv
IGFtZC1nZnggYnkgZmlsbGluZyBvdXQgdGhlIGZvbGxvd2luZyBmb3JtLiBVc2Ugb2YgYWxsIGZy
ZWVkZXNrdG9wLm9yZyBsaXN0cyBpcyBzdWJqZWN0IHRvIG91ciBDb2RlIG9mIENvbmR1Y3QuDQoN
Cg0K

--_000_SN6PR12MB265672B224B5B1CB2BC15DEEE4560SN6PR12MB2656namp_
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
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"Segoe UI Light";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
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
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Sent out the revised pat=
ch.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Regards,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Evan<o:p></o:p></span></=
p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Zhu, Rex
<br>
<b>Sent:</b> Friday, July 20, 2018 6:08 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/powerplay: disallow slow switch if =
NBPState is disabled<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">H=
i Evan</span><span lang=3D"JA" style=3D"color:black">=A3=AC</span><span sty=
le=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><o:p></o:p></=
span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">C=
hanging the title to
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif;color:black">&quot;Only allow slow switch</span><span style=3D"font-=
family:&quot;Calibri&quot;,sans-serif;color:black"> if NB pstate switch is =
enabled&quot;&nbsp;&nbsp; can make patch more<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">u=
nderstandable.<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
br>
<br>
<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">B=
est Regards<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">R=
ex<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span><=
/p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gf=
x &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Zhu, Rex &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu@amd.c=
om</a>&gt;<br>
<b>Sent:</b> Friday, July 20, 2018 4:43 PM<br>
<b>To:</b> Quan, Evan; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/powerplay: disallow slow switch if =
NBPState is disabled</span><span style=3D"font-family:&quot;Calibri&quot;,s=
ans-serif;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if;color:black">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool uclk_switchi=
ng_disabled =3D<br>
&#43;(bool)hwmgr-&gt;display_config-&gt;nb_pstate_switch_disable;</span><sp=
an style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><o:p></=
o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">D=
on't need type convert.<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">B=
est Regards<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">R=
ex<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span><=
/p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gf=
x &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan@=
amd.com</a>&gt;<br>
<b>Sent:</b> Friday, July 20, 2018 10:35 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Quan, Evan; Zhu, Rex<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/powerplay: disallow slow switch if NBPS=
tate is disabled</span><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Otherwise there may be potential SMU pe=
rformance issues.<br>
<br>
Change-Id: I05a09bb05407f7b3705d79a1d2c6628385c80461<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 5 &#43;&#43;&#43=
;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 5 &#43;&#43;&#43=
;&#43;-<br>
&nbsp;2 files changed, 8 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 002ed77a5268..ccb587607b03 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -3779,9 &#43;3779,12 @@ static int vega10_notify_smc_display_config_afte=
r_ps_adjustment(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_Clocks min_clock=
s =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_display_clock_re=
quest clock_req;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool uclk_switching_disabled =3D<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bool)hwmgr-=
&gt;display_config-&gt;nb_pstate_switch_disable;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((hwmgr-&gt;display_con=
fig-&gt;num_display &gt; 1) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !hwmgr-=
&gt;display_config-&gt;multi_monitor_in_sync)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !hw=
mgr-&gt;display_config-&gt;multi_monitor_in_sync &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !uc=
lk_switching_disabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega10_notify_smc_display_change(hwmgr, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega10_notify_smc_display_change(hwmgr, true);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
index 35f96dacb50a..e3b11ae8fdb8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
@@ -1387,9 &#43;1387,12 @@ static int vega12_notify_smc_display_config_afte=
r_ps_adjustment(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (stru=
ct vega12_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_Clocks min_clock=
s =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_display_clock_re=
quest clock_req;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool uclk_switching_disabled =3D<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bool)hwmgr-=
&gt;display_config-&gt;nb_pstate_switch_disable;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((hwmgr-&gt;display_con=
fig-&gt;num_display &gt; 1) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; !hwmgr-&gt;display_config-&gt;multi_monitor_in_sync)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !hw=
mgr-&gt;display_config-&gt;multi_monitor_in_sync &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !uc=
lk_switching_disabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega12_notify_smc_display_change(hwmgr, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega12_notify_smc_display_change(hwmgr, true);<br>
-- <br>
2.18.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<o:p></o:p></span></p>
<div style=3D"margin-bottom:15.0pt;overflow:auto" id=3D"LPBorder_GT_1532076=
0932520.07807509508203059">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"90%" style=3D"width:90.0%;background:white;border-top:dotte=
d #C8C8C8 1.0pt;border-left:none;border-bottom:dotted #C8C8C8 1.0pt;border-=
right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none;padding:0in 0in 0in 0in">
<div id=3D"LPTitle_15320760932460.8893094785459864">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;mso-line-height-alt:15.75=
pt"><span style=3D"font-size:16.0pt;font-family:&quot;Segoe UI Light&quot;,=
sans-serif;color:#0078D7"><a href=3D"https://lists.freedesktop.org/mailman/=
listinfo/amd-gfx" target=3D"_blank"><span style=3D"text-decoration:none">am=
d-gfx
 Info Page - freedesktop.org</span></a><o:p></o:p></span></p>
</div>
<div style=3D"margin-top:7.5pt;margin-bottom:12.0pt" id=3D"LPMetadata_15320=
760932520.4922178239396222">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:10.5pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;colo=
r:#666666">lists.freedesktop.org<o:p></o:p></span></p>
</div>
<div id=3D"LPDescription_15320760932520.6953170574068477">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:15.0pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;colo=
r:#666666">Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the =
following form. Use of all freedesktop.org lists
 is subject to our Code of Conduct.<o:p></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SN6PR12MB265672B224B5B1CB2BC15DEEE4560SN6PR12MB2656namp_--

--===============0166487513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0166487513==--
