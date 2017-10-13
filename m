From: Harsha Sharma <harshasharmaiitr@gmail.com>
Subject: [PATCH v3] drm/amd/powerplay: Remove unnecessary cast on void pointer
Date: Sat, 14 Oct 2017 02:09:40 +0530
Message-ID: <20171013203940.16434-1-harshasharmaiitr@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com, Harsha Sharma <harshasharmaiitr@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Done with following coccinelle patch

@r@
expression x;
void* e;
type T;
identifier f;
@@
(
  *((T *)e)
|
  ((T *)x)[...]
|
  ((T*)x)->f
|

- (T*)
  e
)

Signed-off-by: Harsha Sharma <harshasharmaiitr@gmail.com>
---
Changes in v3:
 -Removed unnecessary lines
 -Remove more useless casts
Changes in v2:
 -Remove unnecessary parentheses
 -Remove one more useless cast

 drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     |   6 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |   8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c   |   2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |   6 +-
 .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  |   2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 177 ++++++++++-----------
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c |   4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  22 +--
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   |   2 +-
 9 files changed, 107 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
index bc839ff0bdd0..f22104c78dcb 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
@@ -474,7 +474,7 @@ static int cz_tf_upload_pptable_to_smu(struct pp_hwmgr *hwmgr, void *input,
 	PP_ASSERT_WITH_CODE((0 == ret && NULL != table),
 			    "Fail to get clock table from SMU!", return -EINVAL;);
 
-	clock_table = (struct SMU8_Fusion_ClkTable *)table;
+	clock_table = table;
 
 	/* patch clock table */
 	PP_ASSERT_WITH_CODE((vddc_table->count <= CZ_MAX_HARDWARE_POWERLEVELS),
@@ -868,8 +868,8 @@ static int cz_tf_update_low_mem_pstate(struct pp_hwmgr *hwmgr,
 {
 	bool disable_switch;
 	bool enable_low_mem_state;
-	struct cz_hwmgr *hw_data = (struct cz_hwmgr *)(hwmgr->backend);
-	const struct phm_set_power_state_input *states = (struct phm_set_power_state_input *)input;
+	struct cz_hwmgr *hw_data = hwmgr->backend;
+	const struct phm_set_power_state_input *states = input;
 	const struct cz_power_state *pnew_state = cast_const_PhwCzPowerState(states->pnew_state);
 
 	if (hw_data->sys_info.nb_dpm_enable) {
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index 9547f265a8bb..5d63a1b18b39 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -469,7 +469,7 @@ int phm_reset_single_dpm_table(void *table,
 {
 	int i;
 
-	struct vi_dpm_table *dpm_table = (struct vi_dpm_table *)table;
+	struct vi_dpm_table *dpm_table = table;
 
 	dpm_table->count = count > max ? max : count;
 
@@ -484,7 +484,7 @@ void phm_setup_pcie_table_entry(
 	uint32_t index, uint32_t pcie_gen,
 	uint32_t pcie_lanes)
 {
-	struct vi_dpm_table *dpm_table = (struct vi_dpm_table *)table;
+	struct vi_dpm_table *dpm_table = table;
 	dpm_table->dpm_level[index].value = pcie_gen;
 	dpm_table->dpm_level[index].param1 = pcie_lanes;
 	dpm_table->dpm_level[index].enabled = 1;
@@ -494,7 +494,7 @@ int32_t phm_get_dpm_level_enable_mask_value(void *table)
 {
 	int32_t i;
 	int32_t mask = 0;
-	struct vi_dpm_table *dpm_table = (struct vi_dpm_table *)table;
+	struct vi_dpm_table *dpm_table = table;
 
 	for (i = dpm_table->count; i > 0; i--) {
 		mask = mask << 1;
@@ -566,7 +566,7 @@ int phm_find_boot_level(void *table,
 {
 	int result = -EINVAL;
 	uint32_t i;
-	struct vi_dpm_table *dpm_table = (struct vi_dpm_table *)table;
+	struct vi_dpm_table *dpm_table = table;
 
 	for (i = 0; i < dpm_table->count; i++) {
 		if (value == dpm_table->dpm_level[i].value) {
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
index 953e0c9ad7cd..676f2e8bb2ee 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
@@ -579,7 +579,7 @@ static ATOM_GPIO_PIN_LUT *get_gpio_lookup_table(void *device)
 	PP_ASSERT_WITH_CODE((NULL != table_address),
 			"Error retrieving BIOS Table Address!", return NULL;);
 
-	return (ATOM_GPIO_PIN_LUT *)table_address;
+	return table_address;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
index c062844b15f3..05e3f5302994 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
@@ -66,7 +66,7 @@ static struct atom_voltage_objects_info_v4_1 *pp_atomfwctrl_get_voltage_info_tab
         "Error retrieving BIOS Table Address!",
         return NULL);
 
-    return (struct atom_voltage_objects_info_v4_1 *)table_address;
+    return table_address;
 }
 
 /**
@@ -173,7 +173,7 @@ static struct atom_gpio_pin_lut_v2_1 *pp_atomfwctrl_get_gpio_lookup_table(
 			"Error retrieving BIOS Table Address!",
 			return NULL);
 
-	return (struct atom_gpio_pin_lut_v2_1 *)table_address;
+	return table_address;
 }
 
 static bool pp_atomfwctrl_lookup_gpio_pin(
@@ -542,4 +542,4 @@ int pp_atomfwctrl_get_vbios_bootup_values(struct pp_hwmgr *hwmgr,
 		boot_values->ulDCEFClk   = frequency;
 
 	return 0;
-}
\ No newline at end of file
+}
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
index 2716721e5453..e795b14eaabe 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
@@ -807,7 +807,7 @@ static const ATOM_PPLIB_POWERPLAYTABLE *get_powerplay_table(
 		hwmgr->soft_pp_table_size = size;
 	}
 
-	return (const ATOM_PPLIB_POWERPLAYTABLE *)table_addr;
+	return table_addr;
 }
 
 int pp_tables_get_response_times(struct pp_hwmgr *hwmgr,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index c2743233ba10..7470e33c4322 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -175,8 +175,7 @@ static int smu7_enable_smc_voltage_controller(struct pp_hwmgr *hwmgr)
 */
 static bool smu7_voltage_control(const struct pp_hwmgr *hwmgr)
 {
-	const struct smu7_hwmgr *data =
-			(const struct smu7_hwmgr *)(hwmgr->backend);
+	const struct smu7_hwmgr *data = hwmgr->backend;
 
 	return (SMU7_VOLTAGE_CONTROL_NONE != data->voltage_control);
 }
@@ -227,7 +226,7 @@ static int phm_get_svi2_voltage_table_v0(pp_atomctrl_voltage_table *voltage_tabl
 */
 static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)hwmgr->pptable;
 	int result = 0;
@@ -340,7 +339,7 @@ static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
 static int smu7_program_static_screen_threshold_parameters(
 							struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	/* Set static screen threshold unit */
 	PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
@@ -386,7 +385,7 @@ static int smu7_enable_display_gap(struct pp_hwmgr *hwmgr)
 */
 static int smu7_program_voting_clients(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	/* Clear reset for voting clients before enabling DPM */
 	PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
@@ -526,7 +525,7 @@ static int smu7_force_switch_to_arbf0(struct pp_hwmgr *hwmgr)
 
 static int smu7_setup_default_pcie_table(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
@@ -619,7 +618,7 @@ static int smu7_setup_default_pcie_table(struct pp_hwmgr *hwmgr)
 
 static int smu7_reset_dpm_tables(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	memset(&(data->dpm_table), 0x00, sizeof(data->dpm_table));
 
@@ -661,7 +660,7 @@ static int smu7_reset_dpm_tables(struct pp_hwmgr *hwmgr)
 
 static int smu7_setup_dpm_tables_v0(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_clock_voltage_dependency_table *allowed_vdd_sclk_table =
 		hwmgr->dyn_state.vddc_dependency_on_sclk;
 	struct phm_clock_voltage_dependency_table *allowed_vdd_mclk_table =
@@ -747,7 +746,7 @@ static int smu7_setup_dpm_tables_v0(struct pp_hwmgr *hwmgr)
 
 static int smu7_setup_dpm_tables_v1(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	uint32_t i;
@@ -809,7 +808,7 @@ static int smu7_setup_dpm_tables_v1(struct pp_hwmgr *hwmgr)
 
 static int smu7_setup_default_dpm_tables(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	smu7_reset_dpm_tables(hwmgr);
 
@@ -870,7 +869,7 @@ static int smu7_enable_sclk_control(struct pp_hwmgr *hwmgr)
 
 static int smu7_enable_ulv(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (data->ulv_supported)
 		return smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_EnableULV);
@@ -880,7 +879,7 @@ static int smu7_enable_ulv(struct pp_hwmgr *hwmgr)
 
 static int smu7_disable_ulv(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (data->ulv_supported)
 		return smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_DisableULV);
@@ -925,7 +924,7 @@ static int smu7_disable_deep_sleep_master_switch(struct pp_hwmgr *hwmgr)
 
 static int smu7_disable_handshake_uvd(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	uint32_t soft_register_value = 0;
 	uint32_t handshake_disables_offset = data->soft_regs_start
 				+ smum_get_offsetof(hwmgr->smumgr,
@@ -942,7 +941,7 @@ static int smu7_disable_handshake_uvd(struct pp_hwmgr *hwmgr)
 
 static int smu7_enable_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	/* enable SCLK dpm */
 	if (!data->sclk_dpm_key_disabled)
@@ -977,7 +976,7 @@ static int smu7_enable_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 
 static int smu7_start_dpm(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	/*enable general power management */
 
@@ -1025,7 +1024,7 @@ static int smu7_start_dpm(struct pp_hwmgr *hwmgr)
 
 static int smu7_disable_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	/* disable SCLK dpm */
 	if (!data->sclk_dpm_key_disabled) {
@@ -1048,7 +1047,7 @@ static int smu7_disable_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 
 static int smu7_stop_dpm(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	/* disable general power management */
 	PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, GENERAL_PWRMGT,
@@ -1120,7 +1119,7 @@ static void smu7_set_dpm_event_sources(struct pp_hwmgr *hwmgr, uint32_t sources)
 static int smu7_enable_auto_throttle_source(struct pp_hwmgr *hwmgr,
 		PHM_AutoThrottleSource source)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (!(data->active_auto_throttle_sources & (1 << source))) {
 		data->active_auto_throttle_sources |= 1 << source;
@@ -1137,7 +1136,7 @@ static int smu7_enable_thermal_auto_throttle(struct pp_hwmgr *hwmgr)
 static int smu7_disable_auto_throttle_source(struct pp_hwmgr *hwmgr,
 		PHM_AutoThrottleSource source)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (data->active_auto_throttle_sources & (1 << source)) {
 		data->active_auto_throttle_sources &= ~(1 << source);
@@ -1153,7 +1152,7 @@ static int smu7_disable_thermal_auto_throttle(struct pp_hwmgr *hwmgr)
 
 static int smu7_pcie_performance_request(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	data->pcie_performance_request = true;
 
 	return 0;
@@ -1349,7 +1348,7 @@ int smu7_reset_asic_tasks(struct pp_hwmgr *hwmgr)
 
 static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	struct cgs_system_info sys_info = {0};
@@ -1472,7 +1471,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 */
 static int smu7_get_evv_voltages(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	uint16_t vv_id;
 	uint16_t vddc = 0;
 	uint16_t vddgfx = 0;
@@ -1624,7 +1623,7 @@ static int smu7_patch_voltage_dependency_tables_with_lookup_table(
 {
 	uint8_t entry_id;
 	uint8_t voltage_id;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 
@@ -1706,7 +1705,7 @@ static int smu7_calc_voltage_dependency_tables(struct pp_hwmgr *hwmgr)
 {
 	uint8_t entry_id;
 	struct phm_ppt_v1_voltage_lookup_record v_record;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_ppt_v1_information *pptable_info = (struct phm_ppt_v1_information *)(hwmgr->pptable);
 
 	phm_ppt_v1_clock_voltage_dependency_table *sclk_table = pptable_info->vdd_dep_on_sclk;
@@ -1748,7 +1747,7 @@ static int smu7_calc_mm_voltage_dependency_table(struct pp_hwmgr *hwmgr)
 {
 	uint8_t entry_id;
 	struct phm_ppt_v1_voltage_lookup_record v_record;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_ppt_v1_information *pptable_info = (struct phm_ppt_v1_information *)(hwmgr->pptable);
 	phm_ppt_v1_mm_clock_voltage_dependency_table *mm_table = pptable_info->mm_dep_table;
 
@@ -1799,7 +1798,7 @@ static int smu7_complete_dependency_tables(struct pp_hwmgr *hwmgr)
 {
 	int result = 0;
 	int tmp_result;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 
@@ -2053,7 +2052,7 @@ static int smu7_patch_vddc(struct pp_hwmgr *hwmgr,
 			      struct phm_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (tab)
 		for (i = 0; i < tab->count; i++)
@@ -2067,7 +2066,7 @@ static int smu7_patch_vddci(struct pp_hwmgr *hwmgr,
 			       struct phm_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (tab)
 		for (i = 0; i < tab->count; i++)
@@ -2081,7 +2080,7 @@ static int smu7_patch_vce_vddc(struct pp_hwmgr *hwmgr,
 				  struct phm_vce_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (tab)
 		for (i = 0; i < tab->count; i++)
@@ -2096,7 +2095,7 @@ static int smu7_patch_uvd_vddc(struct pp_hwmgr *hwmgr,
 				  struct phm_uvd_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (tab)
 		for (i = 0; i < tab->count; i++)
@@ -2110,7 +2109,7 @@ static int smu7_patch_vddc_shed_limit(struct pp_hwmgr *hwmgr,
 					 struct phm_phase_shedding_limits_table *tab)
 {
 	uint16_t i;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (tab)
 		for (i = 0; i < tab->count; i++)
@@ -2124,7 +2123,7 @@ static int smu7_patch_samu_vddc(struct pp_hwmgr *hwmgr,
 				   struct phm_samu_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (tab)
 		for (i = 0; i < tab->count; i++)
@@ -2138,7 +2137,7 @@ static int smu7_patch_acp_vddc(struct pp_hwmgr *hwmgr,
 				  struct phm_acp_clock_voltage_dependency_table *tab)
 {
 	uint16_t i;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (tab)
 		for (i = 0; i < tab->count; i++)
@@ -2152,7 +2151,7 @@ static int smu7_patch_limits_vddc(struct pp_hwmgr *hwmgr,
 				  struct phm_clock_and_voltage_limits *tab)
 {
 	uint32_t vddc, vddci;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (tab) {
 		vddc = tab->vddc;
@@ -2172,7 +2171,7 @@ static int smu7_patch_cac_vddc(struct pp_hwmgr *hwmgr, struct phm_cac_leakage_ta
 {
 	uint32_t i;
 	uint32_t vddc;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (tab) {
 		for (i = 0; i < tab->count; i++) {
@@ -2243,7 +2242,7 @@ static int smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr *hwmgr)
 
 static int smu7_set_private_data_based_on_pptable_v0(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	struct phm_clock_voltage_dependency_table *allowed_sclk_vddc_table = hwmgr->dyn_state.vddc_dependency_on_sclk;
 	struct phm_clock_voltage_dependency_table *allowed_mclk_vddc_table = hwmgr->dyn_state.vddc_dependency_on_mclk;
@@ -2371,7 +2370,7 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 
 static int smu7_force_dpm_highest(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	uint32_t level, tmp;
 
 	if (!data->pcie_dpm_key_disabled) {
@@ -2420,7 +2419,7 @@ static int smu7_force_dpm_highest(struct pp_hwmgr *hwmgr)
 
 static int smu7_upload_dpm_level_enable_mask(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (hwmgr->pp_table_version == PP_TABLE_V1)
 		phm_apply_dal_min_voltage_request(hwmgr);
@@ -2445,7 +2444,7 @@ static int smu7_upload_dpm_level_enable_mask(struct pp_hwmgr *hwmgr)
 
 static int smu7_unforce_dpm_levels(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (!smum_is_dpm_running(hwmgr))
 		return -EINVAL;
@@ -2460,8 +2459,7 @@ static int smu7_unforce_dpm_levels(struct pp_hwmgr *hwmgr)
 
 static int smu7_force_dpm_lowest(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data =
-			(struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	uint32_t level;
 
 	if (!data->sclk_dpm_key_disabled)
@@ -2501,7 +2499,7 @@ static int smu7_get_profiling_clk(struct pp_hwmgr *hwmgr, enum amd_dpm_forced_le
 				uint32_t *sclk_mask, uint32_t *mclk_mask, uint32_t *pcie_mask)
 {
 	uint32_t percentage;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_dpm_table *golden_dpm_table = &data->golden_dpm_table;
 	int32_t tmp_mclk;
 	int32_t tmp_sclk;
@@ -2655,7 +2653,7 @@ static int smu7_get_power_state_size(struct pp_hwmgr *hwmgr)
 static int smu7_vblank_too_short(struct pp_hwmgr *hwmgr,
 				 uint32_t vblank_time_us)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	uint32_t switch_limit_us;
 
 	switch (hwmgr->chip_id) {
@@ -2691,7 +2689,7 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	struct cgs_mode_info mode_info = {0};
 	const struct phm_clock_and_voltage_limits *max_limits;
 	uint32_t i;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	int32_t count;
@@ -2890,7 +2888,7 @@ static int smu7_dpm_get_sclk(struct pp_hwmgr *hwmgr, bool low)
 static int smu7_dpm_patch_boot_state(struct pp_hwmgr *hwmgr,
 					struct pp_hw_power_state *hw_ps)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_power_state *ps = (struct smu7_power_state *)hw_ps;
 	ATOM_FIRMWARE_INFO_V2_2 *fw_info;
 	uint16_t size;
@@ -2952,13 +2950,11 @@ static int smu7_get_pp_table_entry_callback_func_v1(struct pp_hwmgr *hwmgr,
 		void *state, struct pp_power_state *power_state,
 		void *pp_table, uint32_t classification_flag)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
-	struct smu7_power_state  *smu7_power_state =
-			(struct smu7_power_state *)(&(power_state->hardware));
+	struct smu7_hwmgr *data = hwmgr->backend;
+	struct smu7_power_state  *smu7_power_state = &(power_state->hardware);
 	struct smu7_performance_level *performance_level;
-	ATOM_Tonga_State *state_entry = (ATOM_Tonga_State *)state;
-	ATOM_Tonga_POWERPLAYTABLE *powerplay_table =
-			(ATOM_Tonga_POWERPLAYTABLE *)pp_table;
+	ATOM_Tonga_State *state_entry = state;
+	ATOM_Tonga_POWERPLAYTABLE *powerplay_table = pp_table;
 	PPTable_Generic_SubTable_Header *sclk_dep_table =
 			(PPTable_Generic_SubTable_Header *)
 			(((unsigned long)powerplay_table) +
@@ -3051,7 +3047,7 @@ static int smu7_get_pp_table_entry_v1(struct pp_hwmgr *hwmgr,
 {
 	int result;
 	struct smu7_power_state *ps;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	struct phm_ppt_v1_clock_voltage_dependency_table *dep_mclk_table =
@@ -3152,7 +3148,7 @@ static int smu7_get_pp_table_entry_callback_func_v0(struct pp_hwmgr *hwmgr,
 					struct pp_hw_power_state *power_state,
 					unsigned int index, const void *clock_info)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_power_state  *ps = cast_phw_smu7_power_state(power_state);
 	const ATOM_PPLIB_CI_CLOCK_INFO *visland_clk_info = clock_info;
 	struct smu7_performance_level *performance_level;
@@ -3196,7 +3192,7 @@ static int smu7_get_pp_table_entry_v0(struct pp_hwmgr *hwmgr,
 {
 	int result;
 	struct smu7_power_state *ps;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct phm_clock_voltage_dependency_table *dep_mclk_table =
 			hwmgr->dyn_state.vddci_dependency_on_mclk;
 
@@ -3345,7 +3341,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 {
 	uint32_t sclk, mclk, activity_percent;
 	uint32_t offset;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	/* size must be at least 4 bytes for all sensors */
 	if (*size < 4)
@@ -3391,7 +3387,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		if (*size < sizeof(struct pp_gpu_power))
 			return -EINVAL;
 		*size = sizeof(struct pp_gpu_power);
-		return smu7_get_gpu_power(hwmgr, (struct pp_gpu_power *)value);
+		return smu7_get_gpu_power(hwmgr, value);
 	default:
 		return -EINVAL;
 	}
@@ -3399,11 +3395,10 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 
 static int smu7_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, const void *input)
 {
-	const struct phm_set_power_state_input *states =
-			(const struct phm_set_power_state_input *)input;
+	const struct phm_set_power_state_input *states = input;
 	const struct smu7_power_state *smu7_ps =
 			cast_const_phw_smu7_power_state(states->pnew_state);
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_single_dpm_table *sclk_table = &(data->dpm_table.sclk_table);
 	uint32_t sclk = smu7_ps->performance_levels
 			[smu7_ps->performance_level_count - 1].engine_clock;
@@ -3454,7 +3449,7 @@ static uint16_t smu7_get_maximum_link_speed(struct pp_hwmgr *hwmgr,
 {
 	uint32_t i;
 	uint32_t sclk, max_sclk = 0;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_dpm_table *dpm_table = &data->dpm_table;
 
 	for (i = 0; i < smu7_ps->performance_level_count; i++) {
@@ -3477,9 +3472,8 @@ static uint16_t smu7_get_maximum_link_speed(struct pp_hwmgr *hwmgr,
 static int smu7_request_link_speed_change_before_state_change(
 		struct pp_hwmgr *hwmgr, const void *input)
 {
-	const struct phm_set_power_state_input *states =
-			(const struct phm_set_power_state_input *)input;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	const struct phm_set_power_state_input *states = input;
+	struct smu7_hwmgr *data = hwmgr->backend;
 	const struct smu7_power_state *smu7_nps =
 			cast_const_phw_smu7_power_state(states->pnew_state);
 	const struct smu7_power_state *polaris10_cps =
@@ -3521,7 +3515,7 @@ static int smu7_request_link_speed_change_before_state_change(
 
 static int smu7_freeze_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (0 == data->need_update_smu7_dpm_table)
 		return 0;
@@ -3557,11 +3551,10 @@ static int smu7_populate_and_upload_sclk_mclk_dpm_levels(
 		struct pp_hwmgr *hwmgr, const void *input)
 {
 	int result = 0;
-	const struct phm_set_power_state_input *states =
-			(const struct phm_set_power_state_input *)input;
+	const struct phm_set_power_state_input *states = input;
 	const struct smu7_power_state *smu7_ps =
 			cast_const_phw_smu7_power_state(states->pnew_state);
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	uint32_t sclk = smu7_ps->performance_levels
 			[smu7_ps->performance_level_count - 1].engine_clock;
 	uint32_t mclk = smu7_ps->performance_levels
@@ -3702,7 +3695,7 @@ static int smu7_trim_single_dpm_states(struct pp_hwmgr *hwmgr,
 static int smu7_trim_dpm_states(struct pp_hwmgr *hwmgr,
 		const struct smu7_power_state *smu7_ps)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	uint32_t high_limit_count;
 
 	PP_ASSERT_WITH_CODE((smu7_ps->performance_level_count >= 1),
@@ -3728,9 +3721,8 @@ static int smu7_generate_dpm_level_enable_mask(
 		struct pp_hwmgr *hwmgr, const void *input)
 {
 	int result;
-	const struct phm_set_power_state_input *states =
-			(const struct phm_set_power_state_input *)input;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	const struct phm_set_power_state_input *states = input;
+	struct smu7_hwmgr *data = hwmgr->backend;
 	const struct smu7_power_state *smu7_ps =
 			cast_const_phw_smu7_power_state(states->pnew_state);
 
@@ -3750,7 +3742,7 @@ static int smu7_generate_dpm_level_enable_mask(
 
 static int smu7_unfreeze_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (0 == data->need_update_smu7_dpm_table)
 		return 0;
@@ -3788,9 +3780,8 @@ static int smu7_unfreeze_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
 static int smu7_notify_link_speed_change_after_state_change(
 		struct pp_hwmgr *hwmgr, const void *input)
 {
-	const struct phm_set_power_state_input *states =
-			(const struct phm_set_power_state_input *)input;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	const struct phm_set_power_state_input *states = input;
+	struct smu7_hwmgr *data = hwmgr->backend;
 	const struct smu7_power_state *smu7_ps =
 			cast_const_phw_smu7_power_state(states->pnew_state);
 	uint16_t target_link_speed = smu7_get_maximum_link_speed(hwmgr, smu7_ps);
@@ -3821,7 +3812,7 @@ static int smu7_notify_link_speed_change_after_state_change(
 
 static int smu7_notify_smc_display(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (hwmgr->feature_mask & PP_VBI_TIME_SUPPORT_MASK)
 		smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,
@@ -3832,7 +3823,7 @@ static int smu7_notify_smc_display(struct pp_hwmgr *hwmgr)
 static int smu7_set_power_state_tasks(struct pp_hwmgr *hwmgr, const void *input)
 {
 	int tmp_result, result = 0;
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	tmp_result = smu7_find_dpm_states_clocks_in_dpm_table(hwmgr, input);
 	PP_ASSERT_WITH_CODE((0 == tmp_result),
@@ -3939,7 +3930,7 @@ smu7_notify_smc_display_config_after_ps_adjustment(struct pp_hwmgr *hwmgr)
 */
 static int smu7_program_display_gap(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	uint32_t num_active_displays = 0;
 	uint32_t display_gap = cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_DISPLAY_GAP_CNTL);
 	uint32_t display_gap2;
@@ -4020,7 +4011,7 @@ static int smu7_register_internal_thermal_interrupt(struct pp_hwmgr *hwmgr,
 static bool
 smu7_check_smc_update_required_for_display_configuration(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	bool is_update_required = false;
 	struct cgs_display_info info = {0, 0, NULL};
 
@@ -4084,7 +4075,7 @@ static int smu7_check_states_equal(struct pp_hwmgr *hwmgr,
 
 static int smu7_upload_mc_firmware(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	uint32_t vbios_version;
 	uint32_t tmp;
@@ -4116,7 +4107,7 @@ static int smu7_upload_mc_firmware(struct pp_hwmgr *hwmgr)
 
 static int smu7_read_clock_registers(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	data->clock_registers.vCG_SPLL_FUNC_CNTL         =
 		cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_SPLL_FUNC_CNTL);
@@ -4160,7 +4151,7 @@ static int smu7_read_clock_registers(struct pp_hwmgr *hwmgr)
  */
 static int smu7_get_memory_type(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	uint32_t temp;
 
 	temp = cgs_read_register(hwmgr->device, mmMC_SEQ_MISC0);
@@ -4194,7 +4185,7 @@ static int smu7_enable_acpi_power_management(struct pp_hwmgr *hwmgr)
  */
 static int smu7_init_power_gate_state(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	data->uvd_power_gated = false;
 	data->vce_power_gated = false;
@@ -4205,7 +4196,7 @@ static int smu7_init_power_gate_state(struct pp_hwmgr *hwmgr)
 
 static int smu7_init_sclk_threshold(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	data->low_sclk_interrupt_threshold = 0;
 	return 0;
@@ -4247,7 +4238,7 @@ static int smu7_setup_asic_task(struct pp_hwmgr *hwmgr)
 static int smu7_force_clock_level(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, uint32_t mask)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (hwmgr->dpm_level & (AMD_DPM_FORCED_LEVEL_AUTO |
 				AMD_DPM_FORCED_LEVEL_LOW |
@@ -4291,7 +4282,7 @@ static int smu7_force_clock_level(struct pp_hwmgr *hwmgr,
 static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, char *buf)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_single_dpm_table *sclk_table = &(data->dpm_table.sclk_table);
 	struct smu7_single_dpm_table *mclk_table = &(data->dpm_table.mclk_table);
 	struct smu7_single_dpm_table *pcie_table = &(data->dpm_table.pcie_speed_table);
@@ -4384,7 +4375,7 @@ static int smu7_get_fan_control_mode(struct pp_hwmgr *hwmgr)
 
 static int smu7_get_sclk_od(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_single_dpm_table *sclk_table = &(data->dpm_table.sclk_table);
 	struct smu7_single_dpm_table *golden_sclk_table =
 			&(data->golden_dpm_table.sclk_table);
@@ -4400,7 +4391,7 @@ static int smu7_get_sclk_od(struct pp_hwmgr *hwmgr)
 
 static int smu7_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_single_dpm_table *golden_sclk_table =
 			&(data->golden_dpm_table.sclk_table);
 	struct pp_power_state  *ps;
@@ -4426,7 +4417,7 @@ static int smu7_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 
 static int smu7_get_mclk_od(struct pp_hwmgr *hwmgr)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_single_dpm_table *mclk_table = &(data->dpm_table.mclk_table);
 	struct smu7_single_dpm_table *golden_mclk_table =
 			&(data->golden_dpm_table.mclk_table);
@@ -4442,7 +4433,7 @@ static int smu7_get_mclk_od(struct pp_hwmgr *hwmgr)
 
 static int smu7_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_single_dpm_table *golden_mclk_table =
 			&(data->golden_dpm_table.mclk_table);
 	struct pp_power_state  *ps;
@@ -4494,7 +4485,7 @@ static int smu7_get_sclks(struct pp_hwmgr *hwmgr, struct amd_pp_clocks *clocks)
 
 static uint32_t smu7_get_mem_latency(struct pp_hwmgr *hwmgr, uint32_t clk)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 
 	if (clk >= MEM_FREQ_LOW_LATENCY && clk < MEM_FREQ_HIGH_LATENCY)
 		return data->mem_latency_high;
@@ -4552,7 +4543,7 @@ static void smu7_find_min_clock_masks(struct pp_hwmgr *hwmgr,
 		uint32_t *sclk_mask, uint32_t *mclk_mask,
 		uint32_t min_sclk, uint32_t min_mclk)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	struct smu7_dpm_table *dpm_table = &(data->dpm_table);
 	uint32_t i;
 
@@ -4572,7 +4563,7 @@ static void smu7_find_min_clock_masks(struct pp_hwmgr *hwmgr,
 static int smu7_set_power_profile_state(struct pp_hwmgr *hwmgr,
 		struct amd_pp_profile *request)
 {
-	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct smu7_hwmgr *data = hwmgr->backend;
 	int tmp_result, result = 0;
 	uint32_t sclk_mask = 0, mclk_mask = 0;
 
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
index baddb569a8b8..a17443d5aa61 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
@@ -452,7 +452,7 @@ static int tf_smu7_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr,
 static int tf_smu7_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		void *input, void *output, void *storage, int result)
 {
-	struct PP_TemperatureRange *range = (struct PP_TemperatureRange *)input;
+	struct PP_TemperatureRange *range = input;
 
 	if (range == NULL)
 		return -EINVAL;
@@ -581,4 +581,4 @@ void pp_smu7_thermal_fini(struct pp_hwmgr *hwmgr)
 	phm_destroy_table(hwmgr, &(hwmgr->set_temperature_range));
 	phm_destroy_table(hwmgr, &(hwmgr->start_thermal_controller));
 	return;
-}
\ No newline at end of file
+}
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index f8f02e70b8bc..9d3c5bfeebc7 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -2994,9 +2994,8 @@ static int vega10_get_pp_table_entry_callback_func(struct pp_hwmgr *hwmgr,
 	struct vega10_power_state *vega10_power_state =
 			cast_phw_vega10_power_state(&(power_state->hardware));
 	struct vega10_performance_level *performance_level;
-	ATOM_Vega10_State *state_entry = (ATOM_Vega10_State *)state;
-	ATOM_Vega10_POWERPLAYTABLE *powerplay_table =
-			(ATOM_Vega10_POWERPLAYTABLE *)pp_table;
+	ATOM_Vega10_State *state_entry = state;
+	ATOM_Vega10_POWERPLAYTABLE *powerplay_table = pp_table;
 	ATOM_Vega10_SOCCLK_Dependency_Table *socclk_dep_table =
 			(ATOM_Vega10_SOCCLK_Dependency_Table *)
 			(((unsigned long)powerplay_table) +
@@ -3305,8 +3304,7 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 
 static int vega10_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, const void *input)
 {
-	const struct phm_set_power_state_input *states =
-			(const struct phm_set_power_state_input *)input;
+	const struct phm_set_power_state_input *states = input;
 	const struct vega10_power_state *vega10_ps =
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	struct vega10_hwmgr *data =
@@ -3396,12 +3394,10 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_levels(
 		struct pp_hwmgr *hwmgr, const void *input)
 {
 	int result = 0;
-	const struct phm_set_power_state_input *states =
-			(const struct phm_set_power_state_input *)input;
+	const struct phm_set_power_state_input *states = input;
 	const struct vega10_power_state *vega10_ps =
 			cast_const_phw_vega10_power_state(states->pnew_state);
-	struct vega10_hwmgr *data =
-			(struct vega10_hwmgr *)(hwmgr->backend);
+	struct vega10_hwmgr *data = hwmgr->backend;
 	uint32_t sclk = vega10_ps->performance_levels
 			[vega10_ps->performance_level_count - 1].gfx_clock;
 	uint32_t mclk = vega10_ps->performance_levels
@@ -3810,10 +3806,8 @@ static int vega10_upload_dpm_max_level(struct pp_hwmgr *hwmgr)
 static int vega10_generate_dpm_level_enable_mask(
 		struct pp_hwmgr *hwmgr, const void *input)
 {
-	struct vega10_hwmgr *data =
-			(struct vega10_hwmgr *)(hwmgr->backend);
-	const struct phm_set_power_state_input *states =
-			(const struct phm_set_power_state_input *)input;
+	struct vega10_hwmgr *data = hwmgr->backend;
+	const struct phm_set_power_state_input *states = input;
 	const struct vega10_power_state *vega10_ps =
 			cast_const_phw_vega10_power_state(states->pnew_state);
 	int i;
@@ -4042,7 +4036,7 @@ static int vega10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			ret = -EINVAL;
 		else {
 			*size = sizeof(struct pp_gpu_power);
-			ret = vega10_get_gpu_power(hwmgr, (struct pp_gpu_power *)value);
+			ret = vega10_get_gpu_power(hwmgr, value);
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
index d44243441d28..4f832c607514 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
@@ -647,7 +647,7 @@ int tf_vega10_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr,
 int tf_vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		void *input, void *output, void *storage, int result)
 {
-	struct PP_TemperatureRange *range = (struct PP_TemperatureRange *)input;
+	struct PP_TemperatureRange *range = input;
 
 	if (range == NULL)
 		return -EINVAL;
-- 
2.11.0
