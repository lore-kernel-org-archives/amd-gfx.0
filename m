Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11B0C021A7
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6012810ECCE;
	Fri, 14 Feb 2025 15:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QT4nw/Z4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429F010ECB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saGNHKaRYSVFBklOT1wv+HMjDXAPD47ife2OTAb/WTb1x6i30EckdP3wXziwo/C80TvHn1mcckih7PLmGitHfHvFWwoqUygYRb6K7RJ93tLcL1pA+JGeccibrcwpj2FWWn/SKNgi0p/XISy7k6YZmiPKX3wwK9llfoKvFwaUR03bbJ0Lanbb8Q+f4CKq9hSkv/KdzLeK07T1OHZpNySz+ZUPUWppjZrhcdYTnur2Qoex4msf3TEYGNIGjNV+K86urW4DoJVmrqhnFbO16gC5jLV3nYqFhnUSlYyUzuCcP6zksPf3csCcgi5Nh3UDu9sAd+v4BrKUyyD/nPzWlB7ulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKcIvC9IJTQlCyROg415EkRqcfgaNOQx/EKALDBYOOQ=;
 b=ml5trFF657prmZgpommTk6NrdpGE/znUNozD6iYGTffpx+vpqTFYnP0d+/NDmQy0njRm7ACbDeZ3MH/flrbwkW9GlZEOOa9Gdp2wiwPk9FShILc4vXo3QlYvY4jOh7KBXndwHqTAEYrkT7fLypvPgElrXJYfxqNao9F+U7sWXK/hmVTGWf+S0q5zVyJ0SJdD0AtJLft7AbmTeOmPaXk/9cqUKOhf2avvvxSOfSuGqdwvqH62ovjTg9J8XxtHQxloNerKHoR9Sh4CCzAIpQ/ScV+JO6G5B+ov3fqXGfbQlix6ByHaMOetrP/UZK4LOjjWvEd+WEUL+Xb15OvDnUge+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKcIvC9IJTQlCyROg415EkRqcfgaNOQx/EKALDBYOOQ=;
 b=QT4nw/Z4anifOm67F52qEZK1loCLZvxdz3c3eXktQLUZFDEFGPi7BYimKRaSos8vnmtaIiBc22rt9AuFxBqEGZbYMak8zQ/ZbZz12eTUXE/2zLOi+Sk4jIvnLT0LAI1mVieoceEh+rXbOV0b9r7IZzTN/KY/lNJom46L0z7CMjY=
