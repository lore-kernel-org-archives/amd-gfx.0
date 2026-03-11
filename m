Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F7C106289D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 12:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D98E10E8D5;
	Wed, 11 Mar 2026 12:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ucm8ubp+";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366F010E88F;
 Wed, 11 Mar 2026 11:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773228682; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eIVwX9FR8oKpABcO7DsxLuhqJ13SJ3hiAtOqvWBdrVUm+VN+bkCaGrxBYu0nHjlhhMZ8E5FffbeIm3afkshWSUtdVfn2N7P2HuttBA3Tfj/bIFkXXZGrtuWxQQtWSsrI7GNxfsS/wT29+6yEmzfGYQL/yWdDPSFOMvqVy+Pse84=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773228682;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=V26pVzIDfVPYCMw4nJ5W1naFfpb3OzSUw4zIJtbIxDc=; 
 b=nL83CoAWUZg0OakBeuozxu549vBimCjxSeRpIogp6hU+XUtNOeNns4TDRTPXBmSsKjcOeNK7BVE2gH+0tCvWD58V31KeJQfyYsxaAr9CDMevSgbTBemw2yYBWSS0GyXKJtyjqXFJLOk67E4Y1VeK18K5kmYq+jYpPRb8n852JBs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773228682; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=V26pVzIDfVPYCMw4nJ5W1naFfpb3OzSUw4zIJtbIxDc=;
 b=Ucm8ubp+u9TTk94f16SH3TO2VSrJUhFTclxWDvaFSVH6TToA+FEdarF8MvZ5jpgJ
 UkiMf/MjJcAhkymDWHFugngaR7RNSo155QqPKyZ4jbh0T2CUSoE9al6PaGUVXga6mde
 m7XTSn/bODJNUqgSkLQDZQBtA1YEtOMzulGSZUK4=
Received: by mx.zohomail.com with SMTPS id 1773228680844440.5180725378026;
 Wed, 11 Mar 2026 04:31:20 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 11 Mar 2026 12:30:55 +0100
Subject: [PATCH v4 1/2] drm/connector: hdmi: Add a 'link bpc' property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-link-bpc-v4-1-51775e964720@collabora.com>
References: <20260311-link-bpc-v4-0-51775e964720@collabora.com>
In-Reply-To: <20260311-link-bpc-v4-0-51775e964720@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, kernel@collabora.com, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Derek Foreman <derek.foreman@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 11 Mar 2026 12:54:53 +0000
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

Display drivers may degrade from higher bit depths to lower bit depths
for reasons such as bandwidth constraints. Userspace applications, such
as compositors, may wish to know that this has occurred transparently,
instead of assuming that the "max bpc" they requested could be reached.

Introduce a new immutable DRM property called "link bpc" that reflects
the current display link's bits-per-component. An uevent is fired when
the link bpc value changes.

Set the new link_bpc member in the HDMI state helper to its HDMI output
bpc, so that during the next commit, the property is updated accordingly
and the uevent is fired.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Co-developed-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  2 +
 drivers/gpu/drm/drm_atomic_helper.c             |  9 +++
 drivers/gpu/drm/drm_atomic_uapi.c               |  2 +
 drivers/gpu/drm/drm_connector.c                 | 86 +++++++++++++++++++++++++
 include/drm/drm_connector.h                     | 16 +++++
 5 files changed, 115 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index a1d16762ac7a..40648574f5e5 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -865,6 +865,8 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 		struct drm_crtc *crtc = new_conn_state->crtc;
 		struct drm_crtc_state *crtc_state;
 
