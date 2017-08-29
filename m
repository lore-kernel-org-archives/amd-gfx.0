From: Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] drm/amd/powerplay/hwmgr: Remove null check before kfree
Date: Tue, 29 Aug 2017 18:42:27 +0530
Message-ID: <1504012347-14702-1-git-send-email-himanshujha199640@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Rex.Zhu@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

kfree on NULL pointer is a no-op and therefore checking is redundant.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     |  6 +-
 .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  | 96 ++++++++--------------
 drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c     | 52 ++++--------
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 12 +--
 4 files changed, 56 insertions(+), 110 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
index bc839ff..9f2c037 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
@@ -1225,10 +1225,8 @@ static int cz_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
 		phm_destroy_table(hwmgr, &(hwmgr->power_down_asic));
 		phm_destroy_table(hwmgr, &(hwmgr->setup_asic));
 
-		if (NULL != hwmgr->dyn_state.vddc_dep_on_dal_pwrl) {
-			kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
-			hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
-		}
+		kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
+		hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
 
 		kfree(hwmgr->backend);
 		hwmgr->backend = NULL;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
index 2716721..a6dbc55 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
@@ -1615,85 +1615,53 @@ static int pp_tables_uninitialize(struct pp_hwmgr *hwmgr)
 	if (hwmgr->chip_id == CHIP_RAVEN)
 		return 0;
 
-	if (NULL != hwmgr->dyn_state.vddc_dependency_on_sclk) {
-		kfree(hwmgr->dyn_state.vddc_dependency_on_sclk);
-		hwmgr->dyn_state.vddc_dependency_on_sclk = NULL;
-	}
+	kfree(hwmgr->dyn_state.vddc_dependency_on_sclk);
+	hwmgr->dyn_state.vddc_dependency_on_sclk = NULL;
 
-	if (NULL != hwmgr->dyn_state.vddci_dependency_on_mclk) {
-		kfree(hwmgr->dyn_state.vddci_dependency_on_mclk);
-		hwmgr->dyn_state.vddci_dependency_on_mclk = NULL;
-	}
+	kfree(hwmgr->dyn_state.vddci_dependency_on_mclk);
+	hwmgr->dyn_state.vddci_dependency_on_mclk = NULL;
 
-	if (NULL != hwmgr->dyn_state.vddc_dependency_on_mclk) {
-		kfree(hwmgr->dyn_state.vddc_dependency_on_mclk);
-		hwmgr->dyn_state.vddc_dependency_on_mclk = NULL;
-	}
+	kfree(hwmgr->dyn_state.vddc_dependency_on_mclk);
+	hwmgr->dyn_state.vddc_dependency_on_mclk = NULL;
 
-	if (NULL != hwmgr->dyn_state.mvdd_dependency_on_mclk) {
-		kfree(hwmgr->dyn_state.mvdd_dependency_on_mclk);
-		hwmgr->dyn_state.mvdd_dependency_on_mclk = NULL;
-	}
+	kfree(hwmgr->dyn_state.mvdd_dependency_on_mclk);
+	hwmgr->dyn_state.mvdd_dependency_on_mclk = NULL;
 
-	if (NULL != hwmgr->dyn_state.valid_mclk_values) {
-		kfree(hwmgr->dyn_state.valid_mclk_values);
-		hwmgr->dyn_state.valid_mclk_values = NULL;
-	}
+	kfree(hwmgr->dyn_state.valid_mclk_values);
+	hwmgr->dyn_state.valid_mclk_values = NULL;
 
-	if (NULL != hwmgr->dyn_state.valid_sclk_values) {
-		kfree(hwmgr->dyn_state.valid_sclk_values);
-		hwmgr->dyn_state.valid_sclk_values = NULL;
-	}
+	kfree(hwmgr->dyn_state.valid_sclk_values);
+	hwmgr->dyn_state.valid_sclk_values = NULL;
 
