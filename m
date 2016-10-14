From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/7] drm/amdgpu: check min clock set by DAL before set ps.
Date: Fri, 14 Oct 2016 15:38:47 +0000
Message-ID: <MWHPR12MB1694E2CDE1ACDB7D5BA8FEB4F7DF0@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <1476446806-8918-1-git-send-email-Rex.Zhu@amd.com>,
 <MWHPR12MB1694DCA69B5231AC2A53EDB5F7DF0@MWHPR12MB1694.namprd12.prod.outlook.com>
 <CY4PR12MB16871EDF14232EC8FEDAD6DEFBDF0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2018223496=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16871EDF14232EC8FEDAD6DEFBDF0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2018223496==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1694E2CDE1ACDB7D5BA8FEB4F7DF0MWHPR12MB1694namp_"

--_000_MWHPR12MB1694E2CDE1ACDB7D5BA8FEB4F7DF0MWHPR12MB1694namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Up to you; whichever you think is easier.

Alex

From: Zhu, Rex
Sent: Friday, October 14, 2016 11:27 AM
To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/7] drm/amdgpu: check min clock set by DAL before set =
ps.


Ok. i will add CI support in powerplay next week.



Best Regards

Rex

________________________________
From: Deucher, Alexander
Sent: Friday, October 14, 2016 9:42:42 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org>
Cc: Zhu, Rex
Subject: RE: [PATCH 1/7] drm/amdgpu: check min clock set by DAL before set =
ps.

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Rex Zhu
> Sent: Friday, October 14, 2016 8:07 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Cc: Zhu, Rex
> Subject: [PATCH 1/7] drm/amdgpu: check min clock set by DAL before set ps=
.
>
> Change-Id: Id71b9a3329a8a143a189b275926b0a2054bf0bb8

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deuch=
er-5C7GfCeVMHo@public.gmane.org>>

For CI, I wonder if it would be better to add support for it to the powerpl=
ay smu7 module since it's pretty similar to the other smu7 dGPUs.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> index 1d8c375..fd2fe85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> @@ -960,6 +960,12 @@ static void ci_apply_state_adjust_rules(struct
> amdgpu_device *adev,
>                sclk =3D ps->performance_levels[0].sclk;
>        }
>
> +     if (adev->pm.pm_display_cfg.min_core_set_clock > sclk)
> +             sclk =3D adev->pm.pm_display_cfg.min_core_set_clock;
> +
> +     if (adev->pm.pm_display_cfg.min_mem_set_clock > mclk)
> +             mclk =3D adev->pm.pm_display_cfg.min_mem_set_clock;
> +
>        if (rps->vce_active) {
>                if (sclk < adev->pm.dpm.vce_states[adev-
> >pm.dpm.vce_level].sclk)
>                        sclk =3D adev->pm.dpm.vce_states[adev-
> >pm.dpm.vce_level].sclk;
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MWHPR12MB1694E2CDE1ACDB7D5BA8FEB4F7DF0MWHPR12MB1694namp_
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
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:1.0pt;
	margin-bottom:.0001pt;
	border:none;
	padding:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle19
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
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Up to you; whichever you =
think is easier.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex<o:p></o:p></span></p=
>
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
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Zhu, Rex
<br>
<b>Sent:</b> Friday, October 14, 2016 11:27 AM<br>
<b>To:</b> Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/7] drm/amdgpu: check min clock set by DAL befo=
re set ps.<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Ok. i will add CI support in powerplay&nbsp;next week.<o:p></o:p=
></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Best Regards<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Rex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> Deucher, Alexander<br>
<b>Sent:</b> Friday, October 14, 2016 9:42:42 PM<br>
<b>To:</b> Zhu, Rex; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-g=
fx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> RE: [PATCH 1/7] drm/amdgpu: check min clock set by DAL befo=
re set ps.</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">&gt; -----Original =
Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Rex Zhu<br>
&gt; Sent: Friday, October 14, 2016 8:07 AM<br>
&gt; To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt; Cc: Zhu, Rex<br>
&gt; Subject: [PATCH 1/7] drm/amdgpu: check min clock set by DAL before set=
 ps.<br>
&gt; <br>
&gt; Change-Id: Id71b9a3329a8a143a189b275926b0a2054bf0bb8<br>
<br>
Series is:<br>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">=
alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
For CI, I wonder if it would be better to add support for it to the powerpl=
ay smu7 module since it's pretty similar to the other smu7 dGPUs.<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 6 &#43;&#43;&#43;&#43;&#43=
;&#43;<br>
&gt;&nbsp; 1 file changed, 6 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt; index 1d8c375..fd2fe85 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt; @@ -960,6 &#43;960,12 @@ static void ci_apply_state_adjust_rules(struc=
t<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sclk =3D ps-&gt;performance_levels[0].sclk;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pm_display_cfg.min_core_=
set_clock &gt; sclk)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sclk =3D adev-&gt;pm.pm_display_cfg.min_core_set_clock;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pm_display_cfg.min_mem_s=
et_clock &gt; mclk)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; mclk =3D adev-&gt;pm.pm_display_cfg.min_mem_set_clock;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rps-&gt;vce_active) {<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (sclk &lt; adev-&gt;pm.dpm.vce_states[adev-<br>
&gt; &gt;pm.dpm.vce_level].sclk)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sclk =
=3D adev-&gt;pm.dpm.vce_states[adev-<br>
&gt; &gt;pm.dpm.vce_level].sclk;<br>
&gt; --<br>
&gt; 1.9.1<br>
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
</body>
</html>

--_000_MWHPR12MB1694E2CDE1ACDB7D5BA8FEB4F7DF0MWHPR12MB1694namp_--

--===============2018223496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2018223496==--
