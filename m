From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [Patch] drm/amdgpu: fix CPDMA hang in PRT mode for VEGA10
Date: Wed, 11 Sep 2019 02:09:47 +0000
Message-ID: <DM5PR12MB2535330973BC7ABB4C30439F95B10@DM5PR12MB2535.namprd12.prod.outlook.com>
References: <DM5PR12MB2535E7983EAD797B4349F96995B60@DM5PR12MB2535.namprd12.prod.outlook.com>,
 <MN2PR12MB30544FD3CC5E6B46216E6EF4B0B60@MN2PR12MB3054.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2135689028=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB30544FD3CC5E6B46216E6EF4B0B60-rweVpJHSKTqnT25eLM+iUQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Long, Gang" <Gang.Long-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============2135689028==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB2535330973BC7ABB4C30439F95B10DM5PR12MB2535namp_"

--_000_DM5PR12MB2535330973BC7ABB4C30439F95B10DM5PR12MB2535namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhhbmtzIFRhbyENCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBaaG91
MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxMCwg
MjAxOSAxODoyNA0KVG86IFlpbiwgVGlhbmNpIChSaWNvKSA8VGlhbmNpLllpbkBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPg0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBYdSwgRmVp
ZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IExvbmcsIEdhbmcgPEdhbmcuTG9uZ0BhbWQuY29tPg0K
U3ViamVjdDogUkU6IFtQYXRjaF0gZHJtL2FtZGdwdTogZml4IENQRE1BIGhhbmcgaW4gUFJUIG1v
ZGUgZm9yIFZFR0ExMA0KDQoNClJldmlld2VkLWJ5OiBUYW8gWmhvdSA8dGFvLnpob3UxQGFtZC5j
b208bWFpbHRvOnRhby56aG91MUBhbWQuY29tPj4NCg0KDQoNCkZyb206IFlpbiwgVGlhbmNpIChS
aWNvKSA8VGlhbmNpLllpbkBhbWQuY29tPg0KU2VudDogMjAxOcTqOdTCMTDI1SAxNjo1OQ0KVG86
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgWHUsIEZl
aWZlaSA8RmVpZmVpLlh1QGFtZC5jb20+OyBMb25nLCBHYW5nIDxHYW5nLkxvbmdAYW1kLmNvbT4N
ClN1YmplY3Q6IFtQYXRjaF0gZHJtL2FtZGdwdTogZml4IENQRE1BIGhhbmcgaW4gUFJUIG1vZGUg
Zm9yIFZFR0ExMA0KDQoNCg0KDQo=

--_000_DM5PR12MB2535330973BC7ABB4C30439F95B10DM5PR12MB2535namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks Tao!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhou1, Tao &lt;Tao.Zh=
ou1-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, September 10, 2019 18:24<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Xu, Feifei &lt;Fei=
fei.Xu-5C7GfCeVMHo@public.gmane.org&gt;; Long, Gang &lt;Gang.Long-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [Patch] drm/amdgpu: fix CPDMA hang in PRT mode for VEGA=
10</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:"Microsoft YaHei"}
@font-face
	{font-family:"Microsoft YaHei"}
@font-face
	{font-family:DengXian}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:#954F72;
	text-decoration:underline}
p.x_MsoPlainText, li.x_MsoPlainText, div.x_MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
p.x_msonormal0, li.x_msonormal0, div.x_msonormal0
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle19
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.x_PlainTextChar
	{font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:72.0pt 90.0pt 72.0pt 90.0pt}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoPlainText">Reviewed-by: Tao Zhou &lt;<a href=3D"mailto:tao=
.zhou1-5C7GfCeVMHo@public.gmane.org">tao.zhou1-5C7GfCeVMHo@public.gmane.org</a>&gt;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0cm 0cm 0c=
m 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0c=
m 0cm 0cm">
<p class=3D"x_MsoNormal"><b>From:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd=
.com&gt; <br>
<b>Sent:</b> 2019<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=
=ED=D1=C5=BA=DA&quot;,sans-serif">=C4=EA</span>9<span lang=3D"ZH-CN" style=
=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif">=D4=C2</sp=
an>10<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,sans-serif">=C8=D5</span> 16:59<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Zhou1, Tao &lt;Tao=
.Zhou1-5C7GfCeVMHo@public.gmane.org&gt;; Xu, Feifei &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;; Long, Gang &lt;Ga=
ng.Long-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [Patch] drm/amdgpu: fix CPDMA hang in PRT mode for VEGA10</=
p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB2535330973BC7ABB4C30439F95B10DM5PR12MB2535namp_--

--===============2135689028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2135689028==--
