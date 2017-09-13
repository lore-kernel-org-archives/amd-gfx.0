From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH] drivers:gpu:Use ARRAY_SIZE() for the size calculation of the array.
Date: Wed, 13 Sep 2017 13:31:09 +0530
Message-ID: <1505289669-25972-1-git-send-email-allen.lkml@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Allen Pais <allen.lkml@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 4395a4f..0487936 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -274,7 +274,7 @@ static const struct pctl_data pctl0_data[] = {
 	{0x135, 0x12a810},
 	{0x149, 0x7a82c}
 };
-#define PCTL0_DATA_LEN (sizeof(pctl0_data)/sizeof(pctl0_data[0]))
+#define PCTL0_DATA_LEN (ARRAY_SIZE(pctl0_data))
 
 #define PCTL0_RENG_EXEC_END_PTR 0x151
 #define PCTL0_STCTRL_REG_SAVE_RANGE0_BASE  0xa640
@@ -310,7 +310,7 @@ static const struct pctl_data pctl1_data[] = {
 	{0x1f0, 0x5000a7f6},
 	{0x1f1, 0x5000a7e4}
 };
-#define PCTL1_DATA_LEN (sizeof(pctl1_data)/sizeof(pctl1_data[0]))
+#define PCTL1_DATA_LEN (ARRAY_SIZE(pctl1_data))
 
 #define PCTL1_RENG_EXEC_END_PTR 0x1f1
 #define PCTL1_STCTRL_REG_SAVE_RANGE0_BASE  0xa000
-- 
2.7.4
