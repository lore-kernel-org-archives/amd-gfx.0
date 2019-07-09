From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/amdgpu: Fix build without CONFIG_HMM_MIRROR
Date: Tue, 9 Jul 2019 17:10:48 +0800
Message-ID: <20190709091048.35260-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Philip.Yang@amd.com, Felix.Kuehling@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

If CONFIG_HMM_MIRROR is not set, building may fails:

In file included from drivers/gpu/drm/amd/amdgpu/amdgpu.h:72:0,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:40:
drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h:69:20: error: field mirror has incomplete type
  struct hmm_mirror mirror;

Fixes: 7590f6d211ec ("drm/amdgpu: Prepare for hmm_range_register API change")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
index 281fd9f..b14f175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -65,8 +65,10 @@ struct amdgpu_mn {
 	struct rw_semaphore	lock;
 	struct rb_root_cached	objects;
 
+#if defined(CONFIG_HMM_MIRROR)
 	/* HMM mirror */
 	struct hmm_mirror	mirror;
+#endif
 };
 
 #if defined(CONFIG_HMM_MIRROR)
-- 
2.7.4
