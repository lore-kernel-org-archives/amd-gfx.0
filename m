From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/3] drm/amdgpu/sriov:now must reinit psp
Date: Fri, 20 Oct 2017 03:16:42 +0000
Message-ID: <BLUPR12MB0449D044CFC99E4C7ED213FB84430@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1508320755-12780-1-git-send-email-Monk.Liu@amd.com>
 <BLUPR12MB0449CD19152E8028C929046C844D0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BLUPR12MB0449FA5C8FBFD57B503572CB84430@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BN6PR12MB16528DBE63824A591EC35C5FF7430@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2094674938=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16528DBE63824A591EC35C5FF7430-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2094674938==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB0449D044CFC99E4C7ED213FB84430BLUPR12MB0449namp_"

--_000_BLUPR12MB0449D044CFC99E4C7ED213FB84430BLUPR12MB0449namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhhbmtzLA0KDQphbHJlYWR5IGFkZHJlc3NlZCBhY2NvcmRpbmdseQ0KDQpGcm9tOiBEZXVjaGVy
LCBBbGV4YW5kZXINClNlbnQ6IDIwMTfE6jEw1MIyMMjVIDEwOjU2DQpUbzogTGl1LCBNb25rIDxN
b25rLkxpdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6
IFJFOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1L3NyaW92Om5vdyBtdXN0IHJlaW5pdCBwc3ANCg0K
SSBmb2xsb3dlZCB1cCBvbiBhbGwgb2YgdGhlc2UuDQoNCkFsZXgNCg0KRnJvbTogYW1kLWdmeCBb
bWFpbHRvOmFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmddIE9uIEJlaGFsZiBP
ZiBMaXUsIE1vbmsNClNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE5LCAyMDE3IDEwOjUwIFBNDQpU
bzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8bWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPg0KU3ViamVjdDogUkU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHUvc3Jpb3Y6
bm93IG11c3QgcmVpbml0IHBzcA0KDQpJZiBubyBvbmUgcmV2aWV3IEmhr2xsIHN1Ym1pdCBpdCBz
b29uDQoNCkZyb206IGFtZC1nZnggW21haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnXSBPbiBCZWhhbGYgT2YgTGl1LCBNb25rDQpTZW50OiAyMDE3xOoxMNTCMTjI1SAx
ODoxMQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbTxtYWlsdG86QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4+OyBLb2VuaWcsIENo
cmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPG1haWx0bzpDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+Pg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHUvc3Jpb3Y6bm93
IG11c3QgcmVpbml0IHBzcA0KDQoNCmNhbiB5b3UgaGVscCByZXZpZXcgdGhvc2UgdGhyZWUgcGF0
Y2hlcyA/DQoNCg0KDQoxLzMgbm93IG11c3QgcmVpbml0IHBzcA0KDQoyLzMgZml4IHZmX2Vycm9y
X3B1dA0KDQozLzMgZml4IHdiX2NsZWFyDQoNCg0KDQp0aGUgZmlyc3QgdHdvIGFyZSBvbmx5IFNS
SU9WIGFmZmVjdGVkLCBhdCBsZWFzdCBzb21lIG9uZSBnaXZlIG1lIGFuIEFDSy1ieQ0KDQoNCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IGFtZC1nZnggPGFtZC1nZngt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc8bWFpbHRvOmFtZC1nZngtYm91bmNlc0BsaXN0
cy5mcmVlZGVza3RvcC5vcmc+PiBvbiBiZWhhbGYgb2YgTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5j
b208bWFpbHRvOk1vbmsuTGl1QGFtZC5jb20+Pg0KU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDE4
LCAyMDE3IDU6NTk6MTMgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWls
dG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpDYzogTGl1LCBNb25rDQpTdWJqZWN0
OiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1L3NyaW92Om5vdyBtdXN0IHJlaW5pdCBwc3ANCg0Kb3Ro
ZXJ3aXNlIGFmdGVyIFZGIEZMUiB0aGUgS0lRIGNhbm5vdCB3b3JrDQoNCkNoYW5nZS1JZDogSWNi
MThlNzk0YjVlNGRjY2ZkNzBjODExYzEzOGM3MTAyZGY4NzQyMDMNClNpZ25lZC1vZmYtYnk6IE1v
bmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPG1haWx0bzpNb25rLkxpdUBhbWQuY29tPj4NCi0tLQ0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDEgKw0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQppbmRleCAwYTBlYmMwLi44MzU0YWY2IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCkBAIC0xOTU2LDYgKzE5NTYsNyBAQCBz
dGF0aWMgaW50IGFtZGdwdV9zcmlvdl9yZWluaXRfbGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikNCg0KICAgICAgICAgc3RhdGljIGVudW0gYW1kX2lwX2Jsb2NrX3R5cGUgaXBfb3JkZXJb
XSA9IHsNCiAgICAgICAgICAgICAgICAgQU1EX0lQX0JMT0NLX1RZUEVfU01DLA0KKyAgICAgICAg
ICAgICAgIEFNRF9JUF9CTE9DS19UWVBFX1BTUCwNCiAgICAgICAgICAgICAgICAgQU1EX0lQX0JM
T0NLX1RZUEVfRENFLA0KICAgICAgICAgICAgICAgICBBTURfSVBfQkxPQ0tfVFlQRV9HRlgsDQog
ICAgICAgICAgICAgICAgIEFNRF9JUF9CTE9DS19UWVBFX1NETUEsDQotLQ0KMi43LjQNCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFp
bGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc+DQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngNCg==

