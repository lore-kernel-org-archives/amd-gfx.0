From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: correct Vega20 dpm level related
 settings
Date: Thu, 22 Aug 2019 12:49:11 +0000
Message-ID: <BN6PR12MB1809F9E59D061C18B1093ACEF7A50@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190821084143.25713-1-evan.quan@amd.com>,
 <MN2PR12MB3344CC59152485D92985287BE4A50@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1513642333=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344CC59152485D92985287BE4A50-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1513642333==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F9E59D061C18B1093ACEF7A50BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F9E59D061C18B1093ACEF7A50BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 22, 2019 6:21 AM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/2] drm/amd/powerplay: correct Vega20 dpm level relate=
d settings

Ping..

> -----Original Message-----
> From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> Sent: Wednesday, August 21, 2019 4:42 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 1/2] drm/amd/powerplay: correct Vega20 dpm level related
> settings
>
> Correct the settings for auto mode and skip the unnecessary settings for
> dcefclk and fclk.
>
> Change-Id: I7e6ca75ce86b4d5cd44920a9fbc71b6f36ea3c49
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> ---
>  .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 60
> +++++++++++++++++--
>  1 file changed, 54 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> index 0516c294b377..cc52d5c8ccf9 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> @@ -2349,12 +2349,16 @@ static int vega20_force_dpm_highest(struct
> pp_hwmgr *hwmgr)
>                data->dpm_table.soc_table.dpm_state.soft_max_level =3D
>                data->dpm_table.soc_table.dpm_levels[soft_level].value;
>
> -     ret =3D vega20_upload_dpm_min_level(hwmgr, 0xFFFFFFFF);
> +     ret =3D vega20_upload_dpm_min_level(hwmgr,
> FEATURE_DPM_GFXCLK_MASK |
> +                                              FEATURE_DPM_UCLK_MASK
> |
> +
> FEATURE_DPM_SOCCLK_MASK);
>        PP_ASSERT_WITH_CODE(!ret,
>                        "Failed to upload boot level to highest!",
>                        return ret);
>
> -     ret =3D vega20_upload_dpm_max_level(hwmgr, 0xFFFFFFFF);
> +     ret =3D vega20_upload_dpm_max_level(hwmgr,
> FEATURE_DPM_GFXCLK_MASK |
> +                                              FEATURE_DPM_UCLK_MASK
> |
> +
> FEATURE_DPM_SOCCLK_MASK);
>        PP_ASSERT_WITH_CODE(!ret,
>                        "Failed to upload dpm max level to highest!",
>                        return ret);
> @@ -2387,12 +2391,16 @@ static int vega20_force_dpm_lowest(struct
> pp_hwmgr *hwmgr)
>                data->dpm_table.soc_table.dpm_state.soft_max_level =3D
>                data->dpm_table.soc_table.dpm_levels[soft_level].value;
>
> -     ret =3D vega20_upload_dpm_min_level(hwmgr, 0xFFFFFFFF);
> +     ret =3D vega20_upload_dpm_min_level(hwmgr,
> FEATURE_DPM_GFXCLK_MASK |
> +                                              FEATURE_DPM_UCLK_MASK
> |
> +
> FEATURE_DPM_SOCCLK_MASK);
>        PP_ASSERT_WITH_CODE(!ret,
>                        "Failed to upload boot level to highest!",
>                        return ret);
>
> -     ret =3D vega20_upload_dpm_max_level(hwmgr, 0xFFFFFFFF);
> +     ret =3D vega20_upload_dpm_max_level(hwmgr,
> FEATURE_DPM_GFXCLK_MASK |
> +                                              FEATURE_DPM_UCLK_MASK
> |
> +
> FEATURE_DPM_SOCCLK_MASK);
>        PP_ASSERT_WITH_CODE(!ret,
>                        "Failed to upload dpm max level to highest!",
>                        return ret);
> @@ -2403,14 +2411,54 @@ static int vega20_force_dpm_lowest(struct
> pp_hwmgr *hwmgr)
>
>  static int vega20_unforce_dpm_levels(struct pp_hwmgr *hwmgr)  {
> +     struct vega20_hwmgr *data =3D
> +                     (struct vega20_hwmgr *)(hwmgr->backend);
> +     uint32_t soft_min_level, soft_max_level;
>        int ret =3D 0;
>
> -     ret =3D vega20_upload_dpm_min_level(hwmgr, 0xFFFFFFFF);
> +     /* gfxclk soft min/max settings */
> +     soft_min_level =3D
> +             vega20_find_lowest_dpm_level(&(data-
> >dpm_table.gfx_table));
> +     soft_max_level =3D
> +             vega20_find_highest_dpm_level(&(data-
> >dpm_table.gfx_table));
> +
> +     data->dpm_table.gfx_table.dpm_state.soft_min_level =3D
> +             data-
> >dpm_table.gfx_table.dpm_levels[soft_min_level].value;
> +     data->dpm_table.gfx_table.dpm_state.soft_max_level =3D
> +             data-
> >dpm_table.gfx_table.dpm_levels[soft_max_level].value;
> +
> +     /* uclk soft min/max settings */
> +     soft_min_level =3D
> +             vega20_find_lowest_dpm_level(&(data-
> >dpm_table.mem_table));
> +     soft_max_level =3D
> +             vega20_find_highest_dpm_level(&(data-
> >dpm_table.mem_table));
> +
> +     data->dpm_table.mem_table.dpm_state.soft_min_level =3D
> +             data-
> >dpm_table.mem_table.dpm_levels[soft_min_level].value;
> +     data->dpm_table.mem_table.dpm_state.soft_max_level =3D
> +             data-
> >dpm_table.mem_table.dpm_levels[soft_max_level].value;
> +
> +     /* socclk soft min/max settings */
> +     soft_min_level =3D
> +             vega20_find_lowest_dpm_level(&(data-
> >dpm_table.soc_table));
> +     soft_max_level =3D
> +             vega20_find_highest_dpm_level(&(data-
> >dpm_table.soc_table));
> +
> +     data->dpm_table.soc_table.dpm_state.soft_min_level =3D
> +             data-
> >dpm_table.soc_table.dpm_levels[soft_min_level].value;
> +     data->dpm_table.soc_table.dpm_state.soft_max_level =3D
> +             data-
> >dpm_table.soc_table.dpm_levels[soft_max_level].value;
> +
> +     ret =3D vega20_upload_dpm_min_level(hwmgr,
> FEATURE_DPM_GFXCLK_MASK |
> +                                              FEATURE_DPM_UCLK_MASK
> |
> +
> FEATURE_DPM_SOCCLK_MASK);
>        PP_ASSERT_WITH_CODE(!ret,
>                        "Failed to upload DPM Bootup Levels!",
>                        return ret);
>
> -     ret =3D vega20_upload_dpm_max_level(hwmgr, 0xFFFFFFFF);
> +     ret =3D vega20_upload_dpm_max_level(hwmgr,
> FEATURE_DPM_GFXCLK_MASK |
> +                                              FEATURE_DPM_UCLK_MASK
> |
> +
> FEATURE_DPM_SOCCLK_MASK);
>        PP_ASSERT_WITH_CODE(!ret,
>                        "Failed to upload DPM Max Levels!",
>                        return ret);
> --
> 2.23.0


--_000_BN6PR12MB1809F9E59D061C18B1093ACEF7A50BN6PR12MB1809namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 22, 2019 6:21 AM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amd/powerplay: correct Vega20 dpm level=
 related settings</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping..<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Wednesday, August 21, 2019 4:42 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH 1/2] drm/amd/powerplay: correct Vega20 dpm level relat=
