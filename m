From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block's state
 when initialize/resume
Date: Thu, 28 Jul 2016 14:12:53 +0000
Message-ID: <DM5PR12MB11325426775E3913A47F7908F7000@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <1469699605-13978-1-git-send-email-Rex.Zhu@amd.com>
 <1469699605-13978-4-git-send-email-Rex.Zhu@amd.com>,
 <CY4PR12MB13018F6728959608E2BF7A91F7000@CY4PR12MB1301.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1357577034=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB13018F6728959608E2BF7A91F7000-rpdhrqHFk05CiBuckNFh9wdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1357577034==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB11325426775E3913A47F7908F7000DM5PR12MB1132namp_"

--_000_DM5PR12MB11325426775E3913A47F7908F7000DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Um, I had this in my worktree ... so uh do I drop it from mine or what?


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, July 28, 2016 09:48
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: RE: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block's stat=
e when initialize/resume

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Rex Zhu
> Sent: Thursday, July 28, 2016 5:53 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Zhu, Rex
> Subject: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block's state
> when initialize/resume
>
> Change-Id: I6e338a5faeb023b13bb450ecb1c4bb3eaa3b0ac5
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

For the series:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

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
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB11325426775E3913A47F7908F7000DM5PR12MB1132namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Um, I had this in my worktree ... so uh do I drop it from mine or what?<=
/p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deucher, Alexander &lt;Alex=
ander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, July 28, 2016 09:48<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> RE: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block=
's state when initialize/resume</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Rex Zhu<br>
&gt; Sent: Thursday, July 28, 2016 5:53 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Zhu, Rex<br>
&gt; Subject: [PATCH 4/4] drm/amd/powerplay: not change uvd/vce block's sta=
te<br>
&gt; when initialize/resume<br>
&gt; <br>
&gt; Change-Id: I6e338a5faeb023b13bb450ecb1c4bb3eaa3b0ac5<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
For the series:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB11325426775E3913A47F7908F7000DM5PR12MB1132namp_--

--===============1357577034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1357577034==--
