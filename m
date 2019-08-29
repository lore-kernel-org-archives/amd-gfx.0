From: Colin King <colin.king@canonical.com>
Subject: [PATCH][drm-next] drm/amdgpu: fix spelling mistake "jumpimng" -> "jumping"
Date: Thu, 29 Aug 2019 01:51:56 +0100
Message-ID: <20190829005156.26354-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a DRM_DEBUG_DRIVER debug message.
Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 86110e6095cc..8a32b5c93778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -257,7 +257,7 @@ static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
 	 * https://www.st.com/resource/en/datasheet/m24m02-dr.pdf sec. 5.1.2
 	 */
 	if ((curr_address & EEPROM_ADDR_MSB_MASK) != (next_address & EEPROM_ADDR_MSB_MASK)) {
-		DRM_DEBUG_DRIVER("Reached end of EEPROM memory page, jumpimng to next: %lx",
+		DRM_DEBUG_DRIVER("Reached end of EEPROM memory page, jumping to next: %lx",
 				(next_address & EEPROM_ADDR_MSB_MASK));
 
 		return  (next_address & EEPROM_ADDR_MSB_MASK);
-- 
2.20.1