Received: from SA1P222CA0178.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::26)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 14 Feb
 2025 15:01:35 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::6e) by SA1P222CA0178.outlook.office365.com
 (2603:10b6:806:3c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Fri,
 14 Feb 2025 15:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:33 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:33 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Rodrigo
 Siqueira" <Rodrigo.Siqueira@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 04/16] drm/amd/display: Add DCC/Tiling reset helper for DCN
 and DCE
Date: Fri, 14 Feb 2025 10:00:21 -0500
Message-ID: <20250214150033.767978-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6d6d11-0104-4199-9c0b-08dd4d0879bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+TFa261fz1AyKba7glL23P3inordw6hlqjOhWxr+S1bCDSw1BIhJ/nVkdYur?=
 =?us-ascii?Q?I5C1AwjCerC91Hc80qmiDyU/KAzWuVfY5rBMlsfLrZqCDZP3mhv2WgZbflAl?=
 =?us-ascii?Q?7hb3YX8Go0WE8rQqzTYvKJFHzMjU/TYxa9yFnzgMxrz+NidCzm+spmgEOxGT?=
 =?us-ascii?Q?2EMouixSsHb3lFTmH3DfNKtGEJuDoMYy23WHbpXhgWDx2kOW5FAO0TPFHwMd?=
 =?us-ascii?Q?GjJai9MRfCYdGFStGj285bGNkr9cNcEDwLQcZkYuvtY1GAjeiDdr4+96+mzM?=
 =?us-ascii?Q?XY/zqiwi/kzPNjTeESPZRti4QyGZOeBiRLAK1bzEuLp99Ywz+Arn6yhjnOcX?=
 =?us-ascii?Q?huBy3MW5/khQH549R3EltpSDJ7FAiIJ2AQpg8eejbG+rSG6W0VM71BB+Q7Bf?=
 =?us-ascii?Q?SSOosWhhLWBcYNXyLO0wmirv7ix0xzxt5othpUC7yri+s0dEcpT8E2MJmrhS?=
 =?us-ascii?Q?JCM1VkAk4svFLXzcXtt6ZfAXgndo/9E1ivfTdJsJvJ1otge1zWXG+LhRUIHJ?=
 =?us-ascii?Q?baM++8GsbPty1CuX2u6ePwOL9NG3joIP0PSdl2gEgU+ozHuvT9egSLTYrR46?=
 =?us-ascii?Q?xW/vy/bVUyd8qUxhx9etnljoMgZiCWc96Lqkqlj6MFQcxHG6YRhCvOhOiMwT?=
 =?us-ascii?Q?ezFQAXF6lUiBUHsGaHIX0h+n6OZxROpWhtstY+YYDqfzR1CiXOsGOGWQxoff?=
 =?us-ascii?Q?F87VvpCAfyemvAhu2ziBACDVR7pCNdlfV32bEb0kzOIF8qihsXW9JKu/79Lk?=
 =?us-ascii?Q?HVpA2PxA1KuiPkt3cnf74+EJXAKbPfw9CubcCIhgxw4NX7zxLacVl+8dbPZy?=
 =?us-ascii?Q?fTTo23BUde71XUH+0QcZrzHs95QsEU2UF7qOKMc+numYoWIX1jpMDjf5Cv6F?=
 =?us-ascii?Q?Ku+BIq5R8CqtNgVX/enV1PURfPerCtuSU4HtbjXO+NbB2dX6t/1Tai4MGee9?=
 =?us-ascii?Q?rbrN3XXxzgQCt+l9/808uSfWTYBqmsFY+FG7bdS4Dez4GrTDT7KqhvQRaZhF?=
 =?us-ascii?Q?fmT2P9sdr1fcE3pVVdS7LiZ2zRsOZdk6O1kRMwcowPWpfnXlMwVw/sjZw7oY?=
 =?us-ascii?Q?eJes23geP7yz+dfi5HPCh/SkUulOSteluMuU55F40FBwhJBUZDig2dt0vLR4?=
 =?us-ascii?Q?0sICArnWmoou9TAhnEsVMBGeaTHTaN/3AWhFIVxhGZnR5JioAMocInvvNC3/?=
 =?us-ascii?Q?G8ktn/FLwwAHJnpeL2Un+VgW9jIUJjolYJ29xXpTO09S5QIb7DQH3GauUnXm?=
 =?us-ascii?Q?Vb+KpjxPmv233Ih8bck6xVNUB7FitRMPnv+xhoFmnM9ZKYENGc03Viryf3a6?=
 =?us-ascii?Q?qJEWxd2/ynmgs3dwjUMMqqNJ/2/meHovVGqOw34c4dTxG5AdAE7lYkWcPN6D?=
 =?us-ascii?Q?7PrX3PfRD5l2SnvL1xwHCW8RhYQhTpI41+GUC0LM1CnwtdQJYM9ICz/bbiO1?=
 =?us-ascii?Q?LE6m3xD4Qhs5HMXKfilxNvoynAqxVhF+IEJwzsQr2B4C7AGeL3B0k2wltoZs?=
 =?us-ascii?Q?ikpB2rNplzJ3Pbs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:35.3112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6d6d11-0104-4199-9c0b-08dd4d0879bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit introduces a function helper for resetting DCN/DCE DCC and
tiling. Those functions are generic for their respective DCN/DCE, so
they were added to the oldest version of each architecture.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/hwss/dce100/dce100_hwseq.c | 29 +++++++++++++++++++
 .../amd/display/dc/hwss/dce100/dce100_hwseq.h |  4 +++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 29 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  4 +++
 4 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c
index f1f14796a3da..b76350a9cf5f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c
@@ -140,3 +140,32 @@ void dce100_hw_sequencer_construct(struct dc *dc)
 	dc->hwss.optimize_bandwidth = dce100_optimize_bandwidth;
 }
 
