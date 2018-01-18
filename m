From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: Fix smu_table_entry.handle type
Date: Thu, 18 Jan 2018 03:11:57 +0000
Message-ID: <CY4PR12MB16873431BA294A4B26BA7E4DFBE80@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1516228529-14571-1-git-send-email-andrey.grodzovsky@amd.com>
 <CY4PR12MB1653C2E1B728B5CBA10EE68BF7E90@CY4PR12MB1653.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1255908652=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1653C2E1B728B5CBA10EE68BF7E90-rpdhrqHFk06apTa93KjAaQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>

--===============1255908652==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16873431BA294A4B26BA7E4DFBE80CY4PR12MB1687namp_"

--_000_CY4PR12MB16873431BA294A4B26BA7E4DFBE80CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Best Regards
Rex
From: Deucher, Alexander
Sent: Thursday, January 18, 2018 7:11 AM
To: Grodzovsky, Andrey; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Lipski, Mikita; Zhu, Rex
Subject: Re: [PATCH] drm/amd/powerplay: Fix smu_table_entry.handle type


Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deuch=
er-5C7GfCeVMHo@public.gmane.org>>

________________________________
From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org<mailto:andrey.grodzovsky=
@amd.com>>
Sent: Wednesday, January 17, 2018 5:35 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Lipski, Mikita; Zhu, Rex; Deucher, Alexander; Grodzovsky, Andrey
Subject: [PATCH] drm/amd/powerplay: Fix smu_table_entry.handle type

Handle describes kernel logical address, should be unsigned long and not ui=
nt32_t.
Fixes KASAN error and GFP on driver unload.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org<mailto:andrey.g=
rodzovsky-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h b/drivers/gpu=
/drm/amd/powerplay/smumgr/rv_smumgr.h
index 5888840..caebdbe 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h
@@ -40,7 +40,7 @@ struct smu_table_entry {
         uint32_t table_addr_high;
         uint32_t table_addr_low;
         uint8_t *table;
-       uint32_t handle;
+       unsigned long handle;
 };

 struct smu_table_array {
--
2.7.4

--_000_CY4PR12MB16873431BA294A4B26BA7E4DFBE80CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Times New Roman","serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:SimSun;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
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
<p><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;;color:black">Reviewed-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</spa=
n><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&=
quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Best Regar=
ds<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Rex<o:p></=
o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&qu=
ot;sans-serif&quot;"> Deucher, Alexander
<br>
<b>Sent:</b> Thursday, January 18, 2018 7:11 AM<br>
<b>To:</b> Grodzovsky, Andrey; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Lipski, Mikita; Zhu, Rex<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: Fix smu_table_entry.handle t=
ype<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<div id=3D"divtagdefaultwrapper">
<p><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;;color:black">Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:a=
lexander.deucher-5C7GfCeVMHo@public.gmane.org">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></spa=
n></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&q=
uot;;color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</sp=
an></b><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,&quot;sans-serif&quot;;color:black"> Andrey Grodzovsky &lt;<a hr=
ef=3D"mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org</a>&gt;<b=
r>
<b>Sent:</b> Wednesday, January 17, 2018 5:35 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Lipski, Mikita; Zhu, Rex; Deucher, Alexander; Grodzovsky, Andrey=
<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: Fix smu_table_entry.handle type<=
/span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,&quot;s=
ans-serif&quot;;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:black">Handle describes kernel logical address, should be unsig=
ned long and not uint32_t.<br>
Fixes KASAN error and GFP on driver unload.<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;<a href=3D"mailto:andrey.grodzovsky@am=
d.com">andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h b/drivers/gpu=
/drm/amd/powerplay/smumgr/rv_smumgr.h<br>
index 5888840..caebdbe 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h<br>
@@ -40,7 &#43;40,7 @@ struct smu_table_entry {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t table_addr_high;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t table_addr_low;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t handle;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long handle;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct smu_table_array {<br>
-- <br>
2.7.4<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16873431BA294A4B26BA7E4DFBE80CY4PR12MB1687namp_--

--===============1255908652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1255908652==--
