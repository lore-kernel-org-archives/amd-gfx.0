From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/7] drm/amdgpu: check min clock set by DAL before set ps.
Date: Fri, 14 Oct 2016 15:26:41 +0000
Message-ID: <CY4PR12MB16871EDF14232EC8FEDAD6DEFBDF0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1476446806-8918-1-git-send-email-Rex.Zhu@amd.com>,
 <MWHPR12MB1694DCA69B5231AC2A53EDB5F7DF0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0320662775=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1694DCA69B5231AC2A53EDB5F7DF0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============0320662775==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16871EDF14232EC8FEDAD6DEFBDF0CY4PR12MB1687namp_"

--_000_CY4PR12MB16871EDF14232EC8FEDAD6DEFBDF0CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ok. i will add CI support in powerplay next week.


Best Regards

Rex

________________________________
From: Deucher, Alexander
Sent: Friday, October 14, 2016 9:42:42 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: RE: [PATCH 1/7] drm/amdgpu: check min clock set by DAL before set =
ps.

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Rex Zhu
> Sent: Friday, October 14, 2016 8:07 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Zhu, Rex
> Subject: [PATCH 1/7] drm/amdgpu: check min clock set by DAL before set ps=
.
>
> Change-Id: Id71b9a3329a8a143a189b275926b0a2054bf0bb8

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

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
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB16871EDF14232EC8FEDAD6DEFBDF0CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; =
font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Ok. i will add CI support in powerplay&nbsp;next week.</p>
<p><br>
</p>
<p>Best Regards</p>
<p>Rex</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<=
br>
<b>Sent:</b> Friday, October 14, 2016 9:42:42 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> RE: [PATCH 1/7] drm/amdgpu: check min clock set by DAL befo=
re set ps.</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Rex Zhu<br>
&gt; Sent: Friday, October 14, 2016 8:07 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Zhu, Rex<br>
&gt; Subject: [PATCH 1/7] drm/amdgpu: check min clock set by DAL before set=
 ps.<br>
&gt; <br>
&gt; Change-Id: Id71b9a3329a8a143a189b275926b0a2054bf0bb8<br>
<br>
Series is:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB16871EDF14232EC8FEDAD6DEFBDF0CY4PR12MB1687namp_--

--===============0320662775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0320662775==--