+/**
+ * dce100_reset_surface_dcc_and_tiling - Set DCC and tiling in DCE to their disable mode.
+ *
+ * @pipe_ctx: Pointer to the pipe context structure.
+ * @plane_state: Surface state
+ * @clear_tiling: If true set tiling to Linear, otherwise does not change tiling
+ *
+ * This function is responsible for call the HUBP block to disable DCC and set
+ * tiling to the linear mode.
+ */
+void dce100_reset_surface_dcc_and_tiling(struct pipe_ctx *pipe_ctx,
+					struct dc_plane_state *plane_state,
+					bool clear_tiling)
+{
+	struct mem_input *mi = pipe_ctx->plane_res.mi;
+
+	if (!mi)
+		return;
+
+	/* if framebuffer is tiled, disable tiling */
+	if (clear_tiling && mi->funcs->mem_input_clear_tiling)
+		mi->funcs->mem_input_clear_tiling(mi);
+
+	/* force page flip to see the new content of the framebuffer */
+	mi->funcs->mem_input_program_surface_flip_and_addr(mi,
+							   &plane_state->address,
+							   true);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.h
index 34518da20009..fadfa794f96b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.h
@@ -46,5 +46,9 @@ bool dce100_enable_display_power_gating(struct dc *dc, uint8_t controller_id,
 					struct dc_bios *dcb,
 					enum pipe_gating_control power_gating);
 
+void dce100_reset_surface_dcc_and_tiling(struct pipe_ctx *pipe_ctx,
+					struct dc_plane_state *plane_state,
+					bool clear_tiling);
+
 #endif /* __DC_HWSS_DCE100_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 35c0d101d7c8..301ef36d3d05 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3920,3 +3920,32 @@ void dcn10_get_dcc_en_bits(struct dc *dc, int *dcc_en_bits)
 			dcc_en_bits[i] = s->dcc_en ? 1 : 0;
 	}
 }
+
+/**
+ * dcn10_reset_surface_dcc_and_tiling - Set DCC and tiling in DCN to their disable mode.
+ *
+ * @pipe_ctx: Pointer to the pipe context structure.
+ * @plane_state: Surface state
+ * @clear_tiling: If true set tiling to Linear, otherwise does not change tiling
+ *
+ * This function is responsible for call the HUBP block to disable DCC and set
+ * tiling to the linear mode.
+ */
+void dcn10_reset_surface_dcc_and_tiling(struct pipe_ctx *pipe_ctx,
+					struct dc_plane_state *plane_state,
+					bool clear_tiling)
+{
+	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+
+	if (!hubp)
+		return;
+
+	/* if framebuffer is tiled, disable tiling */
+	if (clear_tiling && hubp->funcs->hubp_clear_tiling)
+		hubp->funcs->hubp_clear_tiling(hubp);
+
+	/* force page flip to see the new content of the framebuffer */
+	hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
+							&plane_state->address,
+							true);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index bc5dd68a2408..42ffd1e1299c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -207,4 +207,8 @@ void dcn10_update_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		int mpcc_id);
 
+void dcn10_reset_surface_dcc_and_tiling(struct pipe_ctx *pipe_ctx,
+					struct dc_plane_state *plane_state,
+					bool clear_tiling);
+
 #endif /* __DC_HWSS_DCN10_H__ */
-- 
2.34.1