-	if (NULL != hwmgr->dyn_state.cac_leakage_table) {
-		kfree(hwmgr->dyn_state.cac_leakage_table);
-		hwmgr->dyn_state.cac_leakage_table = NULL;
-	}
+	kfree(hwmgr->dyn_state.cac_leakage_table);
+	hwmgr->dyn_state.cac_leakage_table = NULL;
 
-	if (NULL != hwmgr->dyn_state.vddc_phase_shed_limits_table) {
-		kfree(hwmgr->dyn_state.vddc_phase_shed_limits_table);
-		hwmgr->dyn_state.vddc_phase_shed_limits_table = NULL;
-	}
+	kfree(hwmgr->dyn_state.vddc_phase_shed_limits_table);
+	hwmgr->dyn_state.vddc_phase_shed_limits_table = NULL;
 
-	if (NULL != hwmgr->dyn_state.vce_clock_voltage_dependency_table) {
-		kfree(hwmgr->dyn_state.vce_clock_voltage_dependency_table);
-		hwmgr->dyn_state.vce_clock_voltage_dependency_table = NULL;
-	}
+	kfree(hwmgr->dyn_state.vce_clock_voltage_dependency_table);
+	hwmgr->dyn_state.vce_clock_voltage_dependency_table = NULL;
 
-	if (NULL != hwmgr->dyn_state.uvd_clock_voltage_dependency_table) {
-		kfree(hwmgr->dyn_state.uvd_clock_voltage_dependency_table);
-		hwmgr->dyn_state.uvd_clock_voltage_dependency_table = NULL;
-	}
+	kfree(hwmgr->dyn_state.uvd_clock_voltage_dependency_table);
+	hwmgr->dyn_state.uvd_clock_voltage_dependency_table = NULL;
 
-	if (NULL != hwmgr->dyn_state.samu_clock_voltage_dependency_table) {
-		kfree(hwmgr->dyn_state.samu_clock_voltage_dependency_table);
-		hwmgr->dyn_state.samu_clock_voltage_dependency_table = NULL;
-	}
+	kfree(hwmgr->dyn_state.samu_clock_voltage_dependency_table);
+	hwmgr->dyn_state.samu_clock_voltage_dependency_table = NULL;
 
-	if (NULL != hwmgr->dyn_state.acp_clock_voltage_dependency_table) {
-		kfree(hwmgr->dyn_state.acp_clock_voltage_dependency_table);
-		hwmgr->dyn_state.acp_clock_voltage_dependency_table = NULL;
-	}
+	kfree(hwmgr->dyn_state.acp_clock_voltage_dependency_table);
+	hwmgr->dyn_state.acp_clock_voltage_dependency_table = NULL;
 
-	if (NULL != hwmgr->dyn_state.cac_dtp_table) {
-		kfree(hwmgr->dyn_state.cac_dtp_table);
-		hwmgr->dyn_state.cac_dtp_table = NULL;
-	}
+	kfree(hwmgr->dyn_state.cac_dtp_table);
+	hwmgr->dyn_state.cac_dtp_table = NULL;
 
-	if (NULL != hwmgr->dyn_state.ppm_parameter_table) {
-		kfree(hwmgr->dyn_state.ppm_parameter_table);
-		hwmgr->dyn_state.ppm_parameter_table = NULL;
-	}
+	kfree(hwmgr->dyn_state.ppm_parameter_table);
+	hwmgr->dyn_state.ppm_parameter_table = NULL;
 
-	if (NULL != hwmgr->dyn_state.vdd_gfx_dependency_on_sclk) {
-		kfree(hwmgr->dyn_state.vdd_gfx_dependency_on_sclk);
-		hwmgr->dyn_state.vdd_gfx_dependency_on_sclk = NULL;
-	}
+	kfree(hwmgr->dyn_state.vdd_gfx_dependency_on_sclk);
+	hwmgr->dyn_state.vdd_gfx_dependency_on_sclk = NULL;
 
