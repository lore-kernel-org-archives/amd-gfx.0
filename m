Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66357606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=thRWIFV1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0102D10F95A;
	Wed, 21 Oct 2026 06:27:32 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5910A10F95A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw5xymX6ZNL6NkoUpwVzXm+UsaAdaK+8cjTLZIZG8kffcBslQQsWGGPp5Zz2d6rcCKoa0+V3dwreH0RVJC6TN3Gdvkb8p6Zc4f5MTf7AxtrsfJAgxvfS4XUw1EXg8oPr/ODZbkc+Ymdl51M1eDgHDbalOUFdzlXpGyEAFncdxUdVE9T4sMDT5G7oPaG8yQCJk5IsfovYCpQsox8jDhzLPzluDyYhA+WyFCtukQaEEIbgf/JVCgSezwKuWg7GvbrkIfMa4ckhxk6yCFj4OlM/LDgYhENSNx7fhmkWB6ldPlH/sE+aEC0nu8ypc4gGk0CzGN3xqNBZaznRj0aOBXUdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t88Ewp1QkPDMdywo4/AGpi5a5m68T+bXMxI/fu6oU4g=;
 b=nI+g2Bi0FSONmWa6qD25RMlAMFiCKFMKxh+aqYonq1SbjG6RRtwLJNGKYPaiUdcgZ+T8sf1eWUbOlxQUZL/Tn3TgvMQCBtE3Lq4tSzJxIZFVqYOnlVkNN9ilDprZtD0phUnlTz3lrxaLPjJYTO+IJWAByJLhxcnGl76Nc84QKqgaILs3DOf0PcttzO7gAQJMR80h7X/BCVuPcZkDlp4L99JQyPGkt8CqLQ47VSzbsL6UcLIddcPP54Wqg3ui4D3eSdieoP8Uj7JiyKPx8Z6wuLQFDlpLaYWWgSHjfMrUigJntei6huT2qICVY30T+9cr1pRYJO831cQfxeEHKzYPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t88Ewp1QkPDMdywo4/AGpi5a5m68T+bXMxI/fu6oU4g=;
 b=thRWIFV14U1KhwRIH2sqTfxQrik63M9tlj+75zx4y5yhJw80hPfThl1tzB3odemvXVy0ly04nlKuUkwTPAO7zV9ooxyxz9VPhLSW2qRuiym+gPTDmPCDWG9mRZywZFBykyNdR9S/lYxSk8hq/O+IeIKueaKqh00DK5fADc3QN+M=
Received: from DS7PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:3bb::26)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:27:21 +0000
Received: from BN1PEPF0001854C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::94) by DS7PR03CA0081.outlook.office365.com
 (2603:10b6:5:3bb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:27:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854C.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:18 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:14 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Samson Tam <Samson.Tam@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 31/49] drm/amd/display: Revert "Add new config_dsc hwseq
 function for dcn60"
