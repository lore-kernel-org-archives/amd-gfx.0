Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE28C48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 09:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EE2613E9
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 09:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EE2613E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D8F6E9EC;
	Fri, 18 Jun 2021 09:11:47 +0000 (UTC)
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E9C6E9CB;
 Fri, 18 Jun 2021 09:11:42 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 8FF35C800B3;
 Fri, 18 Jun 2021 11:11:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id aIcyUF-kR98B; Fri, 18 Jun 2021 11:11:41 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box
 (p200300e37f3949001760E5710682cA7E.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f39:4900:1760:e571:682:ca7e])
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPA id 347DAC800BB;
 Fri, 18 Jun 2021 11:11:41 +0200 (CEST)
From: Werner Sembach <wse@tuxedocomputers.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 11/17] drm/i915/display: Add handling for new "active color
 range" property
Date: Fri, 18 Jun 2021 11:11:10 +0200
Message-Id: <20210618091116.14428-12-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618091116.14428-1-wse@tuxedocomputers.com>
References: <20210618091116.14428-1-wse@tuxedocomputers.com>
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

This commit implements the "active color range" drm property for the Intel
GPU driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 6 ++++++
 drivers/gpu/drm/i915/display/intel_dp.c      | 2 ++
 drivers/gpu/drm/i915/display/intel_dp_mst.c  | 5 +++++
 drivers/gpu/drm/i915/display/intel_hdmi.c    | 1 +
 4 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 57bec7f452d8..3d0bdca70c6a 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -10938,9 +10938,15 @@ static int intel_atomic_commit(struct drm_device *dev,
 			drm_connector_set_active_color_format_property(connector,
 				convert_intel_output_format_into_drm_color_format(
 					new_crtc_state->output_format));
+			drm_connector_set_active_color_range_property(connector,
+				new_crtc_state->limited_color_range ?
+					DRM_MODE_COLOR_RANGE_LIMITED_16_235 :
+					DRM_MODE_COLOR_RANGE_FULL);
 		} else {
 			drm_connector_set_active_bpc_property(connector, 0);
 			drm_connector_set_active_color_format_property(connector, 0);
+			drm_connector_set_active_color_range_property(connector,
+								      DRM_MODE_COLOR_RANGE_UNSET);
 		}
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 9204bc14590a..214010f7cbec 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4692,10 +4692,12 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
 		drm_connector_attach_max_bpc_property(connector, 6, 10);
 		drm_connector_attach_active_bpc_property(connector, 6, 10);
 		drm_connector_attach_active_color_format_property(connector);
+		drm_connector_attach_active_color_range_property(connector);
 	} else if (DISPLAY_VER(dev_priv) >= 5) {
 		drm_connector_attach_max_bpc_property(connector, 6, 12);
 		drm_connector_attach_active_bpc_property(connector, 6, 12);
 		drm_connector_attach_active_color_format_property(connector);
+		drm_connector_attach_active_color_range_property(connector);
 	}
 
 	/* Register HDMI colorspace for case of lspcon */
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 3e4237df3360..cb876175258f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -861,6 +861,11 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
 	if (connector->active_color_format_property)
 		drm_connector_attach_active_color_format_property(connector);
 
+	connector->active_color_range_property =
+		intel_dp->attached_connector->base.active_color_range_property;
+	if (connector->active_color_range_property)
+		drm_connector_attach_active_color_range_property(connector);
+
 	return connector;
 
 err:
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 367aba57b55f..dacac23a6c30 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2517,6 +2517,7 @@ intel_hdmi_add_properties(struct intel_hdmi *intel_hdmi, struct drm_connector *c
 		drm_connector_attach_max_bpc_property(connector, 8, 12);
 		drm_connector_attach_active_bpc_property(connector, 8, 12);
 		drm_connector_attach_active_color_format_property(connector);
+		drm_connector_attach_active_color_range_property(connector);
 	}
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
