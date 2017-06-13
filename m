From: Mario Kleiner <mario.kleiner.de@gmail.com>
Subject: [PATCH 2/2] drm/radeon: Fix overflow of watermark calcs at > 4k resolutions.
Date: Tue, 13 Jun 2017 07:17:11 +0200
Message-ID: <20170613051711.16372-2-mario.kleiner.de@gmail.com>
References: <20170613051711.16372-1-mario.kleiner.de@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170613051711.16372-1-mario.kleiner.de@gmail.com>
Sender: stable-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, mario.kleiner.de@gmail.com, Ben Hutchings <ben.hutchings@codethink.co.uk>, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Commit e6b9a6c84b93
("drm/radeon: Make display watermark calculations more accurate")
made watermark calculations more accurate, but not for > 4k
resolutions on 32-Bit architectures, as it introduced an integer
overflow for those setups and resolutions.

Fix this by proper u64 casting and division.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Fixes: e6b9a6c84b93 ("drm/radeon: Make display watermark calculations more accurate")
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/cik.c       | 7 +++++--
 drivers/gpu/drm/radeon/evergreen.c | 7 +++++--
 drivers/gpu/drm/radeon/si.c        | 7 +++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 2589121..667c21a 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9267,8 +9267,11 @@ static void dce8_program_watermarks(struct radeon_device *rdev,
 	u32 tmp, wm_mask;
 
 	if (radeon_crtc->base.enabled && num_heads && mode) {
-		active_time = 1000000UL * (u32)mode->crtc_hdisplay / (u32)mode->clock;
-		line_time = min((u32) (1000000UL * (u32)mode->crtc_htotal / (u32)mode->clock), (u32)65535);
+		active_time = (u32) div_u64((u64)mode->crtc_hdisplay * 1000000,
+					    (u32)mode->clock);
+		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
+					  (u32)mode->clock);
+		line_time = min(line_time, (u32)65535);
 
 		/* watermark for high clocks */
 		if ((rdev->pm.pm_method == PM_METHOD_DPM) &&
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 0bf1035..5346372 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -2266,8 +2266,11 @@ static void evergreen_program_watermarks(struct radeon_device *rdev,
 	fixed20_12 a, b, c;
 
 	if (radeon_crtc->base.enabled && num_heads && mode) {
-		active_time = 1000000UL * (u32)mode->crtc_hdisplay / (u32)mode->clock;
-		line_time = min((u32) (1000000UL * (u32)mode->crtc_htotal / (u32)mode->clock), (u32)65535);
+		active_time = (u32) div_u64((u64)mode->crtc_hdisplay * 1000000,
+					    (u32)mode->clock);
+		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
+					  (u32)mode->clock);
+		line_time = min(line_time, (u32)65535);
 		priority_a_cnt = 0;
 		priority_b_cnt = 0;
 		dram_channels = evergreen_get_number_of_dram_channels(rdev);
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 76d1888..5303f25 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -2284,8 +2284,11 @@ static void dce6_program_watermarks(struct radeon_device *rdev,
 	fixed20_12 a, b, c;
 
 	if (radeon_crtc->base.enabled && num_heads && mode) {
-		active_time = 1000000UL * (u32)mode->crtc_hdisplay / (u32)mode->clock;
-		line_time = min((u32) (1000000UL * (u32)mode->crtc_htotal / (u32)mode->clock), (u32)65535);
+		active_time = (u32) div_u64((u64)mode->crtc_hdisplay * 1000000,
+					    (u32)mode->clock);
+		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
+					  (u32)mode->clock);
+		line_time = min(line_time, (u32)65535);
 		priority_a_cnt = 0;
 		priority_b_cnt = 0;
 
-- 
2.7.4
