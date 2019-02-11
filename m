From: Mario Kleiner <mario.kleiner.de@gmail.com>
Subject: [PATCH 1/3] drm/amdgpu: Fix get_crtc_scanoutpos behavior in vrr when vpos >= vtotal.
Date: Mon, 11 Feb 2019 04:22:23 +0100
Message-ID: <20190211032225.9488-2-mario.kleiner.de@gmail.com>
References: <20190211032225.9488-1-mario.kleiner.de@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190211032225.9488-1-mario.kleiner.de@gmail.com>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: mario.kleiner.de@gmail.com, michel@daenzer.net, stable@vger.kernel.org, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Harry Wentland <harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

This reverts commit 520f08df45fbe300ed650da786a74093d658b7e1
("drm/amdgpu: Correct get_crtc_scanoutpos behavior when vpos >= vtotal")

While the explanation in that commit is correct wrt. the hardware
counter sometimes returning a position >= vtotal in vrr mode if
the query happens while we are inside the "extended front porch",
the math without this commit still returns the desired *vpos value
for achieving a proper vblank timestamping behavior in vrr mode,
according to the kernel documentation about how vblank timestamps
should behave in vrr mode.

According to the vrr mode docs, the vblank timestamp (calculated by
drm_calc_vbltimestamp_from_scanoutpos()) is always supposed to be
the one corresponding to the end of vblank as if vblank duration
is == minimum vblank duration under vrr == vblank duration of the
regular fixed refresh rate mode timing. Iow. it must be the same
timestamp as would show up in non-vrr mode, even if the current
vblank may be much longer (by an unknown amount of time), due to
an extended front porch duration.

Doing the math on this shows that we get the correct *vpos values
to feed into the drm_calc_vbltimestamp_from_scanoutpos() helper
for this to happen by using exactly the same correction:

*vpos = *vpos - vtotal - vbl_end

Therefore we don't need any special case for *vpos >= vtotal and
the special case would cause wrong timestamps.

The only quirk compared to non-vrr mode is that this can return
a *vpos >= 0 despite being in vblank, ie. while returning the
DRM_SCANOUTPOS_IN_VBLANK flag. Auditing all callers of the function
shows this doesn't matter, as they all use the dedicated
DRM_SCANOUTPOS_IN_VBLANK flag to check for "in vblank", but not
the sign of *vpos.

This patch should make sure that amdgpu_display_get_crtc_scanoutpos()
always returns a *vpos value which leads to a stable vblank timestamp,
regardless where the scanout position is during the function call.
This stability is important to not confuse the vblank_disable_immediate
logic in DRM cores vblank counting, and to provide some stable
timestamp for future improvements of the pageflip timestamping under
vrr.

Fixes: 520f08df45fb ("drm/amdgpu: Correct get_crtc_scanoutpos behavior
when vpos >= vtotal")
Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: <stable@vger.kernel.org>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 4e944737b708..13da4e3549f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -779,12 +779,22 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
  * Returns vpos as a positive number while in active scanout area.
  * Returns vpos as a negative number inside vblank, counting the number
  * of scanlines to go until end of vblank, e.g., -1 means "one scanline
- * until start of active scanout / end of vblank."
+ * until start of active scanout / end of vblank." Note that in variable
+ * refresh rate mode (vrr), vpos may be positive inside the extended front
+ * porch, despite being inside vblank, and a negative number does not
+ * always define the number of scanline to true end of vblank. Instead
+ * the vpos values behave as if the crtc would operate in fixed refresh
+ * rate mode. This allows the drm_calc_vbltimestamp_from_scanoutpos()
+ * helper to calculate appropriate and stable vblank timestamps as specified
+ * for vrr mode - corresponding to the shortest vblank duration under vrr.
+ * In vrr mode therefore check the returned Flags for presence of
+ * DRM_SCANOUTPOS_IN_VBLANK to detect if the scanout is currently inside
+ * or outside true vblank.
  *
  * \return Flags, or'ed together as follows:
  *
  * DRM_SCANOUTPOS_VALID = Query successful.
- * DRM_SCANOUTPOS_INVBL = Inside vblank.
+ * DRM_SCANOUTPOS_IN_VBLANK = Inside vblank.
  * DRM_SCANOUTPOS_ACCURATE = Returned position is accurate. A lack of
  * this flag means that returned position may be offset by a constant but
  * unknown small number of scanlines wrt. real scanout position.
@@ -876,12 +886,7 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 	/* Inside "upper part" of vblank area? Apply corrective offset if so: */
 	if (in_vbl && (*vpos >= vbl_start)) {
 		vtotal = mode->crtc_vtotal;
-
-		/* With variable refresh rate displays the vpos can exceed
-		 * the vtotal value. Clamp to 0 to return -vbl_end instead
-		 * of guessing the remaining number of lines until scanout.
-		 */
-		*vpos = (*vpos < vtotal) ? (*vpos - vtotal) : 0;
+		*vpos = *vpos - vtotal;
 	}
 
 	/* Correct for shifted end of vbl at vbl_end. */
-- 
2.17.1
