From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: enable fan RPM and pwm settings
Date: Thu, 20 Sep 2018 07:18:43 +0000
Message-ID: <BYAPR12MB277537CAE06A880DDB8E2FDDFB130@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <20180920022643.19042-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1120379951=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180920022643.19042-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============1120379951==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB277537CAE06A880DDB8E2FDDFB130BYAPR12MB2775namp_"

--_000_BYAPR12MB277537CAE06A880DDB8E2FDDFB130BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Please see in line.


Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, September 20, 2018 10:26 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Quan, Evan
Subject: [PATCH] drm/amd/powerplay: enable fan RPM and pwm settings

Manual fan RPM and pwm setting on vega20 are
available now.

Change-Id: Iad45a169d6984acc091c4efaf46973619fe43a29
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 .../include/asic_reg/thm/thm_11_0_2_offset.h  |  12 ++
 .../include/asic_reg/thm/thm_11_0_2_sh_mask.h |  10 ++
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    |  27 ++++
 .../drm/amd/powerplay/hwmgr/vega20_thermal.c  | 148 +++++++++++++++++-
 .../drm/amd/powerplay/hwmgr/vega20_thermal.h  |  11 +-
 5 files changed, 204 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h b=
/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
index 510ec3c70626..5ad10408660e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
@@ -26,6 +26,18 @@
 #define mmCG_MULT_THERMAL_STATUS                                          =
                             0x005f
 #define mmCG_MULT_THERMAL_STATUS_BASE_IDX                                 =
                             0

+#define mmCG_FDO_CTRL0                                                    =
                             0x0067
+#define mmCG_FDO_CTRL0_BASE_IDX                                           =
                             0
+
+#define mmCG_FDO_CTRL1                                                    =
                             0x0068
+#define mmCG_FDO_CTRL1_BASE_IDX                                           =
                             0
+
+#define mmCG_FDO_CTRL2                                                    =
                             0x0069
+#define mmCG_FDO_CTRL2_BASE_IDX                                           =
                             0
+
+#define mmCG_TACH_STATUS                                                  =
                             0x006b
+#define mmCG_TACH_STATUS_BASE_IDX                                         =
                             0
+
 #define mmTHM_THERMAL_INT_ENA                                             =
                             0x000a
 #define mmTHM_THERMAL_INT_ENA_BASE_IDX                                    =
                             0
 #define mmTHM_THERMAL_INT_CTRL                                            =
                             0x000b
diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h =
b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h
index f69533fa6abf..ed1a2c869de5 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h
@@ -28,6 +28,16 @@
 #define CG_MULT_THERMAL_STATUS__CTF_TEMP__SHIFT                           =
                                    0x9
 #define CG_MULT_THERMAL_STATUS__ASIC_MAX_TEMP_MASK                        =
                                    0x000001FFL
 #define CG_MULT_THERMAL_STATUS__CTF_TEMP_MASK                             =
                                    0x0003FE00L
+#define CG_FDO_CTRL2__TMIN__SHIFT                                         =
                                    0x0
+#define CG_FDO_CTRL2__TMIN_MASK                                           =
                                    0x000000FFL
+#define CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT                                 =
                                    0xb
+#define CG_FDO_CTRL2__FDO_PWM_MODE_MASK                                   =
                                    0x00003800L
+#define CG_FDO_CTRL1__FMAX_DUTY100__SHIFT                                 =
                                    0x0
+#define CG_FDO_CTRL1__FMAX_DUTY100_MASK                                   =
                                    0x000000FFL
+#define CG_FDO_CTRL0__FDO_STATIC_DUTY__SHIFT                              =
                                    0x0
+#define CG_FDO_CTRL0__FDO_STATIC_DUTY_MASK                                =
                                    0x000000FFL
+#define CG_TACH_STATUS__TACH_PERIOD__SHIFT                                =
                                    0x0
+#define CG_TACH_STATUS__TACH_PERIOD_MASK                                  =
                                    0xFFFFFFFFL

 //THM_THERMAL_INT_ENA
 #define THM_THERMAL_INT_ENA__THERM_INTH_SET__SHIFT                        =
                                    0x0
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 39069663ac3f..4a80b8101194 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -2284,6 +2284,25 @@ static uint32_t vega20_get_fan_control_mode(struct p=
p_hwmgr *hwmgr)
                 return AMD_FAN_CTRL_AUTO;
 }

