Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7069CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E06010E8C8;
	Wed,  8 Oct 2025 18:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xPPL69+g";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44F2D10E8C5
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMEcIK+RWag7SELzRGxapRU19WOQC88pKkVPVeCTutcedwqdy8yl4EcWPNbm6/YmO85q7hvwo356+nDzui9kBypVtVuKYT8/dA7vKaCr2PSgeyo7Rplj4p1WLd02XsHFQshknL/LfpVJTOxywR+CGe7o1HuCZnaC7DakZPXZTMGLJMC8bqVNvruxNfqAMHomccvhsxeKy8oPFLU16zRd9umATMotRKw1onZxskVEkBXYsudhDXF1bUXH+vlzB/onjNsAfKC+sMFRCK9LYNdJexniuh8LQeCLJRmKCGzYYEsFDV+lhEuYk6NjS1rWSGOe2o/sstDhiY4Ahbo6QZCQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p+16Q9AMAE3/mNvcCPk9TMzJnQemzJSNSKsVDYrIAc=;
 b=NVdwK68K8n8GdAOI9/BtSQ46OhW7kGgO87S2/mniI6KwsrkflKYDUiLBgBfKFP5/ISQnXnR9C3BHyzTNo4HFkaQSh1b0YoxQOy5jAXyG1Q93RXk35akPBtyecUGJ4kF8rrI1wik7SH82uq64+XyVPd2eIHdXQiT6n9MvHBUr0QLVcUjG67mM7XMt4EsCbsaDgw6z2dlc536NXcKqQtPp57kkIgLAy0/dXlvLkzXDek43PW7ipoqqSfntbZkeb/ePeuCbPVXHdDm4R6UqtzXwrcXmY+32DKy048XmV8Ypmh6aYa0MRPzRg2eLvF3vH0HddgxCpLKzaXpIsOlk3ZvWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p+16Q9AMAE3/mNvcCPk9TMzJnQemzJSNSKsVDYrIAc=;
 b=xPPL69+gELeb/0pKneiFNmqMbQ78U7a/CcFQEdBhQUm+xs+/3tE+wTAcghhbPIcj92nj/e/R+bn/gdvGXYXcoUfBCd3F3iX+CyBGM9L1FYr506ffxcDqqDHlo+sdPqjrFka4281NZl9k43oNq7/Mayj3v9hmmnhWGapEszigNQo=
Received: from BYAPR06CA0039.namprd06.prod.outlook.com (2603:10b6:a03:14b::16)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:49:34 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::7c) by BYAPR06CA0039.outlook.office365.com
 (2603:10b6:a03:14b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.19 via Frontend Transport; Wed,
 8 Oct 2025 18:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:50 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:50 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:50 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 15/22] drm/amd/display: Move all DCCG RCG into HWSS
 root_clock_control
