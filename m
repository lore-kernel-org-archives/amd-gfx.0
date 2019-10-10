From: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feature bit
Date: Thu, 10 Oct 2019 07:00:44 +0000
Message-ID: <MN2PR12MB3598AD3DF5A31DF503C03EAE8E940@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20191009110757.30995-1-xiaojie.yuan@amd.com>,
 <20191009110757.30995-2-xiaojie.yuan@amd.com>,
 <DM5PR12MB182077A0796BED759991002EF7950@DM5PR12MB1820.namprd12.prod.outlook.com>
 <BN8PR12MB3602F6E7A20C0F1FE3997FF589950@BN8PR12MB3602.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1783614633=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN8PR12MB3602F6E7A20C0F1FE3997FF589950-h6+T2+wrnx1lGJ5xs4l7kQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1783614633==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3598AD3DF5A31DF503C03EAE8E940MN2PR12MB3598namp_"

--_000_MN2PR12MB3598AD3DF5A31DF503C03EAE8E940MN2PR12MB3598namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex,
This issue was navi10 specific and was found in May, 2019.
It was early after the asic back, then since gfxoff was removed from navi10=
, we didn't really verify which firmware version started to have a fix.
For navi14/navi12, there's no such issue at all.
Sorry for losing the track of it.


From: Yuan, Xiaojie
Sent: Thursday, October 10, 2019 1:17 AM
To: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org
Cc: Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>=
; Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; F=
eng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feature bit

Hi Alex,

For now, gfxoff for navi10 is disabled by default, and I also verified on n=
avi14 with both GFXOFF and FW_DSTATE feature bits toggled on.

Hi Kenneth / Jack,

Could you help to confirm the firmware version?

BR,
Xiaojie
________________________________
From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deuche=
r@amd.com>>
Sent: Wednesday, October 9, 2019 9:35 PM
To: Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org<mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>>; amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org<mailto:Jack.Xiao-5C7GfCeVMHo@public.gmane.org>>; Wang, Kevin(Y=
ang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>; Zhang, Hawking <Haw=
king.Zhang-5C7GfCeVMHo@public.gmane.org<mailto:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>>; Quan, Evan <Evan.Quan@am=
d.com<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org<mailt=
o:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feature bit

What version of firmware has the fix?  Was it recently fixed?  We should ch=
eck the version if the old one may be out in the wild.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org<m=
ailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>>
Sent: Wednesday, October 9, 2019 7:08 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org<mailto:Jack.Xiao-5C7GfCeVMHo@public.gmane.org>>; Wang, Kevin(Y=
ang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>; Zhang, Hawking <Haw=
king.Zhang-5C7GfCeVMHo@public.gmane.org<mailto:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>>; Quan, Evan <Evan.Quan@am=
d.com<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org<mailt=
o:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>>; Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org<mailto:Xiaoji=
e.Yuan-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feature bit

SMU firmware has fix the bug, so remove this workaround.

Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org<mailto:xiaojie.yuan@amd.c=
om>>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 44152c1f01c7..3628295469c4 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -359,11 +359,8 @@ navi10_get_allowed_feature_mask(struct smu_context *sm=
u,
                                 | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_B=
IT)
                                 | FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BI=
T);

-       if (adev->pm.pp_feature & PP_GFXOFF_MASK) {
+       if (adev->pm.pp_feature & PP_GFXOFF_MASK)
                 *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_GFXOFF=
_BIT);
-               /* TODO: remove it once fw fix the bug */
-               *(uint64_t *)feature_mask &=3D ~FEATURE_MASK(FEATURE_FW_DST=
ATE_BIT);
-       }

         if (smu->adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
                 *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_MMHUB_=
PG_BIT);
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3598AD3DF5A31DF503C03EAE8E940MN2PR12MB3598namp_
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
libri&quot;,sans-serif;color:#1F497D">Hi Alex,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">This issue was navi10 specific and wa=
s found in May, 2019.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">It was early after the asic back, the=
n since gfxoff was removed from navi10, we didn&#8217;t really verify which=
 firmware version started to have a fix.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">For navi14/navi12, there&#8217;s no s=
