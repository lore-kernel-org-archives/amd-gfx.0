Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB59DC47079
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 18:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC4910E4DB;
	Tue,  9 Jan 2024 18:11:50 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2980710E4B8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 18:11:39 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e4d1e0e5eso12117735e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jan 2024 10:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1704823897; x=1705428697; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEKXGZp6/dSPIf69wGEjjsLtzr50iEJJm//VReGTJdM=;
 b=e7dVL4/9X3KP6AOHyICkULy/Vrx+951G8CI5+K1pg280zwgVt+VRSVg214a29EEATp
 AGSiEjzySUQlodBdHmGLS68Oxwga52epfKxNHNPvXrGk4s7mBhuCb5gueUNWQmhCUESY
 GTcVkjaWuMBV3kRMwPLoz3dJPNBpAn6WvXrGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823897; x=1705428697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEKXGZp6/dSPIf69wGEjjsLtzr50iEJJm//VReGTJdM=;
 b=vkyUju7ywfMU4F6tWULgNGqBIxJkBqjd/+H7C207I84AH0ZLeGR2ju5NPmuliRb/7X
 KwmUOOCgGkMeoY8lyC914LLoLVvEZoPN/a8S/ZncnsufILjyAFp7Jlr94UvWdcdJ3hJN
 vdK/gr732xkP3aDkWiKs8XC0EV4/TAm5g47Ihg21wBcLx4t0JydzHwYFGJtozC8Bq/Fv
 SJSKEGWQWyPYmN4SwpLee3aMmaUJ/61WjVt6s3RDO9V9ThEfyodY+uckfCnumNnlZZgI
 iEToQOtp8iV9iy6MsbqXwFhXwXOulRr2jVRLpsxpDTMtd7O8tUZJx/2tMqZfdA5thWUB
 gFDA==
X-Gm-Message-State: AOJu0Yy2EaIXkLNBOAH+Q6fG9tLKskFCXBoaz7HXbwjDtJ9jugOLShiM
 uIuMitvuzccF1KvcfD6xd7+9X4JzOqCXBQ==
X-Google-Smtp-Source: AGHT+IGPmvdUO8SXjXgKV/aQCxeStLpIIPvoeykWdqZkiW7Qc5Us/N/1WUFwWDhYHwAEHPNbOA3kGg==
X-Received: by 2002:a05:600c:228d:b0:40e:4579:9eb1 with SMTP id
 13-20020a05600c228d00b0040e45799eb1mr2208339wmf.1.1704823897680; 
 Tue, 09 Jan 2024 10:11:37 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com
 ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c3b9900b0040e527602c8sm2104579wms.9.2024.01.09.10.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 10:11:37 -0800 (PST)
From: Andri Yngvason <andri@yngvason.is>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: [PATCH 4/7] drm/i915/display: Add handling for new "active color
 format" property
Date: Tue,  9 Jan 2024 18:11:01 +0000
Message-ID: <20240109181104.1670304-5-andri@yngvason.is>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109181104.1670304-1-andri@yngvason.is>
References: <20240109181104.1670304-1-andri@yngvason.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 09 Jan 2024 18:11:48 +0000
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
Cc: amd-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Werner Sembach <wse@tuxedocomputers.com>, Andri Yngvason <andri@yngvason.is>,
 dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Werner Sembach <wse@tuxedocomputers.com>

This commit implements the "active color format" drm property for the Intel
GPU driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Tested-by: Andri Yngvason <andri@yngvason.is>
---
 drivers/gpu/drm/i915/display/intel_display.c | 33 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c      |  7 +++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c  |  5 +++
 drivers/gpu/drm/i915/display/intel_hdmi.c    |  4 ++-
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index df582ff81b45f..79cc258db8f09 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7167,6 +7167,21 @@ static void intel_atomic_prepare_plane_clear_colors(struct intel_atomic_state *s
 	}
 }
 
