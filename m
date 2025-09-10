Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37270CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE2410E85D;
	Wed, 10 Sep 2025 05:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UnUxgw6Y";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6359B10E856
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAbopus2QDBojkxuJKRc7rj+8ppfQ5PcghOoUhIkzVcRdha8oiJ7OSNuToYh/KlhdLd5YSa46SB2Q87B7kIh8ePfmRt4DDtkybpZygjFewNKSBZCmxiC5cBI7stHcMXjXvVbTwy5eavCL6ok0dAKkdqNcOVtNNxscJflQI01YHaZRryI/NA4/61nZ6WtfzmIOTWu/JzwLZeWur1U9EUE67nv5RWOILZX1dHrBByRz9J4XJdRa0X1kUllD6zFuZyKkgvyXFottt0pTclshbJr54w72pz85WnOVvGEEfMoIfSS/YqyIQcBRKE5qVo9aINnadh5LI2sbExbOeXmG3UJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKDokhzUx/C9Gb5/tWWBrmPBPiw3b8mmh323dg5HhgM=;
 b=Y9aIPxWmT86KWbuJYLzQMa/B1yxZp0TA1w7ojbtxxXT1od0M+wlO504u0tfE8FuYcPUkwW2FUUTlyWjQxc8JpcNiVzQCWOkG2GTsOSK+4qhit2LxDfFTND6SJ78FLjLG7mpXj1JCF3DRKLaer0LBV9HK4CSAVGJwrvaUMUG/x2ibQOmfhDUtOH1gQugW1xGeMLuoD97haPhd1CVyfuwYaXa7cfn7UbgktLtfil6nk6s5c7XDJ80nnf2KdM76pCoR9VH3pcx1KqK2qU/BjzfKs99tNPCiqkZeQ6uNwMHwUVWvp5MicIe5a5m9AwE3cSZEnyN3Pz+J6nopG/88VnaiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKDokhzUx/C9Gb5/tWWBrmPBPiw3b8mmh323dg5HhgM=;
 b=UnUxgw6Y1NpA3tSgjfhIX569U693PyZRQqwUg7zkEzQoJ+/EGsGZBPP/+fyjMt0GhbO+yDEBeIskJSSbPsGez3XvZQVErOgekXPSwfMkC9tXpmqTmKOQHxBECr2epSMYvALdRJTuRpwg9QY3Br28X3llqY60APoJzrhGkuZjbNk=
