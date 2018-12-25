From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drm/intel_dsi_vbt: Remove duplicate header
Date: Tue, 25 Dec 2018 19:00:56 +0530
Message-ID: <20181225133055.GA2628@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove video/mipi_display.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/i915/intel_dsi_vbt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_dsi_vbt.c b/drivers/gpu/drm/i915/intel_dsi_vbt.c
index ac83d6b89ae0..40a5efa33c3d 100644
--- a/drivers/gpu/drm/i915/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/intel_dsi_vbt.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 #include <video/mipi_display.h>
 #include <asm/intel-mid.h>
-#include <video/mipi_display.h>
 #include "i915_drv.h"
 #include "intel_drv.h"
 #include "intel_dsi.h"
-- 
2.17.1
