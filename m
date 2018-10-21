From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/powerplay: remove duplicated includes
Date: Sun, 21 Oct 2018 18:39:58 +0800
Message-ID: <20181021103958.12892-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rex.zhu@amd.com, evan.quan@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Hawking.Zhang@amd.com, ray.huang@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Remove some duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h               | 1 -
 drivers/gpu/drm/amd/powerplay/inc/smu7_common.h         | 4 ----
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 -
 drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c     | 1 -
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c     | 1 -
 5 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
index e5a60aa..07d180ce 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -28,7 +28,6 @@
 #include "hardwaremanager.h"
 #include "hwmgr_ppt.h"
 #include "ppatomctrl.h"
-#include "hwmgr_ppt.h"
 #include "power_state.h"
 #include "smu_helper.h"
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h b/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h
index 65eb630..94bf7b6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h
@@ -40,10 +40,6 @@
 #include "bif/bif_5_0_d.h"
 #include "bif/bif_5_0_sh_mask.h"
 
-
-#include "bif/bif_5_0_d.h"
-#include "bif/bif_5_0_sh_mask.h"
-
 #include "dce/dce_10_0_d.h"
 #include "dce/dce_10_0_sh_mask.h"
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 872d382..2b2c266 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -44,7 +44,6 @@
 
 #include "smu7_hwmgr.h"
 #include "hardwaremanager.h"
-#include "ppatomctrl.h"
 #include "atombios.h"
 #include "pppcielanes.h"
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
index d0eb8ab..d111dd4 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
@@ -29,7 +29,6 @@
 #include "rv_ppsmc.h"
 #include "smu10_driver_if.h"
 #include "smu10.h"
-#include "ppatomctrl.h"
 #include "pp_debug.h"
 
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 9f71512..1e69300 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -40,7 +40,6 @@
 
 #include "smu7_hwmgr.h"
 #include "hardwaremanager.h"
-#include "ppatomctrl.h"
 #include "atombios.h"
 #include "pppcielanes.h"
 
-- 
1.8.3.1
