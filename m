Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A3C4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 17:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDC361370
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 17:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDC361370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC1C6EC2A;
	Tue,  8 Jun 2021 17:43:31 +0000 (UTC)
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695536E5B4;
 Tue,  8 Jun 2021 17:43:29 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 1C1ECC800E2;
 Tue,  8 Jun 2021 19:43:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id I1n8CnyppzqO; Tue,  8 Jun 2021 19:43:27 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box
 (p200300E37f4F60006a44b0068bFE089d.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f4f:6000:6a44:b006:8bfe:89d])
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPA id B3080C800EC;
 Tue,  8 Jun 2021 19:43:27 +0200 (CEST)
From: Werner Sembach <wse@tuxedocomputers.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 6/7] drm/amd/display: Add handling for new "active color
 format" property
Date: Tue,  8 Jun 2021 19:43:19 +0200
Message-Id: <20210608174320.37429-7-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608174320.37429-1-wse@tuxedocomputers.com>
References: <20210608174320.37429-1-wse@tuxedocomputers.com>
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

This commit implements the "active color format" drm property for the AMD GPU
driver.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 +++++++++++++++++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  1 +
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e57b2b743d36..019be46def1d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6525,6 +6525,23 @@ static int convert_dc_color_depth_into_bpc (enum dc_color_depth display_color_de
 	return 0;
 }
 
+static int convert_dc_pixel_encoding_into_drm_color_format(enum dc_pixel_encoding display_pixel_encoding)
+{
+	switch (display_pixel_encoding) {
+		case PIXEL_ENCODING_RGB:
+			return DRM_COLOR_FORMAT_RGB444;
+		case PIXEL_ENCODING_YCBCR422:
+			return DRM_COLOR_FORMAT_YCRCB422;
+		case PIXEL_ENCODING_YCBCR444:
+			return DRM_COLOR_FORMAT_YCRCB444;
+		case PIXEL_ENCODING_YCBCR420:
+			return DRM_COLOR_FORMAT_YCRCB420;
+		default:
+			break;
+		}
+	return 0;
+}
+
 static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 					  struct drm_crtc_state *crtc_state,
 					  struct drm_connector_state *conn_state)
@@ -7522,6 +7539,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	if (!aconnector->mst_port) {
 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
 		drm_connector_attach_active_bpc_property(&aconnector->base, 8, 16);
+		drm_connector_attach_active_color_format_property(&aconnector->base);
 	}
 
 	/* This defaults to the max in the range, but we want 8bpc for non-edp. */
@@ -8898,12 +8916,17 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		if (crtc) {
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 			dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-			if (dm_new_crtc_state->stream)
+			if (dm_new_crtc_state->stream) {
 				new_con_state->active_bpc = convert_dc_color_depth_into_bpc(
 					dm_new_crtc_state->stream->timing.display_color_depth);
+				new_con_state->active_color_format = convert_dc_pixel_encoding_into_drm_color_format(
+					dm_new_crtc_state->stream->timing.pixel_encoding);
+			}
 		}
-		else
+		else {
 			new_con_state->active_bpc = 0;
+			new_con_state->active_color_format = 0;
+		}
 	}
 
 	/* Count number of newly disabled CRTCs for dropping PM refs later. */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 2a8dc6b2c6c7..f68950da9ff8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -400,6 +400,7 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	if (connector->max_bpc_property) {
 		drm_connector_attach_max_bpc_property(connector, 8, 16);
 		drm_connector_attach_active_bpc_property(&aconnector->base, 8, 16);
+		drm_connector_attach_active_color_format_property(&aconnector->base);
 	}
 
 	connector->vrr_capable_property = master->base.vrr_capable_property;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
