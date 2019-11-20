From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH] drm/amd/display: make various variable in fixed31_32.h 'global' instead of 'static'
Date: Wed, 20 Nov 2019 21:15:33 +0800
Message-ID: <20191120131533.12720-3-yukuai3@huawei.com>
References: <20191120131533.12720-1-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191120131533.12720-1-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Jammy.Zhou@amd.com, tianci.yin@amd.com, sam@ravnborg.org, luben.tuikov@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

fixed31_32.h declare various variables 'static const', it's very ugly and
waste of memory.

All files that including the header file will have a copy of those
variables of their own. And that's the reason why there will be numerous
gcc '-Wunused-but-set-variable' warnings related to the variables.

Fix it by initializing the variables in a new file "fixed31_32.c", and
declare them 'extern' in "fixed31_32.h".

Fixes: eb0e515464e4 ("drm/amd/display: get rid of 32.32 unsigned fixed point")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---

BTW, this is the best I can think of, there may be better sulotion.

 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/fixed31_32.c  | 17 +++++++++++++++++
 .../gpu/drm/amd/display/include/fixed31_32.h    | 16 ++++++++--------
 3 files changed, 26 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/fixed31_32.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 9a3b7bf8ab0b..8ce291a0279b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -25,7 +25,7 @@
 
 
 
-AMDGPUDM = amdgpu_dm.o amdgpu_dm_irq.o amdgpu_dm_mst_types.o amdgpu_dm_color.o
+AMDGPUDM = amdgpu_dm.o amdgpu_dm_irq.o amdgpu_dm_mst_types.o amdgpu_dm_color.o fixed31_32.o
 
 ifneq ($(CONFIG_DRM_AMD_DC),)
 AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/fixed31_32.c b/drivers/gpu/drm/amd/display/amdgpu_dm/fixed31_32.c
new file mode 100644
index 000000000000..1f51587e342b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/fixed31_32.c
@@ -0,0 +1,17 @@
+/*
+ * Author: yu kuai <yukuai3@huawei.com>
+ */
+
+struct fixed31_32 {
+	long long value;
+};
+
+const struct fixed31_32 dc_fixpt_zero = { 0 };
+const struct fixed31_32 dc_fixpt_epsilon = { 1LL };
+const struct fixed31_32 dc_fixpt_half = { 0x80000000LL };
+const struct fixed31_32 dc_fixpt_one = { 0x100000000LL };
+
+const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
+const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
+const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
+
diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/gpu/drm/amd/display/include/fixed31_32.h
index 291215362e3f..d8dbe96f9b19 100644
--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -64,14 +64,14 @@ struct fixed31_32 {
  * Useful constants
  */
 
-static const struct fixed31_32 dc_fixpt_zero = { 0 };
-static const struct fixed31_32 dc_fixpt_epsilon = { 1LL };
-static const struct fixed31_32 dc_fixpt_half = { 0x80000000LL };
-static const struct fixed31_32 dc_fixpt_one = { 0x100000000LL };
-
-static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
-static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
-static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
+extern const struct fixed31_32 dc_fixpt_zero;
+extern const struct fixed31_32 dc_fixpt_epsilon;
+extern const struct fixed31_32 dc_fixpt_half;
+extern const struct fixed31_32 dc_fixpt_one;
+
+extern const struct fixed31_32 dc_fixpt_two_pi;
+extern const struct fixed31_32 dc_fixpt_ln2;
+extern const struct fixed31_32 dc_fixpt_ln2_div_2;
 
 /*
  * @brief
-- 
2.17.2
