From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mode on smu7
Date: Wed, 24 Jan 2018 20:56:51 +0000
Message-ID: <CY4PR12MB1687F47D96E982B4D6C57C6DFBE20@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1516786649-14914-1-git-send-email-Rex.Zhu@amd.com>
 <1516786649-14914-4-git-send-email-Rex.Zhu@amd.com>
 <e21a2657-7a80-5b59-6c1c-a578d3bf79a9@amd.com>
 <CY4PR12MB1687B4CBFF3BC4DD121752A4FBE20@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <2a05588c-f998-8fca-dad3-3a01677b51ec@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0446507973=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2a05588c-f998-8fca-dad3-3a01677b51ec-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0446507973==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687F47D96E982B4D6C57C6DFBE20CY4PR12MB1687namp_"

--_000_CY4PR12MB1687F47D96E982B4D6C57C6DFBE20CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yes.

Best Regards
Rex
________________________________
From: Huang, JinHuiEric
Sent: Thursday, January 25, 2018 4:47:23 AM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mode on sm=
u7


Hi Rex,

So you intend to separate previous one integrated profile parameters into t=
wo sets implemented by two/three sysfs entries.

Regards,
Eric

On 2018-01-24 03:13 PM, Zhu, Rex wrote:
Hi Eric,

We have sysfs pp-dpm-sclk/mclk to set min dpm level

Best Regards
Rex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>=
<mailto:jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, January 25, 2018 12:04:55 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mode on sm=
u7

We have min_sclk and min_mclk in previous power profile parameters for
VI, which are similar with min_active_level for Vega10. How to implement
these parameters?

Regards,
Eric

