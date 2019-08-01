From: Colin King <colin.king@canonical.com>
Subject: [PATCH][drm-next] drm/amd/powerplay: fix off-by-one upper bounds limit checks
Date: Thu,  1 Aug 2019 12:15:41 +0100
Message-ID: <20190801111541.13627-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Wang <kevin1.wang@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

There are two occurrances of off-by-one upper bound checking of indexes
causing potential out-of-bounds array reads. Fix these.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: cb33363d0e85 ("drm/amd/powerplay: add smu feature name support")
Fixes: 6b294793e384 ("drm/amd/powerplay: add smu message name support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d029a99e600e..b64113740eb5 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -38,7 +38,7 @@ static const char* __smu_message_names[] = {
 
 const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
 {
-	if (type < 0 || type > SMU_MSG_MAX_COUNT)
+	if (type < 0 || type >= SMU_MSG_MAX_COUNT)
 		return "unknown smu message";
 	return __smu_message_names[type];
 }
@@ -51,7 +51,7 @@ static const char* __smu_feature_names[] = {
 
 const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
 {
-	if (feature < 0 || feature > SMU_FEATURE_COUNT)
+	if (feature < 0 || feature >= SMU_FEATURE_COUNT)
 		return "unknown smu feature";
 	return __smu_feature_names[feature];
 }
-- 
2.20.1
