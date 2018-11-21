From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drm/amd/amdgpu: Remove duplicate header
Date: Wed, 21 Nov 2018 19:21:52 +0530
Message-ID: <20181121135151.GA2536@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, andrey.grodzovsky@amd.com, Pixel.Ding@amd.com, Monk.Liu@amd.com
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove gca/gfx_8_0_sh_mask.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 64e875d528dd..6a0fcd67662a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -37,7 +37,6 @@
 #include "gmc/gmc_8_2_sh_mask.h"
 #include "oss/oss_3_0_d.h"
 #include "oss/oss_3_0_sh_mask.h"
-#include "gca/gfx_8_0_sh_mask.h"
 #include "dce/dce_10_0_d.h"
 #include "dce/dce_10_0_sh_mask.h"
 #include "smu/smu_7_1_3_d.h"
-- 
2.17.1