uch issue at all.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Sorry for losing the track of it.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Yuan, Xiaojie
<br>
<b>Sent:</b> Thursday, October 10, 2019 1:17 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Xiao, Jack &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevi=
n1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Ev=
an &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;<br=
>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feat=
ure bit<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Hi Alex,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">For now, gfxoff for navi10 is disabled =
by default, and I also verified on navi14 with both GFXOFF and FW_DSTATE fe=
ature bits toggled on.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Hi Kenneth / Jack,<o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Could you help to confirm the firmware =
version?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">BR,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Xiaojie<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Deuche=
r, Alexander &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexander.Deu=
cher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Wednesday, October 9, 2019 9:35 PM<br>
<b>To:</b> Yuan, Xiaojie &lt;<a href=3D"mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org">Xiaoji=
e.Yuan-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Xiao, Jack &lt;<a href=3D"mailto:Jack.Xiao-5C7GfCeVMHo@public.gmane.org">Jack.Xiao@am=
d.com</a>&gt;; Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org"=
>Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.=
Zhang-5C7GfCeVMHo@public.gmane.org">Hawking.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt;; Quan, Evan
 &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;; Feng, =
Kenneth &lt;<a href=3D"mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org">Kenneth.Feng-5C7GfCeVMHo@public.gmane.org</a=
>&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feat=
ure bit</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">What version of firmware has the fix?&nbsp; Was it recen=
tly fixed?&nbsp; We should check the version if the old one may be out in t=
he wild.<o:p></o:p></span></p>
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
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gf=
x &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Yuan, Xiaojie &lt;<a href=3D"mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org">Xia=
ojie.Yuan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Wednesday, October 9, 2019 7:08 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Xiao, Jack &lt;<a href=3D"mailto:Jack.Xiao-5C7GfCeVMHo@public.gmane.org">Jack.Xiao@am=
d.com</a>&gt;; Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org"=
>Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.=
Zhang-5C7GfCeVMHo@public.gmane.org">Hawking.Zhang-5C7GfCeVMHo@public.gmane.org</a>&gt;; Quan, Evan
 &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;; Feng, =
Kenneth &lt;<a href=3D"mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org">Kenneth.Feng-5C7GfCeVMHo@public.gmane.org</a=
>&gt;; Yuan, Xiaojie &lt;<a href=3D"mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org">Xiaojie.Yu=
an-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feature =
bit</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">SMU firmware has fi=
x the bug, so remove this workaround.<br>
<br>
Signed-off-by: Xiaojie Yuan &lt;<a href=3D"mailto:xiaojie.yuan-5C7GfCeVMHo@public.gmane.org">xia=
ojie.yuan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 5 &#43;----<br>
&nbsp;1 file changed, 1 insertion(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 44152c1f01c7..3628295469c4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -359,11 &#43;359,8 @@ navi10_get_allowed_feature_mask(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_MEM_VDDCI=
_SCALING_BIT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_MEM_MVDD_=
SCALING_BIT);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &amp; PP_G=
FXOFF_MASK) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &amp; =
PP_GFXOFF_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_G=
FXOFF_BIT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* TODO: remove it once fw fix the bug */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *(uint64_t *)feature_mask &amp;=3D ~FEATURE_MASK(FEATURE_FW_DSTA=
TE_BIT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;pg_fl=
ags &amp; AMD_PG_SUPPORT_MMHUB)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_M=
MHUB_PG_BIT);<br>
-- <br>
2.20.1<br>
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
</body>
</html>

--_000_MN2PR12MB3598AD3DF5A31DF503C03EAE8E940MN2PR12MB3598namp_--

--===============1783614633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1783614633==--
