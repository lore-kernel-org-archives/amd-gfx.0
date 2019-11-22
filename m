From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amd/powerplay: remove redundant assignment to variables HiSidd and LoSidd
Date: Fri, 22 Nov 2019 23:04:07 +0000
Message-ID: <20191122230407.109636-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The variables HiSidd and LoSidd are being initialized with values that
are never read and are being updated a little later with a new value.
The initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
index 15590fd86ef4..868e2d5f6e62 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -653,8 +653,8 @@ static int ci_min_max_v_gnbl_pm_lid_from_bapm_vddc(struct pp_hwmgr *hwmgr)
 static int ci_populate_bapm_vddc_base_leakage_sidd(struct pp_hwmgr *hwmgr)
 {
 	struct ci_smumgr *smu_data = (struct ci_smumgr *)(hwmgr->smu_backend);
-	uint16_t HiSidd = smu_data->power_tune_table.BapmVddCBaseLeakageHiSidd;
-	uint16_t LoSidd = smu_data->power_tune_table.BapmVddCBaseLeakageLoSidd;
+	uint16_t HiSidd;
+	uint16_t LoSidd;
 	struct phm_cac_tdp_table *cac_table = hwmgr->dyn_state.cac_dtp_table;
 
 	HiSidd = (uint16_t)(cac_table->usHighCACLeakage / 100 * 256);
-- 
2.24.0
