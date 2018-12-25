From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drm/i915_request.h: Remove duplicate header
Date: Tue, 25 Dec 2018 18:53:40 +0530
Message-ID: <20181225132340.GA2584@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove i915_scheduler.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/i915/i915_request.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_request.h b/drivers/gpu/drm/i915/i915_request.h
index 7fa94b024968..3d9d225bc5fc 100644
--- a/drivers/gpu/drm/i915/i915_request.h
+++ b/drivers/gpu/drm/i915/i915_request.h
@@ -30,7 +30,6 @@
 #include "i915_gem.h"
 #include "i915_scheduler.h"
 #include "i915_sw_fence.h"
-#include "i915_scheduler.h"
 
 #include <uapi/drm/i915_drm.h>
 
-- 
2.17.1
