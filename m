From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 01/14] drm/fb-helper: keep the .gamma_store updated in drm_fb_helper_setcmap
Date: Thu, 22 Jun 2017 08:06:24 +0200
Message-ID: <1498111597-10714-2-git-send-email-peda@axentia.se>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498111597-10714-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Russell King <linux@armlinux.org.uk>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Yannick Fertre <yannick.fertre@st.com>, Philippe Cornu <philippe.cornu@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Vincent Abriou <vincent.abriou@st.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

I think the gamma_store can end up invalid on error. But the way I read
it, that can happen in drm_mode_gamma_set_ioctl as well, so why should
this pesky legacy fbdev stuff be any better?

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_fb_helper.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 574af01..25315fb 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1223,12 +1223,16 @@ int drm_fb_helper_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 	const struct drm_crtc_helper_funcs *crtc_funcs;
 	u16 *red, *green, *blue, *transp;
 	struct drm_crtc *crtc;
+	u16 *r, *g, *b;
 	int i, j, rc = 0;
 	int start;
 
 	if (oops_in_progress)
 		return -EBUSY;
 
+	if (cmap->start + cmap->len < cmap->start)
+		return -EINVAL;
+
 	drm_modeset_lock_all(dev);
 	if (!drm_fb_helper_is_bound(fb_helper)) {
 		drm_modeset_unlock_all(dev);
@@ -1245,6 +1249,29 @@ int drm_fb_helper_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 		transp = cmap->transp;
 		start = cmap->start;
 
+		if (info->fix.visual != FB_VISUAL_TRUECOLOR) {
+			if (!crtc->gamma_size) {
+				rc = -EINVAL;
+				goto out;
+			}
+
+			if (cmap->start + cmap->len > crtc->gamma_size) {
+				rc = -EINVAL;
+				goto out;
+			}
+
+			r = crtc->gamma_store;
+			g = r + crtc->gamma_size;
+			b = g + crtc->gamma_size;
+
+			memcpy(r + cmap->start, cmap->red,
+			       cmap->len * sizeof(u16));
+			memcpy(g + cmap->start, cmap->green,
+			       cmap->len * sizeof(u16));
+			memcpy(b + cmap->start, cmap->blue,
+			       cmap->len * sizeof(u16));
+		}
+
 		for (j = 0; j < cmap->len; j++) {
 			u16 hred, hgreen, hblue, htransp = 0xffff;
 
-- 
2.1.4
