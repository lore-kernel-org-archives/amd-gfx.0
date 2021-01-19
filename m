Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D984C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 20:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF34823107
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 20:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF34823107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 583DD8918E;
	Tue, 19 Jan 2021 20:39:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67FF26E43C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 20:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUg+K6Ple7h29mVddXMgAUVVW9AmpyyJ7MB5nH1gybZssOFEz0RO7Q7TLIReuFgk37dnCjqUb7DnCX4qqn0wYpBXdzgHhTTTlEd48pZB/br0wR9M++NxWcLkioLYp5LBltD+DgyTzPDlG2C1fVgldZ0oWezo3GuG8fuc59XF2L3Bxyb/lv2PBEWgswwTh7vymDquPDI1drNGegrLrgcEt2pM9KHl/sCBmLbo0iifGLd3GvbCTFF5Fq+y358+oRKvIKYo2ktiMqyaboJQpbF3PWpew56zWmdgEMDi4vdlmqidymCTCAb09PiMPyWxTaVpB7uTIyK0frW7NW0fToqLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzNxqg1GPafyIiAL3U9gIuptbEzm+QMIlY4H2y1IaOE=;
 b=QmM8ifntqZgPDA9OvbxVmGQKLCECrZUM0quaSbF3VQd8lWOG1xmaRikxwpDbSVZpSt7Z/VMDcHghHnFcXpyMp5T57h6XfQQ25pXUfVllCu1rbvCy4EQUdrA+GhZdm5CurC1u1O+dCvx1rJKcy1ik9Apb8VUagdIiw4ogZZerh/4bvp2jhH+4OoDdAPPFdodckSJj54+Tp9WzokjahTMa6TXBzIfDMbTIDNlnpFPHlFbRDa0bXYr8gh48oLGwzGm+xNB9CrnqKwv1hLZSKglwgqVyv7cgS59rEIRx87Ggqx5nnzkpYvERY1SaFbGQGFUin4h2vLqkzrfOwe+CtwA6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzNxqg1GPafyIiAL3U9gIuptbEzm+QMIlY4H2y1IaOE=;
 b=AjJ6Nyhlupe5jpjY5Aq806j4/r26t0Twy2+GD2YpgqKtlXiRJRjm/ij7xwyGhJyPiB+Z8CNb0nmJCUNUF+z4f+KU1DOkVA7veXSdKkuB9bD5h2E9YVQ0RXoUlQMVKTk5UwyWv+6UQUAkBw73pC2CKEAWy+XAFzv22pHYh0YwB2s=