Received: from DS7PR05CA0048.namprd05.prod.outlook.com (2603:10b6:8:2f::19) by
 BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:34 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::b8) by DS7PR05CA0048.outlook.office365.com
 (2603:10b6:8:2f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Wed,
 10 Sep 2025 05:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:32 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:31 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:28 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Relja
 Vojvodic" <rvojvodi@amd.com>, Chris Park <chris.park@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 13/15] drm/amd/display: Add DSC padding for OVT Support
Date: Wed, 10 Sep 2025 13:30:36 +0800
Message-ID: <20250910053222.2884632-14-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: 5976b3b5-d916-41df-2987-08ddf02b9575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MJ4rT5rFuUq1hgHCZ/tdQGV2p2Y8SU0kDcYLxi38mXOrp8K4fA7Zq2TB0Kpm?=
 =?us-ascii?Q?NhENKCQ8yPIte8FID4xsh6RMNioAR5p9qKqvH+RSIbM8O2NQBO62+s4m5yD1?=
 =?us-ascii?Q?NzyWZJGcNNobscyC6eKAzv86yYbjo1hzkDxzMTfkR2dhAqSa/AtHn+p4dhm2?=
 =?us-ascii?Q?1YdVg4v074K++GExa8TmL9DfiaAP3HlRAr+TUlZA/AOh+t3Kb152suZD/vmM?=
 =?us-ascii?Q?fyCaTsbgY+knkAMlrj/SlLkuKPW/SdN2LvamUpNT/WjJL+unyl2aHZH6y+oi?=
 =?us-ascii?Q?tC38Tc0JLs+zE7NBwlfhxJrNLu2CBnw81WTa+CyUGHqNjgbmfg90SnqefXfc?=
 =?us-ascii?Q?Wz7HpY2xLxmbiwqYQwKM4A2RJBE6GhR4BCCTuln7TyF3h61+EIBHZKSMqbGw?=
 =?us-ascii?Q?+DHtPHP9vp/Mqb2YWZqzvf+8W8TM4JHDlN4lWHC7HK4o7W4eTUoUikqm6I8Z?=
 =?us-ascii?Q?En9uAtlrm+Ig7ZzwrkWwG6CFu+zu1Np0424YEaW3ABbSpf/6FiPP3g6KiU5q?=
 =?us-ascii?Q?pZyI+bc8URrKyTDlyTAy4XOdecNZOsstyboqbXCMirFfrdEmIjlQrLzJ1h+Q?=
 =?us-ascii?Q?Xt330H2ZfoWdUcDNOlgoqd9ZCn0Dm5HVN7bOZwFbtceP/gMk96wByms3CKG1?=
 =?us-ascii?Q?K80lNwARUQIOyud0Erx6wBmcOf54hy2POfF+VTtzVUBiagwAHzsMCF1CmHo4?=
 =?us-ascii?Q?jdPuXTcjEe3P9Pgrhh3a/KHpKagmMsR0WCe5t5DAmcnsr0ayGYbPOQlJV81B?=
 =?us-ascii?Q?pC87vyQVFOF1MGqKxdFHsw+q0TDLhmaCRBi9DGTGJYW0TJ09Ug2gCtGbYbVt?=
 =?us-ascii?Q?LEie+F8IMZRN3CDk1o7gHV4wARt3GN0+xXbnJkOzZZh6mNzAgUo5S3uZ/HJl?=
 =?us-ascii?Q?N17sHRzf+jr+/hLub/kdmUmPTQFu+JVuRdrzw5NBD7/h8MLi8Y1xn2XUQP6B?=
 =?us-ascii?Q?qIhKg39+c6r6zRwmZGoELrT9FrJqF5mAgeyxfMu7flYDJeQ+tN9gz3KNmZlA?=
 =?us-ascii?Q?yEdrA6uIY9e5nCQVoq1H8w0+fXiFwrilBtEbiCOcsLzvRHt1zdeiPlO6Y2rl?=
 =?us-ascii?Q?kldt82BGp6e2AigA0mpW3BnT5yOHXqjESJ23ZUkySCBEUz71tlhumFr2jIBI?=
 =?us-ascii?Q?eFmEQACGTgQvV1eKLSKdNCM7dYY6yU7xM12woIqLBikVJ22qKk1gi1gBawkW?=
 =?us-ascii?Q?FLVkGY7rj9nxwy9MR8gMtg+SYKzYGdgIP1z5lJizKORn86/blHBASjGfVbWp?=
 =?us-ascii?Q?I0MflfB6sLkflXl9moy2hX2GSfyF25mBnCpDe8hvj9WD3n0qaOVnaf9TkiW3?=
 =?us-ascii?Q?kcRf6pKVdl/ckCVthCQkfJw8WAFMtqKfCY9xYXDjLALtPWwaZFErBb3weQzw?=
 =?us-ascii?Q?eCmUut49hbjCu7EkN6lyQNHvF/pxtWlH6GqsaWmU7E1OGVOvb3WdvqUyMXzv?=
 =?us-ascii?Q?gjv2Xfdi+s+EBzDIvIFsznpG8aJaT1hkkUD9znqDKBRiD+cSq16jSwqQIp1K?=
 =?us-ascii?Q?Kwv+97C8nKxBiE9kvy+sbMy5USDbVMbCwtca?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:33.7421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5976b3b5-d916-41df-2987-08ddf02b9575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
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

From: Relja Vojvodic <rvojvodi@amd.com>

[Why]
-Certain OVT timings require DSC configurations which divide the
horizontal active unevenly across DSC slices
-DSC slices must be even, so padding needs to be added to the active
to make this possible
-The pixel clock of the HW now needs to be increased to accommodate
the extra padded pixels
-To keep the line time the same, the blank of the HW timing needs to
be increased as well

[How]
-Calculate h_active padding, h_total padding, and pixel clock based
off of the original OVT timing and DSC calculations
-Store these values in the pipe and program HW with these modifications
-Added general support for cases where DSC slice config does not evenly
split the horizontal active by fixing some slice width calculations
-Updated PPS calculations for these cases

Reviewed-by: Chris Park <chris.park@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Relja Vojvodic <rvojvodi@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 35 +++++++---------
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  | 41 ++++++++-----------
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |  3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  9 ++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 10 ++++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  3 ++
 10 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 89c805457ed8..cbca3c67f439 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -95,7 +95,6 @@
 #define DC_LOGGER \
 	dc->ctx->logger
 #define DC_LOGGER_INIT(logger)
-
 #include "dml2/dml2_wrapper.h"
 
 #define UNABLE_TO_SPLIT -1
@@ -2149,7 +2148,7 @@ int resource_get_odm_slice_dst_width(struct pipe_ctx *otg_master,
 	h_active = timing->h_addressable +
 			timing->h_border_left +
 			timing->h_border_right +
-			otg_master->hblank_borrow;
+			otg_master->dsc_padding_params.dsc_hactive_padding;
 	width = h_active / count;
 
 	if (otg_master->stream_res.tg)
@@ -4267,39 +4266,33 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 	return res;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_FP)
+#endif /* CONFIG_DRM_AMD_DC_FP */
+
 /**
- * decide_hblank_borrow - Decides the horizontal blanking borrow value for a given pipe context.
+ * calculate_timing_params_for_dsc_with_padding - Calculates timing parameters for DSC with padding.
  * @pipe_ctx: Pointer to the pipe context structure.
  *
- * This function calculates the horizontal blanking borrow value for a given pipe context based on the
+ * This function calculates the timing parameters for a given pipe context based on the
  * display stream compression (DSC) configuration. If the horizontal active pixels (hactive) are less
- * than the total width of the DSC slices, it sets the hblank_borrow value to the difference. If the
- * total horizontal timing minus the hblank_borrow value is less than 32, it resets the hblank_borrow
+ * than the total width of the DSC slices, it sets the dsc_hactive_padding value to the difference. If the
+ * total horizontal timing minus the dsc_hactive_padding value is less than 32, it resets the dsc_hactive_padding
  * value to 0.
  */
-static void decide_hblank_borrow(struct pipe_ctx *pipe_ctx)
+static void calculate_timing_params_for_dsc_with_padding(struct pipe_ctx *pipe_ctx)
 {
-	uint32_t hactive;
-	uint32_t ceil_slice_width;
 	struct dc_stream_state *stream = NULL;
 
 	if (!pipe_ctx)
 		return;
 
 	stream = pipe_ctx->stream;
+	pipe_ctx->dsc_padding_params.dsc_hactive_padding = 0;
+	pipe_ctx->dsc_padding_params.dsc_htotal_padding = 0;
 
-	if (stream->timing.flags.DSC) {
-		hactive = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+	if (stream)
+		pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz = stream->timing.pix_clk_100hz;
 
-		/* Assume if determined slices does not divide Hactive evenly, Hborrow is needed for padding*/
-		if (hactive % stream->timing.dsc_cfg.num_slices_h != 0) {
-			ceil_slice_width = (hactive / stream->timing.dsc_cfg.num_slices_h) + 1;
-			pipe_ctx->hblank_borrow = ceil_slice_width * stream->timing.dsc_cfg.num_slices_h - hactive;
-
-			if (stream->timing.h_total - hactive - pipe_ctx->hblank_borrow < 32)
-				pipe_ctx->hblank_borrow = 0;
-		}
-	}
 }
 
 /**
@@ -4342,7 +4335,7 @@ enum dc_status dc_validate_global_state(
 
 			/* Decide whether hblank borrow is needed and save it in pipe_ctx */
 			if (dc->debug.enable_hblank_borrow)
-				decide_hblank_borrow(pipe_ctx);
+				calculate_timing_params_for_dsc_with_padding(pipe_ctx);
 
 			if (dc->res_pool->funcs->patch_unknown_plane_state &&
 					pipe_ctx->plane_state &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 7f57661433eb..55704d4457ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -128,7 +128,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	spl_in->odm_slice_index = resource_get_odm_slice_index(pipe_ctx);
 	// Make spl input basic out info output_size width point to stream h active
 	spl_in->basic_out.output_size.width =
-		stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->hblank_borrow;
+		stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 	// Make spl input basic out info output_size height point to v active
 	spl_in->basic_out.output_size.height =
 		stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index f6879e622271..bf5e7f4e0416 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -84,25 +84,29 @@ static unsigned int calc_max_hardware_v_total(const struct dc_stream_state *stre
 
 static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cfg *timing,
 		struct dc_stream_state *stream,
+		struct pipe_ctx *pipe_ctx,
 		struct dml2_context *dml_ctx)
 {
 	unsigned int hblank_start, vblank_start, min_hardware_refresh_in_uhz;
+	uint32_t pix_clk_100hz;
 
-	timing->h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+	timing->h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 	timing->v_active = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
 	timing->h_front_porch = stream->timing.h_front_porch;
 	timing->v_front_porch = stream->timing.v_front_porch;
 	timing->pixel_clock_khz = stream->timing.pix_clk_100hz / 10;
+	if (pipe_ctx->dsc_padding_params.dsc_hactive_padding != 0)
+		timing->pixel_clock_khz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz / 10;
 	if (stream->timing.timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
 		timing->pixel_clock_khz *= 2;
-	timing->h_total = stream->timing.h_total;
+	timing->h_total = stream->timing.h_total + pipe_ctx->dsc_padding_params.dsc_htotal_padding;
 	timing->v_total = stream->timing.v_total;
 	timing->h_sync_width = stream->timing.h_sync_width;
 	timing->interlaced = stream->timing.flags.INTERLACE;
 
 	hblank_start = stream->timing.h_total - stream->timing.h_front_porch;
 
-	timing->h_blank_end = hblank_start - stream->timing.h_addressable
+	timing->h_blank_end = hblank_start - stream->timing.h_addressable - pipe_ctx->dsc_padding_params.dsc_hactive_padding
 		- stream->timing.h_border_left - stream->timing.h_border_right;
 
 	if (hblank_start < stream->timing.h_addressable)
@@ -121,8 +125,13 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	/* limit min refresh rate to DC cap */
 	min_hardware_refresh_in_uhz = stream->timing.min_refresh_in_uhz;
 	if (stream->ctx->dc->caps.max_v_total != 0) {
-		min_hardware_refresh_in_uhz = div64_u64((stream->timing.pix_clk_100hz * 100000000ULL),
-				(stream->timing.h_total * (long long)calc_max_hardware_v_total(stream)));
+		if (pipe_ctx->dsc_padding_params.dsc_hactive_padding != 0) {
+			pix_clk_100hz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz;
+		} else {
+			pix_clk_100hz = stream->timing.pix_clk_100hz;
+		}
+		min_hardware_refresh_in_uhz = div64_u64((pix_clk_100hz * 100000000ULL),
+				(timing->h_total * (long long)calc_max_hardware_v_total(stream)));
 	}
 
 	timing->drr_config.min_refresh_uhz = max(stream->timing.min_refresh_in_uhz, min_hardware_refresh_in_uhz);
@@ -173,21 +182,6 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	timing->vblank_nom = timing->v_total - timing->v_active;
 }
 
-/**
- * adjust_dml21_hblank_timing_config_from_pipe_ctx - Adjusts the horizontal blanking timing configuration
- *                                                   based on the pipe context.
- * @timing: Pointer to the dml2_timing_cfg structure to be adjusted.
- * @pipe: Pointer to the pipe_ctx structure containing the horizontal blanking borrow value.
- *
- * This function modifies the horizontal active and blank end timings by adding and subtracting
- * the horizontal blanking borrow value from the pipe context, respectively.
- */
-static void adjust_dml21_hblank_timing_config_from_pipe_ctx(struct dml2_timing_cfg *timing, struct pipe_ctx *pipe)
-{
-	timing->h_active += pipe->hblank_borrow;
-	timing->h_blank_end -= pipe->hblank_borrow;
-}
-
 static void populate_dml21_output_config_from_stream_state(struct dml2_link_output_cfg *output,
 		struct dc_stream_state *stream, const struct pipe_ctx *pipe)
 {
@@ -487,7 +481,9 @@ static const struct scaler_data *get_scaler_data_for_plane(
 			temp_pipe->plane_state = pipe->plane_state;
 			temp_pipe->plane_res.scl_data.taps = pipe->plane_res.scl_data.taps;
 			temp_pipe->stream_res = pipe->stream_res;
-			temp_pipe->hblank_borrow = pipe->hblank_borrow;
+			temp_pipe->dsc_padding_params.dsc_hactive_padding = pipe->dsc_padding_params.dsc_hactive_padding;
+			temp_pipe->dsc_padding_params.dsc_htotal_padding = pipe->dsc_padding_params.dsc_htotal_padding;
+			temp_pipe->dsc_padding_params.dsc_pix_clk_100hz = pipe->dsc_padding_params.dsc_pix_clk_100hz;
 			dml_ctx->config.callbacks.build_scaling_params(temp_pipe);
 			break;
 		}
@@ -755,8 +751,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 			disp_cfg_stream_location = dml_dispcfg->num_streams++;
 
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
-		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], dml_ctx);
-		adjust_dml21_hblank_timing_config_from_pipe_ctx(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, &context->res_ctx.pipe_ctx[stream_index]);
+		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index], dml_ctx);
 		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index]);
 		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index], &context->stream_status[stream_index]);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index bd1b9aef6d5c..89f0d999bf35 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -406,9 +406,10 @@ bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values
 	dsc_reg_vals->alternate_ich_encoding_en = dsc_reg_vals->pps.dsc_version_minor == 1 ? 0 : 1;
 	dsc_reg_vals->ich_reset_at_eol = (dsc_cfg->is_odm || dsc_reg_vals->num_slices_h > 1) ? 0xF : 0;
 
