From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: rv dal-pplib interface refactor
 powerplay part
Date: Wed, 5 Dec 2018 18:24:59 +0000
Message-ID: <BN6PR12MB18094517386BC2D7C102E7FBF7A80@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1543863821-32322-1-git-send-email-hersenxs.wu@amd.com>,
 <DM5PR1201MB25530337DA4C7F36E268ED15FDA80@DM5PR1201MB2553.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1154794256=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR1201MB25530337DA4C7F36E268ED15FDA80-grEf7a3NxMAXo4eMau56LGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============1154794256==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18094517386BC2D7C102E7FBF7A80BN6PR12MB1809namp_"

--_000_BN6PR12MB18094517386BC2D7C102E7FBF7A80BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Looks reasonable to me.

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Wu, Hersen
Sent: Wednesday, December 5, 2018 1:03:57 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex; Deucher, Alexander
Subject: RE: [PATCH] drm/amd/powerplay: rv dal-pplib interface refactor pow=
erplay part

Hello, Alex, Rex,

Would you please help review the change?

Thanks,
Hersen





[WHY] clarify dal input parameters to pplib interface, remove un-used param=
eters. dal knows exactly which parameters needed and their effects at pplib=
 and smu sides.

current dal sequence for dcn1_update_clock to pplib:

1.smu10_display_clock_voltage_request for dcefclk 2.smu10_display_clock_vol=
tage_request for fclk 3.phm_store_dal_configuration_data {
  set_min_deep_sleep_dcfclk
  set_active_display_count
  store_cc6_data --- this data never be referenced

new sequence will be:

1. set_display_count  --- need add new pplib interface 2. set_min_deep_slee=
p_dcfclk -- new pplib interface 3. set_hard_min_dcfclk_by_freq 4. set_hard_=
min_fclk_by_freq

after this code refactor, smu10_display_clock_voltage_request,
phm_store_dal_configuration_data will not be needed for rv.

[HOW] step 1: add new functions at pplib interface
      step 2: add new functions at amdgpu dm and dc

Signed-off-by: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |  4 ++
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      | 76 ++++++++++++++++++=
++++
 .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  | 45 ++++++++++++-  dri=
vers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  | 36 +++++++++-
 .../gpu/drm/amd/powerplay/inc/hardwaremanager.h    |  3 +
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  4 +-
 6 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 980e696..1479ea1 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -276,6 +276,10 @@ struct amd_pm_funcs {
                 struct amd_pp_simple_clock_info *clocks);
         int (*notify_smu_enable_pwe)(void *handle);
         int (*enable_mgpu_fan_boost)(void *handle);
+       int (*set_active_display_count)(void *handle, uint32_t count);
+       int (*set_hard_min_dcefclk_by_freq)(void *handle, uint32_t clock);
+       int (*set_hard_min_fclk_by_freq)(void *handle, uint32_t clock);
+       int (*set_min_deep_sleep_dcefclk)(void *handle, uint32_t clock);
 };

 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index d6aa1d4..53dde16 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1332,6 +1332,78 @@ static int pp_enable_mgpu_fan_boost(void *handle)
         return 0;
 }

