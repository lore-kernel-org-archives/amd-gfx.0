From: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [Patch] drm/amdgpu: fix CPDMA hang in PRT mode for VEGA10
Date: Tue, 10 Sep 2019 10:24:49 +0000
Message-ID: <MN2PR12MB30544FD3CC5E6B46216E6EF4B0B60@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <DM5PR12MB2535E7983EAD797B4349F96995B60@DM5PR12MB2535.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1083068883=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB2535E7983EAD797B4349F96995B60-2J9CzHegvk+FJzKNz6G7XAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Long, Gang" <Gang.Long-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1083068883==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30544FD3CC5E6B46216E6EF4B0B60MN2PR12MB3054namp_"

--_000_MN2PR12MB30544FD3CC5E6B46216E6EF4B0B60MN2PR12MB3054namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

UmV2aWV3ZWQtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbTxtYWlsdG86dGFvLnpob3Ux
QGFtZC5jb20+Pg0KDQpGcm9tOiBZaW4sIFRpYW5jaSAoUmljbykgPFRpYW5jaS5ZaW5AYW1kLmNv
bT4NClNlbnQ6IDIwMTnE6jnUwjEwyNUgMTY6NTkNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91
MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29t
PjsgTG9uZywgR2FuZyA8R2FuZy5Mb25nQGFtZC5jb20+DQpTdWJqZWN0OiBbUGF0Y2hdIGRybS9h
bWRncHU6IGZpeCBDUERNQSBoYW5nIGluIFBSVCBtb2RlIGZvciBWRUdBMTANCg0KDQo=

--_000_MN2PR12MB30544FD3CC5E6B46216E6EF4B0B60MN2PR12MB3054namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
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
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"Microsoft YaHei";}
@font-face
	{font-family:DengXian;
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Reviewed-by: Tao Zhou &lt;<a href=3D"mailto:tao.z=
hou1-5C7GfCeVMHo@public.gmane.org">tao.zhou1-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.c=
om&gt; <br>
<b>Sent:</b> 2019<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=
=ED=D1=C5=BA=DA&quot;,sans-serif">=C4=EA</span>9<span lang=3D"ZH-CN" style=
=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif">=D4=C2</sp=
an>10<span lang=3D"ZH-CN" style=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=
=DA&quot;,sans-serif">=C8=D5</span> 16:59<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Zhou1, Tao &lt;Tao=
.Zhou1-5C7GfCeVMHo@public.gmane.org&gt;; Xu, Feifei &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;; Long, Gang &lt;Ga=
ng.Long-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [Patch] drm/amdgpu: fix CPDMA hang in PRT mode for VEGA10<o=
:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB30544FD3CC5E6B46216E6EF4B0B60MN2PR12MB3054namp_--

--===============1083068883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1083068883==--
