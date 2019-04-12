From: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH libdrm] amdgpu: Fix a structure initialization issue
Date: Fri, 12 Apr 2019 05:40:54 +0000
Message-ID: <SN6PR12MB28003EABE4DE5A814451328887280@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <SN6PR12MB280062745177BDAC40F69C49872F0@SN6PR12MB2800.namprd12.prod.outlook.com>,
 <BYAPR12MB2632F243319B7C06B6937452FC2F0@BYAPR12MB2632.namprd12.prod.outlook.com>
 <BN6PR12MB1809D1208D55E160E66BEE41F72F0@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1652890332=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809D1208D55E160E66BEE41F72F0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1652890332==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB28003EABE4DE5A814451328887280SN6PR12MB2800namp_"

--_000_SN6PR12MB28003EABE4DE5A814451328887280SN6PR12MB2800namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhhbmtzLg0KQWZ0ZXIgZ29vZ2xpbmcgaXQsIHRoZSBiZWhhdmlvciBvZiB7MH0gb24gbG9jYWwg
dmFyaWFibGUgZGVwZW5kcyBvbiBjb21waWxlci4NCg0KDQpGcm9tOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTZW50OiAyMDE5xOo01MIxMcjVIDIyOjE2
DQpUbzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFBhbiwgWGluaHVp
IDxYaW5odWkuUGFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3Vi
amVjdDogUmU6IFtQQVRDSCBsaWJkcm1dIGFtZGdwdTogRml4IGEgc3RydWN0dXJlIGluaXRpYWxp
emF0aW9uIGlzc3VlDQoNClBsZWFzZSB1c2UgbWVtc2V0IHJhdGhlciB0aGFuIHswfS4gIEFwcGFy
ZW50bHkgc29tZSBjb21waWxlcnMgZG9uJ3QgbGlrZSB0aGF0Lg0KDQpBbGV4DQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogWmhhbmcsIEhhd2tpbmcNClNlbnQ6IFRodXJz
ZGF5LCBBcHJpbCAxMSwgMjAxOSA5OjI0IEFNDQpUbzogUGFuLCBYaW5odWk7IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4N
CkNjOiBEZXVjaGVyLCBBbGV4YW5kZXINClN1YmplY3Q6IFJFOiBbUEFUQ0ggbGliZHJtXSBhbWRn
cHU6IEZpeCBhIHN0cnVjdHVyZSBpbml0aWFsaXphdGlvbiBpc3N1ZQ0KDQpSZXZpZXdlZC1ieTog
SGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPG1haWx0bzpIYXdraW5nLlpoYW5n
QGFtZC5jb20+Pg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc8
bWFpbHRvOmFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+PiBPbiBCZWhhbGYg
T2YgUGFuLCBYaW5odWkNClNlbnQ6IDIwMTnE6jTUwjExyNUgMTk6NDINClRvOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+
DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPG1haWx0
bzpBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPj4NClN1YmplY3Q6IFtQQVRDSCBsaWJkcm1dIGFt
ZGdwdTogRml4IGEgc3RydWN0dXJlIGluaXRpYWxpemF0aW9uIGlzc3VlDQoNCnN0cnVjdCBkcm1Q
Y2lCdXNJbmZvIGhhcyBiZWVuIGFsaWduZWQgdG8gNiBieXRlcy4gU28gbWVtY21wIHdpbGwgYWNj
ZXNzIHRoZSBsYXN0IGJ5dGUgd2hpY2ggaXMgbm90IGluaXRpYWxpemVkLiBUaGF0IGNhdXNlcyB0
aGUgbG9va3VwIGZ1bmN0aW9uIGZhaWxzLg0KDQpTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4
aW5odWkucGFuQGFtZC5jb208bWFpbHRvOnhpbmh1aS5wYW5AYW1kLmNvbT4+DQotLS0NCiB0ZXN0
cy9hbWRncHUvcmFzX3Rlc3RzLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvcmFzX3Rlc3Rz
LmMgYi90ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMgaW5kZXggNjEyYWQxZDcuLmViZTc3NGZjIDEw
MDY0NA0KLS0tIGEvdGVzdHMvYW1kZ3B1L3Jhc190ZXN0cy5jDQorKysgYi90ZXN0cy9hbWRncHUv
cmFzX3Rlc3RzLmMNCkBAIC0xOTAsNyArMTkwLDcgQEAgc3RhdGljIGludCBhbWRncHVfcmFzX2xv
b2t1cF9pZChkcm1EZXZpY2VQdHIgZGV2aWNlKSAgew0KICAgICAgICAgY2hhciBwYXRoWzEwMjRd
Ow0KICAgICAgICAgY2hhciBzdHJbMTI4XTsNCi0gICAgICAgZHJtUGNpQnVzSW5mbyBpbmZvOw0K
KyAgICAgICBkcm1QY2lCdXNJbmZvIGluZm8gPSB7MH07DQogICAgICAgICBpbnQgaTsNCiAgICAg
ICAgIGludCByZXQ7DQoNCi0tDQoyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCg==

