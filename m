From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume defaults
Date: Wed, 3 Aug 2016 16:38:12 +0000
Message-ID: <CY4PR12MB1301350D2533F3D9C5ECE415F7060@CY4PR12MB1301.namprd12.prod.outlook.com>
References: <20160803155142.27161-1-tom.stdenis@amd.com>
 <20160803155142.27161-3-tom.stdenis@amd.com>,
 <CY4PR12MB13012C4621A36F9729CABCABF7060@CY4PR12MB1301.namprd12.prod.outlook.com>
 <DM5PR12MB1132B576B670B06A46671827F7060@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1650921597=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1132B576B670B06A46671827F7060-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1650921597==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1301350D2533F3D9C5ECE415F7060CY4PR12MB1301namp_"

--_000_CY4PR12MB1301350D2533F3D9C5ECE415F7060CY4PR12MB1301namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Maybe add a comment to that effect.  With that added,  this patch is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

From: StDenis, Tom
Sent: Wednesday, August 03, 2016 12:31 PM
To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume defaul=
ts


The logic is a bit confusing at first.  "gated" means that SW CG is enabled=
 not that the clocks are turned off.  When I sampled the registers in the o=
riginal configuration the clocks were reading 100% when the core was active=
.  It would read 0% when idle but only because power was gated.



With the logic the way it is when the core is active I see many of the cloc=
ks throttle as they should.



Tom