+static void vega20_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t m=
ode)
+{
+       switch (mode) {
+       case AMD_FAN_CTRL_NONE:
+               vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+               break;
+       case AMD_FAN_CTRL_MANUAL:
+               if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
+                       vega20_fan_ctrl_stop_smc_fan_control(hwmgr);
+               break;
+       case AMD_FAN_CTRL_AUTO:
+               if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
+                       vega20_fan_ctrl_start_smc_fan_control(hwmgr);
+               break;
+       default:
+               break;
+       }
+}
+
 static int vega20_get_dal_power_level(struct pp_hwmgr *hwmgr,
                 struct amd_pp_simple_clock_info *info)
 {
@@ -3447,12 +3466,20 @@ static const struct pp_hwmgr_func vega20_hwmgr_func=
s =3D {
         .disable_smc_firmware_ctf =3D
                 vega20_thermal_disable_alert,
         /* fan control related */
+       .get_fan_speed_percent =3D
+               vega20_fan_ctrl_get_fan_speed_percent,
+       .set_fan_speed_percent =3D
+               vega20_fan_ctrl_set_fan_speed_percent,
         .get_fan_speed_info =3D
                 vega20_fan_ctrl_get_fan_speed_info,
         .get_fan_speed_rpm =3D
                 vega20_fan_ctrl_get_fan_speed_rpm,
+       .set_fan_speed_rpm =3D
+               vega20_fan_ctrl_set_fan_speed_rpm,
         .get_fan_control_mode =3D
                 vega20_get_fan_control_mode,
+       .set_fan_control_mode =3D
+               vega20_set_fan_control_mode,
         /* smu memory related */
         .notify_cac_buffer_info =3D
                 vega20_notify_cac_buffer_info,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c
index 2984ddd5428c..33062497a2c0 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c
@@ -29,6 +29,78 @@
 #include "soc15_common.h"
 #include "pp_debug.h"

+static int vega20_disable_fan_control_feature(struct pp_hwmgr *hwmgr)
+{
+       struct vega20_hwmgr *data =3D hwmgr->backend;
+       int ret =3D 0;
+
+       if (data->smu_features[GNLD_FAN_CONTROL].supported) {
+               ret =3D vega20_enable_smc_features(
+                               hwmgr, false,
+                               data->smu_features[GNLD_FAN_CONTROL].
+                               smu_feature_bitmap);
+               PP_ASSERT_WITH_CODE(!ret,
+                               "Disable FAN CONTROL feature Failed!",
+                               return ret);
+               data->smu_features[GNLD_FAN_CONTROL].enabled =3D false;
+       }
+
+       return ret;
+}
+
+int vega20_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)
+{
+       struct vega20_hwmgr *data =3D hwmgr->backend;
+
+       if (data->smu_features[GNLD_FAN_CONTROL].supported)
+               return vega20_disable_fan_control_feature(hwmgr);
+
+       return 0;
+}
+
+static int vega20_enable_fan_control_feature(struct pp_hwmgr *hwmgr)
+{
+       struct vega20_hwmgr *data =3D hwmgr->backend;
+       int ret =3D 0;
+
+       if (data->smu_features[GNLD_FAN_CONTROL].supported) {
+               ret =3D vega20_enable_smc_features(
+                               hwmgr, true,
+                               data->smu_features[GNLD_FAN_CONTROL].
+                               smu_feature_bitmap);
+               PP_ASSERT_WITH_CODE(!ret,
+                               "Enable FAN CONTROL feature Failed!",
+                               return ret);
+               data->smu_features[GNLD_FAN_CONTROL].enabled =3D true;
+       }
+
+       return ret;
+}
+
+int vega20_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)
+{
+       struct vega20_hwmgr *data =3D hwmgr->backend;
+
+       if (data->smu_features[GNLD_FAN_CONTROL].supported)
+               return vega20_enable_fan_control_feature(hwmgr);
+
+       return 0;
+}
+
+static int vega20_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_=
t mode)
+{
+       struct amdgpu_device *adev =3D hwmgr->adev;
+
+       WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
+                       REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
+                               CG_FDO_CTRL2, TMIN, 0));
+       WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
+                       REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
+                               CG_FDO_CTRL2, FDO_PWM_MODE, mode));
+
+       return 0;
+}
+
 static int vega20_get_current_rpm(struct pp_hwmgr *hwmgr, uint32_t *curren=
t_rpm)
 {
         int ret =3D 0;
@@ -45,12 +117,62 @@ static int vega20_get_current_rpm(struct pp_hwmgr *hwm=
gr, uint32_t *current_rpm)
         return 0;
 }

