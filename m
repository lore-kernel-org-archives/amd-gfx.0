Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7E1C54EBE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 14:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3ACD10E438;
	Mon,  9 Jan 2023 14:44:35 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 427B410E436;
 Mon,  9 Jan 2023 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cKIgQ2NkBMGH8emqa7YtqDB/L0xQKuwdjNrEqIF3P4M=; b=KydMXJYozSRjwD7sxmrNzx74C+
 RMz3tPCTbB6hNYG1aEeMkMGEAJLl8mjAsTqD/ewUWWEN1piHTlumNaX3yKfqdSRmJgnbXep+7GcEL
 75jfb/AilU3RnAbKzZNU/oMuaA5lrQmfhR5SInbLz9PhFdwzo5Tsj0kf2kNFDReaIdOAb1/3yk7oo
 2Gt3+ixBw9Ju92ttxATxODpwBvQel9wTng+5qq37UpRnFrf7MfzCtJ2VHmlSBl9yGR5I9eksK+H76
 o0V9quBXJG6DFp1WArCbriL876r71WmZHe8iLga0rc/QGK1OZjV6zTznB8ffpyc7YQA8yaDIrV28M
 hU+Er4dQ==;
Received: from [41.74.137.107] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pEtNs-003TyM-8H; Mon, 09 Jan 2023 15:44:20 +0100
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [RFC PATCH v2 12/18] drm/amd/display: acquire/release 3D LUT
 resources for ctx on DCN301
Date: Mon,  9 Jan 2023 13:38:40 -0100
Message-Id: <20230109143846.1966301-13-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109143846.1966301-1-mwen@igalia.com>
References: <20230109143846.1966301-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: laurent.pinchart+renesas@ideasonboard.com, kernel-dev@igalia.com,
 Shashank Sharma <shashank.sharma@amd.com>, alex.hung@amd.com,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 linux-kernel@vger.kernel.org, mripard@kernel.org,
 Melissa Wen <mwen@igalia.com>, seanpaul@chromium.org,
 ville.syrjala@linux.intel.com, tzimmermann@suse.de,
 amd-gfx@lists.freedesktop.org, bhawanpreet.lakha@amd.com,
 nicholas.kazlauskas@amd.com, Joshua Ashton <joshua@froggi.es>,
 sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acquire and release 3D LUT and shaper LUT every time we create/remove a
new ctx and add/remove stream to/from it. 3D LUT acquire/release can
fail and therefore we should check its availability during atomic check
considering the new context created not the current one.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/dcn301/dcn301_resource.c   | 47 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index ee62ae3eb98f..5bae0972bd5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1260,6 +1260,49 @@ static struct display_stream_compressor *dcn301_dsc_create(
 	return &dsc->base;
 }
 
+static enum dc_status
+dcn301_add_stream_to_ctx(struct dc *dc,
+			 struct dc_state *new_ctx,
+			 struct dc_stream_state *dc_stream)
+{
+	enum dc_status result = DC_ERROR_UNEXPECTED;
+	struct dc_3dlut *lut3d_func_new = NULL;
+	struct dc_transfer_func *func_shaper_new = NULL;
+
+	result = dcn20_add_stream_to_ctx(dc, new_ctx, dc_stream);
+	if (result != DC_OK)
+		return result;
+
+	if (!dc_acquire_release_mpc_3dlut_for_ctx(dc, true, new_ctx, dc_stream,
+						  &lut3d_func_new, &func_shaper_new))
+		return DC_ERROR_UNEXPECTED;
+
+	dc_stream->lut3d_func = lut3d_func_new;
+	dc_stream->func_shaper = func_shaper_new;
+
+	return DC_OK;
+}
+
+static enum dc_status
+dcn301_remove_stream_from_ctx(struct dc *dc,
+			      struct dc_state *new_ctx,
+			      struct dc_stream_state *dc_stream)
+{
+	struct dc_3dlut *lut3d_func;
+	struct dc_transfer_func *func_shaper;
+
+	lut3d_func = (struct dc_3dlut *)dc_stream->lut3d_func;
+	func_shaper = (struct dc_transfer_func *)dc_stream->func_shaper;
+
+	if (!dc_acquire_release_mpc_3dlut_for_ctx(dc, false, new_ctx, dc_stream,
+						  &lut3d_func, &func_shaper))
+		return DC_ERROR_UNEXPECTED;
+
+	dc_stream->lut3d_func = lut3d_func;
+	dc_stream->func_shaper = func_shaper;
+
+	return dcn20_remove_stream_from_ctx(dc, new_ctx, dc_stream);
+}
 
 static void dcn301_destroy_resource_pool(struct resource_pool **pool)
 {
@@ -1406,9 +1449,9 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
-	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
+	.add_stream_to_ctx = dcn301_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
-	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
+	.remove_stream_from_ctx = dcn301_remove_stream_from_ctx,
 	.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
 	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
-- 
2.35.1