+	// Need to find the ceiling value for the slice width
+	dsc_reg_vals->pps.slice_width = (dsc_cfg->pic_width + dsc_cfg->dc_dsc_cfg.num_slices_h - 1) / dsc_cfg->dc_dsc_cfg.num_slices_h;
 	// TODO: in addition to validating slice height (pic height must be divisible by slice height),
 	// see what happens when the same condition doesn't apply for slice_width/pic_width.
-	dsc_reg_vals->pps.slice_width = dsc_cfg->pic_width / dsc_cfg->dc_dsc_cfg.num_slices_h;
 	dsc_reg_vals->pps.slice_height = dsc_cfg->pic_height / dsc_cfg->dc_dsc_cfg.num_slices_v;
 
 	ASSERT(dsc_reg_vals->pps.slice_height * dsc_cfg->dc_dsc_cfg.num_slices_v == dsc_cfg->pic_height);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 3a6f946643ef..f39292952702 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1052,7 +1052,7 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 
 		/* Enable DSC hw block */
-		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->hblank_borrow +
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding +
 				stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 9956145e3d18..1b0b772fc5dd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -810,9 +810,12 @@ enum dc_status dcn401_enable_stream_timing(
 	if (dc->hwseq->funcs.PLAT_58856_wa && (!dc_is_dp_signal(stream->signal)))
 		dc->hwseq->funcs.PLAT_58856_wa(context, pipe_ctx);
 
-	/* if we are borrowing from hblank, h_addressable needs to be adjusted */
-	if (dc->debug.enable_hblank_borrow)
-		patched_crtc_timing.h_addressable = patched_crtc_timing.h_addressable + pipe_ctx->hblank_borrow;
+	/* if we are padding, h_addressable needs to be adjusted */
+	if (dc->debug.enable_hblank_borrow) {
+		patched_crtc_timing.h_addressable = patched_crtc_timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		patched_crtc_timing.h_total = patched_crtc_timing.h_total + pipe_ctx->dsc_padding_params.dsc_htotal_padding;
+		patched_crtc_timing.pix_clk_100hz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz;
+	}
 
 	pipe_ctx->stream_res.tg->funcs->program_timing(
 		pipe_ctx->stream_res.tg,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index d30f94c35f11..f49549147d99 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -437,6 +437,13 @@ enum p_state_switch_method {
 	P_STATE_V_BLANK_SUB_VP,
 };
 
+struct dsc_padding_params {
+	/* pixels borrowed from hblank to hactive */
+	uint8_t dsc_hactive_padding;
+	uint32_t dsc_htotal_padding;
+	uint32_t dsc_pix_clk_100hz;
+};
+
 struct pipe_ctx {
 	struct dc_plane_state *plane_state;
 	struct dc_stream_state *stream;
@@ -494,8 +501,7 @@ struct pipe_ctx {
 	/* subvp_index: only valid if the pipe is a SUBVP_MAIN*/
 	uint8_t subvp_index;
 	struct pixel_rate_divider pixel_rate_divider;
-	/* pixels borrowed from hblank to hactive */
-	uint8_t hblank_borrow;
+	struct dsc_padding_params dsc_padding_params;
 	/* next vupdate */
 	uint32_t next_vupdate;
 	uint32_t wait_frame_count;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 08ee8d2f777b..83419e1a9036 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -832,7 +832,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		enum optc_dsc_mode optc_dsc_mode;
 
 		/* Enable DSC hw block */
-		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->hblank_borrow +
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding +
 				stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index ed639437ae6b..3965a7f1b64b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2853,7 +2853,7 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_opp_head(
 		free_pipe->plane_res.xfm = pool->transforms[free_pipe_idx];
 		free_pipe->plane_res.dpp = pool->dpps[free_pipe_idx];
 		free_pipe->plane_res.mpcc_inst = pool->dpps[free_pipe_idx]->inst;
-		free_pipe->hblank_borrow = otg_master->hblank_borrow;
+		free_pipe->dsc_padding_params = otg_master->dsc_padding_params;
 		if (free_pipe->stream->timing.flags.DSC == 1) {
 			dcn20_acquire_dsc(free_pipe->stream->ctx->dc,
 					&new_ctx->res_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index d498c0983d74..1d18807e4749 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1699,6 +1699,9 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 
 	pixel_clk_params->requested_pix_clk_100hz = stream->timing.pix_clk_100hz;
 
+	if (pipe_ctx->dsc_padding_params.dsc_hactive_padding != 0)
+		pixel_clk_params->requested_pix_clk_100hz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz;
+
 	if (!pipe_ctx->stream->ctx->dc->config.unify_link_enc_assignment)
 		link_enc = link_enc_cfg_get_link_enc(link);
 	if (link_enc)
-- 
2.43.0

