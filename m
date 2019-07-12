From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: avoid double check feature enabled
Date: Fri, 12 Jul 2019 07:21:17 +0000
Message-ID: <MN2PR12MB329644EF69227432287703BBA2F20@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190712065959.25753-1-kevin1.wang@amd.com>
 <20190712065959.25753-3-kevin1.wang@amd.com>,
 <MN2PR12MB33448DDED55CA6C501E4C5A8E4F20@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0821685532=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB33448DDED55CA6C501E4C5A8E4F20-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============0821685532==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329644EF69227432287703BBA2F20MN2PR12MB3296namp_"

--_000_MN2PR12MB329644EF69227432287703BBA2F20MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

thanks,
i will make a new patch to fix this problem.

Best Regards,
Kevin
________________________________
From: Quan, Evan
Sent: Friday, July 12, 2019 3:09:54 PM
To: Wang, Kevin(Yang); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Feng, Kenneth
Subject: RE: [PATCH 3/3] drm/amd/powerplay: avoid double check feature enab=
led

Patch1 & 2 are reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

For patch3, for dpm disabled case, "smu_get_dpm_freq_range(smu, clk_type, &=
min_freq,&max_freq)" will not se the min_freq and max_freq.
That will cause some troubles for the succeeding smu_set_soft_freq_range. P=
lease get that handled properly.

Regards,
Evan
> -----Original Message-----
> From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> Sent: Friday, July 12, 2019 3:00 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Quan, Evan
> <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 3/3] drm/amd/powerplay: avoid double check feature
> enabled
>
> the unforce_dpm_levels doesn't need to check feature enable, because the
> smu_get_dpm_freq_range function has check feature logic.
>
> Change-Id: I6ae62b355aa76a00f0f6e164cd9848fb32fc7c12
> Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 23 ++++++++--------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 16a4c1ca98cf..895a4e592d5a 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -833,27 +833,20 @@ static int navi10_force_dpm_limit_value(struct
> smu_context *smu, bool highest)
>        return ret;
>  }
>
> -static int navi10_unforce_dpm_levels(struct smu_context *smu) {
> -
> +static int navi10_unforce_dpm_levels(struct smu_context *smu) {
>        int ret =3D 0, i =3D 0;
>        uint32_t min_freq, max_freq;
>        enum smu_clk_type clk_type;
>
> -     struct clk_feature_map {
> -             enum smu_clk_type clk_type;
> -             uint32_t        feature;
> -     } clk_feature_map[] =3D {
> -             {SMU_GFXCLK, SMU_FEATURE_DPM_GFXCLK_BIT},
> -             {SMU_MCLK,   SMU_FEATURE_DPM_UCLK_BIT},
> -             {SMU_SOCCLK, SMU_FEATURE_DPM_SOCCLK_BIT},
> +     enum smu_clk_type clks[] =3D {
> +             SMU_GFXCLK,
> +             SMU_MCLK,
> +             SMU_SOCCLK,
>        };
>
> -     for (i =3D 0; i < ARRAY_SIZE(clk_feature_map); i++) {
> -             if (!smu_feature_is_enabled(smu,
> clk_feature_map[i].feature))
> -                 continue;
> -
> -             clk_type =3D clk_feature_map[i].clk_type;
> -
> +     for (i =3D 0; i < ARRAY_SIZE(clks); i++) {
> +             clk_type =3D clks[i];
>                ret =3D smu_get_dpm_freq_range(smu, clk_type, &min_freq,
> &max_freq);
>                if (ret)
>                        return ret;
> --
> 2.22.0


--_000_MN2PR12MB329644EF69227432287703BBA2F20MN2PR12MB3296namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
thanks,&nbsp;
<div>i will make a new patch to fix this problem.</div>
<div><br>
</div>
<div>Best Regards,</div>
<div>Kevin</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Friday, July 12, 2019 3:09:54 PM<br>
<b>To:</b> Wang, Kevin(Yang); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Feng, Kenneth<br>
<b>Subject:</b> RE: [PATCH 3/3] drm/amd/powerplay: avoid double check featu=
re enabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Patch1 &amp; 2 are reviewed-by: Evan Quan &lt;evan=
.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
For patch3, for dpm disabled case, &quot;smu_get_dpm_freq_range(smu, clk_ty=
pe, &amp;min_freq,&amp;max_freq)&quot; will not se the min_freq and max_fre=
q.<br>
That will cause some troubles for the succeeding smu_set_soft_freq_range. P=
lease get that handled properly.<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Friday, July 12, 2019 3:00 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan<br>
&gt; &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
&gt; Subject: [PATCH 3/3] drm/amd/powerplay: avoid double check feature<br>
&gt; enabled<br>
&gt; <br>
&gt; the unforce_dpm_levels doesn't need to check feature enable, because t=
he<br>
&gt; smu_get_dpm_freq_range function has check feature logic.<br>
&gt; <br>
&gt; Change-Id: I6ae62b355aa76a00f0f6e164cd9848fb32fc7c12<br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 23 &#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;--------------<br>
&gt;&nbsp; 1 file changed, 8 insertions(&#43;), 15 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; index 16a4c1ca98cf..895a4e592d5a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; @@ -833,27 &#43;833,20 @@ static int navi10_force_dpm_limit_value(stru=
ct<br>
&gt; smu_context *smu, bool highest)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -static int navi10_unforce_dpm_levels(struct smu_context *smu) {<br>
&gt; -<br>
&gt; &#43;static int navi10_unforce_dpm_levels(struct smu_context *smu) {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, i =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_freq, max_freq;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_type;<=
br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct clk_feature_map {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; enum smu_clk_type clk_type;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } clk_feature_map[] =3D {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; {SMU_GFXCLK, SMU_FEATURE_DPM_GFXCLK_BIT},<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; {SMU_MCLK,&nbsp;&nbsp; SMU_FEATURE_DPM_UCLK_BIT},<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; {SMU_SOCCLK, SMU_FEATURE_DPM_SOCCLK_BIT},<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clks[] =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; SMU_GFXCLK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; SMU_MCLK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; SMU_SOCCLK,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(clk_feature_=
map); i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!smu_feature_is_enabled(smu,<br>
&gt; clk_feature_map[i].feature))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; clk_type =3D clk_feature_map[i].clk_type;<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(clks); i=
&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; clk_type =3D clks[i];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D smu_get_dpm_freq_range(smu, clk_type, &amp;min_=
freq,<br>
&gt; &amp;max_freq);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt; --<br>
&gt; 2.22.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB329644EF69227432287703BBA2F20MN2PR12MB3296namp_--

--===============0821685532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0821685532==--
