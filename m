From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: add renoir funcs to support dc
Date: Fri, 11 Oct 2019 13:28:20 +0000
Message-ID: <MN2PR12MB32968BB65C4A075746BD1A80A2970@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191010145805.4832-1-hersenxs.wu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1904973727=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191010145805.4832-1-hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
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
To: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============1904973727==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32968BB65C4A075746BD1A80A2970MN2PR12MB3296namp_"

--_000_MN2PR12MB32968BB65C4A075746BD1A80A2970MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

it looks fine for me.

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin

________________________________
From: Hersen Wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, October 10, 2019 10:58 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Wentland, Harry <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wan=
g@amd.com>; Wu, Hersen <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/powerplay: add renoir funcs to support dc

there are two paths for renoir dc access smu.
one dc access smu directly using bios smc
interface: set disply, dprefclk, etc.
another goes through pplib for get dpm clock
table and set watermmark.

Signed-off-by: Hersen Wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 16 +---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 35 +++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    | 16 ++--
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 96 +++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 39 --------
 5 files changed, 141 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index f4cfa0caeba8..95564b8de3ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -589,10 +589,9 @@ void pp_rv_set_wm_ranges(struct pp_smu *pp,
         if (pp_funcs && pp_funcs->set_watermarks_for_clocks_ranges)
                 pp_funcs->set_watermarks_for_clocks_ranges(pp_handle,
                                                            &wm_with_clock_=
ranges);
-       else if (adev->smu.funcs &&
-                adev->smu.funcs->set_watermarks_for_clock_ranges)
+       else
                 smu_set_watermarks_for_clock_ranges(&adev->smu,
-                                                   &wm_with_clock_ranges);
+                               &wm_with_clock_ranges);
 }

 void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
@@ -665,7 +664,6 @@ enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *p=
p,
 {
         const struct dc_context *ctx =3D pp->dm;
         struct amdgpu_device *adev =3D ctx->driver_context;
-       struct smu_context *smu =3D &adev->smu;
         struct dm_pp_wm_sets_with_clock_ranges_soc15 wm_with_clock_ranges;
         struct dm_pp_clock_range_for_dmif_wm_set_soc15 *wm_dce_clocks =3D
                         wm_with_clock_ranges.wm_dmif_clocks_ranges;
@@ -708,15 +706,7 @@ enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *=
pp,
                         ranges->writer_wm_sets[i].min_drain_clk_mhz * 1000=
;
         }

-       if (!smu->funcs)
-               return PP_SMU_RESULT_UNSUPPORTED;
-
-       /* 0: successful or smu.funcs->set_watermarks_for_clock_ranges =3D =
NULL;
-        * 1: fail
-        */
-       if (smu_set_watermarks_for_clock_ranges(&adev->smu,
-                       &wm_with_clock_ranges))
-               return PP_SMU_RESULT_UNSUPPORTED;
+       smu_set_watermarks_for_clock_ranges(&adev->smu, &wm_with_clock_rang=
es);

         return PP_SMU_RESULT_OK;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index c9266ea70331..1b71c38cdf96 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1834,6 +1834,41 @@ int smu_set_mp1_state(struct smu_context *smu,
         return ret;
 }

+int smu_write_watermarks_table(struct smu_context *smu)
+{
+       int ret =3D 0;
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+       struct smu_table *table =3D NULL;
+
+       table =3D &smu_table->tables[SMU_TABLE_WATERMARKS];
+
+       if (!table->cpu_addr)
+               return -EINVAL;
+
+       ret =3D smu_update_table(smu, SMU_TABLE_WATERMARKS, 0, table->cpu_a=
ddr,
+                               true);
+
+       return ret;
+}
+
+int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
+               struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
+{
+       int ret =3D 0;
+       struct smu_table *watermarks =3D &smu->smu_table.tables[SMU_TABLE_W=
ATERMARKS];
+       void *table =3D watermarks->cpu_addr;
+
+       if (!smu->disable_watermark &&
+                       smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK=
_BIT) &&
+                       smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_=
BIT)) {
+               smu_set_watermarks_table(smu, table, clock_ranges);
+               smu->watermarks_bitmap |=3D WATERMARKS_EXIST;
+               smu->watermarks_bitmap &=3D ~WATERMARKS_LOADED;
+       }
+
+       return ret;
+}
+
 const struct amd_ip_funcs smu_ip_funcs =3D {
         .name =3D "smu",
         .early_init =3D smu_early_init,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index ccf711c327c8..1469146da1aa 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -468,6 +468,7 @@ struct pptable_funcs {
         int (*get_power_limit)(struct smu_context *smu, uint32_t *limit, b=
ool asic_default);
         int (*get_dpm_clk_limited)(struct smu_context *smu, enum smu_clk_t=
ype clk_type,
                                    uint32_t dpm_level, uint32_t *freq);
+       int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_cloc=
ks *clock_table);
 };

 struct smu_funcs
