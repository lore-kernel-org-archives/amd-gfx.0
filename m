From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: simplify the code of
 [get|set]_activity_monitor_coeff
Date: Tue, 9 Apr 2019 03:25:07 +0000
Message-ID: <BN8PR12MB32832860B0E06E8DDD0392A5A22D0@BN8PR12MB3283.namprd12.prod.outlook.com>
References: <20190408084240.17192-1-kevin1.wang@amd.com>
 <20190408084240.17192-2-kevin1.wang@amd.com>,
 <MN2PR12MB3344E5BC17ADD1689F4AEFCAE42D0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1277503320=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344E5BC17ADD1689F4AEFCAE42D0-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============1277503320==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB32832860B0E06E8DDD0392A5A22D0BN8PR12MB3283namp_"

--_000_BN8PR12MB32832860B0E06E8DDD0392A5A22D0BN8PR12MB3283namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

@Quan, Evan<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>

I remake a new patch v2 to fix it, please help me review it.

Thanks.


Best Regards,
Kevin

________________________________
From: Quan, Evan
Sent: Tuesday, April 9, 2019 9:33:06 AM
To: Wang, Kevin(Yang); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang, Ray; Feng, Kenneth; Wang, Kevin(Yang)
Subject: RE: [PATCH 2/2] drm/amd/powerplay: simplify the code of [get|set]_=
activity_monitor_coeff

