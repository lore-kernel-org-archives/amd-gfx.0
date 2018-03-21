From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Clean up powerplay code on Vega12
Date: Wed, 21 Mar 2018 13:30:06 +0000
Message-ID: <BN6PR12MB18091B6FA1B1B3B51014822AF7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1521625594-11923-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1805060149=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521625594-11923-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============1805060149==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18091B6FA1B1B3B51014822AF7AA0BN6PR12MB1809namp_"

--_000_BN6PR12MB18091B6FA1B1B3B51014822AF7AA0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, March 21, 2018 5:46:34 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/pp: Clean up powerplay code on Vega12

Change-Id: I792a0c6170115867b99d7112d8eba9ff2faf39d7
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 482 +----------------=
----
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |  32 --
 2 files changed, 1 insertion(+), 513 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index da2053e..15ce1e8 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -48,7 +48,6 @@
 #include "pp_overdriver.h"
 #include "pp_thermal.h"

-static const ULONG PhwVega12_Magic =3D (ULONG)(PHM_VIslands_Magic);

 static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
                 enum pp_clock_type type, uint32_t mask);
@@ -57,26 +56,6 @@ static int vega12_get_clock_ranges(struct pp_hwmgr *hwmg=
r,
                 PPCLK_e clock_select,
                 bool max);

-struct vega12_power_state *cast_phw_vega12_power_state(
-                                 struct pp_hw_power_state *hw_ps)
-{
-       PP_ASSERT_WITH_CODE((PhwVega12_Magic =3D=3D hw_ps->magic),
-                               "Invalid Powerstate Type!",
-                                return NULL;);
-
-       return (struct vega12_power_state *)hw_ps;
-}
-
-const struct vega12_power_state *cast_const_phw_vega12_power_state(
-                                const struct pp_hw_power_state *hw_ps)
-{
-       PP_ASSERT_WITH_CODE((PhwVega12_Magic =3D=3D hw_ps->magic),
-                               "Invalid Powerstate Type!",
-                                return NULL;);
-
-       return (const struct vega12_power_state *)hw_ps;
-}
-
 static void vega12_set_default_registry_data(struct pp_hwmgr *hwmgr)
 {
         struct vega12_hwmgr *data =3D
@@ -590,7 +569,7 @@ static int vega12_setup_default_dpm_tables(struct pp_hw=
mgr *hwmgr)
         }

         vega12_init_dpm_state(&(dpm_table->dpm_state));
