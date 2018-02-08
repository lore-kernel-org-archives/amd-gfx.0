From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Expose new interface to DC to ctrl auto
 wattman
Date: Thu, 8 Feb 2018 15:07:41 +0000
Message-ID: <CY4PR12MB16870B662724C2F6BD1A8014FBF30@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1518088825-4744-1-git-send-email-Rex.Zhu@amd.com>,
 <1a93901f-528c-b28e-d0c0-57809543a759@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1457762782=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1a93901f-528c-b28e-d0c0-57809543a759-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1457762782==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16870B662724C2F6BD1A8014FBF30CY4PR12MB1687namp_"

--_000_CY4PR12MB16870B662724C2F6BD1A8014FBF30CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

when autowattman enabled=1B$B!$=1B(Bwe will update uphyst/downhyst/min-sclk=
/mclk activity  value to smu based on the workload.

Best Regards
Rex

________________________________
From: Wentland, Harry
Sent: Thursday, February 8, 2018 10:22:16 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/pp: Expose new interface to DC to ctrl auto wa=
ttman

On 2018-02-08 06:20 AM, Rex Zhu wrote:
> Disable AutoWattman (if enabled) when FreeSync is enabled.

Do you have a DC change calling this?

What's the use case for this and why do we need to disable AutoWattman when=
 Freesync is enabled?

What does AutoWattman do?

Harry

>
> Change-Id: I9a531321d7913b8b40e60070c569a01c4f202002
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h |  1 +
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c  | 25 ++++++++++++++++++++=
+++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu=
/drm/amd/include/kgd_pp_interface.h
> index 22c2fa3..f7bb565 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -313,6 +313,7 @@ struct amd_pm_funcs {
>        int (*set_power_profile_mode)(void *handle, long *input, uint32_t =
size);
>        int (*odn_edit_dpm_table)(void *handle, uint32_t type, long *input=
, uint32_t size);
>        int (*set_mmhub_powergating_by_smu)(void *handle);
> +     int (*notify_free_sync_change)(void *handle, bool en);
>  };
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/=
drm/amd/powerplay/amd_powerplay.c
> index 376ed2d..d0306b6 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -1555,6 +1555,30 @@ static int pp_set_mmhub_powergating_by_smu(void *h=
andle)
>        return hwmgr->hwmgr_func->set_mmhub_powergating_by_smu(hwmgr);
>  }
>
> +static int pp_notify_free_sync_change(void *handle, bool en)
> +{
> +     struct pp_hwmgr *hwmgr;
> +     struct pp_instance *pp_handle =3D (struct pp_instance *)handle;
> +     int ret =3D 0;
> +
> +     ret =3D pp_check(pp_handle);
> +
> +     if (ret)
> +             return ret;
> +
> +     hwmgr =3D pp_handle->hwmgr;
> +
> +     mutex_lock(&pp_handle->pp_lock);
> +     if (hwmgr->autowattman_enabled) {
> +             if (hwmgr->hwmgr_func->start_auto_wattman !=3D NULL) {
> +                     if (!cancel_delayed_work_sync(&hwmgr->wattman_updat=
e_work))
> +                             hwmgr->hwmgr_func->start_auto_wattman(hwmgr=
, en);
> +             }
> +     }
> +     mutex_unlock(&pp_handle->pp_lock);
> +     return 0;
> +}
> +
>  const struct amd_pm_funcs pp_dpm_funcs =3D {
>        .load_firmware =3D pp_dpm_load_fw,
>        .wait_for_fw_loading_complete =3D pp_dpm_fw_loading_complete,
> @@ -1604,4 +1628,5 @@ static int pp_set_mmhub_powergating_by_smu(void *ha=
ndle)
>        .display_clock_voltage_request =3D pp_display_clock_voltage_reques=
t,
>        .get_display_mode_validation_clocks =3D pp_get_display_mode_valida=
tion_clocks,
>        .set_mmhub_powergating_by_smu =3D pp_set_mmhub_powergating_by_smu,
> +     .notify_free_sync_change =3D pp_notify_free_sync_change,
>  };
>

--_000_CY4PR12MB16870B662724C2F6BD1A8014FBF30CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
</head>
<body>
when autowattman enabled=1B$B!$=1B(Bwe will update uphyst/downhyst/min-sclk=
/mclk activity&nbsp; value to smu based on the workload.
<br>
<br>
Best Regards<br>
Rex<br>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wentland, Harry<br>
<b>Sent:</b> Thursday, February 8, 2018 10:22:16 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pp: Expose new interface to DC to ctrl =
auto wattman</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2018-02-08 06:20 AM, Rex Zhu wrote:<br>
&gt; Disable AutoWattman (if enabled) when FreeSync is enabled.<br>
<br>
Do you have a DC change calling this?<br>
<br>
What's the use case for this and why do we need to disable AutoWattman when=
 Freesync is enabled?<br>
<br>
What does AutoWattman do?<br>
<br>
Harry<br>
<br>
&gt; <br>
&gt; Change-Id: I9a531321d7913b8b40e60070c569a01c4f202002<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/include/kgd_pp_interface.h |&nbsp; 1 &#43;<b=
r>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp; | 25 &#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 2 files changed, 26 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/=
gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; index 22c2fa3..f7bb565 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; @@ -313,6 &#43;313,7 @@ struct amd_pm_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_profile_mode=
)(void *handle, long *input, uint32_t size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*odn_edit_dpm_table)(vo=
id *handle, uint32_t type, long *input, uint32_t size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_mmhub_powergating_=
by_smu)(void *handle);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_free_sync_change)(void *han=
dle, bool en);<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; index 376ed2d..d0306b6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; @@ -1555,6 &#43;1555,30 @@ static int pp_set_mmhub_powergating_by_smu(=
void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-=
&gt;set_mmhub_powergating_by_smu(hwmgr);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;static int pp_notify_free_sync_change(void *handle, bool en)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_instance *pp_handle =3D (struc=
t pp_instance *)handle;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(pp_handle);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr =3D pp_handle-&gt;hwmgr;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pp_handle-&gt;pp_lock);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;autowattman_enabled) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;start_auto_wattman !=3D NULL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cancel_delayed=
_work_sync(&amp;hwmgr-&gt;wattman_update_work))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;start_auto_wattman(hw=
mgr, en);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pp_handle-&gt;pp_lock)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; const struct amd_pm_funcs pp_dpm_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_firmware =3D pp_dpm_lo=
ad_fw,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_fw_loading_complet=
e =3D pp_dpm_fw_loading_complete,<br>
&gt; @@ -1604,4 &#43;1628,5 @@ static int pp_set_mmhub_powergating_by_smu(v=
oid *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_voltage_reque=
st =3D pp_display_clock_voltage_request,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_display_mode_validation=
_clocks =3D pp_get_display_mode_validation_clocks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mmhub_powergating_by_sm=
u =3D pp_set_mmhub_powergating_by_smu,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .notify_free_sync_change =3D pp_notify_f=
ree_sync_change,<br>
&gt;&nbsp; };<br>
&gt; <br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB16870B662724C2F6BD1A8014FBF30CY4PR12MB1687namp_--

--===============1457762782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1457762782==--
