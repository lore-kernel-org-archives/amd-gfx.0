From: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: [PATCH] drm/amd/powerplay: Remove duplicate header
Date: Fri, 21 Dec 2018 14:48:54 +0530
Message-ID: <20181221091853.GA2319@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: rex.zhu@amd.com, evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Hawking.Zhang@amd.com, ray.huang@amd.com
Cc: jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove hwmgr_ppt.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
index e5a60aa44b5d..07d180ce4d18 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -28,7 +28,6 @@
 #include "hardwaremanager.h"
 #include "hwmgr_ppt.h"
 #include "ppatomctrl.h"
-#include "hwmgr_ppt.h"
 #include "power_state.h"
 #include "smu_helper.h"
 
-- 
2.17.1