Received: from BN8PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:ac::19)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 19 Jan
 2021 20:39:52 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::f4) by BN8PR07CA0006.outlook.office365.com
 (2603:10b6:408:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Tue, 19 Jan 2021 20:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Tue, 19 Jan 2021 20:39:50 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 19 Jan
 2021 14:39:44 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 19 Jan 2021 14:39:44 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amd/display: Update
 dcn30_apply_idle_power_optimizations() code
Date: Tue, 19 Jan 2021 15:38:10 -0500
Message-ID: <20210119203810.2667860-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119203810.2667860-1-Bhawanpreet.Lakha@amd.com>
References: <20210119203810.2667860-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 913df155-8311-4613-ec86-08d8bcba5e58
X-MS-TrafficTypeDiagnostic: BY5PR12MB4068:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4068FBFCC65AEAC83D199BB0F9A30@BY5PR12MB4068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:225;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnxIE9NDTYy1sAQNEWCopDYKrMVLJI3NUoSFrvY2VlZYeUOepTUhuFquoBD4kz5Igc3Pf8XswVBqCNOauPVNHS3pa80dFP0uGaQ2l6iYarDGvstk/wPPhpDjZ6g0sRsV1DwcLri7ooagCL4QDkbLYdKtMrmME75tPrJfRwUvGk8E8pelgUS9bI9RbLBUc2mVG5GkRlreCpkQ0OO7xleRFHISemqYgRZcY/Pnnhp3aonhLKh87g+JVGgAdkbl9NswfeznEk/BSqZaoc4wadFUcgh8kqdLqgJx0XC3N7EeUuNXaLgywW90aTiYNHaVSkAjBMpst6suHLhq6Ewms+tYsSjHlW+1Lgx9OmEOfsqUjeWOYzZHqAQHPZM3KVuSwOL5wqsMQ2GSmO5AXJ2joYVIWps8sotFprKm2O2HDHldQzZnwXQ4fmnhVoVvxPN0HQr1YljvCyTthnL+MCtj4Hh5xxaXJ9aj6dhO5OYVuMKb+j9EVdm2G6vtwBN/mP9ym60Hhhc7sS9Rgn9hRt4NdkIIYApib6S1bKGOLoFGWNtOXXHvt3SUwodT6iwKdnWuRM3AoumRh7hrDYfAreKE22zVfxTUZdjaoONCGlqqccy1i8w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(478600001)(356005)(81166007)(83380400001)(6636002)(86362001)(36756003)(336012)(82740400003)(186003)(426003)(7696005)(70586007)(2616005)(26005)(110136005)(1076003)(82310400003)(30864003)(8936002)(54906003)(47076005)(6666004)(2906002)(5660300002)(15650500001)(4326008)(316002)(8676002)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 20:39:50.5310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 913df155-8311-4613-ec86-08d8bcba5e58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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
Cc: Joshua Aberback <joshua.aberback@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the function for idle optimizations
-remove hardcoded size
-enable no memory-request case
-add cursor copy
-update mall eligibility check case

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 157 +++++++++++++-----
 .../amd/display/dc/dcn302/dcn302_resource.c   |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +
 4 files changed, 129 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e21d4602e427..71d46ade24e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -502,6 +502,8 @@ struct dc_debug_options {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool disable_idle_power_optimizations;
 	unsigned int mall_size_override;
+	unsigned int mall_additional_timer_percent;
+	bool mall_error_as_fatal;
 #endif
 	bool dmub_command_table; /* for testing only */
 	struct dc_bw_validation_profile bw_val_profile;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 5c546b06f551..dff83c6a142a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -710,8 +710,11 @@ void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx)
 bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
 	union dmub_rb_cmd cmd;
-	unsigned int surface_size, refresh_hz, denom;
 	uint32_t tmr_delay = 0, tmr_scale = 0;
+	struct dc_cursor_attributes cursor_attr;
+	bool cursor_cache_enable = false;
+	struct dc_stream_state *stream = NULL;
+	struct dc_plane_state *plane = NULL;
 
 	if (!dc->ctx->dmub_srv)
 		return false;
@@ -722,72 +725,150 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 			/* First, check no-memory-requests case */
 			for (i = 0; i < dc->current_state->stream_count; i++) {
-				if (dc->current_state->stream_status[i]
-					    .plane_count)
+				if (dc->current_state->stream_status[i].plane_count)
 					/* Fail eligibility on a visible stream */
 					break;
 			}
 
-			if (dc->current_state->stream_count == 1 // single display only
-			    && dc->current_state->stream_status[0].plane_count == 1 // single surface only
-			    && dc->current_state->stream_status[0].plane_states[0]->address.page_table_base.quad_part == 0 // no VM
-			    // Only 8 and 16 bit formats
-			    && dc->current_state->stream_status[0].plane_states[0]->format <= SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F
-			    && dc->current_state->stream_status[0].plane_states[0]->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB8888) {
-				surface_size = dc->current_state->stream_status[0].plane_states[0]->plane_size.surface_pitch *
-					dc->current_state->stream_status[0].plane_states[0]->plane_size.surface_size.height *
-					(dc->current_state->stream_status[0].plane_states[0]->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ?
-					 8 : 4);
-			} else {
-				// TODO: remove hard code size
-				surface_size = 128 * 1024 * 1024;
+			if (i == dc->current_state->stream_count) {
+				/* Enable no-memory-requests case */
+				memset(&cmd, 0, sizeof(cmd));
+				cmd.mall.header.type = DMUB_CMD__MALL;
+				cmd.mall.header.sub_type = DMUB_CMD__MALL_ACTION_NO_DF_REQ;
+				cmd.mall.header.payload_bytes = sizeof(cmd.mall) - sizeof(cmd.mall.header);
+
+				dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
+				dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
+
+				return true;
 			}
 
-			// TODO: remove hard code size
-			if (surface_size < 128 * 1024 * 1024) {
-				refresh_hz = div_u64((unsigned long long) dc->current_state->streams[0]->timing.pix_clk_100hz *
-						     100LL,
-						     (dc->current_state->streams[0]->timing.v_total *
-						      dc->current_state->streams[0]->timing.h_total));
+			stream = dc->current_state->streams[0];
+			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
+
+			if (stream && plane) {
+				cursor_cache_enable = stream->cursor_position.enable &&
+						plane->address.grph.cursor_cache_addr.quad_part;
+				cursor_attr = stream->cursor_attributes;
+			}
+
+			/*
+			 * Second, check MALL eligibility
+			 *
+			 * single display only, single surface only, 8 and 16 bit formats only, no VM,
+			 * do not use MALL for displays that support PSR as they use D0i3.2 in DMCUB FW
+			 *
+			 * TODO: When we implement multi-display, PSR displays will be allowed if there is
+			 * a non-PSR display present, since in that case we can't do D0i3.2
+			 */
+			if (dc->current_state->stream_count == 1 &&
+					stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED &&
+					dc->current_state->stream_status[0].plane_count == 1 &&
+					plane->format <= SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F &&
+					plane->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB8888 &&
+					plane->address.page_table_base.quad_part == 0 &&
+					dc->hwss.does_plane_fit_in_mall &&
+					dc->hwss.does_plane_fit_in_mall(dc, plane,
+							cursor_cache_enable ? &cursor_attr : NULL)) {
+				unsigned int v_total = stream->adjust.v_total_max ?
+						stream->adjust.v_total_max : stream->timing.v_total;
+				unsigned int refresh_hz = (unsigned long long) stream->timing.pix_clk_100hz *
+						100LL /	(v_total * stream->timing.h_total);
 
 				/*
-				 * Delay_Us = 65.28 * (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
-				 * Delay_Us / 65.28 = (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
-				 * (Delay_Us / 65.28) / 2^MallFrameCacheTmrScale = 64 + MallFrameCacheTmrDly
-				 * MallFrameCacheTmrDly = ((Delay_Us / 65.28) / 2^MallFrameCacheTmrScale) - 64
-				 *                      = (1000000 / refresh) / 65.28 / 2^MallFrameCacheTmrScale - 64
-				 *                      = 1000000 / (refresh * 65.28 * 2^MallFrameCacheTmrScale) - 64
-				 *                      = (1000000 * 100) / (refresh * 6528 * 2^MallFrameCacheTmrScale) - 64
+				 * one frame time in microsec:
+				 * Delay_Us = 1000000 / refresh
+				 * dynamic_delay_us = 1000000 / refresh + 2 * stutter_period
+				 *
+				 * one frame time modified by 'additional timer percent' (p):
+				 * Delay_Us_modified = dynamic_delay_us + dynamic_delay_us * p / 100
+				 *                   = dynamic_delay_us * (1 + p / 100)
+				 *                   = (1000000 / refresh + 2 * stutter_period) * (100 + p) / 100
+				 *                   = (1000000 + 2 * stutter_period * refresh) * (100 + p) / (100 * refresh)
+				 *
+				 * formula for timer duration based on parameters, from regspec:
+				 * dynamic_delay_us = 65.28 * (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
+				 *
+				 * dynamic_delay_us / 65.28 = (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
+				 * (dynamic_delay_us / 65.28) / 2^MallFrameCacheTmrScale = 64 + MallFrameCacheTmrDly
+				 * MallFrameCacheTmrDly = ((dynamic_delay_us / 65.28) / 2^MallFrameCacheTmrScale) - 64
+				 *                      = (1000000 + 2 * stutter_period * refresh) * (100 + p) / (100 * refresh) / 65.28 / 2^MallFrameCacheTmrScale - 64
+				 *                      = (1000000 + 2 * stutter_period * refresh) * (100 + p) / (refresh * 6528 * 2^MallFrameCacheTmrScale) - 64
 				 *
 				 * need to round up the result of the division before the subtraction
 				 */
-				denom = refresh_hz * 6528;
-				tmr_delay = div_u64((100000000LL + denom - 1), denom) - 64LL;
+				unsigned int denom = refresh_hz * 6528;
+				unsigned int stutter_period = dc->current_state->perf_params.stutter_period_us;
+
+				tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
+						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
+						denom) - 64LL;
 
 				/* scale should be increased until it fits into 6 bits */
 				while (tmr_delay & ~0x3F) {
 					tmr_scale++;
 
 					if (tmr_scale > 3) {
-						/* The delay exceeds the range of the hystersis timer */
+						/* Delay exceeds range of hysteresis timer */
 						ASSERT(false);
 						return false;
 					}
 
 					denom *= 2;
-					tmr_delay = div_u64((100000000LL + denom - 1), denom) - 64LL;
+					tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
+							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
+							denom) - 64LL;
+				}
+
+				/* Copy HW cursor */
+				if (cursor_cache_enable) {
+					memset(&cmd, 0, sizeof(cmd));
+					cmd.mall.header.type = DMUB_CMD__MALL;
+					cmd.mall.header.sub_type = DMUB_CMD__MALL_ACTION_COPY_CURSOR;
+					cmd.mall.header.payload_bytes =
+							sizeof(cmd.mall) - sizeof(cmd.mall.header);
+
+					switch (cursor_attr.color_format) {
+					case CURSOR_MODE_MONO:
+						cmd.mall.cursor_bpp = 2;
+						break;
+					case CURSOR_MODE_COLOR_1BIT_AND:
+					case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
+					case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
+						cmd.mall.cursor_bpp = 32;
+						break;
+
+					case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
+					case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
+						cmd.mall.cursor_bpp = 64;
+						break;
+					}
+
+					cmd.mall.cursor_copy_src.quad_part = cursor_attr.address.quad_part;
+					cmd.mall.cursor_copy_dst.quad_part =
+							plane->address.grph.cursor_cache_addr.quad_part;
+					cmd.mall.cursor_width = cursor_attr.width;
+					cmd.mall.cursor_height = cursor_attr.height;
+					cmd.mall.cursor_pitch = cursor_attr.pitch;
+
+					dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
+					dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
+					dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
+
+					/* Use copied cursor, and it's okay to not switch back */
+					cursor_attr.address.quad_part =
+							plane->address.grph.cursor_cache_addr.quad_part;
+					dc_stream_set_cursor_attributes(stream, &cursor_attr);
 				}
 
 				/* Enable MALL */
 				memset(&cmd, 0, sizeof(cmd));
 				cmd.mall.header.type = DMUB_CMD__MALL;
-				cmd.mall.header.sub_type =
-					DMUB_CMD__MALL_ACTION_ALLOW;
-				cmd.mall.header.payload_bytes =
-					sizeof(cmd.mall) -
-					sizeof(cmd.mall.header);
+				cmd.mall.header.sub_type = DMUB_CMD__MALL_ACTION_ALLOW;
+				cmd.mall.header.payload_bytes = sizeof(cmd.mall) - sizeof(cmd.mall.header);
 				cmd.mall.tmr_delay = tmr_delay;
 				cmd.mall.tmr_scale = tmr_scale;
+				cmd.mall.debug_bits = dc->debug.mall_error_as_fatal;
 
 				dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
 				dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index b96b32a37178..b4ff73e32279 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1316,7 +1316,9 @@ static bool dcn302_resource_construct(
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-
+	dc->caps.mall_size_per_mem_channel = 4;
+	/* total size = mall per channel * num channels * 1024 * 1024 */
+	dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel * dc->ctx->dc_bios->vram_info.num_chans * 1048576;
 	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
 	dc->caps.max_slave_planes = 1;
 	dc->caps.post_blend_color_processing = true;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a50bdd6c7131..98dd8b5f463c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -458,6 +458,10 @@ struct dmub_rb_cmd_mall {
 	uint16_t cursor_pitch;
 	uint16_t cursor_height;
 	uint8_t cursor_bpp;
+	uint8_t debug_bits;
+
+	uint8_t reserved1;
+	uint8_t reserved2;
 };
 
 struct dmub_cmd_digx_encoder_control_data {
@@ -624,6 +628,7 @@ enum dmub_cmd_mall_type {
 	DMUB_CMD__MALL_ACTION_ALLOW = 0,
 	DMUB_CMD__MALL_ACTION_DISALLOW = 1,
 	DMUB_CMD__MALL_ACTION_COPY_CURSOR = 2,
+	DMUB_CMD__MALL_ACTION_NO_DF_REQ = 3,
 };
 
 struct dmub_cmd_psr_copy_settings_data {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
