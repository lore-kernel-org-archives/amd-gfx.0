From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove duplicated include from gfx_v9_0.c
Date: Wed, 10 Jul 2019 01:57:20 +0000
Message-ID: <20190710015720.107326-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Feifei.Xu@amd.com, Likun.Gao@amd.com, James.Zhu@amd.com, shirish.s@amd.com, evan.quan@amd.com, ray.huang@amd.com, Rex.Zhu@amd.com
Cc: YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5ba332376710..822f45161240 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -39,7 +39,6 @@
 #include "vega10_enum.h"
 #include "hdp/hdp_4_0_offset.h"
 
-#include "soc15.h"
 #include "soc15_common.h"
 #include "clearstate_gfx9.h"
 #include "v9_structs.h"
