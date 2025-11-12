Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB45CD4F50
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 08:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F4FF10E602;
	Thu, 13 Nov 2025 08:36:12 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C42D10E751
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 15:18:48 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-42b3b29153fso526312f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 07:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762960727; x=1763565527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1KXel6Qy/7m9K4NuS3jmCrDuFbX4pw+8Ecrilun1is=;
 b=EzTc8ZbBc8Lt6p98ARywPhKQmR9U23zd3HhAcrJIQiD+6i9x7SzSXtf9ZlGAzknl4D
 bntwji7FUCZH8nype1UqoKKD6Pi4GaRHTbSZZDLx1QFV42gEXtavvHrZN92YFXC29Llg
 EZnEgQSudrNFjbmqHwXYq+/Ies/wtCqmZ2gxEsYDR7Xz3S8VMNxg4DGHLbU3CygD8sCi
 F0ribDAQp0w5beVV7KurZNRllsn55dC79lZAS+d+Bf7S0lEwQrTHoAIlVpkKYZ6A+7Yr
 hNI9LZVEG9WUREu2Mm8lYe9UjSa9p6+kKd85NCsAD+5FuKmS+gEycRoGBxRxFaslRCTn
 KCRQ==
X-Gm-Message-State: AOJu0YzIOQtdw8KJwQ27NoXXEwoXHUkzEUlyxtPyki9Ww0giE3ZDM/0O
 /41kgleOTr9fsrThlpFiuxFepmdpFfZmV0KRpW4ciXoX6iYeRslhgU9T
X-Gm-Gg: ASbGncvM8ZUySXnQJ/Zkqmp9QMli4eK1LlSfv6unkOT0fJTEKXcvF/7vVGy6XA/HRZZ
 v7zgIOLDdjHqmJOfnpGH0B1DsbxNYf4u1Lcb/Xc56593LplY5RYUXvUgkGLYJGXdcowApFIt5Rk
 IYyFS7RLVhnMaJfM/ZJLt6ofRc+L8rKN6bwrOnYtqD+7cdicpye/P+EFRrs1ppTAGBd7Q6z9pYf
 XU+uJ6H/ZWauLSynbxzmsfPJil7Il+mi0YoItGrUHSiS7zM4lwpTaQvoBdl/FsOxn4r3POj/8jo
 MsQSPzG4B9CJFpJGhvwqF3O5Hnslb3QwLc3KVwFGv7TVe4X79bQJ4ov04aTY6Hyt5vphZ7dDNN6
 SYZD+nCzW+yH2sagFcYRIZo3LOTrtSw57xZs/+sW6BNvULqk95ymk4OGwIVNLl7pCJsIifyC7VC
 Z5T/Vo+DCnslu4AxiVu18=
X-Google-Smtp-Source: AGHT+IEExQ41M3pc3vufOuMnv5kj0G3Q1neuAJGL6Bi1ukKfbEtQgZRVJUQ4VEqLNJ0PynCjxn4wVw==
X-Received: by 2002:a05:6000:61e:b0:42b:3ee9:4772 with SMTP id
 ffacd0b85a97d-42b4bdb6744mr2952981f8f.52.1762960726777; 
 Wed, 12 Nov 2025 07:18:46 -0800 (PST)
