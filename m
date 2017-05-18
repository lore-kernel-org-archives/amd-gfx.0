From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] drm/amd: include <linux/delay.h> instead of "linux/delay.h"
Date: Thu, 18 May 2017 13:43:32 +0900
Message-ID: <1495082612-10385-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
Cc: linux-kernel@vger.kernel.org, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: amd-gfx.lists.freedesktop.org

Use <...> notation to include headers located in include/linux.
While we are here, tweak the includes order a bit to sort them
alphabetically.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        | 4 ++--
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_acpi.c      | 2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 4 ++--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 5 +++--
 drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c   | 8 +++++---
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c      | 5 +++--
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index ff4ae3d..963a9e0 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -22,10 +22,10 @@
  */
 
 #include "pp_debug.h"
-#include "linux/delay.h"
-#include <linux/types.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/types.h>
 #include <drm/amdgpu_drm.h>
 #include "cgs_common.h"
 #include "power_state.h"
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_acpi.c b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_acpi.c
index f5e8fda..f6b4dd9 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_acpi.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_acpi.c
@@ -21,8 +21,8 @@
  *
  */
 
+#include <linux/delay.h>
 #include <linux/errno.h>
-#include "linux/delay.h"
 #include "hwmgr.h"
 #include "amd_acpi.h"
 #include "pp_acpi.h"
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 8f663ab..581374d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -21,11 +21,11 @@
  *
  */
 #include "pp_debug.h"
+#include <linux/delay.h>
+#include <linux/fb.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/fb.h>
 #include <asm/div64.h>
-#include "linux/delay.h"
 #include "pp_acpi.h"
 #include "ppatomctrl.h"
 #include "atombios.h"
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 8394955..f4ab81b 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -20,10 +20,11 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+
+#include <linux/delay.h>
+#include <linux/fb.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/fb.h>
-#include "linux/delay.h"
 
 #include "hwmgr.h"
 #include "amd_powerplay.h"
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
index 1f6744a..39c7091 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
@@ -20,11 +20,13 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-#include <linux/types.h>
+
+#include <linux/delay.h>
+#include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/gfp.h>
-#include "linux/delay.h"
+#include <linux/types.h>
+
 #include "cgs_common.h"
 #include "smu/smu_8_0_d.h"
 #include "smu/smu_8_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
index c0d7576..2e954a4 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
@@ -20,15 +20,16 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-#include <linux/types.h>
+
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/types.h>
 #include <drm/amdgpu_drm.h>
 #include "pp_instance.h"
 #include "smumgr.h"
 #include "cgs_common.h"
-#include "linux/delay.h"
 
 MODULE_FIRMWARE("amdgpu/topaz_smc.bin");
 MODULE_FIRMWARE("amdgpu/topaz_k_smc.bin");
-- 
2.7.4
