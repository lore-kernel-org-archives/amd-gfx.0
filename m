Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F315CA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2354B10F713;
	Wed,  7 Oct 2026 17:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oDDAy3/K";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF9510F704
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mw1qUHivFwW3SUQF+Psaoktb/NCeBGnfjqQhnIqHnaYOzoF3d12qAVqEocFrKWBj2ipNXp7TXXk8RMiRdEU/YbQ4cb2a1OvsWwuzScpmqeYMZewIQHJB+eq28LWxXxZe1PeB+i7ldGUiGlF9n0avq8+9hlmIpW5IW+4ILqXGC+HDkoL3Q9+MmyS2y3/YBIfx5CM8YSvq+ou6BkwE4xkl1Y5Bjb0pdMSvvQFy6BbHZRLnA23X0cdBpPbGQAXqPN0gBW/4ZZZNQgG+96PjonN4xK+p0ogfpypmV0lzpfLNFzD1s1cK/1eYOU5p5Ew9FZOpeJ2SGMjuMFJS69W7l6jTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjvZrHZNpXH405rmCYmT772bzCg0R7ChbzbmNgVQ+g4=;
 b=bDGcyO0LWsb1fBs+Ap75tCe5x1baziY5TQCDjeNmkh/wCaGaecqoUioPKalH9X2K5Yrzg0co/OaXolLTpj8oSG0kckmNgX3YRp1wcj0OXDJUNB4le9wwvGQGShyE0MoyXLqZu3IM1PDsw3dZvNL/kGfwZ7ofz7P24kdwu9dB+onXjmmVLRILiTKzCrNRr8MzTbDbJFex1LghhHCUcgtGlUZVanrBtRD4Ih+RG068LlqbISRp0Jn9YJyZwudrrdHEhn2cOF9LO3ZVKlifSSGYyck39t3BGfsi0J5seXiSzwFlzIh/BRvdFrbQOpMd1mdN8g3AEpQp6rHxYEJwcU5T6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjvZrHZNpXH405rmCYmT772bzCg0R7ChbzbmNgVQ+g4=;
 b=oDDAy3/K+RvBcl3rq6cPu1C6GyJSfuzEAMwOsS220+zUvCiHGniC6QzUyU1EEs2upeUga7vkNbsTJifB2HGcgOmzQIKJCRsTjNq9ET234D+g+x1p6Z1lMQ3v7C2XSmPKn5a2YEAwHyuXJRBJ0lg25B6O/6mEAIjMkRwY7L/A2g0=
Received: from YT3PR01CA0122.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::12)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 17:04:36 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:b01:83:cafe::a5) by YT3PR01CA0122.outlook.office365.com
 (2603:10b6:b01:83::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:32 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:31 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Shen <george.shen@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 14/19] drm/amd/display: Add new config_dsc hwseq function for
 dcn60