+static int pp_set_min_deep_sleep_dcefclk(void *handle, uint32_t clock)
+{
+       struct pp_hwmgr *hwmgr =3D handle;
+
+       if (!hwmgr || !hwmgr->pm_en)
+               return -EINVAL;
+
+       if (hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk =3D=3D NULL) {
+               pr_info("%s was not implemented.\n", __func__);
+               return -EINVAL;;
+       }
+
+       mutex_lock(&hwmgr->smu_lock);
+       hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk(hwmgr, clock);
+       mutex_unlock(&hwmgr->smu_lock);
+
+       return 0;
+}
+
+static int pp_set_hard_min_dcefclk_by_freq(void *handle, uint32_t
+clock) {
+       struct pp_hwmgr *hwmgr =3D handle;
+
+       if (!hwmgr || !hwmgr->pm_en)
+               return -EINVAL;
+
+       if (hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq =3D=3D NULL) {
+               pr_info("%s was not implemented.\n", __func__);
+               return -EINVAL;;
+       }
+
+       mutex_lock(&hwmgr->smu_lock);
+       hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq(hwmgr, clock);
+       mutex_unlock(&hwmgr->smu_lock);
+
+       return 0;
+}
+
+static int pp_set_hard_min_fclk_by_freq(void *handle, uint32_t clock) {
+       struct pp_hwmgr *hwmgr =3D handle;
+
+       if (!hwmgr || !hwmgr->pm_en)
+               return -EINVAL;
+
+       if (hwmgr->hwmgr_func->set_hard_min_fclk_by_freq =3D=3D NULL) {
+               pr_info("%s was not implemented.\n", __func__);
+               return -EINVAL;;
+       }
+
+       mutex_lock(&hwmgr->smu_lock);
+       hwmgr->hwmgr_func->set_hard_min_fclk_by_freq(hwmgr, clock);
+       mutex_unlock(&hwmgr->smu_lock);
+
+       return 0;
+}
+
+static int pp_set_active_display_count(void *handle, uint32_t count) {
+       struct pp_hwmgr *hwmgr =3D handle;
+       int ret =3D 0;
+
+       if (!hwmgr || !hwmgr->pm_en)
+               return -EINVAL;
+
+       mutex_lock(&hwmgr->smu_lock);
+       ret =3D phm_set_active_display_count(hwmgr, count);
+       mutex_unlock(&hwmgr->smu_lock);
+
+       return ret;
+}
+
 static const struct amd_pm_funcs pp_dpm_funcs =3D {
         .load_firmware =3D pp_dpm_load_fw,
         .wait_for_fw_loading_complete =3D pp_dpm_fw_loading_complete, @@ -=
1378,4 +1450,8 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D {
         .get_display_mode_validation_clocks =3D pp_get_display_mode_valida=
tion_clocks,
         .notify_smu_enable_pwe =3D pp_notify_smu_enable_pwe,
         .enable_mgpu_fan_boost =3D pp_enable_mgpu_fan_boost,
+       .set_active_display_count =3D pp_set_active_display_count,
+       .set_min_deep_sleep_dcefclk =3D pp_set_min_deep_sleep_dcefclk,
+       .set_hard_min_dcefclk_by_freq =3D pp_set_hard_min_dcefclk_by_freq,
+       .set_hard_min_fclk_by_freq =3D pp_set_hard_min_fclk_by_freq,
 };
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
index 85119c2..333b9b8 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
@@ -286,8 +286,8 @@ int phm_store_dal_configuration_data(struct pp_hwmgr *h=
wmgr,
         if (display_config =3D=3D NULL)
                 return -EINVAL;

-       if (NULL !=3D hwmgr->hwmgr_func->set_deep_sleep_dcefclk)
-               hwmgr->hwmgr_func->set_deep_sleep_dcefclk(hwmgr, display_co=
nfig->min_dcef_deep_sleep_set_clk);
+       if (NULL !=3D hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk)
+               hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk(hwmgr,
+display_config->min_dcef_deep_sleep_set_clk);

         for (index =3D 0; index < display_config->num_path_including_non_d=
isplay; index++) {
                 if (display_config->displays[index].controller_id !=3D 0) =
@@ -478,3 +478,44 @@ int phm_disable_smc_firmware_ctf(struct pp_hwmgr *hwmg=
r)

         return hwmgr->hwmgr_func->disable_smc_firmware_ctf(hwmgr);
 }
+
+int phm_set_active_display_count(struct pp_hwmgr *hwmgr, uint32_t
+count) {
+       PHM_FUNC_CHECK(hwmgr);
+
+       if (!hwmgr->hwmgr_func->set_active_display_count)
+               return -EINVAL;
+
+       return hwmgr->hwmgr_func->set_active_display_count(hwmgr, count); }
+
+int phm_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, uint32_t
+clock) {
+       PHM_FUNC_CHECK(hwmgr);
+
+       if (!hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk)
+               return -EINVAL;
+
+       return hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk(hwmgr, clock);=
 }
+
+int phm_set_hard_min_dcefclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t
+clock) {
+       PHM_FUNC_CHECK(hwmgr);
+
+       if (!hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq)
+               return -EINVAL;
+
+       return hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq(hwmgr, clock=
);
+}
+
+int phm_set_hard_min_fclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t
+clock) {
+       PHM_FUNC_CHECK(hwmgr);
+
+       if (!hwmgr->hwmgr_func->set_hard_min_fclk_by_freq)
+               return -EINVAL;
+
+       return hwmgr->hwmgr_func->set_hard_min_fclk_by_freq(hwmgr, clock); =
}
+
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index dd18cb7..f95c5f5 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -216,12 +216,12 @@ static inline uint32_t convert_10k_to_mhz(uint32_t cl=
ock)
         return (clock + 99) / 100;
 }