@@ -493,7 +494,6 @@ struct smu_funcs
         int (*set_min_dcef_deep_sleep)(struct smu_context *smu);
         int (*set_tool_table_location)(struct smu_context *smu);
         int (*notify_memory_pool_location)(struct smu_context *smu);
-       int (*write_watermarks_table)(struct smu_context *smu);
         int (*set_last_dcef_min_deep_sleep_clk)(struct smu_context *smu);
         int (*system_features_control)(struct smu_context *smu, bool en);
         int (*send_smc_msg)(struct smu_context *smu, uint16_t msg);
@@ -531,8 +531,6 @@ struct smu_funcs
         int (*get_current_shallow_sleep_clocks)(struct smu_context *smu,
                                                 struct smu_clock_info *clo=
cks);
         int (*notify_smu_enable_pwe)(struct smu_context *smu);
-       int (*set_watermarks_for_clock_ranges)(struct smu_context *smu,
-                                              struct dm_pp_wm_sets_with_cl=
ock_ranges_soc15 *clock_ranges);
         int (*conv_power_profile_to_pplib_workload)(int power_profile);
         uint32_t (*get_fan_control_mode)(struct smu_context *smu);
         int (*set_fan_control_mode)(struct smu_context *smu, uint32_t mode=
);
@@ -596,9 +594,6 @@ struct smu_funcs
         ((smu)->funcs->notify_memory_pool_location ? (smu)->funcs->notify_=
memory_pool_location((smu)) : 0)
 #define smu_gfx_off_control(smu, enable) \
         ((smu)->funcs->gfx_off_control ? (smu)->funcs->gfx_off_control((sm=
u), (enable)) : 0)
-
-#define smu_write_watermarks_table(smu) \
-       ((smu)->funcs->write_watermarks_table ? (smu)->funcs->write_waterma=
rks_table((smu)) : 0)
 #define smu_set_last_dcef_min_deep_sleep_clk(smu) \
         ((smu)->funcs->set_last_dcef_min_deep_sleep_clk ? (smu)->funcs->se=
t_last_dcef_min_deep_sleep_clk((smu)) : 0)
 #define smu_system_features_control(smu, en) \
@@ -738,8 +733,6 @@ struct smu_funcs
         ((smu)->funcs->get_current_shallow_sleep_clocks ? (smu)->funcs->ge=
t_current_shallow_sleep_clocks((smu), (clocks)) : 0)
 #define smu_notify_smu_enable_pwe(smu) \
         ((smu)->funcs->notify_smu_enable_pwe ? (smu)->funcs->notify_smu_en=
able_pwe((smu)) : 0)
-#define smu_set_watermarks_for_clock_ranges(smu, clock_ranges) \
-       ((smu)->funcs->set_watermarks_for_clock_ranges ? (smu)->funcs->set_=
watermarks_for_clock_ranges((smu), (clock_ranges)) : 0)
 #define smu_dpm_set_uvd_enable(smu, enable) \
         ((smu)->ppt_funcs->dpm_set_uvd_enable ? (smu)->ppt_funcs->dpm_set_=
uvd_enable((smu), (enable)) : 0)
 #define smu_dpm_set_vce_enable(smu, enable) \
@@ -778,9 +771,10 @@ struct smu_funcs
         ((smu)->ppt_funcs->dump_pptable ? (smu)->ppt_funcs->dump_pptable((=
smu)) : 0)
 #define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq) \
                 ((smu)->ppt_funcs->get_dpm_clk_limited ? (smu)->ppt_funcs-=
>get_dpm_clk_limited((smu), (clk_type), (dpm_level), (freq)) : -EINVAL)
-
 #define smu_set_soft_freq_limited_range(smu, clk_type, min, max) \
                 ((smu)->funcs->set_soft_freq_limited_range ? (smu)->funcs-=
>set_soft_freq_limited_range((smu), (clk_type), (min), (max)) : -EINVAL)
+#define smu_get_dpm_clock_table(smu, clock_table) \
+               ((smu)->ppt_funcs->get_dpm_clock_table ? (smu)->ppt_funcs->=
get_dpm_clock_table((smu), (clock_table)) : -EINVAL)

 extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table=
,
                                    uint16_t *size, uint8_t *frev, uint8_t =
