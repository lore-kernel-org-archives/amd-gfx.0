From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Remove SAMU support in powerplay
Date: Wed, 13 Jun 2018 13:51:26 +0000
Message-ID: <BN6PR12MB1809CFE0A857C2FC95CFEBFFF77E0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1528875245-5747-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1814628054=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1528875245-5747-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1814628054==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809CFE0A857C2FC95CFEBFFF77E0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809CFE0A857C2FC95CFEBFFF77E0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, June 13, 2018 3:34:05 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/pp: Remove SAMU support in powerplay

As the SAMU ip was not supported in linux,
so delete the SAMU support in powerplay on
asics Bonarire/Hawwii/Tonga/Fiji/Polaris/vegam.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 .../amd/powerplay/hwmgr/smu7_clockpowergating.c    | 54 --------------
 .../amd/powerplay/hwmgr/smu7_clockpowergating.h    |  1 -
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  1 -
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h   |  1 -
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h |  1 -
 drivers/gpu/drm/amd/powerplay/inc/smumgr.h         |  2 -
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   | 35 ---------
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c | 74 ------------------=
-
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  | 10 ---
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    | 86 ------------------=
----
 .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    | 80 ------------------=
--
 .../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c    | 85 ------------------=
---
 12 files changed, 430 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c b/=
drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
index 6d72a56..4149562 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
@@ -39,13 +39,6 @@ static int smu7_enable_disable_vce_dpm(struct pp_hwmgr *=
hwmgr, bool enable)
                         PPSMC_MSG_VCEDPM_Disable);
 }

-static int smu7_enable_disable_samu_dpm(struct pp_hwmgr *hwmgr, bool enabl=
e)
-{
-       return smum_send_msg_to_smc(hwmgr, enable ?
-                       PPSMC_MSG_SAMUDPM_Enable :
-                       PPSMC_MSG_SAMUDPM_Disable);
-}
-
 static int smu7_update_uvd_dpm(struct pp_hwmgr *hwmgr, bool bgate)
 {
         if (!bgate)
@@ -60,13 +53,6 @@ static int smu7_update_vce_dpm(struct pp_hwmgr *hwmgr, b=
ool bgate)
         return smu7_enable_disable_vce_dpm(hwmgr, !bgate);
 }

-static int smu7_update_samu_dpm(struct pp_hwmgr *hwmgr, bool bgate)
-{
-       if (!bgate)
-               smum_update_smc_table(hwmgr, SMU_SAMU_TABLE);
-       return smu7_enable_disable_samu_dpm(hwmgr, !bgate);
-}
-
 int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr)
 {
         if (phm_cf_want_uvd_power_gating(hwmgr))
@@ -107,35 +93,15 @@ static int smu7_powerup_vce(struct pp_hwmgr *hwmgr)
         return 0;
 }

-static int smu7_powerdown_samu(struct pp_hwmgr *hwmgr)
-{
-       if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
-                       PHM_PlatformCaps_SamuPowerGating))
-               return smum_send_msg_to_smc(hwmgr,
-                               PPSMC_MSG_SAMPowerOFF);
-       return 0;
-}
-
-static int smu7_powerup_samu(struct pp_hwmgr *hwmgr)
-{
-       if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
-                       PHM_PlatformCaps_SamuPowerGating))
-               return smum_send_msg_to_smc(hwmgr,
-                               PPSMC_MSG_SAMPowerON);
-       return 0;
-}
-
 int smu7_disable_clock_power_gating(struct pp_hwmgr *hwmgr)
 {
         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);

         data->uvd_power_gated =3D false;
         data->vce_power_gated =3D false;
-       data->samu_power_gated =3D false;

         smu7_powerup_uvd(hwmgr);
         smu7_powerup_vce(hwmgr);
-       smu7_powerup_samu(hwmgr);

         return 0;
 }
@@ -195,26 +161,6 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool b=
gate)
         }
 }

-int smu7_powergate_samu(struct pp_hwmgr *hwmgr, bool bgate)
-{
-       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
-
-       if (data->samu_power_gated =3D=3D bgate)
-               return 0;
-
-       data->samu_power_gated =3D bgate;
-
-       if (bgate) {
-               smu7_update_samu_dpm(hwmgr, true);
-               smu7_powerdown_samu(hwmgr);
-       } else {
-               smu7_powerup_samu(hwmgr);
-               smu7_update_samu_dpm(hwmgr, false);
-       }
-
-       return 0;
-}
-
 int smu7_update_clock_gatings(struct pp_hwmgr *hwmgr,
                                         const uint32_t *msg_id)
 {
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h b/=
drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h
index 1ddce02..be7f66d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h
@@ -29,7 +29,6 @@
 void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate);
 void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate);
 int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr);
