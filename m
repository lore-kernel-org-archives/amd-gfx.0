From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drm/amd/amdkfd: Remove duplicate header
Date: Thu, 22 Nov 2018 19:37:14 +0530
Message-ID: <20181122140714.GA3219@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: oded.gabbay@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove gca/gfx_8_0_enum.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
index fd60a116be37..c3a5dcfe877a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
@@ -24,7 +24,6 @@
 #include "kfd_device_queue_manager.h"
 #include "gca/gfx_8_0_enum.h"
 #include "gca/gfx_8_0_sh_mask.h"
-#include "gca/gfx_8_0_enum.h"
 #include "oss/oss_3_0_sh_mask.h"
 
 static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
-- 
2.17.1