+int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
+               uint32_t *speed)
+{
+       struct vega20_hwmgr *data =3D (struct vega20_hwmgr *)(hwmgr->backen=
d);
+       PPTable_t *pp_table =3D &(data->smc_state_table.pp_table);
+       uint32_t current_rpm, percent =3D 0;
+       int ret =3D 0;
+
+       ret =3D vega20_get_current_rpm(hwmgr, &current_rpm);
+       if (ret)
+               return ret;
+
+       percent =3D current_rpm * 100 / pp_table->FanMaximumRpm;
+
+       *speed =3D percent > 100 ? 100 : percent;
+
+       return 0;
+}
+
+int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
+               uint32_t speed)
+{
+       struct amdgpu_device *adev =3D hwmgr->adev;
+       uint32_t duty100;
+       uint32_t duty;
+       uint64_t tmp64;
+
+       if (speed > 100)
+               speed =3D 100;
+
+       if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
+               vega20_fan_ctrl_stop_smc_fan_control(hwmgr);
+
+       duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+                                   CG_FDO_CTRL1, FMAX_DUTY100);
+
+       if (duty100 =3D=3D 0)
+               return -EINVAL;
+
+       tmp64 =3D (uint64_t)speed * duty100;
+       do_div(tmp64, 100);
+       duty =3D (uint32_t)tmp64;
+
+       WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
+               REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),
+                       CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
+
+       return vega20_fan_ctrl_set_static_mode(hwmgr, FDO_PWM_MODE_STATIC);
+}
+
 int vega20_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
                 struct phm_fan_speed_info *fan_speed_info)
 {
         memset(fan_speed_info, 0, sizeof(*fan_speed_info));
-       fan_speed_info->supports_percent_read =3D false;
-       fan_speed_info->supports_percent_write =3D false;
+       fan_speed_info->supports_percent_read =3D true;
+       fan_speed_info->supports_percent_write =3D true;
         fan_speed_info->supports_rpm_read =3D true;
         fan_speed_info->supports_rpm_write =3D true;

@@ -64,6 +186,28 @@ int vega20_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *=
hwmgr, uint32_t *speed)
         return vega20_get_current_rpm(hwmgr, speed);
 }

+int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t spe=
ed)
+{
+       struct amdgpu_device *adev =3D hwmgr->adev;
+       uint32_t tach_period, crystal_clock_freq;
+       int result =3D 0;
+
+       if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl)) {
+               result =3D vega20_fan_ctrl_stop_smc_fan_control(hwmgr);
+               if (result)
+                       return result;
+       }
+
+       crystal_clock_freq =3D amdgpu_asic_get_xclk((struct amdgpu_device *=
)hwmgr->adev);

Make sure the speed not equal to zero to avoid divide-by-zero crash

+       tach_period =3D 60 * crystal_clock_freq * 10000 / (8 * speed);

+       WREG32_SOC15(THM, 0, mmCG_TACH_STATUS,
+                       REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_STATUS=
),
+                               CG_TACH_STATUS, TACH_PERIOD,
+                               tach_period));

should be set the register mmCG_TACH_CTRL

Rex

