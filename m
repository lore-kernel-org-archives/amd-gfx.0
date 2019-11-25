From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/powerplay: remove set but not used variable 'stretch_amount2'
Date: Mon, 25 Nov 2019 22:58:43 +0800
Message-ID: <20191125145843.15764-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Prike.Liang@amd.com, yuehaibing@huawei.com, chenwandun@huawei.com, yukuai3@huawei.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:
 In function vegam_populate_clock_stretcher_data_table:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1489:29:
 warning: variable stretch_amount2 set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 50896e9..b0e0d67 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1486,7 +1486,7 @@ static int vegam_populate_clock_stretcher_data_table(struct pp_hwmgr *hwmgr)
 	struct vegam_smumgr *smu_data =
 			(struct vegam_smumgr *)(hwmgr->smu_backend);
 
-	uint8_t i, stretch_amount, stretch_amount2, volt_offset = 0;
+	uint8_t i, stretch_amount, volt_offset = 0;
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	struct phm_ppt_v1_clock_voltage_dependency_table *sclk_table =
@@ -1525,11 +1525,9 @@ static int vegam_populate_clock_stretcher_data_table(struct pp_hwmgr *hwmgr)
 			(table_info->cac_dtp_table->ucCKS_LDO_REFSEL != 0) ?
 			table_info->cac_dtp_table->ucCKS_LDO_REFSEL : 5;
 	/* Populate CKS Lookup Table */
-	if (stretch_amount == 1 || stretch_amount == 2 || stretch_amount == 5)
-		stretch_amount2 = 0;
-	else if (stretch_amount == 3 || stretch_amount == 4)
-		stretch_amount2 = 1;
-	else {
+	if (!(stretch_amount == 1 || stretch_amount == 2 ||
+	      stretch_amount == 5 || stretch_amount == 3 ||
+	      stretch_amount == 4)) {
 		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
 				PHM_PlatformCaps_ClockStretcher);
 		PP_ASSERT_WITH_CODE(false,
-- 
2.7.4
