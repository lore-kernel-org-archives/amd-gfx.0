From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/display: Remove useless set memory to zero use memset()
Date: Sat, 23 Mar 2019 21:30:19 +0800
Message-ID: <20190323133019.13620-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, mikita.lipski@amd.com, David.Francis@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

From: YueHaibing <yuehaibing@huawei.com>

The memory return by kzalloc() has already be set to zero, so
remove useless memset(0).

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index cd10f77..6c7a46a 100644
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
2.7.0
