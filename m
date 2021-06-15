Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C13C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 14:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24865613DA
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 14:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24865613DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957066E409;
	Tue, 15 Jun 2021 14:14:44 +0000 (UTC)
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C806E3DB;
 Tue, 15 Jun 2021 14:14:40 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 0C8F0C800B5;
 Tue, 15 Jun 2021 16:14:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id BvmnZNI_tOo8; Tue, 15 Jun 2021 16:14:38 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box
 (p200300e37F3949009F7CF2Abd5Da2787.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f39:4900:9f7c:f2ab:d5da:2787])
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPA id 9F9DDC80095;
 Tue, 15 Jun 2021 16:14:38 +0200 (CEST)
From: Werner Sembach <wse@tuxedocomputers.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v3 13/14] drm/amd/display: Add handling for new "preferred
 color format" property
Date: Tue, 15 Jun 2021 16:14:24 +0200
Message-Id: <20210615141426.6001-14-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141426.6001-1-wse@tuxedocomputers.com>
References: <20210615141426.6001-1-wse@tuxedocomputers.com>
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

This commit implements the "preferred color format" drm property for the AMD GPU
driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++++++-----
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 ++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 705cd2e015af..ead246b2ec57 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5351,15 +5351,26 @@ static void fill_stream_properties_from_drm_display_mode(
 	timing_out->h_border_right = 0;
 	timing_out->v_border_top = 0;
 	timing_out->v_border_bottom = 0;
-	/* TODO: un-hardcode */
-	if (drm_mode_is_420_only(info, mode_in)
-			|| (drm_mode_is_420_also(info, mode_in) && aconnector->force_yuv420_output))
+
+	if (connector_state && (connector_state->preferred_color_format == DRM_COLOR_FORMAT_YCRCB420
+			|| aconnector->force_yuv420_output) && drm_mode_is_420(info, mode_in))
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCRCB444)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+	else if (connector_state && connector_state->preferred_color_format == DRM_COLOR_FORMAT_YCRCB444
+			&& connector->display_info.color_formats & DRM_COLOR_FORMAT_YCRCB444)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
-	else
+	else if (connector_state && connector_state->preferred_color_format == DRM_COLOR_FORMAT_RGB444
+			&& !drm_mode_is_420_only(info, mode_in))
 		timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
+	else /* connector_state->preferred_color_format not possible
+			|| connector_state->preferred_color_format == 0 (auto)
+			|| connector_state->preferred_color_format == DRM_COLOR_FORMAT_YCRCB422 */
+		if (drm_mode_is_420_only(info, mode_in))
+			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
+		else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCRCB444)
+				&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
+		else
+			timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
 
 	timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;
 	timing_out->display_color_depth = convert_color_depth_from_display_info(
@@ -7760,6 +7771,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	if (!aconnector->mst_port) {
 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
 		drm_connector_attach_active_bpc_property(&aconnector->base, 8, 16);
+		drm_connector_attach_preferred_color_format_property(&aconnector->base);
 		drm_connector_attach_active_color_format_property(&aconnector->base);
 		drm_connector_attach_active_color_range_property(&aconnector->base);
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index b5d57bbbdd20..2563788ba95a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -413,6 +413,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	if (connector->active_bpc_property)
 		drm_connector_attach_active_bpc_property(&aconnector->base, 8, 16);
 
+	connector->preferred_color_format_property = master->base.preferred_color_format_property;
+	if (connector->preferred_color_format_property)
+		drm_connector_attach_preferred_color_format_property(&aconnector->base);
+
 	connector->active_color_format_property = master->base.active_color_format_property;
 	if (connector->active_color_format_property)
 		drm_connector_attach_active_color_format_property(&aconnector->base);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
