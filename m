From: Umang Raghuvanshi <u@umangis.me>
Subject: [PATCH] drm/radeon: Fix GPU lockups for the R7 M270
Date: Sat, 11 Mar 2017 21:51:13 +0530
Message-ID: <20170311162113.7497-1-u@umangis.me>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Umang Raghuvanshi <u@umangis.me>
List-Id: amd-gfx.lists.freedesktop.org

Commit 3a69adfe5617 ("drm/radeon: drop oland quirks") removed
quirks for Oland but also caused a regression where M270 GPUs
would go into a lock-up when OpenGL intensive applications were used.
This reverts the change only for the M270 and fixes the lock-ups.

Signed-off-by: Umang Raghuvanshi <u@umangis.me>
---
 drivers/gpu/drm/radeon/si_dpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index d12b8978142f..c2c129eef3c4 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2984,6 +2984,11 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
 		    (rdev->pdev->device == 0x6667)) {
 			max_sclk = 75000;
 		}
+	} else if (rdev->family == CHIP_OLAND && rdev->pdev->device == 0x6604 &&
+		   rdev->pdev->revision == 0) {
+		// Fix max_sclk and max_mclk for the Radeon R7 M270
+		max_sclk = 75000;
+		max_mclk = 80000;
 	}
 
 	if (rps->vce_active) {
-- 
2.12.0