-    /* Initialize Mclk DPM table based on allow Mclk values */
+       /* Initialize Mclk DPM table based on allow Mclk values */
         dpm_table =3D &(data->dpm_table.mem_table);

         PP_ASSERT_WITH_CODE(vega12_get_number_dpm_level(hwmgr, PPCLK_UCLK,
@@ -953,262 +932,12 @@ static int vega12_enable_dpm_tasks(struct pp_hwmgr *=
hwmgr)
         return result;
 }

-static int vega12_get_power_state_size(struct pp_hwmgr *hwmgr)
-{
-       return sizeof(struct vega12_power_state);
-}
-
-static int vega12_get_number_of_pp_table_entries(struct pp_hwmgr *hwmgr)
-{
-       return 0;
-}
-
 static int vega12_patch_boot_state(struct pp_hwmgr *hwmgr,
              struct pp_hw_power_state *hw_ps)
 {
         return 0;
 }

-static int vega12_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
-                               struct pp_power_state  *request_ps,
-                       const struct pp_power_state *current_ps)
-{
-       struct vega12_power_state *vega12_ps =3D
-                               cast_phw_vega12_power_state(&request_ps->ha=
rdware);
-       uint32_t sclk;
-       uint32_t mclk;
-       struct PP_Clocks minimum_clocks =3D {0};
-       bool disable_mclk_switching;
-       bool disable_mclk_switching_for_frame_lock;
-       bool disable_mclk_switching_for_vr;
-       bool force_mclk_high;
-       struct cgs_display_info info =3D {0};
-       const struct phm_clock_and_voltage_limits *max_limits;
-       uint32_t i;
-       struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr->backen=
d);
-       struct phm_ppt_v2_information *table_info =3D
-                       (struct phm_ppt_v2_information *)(hwmgr->pptable);
-       int32_t count;
-       uint32_t stable_pstate_sclk_dpm_percentage;
-       uint32_t stable_pstate_sclk =3D 0, stable_pstate_mclk =3D 0;
-       uint32_t latency;
-
-       data->battery_state =3D (PP_StateUILabel_Battery =3D=3D
-                       request_ps->classification.ui_label);
-
-       if (vega12_ps->performance_level_count !=3D 2)
-               pr_info("VI should always have 2 performance levels");
-
-       max_limits =3D (PP_PowerSource_AC =3D=3D hwmgr->power_source) ?
-                       &(hwmgr->dyn_state.max_clock_voltage_on_ac) :
-                       &(hwmgr->dyn_state.max_clock_voltage_on_dc);
-
-       /* Cap clock DPM tables at DC MAX if it is in DC. */
-       if (PP_PowerSource_DC =3D=3D hwmgr->power_source) {
-               for (i =3D 0; i < vega12_ps->performance_level_count; i++) =
{
-                       if (vega12_ps->performance_levels[i].mem_clock >
-                               max_limits->mclk)
-                               vega12_ps->performance_levels[i].mem_clock =
=3D
-                                               max_limits->mclk;
-                       if (vega12_ps->performance_levels[i].gfx_clock >
-                               max_limits->sclk)
-                               vega12_ps->performance_levels[i].gfx_clock =
=3D
-                                               max_limits->sclk;
-               }
-       }
-
-       cgs_get_active_displays_info(hwmgr->device, &info);
-
-       /* result =3D PHM_CheckVBlankTime(hwmgr, &vblankTooShort);*/
-       minimum_clocks.engineClock =3D hwmgr->display_config.min_core_set_c=
lock;
-       minimum_clocks.memoryClock =3D hwmgr->display_config.min_mem_set_cl=
ock;
-
-       if (PP_CAP(PHM_PlatformCaps_StablePState)) {
-               PP_ASSERT_WITH_CODE(
-                       data->registry_data.stable_pstate_sclk_dpm_percenta=
ge >=3D 1 &&
-                       data->registry_data.stable_pstate_sclk_dpm_percenta=
ge <=3D 100,
-                       "percent sclk value must range from 1% to 100%, set=
ting default value",
-                       stable_pstate_sclk_dpm_percentage =3D 75);
-
-               max_limits =3D &(hwmgr->dyn_state.max_clock_voltage_on_ac);
-               stable_pstate_sclk =3D (max_limits->sclk *
-                               stable_pstate_sclk_dpm_percentage) / 100;
-
-               for (count =3D table_info->vdd_dep_on_sclk->count - 1;
-                               count >=3D 0; count--) {
-                       if (stable_pstate_sclk >=3D
-                                       table_info->vdd_dep_on_sclk->entrie=
s[count].clk) {
-                               stable_pstate_sclk =3D
-                                               table_info->vdd_dep_on_sclk=
->entries[count].clk;
-                               break;
-                       }
-               }
-
-               if (count < 0)
-                       stable_pstate_sclk =3D table_info->vdd_dep_on_sclk-=
>entries[0].clk;
-
-               stable_pstate_mclk =3D max_limits->mclk;
-
-               minimum_clocks.engineClock =3D stable_pstate_sclk;
-               minimum_clocks.memoryClock =3D stable_pstate_mclk;
-       }
-
-       disable_mclk_switching_for_frame_lock =3D phm_cap_enabled(
-                                   hwmgr->platform_descriptor.platformCaps=
,
-                                   PHM_PlatformCaps_DisableMclkSwitchingFo=
rFrameLock);
-       disable_mclk_switching_for_vr =3D PP_CAP(PHM_PlatformCaps_DisableMc=
lkSwitchForVR);
-       force_mclk_high =3D PP_CAP(PHM_PlatformCaps_ForceMclkHigh);
-
-       if (info.display_count =3D=3D 0)
-               disable_mclk_switching =3D false;
-       else
-               disable_mclk_switching =3D (info.display_count > 1) ||
-                       disable_mclk_switching_for_frame_lock ||
-                       disable_mclk_switching_for_vr ||
-                       force_mclk_high;
-
-       sclk =3D vega12_ps->performance_levels[0].gfx_clock;
-       mclk =3D vega12_ps->performance_levels[0].mem_clock;
-
-       if (sclk < minimum_clocks.engineClock)
-               sclk =3D (minimum_clocks.engineClock > max_limits->sclk) ?
-                               max_limits->sclk : minimum_clocks.engineClo=
ck;
-
-       if (mclk < minimum_clocks.memoryClock)
-               mclk =3D (minimum_clocks.memoryClock > max_limits->mclk) ?
-                               max_limits->mclk : minimum_clocks.memoryClo=
ck;
-
-       vega12_ps->performance_levels[0].gfx_clock =3D sclk;
-       vega12_ps->performance_levels[0].mem_clock =3D mclk;
-
-       if (vega12_ps->performance_levels[1].gfx_clock <
-                       vega12_ps->performance_levels[0].gfx_clock)
-               vega12_ps->performance_levels[0].gfx_clock =3D
-                               vega12_ps->performance_levels[1].gfx_clock;
-
-       if (disable_mclk_switching) {
-               /* Set Mclk the max of level 0 and level 1 */
-               if (mclk < vega12_ps->performance_levels[1].mem_clock)
-                       mclk =3D vega12_ps->performance_levels[1].mem_clock=
;
-               /* Find the lowest MCLK frequency that is within
-                * the tolerable latency defined in DAL
-                */
-               latency =3D 0;
-               for (i =3D 0; i < data->mclk_latency_table.count; i++) {
-                       if ((data->mclk_latency_table.entries[i].latency <=
=3D latency) &&
-                               (data->mclk_latency_table.entries[i].freque=
ncy >=3D
-                                               vega12_ps->performance_leve=
ls[0].mem_clock) &&
-                               (data->mclk_latency_table.entries[i].freque=
ncy <=3D
-                                               vega12_ps->performance_leve=
ls[1].mem_clock))
-                               mclk =3D data->mclk_latency_table.entries[i=
].frequency;
-               }
-               vega12_ps->performance_levels[0].mem_clock =3D mclk;
-       } else {
-               if (vega12_ps->performance_levels[1].mem_clock <
-                               vega12_ps->performance_levels[0].mem_clock)
-                       vega12_ps->performance_levels[0].mem_clock =3D
-                                       vega12_ps->performance_levels[1].me=
m_clock;
-       }
-
-       if (PP_CAP(PHM_PlatformCaps_StablePState)) {
-               for (i =3D 0; i < vega12_ps->performance_level_count; i++) =
{
-                       vega12_ps->performance_levels[i].gfx_clock =3D stab=
le_pstate_sclk;
-                       vega12_ps->performance_levels[i].mem_clock =3D stab=
le_pstate_mclk;
-               }
-       }
-
-       return 0;
-}
-
-static int vega12_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwm=
gr, const void *input)
-{
-       struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr->backen=
d);
-       struct PP_Clocks min_clocks =3D {0};
-       struct cgs_display_info info =3D {0};
-
-       data->need_update_dpm_table =3D 0;
-
-       min_clocks.engineClockInSR =3D hwmgr->display_config.min_core_set_c=
lock_in_sr;
-       if (data->display_timing.min_clock_in_sr !=3D min_clocks.engineCloc=
kInSR &&
-                       (min_clocks.engineClockInSR >=3D VEGA12_MINIMUM_ENG=
INE_CLOCK ||
-                        data->display_timing.min_clock_in_sr >=3D VEGA12_M=
INIMUM_ENGINE_CLOCK))
-               data->need_update_dpm_table |=3D DPMTABLE_UPDATE_SCLK;
-
-       cgs_get_active_displays_info(hwmgr->device, &info);
-       if (data->display_timing.num_existing_displays !=3D info.display_co=
unt)
-               data->need_update_dpm_table |=3D DPMTABLE_UPDATE_MCLK;
-
-       return 0;
-}
-
-static int vega12_trim_single_dpm_states(struct pp_hwmgr *hwmgr,
-               struct vega12_single_dpm_table *dpm_table,
-               uint32_t low_limit, uint32_t high_limit)
-{
-       uint32_t i;
-
-       for (i =3D 0; i < dpm_table->count; i++) {
-               if ((dpm_table->dpm_levels[i].value < low_limit) ||
-                   (dpm_table->dpm_levels[i].value > high_limit))
-                       dpm_table->dpm_levels[i].enabled =3D false;
-               else
-                       dpm_table->dpm_levels[i].enabled =3D true;
-       }
-       return 0;
-}
-
-static int vega12_trim_single_dpm_states_with_mask(struct pp_hwmgr *hwmgr,
-               struct vega12_single_dpm_table *dpm_table,
-               uint32_t low_limit, uint32_t high_limit,
-               uint32_t disable_dpm_mask)
-{
-       uint32_t i;
-
-       for (i =3D 0; i < dpm_table->count; i++) {
-               if ((dpm_table->dpm_levels[i].value < low_limit) ||
-                   (dpm_table->dpm_levels[i].value > high_limit))
-                       dpm_table->dpm_levels[i].enabled =3D false;
-               else if ((!((1 << i) & disable_dpm_mask)) &&
-                               !(low_limit =3D=3D high_limit))
-                       dpm_table->dpm_levels[i].enabled =3D false;
-               else
-                       dpm_table->dpm_levels[i].enabled =3D true;
-       }
-       return 0;
-}
-
-static int vega12_trim_dpm_states(struct pp_hwmgr *hwmgr,
-               const struct vega12_power_state *vega12_ps)
-{
-       struct vega12_hwmgr *data =3D
-                       (struct vega12_hwmgr *)(hwmgr->backend);
-       uint32_t high_limit_count;
-
-       PP_ASSERT_WITH_CODE((vega12_ps->performance_level_count >=3D 1),
-                       "power state did not have any performance level",
-                       return -1);
-
-       high_limit_count =3D (vega12_ps->performance_level_count =3D=3D 1) =
? 0 : 1;
-
-       vega12_trim_single_dpm_states(hwmgr,
-                       &(data->dpm_table.soc_table),
-                       vega12_ps->performance_levels[0].soc_clock,
-                       vega12_ps->performance_levels[high_limit_count].soc=
_clock);
-
-       vega12_trim_single_dpm_states_with_mask(hwmgr,
-                       &(data->dpm_table.gfx_table),
-                       vega12_ps->performance_levels[0].gfx_clock,
-                       vega12_ps->performance_levels[high_limit_count].gfx=
_clock,
-                       data->disable_dpm_mask);
-
-       vega12_trim_single_dpm_states(hwmgr,
-                       &(data->dpm_table.mem_table),
-                       vega12_ps->performance_levels[0].mem_clock,
-                       vega12_ps->performance_levels[high_limit_count].mem=
_clock);
-
-       return 0;
-}
-
 static uint32_t vega12_find_lowest_dpm_level(
                 struct vega12_single_dpm_table *table)
 {
@@ -1250,45 +979,6 @@ static int vega12_upload_dpm_max_level(struct pp_hwmg=
r *hwmgr)
         return 0;
 }

