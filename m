Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DFBCFD65E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C148210E62F;
	Wed,  7 Jan 2026 15:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OYMLsXDg";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A0710E643
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9oHYGqUVtpStLp2B01SgYySBj7iw/iB2XwwMlsk009BSb1GpjQgTPU0XVH+81LmupwH6zt01IooKAyAkNEPIM+G2ndLBWzg323Jcd3I5MTRiP5qQT3bKkD2xqpp3hDh8s0Cy1SZ55UnDFvKaS0wE5WoLPZQUwl9zYzq22QC7ucW0oQ7GxTz7zHBIwh7aeF1npoziN5jUhbLUpzZJrNKIhUOW+UeCLeWwdP3iRCHKwOx0x2tP2VNroHbLIYy1cCV4ubIuR/pqBM1Cn3O5DA0l1Bni0/XcQJtqRHOJG6a26sqV9Q29x1DyF8N8rX9WYNdzeUx7Ec4LGgsGztF7BJaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+D3ocJF+WhVV5CO4qNf+4kOUujz+Tl+P6V7xd5FvLc=;
 b=xfwppMikayfBSAaaBHotk6v3VMnHFSdlgSQ/bJCbiQgy6Jud3RNyfs0f+2jTVEq0EhWIExDUQHlqpiHbcSnOo3jKbAMu9ovyUQ7ty4SFsUQHLONR3uPPVLuNOSKGox3gRoWGl7XVDdFg1d2xEjtP4QWOf31ZY8oqhMja4kas0Z9tRTuSLhrPNb21QC6wRWnM9juciwC4vBQmeScFtTopvoFyt/5H60CK3JgYKe6iZGj3NqRf6suPr72CF6OpjvuTDkRSk8PyLbArk2mi5sEMSeEbmWhjIBaYO8+gfpyw8DEOyy39QsBazdl/6GviSV3Rt7n4qshZB2vE+84ovcpR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+D3ocJF+WhVV5CO4qNf+4kOUujz+Tl+P6V7xd5FvLc=;
 b=OYMLsXDgCf8o8mzYX1rjCpceKrSbos/d2DeToe7954yKOmSo4D4jqQeGUdXvf0ooOv4m+7+ENOdWqXVMGbrZevr31FjBu18xXeVhOEnQsbnEb2hCF3aj69il/0Wigj2yUku0b0+Nu6VSvz/L7y/Ul5E5pNM3BkiDoHFBGi5a4fo=
Received: from BL1PR13CA0114.namprd13.prod.outlook.com (2603:10b6:208:2b9::29)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:13 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::d6) by BL1PR13CA0114.outlook.office365.com
 (2603:10b6:208:2b9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:08 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:58:08 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Yihan
 Zhu <yihan.zhu@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 16/21] drm/amd/display: Adjust PHY FSM transition to
 TX_EN-to-PLL_ON for TMDS on DCN35
Date: Wed, 7 Jan 2026 10:48:08 -0500
Message-ID: <20260107155421.1999951-17-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 4060c43d-7351-45c3-73d5-08de4e059011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f9ktj6hYewTI4K4n8YzqRNg1AvOjIHrskZ9/+Pzu3eU4P+VXnz6eZjaiYDH3?=
 =?us-ascii?Q?0+hW0HNftXud5z3anBBzBkCJKMw05E7YCB/Io4ej6YfZA2kC6BcFMbSPodgv?=
 =?us-ascii?Q?EtARJ989Vfuz7XyYVjUFqGBCJKyIGXBKz3gaXls6jOq2s9nIHnfCKkj7XlW7?=
 =?us-ascii?Q?2yxt/iQJ0Exw5w146HrmaabHd+1/CZEqSV33EJ5y6GoRNbpM7Uh+6mN9lpRy?=
 =?us-ascii?Q?JjaQppz1R0vHPeSmN8RH0J5PHJq6/EFuCGmDxARWA9Pqpi3lqRn8CDhBK1BJ?=
 =?us-ascii?Q?TwLm7/rCOE5mfd/gqviZhuX8bH+TPtiDdtWTcMlB9whJRD9BCDE9RSALg7+l?=
 =?us-ascii?Q?cfQyZYX010qAYhfcMiuWdVTL3xaj5S19ADwpVdRRz2NASAqrg+9lttx44VHY?=
 =?us-ascii?Q?RlJESwMZmiIgPKyjj4muk1vN2NVirLElWB8616njA/dUaa+rIXEs4VJu0Vqo?=
 =?us-ascii?Q?Z4wJip7rtXLYIhM10cVQjuPSI7Wg6SLtPB3K9n/28RWM6sjt0Yf5ijhFlegw?=
 =?us-ascii?Q?d40JL33Hl+gEqB5OSZ8Ck61+9TrxsK+sYRRsJ2/LmXj9ceXTA4GvR6wx4FUS?=
 =?us-ascii?Q?025uian8u2dygzrks5dCGnu9ySlaGD9RvZ4kapiP2Ny5IBRN+WK59xTxvU8h?=
 =?us-ascii?Q?VFOdTo1Hrf76jnHcWXyjz2HuOg1PKEV2BqPaemvIFN5BafJ61rR93xrC9fWQ?=
 =?us-ascii?Q?NBYpc/wznJlXNS3R9AtQHADuQV/SNuJFgt6o61r1Cy46aVeiYoZQkwOml4DA?=
 =?us-ascii?Q?OUhgL1idruVSTheEYqw9eEKFa+7a8m7DQzVptzGlnW1GA/EXquyiqvAs3p0i?=
 =?us-ascii?Q?j1OHlJbppIRj/K6LKoq2K6HrFIMlieYG305CNvptQ1u550ODSHxQr8XpItAP?=
 =?us-ascii?Q?Xk8WxmuUjHA5iEk4Z1/5elPfCrVjHeXwx1rgVDTQ6tKgX2AHMOZIjhGg3jp2?=
 =?us-ascii?Q?8QwSRQctOgmYpqquEcelMUbySmE3zB8MqRQ+VgTPaLRD6+lR8wm3fateZfb9?=
 =?us-ascii?Q?/OuJj6alFN9kFZw2d54UYwN+/ZcoJeCPIzq+8km/+I+8HP+ZOmE0Bp9jDgo4?=
 =?us-ascii?Q?RxIvIZ/yyIGa7PHcbEhUZx8goLTY1vPtSIsE13TCtS8VdzSP3q8Esbi8xNAF?=
 =?us-ascii?Q?9FgofvX01M63vAZKX971mFpvJdo+ZCKyw9vLi6wGIfh2wyAA3AtLldkKzd7W?=
 =?us-ascii?Q?q3LpLsBYPgTMXuT2oF2VVpjFPrY8nEk3qOiVVsHG7OIfklzR6HjI4biVdlVA?=
 =?us-ascii?Q?0RbBsTPFqm9H/AtsiKq5+fgLaynZxC27MHIAGGYGC5tdaBxEUH4lO0rwX7Vk?=
 =?us-ascii?Q?+envr/LUwj93uV2BBbmiTJzVRkF8/aFTuI30elVwMvuh9re+Sd87TuwbR1QL?=
 =?us-ascii?Q?hzTkC4ITpIQJW4jPDew8pGueK585Nf+9/OyTWHEMAXZ77dUiV36BjafuPe2a?=
 =?us-ascii?Q?s8ogLpMI/sbtHwjz57Tk+bLgYM3e1Ft9GUllDarQ8i93udBC/13cZ8ayHWIn?=
 =?us-ascii?Q?ewSh7BMRjO3I89kWbVaWqxh8//ZNnVBZftVwBEdQOLh4ol4EoRMRe4M2VLQ8?=
 =?us-ascii?Q?TCE0q/iwerIUIyOX3zw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:13.1621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4060c43d-7351-45c3-73d5-08de4e059011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
