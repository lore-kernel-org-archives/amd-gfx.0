From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
 power_dpm_force_performance_level
Date: Fri, 26 Jan 2018 00:07:05 +0000
Message-ID: <CY4PR12MB1687930CD8F44390C3791A63FBE10@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1516879614-11533-1-git-send-email-Rex.Zhu@amd.com>,
 <51c6111b-78ec-36f8-b5e0-4a23ccea6de4@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0073880318=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <51c6111b-78ec-36f8-b5e0-4a23ccea6de4-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0073880318==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687930CD8F44390C3791A63FBE10CY4PR12MB1687namp_"

--_000_CY4PR12MB1687930CD8F44390C3791A63FBE10CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I also think about this problem.
just think user should unforced clk level through pp dpm sclk/mclk/pcie if =
they change the clock logic through those sysfs.

The logic seems weird, As we supply many sysfs for adjust clock range.

We can fix this problem by change current mode to manual mode after user ca=
ll pp dpm sclk/mclk/pcie.

But another think?if user change back the clk range through pp dpm clk.

we are in manual mode, and user set auto mode, in fact, driver change nothi=
ng.

Comparatively speaking, better set manual mode after user call pp dpm clk.
Thanks very much.

Best Regards
Rex
________________________________
From: Kuehling, Felix
Sent: Friday, January 26, 2018 12:55:19 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex
Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for power_dpm_force=
_performance_level

This patch breaks unforcing of clocks, which is currently done by
switching back from "manual" to "auto". By removing "manual" mode, you
remove the ability to unset forced clocks.

Regards,
  Felix