-static int vega12_generate_dpm_level_enable_mask(
-               struct pp_hwmgr *hwmgr, const void *input)
-{
-       struct vega12_hwmgr *data =3D
-                       (struct vega12_hwmgr *)(hwmgr->backend);
-       const struct phm_set_power_state_input *states =3D
-                       (const struct phm_set_power_state_input *)input;
-       const struct vega12_power_state *vega12_ps =3D
-                       cast_const_phw_vega12_power_state(states->pnew_stat=
e);
-       int i;
-
-       PP_ASSERT_WITH_CODE(!vega12_trim_dpm_states(hwmgr, vega12_ps),
-                       "Attempt to Trim DPM States Failed!",
-                       return -1);
-
-       data->smc_state_table.gfx_boot_level =3D
-                       vega12_find_lowest_dpm_level(&(data->dpm_table.gfx_=
table));
-       data->smc_state_table.gfx_max_level =3D
-                       vega12_find_highest_dpm_level(&(data->dpm_table.gfx=
_table));
-       data->smc_state_table.mem_boot_level =3D
-                       vega12_find_lowest_dpm_level(&(data->dpm_table.mem_=
table));
-       data->smc_state_table.mem_max_level =3D
-                       vega12_find_highest_dpm_level(&(data->dpm_table.mem=
_table));
-
-       PP_ASSERT_WITH_CODE(!vega12_upload_dpm_min_level(hwmgr),
-                       "Attempt to upload DPM Bootup Levels Failed!",
-                       return -1);
-       PP_ASSERT_WITH_CODE(!vega12_upload_dpm_max_level(hwmgr),
-                       "Attempt to upload DPM Max Levels Failed!",
-                       return -1);
-       for (i =3D data->smc_state_table.gfx_boot_level; i < data->smc_stat=
e_table.gfx_max_level; i++)
-               data->dpm_table.gfx_table.dpm_levels[i].enabled =3D true;
-
-
-       for (i =3D data->smc_state_table.mem_boot_level; i < data->smc_stat=
e_table.mem_max_level; i++)
-               data->dpm_table.mem_table.dpm_levels[i].enabled =3D true;
-
-       return 0;
-}

 int vega12_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool enable)
 {
@@ -1307,45 +997,6 @@ int vega12_enable_disable_vce_dpm(struct pp_hwmgr *hw=
mgr, bool enable)
         return 0;
 }

-static int vega12_update_sclk_threshold(struct pp_hwmgr *hwmgr)
-{
-       return 0;
-}
-
-static int vega12_set_power_state_tasks(struct pp_hwmgr *hwmgr,
-               const void *input)
-{
-       int tmp_result, result =3D 0;
-       struct vega12_hwmgr *data =3D
-                       (struct vega12_hwmgr *)(hwmgr->backend);
-       PPTable_t *pp_table =3D &(data->smc_state_table.pp_table);
-
-       tmp_result =3D vega12_find_dpm_states_clocks_in_dpm_table(hwmgr, in=
put);
-       PP_ASSERT_WITH_CODE(!tmp_result,
-                       "Failed to find DPM states clocks in DPM table!",
-                       result =3D tmp_result);
-
-       tmp_result =3D vega12_generate_dpm_level_enable_mask(hwmgr, input);
-       PP_ASSERT_WITH_CODE(!tmp_result,
-                       "Failed to generate DPM level enabled mask!",
-                       result =3D tmp_result);
-
-       tmp_result =3D vega12_update_sclk_threshold(hwmgr);
-       PP_ASSERT_WITH_CODE(!tmp_result,
-                       "Failed to update SCLK threshold!",
-                       result =3D tmp_result);
-
-       result =3D vega12_copy_table_to_smc(hwmgr,
-                       (uint8_t *)pp_table, TABLE_PPTABLE);
-       PP_ASSERT_WITH_CODE(!result,
-                       "Failed to upload PPtable!", return result);
-
-       data->apply_optimized_settings =3D false;
-       data->apply_overdrive_next_settings_mask =3D 0;
-
-       return 0;
-}
-
 static uint32_t vega12_dpm_get_sclk(struct pp_hwmgr *hwmgr, bool low)
 {
         struct vega12_hwmgr *data =3D
@@ -2217,50 +1868,6 @@ static void vega12_power_gate_uvd(struct pp_hwmgr *h=
wmgr, bool bgate)
         vega12_enable_disable_uvd_dpm(hwmgr, !bgate);
 }