*crev,
@@ -814,6 +808,10 @@ int smu_sys_get_pp_table(struct smu_context *smu, void=
 **table);
 int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)=
;
 int smu_get_power_num_states(struct smu_context *smu, struct pp_states_inf=
o *state_info);
 enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu=
);
+int smu_write_watermarks_table(struct smu_context *smu);
+int smu_set_watermarks_for_clock_ranges(
+               struct smu_context *smu,
+               struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)=
;

 /* smu to display interface */
 extern int smu_display_configuration_change(struct smu_context *smu, const
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 6aedffd739db..fa314c275a82 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -416,6 +416,40 @@ static int renoir_get_profiling_clk_mask(struct smu_co=
ntext *smu,
         return 0;
 }

+/**
+ * This interface get dpm clock table for dc
+ */
+static int renoir_get_dpm_clock_table(struct smu_context *smu, struct dpm_=
clocks *clock_table)
+{
+       DpmClocks_t *table =3D smu->smu_table.clocks_table;
+       int i;
+
+       if (!clock_table || !table)
+               return -EINVAL;
+
+       for (i =3D 0; i < PP_SMU_NUM_DCFCLK_DPM_LEVELS; i++) {
+               clock_table->DcfClocks[i].Freq =3D table->DcfClocks[i].Freq=
;
+               clock_table->DcfClocks[i].Vol =3D table->DcfClocks[i].Vol;
+       }
+
+       for (i =3D 0; i < PP_SMU_NUM_SOCCLK_DPM_LEVELS; i++) {
+               clock_table->SocClocks[i].Freq =3D table->SocClocks[i].Freq=
;
+               clock_table->SocClocks[i].Vol =3D table->SocClocks[i].Vol;
+       }
+
+       for (i =3D 0; i < PP_SMU_NUM_FCLK_DPM_LEVELS; i++) {
+               clock_table->FClocks[i].Freq =3D table->FClocks[i].Freq;
+               clock_table->FClocks[i].Vol =3D table->FClocks[i].Vol;
+       }
+
+       for (i =3D 0; i<  PP_SMU_NUM_MEMCLK_DPM_LEVELS; i++) {
+               clock_table->MemClocks[i].Freq =3D table->MemClocks[i].Freq=
;
+               clock_table->MemClocks[i].Vol =3D table->MemClocks[i].Vol;
+       }
+
+       return 0;
+}
+
 static int renoir_force_clk_levels(struct smu_context *smu,
                                    enum smu_clk_type clk_type, uint32_t ma=
sk)
 {
@@ -546,6 +580,66 @@ static int renoir_set_performance_level(struct smu_con=
text *smu, enum amd_dpm_fo
         return ret;
 }

+/* save watermark settings into pplib smu structure,
+ * also pass data to smu controller
+ */
+static int renoir_set_watermarks_table(
+               struct smu_context *smu,
+               void *watermarks,
+               struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
+{
+       int i;
+       int ret =3D 0;
+       Watermarks_t *table =3D watermarks;
+
+       if (!table || !clock_ranges)
+               return -EINVAL;
+
+       if (clock_ranges->num_wm_dmif_sets > 4 ||
+                       clock_ranges->num_wm_mcif_sets > 4)
+               return -EINVAL;
+
+       /* save into smu->smu_table.tables[SMU_TABLE_WATERMARKS]->cpu_addr*=
/
+       for (i =3D 0; i < clock_ranges->num_wm_dmif_sets; i++) {
+               table->WatermarkRow[WM_DCFCLK][i].MinClock =3D
+                       cpu_to_le16((uint16_t)
+                       (clock_ranges->wm_dmif_clocks_ranges[i].wm_min_dcfc=
lk_clk_in_khz));
+               table->WatermarkRow[WM_DCFCLK][i].MaxClock =3D
+                       cpu_to_le16((uint16_t)
+                       (clock_ranges->wm_dmif_clocks_ranges[i].wm_max_dcfc=
lk_clk_in_khz));
+               table->WatermarkRow[WM_DCFCLK][i].MinMclk =3D
+                       cpu_to_le16((uint16_t)
+                       (clock_ranges->wm_dmif_clocks_ranges[i].wm_min_mem_=
clk_in_khz));
+               table->WatermarkRow[WM_DCFCLK][i].MaxMclk =3D
+                       cpu_to_le16((uint16_t)
+                       (clock_ranges->wm_dmif_clocks_ranges[i].wm_max_mem_=
clk_in_khz));
+               table->WatermarkRow[WM_DCFCLK][i].WmSetting =3D (uint8_t)
+                               clock_ranges->wm_dmif_clocks_ranges[i].wm_s=
et_id;
+       }
+
+       for (i =3D 0; i < clock_ranges->num_wm_mcif_sets; i++) {
+               table->WatermarkRow[WM_SOCCLK][i].MinClock =3D
+                       cpu_to_le16((uint16_t)
+                       (clock_ranges->wm_mcif_clocks_ranges[i].wm_min_socc=
lk_clk_in_khz));
+               table->WatermarkRow[WM_SOCCLK][i].MaxClock =3D
+                       cpu_to_le16((uint16_t)
+                       (clock_ranges->wm_mcif_clocks_ranges[i].wm_max_socc=
lk_clk_in_khz));
+               table->WatermarkRow[WM_SOCCLK][i].MinMclk =3D
+                       cpu_to_le16((uint16_t)
+                       (clock_ranges->wm_mcif_clocks_ranges[i].wm_min_mem_=
clk_in_khz));
+               table->WatermarkRow[WM_SOCCLK][i].MaxMclk =3D
+                       cpu_to_le16((uint16_t)
+                       (clock_ranges->wm_mcif_clocks_ranges[i].wm_max_mem_=
clk_in_khz));
+               table->WatermarkRow[WM_SOCCLK][i].WmSetting =3D (uint8_t)
+                               clock_ranges->wm_mcif_clocks_ranges[i].wm_s=
et_id;
+       }
+
+       /* pass data to smu controller */
+       ret =3D smu_write_watermarks_table(smu);
+
+       return ret;
+}
+
 static const struct pptable_funcs renoir_ppt_funcs =3D {
         .get_smu_msg_index =3D renoir_get_smu_msg_index,
         .get_smu_table_index =3D renoir_get_smu_table_index,
@@ -562,6 +656,8 @@ static const struct pptable_funcs renoir_ppt_funcs =3D =
{
         .force_clk_levels =3D renoir_force_clk_levels,
         .set_power_profile_mode =3D renoir_set_power_profile_mode,
         .set_performance_level =3D renoir_set_performance_level,
+       .get_dpm_clock_table =3D renoir_get_dpm_clock_table,
+       .set_watermarks_table =3D renoir_set_watermarks_table,
 };

 void renoir_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index c9e90d59a6b8..eff7faa7944e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -770,23 +770,6 @@ static int smu_v11_0_write_pptable(struct smu_context =
*smu)
         return ret;
 }

-static int smu_v11_0_write_watermarks_table(struct smu_context *smu)
-{
-       int ret =3D 0;
-       struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct smu_table *table =3D NULL;
-
-       table =3D &smu_table->tables[SMU_TABLE_WATERMARKS];
-
-       if (!table->cpu_addr)
-               return -EINVAL;
-
-       ret =3D smu_update_table(smu, SMU_TABLE_WATERMARKS, 0, table->cpu_a=
ddr,
-                               true);
-
-       return ret;
-}
-
 static int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, uint3=
2_t clk)
 {
         int ret;
@@ -1336,26 +1319,6 @@ smu_v11_0_display_clock_voltage_request(struct smu_c=
ontext *smu,
         return ret;
 }

-static int
-smu_v11_0_set_watermarks_for_clock_ranges(struct smu_context *smu, struct
-                                         dm_pp_wm_sets_with_clock_ranges_s=
oc15
-                                         *clock_ranges)
-{
-       int ret =3D 0;
-       struct smu_table *watermarks =3D &smu->smu_table.tables[SMU_TABLE_W=
ATERMARKS];
-       void *table =3D watermarks->cpu_addr;
-
-       if (!smu->disable_watermark &&
-           smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
-           smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
-               smu_set_watermarks_table(smu, table, clock_ranges);
-               smu->watermarks_bitmap |=3D WATERMARKS_EXIST;
-               smu->watermarks_bitmap &=3D ~WATERMARKS_LOADED;
-       }
-
-       return ret;
-}
-
 static int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 {
         int ret =3D 0;
@@ -1812,7 +1775,6 @@ static const struct smu_funcs smu_v11_0_funcs =3D {
         .parse_pptable =3D smu_v11_0_parse_pptable,
         .populate_smc_tables =3D smu_v11_0_populate_smc_pptable,
         .write_pptable =3D smu_v11_0_write_pptable,
-       .write_watermarks_table =3D smu_v11_0_write_watermarks_table,
         .set_min_dcef_deep_sleep =3D smu_v11_0_set_min_dcef_deep_sleep,
         .set_tool_table_location =3D smu_v11_0_set_tool_table_location,
         .init_display_count =3D smu_v11_0_init_display_count,
@@ -1828,7 +1790,6 @@ static const struct smu_funcs smu_v11_0_funcs =3D {
         .read_sensor =3D smu_v11_0_read_sensor,
         .set_deep_sleep_dcefclk =3D smu_v11_0_set_deep_sleep_dcefclk,
         .display_clock_voltage_request =3D smu_v11_0_display_clock_voltage=
_request,
-       .set_watermarks_for_clock_ranges =3D smu_v11_0_set_watermarks_for_c=
lock_ranges,
         .get_fan_control_mode =3D smu_v11_0_get_fan_control_mode,
         .set_fan_control_mode =3D smu_v11_0_set_fan_control_mode,
         .set_fan_speed_percent =3D smu_v11_0_set_fan_speed_percent,
--
2.17.1


--_000_MN2PR12MB32968BB65C4A075746BD1A80A2970MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
it looks fine for me.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Hersen Wu &lt;hersenx=
s.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, October 10, 2019 10:58 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang=
) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Wu, Hersen &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/powerplay: add renoir funcs to support d=
c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">there are two paths for renoir dc access smu.<br>
one dc access smu directly using bios smc<br>
interface: set disply, dprefclk, etc.<br>
another goes through pplib for get dpm clock<br>
table and set watermmark.<br>
<br>
Signed-off-by: Hersen Wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c&nbsp; | 16 &#43;---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp; | 35 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; | 16 &#4=
3;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c&nbsp;&nbsp;&nbsp; | 96 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 3=
9 --------<br>
&nbsp;5 files changed, 141 insertions(&#43;), 61 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<br>
index f4cfa0caeba8..95564b8de3ce 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<=
br>
@@ -589,10 &#43;589,9 @@ void pp_rv_set_wm_ranges(struct pp_smu *pp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs &amp;&amp; pp=
_funcs-&gt;set_watermarks_for_clocks_ranges)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;set_watermarks_for_clocks_ranges(pp_hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;wm_with_clock_r=
anges);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;smu.funcs &amp;&amp=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;smu.funcs-&gt;set_watermarks_for_clock_ranges)<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_set_watermarks_for_clock_ranges(&amp;adev-&gt;smu=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &amp;wm_with_clock_ranges);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;wm_with_clock_ranges);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void pp_rv_set_pme_wa_enable(struct pp_smu *pp)<br>
@@ -665,7 &#43;664,6 @@ enum pp_smu_status pp_nv_set_wm_ranges(struct pp_sm=
u *pp,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dc_context *c=
tx =3D pp-&gt;dm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ctx-&gt;driver_context;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D &amp;adev=
-&gt;smu;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_pp_wm_sets_with_=
clock_ranges_soc15 wm_with_clock_ranges;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_pp_clock_range_f=
or_dmif_wm_set_soc15 *wm_dce_clocks =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wm_wi=
th_clock_ranges.wm_dmif_clocks_ranges;<br>
@@ -708,15 &#43;706,7 @@ enum pp_smu_status pp_nv_set_wm_ranges(struct pp_s=
mu *pp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; range=
s-&gt;writer_wm_sets[i].min_drain_clk_mhz * 1000;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;funcs)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return PP_SMU_RESULT_UNSUPPORTED;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 0: successful or smu.funcs-&gt;set=
_watermarks_for_clock_ranges =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 1: fail<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_set_watermarks_for_clock_rang=
es(&amp;adev-&gt;smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;wm_with_clo=
ck_ranges))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return PP_SMU_RESULT_UNSUPPORTED;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_set_watermarks_for_clock_rang=
es(&amp;adev-&gt;smu, &amp;wm_with_clock_ranges);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PP_SMU_RESULT_OK;<b=
r>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index c9266ea70331..1b71c38cdf96 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -1834,6 &#43;1834,41 @@ int smu_set_mp1_state(struct smu_context *smu,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;int smu_write_watermarks_table(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *smu_tab=
le =3D &amp;smu-&gt;smu_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =3D NULL;=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table =3D &amp;smu_table-&gt;tabl=
es[SMU_TABLE_WATERMARKS];<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!table-&gt;cpu_addr)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_update_table(smu, SMU=
_TABLE_WATERMARKS, 0, table-&gt;cpu_addr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)<=
br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *watermarks =3D =
&amp;smu-&gt;smu_table.tables[SMU_TABLE_WATERMARKS];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *table =3D watermarks-&gt;cp=
u_addr;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;disable_watermark &a=
mp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_feature_=
is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_feature_=
is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_set_watermarks_table(smu, table, clock_ranges);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu-&gt;watermarks_bitmap |=3D WATERMARKS_EXIST;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu-&gt;watermarks_bitmap &amp;=3D ~WATERMARKS_LOADED;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;const struct amd_ip_funcs smu_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;smu&quot;,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D smu_early_=
init,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index ccf711c327c8..1469146da1aa 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -468,6 &#43;468,7 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_power_limit)(str=
uct smu_context *smu, uint32_t *limit, bool asic_default);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_dpm_clk_limited)=
(struct smu_context *smu, enum smu_clk_type clk_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t dpm_l=
evel, uint32_t *freq);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_dpm_clock_table)(struct=
 smu_context *smu, struct dpm_clocks *clock_table);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct smu_funcs<br>
