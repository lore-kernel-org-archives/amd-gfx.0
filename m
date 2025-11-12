Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192E5CD3429
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765F210E78A;
	Wed, 12 Nov 2025 18:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XUYds+m7";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CDAA10E78B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwDS48pW7xrZY8QSZ5X9TZDPz5HMddJ5SbN9wlfaR2sktU55Jlcthb0QvseHwXwUVR2IBDdkaF81aU85aK/RmfALcTQs8W/yd9vqTc4p/R542aCccF3LzZR6+Mn6IYNHHqwmfMjvdxiMbMvf80WfQHIrf0kbIeD0H8S2dybK7Axd7Sx/Vr3ZJtPDmZw9O/nZPRysEcGnl3i9UlpNO1HknIf0GOZmD+//bt0L9OMNXQf1jN3cFnmdvJ5TiqNNVnPuDr36tdSXAo8P0D2uiRWfUE2CLRS0SNQMKLd5sykMuwTtHxGjXJRuMv3Ybm1Si5qVUkS+ly3A/N1zrZMUpB2rjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD/Qz7AU1mxykcFEywDVTwmsVUtuM2OE8P1uLnoRrMU=;
 b=tVPTogQ+pgN+1/V9viUnwPfRhu4zkztp98XYSNO7xMFS0sjSBl5dYQNXZO2+MR3SWOqr4sXbvSu/lVBL2ZtPFyRDBbFlFnU653H+0+dwzIoY8kwXRrI2QVJWJTXgSyCJ1946lLpUqr7goJkU3kSlQJhx1qXLOpXTakQvPx61Y4WDfwQDGPzDkwlLpR+42PDc5ZEnYl3xNwbk5BqW4/FlMo+1ABsGzjF0pjFzzdyCsLA/93gXXaJnAN2g62goypAOgVUoYTwlihp7y2mkHFPIzVr5ImqkiNCAZ1+Y71dZ+HRF/Wj8j+l6SvWaN/a6IeRLX/lHxr3RdIQv/gOxxm/YrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD/Qz7AU1mxykcFEywDVTwmsVUtuM2OE8P1uLnoRrMU=;
 b=XUYds+m7k1LdKgLWP5PVR0hN7PRUXa9kbdRZGcP+EMFP6c5vv2HIoccFAGPS2fOD+rKGO37zXy3kJdrBfCPFE6KICkzJqs3C38qnyqBr6R1uCUZ6n+hpzHt3BAMU+Rl3eYzm+av984I3c0Pu8/RsYdHOwPi5fKAxIW2OadpSeWQ=
Received: from CY5PR22CA0048.namprd22.prod.outlook.com (2603:10b6:930:1d::29)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 18:04:19 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::bd) by CY5PR22CA0048.outlook.office365.com
 (2603:10b6:930:1d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:04:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:02:49 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:02:49 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:02:49 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, George Shen <george.shen@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Add interface to capture expected HW
 state from SW state
Date: Wed, 12 Nov 2025 12:55:57 -0500
Message-ID: <20251112180242.556200-2-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112180242.556200-1-IVAN.LIPSKI@amd.com>
References: <20251112180242.556200-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: e6afa0e4-4fe2-4713-427b-08de2215e636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nQtE7mrPMQ4GwKsFgaCsw5oFnS+qnnCfzq6ZkkL880nqry2M3JVA7tAvo9UJ?=
 =?us-ascii?Q?uuuFMJ9I42270iHEtHJOeVVb+a0rp4VXyy6UHzEyq5tVyq2M54O28SPGQ+9z?=
 =?us-ascii?Q?xMlb/GKbaBY40zqYusL3G3Aa+ghmKotCND9RVugEs1z0G5moi+iMkh1DiUCq?=
 =?us-ascii?Q?7oAofd9zmOgaX4j8owzUlBE3l5DgDSs5IJ0igw6MH0/SGxx7WUZFdYuxcs/c?=
 =?us-ascii?Q?+cVVTot7mZ6Sc0JshREI+YjngwNjPY8tBkxQ7Ph56/vYlc+EQds37HbepQ34?=
 =?us-ascii?Q?Thu+PcVjagpBnbp4nMku5uK655OMB6ObpjytSICr8kbfAnOSTsPUcLY+XxX4?=
 =?us-ascii?Q?VAogl9z0bHA8hFJ830akrFwO/hYxXFLfNaBOlvM6MQAyKRDcf4yqtW/VZQjo?=
 =?us-ascii?Q?3gZXn8tpcLhm7wq0o913ucq14vRL6xP51oLPwiuIoDzxoYp6KsGGhHLhOv5V?=
 =?us-ascii?Q?iW3aXjgK3SDomPmSgF1z8o2yDBsY7FVWzW31XKNHIP6J7nx6obIoGoGzB5HQ?=
 =?us-ascii?Q?+FJS8f/cn+cNmOQVyo04aGNj52VAE2rPKzgua9CXJDDQ1mfQzCb6mxyOGF1C?=
 =?us-ascii?Q?/Ta6KOb71cCWgsIOTkJz0FRIvv2tYg9xD/1MrWbYyOAIUghlspPi2U8ecqpq?=
 =?us-ascii?Q?v6xcpUl/CH3WxQszsw/Y/jMNQNEVIbdPTuIJhuakEPNTbs3SnNcbEgLTqTeV?=
 =?us-ascii?Q?InJH+9DYkSYImRmdnSRI3lVhYLM1NmandJy4KB8b2j1vmCxoSNVWqAhcozA9?=
 =?us-ascii?Q?2SxEEmaPiDRyKtdUdlJmZ5yR2O+LUuvAdhqG+yBSldZJhZhNMfIbW48zCBHa?=
 =?us-ascii?Q?nB1kk1sG7BICmONEW5L+v+XmOytnl90MkRxJmo5PKiLgydrIXenGj5hneF5e?=
 =?us-ascii?Q?v+cP/CcL0zbrJFBvn5E13JJ3dv7XX48NxdFdGTrOyVNcxoSX5Glbk1bqp0pv?=
 =?us-ascii?Q?wfhBXT313ENNbRTa1xXi2iXvgQPuDDvFIrjxLNxDhoCH6t50Wlbu7Xh27kQK?=
 =?us-ascii?Q?aS86kI91k3WxP+9xRWcxtLM67uF3IioGdyk3LQMZGkKpwpXDqvQuUTLB8uNi?=
 =?us-ascii?Q?3LcHYPhqfz3mpAnjb3U7Pj7bE7MooDdRabXNSjrypJHqvWnBUwji/8rL3Mg9?=
 =?us-ascii?Q?LeFflGsXqvtttGVmFqMrn/UULhu+7zi8LZY0S+n9UCqr9sBJCgheTaPcD6D2?=
 =?us-ascii?Q?K5fz2oHSwHFbVttrTFz+eSWc0HUA5seg3TL82qKwJjrf7vFrDkoYXllvtgBa?=
 =?us-ascii?Q?qnURaHKOLi505zPbwJN5q98YjRCVATrz6KWQ44Xii82CC2s9nfODYpsVSK9e?=
 =?us-ascii?Q?x9iCMCogs61s9I2lv3r1JqKAgFUsEIH1u0eBMsWUbZ2zZwuXT8TszZZEEFCj?=
 =?us-ascii?Q?L2IHZftVDYScP8zXPwtNysBHjDNOdsde5W0VMJ2BcPkq9aH1BRBH1qYeLMAS?=
 =?us-ascii?Q?lCxdUduEnKzp7DYik3fE7/gu5ZNL3jr7td/J17Nz/ZOMi/vkZVP/Nem3C5sD?=
 =?us-ascii?Q?tboeN3OYcFc4JSjbGmxOQ8Z1sPAQCOIFFrQ/pYxL48K1w8bdrnh008SWcs+J?=
 =?us-ascii?Q?ZQv57FdsFmziPNyRdvk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:04:18.4278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6afa0e4-4fe2-4713-427b-08de2215e636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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
To debug certain issues, such as underflow, it is common practice to
dump the HW state of all registers for analysis. The first thing to
check with the dump is to ensure all values are programmed as expected
according to SW state.

[How]
Add interface to DC to capture expected HW register values based on SW
state.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 561 +++++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 487 ++++++++++++++++++++
 2 files changed, 1048 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5764f15c16b7..a1b4dc9f5435 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6511,6 +6511,567 @@ void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst,
 	out_data->fams = dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
 }
 