-	if (NULL != hwmgr->dyn_state.vq_budgeting_table) {
-		kfree(hwmgr->dyn_state.vq_budgeting_table);
-		hwmgr->dyn_state.vq_budgeting_table = NULL;
-	}
+	kfree(hwmgr->dyn_state.vq_budgeting_table);
+	hwmgr->dyn_state.vq_budgeting_table = NULL;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
index 2c3e6ba..5547ed3 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
@@ -640,40 +640,24 @@ static int rv_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
 	phm_destroy_table(hwmgr, &(hwmgr->power_down_asic));
 	phm_destroy_table(hwmgr, &(hwmgr->setup_asic));
 
-	if (pinfo->vdd_dep_on_dcefclk) {
-		kfree(pinfo->vdd_dep_on_dcefclk);
-		pinfo->vdd_dep_on_dcefclk = NULL;
-	}
-	if (pinfo->vdd_dep_on_socclk) {
-		kfree(pinfo->vdd_dep_on_socclk);
-		pinfo->vdd_dep_on_socclk = NULL;
-	}
-	if (pinfo->vdd_dep_on_fclk) {
-		kfree(pinfo->vdd_dep_on_fclk);
-		pinfo->vdd_dep_on_fclk = NULL;
-	}
-	if (pinfo->vdd_dep_on_dispclk) {
-		kfree(pinfo->vdd_dep_on_dispclk);
-		pinfo->vdd_dep_on_dispclk = NULL;
-	}
-	if (pinfo->vdd_dep_on_dppclk) {
-		kfree(pinfo->vdd_dep_on_dppclk);
-		pinfo->vdd_dep_on_dppclk = NULL;
-	}
-	if (pinfo->vdd_dep_on_phyclk) {
-		kfree(pinfo->vdd_dep_on_phyclk);
-		pinfo->vdd_dep_on_phyclk = NULL;
-	}
-
-	if (NULL != hwmgr->dyn_state.vddc_dep_on_dal_pwrl) {
-		kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
-		hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
-	}
-
-	if (NULL != hwmgr->dyn_state.vq_budgeting_table) {
-		kfree(hwmgr->dyn_state.vq_budgeting_table);
-		hwmgr->dyn_state.vq_budgeting_table = NULL;
-	}
+	kfree(pinfo->vdd_dep_on_dcefclk);
+	pinfo->vdd_dep_on_dcefclk = NULL;
+	kfree(pinfo->vdd_dep_on_socclk);
+	pinfo->vdd_dep_on_socclk = NULL;
+	kfree(pinfo->vdd_dep_on_fclk);
+	pinfo->vdd_dep_on_fclk = NULL;
+	kfree(pinfo->vdd_dep_on_dispclk);
+	pinfo->vdd_dep_on_dispclk = NULL;
+	kfree(pinfo->vdd_dep_on_dppclk);
+	pinfo->vdd_dep_on_dppclk = NULL;
+	kfree(pinfo->vdd_dep_on_phyclk);
+	pinfo->vdd_dep_on_phyclk = NULL;
+
+	kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
+	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
+
+	kfree(hwmgr->dyn_state.vq_budgeting_table);
+	hwmgr->dyn_state.vq_budgeting_table = NULL;
 
 	kfree(hwmgr->backend);
 	hwmgr->backend = NULL;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index c274323..eb8a3ff 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -2282,15 +2282,11 @@ static int smu7_set_private_data_based_on_pptable_v0(struct pp_hwmgr *hwmgr)
 
 static int smu7_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
 {
-	if (NULL != hwmgr->dyn_state.vddc_dep_on_dal_pwrl) {
-		kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
-		hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
-	}
+	kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
+	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
 	pp_smu7_thermal_fini(hwmgr);
-	if (NULL != hwmgr->backend) {
-		kfree(hwmgr->backend);
-		hwmgr->backend = NULL;
-	}
+	kfree(hwmgr->backend);
+	hwmgr->backend = NULL;
 
 	return 0;
 }
-- 
2.7.4
