From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove duplicated include from mmhub_v1_0.c
Date: Sun, 6 Oct 2019 07:44:04 +0000
Message-ID: <20191006074404.48416-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, le.ma@amd.com, Yong.Zhao@amd.com, Trigger.Huang@amd.com, tao.zhou1@amd.com, Hawking.Zhang@amd.com, Felix.Kuehling@amd.com
Cc: YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 4c7e8c64a94e..6965e1e6fa9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -31,7 +31,6 @@
 #include "vega10_enum.h"
 
 #include "soc15_common.h"
-#include "amdgpu_ras.h"
 
 #define mmDAGB0_CNTL_MISC2_RV 0x008f
 #define mmDAGB0_CNTL_MISC2_RV_BASE_IDX 0