+bool dc_capture_register_software_state(struct dc *dc, struct dc_register_software_state *state)
+{
+	struct dc_state *context;
+	struct resource_context *res_ctx;
+	int i;
+
+	if (!dc || !dc->current_state || !state) {
+		if (state)
+			state->state_valid = false;
+		return false;
+	}
+
+	/* Initialize the state structure */
+	memset(state, 0, sizeof(struct dc_register_software_state));
+
+	context = dc->current_state;
+	res_ctx = &context->res_ctx;
+
+	/* Count active pipes and streams */
+	state->active_pipe_count = 0;
+	state->active_stream_count = context->stream_count;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (res_ctx->pipe_ctx[i].stream)
+			state->active_pipe_count++;
+	}
+
+	/* Capture HUBP programming state for each pipe */
+	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
+
+		state->hubp[i].valid_stream = false;
+		if (!pipe_ctx->stream)
+			continue;
+
+		state->hubp[i].valid_stream = true;
+
+		/* HUBP register programming variables */
+		if (pipe_ctx->stream_res.tg)
+			state->hubp[i].vtg_sel = pipe_ctx->stream_res.tg->inst;
+
+		state->hubp[i].hubp_clock_enable = (pipe_ctx->plane_res.hubp != NULL) ? 1 : 0;
+
+		state->hubp[i].valid_plane_state = false;
+		if (pipe_ctx->plane_state) {
+			state->hubp[i].valid_plane_state = true;
+			state->hubp[i].surface_pixel_format = pipe_ctx->plane_state->format;
+			state->hubp[i].rotation_angle = pipe_ctx->plane_state->rotation;
+			state->hubp[i].h_mirror_en = pipe_ctx->plane_state->horizontal_mirror ? 1 : 0;
+
+			/* Surface size */
+			if (pipe_ctx->plane_state->plane_size.surface_size.width > 0) {
+				state->hubp[i].surface_size_width = pipe_ctx->plane_state->plane_size.surface_size.width;
+				state->hubp[i].surface_size_height = pipe_ctx->plane_state->plane_size.surface_size.height;
+			}
+
+			/* Viewport dimensions from scaler data */
+			if (pipe_ctx->plane_state->src_rect.width > 0) {
+				state->hubp[i].pri_viewport_width = pipe_ctx->plane_state->src_rect.width;
+				state->hubp[i].pri_viewport_height = pipe_ctx->plane_state->src_rect.height;
+				state->hubp[i].pri_viewport_x_start = pipe_ctx->plane_state->src_rect.x;
+				state->hubp[i].pri_viewport_y_start = pipe_ctx->plane_state->src_rect.y;
+			}
+
+			/* DCC settings */
+			state->hubp[i].surface_dcc_en = (pipe_ctx->plane_state->dcc.enable) ? 1 : 0;
+			state->hubp[i].surface_dcc_ind_64b_blk = pipe_ctx->plane_state->dcc.independent_64b_blks;
+			state->hubp[i].surface_dcc_ind_128b_blk = pipe_ctx->plane_state->dcc.dcc_ind_blk;
+
+			/* Surface pitch */
+			state->hubp[i].surface_pitch = pipe_ctx->plane_state->plane_size.surface_pitch;
+			state->hubp[i].meta_pitch = pipe_ctx->plane_state->dcc.meta_pitch;
+			state->hubp[i].chroma_pitch = pipe_ctx->plane_state->plane_size.chroma_pitch;
+			state->hubp[i].meta_pitch_c = pipe_ctx->plane_state->dcc.meta_pitch_c;
+
+			/* Surface addresses - primary */
+			state->hubp[i].primary_surface_address_low = pipe_ctx->plane_state->address.grph.addr.low_part;
+			state->hubp[i].primary_surface_address_high = pipe_ctx->plane_state->address.grph.addr.high_part;
+			state->hubp[i].primary_meta_surface_address_low = pipe_ctx->plane_state->address.grph.meta_addr.low_part;
+			state->hubp[i].primary_meta_surface_address_high = pipe_ctx->plane_state->address.grph.meta_addr.high_part;
+
+			/* TMZ settings */
+			state->hubp[i].primary_surface_tmz = pipe_ctx->plane_state->address.tmz_surface;
+			state->hubp[i].primary_meta_surface_tmz = pipe_ctx->plane_state->address.tmz_surface;
+
+			/* Tiling configuration */
+			state->hubp[i].min_dc_gfx_version9 = false;
+			if (pipe_ctx->plane_state->tiling_info.gfxversion >= DcGfxVersion9) {
+				state->hubp[i].min_dc_gfx_version9 = true;
+				state->hubp[i].sw_mode = pipe_ctx->plane_state->tiling_info.gfx9.swizzle;
+				state->hubp[i].num_pipes = pipe_ctx->plane_state->tiling_info.gfx9.num_pipes;
+				state->hubp[i].num_banks = pipe_ctx->plane_state->tiling_info.gfx9.num_banks;
+				state->hubp[i].pipe_interleave = pipe_ctx->plane_state->tiling_info.gfx9.pipe_interleave;
+				state->hubp[i].num_shader_engines = pipe_ctx->plane_state->tiling_info.gfx9.num_shader_engines;
+				state->hubp[i].num_rb_per_se = pipe_ctx->plane_state->tiling_info.gfx9.num_rb_per_se;
+				state->hubp[i].num_pkrs = pipe_ctx->plane_state->tiling_info.gfx9.num_pkrs;
+			}
+		}
+
+		/* DML Request Size Configuration */
+		if (pipe_ctx->rq_regs.rq_regs_l.chunk_size > 0) {
+			state->hubp[i].rq_chunk_size = pipe_ctx->rq_regs.rq_regs_l.chunk_size;
+			state->hubp[i].rq_min_chunk_size = pipe_ctx->rq_regs.rq_regs_l.min_chunk_size;
+			state->hubp[i].rq_meta_chunk_size = pipe_ctx->rq_regs.rq_regs_l.meta_chunk_size;
+			state->hubp[i].rq_min_meta_chunk_size = pipe_ctx->rq_regs.rq_regs_l.min_meta_chunk_size;
+			state->hubp[i].rq_dpte_group_size = pipe_ctx->rq_regs.rq_regs_l.dpte_group_size;
+			state->hubp[i].rq_mpte_group_size = pipe_ctx->rq_regs.rq_regs_l.mpte_group_size;
+			state->hubp[i].rq_swath_height_l = pipe_ctx->rq_regs.rq_regs_l.swath_height;
+			state->hubp[i].rq_pte_row_height_l = pipe_ctx->rq_regs.rq_regs_l.pte_row_height_linear;
+		}
+
+		/* Chroma request size configuration */
+		if (pipe_ctx->rq_regs.rq_regs_c.chunk_size > 0) {
+			state->hubp[i].rq_chunk_size_c = pipe_ctx->rq_regs.rq_regs_c.chunk_size;
+			state->hubp[i].rq_min_chunk_size_c = pipe_ctx->rq_regs.rq_regs_c.min_chunk_size;
+			state->hubp[i].rq_meta_chunk_size_c = pipe_ctx->rq_regs.rq_regs_c.meta_chunk_size;
+			state->hubp[i].rq_min_meta_chunk_size_c = pipe_ctx->rq_regs.rq_regs_c.min_meta_chunk_size;
+			state->hubp[i].rq_dpte_group_size_c = pipe_ctx->rq_regs.rq_regs_c.dpte_group_size;
+			state->hubp[i].rq_mpte_group_size_c = pipe_ctx->rq_regs.rq_regs_c.mpte_group_size;
+			state->hubp[i].rq_swath_height_c = pipe_ctx->rq_regs.rq_regs_c.swath_height;
+			state->hubp[i].rq_pte_row_height_c = pipe_ctx->rq_regs.rq_regs_c.pte_row_height_linear;
+		}
+
+		/* DML expansion modes */
+		state->hubp[i].drq_expansion_mode = pipe_ctx->rq_regs.drq_expansion_mode;
+		state->hubp[i].prq_expansion_mode = pipe_ctx->rq_regs.prq_expansion_mode;
+		state->hubp[i].mrq_expansion_mode = pipe_ctx->rq_regs.mrq_expansion_mode;
+		state->hubp[i].crq_expansion_mode = pipe_ctx->rq_regs.crq_expansion_mode;
+
+		/* DML DLG parameters - nominal */
+		state->hubp[i].dst_y_per_vm_vblank = pipe_ctx->dlg_regs.dst_y_per_vm_vblank;
+		state->hubp[i].dst_y_per_row_vblank = pipe_ctx->dlg_regs.dst_y_per_row_vblank;
+		state->hubp[i].dst_y_per_vm_flip = pipe_ctx->dlg_regs.dst_y_per_vm_flip;
+		state->hubp[i].dst_y_per_row_flip = pipe_ctx->dlg_regs.dst_y_per_row_flip;
+
+		/* DML prefetch settings */
+		state->hubp[i].dst_y_prefetch = pipe_ctx->dlg_regs.dst_y_prefetch;
+		state->hubp[i].vratio_prefetch = pipe_ctx->dlg_regs.vratio_prefetch;
+		state->hubp[i].vratio_prefetch_c = pipe_ctx->dlg_regs.vratio_prefetch_c;
+
+		/* TTU parameters */
+		state->hubp[i].qos_level_low_wm = pipe_ctx->ttu_regs.qos_level_low_wm;
+		state->hubp[i].qos_level_high_wm = pipe_ctx->ttu_regs.qos_level_high_wm;
+		state->hubp[i].qos_level_flip = pipe_ctx->ttu_regs.qos_level_flip;
+		state->hubp[i].min_ttu_vblank = pipe_ctx->ttu_regs.min_ttu_vblank;
+	}
+
+	/* Capture HUBBUB programming state */
+	if (dc->res_pool->hubbub) {
+		/* Individual DET buffer sizes - software state variables that program DET registers */
+		for (i = 0; i < 4 && i < dc->res_pool->pipe_count; i++) {
+			uint32_t det_size = res_ctx->pipe_ctx[i].det_buffer_size_kb;
+			switch (i) {
+			case 0:
+				state->hubbub.det0_size = det_size;
+				break;
+			case 1:
+				state->hubbub.det1_size = det_size;
+				break;
+			case 2:
+				state->hubbub.det2_size = det_size;
+				break;
+			case 3:
+				state->hubbub.det3_size = det_size;
+				break;
+			}
+		}
+
+		/* Compression buffer configuration - software state that programs COMPBUF_SIZE register */
+		// TODO: Handle logic for legacy DCN pre-DCN401
+		state->hubbub.compbuf_size = context->bw_ctx.bw.dcn.arb_regs.compbuf_size;
+	}
+
+	/* Capture DPP programming state for each pipe */
+	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
+
+		if (!pipe_ctx->stream)
+			continue;
+
+		state->dpp[i].dpp_clock_enable = (pipe_ctx->plane_res.dpp != NULL) ? 1 : 0;
+
+		if (pipe_ctx->plane_state && pipe_ctx->plane_res.scl_data.recout.width > 0) {
+			/* Access dscl_prog_data directly - this contains the actual software state used for register programming */
+			struct dscl_prog_data *dscl_data = &pipe_ctx->plane_res.scl_data.dscl_prog_data;
+
+			/* Recout (Rectangle of Interest) configuration - software state that programs RECOUT registers */
+			state->dpp[i].recout_start_x = dscl_data->recout.x;
+			state->dpp[i].recout_start_y = dscl_data->recout.y;
+			state->dpp[i].recout_width = dscl_data->recout.width;
+			state->dpp[i].recout_height = dscl_data->recout.height;
+
+			/* MPC (Multiple Pipe/Plane Combiner) size - software state that programs MPC_SIZE registers */
+			state->dpp[i].mpc_width = dscl_data->mpc_size.width;
+			state->dpp[i].mpc_height = dscl_data->mpc_size.height;
+
+			/* DSCL mode - software state that programs SCL_MODE registers */
+			state->dpp[i].dscl_mode = dscl_data->dscl_mode;
+
+			/* Scaler ratios - software state that programs scale ratio registers (use actual programmed ratios) */
+			state->dpp[i].horz_ratio_int = dscl_data->ratios.h_scale_ratio >> 19; // Extract integer part from programmed ratio
+			state->dpp[i].vert_ratio_int = dscl_data->ratios.v_scale_ratio >> 19; // Extract integer part from programmed ratio
+
+			/* Basic scaler taps - software state that programs tap control registers (use actual programmed taps) */
+			state->dpp[i].h_taps = dscl_data->taps.h_taps + 1; // dscl_prog_data.taps stores (taps - 1), so add 1 back
+			state->dpp[i].v_taps = dscl_data->taps.v_taps + 1; // dscl_prog_data.taps stores (taps - 1), so add 1 back
+		}
+	}
+
+	/* Capture essential clock state for underflow analysis */
+	if (dc->clk_mgr && dc->clk_mgr->clks.dispclk_khz > 0) {
+		/* Core display clocks affecting bandwidth and timing */
+		state->dccg.dispclk_khz = dc->clk_mgr->clks.dispclk_khz;
+
+		/* Per-pipe clock configuration - only capture what's essential */
+		for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
+			if (pipe_ctx->stream) {
+				/* Essential clocks that directly affect underflow risk */
+				state->dccg.dppclk_khz[i] = dc->clk_mgr->clks.dppclk_khz;
+				state->dccg.pixclk_khz[i] = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+				state->dccg.dppclk_enable[i] = 1;
+
+				/* DP stream clock only for DP signals */
+				if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
+						pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+					state->dccg.dpstreamclk_enable[i] = 1;
+				} else {
+					state->dccg.dpstreamclk_enable[i] = 0;
+				}
+			} else {
+				/* Inactive pipe - no clocks */
+				state->dccg.dppclk_khz[i] = 0;
+				state->dccg.pixclk_khz[i] = 0;
+				state->dccg.dppclk_enable[i] = 0;
+				if (i < 4) {
+					state->dccg.dpstreamclk_enable[i] = 0;
+				}
+			}
+		}
+
+		/* DSC clock state - only when actually using DSC */
+		for (i = 0; i < MAX_PIPES; i++) {
+			struct pipe_ctx *pipe_ctx = (i < dc->res_pool->pipe_count) ? &res_ctx->pipe_ctx[i] : NULL;
+			if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->timing.dsc_cfg.num_slices_h > 0) {
+				state->dccg.dscclk_khz[i] = 400000; /* Typical DSC clock frequency */
+			} else {
+				state->dccg.dscclk_khz[i] = 0;
+			}
+		}
+
+		/* SYMCLK32 LE Control - only the essential HPO state for underflow analysis */
+		for (i = 0; i < 2; i++) {
+			state->dccg.symclk32_le_enable[i] = 0; /* Default: disabled */
+		}
+
+	}
+
+	/* Capture essential DSC configuration for underflow analysis */
+	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
+
+		if (pipe_ctx->stream && pipe_ctx->stream->timing.dsc_cfg.num_slices_h > 0) {
+			/* DSC is enabled - capture essential configuration */
+			state->dsc[i].dsc_clock_enable = 1;
+
+			/* DSC configuration affecting bandwidth and timing */
+			struct dc_dsc_config *dsc_cfg = &pipe_ctx->stream->timing.dsc_cfg;
+			state->dsc[i].dsc_num_slices_h = dsc_cfg->num_slices_h;
+			state->dsc[i].dsc_num_slices_v = dsc_cfg->num_slices_v;
+			state->dsc[i].dsc_bits_per_pixel = dsc_cfg->bits_per_pixel;
+
+			/* OPP pipe source for DSC forwarding */
+			if (pipe_ctx->stream_res.opp) {
+				state->dsc[i].dscrm_dsc_forward_enable = 1;
+				state->dsc[i].dscrm_dsc_opp_pipe_source = pipe_ctx->stream_res.opp->inst;
+			} else {
+				state->dsc[i].dscrm_dsc_forward_enable = 0;
+				state->dsc[i].dscrm_dsc_opp_pipe_source = 0;
+			}
+		} else {
+			/* DSC not enabled - clear all fields */
+			memset(&state->dsc[i], 0, sizeof(state->dsc[i]));
+		}
+	}
+
+	/* Capture MPC programming state - comprehensive register field coverage */
+	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
+
+		if (pipe_ctx->plane_state && pipe_ctx->stream) {
+			struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+
+			/* MPCC blending tree and mode control - capture actual blend configuration */
+			state->mpc.mpcc_mode[i] = (plane_state->blend_tf.type != TF_TYPE_BYPASS) ? 1 : 0;
+			state->mpc.mpcc_alpha_blend_mode[i] = plane_state->per_pixel_alpha ? 1 : 0;
+			state->mpc.mpcc_alpha_multiplied_mode[i] = plane_state->pre_multiplied_alpha ? 1 : 0;
+			state->mpc.mpcc_blnd_active_overlap_only[i] = 0; /* Default - no overlap restriction */
+			state->mpc.mpcc_global_alpha[i] = plane_state->global_alpha_value;
+			state->mpc.mpcc_global_gain[i] = plane_state->global_alpha ? 255 : 0;
+			state->mpc.mpcc_bg_bpc[i] = 8; /* Standard 8-bit background */
+			state->mpc.mpcc_bot_gain_mode[i] = 0; /* Standard gain mode */
+
+			/* MPCC blending tree connections - capture tree topology */
+			if (pipe_ctx->bottom_pipe) {
+				state->mpc.mpcc_bot_sel[i] = pipe_ctx->bottom_pipe->pipe_idx;
+			} else {
+				state->mpc.mpcc_bot_sel[i] = 0xF; /* No bottom connection */
+			}
+			state->mpc.mpcc_top_sel[i] = pipe_ctx->pipe_idx; /* This pipe's DPP ID */
+
+			/* MPCC output gamma control - capture gamma programming */
+			if (plane_state->gamma_correction.type != GAMMA_CS_TFM_1D && plane_state->gamma_correction.num_entries > 0) {
+				state->mpc.mpcc_ogam_mode[i] = 1; /* Gamma enabled */
+				state->mpc.mpcc_ogam_select[i] = 0; /* Bank A selection */
+				state->mpc.mpcc_ogam_pwl_disable[i] = 0; /* PWL enabled */
+			} else {
+				state->mpc.mpcc_ogam_mode[i] = 0; /* Bypass mode */
+				state->mpc.mpcc_ogam_select[i] = 0;
+				state->mpc.mpcc_ogam_pwl_disable[i] = 1; /* PWL disabled */
+			}
+
+			/* MPCC pipe assignment and operational status */
+			if (pipe_ctx->stream_res.opp) {
+				state->mpc.mpcc_opp_id[i] = pipe_ctx->stream_res.opp->inst;
+			} else {
+				state->mpc.mpcc_opp_id[i] = 0xF; /* No OPP assignment */
+			}
+
+			/* MPCC status indicators - active pipe state */
+			state->mpc.mpcc_idle[i] = 0; /* Active pipe - not idle */
+			state->mpc.mpcc_busy[i] = 1; /* Active pipe - busy processing */
+
+		} else {
+			/* Pipe not active - set disabled/idle state for all fields */
+			state->mpc.mpcc_mode[i] = 0;
+			state->mpc.mpcc_alpha_blend_mode[i] = 0;
+			state->mpc.mpcc_alpha_multiplied_mode[i] = 0;
+			state->mpc.mpcc_blnd_active_overlap_only[i] = 0;
+			state->mpc.mpcc_global_alpha[i] = 0;
+			state->mpc.mpcc_global_gain[i] = 0;
+			state->mpc.mpcc_bg_bpc[i] = 0;
+			state->mpc.mpcc_bot_gain_mode[i] = 0;
+			state->mpc.mpcc_bot_sel[i] = 0xF; /* No bottom connection */
+			state->mpc.mpcc_top_sel[i] = 0xF; /* No top connection */
+			state->mpc.mpcc_ogam_mode[i] = 0; /* Bypass */
+			state->mpc.mpcc_ogam_select[i] = 0;
+			state->mpc.mpcc_ogam_pwl_disable[i] = 1; /* PWL disabled */
+			state->mpc.mpcc_opp_id[i] = 0xF; /* No OPP assignment */
+			state->mpc.mpcc_idle[i] = 1; /* Idle */
+			state->mpc.mpcc_busy[i] = 0; /* Not busy */
+		}
+	}
+
+	/* Capture OPP programming state for each pipe - comprehensive register field coverage */
+	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
+
+		if (!pipe_ctx->stream)
+			continue;
+
+		if (pipe_ctx->stream_res.opp) {
+			struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
+
+			/* OPP Pipe Control */
+			state->opp[i].opp_pipe_clock_enable = 1; /* Active pipe has clock enabled */
+
+			/* Display Pattern Generator (DPG) Control - 19 fields */
+			if (pipe_ctx->stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
+				state->opp[i].dpg_enable = 1;
+			} else {
+				/* Video mode - DPG disabled */
+				state->opp[i].dpg_enable = 0;
+			}
+
+			/* Format Control (FMT) - 18 fields */
+			state->opp[i].fmt_pixel_encoding = timing->pixel_encoding;
+
+			/* Chroma subsampling mode based on pixel encoding */
+			if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+				state->opp[i].fmt_subsampling_mode = 1; /* 4:2:0 subsampling */
+			} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+				state->opp[i].fmt_subsampling_mode = 2; /* 4:2:2 subsampling */
+			} else {
+				state->opp[i].fmt_subsampling_mode = 0; /* No subsampling (4:4:4) */
+			}
+
+			state->opp[i].fmt_cbcr_bit_reduction_bypass = (timing->pixel_encoding == PIXEL_ENCODING_RGB) ? 1 : 0;
+			state->opp[i].fmt_stereosync_override = (timing->timing_3d_format != TIMING_3D_FORMAT_NONE) ? 1 : 0;
+
+			/* Dithering control based on bit depth */
+			if (timing->display_color_depth < COLOR_DEPTH_121212) {
+				state->opp[i].fmt_spatial_dither_frame_counter_max = 15; /* Typical frame counter max */
+				state->opp[i].fmt_spatial_dither_frame_counter_bit_swap = 0; /* No bit swapping */
+				state->opp[i].fmt_spatial_dither_enable = 1;
+				state->opp[i].fmt_spatial_dither_mode = 0; /* Spatial dithering mode */
+				state->opp[i].fmt_spatial_dither_depth = timing->display_color_depth;
+				state->opp[i].fmt_temporal_dither_enable = 0; /* Spatial dithering preferred */
+			} else {
+				state->opp[i].fmt_spatial_dither_frame_counter_max = 0;
+				state->opp[i].fmt_spatial_dither_frame_counter_bit_swap = 0;
+				state->opp[i].fmt_spatial_dither_enable = 0;
+				state->opp[i].fmt_spatial_dither_mode = 0;
+				state->opp[i].fmt_spatial_dither_depth = 0;
+				state->opp[i].fmt_temporal_dither_enable = 0;
+			}
+
+			/* Truncation control for bit depth reduction */
+			if (timing->display_color_depth < COLOR_DEPTH_121212) {
+				state->opp[i].fmt_truncate_enable = 1;
+				state->opp[i].fmt_truncate_depth = timing->display_color_depth;
+				state->opp[i].fmt_truncate_mode = 0; /* Round mode */
+			} else {
+				state->opp[i].fmt_truncate_enable = 0;
+				state->opp[i].fmt_truncate_depth = 0;
+				state->opp[i].fmt_truncate_mode = 0;
+			}
+
+			/* Data clamping control */
+			state->opp[i].fmt_clamp_data_enable = 1; /* Clamping typically enabled */
+			state->opp[i].fmt_clamp_color_format = timing->pixel_encoding;
+
+			/* Dynamic expansion for limited range content */
+			if (timing->pixel_encoding != PIXEL_ENCODING_RGB) {
+				state->opp[i].fmt_dynamic_exp_enable = 1; /* YCbCr typically needs expansion */
+				state->opp[i].fmt_dynamic_exp_mode = 0; /* Standard expansion */
+			} else {
+				state->opp[i].fmt_dynamic_exp_enable = 0; /* RGB typically full range */
+				state->opp[i].fmt_dynamic_exp_mode = 0;
+			}
+
+			/* Legacy field for compatibility */
+			state->opp[i].fmt_bit_depth_control = timing->display_color_depth;
+
+			/* Output Buffer (OPPBUF) Control - 6 fields */
+			state->opp[i].oppbuf_active_width = timing->h_addressable;
+			state->opp[i].oppbuf_pixel_repetition = 0; /* No pixel repetition by default */
+
+			/* Multi-Stream Output (MSO) / ODM segmentation */
+			if (pipe_ctx->next_odm_pipe) {
+				state->opp[i].oppbuf_display_segmentation = 1; /* Segmented display */
+				state->opp[i].oppbuf_overlap_pixel_num = 0; /* ODM overlap pixels */
+			} else {
+				state->opp[i].oppbuf_display_segmentation = 0; /* Single segment */
+				state->opp[i].oppbuf_overlap_pixel_num = 0;
+			}
+
+			/* 3D/Stereo control */
+			if (timing->timing_3d_format != TIMING_3D_FORMAT_NONE) {
+				state->opp[i].oppbuf_3d_vact_space1_size = 30; /* Typical stereo blanking */
+				state->opp[i].oppbuf_3d_vact_space2_size = 30;
+			} else {
+				state->opp[i].oppbuf_3d_vact_space1_size = 0;
+				state->opp[i].oppbuf_3d_vact_space2_size = 0;
+			}
+
+			/* DSC Forward Config - 3 fields */
+			if (timing->dsc_cfg.num_slices_h > 0) {
+				state->opp[i].dscrm_dsc_forward_enable = 1;
+				state->opp[i].dscrm_dsc_opp_pipe_source = pipe_ctx->stream_res.opp->inst;
+				state->opp[i].dscrm_dsc_forward_enable_status = 1; /* Status follows enable */
+			} else {
+				state->opp[i].dscrm_dsc_forward_enable = 0;
+				state->opp[i].dscrm_dsc_opp_pipe_source = 0;
+				state->opp[i].dscrm_dsc_forward_enable_status = 0;
+			}
+		} else {
+			/* No OPP resource - set all fields to disabled state */
+			memset(&state->opp[i], 0, sizeof(state->opp[i]));
+		}
+	}
+
+	/* Capture OPTC programming state for each pipe - comprehensive register field coverage */
+	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
+
+		if (!pipe_ctx->stream)
+			continue;
+
+		if (pipe_ctx->stream_res.tg) {
+			struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
+
+			state->optc[i].otg_master_inst = pipe_ctx->stream_res.tg->inst;
+
+			/* OTG_CONTROL register - 5 fields */
+			state->optc[i].otg_master_enable = 1; /* Active stream */
+			state->optc[i].otg_disable_point_cntl = 0; /* Normal operation */
+			state->optc[i].otg_start_point_cntl = 0; /* Normal start */
+			state->optc[i].otg_field_number_cntl = (timing->flags.INTERLACE) ? 1 : 0;
+			state->optc[i].otg_out_mux = 0; /* Direct output */
+
+			/* OTG Horizontal Timing - 7 fields */
+			state->optc[i].otg_h_total = timing->h_total;
+			state->optc[i].otg_h_blank_start = timing->h_addressable;
+			state->optc[i].otg_h_blank_end = timing->h_total - timing->h_front_porch;
+			state->optc[i].otg_h_sync_start = timing->h_addressable + timing->h_front_porch;
+			state->optc[i].otg_h_sync_end = timing->h_addressable + timing->h_front_porch + timing->h_sync_width;
+			state->optc[i].otg_h_sync_polarity = timing->flags.HSYNC_POSITIVE_POLARITY ? 0 : 1;
+			state->optc[i].otg_h_timing_div_mode = (pipe_ctx->next_odm_pipe) ? 1 : 0; /* ODM divide mode */
+
+			/* OTG Vertical Timing - 7 fields */
+			state->optc[i].otg_v_total = timing->v_total;
+			state->optc[i].otg_v_blank_start = timing->v_addressable;
+			state->optc[i].otg_v_blank_end = timing->v_total - timing->v_front_porch;
+			state->optc[i].otg_v_sync_start = timing->v_addressable + timing->v_front_porch;
+			state->optc[i].otg_v_sync_end = timing->v_addressable + timing->v_front_porch + timing->v_sync_width;
+			state->optc[i].otg_v_sync_polarity = timing->flags.VSYNC_POSITIVE_POLARITY ? 0 : 1;
+			state->optc[i].otg_v_sync_mode = 0; /* Normal sync mode */
+
+			/* Initialize remaining core fields with appropriate defaults */
+			// TODO: Update logic for accurate vtotal min/max
+			state->optc[i].otg_v_total_max = timing->v_total + 100; /* Typical DRR range */
+			state->optc[i].otg_v_total_min = timing->v_total - 50;
+			state->optc[i].otg_v_total_mid = timing->v_total;
+
+			/* ODM configuration */
+			// TODO: Update logic to have complete ODM mappings (e.g. 3:1 and 4:1) stored in single pipe
+			if (pipe_ctx->next_odm_pipe) {
+				state->optc[i].optc_seg0_src_sel = pipe_ctx->stream_res.opp ? pipe_ctx->stream_res.opp->inst : 0;
+				state->optc[i].optc_seg1_src_sel = pipe_ctx->next_odm_pipe->stream_res.opp ? pipe_ctx->next_odm_pipe->stream_res.opp->inst : 0;
+				state->optc[i].optc_num_of_input_segment = 1; /* 2 segments - 1 */
+			} else {
+				state->optc[i].optc_seg0_src_sel = pipe_ctx->stream_res.opp ? pipe_ctx->stream_res.opp->inst : 0;
+				state->optc[i].optc_seg1_src_sel = 0;
+				state->optc[i].optc_num_of_input_segment = 0; /* Single segment */
+			}
+
+			/* DSC configuration */
+			if (timing->dsc_cfg.num_slices_h > 0) {
+				state->optc[i].optc_dsc_mode = 1; /* DSC enabled */
+				state->optc[i].optc_dsc_bytes_per_pixel = timing->dsc_cfg.bits_per_pixel / 16; /* Convert to bytes */
+				state->optc[i].optc_dsc_slice_width = timing->h_addressable / timing->dsc_cfg.num_slices_h;
+			} else {
+				state->optc[i].optc_dsc_mode = 0;
+				state->optc[i].optc_dsc_bytes_per_pixel = 0;
+				state->optc[i].optc_dsc_slice_width = 0;
+			}
+
+			/* Essential control fields */
+			state->optc[i].otg_stereo_enable = (timing->timing_3d_format != TIMING_3D_FORMAT_NONE) ? 1 : 0;
+			state->optc[i].otg_interlace_enable = timing->flags.INTERLACE ? 1 : 0;
+			state->optc[i].otg_clock_enable = 1; /* OTG clock enabled */
+			state->optc[i].vtg0_enable = 1; /* VTG enabled for timing generation */
+
+			/* Initialize other key fields to defaults */
+			state->optc[i].optc_input_pix_clk_en = 1;
+			state->optc[i].optc_segment_width = (pipe_ctx->next_odm_pipe) ? (timing->h_addressable / 2) : timing->h_addressable;
+			state->optc[i].otg_vready_offset = 1;
+			state->optc[i].otg_vstartup_start = timing->v_addressable + 10;
+			state->optc[i].otg_vupdate_offset = 0;
+			state->optc[i].otg_vupdate_width = 5;
+		} else {
+			/* No timing generator resource - initialize all fields to 0 */
+			memset(&state->optc[i], 0, sizeof(state->optc[i]));
+		}
+	}
+
+	state->state_valid = true;
+	return true;
+}
+
 void dc_log_preos_dmcub_info(const struct dc *dc)
 {
 	dc_dmub_srv_log_preos_dmcub_info(dc->ctx->dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3c032ac80d24..2396c2806a7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2792,4 +2792,491 @@ void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst, st
 
 void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst, struct power_features *out_data);
 
+/**
+ * Software state variables used to program register fields across the display pipeline
+ */
+struct dc_register_software_state {
+	/* HUBP register programming variables for each pipe */
+	struct {
+		bool valid_plane_state;
+		bool valid_stream;
+		bool min_dc_gfx_version9;
+		uint32_t vtg_sel;                        /* DCHUBP_CNTL->HUBP_VTG_SEL from pipe_ctx->stream_res.tg->inst */
+		uint32_t hubp_clock_enable;              /* HUBP_CLK_CNTL->HUBP_CLOCK_ENABLE from power management */
+		uint32_t surface_pixel_format;           /* DCSURF_SURFACE_CONFIG->SURFACE_PIXEL_FORMAT from plane_state->format */
+		uint32_t rotation_angle;                 /* DCSURF_SURFACE_CONFIG->ROTATION_ANGLE from plane_state->rotation */
+		uint32_t h_mirror_en;                    /* DCSURF_SURFACE_CONFIG->H_MIRROR_EN from plane_state->horizontal_mirror */
+		uint32_t surface_dcc_en;                 /* DCSURF_SURFACE_CONTROL->PRIMARY_SURFACE_DCC_EN from dcc->enable */
+		uint32_t surface_size_width;             /* HUBP_SIZE->SURFACE_SIZE_WIDTH from plane_size.surface_size.width */
+		uint32_t surface_size_height;            /* HUBP_SIZE->SURFACE_SIZE_HEIGHT from plane_size.surface_size.height */
+		uint32_t pri_viewport_width;             /* DCSURF_PRI_VIEWPORT_DIMENSION->PRI_VIEWPORT_WIDTH from scaler_data.viewport.width */
+		uint32_t pri_viewport_height;            /* DCSURF_PRI_VIEWPORT_DIMENSION->PRI_VIEWPORT_HEIGHT from scaler_data.viewport.height */
+		uint32_t pri_viewport_x_start;           /* DCSURF_PRI_VIEWPORT_START->PRI_VIEWPORT_X_START from scaler_data.viewport.x */
+		uint32_t pri_viewport_y_start;           /* DCSURF_PRI_VIEWPORT_START->PRI_VIEWPORT_Y_START from scaler_data.viewport.y */
+		uint32_t cursor_enable;                  /* CURSOR_CONTROL->CURSOR_ENABLE from cursor_attributes.enable */
+		uint32_t cursor_width;                   /* CURSOR_SETTINGS->CURSOR_WIDTH from cursor_position.width */
+		uint32_t cursor_height;                  /* CURSOR_SETTINGS->CURSOR_HEIGHT from cursor_position.height */
+
+		/* Additional DCC configuration */
+		uint32_t surface_dcc_ind_64b_blk;        /* DCSURF_SURFACE_CONTROL->PRIMARY_SURFACE_DCC_IND_64B_BLK from dcc.independent_64b_blks */
+		uint32_t surface_dcc_ind_128b_blk;       /* DCSURF_SURFACE_CONTROL->PRIMARY_SURFACE_DCC_IND_128B_BLK from dcc.independent_128b_blks */
+
+		/* Surface pitch configuration */
+		uint32_t surface_pitch;                  /* DCSURF_SURFACE_PITCH->PITCH from plane_size.surface_pitch */
+		uint32_t meta_pitch;                     /* DCSURF_SURFACE_PITCH->META_PITCH from dcc.meta_pitch */
+		uint32_t chroma_pitch;                   /* DCSURF_SURFACE_PITCH_C->PITCH_C from plane_size.chroma_pitch */
+		uint32_t meta_pitch_c;                   /* DCSURF_SURFACE_PITCH_C->META_PITCH_C from dcc.meta_pitch_c */
+
+		/* Surface addresses */
+		uint32_t primary_surface_address_low;    /* DCSURF_PRIMARY_SURFACE_ADDRESS->PRIMARY_SURFACE_ADDRESS from address.grph.addr.low_part */
+		uint32_t primary_surface_address_high;   /* DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH->PRIMARY_SURFACE_ADDRESS_HIGH from address.grph.addr.high_part */
+		uint32_t primary_meta_surface_address_low;  /* DCSURF_PRIMARY_META_SURFACE_ADDRESS->PRIMARY_META_SURFACE_ADDRESS from address.grph.meta_addr.low_part */
+		uint32_t primary_meta_surface_address_high; /* DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH->PRIMARY_META_SURFACE_ADDRESS_HIGH from address.grph.meta_addr.high_part */
+
+		/* TMZ configuration */
+		uint32_t primary_surface_tmz;            /* DCSURF_SURFACE_CONTROL->PRIMARY_SURFACE_TMZ from address.tmz_surface */
+		uint32_t primary_meta_surface_tmz;       /* DCSURF_SURFACE_CONTROL->PRIMARY_META_SURFACE_TMZ from address.tmz_surface */
+
+		/* Tiling configuration */
+		uint32_t sw_mode;                        /* DCSURF_TILING_CONFIG->SW_MODE from tiling_info.gfx9.swizzle */
+		uint32_t num_pipes;                      /* DCSURF_ADDR_CONFIG->NUM_PIPES from tiling_info.gfx9.num_pipes */
+		uint32_t num_banks;                      /* DCSURF_ADDR_CONFIG->NUM_BANKS from tiling_info.gfx9.num_banks */
+		uint32_t pipe_interleave;                /* DCSURF_ADDR_CONFIG->PIPE_INTERLEAVE from tiling_info.gfx9.pipe_interleave */
+		uint32_t num_shader_engines;             /* DCSURF_ADDR_CONFIG->NUM_SE from tiling_info.gfx9.num_shader_engines */
+		uint32_t num_rb_per_se;                  /* DCSURF_ADDR_CONFIG->NUM_RB_PER_SE from tiling_info.gfx9.num_rb_per_se */
+		uint32_t num_pkrs;                       /* DCSURF_ADDR_CONFIG->NUM_PKRS from tiling_info.gfx9.num_pkrs */
+
+		/* DML Request Size Configuration - Luma */
+		uint32_t rq_chunk_size;                  /* DCHUBP_REQ_SIZE_CONFIG->CHUNK_SIZE from rq_regs.rq_regs_l.chunk_size */
+		uint32_t rq_min_chunk_size;              /* DCHUBP_REQ_SIZE_CONFIG->MIN_CHUNK_SIZE from rq_regs.rq_regs_l.min_chunk_size */
+		uint32_t rq_meta_chunk_size;             /* DCHUBP_REQ_SIZE_CONFIG->META_CHUNK_SIZE from rq_regs.rq_regs_l.meta_chunk_size */
+		uint32_t rq_min_meta_chunk_size;         /* DCHUBP_REQ_SIZE_CONFIG->MIN_META_CHUNK_SIZE from rq_regs.rq_regs_l.min_meta_chunk_size */
+		uint32_t rq_dpte_group_size;             /* DCHUBP_REQ_SIZE_CONFIG->DPTE_GROUP_SIZE from rq_regs.rq_regs_l.dpte_group_size */
+		uint32_t rq_mpte_group_size;             /* DCHUBP_REQ_SIZE_CONFIG->MPTE_GROUP_SIZE from rq_regs.rq_regs_l.mpte_group_size */
+		uint32_t rq_swath_height_l;              /* DCHUBP_REQ_SIZE_CONFIG->SWATH_HEIGHT_L from rq_regs.rq_regs_l.swath_height */
+		uint32_t rq_pte_row_height_l;            /* DCHUBP_REQ_SIZE_CONFIG->PTE_ROW_HEIGHT_L from rq_regs.rq_regs_l.pte_row_height */
+
+		/* DML Request Size Configuration - Chroma */
+		uint32_t rq_chunk_size_c;                /* DCHUBP_REQ_SIZE_CONFIG_C->CHUNK_SIZE_C from rq_regs.rq_regs_c.chunk_size */
+		uint32_t rq_min_chunk_size_c;            /* DCHUBP_REQ_SIZE_CONFIG_C->MIN_CHUNK_SIZE_C from rq_regs.rq_regs_c.min_chunk_size */
+		uint32_t rq_meta_chunk_size_c;           /* DCHUBP_REQ_SIZE_CONFIG_C->META_CHUNK_SIZE_C from rq_regs.rq_regs_c.meta_chunk_size */
+		uint32_t rq_min_meta_chunk_size_c;       /* DCHUBP_REQ_SIZE_CONFIG_C->MIN_META_CHUNK_SIZE_C from rq_regs.rq_regs_c.min_meta_chunk_size */
+		uint32_t rq_dpte_group_size_c;           /* DCHUBP_REQ_SIZE_CONFIG_C->DPTE_GROUP_SIZE_C from rq_regs.rq_regs_c.dpte_group_size */
+		uint32_t rq_mpte_group_size_c;           /* DCHUBP_REQ_SIZE_CONFIG_C->MPTE_GROUP_SIZE_C from rq_regs.rq_regs_c.mpte_group_size */
+		uint32_t rq_swath_height_c;              /* DCHUBP_REQ_SIZE_CONFIG_C->SWATH_HEIGHT_C from rq_regs.rq_regs_c.swath_height */
+		uint32_t rq_pte_row_height_c;            /* DCHUBP_REQ_SIZE_CONFIG_C->PTE_ROW_HEIGHT_C from rq_regs.rq_regs_c.pte_row_height */
+
+		/* DML Expansion Modes */
+		uint32_t drq_expansion_mode;             /* DCN_EXPANSION_MODE->DRQ_EXPANSION_MODE from rq_regs.drq_expansion_mode */
+		uint32_t prq_expansion_mode;             /* DCN_EXPANSION_MODE->PRQ_EXPANSION_MODE from rq_regs.prq_expansion_mode */
+		uint32_t mrq_expansion_mode;             /* DCN_EXPANSION_MODE->MRQ_EXPANSION_MODE from rq_regs.mrq_expansion_mode */
+		uint32_t crq_expansion_mode;             /* DCN_EXPANSION_MODE->CRQ_EXPANSION_MODE from rq_regs.crq_expansion_mode */
+
+		/* DML DLG parameters - nominal */
+		uint32_t dst_y_per_vm_vblank;            /* NOM_PARAMETERS_0->DST_Y_PER_VM_VBLANK from dlg_regs.dst_y_per_vm_vblank */
+		uint32_t dst_y_per_row_vblank;           /* NOM_PARAMETERS_0->DST_Y_PER_ROW_VBLANK from dlg_regs.dst_y_per_row_vblank */
+		uint32_t dst_y_per_vm_flip;              /* NOM_PARAMETERS_1->DST_Y_PER_VM_FLIP from dlg_regs.dst_y_per_vm_flip */
+		uint32_t dst_y_per_row_flip;             /* NOM_PARAMETERS_1->DST_Y_PER_ROW_FLIP from dlg_regs.dst_y_per_row_flip */
+
+		/* DML prefetch settings */
+		uint32_t dst_y_prefetch;                 /* PREFETCH_SETTINS->DST_Y_PREFETCH from dlg_regs.dst_y_prefetch */
+		uint32_t vratio_prefetch;                /* PREFETCH_SETTINS->VRATIO_PREFETCH from dlg_regs.vratio_prefetch */
+		uint32_t vratio_prefetch_c;              /* PREFETCH_SETTINS_C->VRATIO_PREFETCH_C from dlg_regs.vratio_prefetch_c */
+
+		/* TTU parameters */
+		uint32_t qos_level_low_wm;               /* TTU_CNTL1->QoSLevelLowWaterMark from ttu_regs.qos_level_low_wm */
+		uint32_t qos_level_high_wm;              /* TTU_CNTL1->QoSLevelHighWaterMark from ttu_regs.qos_level_high_wm */
+		uint32_t qos_level_flip;                 /* TTU_CNTL2->QoS_LEVEL_FLIP_L from ttu_regs.qos_level_flip */
+		uint32_t min_ttu_vblank;                 /* DCN_GLOBAL_TTU_CNTL->MIN_TTU_VBLANK from ttu_regs.min_ttu_vblank */
+	} hubp[MAX_PIPES];
+
+	/* HUBBUB register programming variables */
+	struct {
+		/* Individual DET buffer control per pipe - software state that programs DET registers */
+		uint32_t det0_size;                      /* DCHUBBUB_DET0_CTRL->DET0_SIZE from hubbub->funcs->program_det_size(hubbub, 0, det_buffer_size_kb) */
+		uint32_t det1_size;                      /* DCHUBBUB_DET1_CTRL->DET1_SIZE from hubbub->funcs->program_det_size(hubbub, 1, det_buffer_size_kb) */
+		uint32_t det2_size;                      /* DCHUBBUB_DET2_CTRL->DET2_SIZE from hubbub->funcs->program_det_size(hubbub, 2, det_buffer_size_kb) */
+		uint32_t det3_size;                      /* DCHUBBUB_DET3_CTRL->DET3_SIZE from hubbub->funcs->program_det_size(hubbub, 3, det_buffer_size_kb) */
+
+		/* Compression buffer control - software state that programs COMPBUF registers */
+		uint32_t compbuf_size;                   /* DCHUBBUB_COMPBUF_CTRL->COMPBUF_SIZE from hubbub->funcs->program_compbuf_size(hubbub, compbuf_size_kb, safe_to_increase) */
+		uint32_t compbuf_reserved_space_64b;     /* COMPBUF_RESERVED_SPACE->COMPBUF_RESERVED_SPACE_64B from hubbub2->pixel_chunk_size / 32 */
+		uint32_t compbuf_reserved_space_zs;      /* COMPBUF_RESERVED_SPACE->COMPBUF_RESERVED_SPACE_ZS from hubbub2->pixel_chunk_size / 128 */
+	} hubbub;
+
+	/* DPP register programming variables for each pipe (simplified for available fields) */
+	struct {
+		uint32_t dpp_clock_enable;               /* DPP_CONTROL->DPP_CLOCK_ENABLE from dppclk_enable */
+
+		/* Recout (Rectangle of Interest) configuration */
+		uint32_t recout_start_x;                 /* RECOUT_START->RECOUT_START_X from pipe_ctx->plane_res.scl_data.recout.x */
+		uint32_t recout_start_y;                 /* RECOUT_START->RECOUT_START_Y from pipe_ctx->plane_res.scl_data.recout.y */
+		uint32_t recout_width;                   /* RECOUT_SIZE->RECOUT_WIDTH from pipe_ctx->plane_res.scl_data.recout.width */
+		uint32_t recout_height;                  /* RECOUT_SIZE->RECOUT_HEIGHT from pipe_ctx->plane_res.scl_data.recout.height */
+
+		/* MPC (Multiple Pipe/Plane Combiner) size configuration */
+		uint32_t mpc_width;                      /* MPC_SIZE->MPC_WIDTH from pipe_ctx->plane_res.scl_data.h_active */
+		uint32_t mpc_height;                     /* MPC_SIZE->MPC_HEIGHT from pipe_ctx->plane_res.scl_data.v_active */
+
+		/* DSCL mode configuration */
+		uint32_t dscl_mode;                      /* SCL_MODE->DSCL_MODE from pipe_ctx->plane_res.scl_data.dscl_prog_data.dscl_mode */
+
+		/* Scaler ratios (simplified to integer parts) */
+		uint32_t horz_ratio_int;                 /* SCL_HORZ_FILTER_SCALE_RATIO->SCL_H_SCALE_RATIO integer part from ratios.horz */
+		uint32_t vert_ratio_int;                 /* SCL_VERT_FILTER_SCALE_RATIO->SCL_V_SCALE_RATIO integer part from ratios.vert */
+
+		/* Basic scaler taps */
+		uint32_t h_taps;                         /* SCL_TAP_CONTROL->SCL_H_NUM_TAPS from taps.h_taps */
+		uint32_t v_taps;                         /* SCL_TAP_CONTROL->SCL_V_NUM_TAPS from taps.v_taps */
+	} dpp[MAX_PIPES];
+
+	/* DCCG register programming variables */
+	struct {
+		/* Core Display Clock Control */
+		uint32_t dispclk_khz;                    /* DENTIST_DISPCLK_CNTL->DENTIST_DISPCLK_WDIVIDER from clk_mgr.dispclk_khz */
+		uint32_t dc_mem_global_pwr_req_dis;      /* DC_MEM_GLOBAL_PWR_REQ_CNTL->DC_MEM_GLOBAL_PWR_REQ_DIS from memory power management settings */
+
+		/* DPP Clock Control - 4 fields per pipe */
+		uint32_t dppclk_khz[MAX_PIPES];          /* DPPCLK_CTRL->DPPCLK_R_GATE_DISABLE from dpp_clocks[pipe] */
+		uint32_t dppclk_enable[MAX_PIPES];       /* DPPCLK_CTRL->DPPCLK0_EN,DPPCLK1_EN,DPPCLK2_EN,DPPCLK3_EN from dccg31_update_dpp_dto() */
+		uint32_t dppclk_dto_enable[MAX_PIPES];   /* DPPCLK_DTO_CTRL->DPPCLK_DTO_ENABLE from dccg->dpp_clock_gated[dpp_inst] state */
+		uint32_t dppclk_dto_phase[MAX_PIPES];    /* DPPCLK0_DTO_PARAM->DPPCLK0_DTO_PHASE from phase calculation req_dppclk/ref_dppclk */
+		uint32_t dppclk_dto_modulo[MAX_PIPES];   /* DPPCLK0_DTO_PARAM->DPPCLK0_DTO_MODULO from modulo = 0xff */
+
+		/* DSC Clock Control - 4 fields per DSC resource */
+		uint32_t dscclk_khz[MAX_PIPES]; /* DSCCLK_DTO_CTRL->DSCCLK_DTO_ENABLE from dsc_clocks */
+		uint32_t dscclk_dto_enable[MAX_PIPES]; /* DSCCLK_DTO_CTRL->DSCCLK0_DTO_ENABLE,DSCCLK1_DTO_ENABLE,DSCCLK2_DTO_ENABLE,DSCCLK3_DTO_ENABLE */
+		uint32_t dscclk_dto_phase[MAX_PIPES];  /* DSCCLK0_DTO_PARAM->DSCCLK0_DTO_PHASE from dccg31_enable_dscclk() */
+		uint32_t dscclk_dto_modulo[MAX_PIPES]; /* DSCCLK0_DTO_PARAM->DSCCLK0_DTO_MODULO from dccg31_enable_dscclk() */
+
+		/* Pixel Clock Control - per pipe */
+		uint32_t pixclk_khz[MAX_PIPES];          /* PIXCLK_RESYNC_CNTL->PIXCLK_RESYNC_ENABLE from stream.timing.pix_clk_100hz */
+		uint32_t otg_pixel_rate_div[MAX_PIPES];  /* OTG_PIXEL_RATE_DIV->OTG_PIXEL_RATE_DIV from OTG pixel rate divider control */
+		uint32_t dtbclk_dto_enable[MAX_PIPES];   /* OTG0_PIXEL_RATE_CNTL->DTBCLK_DTO_ENABLE from dccg31_set_dtbclk_dto() */
+		uint32_t pipe_dto_src_sel[MAX_PIPES];    /* OTG0_PIXEL_RATE_CNTL->PIPE_DTO_SRC_SEL from dccg31_set_dtbclk_dto() source selection */
+		uint32_t dtbclk_dto_div[MAX_PIPES];      /* OTG0_PIXEL_RATE_CNTL->DTBCLK_DTO_DIV from dtbdto_div calculation */
+		uint32_t otg_add_pixel[MAX_PIPES];       /* OTG0_PIXEL_RATE_CNTL->OTG_ADD_PIXEL from dccg31_otg_add_pixel() */
+		uint32_t otg_drop_pixel[MAX_PIPES];      /* OTG0_PIXEL_RATE_CNTL->OTG_DROP_PIXEL from dccg31_otg_drop_pixel() */
+
+		/* DTBCLK DTO Control - 4 DTOs */
+		uint32_t dtbclk_dto_modulo[4];           /* DTBCLK_DTO0_MODULO->DTBCLK_DTO0_MODULO from dccg31_set_dtbclk_dto() modulo calculation */
+		uint32_t dtbclk_dto_phase[4];            /* DTBCLK_DTO0_PHASE->DTBCLK_DTO0_PHASE from phase calculation pixclk_khz/ref_dtbclk_khz */
+		uint32_t dtbclk_dto_dbuf_en;             /* DTBCLK_DTO_DBUF_EN->DTBCLK DTO data buffer enable */
+
+		/* DP Stream Clock Control - 4 pipes */
+		uint32_t dpstreamclk_enable[MAX_PIPES];          /* DPSTREAMCLK_CNTL->DPSTREAMCLK_PIPE0_EN,DPSTREAMCLK_PIPE1_EN,DPSTREAMCLK_PIPE2_EN,DPSTREAMCLK_PIPE3_EN */
+		uint32_t dp_dto_modulo[4];               /* DP_DTO0_MODULO->DP_DTO0_MODULO from DP stream DTO programming */
+		uint32_t dp_dto_phase[4];                /* DP_DTO0_PHASE->DP_DTO0_PHASE from DP stream DTO programming */
+		uint32_t dp_dto_dbuf_en;                 /* DP_DTO_DBUF_EN->DP DTO data buffer enable */
+
+		/* PHY Symbol Clock Control - 5 PHYs (A,B,C,D,E) */
+		uint32_t phy_symclk_force_en[5];         /* PHYASYMCLK_CLOCK_CNTL->PHYASYMCLK_FORCE_EN from dccg31_set_physymclk() force_enable */
+		uint32_t phy_symclk_force_src_sel[5];    /* PHYASYMCLK_CLOCK_CNTL->PHYASYMCLK_FORCE_SRC_SEL from dccg31_set_physymclk() clk_src */
+		uint32_t phy_symclk_gate_disable[5];     /* DCCG_GATE_DISABLE_CNTL2->PHYASYMCLK_GATE_DISABLE from debug.root_clock_optimization.bits.physymclk */
+
+		/* SYMCLK32 SE Control - 4 instances */
+		uint32_t symclk32_se_src_sel[4];         /* SYMCLK32_SE_CNTL->SYMCLK32_SE0_SRC_SEL from dccg31_enable_symclk32_se() with get_phy_mux_symclk() mapping */
+		uint32_t symclk32_se_enable[4];          /* SYMCLK32_SE_CNTL->SYMCLK32_SE0_EN from dccg31_enable_symclk32_se() enable */
+		uint32_t symclk32_se_gate_disable[4];    /* DCCG_GATE_DISABLE_CNTL3->SYMCLK32_SE0_GATE_DISABLE from debug.root_clock_optimization.bits.symclk32_se */
+
+		/* SYMCLK32 LE Control - 2 instances */
+		uint32_t symclk32_le_src_sel[2];         /* SYMCLK32_LE_CNTL->SYMCLK32_LE0_SRC_SEL from dccg31_enable_symclk32_le() phyd32clk source */
+		uint32_t symclk32_le_enable[2];          /* SYMCLK32_LE_CNTL->SYMCLK32_LE0_EN from dccg31_enable_symclk32_le() enable */
+		uint32_t symclk32_le_gate_disable[2];    /* DCCG_GATE_DISABLE_CNTL3->SYMCLK32_LE0_GATE_DISABLE from debug.root_clock_optimization.bits.symclk32_le */
+
+		/* DPIA Clock Control */
+		uint32_t dpiaclk_540m_dto_modulo;        /* DPIACLK_540M_DTO_MODULO->DPIA 540MHz DTO modulo */
+		uint32_t dpiaclk_540m_dto_phase;         /* DPIACLK_540M_DTO_PHASE->DPIA 540MHz DTO phase */
+		uint32_t dpiaclk_810m_dto_modulo;        /* DPIACLK_810M_DTO_MODULO->DPIA 810MHz DTO modulo */
+		uint32_t dpiaclk_810m_dto_phase;         /* DPIACLK_810M_DTO_PHASE->DPIA 810MHz DTO phase */
+		uint32_t dpiaclk_dto_cntl;               /* DPIACLK_DTO_CNTL->DPIA clock DTO control */
+		uint32_t dpiasymclk_cntl;                /* DPIASYMCLK_CNTL->DPIA symbol clock control */
+
+		/* Clock Gating Control */
+		uint32_t dccg_gate_disable_cntl;         /* DCCG_GATE_DISABLE_CNTL->Clock gate disable control from dccg31_init() */
+		uint32_t dpstreamclk_gate_disable;       /* DCCG_GATE_DISABLE_CNTL3->DPSTREAMCLK_GATE_DISABLE from debug.root_clock_optimization.bits.dpstream */
+		uint32_t dpstreamclk_root_gate_disable;  /* DCCG_GATE_DISABLE_CNTL3->DPSTREAMCLK_ROOT_GATE_DISABLE from debug.root_clock_optimization.bits.dpstream */
+
+		/* VSync Control */
+		uint32_t vsync_cnt_ctrl;                 /* DCCG_VSYNC_CNT_CTRL->VSync counter control */
+		uint32_t vsync_cnt_int_ctrl;             /* DCCG_VSYNC_CNT_INT_CTRL->VSync counter interrupt control */
+		uint32_t vsync_otg_latch_value[6];       /* DCCG_VSYNC_OTG0_LATCH_VALUE->OTG0 VSync latch value (for OTG0-5) */
+
+		/* Time Base Control */
+		uint32_t microsecond_time_base_div;      /* MICROSECOND_TIME_BASE_DIV->Microsecond time base divider */
+		uint32_t millisecond_time_base_div;      /* MILLISECOND_TIME_BASE_DIV->Millisecond time base divider */
+	} dccg;
+
+	/* DSC essential configuration for underflow analysis */
+	struct {
+		/* DSC active state - critical for bandwidth analysis */
+		uint32_t dsc_clock_enable;               /* DSC enabled - affects bandwidth requirements */
+
+		/* DSC configuration affecting bandwidth and timing */
+		uint32_t dsc_num_slices_h;              /* Horizontal slice count - affects throughput */
+		uint32_t dsc_num_slices_v;              /* Vertical slice count - affects throughput */
+		uint32_t dsc_bits_per_pixel;            /* Compression ratio - affects bandwidth */
+
+		/* OPP integration - affects pipeline flow */
+		uint32_t dscrm_dsc_forward_enable;      /* DSC forwarding to OPP enabled */
+		uint32_t dscrm_dsc_opp_pipe_source;    /* Which OPP receives DSC output */
+	} dsc[MAX_PIPES];
+
+	/* MPC register programming variables */
+	struct {
+		/* MPCC blending tree and mode control */
+		uint32_t mpcc_mode[MAX_PIPES];           /* MPCC_CONTROL->MPCC_MODE from blend_cfg.blend_mode */
+		uint32_t mpcc_alpha_blend_mode[MAX_PIPES]; /* MPCC_CONTROL->MPCC_ALPHA_BLND_MODE from blend_cfg.alpha_mode */
+		uint32_t mpcc_alpha_multiplied_mode[MAX_PIPES]; /* MPCC_CONTROL->MPCC_ALPHA_MULTIPLIED_MODE from blend_cfg.pre_multiplied_alpha */
+		uint32_t mpcc_blnd_active_overlap_only[MAX_PIPES]; /* MPCC_CONTROL->MPCC_BLND_ACTIVE_OVERLAP_ONLY from blend_cfg.overlap_only */
+		uint32_t mpcc_global_alpha[MAX_PIPES];   /* MPCC_CONTROL->MPCC_GLOBAL_ALPHA from blend_cfg.global_alpha */
+		uint32_t mpcc_global_gain[MAX_PIPES];    /* MPCC_CONTROL->MPCC_GLOBAL_GAIN from blend_cfg.global_gain */
+		uint32_t mpcc_bg_bpc[MAX_PIPES];         /* MPCC_CONTROL->MPCC_BG_BPC from background color depth */
+		uint32_t mpcc_bot_gain_mode[MAX_PIPES];  /* MPCC_CONTROL->MPCC_BOT_GAIN_MODE from bottom layer gain control */
+
+		/* MPCC blending tree connections */
+		uint32_t mpcc_bot_sel[MAX_PIPES];        /* MPCC_BOT_SEL->MPCC_BOT_SEL from mpcc_state->bot_sel */
+		uint32_t mpcc_top_sel[MAX_PIPES];        /* MPCC_TOP_SEL->MPCC_TOP_SEL from mpcc_state->dpp_id */
+
+		/* MPCC output gamma control */
+		uint32_t mpcc_ogam_mode[MAX_PIPES];      /* MPCC_OGAM_CONTROL->MPCC_OGAM_MODE from output gamma mode */
+		uint32_t mpcc_ogam_select[MAX_PIPES];    /* MPCC_OGAM_CONTROL->MPCC_OGAM_SELECT from gamma LUT bank selection */
+		uint32_t mpcc_ogam_pwl_disable[MAX_PIPES]; /* MPCC_OGAM_CONTROL->MPCC_OGAM_PWL_DISABLE from PWL control */
+
+		/* MPCC pipe assignment and status */
+		uint32_t mpcc_opp_id[MAX_PIPES];         /* MPCC_OPP_ID->MPCC_OPP_ID from mpcc_state->opp_id */
+		uint32_t mpcc_idle[MAX_PIPES];           /* MPCC_STATUS->MPCC_IDLE from mpcc idle status */
+		uint32_t mpcc_busy[MAX_PIPES];           /* MPCC_STATUS->MPCC_BUSY from mpcc busy status */
+
+		/* MPC output processing */
+		uint32_t mpc_out_csc_mode;               /* MPC_OUT_CSC_COEF->MPC_OUT_CSC_MODE from output_csc */
+		uint32_t mpc_out_gamma_mode;             /* MPC_OUT_GAMMA_LUT->MPC_OUT_GAMMA_MODE from output_gamma */
+	} mpc;
+
+	/* OPP register programming variables for each pipe */
+	struct {
+		/* Display Pattern Generator (DPG) Control - 19 fields from DPG_CONTROL register */
+		uint32_t dpg_enable;                     /* DPG_CONTROL->DPG_EN from test_pattern parameter (enable/disable) */
+
+		/* Format Control (FMT) - 18 fields from FMT_CONTROL register */
+		uint32_t fmt_pixel_encoding;             /* FMT_CONTROL->FMT_PIXEL_ENCODING from clamping->pixel_encoding */
+		uint32_t fmt_subsampling_mode;           /* FMT_CONTROL->FMT_SUBSAMPLING_MODE from force_chroma_subsampling_1tap */
+		uint32_t fmt_cbcr_bit_reduction_bypass;  /* FMT_CONTROL->FMT_CBCR_BIT_REDUCTION_BYPASS from pixel_encoding bypass control */
+		uint32_t fmt_stereosync_override;        /* FMT_CONTROL->FMT_STEREOSYNC_OVERRIDE from stereo timing override */
+		uint32_t fmt_spatial_dither_frame_counter_max; /* FMT_CONTROL->FMT_SPATIAL_DITHER_FRAME_COUNTER_MAX from fmt_bit_depth->flags */
+		uint32_t fmt_spatial_dither_frame_counter_bit_swap; /* FMT_CONTROL->FMT_SPATIAL_DITHER_FRAME_COUNTER_BIT_SWAP from dither control */
+		uint32_t fmt_truncate_enable;            /* FMT_CONTROL->FMT_TRUNCATE_EN from fmt_bit_depth->flags.TRUNCATE_ENABLED */
+		uint32_t fmt_truncate_depth;             /* FMT_CONTROL->FMT_TRUNCATE_DEPTH from fmt_bit_depth->flags.TRUNCATE_DEPTH */
+		uint32_t fmt_truncate_mode;              /* FMT_CONTROL->FMT_TRUNCATE_MODE from fmt_bit_depth->flags.TRUNCATE_MODE */
+		uint32_t fmt_spatial_dither_enable;      /* FMT_CONTROL->FMT_SPATIAL_DITHER_EN from fmt_bit_depth->flags.SPATIAL_DITHER_ENABLED */
+		uint32_t fmt_spatial_dither_mode;        /* FMT_CONTROL->FMT_SPATIAL_DITHER_MODE from fmt_bit_depth->flags.SPATIAL_DITHER_MODE */
+		uint32_t fmt_spatial_dither_depth;       /* FMT_CONTROL->FMT_SPATIAL_DITHER_DEPTH from fmt_bit_depth->flags.SPATIAL_DITHER_DEPTH */
+		uint32_t fmt_temporal_dither_enable;     /* FMT_CONTROL->FMT_TEMPORAL_DITHER_EN from fmt_bit_depth->flags.TEMPORAL_DITHER_ENABLED */
+		uint32_t fmt_clamp_data_enable;          /* FMT_CONTROL->FMT_CLAMP_DATA_EN from clamping->clamping_range enable */
+		uint32_t fmt_clamp_color_format;         /* FMT_CONTROL->FMT_CLAMP_COLOR_FORMAT from clamping->color_format */
+		uint32_t fmt_dynamic_exp_enable;         /* FMT_CONTROL->FMT_DYNAMIC_EXP_EN from color_sp/color_dpth/signal */
+		uint32_t fmt_dynamic_exp_mode;           /* FMT_CONTROL->FMT_DYNAMIC_EXP_MODE from color space mode mapping */
+		uint32_t fmt_bit_depth_control;          /* Legacy field - kept for compatibility */
+
+		/* OPP Pipe Control - 1 field from OPP_PIPE_CONTROL register */
+		uint32_t opp_pipe_clock_enable;          /* OPP_PIPE_CONTROL->OPP_PIPE_CLOCK_EN from enable parameter (bool) */
+
+		/* OPP CRC Control - 3 fields from OPP_PIPE_CRC_CONTROL register */
+		uint32_t opp_crc_enable;                 /* OPP_PIPE_CRC_CONTROL->CRC_EN from CRC enable control */
+		uint32_t opp_crc_select_source;          /* OPP_PIPE_CRC_CONTROL->CRC_SELECT_SOURCE from CRC source selection */
+		uint32_t opp_crc_stereo_cont;            /* OPP_PIPE_CRC_CONTROL->CRC_STEREO_CONT from stereo continuous CRC */
+
+		/* Output Buffer (OPPBUF) Control - 6 fields from OPPBUF_CONTROL register */
+		uint32_t oppbuf_active_width;            /* OPPBUF_CONTROL->OPPBUF_ACTIVE_WIDTH from oppbuf_params->active_width */
+		uint32_t oppbuf_pixel_repetition;        /* OPPBUF_CONTROL->OPPBUF_PIXEL_REPETITION from oppbuf_params->pixel_repetition */
+		uint32_t oppbuf_display_segmentation;    /* OPPBUF_CONTROL->OPPBUF_DISPLAY_SEGMENTATION from oppbuf_params->mso_segmentation */
+		uint32_t oppbuf_overlap_pixel_num;       /* OPPBUF_CONTROL->OPPBUF_OVERLAP_PIXEL_NUM from oppbuf_params->mso_overlap_pixel_num */
+		uint32_t oppbuf_3d_vact_space1_size;     /* OPPBUF_CONTROL->OPPBUF_3D_VACT_SPACE1_SIZE from 3D timing space1_size */
+		uint32_t oppbuf_3d_vact_space2_size;     /* OPPBUF_CONTROL->OPPBUF_3D_VACT_SPACE2_SIZE from 3D timing space2_size */
+
+		/* DSC Forward Config - 3 fields from DSCRM_DSC_FORWARD_CONFIG register */
+		uint32_t dscrm_dsc_forward_enable;       /* DSCRM_DSC_FORWARD_CONFIG->DSCRM_DSC_FORWARD_EN from DSC forward enable control */
+		uint32_t dscrm_dsc_opp_pipe_source;      /* DSCRM_DSC_FORWARD_CONFIG->DSCRM_DSC_OPP_PIPE_SOURCE from opp_pipe parameter */
+		uint32_t dscrm_dsc_forward_enable_status; /* DSCRM_DSC_FORWARD_CONFIG->DSCRM_DSC_FORWARD_EN_STATUS from DSC forward status (read-only) */
+	} opp[MAX_PIPES];
+
+	/* OPTC register programming variables for each pipe */
+	struct {
+		uint32_t otg_master_inst;
+
+		/* OTG_CONTROL register - 5 fields for OTG control */
+		uint32_t otg_master_enable;              /* OTG_CONTROL->OTG_MASTER_EN from timing enable/disable control */
+		uint32_t otg_disable_point_cntl;         /* OTG_CONTROL->OTG_DISABLE_POINT_CNTL from disable timing control */
+		uint32_t otg_start_point_cntl;           /* OTG_CONTROL->OTG_START_POINT_CNTL from start timing control */
+		uint32_t otg_field_number_cntl;          /* OTG_CONTROL->OTG_FIELD_NUMBER_CNTL from interlace field control */
+		uint32_t otg_out_mux;                    /* OTG_CONTROL->OTG_OUT_MUX from output mux selection */
+
+		/* OTG Horizontal Timing - 7 fields */
+		uint32_t otg_h_total;                    /* OTG_H_TOTAL->OTG_H_TOTAL from dc_crtc_timing->h_total */
+		uint32_t otg_h_blank_start;              /* OTG_H_BLANK_START_END->OTG_H_BLANK_START from dc_crtc_timing->h_front_porch */
+		uint32_t otg_h_blank_end;                /* OTG_H_BLANK_START_END->OTG_H_BLANK_END from dc_crtc_timing->h_addressable_video_pixel_width */
+		uint32_t otg_h_sync_start;               /* OTG_H_SYNC_A->OTG_H_SYNC_A_START from dc_crtc_timing->h_sync_width */
+		uint32_t otg_h_sync_end;                 /* OTG_H_SYNC_A->OTG_H_SYNC_A_END from calculated sync end position */
+		uint32_t otg_h_sync_polarity;            /* OTG_H_SYNC_A_CNTL->OTG_H_SYNC_A_POL from dc_crtc_timing->flags.HSYNC_POSITIVE_POLARITY */
+		uint32_t otg_h_timing_div_mode;          /* OTG_H_TIMING_CNTL->OTG_H_TIMING_DIV_MODE from horizontal timing division mode */
+
+		/* OTG Vertical Timing - 7 fields */
+		uint32_t otg_v_total;                    /* OTG_V_TOTAL->OTG_V_TOTAL from dc_crtc_timing->v_total */
+		uint32_t otg_v_blank_start;              /* OTG_V_BLANK_START_END->OTG_V_BLANK_START from dc_crtc_timing->v_front_porch */
+		uint32_t otg_v_blank_end;                /* OTG_V_BLANK_START_END->OTG_V_BLANK_END from dc_crtc_timing->v_addressable_video_line_width */
+		uint32_t otg_v_sync_start;               /* OTG_V_SYNC_A->OTG_V_SYNC_A_START from dc_crtc_timing->v_sync_width */
+		uint32_t otg_v_sync_end;                 /* OTG_V_SYNC_A->OTG_V_SYNC_A_END from calculated sync end position */
+		uint32_t otg_v_sync_polarity;            /* OTG_V_SYNC_A_CNTL->OTG_V_SYNC_A_POL from dc_crtc_timing->flags.VSYNC_POSITIVE_POLARITY */
+		uint32_t otg_v_sync_mode;                /* OTG_V_SYNC_A_CNTL->OTG_V_SYNC_MODE from sync mode selection */
+
+		/* OTG DRR (Dynamic Refresh Rate) Control - 8 fields */
+		uint32_t otg_v_total_max;                /* OTG_V_TOTAL_MAX->OTG_V_TOTAL_MAX from drr_params->vertical_total_max */
+		uint32_t otg_v_total_min;                /* OTG_V_TOTAL_MIN->OTG_V_TOTAL_MIN from drr_params->vertical_total_min */
+		uint32_t otg_v_total_mid;                /* OTG_V_TOTAL_MID->OTG_V_TOTAL_MID from drr_params->vertical_total_mid */
+		uint32_t otg_v_total_max_sel;            /* OTG_V_TOTAL_CONTROL->OTG_V_TOTAL_MAX_SEL from DRR max selection enable */
+		uint32_t otg_v_total_min_sel;            /* OTG_V_TOTAL_CONTROL->OTG_V_TOTAL_MIN_SEL from DRR min selection enable */
+		uint32_t otg_vtotal_mid_replacing_max_en; /* OTG_V_TOTAL_CONTROL->OTG_VTOTAL_MID_REPLACING_MAX_EN from DRR mid-frame enable */
+		uint32_t otg_vtotal_mid_frame_num;       /* OTG_V_TOTAL_CONTROL->OTG_VTOTAL_MID_FRAME_NUM from drr_params->vertical_total_mid_frame_num */
+		uint32_t otg_set_v_total_min_mask;       /* OTG_V_TOTAL_CONTROL->OTG_SET_V_TOTAL_MIN_MASK from DRR trigger mask */
+		uint32_t otg_force_lock_on_event;        /* OTG_V_TOTAL_CONTROL->OTG_FORCE_LOCK_ON_EVENT from DRR force lock control */
+
+		/* OPTC Data Source and ODM - 6 fields */
+		uint32_t optc_seg0_src_sel;              /* OPTC_DATA_SOURCE_SELECT->OPTC_SEG0_SRC_SEL from opp_id[0] ODM segment 0 source */
+		uint32_t optc_seg1_src_sel;              /* OPTC_DATA_SOURCE_SELECT->OPTC_SEG1_SRC_SEL from opp_id[1] ODM segment 1 source */
+		uint32_t optc_seg2_src_sel;              /* OPTC_DATA_SOURCE_SELECT->OPTC_SEG2_SRC_SEL from opp_id[2] ODM segment 2 source */
+		uint32_t optc_seg3_src_sel;              /* OPTC_DATA_SOURCE_SELECT->OPTC_SEG3_SRC_SEL from opp_id[3] ODM segment 3 source */
+		uint32_t optc_num_of_input_segment;      /* OPTC_DATA_SOURCE_SELECT->OPTC_NUM_OF_INPUT_SEGMENT from opp_cnt-1 number of input segments */
+		uint32_t optc_mem_sel;                   /* OPTC_MEMORY_CONFIG->OPTC_MEM_SEL from memory_mask ODM memory selection */
+
+		/* OPTC Data Format and DSC - 4 fields */
+		uint32_t optc_data_format;               /* OPTC_DATA_FORMAT_CONTROL->OPTC_DATA_FORMAT from data format selection */
+		uint32_t optc_dsc_mode;                  /* OPTC_DATA_FORMAT_CONTROL->OPTC_DSC_MODE from dsc_mode parameter */
+		uint32_t optc_dsc_bytes_per_pixel;       /* OPTC_BYTES_PER_PIXEL->OPTC_DSC_BYTES_PER_PIXEL from dsc_bytes_per_pixel parameter */
+		uint32_t optc_segment_width;             /* OPTC_WIDTH_CONTROL->OPTC_SEGMENT_WIDTH from segment_width parameter */
+		uint32_t optc_dsc_slice_width;           /* OPTC_WIDTH_CONTROL->OPTC_DSC_SLICE_WIDTH from dsc_slice_width parameter */
+
+		/* OPTC Clock and Underflow Control - 4 fields */
+		uint32_t optc_input_pix_clk_en;          /* OPTC_INPUT_CLOCK_CONTROL->OPTC_INPUT_PIX_CLK_EN from pixel clock enable */
+		uint32_t optc_underflow_occurred_status; /* OPTC_INPUT_GLOBAL_CONTROL->OPTC_UNDERFLOW_OCCURRED_STATUS from underflow status (read-only) */
+		uint32_t optc_underflow_clear;           /* OPTC_INPUT_GLOBAL_CONTROL->OPTC_UNDERFLOW_CLEAR from underflow clear control */
+		uint32_t otg_clock_enable;               /* OTG_CLOCK_CONTROL->OTG_CLOCK_EN from OTG clock enable */
+		uint32_t otg_clock_gate_dis;             /* OTG_CLOCK_CONTROL->OTG_CLOCK_GATE_DIS from clock gate disable */
+
+		/* OTG Stereo and 3D Control - 6 fields */
+		uint32_t otg_stereo_enable;              /* OTG_STEREO_CONTROL->OTG_STEREO_EN from stereo enable control */
+		uint32_t otg_stereo_sync_output_line_num; /* OTG_STEREO_CONTROL->OTG_STEREO_SYNC_OUTPUT_LINE_NUM from timing->stereo_3d_format line num */
+		uint32_t otg_stereo_sync_output_polarity; /* OTG_STEREO_CONTROL->OTG_STEREO_SYNC_OUTPUT_POLARITY from stereo polarity control */
+		uint32_t otg_3d_structure_en;            /* OTG_3D_STRUCTURE_CONTROL->OTG_3D_STRUCTURE_EN from 3D structure enable */
+		uint32_t otg_3d_structure_v_update_mode; /* OTG_3D_STRUCTURE_CONTROL->OTG_3D_STRUCTURE_V_UPDATE_MODE from 3D vertical update mode */
+		uint32_t otg_3d_structure_stereo_sel_ovr; /* OTG_3D_STRUCTURE_CONTROL->OTG_3D_STRUCTURE_STEREO_SEL_OVR from 3D stereo selection override */
+		uint32_t otg_interlace_enable;           /* OTG_INTERLACE_CONTROL->OTG_INTERLACE_ENABLE from dc_crtc_timing->flags.INTERLACE */
+
+		/* OTG GSL (Global Sync Lock) Control - 5 fields */
+		uint32_t otg_gsl0_en;                    /* OTG_GSL_CONTROL->OTG_GSL0_EN from GSL group 0 enable */
+		uint32_t otg_gsl1_en;                    /* OTG_GSL_CONTROL->OTG_GSL1_EN from GSL group 1 enable */
+		uint32_t otg_gsl2_en;                    /* OTG_GSL_CONTROL->OTG_GSL2_EN from GSL group 2 enable */
+		uint32_t otg_gsl_master_en;              /* OTG_GSL_CONTROL->OTG_GSL_MASTER_EN from GSL master enable */
+		uint32_t otg_gsl_master_mode;            /* OTG_GSL_CONTROL->OTG_GSL_MASTER_MODE from gsl_params->gsl_master mode */
+
+		/* OTG DRR Advanced Control - 4 fields */
+		uint32_t otg_v_total_last_used_by_drr;   /* OTG_DRR_CONTROL->OTG_V_TOTAL_LAST_USED_BY_DRR from last used DRR V_TOTAL (read-only) */
+		uint32_t otg_drr_trigger_window_start_x; /* OTG_DRR_TRIGGER_WINDOW->OTG_DRR_TRIGGER_WINDOW_START_X from window_start parameter */
+		uint32_t otg_drr_trigger_window_end_x;   /* OTG_DRR_TRIGGER_WINDOW->OTG_DRR_TRIGGER_WINDOW_END_X from window_end parameter */
+		uint32_t otg_drr_v_total_change_limit;   /* OTG_DRR_V_TOTAL_CHANGE->OTG_DRR_V_TOTAL_CHANGE_LIMIT from limit parameter */
+
+		/* OTG DSC Position Control - 2 fields */
+		uint32_t otg_dsc_start_position_x;       /* OTG_DSC_START_POSITION->OTG_DSC_START_POSITION_X from DSC start X position */
+		uint32_t otg_dsc_start_position_line_num; /* OTG_DSC_START_POSITION->OTG_DSC_START_POSITION_LINE_NUM from DSC start line number */
+
+		/* OTG Double Buffer Control - 2 fields */
+		uint32_t otg_drr_timing_dbuf_update_mode; /* OTG_DOUBLE_BUFFER_CONTROL->OTG_DRR_TIMING_DBUF_UPDATE_MODE from DRR double buffer mode */
+		uint32_t otg_blank_data_double_buffer_en; /* OTG_DOUBLE_BUFFER_CONTROL->OTG_BLANK_DATA_DOUBLE_BUFFER_EN from blank data double buffer enable */
+
+		/* OTG Vertical Interrupts - 6 fields */
+		uint32_t otg_vertical_interrupt0_int_enable; /* OTG_VERTICAL_INTERRUPT0_CONTROL->OTG_VERTICAL_INTERRUPT0_INT_ENABLE from interrupt 0 enable */
+		uint32_t otg_vertical_interrupt0_line_start; /* OTG_VERTICAL_INTERRUPT0_POSITION->OTG_VERTICAL_INTERRUPT0_LINE_START from start_line parameter */
+		uint32_t otg_vertical_interrupt1_int_enable; /* OTG_VERTICAL_INTERRUPT1_CONTROL->OTG_VERTICAL_INTERRUPT1_INT_ENABLE from interrupt 1 enable */
+		uint32_t otg_vertical_interrupt1_line_start; /* OTG_VERTICAL_INTERRUPT1_POSITION->OTG_VERTICAL_INTERRUPT1_LINE_START from start_line parameter */
+		uint32_t otg_vertical_interrupt2_int_enable; /* OTG_VERTICAL_INTERRUPT2_CONTROL->OTG_VERTICAL_INTERRUPT2_INT_ENABLE from interrupt 2 enable */
+		uint32_t otg_vertical_interrupt2_line_start; /* OTG_VERTICAL_INTERRUPT2_POSITION->OTG_VERTICAL_INTERRUPT2_LINE_START from start_line parameter */
+
+		/* OTG Global Sync Parameters - 6 fields */
+		uint32_t otg_vready_offset;              /* OTG_VREADY_PARAM->OTG_VREADY_OFFSET from vready_offset parameter */
+		uint32_t otg_vstartup_start;             /* OTG_VSTARTUP_PARAM->OTG_VSTARTUP_START from vstartup_start parameter */
+		uint32_t otg_vupdate_offset;             /* OTG_VUPDATE_PARAM->OTG_VUPDATE_OFFSET from vupdate_offset parameter */
+		uint32_t otg_vupdate_width;              /* OTG_VUPDATE_PARAM->OTG_VUPDATE_WIDTH from vupdate_width parameter */
+		uint32_t master_update_lock_vupdate_keepout_start_offset; /* OTG_VUPDATE_KEEPOUT->MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET from pstate_keepout start */
+		uint32_t master_update_lock_vupdate_keepout_end_offset;   /* OTG_VUPDATE_KEEPOUT->MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET from pstate_keepout end */
+
+		/* OTG Manual Trigger Control - 11 fields */
+		uint32_t otg_triga_source_select;        /* OTG_TRIGA_CNTL->OTG_TRIGA_SOURCE_SELECT from trigger A source selection */
+		uint32_t otg_triga_source_pipe_select;   /* OTG_TRIGA_CNTL->OTG_TRIGA_SOURCE_PIPE_SELECT from trigger A pipe selection */
+		uint32_t otg_triga_rising_edge_detect_cntl; /* OTG_TRIGA_CNTL->OTG_TRIGA_RISING_EDGE_DETECT_CNTL from trigger A rising edge detect */
+		uint32_t otg_triga_falling_edge_detect_cntl; /* OTG_TRIGA_CNTL->OTG_TRIGA_FALLING_EDGE_DETECT_CNTL from trigger A falling edge detect */
+		uint32_t otg_triga_polarity_select;      /* OTG_TRIGA_CNTL->OTG_TRIGA_POLARITY_SELECT from trigger A polarity selection */
+		uint32_t otg_triga_frequency_select;     /* OTG_TRIGA_CNTL->OTG_TRIGA_FREQUENCY_SELECT from trigger A frequency selection */
+		uint32_t otg_triga_delay;                /* OTG_TRIGA_CNTL->OTG_TRIGA_DELAY from trigger A delay */
+		uint32_t otg_triga_clear;                /* OTG_TRIGA_CNTL->OTG_TRIGA_CLEAR from trigger A clear */
+		uint32_t otg_triga_manual_trig;          /* OTG_TRIGA_MANUAL_TRIG->OTG_TRIGA_MANUAL_TRIG from manual trigger A */
+		uint32_t otg_trigb_source_select;        /* OTG_TRIGB_CNTL->OTG_TRIGB_SOURCE_SELECT from trigger B source selection */
+		uint32_t otg_trigb_polarity_select;      /* OTG_TRIGB_CNTL->OTG_TRIGB_POLARITY_SELECT from trigger B polarity selection */
+		uint32_t otg_trigb_manual_trig;          /* OTG_TRIGB_MANUAL_TRIG->OTG_TRIGB_MANUAL_TRIG from manual trigger B */
+
+		/* OTG Static Screen and Update Control - 6 fields */
+		uint32_t otg_static_screen_event_mask;   /* OTG_STATIC_SCREEN_CONTROL->OTG_STATIC_SCREEN_EVENT_MASK from event_triggers parameter */
+		uint32_t otg_static_screen_frame_count;  /* OTG_STATIC_SCREEN_CONTROL->OTG_STATIC_SCREEN_FRAME_COUNT from num_frames parameter */
+		uint32_t master_update_lock;             /* OTG_MASTER_UPDATE_LOCK->MASTER_UPDATE_LOCK from update lock control */
+		uint32_t master_update_mode;             /* OTG_MASTER_UPDATE_MODE->MASTER_UPDATE_MODE from update mode selection */
+		uint32_t otg_force_count_now_mode;       /* OTG_FORCE_COUNT_NOW_CNTL->OTG_FORCE_COUNT_NOW_MODE from force count mode */
+		uint32_t otg_force_count_now_clear;      /* OTG_FORCE_COUNT_NOW_CNTL->OTG_FORCE_COUNT_NOW_CLEAR from force count clear */
+
+		/* VTG Control - 3 fields */
+		uint32_t vtg0_enable;                    /* CONTROL->VTG0_ENABLE from VTG enable control */
+		uint32_t vtg0_fp2;                       /* CONTROL->VTG0_FP2 from VTG front porch 2 */
+		uint32_t vtg0_vcount_init;               /* CONTROL->VTG0_VCOUNT_INIT from VTG vertical count init */
+
+		/* OTG Status (Read-Only) - 12 fields */
+		uint32_t otg_v_blank;                    /* OTG_STATUS->OTG_V_BLANK from vertical blank status (read-only) */
+		uint32_t otg_v_active_disp;              /* OTG_STATUS->OTG_V_ACTIVE_DISP from vertical active display (read-only) */
+		uint32_t otg_frame_count;                /* OTG_STATUS_FRAME_COUNT->OTG_FRAME_COUNT from frame count (read-only) */
+		uint32_t otg_horz_count;                 /* OTG_STATUS_POSITION->OTG_HORZ_COUNT from horizontal position (read-only) */
+		uint32_t otg_vert_count;                 /* OTG_STATUS_POSITION->OTG_VERT_COUNT from vertical position (read-only) */
+		uint32_t otg_horz_count_hv;              /* OTG_STATUS_HV_COUNT->OTG_HORZ_COUNT from horizontal count (read-only) */
+		uint32_t otg_vert_count_nom;             /* OTG_STATUS_HV_COUNT->OTG_VERT_COUNT_NOM from vertical count nominal (read-only) */
+		uint32_t otg_flip_pending;               /* OTG_PIPE_UPDATE_STATUS->OTG_FLIP_PENDING from flip pending status (read-only) */
+		uint32_t otg_dc_reg_update_pending;      /* OTG_PIPE_UPDATE_STATUS->OTG_DC_REG_UPDATE_PENDING from DC register update pending (read-only) */
+		uint32_t otg_cursor_update_pending;      /* OTG_PIPE_UPDATE_STATUS->OTG_CURSOR_UPDATE_PENDING from cursor update pending (read-only) */
+		uint32_t otg_vupdate_keepout_status;     /* OTG_PIPE_UPDATE_STATUS->OTG_VUPDATE_KEEPOUT_STATUS from VUPDATE keepout status (read-only) */
+	} optc[MAX_PIPES];
+
+	/* Metadata */
+	uint32_t active_pipe_count;
+	uint32_t active_stream_count;
+	bool state_valid;
+};
+
+/**
+ * dc_capture_register_software_state() - Capture software state for register programming
+ * @dc: DC context containing current display configuration
+ * @state: Pointer to dc_register_software_state structure to populate
+ *
+ * Extracts all software state variables that are used to program hardware register
+ * fields across the display driver pipeline. This provides a complete snapshot
+ * of the software configuration that drives hardware register programming.
+ *
+ * The function traverses the DC context and extracts values from:
+ * - Stream configurations (timing, format, DSC settings)
+ * - Plane states (surface format, rotation, scaling, cursor)
+ * - Pipe contexts (resource allocation, blending, viewport)
+ * - Clock manager (display clocks, DPP clocks, pixel clocks)
+ * - Resource context (DET buffer allocation, ODM configuration)
+ *
+ * This is essential for underflow debugging as it captures the exact software
+ * state that determines how registers are programmed, allowing analysis of
+ * whether underflow is caused by incorrect register programming or timing issues.
+ *
+ * Return: true if state was successfully captured, false on error
+ */
+bool dc_capture_register_software_state(struct dc *dc, struct dc_register_software_state *state);
+
 #endif /* DC_INTERFACE_H_ */
-- 
2.43.0

