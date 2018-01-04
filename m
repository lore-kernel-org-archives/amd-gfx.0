From: "Tao, Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: fix memory leakage when reload
Date: Thu, 4 Jan 2018 02:49:00 +0000
Message-ID: <DM3PR1201MB104016D7ABE0405FF67C0305E51F0@DM3PR1201MB1040.namprd12.prod.outlook.com>
References: <1514776580-17052-1-git-send-email-yttao@amd.com>,
 <DM3PR1201MB1040AD31CDCD1F1ECA34329CE51E0@DM3PR1201MB1040.namprd12.prod.outlook.com>
 <BN6PR12MB1652DDD5B775B8D64A2E42E1F71E0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1118439499=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652DDD5B775B8D64A2E42E1F71E0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1118439499==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM3PR1201MB104016D7ABE0405FF67C0305E51F0DM3PR1201MB1040_"

--_000_DM3PR1201MB104016D7ABE0405FF67C0305E51F0DM3PR1201MB1040_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex

Thanks a lot. I got it.

Best Regards
Yintian Tao

From: Deucher, Alexander
Sent: Wednesday, January 03, 2018 10:32 PM
To: Tao, Yintian <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/powerplay: fix memory leakage when reload


Did you see my reply yesterday?  I reviewed it.  I also think we need to fi=
x up cz, rv, and vg10.

________________________________
From: Tao, Yintian
Sent: Tuesday, January 2, 2018 9:22:23 PM
To: Tao, Yintian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org>; Deucher, Alexander
Subject: RE: [PATCH] drm/amd/powerplay: fix memory leakage when reload

Add Alex

-----Original Message-----
From: Yintian Tao [mailto:yttao-5C7GfCeVMHo@public.gmane.org]
Sent: Monday, January 01, 2018 11:16 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Tao, Yintian <Yintian.Tao-5C7GfCeVMHo@public.gmane.org<mailto:Yintian.Tao-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH] drm/amd/powerplay: fix memory leakage when reload

add smu_free_memory when smu fini to prevent memory leakage

Change-Id: Id9103d8b54869b63f22a9af53d9fbc3b7a221191
Signed-off-by: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org<mailto:yttao-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index c49a6f2..925217e 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -607,6 +607,12 @@ int smu7_init(struct pp_smumgr *smumgr)

 int smu7_smu_fini(struct pp_smumgr *smumgr)  {
+       struct smu7_smumgr *smu_data =3D (struct smu7_smumgr
+*)(smumgr->backend);
+
+       smu_free_memory(smumgr->device, smu_data->header_buffer.handle);
+       if (!cgs_is_virtualization_enabled(smumgr->device))
+               smu_free_memory(smumgr->device, smu_data->smu_buffer.handle=
);
+
         if (smumgr->backend) {
                 kfree(smumgr->backend);
                 smumgr->backend =3D NULL;
--
2.7.4

--_000_DM3PR1201MB104016D7ABE0405FF67C0305E51F0DM3PR1201MB1040_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
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
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
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
libri&quot;,sans-serif;color:#1F497D">Hi Alex
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Thanks a lot. I got it.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Best Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Yintian Tao<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander
<br>
<b>Sent:</b> Wednesday, January 03, 2018 10:32 PM<br>
<b>To:</b> Tao, Yintian &lt;Yintian.Tao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: fix memory leakage when relo=
ad<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">D=
id you see my reply yesterday?&nbsp; I reviewed it.&nbsp; I also think we n=
eed to fix up cz, rv, and vg10.<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Tao, Y=
intian<br>
<b>Sent:</b> Tuesday, January 2, 2018 9:22:23 PM<br>
<b>To:</b> Tao, Yintian; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Deucher, Alexander<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: fix memory leakage when relo=
ad</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Add Alex<br>
<br>
-----Original Message-----<br>
From: Yintian Tao [<a href=3D"mailto:yttao-5C7GfCeVMHo@public.gmane.org">mailto:yttao-5C7GfCeVMHo@public.gmane.org</a=
>] <br>
Sent: Monday, January 01, 2018 11:16 AM<br>
To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org</a><br>
Cc: Tao, Yintian &lt;<a href=3D"mailto:Yintian.Tao-5C7GfCeVMHo@public.gmane.org">Yintian.Tao@amd=
.com</a>&gt;<br>
Subject: [PATCH] drm/amd/powerplay: fix memory leakage when reload<br>
<br>
add smu_free_memory when smu fini to prevent memory leakage<br>
<br>
Change-Id: Id9103d8b54869b63f22a9af53d9fbc3b7a221191<br>
Signed-off-by: Yintian Tao &lt;<a href=3D"mailto:yttao-5C7GfCeVMHo@public.gmane.org">yttao@amd.c=
om</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 6 &#43;&#43;&#43=
;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 6 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
index c49a6f2..925217e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
@@ -607,6 &#43;607,12 @@ int smu7_init(struct pp_smumgr *smumgr)<br>
&nbsp;<br>
&nbsp;int smu7_smu_fini(struct pp_smumgr *smumgr)&nbsp; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_smumgr *smu_data =3D =
(struct smu7_smumgr <br>
&#43;*)(smumgr-&gt;backend);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_free_memory(smumgr-&gt;device=
, smu_data-&gt;header_buffer.handle);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cgs_is_virtualization_enable=
d(smumgr-&gt;device))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_free_memory(smumgr-&gt;device, smu_data-&gt;smu_buffer.h=
andle);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smumgr-&gt;backend) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(smumgr-&gt;backend);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smumgr-&gt;backend =3D NULL;<br>
--<br>
2.7.4<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM3PR1201MB104016D7ABE0405FF67C0305E51F0DM3PR1201MB1040_--

--===============1118439499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1118439499==--
