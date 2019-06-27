From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 14/87] gpu: amd: Remove call to memset after kzalloc
Date: Fri, 28 Jun 2019 01:35:52 +0800
Message-ID: <20190627173553.2561-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, David Francis <David.Francis@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

kzalloc already zerored the memory.
so memset is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 2 --
 1 file changed, 2 deletions(-)

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
-- 
2.11.0
