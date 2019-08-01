From: Colin King <colin.king@canonical.com>
Subject: [PATCH][drm-next] drm/amd/powerplay: fix a few spelling mistakes
Date: Thu,  1 Aug 2019 09:39:41 +0100
Message-ID: <20190801083941.4230-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

There are a few spelling mistakes "unknow" -> "unknown" and
"enabeld" -> "enabled". Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 13b2c8a60232..d029a99e600e 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -39,7 +39,7 @@ static const char* __smu_message_names[] = {
 const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
 {
 	if (type < 0 || type > SMU_MSG_MAX_COUNT)
-		return "unknow smu message";
+		return "unknown smu message";
 	return __smu_message_names[type];
 }
 
@@ -52,7 +52,7 @@ static const char* __smu_feature_names[] = {
 const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
 {
 	if (feature < 0 || feature > SMU_FEATURE_COUNT)
-		return "unknow smu feature";
+		return "unknown smu feature";
 	return __smu_feature_names[feature];
 }
 
@@ -79,7 +79,7 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 			       count++,
 			       smu_get_feature_name(smu, i),
 			       feature_index,
-			       !!smu_feature_is_enabled(smu, i) ? "enabeld" : "disabled");
+			       !!smu_feature_is_enabled(smu, i) ? "enabled" : "disabled");
 	}
 
 failed:
-- 
2.20.1
