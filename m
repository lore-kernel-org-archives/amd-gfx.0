From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 15/87] gpu: drm: Remove call to memset after kzalloc in process_pptable_v1_0.c
Date: Fri, 28 Jun 2019 01:40:10 +0800
Message-ID: <20190627174012.4062-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

kzalloc has already zeroes the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
 1 file changed, 2 deletions(-)

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
-- 
2.11.0
