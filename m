From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drm/amd/display/amdgpu_dm/amdgpu_dm.c: Remove duplicate
 header
Date: Wed, 21 Nov 2018 12:55:08 +0530
Message-ID: <20181121072508.GA2948@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Tony.Cheng@amd.com, mikita.lipski@amd.com, shirish.s@amd.com, Bhawanpreet.Lakha@amd.com, David.Francis@amd.com, Anthony.Koo@amd.com
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove dm_services_types.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e224f23e2215..62a96c683584 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -38,7 +38,6 @@
 #include "amd_shared.h"
 #include "amdgpu_dm_irq.h"
 #include "dm_helpers.h"
-#include "dm_services_types.h"
 #include "amdgpu_dm_mst_types.h"
 #if defined(CONFIG_DEBUG_FS)
 #include "amdgpu_dm_debugfs.h"
-- 
2.17.1