Date: Wed, 8 Oct 2025 14:47:09 -0400
Message-ID: <20251008184839.78916-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b0e39c-4f98-405c-ae18-08de069b6bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1WEL3gy0KVstaFR3QpHbh/HaAni8BIwjnZT5UQrExADYSyC6dVYSFDT08AN9?=
 =?us-ascii?Q?hk8doe1blY2Bz43jI3fn+vlI09DlzIRtHqLWoh/isZ1rY1yfOmzvlos0Xy76?=
 =?us-ascii?Q?UNRtrIvvCpar09NnVc/INUIFbdAYCBnqK/fUjzvXEvG8Me8y1ER3xQ2IfRYI?=
 =?us-ascii?Q?cna0OS3oLolXZvHKj34qMQldrui4kiyyo6AQxyRPjoWp0DgYo473DwTHrsgw?=
 =?us-ascii?Q?3fNvjTAHX316vXa3+FCW13754DaI+Q8nRxfhg7t5fG0C+Og48iCk4Rc3SSOT?=
 =?us-ascii?Q?A0HaUJrCC2nDZYTXbXQBvA3QSd4R7Y7xSlcvnMR3WG04bGzODRXdEOiXMzvP?=
 =?us-ascii?Q?kq5ytv++rVFNN5r4MlYRuSWDMKOCjkKm911vKpxNv3A3hi3BLK0HSfXlRySE?=
 =?us-ascii?Q?9qL2VEnEGNBzR5pPogSzC5xsPvkyi13OT7y98wlyMetjsB4znBlm2QPhXKHV?=
 =?us-ascii?Q?SiJ8UzJ6H5UKIxmph1SZIj3eFh48/OIeEY65KfjB1CHDdU2sUklCE+USQFMh?=
 =?us-ascii?Q?wNLpqTnrFkANDe4PIG4ZvhMZ1GNY5bfBbHKL4fBWnT346+pM0ChKROmNucfb?=
 =?us-ascii?Q?0rPQZHd84d7HADy7X+iOQwfythIgnB/20El1VgpXUK5yDdDdBDNoBywuraE+?=
 =?us-ascii?Q?hCkCtZDCFu2gWxrvRjpLiDrCAULITvQ25nMPTZEku8RwFcd32V9yO7lWs3oB?=
 =?us-ascii?Q?Meb5vft+13FXieFgb9B2f0URf52H5nK3laCXfjSex3Z6bk4YyR8NXVjVwUXM?=
 =?us-ascii?Q?VyoC75HcyMS9iVvfRfbmoGxIUVXNpGbvsUqHoQ6hmp8z2qqCM8phrkpqHzhe?=
 =?us-ascii?Q?gAcF7hDmqXvBydxnzEwAaRR4ymH0inyixcDnnjGszhJRjcdASfgOP6VDOW3/?=
 =?us-ascii?Q?t6lkPjGVr6kDjKlkHDgvbE6Qfe2x4nCeay06FO+3oZS4hq9RHsx5x9czioXt?=
 =?us-ascii?Q?tvBg6J4nC6woWwHRur0imwe/gEFEkk5twkiW0kNAn2K4kWItqagmzc9IERnS?=
 =?us-ascii?Q?HW/XG04iy0wjHYIkq+NbaZ1J90QalzWqw+YrfKGcj4gXedFhIPKpupcZtlfv?=
 =?us-ascii?Q?xryXU8rSKxotLOUf2hHTSLUjOOfxNZyvOeAPWwAkC9CAgKzehigpfKrbtT/8?=
 =?us-ascii?Q?LePoclnqxRNNgN8E/DAWKzE2XzPigxWF+JCen41IE6quTHydCSyRJuP9V605?=
 =?us-ascii?Q?XEl3oGIxy/VQzGVAobs02fQegtwA64k3HFjqdoNR1tbZiA1nGCYbdatae7D+?=
 =?us-ascii?Q?XeB0PuXCtuc3FSH+hZIXGa7BjH4MdvJoRB/pmUfzFsIsvmYpaa3eJd9Fshqm?=
 =?us-ascii?Q?gnDTHWLryE+wNYrWVbMQXZod2Ni3wRNbIlPBswkXLKI0x0pWjSHG7WmMrU+a?=
 =?us-ascii?Q?LaC81J9dQ2hCO6QUivKgbE2LdkMk22+f30/uKEhmBBQ9MIp+EohW+REqpHqm?=
 =?us-ascii?Q?vg2ZZn1ZOytxUSxd+y3WVZlDaRMyMgzNDvEW9jLFezPdcAFPQwdmwYRMKEbD?=
 =?us-ascii?Q?zpf0X/9dxMjT181PvTJxFJF+5UfO3i+B+k3khy2x/s3AtgLfFj76WH4wuZsH?=
 =?us-ascii?Q?HJUYT6WexrNlkpL8msg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:33.3390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b0e39c-4f98-405c-ae18-08de069b6bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
Enabling/disabling DCCG RCG should be done as a last-level step when
enabling/disable blocks. This is handled by HWSS root_clock_control
already during optimize_bandwidth.
However, dccg35_dpp_root_clock_control was missing the RCG enable
call on the disable path.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c  | 5 ++---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 5 -----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 856615e7648b..0aa41759f79d 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1184,8 +1184,7 @@ static void dccg35_update_dpp_dto(struct dccg *dccg, int dpp_inst,
 		dcn35_set_dppclk_enable(dccg, dpp_inst, true);
 	} else {
 		dcn35_set_dppclk_enable(dccg, dpp_inst, false);
-		/*we have this in hwss: disable_plane*/
-		//dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
+		dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
 	}
 	udelay(10);
 	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
@@ -1695,7 +1694,7 @@ static void dccg35_dpp_root_clock_control(
 			  DPPCLK0_DTO_PHASE, 0,
 			  DPPCLK0_DTO_MODULO, 1);
 		/*we have this in hwss: disable_plane*/
-		//dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
+		dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
 	}
 
 	// wait for clock to fully ramp
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 404ff00c7130..9333b7fde3bc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -817,8 +817,6 @@ void dcn35_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			       struct dc_state *context)
 {
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
-	struct dccg *dccg = dc->res_pool->dccg;
-
 
 	/* enable DCFCLK current DCHUB */
 	pipe_ctx->plane_res.hubp->funcs->hubp_clk_cntl(pipe_ctx->plane_res.hubp, true);
@@ -826,7 +824,6 @@ void dcn35_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	/* initialize HUBP on power up */
 	pipe_ctx->plane_res.hubp->funcs->hubp_init(pipe_ctx->plane_res.hubp);
 	/*make sure DPPCLK is on*/
-	dccg->funcs->dccg_root_gate_disable_control(dccg, dpp->inst, true);
 	dpp->funcs->dpp_dppclk_control(dpp, false, true);
 	/* make sure OPP_PIPE_CLOCK_EN = 1 */
 	pipe_ctx->stream_res.opp->funcs->opp_pipe_clock_control(
@@ -860,7 +857,6 @@ void dcn35_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
-	struct dccg *dccg = dc->res_pool->dccg;
 
 
 	dc->hwss.wait_for_mpcc_disconnect(dc, dc->res_pool, pipe_ctx);
@@ -879,7 +875,6 @@ void dcn35_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	hubp->funcs->hubp_clk_cntl(hubp, false);
 
 	dpp->funcs->dpp_dppclk_control(dpp, false, false);
-	dccg->funcs->dccg_root_gate_disable_control(dccg, dpp->inst, false);
 
 	hubp->power_gated = true;
 
-- 
2.51.0