+       return vega20_fan_ctrl_set_static_mode(hwmgr, FDO_PWM_MODE_STATIC_R=
PM);
+}
+
 /**
 * Reads the remote temperature from the SIslands thermal controller.
 *
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h
index 2a6d49fec4e0..2d1769bbd24e 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h
@@ -50,15 +50,22 @@ struct vega20_temperature {
 #define FDO_PWM_MODE_STATIC_RPM 5

 extern int vega20_thermal_get_temperature(struct pp_hwmgr *hwmgr);
-extern int vega20_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr);
 extern int vega20_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
                 struct phm_fan_speed_info *fan_speed_info);
-extern int vega20_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwm=
gr);
 extern int vega20_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr,
                 uint32_t *speed);
+extern int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr,
+               uint32_t speed);
+extern int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
+               uint32_t *speed);
+extern int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
+               uint32_t speed);
+extern int vega20_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr);
+extern int vega20_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr);
 extern int vega20_thermal_disable_alert(struct pp_hwmgr *hwmgr);
 extern int vega20_start_thermal_controller(struct pp_hwmgr *hwmgr,
                                 struct PP_TemperatureRange *range);
+extern int vega20_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr);

 #endif

--
2.19.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_BYAPR12MB277537CAE06A880DDB8E2FDDFB130BYAPR12MB2775namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(255, 0,=
 0);">Please see in line.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.=
com&gt;<br>
<b>Sent:</b> Thursday, September 20, 2018 10:26 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Quan, Evan<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: enable fan RPM and pwm settings<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Manual fan RPM and pwm setting on vega20 are<br>
available now.<br>
<br>
Change-Id: Iad45a169d6984acc091c4efaf46973619fe43a29<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../include/asic_reg/thm/thm_11_0_2_offset.h&nbsp; |&nbsp; 12 &#43;&#=
43;<br>
&nbsp;.../include/asic_reg/thm/thm_11_0_2_sh_mask.h |&nbsp; 10 &#43;&#43;<b=
r>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp; |&nbsp; =
27 &#43;&#43;&#43;&#43;<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_thermal.c&nbsp; | 148 &#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<=
br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_thermal.h&nbsp; |&nbsp; 11 &#43;-<=
br>
&nbsp;5 files changed, 204 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h b=
/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h<br>
index 510ec3c70626..5ad10408660e 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offse=
t.h<br>
@@ -26,6 &#43;26,18 @@<br>
&nbsp;#define mmCG_MULT_THERMAL_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x005f<br>
&nbsp;#define mmCG_MULT_THERMAL_STATUS_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
&#43;#define mmCG_FDO_CTRL0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0067<br>
&#43;#define mmCG_FDO_CTRL0_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0<br>
&#43;<br>
&#43;#define mmCG_FDO_CTRL1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0068<br>
&#43;#define mmCG_FDO_CTRL1_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0<br>
&#43;<br>
&#43;#define mmCG_FDO_CTRL2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0069<br>
&#43;#define mmCG_FDO_CTRL2_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0<br>
&#43;<br>
&#43;#define mmCG_TACH_STATUS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x006b<br>
&#43;#define mmCG_TACH_STATUS_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0<br>
&#43;<br>
&nbsp;#define mmTHM_THERMAL_INT_ENA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x000a<br>
&nbsp;#define mmTHM_THERMAL_INT_ENA_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;#define mmTHM_THERMAL_INT_CTRL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x000b<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h =
b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h<br>
index f69533fa6abf..ed1a2c869de5 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_mask.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_sh_ma=
sk.h<br>
@@ -28,6 &#43;28,16 @@<br>
&nbsp;#define CG_MULT_THERMAL_STATUS__CTF_TEMP__SHIFT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x9<br>
&nbsp;#define CG_MULT_THERMAL_STATUS__ASIC_MAX_TEMP_MASK&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000001FFL<br>
&nbsp;#define CG_MULT_THERMAL_STATUS__CTF_TEMP_MASK&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0003FE00L<br=
>
&#43;#define CG_FDO_CTRL2__TMIN__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&#43;#define CG_FDO_CTRL2__TMIN_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000FFL<br>
&#43;#define CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0xb<br>
&#43;#define CG_FDO_CTRL2__FDO_PWM_MODE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x00003800L<br>
&#43;#define CG_FDO_CTRL1__FMAX_DUTY100__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x0<br>
&#43;#define CG_FDO_CTRL1__FMAX_DUTY100_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x000000FFL<br>
&#43;#define CG_FDO_CTRL0__FDO_STATIC_DUTY__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&#43;#define CG_FDO_CTRL0__FDO_STATIC_DUTY_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x000000FFL<br>
&#43;#define CG_TACH_STATUS__TACH_PERIOD__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0<br>
&#43;#define CG_TACH_STATUS__TACH_PERIOD_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0xFFFFFFFFL<br>
&nbsp;<br>
&nbsp;//THM_THERMAL_INT_ENA<br>
&nbsp;#define THM_THERMAL_INT_ENA__THERM_INTH_SET__SHIFT&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index 39069663ac3f..4a80b8101194 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -2284,6 &#43;2284,25 @@ static uint32_t vega20_get_fan_control_mode(stru=
ct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMD_FAN_CTRL_AUTO;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void vega20_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32=
_t mode)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mode) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_NONE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 100);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_MANUAL:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_fan_c=
trl_stop_smc_fan_control(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_AUTO:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_fan_c=
trl_start_smc_fan_control(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;}<br>
&#43;<br>
&nbsp;static int vega20_get_dal_power_level(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock_info *info)<br>
&nbsp;{<br>
@@ -3447,12 &#43;3466,20 @@ static const struct pp_hwmgr_func vega20_hwmgr_=
funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_smc_firmware_ctf =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_thermal_disable_alert,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fan control related */<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_percent =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega20_fan_ctrl_get_fan_speed_percent,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_percent =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega20_fan_ctrl_set_fan_speed_percent,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_info =3D<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_fan_ctrl_get_fan_speed_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_rpm =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_fan_ctrl_get_fan_speed_rpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_rpm =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega20_fan_ctrl_set_fan_speed_rpm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_control_mode =3D<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_get_fan_control_mode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_control_mode =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega20_set_fan_control_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* smu memory related */<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_cac_buffer_info =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_notify_cac_buffer_info,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c<br>
index 2984ddd5428c..33062497a2c0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c<br>
@@ -29,6 &#43;29,78 @@<br>
&nbsp;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;pp_debug.h&quot;<br>
&nbsp;<br>
&#43;static int vega20_disable_fan_control_feature(struct pp_hwmgr *hwmgr)<=
br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D hwm=
gr-&gt;backend;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GNLD_FA=
N_CONTROL].supported) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D vega20_enable_smc_features(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr, false,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu_features[GNLD_FAN_CONTROL]=
.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_feature_bitmap);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Disable FAN CONTROL feature Faile=
d!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_FAN_CONTROL].enabled =3D false;<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;int vega20_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D hwm=
gr-&gt;backend;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GNLD_FA=
N_CONTROL].supported)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return vega20_disable_fan_control_feature(hwmgr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int vega20_enable_fan_control_feature(struct pp_hwmgr *hwmgr)<b=
r>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D hwm=
gr-&gt;backend;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GNLD_FA=
N_CONTROL].supported) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D vega20_enable_smc_features(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr, true,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu_features[GNLD_FAN_CONTROL]=
.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_feature_bitmap);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Enable FAN CONTROL feature Failed=
!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_FAN_CONTROL].enabled =3D true;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;int vega20_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D hwm=
gr-&gt;backend;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GNLD_FA=
N_CONTROL].supported)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return vega20_enable_fan_control_feature(hwmgr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int vega20_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uin=
t32_t mode)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_FDO_CTR=
L2,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2, TMIN, 0));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_FDO_CTR=
L2,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2, FDO_PWM_MODE, mode));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int vega20_get_current_rpm(struct pp_hwmgr *hwmgr, uint32_t *c=
urrent_rpm)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -45,12 &#43;117,62 @@ static int vega20_get_current_rpm(struct pp_hwmgr =
*hwmgr, uint32_t *current_rpm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t *speed)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D (st=
ruct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pp_table =3D &amp;(dat=
a-&gt;smc_state_table.pp_table);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t current_rpm, percent =3D=
 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_get_current_rpm(hw=
mgr, &amp;current_rpm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; percent =3D current_rpm * 100 / p=
p_table-&gt;FanMaximumRpm;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *speed =3D percent &gt; 100 ? 100=
 : percent;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t speed)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t duty100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t duty;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t tmp64;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (speed &gt; 100)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; speed =3D 100;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_Micro=
codeFanControl))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega20_fan_ctrl_stop_smc_fan_control(hwmgr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; duty100 =3D REG_GET_FIELD(RREG32_=
SOC15(THM, 0, mmCG_FDO_CTRL1),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL1, F=
MAX_DUTY100);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (duty100 =3D=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp64 =3D (uint64_t)speed * duty1=
00;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_div(tmp64, 100);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; duty =3D (uint32_t)tmp64;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_FDO_CTR=
L0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL0=
, FDO_STATIC_DUTY, duty));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vega20_fan_ctrl_set_static=
_mode(hwmgr, FDO_PWM_MODE_STATIC);<br>
&#43;}<br>
&#43;<br>
&nbsp;int vega20_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct phm_fan_speed_info *fan_speed_info)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(fan_speed_info, 0, =
sizeof(*fan_speed_info));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fan_speed_info-&gt;supports_percent_r=
ead =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fan_speed_info-&gt;supports_percent_w=
rite =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fan_speed_info-&gt;supports_perce=
nt_read =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fan_speed_info-&gt;supports_perce=
nt_write =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fan_speed_info-&gt;support=
s_rpm_read =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fan_speed_info-&gt;support=
s_rpm_write =3D true;<br>
&nbsp;<br>
@@ -64,6 &#43;186,28 @@ int vega20_fan_ctrl_get_fan_speed_rpm(struct pp_hwm=
gr *hwmgr, uint32_t *speed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vega20_get_current_=
rpm(hwmgr, speed);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t=
 speed)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tach_period, crystal_clo=
