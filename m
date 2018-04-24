From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] drm/radeon: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:15:13 +0200
Message-ID: <20180424131513.2311-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

The method struct drm_connector_helper_funcs::mode_valid is defined
as returning an 'enum drm_mode_status' but the driver implementation
for this method uses an 'int' for it.

Fix this by using 'enum drm_mode_status' in the driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index df9469a8f..2aea2bdff 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -852,7 +852,7 @@ static int radeon_lvds_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static int radeon_lvds_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status radeon_lvds_mode_valid(struct drm_connector *connector,
 				  struct drm_display_mode *mode)
 {
 	struct drm_encoder *encoder = radeon_best_single_encoder(connector);
@@ -1012,7 +1012,7 @@ static int radeon_vga_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static int radeon_vga_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status radeon_vga_mode_valid(struct drm_connector *connector,
 				  struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
@@ -1156,7 +1156,7 @@ static int radeon_tv_get_modes(struct drm_connector *connector)
 	return 1;
 }
 
-static int radeon_tv_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status radeon_tv_mode_valid(struct drm_connector *connector,
 				struct drm_display_mode *mode)
 {
 	if ((mode->hdisplay > 1024) || (mode->vdisplay > 768))
@@ -1498,7 +1498,7 @@ static void radeon_dvi_force(struct drm_connector *connector)
 		radeon_connector->use_digital = true;
 }
 
-static int radeon_dvi_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status radeon_dvi_mode_valid(struct drm_connector *connector,
 				  struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
@@ -1800,7 +1800,7 @@ radeon_dp_detect(struct drm_connector *connector, bool force)
 	return ret;
 }
 
-static int radeon_dp_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status radeon_dp_mode_valid(struct drm_connector *connector,
 				  struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
-- 
2.17.0
