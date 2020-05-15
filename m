Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAF3C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7B020657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GDfYugOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7B020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 625D46ED2D;
	Fri, 15 May 2020 18:14:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8F56ED24
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz1SUX5ytHkAEtwLMHP2tNBE1mWIDg0Ri7Oe/a1NemKrCbsFuV5K8OfRyFI+TxZzb+SM6XtgUyk12n90DU7tuJ88RopTrX68Crk6GPoB7luFYmHfu7a78QaUtgyk53n/FpDR2gKnYT2RljmWP+FD1eF7kBf5bkW+jZH5jFJIGSsThA91dFRvbJy1WofhJpgK2XFVDm9tLGsJCkcatWFoWl5HrOS5s1xzUzVZSYRNQLv2PipHRs0iUOwMfD7sRMQI+GdGDiVQAH4TC7LYzK3OYNpcfhOM06kvvx7lGAhr+Fw5FB+71FfAT8avMLMPzhmFilsksAas5zppl26iCE7FIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBRFSHh6RheGEnm3OxmPUwhn/+MakalztIURuFEnyOI=;
 b=c5OciNvNinggwkDKalh3I0c+JIZxZV6aHGKpSVapGPybMPGqNOw5kM9gSTufQx2KAFqVz2NStIbVkKw82SU9nBreZ1XrU7et865AhlPKqLTI2MnV7G4cbsZAsUGLRgjoYtqW5IHrjJyZdkufTDOTfmZjmd/o0OLWzHhr14eisGgj79HUGq5KHZriUkWY1hWE2GNdlW9W4voNECnulUmQ7Gp4UZDo2H6iInFqpmGewMhIR0Wih50M8pGNymOs0xMOQQP7s6ODqEY2gA/pwYIcf1zHqGtufaQxQ/uI3U2/EE3ZWWv190pYFdSwdhquFEj5tTIofieFe2W131zgXuaeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBRFSHh6RheGEnm3OxmPUwhn/+MakalztIURuFEnyOI=;
 b=GDfYugOvQ+VuW8ZZUQCqPjU1lvoHEgYDtuewCanR99oFDZsSDLyHmJu2gGcGFt2lK8wx3AS0zpG60RvlwHdWwVS37uRDs4wRMBW7SbL970XHQ6phtfV29pRlbDdt+1PCbwOO4gt+VJF5wKFlmQLra1rEua+uMWhr0WkKhr4cP4U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 18:13:58 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:58 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/27] drm/amd/display: Fix incorrectly pruned modes with deep
 color
Date: Fri, 15 May 2020 14:13:07 -0400
Message-Id: <20200515181315.1237251-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:57 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ba43c27-efc4-4814-795f-08d7f8fbbc67
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848A8D98B78514C56980CF898BD0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kerYN8Kp/hgCWozJOeEyoU+fWDt2yY2J1Ol49YoP62WLPRJg4vgwwOWhLRlqHgn9Wv2LzCsSZRJTcKGpiLnohIdVG8hzNb8OP7E74PSPnAG8LzCa+XGKpnlYpwClGs2ZXYA2ryBZuv4fAV8fhvg9G8p7iYdSK2snMd25jubpiup3mviaoamougROiNAD9DPdSwKQpHXdOnAuX8QOgK0mTHdQvCHP6MNZWL4jzPEw8qOdDUvEYRkiQkt/Dxfi53zn0xspIyWgUHNLxSQJ/A16o7fOg5mBpbXFNNbTyjLpzV+LtOoZG5iseJ58WSm5oPnH29vh8g00JTWVvGMewjH8VvaeJGhl3jeSsX6jSDVdCSfnWW0M601BSrbOkH1eECOwOOiV+t38FvpbwU5+p20wsRdVUotjujW1Itx0QJLaQj7DVGuUo6Ocsyh6QcbJb6UH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(86362001)(2906002)(186003)(8936002)(52116002)(6506007)(6512007)(8676002)(36756003)(316002)(5660300002)(16526019)(4326008)(6916009)(66556008)(478600001)(1076003)(66946007)(6486002)(66476007)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5QNGP1TitUT1qoMk7kmY8o0dYNAR9tq2aru15CK2DbEjWjj89eGkQrTHNd2X3LIpkFnZiN6kHRF9xADsiqztL562rPf3Va3HqHJeDKZgWPhp7OHGHnBN5yPYoDDD5+qjUSUuQ6iTaH/0jPzmPsHimfEqBVQSIZHDU9QdtbDOwjsyJXvrjdRM0Nr4SDegZPiln2E0JlPMtyXs075fnZ+QQQKKWhJZp8mrxcsWvKtGbaqlY9lRRq3tfa6ABYvQGGUUBHGGrhUv7x4mImU7Y1iiUkDJjbPm/TXfOLepf2wmdCaWUD2qnrht3JNUaJHinomrw02RS18JnX+2SD/D3D+qyd6prRwF/dN4QlCLeIxQhzyeYOwbEYFAHU1O6tWl5n+bLDYpqBmR7wNBbVI/GwspTicS34uSm2oyFY6JfAbtSTstXXZeDiHgozkOZVp8ndpgOAK2LMYKKYpZljCFIjbJdVQMMUT9j8ax5zOnqhKh4iEGlSgorOOUQvZxWEqwlSxp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba43c27-efc4-4814-795f-08d7f8fbbc67
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:57.9747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVqS/LxqefYzZREW2FiZDYbxNEobRPO+gdgMdGL5eOmQ2ZVao0JjELRjKaEnQsgyEOU46vyJLhmo03QtItvkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
When "max bpc" is set to enable deep color, some modes are removed from
the list if they fail validation on max bpc. These modes should be kept
if they validates fine with lower bpc.

