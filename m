From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: set uvd/vce/nb/mclk level as UMD
 P-state required
Date: Fri, 1 Sep 2017 18:32:27 +0000
Message-ID: <CY4PR12MB1687C349E15EB23278EBDA11FB920@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1504259466-27612-1-git-send-email-Rex.Zhu@amd.com>,
 <BN6PR12MB16522EA8F0FE7AC5405ED464F7920@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1817478755=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16522EA8F0FE7AC5405ED464F7920-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1817478755==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687C349E15EB23278EBDA11FB920CY4PR12MB1687namp_"

--_000_CY4PR12MB1687C349E15EB23278EBDA11FB920CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

=1B$B!U=1B(BBTW, can you review my stable p-state fix for CZ?
=1B$B!U=1B(Bhttps://patchwork.freedesktop.org/patch/174102

Patch is
Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Best Regards
Rex

________________________________
From: Deucher, Alexander
Sent: Friday, September 1, 2017 11:03:10 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: RE: [PATCH 4/4] drm/amd/powerplay: set uvd/vce/nb/mclk level as UM=
D P-state required

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Rex Zhu
> Sent: Friday, September 01, 2017 5:51 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Zhu, Rex
> Subject: [PATCH 4/4] drm/amd/powerplay: set uvd/vce/nb/mclk level as
> UMD P-state required
>
> Change-Id: I6e5cb169fcc22525d26cdc3f82ca011249f912ef
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

This series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

BTW, can you review my stable p-state fix for CZ?
https://patchwork.freedesktop.org/patch/174102/

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> index 573e4da..3a8bc74 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> @@ -1138,7 +1138,11 @@ static int cz_apply_state_adjust_rules(struct
> pp_hwmgr *hwmgr,
>
>        cz_ps->action =3D cz_current_ps->action;
>
> -     if (!force_high && (cz_ps->action =3D=3D FORCE_HIGH))
> +     if (hwmgr->request_dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> +             cz_nbdpm_pstate_enable_disable(hwmgr, false, false);
> +     else if (hwmgr->request_dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD)
> +             cz_nbdpm_pstate_enable_disable(hwmgr, false, true);
> +     else if (!force_high && (cz_ps->action =3D=3D FORCE_HIGH))
>                cz_ps->action =3D CANCEL_FORCE_HIGH;
>        else if (force_high && (cz_ps->action !=3D FORCE_HIGH))
>                cz_ps->action =3D FORCE_HIGH;
> @@ -1416,7 +1420,8 @@ int cz_dpm_update_uvd_dpm(struct pp_hwmgr
> *hwmgr, bool bgate)
>        if (!bgate) {
>                /* Stable Pstate is enabled and we need to set the UVD DPM
> to highest level */
>                if (phm_cap_enabled(hwmgr-
> >platform_descriptor.platformCaps,
> -                                      PHM_PlatformCaps_StablePState)) {
> +                                      PHM_PlatformCaps_StablePState)
> +                     || hwmgr->en_umd_pstate) {
>                        cz_hwmgr->uvd_dpm.hard_min_clk =3D
>                                   ptable->entries[ptable->count - 1].vclk=
;
>
> @@ -1445,7 +1450,8 @@ int  cz_dpm_update_vce_dpm(struct pp_hwmgr
> *hwmgr)
>
>        /* Stable Pstate is enabled and we need to set the VCE DPM to
> highest level */
>        if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> -                                      PHM_PlatformCaps_StablePState)) {
> +                                     PHM_PlatformCaps_StablePState)
> +                                     || hwmgr->en_umd_pstate) {
>                cz_hwmgr->vce_dpm.hard_min_clk =3D
>                                  ptable->entries[ptable->count - 1].ecclk=
;
>
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1687C349E15EB23278EBDA11FB920CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>Hi Alex,<br>
<br>
=1B$B!U=1B(BBTW, can you review my stable p-state fix for CZ?<br>
=1B$B!U=1B(Bhttps://patchwork.freedesktop.org/patch/174102<br>
<br>
Patch is <br>
Reviewed-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Best Regards<br>
Rex<br>
<br>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<=
br>
<b>Sent:</b> Friday, September 1, 2017 11:03:10 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> RE: [PATCH 4/4] drm/amd/powerplay: set uvd/vce/nb/mclk leve=
l as UMD P-state required</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Rex Zhu<br>
&gt; Sent: Friday, September 01, 2017 5:51 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Zhu, Rex<br>
&gt; Subject: [PATCH 4/4] drm/amd/powerplay: set uvd/vce/nb/mclk level as<b=
r>
&gt; UMD P-state required<br>
&gt; <br>
&gt; Change-Id: I6e5cb169fcc22525d26cdc3f82ca011249f912ef<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
This series is:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
BTW, can you review my stable p-state fix for CZ?<br>
<a href=3D"https://patchwork.freedesktop.org/patch/174102/">https://patchwo=
rk.freedesktop.org/patch/174102/</a><br>
<br>
Thanks,<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c | 12 &#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp; 1 file changed, 9 insertions(&#43;), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; index 573e4da..3a8bc74 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; @@ -1138,7 &#43;1138,11 @@ static int cz_apply_state_adjust_rules(stru=
ct<br>
&gt; pp_hwmgr *hwmgr,<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_ps-&gt;action =3D cz_curr=
ent_ps-&gt;action;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!force_high &amp;&amp; (cz_ps-&gt;action=
 =3D=3D FORCE_HIGH))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;request_dpm_level =3D=3D<b=
r>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; cz_nbdpm_pstate_enable_disable(hwmgr, false, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (hwmgr-&gt;request_dpm_level =3D=
=3D<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; cz_nbdpm_pstate_enable_disable(hwmgr, false, true);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (!force_high &amp;&amp; (cz_ps-&=
gt;action =3D=3D FORCE_HIGH))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cz_ps-&gt;action =3D CANCEL_FORCE_HIGH;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (force_high &amp;&am=
p; (cz_ps-&gt;action !=3D FORCE_HIGH))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cz_ps-&gt;action =3D FORCE_HIGH;<br>
&gt; @@ -1416,7 &#43;1420,8 @@ int cz_dpm_update_uvd_dpm(struct pp_hwmgr<br=
>
&gt; *hwmgr, bool bgate)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bgate) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Stable Pstate is enabled and we need to set the UVD =
DPM<br>
&gt; to highest level */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-<br>
&gt; &gt;platform_descriptor.platformCaps,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PHM_PlatformCaps_StablePState)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; PHM_PlatformCaps_StablePState)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || hwmgr-&gt;en_umd=
_pstate) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_hwmg=
r-&gt;uvd_dpm.hard_min_clk =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptable-&gt;entri=
es[ptable-&gt;count - 1].vclk;<br>
&gt; <br>
&gt; @@ -1445,7 &#43;1450,8 @@ int&nbsp; cz_dpm_update_vce_dpm(struct pp_hw=
mgr<br>
&gt; *hwmgr)<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Stable Pstate is enabled =
and we need to set the VCE DPM to<br>
&gt; highest level */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-&g=
t;platform_descriptor.platformCaps,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PHM_PlatformCaps_StablePState)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; PHM_PlatformCaps_StablePState)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; || hwmgr-&gt;en_umd_pstate) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cz_hwmgr-&gt;vce_dpm.hard_min_clk =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptable-&gt;entries[pta=
ble-&gt;count - 1].ecclk;<br>
&gt; <br>
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

--_000_CY4PR12MB1687C349E15EB23278EBDA11FB920CY4PR12MB1687namp_--

--===============1817478755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1817478755==--