-int smu7_powergate_samu(struct pp_hwmgr *hwmgr, bool bgate);
 int smu7_powergate_acp(struct pp_hwmgr *hwmgr, bool bgate);
 int smu7_disable_clock_power_gating(struct pp_hwmgr *hwmgr);
 int smu7_update_clock_gatings(struct pp_hwmgr *hwmgr,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 11e1762..a338142 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4244,7 +4244,6 @@ static int smu7_init_power_gate_state(struct pp_hwmgr=
 *hwmgr)

         data->uvd_power_gated =3D false;
         data->vce_power_gated =3D false;
-       data->samu_power_gated =3D false;

         return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.h
index c91e75d..3784ce6 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h
@@ -310,7 +310,6 @@ struct smu7_hwmgr {
         /* ---- Power Gating States ---- */
         bool                           uvd_power_gated;
         bool                           vce_power_gated;
-       bool                           samu_power_gated;
         bool                           need_long_memory_training;

         /* Application power optimization parameters */
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h
index aadd6cb..339820d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h
@@ -370,7 +370,6 @@ struct vega10_hwmgr {
         /* ---- Power Gating States ---- */
         bool                           uvd_power_gated;
         bool                           vce_power_gated;
-       bool                           samu_power_gated;
         bool                           need_long_memory_training;

         /* Internal settings to apply the application power optimization p=
arameters */
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h b/drivers/gpu/drm/a=
md/powerplay/inc/smumgr.h
index 6c22ed9..89dfbf5 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
@@ -29,7 +29,6 @@
 enum SMU_TABLE {
         SMU_UVD_TABLE =3D 0,
         SMU_VCE_TABLE,
-       SMU_SAMU_TABLE,
         SMU_BIF_TABLE,
 };

@@ -47,7 +46,6 @@ enum SMU_MEMBER {
         UcodeLoadStatus,
         UvdBootLevel,
         VceBootLevel,
-       SamuBootLevel,
         LowSclkInterruptThreshold,
         DRAM_LOG_ADDR_H,
         DRAM_LOG_ADDR_L,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/ci_smumgr.c
index 2d4ec8a..8cd21ac 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -1614,37 +1614,6 @@ static int ci_populate_smc_acp_level(struct pp_hwmgr=
 *hwmgr,
         return result;
 }

-static int ci_populate_smc_samu_level(struct pp_hwmgr *hwmgr,
-                                       SMU7_Discrete_DpmTable *table)
-{
-       int result =3D -EINVAL;
-       uint8_t count;
-       struct pp_atomctrl_clock_dividers_vi dividers;
-       struct phm_samu_clock_voltage_dependency_table *samu_table =3D
-                               hwmgr->dyn_state.samu_clock_voltage_depende=
ncy_table;
-
-       table->SamuBootLevel =3D 0;
-       table->SamuLevelCount =3D (uint8_t)(samu_table->count);
-
-       for (count =3D 0; count < table->SamuLevelCount; count++) {
-               table->SamuLevel[count].Frequency =3D samu_table->entries[c=
ount].samclk;
-               table->SamuLevel[count].MinVoltage =3D samu_table->entries[=
count].v * VOLTAGE_SCALE;
-               table->SamuLevel[count].MinPhases =3D 1;
-
-               /* retrieve divider value for VBIOS */
-               result =3D atomctrl_get_dfs_pll_dividers_vi(hwmgr,
-                               table->SamuLevel[count].Frequency, &divider=
s);
-               PP_ASSERT_WITH_CODE((0 =3D=3D result),
-                               "can not find divide id for samu clock", re=
turn result);
-
-               table->SamuLevel[count].Divider =3D (uint8_t)dividers.pll_p=
ost_divider;
-
-               CONVERT_FROM_HOST_TO_SMC_UL(table->SamuLevel[count].Frequen=
cy);
-               CONVERT_FROM_HOST_TO_SMC_US(table->SamuLevel[count].MinVolt=
age);
-       }
-       return result;
-}
-
 static int ci_populate_memory_timing_parameters(
                 struct pp_hwmgr *hwmgr,
                 uint32_t engine_clock,
@@ -2026,10 +1995,6 @@ static int ci_init_smc_table(struct pp_hwmgr *hwmgr)
         PP_ASSERT_WITH_CODE(0 =3D=3D result,
                 "Failed to initialize ACP Level!", return result);

-       result =3D ci_populate_smc_samu_level(hwmgr, table);
-       PP_ASSERT_WITH_CODE(0 =3D=3D result,
-               "Failed to initialize SAMU Level!", return result);
-
         /* Since only the initial state is completely set up at this point=
 (the other states are just copies of the boot state) we only */
         /* need to populate the  ARB settings for the initial state. */
         result =3D ci_program_memory_timing_parameters(hwmgr);
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index 53df940..18048f8 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -1503,44 +1503,6 @@ static int fiji_populate_smc_acp_level(struct pp_hwm=
gr *hwmgr,
         return result;
 }

-static int fiji_populate_smc_samu_level(struct pp_hwmgr *hwmgr,
-               SMU73_Discrete_DpmTable *table)
-{
-       int result =3D -EINVAL;
-       uint8_t count;
-       struct pp_atomctrl_clock_dividers_vi dividers;
-       struct phm_ppt_v1_information *table_info =3D
-                       (struct phm_ppt_v1_information *)(hwmgr->pptable);
-       struct phm_ppt_v1_mm_clock_voltage_dependency_table *mm_table =3D
-                       table_info->mm_dep_table;
-
-       table->SamuBootLevel =3D 0;
-       table->SamuLevelCount =3D (uint8_t)(mm_table->count);
-
-       for (count =3D 0; count < table->SamuLevelCount; count++) {
-               /* not sure whether we need evclk or not */
-               table->SamuLevel[count].MinVoltage =3D 0;
-               table->SamuLevel[count].Frequency =3D mm_table->entries[cou=
nt].samclock;
-               table->SamuLevel[count].MinVoltage |=3D (mm_table->entries[=
count].vddc *
-                               VOLTAGE_SCALE) << VDDC_SHIFT;
-               table->SamuLevel[count].MinVoltage |=3D ((mm_table->entries=
[count].vddc -
-                               VDDC_VDDCI_DELTA) * VOLTAGE_SCALE) << VDDCI=
_SHIFT;
-               table->SamuLevel[count].MinVoltage |=3D 1 << PHASES_SHIFT;
-
-               /* retrieve divider value for VBIOS */
-               result =3D atomctrl_get_dfs_pll_dividers_vi(hwmgr,
-                               table->SamuLevel[count].Frequency, &divider=
s);
-               PP_ASSERT_WITH_CODE((0 =3D=3D result),
-                               "can not find divide id for samu clock", re=
turn result);
-
-               table->SamuLevel[count].Divider =3D (uint8_t)dividers.pll_p=
ost_divider;
-
-               CONVERT_FROM_HOST_TO_SMC_UL(table->SamuLevel[count].Frequen=
cy);
-               CONVERT_FROM_HOST_TO_SMC_UL(table->SamuLevel[count].MinVolt=
age);
-       }
-       return result;
-}
-
 static int fiji_populate_memory_timing_parameters(struct pp_hwmgr *hwmgr,
                 int32_t eng_clock, int32_t mem_clock,
                 struct SMU73_Discrete_MCArbDramTimingTableEntry *arb_regs)
@@ -2028,10 +1990,6 @@ static int fiji_init_smc_table(struct pp_hwmgr *hwmg=
r)
         PP_ASSERT_WITH_CODE(0 =3D=3D result,
                         "Failed to initialize ACP Level!", return result);

-       result =3D fiji_populate_smc_samu_level(hwmgr, table);
-       PP_ASSERT_WITH_CODE(0 =3D=3D result,
-                       "Failed to initialize SAMU Level!", return result);
-
         /* Since only the initial state is completely set up at this point
          * (the other states are just copies of the boot state) we only
          * need to populate the  ARB settings for the initial state.
@@ -2378,8 +2336,6 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint=
32_t member)
                         return offsetof(SMU73_Discrete_DpmTable, UvdBootLe=
vel);
                 case VceBootLevel:
                         return offsetof(SMU73_Discrete_DpmTable, VceBootLe=
vel);
-               case SamuBootLevel:
-                       return offsetof(SMU73_Discrete_DpmTable, SamuBootLe=
vel);
                 case LowSclkInterruptThreshold:
                         return offsetof(SMU73_Discrete_DpmTable, LowSclkIn=
terruptThreshold);
                 }
@@ -2478,33 +2434,6 @@ static int fiji_update_vce_smc_table(struct pp_hwmgr=
 *hwmgr)
         return 0;
 }

-static int fiji_update_samu_smc_table(struct pp_hwmgr *hwmgr)
-{
-       struct fiji_smumgr *smu_data =3D (struct fiji_smumgr *)(hwmgr->smu_=
backend);
-       uint32_t mm_boot_level_offset, mm_boot_level_value;
-
-
-       smu_data->smc_state_table.SamuBootLevel =3D 0;
-       mm_boot_level_offset =3D smu_data->smu7_data.dpm_table_start +
-                               offsetof(SMU73_Discrete_DpmTable, SamuBootL=
evel);
-
-       mm_boot_level_offset /=3D 4;
-       mm_boot_level_offset *=3D 4;
-       mm_boot_level_value =3D cgs_read_ind_register(hwmgr->device,
-                       CGS_IND_REG__SMC, mm_boot_level_offset);
-       mm_boot_level_value &=3D 0xFFFFFF00;
-       mm_boot_level_value |=3D smu_data->smc_state_table.SamuBootLevel <<=
 0;
-       cgs_write_ind_register(hwmgr->device,
-                       CGS_IND_REG__SMC, mm_boot_level_offset, mm_boot_lev=
el_value);
-
-       if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
-                       PHM_PlatformCaps_StablePState))
-               smum_send_msg_to_smc_with_parameter(hwmgr,
-                               PPSMC_MSG_SAMUDPM_SetEnabledMask,
-                               (uint32_t)(1 << smu_data->smc_state_table.S=
amuBootLevel));
-       return 0;
-}
-
 static int fiji_update_smc_table(struct pp_hwmgr *hwmgr, uint32_t type)
 {
         switch (type) {
@@ -2514,9 +2443,6 @@ static int fiji_update_smc_table(struct pp_hwmgr *hwm=
gr, uint32_t type)
         case SMU_VCE_TABLE:
                 fiji_update_vce_smc_table(hwmgr);
                 break;
-       case SMU_SAMU_TABLE:
-               fiji_update_samu_smc_table(hwmgr);
-               break;
         default:
                 break;
         }
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/driver=
s/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index 415f691..9299b93 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -1578,12 +1578,6 @@ static int iceland_populate_smc_acp_level(struct pp_=
hwmgr *hwmgr,
         return 0;
 }

-static int iceland_populate_smc_samu_level(struct pp_hwmgr *hwmgr,
-       SMU71_Discrete_DpmTable *table)
-{
-       return 0;
-}
-
 static int iceland_populate_memory_timing_parameters(
                 struct pp_hwmgr *hwmgr,
                 uint32_t engine_clock,
@@ -1992,10 +1986,6 @@ static int iceland_init_smc_table(struct pp_hwmgr *h=
wmgr)
         PP_ASSERT_WITH_CODE(0 =3D=3D result,
                 "Failed to initialize ACP Level!", return result;);

-       result =3D iceland_populate_smc_samu_level(hwmgr, table);
-       PP_ASSERT_WITH_CODE(0 =3D=3D result,
-               "Failed to initialize SAMU Level!", return result;);
-
         /* Since only the initial state is completely set up at this point=
 (the other states are just copies of the boot state) we only */
         /* need to populate the  ARB settings for the initial state. */
         result =3D iceland_program_memory_timing_parameters(hwmgr);
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index a8c6524..a4ce199 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -1337,55 +1337,6 @@ static int polaris10_populate_smc_vce_level(struct p=
p_hwmgr *hwmgr,
         return result;
 }

-
-static int polaris10_populate_smc_samu_level(struct pp_hwmgr *hwmgr,
-               SMU74_Discrete_DpmTable *table)
-{
-       int result =3D -EINVAL;
-       uint8_t count;
-       struct pp_atomctrl_clock_dividers_vi dividers;
-       struct phm_ppt_v1_information *table_info =3D
-                       (struct phm_ppt_v1_information *)(hwmgr->pptable);
-       struct phm_ppt_v1_mm_clock_voltage_dependency_table *mm_table =3D
-                       table_info->mm_dep_table;
-       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
-       uint32_t vddci;
-
-       table->SamuBootLevel =3D 0;
-       table->SamuLevelCount =3D (uint8_t)(mm_table->count);
-
-       for (count =3D 0; count < table->SamuLevelCount; count++) {
-               /* not sure whether we need evclk or not */
-               table->SamuLevel[count].MinVoltage =3D 0;
-               table->SamuLevel[count].Frequency =3D mm_table->entries[cou=
nt].samclock;
-               table->SamuLevel[count].MinVoltage |=3D (mm_table->entries[=
count].vddc *
-                               VOLTAGE_SCALE) << VDDC_SHIFT;
-
-               if (SMU7_VOLTAGE_CONTROL_BY_GPIO =3D=3D data->vddci_control=
)
-                       vddci =3D (uint32_t)phm_find_closest_vddci(&(data->=
vddci_voltage_table),
-                                               mm_table->entries[count].vd=
dc - VDDC_VDDCI_DELTA);
-               else if (SMU7_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data->vddci_c=
ontrol)
-                       vddci =3D mm_table->entries[count].vddc - VDDC_VDDC=
I_DELTA;
-               else
-                       vddci =3D (data->vbios_boot_state.vddci_bootup_valu=
e * VOLTAGE_SCALE) << VDDCI_SHIFT;
-
-               table->SamuLevel[count].MinVoltage |=3D (vddci * VOLTAGE_SC=
ALE) << VDDCI_SHIFT;
-               table->SamuLevel[count].MinVoltage |=3D 1 << PHASES_SHIFT;
-
-               /* retrieve divider value for VBIOS */
-               result =3D atomctrl_get_dfs_pll_dividers_vi(hwmgr,
-                               table->SamuLevel[count].Frequency, &divider=
s);
-               PP_ASSERT_WITH_CODE((0 =3D=3D result),
-                               "can not find divide id for samu clock", re=
turn result);
-
-               table->SamuLevel[count].Divider =3D (uint8_t)dividers.pll_p=
ost_divider;
-
-               CONVERT_FROM_HOST_TO_SMC_UL(table->SamuLevel[count].Frequen=
cy);
-               CONVERT_FROM_HOST_TO_SMC_UL(table->SamuLevel[count].MinVolt=
age);
-       }
-       return result;
-}
-
 static int polaris10_populate_memory_timing_parameters(struct pp_hwmgr *hw=
mgr,
                 int32_t eng_clock, int32_t mem_clock,
                 SMU74_Discrete_MCArbDramTimingTableEntry *arb_regs)
@@ -1865,10 +1816,6 @@ static int polaris10_init_smc_table(struct pp_hwmgr =
*hwmgr)
         PP_ASSERT_WITH_CODE(0 =3D=3D result,
                         "Failed to initialize VCE Level!", return result);

-       result =3D polaris10_populate_smc_samu_level(hwmgr, table);
-       PP_ASSERT_WITH_CODE(0 =3D=3D result,
-                       "Failed to initialize SAMU Level!", return result);
-
         /* Since only the initial state is completely set up at this point
          * (the other states are just copies of the boot state) we only
          * need to populate the  ARB settings for the initial state.
@@ -2222,34 +2169,6 @@ static int polaris10_update_vce_smc_table(struct pp_=
hwmgr *hwmgr)
         return 0;
 }

-static int polaris10_update_samu_smc_table(struct pp_hwmgr *hwmgr)
-{
-       struct polaris10_smumgr *smu_data =3D (struct polaris10_smumgr *)(h=
wmgr->smu_backend);
-       uint32_t mm_boot_level_offset, mm_boot_level_value;
-
-
-       smu_data->smc_state_table.SamuBootLevel =3D 0;
-       mm_boot_level_offset =3D smu_data->smu7_data.dpm_table_start +
-                               offsetof(SMU74_Discrete_DpmTable, SamuBootL=
evel);
-
-       mm_boot_level_offset /=3D 4;
-       mm_boot_level_offset *=3D 4;
-       mm_boot_level_value =3D cgs_read_ind_register(hwmgr->device,
-                       CGS_IND_REG__SMC, mm_boot_level_offset);
-       mm_boot_level_value &=3D 0xFFFFFF00;
-       mm_boot_level_value |=3D smu_data->smc_state_table.SamuBootLevel <<=
 0;
-       cgs_write_ind_register(hwmgr->device,
-                       CGS_IND_REG__SMC, mm_boot_level_offset, mm_boot_lev=
el_value);
-
-       if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
-                       PHM_PlatformCaps_StablePState))
-               smum_send_msg_to_smc_with_parameter(hwmgr,
-                               PPSMC_MSG_SAMUDPM_SetEnabledMask,
-                               (uint32_t)(1 << smu_data->smc_state_table.S=
amuBootLevel));
-       return 0;
-}
-
-
 static int polaris10_update_bif_smc_table(struct pp_hwmgr *hwmgr)
 {
         struct polaris10_smumgr *smu_data =3D (struct polaris10_smumgr *)(=
hwmgr->smu_backend);
@@ -2276,9 +2195,6 @@ static int polaris10_update_smc_table(struct pp_hwmgr=
 *hwmgr, uint32_t type)
         case SMU_VCE_TABLE:
                 polaris10_update_vce_smc_table(hwmgr);
                 break;
-       case SMU_SAMU_TABLE:
-               polaris10_update_samu_smc_table(hwmgr);
-               break;
         case SMU_BIF_TABLE:
                 polaris10_update_bif_smc_table(hwmgr);
         default:
@@ -2357,8 +2273,6 @@ static uint32_t polaris10_get_offsetof(uint32_t type,=
 uint32_t member)
                         return offsetof(SMU74_Discrete_DpmTable, UvdBootLe=
vel);
                 case VceBootLevel:
                         return offsetof(SMU74_Discrete_DpmTable, VceBootLe=
vel);
-               case SamuBootLevel:
-                       return offsetof(SMU74_Discrete_DpmTable, SamuBootLe=
vel);
                 case LowSclkInterruptThreshold:
                         return offsetof(SMU74_Discrete_DpmTable, LowSclkIn=
terruptThreshold);
                 }
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
index 782b19f..7dabc6c 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -1443,51 +1443,6 @@ static int tonga_populate_smc_acp_level(struct pp_hw=
mgr *hwmgr,
         return result;
 }

-static int tonga_populate_smc_samu_level(struct pp_hwmgr *hwmgr,
-               SMU72_Discrete_DpmTable *table)
-{
-       int result =3D 0;
-       uint8_t count;
-       pp_atomctrl_clock_dividers_vi dividers;
-       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
-       struct phm_ppt_v1_information *pptable_info =3D
-                            (struct phm_ppt_v1_information *)(hwmgr->pptab=
le);
-       phm_ppt_v1_mm_clock_voltage_dependency_table *mm_table =3D
-                                                   pptable_info->mm_dep_ta=
ble;
-
-       table->SamuBootLevel =3D 0;
-       table->SamuLevelCount =3D (uint8_t) (mm_table->count);
-
-       for (count =3D 0; count < table->SamuLevelCount; count++) {
-               /* not sure whether we need evclk or not */
-               table->SamuLevel[count].Frequency =3D
-                       pptable_info->mm_dep_table->entries[count].samclock=
;
-               table->SamuLevel[count].MinVoltage.Vddc =3D
-                       phm_get_voltage_index(pptable_info->vddc_lookup_tab=
le,
-                               mm_table->entries[count].vddc);
-               table->SamuLevel[count].MinVoltage.VddGfx =3D
-                       (data->vdd_gfx_control =3D=3D SMU7_VOLTAGE_CONTROL_=
BY_SVID2) ?
-                       phm_get_voltage_index(pptable_info->vddgfx_lookup_t=
able,
-                               mm_table->entries[count].vddgfx) : 0;
-               table->SamuLevel[count].MinVoltage.Vddci =3D
-                       phm_get_voltage_id(&data->vddci_voltage_table,
-                               mm_table->entries[count].vddc - VDDC_VDDCI_=
DELTA);
-               table->SamuLevel[count].MinVoltage.Phases =3D 1;
-
-               /* retrieve divider value for VBIOS */
-               result =3D atomctrl_get_dfs_pll_dividers_vi(hwmgr,
-                                       table->SamuLevel[count].Frequency, =
&dividers);
-               PP_ASSERT_WITH_CODE((!result),
-                       "can not find divide id for samu clock", return res=
ult);
-
-               table->SamuLevel[count].Divider =3D (uint8_t)dividers.pll_p=
ost_divider;
-
-               CONVERT_FROM_HOST_TO_SMC_UL(table->SamuLevel[count].Frequen=
cy);
-       }
-
-       return result;
-}
-
 static int tonga_populate_memory_timing_parameters(
                 struct pp_hwmgr *hwmgr,
                 uint32_t engine_clock,
@@ -2323,10 +2278,6 @@ static int tonga_init_smc_table(struct pp_hwmgr *hwm=
gr)
         PP_ASSERT_WITH_CODE(!result,
                 "Failed to initialize ACP Level !", return result);

-       result =3D tonga_populate_smc_samu_level(hwmgr, table);
-       PP_ASSERT_WITH_CODE(!result,
-               "Failed to initialize SAMU Level !", return result);
-
         /* Since only the initial state is completely set up at this
         * point (the other states are just copies of the boot state) we on=
ly
         * need to populate the  ARB settings for the initial state.
@@ -2673,8 +2624,6 @@ static uint32_t tonga_get_offsetof(uint32_t type, uin=
t32_t member)
                         return offsetof(SMU72_Discrete_DpmTable, UvdBootLe=
vel);
                 case VceBootLevel:
                         return offsetof(SMU72_Discrete_DpmTable, VceBootLe=
vel);
-               case SamuBootLevel:
-                       return offsetof(SMU72_Discrete_DpmTable, SamuBootLe=
vel);
                 case LowSclkInterruptThreshold:
                         return offsetof(SMU72_Discrete_DpmTable, LowSclkIn=
terruptThreshold);
                 }
@@ -2773,32 +2722,6 @@ static int tonga_update_vce_smc_table(struct pp_hwmg=
r *hwmgr)
         return 0;
 }

-static int tonga_update_samu_smc_table(struct pp_hwmgr *hwmgr)
-{
-       struct tonga_smumgr *smu_data =3D (struct tonga_smumgr *)(hwmgr->sm=
u_backend);
-       uint32_t mm_boot_level_offset, mm_boot_level_value;
-
-       smu_data->smc_state_table.SamuBootLevel =3D 0;
-       mm_boot_level_offset =3D smu_data->smu7_data.dpm_table_start +
-                               offsetof(SMU72_Discrete_DpmTable, SamuBootL=
evel);
-
-       mm_boot_level_offset /=3D 4;
-       mm_boot_level_offset *=3D 4;
-       mm_boot_level_value =3D cgs_read_ind_register(hwmgr->device,
-                       CGS_IND_REG__SMC, mm_boot_level_offset);
-       mm_boot_level_value &=3D 0xFFFFFF00;
-       mm_boot_level_value |=3D smu_data->smc_state_table.SamuBootLevel <<=
 0;
-       cgs_write_ind_register(hwmgr->device,
-                       CGS_IND_REG__SMC, mm_boot_level_offset, mm_boot_lev=
el_value);
-
-       if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
-                       PHM_PlatformCaps_StablePState))
-               smum_send_msg_to_smc_with_parameter(hwmgr,
-                               PPSMC_MSG_SAMUDPM_SetEnabledMask,
-                               (uint32_t)(1 << smu_data->smc_state_table.S=
amuBootLevel));
-       return 0;
-}
-
 static int tonga_update_smc_table(struct pp_hwmgr *hwmgr, uint32_t type)
 {
         switch (type) {
@@ -2808,9 +2731,6 @@ static int tonga_update_smc_table(struct pp_hwmgr *hw=
mgr, uint32_t type)
         case SMU_VCE_TABLE:
                 tonga_update_vce_smc_table(hwmgr);
                 break;
-       case SMU_SAMU_TABLE:
-               tonga_update_samu_smc_table(hwmgr);
-               break;
         default:
                 break;
         }
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 2de4895..57420d7 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -393,34 +393,6 @@ static int vegam_update_vce_smc_table(struct pp_hwmgr =
*hwmgr)
         return 0;
 }

-static int vegam_update_samu_smc_table(struct pp_hwmgr *hwmgr)
-{
-       struct vegam_smumgr *smu_data =3D (struct vegam_smumgr *)(hwmgr->sm=
u_backend);
-       uint32_t mm_boot_level_offset, mm_boot_level_value;
-
-
-       smu_data->smc_state_table.SamuBootLevel =3D 0;
-       mm_boot_level_offset =3D smu_data->smu7_data.dpm_table_start +
-                               offsetof(SMU75_Discrete_DpmTable, SamuBootL=
evel);
-
-       mm_boot_level_offset /=3D 4;
-       mm_boot_level_offset *=3D 4;
-       mm_boot_level_value =3D cgs_read_ind_register(hwmgr->device,
-                       CGS_IND_REG__SMC, mm_boot_level_offset);
-       mm_boot_level_value &=3D 0xFFFFFF00;
-       mm_boot_level_value |=3D smu_data->smc_state_table.SamuBootLevel <<=
 0;
-       cgs_write_ind_register(hwmgr->device,
-                       CGS_IND_REG__SMC, mm_boot_level_offset, mm_boot_lev=
el_value);
-
-       if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
-                       PHM_PlatformCaps_StablePState))
-               smum_send_msg_to_smc_with_parameter(hwmgr,
-                               PPSMC_MSG_SAMUDPM_SetEnabledMask,
-                               (uint32_t)(1 << smu_data->smc_state_table.S=
amuBootLevel));
-       return 0;
-}
-
-
 static int vegam_update_bif_smc_table(struct pp_hwmgr *hwmgr)
 {
         struct vegam_smumgr *smu_data =3D (struct vegam_smumgr *)(hwmgr->s=
mu_backend);
@@ -447,9 +419,6 @@ static int vegam_update_smc_table(struct pp_hwmgr *hwmg=
r, uint32_t type)
         case SMU_VCE_TABLE:
                 vegam_update_vce_smc_table(hwmgr);
                 break;
-       case SMU_SAMU_TABLE:
-               vegam_update_samu_smc_table(hwmgr);
-               break;
         case SMU_BIF_TABLE:
                 vegam_update_bif_smc_table(hwmgr);
                 break;
@@ -1281,54 +1250,6 @@ static int vegam_populate_smc_vce_level(struct pp_hw=
mgr *hwmgr,
         return result;
 }

-static int vegam_populate_smc_samu_level(struct pp_hwmgr *hwmgr,
-               SMU75_Discrete_DpmTable *table)
-{
-       int result =3D -EINVAL;
-       uint8_t count;
-       struct pp_atomctrl_clock_dividers_vi dividers;
-       struct phm_ppt_v1_information *table_info =3D
-                       (struct phm_ppt_v1_information *)(hwmgr->pptable);
-       struct phm_ppt_v1_mm_clock_voltage_dependency_table *mm_table =3D
-                       table_info->mm_dep_table;
-       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
-       uint32_t vddci;
-
-       table->SamuBootLevel =3D 0;
-       table->SamuLevelCount =3D (uint8_t)(mm_table->count);
-
-       for (count =3D 0; count < table->SamuLevelCount; count++) {
-               /* not sure whether we need evclk or not */
-               table->SamuLevel[count].MinVoltage =3D 0;
-               table->SamuLevel[count].Frequency =3D mm_table->entries[cou=
nt].samclock;
-               table->SamuLevel[count].MinVoltage |=3D (mm_table->entries[=
count].vddc *
-                               VOLTAGE_SCALE) << VDDC_SHIFT;
-
-               if (SMU7_VOLTAGE_CONTROL_BY_GPIO =3D=3D data->vddci_control=
)
-                       vddci =3D (uint32_t)phm_find_closest_vddci(&(data->=
vddci_voltage_table),
-                                               mm_table->entries[count].vd=
dc - VDDC_VDDCI_DELTA);
-               else if (SMU7_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data->vddci_c=
ontrol)
-                       vddci =3D mm_table->entries[count].vddc - VDDC_VDDC=
I_DELTA;
-               else
-                       vddci =3D (data->vbios_boot_state.vddci_bootup_valu=
e * VOLTAGE_SCALE) << VDDCI_SHIFT;
-
-               table->SamuLevel[count].MinVoltage |=3D (vddci * VOLTAGE_SC=
ALE) << VDDCI_SHIFT;
-               table->SamuLevel[count].MinVoltage |=3D 1 << PHASES_SHIFT;
-
-               /* retrieve divider value for VBIOS */
-               result =3D atomctrl_get_dfs_pll_dividers_vi(hwmgr,
-                               table->SamuLevel[count].Frequency, &divider=
s);
-               PP_ASSERT_WITH_CODE((0 =3D=3D result),
-                               "can not find divide id for samu clock", re=
turn result);
-
-               table->SamuLevel[count].Divider =3D (uint8_t)dividers.pll_p=
ost_divider;
-
-               CONVERT_FROM_HOST_TO_SMC_UL(table->SamuLevel[count].Frequen=
cy);
-               CONVERT_FROM_HOST_TO_SMC_UL(table->SamuLevel[count].MinVolt=
age);
-       }
-       return result;
-}
-
 static int vegam_populate_memory_timing_parameters(struct pp_hwmgr *hwmgr,
                 int32_t eng_clock, int32_t mem_clock,
                 SMU75_Discrete_MCArbDramTimingTableEntry *arb_regs)
@@ -2062,10 +1983,6 @@ static int vegam_init_smc_table(struct pp_hwmgr *hwm=
gr)
         PP_ASSERT_WITH_CODE(!result,
                         "Failed to initialize VCE Level!", return result);

-       result =3D vegam_populate_smc_samu_level(hwmgr, table);
-       PP_ASSERT_WITH_CODE(!result,
-                       "Failed to initialize SAMU Level!", return result);
-
         /* Since only the initial state is completely set up at this point
          * (the other states are just copies of the boot state) we only
          * need to populate the  ARB settings for the initial state.
@@ -2273,8 +2190,6 @@ static uint32_t vegam_get_offsetof(uint32_t type, uin=
t32_t member)
                         return offsetof(SMU75_Discrete_DpmTable, UvdBootLe=
vel);
                 case VceBootLevel:
                         return offsetof(SMU75_Discrete_DpmTable, VceBootLe=
vel);
-               case SamuBootLevel:
-                       return offsetof(SMU75_Discrete_DpmTable, SamuBootLe=
vel);
                 case LowSclkInterruptThreshold:
                         return offsetof(SMU75_Discrete_DpmTable, LowSclkIn=
terruptThreshold);
                 }
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809CFE0A857C2FC95CFEBFFF77E0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Wednesday, June 13, 2018 3:34:05 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/pp: Remove SAMU support in powerplay</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">As the SAMU ip was not supported in linux,<br>
so delete the SAMU support in powerplay on<br>
asics Bonarire/Hawwii/Tonga/Fiji/Polaris/vegam.<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../amd/powerplay/hwmgr/smu7_clockpowergating.c&nbsp;&nbsp;&nbsp; | 5=
4 --------------<br>
&nbsp;.../amd/powerplay/hwmgr/smu7_clockpowergating.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp; |&nbsp; =
1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h&nbsp;&nbsp; |&nbsp; =
1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smumgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c&nbsp;&nbsp; | 35 ---=
------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c | 74 -------------=
------<br>
&nbsp;.../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c&nbsp; | 10 ---<br>
&nbsp;.../drm/amd/powerplay/smumgr/polaris10_smumgr.c&nbsp;&nbsp;&nbsp; | 8=
6 ----------------------<br>
&nbsp;.../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c&nbsp;&nbsp;&nbsp; | 8=
0 --------------------<br>
&nbsp;.../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c&nbsp;&nbsp;&nbsp; | 8=
5 ---------------------<br>
&nbsp;12 files changed, 430 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c b/=
drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c<br>
index 6d72a56..4149562 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating=
.c<br>
@@ -39,13 &#43;39,6 @@ static int smu7_enable_disable_vce_dpm(struct pp_hwm=
gr *hwmgr, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC=
_MSG_VCEDPM_Disable);<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu7_enable_disable_samu_dpm(struct pp_hwmgr *hwmgr, bool enabl=
e)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smum_send_msg_to_smc(hwmgr, en=
able ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SAMUDP=
M_Enable :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SAMUDP=
M_Disable);<br>
-}<br>
-<br>
&nbsp;static int smu7_update_uvd_dpm(struct pp_hwmgr *hwmgr, bool bgate)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bgate)<br>
@@ -60,13 &#43;53,6 @@ static int smu7_update_vce_dpm(struct pp_hwmgr *hwmg=
r, bool bgate)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu7_enable_disable=
_vce_dpm(hwmgr, !bgate);<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu7_update_samu_dpm(struct pp_hwmgr *hwmgr, bool bgate)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bgate)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_update_smc_table(hwmgr, SMU_SAMU_TABLE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu7_enable_disable_samu_dpm(h=
wmgr, !bgate);<br>
-}<br>
-<br>
&nbsp;int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cf_want_uvd_power_=
gating(hwmgr))<br>
@@ -107,35 &#43;93,15 @@ static int smu7_powerup_vce(struct pp_hwmgr *hwmgr=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu7_powerdown_samu(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;platfor=
m_descriptor.platformCaps,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps=
_SamuPowerGating))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return smum_send_msg_to_smc(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SAMPowerOFF);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-static int smu7_powerup_samu(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;platfor=
m_descriptor.platformCaps,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps=
_SamuPowerGating))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return smum_send_msg_to_smc(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SAMPowerON);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;int smu7_disable_clock_power_gating(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =
=3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;uvd_power_gated =
=3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;vce_power_gated =
=3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;samu_power_gated =3D false;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_powerup_uvd(hwmgr);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_powerup_vce(hwmgr);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_powerup_samu(hwmgr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -195,26 &#43;161,6 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bo=
ol bgate)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-int smu7_powergate_samu(struct pp_hwmgr *hwmgr, bool bgate)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D (struct s=
mu7_hwmgr *)(hwmgr-&gt;backend);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;samu_power_gated =3D=3D =
bgate)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;samu_power_gated =3D bgate;<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bgate) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu7_update_samu_dpm(hwmgr, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu7_powerdown_samu(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu7_powerup_samu(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu7_update_samu_dpm(hwmgr, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;int smu7_update_clock_gatings(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const uint32_t *msg_id)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h b/=
drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h<br>
index 1ddce02..be7f66d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating=
.h<br>
@@ -29,7 &#43;29,6 @@<br>
&nbsp;void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate);<br>
&nbsp;void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate);<br>
&nbsp;int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr);<br>
-int smu7_powergate_samu(struct pp_hwmgr *hwmgr, bool bgate);<br>
&nbsp;int smu7_powergate_acp(struct pp_hwmgr *hwmgr, bool bgate);<br>
&nbsp;int smu7_disable_clock_power_gating(struct pp_hwmgr *hwmgr);<br>
&nbsp;int smu7_update_clock_gatings(struct pp_hwmgr *hwmgr,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index 11e1762..a338142 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -4244,7 &#43;4244,6 @@ static int smu7_init_power_gate_state(struct pp_h=
wmgr *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;uvd_power_gated =
=3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;vce_power_gated =
=3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;samu_power_gated =3D false;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.h<br>
index c91e75d..3784ce6 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h<br>
@@ -310,7 &#43;310,6 @@ struct smu7_hwmgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ---- Power Gating State=
s ---- */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_power_gated=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_power_gated=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; samu_power_gated;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; need_long_memor=
y_training;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Application power optim=
ization parameters */<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h<br>
index aadd6cb..339820d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h<br>
@@ -370,7 &#43;370,6 @@ struct vega10_hwmgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ---- Power Gating State=
s ---- */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_power_gated=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_power_gated=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; samu_power_gated;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; need_long_memor=
y_training;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Internal settings to ap=
ply the application power optimization parameters */<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h b/drivers/gpu/drm/a=
md/powerplay/inc/smumgr.h<br>
index 6c22ed9..89dfbf5 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
@@ -29,7 &#43;29,6 @@<br>
&nbsp;enum SMU_TABLE {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_UVD_TABLE =3D 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_VCE_TABLE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_SAMU_TABLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_BIF_TABLE,<br>
&nbsp;};<br>
&nbsp;<br>
@@ -47,7 &#43;46,6 @@ enum SMU_MEMBER {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UcodeLoadStatus,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UvdBootLevel,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VceBootLevel,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SamuBootLevel,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LowSclkInterruptThreshold,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRAM_LOG_ADDR_H,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRAM_LOG_ADDR_L,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/ci_smumgr.c<br>
index 2d4ec8a..8cd21ac 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c<br>
@@ -1614,37 &#43;1614,6 @@ static int ci_populate_smc_acp_level(struct pp_h=
wmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
-static int ci_populate_smc_samu_level(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; SMU7_Discrete_DpmTable *table)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_atomctrl_clock_dividers_vi =
dividers;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_samu_clock_voltage_depende=
ncy_table *samu_table =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.samu_clock_voltage_depe=
ndency_table;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuBootLevel =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuLevelCount =3D (uint8_t=
)(samu_table-&gt;count);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (count =3D 0; count &lt; table-&g=
t;SamuLevelCount; count&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].Frequency =3D samu_table-&gt;entries[=
count].samclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage =3D samu_table-&gt;entries=
[count].v * VOLTAGE_SCALE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinPhases =3D 1;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* retrieve divider value for VBIOS */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D atomctrl_get_dfs_pll_dividers_vi(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuLevel[count].Frequency, &amp;=
dividers);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE((0 =3D=3D result),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;can not find divide id for samu clock=
&quot;, return result);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].Divider =3D (uint8_t)dividers.pll_pos=
t_divider;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CONVERT_FROM_HOST_TO_SMC_UL(table-&gt;SamuLevel[count].Frequency=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CONVERT_FROM_HOST_TO_SMC_US(table-&gt;SamuLevel[count].MinVoltag=
e);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
-}<br>
-<br>
&nbsp;static int ci_populate_memory_timing_parameters(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t engine_clock,<br>
@@ -2026,10 &#43;1995,6 @@ static int ci_init_smc_table(struct pp_hwmgr *hw=
mgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D result,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;Failed to initialize ACP Level!&quot;, return r=
esult);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D ci_populate_smc_samu_level=
(hwmgr, table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=3D result,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &quot;Failed to initialize SAMU Level!&quot;, return result);<br=
>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Since only the initial =
state is completely set up at this point (the other states are just copies =
of the boot state) we only */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need to populate the&nb=
sp; ARB settings for the initial state. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D ci_program_memo=
ry_timing_parameters(hwmgr);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
index 53df940..18048f8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
@@ -1503,44 &#43;1503,6 @@ static int fiji_populate_smc_acp_level(struct pp=
_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
-static int fiji_populate_smc_samu_level(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU73_Discrete_DpmTable *table)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_atomctrl_clock_dividers_vi =
dividers;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_information *table_=
info =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct phm_ppt_=
v1_information *)(hwmgr-&gt;pptable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_mm_clock_voltage_de=
pendency_table *mm_table =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_info-&gt;m=
m_dep_table;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuBootLevel =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuLevelCount =3D (uint8_t=
)(mm_table-&gt;count);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (count =3D 0; count &lt; table-&g=
t;SamuLevelCount; count&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* not sure whether we need evclk or not */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].Frequency =3D mm_table-&gt;entries[co=
unt].samclock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage |=3D (mm_table-&gt;entries=
[count].vddc *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VOLTAGE_SCALE) &lt;&lt; VDDC_SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage |=3D ((mm_table-&gt;entrie=
s[count].vddc -<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VDDC_VDDCI_DELTA) * VOLTAGE_SCALE) &lt;&lt;=
 VDDCI_SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage |=3D 1 &lt;&lt; PHASES_SHI=
FT;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* retrieve divider value for VBIOS */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D atomctrl_get_dfs_pll_dividers_vi(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuLevel[count].Frequency, &amp;=
dividers);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE((0 =3D=3D result),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;can not find divide id for samu clock=
&quot;, return result);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].Divider =3D (uint8_t)dividers.pll_pos=
t_divider;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CONVERT_FROM_HOST_TO_SMC_UL(table-&gt;SamuLevel[count].Frequency=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CONVERT_FROM_HOST_TO_SMC_UL(table-&gt;SamuLevel[count].MinVoltag=
e);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
-}<br>
-<br>
&nbsp;static int fiji_populate_memory_timing_parameters(struct pp_hwmgr *hw=
mgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int32_t eng_clock, int32_t mem_clock,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct SMU73_Discrete_MCArbDramTimingTableEntry *arb_=
regs)<br>
@@ -2028,10 &#43;1990,6 @@ static int fiji_init_smc_table(struct pp_hwmgr *=
hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D result,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Failed to initialize ACP Level!&quot;, return result);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D fiji_populate_smc_samu_lev=
el(hwmgr, table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=3D result,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to =
initialize SAMU Level!&quot;, return result);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Since only the initial =
state is completely set up at this point<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (the other states =
are just copies of the boot state) we only<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * need to populate t=
he&nbsp; ARB settings for the initial state.<br>
@@ -2378,8 &#43;2336,6 @@ static uint32_t fiji_get_offsetof(uint32_t type, =
uint32_t member)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU73_Discrete_DpmTable, UvdBootLevel);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case VceBootLevel:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU73_Discrete_DpmTable, VceBootLevel);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case SamuBootLevel:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return offsetof(=
SMU73_Discrete_DpmTable, SamuBootLevel);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case LowSclkInterruptThreshold:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU73_Discrete_DpmTable, LowSclkInterruptThreshold);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2478,33 &#43;2434,6 @@ static int fiji_update_vce_smc_table(struct pp_h=
wmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int fiji_update_samu_smc_table(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct fiji_smumgr *smu_data =3D (str=
uct fiji_smumgr *)(hwmgr-&gt;smu_backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mm_boot_level_offset, mm_boo=
t_level_value;<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_data-&gt;smc_state_table.SamuBoot=
Level =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset =3D smu_data-&gt=
;smu7_data.dpm_table_start &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(SMU73_Discrete_DpmTable, SamuBootL=
evel);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset /=3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset *=3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value =3D cgs_read_ind_=
register(hwmgr-&gt;device,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC=
, mm_boot_level_offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value &amp;=3D 0xFFFFFF=
00;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value |=3D smu_data-&gt=
;smc_state_table.SamuBootLevel &lt;&lt; 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_ind_register(hwmgr-&gt;devi=
ce,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC=
, mm_boot_level_offset, mm_boot_level_value);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;platfor=
m_descriptor.platformCaps,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps=
_StablePState))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SAMUDPM_SetEnabledMask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t)(1 &lt;&lt; smu_data-&gt;smc_stat=
e_table.SamuBootLevel));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int fiji_update_smc_table(struct pp_hwmgr *hwmgr, uint32_t typ=
e)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
@@ -2514,9 &#43;2443,6 @@ static int fiji_update_smc_table(struct pp_hwmgr =
*hwmgr, uint32_t type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_VCE_TABLE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fiji_update_vce_smc_table(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SAMU_TABLE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fiji_update_samu_smc_table(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/driver=
s/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
index 415f691..9299b93 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
@@ -1578,12 &#43;1578,6 @@ static int iceland_populate_smc_acp_level(struct=
 pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int iceland_populate_smc_samu_level(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU71_Discrete_DpmTable *table)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int iceland_populate_memory_timing_parameters(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t engine_clock,<br>
@@ -1992,10 &#43;1986,6 @@ static int iceland_init_smc_table(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D result,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;Failed to initialize ACP Level!&quot;, return r=
esult;);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D iceland_populate_smc_samu_=
level(hwmgr, table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=3D result,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &quot;Failed to initialize SAMU Level!&quot;, return result;);<b=
r>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Since only the initial =
state is completely set up at this point (the other states are just copies =
of the boot state) we only */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need to populate the&nb=
sp; ARB settings for the initial state. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D iceland_program=
_memory_timing_parameters(hwmgr);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
index a8c6524..a4ce199 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<b=
r>
@@ -1337,55 &#43;1337,6 @@ static int polaris10_populate_smc_vce_level(stru=
ct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
-<br>
-static int polaris10_populate_smc_samu_level(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU74_Discrete_DpmTable *table)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_atomctrl_clock_dividers_vi =
dividers;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_information *table_=
info =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct phm_ppt_=
v1_information *)(hwmgr-&gt;pptable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_mm_clock_voltage_de=
pendency_table *mm_table =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_info-&gt;m=
m_dep_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D (struct s=
mu7_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vddci;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuBootLevel =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuLevelCount =3D (uint8_t=
)(mm_table-&gt;count);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (count =3D 0; count &lt; table-&g=
t;SamuLevelCount; count&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* not sure whether we need evclk or not */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].Frequency =3D mm_table-&gt;entries[co=
unt].samclock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage |=3D (mm_table-&gt;entries=
[count].vddc *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VOLTAGE_SCALE) &lt;&lt; VDDC_SHIFT;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (SMU7_VOLTAGE_CONTROL_BY_GPIO =3D=3D data-&gt;vddci_control)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vddci =3D (uint3=
2_t)phm_find_closest_vddci(&amp;(data-&gt;vddci_voltage_table),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_table-&gt;entries[c=
ount].vddc - VDDC_VDDCI_DELTA);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (SMU7_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data-&gt;vddci_con=
trol)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vddci =3D mm_tab=
le-&gt;entries[count].vddc - VDDC_VDDCI_DELTA;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vddci =3D (data-=
&gt;vbios_boot_state.vddci_bootup_value * VOLTAGE_SCALE) &lt;&lt; VDDCI_SHI=
FT;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage |=3D (vddci * VOLTAGE_SCAL=
E) &lt;&lt; VDDCI_SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage |=3D 1 &lt;&lt; PHASES_SHI=
FT;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* retrieve divider value for VBIOS */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D atomctrl_get_dfs_pll_dividers_vi(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuLevel[count].Frequency, &amp;=
dividers);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE((0 =3D=3D result),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;can not find divide id for samu clock=
&quot;, return result);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].Divider =3D (uint8_t)dividers.pll_pos=
t_divider;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CONVERT_FROM_HOST_TO_SMC_UL(table-&gt;SamuLevel[count].Frequency=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CONVERT_FROM_HOST_TO_SMC_UL(table-&gt;SamuLevel[count].MinVoltag=
e);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
-}<br>
-<br>
&nbsp;static int polaris10_populate_memory_timing_parameters(struct pp_hwmg=
r *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int32_t eng_clock, int32_t mem_clock,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SMU74_Discrete_MCArbDramTimingTableEntry *arb_regs)<b=
r>
@@ -1865,10 &#43;1816,6 @@ static int polaris10_init_smc_table(struct pp_hw=
mgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=
=3D result,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Failed to initialize VCE Level!&quot;, return result);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D polaris10_populate_smc_sam=
u_level(hwmgr, table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(0 =3D=3D result,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to =
initialize SAMU Level!&quot;, return result);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Since only the initial =
state is completely set up at this point<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (the other states =
are just copies of the boot state) we only<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * need to populate t=
he&nbsp; ARB settings for the initial state.<br>
@@ -2222,34 &#43;2169,6 @@ static int polaris10_update_vce_smc_table(struct=
 pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int polaris10_update_samu_smc_table(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct polaris10_smumgr *smu_data =3D=
 (struct polaris10_smumgr *)(hwmgr-&gt;smu_backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mm_boot_level_offset, mm_boo=
t_level_value;<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_data-&gt;smc_state_table.SamuBoot=
Level =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset =3D smu_data-&gt=
;smu7_data.dpm_table_start &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(SMU74_Discrete_DpmTable, SamuBootL=
evel);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset /=3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset *=3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value =3D cgs_read_ind_=
register(hwmgr-&gt;device,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC=
, mm_boot_level_offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value &amp;=3D 0xFFFFFF=
00;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value |=3D smu_data-&gt=
;smc_state_table.SamuBootLevel &lt;&lt; 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_ind_register(hwmgr-&gt;devi=
ce,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC=
, mm_boot_level_offset, mm_boot_level_value);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;platfor=
m_descriptor.platformCaps,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps=
_StablePState))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SAMUDPM_SetEnabledMask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t)(1 &lt;&lt; smu_data-&gt;smc_stat=
e_table.SamuBootLevel));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-<br>
&nbsp;static int polaris10_update_bif_smc_table(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct polaris10_smumgr *s=
mu_data =3D (struct polaris10_smumgr *)(hwmgr-&gt;smu_backend);<br>
@@ -2276,9 &#43;2195,6 @@ static int polaris10_update_smc_table(struct pp_h=
wmgr *hwmgr, uint32_t type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_VCE_TABLE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; polaris10_update_vce_smc_table(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SAMU_TABLE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; polaris10_update_samu_smc_table(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_BIF_TABLE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; polaris10_update_bif_smc_table(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
@@ -2357,8 &#43;2273,6 @@ static uint32_t polaris10_get_offsetof(uint32_t t=
ype, uint32_t member)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU74_Discrete_DpmTable, UvdBootLevel);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case VceBootLevel:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU74_Discrete_DpmTable, VceBootLevel);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case SamuBootLevel:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return offsetof(=
SMU74_Discrete_DpmTable, SamuBootLevel);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case LowSclkInterruptThreshold:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU74_Discrete_DpmTable, LowSclkInterruptThreshold);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
index 782b19f..7dabc6c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
@@ -1443,51 &#43;1443,6 @@ static int tonga_populate_smc_acp_level(struct p=
p_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
-static int tonga_populate_smc_samu_level(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU72_Discrete_DpmTable *table)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_atomctrl_clock_dividers_vi divider=
s;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D (struct s=
mu7_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_information *pptabl=
e_info =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (struct phm_ppt_v1_information *)(hwmgr-&gt;pptable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_ppt_v1_mm_clock_voltage_dependenc=
y_table *mm_table =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; pptable_info-&gt;mm_dep_table;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuBootLevel =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuLevelCount =3D (uint8_t=
) (mm_table-&gt;count);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (count =3D 0; count &lt; table-&g=
t;SamuLevelCount; count&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* not sure whether we need evclk or not */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].Frequency =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptable_info-&gt=
;mm_dep_table-&gt;entries[count].samclock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage.Vddc =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_get_voltage_=
index(pptable_info-&gt;vddc_lookup_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_table-&gt;entries[count].vddc);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage.VddGfx =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (data-&gt;vdd_gf=
x_control =3D=3D SMU7_VOLTAGE_CONTROL_BY_SVID2) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_get_voltage_=
index(pptable_info-&gt;vddgfx_lookup_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_table-&gt;entries[count].vddgfx) : 0;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage.Vddci =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_get_voltage_=
id(&amp;data-&gt;vddci_voltage_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_table-&gt;entries[count].vddc - VDDC_VDD=
CI_DELTA);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage.Phases =3D 1;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* retrieve divider value for VBIOS */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D atomctrl_get_dfs_pll_dividers_vi(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; table-&gt;SamuLevel[count].Frequency, &amp;dividers);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE((!result),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;can not fi=
nd divide id for samu clock&quot;, return result);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].Divider =3D (uint8_t)dividers.pll_pos=
t_divider;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CONVERT_FROM_HOST_TO_SMC_UL(table-&gt;SamuLevel[count].Frequency=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
-}<br>
-<br>
&nbsp;static int tonga_populate_memory_timing_parameters(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t engine_clock,<br>
@@ -2323,10 &#43;2278,6 @@ static int tonga_init_smc_table(struct pp_hwmgr =
*hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!resul=
t,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;Failed to initialize ACP Level !&quot;, return =
result);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D tonga_populate_smc_samu_le=
vel(hwmgr, table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!result,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &quot;Failed to initialize SAMU Level !&quot;, return result);<b=
r>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Since only the initial =
state is completely set up at this<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * point (the other states =
are just copies of the boot state) we only<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * need to populate the&nbs=
p; ARB settings for the initial state.<br>
@@ -2673,8 &#43;2624,6 @@ static uint32_t tonga_get_offsetof(uint32_t type,=
 uint32_t member)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU72_Discrete_DpmTable, UvdBootLevel);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case VceBootLevel:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU72_Discrete_DpmTable, VceBootLevel);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case SamuBootLevel:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return offsetof(=
SMU72_Discrete_DpmTable, SamuBootLevel);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case LowSclkInterruptThreshold:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU72_Discrete_DpmTable, LowSclkInterruptThreshold);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2773,32 &#43;2722,6 @@ static int tonga_update_vce_smc_table(struct pp_=
hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int tonga_update_samu_smc_table(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tonga_smumgr *smu_data =3D (st=
ruct tonga_smumgr *)(hwmgr-&gt;smu_backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mm_boot_level_offset, mm_boo=
t_level_value;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_data-&gt;smc_state_table.SamuBoot=
Level =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset =3D smu_data-&gt=
;smu7_data.dpm_table_start &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(SMU72_Discrete_DpmTable, SamuBootL=
evel);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset /=3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset *=3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value =3D cgs_read_ind_=
register(hwmgr-&gt;device,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC=
, mm_boot_level_offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value &amp;=3D 0xFFFFFF=
00;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value |=3D smu_data-&gt=
;smc_state_table.SamuBootLevel &lt;&lt; 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_ind_register(hwmgr-&gt;devi=
ce,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC=
, mm_boot_level_offset, mm_boot_level_value);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;platfor=
m_descriptor.platformCaps,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps=
_StablePState))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SAMUDPM_SetEnabledMask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t)(1 &lt;&lt; smu_data-&gt;smc_stat=
e_table.SamuBootLevel));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int tonga_update_smc_table(struct pp_hwmgr *hwmgr, uint32_t ty=
pe)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
@@ -2808,9 &#43;2731,6 @@ static int tonga_update_smc_table(struct pp_hwmgr=
 *hwmgr, uint32_t type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_VCE_TABLE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tonga_update_vce_smc_table(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SAMU_TABLE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tonga_update_samu_smc_table(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
index 2de4895..57420d7 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
@@ -393,34 &#43;393,6 @@ static int vegam_update_vce_smc_table(struct pp_hw=
mgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int vegam_update_samu_smc_table(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vegam_smumgr *smu_data =3D (st=
ruct vegam_smumgr *)(hwmgr-&gt;smu_backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mm_boot_level_offset, mm_boo=
t_level_value;<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_data-&gt;smc_state_table.SamuBoot=
Level =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset =3D smu_data-&gt=
;smu7_data.dpm_table_start &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(SMU75_Discrete_DpmTable, SamuBootL=
evel);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset /=3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_offset *=3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value =3D cgs_read_ind_=
register(hwmgr-&gt;device,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC=
, mm_boot_level_offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value &amp;=3D 0xFFFFFF=
00;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_boot_level_value |=3D smu_data-&gt=
;smc_state_table.SamuBootLevel &lt;&lt; 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_ind_register(hwmgr-&gt;devi=
ce,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC=
, mm_boot_level_offset, mm_boot_level_value);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;platfor=
m_descriptor.platformCaps,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps=
_StablePState))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SAMUDPM_SetEnabledMask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t)(1 &lt;&lt; smu_data-&gt;smc_stat=
e_table.SamuBootLevel));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-<br>
&nbsp;static int vegam_update_bif_smc_table(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vegam_smumgr *smu_d=
ata =3D (struct vegam_smumgr *)(hwmgr-&gt;smu_backend);<br>
@@ -447,9 &#43;419,6 @@ static int vegam_update_smc_table(struct pp_hwmgr *=
hwmgr, uint32_t type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_VCE_TABLE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vegam_update_vce_smc_table(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SAMU_TABLE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vegam_update_samu_smc_table(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_BIF_TABLE:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vegam_update_bif_smc_table(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -1281,54 &#43;1250,6 @@ static int vegam_populate_smc_vce_level(struct p=
p_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
-static int vegam_populate_smc_samu_level(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SMU75_Discrete_DpmTable *table)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_atomctrl_clock_dividers_vi =
dividers;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_information *table_=
info =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct phm_ppt_=
v1_information *)(hwmgr-&gt;pptable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v1_mm_clock_voltage_de=
pendency_table *mm_table =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_info-&gt;m=
m_dep_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D (struct s=
mu7_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vddci;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuBootLevel =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuLevelCount =3D (uint8_t=
)(mm_table-&gt;count);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (count =3D 0; count &lt; table-&g=
t;SamuLevelCount; count&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* not sure whether we need evclk or not */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].Frequency =3D mm_table-&gt;entries[co=
unt].samclock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage |=3D (mm_table-&gt;entries=
[count].vddc *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VOLTAGE_SCALE) &lt;&lt; VDDC_SHIFT;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (SMU7_VOLTAGE_CONTROL_BY_GPIO =3D=3D data-&gt;vddci_control)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vddci =3D (uint3=
2_t)phm_find_closest_vddci(&amp;(data-&gt;vddci_voltage_table),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm_table-&gt;entries[c=
ount].vddc - VDDC_VDDCI_DELTA);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (SMU7_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data-&gt;vddci_con=
trol)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vddci =3D mm_tab=
le-&gt;entries[count].vddc - VDDC_VDDCI_DELTA;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vddci =3D (data-=
&gt;vbios_boot_state.vddci_bootup_value * VOLTAGE_SCALE) &lt;&lt; VDDCI_SHI=
FT;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage |=3D (vddci * VOLTAGE_SCAL=
E) &lt;&lt; VDDCI_SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].MinVoltage |=3D 1 &lt;&lt; PHASES_SHI=
FT;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* retrieve divider value for VBIOS */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D atomctrl_get_dfs_pll_dividers_vi(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;SamuLevel[count].Frequency, &amp;=
dividers);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE((0 =3D=3D result),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;can not find divide id for samu clock=
&quot;, return result);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;SamuLevel[count].Divider =3D (uint8_t)dividers.pll_pos=
t_divider;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CONVERT_FROM_HOST_TO_SMC_UL(table-&gt;SamuLevel[count].Frequency=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CONVERT_FROM_HOST_TO_SMC_UL(table-&gt;SamuLevel[count].MinVoltag=
e);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
-}<br>
-<br>
&nbsp;static int vegam_populate_memory_timing_parameters(struct pp_hwmgr *h=
wmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int32_t eng_clock, int32_t mem_clock,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SMU75_Discrete_MCArbDramTimingTableEntry *arb_regs)<b=
r>
@@ -2062,10 &#43;1983,6 @@ static int vegam_init_smc_table(struct pp_hwmgr =
*hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!resul=
t,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Failed to initialize VCE Level!&quot;, return result);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D vegam_populate_smc_samu_le=
vel(hwmgr, table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!result,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to =
initialize SAMU Level!&quot;, return result);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Since only the initial =
state is completely set up at this point<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (the other states =
are just copies of the boot state) we only<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * need to populate t=
he&nbsp; ARB settings for the initial state.<br>
@@ -2273,8 &#43;2190,6 @@ static uint32_t vegam_get_offsetof(uint32_t type,=
 uint32_t member)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU75_Discrete_DpmTable, UvdBootLevel);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case VceBootLevel:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU75_Discrete_DpmTable, VceBootLevel);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case SamuBootLevel:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return offsetof(=
SMU75_Discrete_DpmTable, SamuBootLevel);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case LowSclkInterruptThreshold:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n offsetof(SMU75_Discrete_DpmTable, LowSclkInterruptThreshold);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
1.9.1<br>
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

--_000_BN6PR12MB1809CFE0A857C2FC95CFEBFFF77E0BN6PR12MB1809namp_--

--===============1814628054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1814628054==--