ck_freq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_Micro=
codeFanControl)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; result =3D vega20_fan_ctrl_stop_smc_fan_control(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (result)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return resul=
t;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crystal_clock_freq =3D amdgpu_asi=
c_get_xclk((struct amdgpu_device *)hwmgr-&gt;adev);<br>
<br>
<span style=3D"color: rgb(255, 0, 0);">Make sure the speed not equal to zer=
o to avoid
</span><span><span style=3D"color: rgb(255, 0, 0);">divide-by-zero</span><s=
pan style=3D"color: rgb(255, 0, 0);"> crash</span><br>
<br>
</span>&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tach_period =3D 60 * cryst=
al_clock_freq * 10000 / (8 * speed);<br>
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, <span style=
=3D"background-color: rgb(0, 255, 0);">mmCG_TACH_STATUS,</span><br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_TACH_STATUS),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_TACH_STATUS, TACH_PERIOD,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tach_period));<br>
<br>
<span style=3D"color: rgb(255, 0, 0);">should be set the register </span><f=
ont size=3D"2"><span style=3D"font-size:11pt;"><span style=3D"background-co=
lor: rgb(0, 255, 0); color: rgb(255, 0, 0);">mmCG_TACH_CTRL<br>
<br>
<span style=3D"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0);">=
Rex</span><br>
<br>
</span></span></font>&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vega2=
0_fan_ctrl_set_static_mode(hwmgr, FDO_PWM_MODE_STATIC_RPM);<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp;* Reads the remote temperature from the SIslands thermal controller.<=
br>
&nbsp;*<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h<br>
index 2a6d49fec4e0..2d1769bbd24e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h<br>
@@ -50,15 &#43;50,22 @@ struct vega20_temperature {<br>
&nbsp;#define FDO_PWM_MODE_STATIC_RPM 5<br>
&nbsp;<br>
&nbsp;extern int vega20_thermal_get_temperature(struct pp_hwmgr *hwmgr);<br=
>
-extern int vega20_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr);=
<br>
&nbsp;extern int vega20_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct phm_fan_speed_info *fan_speed_info);<br>
-extern int vega20_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwm=
gr);<br>
&nbsp;extern int vega20_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t *speed);<br>
&#43;extern int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t speed);<br>
&#43;extern int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmg=
r,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t *speed);<br>
&#43;extern int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmg=
r,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t speed);<br>
&#43;extern int vega20_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr=
);<br>
&#43;extern int vega20_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmg=
r);<br>
&nbsp;extern int vega20_thermal_disable_alert(struct pp_hwmgr *hwmgr);<br>
&nbsp;extern int vega20_start_thermal_controller(struct pp_hwmgr *hwmgr,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_TemperatureRange *rang=
e);<br>
&#43;extern int vega20_thermal_stop_thermal_controller(struct pp_hwmgr *hwm=
gr);<br>
&nbsp;<br>
&nbsp;#endif<br>
&nbsp;<br>
-- <br>
2.19.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk501422" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15374277370060.9438929616905177" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15374277370040.1896930136272339" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15374277370040.585617775214696" style=3D"vertical-align:=
 top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2"=
>
<div id=3D"LPRemovePreviewContainer_15374277370040.5915342476635934"></div>
<div id=3D"LPTitle_15374277370040.8118232702903718" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&q=
uot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif=
; line-height: 21px;">
<a id=3D"LPUrlAnchor_15374277370040.049581260627777124" style=3D"text-decor=
ation: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gf=
x" target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15374277370060.33834794254126455" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quo=
t;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tah=
oma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15374277370060.5403322754932623" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, =
Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; o=
verflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB277537CAE06A880DDB8E2FDDFB130BYAPR12MB2775namp_--

--===============1120379951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1120379951==--