-static int smu10_set_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, uint32_t c=
lock)
+static int smu10_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr,
+uint32_t clock)
 {
         struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->b=
ackend);

         if (smu10_data->need_min_deep_sleep_dcefclk &&
-           smu10_data->deep_sleep_dcefclk !=3D convert_10k_to_mhz(clock)) =
{
+               smu10_data->deep_sleep_dcefclk !=3D convert_10k_to_mhz(cloc=
k)) {
                 smu10_data->deep_sleep_dcefclk =3D convert_10k_to_mhz(cloc=
k);
                 smum_send_msg_to_smc_with_parameter(hwmgr,
                                         PPSMC_MSG_SetMinDeepSleepDcefclk,
@@ -230,6 +230,34 @@ static int smu10_set_deep_sleep_dcefclk(struct pp_hwmg=
r *hwmgr, uint32_t clock)
         return 0;
 }

+static int smu10_set_hard_min_dcefclk_by_freq(struct pp_hwmgr *hwmgr,
+uint32_t clock) {
+       struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr
+*)(hwmgr->backend);
+
+       if (smu10_data->dcf_actual_hard_min_freq &&
+               smu10_data->dcf_actual_hard_min_freq !=3D convert_10k_to_mh=
z(clock)) {
+               smu10_data->dcf_actual_hard_min_freq =3D convert_10k_to_mhz=
(clock);
+               smum_send_msg_to_smc_with_parameter(hwmgr,
+                                       PPSMC_MSG_SetHardMinDcefclkByFreq,
+                                       smu10_data->dcf_actual_hard_min_fre=
q);
+       }
+       return 0;
+}
+
+static int smu10_set_hard_min_fclk_by_freq(struct pp_hwmgr *hwmgr,
+uint32_t clock) {
+       struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr
+*)(hwmgr->backend);
+
+       if (smu10_data->f_actual_hard_min_freq &&
+               smu10_data->f_actual_hard_min_freq !=3D convert_10k_to_mhz(=
clock)) {
+               smu10_data->f_actual_hard_min_freq =3D convert_10k_to_mhz(c=
lock);
+               smum_send_msg_to_smc_with_parameter(hwmgr,
+                                       PPSMC_MSG_SetHardMinFclkByFreq,
+                                       smu10_data->f_actual_hard_min_freq)=
;
+       }
+       return 0;
+}
+
 static int smu10_set_active_display_count(struct pp_hwmgr *hwmgr, uint32_t=
 count)  {
         struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->b=
ackend); @@ -1206,7 +1234,7 @@ static const struct pp_hwmgr_func smu10_hwmg=
r_funcs =3D {
         .get_max_high_clocks =3D smu10_get_max_high_clocks,
         .read_sensor =3D smu10_read_sensor,
         .set_active_display_count =3D smu10_set_active_display_count,
-       .set_deep_sleep_dcefclk =3D smu10_set_deep_sleep_dcefclk,
+       .set_min_deep_sleep_dcefclk =3D smu10_set_min_deep_sleep_dcefclk,
         .dynamic_state_management_enable =3D smu10_enable_dpm_tasks,
         .power_off_asic =3D smu10_power_off_asic,
         .asic_setup =3D smu10_setup_asic_task,
@@ -1217,6 +1245,8 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs =
=3D {
         .display_clock_voltage_request =3D smu10_display_clock_voltage_req=
uest,
         .powergate_gfx =3D smu10_gfx_off_control,
         .powergate_sdma =3D smu10_powergate_sdma,
+       .set_hard_min_dcefclk_by_freq =3D smu10_set_hard_min_dcefclk_by_fre=
q,
+       .set_hard_min_fclk_by_freq =3D smu10_set_hard_min_fclk_by_freq,
 };

 int smu10_init_function_pointers(struct pp_hwmgr *hwmgr) diff --git a/driv=
ers/gpu/drm/amd/powerplay/inc/hardwaremanager.h b/drivers/gpu/drm/amd/power=
play/inc/hardwaremanager.h
index 54fd012..f4dab97 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
@@ -463,5 +463,8 @@ extern int phm_display_clock_voltage_request(struct pp_=
hwmgr *hwmgr,

 extern int phm_get_max_high_clocks(struct pp_hwmgr *hwmgr, struct amd_pp_s=
imple_clock_info *clocks);  extern int phm_disable_smc_firmware_ctf(struct =
pp_hwmgr *hwmgr);
+
+extern int phm_set_active_display_count(struct pp_hwmgr *hwmgr,
+uint32_t count);
+
 #endif /* _HARDWARE_MANAGER_H_ */

diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index 07d180ce..19edfc9 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -309,7 +309,7 @@ struct pp_hwmgr_func {
         int (*avfs_control)(struct pp_hwmgr *hwmgr, bool enable);
         int (*disable_smc_firmware_ctf)(struct pp_hwmgr *hwmgr);
         int (*set_active_display_count)(struct pp_hwmgr *hwmgr, uint32_t c=
ount);
-       int (*set_deep_sleep_dcefclk)(struct pp_hwmgr *hwmgr, uint32_t cloc=
k);
+       int (*set_min_deep_sleep_dcefclk)(struct pp_hwmgr *hwmgr, uint32_t
+clock);
         int (*start_thermal_controller)(struct pp_hwmgr *hwmgr, struct PP_=
TemperatureRange *range);
         int (*notify_cac_buffer_info)(struct pp_hwmgr *hwmgr,
                                         uint32_t virtual_addr_low,
@@ -329,6 +329,8 @@ struct pp_hwmgr_func {
         int (*smus_notify_pwe)(struct pp_hwmgr *hwmgr);
         int (*powergate_sdma)(struct pp_hwmgr *hwmgr, bool bgate);
         int (*enable_mgpu_fan_boost)(struct pp_hwmgr *hwmgr);
+       int (*set_hard_min_dcefclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_=
t clock);
+       int (*set_hard_min_fclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t
+clock);
 };

 struct pp_table_func {
--
2.7.4


--_000_BN6PR12MB18094517386BC2D7C102E7FBF7A80BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Looks reasonable to me.</p>
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wu, Hersen<br>
<b>Sent:</b> Wednesday, December 5, 2018 1:03:57 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex; Deucher, Alexander<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: rv dal-pplib interface refac=
tor powerplay part</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hello, Alex, Rex,<br>
<br>
Would you please help review the change?<br>
<br>
Thanks,<br>
Hersen<br>
<br>
<br>
<br>
<br>
<br>
[WHY] clarify dal input parameters to pplib interface, remove un-used param=
eters. dal knows exactly which parameters needed and their effects at pplib=
 and smu sides.<br>
<br>
current dal sequence for dcn1_update_clock to pplib:<br>
<br>
1.smu10_display_clock_voltage_request for dcefclk 2.smu10_display_clock_vol=
tage_request for fclk 3.phm_store_dal_configuration_data {<br>
&nbsp; set_min_deep_sleep_dcfclk<br>
&nbsp; set_active_display_count<br>
&nbsp; store_cc6_data --- this data never be referenced<br>
<br>
new sequence will be:<br>
<br>
1. set_display_count&nbsp; --- need add new pplib interface 2. set_min_deep=
_sleep_dcfclk -- new pplib interface 3. set_hard_min_dcfclk_by_freq 4. set_=
hard_min_fclk_by_freq<br>
<br>
after this code refactor, smu10_display_clock_voltage_request,<br>
phm_store_dal_configuration_data will not be needed for rv.<br>
<br>
[HOW] step 1: add new functions at pplib interface<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; step 2: add new functions at amdgpu dm and d=
c<br>
<br>
Signed-off-by: hersen wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 4 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 76 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c&nbsp; | 45 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-&nbsp; drivers/gpu/drm=
/amd/powerplay/hwmgr/smu10_hwmgr.c&nbsp; | 36 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;-<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/hardwaremanager.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 3 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;-<br>
&nbsp;6 files changed, 162 insertions(&#43;), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index 980e696..1479ea1 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -276,6 &#43;276,10 @@ struct amd_pm_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock_info *clocks);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_smu_enable_pw=
e)(void *handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*enable_mgpu_fan_boos=
t)(void *handle);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_active_display_count)(v=
oid *handle, uint32_t count);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_hard_min_dcefclk_by_fre=
q)(void *handle, uint32_t clock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_hard_min_fclk_by_freq)(=
void *handle, uint32_t clock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_min_deep_sleep_dcefclk)=
(void *handle, uint32_t clock);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index d6aa1d4..53dde16 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -1332,6 &#43;1332,78 @@ static int pp_enable_mgpu_fan_boost(void *handle=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int pp_set_min_deep_sleep_dcefclk(void *handle, uint32_t clock)=
 <br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle=
;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;pm_en)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;set_=
min_deep_sleep_dcefclk =3D=3D NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __func__);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_loc=
k);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_min_=
deep_sleep_dcefclk(hwmgr, clock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_l=
ock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int pp_set_hard_min_dcefclk_by_freq(void *handle, uint32_t <br>
&#43;clock) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle=
;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;pm_en)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;set_=
hard_min_dcefclk_by_freq =3D=3D NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __func__);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_loc=
k);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_hard=
_min_dcefclk_by_freq(hwmgr, clock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_l=
ock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int pp_set_hard_min_fclk_by_freq(void *handle, uint32_t clock) =
{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle=
;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;pm_en)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;set_=
hard_min_fclk_by_freq =3D=3D NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __func__);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_loc=
k);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_hard=
_min_fclk_by_freq(hwmgr, clock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_l=
ock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int pp_set_active_display_count(void *handle, uint32_t count) {=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;pm_en)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_loc=
k);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_set_active_display_co=
unt(hwmgr, count);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_l=
ock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct amd_pm_funcs pp_dpm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_firmware =3D pp_dpm_=
load_fw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_fw_loading_compl=
ete =3D pp_dpm_fw_loading_complete, @@ -1378,4 &#43;1450,8 @@ static const =
struct amd_pm_funcs pp_dpm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_display_mode_validati=
on_clocks =3D pp_get_display_mode_validation_clocks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_smu_enable_pwe =3D=
 pp_notify_smu_enable_pwe,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_mgpu_fan_boost =3D=
 pp_enable_mgpu_fan_boost,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_active_display_count =3D pp_=