A backport of the change made for DCN401 that addresses an issue where
we turn off the PHY PLL when disabling TMDS output, which causes the
OTG to remain stuck.

The OTG being stuck can lead to a hang in the DCHVM's ability to ACK
invalidations when it thinks the HUBP is still on but it's not receiving
global sync.

The transition to PLL_ON needs to be atomic as there's no guarantee
that the thread isn't pre-empted or is able to complete before the
IOMMU watchdog times out.

[How]
Backport the implementation from dcn401 back to dcn35.

There's a functional difference in when the eDP output is disabled in
dcn401 code so we don't want to utilize it directly.

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 52 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  3 ++
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 1271bf55dac3..2675d7dca586 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1727,3 +1727,55 @@ void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe
 {
 	dc_dmub_srv_program_cursor_now(dc, pipe);
 }
+
+static void disable_link_output_symclk_on_tx_off(struct dc_link *link, enum dp_link_encoding link_encoding)
+{
+	struct dc *dc = link->ctx->dc;
+	struct pipe_ctx *pipe_ctx = NULL;
+	uint8_t i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx->stream && pipe_ctx->stream->link == link && pipe_ctx->top_pipe == NULL) {
+			pipe_ctx->clock_source->funcs->program_pix_clk(
+					pipe_ctx->clock_source,
+					&pipe_ctx->stream_res.pix_clk_params,
+					link_encoding,
+					&pipe_ctx->pll_settings);
+			break;
+		}
+	}
+}
+
+void dcn35_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct dc *dc = link->ctx->dc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+
+	if (signal == SIGNAL_TYPE_EDP &&
+			link->dc->hwss.edp_backlight_control &&
+			!link->skip_implict_edp_power_control)
+		link->dc->hwss.edp_backlight_control(link, false);
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->lock_phy(dmcu);
+
+	if (dc_is_tmds_signal(signal) && link->phy_state.symclk_ref_cnts.otg > 0) {
+		disable_link_output_symclk_on_tx_off(link, DP_UNKNOWN_ENCODING);
+		link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
+	} else {
+		link_hwss->disable_link_output(link, link_res, signal);
+		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	}
+	/*
+	 * Add the logic to extract BOTH power up and power down sequences
+	 * from enable/disable link output and only call edp panel control
+	 * in enable_link_dp and disable_link_dp once.
+	 */
+	if (dmcu != NULL && dmcu->funcs->unlock_phy)
+		dmcu->funcs->unlock_phy(dmcu);
+
+	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 1ff41dba556c..e3459546a908 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -108,5 +108,8 @@ void dcn35_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe
 void dcn35_notify_cursor_offload_drr_update(struct dc *dc, struct dc_state *context,
 					    const struct dc_stream_state *stream);
 void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe);
+void dcn35_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal);
 
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 5a66c9db2670..81bd36f3381d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -113,7 +113,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dcn32_disable_link_output,
+	.disable_link_output = dcn35_disable_link_output,
 	.z10_restore = dcn35_z10_restore,
 	.z10_save_init = dcn31_z10_save_init,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
-- 
2.52.0

