From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 5/5] drm/radeon: narrow asic_init for virtualization
Date: Mon, 19 Sep 2016 13:12:41 -0400
Message-ID: <1474305161-11435-5-git-send-email-alexander.deucher@amd.com>
References: <1474305161-11435-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1474305161-11435-1-git-send-email-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Only needed on CIK+ due to the way pci reset is handled
by the GPU.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/radeon_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index bbc8958..eb92aef4 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -661,8 +661,9 @@ bool radeon_card_posted(struct radeon_device *rdev)
 {
 	uint32_t reg;
 
-	/* for pass through, always force asic_init */
-	if (radeon_device_is_virtual())
+	/* for pass through, always force asic_init for CI */
+	if (rdev->family >= CHIP_BONAIRE &&
+	    radeon_device_is_virtual())
 		return false;
 
 	/* required for EFI mode on macbook2,1 which uses an r5xx asic */
-- 
2.5.5