[How]
- Retry with lower bpc in mode validation.
- Same in atomic commit to apply working bpc, not necessarily max bpc.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 102 +++++++++++-------
 1 file changed, 64 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d2bb0d9839c9..2c3a443771ea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3895,8 +3895,7 @@ static void update_stream_scaling_settings(const struct drm_display_mode *mode,
 
 static enum dc_color_depth
 convert_color_depth_from_display_info(const struct drm_connector *connector,
-				      const struct drm_connector_state *state,
-				      bool is_y420)
+				      bool is_y420, int requested_bpc)
 {
 	uint8_t bpc;
 
@@ -3916,10 +3915,7 @@ convert_color_depth_from_display_info(const struct drm_connector *connector,
 		bpc = bpc ? bpc : 8;
 	}
 
-	if (!state)
-		state = connector->state;
-
-	if (state) {
+	if (requested_bpc > 0) {
 		/*
 		 * Cap display bpc based on the user requested value.
 		 *
@@ -3928,7 +3924,7 @@ convert_color_depth_from_display_info(const struct drm_connector *connector,
 		 * or if this was called outside of atomic check, so it
 		 * can't be used directly.
 		 */
-		bpc = min(bpc, state->max_requested_bpc);
+		bpc = min_t(u8, bpc, requested_bpc);
 
 		/* Round down to the nearest even number. */
 		bpc = bpc - (bpc & 1);
@@ -4050,7 +4046,8 @@ static void fill_stream_properties_from_drm_display_mode(
 	const struct drm_display_mode *mode_in,
 	const struct drm_connector *connector,
 	const struct drm_connector_state *connector_state,
-	const struct dc_stream_state *old_stream)
+	const struct dc_stream_state *old_stream,
+	int requested_bpc)
 {
 	struct dc_crtc_timing *timing_out = &stream->timing;
 	const struct drm_display_info *info = &connector->display_info;
@@ -4080,8 +4077,9 @@ static void fill_stream_properties_from_drm_display_mode(
 
 	timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;
 	timing_out->display_color_depth = convert_color_depth_from_display_info(
-		connector, connector_state,
-		(timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420));
+		connector,
+		(timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420),
+		requested_bpc);
 	timing_out->scan_type = SCANNING_TYPE_NODATA;
 	timing_out->hdmi_vic = 0;
 
@@ -4287,7 +4285,8 @@ static struct dc_stream_state *
 create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		       const struct drm_display_mode *drm_mode,
 		       const struct dm_connector_state *dm_state,
-		       const struct dc_stream_state *old_stream)
+		       const struct dc_stream_state *old_stream,
+		       int requested_bpc)
 {
 	struct drm_display_mode *preferred_mode = NULL;
 	struct drm_connector *drm_connector;
@@ -4372,10 +4371,10 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	*/
 	if (!scale || mode_refresh != preferred_refresh)
 		fill_stream_properties_from_drm_display_mode(stream,
-			&mode, &aconnector->base, con_state, NULL);
+			&mode, &aconnector->base, con_state, NULL, requested_bpc);
 	else
 		fill_stream_properties_from_drm_display_mode(stream,
-			&mode, &aconnector->base, con_state, old_stream);
+			&mode, &aconnector->base, con_state, old_stream, requested_bpc);
 
 	stream->timing.flags.DSC = 0;
 
