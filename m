From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once on
 Stoney
Date: Fri, 26 Aug 2016 16:52:28 +0000
Message-ID: <MWHPR12MB1694C63CD7142919F461E5FFF7EC0@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <20160826164627.6734-1-tom.stdenis@amd.com>,
 <20160826164627.6734-4-tom.stdenis@amd.com>
 <DM5PR12MB1132C685592A9CB895B951A5F7EC0@DM5PR12MB1132.namprd12.prod.outlook.com>,
 <MWHPR12MB16943D4174366F50B3FF6E8BF7EC0@MWHPR12MB1694.namprd12.prod.outlook.com>
 <DM5PR12MB1132D8264821843420BD7640F7EC0@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1048744266=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1132D8264821843420BD7640F7EC0-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1048744266==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1694C63CD7142919F461E5FFF7EC0MWHPR12MB1694namp_"

--_000_MWHPR12MB1694C63CD7142919F461E5FFF7EC0MWHPR12MB1694namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sorry mi-read your email.

From: StDenis, Tom
Sent: Friday, August 26, 2016 12:50 PM
To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once on =
Stoney


Patch #3 is correct but missing the SDMA0 duplicate which I amended locally=
.  I only noticed it after I hit send.

________________________________
From: Deucher, Alexander
Sent: Friday, August 26, 2016 12:49
To: StDenis, Tom; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org>
Subject: RE: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once on =
Stoney


Wrong patch? ;)



From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of S=
tDenis, Tom
Sent: Friday, August 26, 2016 12:48 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once on =
Stoney



I swear this isn't intentional but I just realized that SDMA0 was loaded tw=
ice too only after hitting send-email.  I've amended my patch locally to av=
oid loading SDMA0 twice too..



Tom



________________________________

From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Friday, August 26, 2016 12:46
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: StDenis, Tom
Subject: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once on Ston=
ey



Only load the MEC1 firmware once in the Carrizo SMU manager
driver.

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org<mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org=
>>
---
 drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/cz_smumgr.c
index f51bd8de2f69..1529516089bc 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
@@ -574,10 +574,7 @@ static int cz_smu_construct_toc_for_bootup(struct pp_s=
mumgr *smumgr)
                                 CZ_SCRATCH_ENTRY_UCODE_ID_CP_ME, false);
         cz_smu_populate_single_ucode_load_task(smumgr,
                                 CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT1, fals=
e);
-       if (smumgr->chip_id =3D=3D CHIP_STONEY)
-               cz_smu_populate_single_ucode_load_task(smumgr,
-                               CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT1, false=
);
-       else
+       if (smumgr->chip_id !=3D CHIP_STONEY)
                 cz_smu_populate_single_ucode_load_task(smumgr,
                                 CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT2, fals=
e);
         cz_smu_populate_single_ucode_load_task(smumgr,
--
2.9.3

--_000_MWHPR12MB1694C63CD7142919F461E5FFF7EC0MWHPR12MB1694namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Sorry mi-read your email.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> StDenis,=
 Tom
<br>
<b>Sent:</b> Friday, August 26, 2016 12:50 PM<br>
<b>To:</b> Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware o=
nce on Stoney<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">Patch #3 is correct but missing the S=
DMA0 duplicate which I amended locally. &nbsp;I only noticed it after I hit=
 send.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;background:white"><spa=
n style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:bla=
ck"><o:p>&nbsp;</o:p></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color=
:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal" style=3D"background:white"><b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">From:</span></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibr=
i&quot;,&quot;sans-serif&quot;;color:black"> Deucher, Alexander<br>
<b>Sent:</b> Friday, August 26, 2016 12:49<br>
<b>To:</b> StDenis, Tom; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> RE: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware o=
nce on Stoney</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sa=
ns-serif&quot;;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbsp;<o:p></o:p>=
</span></p>
</div>
</div>
<div>
<div>
<p style=3D"background:white"><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Wrong patch? ;)</s=
pan><span style=3D"color:black"><o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;</span><span=
 style=3D"color:black"><o:p></o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p style=3D"background:white"><b><span style=3D"font-size:10.0pt;font-famil=
y:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><s=
pan style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-ser=
if&quot;;color:black"> amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
<b>On Behalf Of </b>StDenis, Tom<br>
<b>Sent:</b> Friday, August 26, 2016 12:48 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware o=
nce on Stoney</span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
</div>
<p style=3D"background:white"><span style=3D"color:black">&nbsp;<o:p></o:p>=
</span></p>
<div id=3D"divtagdefaultwrapper">
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">I swear this isn't intentional&nbsp;b=
ut I just realized that SDMA0 was loaded twice too only after hitting send-=
email. &nbsp;I've amended my patch locally to avoid loading SDMA0
 twice too..<o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">Tom<o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">&nbsp;</span><span style=3D"color:bla=
ck"><o:p></o:p></span></p>
<div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color=
:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p style=3D"background:white"><b><span style=3D"font-size:11.0pt;font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-s=
erif&quot;;color:black"> Tom St Denis &lt;<a href=3D"mailto:tstdenis82@gmai=
l.com">tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, August 26, 2016 12:46<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once =
on Stoney</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-s=
erif&quot;;color:black">
</span><span style=3D"color:black"><o:p></o:p></span></p>
<div>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">&nbsp;</span><span style=3D"color:bla=
ck"><o:p></o:p></span></p>
</div>
</div>
</div>
<div>
<p style=3D"background:white"><span style=3D"font-size:10.0pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Only load the MEC1 f=
irmware once in the Carrizo SMU manager<br>
driver.<br>
<br>
Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org">tom.=
stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c | 5 &#43;----<br>
&nbsp;1 file changed, 1 insertion(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/cz_smumgr.c<br>
index f51bd8de2f69..1529516089bc 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c<br>
@@ -574,10 &#43;574,7 @@ static int cz_smu_construct_toc_for_bootup(struct =
pp_smumgr *smumgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CZ_SCRATCH_ENTRY_UCODE_ID_CP_ME,=
 false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_smu_populate_single_uco=
de_load_task(smumgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC=
_JT1, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smumgr-&gt;chip_id =3D=3D CHIP_ST=
ONEY)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cz_smu_populate_single_ucode_load_task(smumgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT1, false=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smumgr-&gt;chip_id !=3D CHIP_=
STONEY)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cz_smu_populate_single_ucode_load_task(smumgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC=
_JT2, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_smu_populate_single_uco=
de_load_task(smumgr,<br>
-- <br>
2.9.3</span><span style=3D"color:black"><o:p></o:p></span></p>
</div>
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

--_000_MWHPR12MB1694C63CD7142919F461E5FFF7EC0MWHPR12MB1694namp_--

--===============1048744266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1048744266==--
