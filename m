From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: Remove duplicate
 header
Date: Mon, 19 Nov 2018 22:02:19 +0530
Message-ID: <20181119163219.GA26520@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Rex.Zhu@amd.com, andrey.grodzovsky@amd.com, leo.liu@amd.com, David.Panariti@amd.com, shirish.s@amd.com
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove gca/gfx_8_0_enum.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 3d0f277a6523..4ca1ecf1ffd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -44,7 +44,6 @@
 #include "gca/gfx_8_0_d.h"
 #include "gca/gfx_8_0_enum.h"
 #include "gca/gfx_8_0_sh_mask.h"
-#include "gca/gfx_8_0_enum.h"
 
 #include "dce/dce_10_0_d.h"
 #include "dce/dce_10_0_sh_mask.h"
-- 
2.17.1