--_000_SN6PR12MB28003EABE4DE5A814451328887280SN6PR12MB2800namp_
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
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	margin:0cm;
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Thanks.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">After googling it, the b=
ehavior of {0} on local variable depends on compiler.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Alexand=
er.Deucher-5C7GfCeVMHo@public.gmane.org&gt;
<br>
<b>Sent:</b> 2019</span><span lang=3D"JA" style=3D"font-size:11.0pt">=C4=EA=
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif">4</span><span lang=3D"JA" style=3D"font-size:11.0pt">=D4=C2</span><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">=
11</span><span lang=3D"JA" style=3D"font-size:11.0pt">=C8=D5</span><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
 22:16<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Pan, Xinhui &lt;Xi=
nhui.Pan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH libdrm] amdgpu: Fix a structure initialization i=
ssue<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">Please use memset rather than {0}.&nbsp; Apparently some=
 compilers don't like that.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">Alex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Zhang,=
 Hawking<br>
<b>Sent:</b> Thursday, April 11, 2019 9:24 AM<br>
<b>To:</b> Pan, Xinhui; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> RE: [PATCH libdrm] amdgpu: Fix a structure initialization i=
ssue</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;<a href=3D"mailto:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org">Hawking.Zhang-5C7GfCeVMHo@public.gmane.org<=
/a>&gt;<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">=
amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; On Behalf Of Pan, Xinhui<br>
Sent: 2019<span lang=3D"JA">=C4=EA</span>4<span lang=3D"JA">=D4=C2</span>11=
<span lang=3D"JA">=C8=D5</span> 19:42<br>
To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Ale=
xander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Subject: [PATCH libdrm] amdgpu: Fix a structure initialization issue<br>
<br>
struct drmPciBusInfo has been aligned to 6 bytes. So memcmp will access the=
 last byte which is not initialized. That causes the lookup function fails.=
<br>
<br>
Signed-off-by: xinhui pan &lt;<a href=3D"mailto:xinhui.pan-5C7GfCeVMHo@public.gmane.org">xinhui.=
pan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;tests/amdgpu/ras_tests.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/tests/amdgpu/ras_tests.c b/tests/amdgpu/ras_tests.c index 612a=
d1d7..ebe774fc 100644<br>
--- a/tests/amdgpu/ras_tests.c<br>
&#43;&#43;&#43; b/tests/amdgpu/ras_tests.c<br>
@@ -190,7 &#43;190,7 @@ static int amdgpu_ras_lookup_id(drmDevicePtr device=
)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char path[1024];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char str[128];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmPciBusInfo info;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmPciBusInfo info =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
--<br>
2.17.1<br>
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
</body>
</html>

--_000_SN6PR12MB28003EABE4DE5A814451328887280SN6PR12MB2800namp_--

--===============1652890332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1652890332==--
