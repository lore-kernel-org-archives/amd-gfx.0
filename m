From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] GPU-DRM-Radeon: Use seq_puts() in
 radeon_debugfs_pm_info()
Date: Tue, 2 May 2017 22:08:10 +0200
Message-ID: <85bb0532-b548-b3cc-4482-ce7a161c7d32@users.sourceforge.net>
References: <74d2df52-f509-e6d2-5b35-e25b7cbd1fbe@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <74d2df52-f509-e6d2-5b35-e25b7cbd1fbe@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 May 2017 21:50:14 +0200

Two strings which did not contain data format specifications should be put
into a sequence. Thus use the corresponding function "seq_puts".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/radeon/radeon_pm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
index 326ad068c15a..f84ddcc426c1 100644
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -1869,13 +1869,14 @@ static int radeon_debugfs_pm_info(struct seq_file *m, void *data)
 
 	if  ((rdev->flags & RADEON_IS_PX) &&
 	     (ddev->switch_power_state != DRM_SWITCH_POWER_ON)) {
-		seq_printf(m, "PX asic powered off\n");
+		seq_puts(m, "PX asic powered off\n");
 	} else if (rdev->pm.dpm_enabled) {
 		mutex_lock(&rdev->pm.mutex);
 		if (rdev->asic->dpm.debugfs_print_current_performance_level)
 			radeon_dpm_debugfs_print_current_performance_level(rdev, m);
 		else
-			seq_printf(m, "Debugfs support not implemented for this asic\n");
+			seq_puts(m,
+				 "Debugfs support not implemented for this asic\n");
 		mutex_unlock(&rdev->pm.mutex);
 	} else {
 		seq_printf(m, "default engine clock: %u0 kHz\n", rdev->pm.default_sclk);
-- 
2.12.2

