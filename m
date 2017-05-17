From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] gpu: drm: radeon: refactor code
Date: Tue, 16 May 2017 21:20:12 -0500
Message-ID: <20170517022012.GA11913@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Local variable _color_ is assigned to a constant value and it is
never updated again. Remove this variable and refactor the code it
affects.

Addresses-Coverity-ID: 1226745
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
index 222a1fa..7235d0c 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
@@ -640,7 +640,6 @@ static enum drm_connector_status radeon_legacy_primary_dac_detect(struct drm_enc
 	uint32_t vclk_ecp_cntl, crtc_ext_cntl;
 	uint32_t dac_ext_cntl, dac_cntl, dac_macro_cntl, tmp;
 	enum drm_connector_status found = connector_status_disconnected;
-	bool color = true;
 
 	/* just don't bother on RN50 those chip are often connected to remoting
 	 * console hw and often we get failure to load detect those. So to make
@@ -665,12 +664,7 @@ static enum drm_connector_status radeon_legacy_primary_dac_detect(struct drm_enc
 	WREG32(RADEON_CRTC_EXT_CNTL, tmp);
 
 	tmp = RADEON_DAC_FORCE_BLANK_OFF_EN |
-		RADEON_DAC_FORCE_DATA_EN;
-
-	if (color)
-		tmp |= RADEON_DAC_FORCE_DATA_SEL_RGB;
-	else
-		tmp |= RADEON_DAC_FORCE_DATA_SEL_G;
+		RADEON_DAC_FORCE_DATA_EN | RADEON_DAC_FORCE_DATA_SEL_RGB;
 
 	if (ASIC_IS_R300(rdev))
 		tmp |= (0x1b6 << RADEON_DAC_FORCE_DATA_SHIFT);
-- 
2.5.0