On 2018-01-25 06:26 AM, Rex Zhu wrote:
> Driver do not maintain manual mode for dpm_force_performance_level,
> User can set sclk/mclk/pcie range through pp_dpm_sclk/pp_dpm_mclk/pp_dpm_=
pcie
> directly.
>
> In order to not break currently tools,
> when set "manual" to power_dpm_force_performance_level
> driver will do nothing and just return successful.
>
> Change-Id: Iaf672b9abc7fa57b765ceb7fa2fba6ad3e80c50b
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  3 +--
>  drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |  5 -----
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h     | 15 +++++++--------
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     |  4 ----
>  drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c     |  1 -
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  6 ------
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  6 ------
>  7 files changed, 8 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_pm.c
> index 1812009..66b4df0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -152,7 +152,6 @@ static ssize_t amdgpu_get_dpm_forced_performance_leve=
l(struct device *dev,
>                        (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? "auto" =
:
>                        (level =3D=3D AMD_DPM_FORCED_LEVEL_LOW) ? "low" :
>                        (level =3D=3D AMD_DPM_FORCED_LEVEL_HIGH) ? "high" =
:
> -                     (level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) ? "manua=
l" :
>                        (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_STANDAR=
D) ? "profile_standard" :
>                        (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCL=
K) ? "profile_min_sclk" :
>                        (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCL=
K) ? "profile_min_mclk" :
> @@ -186,7 +185,7 @@ static ssize_t amdgpu_set_dpm_forced_performance_leve=
l(struct device *dev,
>        } else if (strncmp("auto", buf, strlen("auto")) =3D=3D 0) {
>                level =3D AMD_DPM_FORCED_LEVEL_AUTO;
>        } else if (strncmp("manual", buf, strlen("manual")) =3D=3D 0) {
> -             level =3D AMD_DPM_FORCED_LEVEL_MANUAL;
> +             pr_info("No need to set manual mode, Just go ahead\n");
>        } else if (strncmp("profile_exit", buf, strlen("profile_exit")) =
=3D=3D 0) {
>                level =3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT;
>        } else if (strncmp("profile_standard", buf, strlen("profile_standa=
rd")) =3D=3D 0) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/am=
dgpu/ci_dpm.c
> index ab45232..8ddc978 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> @@ -6639,11 +6639,6 @@ static int ci_dpm_force_clock_level(void *handle,
>        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>        struct ci_power_info *pi =3D ci_get_pi(adev);
>
> -     if (adev->pm.dpm.forced_level & (AMD_DPM_FORCED_LEVEL_AUTO |
> -                             AMD_DPM_FORCED_LEVEL_LOW |
> -                             AMD_DPM_FORCED_LEVEL_HIGH))
> -             return -EINVAL;
> -
>        switch (type) {
>        case PP_SCLK:
>                if (!pi->sclk_dpm_key_disabled)
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu=
/drm/amd/include/kgd_pp_interface.h
> index b9aa9f4..3fab686 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -41,14 +41,13 @@ struct amd_vce_state {
>
>  enum amd_dpm_forced_level {
>        AMD_DPM_FORCED_LEVEL_AUTO =3D 0x1,
> -     AMD_DPM_FORCED_LEVEL_MANUAL =3D 0x2,
> -     AMD_DPM_FORCED_LEVEL_LOW =3D 0x4,
> -     AMD_DPM_FORCED_LEVEL_HIGH =3D 0x8,
> -     AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD =3D 0x10,
> -     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK =3D 0x20,
> -     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK =3D 0x40,
> -     AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =3D 0x80,
> -     AMD_DPM_FORCED_LEVEL_PROFILE_EXIT =3D 0x100,
> +     AMD_DPM_FORCED_LEVEL_LOW =3D 0x2,
> +     AMD_DPM_FORCED_LEVEL_HIGH =3D 0x4,
> +     AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD =3D 0x8,
> +     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK =3D 0x10,
> +     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK =3D 0x20,
> +     AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =3D 0x40,
> +     AMD_DPM_FORCED_LEVEL_PROFILE_EXIT =3D 0x80,
>  };
>
>  enum amd_pm_state_type {
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> index dec8dd9..60d280c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> @@ -1250,7 +1250,6 @@ static int cz_dpm_force_dpm_level(struct pp_hwmgr *=
hwmgr,
>        case AMD_DPM_FORCED_LEVEL_AUTO:
>                ret =3D cz_phm_unforce_dpm_levels(hwmgr);
>                break;
> -     case AMD_DPM_FORCED_LEVEL_MANUAL:
>        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>        default:
>                break;
> @@ -1558,9 +1557,6 @@ static int cz_get_dal_power_level(struct pp_hwmgr *=
hwmgr,
>  static int cz_force_clock_level(struct pp_hwmgr *hwmgr,
>                enum pp_clock_type type, uint32_t mask)
>  {
> -     if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
> -             return -EINVAL;
> -
>        switch (type) {
>        case PP_SCLK:
>                smum_send_msg_to_smc_with_parameter(hwmgr,
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> index 409a56b..eddcbcd 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> @@ -605,7 +605,6 @@ static int rv_dpm_force_dpm_level(struct pp_hwmgr *hw=
mgr,
>                                                PPSMC_MSG_SetSoftMaxFclkBy=
Freq,
>                                                RAVEN_UMD_PSTATE_MIN_FCLK)=
;
>                break;
> -     case AMD_DPM_FORCED_LEVEL_MANUAL:
>        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>        default:
>                break;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index 13db75c..e3a8374 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -2798,7 +2798,6 @@ static int smu7_force_dpm_level(struct pp_hwmgr *hw=
mgr,
>                smu7_force_clock_level(hwmgr, PP_MCLK, 1<<mclk_mask);
>                smu7_force_clock_level(hwmgr, PP_PCIE, 1<<pcie_mask);
>                break;
> -     case AMD_DPM_FORCED_LEVEL_MANUAL:
>        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>        default:
>                break;
> @@ -4311,11 +4310,6 @@ static int smu7_force_clock_level(struct pp_hwmgr =
*hwmgr,
>  {
>        struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
>
> -     if (hwmgr->request_dpm_level & (AMD_DPM_FORCED_LEVEL_AUTO |
> -                                     AMD_DPM_FORCED_LEVEL_LOW |
> -                                     AMD_DPM_FORCED_LEVEL_HIGH))
> -             return -EINVAL;
> -
>        switch (type) {
>        case PP_SCLK:
>                if (!data->sclk_dpm_key_disabled)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index 6b28896..828677e 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4241,7 +4241,6 @@ static int vega10_dpm_force_dpm_level(struct pp_hwm=
gr *hwmgr,
>                vega10_force_clock_level(hwmgr, PP_SCLK, 1<<sclk_mask);
>                vega10_force_clock_level(hwmgr, PP_MCLK, 1<<mclk_mask);
>                break;
> -     case AMD_DPM_FORCED_LEVEL_MANUAL:
>        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>        default:
>                break;
> @@ -4500,11 +4499,6 @@ static int vega10_force_clock_level(struct pp_hwmg=
r *hwmgr,
>  {
>        struct vega10_hwmgr *data =3D (struct vega10_hwmgr *)(hwmgr->backe=
nd);
>
> -     if (hwmgr->request_dpm_level & (AMD_DPM_FORCED_LEVEL_AUTO |
> -                             AMD_DPM_FORCED_LEVEL_LOW |
> -                             AMD_DPM_FORCED_LEVEL_HIGH))
> -             return -EINVAL;
> -
>        switch (type) {
>        case PP_SCLK:
>                data->smc_state_table.gfx_boot_level =3D mask ? (ffs(mask)=
 - 1) : 0;


--_000_CY4PR12MB1687930CD8F44390C3791A63FBE10CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
I also think about this problem.<br>
just think user should unforced clk level through pp dpm sclk/mclk/pcie if =
they change the clock logic through those sysfs.<br>
<br>
The logic seems weird, As we supply many sysfs for adjust clock range.<br>
<br>
We can fix this problem by change current mode to manual mode after user ca=
ll pp dpm sclk/mclk/pcie.<br>
<br>
But another think&#65292;if user change back the clk range through pp dpm c=
lk.<br>
<br>
we are in manual mode, and user set auto mode, in fact, driver change nothi=
ng.<br>
<br>
Comparatively speaking, better set manual mode after user call pp dpm clk.<=
br>
Thanks very much.<br>
<br>
Best Regards<br>
Rex<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Friday, January 26, 2018 12:55:19 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for power_dp=
m_force_performance_level</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch breaks unforcing of clocks, which is cu=
rrently done by<br>
switching back from &quot;manual&quot; to &quot;auto&quot;. By removing &qu=
ot;manual&quot; mode, you<br>
remove the ability to unset forced clocks.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
<br>
On 2018-01-25 06:26 AM, Rex Zhu wrote:<br>
&gt; Driver do not maintain manual mode for dpm_force_performance_level,<br=
>
&gt; User can set sclk/mclk/pcie range through pp_dpm_sclk/pp_dpm_mclk/pp_d=
pm_pcie<br>
&gt; directly.<br>
&gt;<br>
&gt; In order to not break currently tools,<br>
&gt; when set &quot;manual&quot; to power_dpm_force_performance_level<br>
&gt; driver will do nothing and just return successful.<br>
&gt;<br>
&gt; Change-Id: Iaf672b9abc7fa57b765ceb7fa2fba6ad3e80c50b<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/ci_dpm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ---=
--<br>
&gt;&nbsp; drivers/gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp;=
&nbsp; | 15 &#43;&#43;&#43;&#43;&#43;&#43;&#43;--------<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 4 ----<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 1 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp; |&n=
bsp; 6 ------<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |&nbsp; 6 ---=
---<br>
&gt;&nbsp; 7 files changed, 8 insertions(&#43;), 32 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.c<br>
&gt; index 1812009..66b4df0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; @@ -152,7 &#43;152,6 @@ static ssize_t amdgpu_get_dpm_forced_performan=
ce_level(struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (level =
=3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? &quot;auto&quot; :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (level =
=3D=3D AMD_DPM_FORCED_LEVEL_LOW) ? &quot;low&quot; :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (level =
=3D=3D AMD_DPM_FORCED_LEVEL_HIGH) ? &quot;high&quot; :<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (level =3D=3D AMD_DPM_F=
ORCED_LEVEL_MANUAL) ? &quot;manual&quot; :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (level =
=3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD) ? &quot;profile_standard&quot=
; :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (level =
=3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) ? &quot;profile_min_sclk&quot=
; :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (level =
=3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) ? &quot;profile_min_mclk&quot=
; :<br>
&gt; @@ -186,7 &#43;185,7 @@ static ssize_t amdgpu_set_dpm_forced_performan=
ce_level(struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp(&quot;aut=
o&quot;, buf, strlen(&quot;auto&quot;)) =3D=3D 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEVEL_AUTO;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp(&quot;man=
ual&quot;, buf, strlen(&quot;manual&quot;)) =3D=3D 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; level =3D AMD_DPM_FORCED_LEVEL_MANUAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pr_info(&quot;No need to set manual mode, Just go ahead\n&quot;);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp(&quot;pro=
file_exit&quot;, buf, strlen(&quot;profile_exit&quot;)) =3D=3D 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp(&quot;pro=
file_standard&quot;, buf, strlen(&quot;profile_standard&quot;)) =3D=3D 0) {=
<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd=
/amdgpu/ci_dpm.c<br>
&gt; index ab45232..8ddc978 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt; @@ -6639,11 &#43;6639,6 @@ static int ci_dpm_force_clock_level(void *h=
andle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_info *pi =3D=
 ci_get_pi(adev);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm.forced_level &amp; (AMD_=
DPM_FORCED_LEVEL_AUTO |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LOW |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!pi-&gt;sclk_dpm_key_disabled)<br>
&gt; diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/=
gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; index b9aa9f4..3fab686 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; @@ -41,14 &#43;41,13 @@ struct amd_vce_state {<br>
&gt;&nbsp; <br>
&gt;&nbsp; enum amd_dpm_forced_level {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_AUTO =
=3D 0x1,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_MANUAL =3D 0x2,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LOW =3D 0x4,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH =3D 0x8,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD =3D 0x=
10,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK =3D 0x=
20,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK =3D 0x=
40,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =3D 0x80,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_EXIT =3D 0x100,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LOW =3D 0x2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH =3D 0x4,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD =
=3D 0x8,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK =
=3D 0x10,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK =
=3D 0x20,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =3D 0x=
40,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_EXIT =3D 0x=
80,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; enum amd_pm_state_type {<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; index dec8dd9..60d280c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; @@ -1250,7 &#43;1250,6 @@ static int cz_dpm_force_dpm_level(struct pp_=
hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_AU=
TO:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D cz_phm_unforce_dpm_levels(hwmgr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_MANUAL:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PR=
OFILE_EXIT:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; @@ -1558,9 &#43;1557,6 @@ static int cz_get_dal_power_level(struct pp_=
hwmgr *hwmgr,<br>
&gt;&nbsp; static int cz_force_clock_level(struct pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; enum pp_clock_type type, uint32_t mask)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=3D AMD_DPM_FORCED_=
LEVEL_MANUAL)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; index 409a56b..eddcbcd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; @@ -605,7 &#43;605,6 @@ static int rv_dpm_force_dpm_level(struct pp_hw=
mgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Set=
SoftMaxFclkByFreq,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RAVEN_UMD_PST=
ATE_MIN_FCLK);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_MANUAL:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PR=
OFILE_EXIT:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; index 13db75c..e3a8374 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; @@ -2798,7 &#43;2798,6 @@ static int smu7_force_dpm_level(struct pp_hw=
mgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smu7_force_clock_level(hwmgr, PP_MCLK, 1&lt;&lt;mclk_ma=
sk);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smu7_force_clock_level(hwmgr, PP_PCIE, 1&lt;&lt;pcie_ma=
sk);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_MANUAL:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PR=
OFILE_EXIT:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; @@ -4311,11 &#43;4310,6 @@ static int smu7_force_clock_level(struct pp=
_hwmgr *hwmgr,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D =
(struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;request_dpm_level &amp; (AMD_D=
PM_FORCED_LEVEL_AUTO |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AM=
D_DPM_FORCED_LEVEL_LOW |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AM=
D_DPM_FORCED_LEVEL_HIGH))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!data-&gt;sclk_dpm_key_disabled)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index 6b28896..828677e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -4241,7 &#43;4241,6 @@ static int vega10_dpm_force_dpm_level(struct=
 pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vega10_force_clock_level(hwmgr, PP_SCLK, 1&lt;&lt;sclk_=
mask);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vega10_force_clock_level(hwmgr, PP_MCLK, 1&lt;&lt;mclk_=
mask);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_MANUAL:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PR=
OFILE_EXIT:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; @@ -4500,11 &#43;4499,6 @@ static int vega10_force_clock_level(struct =
pp_hwmgr *hwmgr,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =
=3D (struct vega10_hwmgr *)(hwmgr-&gt;backend);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;request_dpm_level &amp; (AMD_D=
PM_FORCED_LEVEL_AUTO |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LOW |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;smc_state_table.gfx_boot_level =3D mask ? (ffs=
(mask) - 1) : 0;<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1687930CD8F44390C3791A63FBE10CY4PR12MB1687namp_--

--===============0073880318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0073880318==--