________________________________
From: Deucher, Alexander
Sent: Wednesday, August 3, 2016 12:28
To: 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org>
Cc: StDenis, Tom
Subject: RE: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume defaul=
ts

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Tom St Denis
> Sent: Wednesday, August 03, 2016 11:52 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Cc: StDenis, Tom
> Subject: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume
> defaults
>
> CG was being enabled in reverse sense from dpm/powerplay.
> Also fix the default CLK_EN signal to enable all of the blocks.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org<mailto:tom.stdenis@amd.c=
om>>
> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 26fb606e2d3e..93604bb78257 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -130,7 +130,7 @@ static void vce_v3_0_set_vce_sw_clock_gating(struct
> amdgpu_device *adev,
>        /* Set Override to disable Clock Gating */
>        vce_v3_0_override_vce_clock_gating(adev, true);
>
> -     if (!gated) {
> +     if (gated) {
>                /* Force CLOCK ON for VCE_CLOCK_GATING_B,
>                 * {*_FORCE_ON, *_FORCE_OFF} =3D {1, 0}

This doesn't make sense to me unless I'm mis-understanding the specific CG =
feature.  Forcing the clocks on, implies ungating, not gating.  In this cas=
e if forcing the clocks on part of the fw controlled clockgating configurat=
ion?  If so, please add a comment to that effect in the function.

Alex

>                 * VREG can be FORCE ON or set to Dynamic, but can't be OF=
F
> @@ -153,7 +153,7 @@ static void vce_v3_0_set_vce_sw_clock_gating(struct
> amdgpu_device *adev,
>                /* set VCE_UENC_CLOCK_GATING_2 */
>                tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);
>                data |=3D 0x2;
> -             data &=3D ~0x2;
> +             data &=3D ~0x00010000;
>                if (tmp !=3D data)
>                        WREG32(mmVCE_UENC_CLOCK_GATING_2, data);
>
> @@ -538,7 +538,7 @@ static void vce_v3_0_mc_resume(struct
> amdgpu_device *adev, int idx)
>        WREG32_P(mmVCE_CLOCK_GATING_A, 0, ~(1 << 16));
>        WREG32_P(mmVCE_UENC_CLOCK_GATING, 0x1FF000,
> ~0xFF9FF000);
>        WREG32_P(mmVCE_UENC_REG_CLOCK_GATING, 0x3F, ~0x3F);
> -     WREG32(mmVCE_CLOCK_GATING_B, 0xf7);
> +     WREG32(mmVCE_CLOCK_GATING_B, 0x1FF);
>
>        WREG32(mmVCE_LMI_CTRL, 0x00398000);
>        WREG32_P(mmVCE_LMI_CACHE_CTRL, 0x0, ~0x1);
> --
> 2.9.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1301350D2533F3D9C5ECE415F7060CY4PR12MB1301namp_
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
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Maybe add a comment to th=
at effect.&nbsp; With that added,&nbsp; this patch is:<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Reviewed-by: Alex Deucher=
 &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<o:p></o:p></span></p>
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
<b>Sent:</b> Wednesday, August 03, 2016 12:31 PM<br>
<b>To:</b> Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume=
 defaults<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">The logic is a bit confusing at first=
. &nbsp;&quot;gated&quot; means that SW CG is enabled not that the clocks a=
re turned off. &nbsp;When I sampled the registers in the original configura=
tion
 the clocks were reading 100% when the core was active. &nbsp;It would read=
 0% when idle but only because power was gated.<o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">With the logic the way it is when the=
 core is active I see many of the clocks throttle as they should.<o:p></o:p=
></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">Tom<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;background:white"><spa=
n style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:bla=
ck"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color=
:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal" style=3D"background:white"><b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">From:</span></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibr=
i&quot;,&quot;sans-serif&quot;;color:black"> Deucher, Alexander<br>
<b>Sent:</b> Wednesday, August 3, 2016 12:28<br>
<b>To:</b> 'Tom St Denis'; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"=
>amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> RE: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume=
 defaults</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-s=
erif&quot;;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbsp;<o:p></o:p>=
</span></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">=
&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Tom St Denis<br>
&gt; Sent: Wednesday, August 03, 2016 11:52 AM<br>
&gt; To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt; Cc: StDenis, Tom<br>
&gt; Subject: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume<br>
&gt; defaults<br>
&gt; <br>
&gt; CG was being enabled in reverse sense from dpm/powerplay.<br>
&gt; Also fix the default CLK_EN signal to enable all of the blocks.<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org"=
>tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 6 &#43;&#43;&#43;---<br>
&gt;&nbsp; 1 file changed, 3 insertions(&#43;), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; index 26fb606e2d3e..93604bb78257 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; @@ -130,7 &#43;130,7 @@ static void vce_v3_0_set_vce_sw_clock_gating(s=
truct<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set Override to disable C=
lock Gating */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_0_override_vce_clock_=
gating(adev, true);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!gated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (gated) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Force CLOCK ON for VCE_CLOCK_GATING_B,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * {*_FORCE_ON, *_FORCE_OFF} =3D {1, 0}<br>
<br>
This doesn't make sense to me unless I'm mis-understanding the specific CG =
feature.&nbsp; Forcing the clocks on, implies ungating, not gating.&nbsp; I=
n this case if forcing the clocks on part of the fw controlled clockgating =
configuration?&nbsp; If so, please add a comment
 to that effect in the function.<br>
<br>
Alex<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * VREG can be FORCE ON or set to Dynamic, but can=
't be OFF<br>
&gt; @@ -153,7 &#43;153,7 @@ static void vce_v3_0_set_vce_sw_clock_gating(s=
truct<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* set VCE_UENC_CLOCK_GATING_2 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D 0x2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~0x2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data &amp;=3D ~0x00010000;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (tmp !=3D data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(=
mmVCE_UENC_CLOCK_GATING_2, data);<br>
&gt; <br>
&gt; @@ -538,7 &#43;538,7 @@ static void vce_v3_0_mc_resume(struct<br>
&gt; amdgpu_device *adev, int idx)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_CLOCK_GATING_=
A, 0, ~(1 &lt;&lt; 16));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_UENC_CLOCK_GA=
TING, 0x1FF000,<br>
&gt; ~0xFF9FF000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_UENC_REG_CLOC=
K_GATING, 0x3F, ~0x3F);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_CLOCK_GATING_B, 0xf7);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_CLOCK_GATING_B, 0x1FF);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_LMI_CTRL, 0x003=
98000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_LMI_CACHE_CTR=
L, 0x0, ~0x1);<br>
&gt; --<br>
&gt; 2.9.2<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></=
p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1301350D2533F3D9C5ECE415F7060CY4PR12MB1301namp_--

--===============1650921597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1650921597==--