On 2018-01-24 04:37 AM, Rex Zhu wrote:
> User can set smu7 profile pamameters through sysfs
>
> echo "0/1/2/3/4">pp_power_profile_mode
> to select 3D_FULL_SCREEN/POWER_SAVING/VIDEO/VR/COMPUTE
> mode.
> echo "5 * * * * * * * *">pp_power_profile_mode
> to config custom mode.
> "5 * * * * * * * *" mean "CUSTOM enable_sclk SCLK_UP_HYST
> SCLK_DOWN_HYST SCLK_ACTIVE_LEVEL enable_mclk MCLK_UP_HYST
> MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL"
>
> Change-Id: Ic6d6f37363bc81ab17051285f6ace847edf725de
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org><mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 49 +++++++++++++++++=
++++++-
>   1 file changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index 9f6afd5..13db75c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -5036,7 +5036,54 @@ static int smu7_get_power_profile_mode(struct pp_h=
wmgr *hwmgr, char *buf)
>
>   static int smu7_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *in=
put, uint32_t size)
>   {
> -     /* To Do */
> +     struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
> +     struct profile_mode_setting tmp;
> +
> +     hwmgr->power_profile_mode =3D input[size];
> +
> +     switch (hwmgr->power_profile_mode) {
> +     case PP_SMC_POWER_PROFILE_CUSTOM:
> +             if (size < 8)
> +                     return -EINVAL;
> +
> +             data->custom_profile_setting.bupdate_sclk =3D input[0];
> +             data->custom_profile_setting.sclk_up_hyst =3D input[1];
> +             data->custom_profile_setting.sclk_down_hyst =3D input[2];
> +             data->custom_profile_setting.sclk_activity =3D  input[3];
> +             data->custom_profile_setting.bupdate_mclk =3D input[4];
> +             data->custom_profile_setting.mclk_up_hyst =3D input[5];
> +             data->custom_profile_setting.mclk_down_hyst =3D input[6];
> +             data->custom_profile_setting.mclk_activity =3D  input[7];
> +             if (!smum_update_dpm_settings(hwmgr, &data->custom_profile_=
setting))
> +                     memcpy(&data->current_profile_setting, &data->custo=
m_profile_setting, sizeof(struct profile_mode_setting));
> +             break;
> +     case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
> +     case PP_SMC_POWER_PROFILE_POWERSAVING:
> +     case PP_SMC_POWER_PROFILE_VIDEO:
> +     case PP_SMC_POWER_PROFILE_VR:
> +     case PP_SMC_POWER_PROFILE_COMPUTE:
> +             memcpy(&tmp, &smu7_profiling[hwmgr->power_profile_mode], si=
zeof(struct profile_mode_setting));
> +             if (!smum_update_dpm_settings(hwmgr, &tmp)) {
> +                     if (tmp.bupdate_sclk) {
> +                             data->current_profile_setting.bupdate_sclk =
=3D tmp.bupdate_sclk;
> +                             data->current_profile_setting.sclk_up_hyst =
=3D tmp.sclk_up_hyst;
> +                             data->current_profile_setting.sclk_down_hys=
t =3D tmp.sclk_down_hyst;
> +                             data->current_profile_setting.sclk_activity=
 =3D tmp.sclk_activity;
> +                     }
> +                     if (tmp.bupdate_mclk) {
> +                             data->current_profile_setting.bupdate_mclk =
=3D tmp.bupdate_mclk;
> +                             data->current_profile_setting.mclk_up_hyst =
=3D tmp.mclk_up_hyst;
> +                             data->current_profile_setting.mclk_down_hys=
t =3D tmp.mclk_down_hyst;
> +                             data->current_profile_setting.mclk_activity=
 =3D tmp.mclk_activity;
> +                     }
> +             }
> +             break;
> +     case PP_SMC_POWER_PROFILE_AUTO: /* TO DO auto wattman feature not i=
mplement */
> +             return 0;
> +     default:
> +             return -EINVAL;
> +     }
> +
>        return 0;
>   }
>

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_CY4PR12MB1687F47D96E982B4D6C57C6DFBE20CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
Yes. <br>
<br>
Best Regards<br>
Rex
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, JinHuiEric<br>
<b>Sent:</b> Thursday, January 25, 2018 4:47:23 AM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mod=
e on smu7</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<p>Hi Rex,</p>
<p>So you intend to separate previous one integrated profile parameters int=
o two sets implemented by two/three sysfs entries.<br>
</p>
Regards,<br>
Eric<br>
<br>
<div class=3D"x_moz-cite-prefix">On 2018-01-24 03:13 PM, Zhu, Rex wrote:<br=
>
</div>
<blockquote type=3D"cite">Hi Eric,<br>
<br>
We have sysfs pp-dpm-sclk/mclk to set min dpm level<br>
<br>
Best Regards<br>
Rex
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Eric Huang <=
a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:jinhuieric.huang-5C7GfCeVMHo@public.gmane.org=
">
&lt;jinhuieric.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Thursday, January 25, 2018 12:04:55 AM<br>
<b>To:</b> <a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@l=
ists.freedesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mod=
e on smu7</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">We have min_sclk and min_mclk in previous power =
profile parameters for
<br>
VI, which are similar with min_active_level for Vega10. How to implement <b=
r>
these parameters?<br>
<br>
Regards,<br>
Eric<br>
<br>
On 2018-01-24 04:37 AM, Rex Zhu wrote:<br>
&gt; User can set smu7 profile pamameters through sysfs<br>
&gt;<br>
&gt; echo &quot;0/1/2/3/4&quot;&gt;pp_power_profile_mode<br>
&gt; to select 3D_FULL_SCREEN/POWER_SAVING/VIDEO/VR/COMPUTE<br>
&gt; mode.<br>
&gt; echo &quot;5 * * * * * * * *&quot;&gt;pp_power_profile_mode<br>
&gt; to config custom mode.<br>
&gt; &quot;5 * * * * * * * *&quot; mean &quot;CUSTOM enable_sclk SCLK_UP_HY=
ST<br>
&gt; SCLK_DOWN_HYST SCLK_ACTIVE_LEVEL enable_mclk MCLK_UP_HYST<br>
&gt; MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL&quot;<br>
&gt;<br>
&gt; Change-Id: Ic6d6f37363bc81ab17051285f6ace847edf725de<br>
&gt; Signed-off-by: Rex Zhu <a class=3D"x_moz-txt-link-rfc2396E" href=3D"ma=
ilto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">
&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 49 &#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; 1 file changed, 48 insertions(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; index 9f6afd5..13db75c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; @@ -5036,7 &#43;5036,54 @@ static int smu7_get_power_profile_mode(stru=
ct pp_hwmgr *hwmgr, char *buf)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int smu7_set_power_profile_mode(struct pp_hwmgr *hw=
mgr, long *input, uint32_t size)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* To Do */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D (struct smu7=
_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct profile_mode_setting tmp;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mode =3D input[s=
ize];<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (hwmgr-&gt;power_profile_mode) {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_CUSTOM:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size &lt; 8)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;custom_profile_setting.bupdate_sclk =3D input[0];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;custom_profile_setting.sclk_up_hyst =3D input[1];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;custom_profile_setting.sclk_down_hyst =3D input[2];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;custom_profile_setting.sclk_activity =3D&nbsp; input[3];<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;custom_profile_setting.bupdate_mclk =3D input[4];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;custom_profile_setting.mclk_up_hyst =3D input[5];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;custom_profile_setting.mclk_down_hyst =3D input[6];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data-&gt;custom_profile_setting.mclk_activity =3D&nbsp; input[7];<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!smum_update_dpm_settings(hwmgr, &amp;data-&gt;custom_profile_s=
etting))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;data-&g=
t;current_profile_setting, &amp;data-&gt;custom_profile_setting, sizeof(str=
uct profile_mode_setting));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_FULLSCREEN3D:<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_POWERSAVING:<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_VIDEO:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_VR:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_COMPUTE:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; memcpy(&amp;tmp, &amp;smu7_profiling[hwmgr-&gt;power_profile_mode],=
 sizeof(struct profile_mode_setting));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!smum_update_dpm_settings(hwmgr, &amp;tmp)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp.bupdate_scl=
k) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_setting.bupdate_sclk =
=3D tmp.bupdate_sclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_setting.sclk_up_hyst =
=3D tmp.sclk_up_hyst;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_setting.sclk_down_hys=
t =3D tmp.sclk_down_hyst;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_setting.sclk_activity=
 =3D tmp.sclk_activity;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp.bupdate_mcl=
k) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_setting.bupdate_mclk =
=3D tmp.bupdate_mclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_setting.mclk_up_hyst =
=3D tmp.mclk_up_hyst;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_setting.mclk_down_hys=
t =3D tmp.mclk_down_hyst;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_setting.mclk_activity=
 =3D tmp.mclk_activity;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_AUTO: /* TO DO=
 auto wattman feature not implement */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</blockquote>
<br>
</div>
</body>
</html>

--_000_CY4PR12MB1687F47D96E982B4D6C57C6DFBE20CY4PR12MB1687namp_--

--===============0446507973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0446507973==--
