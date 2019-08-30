From: Yizhuo <yzhai003@ucr.edu>
Subject: [PATCH] drm/amd/powerplay: Variable ps could be NULL when it get dereferenced
Date: Thu, 29 Aug 2019 21:35:04 -0700
Message-ID: <20190830043504.23760-1-yzhai003@ucr.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Inside function cz_get_performance_level(), pointer ps could be NULL via
cast_const_PhwCzPowerState(). However, this pointer is dereferenced
without any check, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
index bc839ff0bdd0..d2628e7b612d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
@@ -1799,6 +1799,9 @@ static int cz_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_hw_p
 	data = (struct cz_hwmgr *)(hwmgr->backend);
 	ps = cast_const_PhwCzPowerState(state);
 
+	if (!ps)
+		return -EINVAL;
+
 	level_index = index > ps->level - 1 ? ps->level - 1 : index;
 	level->coreClock = ps->levels[level_index].engineClock;
 
-- 
2.17.1
