From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: Fix a possible null-pointer dereference in radeon_connector_set_property()
Date: Mon, 29 Jul 2019 16:36:44 +0800
Message-ID: <20190729083644.29160-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

In radeon_connector_set_property(), there is an if statement on line 743
to check whether connector->encoder is NULL:
    if (connector->encoder)

When connector->encoder is NULL, it is used on line 755:
    if (connector->encoder->crtc)

Thus, a possible null-pointer dereference may occur.

To fix this bug, connector->encoder is checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index c60d1a44d22a..b684cd719612 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -752,7 +752,7 @@ static int radeon_connector_set_property(struct drm_connector *connector, struct
 
 		radeon_encoder->output_csc = val;
 
-		if (connector->encoder->crtc) {
+		if (connector->encoder && connector->encoder->crtc) {
 			struct drm_crtc *crtc  = connector->encoder->crtc;
 			struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
 
-- 
2.17.0
