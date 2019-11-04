From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 2/7] drm/amdgpu: add function parameter description in 'amdgpu_device_set_cg_state'
Date: Mon, 4 Nov 2019 21:27:21 +0800
Message-ID: <1572874046-30996-3-git-send-email-yukuai3@huawei.com>
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

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1954: warning: Function
parameter or member 'state' not described in 'amdgpu_device_set_cg_state'

Fixes: e3ecdffac9cc ("drm/amdgpu: add documentation for amdgpu_device.c")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b4fb6d8..26c43e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1941,6 +1941,7 @@ static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
  * amdgpu_device_set_cg_state - set clockgating for amdgpu device
  *
  * @adev: amdgpu_device pointer
+ * @state: clockgating state (gate or ungate)
  *
  * The list of all the hardware IPs that make up the asic is walked and the
  * set_clockgating_state callbacks are run.
-- 
2.7.4