Date: Wed, 21 Oct 2026 14:22:37 +0800
Message-ID: <20261021062519.674697-32-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854C:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 6868f2b8-765f-4d60-1660-08df2f3c5cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|261009221227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: egna8OY2dfJhU1SYPlDKHhoPDj9cBF79I2B3nYwu1kC4ofIN4p+2dWquvz9j/gNjE2DKYWakcOgKVdbo8pkCnl79ej6CF3NSVF/9ziCbeNb8X4tspYSyvTU+878paaN5aOyWzdla/HtJ5FuoXEVuNlpEEgp65rejAU07+2R6d9b4E0MhTtVrPuAp4FQpEJ4OdAarnf0HgH/kDm1E1/gkdJXPx6XppqbI6SA5jOITRYYYJCiA9iA69y7gN4dgaZScMIR8qzdyEjd3S8FEGFvItz49AzigiOLeT2g6RMbnxEBDTV+3EO4Ig6l6zQpoHgA8ga4dQhHzBRcXd8c4FRT9JCoADKjA0uO96o+D2c1iaF0RtxaYA3vGsyeuVIxQukRvPjPFimF0ULZzJrTkfVg6DvVTjDH+yW0V5kz1VCDlGHpVHZ4zcUIwxT2jHgRGboFAGOaV/Uw63IhvK7K+YcdecZ6fy10G9yd6rlQW+fyLvuFqC0FVcUISQroz8B12J7H8Hl3EPr/b44/Woy3wRVkqbWvssvx+PL7pHLES4DcGVKBcHSUOfmRhpoqhnQ5pzIlHc0asQWrlauUDjuT9LwT5FBXAr1YK84pDKaByaIDdqE5xY9O1OyVaNPcvwxYhLq90rT2W8dmS09bWWZX6TJYD7VlRMDglDxFKjt20ja/sln7hw/GtDV8D3Ai522ULZiFFJW1wTe98WoWwnZcXyZSshQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LKBogxWEt8oBkFMqOc37gxKKOBQgzdNawGq/C2unDbz+PvYfUcoM96jaRhlKZq1yy6s1JH1R/nCaWNI5WJhYE3LBXjHeRutv0Wx8sAlCUCihU9Y1a2qXtepJS9noLNzLUGHcp9EcP+4x4YS6xk1BZY1cwNaQF9J5N5u45HiKthtfOJQuooMlc7DDkHIeHMFAvQ3BGScsi6F5dMFH+sALQuv3/0sCP1Sp9bj8F6fgix29PzO3cR8YiAiPj+FZJpD8dpprHkbDWF1ioY3BxJTDbLQNXUB4+00YNfhWzdI/M7OzvU/ZwXD//HscSsoWYfdu3esNLOnNreo71p4x5SajJsVQK1hqtcFZRcXVls4hzmDIJ8vHGZ2DJb7AETH5xYCzsg+ypIhu4GNJgAuftTEyX+Bg3GgilwuuLAdiXTq6J6TOpIE8RPtOUM1xa+lYKxaC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:21.4087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6868f2b8-765f-4d60-1660-08df2f3c5cfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Samson Tam <Samson.Tam@amd.com>