@@ -493,7 &#43;494,6 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_min_dcef_deep_sl=
eep)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_tool_table_locat=
ion)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_memory_pool_l=
ocation)(struct smu_context *smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*write_watermarks_table)(struct =
smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_last_dcef_min_de=
ep_sleep_clk)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*system_features_cont=
rol)(struct smu_context *smu, bool en);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*send_smc_msg)(struct=
 smu_context *smu, uint16_t msg);<br>
@@ -531,8 &#43;531,6 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_current_shallow_=
sleep_clocks)(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_=
clock_info *clocks);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_smu_enable_pw=
e)(struct smu_context *smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_watermarks_for_clock_ranges=
)(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_pp_wm_sets_with_cl=
ock_ranges_soc15 *clock_ranges);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*conv_power_profile_t=
o_pplib_workload)(int power_profile);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*get_fan_control=
_mode)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_control_mode=
)(struct smu_context *smu, uint32_t mode);<br>
@@ -596,9 &#43;594,6 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;notif=
y_memory_pool_location ? (smu)-&gt;funcs-&gt;notify_memory_pool_location((s=
mu)) : 0)<br>
&nbsp;#define smu_gfx_off_control(smu, enable) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;gfx_o=
ff_control ? (smu)-&gt;funcs-&gt;gfx_off_control((smu), (enable)) : 0)<br>
-<br>
-#define smu_write_watermarks_table(smu) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;write_watermarks=
_table ? (smu)-&gt;funcs-&gt;write_watermarks_table((smu)) : 0)<br>
&nbsp;#define smu_set_last_dcef_min_deep_sleep_clk(smu) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;set_l=
ast_dcef_min_deep_sleep_clk ? (smu)-&gt;funcs-&gt;set_last_dcef_min_deep_sl=
eep_clk((smu)) : 0)<br>
&nbsp;#define smu_system_features_control(smu, en) \<br>
@@ -738,8 &#43;733,6 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;get_c=
urrent_shallow_sleep_clocks ? (smu)-&gt;funcs-&gt;get_current_shallow_sleep=
_clocks((smu), (clocks)) : 0)<br>
&nbsp;#define smu_notify_smu_enable_pwe(smu) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;notif=
y_smu_enable_pwe ? (smu)-&gt;funcs-&gt;notify_smu_enable_pwe((smu)) : 0)<br=
>
-#define smu_set_watermarks_for_clock_ranges(smu, clock_ranges) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;set_watermarks_f=
or_clock_ranges ? (smu)-&gt;funcs-&gt;set_watermarks_for_clock_ranges((smu)=
, (clock_ranges)) : 0)<br>
&nbsp;#define smu_dpm_set_uvd_enable(smu, enable) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;d=
pm_set_uvd_enable ? (smu)-&gt;ppt_funcs-&gt;dpm_set_uvd_enable((smu), (enab=
le)) : 0)<br>
&nbsp;#define smu_dpm_set_vce_enable(smu, enable) \<br>
@@ -778,9 &#43;771,10 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;d=
ump_pptable ? (smu)-&gt;ppt_funcs-&gt;dump_pptable((smu)) : 0)<br>
&nbsp;#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_dpm_clk_limited ? (smu)-=
&gt;ppt_funcs-&gt;get_dpm_clk_limited((smu), (clk_type), (dpm_level), (freq=
)) : -EINVAL)<br>
-<br>
&nbsp;#define smu_set_soft_freq_limited_range(smu, clk_type, min, max) \<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;set_soft_freq_limited_range ? (s=
mu)-&gt;funcs-&gt;set_soft_freq_limited_range((smu), (clk_type), (min), (ma=
x)) : -EINVAL)<br>
&#43;#define smu_get_dpm_clock_table(smu, clock_table) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_dpm_clock_table ? (smu)-&gt;ppt=
_funcs-&gt;get_dpm_clock_table((smu), (clock_table)) : -EINVAL)<br>
&nbsp;<br>
&nbsp;extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t =
table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t *size=
, uint8_t *frev, uint8_t *crev,<br>
@@ -814,6 &#43;808,10 @@ int smu_sys_get_pp_table(struct smu_context *smu, =
void **table);<br>
&nbsp;int smu_sys_set_pp_table(struct smu_context *smu,&nbsp; void *buf, si=
ze_t size);<br>
&nbsp;int smu_get_power_num_states(struct smu_context *smu, struct pp_state=
s_info *state_info);<br>
&nbsp;enum amd_pm_state_type smu_get_current_power_state(struct smu_context=
 *smu);<br>
