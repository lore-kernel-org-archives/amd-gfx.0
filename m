From: "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/2] drm/amd/powerplay: Add UMD PState Renoir Msg
 Parameters
Date: Wed, 4 Sep 2019 08:56:22 +0000
Message-ID: <MN2PR12MB35369B63693643B38A9F0669FBB80@MN2PR12MB3536.namprd12.prod.outlook.com>
References: <1567576882-13685-1-git-send-email-Prike.Liang@amd.com>
 <MN2PR12MB3296B324AFCAABE3E7E63ECEA2B80@MN2PR12MB3296.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1092164130=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3296B324AFCAABE3E7E63ECEA2B80-rweVpJHSKTqAm9ToKNQgFgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============1092164130==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB35369B63693643B38A9F0669FBB80MN2PR12MB3536namp_"

--_000_MN2PR12MB35369B63693643B38A9F0669FBB80MN2PR12MB3536namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks review .

Initial thoughts use this patch for overall initializing the UMD_PSATET_* a=
ssignment and
some Pstate definitions are not used for patch#2. But combine those two pat=
ches also seems well.

Thanks,
Prike
From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, September 4, 2019 2:32 PM
To: Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: Add UMD PState Renoir Msg Param=
eters

i think it's better to merge these two patches into one patch.
after fixed: Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org<mailto:kevin1.wan=
g@amd.com>>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org<mai=
lto:Prike.Liang-5C7GfCeVMHo@public.gmane.org>>
Sent: Wednesday, September 4, 2019 2:01 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deucher@=
amd.com>>; Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org<mailto:Prike.Liang-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH 1/2] drm/amd/powerplay: Add UMD PState Renoir Msg Parameter=
s

Add UMD PState macro definition for PState update.

Signed-off-by: Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org<mailto:Prike.Liang-5C7GfCeVMHo@public.gmane.org>=
>
reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:evan.quan-5C7GfCeVMHo@public.gmane.org>>
[Kevin]: change "reviewed-by" to "Reviewed-by"
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.h
index e9b7237..a017a47 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
@@ -25,4 +25,9 @@

 extern void renoir_set_ppt_funcs(struct smu_context *smu);

+//UMD PState Renoir Msg Parameters in MHz
+#define RENOIR_UMD_PSTATE_GFXCLK       700
+#define RENOIR_UMD_PSTATE_SOCCLK       678
+#define RENOIR_UMD_PSTATE_FCLK         800
+
 #endif
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB35369B63693643B38A9F0669FBB80MN2PR12MB3536namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
<p class=3D"MsoNormal">Thanks review . <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Initial thoughts use this patch for overall initiali=
zing the UMD_PSATET_* assignment and
<o:p></o:p></p>
<p class=3D"MsoNormal">some Pstate definitions are not used for patch#2. Bu=
t combine those two patches also seems well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Prike<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt; <br>
<b>Sent:</b> Wednesday, September 4, 2019 2:32 PM<br>
<b>To:</b> Liang, Prike &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/powerplay: Add UMD PState Renoir Ms=
g Parameters<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">i think=
 it's better to merge these two patches into one patch.<o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">after f=
ixed: Reviewed-by: Kevin Wang &lt;<a href=3D"mailto:kevin1.wang-5C7GfCeVMHo@public.gmane.org">ke=
vin1.wang-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Best Re=
gards,<br>
Kevin<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Liang, Prike &lt;<a href=3D"mailto:Prike.Liang-5C7GfCeVMHo@public.gmane.org">Prike.Liang@amd.c=
om</a>&gt;<br>
<b>Sent:</b> Wednesday, September 4, 2019 2:01 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;; Liang, Prike &lt;<a href=3D"mailto:P=
rike.Liang-5C7GfCeVMHo@public.gmane.org">Prike.Liang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/powerplay: Add UMD PState Renoir Msg Pa=
rameters</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Add UMD PState macro definition for PState update.<b=
r>
<br>
Signed-off-by: Prike Liang &lt;<a href=3D"mailto:Prike.Liang-5C7GfCeVMHo@public.gmane.org">Prike=
.Liang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
reviewed-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan@a=
md.com</a>&gt;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><b><i>[Kevin]: change &quot;reviewed-by&quot; to &qu=
ot;Reviewed-by&quot;</i></b><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 5 &#43;&#43;&#43;&#43;&#=
43;<br>
&nbsp;1 file changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.h<br>
index e9b7237..a017a47 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h<br>
@@ -25,4 &#43;25,9 @@<br>
&nbsp;<br>
&nbsp;extern void renoir_set_ppt_funcs(struct smu_context *smu);<br>
&nbsp;<br>
&#43;//UMD PState Renoir Msg Parameters in MHz<br>
&#43;#define RENOIR_UMD_PSTATE_GFXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7=
00<br>
&#43;#define RENOIR_UMD_PSTATE_SOCCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6=
78<br>
&#43;#define RENOIR_UMD_PSTATE_FCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 800<br>
&#43;<br>
&nbsp;#endif<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB35369B63693643B38A9F0669FBB80MN2PR12MB3536namp_--

--===============1092164130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1092164130==--
