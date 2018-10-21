From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/radeon/kms: remove set but not used variable 'pll'
Date: Sun, 21 Oct 2018 10:05:59 +0000
Message-ID: <1540116359-164086-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/radeon_legacy_tv.c: In function 'radeon_legacy_tv_init_restarts':
drivers/gpu/drm/radeon/radeon_legacy_tv.c:435:21: warning:
 variable 'pll' set but not used [-Wunused-but-set-variable]
  struct radeon_pll *pll;
  
It never used since introduction in commit
4ce001abafaf ("drm/radeon/kms: add initial radeon tv-out support.")
Also remove related variables 'dev, rdev, radeon_crtc'

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_legacy_tv.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_legacy_tv.c b/drivers/gpu/drm/radeon/radeon_legacy_tv.c
index 4278272..3dae2c4 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_tv.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_tv.c
@@ -421,24 +421,14 @@ static void radeon_legacy_write_tv_restarts(struct radeon_encoder *radeon_encode
 
 static bool radeon_legacy_tv_init_restarts(struct drm_encoder *encoder)
 {
-	struct drm_device *dev = encoder->dev;
-	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
 	struct radeon_encoder_tv_dac *tv_dac = radeon_encoder->enc_priv;
-	struct radeon_crtc *radeon_crtc;
 	int restart;
 	unsigned int h_total, v_total, f_total;
 	int v_offset, h_offset;
 	u16 p1, p2, h_inc;
 	bool h_changed;
 	const struct radeon_tv_mode_constants *const_ptr;
-	struct radeon_pll *pll;
-
-	radeon_crtc = to_radeon_crtc(radeon_encoder->base.crtc);
-	if (radeon_crtc->crtc_id == 1)
-		pll = &rdev->clock.p2pll;
-	else
-		pll = &rdev->clock.p1pll;
 
 	const_ptr = radeon_legacy_tv_get_std_mode(radeon_encoder, NULL);
 	if (!const_ptr)