&#43;int smu_write_watermarks_table(struct smu_context *smu);<br>
&#43;int smu_set_watermarks_for_clock_ranges(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct smu_context *smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges);=
<br>
&nbsp;<br>
&nbsp;/* smu to display interface */<br>
&nbsp;extern int smu_display_configuration_change(struct smu_context *smu, =
const<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 6aedffd739db..fa314c275a82 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -416,6 &#43;416,40 @@ static int renoir_get_profiling_clk_mask(struct sm=
u_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/**<br>
&#43; * This interface get dpm clock table for dc<br>
&#43; */<br>
&#43;static int renoir_get_dpm_clock_table(struct smu_context *smu, struct =
dpm_clocks *clock_table)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DpmClocks_t *table =3D smu-&gt;sm=
u_table.clocks_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!clock_table || !table)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; PP_SMU_NUM_D=
CFCLK_DPM_LEVELS; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock_table-&gt;DcfClocks[i].Freq =3D table-&gt;DcfClocks[i]=
.Freq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock_table-&gt;DcfClocks[i].Vol =3D table-&gt;DcfClocks[i].=
Vol;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; PP_SMU_NUM_S=
OCCLK_DPM_LEVELS; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock_table-&gt;SocClocks[i].Freq =3D table-&gt;SocClocks[i]=
.Freq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock_table-&gt;SocClocks[i].Vol =3D table-&gt;SocClocks[i].=
Vol;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; PP_SMU_NUM_F=
CLK_DPM_LEVELS; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock_table-&gt;FClocks[i].Freq =3D table-&gt;FClocks[i].Fre=
q;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock_table-&gt;FClocks[i].Vol =3D table-&gt;FClocks[i].Vol;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i&lt;&nbsp; PP_SMU_=
NUM_MEMCLK_DPM_LEVELS; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock_table-&gt;MemClocks[i].Freq =3D table-&gt;MemClocks[i]=
.Freq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; clock_table-&gt;MemClocks[i].Vol =3D table-&gt;MemClocks[i].=
Vol;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int renoir_force_clk_levels(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_t=
ype clk_type, uint32_t mask)<br>
&nbsp;{<br>
@@ -546,6 &#43;580,66 @@ static int renoir_set_performance_level(struct smu=
_context *smu, enum amd_dpm_fo<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/* save watermark settings into pplib smu structure,<br>
&#43; * also pass data to smu controller<br>
&#43; */<br>
&#43;static int renoir_set_watermarks_table(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct smu_context *smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; void *watermarks,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)<=
br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Watermarks_t *table =3D watermark=
s;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!table || !clock_ranges)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clock_ranges-&gt;num_wm_dmif_=
sets &gt; 4 ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_ranges=
-&gt;num_wm_mcif_sets &gt; 4)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save into smu-&gt;smu_table.ta=
bles[SMU_TABLE_WATERMARKS]-&gt;cpu_addr*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; clock_ranges=
-&gt;num_wm_dmif_sets; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;WatermarkRow[WM_DCFCLK][i].MinClock =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le16(=
(uint16_t)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clock_range=
s-&gt;wm_dmif_clocks_ranges[i].wm_min_dcfclk_clk_in_khz));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;WatermarkRow[WM_DCFCLK][i].MaxClock =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le16(=
(uint16_t)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clock_range=
s-&gt;wm_dmif_clocks_ranges[i].wm_max_dcfclk_clk_in_khz));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;WatermarkRow[WM_DCFCLK][i].MinMclk =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le16(=
(uint16_t)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clock_range=
s-&gt;wm_dmif_clocks_ranges[i].wm_min_mem_clk_in_khz));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;WatermarkRow[WM_DCFCLK][i].MaxMclk =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le16(=
(uint16_t)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clock_range=
s-&gt;wm_dmif_clocks_ranges[i].wm_max_mem_clk_in_khz));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;WatermarkRow[WM_DCFCLK][i].WmSetting =3D (uint8_t)=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_ranges-&gt;wm_dmif_clocks_ranges[=
i].wm_set_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; clock_ranges=
-&gt;num_wm_mcif_sets; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;WatermarkRow[WM_SOCCLK][i].MinClock =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le16(=
(uint16_t)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clock_range=
s-&gt;wm_mcif_clocks_ranges[i].wm_min_socclk_clk_in_khz));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;WatermarkRow[WM_SOCCLK][i].MaxClock =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le16(=
(uint16_t)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clock_range=
s-&gt;wm_mcif_clocks_ranges[i].wm_max_socclk_clk_in_khz));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;WatermarkRow[WM_SOCCLK][i].MinMclk =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le16(=
(uint16_t)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clock_range=
s-&gt;wm_mcif_clocks_ranges[i].wm_min_mem_clk_in_khz));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;WatermarkRow[WM_SOCCLK][i].MaxMclk =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le16(=
(uint16_t)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clock_range=
s-&gt;wm_mcif_clocks_ranges[i].wm_max_mem_clk_in_khz));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;WatermarkRow[WM_SOCCLK][i].WmSetting =3D (uint8_t)=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock_ranges-&gt;wm_mcif_clocks_ranges[=
i].wm_set_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pass data to smu controller */=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_write_watermarks_tabl=
e(smu);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct pptable_funcs renoir_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_msg_index =3D ren=
oir_get_smu_msg_index,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_table_index =3D r=
enoir_get_smu_table_index,<br>
@@ -562,6 &#43;656,8 @@ static const struct pptable_funcs renoir_ppt_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clk_levels =3D reno=
ir_force_clk_levels,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =
=3D renoir_set_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_performance_level =3D=
 renoir_set_performance_level,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dpm_clock_table =3D renoir_g=
