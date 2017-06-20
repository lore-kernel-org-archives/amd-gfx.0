From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/radeon: add a PX quirk for another K53TK variant
Date: Tue, 20 Jun 2017 13:25:14 -0400
Message-ID: <1497979515-2542-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Disable PX on these systems.

bug: https://bugs.freedesktop.org/show_bug.cgi?id=101491
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 6ecf427..0a6444d 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -136,6 +136,10 @@ static struct radeon_px_quirk radeon_px_quirk_list[] = {
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=51381
 	 */
 	{ PCI_VENDOR_ID_ATI, 0x6840, 0x1043, 0x2122, RADEON_PX_QUIRK_DISABLE_PX },
+	/* Asus K53TK laptop with AMD A6-3420M APU and Radeon 7670m GPU
+	 * https://bugs.freedesktop.org/show_bug.cgi?id=101491
+	 */
+	{ PCI_VENDOR_ID_ATI, 0x6741, 0x1043, 0x2122, RADEON_PX_QUIRK_DISABLE_PX },
 	/* macbook pro 8.2 */
 	{ PCI_VENDOR_ID_ATI, 0x6741, PCI_VENDOR_ID_APPLE, 0x00e2, RADEON_PX_QUIRK_LONG_WAKEUP },
 	{ 0, 0, 0, 0, 0 },
-- 
2.5.5