--_000_BLUPR12MB0449D044CFC99E4C7ED213FB84430BLUPR12MB0449namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
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
	{font-family:SimSun;
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@MS PGothic";}
@font-face
	{font-family:"Microsoft YaHei";}
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
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-style-priority:99;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma",sans-serif;
	mso-fareast-language:ZH-CN;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	mso-style-priority:99;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:1.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:DengXian;
	color:windowtext;}
span.EmailStyle23
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle25
	{mso-style-type:personal-reply;
	font-family:DengXian;
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
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Thanks,
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">already addressed accordingly
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"mso-fareast-languag=
e:JA">From:</span></b><span lang=3D"EN-US" style=3D"mso-fareast-language:JA=
"> Deucher, Alexander
<br>
<b>Sent:</b> 2017</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGo=
thic&quot;,sans-serif;mso-fareast-language:JA">=C4=EA</span><span lang=3D"E=
N-US" style=3D"mso-fareast-language:JA">10</span><span lang=3D"JA" style=3D=
"font-family:&quot;MS PGothic&quot;,sans-serif;mso-fareast-language:JA">=D4=
=C2</span><span lang=3D"EN-US" style=3D"mso-fareast-language:JA">20</span><=
span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso=
-fareast-language:JA">=C8=D5</span><span lang=3D"EN-US" style=3D"mso-fareas=
t-language:JA">
 10:56<br>
<b>To:</b> Liu, Monk &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g<br>
<b>Subject:</b> RE: [PATCH 1/3] drm/amdgpu/sriov:now must reinit psp<o:p></=
o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">I follo=
wed up on all of these.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Alex<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,sans-serif">From:</span></b><span lang=3D"EN-U=
S" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,sans-serif"> am=
d-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-=
gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
<b>On Behalf Of </b>Liu, Monk<br>
<b>Sent:</b> Thursday, October 19, 2017 10:50 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> RE: [PATCH 1/3] drm/amdgpu/sriov:now must reinit psp<o:p></=
o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">If no one review I</span><span style=3D"font-size:10.5pt;f=
ont-family:DengXian">=A1=AF<span lang=3D"EN-US">ll submit it soon
</span></span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">&nbsp;</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
<b>On Behalf Of </b>Liu, Monk<br>
<b>Sent:</b> 2017</span><span style=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=
=BA=DA&quot;,sans-serif">=C4=EA</span><span lang=3D"EN-US">10</span><span s=
tyle=3D"font-family:&quot;=CE=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif">=D4=C2=
</span><span lang=3D"EN-US">18</span><span style=3D"font-family:&quot;=CE=
=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif">=C8=D5</span><span lang=3D"EN-US"> =
18:11<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a>; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deuc=
her-5C7GfCeVMHo@public.gmane.org">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;; Koenig, Christian &lt;<a hr=
ef=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amdgpu/sriov:now must reinit psp<o:p></=
o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<div>
<div id=3D"x_divtagdefaultwrapper">
<p><span lang=3D"EN-US" style=3D"color:black">can you help review those thr=
ee patches ?</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p><span lang=3D"EN-US" style=3D"color:black">&nbsp;</span><span lang=3D"EN=
-US"><o:p></o:p></span></p>
<p><span lang=3D"EN-US" style=3D"color:black">1/3 now must reinit psp</span=
><span lang=3D"EN-US"><o:p></o:p></span></p>
<p><span lang=3D"EN-US" style=3D"color:black">2/3 fix vf_error_put</span><s=
pan lang=3D"EN-US"><o:p></o:p></span></p>
<p><span lang=3D"EN-US" style=3D"color:black">3/3 fix wb_clear</span><span =
lang=3D"EN-US"><o:p></o:p></span></p>
<p><span lang=3D"EN-US" style=3D"color:black">&nbsp;</span><span lang=3D"EN=
-US"><o:p></o:p></span></p>
<p><span lang=3D"EN-US" style=3D"color:black">the first two are only SRIOV =
affected, at least some one give me an ACK-by</span><span lang=3D"EN-US"><o=
:p></o:p></span></p>
<p><span lang=3D"EN-US" style=3D"color:black">&nbsp;</span><span lang=3D"EN=
-US"><o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 lang=3D"EN-US">
<hr size=3D"3" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"color:black">From:<=
/span></b><span lang=3D"EN-US" style=3D"color:black"> amd-gfx &lt;<a href=
=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a>&gt; on behalf of Monk Liu &lt;<a href=3D"mailto:Monk.Liu@a=
md.com">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Wednesday, October 18, 2017 5:59:13 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Liu, Monk<br>
<b>Subject:</b> [PATCH 1/3] drm/amdgpu/sriov:now must reinit psp</span><spa=
n lang=3D"EN-US">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt">othe=
rwise after VF FLR the KIQ cannot work<br>
<br>
Change-Id: Icb18e794b5e4dccfd70c811c138c7102df874203<br>
Signed-off-by: Monk Liu &lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">Monk.Liu@am=
d.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 0a0ebc0..8354af6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1956,6 &#43;1956,7 @@ static int amdgpu_sriov_reinit_late(struct amdgpu=
_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static enum amd_ip_block_t=
ype ip_order[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_SMC,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_PSP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_DCE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_GFX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_SDMA,<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></span><span lang=3D"EN-U=
S"><o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BLUPR12MB0449D044CFC99E4C7ED213FB84430BLUPR12MB0449namp_--

--===============2094674938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2094674938==--
