From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Add the interface for geting dpm
 current power state
Date: Mon, 9 Sep 2019 13:20:41 +0000
Message-ID: <MN2PR12MB3296DEA8597993E2B2CBDD63A2B70@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <1568006521-7471-1-git-send-email-Prike.Liang@amd.com>,
 <MN2PR12MB3344C78FF82CFB5166571091E4B70@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1888218740=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344C78FF82CFB5166571091E4B70-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>

--===============1888218740==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296DEA8597993E2B2CBDD63A2B70MN2PR12MB3296namp_"

--_000_MN2PR12MB3296DEA8597993E2B2CBDD63A2B70MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

comment inline.
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Quan, Ev=
an <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, September 9, 2019 4:31 PM
To: Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; L=
iu, Aaron <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: Add the interface for geting dpm cu=
rrent power state

Reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

> -----Original Message-----
> From: Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
> Sent: 2019=1B$BG/=1B(B9=1B$B7n=1B(B9=1B$BF|=1B(B 13:22
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth
> <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Liu, Aaron
> <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>; Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH] drm/amd/powerplay: Add the interface for geting dpm
> current power state
>
> implement the sysfs power_dpm_state
>
> Signed-off-by: Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 34
> ++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index a5cf846..2c22ba4 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -246,6 +246,38 @@ static int renoir_print_clk_levels(struct smu_contex=
t
> *smu,
>        return size;
>  }
>
> +static enum amd_pm_state_type renoir_get_current_power_state(struct
> +smu_context *smu) {
> +     enum amd_pm_state_type pm_type;
> +     struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> +
> +     if (!smu_dpm_ctx->dpm_context ||
> +         !smu_dpm_ctx->dpm_current_power_state)
> +             return -EINVAL;
> +
> +     mutex_lock(&(smu->mutex));
> +     switch (smu_dpm_ctx->dpm_current_power_state-
> >classification.ui_label) {
> +     case SMU_STATE_UI_LABEL_BATTERY:
> +             pm_type =3D POWER_STATE_TYPE_BATTERY;
> +             break;
> +     case SMU_STATE_UI_LABEL_BALLANCED:
> +             pm_type =3D POWER_STATE_TYPE_BALANCED;
> +             break;
> +     case SMU_STATE_UI_LABEL_PERFORMANCE:
> +             pm_type =3D POWER_STATE_TYPE_PERFORMANCE;
> +             break;
> +     default:
> +             if (smu_dpm_ctx->dpm_current_power_state-
> >classification.flags & SMU_STATE_CLASSIFICATION_FLAG_BOOT)
> +                     pm_type =3D POWER_STATE_TYPE_INTERNAL_BOOT;
> +             else
> +                     pm_type =3D POWER_STATE_TYPE_DEFAULT;
> +             break;
> +     }
> +     mutex_unlock(&(smu->mutex));
> +
> +     return pm_type;
> +}
> +
>  static const struct pptable_funcs renoir_ppt_funcs =3D {
>        .get_smu_msg_index =3D renoir_get_smu_msg_index,
>        .get_smu_table_index =3D renoir_get_smu_table_index, @@ -253,6
> +285,8 @@ static const struct pptable_funcs renoir_ppt_funcs =3D {
>        .set_power_state =3D NULL,
>        .get_dpm_uclk_limited =3D renoir_get_dpm_uclk_limited,
>        .print_clk_levels =3D renoir_print_clk_levels,
> +     .get_current_power_state =3D renoir_get_current_power_state,
> +
[kevin]:
please remove this blank line.
after fixed:
Reviewed-by: Kevin wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
>  };
>
>  void renoir_set_ppt_funcs(struct smu_context *smu)
> --
> 2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3296DEA8597993E2B2CBDD63A2B70MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
comment inline.</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Monday, September 9, 2019 4:31 PM<br>
<b>To:</b> Liang, Prike &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.=
Feng-5C7GfCeVMHo@public.gmane.org&gt;; Liu, Aaron &lt;Aaron.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: Add the interface for geting=
 dpm current power state</font>
<div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0)">
<br>
</div>
</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Reviewed-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
<br>
&gt; -----Original Message-----<br>
&gt; From: Liang, Prike &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: 2019=1B$BG/=1B(B9=1B$B7n=1B(B9=1B$BF|=1B(B 13:22<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth<br>
&gt; &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Li=
u, Aaron<br>
&gt; &lt;Aaron.Liu-5C7GfCeVMHo@public.gmane.org&gt;; Liang, Prike &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;<br=
>
&gt; Subject: [PATCH] drm/amd/powerplay: Add the interface for geting dpm<b=
r>
&gt; current power state<br>
&gt; <br>
&gt; implement the sysfs power_dpm_state<br>
&gt; <br>
&gt; Signed-off-by: Prike Liang &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 34<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;<br>
&gt;&nbsp; 1 file changed, 34 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&gt; index a5cf846..2c22ba4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&gt; @@ -246,6 &#43;246,38 @@ static int renoir_print_clk_levels(struct smu=
_context<br>
&gt; *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; &#43;static enum amd_pm_state_type renoir_get_current_power_state(stru=
ct<br>
&gt; &#43;smu_context *smu) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type pm_type;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_dpm_ctx =3D =
&amp;(smu-&gt;smu_dpm);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_dpm_ctx-&gt;dpm_context ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !smu_dpm_ctx-&gt=
;dpm_current_power_state)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;(smu-&gt;mutex));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (smu_dpm_ctx-&gt;dpm_current_powe=
r_state-<br>
&gt; &gt;classification.ui_label) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_STATE_UI_LABEL_BATTERY:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pm_type =3D POWER_STATE_TYPE_BATTERY;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_STATE_UI_LABEL_BALLANCED:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pm_type =3D POWER_STATE_TYPE_BALANCED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_STATE_UI_LABEL_PERFORMANCE:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pm_type =3D POWER_STATE_TYPE_PERFORMANCE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (smu_dpm_ctx-&gt;dpm_current_power_state-<br>
&gt; &gt;classification.flags &amp; SMU_STATE_CLASSIFICATION_FLAG_BOOT)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_type =3D POWER_S=
TATE_TYPE_INTERNAL_BOOT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_type =3D POWER_S=
TATE_TYPE_DEFAULT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;(smu-&gt;mutex));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return pm_type;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct pptable_funcs renoir_ppt_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_msg_index =3D renoi=
r_get_smu_msg_index,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_table_index =3D ren=
oir_get_smu_table_index, @@ -253,6<br>
&gt; &#43;285,8 @@ static const struct pptable_funcs renoir_ppt_funcs =3D {=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_state =3D NULL,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dpm_uclk_limited =3D re=
noir_get_dpm_uclk_limited,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clk_levels =3D renoir=
_print_clk_levels,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .get_current_power_state =3D renoir_get_=
current_power_state,<br>
&gt; &#43;</div>
<div class=3D"PlainText"><b>[kevin]:</b></div>
<div class=3D"PlainText"><b>please remove this&nbsp;blank line.</b></div>
<div class=3D"PlainText"><b>after fixed:</b></div>
<div class=3D"PlainText"><b>Reviewed-by: Kevin wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org=
&gt;</b></div>
<div class=3D"PlainText">&gt;&nbsp; };<br>
&gt; <br>
&gt;&nbsp; void renoir_set_ppt_funcs(struct smu_context *smu)<br>
&gt; --<br>
&gt; 2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296DEA8597993E2B2CBDD63A2B70MN2PR12MB3296namp_--

--===============1888218740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1888218740==--
