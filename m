From: Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] drm/amd: fix hotplug race at startup
Date: Fri, 14 Jun 2019 19:29:23 +0800
Message-ID: <1560511763-2140-1-git-send-email-92siuyang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Young Xiao <92siuyang@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

We should check mode_config_initialized flag in amdgpu_hotplug_work_func.

See commit 7f98ca454ad3 ("drm/radeon: fix hotplug race at startup") for details.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index af4c3b1..13186d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -85,6 +85,9 @@ static void amdgpu_hotplug_work_func(struct work_struct *work)
 	struct drm_mode_config *mode_config = &dev->mode_config;
 	struct drm_connector *connector;
 
+	if (!adev->mode_info.mode_config_initialized)
+		return;
+
 	mutex_lock(&mode_config->mutex);
 	list_for_each_entry(connector, &mode_config->connector_list, head)
 		amdgpu_connector_hotplug(connector);
-- 
2.7.4