ed<br>
&gt; settings<br>
&gt; <br>
&gt; Correct the settings for auto mode and skip the unnecessary settings f=
or<br>
&gt; dcefclk and fclk.<br>
&gt; <br>
&gt; Change-Id: I7e6ca75ce86b4d5cd44920a9fbc71b6f36ea3c49<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp; | 6=
0<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;--<br>
&gt;&nbsp; 1 file changed, 54 insertions(&#43;), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; index 0516c294b377..cc52d5c8ccf9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<b=
r>
&gt; @@ -2349,12 &#43;2349,16 @@ static int vega20_force_dpm_highest(struct=
<br>
&gt; pp_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.soc_table.dpm_state.soft_max_level =
=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.soc_table.dpm_levels[soft_level].val=
ue;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_min_level(hwmgr, 0=
xFFFFFFFF);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_min_level(hwmg=
r,<br>
&gt; FEATURE_DPM_GFXCLK_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_UCLK_MA=
SK<br>
&gt; |<br>
&gt; &#43;<br>
&gt; FEATURE_DPM_SOCCLK_MASK);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;F=
ailed to upload boot level to highest!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_max_level(hwmgr, 0=
xFFFFFFFF);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_max_level(hwmg=
r,<br>
&gt; FEATURE_DPM_GFXCLK_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_UCLK_MA=
SK<br>
&gt; |<br>
&gt; &#43;<br>
&gt; FEATURE_DPM_SOCCLK_MASK);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;F=
ailed to upload dpm max level to highest!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret);<br>
&gt; @@ -2387,12 &#43;2391,16 @@ static int vega20_force_dpm_lowest(struct<=
br>
&gt; pp_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.soc_table.dpm_state.soft_max_level =
=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.soc_table.dpm_levels[soft_level].val=
ue;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_min_level(hwmgr, 0=
xFFFFFFFF);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_min_level(hwmg=
r,<br>
&gt; FEATURE_DPM_GFXCLK_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_UCLK_MA=
SK<br>
&gt; |<br>
&gt; &#43;<br>
&gt; FEATURE_DPM_SOCCLK_MASK);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;F=
ailed to upload boot level to highest!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_max_level(hwmgr, 0=
xFFFFFFFF);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_max_level(hwmg=
r,<br>
&gt; FEATURE_DPM_GFXCLK_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_UCLK_MA=
SK<br>
&gt; |<br>
&gt; &#43;<br>
&gt; FEATURE_DPM_SOCCLK_MASK);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;F=
ailed to upload dpm max level to highest!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret);<br>
&gt; @@ -2403,14 &#43;2411,54 @@ static int vega20_force_dpm_lowest(struct<=
br>
&gt; pp_hwmgr *hwmgr)<br>
&gt; <br>
&gt;&nbsp; static int vega20_unforce_dpm_levels(struct pp_hwmgr *hwmgr)&nbs=
p; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct vega20_hwmg=
r *)(hwmgr-&gt;backend);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t soft_min_level, soft_max_level;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_min_level(hwmgr, 0=
xFFFFFFFF);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* gfxclk soft min/max settings */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; soft_min_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vega20_find_lowest_dpm_level(&amp;(data-<br>
&gt; &gt;dpm_table.gfx_table));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; soft_max_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vega20_find_highest_dpm_level(&amp;(data-<br>
&gt; &gt;dpm_table.gfx_table));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.gfx_table.dpm_state.s=
oft_min_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-<br>
&gt; &gt;dpm_table.gfx_table.dpm_levels[soft_min_level].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.gfx_table.dpm_state.s=
oft_max_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-<br>
&gt; &gt;dpm_table.gfx_table.dpm_levels[soft_max_level].value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* uclk soft min/max settings */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; soft_min_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vega20_find_lowest_dpm_level(&amp;(data-<br>
&gt; &gt;dpm_table.mem_table));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; soft_max_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vega20_find_highest_dpm_level(&amp;(data-<br>
&gt; &gt;dpm_table.mem_table));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.mem_table.dpm_state.s=
oft_min_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-<br>
&gt; &gt;dpm_table.mem_table.dpm_levels[soft_min_level].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.mem_table.dpm_state.s=
oft_max_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-<br>
&gt; &gt;dpm_table.mem_table.dpm_levels[soft_max_level].value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* socclk soft min/max settings */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; soft_min_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vega20_find_lowest_dpm_level(&amp;(data-<br>
&gt; &gt;dpm_table.soc_table));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; soft_max_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vega20_find_highest_dpm_level(&amp;(data-<br>
&gt; &gt;dpm_table.soc_table));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.soc_table.dpm_state.s=
oft_min_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-<br>
&gt; &gt;dpm_table.soc_table.dpm_levels[soft_min_level].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_table.soc_table.dpm_state.s=
oft_max_level =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-<br>
&gt; &gt;dpm_table.soc_table.dpm_levels[soft_max_level].value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_min_level(hwmg=
r,<br>
&gt; FEATURE_DPM_GFXCLK_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_UCLK_MA=
SK<br>
&gt; |<br>
&gt; &#43;<br>
&gt; FEATURE_DPM_SOCCLK_MASK);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;F=
ailed to upload DPM Bootup Levels!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_max_level(hwmgr, 0=
xFFFFFFFF);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_upload_dpm_max_level(hwmg=
r,<br>
&gt; FEATURE_DPM_GFXCLK_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_DPM_UCLK_MA=
SK<br>
&gt; |<br>
&gt; &#43;<br>
&gt; FEATURE_DPM_SOCCLK_MASK);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;F=
ailed to upload DPM Max Levels!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret);<br>
&gt; --<br>
&gt; 2.23.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809F9E59D061C18B1093ACEF7A50BN6PR12MB1809namp_--

--===============1513642333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1513642333==--