Comment inline

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> Wang, Kevin(Yang)
> Sent: Monday, April 08, 2019 4:43 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth
> <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 2/2] drm/amd/powerplay: simplify the code of
> [get|set]_activity_monitor_coeff
>
> use smu_update_table_with_arg to replace old code logic
>
> Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
> ---
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  6 --
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 75 ++-----------------
>  2 files changed, 7 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index c146b5e884f8..26a7d2c7f4fa 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -524,12 +524,6 @@ struct smu_funcs
>                                               struct
> dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges);
>        int (*set_od8_default_settings)(struct smu_context *smu,
>                                        bool initialize);
> -     int (*get_activity_monitor_coeff)(struct smu_context *smu,
> -                                   uint8_t *table,
> -                                   uint16_t workload_type);
> -     int (*set_activity_monitor_coeff)(struct smu_context *smu,
> -                                   uint8_t *table,
> -                                   uint16_t workload_type);
>        int (*conv_power_profile_to_pplib_workload)(int power_profile);
>        int (*get_power_profile_mode)(struct smu_context *smu, char
> *buf);
>        int (*set_power_profile_mode)(struct smu_context *smu, long
> *input, uint32_t size); diff --git
> a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 0e4b4b88af24..435cb606d7eb 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1460,62 +1460,6 @@ static int
> smu_v11_0_set_od8_default_settings(struct smu_context *smu,
>        return 0;
>  }
>
> -static int smu_v11_0_set_activity_monitor_coeff(struct smu_context *smu,
> -                                   uint8_t *table, uint16_t workload_typ=
e)
> -{
> -     int ret =3D 0;
> -     memcpy(smu-
> >smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].cpu_addr,
> -            table, smu-
> >smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].size);
> -     ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_SetDriverDramAddrHigh,
> -                                       upper_32_bits(smu-
> >smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].mc_address));
> -     if (ret) {
> -             pr_err("[%s] Attempt to Set Dram Addr High Failed!",
> __func__);
> -             return ret;
> -     }
> -     ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_SetDriverDramAddrLow,
> -                                       lower_32_bits(smu-
> >smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].mc_address));
> -     if (ret) {
> -             pr_err("[%s] Attempt to Set Dram Addr Low Failed!",
> __func__);
> -             return ret;
> -     }
> -     ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_TransferTableSmu2Dram,
> -                                       TABLE_ACTIVITY_MONITOR_COEFF
> | (workload_type << 16));
> -     if (ret) {
> -             pr_err("[%s] Attempt to Transfer Table From SMU Failed!",
> __func__);
> -             return ret;
> -     }
> -
> -     return ret;
> -}
> -
> -static int smu_v11_0_get_activity_monitor_coeff(struct smu_context *smu,
> -                                   uint8_t *table, uint16_t workload_typ=
e)
> -{
> -     int ret =3D 0;
> -     ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_SetDriverDramAddrHigh,
> -                                       upper_32_bits(smu-
> >smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].mc_address));
> -     if (ret) {
> -             pr_err("[%s] Attempt to Set Dram Addr High Failed!",
> __func__);
> -             return ret;
> -     }
> -
> -     ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_SetDriverDramAddrLow,
> -                                       lower_32_bits(smu-
> >smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].mc_address));
> -     if (ret) {
> -             pr_err("[%s] Attempt to Set Dram Addr Low Failed!",
> __func__);
> -             return ret;
> -     }
> -
> -     ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_TransferTableSmu2Dram,
> -                                       TABLE_ACTIVITY_MONITOR_COEFF
> | (workload_type << 16));
> -     if (ret) {
> -             pr_err("[%s] Attempt to Transfer Table From SMU Failed!",
> __func__);
> -             return ret;
> -     }
> -
> -     return ret;
> -}
> -
>  static int smu_v11_0_conv_power_profile_to_pplib_workload(int
> power_profile)  {
>        int pplib_workload =3D 0;
> @@ -1584,9 +1528,8 @@ static int
> smu_v11_0_get_power_profile_mode(struct smu_context *smu, char *buf)
>        for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_CUSTOM; i++) {
>                /* conv PP_SMC_POWER_PROFILE* to
> WORKLOAD_PPLIB_*_BIT */
>                workload_type =3D
> smu_v11_0_conv_power_profile_to_pplib_workload(i);
> -             result =3D smu_v11_0_get_activity_monitor_coeff(smu,
> -                                                           (uint8_t
> *)(&activity_monitor),
> -                                                           workload_type=
);
> +             result =3D smu_update_table_with_arg(smu,
> TABLE_ACTIVITY_MONITOR_COEFF,
> +                                                workload_type,
> &activity_monitor, false);
>                if (result) {
>                        pr_err("[%s] Failed to get activity monitor!",
> __func__);
>                        return result;
> @@ -1658,7 +1601,7 @@ static int
> smu_v11_0_get_power_profile_mode(struct smu_context *smu, char *buf)
> static int smu_v11_0_set_power_profile_mode(struct smu_context *smu,
> long *input, uint32_t size)  {
>        DpmActivityMonitorCoeffInt_t activity_monitor;
> -     int workload_type, ret =3D 0;
> +     int workload_type =3D 0, ret =3D 0;
>
>        smu->power_profile_mode =3D input[size];
>
> @@ -1668,9 +1611,8 @@ static int
> smu_v11_0_set_power_profile_mode(struct smu_context *smu, long
> *input
>        }
>
>        if (smu->power_profile_mode =3D=3D
> PP_SMC_POWER_PROFILE_CUSTOM) {
> -             ret =3D smu_v11_0_get_activity_monitor_coeff(smu,
> -                                                        (uint8_t
> *)(&activity_monitor),
> -
> WORKLOAD_PPLIB_CUSTOM_BIT);
> +             ret =3D smu_update_table_with_arg(smu,
> TABLE_ACTIVITY_MONITOR_COEFF,
> +                                             workload_type,
[Quan, Evan] workload_type seems not initialzed as WORKLOAD_PPLIB_CUSTOM_BI=
T before use. Can you confirm that?
> &activity_monitor, false);
>                if (ret) {
>                        pr_err("[%s] Failed to get activity monitor!",
> __func__);
>                        return ret;
> @@ -1723,9 +1665,8 @@ static int
> smu_v11_0_set_power_profile_mode(struct smu_context *smu, long
> *input
>                        break;
>                }
>
> -             ret =3D smu_v11_0_set_activity_monitor_coeff(smu,
> -                                                        (uint8_t
> *)(&activity_monitor),
> -
> WORKLOAD_PPLIB_CUSTOM_BIT);
> +             ret =3D smu_update_table_with_arg(smu,
> TABLE_ACTIVITY_MONITOR_COEFF,
> +
>        WORKLOAD_PPLIB_COMPUTE_BIT, &activity_monitor, true);
>                if (ret) {
>                        pr_err("[%s] Failed to set activity monitor!",
> __func__);
>                        return ret;
> @@ -1994,8 +1935,6 @@ static const struct smu_funcs smu_v11_0_funcs =3D {
>        .get_sclk =3D smu_v11_0_dpm_get_sclk,
>        .get_mclk =3D smu_v11_0_dpm_get_mclk,
>        .set_od8_default_settings =3D smu_v11_0_set_od8_default_settings,
> -     .get_activity_monitor_coeff =3D
> smu_v11_0_get_activity_monitor_coeff,
> -     .set_activity_monitor_coeff =3D
> smu_v11_0_set_activity_monitor_coeff,
>        .conv_power_profile_to_pplib_workload =3D
> smu_v11_0_conv_power_profile_to_pplib_workload,
>        .get_power_profile_mode =3D smu_v11_0_get_power_profile_mode,
>        .set_power_profile_mode =3D smu_v11_0_set_power_profile_mode,
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN8PR12MB32832860B0E06E8DDD0392A5A22D0BN8PR12MB3283namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><a class=3D"mention ms-bgc-nlr ms=
-fcl-b" id=3D"OWAAM172094" href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">@Quan, Evan</a=
></p>
<p style=3D"margin-top:0;margin-bottom:0">I remake a new patch v2 to fix it=
, please help me review it.</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards,<br>
Kevin</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Tuesday, April 9, 2019 9:33:06 AM<br>
<b>To:</b> Wang, Kevin(Yang); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Huang, Ray; Feng, Kenneth; Wang, Kevin(Yang)<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd/powerplay: simplify the code of [ge=
t|set]_activity_monitor_coeff</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Comment inline<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of<br>
&gt; Wang, Kevin(Yang)<br>
&gt; Sent: Monday, April 08, 2019 4:43 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth<br>
&gt; &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
&gt; Subject: [PATCH 2/2] drm/amd/powerplay: simplify the code of<br>
&gt; [get|set]_activity_monitor_coeff<br>
&gt; <br>
&gt; use smu_update_table_with_arg to replace old code logic<br>
&gt; <br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 6 --<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp=
; | 75 &#43;&#43;-----------------<br>
&gt;&nbsp; 2 files changed, 7 insertions(&#43;), 74 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; index c146b5e884f8..26a7d2c7f4fa 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; @@ -524,12 &#43;524,6 @@ struct smu_funcs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct<br>
&gt; dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_od8_default_settin=
gs)(struct smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; bool initialize);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int (*get_activity_monitor_coeff)(struct smu=
_context *smu,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *table=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t workl=
oad_type);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int (*set_activity_monitor_coeff)(struct smu=
_context *smu,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *table=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t workl=
oad_type);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*conv_power_profile_to_=
pplib_workload)(int power_profile);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_power_profile_mode=
)(struct smu_context *smu, char<br>
&gt; *buf);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_profile_mode=
)(struct smu_context *smu, long<br>
&gt; *input, uint32_t size); diff --git<br>
&gt; a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; index 0e4b4b88af24..435cb606d7eb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; @@ -1460,62 &#43;1460,6 @@ static int<br>
&gt; smu_v11_0_set_od8_default_settings(struct smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -static int smu_v11_0_set_activity_monitor_coeff(struct smu_context *s=
mu,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *table=
, uint16_t workload_type)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memcpy(smu-<br>
&gt; &gt;smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].cpu_addr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta=
ble, smu-<br>
&gt; &gt;smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].size);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_SetDriverDramAddrHigh,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; upper_32_bits(smu-<br>
&gt; &gt;smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].mc_address));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pr_err(&quot;[%s] Attempt to Set Dram Addr High Failed!&quot;,<br>
&gt; __func__);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_SetDriverDramAddrLow,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; lower_32_bits(smu-<br>
&gt; &gt;smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].mc_address));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pr_err(&quot;[%s] Attempt to Set Dram Addr Low Failed!&quot;,<br>
&gt; __func__);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_TransferTableSmu2Dram,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; TABLE_ACTIVITY_MONITOR_COEFF<br>
&gt; | (workload_type &lt;&lt; 16));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pr_err(&quot;[%s] Attempt to Transfer Table From SMU Failed!&quot;,<br>
&gt; __func__);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static int smu_v11_0_get_activity_monitor_coeff(struct smu_context *s=
mu,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *table=
, uint16_t workload_type)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_SetDriverDramAddrHigh,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; upper_32_bits(smu-<br>
&gt; &gt;smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].mc_address));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pr_err(&quot;[%s] Attempt to Set Dram Addr High Failed!&quot;,<br>
&gt; __func__);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_SetDriverDramAddrLow,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; lower_32_bits(smu-<br>
&gt; &gt;smu_table.tables[TABLE_ACTIVITY_MONITOR_COEFF].mc_address));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pr_err(&quot;[%s] Attempt to Set Dram Addr Low Failed!&quot;,<br>
&gt; __func__);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_TransferTableSmu2Dram,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; TABLE_ACTIVITY_MONITOR_COEFF<br>
&gt; | (workload_type &lt;&lt; 16));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pr_err(&quot;[%s] Attempt to Transfer Table From SMU Failed!&quot;,<br>
&gt; __func__);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp; static int smu_v11_0_conv_power_profile_to_pplib_workload(int<br=
>
&gt; power_profile)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pplib_workload =3D 0;<br=
>
&gt; @@ -1584,9 &#43;1528,8 @@ static int<br>
&gt; smu_v11_0_get_power_profile_mode(struct smu_context *smu, char *buf)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt;=3D PP_S=
MC_POWER_PROFILE_CUSTOM; i&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* conv PP_SMC_POWER_PROFILE* to<br>
&gt; WORKLOAD_PPLIB_*_BIT */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; workload_type =3D<br>
&gt; smu_v11_0_conv_power_profile_to_pplib_workload(i);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; result =3D smu_v11_0_get_activity_monitor_coeff(smu,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t<br>
&gt; *)(&amp;activity_monitor),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workload_type);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; result =3D smu_update_table_with_arg(smu,<br>
&gt; TABLE_ACTIVITY_MONITOR_COEFF,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workloa=
d_type,<br>
&gt; &amp;activity_monitor, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (result) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(=
&quot;[%s] Failed to get activity monitor!&quot;,<br>
&gt; __func__);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
result;<br>
&gt; @@ -1658,7 &#43;1601,7 @@ static int<br>
&gt; smu_v11_0_get_power_profile_mode(struct smu_context *smu, char *buf)<b=
r>
&gt; static int smu_v11_0_set_power_profile_mode(struct smu_context *smu,<b=
r>
&gt; long *input, uint32_t size)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DpmActivityMonitorCoeffInt_t=
 activity_monitor;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int workload_type, ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int workload_type =3D 0, ret =3D 0;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;power_profile_mode =
=3D input[size];<br>
&gt; <br>
&gt; @@ -1668,9 &#43;1611,8 @@ static int<br>
&gt; smu_v11_0_set_power_profile_mode(struct smu_context *smu, long<br>
&gt; *input<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;power_profile_mo=
de =3D=3D<br>
&gt; PP_SMC_POWER_PROFILE_CUSTOM) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_v11_0_get_activity_monitor_coeff(smu,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t<br>
&gt; *)(&amp;activity_monitor),<br>
&gt; -<br>
&gt; WORKLOAD_PPLIB_CUSTOM_BIT);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D smu_update_table_with_arg(smu,<br>
&gt; TABLE_ACTIVITY_MONITOR_COEFF,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workload_type,<br>
[Quan, Evan] workload_type seems not initialzed as WORKLOAD_PPLIB_CUSTOM_BI=
T before use. Can you confirm that?<br>
&gt; &amp;activity_monitor, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(=
&quot;[%s] Failed to get activity monitor!&quot;,<br>
&gt; __func__);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt; @@ -1723,9 &#43;1665,8 @@ static int<br>
&gt; smu_v11_0_set_power_profile_mode(struct smu_context *smu, long<br>
&gt; *input<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_v11_0_set_activity_monitor_coeff(smu,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t<br>
&gt; *)(&amp;activity_monitor),<br>
&gt; -<br>
&gt; WORKLOAD_PPLIB_CUSTOM_BIT);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D smu_update_table_with_arg(smu,<br>
&gt; TABLE_ACTIVITY_MONITOR_COEFF,<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WORKLOAD_PPLIB_COMPUTE_BIT, =
&amp;activity_monitor, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(=
&quot;[%s] Failed to set activity monitor!&quot;,<br>
&gt; __func__);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt; @@ -1994,8 &#43;1935,6 @@ static const struct smu_funcs smu_v11_0_func=
s =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_sclk =3D smu_v11_0_dpm_=
get_sclk,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk =3D smu_v11_0_dpm_=
get_mclk,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_od8_default_settings =
=3D smu_v11_0_set_od8_default_settings,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .get_activity_monitor_coeff =3D<br>
&gt; smu_v11_0_get_activity_monitor_coeff,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .set_activity_monitor_coeff =3D<br>
&gt; smu_v11_0_set_activity_monitor_coeff,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .conv_power_profile_to_pplib=
_workload =3D<br>
&gt; smu_v11_0_conv_power_profile_to_pplib_workload,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profile_mode =3D =
smu_v11_0_get_power_profile_mode,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =3D =
smu_v11_0_set_power_profile_mode,<br>
&gt; --<br>
&gt; 2.21.0<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN8PR12MB32832860B0E06E8DDD0392A5A22D0BN8PR12MB3283namp_--

--===============1277503320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1277503320==--