Date: Wed, 7 Oct 2026 12:59:47 -0400
Message-ID: <20261007170412.1898315-15-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b14fb89-faac-4c69-3516-08df24951112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|11063799006|56012099006|18002099003|10067099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: eLSC1g84b4SCzBHwJEgApF6sxEEh8BID8HgCrxPL+QdiCKtjqyhvtThw3ISknaAyNdRoRxZHsV/ofTv7ZAe367LRxjP4uVchBGkhe6XEovIt/Hp3BgdyRPWkcKYmtx8aTyLmpQU5AYRk/kOrBDYkNnDo1pAz107Y8o6CvvN3VrH0DDORZYLTVemNGXdp1RP9QxRJHyThxgYNUqZGx/l4yb4sdGdDe+jR9SP5g+5rknXx+LgNW5yEKkDFCRSfjfFQHqUjrGtdDBPBrkBX0kRN3n7Dox8Ce9Y2KscyfcWkoqXbKsJuA4v+43JmjMRC1ScK/E1GvDbkeAsnxJpaXBEnXiHZYsxLp2jF5TsMZZBw4TzIBEP9kMgG8r/Ao5ClTvFlYjyHTfwV0GLzBlIw82yiO+iSaiiFVw95P6mgzmURcPDNCvHJH37ABqe3dlhYWSChy9EbqYSGbRq9sdXZoNPpqH+OrlC5pmrNipycXGmj2gX2x4gDBrm3gaSsjLVGbQypIiE98FA6ROqmvkR5rGg7ZrLcYsVu6R9/YYFOpWorAn9paaaNerWxkas4+Z0eEUGdWjL7vmBUycAzOh4/a+UezXQ9Lzk4wQoTu/by0CRYPhKLe1lvqK+z+9S42zQuY8wLx5tyRdml8EMFp9IklMBQGfdl5yLQJzzClD2WuMk+JLSBVLRDxBeBU9DqZNMNn2sqDp2n2GJ0FYuDzMV24sG5CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(18002099003)(10067099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +f+ZJM/vsbPmAX40Nzype8RZo6+vIvQoPFgjkLb2rn9y29q8c0KjpWUUgIVIN5JyDMEb+apohK7dsUaKPNyTp1PS1iFchzgFtim7VWXCLOjhbUDtR+HkYlmvsABjvXbJz/aidKppacDeVnqH75UUMPHMtfY3+Plg8vnZUWzY2T/OA5P5XGW4Pqes5ObPX9Oltv9SxpoFkZaROaCZ8pyLmbQRDNRkyZtgzdvZftFKBXxnu9YzIT1JjxiFHjyjmo+anh2fZj2sBIEwRdyCpJKYQzlxL4Ao3Pti3tfKl5oZt/cfD+bN/p4Q46dbPIfq1jgIRuO5tMrh18OUPcS96MTfHDk/o+otFKPan27ZRDzEFJvRoepjcPybfRUe82IOtXwMVCT9Xl2/6tgq5Zxu7agh7e2O5cj5iHDpECl0TJN2VAXs4fC0D9R+VgOodhPywyM9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:36.4610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b14fb89-faac-4c69-3516-08df24951112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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

From: George Shen <george.shen@amd.com>

[Why]
The current DSC block programming sequence is intertwined with the
stream encoder DSC-related programming. Logically, the programming of
the DSC (front end) and stream encoder (back end) blocks should be
independent of each other.

[How]
Create a new hwseq function config_dsc to handle the DSC block
programming sequence.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   | 95 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |  1 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
 4 files changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index f8254dfe1ce7..e2dddbc170f8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -53,6 +53,101 @@
 #define FN(reg_name, field_name) \
 	hws->shifts->field_name, hws->masks->field_name
 
+bool dcn60_configure_dsc(struct pipe_ctx *pipe_ctx, bool enable)
+{
+	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct pipe_ctx *odm_pipe;
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct dsc_config dsc_cfg = {0};
+	struct dsc_optc_config dsc_optc_cfg = {0};
+	uint32_t odm_count = 1;
+
+	/* It has been found that when DSCCLK is lower than 16Mhz, we will get DCN
+	 * register access hung. When DSCCLk is based on refclk, DSCCLk is always a
+	 * fixed value higher than 16Mhz so the issue doesn't occur. When DSCCLK is
+	 * generated by DTO, DSCCLK would be based on 1/3 dispclk. For small timings
+	 * with DSC such as 480p60Hz, the dispclk could be low enough to trigger
+	 * this problem. We are implementing a workaround here to keep using dscclk
+	 * based on fixed value refclk when timing is smaller than 3x16Mhz (i.e
+	 * 48Mhz) pixel clock to avoid hitting this problem.
+	 */
+	bool use_dto = dccg->funcs->set_dto_dscclk && stream->timing.pix_clk_100hz > 480000;
+
+	if (!dsc)
+		return false;
+
+	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		odm_count++;
+
+	if (enable) {
+		dsc_cfg.pic_width = (stream->timing.h_addressable +
+				pipe_ctx->dsc_padding_params.dsc_hactive_padding +
+				stream->timing.h_border_left + stream->timing.h_border_right) / odm_count;
+		dsc_cfg.pic_height = stream->timing.v_addressable +
+				stream->timing.v_border_top + stream->timing.v_border_bottom;
+		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
+		dsc_cfg.color_depth = stream->timing.display_color_depth;
+		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe != NULL;
+		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
+		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % odm_count == 0);
+		dsc_cfg.dc_dsc_cfg.num_slices_h /= odm_count;
+
+		if (use_dto)
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst,
+					(uint32_t)dsc_cfg.dc_dsc_cfg.num_slices_h);
+		if (!dsc->funcs->dsc_prepare_config(dsc, &dsc_cfg, &dsc_optc_cfg)) {
+			ASSERT(false);
+			return false;
+		}
+		dsc->funcs->dsc_set_config(dsc);
+		dsc->funcs->dsc_enable(dsc, (int)pipe_ctx->stream_res.opp->inst);
+
+		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+			struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
+
+			ASSERT(odm_dsc);
+			if (!odm_dsc)
+				return false;
+			if (use_dto)
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst,
+						(uint32_t)dsc_cfg.dc_dsc_cfg.num_slices_h);
+			if (!odm_dsc->funcs->dsc_prepare_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg)) {
+				ASSERT(false);
+				return false;
+			}
+			odm_dsc->funcs->dsc_set_config(odm_dsc);
+			odm_dsc->funcs->dsc_enable(odm_dsc, (int)odm_pipe->stream_res.opp->inst);
+		}
+
+		{
+			enum optc_dsc_mode mode = dsc_optc_cfg.is_pixel_format_444 ?
+					OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+
+			pipe_ctx->stream_res.tg->funcs->set_dsc_config(
+					pipe_ctx->stream_res.tg, mode,
+					dsc_optc_cfg.bytes_per_pixel, dsc_optc_cfg.slice_width);
+		}
+		return true;
+	}
+
+	pipe_ctx->stream_res.tg->funcs->set_dsc_config(
+			pipe_ctx->stream_res.tg, OPTC_DSC_DISABLED, 0, 0);
+
+	for (odm_pipe = pipe_ctx; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+		struct display_stream_compressor *odm_dsc = odm_pipe->stream_res.dsc;
+
+		if (!odm_dsc)
+			continue;
+		odm_dsc->funcs->dsc_disconnect(odm_dsc);
+		odm_dsc->funcs->dsc_disable(odm_dsc);
+		if (dccg->funcs->set_ref_dscclk)
+			dccg->funcs->set_ref_dscclk(dccg, (uint32_t)odm_dsc->inst);
+	}
+	return true;
+}
+
 bool dcn60_set_rmcm_luts(struct set_input_transfer_func_params *params)
 {
 	struct dpp *dpp_base = params->dpp;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
index b880988ff1fc..44eb30608feb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
@@ -31,5 +31,6 @@ void dcn60_program_perfmon(struct dc *dc, struct dc_state *context);
 bool dcn60_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
 bool dcn60_set_rmcm_luts(struct set_input_transfer_func_params *params);
+bool dcn60_configure_dsc(struct pipe_ctx *pipe_ctx, bool enable);
 
 #endif /* __DC_HWSS_DCN60_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
index 80125c3596ce..7b488753fe50 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
@@ -25,6 +25,7 @@ static const struct hw_sequencer_funcs dcn60_funcs = {
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn50_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
+	.configure_dsc = dcn60_configure_dsc,
 	.prepare_plane_addr_update = dcn20_prepare_plane_addr_update,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 7de59001453c..8f4ed80385fc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1413,6 +1413,7 @@ struct hw_sequencer_funcs {
 			struct dc_state *context);
 	void (*update_plane_addr)(const struct dc *dc,
 			struct pipe_ctx *pipe_ctx);
+	bool (*configure_dsc)(struct pipe_ctx *pipe_ctx, bool enable);
 	void (*prepare_plane_addr_update)(const struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			struct dc_plane_address *addr_to_program,
-- 
2.43.0

