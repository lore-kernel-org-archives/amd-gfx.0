From: Mario Kleiner <mario.kleiner.de@gmail.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix overflow of watermark calcs at > 4k resolutions.
Date: Tue, 13 Jun 2017 07:17:10 +0200
Message-ID: <20170613051711.16372-1-mario.kleiner.de@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, mario.kleiner.de@gmail.com, Ben Hutchings <ben.hutchings@codethink.co.uk>, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Commit d63c277dc672e0
("drm/amdgpu: Make display watermark calculations more accurate")
made watermark calculations more accurate, but not for > 4k
resolutions on 32-Bit architectures, as it introduced an integer
overflow for those setups and resolutions.

Fix this by proper u64 casting and division.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Fixes: d63c277dc672 ("drm/amdgpu: Make display watermark calculations more accurate")
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 7 +++++--
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 3c62c45..9f78c03 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1207,8 +1207,11 @@ static void dce_v10_0_program_watermarks(struct amdgpu_device *adev,
 	u32 tmp, wm_mask, lb_vblank_lead_lines = 0;
 
 	if (amdgpu_crtc->base.enabled && num_heads && mode) {
-		active_time = 1000000UL * (u32)mode->crtc_hdisplay / (u32)mode->clock;
-		line_time = min((u32) (1000000UL * (u32)mode->crtc_htotal / (u32)mode->clock), (u32)65535);
+		active_time = (u32) div_u64((u64)mode->crtc_hdisplay * 1000000,
+					    (u32)mode->clock);
+		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
+					  (u32)mode->clock);
+		line_time = min(line_time, (u32)65535);
 
 		/* watermark for high clocks */
 		if (adev->pm.dpm_enabled) {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c8ed0fa..4bcf01d 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1176,8 +1176,11 @@ static void dce_v11_0_program_watermarks(struct amdgpu_device *adev,
 	u32 tmp, wm_mask, lb_vblank_lead_lines = 0;
 
 	if (amdgpu_crtc->base.enabled && num_heads && mode) {
-		active_time = 1000000UL * (u32)mode->crtc_hdisplay / (u32)mode->clock;
-		line_time = min((u32) (1000000UL * (u32)mode->crtc_htotal / (u32)mode->clock), (u32)65535);
+		active_time = (u32) div_u64((u64)mode->crtc_hdisplay * 1000000,
+					    (u32)mode->clock);
+		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
+					  (u32)mode->clock);
+		line_time = min(line_time, (u32)65535);
 
 		/* watermark for high clocks */
 		if (adev->pm.dpm_enabled) {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 3f3a254..eaa8f90 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -983,8 +983,11 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
 	fixed20_12 a, b, c;
 
 	if (amdgpu_crtc->base.enabled && num_heads && mode) {
-		active_time = 1000000UL * (u32)mode->crtc_hdisplay / (u32)mode->clock;
-		line_time = min((u32) (1000000UL * (u32)mode->crtc_htotal / (u32)mode->clock), (u32)65535);
+		active_time = (u32) div_u64((u64)mode->crtc_hdisplay * 1000000,
+					    (u32)mode->clock);
+		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
+					  (u32)mode->clock);
+		line_time = min(line_time, (u32)65535);
 		priority_a_cnt = 0;
 		priority_b_cnt = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 3e90c19..a9e8695 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1091,8 +1091,11 @@ static void dce_v8_0_program_watermarks(struct amdgpu_device *adev,
 	u32 tmp, wm_mask, lb_vblank_lead_lines = 0;
 
 	if (amdgpu_crtc->base.enabled && num_heads && mode) {
-		active_time = 1000000UL * (u32)mode->crtc_hdisplay / (u32)mode->clock;
-		line_time = min((u32) (1000000UL * (u32)mode->crtc_htotal / (u32)mode->clock), (u32)65535);
+		active_time = (u32) div_u64((u64)mode->crtc_hdisplay * 1000000,
+					    (u32)mode->clock);
+		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
+					  (u32)mode->clock);
+		line_time = min(line_time, (u32)65535);
 
 		/* watermark for high clocks */
 		if (adev->pm.dpm_enabled) {
-- 
2.7.4
