From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 07/27] gpu: drm: remove memset after zalloc
Date: Fri, 28 Jun 2019 10:46:54 +0800
Message-ID: <20190628024700.15141-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, David Francis <David.Francis@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, Huang Rui <ray.huang@amd.com>, Colin Ian King <colin.king@canonical.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

zalloc has already zeroed the memory.
so memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c       | 2 --
 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c            | 2 --
 drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c       | 2 --
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c         | 2 --
 5 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index fd22b4474dbf..4e6da61d1a93 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -279,8 +279,6 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
 		return DAL_INVALID_IRQ_HANDLER_IDX;
 	}
 
-	memset(handler_data, 0, sizeof(*handler_data));
-
 	init_handler_common_data(handler_data, ih, handler_args, &adev->dm);
 
 	irq_source = int_params->irq_source;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
index ae64ff7153d6..eb7757443bdd 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
@@ -1065,8 +1065,6 @@ static int pp_tables_v1_0_initialize(struct pp_hwmgr *hwmgr)
 	PP_ASSERT_WITH_CODE((NULL != hwmgr->pptable),
 			    "Failed to allocate hwmgr->pptable!", return -ENOMEM);
 
-	memset(hwmgr->pptable, 0x00, sizeof(struct phm_ppt_v1_information));
-
 	powerplay_table = get_powerplay_table(hwmgr);
 
 	PP_ASSERT_WITH_CODE((NULL != powerplay_table),
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
index 669bd0c2a16c..d55e264c5df5 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2702,8 +2702,6 @@ static int ci_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
 	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS2_LP, cgs_read_register(hwmgr->device, mmMC_PMG_CMD_MRS2));
 	cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP, cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
 
-	memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
-
 	result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
 
 	if (0 == result)
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index 375ccf6ff5f2..c123b4d9c621 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -2631,8 +2631,6 @@ static int iceland_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
 	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS2_LP, cgs_read_register(hwmgr->device, mmMC_PMG_CMD_MRS2));
 	cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP, cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
 
-	memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
-
 	result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
 
 	if (0 == result)
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
index 3ed6c5f1e5cf..60462c7211e3 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -3114,8 +3114,6 @@ static int tonga_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
 	cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP,
 			cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
 
-	memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
-
 	result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
 
 	if (!result)
-- 
2.11.0