Received: from xavers-framework.fritz.box ([193.124.138.23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b32c1ad2bsm23255211f8f.6.2025.11.12.07.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 07:18:46 -0800 (PST)
From: Xaver Hugl <xaver.hugl@kde.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 harry.wentland@amd.com, Xaver Hugl <xaver.hugl@kde.org>
Subject: [PATCH 3/3] drm,
 amdgpu: add the "FreeSync HDR Mode" connector property
Date: Wed, 12 Nov 2025 16:18:32 +0100
Message-ID: <20251112151832.77867-3-xaver.hugl@kde.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112151832.77867-1-xaver.hugl@kde.org>
References: <20251112151832.77867-1-xaver.hugl@kde.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Nov 2025 08:36:11 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This property allows userspace to make the driver signal the display that it
should switch to FreeSync 2 HDR mode, which uses the native primaries and a
gamma 2.2 transfer function, instead of BT2020 + PQ in the more common HDR
mode.
FreeSync HDR provides the big benefit that display behavior is more
predictable, and the "native" signal doesn't waste any color resolution on
out of bounds colors or luminance values.

The property has two values right now, "Disabled" and "FreeSync 2 Native".
If any other FreeSync HDR modes exist or will be added at some point, they
can be added as new enum values as well.

Signed-off-by: Xaver Hugl <xaver.hugl@kde.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 drivers/gpu/drm/drm_atomic_uapi.c             |  4 ++
 drivers/gpu/drm/drm_connector.c               | 45 +++++++++++++++++++
 include/drm/drm_connector.h                   | 18 ++++++++
 5 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6597fe07e984..82951c53562b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8494,6 +8494,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		if (adev->dm.hdcp_workqueue)
 			drm_connector_attach_content_protection_property(&aconnector->base, true);
 	}
+
+	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
+		drm_connector_attach_freesync_hdr_property(&aconnector->base);
+	}
 }
 
 static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
@@ -9011,6 +9015,7 @@ static void update_freesync_state_on_stream(
 	bool pack_sdp_v1_3 = false;
 	struct amdgpu_dm_connector *aconn;
 	enum vrr_packet_type packet_type = PACKET_TYPE_VRR;
+	enum color_transfer_func tf = TRANSFER_FUNC_UNKNOWN;
 
 	if (!new_stream)
 		return;
@@ -9066,12 +9071,16 @@ static void update_freesync_state_on_stream(
 							   &new_stream->adaptive_sync_infopacket);
 	}
 
+	if (aconn && aconn->freesync_hdr_mode == FREESYNC_2_HDR_NATIVE) {
+		tf = TRANSFER_FUNC_GAMMA_22;
+	}
+
 	mod_freesync_build_vrr_infopacket(
 		dm->freesync_module,
 		new_stream,
 		&vrr_params,
 		packet_type,
-		TRANSFER_FUNC_UNKNOWN,
+		tf,
 		&vrr_infopacket,
 		pack_sdp_v1_3);
 
@@ -10291,6 +10300,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct dc_stream_update stream_update;
 		struct dc_info_packet hdr_packet;
 		struct dc_stream_status *status = NULL;
+		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 		bool abm_changed, hdr_changed, scaling_changed, output_color_space_changed = false;
 
 		memset(&stream_update, 0, sizeof(stream_update));
@@ -10300,6 +10310,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
 		}
 
