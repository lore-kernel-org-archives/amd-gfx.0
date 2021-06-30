Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48488C11F6A
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 15:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD1E61476
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 15:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD1E61476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A2C6EA4B;
	Wed, 30 Jun 2021 15:10:37 +0000 (UTC)
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA466EA23;
 Wed, 30 Jun 2021 15:10:30 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 05F60C80098;
 Wed, 30 Jun 2021 17:10:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id 8hAfmwTSdxuI; Wed, 30 Jun 2021 17:10:28 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box
 (p200300e37F394900095779a208783f8e.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f39:4900:957:79a2:878:3f8e])
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPA id 1E668C8009A;
 Wed, 30 Jun 2021 17:10:27 +0200 (CEST)
From: Werner Sembach <wse@tuxedocomputers.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, emil.l.velikov@gmail.com
Subject: [PATCH v5 15/17] drm/uAPI: Move "Broadcast RGB" property from driver
 specific to general context
Date: Wed, 30 Jun 2021 17:10:16 +0200
Message-Id: <20210630151018.330354-16-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210630151018.330354-1-wse@tuxedocomputers.com>
References: <20210630151018.330354-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Werner Sembach <wse@tuxedocomputers.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add "Broadcast RGB" to general drm context so that more drivers besides
i915 and gma500 can implement it without duplicating code.

Userspace can use this property to tell the graphic driver to use full or
limited color range for a given connector, overwriting the default
behaviour/automatic detection.

Possible options are:
    - Automatic (default/current behaviour)
    - Full
    - Limited 16:235

In theory the driver should be able to automatically detect the monitors
capabilities, but because of flawed standard implementations in Monitors,
this might fail. In this case a manual overwrite is required to not have
washed out colors or lose details in very dark or bright scenes.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/drm_atomic_helper.c |  4 +++
 drivers/gpu/drm/drm_atomic_uapi.c   |  4 +++
 drivers/gpu/drm/drm_connector.c     | 46 +++++++++++++++++++++++++++++
 include/drm/drm_connector.h         | 16 ++++++++++
 4 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 90d62f305257..0c89d32efbd0 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -691,6 +691,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 			if (old_connector_state->preferred_color_format !=
 			    new_connector_state->preferred_color_format)
 				new_crtc_state->connectors_changed = true;
+
+			if (old_connector_state->preferred_color_range !=
+			    new_connector_state->preferred_color_range)
+				new_crtc_state->connectors_changed = true;
 		}
 
 		if (funcs->atomic_check)
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index c536f5e22016..c589bb1a8163 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -798,6 +798,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->max_requested_bpc = val;
 	} else if (property == connector->preferred_color_format_property) {
 		state->preferred_color_format = val;
+	} else if (property == connector->preferred_color_range_property) {
+		state->preferred_color_range = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -877,6 +879,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->max_requested_bpc;
 	} else if (property == connector->preferred_color_format_property) {
 		*val = state->preferred_color_format;
+	} else if (property == connector->preferred_color_range_property) {
+		*val = state->preferred_color_range;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 67dd59b12258..20ae2e6d907b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -905,6 +905,12 @@ static const struct drm_prop_enum_list drm_active_color_format_enum_list[] = {
 	{ DRM_COLOR_FORMAT_YCRCB420, "ycbcr420" },
 };
 
+static const struct drm_prop_enum_list drm_preferred_color_range_enum_list[] = {
+	{ DRM_MODE_COLOR_RANGE_UNSET, "Automatic" },
+	{ DRM_MODE_COLOR_RANGE_FULL, "Full" },
+	{ DRM_MODE_COLOR_RANGE_LIMITED_16_235, "Limited 16:235" },
+};
+
 static const struct drm_prop_enum_list drm_active_color_range_enum_list[] = {
 	{ DRM_MODE_COLOR_RANGE_UNSET, "Not Applicable" },
 	{ DRM_MODE_COLOR_RANGE_FULL, "Full" },
@@ -1246,6 +1252,15 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
  *	property. Possible values are "not applicable", "rgb", "ycbcr444",
  *	"ycbcr422", and "ycbcr420".
  *
+ * Broadcast RGB:
+ *	This property is used by userspace to change the used color range. This
+ *	property affects the RGB color format as well as the Y'CbCr color
+ *	formats, if the driver supports both full and limited Y'CbCr. Drivers to
+ *	use the function drm_connector_attach_preferred_color_format_property()
+ *	to create and attach the property to the connector during
+ *	initialization. Possible values are "Automatic", "Full", and "Limited
+ *	16:235".
+ *
  * active color range:
  *	This read-only property tells userspace the color range actually used by
  *	the hardware display engine "on the cable" on a connector. The chosen
@@ -2331,6 +2346,37 @@ void drm_connector_set_active_color_format_property(struct drm_connector *connec
 }
 EXPORT_SYMBOL(drm_connector_set_active_color_format_property);
 
+/**
+ * drm_connector_attach_preferred_color_range_property - attach "Broadcast RGB" property
+ * @connector: connector to attach preferred color range property on.
+ *
+ * This is used to add support for selecting a color range on a connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_preferred_color_range_property(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	if (!connector->preferred_color_range_property) {
+		prop = drm_property_create_enum(dev, 0, "Broadcast RGB",
+						drm_preferred_color_range_enum_list,
+						ARRAY_SIZE(drm_preferred_color_range_enum_list));
+		if (!prop)
+			return -ENOMEM;
+
+		connector->preferred_color_range_property = prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop, DRM_MODE_COLOR_RANGE_UNSET);
+	connector->state->preferred_color_range = DRM_MODE_COLOR_RANGE_UNSET;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_preferred_color_range_property);
+
 /**
  * drm_connector_attach_active_color_range_property - attach "active color range" property
  * @connector: connector to attach active color range property on.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 0dd7ece375c5..028bfb831abb 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -809,6 +809,15 @@ struct drm_connector_state {
 	 */
 	u32 preferred_color_format;
 
+	/**
+	 * preferred_color_range: Property set by userspace via "Broadcast RGB"
+	 * property to tell the GPU driver which color range to use. It
+	 * overwrites existing automatic detection mechanisms, if set and valid
+	 * for the current color format. Userspace can check for (un-)successful
+	 * application via the "active color range" property.
+	 */
+	enum drm_mode_color_range preferred_color_range;
+
 	/**
 	 * @hdr_output_metadata:
 	 * DRM blob property for HDR output metadata
@@ -1426,6 +1435,12 @@ struct drm_connector {
 	 */
 	struct drm_property *active_color_format_property;
 
+	/**
+	 * @preferred_color_range_property: Default connector property for the
+	 * preferred color range to be driven out of the connector.
+	 */
+	struct drm_property *preferred_color_range_property;
+
 	/**
 	 * @active_color_range_property: Default connector property for the
 	 * active color range to be driven out of the connector.
@@ -1760,6 +1775,7 @@ int drm_connector_attach_preferred_color_format_property(struct drm_connector *c
 int drm_connector_attach_active_color_format_property(struct drm_connector *connector);
 void drm_connector_set_active_color_format_property(struct drm_connector *connector,
 						    u32 active_color_format);
+int drm_connector_attach_preferred_color_range_property(struct drm_connector *connector);
 int drm_connector_attach_active_color_range_property(struct drm_connector *connector);
 void drm_connector_set_active_color_range_property(struct drm_connector *connector,
 						   enum drm_mode_color_range active_color_range);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
