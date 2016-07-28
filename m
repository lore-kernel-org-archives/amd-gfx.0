From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block's state
 when initialize/resume
Date: Thu, 28 Jul 2016 14:17:09 +0000
Message-ID: <CY4PR12MB130129B7D12B803A88142219F7000@CY4PR12MB1301.namprd12.prod.outlook.com>
References: <1469699605-13978-1-git-send-email-Rex.Zhu@amd.com>
 <1469699605-13978-4-git-send-email-Rex.Zhu@amd.com>,
 <CY4PR12MB13018F6728959608E2BF7A91F7000@CY4PR12MB1301.namprd12.prod.outlook.com>
 <DM5PR12MB11325426775E3913A47F7908F7000@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0418760059=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB11325426775E3913A47F7908F7000-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0418760059==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB130129B7D12B803A88142219F7000CY4PR12MB1301namp_"

--_000_CY4PR12MB130129B7D12B803A88142219F7000CY4PR12MB1301namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Whoever commits it first wins ;)

From: StDenis, Tom
Sent: Thursday, July 28, 2016 10:13 AM
To: Deucher, Alexander; Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block's stat=
e when initialize/resume


Um, I had this in my worktree ... so uh do I drop it from mine or what?



Tom

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Deucher, Alexander <Alexander.Deucher=
@amd.com<mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, July 28, 2016 09:48
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org>
Cc: Zhu, Rex
Subject: RE: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block's stat=
e when initialize/resume

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Rex Zhu
> Sent: Thursday, July 28, 2016 5:53 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Cc: Zhu, Rex
> Subject: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block's state
> when initialize/resume
>
> Change-Id: I6e338a5faeb023b13bb450ecb1c4bb3eaa3b0ac5
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>

For the series:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deuch=
er-5C7GfCeVMHo@public.gmane.org>>

> ---
>  drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c
> b/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c
> index d6635cc..635fc4b 100644
> --- a/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c
> +++ b/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c
> @@ -30,7 +30,6 @@ static const pem_event_action * const initialize_event[=
]
> =3D {
>        system_config_tasks,
>        setup_asic_tasks,
>        enable_dynamic_state_management_tasks,
> -     enable_clock_power_gatings_tasks,
>        get_2d_performance_state_tasks,
>        set_performance_state_tasks,
>        initialize_thermal_controller_tasks,
> @@ -140,7 +139,6 @@ static const pem_event_action * const
> resume_event[] =3D {
>        setup_asic_tasks,
>        enable_stutter_mode_tasks, /*must do this in boot state and before
> SMC is started */
>        enable_dynamic_state_management_tasks,
> -     enable_clock_power_gatings_tasks,
>        enable_disable_bapm_tasks,
>        initialize_thermal_controller_tasks,
>        get_2d_performance_state_tasks,
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB130129B7D12B803A88142219F7000CY4PR12MB1301namp_
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
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Whoever commits it first =
wins ;)<o:p></o:p></span></p>
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
<b>Sent:</b> Thursday, July 28, 2016 10:13 AM<br>
<b>To:</b> Deucher, Alexander; Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block=
's state when initialize/resume<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">Um, I had this in my worktree ... so =
uh do I drop it from mine or what?<o:p></o:p></span></p>
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
i&quot;,&quot;sans-serif&quot;;color:black"> amd-gfx &lt;<a href=3D"mailto:=
amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g</a>&gt;
 on behalf of Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@am=
d.com">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, July 28, 2016 09:48<br>
<b>To:</b> Zhu, Rex; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-g=
fx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> RE: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block=
's state when initialize/resume</span><span style=3D"font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black">
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
&gt; Of Rex Zhu<br>
&gt; Sent: Thursday, July 28, 2016 5:53 AM<br>
&gt; To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt; Cc: Zhu, Rex<br>
&gt; Subject: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block's sta=
te<br>
&gt; when initialize/resume<br>
&gt; <br>
&gt; Change-Id: I6e338a5faeb023b13bb450ecb1c4bb3eaa3b0ac5<br>
&gt; Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">Rex.Zhu@=
amd.com</a>&gt;<br>
<br>
For the series:<br>
Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">=
alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c | 2 -=
-<br>
&gt;&nbsp; 1 file changed, 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.=
c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c<br>
&gt; index d6635cc..635fc4b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionch=
ains.c<br>
&gt; @@ -30,7 &#43;30,6 @@ static const pem_event_action * const initialize=
_event[]<br>
&gt; =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_config_tasks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_asic_tasks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_dynamic_state_managem=
ent_tasks,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; enable_clock_power_gatings_tasks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_2d_performance_state_tas=
ks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_performance_state_tasks,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initialize_thermal_controlle=
r_tasks,<br>
&gt; @@ -140,7 &#43;139,6 @@ static const pem_event_action * const<br>
&gt; resume_event[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_asic_tasks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_stutter_mode_tasks, /=
*must do this in boot state and before<br>
&gt; SMC is started */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_dynamic_state_managem=
ent_tasks,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; enable_clock_power_gatings_tasks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable_disable_bapm_tasks,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initialize_thermal_controlle=
r_tasks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_2d_performance_state_tas=
ks,<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
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
</div>
</body>
</html>

--_000_CY4PR12MB130129B7D12B803A88142219F7000CY4PR12MB1301namp_--

--===============0418760059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0418760059==--
