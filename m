From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 3/7] drm/amdgpu: add function parameter description in 'amdgpu_gart_bind'
Date: Mon, 4 Nov 2019 21:27:22 +0800
Message-ID: <1572874046-30996-4-git-send-email-yukuai3@huawei.com>
References: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Jammy.Zhou@amd.com, tianci.yin@amd.com, sam@ravnborg.org, luben.tuikov@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:313: warning: Function
parameter or member 'flags' not described in 'amdgpu_gart_bind'

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 19705e3..e01e681 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -302,6 +302,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
  * @pages: number of pages to bind
  * @pagelist: pages to bind
  * @dma_addr: DMA addresses of pages
+ * @flags: page table entry flags
  *
  * Binds the requested pages to the gart page table
  * (all asics).
-- 
2.7.4
