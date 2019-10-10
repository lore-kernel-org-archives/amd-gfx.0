From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feature bit
Date: Thu, 10 Oct 2019 12:20:32 +0000
Message-ID: <CY4PR12MB181316A0DC0FC83741C2D887F7940@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191009110757.30995-1-xiaojie.yuan@amd.com>,
 <20191009110757.30995-2-xiaojie.yuan@amd.com>,
 <DM5PR12MB182077A0796BED759991002EF7950@DM5PR12MB1820.namprd12.prod.outlook.com>
 <BN8PR12MB3602F6E7A20C0F1FE3997FF589950@BN8PR12MB3602.namprd12.prod.outlook.com>,
 <MN2PR12MB3598AD3DF5A31DF503C03EAE8E940@MN2PR12MB3598.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0922403181=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3598AD3DF5A31DF503C03EAE8E940-rweVpJHSKTohWwLleUddgQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0922403181==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB181316A0DC0FC83741C2D887F7940CY4PR12MB1813namp_"

--_000_CY4PR12MB181316A0DC0FC83741C2D887F7940CY4PR12MB1813namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Great.  thanks!

Alex
________________________________
From: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, October 10, 2019 3:00 AM
To: Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deu=
cher-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
>
Cc: Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>=
; Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feature bit


Hi Alex,

This issue was navi10 specific and was found in May, 2019.

It was early after the asic back, then since gfxoff was removed from navi10=
, we didn=92t really verify which firmware version started to have a fix.

For navi14/navi12, there=92s no such issue at all.

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

--_000_CY4PR12MB181316A0DC0FC83741C2D887F7940CY4PR12MB1813namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Great.&nbsp; thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Feng, Kenneth &lt;Ken=
neth.Feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, October 10, 2019 3:00 AM<br>
<b>To:</b> Yuan, Xiaojie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Alexander &=
lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx=
@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Xiao, Jack &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevi=
n1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Ev=
an &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feat=
ure bit</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:SimSun}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:SimSun}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
p
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:#1F497D}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.25in 1.0in 1.25in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#1F497D">Hi Alex,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#1F497D">This issue was navi10 specific an=
d was found in May, 2019.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#1F497D">It was early after the asic back,=
 then since gfxoff was removed from navi10, we didn=92t really verify which=
 firmware version started to have a fix.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#1F497D">For navi14/navi12, there=92s no s=
uch issue at all.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#1F497D">Sorry for losing the track of it.=
</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#1F497D">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#1F497D">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,sans-serif"> Yuan, Xiaojie
<br>
<b>Sent:</b> Thursday, October 10, 2019 1:17 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Xiao, Jack &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevi=
n1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Ev=
an &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;<br=
>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/powerplay: re-enable FW_DSTATE feat=
ure bit</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">Hi Alex,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">For now, gfxoff for navi10 is disab=
led by default, and I also verified on navi14 with both GFXOFF and FW_DSTAT=
E feature bits toggled on.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">Hi Kenneth / Jack,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">Could you help to confirm the firmw=
are version?</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">BR,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:black">Xiaojie</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> =
Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexand=
er.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
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
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,san=
s-serif; color:black">What version of firmware has the fix?&nbsp; Was it re=
cently fixed?&nbsp; We should check the version if the old one may be out i=
n the wild.</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,san=
s-serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,san=
s-serif; color:black">Alex</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> =
amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gf=
x-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
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
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt">SMU firmware has =
fix the bug, so remove this workaround.<br>
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
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB181316A0DC0FC83741C2D887F7940CY4PR12MB1813namp_--

--===============0922403181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0922403181==--
