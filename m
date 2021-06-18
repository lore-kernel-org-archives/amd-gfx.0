Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7136C49EBF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 09:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B701360FD8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 09:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B701360FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933E06E9E8;
	Fri, 18 Jun 2021 09:11:50 +0000 (UTC)
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7DE76E9D8;
 Fri, 18 Jun 2021 09:11:48 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id AA9C3C800B9;
 Fri, 18 Jun 2021 11:11:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id K4gE7Xv2qCCa; Fri, 18 Jun 2021 11:11:47 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box
 (p200300e37f3949001760E5710682cA7E.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f39:4900:1760:e571:682:ca7e])
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPA id 4F361C800B7;
 Fri, 18 Jun 2021 11:11:47 +0200 (CEST)
From: Werner Sembach <wse@tuxedocomputers.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 17/17] drm/amd/display: Add handling for new "Broadcast
 RGB" property
Date: Fri, 18 Jun 2021 11:11:16 +0200
Message-Id: <20210618091116.14428-18-wse@tuxedocomputers.com>
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

This commit implements the "Broadcast RGB" drm property for the AMD GPU
driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++++-----
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 ++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9ffd2f9d3d75..c5dbf948a47a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5252,7 +5252,8 @@ get_aspect_ratio(const struct drm_display_mode *mode_in)
 }
 
 static enum dc_color_space
-get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
+get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
+		       enum drm_mode_color_range preferred_color_range)
 {
 	enum dc_color_space color_space = COLOR_SPACE_SRGB;
 
@@ -5267,13 +5268,17 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
 		 * respectively
 		 */
 		if (dc_crtc_timing->pix_clk_100hz > 270300) {
-			if (dc_crtc_timing->flags.Y_ONLY)
+			if (dc_crtc_timing->flags.Y_ONLY
+					|| preferred_color_range ==
+						DRM_MODE_COLOR_RANGE_LIMITED_16_235)
 				color_space =
 					COLOR_SPACE_YCBCR709_LIMITED;
 			else
 				color_space = COLOR_SPACE_YCBCR709;
 		} else {
-			if (dc_crtc_timing->flags.Y_ONLY)
+			if (dc_crtc_timing->flags.Y_ONLY
+					|| preferred_color_range ==
+						DRM_MODE_COLOR_RANGE_LIMITED_16_235)
 				color_space =
 					COLOR_SPACE_YCBCR601_LIMITED;
 			else
@@ -5283,7 +5288,10 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
 	}
 	break;
 	case PIXEL_ENCODING_RGB:
-		color_space = COLOR_SPACE_SRGB;
+		if (preferred_color_range == DRM_MODE_COLOR_RANGE_LIMITED_16_235)
+			color_space = COLOR_SPACE_SRGB_LIMITED;
+		else
+			color_space = COLOR_SPACE_SRGB;
 		break;
 
 	default:
@@ -5429,7 +5437,10 @@ static void fill_stream_properties_from_drm_display_mode(
 
 	timing_out->aspect_ratio = get_aspect_ratio(mode_in);
 
-	stream->output_color_space = get_output_color_space(timing_out);
+	stream->output_color_space = get_output_color_space(timing_out,
+							    connector_state ?
+							    connector_state->preferred_color_range :
+							    DRM_MODE_COLOR_RANGE_UNSET);
 
 	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
 	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
@@ -7780,6 +7791,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		drm_connector_attach_active_bpc_property(&aconnector->base, 8, 16);
 		drm_connector_attach_preferred_color_format_property(&aconnector->base);
 		drm_connector_attach_active_color_format_property(&aconnector->base);
+		drm_connector_attach_preferred_color_range_property(&aconnector->base);
 		drm_connector_attach_active_color_range_property(&aconnector->base);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 2563788ba95a..80e1389fd0ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -421,6 +421,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	if (connector->active_color_format_property)
 		drm_connector_attach_active_color_format_property(&aconnector->base);
 
+	connector->preferred_color_range_property = master->base.preferred_color_range_property;
+	if (connector->preferred_color_range_property)
+		drm_connector_attach_preferred_color_range_property(&aconnector->base);
+
 	connector->active_color_range_property = master->base.active_color_range_property;
 	if (connector->active_color_range_property)
 		drm_connector_attach_active_color_range_property(&aconnector->base);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
