From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH 2/10] drm/amdgpu: Use ARRAY_SIZE macro
Date: Sun, 03 Sep 2017 14:19:31 +0200
Message-ID: <1504439110050-1389363803-2-diffsplit-thomas@m3y3r.de>
References: <1504439110050-939061377-0-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504439110050-939061377-0-diffsplit-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Use ARRAY_SIZE macro, rather than explicitly coding some variant of it
yourself.
Found with: find -type f -name "*.c" -o -name "*.h" | xargs perl -p -i -e
's/\bsizeof\s*\(\s*(\w+)\s*\)\s*\ /\s*sizeof\s*\(\s*\1\s*\[\s*0\s*\]\s*\)
/ARRAY_SIZE(\1)/g' and manual check/verification.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 9804318f3488..7ef84d884714 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -20,6 +20,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <linux/kernel.h>
+
 #include "amdgpu.h"
 #include "mmhub_v1_0.h"
 
@@ -268,7 +270,7 @@ const struct pctl_data pctl0_data[] = {
     {0x135, 0x12a810},
     {0x149, 0x7a82c}
 };
-#define PCTL0_DATA_LEN (sizeof(pctl0_data)/sizeof(pctl0_data[0]))
+#define PCTL0_DATA_LEN (ARRAY_SIZE(pctl0_data))
 
 #define PCTL0_RENG_EXEC_END_PTR 0x151
 #define PCTL0_STCTRL_REG_SAVE_RANGE0_BASE  0xa640
@@ -297,7 +299,7 @@ const struct pctl_data pctl1_data[] = {
     {0x1be, 0x17a7dd},
     {0x1d7, 0x12a810}
 };
-#define PCTL1_DATA_LEN (sizeof(pctl1_data)/sizeof(pctl1_data[0]))
+#define PCTL1_DATA_LEN (ARRAY_SIZE(pctl1_data))
 
 #define PCTL1_RENG_EXEC_END_PTR 0x1ea
 #define PCTL1_STCTRL_REG_SAVE_RANGE0_BASE  0xa000