-static inline bool vega12_are_power_levels_equal(
-                               const struct vega12_performance_level *pl1,
-                               const struct vega12_performance_level *pl2)
-{
-       return ((pl1->soc_clock =3D=3D pl2->soc_clock) &&
-                       (pl1->gfx_clock =3D=3D pl2->gfx_clock) &&
-                       (pl1->mem_clock =3D=3D pl2->mem_clock));
-}
-
-static int vega12_check_states_equal(struct pp_hwmgr *hwmgr,
-                               const struct pp_hw_power_state *pstate1,
-                       const struct pp_hw_power_state *pstate2, bool *equa=
l)
-{
-       const struct vega12_power_state *psa;
-       const struct vega12_power_state *psb;
-       int i;
-
-       if (pstate1 =3D=3D NULL || pstate2 =3D=3D NULL || equal =3D=3D NULL=
)
-               return -EINVAL;
-
-       psa =3D cast_const_phw_vega12_power_state(pstate1);
-       psb =3D cast_const_phw_vega12_power_state(pstate2);
-       /* If the two states don't even have the same number of performance=
 levels they cannot be the same state. */
-       if (psa->performance_level_count !=3D psb->performance_level_count)=
 {
-               *equal =3D false;
-               return 0;
-       }
-
-       for (i =3D 0; i < psa->performance_level_count; i++) {
-               if (!vega12_are_power_levels_equal(&(psa->performance_level=
s[i]), &(psb->performance_levels[i]))) {
-                       /* If we have found even one performance level pair=
 that is different the states are different. */
-                       *equal =3D false;
-                       return 0;
-               }
-       }
-
-       /* If all performance levels are the same try to use the UVD clocks=
 to break the tie.*/
-       *equal =3D ((psa->uvd_clks.vclk =3D=3D psb->uvd_clks.vclk) && (psa-=
>uvd_clks.dclk =3D=3D psb->uvd_clks.dclk));
-       *equal &=3D ((psa->vce_clks.evclk =3D=3D psb->vce_clks.evclk) && (p=
sa->vce_clks.ecclk =3D=3D psb->vce_clks.ecclk));
-       *equal &=3D (psa->sclk_threshold =3D=3D psb->sclk_threshold);
-
-       return 0;
-}
-
 static bool
 vega12_check_smc_update_required_for_display_configuration(struct pp_hwmgr=
 *hwmgr)
 {
@@ -2337,37 +1944,6 @@ static void vega12_find_min_clock_index(struct pp_hw=
mgr *hwmgr,
 static int vega12_set_power_profile_state(struct pp_hwmgr *hwmgr,
                 struct amd_pp_profile *request)
 {
-       struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr->backen=
d);
-       uint32_t sclk_idx =3D ~0, mclk_idx =3D ~0;
-
-       if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_AUTO)
-               return -EINVAL;
-
-       vega12_find_min_clock_index(hwmgr, &sclk_idx, &mclk_idx,
-                       request->min_sclk, request->min_mclk);
-
-       if (sclk_idx !=3D ~0) {
-               if (!data->registry_data.sclk_dpm_key_disabled)
-                       PP_ASSERT_WITH_CODE(
-                                       !smum_send_msg_to_smc_with_paramete=
r(
-                                       hwmgr,
-                                       PPSMC_MSG_SetSoftMinGfxclkByIndex,
-                                       sclk_idx),
-                                       "Failed to set soft min sclk index!=
",
-                                       return -EINVAL);
-       }
-
-       if (mclk_idx !=3D ~0) {
-               if (!data->registry_data.mclk_dpm_key_disabled)
-                       PP_ASSERT_WITH_CODE(
-                                       !smum_send_msg_to_smc_with_paramete=
r(
-                                       hwmgr,
-                                       PPSMC_MSG_SetSoftMinUclkByIndex,
-                                       mclk_idx),
-                                       "Failed to set soft min mclk index!=
",
-                                       return -EINVAL);
-       }
-
         return 0;
 }

@@ -2389,28 +1965,6 @@ static int vega12_get_sclk_od(struct pp_hwmgr *hwmgr=
)

 static int vega12_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 {
-       struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr->backen=
d);
-       struct vega12_single_dpm_table *golden_sclk_table =3D
-                       &(data->golden_dpm_table.gfx_table);
-       struct pp_power_state *ps;
-       struct vega12_power_state *vega12_ps;
-
-       ps =3D hwmgr->request_ps;
-
-       if (ps =3D=3D NULL)
-               return -EINVAL;
-
-       vega12_ps =3D cast_phw_vega12_power_state(&ps->hardware);
-
-       vega12_ps->performance_levels[vega12_ps->performance_level_count - =
1].gfx_clock =3D
-               golden_sclk_table->dpm_levels[golden_sclk_table->count - 1]=
.value * value / 100 +
-               golden_sclk_table->dpm_levels[golden_sclk_table->count - 1]=
.value;
-
-       if (vega12_ps->performance_levels[vega12_ps->performance_level_coun=
t - 1].gfx_clock >
-                       hwmgr->platform_descriptor.overdriveLimit.engineClo=
ck)
-               vega12_ps->performance_levels[vega12_ps->performance_level_=
count - 1].gfx_clock =3D
-                       hwmgr->platform_descriptor.overdriveLimit.engineClo=
ck;
-
         return 0;
 }

@@ -2435,34 +1989,6 @@ static int vega12_get_mclk_od(struct pp_hwmgr *hwmgr=
)

 static int vega12_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 {
-       struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr->backen=
d);
-       struct vega12_single_dpm_table *golden_mclk_table =3D
-                       &(data->golden_dpm_table.mem_table);
-       struct pp_power_state  *ps;
-       struct vega12_power_state  *vega12_ps;
-
-       ps =3D hwmgr->request_ps;
-
-       if (ps =3D=3D NULL)
-               return -EINVAL;
-
-       vega12_ps =3D cast_phw_vega12_power_state(&ps->hardware);
-
-       vega12_ps->performance_levels
-       [vega12_ps->performance_level_count - 1].mem_clock =3D
-                       golden_mclk_table->dpm_levels
-                       [golden_mclk_table->count - 1].value *
-                       value / 100 +
-                       golden_mclk_table->dpm_levels
-                       [golden_mclk_table->count - 1].value;
-
-       if (vega12_ps->performance_levels
-                       [vega12_ps->performance_level_count - 1].mem_clock =
>
-                       hwmgr->platform_descriptor.overdriveLimit.memoryClo=
ck)
-               vega12_ps->performance_levels
-               [vega12_ps->performance_level_count - 1].mem_clock =3D
-                               hwmgr->platform_descriptor.overdriveLimit.m=
emoryClock;
-
         return 0;
 }
 #endif