+		new_conn_state->link_bpc = new_conn_state->hdmi.output_bpc;
+
 		crtc_state = drm_atomic_get_crtc_state(state, crtc);
 		if (IS_ERR(crtc_state))
 			return PTR_ERR(crtc_state);
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 26953ed6b53e..4a932f543ac7 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2033,9 +2033,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_tail_rpm);
 
 static void commit_tail(struct drm_atomic_state *state)
 {
+	struct drm_connector_state *old_conn_state, *new_conn_state;
 	struct drm_device *dev = state->dev;
 	const struct drm_mode_config_helper_funcs *funcs;
 	struct drm_crtc_state *new_crtc_state;
+	struct drm_connector *connector;
 	struct drm_crtc *crtc;
 	ktime_t start;
 	s64 commit_time_ms;
@@ -2059,6 +2061,13 @@ static void commit_tail(struct drm_atomic_state *state)
 
 	drm_atomic_helper_wait_for_dependencies(state);
 
+	for_each_oldnew_connector_in_state(state, connector, old_conn_state,
+					   new_conn_state, i) {
+		if (old_conn_state->link_bpc != new_conn_state->link_bpc)
+			drm_connector_update_link_bpc_property(connector,
+							       new_conn_state);
+	}
+
 	/*
 	 * We cannot safely access new_crtc_state after
 	 * drm_atomic_helper_commit_hw_done() so figure out which crtc's have
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 87de41fb4459..3e8b4b795512 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1016,6 +1016,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->privacy_screen_sw_state;
 	} else if (property == connector->broadcast_rgb_property) {
 		*val = state->hdmi.broadcast_rgb;
+	} else if (property == connector->link_bpc_property) {
+		*val = state->link_bpc;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index e70699c59c43..572894dad4bf 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -542,6 +542,75 @@ int drmm_connector_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drmm_connector_init);
 
+/**
+ * drm_connector_attach_link_bpc_property - create and attach 'link bpc' property
+ * @connector: drm connector
+ * @max_bpc: specify the upper limit, matching  that of 'max bpc' property
+ *
+ * Create and attach the 'link bpc' DRM property on @connector with an upper
+ * limit of @max_bpc.
+ *
+ * Returns:
+ * 0 on success, negative errno on failure.
+ */
+int
+drm_connector_attach_link_bpc_property(struct drm_connector *connector,
+				       unsigned int max_bpc)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	if (connector->link_bpc_property)
+		return -EBUSY;
+
+	if (max_bpc < 8 || max_bpc > U8_MAX)
+		return -EINVAL;
+
+	prop = drm_property_create_range(dev, DRM_MODE_PROP_IMMUTABLE,
+					 "link bpc", 8, max_bpc);
+	if (!prop)
+		return -ENOMEM;
+
+	connector->link_bpc_property = prop;
+
+	drm_object_attach_property(&connector->base, prop, max_bpc);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_link_bpc_property);
+
+/**
+ * drm_connector_update_link_bpc_property - update the 'link bpc' property of a
+ *                                          connector and fire uevent
+ * @connector: pointer to the &struct drm_connector
+ * @state: pointer to the &struct drm_connector_state with the new value
+ *
+ * Update the 'link bpc' property of the given @connector to the
+ * &drm_connector_state.link_bpc member's value of @state and fire a uevent.
+ */
+void
+drm_connector_update_link_bpc_property(struct drm_connector *connector,
+				       struct drm_connector_state *state)
+{
+	u8 bpc = clamp(state->link_bpc, 8, state->max_bpc);
+
+	if (!connector->link_bpc_property)
+		return;
+
+	if (bpc != state->link_bpc)
+		drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] Clamping link bpc from %u to %u\n",
+			    connector->base.id, connector->name, state->link_bpc, bpc);
+
+	drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] Setting state link bpc %u\n",
+				     connector->base.id, connector->name, bpc);
+	drm_object_property_set_value(&connector->base, connector->link_bpc_property,
+				      bpc);
+
+	drm_sysfs_connector_property_event(connector,
+					   connector->link_bpc_property);
+}
+EXPORT_SYMBOL(drm_connector_update_link_bpc_property);
+
 /**
  * drmm_connector_hdmi_init - Init a preallocated HDMI connector
  * @dev: DRM device
@@ -624,6 +693,10 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	drm_connector_attach_max_bpc_property(connector, 8, max_bpc);
 	connector->max_bpc = max_bpc;
 
+	ret = drm_connector_attach_link_bpc_property(connector, max_bpc);
+	if (ret)
+		return ret;
+
 	if (max_bpc > 8)
 		drm_connector_attach_hdr_output_metadata_property(connector);
 
@@ -1713,6 +1786,19 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
  *	drm_connector_attach_max_bpc_property() to create and attach the
  *	property to the connector during initialization.
  *
+ * link bpc:
+ *	This immutable range property can be used by userspace to determine the
+ *	current display link's bit depth. Drivers can use
+ *	drm_connector_attach_link_bpc_property() to create and attach the
+ *	property to the connector during initialization. They can then set the
+ *	&drm_connector_state.link_bpc member to the actual output bit depth
+ *	after any degradation. The drm property will be updated to this member's
+ *	value on the next atomic commit, and if it changed, a uevent will be
+ *	fired.
+ *	Userspace can listen to the uevent to be notified of link bpc changes,
+ *	and compare the property's value to what userspace requested to
+ *	determine whether colour depth has been degraded.
+ *
  * Connectors also have one standardized atomic property:
  *
  * CRTC_ID:
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c18be8c19de0..3c339a9840c9 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1132,6 +1132,11 @@ struct drm_connector_state {
 	 */
 	u8 max_bpc;
 
+	/**
+	 * @link_bpc: Current display link's bits-per-component.
+	 */
+	u8 link_bpc;
+
 	/**
 	 * @privacy_screen_sw_state: See :ref:`Standard Connector
 	 * Properties<standard_connector_properties>`
@@ -2124,6 +2129,12 @@ struct drm_connector {
 	 */
 	struct drm_property *max_bpc_property;
 
+	/**
+	 * @link_bpc_property: Connector property that reflects the current
+	 * output bits per component.
+	 */
+	struct drm_property *link_bpc_property;
+
 	/** @privacy_screen: drm_privacy_screen for this connector, or NULL. */
 	struct drm_privacy_screen *privacy_screen;
 
@@ -2534,6 +2545,11 @@ void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv);
 void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
 
+int drm_connector_attach_link_bpc_property(struct drm_connector *connector,
+					   unsigned int max_bpc);
+void drm_connector_update_link_bpc_property(struct drm_connector *connector,
+					    struct drm_connector_state *state);
+
 /**
  * struct drm_tile_group - Tile group metadata
  * @refcount: reference count

-- 
2.53.0

