From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amd/pp: Add new smu callback function
Date: Thu, 25 Jan 2018 23:15:10 +0000
Message-ID: <CY4PR12MB168701E9A698764CDCC6D278FBE10@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1516786649-14914-1-git-send-email-Rex.Zhu@amd.com>,
 <cba449fc-1e35-382f-919d-e429d325a553@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0092845992=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cba449fc-1e35-382f-919d-e429d325a553-5C7GfCeVMHo@public.gmane.org>
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

--===============0092845992==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB168701E9A698764CDCC6D278FBE10CY4PR12MB1687namp_"

--_000_CY4PR12MB168701E9A698764CDCC6D278FBE10CY4PR12MB1687namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

For the power containment issue on Fiji.
We want to expose set power limit function.
Maybe we can adjust the power limit instand of just disable this feature.
But I am not sure this can meet kfd =91 s requirement.

Best Regards
Rex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Eric Hua=
ng <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, January 26, 2018 12:18:45 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/4] drm/amd/pp: Add new smu callback function

Hi Rex,

Why don't you use function smum_populate_requested_graphic_levels()
which is doing exactly the same thing as the function you add ?

And in old power profile setting function
smu7_set_power_profile_state(), we implement this:

if (hwmgr->chip_id =3D=3D CHIP_FIJI) {
         if (request->type =3D=3D AMD_PP_GFX_PROFILE)
             smu7_enable_power_containment(hwmgr);
         else if (request->type =3D=3D AMD_PP_COMPUTE_PROFILE)
             smu7_disable_power_containment(hwmgr);
     }

This should be merged into your new power profile setting.

Regards,
Eric

On 2018-01-24 04:37 AM, Rex Zhu wrote:
> it is used for update dpm settings
>
> Change-Id: Idc0362c219d84564693ca90adf9299e56cfeb6a4
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     | 1 +
>   drivers/gpu/drm/amd/powerplay/inc/smumgr.h    | 1 +
>   drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c | 8 ++++++++
>   3 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/=
amd/powerplay/inc/hwmgr.h
> index 604a7cb..3e8959e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -238,6 +238,7 @@ struct pp_smumgr_func {
>        int (*populate_requested_graphic_levels)(struct pp_hwmgr *hwmgr,
>                        struct amd_pp_profile *request);
>        bool (*is_hw_avfs_present)(struct pp_hwmgr  *hwmgr);
> +     int (*update_dpm_settings)(struct pp_hwmgr *hwmgr, void *profile_se=
tting);
>   };
>
>   struct pp_hwmgr_func {
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h b/drivers/gpu/drm=
/amd/powerplay/inc/smumgr.h
> index b1b27b2..e05a57e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> @@ -134,5 +134,6 @@ extern int smum_populate_requested_graphic_levels(str=
uct pp_hwmgr *hwmgr,
>
>   extern bool smum_is_hw_avfs_present(struct pp_hwmgr *hwmgr);
>
> +extern int smum_update_dpm_settings(struct pp_hwmgr *hwmgr, void *profil=
e_setting);
>
>   #endif
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c b/drivers/gpu/=
drm/amd/powerplay/smumgr/smumgr.c
> index 8673884..1ce4959 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
> @@ -253,3 +253,11 @@ bool smum_is_hw_avfs_present(struct pp_hwmgr *hwmgr)
>
>        return false;
>   }
> +
> +int smum_update_dpm_settings(struct pp_hwmgr *hwmgr, void *profile_setti=
ng)
> +{
> +     if (hwmgr->smumgr_funcs->update_dpm_settings)
> +             return hwmgr->smumgr_funcs->update_dpm_settings(hwmgr, prof=
ile_setting);
> +
> +     return -EINVAL;
> +}

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB168701E9A698764CDCC6D278FBE10CY4PR12MB1687namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
For the power containment issue on Fiji.<br>
We want to expose set power limit function.<br>
Maybe we can adjust the power limit instand of just disable this feature.<b=
r>
But I am not sure this can meet kfd =91 s requirement.<br>
<br>
Best Regards<br>
Rex<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Eric Huang &lt;jinhuieric.hua=
ng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, January 26, 2018 12:18:45 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/4] drm/amd/pp: Add new smu callback function</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Rex,<br>
<br>
Why don't you use function smum_populate_requested_graphic_levels() <br>
which is doing exactly the same thing as the function you add ?<br>
<br>
And in old power profile setting function <br>
smu7_set_power_profile_state(), we implement this:<br>
<br>
if (hwmgr-&gt;chip_id =3D=3D CHIP_FIJI) {<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (request-&gt;type =3D=3D AMD=
_PP_GFX_PROFILE)<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; smu7_enable_=
power_containment(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; else if (request-&gt;type =3D=
=3D AMD_PP_COMPUTE_PROFILE)<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; smu7_disable=
_power_containment(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
This should be merged into your new power profile setting.<br>
<br>
Regards,<br>
Eric<br>
<br>
On 2018-01-24 04:37 AM, Rex Zhu wrote:<br>
&gt; it is used for update dpm settings<br>
&gt;<br>
&gt; Change-Id: Idc0362c219d84564693ca90adf9299e56cfeb6a4<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp=
;&nbsp; | 1 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/inc/smumgr.h&nbsp;&nbsp;&nbs=
p; | 1 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c | 8 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 3 files changed, 10 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/d=
rm/amd/powerplay/inc/hwmgr.h<br>
&gt; index 604a7cb..3e8959e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; @@ -238,6 &#43;238,7 @@ struct pp_smumgr_func {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*populate_requested_gra=
phic_levels)(struct pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
amd_pp_profile *request);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*is_hw_avfs_present)(s=
truct pp_hwmgr&nbsp; *hwmgr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int (*update_dpm_settings)(struct pp_hwm=
gr *hwmgr, void *profile_setting);<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct pp_hwmgr_func {<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h b/drivers/gpu/=
drm/amd/powerplay/inc/smumgr.h<br>
&gt; index b1b27b2..e05a57e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
&gt; @@ -134,5 &#43;134,6 @@ extern int smum_populate_requested_graphic_lev=
els(struct pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; extern bool smum_is_hw_avfs_present(struct pp_hwmgr *hwmgr=
);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;extern int smum_update_dpm_settings(struct pp_hwmgr *hwmgr, void =
*profile_setting);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smumgr.c<br>
&gt; index 8673884..1ce4959 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c<br>
&gt; @@ -253,3 &#43;253,11 @@ bool smum_is_hw_avfs_present(struct pp_hwmgr =
*hwmgr)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;int smum_update_dpm_settings(struct pp_hwmgr *hwmgr, void *profil=
e_setting)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs-&gt;update_dp=
m_settings)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return hwmgr-&gt;smumgr_funcs-&gt;update_dpm_settings(hwmgr, profil=
e_setting);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;}<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB168701E9A698764CDCC6D278FBE10CY4PR12MB1687namp_--

--===============0092845992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0092845992==--