et_dpm_clock_table,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_watermarks_table =3D renoir_=
set_watermarks_table,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void renoir_set_ppt_funcs(struct smu_context *smu)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index c9e90d59a6b8..eff7faa7944e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -770,23 &#43;770,6 @@ static int smu_v11_0_write_pptable(struct smu_cont=
ext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu_v11_0_write_watermarks_table(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *smu_table =
=3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *table =3D NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table =3D &amp;smu_table-&gt;tables[S=
MU_TABLE_WATERMARKS];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!table-&gt;cpu_addr)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_update_table(smu, SMU_TAB=
LE_WATERMARKS, 0, table-&gt;cpu_addr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
&nbsp;static int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, =
uint32_t clk)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
@@ -1336,26 &#43;1319,6 @@ smu_v11_0_display_clock_voltage_request(struct s=
mu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int<br>
-smu_v11_0_set_watermarks_for_clock_ranges(struct smu_context *smu, struct<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; dm_pp_wm_sets_with_clock_ranges_soc15<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; *clock_ranges)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *watermarks =3D &amp=
;smu-&gt;smu_table.tables[SMU_TABLE_WATERMARKS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *table =3D watermarks-&gt;cpu_ad=
dr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;disable_watermark &amp;&=
amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_feature_i=
s_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_feature_i=
s_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_watermarks_table(smu, table, clock_ranges);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;watermarks_bitmap |=3D WATERMARKS_EXIST;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;watermarks_bitmap &amp;=3D ~WATERMARKS_LOADED;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
&nbsp;static int smu_v11_0_gfx_off_control(struct smu_context *smu, bool en=
able)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -1812,7 &#43;1775,6 @@ static const struct smu_funcs smu_v11_0_funcs =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .parse_pptable =3D smu_v11=
_0_parse_pptable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .populate_smc_tables =3D s=
mu_v11_0_populate_smc_pptable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write_pptable =3D smu_v11=
_0_write_pptable,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write_watermarks_table =3D smu_v11_0=
_write_watermarks_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_min_dcef_deep_sleep =
=3D smu_v11_0_set_min_dcef_deep_sleep,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =
=3D smu_v11_0_set_tool_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_display_count =3D sm=
u_v11_0_init_display_count,<br>
@@ -1828,7 &#43;1790,6 @@ static const struct smu_funcs smu_v11_0_funcs =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D smu_v11_0=
_read_sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_deep_sleep_dcefclk =
=3D smu_v11_0_set_deep_sleep_dcefclk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_voltage_req=
uest =3D smu_v11_0_display_clock_voltage_request,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_watermarks_for_clock_ranges =3D =
smu_v11_0_set_watermarks_for_clock_ranges,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_control_mode =3D =
smu_v11_0_get_fan_control_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_control_mode =3D =
smu_v11_0_set_fan_control_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_percent =3D=
 smu_v11_0_set_fan_speed_percent,<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB32968BB65C4A075746BD1A80A2970MN2PR12MB3296namp_--

--===============1904973727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1904973727==--
