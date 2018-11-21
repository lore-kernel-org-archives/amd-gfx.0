From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drm/amd/amdgpu/vce_v3_0.c: Remove duplicate header
Date: Wed, 21 Nov 2018 12:41:03 +0530
Message-ID: <20181121071103.GA2622@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Jerry.Zhang@amd.com, leo.liu@amd.com, andrey.grodzovsky@amd.com, Emily.Deng@amd.com, Rex.Zhu@amd.com
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove gca/gfx_8_0_d.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6dbd39730070..4e4289a06a53 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -37,7 +37,6 @@
 #include "gca/gfx_8_0_d.h"
 #include "smu/smu_7_1_2_d.h"
 #include "smu/smu_7_1_2_sh_mask.h"
-#include "gca/gfx_8_0_d.h"
 #include "gca/gfx_8_0_sh_mask.h"
 #include "ivsrcid/ivsrcid_vislands30.h"
 
-- 
2.17.1
