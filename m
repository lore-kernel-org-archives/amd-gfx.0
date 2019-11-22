From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/radeon: remove redundant assignment to variable ret
Date: Fri, 22 Nov 2019 23:15:04 +0000
Message-ID: <20191122231504.109948-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never
read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 8148a7883de4..346315b3eebe 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5899,7 +5899,7 @@ static int si_patch_single_dependency_table_based_on_leakage(struct radeon_devic
 
 static int si_patch_dependency_tables_based_on_leakage(struct radeon_device *rdev)
 {
-	int ret = 0;
+	int ret;
 
 	ret = si_patch_single_dependency_table_based_on_leakage(rdev,
 								&rdev->pm.dpm.dyn_state.vddc_dependency_on_sclk);
-- 
2.24.0
