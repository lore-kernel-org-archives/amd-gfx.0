From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 18/87] gpu: drm: Remove call to memset after kzalloc in tonga_smumgr.c
Date: Fri, 28 Jun 2019 01:36:38 +0800
Message-ID: <20190627173639.2779-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>, Colin Ian King <colin.king@canonical.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

kzalloc has already zeroes the memory.
So memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c | 2 --
 1 file changed, 2 deletions(-)

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
