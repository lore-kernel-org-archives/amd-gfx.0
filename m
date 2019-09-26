From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 6/6] drm/encoder: WARN() when adding/removing encoders after device registration
Date: Thu, 26 Sep 2019 18:51:08 -0400
Message-ID: <20190926225122.31455-7-lyude@redhat.com>
References: <20190926225122.31455-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926225122.31455-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Turns out that we don't actually check this anywhere, and additionally
actually forget to even mention this in our documentation.

Since we've had one driver making this mistake already, let's clarify
this by mentioning this limitation in the kernel docs. Additionally, for
drivers not using the legacy ->load/->unload() hooks (which make it
impossible to create all encoders before registration): print a big
warning when drm_encoder_init() is called after device registration, or
when drm_encoder_cleanup() is called before device unregistration.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_encoder.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index 80d88a55302e..5c5e40aafa4e 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -99,9 +99,12 @@ void drm_encoder_unregister_all(struct drm_device *dev)
  * @encoder_type: user visible type of the encoder
  * @name: printf style format string for the encoder name, or NULL for default name
  *
- * Initialises a preallocated encoder. Encoder should be subclassed as part of
- * driver encoder objects. At driver unload time drm_encoder_cleanup() should be
- * called from the driver's &drm_encoder_funcs.destroy hook.
+ * Initialises a preallocated encoder. The encoder should be subclassed as
+ * part of driver encoder objects. This function may not be called after the
+ * device is registered with drm_dev_register().
+ *
+ * At driver unload time drm_encoder_cleanup() must be called from the
+ * driver's &drm_encoder_funcs.destroy hook.
  *
  * Returns:
  * Zero on success, error code on failure.
@@ -117,6 +120,14 @@ int drm_encoder_init(struct drm_device *dev,
 	if (WARN_ON(dev->mode_config.num_encoder >= 32))
 		return -EINVAL;
 
+	/*
+	 * Encoders should never be added after device registration, with the
+	 * exception of drivers using the legacy load/unload callbacks where
+	 * it's impossible to create encoders beforehand. Such drivers should
+	 * convert to using drm_dev_register() and friends.
+	 */
+	WARN_ON(dev->registered && !dev->driver->load);
+
 	ret = drm_mode_object_add(dev, &encoder->base, DRM_MODE_OBJECT_ENCODER);
 	if (ret)
 		return ret;
@@ -155,16 +166,22 @@ EXPORT_SYMBOL(drm_encoder_init);
  * drm_encoder_cleanup - cleans up an initialised encoder
  * @encoder: encoder to cleanup
  *
- * Cleans up the encoder but doesn't free the object.
+ * Cleans up the encoder but doesn't free the object. This function may not be
+ * called until the respective &struct drm_device has been unregistered from
+ * userspace using drm_dev_unregister().
  */
 void drm_encoder_cleanup(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
 
-	/* Note that the encoder_list is considered to be static; should we
-	 * remove the drm_encoder at runtime we would have to decrement all
-	 * the indices on the drm_encoder after us in the encoder_list.
+	/*
+	 * Encoders should never be removed after device registration, with
+	 * the exception of drivers using the legacy load/unload callbacks
+	 * where it's impossible to remove encoders until after
+	 * deregistration. Such drivers should convert to using
+	 * drm_dev_register() and friends.
 	 */
+	WARN_ON(dev->registered && !dev->driver->unload);
 
 	if (encoder->bridge) {
 		struct drm_bridge *bridge = encoder->bridge;
-- 
2.21.0