@@ -2514,12 +2040,7 @@ static int vega12_get_thermal_temperature_range(stru=
ct pp_hwmgr *hwmgr,
         .asic_setup =3D vega12_setup_asic_task,
         .dynamic_state_management_enable =3D vega12_enable_dpm_tasks,
         .dynamic_state_management_disable =3D vega12_disable_dpm_tasks,
-       .get_num_of_pp_table_entries =3D
-                       vega12_get_number_of_pp_table_entries,
-       .get_power_state_size =3D vega12_get_power_state_size,
         .patch_boot_state =3D vega12_patch_boot_state,
-       .apply_state_adjust_rules =3D vega12_apply_state_adjust_rules,
-       .power_state_set =3D vega12_set_power_state_tasks,
         .get_sclk =3D vega12_dpm_get_sclk,
         .get_mclk =3D vega12_dpm_get_mclk,
         .notify_smc_display_config_after_ps_adjustment =3D
@@ -2543,7 +2064,6 @@ static int vega12_get_thermal_temperature_range(struc=
t pp_hwmgr *hwmgr,
         .display_config_changed =3D vega12_display_configuration_changed_t=
ask,
         .powergate_uvd =3D vega12_power_gate_uvd,
         .powergate_vce =3D vega12_power_gate_vce,
-       .check_states_equal =3D vega12_check_states_equal,
         .check_smc_update_required_for_display_configuration =3D
                         vega12_check_smc_update_required_for_display_confi=
guration,
         .power_off_asic =3D vega12_power_off_asic,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
index 644c7f0..bc98b1d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
@@ -86,37 +86,6 @@ struct smu_features {
         uint64_t smu_feature_bitmap;
 };

-struct vega12_performance_level {
-       uint32_t  soc_clock;
-       uint32_t  gfx_clock;
-       uint32_t  mem_clock;
-};
-
-struct vega12_bacos {
-       uint32_t                       baco_flags;
-       /* struct vega12_performance_level  performance_level; */
-};
-
-struct vega12_uvd_clocks {
-       uint32_t  vclk;
-       uint32_t  dclk;
-};
-
-struct vega12_vce_clocks {
-       uint32_t  evclk;
-       uint32_t  ecclk;
-};
-
-struct vega12_power_state {
-       uint32_t                  magic;
-       struct vega12_uvd_clocks    uvd_clks;
-       struct vega12_vce_clocks    vce_clks;
-       uint16_t                  performance_level_count;
-       bool                      dc_compatible;
-       uint32_t                  sclk_threshold;
-       struct vega12_performance_level  performance_levels[VEGA12_MAX_HARD=
WARE_POWERLEVELS];
-};
-
 struct vega12_dpm_level {
         bool            enabled;
         uint32_t        value;
@@ -350,7 +319,6 @@ struct vega12_hwmgr {

         uint32_t                           active_auto_throttle_sources;
         uint32_t                           water_marks_bitmap;
-       struct vega12_bacos                bacos;

         struct vega12_odn_dpm_table       odn_dpm_table;
         struct vega12_odn_fan_table       odn_fan_table;
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18091B6FA1B1B3B51014822AF7AA0BN6PR12MB1809namp_
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
<b>Sent:</b> Wednesday, March 21, 2018 5:46:34 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/pp: Clean up powerplay code on Vega12</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Change-Id: I792a0c6170115867b99d7112d8eba9ff2faf39=
d7<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 482 &#43;-------=
-------------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |&nbsp; 32 --<br>
&nbsp;2 files changed, 1 insertion(&#43;), 513 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
index da2053e..15ce1e8 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
@@ -48,7 &#43;48,6 @@<br>
&nbsp;#include &quot;pp_overdriver.h&quot;<br>
&nbsp;#include &quot;pp_thermal.h&quot;<br>
&nbsp;<br>
-static const ULONG PhwVega12_Magic =3D (ULONG)(PHM_VIslands_Magic);<br>
&nbsp;<br>
&nbsp;static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type, uint32_t mask);<br>
@@ -57,26 &#43;56,6 @@ static int vega12_get_clock_ranges(struct pp_hwmgr *=
hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PPCLK_e clock_select,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bool max);<br>
&nbsp;<br>
-struct vega12_power_state *cast_phw_vega12_power_state(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hw_power_state *hw_ps=
)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE((PhwVega12_Magic =
=3D=3D hw_ps-&gt;magic),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Invalid Powerstate Type!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (struct vega12_power_state *)h=
w_ps;<br>
-}<br>
-<br>
-const struct vega12_power_state *cast_const_phw_vega12_power_state(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pp_hw_power_state *hw_ps=
)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE((PhwVega12_Magic =
=3D=3D hw_ps-&gt;magic),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Invalid Powerstate Type!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (const struct vega12_power_sta=
te *)hw_ps;<br>
-}<br>
-<br>
&nbsp;static void vega12_set_default_registry_data(struct pp_hwmgr *hwmgr)<=
br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =
=3D<br>
@@ -590,7 &#43;569,7 @@ static int vega12_setup_default_dpm_tables(struct p=
p_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_init_dpm_state(&amp=
;(dpm_table-&gt;dpm_state));<br>
-&nbsp;&nbsp;&nbsp; /* Initialize Mclk DPM table based on allow Mclk values=
 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize Mclk DPM table base=
d on allow Mclk values */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(data-&=
gt;dpm_table.mem_table);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(vega12=
_get_number_dpm_level(hwmgr, PPCLK_UCLK,<br>
@@ -953,262 &#43;932,12 @@ static int vega12_enable_dpm_tasks(struct pp_hwm=
gr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
-static int vega12_get_power_state_size(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct vega12_power_sta=
te);<br>
-}<br>
-<br>
-static int vega12_get_number_of_pp_table_entries(struct pp_hwmgr *hwmgr)<b=
r>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int vega12_patch_boot_state(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct pp_hw_power_state *hw_ps)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int vega12_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state&nbsp; *request_ps,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pp_=
power_state *current_ps)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_power_state *vega12_ps =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cast_phw_vega12_power_state(&amp;request_ps=
-&gt;hardware);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_Clocks minimum_clocks =3D {=
0};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_mclk_switching;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_mclk_switching_for_frame=
_lock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_mclk_switching_for_vr;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool force_mclk_high;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cgs_display_info info =3D {0};=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct phm_clock_and_voltage_li=
mits *max_limits;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =3D (struct=
 vega12_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_ppt_v2_information *table_=
info =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct phm_ppt_=
v2_information *)(hwmgr-&gt;pptable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t stable_pstate_sclk_dpm_perce=
ntage;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t stable_pstate_sclk =3D 0, st=
able_pstate_mclk =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t latency;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;battery_state =3D (PP_StateU=
ILabel_Battery =3D=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request_ps-&gt;c=
lassification.ui_label);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vega12_ps-&gt;performance_level_c=
ount !=3D 2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_info(&quot;VI should always have 2 performance levels&quot;);=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_limits =3D (PP_PowerSource_AC =3D=
=3D hwmgr-&gt;power_source) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(hwmgr-&gt;=
dyn_state.max_clock_voltage_on_ac) :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(hwmgr-&gt;=
dyn_state.max_clock_voltage_on_dc);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Cap clock DPM tables at DC MAX if =
it is in DC. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_PowerSource_DC =3D=3D hwmgr-&g=
t;power_source) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; vega12_ps-&gt;performance_level_count; i&#4=
3;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vega12_ps-&g=
t;performance_levels[i].mem_clock &gt;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_limits-&gt;mclk)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;performance_levels[i].mem_clo=
ck =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_limits-&gt;mclk;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vega12_ps-&g=
t;performance_levels[i].gfx_clock &gt;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_limits-&gt;sclk)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;performance_levels[i].gfx_clo=
ck =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_limits-&gt;sclk;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_get_active_displays_info(hwmgr-&g=
t;device, &amp;info);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* result =3D PHM_CheckVBlankTime(hwm=
gr, &amp;vblankTooShort);*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; minimum_clocks.engineClock =3D hwmgr-=
&gt;display_config.min_core_set_clock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; minimum_clocks.memoryClock =3D hwmgr-=
&gt;display_config.min_mem_set_clock;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_StablePSt=
ate)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registr=
y_data.stable_pstate_sclk_dpm_percentage &gt;=3D 1 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;registr=
y_data.stable_pstate_sclk_dpm_percentage &lt;=3D 100,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;percent sc=
lk value must range from 1% to 100%, setting default value&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stable_pstate_sc=
lk_dpm_percentage =3D 75);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_limits =3D &amp;(hwmgr-&gt;dyn_state.max_clock_voltage_on_ac=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stable_pstate_sclk =3D (max_limits-&gt;sclk *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stable_pstate_sclk_dpm_percentage) / 100;<b=
r>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (count =3D table_info-&gt;vdd_dep_on_sclk-&gt;count - 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count &gt;=3D 0; count--) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (stable_pstat=
e_sclk &gt;=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; table_info-&gt;vdd_dep_on_sclk-&gt;entries[count].clk) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stable_pstate_sclk =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_info-&gt;vdd_dep=
_on_sclk-&gt;entries[count].clk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (count &lt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stable_pstate_sc=
lk =3D table_info-&gt;vdd_dep_on_sclk-&gt;entries[0].clk;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stable_pstate_mclk =3D max_limits-&gt;mclk;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; minimum_clocks.engineClock =3D stable_pstate_sclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; minimum_clocks.memoryClock =3D stable_pstate_mclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_mclk_switching_for_frame_lock=
 =3D phm_cap_enabled(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;platform_=
descriptor.platformCaps,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps_Di=
sableMclkSwitchingForFrameLock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_mclk_switching_for_vr =3D PP_=
CAP(PHM_PlatformCaps_DisableMclkSwitchForVR);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; force_mclk_high =3D PP_CAP(PHM_Platfo=
rmCaps_ForceMclkHigh);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info.display_count =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; disable_mclk_switching =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; disable_mclk_switching =3D (info.display_count &gt; 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_mclk_swi=
tching_for_frame_lock ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_mclk_swi=
tching_for_vr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; force_mclk_high;=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sclk =3D vega12_ps-&gt;performance_le=
vels[0].gfx_clock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mclk =3D vega12_ps-&gt;performance_le=
vels[0].mem_clock;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sclk &lt; minimum_clocks.engineCl=
ock)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sclk =3D (minimum_clocks.engineClock &gt; max_limits-&gt;sclk) ?=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_limits-&gt;sclk : minimum_clocks.engine=
Clock;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mclk &lt; minimum_clocks.memoryCl=
ock)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mclk =3D (minimum_clocks.memoryClock &gt; max_limits-&gt;mclk) ?=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_limits-&gt;mclk : minimum_clocks.memory=
Clock;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;performance_levels[0].g=
fx_clock =3D sclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;performance_levels[0].m=
em_clock =3D mclk;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vega12_ps-&gt;performance_levels[=
1].gfx_clock &lt;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;pe=
rformance_levels[0].gfx_clock)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega12_ps-&gt;performance_levels[0].gfx_clock =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;performance_levels[1].gfx_clo=
ck;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (disable_mclk_switching) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Set Mclk the max of level 0 and level 1 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (mclk &lt; vega12_ps-&gt;performance_levels[1].mem_clock)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mclk =3D vega12_=
ps-&gt;performance_levels[1].mem_clock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Find the lowest MCLK frequency that is within<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * the tolerable latency defined in DAL<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; latency =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; data-&gt;mclk_latency_table.count; i&#43;&#=
43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((data-&gt;mc=
lk_latency_table.entries[i].latency &lt;=3D latency) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (data-&gt;mclk_latency_table.entries[i].fre=
quency &gt;=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;performa=
nce_levels[0].mem_clock) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (data-&gt;mclk_latency_table.entries[i].fre=
quency &lt;=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;performa=
nce_levels[1].mem_clock))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mclk =3D data-&gt;mclk_latency_table.entrie=
s[i].frequency;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega12_ps-&gt;performance_levels[0].mem_clock =3D mclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (vega12_ps-&gt;performance_levels[1].mem_clock &lt;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;performance_levels[0].mem_clo=
ck)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;pe=
rformance_levels[0].mem_clock =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; vega12_ps-&gt;performance_levels[1].mem_clock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_StablePSt=
ate)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; vega12_ps-&gt;performance_level_count; i&#4=
3;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;pe=
rformance_levels[i].gfx_clock =3D stable_pstate_sclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;pe=
rformance_levels[i].mem_clock =3D stable_pstate_mclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-static int vega12_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwm=
gr, const void *input)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =3D (struct=
 vega12_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_Clocks min_clocks =3D {0};<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cgs_display_info info =3D {0};=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;need_update_dpm_table =3D 0;=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clocks.engineClockInSR =3D hwmgr-=
&gt;display_config.min_core_set_clock_in_sr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;display_timing.min_clock=
_in_sr !=3D min_clocks.engineClockInSR &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (min_clocks.engi=
neClockInSR &gt;=3D VEGA12_MINIMUM_ENGINE_CLOCK ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;d=
isplay_timing.min_clock_in_sr &gt;=3D VEGA12_MINIMUM_ENGINE_CLOCK))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;need_update_dpm_table |=3D DPMTABLE_UPDATE_SCLK;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_get_active_displays_info(hwmgr-&g=
t;device, &amp;info);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;display_timing.num_exist=
ing_displays !=3D info.display_count)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;need_update_dpm_table |=3D DPMTABLE_UPDATE_MCLK;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-static int vega12_trim_single_dpm_states(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct vega12_single_dpm_table *dpm_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t low_limit, uint32_t high_limit)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dpm_table-&gt;co=
unt; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((dpm_table-&gt;dpm_levels[i].value &lt; low_limit) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dpm_table-&gt;dpm_levels[i].value &gt; =
high_limit))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dp=
m_levels[i].enabled =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dp=
m_levels[i].enabled =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-static int vega12_trim_single_dpm_states_with_mask(struct pp_hwmgr *hwmgr,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct vega12_single_dpm_table *dpm_table,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t low_limit, uint32_t high_limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t disable_dpm_mask)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dpm_table-&gt;co=
unt; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((dpm_table-&gt;dpm_levels[i].value &lt; low_limit) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dpm_table-&gt;dpm_levels[i].value &gt; =
high_limit))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dp=
m_levels[i].enabled =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if ((!((1 &lt;&lt; i) &amp; disable_dpm_mask)) &amp;&amp;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(low_limit =3D=3D high_limit))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dp=
m_levels[i].enabled =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dp=
m_levels[i].enabled =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-static int vega12_trim_dpm_states(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const struct vega12_power_state *vega12_ps)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct vega12_h=
wmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t high_limit_count;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE((vega12_ps-&gt;pe=
rformance_level_count &gt;=3D 1),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;power stat=
e did not have any performance level&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; high_limit_count =3D (vega12_ps-&gt;p=
erformance_level_count =3D=3D 1) ? 0 : 1;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_trim_single_dpm_states(hwmgr,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(data-&gt;d=
pm_table.soc_table),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;pe=
rformance_levels[0].soc_clock,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;pe=
rformance_levels[high_limit_count].soc_clock);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_trim_single_dpm_states_with_ma=
sk(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(data-&gt;d=
pm_table.gfx_table),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;pe=
rformance_levels[0].gfx_clock,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;pe=
rformance_levels[high_limit_count].gfx_clock,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;disable=
_dpm_mask);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_trim_single_dpm_states(hwmgr,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(data-&gt;d=
pm_table.mem_table),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;pe=
rformance_levels[0].mem_clock,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;pe=
rformance_levels[high_limit_count].mem_clock);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static uint32_t vega12_find_lowest_dpm_level(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct vega12_single_dpm_table *table)<br>
&nbsp;{<br>
@@ -1250,45 &#43;979,6 @@ static int vega12_upload_dpm_max_level(struct pp_=
hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int vega12_generate_dpm_level_enable_mask(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct pp_hwmgr *hwmgr, const void *input)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct vega12_h=
wmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct phm_set_power_state_inpu=
t *states =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const struct ph=
m_set_power_state_input *)input;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct vega12_power_state *vega=
12_ps =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cast_const_phw_v=
ega12_power_state(states-&gt;pnew_state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!vega12_trim_dpm_=
states(hwmgr, vega12_ps),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Attempt to=
 Trim DPM States Failed!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smc_state_table.gfx_boot_lev=
el =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_find_lowe=
st_dpm_level(&amp;(data-&gt;dpm_table.gfx_table));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smc_state_table.gfx_max_leve=
l =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_find_high=
est_dpm_level(&amp;(data-&gt;dpm_table.gfx_table));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smc_state_table.mem_boot_lev=
el =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_find_lowe=
st_dpm_level(&amp;(data-&gt;dpm_table.mem_table));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smc_state_table.mem_max_leve=
l =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_find_high=
est_dpm_level(&amp;(data-&gt;dpm_table.mem_table));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!vega12_upload_dp=
m_min_level(hwmgr),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Attempt to=
 upload DPM Bootup Levels Failed!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!vega12_upload_dp=
m_max_level(hwmgr),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Attempt to=
 upload DPM Max Levels Failed!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D data-&gt;smc_state_table.g=
fx_boot_level; i &lt; data-&gt;smc_state_table.gfx_max_level; i&#43;&#43;)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;dpm_table.gfx_table.dpm_levels[i].enabled =3D true;<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D data-&gt;smc_state_table.m=
em_boot_level; i &lt; data-&gt;smc_state_table.mem_max_level; i&#43;&#43;)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; data-&gt;dpm_table.mem_table.dpm_levels[i].enabled =3D true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
&nbsp;<br>
&nbsp;int vega12_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool enable=
)<br>
&nbsp;{<br>
@@ -1307,45 &#43;997,6 @@ int vega12_enable_disable_vce_dpm(struct pp_hwmgr=
 *hwmgr, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int vega12_update_sclk_threshold(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-static int vega12_set_power_state_tasks(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const void *input)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int tmp_result, result =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct vega12_h=
wmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pp_table =3D &amp;(data-&g=
t;smc_state_table.pp_table);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_result =3D vega12_find_dpm_states=
_clocks_in_dpm_table(hwmgr, input);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!tmp_result,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to =
find DPM states clocks in DPM table!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D tmp_r=
esult);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_result =3D vega12_generate_dpm_le=
vel_enable_mask(hwmgr, input);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!tmp_result,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to =
generate DPM level enabled mask!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D tmp_r=
esult);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_result =3D vega12_update_sclk_thr=
eshold(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!tmp_result,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to =
update SCLK threshold!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D tmp_r=
esult);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D vega12_copy_table_to_smc(h=
wmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)pp_ta=
ble, TABLE_PPTABLE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!result,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to =
upload PPtable!&quot;, return result);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;apply_optimized_settings =3D=
 false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;apply_overdrive_next_setting=