@@ -4907,16 +4906,54 @@ static void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 	create_eml_sink(aconnector);
 }
 
+static struct dc_stream_state *
+create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
+				const struct drm_display_mode *drm_mode,
+				const struct dm_connector_state *dm_state,
+				const struct dc_stream_state *old_stream)
+{
+	struct drm_connector *connector = &aconnector->base;
+	struct amdgpu_device *adev = connector->dev->dev_private;
+	struct dc_stream_state *stream;
+	int requested_bpc = connector->state ? connector->state->max_requested_bpc : 8;
+	enum dc_status dc_result = DC_OK;
+
+	do {
+		stream = create_stream_for_sink(aconnector, drm_mode,
+						dm_state, old_stream,
+						requested_bpc);
+		if (stream == NULL) {
+			DRM_ERROR("Failed to create stream for sink!\n");
+			break;
+		}
+
+		dc_result = dc_validate_stream(adev->dm.dc, stream);
+
+		if (dc_result != DC_OK) {
+			DRM_DEBUG_KMS("Mode %dx%d (clk %d) failed DC validation with error %d\n",
+				      drm_mode->hdisplay,
+				      drm_mode->vdisplay,
+				      drm_mode->clock,
+				      dc_result);
+
+			dc_stream_release(stream);
+			stream = NULL;
+			requested_bpc -= 2; /* lower bpc to retry validation */
+		}
+
+	} while (stream == NULL && requested_bpc >= 6);
+
+	return stream;
+}
+
 enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
 				   struct drm_display_mode *mode)
 {
 	int result = MODE_ERROR;
 	struct dc_sink *dc_sink;
-	struct amdgpu_device *adev = connector->dev->dev_private;
 	/* TODO: Unhardcode stream count */
 	struct dc_stream_state *stream;
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
-	enum dc_status dc_result = DC_OK;
 
 	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) ||
 			(mode->flags & DRM_MODE_FLAG_DBLSCAN))
@@ -4937,24 +4974,11 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 		goto fail;
 	}
 
-	stream = create_stream_for_sink(aconnector, mode, NULL, NULL);
-	if (stream == NULL) {
-		DRM_ERROR("Failed to create stream for sink!\n");
-		goto fail;
-	}
-
-	dc_result = dc_validate_stream(adev->dm.dc, stream);
-
-	if (dc_result == DC_OK)
+	stream = create_validate_stream_for_sink(aconnector, mode, NULL, NULL);
+	if (stream) {
+		dc_stream_release(stream);
 		result = MODE_OK;
-	else
-		DRM_DEBUG_KMS("Mode %dx%d (clk %d) failed DC validation with error %d\n",
-			      mode->hdisplay,
-			      mode->vdisplay,
-			      mode->clock,
-			      dc_result);
-
-	dc_stream_release(stream);
+	}
 
 fail:
 	/* TODO: error handling*/
@@ -5277,10 +5301,12 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 		return 0;
 
 	if (!state->duplicated) {
+		int max_bpc = conn_state->max_requested_bpc;
 		is_y420 = drm_mode_is_420_also(&connector->display_info, adjusted_mode) &&
 				aconnector->force_yuv420_output;
-		color_depth = convert_color_depth_from_display_info(connector, conn_state,
-								    is_y420);
+		color_depth = convert_color_depth_from_display_info(connector,
+								    is_y420,
+								    max_bpc);
 		bpp = convert_dc_color_depth_into_bpc(color_depth) * 3;
 		clock = adjusted_mode->clock;
 		dm_new_connector_state->pbn = drm_dp_calc_pbn_mode(clock, bpp, false);
@@ -7711,10 +7737,10 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 			goto skip_modeset;
 
-		new_stream = create_stream_for_sink(aconnector,
-						     &new_crtc_state->mode,
-						    dm_new_conn_state,
-						    dm_old_crtc_state->stream);
+		new_stream = create_validate_stream_for_sink(aconnector,
+							     &new_crtc_state->mode,
+							     dm_new_conn_state,
+							     dm_old_crtc_state->stream);
 
 		/*
 		 * we can have no stream on ACTION_SET if a display
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
