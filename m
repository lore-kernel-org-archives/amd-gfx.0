From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 02/14] drm/fb-helper: remove drm_fb_helper_save_lut_atomic
Date: Thu, 22 Jun 2017 08:06:25 +0200
Message-ID: <1498111597-10714-3-git-send-email-peda@axentia.se>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498111597-10714-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Russell King <linux@armlinux.org.uk>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Yannick Fertre <yannick.fertre@st.com>, Philippe Cornu <philippe.cornu@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Vincent Abriou <vincent.abriou@st.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: amd-gfx.lists.freedesktop.org

drm_fb_helper_save_lut_atomic is redundant since the .gamma_store is
now always kept up to date by drm_fb_helper_setcmap.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_fb_helper.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 25315fb..7ade384 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -229,22 +229,6 @@ int drm_fb_helper_remove_one_connector(struct drm_fb_helper *fb_helper,
 }
 EXPORT_SYMBOL(drm_fb_helper_remove_one_connector);
 
-static void drm_fb_helper_save_lut_atomic(struct drm_crtc *crtc, struct drm_fb_helper *helper)
-{
-	uint16_t *r_base, *g_base, *b_base;
-	int i;
-
-	if (helper->funcs->gamma_get == NULL)
-		return;
-
-	r_base = crtc->gamma_store;
-	g_base = r_base + crtc->gamma_size;
-	b_base = g_base + crtc->gamma_size;
-
-	for (i = 0; i < crtc->gamma_size; i++)
-		helper->funcs->gamma_get(crtc, &r_base[i], &g_base[i], &b_base[i], i);
-}
-
 static void drm_fb_helper_restore_lut_atomic(struct drm_crtc *crtc)
 {
 	uint16_t *r_base, *g_base, *b_base;
@@ -285,7 +269,6 @@ int drm_fb_helper_debug_enter(struct fb_info *info)
 			if (drm_drv_uses_atomic_modeset(mode_set->crtc->dev))
 				continue;
 
-			drm_fb_helper_save_lut_atomic(mode_set->crtc, helper);
 			funcs->mode_set_base_atomic(mode_set->crtc,
 						    mode_set->fb,
 						    mode_set->x,
-- 
2.1.4