s_mask =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static uint32_t vega12_dpm_get_sclk(struct pp_hwmgr *hwmgr, bool low)=
<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =
=3D<br>
@@ -2217,50 &#43;1868,6 @@ static void vega12_power_gate_uvd(struct pp_hwmg=
r *hwmgr, bool bgate)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_enable_disable_uvd_=
dpm(hwmgr, !bgate);<br>
&nbsp;}<br>
&nbsp;<br>
-static inline bool vega12_are_power_levels_equal(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct vega12_performance_level *pl1,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct vega12_performance_level *pl2)=
<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ((pl1-&gt;soc_clock =3D=3D pl2=
-&gt;soc_clock) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pl1-&gt;gfx_clo=
ck =3D=3D pl2-&gt;gfx_clock) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pl1-&gt;mem_clo=
ck =3D=3D pl2-&gt;mem_clock));<br>
-}<br>
-<br>
-static int vega12_check_states_equal(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pp_hw_power_state *pstate1,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pp_=
hw_power_state *pstate2, bool *equal)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct vega12_power_state *psa;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct vega12_power_state *psb;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pstate1 =3D=3D NULL || pstate2 =
=3D=3D NULL || equal =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psa =3D cast_const_phw_vega12_power_s=
tate(pstate1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psb =3D cast_const_phw_vega12_power_s=
tate(pstate2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If the two states don't even have =
the same number of performance levels they cannot be the same state. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psa-&gt;performance_level_count !=
=3D psb-&gt;performance_level_count) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *equal =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; psa-&gt;performa=
nce_level_count; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!vega12_are_power_levels_equal(&amp;(psa-&gt;performance_lev=
els[i]), &amp;(psb-&gt;performance_levels[i]))) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If we have fo=
und even one performance level pair that is different the states are differ=
ent. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *equal =3D false=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If all performance levels are the =
same try to use the UVD clocks to break the tie.*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *equal =3D ((psa-&gt;uvd_clks.vclk =
=3D=3D psb-&gt;uvd_clks.vclk) &amp;&amp; (psa-&gt;uvd_clks.dclk =3D=3D psb-=
&gt;uvd_clks.dclk));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *equal &amp;=3D ((psa-&gt;vce_clks.ev=
clk =3D=3D psb-&gt;vce_clks.evclk) &amp;&amp; (psa-&gt;vce_clks.ecclk =3D=
=3D psb-&gt;vce_clks.ecclk));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *equal &amp;=3D (psa-&gt;sclk_thresho=
ld =3D=3D psb-&gt;sclk_threshold);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static bool<br>
&nbsp;vega12_check_smc_update_required_for_display_configuration(struct pp_=
hwmgr *hwmgr)<br>
&nbsp;{<br>
@@ -2337,37 &#43;1944,6 @@ static void vega12_find_min_clock_index(struct p=
p_hwmgr *hwmgr,<br>
&nbsp;static int vega12_set_power_profile_state(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =3D (struct=
 vega12_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_idx =3D ~0, mclk_idx =
=3D ~0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=3D AMD_DPM_=
FORCED_LEVEL_AUTO)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_find_min_clock_index(hwmgr, &a=
mp;sclk_idx, &amp;mclk_idx,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;min_=
sclk, request-&gt;min_mclk);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sclk_idx !=3D ~0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!data-&gt;registry_data.sclk_dpm_key_disabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_C=
ODE(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; !smum_send_msg_to_smc_with_parameter(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; PPSMC_MSG_SetSoftMinGfxclkByIndex,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sclk_idx),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;Failed to set soft min sclk index!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return -EINVAL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mclk_idx !=3D ~0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!data-&gt;registry_data.mclk_dpm_key_disabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_C=
ODE(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; !smum_send_msg_to_smc_with_parameter(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; PPSMC_MSG_SetSoftMinUclkByIndex,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; mclk_idx),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;Failed to set soft min mclk index!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return -EINVAL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2389,28 &#43;1965,6 @@ static int vega12_get_sclk_od(struct pp_hwmgr *h=
wmgr)<br>
&nbsp;<br>
&nbsp;static int vega12_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)=
<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =3D (struct=
 vega12_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_single_dpm_table *golde=
n_sclk_table =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(data-&gt;g=
olden_dpm_table.gfx_table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *ps;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_power_state *vega12_ps;=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ps =3D hwmgr-&gt;request_ps;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ps =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps =3D cast_phw_vega12_power_s=
tate(&amp;ps-&gt;hardware);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;performance_levels[vega=
12_ps-&gt;performance_level_count - 1].gfx_clock =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; golden_sclk_table-&gt;dpm_levels[golden_sclk_table-&gt;count - 1=
].value * value / 100 &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; golden_sclk_table-&gt;dpm_levels[golden_sclk_table-&gt;count - 1=
].value;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vega12_ps-&gt;performance_levels[=
vega12_ps-&gt;performance_level_count - 1].gfx_clock &gt;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;platfo=
rm_descriptor.overdriveLimit.engineClock)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega12_ps-&gt;performance_levels[vega12_ps-&gt;performance_level=
_count - 1].gfx_clock =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;platfo=
rm_descriptor.overdriveLimit.engineClock;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2435,34 &#43;1989,6 @@ static int vega12_get_mclk_od(struct pp_hwmgr *h=
wmgr)<br>
&nbsp;<br>
&nbsp;static int vega12_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)=
<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =3D (struct=
 vega12_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_single_dpm_table *golde=
n_mclk_table =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(data-&gt;g=
olden_dpm_table.mem_table);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state&nbsp; *ps;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_power_state&nbsp; *vega=
12_ps;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ps =3D hwmgr-&gt;request_ps;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ps =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps =3D cast_phw_vega12_power_s=
tate(&amp;ps-&gt;hardware);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_ps-&gt;performance_levels<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [vega12_ps-&gt;performance_level_coun=
t - 1].mem_clock =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_mclk_tabl=
e-&gt;dpm_levels<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [golden_mclk_tab=
le-&gt;count - 1].value *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value / 100 &#43=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_mclk_tabl=
e-&gt;dpm_levels<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [golden_mclk_tab=
le-&gt;count - 1].value;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vega12_ps-&gt;performance_levels<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [vega12_ps-&gt;p=
erformance_level_count - 1].mem_clock &gt;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;platfo=
rm_descriptor.overdriveLimit.memoryClock)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega12_ps-&gt;performance_levels<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [vega12_ps-&gt;performance_level_count - 1].mem_clock =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;platform_descriptor.overdriveLimi=
t.memoryClock;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;#endif<br>
@@ -2514,12 &#43;2040,7 @@ static int vega12_get_thermal_temperature_range(=
struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_setup =3D vega12_set=
up_asic_task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dynamic_state_management_=
enable =3D vega12_enable_dpm_tasks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dynamic_state_management_=
disable =3D vega12_disable_dpm_tasks,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_num_of_pp_table_entries =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_get_numbe=
r_of_pp_table_entries,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_state_size =3D vega12_get_=
power_state_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .patch_boot_state =3D vega=
12_patch_boot_state,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .apply_state_adjust_rules =3D vega12_=
apply_state_adjust_rules,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .power_state_set =3D vega12_set_power=
_state_tasks,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_sclk =3D vega12_dpm_g=
et_sclk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk =3D vega12_dpm_g=
et_mclk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_smc_display_config=
_after_ps_adjustment =3D<br>
@@ -2543,7 &#43;2064,6 @@ static int vega12_get_thermal_temperature_range(s=
truct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_config_changed =
=3D vega12_display_configuration_changed_task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_uvd =3D vega12_=
power_gate_uvd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_vce =3D vega12_=
power_gate_vce,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_states_equal =3D vega12_check_=
states_equal,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_smc_update_required=
_for_display_configuration =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega1=
2_check_smc_update_required_for_display_configuration,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .power_off_asic =3D vega12=
_power_off_asic,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h<br>
index 644c7f0..bc98b1d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h<br>
@@ -86,37 &#43;86,6 @@ struct smu_features {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t smu_feature_bitma=
p;<br>
&nbsp;};<br>
&nbsp;<br>
-struct vega12_performance_level {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; soc_clock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; gfx_clock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; mem_clock;<br>
-};<br>
-<br>
-struct vega12_bacos {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; baco_flags;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* struct vega12_performance_level&nb=
sp; performance_level; */<br>
-};<br>
-<br>
-struct vega12_uvd_clocks {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; vclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; dclk;<br>
-};<br>
-<br>
-struct vega12_vce_clocks {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; evclk;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; ecclk;<br>
-};<br>
-<br>
-struct vega12_power_state {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
agic;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_uvd_clocks&nbsp;&nbsp;&=
nbsp; uvd_clks;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_vce_clocks&nbsp;&nbsp;&=
nbsp; vce_clks;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
erformance_level_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; dc_compatible;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
clk_threshold;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_performance_level&nbsp;=
 performance_levels[VEGA12_MAX_HARDWARE_POWERLEVELS];<br>
-};<br>
-<br>
&nbsp;struct vega12_dpm_level {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enabled;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value;<br>
@@ -350,7 &#43;319,6 @@ struct vega12_hwmgr {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_auto=
_throttle_sources;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; water_marks=
_bitmap;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_bacos&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ba=
cos;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_odn_dpm_tabl=
e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_odn_fan_tabl=
e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; odn_fan_table;<br>
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

--_000_BN6PR12MB18091B6FA1B1B3B51014822AF7AA0BN6PR12MB1809namp_--

--===============1805060149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1805060149==--