This reverts commit 1534564fb404 ("drm/amd/display: Add new config_dsc
hwseq function for dcn60").

Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   | 95 -------------------
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |  1 -
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |  1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 -
 4 files changed, 98 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index e2dddbc170f8..f8254dfe1ce7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -53,101 +53,6 @@
 #define FN(reg_name, field_name) \
 	hws->shifts->field_name, hws->masks->field_name
 
-bool dcn60_configure_dsc(struct pipe_ctx *pipe_ctx, bool enable)
-{
-	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
-	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct pipe_ctx *odm_pipe;
-	struct dccg *dccg = dc->res_pool->dccg;
-	struct dsc_config dsc_cfg = {0};
-	struct dsc_optc_config dsc_optc_cfg = {0};
-	uint32_t odm_count = 1;
-
-	/* It has been found that when DSCCLK is lower than 16Mhz, we will get DCN
-	 * register access hung. When DSCCLk is based on refclk, DSCCLk is always a
-	 * fixed value higher than 16Mhz so the issue doesn't occur. When DSCCLK is
-	 * generated by DTO, DSCCLK would be based on 1/3 dispclk. For small timings
-	 * with DSC such as 480p60Hz, the dispclk could be low enough to trigger
-	 * this problem. We are implementing a workaround here to keep using dscclk
-	 * based on fixed value refclk when timing is smaller than 3x16Mhz (i.e
-	 * 48Mhz) pixel clock to avoid hitting this problem.
-	 */
-	bool use_dto = dccg->funcs->set_dto_dscclk && stream->timing.pix_clk_100hz > 480000;
-
-	if (!dsc)
-		return false;
-
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-		odm_count++;
-
-	if (enable) {
-		dsc_cfg.pic_width = (stream->timing.h_addressable +
-				pipe_ctx->dsc_padding_params.dsc_hactive_padding +
-				stream->timing.h_border_left + stream->timing.h_border_right) / odm_count;
-		dsc_cfg.pic_height = stream->timing.v_addressable +
-				stream->timing.v_border_top + stream->timing.v_border_bottom;
-		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
-		dsc_cfg.color_depth = stream->timing.display_color_depth;
-		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe != NULL;
-		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
-		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % odm_count == 0);
-		dsc_cfg.dc_dsc_cfg.num_slices_h /= odm_count;
-
-		if (use_dto)
-			dccg->funcs->set_dto_dscclk(dccg, dsc->inst,
-					(uint32_t)dsc_cfg.dc_dsc_cfg.num_slices_h);
-		if (!dsc->funcs->dsc_prepare_config(dsc, &dsc_cfg, &dsc_optc_cfg)) {
-			ASSERT(false);
-			return false;
-		}
-		dsc->funcs->dsc_set_config(dsc);
-		dsc->funcs->dsc_enable(dsc, (int)pipe_ctx->stream_res.opp->inst);
-
-		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
-
-			ASSERT(odm_dsc);
-			if (!odm_dsc)
-				return false;
-			if (use_dto)
-				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst,
-						(uint32_t)dsc_cfg.dc_dsc_cfg.num_slices_h);
-			if (!odm_dsc->funcs->dsc_prepare_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg)) {
-				ASSERT(false);
-				return false;
-			}
-			odm_dsc->funcs->dsc_set_config(odm_dsc);
-			odm_dsc->funcs->dsc_enable(odm_dsc, (int)odm_pipe->stream_res.opp->inst);
-		}
-
-		{
-			enum optc_dsc_mode mode = dsc_optc_cfg.is_pixel_format_444 ?
-					OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
-
-			pipe_ctx->stream_res.tg->funcs->set_dsc_config(
-					pipe_ctx->stream_res.tg, mode,
-					dsc_optc_cfg.bytes_per_pixel, dsc_optc_cfg.slice_width);
-		}
-		return true;
-	}
-
-	pipe_ctx->stream_res.tg->funcs->set_dsc_config(
-			pipe_ctx->stream_res.tg, OPTC_DSC_DISABLED, 0, 0);
-
-	for (odm_pipe = pipe_ctx; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-		struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
-
-		if (!odm_dsc)
-			continue;
-		odm_dsc->funcs->dsc_disconnect(odm_dsc);
-		odm_dsc->funcs->dsc_disable(odm_dsc);
-		if (dccg->funcs->set_ref_dscclk)
-			dccg->funcs->set_ref_dscclk(dccg, (uint32_t)odm_dsc->inst);
-	}
-	return true;
-}
-
 bool dcn60_set_rmcm_luts(struct set_input_transfer_func_params *params)
 {
 	struct dpp *dpp_base = params->dpp;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
index 44eb30608feb..b880988ff1fc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
@@ -31,6 +31,5 @@ void dcn60_program_perfmon(struct dc *dc, struct dc_state *context);
 bool dcn60_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
 bool dcn60_set_rmcm_luts(struct set_input_transfer_func_params *params);
-bool dcn60_configure_dsc(struct pipe_ctx *pipe_ctx, bool enable);
 
 #endif /* __DC_HWSS_DCN60_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
index 7b488753fe50..80125c3596ce 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
@@ -25,7 +25,6 @@ static const struct hw_sequencer_funcs dcn60_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn50_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
-	.configure_dsc = dcn60_configure_dsc,
 	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index f576039161e2..3ee6129a388d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1641,7 +1641,6 @@ struct hw_sequencer_funcs {
 			struct dc_state *context);
 	void (*update_plane_addr)(const struct dc *dc,
 			struct pipe_ctx *pipe_ctx);
-	bool (*configure_dsc)(struct pipe_ctx *pipe_ctx, bool enable);
 	void (*prepare_plane_addr_update)(const struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			struct dc_plane_address *addr_to_program,
-- 
2.43.0