set_active_display_count,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_min_deep_sleep_dcefclk =3D p=
p_set_min_deep_sleep_dcefclk,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_hard_min_dcefclk_by_freq =3D=
 pp_set_hard_min_dcefclk_by_freq,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_hard_min_fclk_by_freq =3D pp=
_set_hard_min_fclk_by_freq,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
index 85119c2..333b9b8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
@@ -286,8 &#43;286,8 @@ int phm_store_dal_configuration_data(struct pp_hwmg=
r *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (display_config =3D=3D =
NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;hwmgr_func-&g=
t;set_deep_sleep_dcefclk)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_deep_sleep_dcefclk(hwmgr, display_c=
onfig-&gt;min_dcef_deep_sleep_set_clk);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;hwmgr_fun=
c-&gt;set_min_deep_sleep_dcefclk)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_min_deep_sleep_dcefclk(hwmgr, <=
br>
&#43;display_config-&gt;min_dcef_deep_sleep_set_clk);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (index =3D 0; index &l=
t; display_config-&gt;num_path_including_non_display; index&#43;&#43;) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (display_config-&gt;displays[index].controller_id =
!=3D 0) @@ -478,3 &#43;478,44 @@ int phm_disable_smc_firmware_ctf(struct pp=
_hwmgr *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_fun=
c-&gt;disable_smc_firmware_ctf(hwmgr);<br>
&nbsp;}<br>
&#43;<br>
&#43;int phm_set_active_display_count(struct pp_hwmgr *hwmgr, uint32_t <br>
&#43;count) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_FUNC_CHECK(hwmgr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;hwmgr_func-&gt;set=
_active_display_count)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-&gt;s=
et_active_display_count(hwmgr, count); }<br>
&#43;<br>
&#43;int phm_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, uint32_t <b=
r>
&#43;clock) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_FUNC_CHECK(hwmgr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;hwmgr_func-&gt;set=
_min_deep_sleep_dcefclk)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-&gt;s=
et_min_deep_sleep_dcefclk(hwmgr, clock); }<br>
&#43;<br>
&#43;int phm_set_hard_min_dcefclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t =
<br>
&#43;clock) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_FUNC_CHECK(hwmgr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;hwmgr_func-&gt;set=
_hard_min_dcefclk_by_freq)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-&gt;s=
et_hard_min_dcefclk_by_freq(hwmgr, clock); <br>
&#43;}<br>
&#43;<br>
&#43;int phm_set_hard_min_fclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t <br=
>
&#43;clock) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_FUNC_CHECK(hwmgr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;hwmgr_func-&gt;set=
_hard_min_fclk_by_freq)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-&gt;s=
et_hard_min_fclk_by_freq(hwmgr, clock); }<br>
&#43;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
index dd18cb7..f95c5f5 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -216,12 &#43;216,12 @@ static inline uint32_t convert_10k_to_mhz(uint32_=
t clock)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (clock &#43; 99) / =
100;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu10_set_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, uint32_t c=
lock)<br>
&#43;static int smu10_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, <b=
r>
&#43;uint32_t clock)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_=
data =3D (struct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu10_data-&gt;need_mi=
n_deep_sleep_dcefclk &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10_data-&g=
t;deep_sleep_dcefclk !=3D convert_10k_to_mhz(clock)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;deep_sleep_dcefclk !=3D convert_10k_to_mhz(cl=
ock)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu10_data-&gt;deep_sleep_dcefclk =3D convert_10k_to_=
mhz(clock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PPSMC_MSG_SetMinDeepSleepDcefclk,<br>
@@ -230,6 &#43;230,34 @@ static int smu10_set_deep_sleep_dcefclk(struct pp_=
hwmgr *hwmgr, uint32_t clock)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int smu10_set_hard_min_dcefclk_by_freq(struct pp_hwmgr *hwmgr, =
<br>
&#43;uint32_t clock) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_data =
=3D (struct smu10_hwmgr <br>
&#43;*)(hwmgr-&gt;backend);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu10_data-&gt;dcf_actual_har=
d_min_freq &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;dcf_actual_hard_min_freq !=3D convert_10k_to_=
mhz(clock)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;dcf_actual_hard_min_freq =3D convert_10k_to_m=
hz(clock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_SetHardMinDcefclkByFreq,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; smu10_data-&gt;dcf_actual_hard_min_freq);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int smu10_set_hard_min_fclk_by_freq(struct pp_hwmgr *hwmgr, <br=
>
&#43;uint32_t clock) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_data =
=3D (struct smu10_hwmgr <br>
&#43;*)(hwmgr-&gt;backend);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu10_data-&gt;f_actual_hard_=
min_freq &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;f_actual_hard_min_freq !=3D convert_10k_to_mh=
z(clock)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;f_actual_hard_min_freq =3D convert_10k_to_mhz=
(clock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_SetHardMinFclkByFreq,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; smu10_data-&gt;f_actual_hard_min_freq);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int smu10_set_active_display_count(struct pp_hwmgr *hwmgr, uin=
t32_t count)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_=
data =3D (struct smu10_hwmgr *)(hwmgr-&gt;backend); @@ -1206,7 &#43;1234,7 =
@@ static const struct pp_hwmgr_func smu10_hwmgr_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_high_clocks =3D s=
mu10_get_max_high_clocks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D smu10_rea=
d_sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_active_display_count =
=3D smu10_set_active_display_count,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_deep_sleep_dcefclk =3D smu10_set=
_deep_sleep_dcefclk,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_min_deep_sleep_dcefclk =3D s=
mu10_set_min_deep_sleep_dcefclk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dynamic_state_management_=
enable =3D smu10_enable_dpm_tasks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .power_off_asic =3D smu10_=
power_off_asic,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_setup =3D smu10_setu=
p_asic_task,<br>
@@ -1217,6 &#43;1245,8 @@ static const struct pp_hwmgr_func smu10_hwmgr_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_voltage_req=
uest =3D smu10_display_clock_voltage_request,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_gfx =3D smu10_g=
fx_off_control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_sdma =3D smu10_=
powergate_sdma,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_hard_min_dcefclk_by_freq =3D=
 smu10_set_hard_min_dcefclk_by_freq,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_hard_min_fclk_by_freq =3D sm=
u10_set_hard_min_fclk_by_freq,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int smu10_init_function_pointers(struct pp_hwmgr *hwmgr) diff --git a=
/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h b/drivers/gpu/drm/amd/=
powerplay/inc/hardwaremanager.h<br>
index 54fd012..f4dab97 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h<br>
@@ -463,5 &#43;463,8 @@ extern int phm_display_clock_voltage_request(struct=
 pp_hwmgr *hwmgr,<br>
&nbsp;<br>
&nbsp;extern int phm_get_max_high_clocks(struct pp_hwmgr *hwmgr, struct amd=
_pp_simple_clock_info *clocks);&nbsp; extern int phm_disable_smc_firmware_c=
tf(struct pp_hwmgr *hwmgr);<br>
&#43;<br>
&#43;extern int phm_set_active_display_count(struct pp_hwmgr *hwmgr, <br>
&#43;uint32_t count);<br>
&#43;<br>
&nbsp;#endif /* _HARDWARE_MANAGER_H_ */<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 07d180ce..19edfc9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -309,7 &#43;309,7 @@ struct pp_hwmgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*avfs_control)(struct=
 pp_hwmgr *hwmgr, bool enable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*disable_smc_firmware=
_ctf)(struct pp_hwmgr *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_active_display_c=
ount)(struct pp_hwmgr *hwmgr, uint32_t count);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_deep_sleep_dcefclk)(struct =
pp_hwmgr *hwmgr, uint32_t clock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_min_deep_sleep_dcefclk)=
(struct pp_hwmgr *hwmgr, uint32_t <br>
&#43;clock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*start_thermal_contro=
ller)(struct pp_hwmgr *hwmgr, struct PP_TemperatureRange *range);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_cac_buffer_in=
fo)(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t virtual_addr_low,<br>
@@ -329,6 &#43;329,8 @@ struct pp_hwmgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smus_notify_pwe)(str=
uct pp_hwmgr *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*powergate_sdma)(stru=
ct pp_hwmgr *hwmgr, bool bgate);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*enable_mgpu_fan_boos=
t)(struct pp_hwmgr *hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_hard_min_dcefclk_by_fre=
q)(struct pp_hwmgr *hwmgr, uint32_t clock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_hard_min_fclk_by_freq)(=
struct pp_hwmgr *hwmgr, uint32_t <br>
&#43;clock);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct pp_table_func {<br>
--<br>
2.7.4<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18094517386BC2D7C102E7FBF7A80BN6PR12MB1809namp_--

--===============1154794256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1154794256==--
