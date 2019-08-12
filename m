From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: add arcturus_is_dpm_running
 function for arcturus
Date: Mon, 12 Aug 2019 09:52:15 +0000
Message-ID: <MN2PR12MB3296807CB0DAC9F94D795E56A2D30@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <1565598138-13844-1-git-send-email-Jack.Gui@amd.com>
 <1565598138-13844-2-git-send-email-Jack.Gui@amd.com>,
 <MN2PR12MB33441DEDEEB00F8F321F72BBE4D30@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1464525492=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB33441DEDEEB00F8F321F72BBE4D30-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Gui, Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1464525492==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296807CB0DAC9F94D795E56A2D30MN2PR12MB3296namp_"

--_000_MN2PR12MB3296807CB0DAC9F94D795E56A2D30MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

if any DPM feature is enabled, then DPM is running, return true.
if all DPM feature is disabled, the DPM is not running, return false.
so the macro of  "SMC_DPM_FEATURE" should be include all dpm feature, wheth=
er is enabled or supported.
i think the @Gui, Jack<mailto:Jack.Gui-5C7GfCeVMHo@public.gmane.org>'s patch is right.

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Quan, Ev=
an <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, August 12, 2019 5:38 PM
To: Gui, Jack <Jack.Gui-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@li=
sts.freedesktop.org>
Cc: Gui, Jack <Jack.Gui-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: add arcturus_is_dpm_running fun=
ction for arcturus

Please set FEATURE_DPM_PREFETCHER_MASK | FEATURE_DPM_GFXCLK_MASK only. For =
now, only these two are enabled on arcturus.

