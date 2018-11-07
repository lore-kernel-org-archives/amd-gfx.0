From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: correct code style
Date: Wed, 7 Nov 2018 14:48:11 +0000
Message-ID: <BN6PR12MB1809E321DAF57F20F4ADA833F7C40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181107104212.14131-1-Jim.Qu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0593369313=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181107104212.14131-1-Jim.Qu-5C7GfCeVMHo@public.gmane.org>
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
To: "Qu, Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0593369313==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809E321DAF57F20F4ADA833F7C40BN6PR12MB1809namp_"

--_000_BN6PR12MB1809E321DAF57F20F4ADA833F7C40BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Jim Qu <=
Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 7, 2018 5:42:12 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Qu, Jim
Subject: [PATCH] drm/amd/powerplay: correct code style

Change-Id: I844949ae1738adae3dfad431a270913d04832f56
Signed-off-by: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 135 ++++++------------
 1 file changed, 45 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index cb3c3d69c3d3..f2daf00cc911 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -3454,109 +3454,64 @@ static int vega20_get_thermal_temperature_range(st=
ruct pp_hwmgr *hwmgr,

 static const struct pp_hwmgr_func vega20_hwmgr_funcs =3D {
         /* init/fini related */
-       .backend_init =3D
-               vega20_hwmgr_backend_init,
-       .backend_fini =3D
-               vega20_hwmgr_backend_fini,
-       .asic_setup =3D
-               vega20_setup_asic_task,
-       .power_off_asic =3D
-               vega20_power_off_asic,
-       .dynamic_state_management_enable =3D
-               vega20_enable_dpm_tasks,
-       .dynamic_state_management_disable =3D
-               vega20_disable_dpm_tasks,
+       .backend_init =3D vega20_hwmgr_backend_init,
+       .backend_fini =3D vega20_hwmgr_backend_fini,
+       .asic_setup =3D vega20_setup_asic_task,
+       .power_off_asic =3D vega20_power_off_asic,
+       .dynamic_state_management_enable =3D vega20_enable_dpm_tasks,
+       .dynamic_state_management_disable =3D vega20_disable_dpm_tasks,
         /* power state related */
-       .apply_clocks_adjust_rules =3D
-               vega20_apply_clocks_adjust_rules,
-       .pre_display_config_changed =3D
-               vega20_pre_display_configuration_changed_task,
-       .display_config_changed =3D
-               vega20_display_configuration_changed_task,
+       .apply_clocks_adjust_rules =3D vega20_apply_clocks_adjust_rules,
+       .pre_display_config_changed =3D vega20_pre_display_configuration_ch=
anged_task,
+       .display_config_changed =3D vega20_display_configuration_changed_ta=
sk,
         .check_smc_update_required_for_display_configuration =3D
                 vega20_check_smc_update_required_for_display_configuration=
,
         .notify_smc_display_config_after_ps_adjustment =3D
                 vega20_notify_smc_display_config_after_ps_adjustment,
         /* export to DAL */
-       .get_sclk =3D
-               vega20_dpm_get_sclk,
-       .get_mclk =3D
-               vega20_dpm_get_mclk,
-       .get_dal_power_level =3D
-               vega20_get_dal_power_level,
-       .get_clock_by_type_with_latency =3D
-               vega20_get_clock_by_type_with_latency,
-       .get_clock_by_type_with_voltage =3D
-               vega20_get_clock_by_type_with_voltage,
-       .set_watermarks_for_clocks_ranges =3D
-               vega20_set_watermarks_for_clocks_ranges,
-       .display_clock_voltage_request =3D
-               vega20_display_clock_voltage_request,
-       .get_performance_level =3D
-               vega20_get_performance_level,
+       .get_sclk =3D vega20_dpm_get_sclk,
+       .get_mclk =3D vega20_dpm_get_mclk,
+       .get_dal_power_level =3D vega20_get_dal_power_level,
+       .get_clock_by_type_with_latency =3D vega20_get_clock_by_type_with_l=
atency,
+       .get_clock_by_type_with_voltage =3D vega20_get_clock_by_type_with_v=
oltage,
+       .set_watermarks_for_clocks_ranges =3D vega20_set_watermarks_for_clo=
cks_ranges,
+       .display_clock_voltage_request =3D vega20_display_clock_voltage_req=
uest,
+       .get_performance_level =3D vega20_get_performance_level,
         /* UMD pstate, profile related */
-       .force_dpm_level =3D
-               vega20_dpm_force_dpm_level,
-       .get_power_profile_mode =3D
-               vega20_get_power_profile_mode,
-       .set_power_profile_mode =3D
-               vega20_set_power_profile_mode,
+       .force_dpm_level =3D vega20_dpm_force_dpm_level,
+       .get_power_profile_mode =3D vega20_get_power_profile_mode,
+       .set_power_profile_mode =3D vega20_set_power_profile_mode,
         /* od related */
-       .set_power_limit =3D
-               vega20_set_power_limit,
-       .get_sclk_od =3D
-               vega20_get_sclk_od,
-       .set_sclk_od =3D
-               vega20_set_sclk_od,
-       .get_mclk_od =3D
-               vega20_get_mclk_od,
-       .set_mclk_od =3D
-               vega20_set_mclk_od,
-       .odn_edit_dpm_table =3D
-               vega20_odn_edit_dpm_table,
+       .set_power_limit =3D vega20_set_power_limit,
+       .get_sclk_od =3D vega20_get_sclk_od,
+       .set_sclk_od =3D vega20_set_sclk_od,
+       .get_mclk_od =3D vega20_get_mclk_od,
+       .set_mclk_od =3D vega20_set_mclk_od,
+       .odn_edit_dpm_table =3D vega20_odn_edit_dpm_table,
         /* for sysfs to retrive/set gfxclk/memclk */
-       .force_clock_level =3D
-               vega20_force_clock_level,
-       .print_clock_levels =3D
-               vega20_print_clock_levels,
-       .read_sensor =3D
-               vega20_read_sensor,
+       .force_clock_level =3D vega20_force_clock_level,
+       .print_clock_levels =3D vega20_print_clock_levels,
+       .read_sensor =3D vega20_read_sensor,
         /* powergate related */
-       .powergate_uvd =3D
-               vega20_power_gate_uvd,
-       .powergate_vce =3D
-               vega20_power_gate_vce,
+       .powergate_uvd =3D vega20_power_gate_uvd,
+       .powergate_vce =3D vega20_power_gate_vce,
         /* thermal related */
-       .start_thermal_controller =3D
-               vega20_start_thermal_controller,
-       .stop_thermal_controller =3D
-               vega20_thermal_stop_thermal_controller,
-       .get_thermal_temperature_range =3D
-               vega20_get_thermal_temperature_range,
-       .register_irq_handlers =3D
-               smu9_register_irq_handlers,
-       .disable_smc_firmware_ctf =3D
-               vega20_thermal_disable_alert,
+       .start_thermal_controller =3D vega20_start_thermal_controller,
+       .stop_thermal_controller =3D vega20_thermal_stop_thermal_controller=
,
+       .get_thermal_temperature_range =3D vega20_get_thermal_temperature_r=
ange,
+       .register_irq_handlers =3D smu9_register_irq_handlers,
+       .disable_smc_firmware_ctf =3D vega20_thermal_disable_alert,
         /* fan control related */
-       .get_fan_speed_percent =3D
-               vega20_fan_ctrl_get_fan_speed_percent,
-       .set_fan_speed_percent =3D
-               vega20_fan_ctrl_set_fan_speed_percent,
-       .get_fan_speed_info =3D
-               vega20_fan_ctrl_get_fan_speed_info,
-       .get_fan_speed_rpm =3D
-               vega20_fan_ctrl_get_fan_speed_rpm,
-       .set_fan_speed_rpm =3D
-               vega20_fan_ctrl_set_fan_speed_rpm,
-       .get_fan_control_mode =3D
-               vega20_get_fan_control_mode,
-       .set_fan_control_mode =3D
-               vega20_set_fan_control_mode,
+       .get_fan_speed_percent =3D vega20_fan_ctrl_get_fan_speed_percent,
+       .set_fan_speed_percent =3D vega20_fan_ctrl_set_fan_speed_percent,
+       .get_fan_speed_info =3D vega20_fan_ctrl_get_fan_speed_info,
+       .get_fan_speed_rpm =3D vega20_fan_ctrl_get_fan_speed_rpm,
+       .set_fan_speed_rpm =3D vega20_fan_ctrl_set_fan_speed_rpm,
+       .get_fan_control_mode =3D vega20_get_fan_control_mode,
+       .set_fan_control_mode =3D vega20_set_fan_control_mode,
         /* smu memory related */
-       .notify_cac_buffer_info =3D
-               vega20_notify_cac_buffer_info,
-       .enable_mgpu_fan_boost =3D
-               vega20_enable_mgpu_fan_boost,
+       .notify_cac_buffer_info =3D vega20_notify_cac_buffer_info,
+       .enable_mgpu_fan_boost =3D vega20_enable_mgpu_fan_boost,
 };

 int vega20_hwmgr_init(struct pp_hwmgr *hwmgr)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809E321DAF57F20F4ADA833F7C40BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Jim Qu &lt;Jim.Qu-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
<b>Sent:</b> Wednesday, November 7, 2018 5:42:12 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Qu, Jim<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: correct code style</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Change-Id: I844949ae1738adae3dfad431a270913d04832f=
56<br>
Signed-off-by: Jim Qu &lt;Jim.Qu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp; | 135 &#=
43;&#43;&#43;&#43;&#43;&#43;------------<br>
&nbsp;1 file changed, 45 insertions(&#43;), 90 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index cb3c3d69c3d3..f2daf00cc911 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -3454,109 &#43;3454,64 @@ static int vega20_get_thermal_temperature_rang=
e(struct pp_hwmgr *hwmgr,<br>
&nbsp;<br>
&nbsp;static const struct pp_hwmgr_func vega20_hwmgr_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init/fini related */<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_init =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_hwmgr_backend_init,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_fini =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_hwmgr_backend_fini,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_setup =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_setup_asic_task,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .power_off_asic =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_power_off_asic,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dynamic_state_management_enable =3D<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_enable_dpm_tasks,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dynamic_state_management_disable =3D=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_disable_dpm_tasks,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_init =3D vega20_hwmgr_ba=
ckend_init,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_fini =3D vega20_hwmgr_ba=
ckend_fini,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_setup =3D vega20_setup_asic=
_task,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .power_off_asic =3D vega20_power_=
off_asic,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dynamic_state_management_enable =
=3D vega20_enable_dpm_tasks,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dynamic_state_management_disable=
 =3D vega20_disable_dpm_tasks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* power state related */<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .apply_clocks_adjust_rules =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_apply_clocks_adjust_rules,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pre_display_config_changed =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_pre_display_configuration_changed_task,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_config_changed =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_display_configuration_changed_task,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .apply_clocks_adjust_rules =3D ve=
ga20_apply_clocks_adjust_rules,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pre_display_config_changed =3D v=
ega20_pre_display_configuration_changed_task,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_config_changed =3D vega2=
0_display_configuration_changed_task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_smc_update_required=
_for_display_configuration =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_check_smc_update_required_for_display_configur=
ation,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_smc_display_config=
_after_ps_adjustment =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_notify_smc_display_config_after_ps_adjustment,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* export to DAL */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_sclk =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_dpm_get_sclk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_dpm_get_mclk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dal_power_level =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_get_dal_power_level,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock_by_type_with_latency =3D<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_get_clock_by_type_with_latency,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock_by_type_with_voltage =3D<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_get_clock_by_type_with_voltage,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_watermarks_for_clocks_ranges =3D=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_set_watermarks_for_clocks_ranges,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_voltage_request =3D<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_display_clock_voltage_request,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_performance_level =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_get_performance_level,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_sclk =3D vega20_dpm_get_sclk=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk =3D vega20_dpm_get_mclk=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dal_power_level =3D vega20_g=
et_dal_power_level,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock_by_type_with_latency =
=3D vega20_get_clock_by_type_with_latency,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock_by_type_with_voltage =
=3D vega20_get_clock_by_type_with_voltage,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_watermarks_for_clocks_ranges=
 =3D vega20_set_watermarks_for_clocks_ranges,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_voltage_request =
=3D vega20_display_clock_voltage_request,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_performance_level =3D vega20=
_get_performance_level,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UMD pstate, profile rel=
ated */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_dpm_level =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_dpm_force_dpm_level,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profile_mode =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_get_power_profile_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_set_power_profile_mode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_dpm_level =3D vega20_dpm_f=
orce_dpm_level,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profile_mode =3D vega2=
0_get_power_profile_mode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =3D vega2=
0_set_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* od related */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_limit =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_set_power_limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_sclk_od =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_get_sclk_od,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_sclk_od =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_set_sclk_od,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk_od =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_get_mclk_od,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mclk_od =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_set_mclk_od,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .odn_edit_dpm_table =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_odn_edit_dpm_table,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_limit =3D vega20_set_p=
ower_limit,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_sclk_od =3D vega20_get_sclk_=
od,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_sclk_od =3D vega20_set_sclk_=
od,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk_od =3D vega20_get_mclk_=
od,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mclk_od =3D vega20_set_mclk_=
od,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .odn_edit_dpm_table =3D vega20_od=
n_edit_dpm_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* for sysfs to retrive/se=
t gfxclk/memclk */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clock_level =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_force_clock_level,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clock_levels =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_print_clock_levels,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_read_sensor,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clock_level =3D vega20_for=
ce_clock_level,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clock_levels =3D vega20_pr=
int_clock_levels,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D vega20_read_sens=
or,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* powergate related */<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_uvd =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_power_gate_uvd,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_vce =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_power_gate_vce,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_uvd =3D vega20_power_g=
ate_uvd,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_vce =3D vega20_power_g=
ate_vce,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* thermal related */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_thermal_controller =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_start_thermal_controller,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop_thermal_controller =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_thermal_stop_thermal_controller,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_thermal_temperature_range =3D<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_get_thermal_temperature_range,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handlers =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu9_register_irq_handlers,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_smc_firmware_ctf =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_thermal_disable_alert,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_thermal_controller =3D veg=
a20_start_thermal_controller,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop_thermal_controller =3D vega=
20_thermal_stop_thermal_controller,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_thermal_temperature_range =
=3D vega20_get_thermal_temperature_range,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handlers =3D smu9_r=
egister_irq_handlers,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_smc_firmware_ctf =3D veg=
a20_thermal_disable_alert,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fan control related */<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_percent =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_fan_ctrl_get_fan_speed_percent,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_percent =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_fan_ctrl_set_fan_speed_percent,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_info =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_fan_ctrl_get_fan_speed_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_rpm =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_fan_ctrl_get_fan_speed_rpm,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_rpm =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_fan_ctrl_set_fan_speed_rpm,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_control_mode =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_get_fan_control_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_control_mode =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_set_fan_control_mode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_percent =3D vega20=
_fan_ctrl_get_fan_speed_percent,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_percent =3D vega20=
_fan_ctrl_set_fan_speed_percent,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_info =3D vega20_fa=
n_ctrl_get_fan_speed_info,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_rpm =3D vega20_fan=
_ctrl_get_fan_speed_rpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_rpm =3D vega20_fan=
_ctrl_set_fan_speed_rpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_control_mode =3D vega20_=
get_fan_control_mode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_control_mode =3D vega20_=
set_fan_control_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* smu memory related */<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_cac_buffer_info =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_notify_cac_buffer_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_mgpu_fan_boost =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega20_enable_mgpu_fan_boost,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_cac_buffer_info =3D vega2=
0_notify_cac_buffer_info,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_mgpu_fan_boost =3D vega20=
_enable_mgpu_fan_boost,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int vega20_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
-- <br>
2.17.1<br>
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

--_000_BN6PR12MB1809E321DAF57F20F4ADA833F7C40BN6PR12MB1809namp_--

--===============0593369313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0593369313==--
