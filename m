From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amdgpu/powerplay: remove redundant assignment to variable baco_state
Date: Thu, 22 Aug 2019 14:09:48 +0100
Message-ID: <20190822130948.32195-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

Variable baco_state is initialized to a value that is never read and it is
re-assigned later. The initialization is redundant and can be removed.

Addresses-Coverity: ("Unused Value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 89749b1d2019..a4aba8576900 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1656,7 +1656,7 @@ static bool smu_v11_0_baco_is_support(struct smu_context *smu)
 static enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	enum smu_baco_state baco_state = SMU_BACO_STATE_EXIT;
+	enum smu_baco_state baco_state;
 
 	mutex_lock(&smu_baco->mutex);
 	baco_state = smu_baco->state;
-- 
2.20.1