With that fixed, the patch is reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> Chengming Gui
> Sent: Monday, August 12, 2019 4:22 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Gui, Jack <Jack.Gui-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 2/2] drm/amd/powerplay: add arcturus_is_dpm_running
> function for arcturus
>
> add arcturus_is_dpm_running function
>
> Signed-off-by: Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 21
> +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 03ce871..9107beb 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -51,6 +51,15 @@
>  #define SMU_FEATURES_HIGH_MASK       0xFFFFFFFF00000000
>  #define SMU_FEATURES_HIGH_SHIFT      32
>
> +#define SMC_DPM_FEATURE ( \
> +     FEATURE_DPM_PREFETCHER_MASK | \
> +     FEATURE_DPM_GFXCLK_MASK | \
> +     FEATURE_DPM_UCLK_MASK | \
> +     FEATURE_DPM_SOCCLK_MASK | \
> +     FEATURE_DPM_MP0CLK_MASK | \
> +     FEATURE_DPM_FCLK_MASK | \
> +     FEATURE_DPM_XGMI_MASK)
> +
>  /* possible frequency drift (1Mhz) */
>  #define EPSILON                              1
>
> @@ -1873,6 +1882,17 @@ static void arcturus_dump_pptable(struct
> smu_context *smu)
>
>  }
>
> +static bool arcturus_is_dpm_running(struct smu_context *smu) {
> +     int ret =3D 0;
> +     uint32_t feature_mask[2];
> +     unsigned long feature_enabled;
> +     ret =3D smu_feature_get_enabled_mask(smu, feature_mask, 2);
> +     feature_enabled =3D (unsigned long)((uint64_t)feature_mask[0] |
> +                        ((uint64_t)feature_mask[1] << 32));
> +     return !!(feature_enabled & SMC_DPM_FEATURE); }
> +
>  static const struct pptable_funcs arcturus_ppt_funcs =3D {
>        /* translate smu index into arcturus specific index */
>        .get_smu_msg_index =3D arcturus_get_smu_msg_index, @@ -1910,6
> +1930,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =3D {
>        /* debug (internal used) */
>        .dump_pptable =3D arcturus_dump_pptable,
>        .get_power_limit =3D arcturus_get_power_limit,
> +     .is_dpm_running =3D arcturus_is_dpm_running,
>  };
>
>  void arcturus_set_ppt_funcs(struct smu_context *smu)
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3296807CB0DAC9F94D795E56A2D30MN2PR12MB3296namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>if any DPM feature is enabled, then DPM is running, return true.</spa=
n></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>if all DPM feature is disabled, the DPM is not running, return false.=
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">so the macro of&nbsp; &quot;</span><i style=
=3D"font-size: 12pt; font-variant-ligatures: inherit; font-variant-caps: in=
herit; font-weight: inherit;">SMC_DPM_FEATURE</i><span style=3D"color: rgb(=
0, 0, 0); font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12=
pt;">&quot;
 should be include all dpm feature, whether is enabled or supported.</span>=
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>i think the&nbsp;<a id=3D"OWAAM823302" class=3D"_1OtrSZdhKXVv3Uhaivrd=
J4 mention ms-bgc-nlr ms-fcl-b" href=3D"mailto:Jack.Gui-5C7GfCeVMHo@public.gmane.org">@Gui, Jack=
</a>'s patch is right.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>Best Regards,<br>
Kevin<br>
</span><span></span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Monday, August 12, 2019 5:38 PM<br>
<b>To:</b> Gui, Jack &lt;Jack.Gui-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Gui, Jack &lt;Jack.Gui-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd/powerplay: add arcturus_is_dpm_runn=
ing function for arcturus</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Please set FEATURE_DPM_PREFETCHER_MASK | FEATURE_D=
PM_GFXCLK_MASK only. For now, only these two are enabled on arcturus.<br>
<br>
With that fixed, the patch is reviewed-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&=
gt;<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of<br>
&gt; Chengming Gui<br>
&gt; Sent: Monday, August 12, 2019 4:22 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Gui, Jack &lt;Jack.Gui-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH 2/2] drm/amd/powerplay: add arcturus_is_dpm_running<br=
>
&gt; function for arcturus<br>
&gt; <br>
&gt; add arcturus_is_dpm_running function<br>
&gt; <br>
&gt; Signed-off-by: Chengming Gui &lt;Jack.Gui-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 21<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 21 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; index 03ce871..9107beb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; @@ -51,6 &#43;51,15 @@<br>
&gt;&nbsp; #define SMU_FEATURES_HIGH_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0xFFFFFFFF00000000<br>
&gt;&nbsp; #define SMU_FEATURES_HIGH_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32=
<br>
&gt; <br>
&gt; &#43;#define SMC_DPM_FEATURE ( \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_PREFETCHER_MASK | \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_GFXCLK_MASK | \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_UCLK_MASK | \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_SOCCLK_MASK | \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_MP0CLK_MASK | \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_FCLK_MASK | \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_XGMI_MASK)<br>
&gt; &#43;<br>
&gt;&nbsp; /* possible frequency drift (1Mhz) */<br>
&gt;&nbsp; #define EPSILON&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
&gt; <br>
&gt; @@ -1873,6 &#43;1882,17 @@ static void arcturus_dump_pptable(struct<br=
>
&gt; smu_context *smu)<br>
&gt; <br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; &#43;static bool arcturus_is_dpm_running(struct smu_context *smu) {<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long feature_enabled;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_get_enabled_mask(smu=
, feature_mask, 2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; feature_enabled =3D (unsigned long)((uin=
t64_t)feature_mask[0] |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
(uint64_t)feature_mask[1] &lt;&lt; 32));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return !!(feature_enabled &amp; SMC_DPM_=
FEATURE); }<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct pptable_funcs arcturus_ppt_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* translate smu index into =
arcturus specific index */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_msg_index =3D arctu=
rus_get_smu_msg_index, @@ -1910,6<br>
&gt; &#43;1930,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* debug (internal used) */<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dump_pptable =3D arcturus_d=
ump_pptable,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_limit =3D arcturu=
s_get_power_limit,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .is_dpm_running =3D arcturus_is_dpm_runn=
ing,<br>
&gt;&nbsp; };<br>
&gt; <br>
&gt;&nbsp; void arcturus_set_ppt_funcs(struct smu_context *smu)<br>
&gt; --<br>
&gt; 2.7.4<br>
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
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296807CB0DAC9F94D795E56A2D30MN2PR12MB3296namp_--

--===============1464525492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1464525492==--
