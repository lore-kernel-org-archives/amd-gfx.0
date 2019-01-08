From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 26/97] drm/amdgpu: Correct get_crtc_scanoutpos behavior when vpos >= vtotal
Date: Tue,  8 Jan 2019 14:28:35 -0500
Message-ID: <20190108192949.122407-26-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 520f08df45fbe300ed650da786a74093d658b7e1 ]

When variable refresh rate is active the hardware counter can return
a position >= vtotal. This results in a vpos being returned from
amdgpu_display_get_crtc_scanoutpos that's a positive value. The
positive value indicates to the caller that the display is
currently in scanout when the display is actually still in vblank.

This is because the vfront porch duration is unknown with variable
refresh active and will end when either a page flip occurs or the
timeout specified by the driver/display is reached.

The behavior of the amdgpu_display_get_crtc_scanoutpos remains the
same when the position is below vtotal. When the position is above
vtotal the function will return a value that is effectively -vbl_end,
the size of the vback porch.

The only caller affected by this change is the DRM helper for
calculating vblank timestamps. This change corrects behavior for
calculating the page flip timestamp from being the previous timestamp
to the calculation to the next timestamp when position >= vtotal.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 686a26de50f9..9c940bbed608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -857,7 +857,12 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 	/* Inside "upper part" of vblank area? Apply corrective offset if so: */
 	if (in_vbl && (*vpos >= vbl_start)) {
 		vtotal = mode->crtc_vtotal;
-		*vpos = *vpos - vtotal;
+
+		/* With variable refresh rate displays the vpos can exceed
+		 * the vtotal value. Clamp to 0 to return -vbl_end instead
+		 * of guessing the remaining number of lines until scanout.
+		 */
+		*vpos = (*vpos < vtotal) ? (*vpos - vtotal) : 0;
 	}
 
 	/* Correct for shifted end of vbl at vbl_end. */
-- 
2.19.1