+		aconnector->freesync_hdr_mode = dm_new_con_state->base.freesync_hdr_mode;
+
 		/* Skip any modesets/resets */
 		if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b937da0a4e4a..b9b669efc075 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -795,6 +795,7 @@ struct amdgpu_dm_connector {
 	bool pack_sdp_v1_3;
 	enum adaptive_sync_type as_type;
 	struct amdgpu_hdmi_vsdb_info vsdb_info;
+	enum freesync_hdr_mode freesync_hdr_mode;
 };
 
 static inline void amdgpu_dm_set_mst_status(uint8_t *status,
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 85dbdaa4a2e2..c56ca11322c1 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -780,6 +780,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->privacy_screen_sw_state = val;
 	} else if (property == connector->broadcast_rgb_property) {
 		state->hdmi.broadcast_rgb = val;
+	} else if (property == connector->freesync_hdr_property) {
+		state->freesync_hdr_mode = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -865,6 +867,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->privacy_screen_sw_state;
 	} else if (property == connector->broadcast_rgb_property) {
 		*val = state->hdmi.broadcast_rgb;
+	} else if (property == connector->freesync_hdr_property) {
+		*val = state->freesync_hdr_mode;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 272d6254ea47..93727992f757 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1802,6 +1802,15 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
  *
  *	Drivers can set up these properties by calling
  *	drm_mode_create_tv_margin_properties().
+ *
+ * FreeSync HDR Mode:
+ * 	This optional property allows userspace to signal the display to switch
+ * 	into FreeSync 2 HDR mode, which assumes a colorspace with native
+ * 	primaries and a gamma 2.2 transfer function with min and max luminance
+ * 	matching the display.
+ * 	Like with HDR_OUTPUT_METADATA, it is up to userspace to find out which
+ * 	mode the display supports, and which primaries and luminance levels it
+ * 	has to use.
  */
 
 int drm_connector_create_standard_properties(struct drm_device *dev)
@@ -2947,6 +2956,42 @@ bool drm_connector_atomic_hdr_metadata_equal(struct drm_connector_state *old_sta
 }
 EXPORT_SYMBOL(drm_connector_atomic_hdr_metadata_equal);
 
+static const struct drm_prop_enum_list freesync_hdr_mode_names[] = {
+	{ FREESYNC_HDR_DISABLED, "Disabled" },
+	{ FREESYNC_2_HDR_NATIVE, "FreeSync 2 Native" },
+};
+
+/**
+ * drm_connector_attach_freesync_hdr_property - attach "FreeSync HDR Mode"property
+ * @connector: connector to attach the property on.
+ *
+ * This is used to allow the userspace to enable or disable FreeSync HDR.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_freesync_hdr_property(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop = connector->freesync_hdr_property;
+	if (!prop) {
+		prop = drm_property_create_enum(dev, DRM_MODE_PROP_ENUM,
+						"FreeSync HDR Mode",
+						freesync_hdr_mode_names,
+						ARRAY_SIZE(freesync_hdr_mode_names));
+		if (!prop)
+			return -EINVAL;
+
+		connector->freesync_hdr_property = prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop,
+				   FREESYNC_HDR_DISABLED);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_freesync_hdr_property);
+
 /**
  * drm_connector_set_vrr_capable_property - sets the variable refresh rate
  * capable property for a connector
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8f34f4b8183d..33e557a2d985 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -462,6 +462,11 @@ enum drm_privacy_screen_status {
 	PRIVACY_SCREEN_ENABLED_LOCKED,
 };
 
+enum freesync_hdr_mode {
+    FREESYNC_HDR_DISABLED = 0,
+    FREESYNC_2_HDR_NATIVE = 1,
+};
+
 /**
  * enum drm_colorspace - color space
  *
@@ -1149,6 +1154,12 @@ struct drm_connector_state {
 	 * @drm_atomic_helper_connector_hdmi_check().
 	 */
 	struct drm_connector_hdmi_state hdmi;
+
+	/**
+	* @freesync_hdr_mode: Connector property to enable
+	* or disable FreeSync HDR
+	*/
+	enum freesync_hdr_mode freesync_hdr_mode;
 };
 
 struct drm_connector_hdmi_audio_funcs {
@@ -2103,6 +2114,12 @@ struct drm_connector {
 	 */
 	struct drm_property *broadcast_rgb_property;
 
+	/**
+	* @freesync_hdr_property: Connector property to enable
+	* or disable FreeSync HDR
+	*/
+	struct drm_property *freesync_hdr_property;
+
 #define DRM_CONNECTOR_POLL_HPD (1 << 0)
 #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
 #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
@@ -2453,6 +2470,7 @@ int drm_connector_attach_colorspace_property(struct drm_connector *connector);
 int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector);
 bool drm_connector_atomic_hdr_metadata_equal(struct drm_connector_state *old_state,
 					     struct drm_connector_state *new_state);
+int drm_connector_attach_freesync_hdr_property(struct drm_connector *connector);
 int drm_mode_create_aspect_ratio_property(struct drm_device *dev);
 int drm_mode_create_hdmi_colorspace_property(struct drm_connector *connector,
 					     u32 supported_colorspaces);
-- 
2.51.1