+static int convert_intel_output_format_into_drm_color_format(enum intel_output_format output_format)
+{
+	switch (output_format) {
+	case INTEL_OUTPUT_FORMAT_RGB:
+		return DRM_COLOR_FORMAT_RGB444;
+	case INTEL_OUTPUT_FORMAT_YCBCR420:
+		return DRM_COLOR_FORMAT_YCBCR420;
+	case INTEL_OUTPUT_FORMAT_YCBCR444:
+		return DRM_COLOR_FORMAT_YCBCR444;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static void intel_atomic_commit_tail(struct intel_atomic_state *state)
 {
 	struct drm_device *dev = state->base.dev;
@@ -7438,6 +7453,9 @@ int intel_atomic_commit(struct drm_device *dev, struct drm_atomic_state *_state,
 {
 	struct intel_atomic_state *state = to_intel_atomic_state(_state);
 	struct drm_i915_private *dev_priv = to_i915(dev);
+	struct drm_connector *connector;
+	struct drm_connector_state *new_conn_state;
+	int i;
 	int ret = 0;
 
 	state->wakeref = intel_runtime_pm_get(&dev_priv->runtime_pm);
@@ -7506,6 +7524,21 @@ int intel_atomic_commit(struct drm_device *dev, struct drm_atomic_state *_state,
 	intel_shared_dpll_swap_state(state);
 	intel_atomic_track_fbs(state);
 
+	/* Extract information from crtc to communicate it to userspace as connector properties */
+	for_each_new_connector_in_state(&state->base, connector, new_conn_state, i) {
+		struct intel_crtc *crtc = to_intel_crtc(new_conn_state->crtc);
+
+		if (crtc) {
+			struct intel_crtc_state *new_crtc_state =
+				intel_atomic_get_new_crtc_state(state, crtc);
+
+			drm_connector_set_active_color_format_property(connector,
+				convert_intel_output_format_into_drm_color_format(
+					new_crtc_state->output_format));
+		} else
+			drm_connector_set_active_color_format_property(connector, 0);
+	}
+
 	drm_atomic_state_get(&state->base);
 	INIT_WORK(&state->base.commit_work, intel_atomic_commit_work);
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 62ce92772367f..c40fe8a847614 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5910,10 +5910,13 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 		intel_attach_force_audio_property(connector);
 
 	intel_attach_broadcast_rgb_property(connector);
-	if (HAS_GMCH(dev_priv))
+	if (HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 6, 10);
-	else if (DISPLAY_VER(dev_priv) >= 5)
+		drm_connector_attach_active_color_format_property(connector);
+	} else if (DISPLAY_VER(dev_priv) >= 5) {
 		drm_connector_attach_max_bpc_property(connector, 6, 12);
+		drm_connector_attach_active_color_format_property(connector);
+	}
 
 	/* Register HDMI colorspace for case of lspcon */
 	if (intel_bios_encoder_is_lspcon(dp_to_dig_port(intel_dp)->base.devdata)) {
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index aa10612626136..e7574ca0604e6 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1210,6 +1210,11 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
 		drm_dbg_kms(&dev_priv->drm, "[%s:%d] HDCP MST init failed, skipping.\n",
 			    connector->name, connector->base.id);
 
+	connector->active_color_format_property =
+		intel_dp->attached_connector->base.active_color_format_property;
+	if (connector->active_color_format_property)
+		drm_connector_attach_active_color_format_property(connector);
+
 	return connector;
 
 err:
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index bfa456fa7d25c..ce0221f90de92 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2611,8 +2611,10 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *c
 	if (DISPLAY_VER(dev_priv) >= 10)
 		drm_connector_attach_hdr_output_metadata_property(connector);
 
-	if (!HAS_GMCH(dev_priv))
+	if (!HAS_GMCH(dev_priv)) {
 		drm_connector_attach_max_bpc_property(connector, 8, 12);
+		drm_connector_attach_active_color_format_property(connector);
+	}
 }
 
 /*
-- 
2.43.0

