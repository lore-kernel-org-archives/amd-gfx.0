Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA12CAC59F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4235110E79E;
	Tue, 16 Sep 2025 19:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vUodZAxL";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07E8510E3DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHxOrpI+bxcVfwCNXMK83zWatFM6+PESVre7RKQJdwZT/4Jc9YU6CWIjcIeOVBnoOOk6cjV6sSd5c2wvHkOfJqVOaF9Rnjww6SCEIVB9wczdORk+girPRAlo+JKm5fad1nEGZcCUU0uIgaLwXFJtXW/Law747QFH6vlnG0BWUVVZ/VZBa7Hy3COOKd5MD2QM5xy+QR7x3bi72t97+wc8cctVVqDxoN6OgIBiQgsLpBq0uiqECwr3pxEv9cDJJQlP2K+Zk2k4qSUUdISTCvhFJTSPpiLxXTNLgc92XAcTn1e0QYg+zu88DZwbZ2VN1IfyZEcNQU4vLet/hmBN5zNUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNFc2fog4Og/NKZ7BSWdoP0wqMngVAnAlmTPaa8DarU=;
 b=rG/AghVdNX6fkCjNrqFyPVX2tDb8+sp6oYIVgxjXwlIx4xKVrjvZUkYJ8qnp6rOwrduiX3yr6argLP0gtTOxvVjc1vE2F7tIk6HXPgv3orqU8FeytXMsuS4ATToLuKa7hZiwDI5V61/GZQeZjKT6LwxRSSjXcBTzss1Gsb/k3f/fHFgf6pVSJrpiYww3qOHS8SGu0rZYIzpO3tpOcq6QL6yqZfFij+JDyo9DsOqyzKLctJTD7N0z3ApAGXeaD9BVr60uFoea13nepNFm0iq2wgeH46Bea9Vivs7YqLeKTZ0TWCzRCbMDmIgmjy86uuC8WefSjglEx57turPIwRYYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNFc2fog4Og/NKZ7BSWdoP0wqMngVAnAlmTPaa8DarU=;
 b=vUodZAxLc+cjFRIsVuKGvvV9U0M+1L+PHTNUfEhIayExgkRX5TPHcRkmoB46vGlBe50LvqkvgYHy65awqPGGOlztELl73eb2EWNOn7Ex9NibGf1kQi9/NU3wsVGyCby4CRkfIi/GjHPVC3rgHVPwvD7IPMxDKwv49YOurmbWDkc=
Received: from BN9PR03CA0121.namprd03.prod.outlook.com (2603:10b6:408:fe::6)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:24 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::8a) by BN9PR03CA0121.outlook.office365.com
 (2603:10b6:408:fe::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:15 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 14:12:15 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:14 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 14/20] drm/amd/display: Remove wm_optimized_required
Date: Tue, 16 Sep 2025 15:09:34 -0400
Message-ID: <20250916191142.3504643-15-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dc4be0-ebb3-434a-6932-08ddf554f7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qey71gJN/f7K0/lvuXXJL/jmil2tutwaoSW5NJvXdzNcSlu4gBvnYoOUMse2?=
 =?us-ascii?Q?i/s6z6NKsFJHdrKUuxHY5FI9drtGM46TCVuFiHZnGqnxBn+cHeNmbz+Hcwb8?=
 =?us-ascii?Q?OHtBRVNzW/kB66Js0GSMQplxdKi6PNhl9dcwsJiy2euQ/g4wFmz5Ekl3Jtua?=
 =?us-ascii?Q?0+VENz30cisyoW4X7vEJlmVyibRlv5RPCKAyEnx89s2hmU75nhP+vj5Eeft2?=
 =?us-ascii?Q?6BiWGOgbxeFoXBL5Lglf81FZKUbh5i1vOvFuS/z77mbMuzI9Upd2fqr+dLZ6?=
 =?us-ascii?Q?ystF5APjNpVcMBs1sC8l25ZUb3KNQFTJ3eLj0GBWTT5/nsVRRiVRBS0YrVIN?=
 =?us-ascii?Q?QIbkIXnKJz+suFgNZZL9a4l6M5H71FA8GuLvzocxNQcZW/amJIgvQ+/2sQmh?=
 =?us-ascii?Q?VmokHVfy5LXxbeH+3aRYhTNW7pzj5IA2GcUHn3eApBkDyiLRUlJZh/uraoAQ?=
 =?us-ascii?Q?EY5yk6+bt+czumj7ytTPlqZsstO+qXwvfh3xiiC7n51pINph0PSIjxour45s?=
 =?us-ascii?Q?fBKsvUddzhVHErcFP0AnqjPtLnyQId5X25l2P/3z7Ya+XNd6fH/jVK6/Sk3t?=
 =?us-ascii?Q?aG+LBnrsZNH69sKyzhwb4JfGErlXMMh5PYLlCYzN/XiB6t/VwNfv40HNYqpJ?=
 =?us-ascii?Q?U6LTEio4QmHHQf6bSgw4Zfp/FEpTscx+8u5DlEdDZLwAT67VV/vkvz7VTyvg?=
 =?us-ascii?Q?RcIJ2ekES0cF6qsSL3azXe20Trn9ROxGrQZ6WjC3OTeWoVfSm4h4n5UTY3XY?=
 =?us-ascii?Q?2nxr2CGuxNIu39XfQNRU9q6Ggd0LuXxwJheAbVTgwrpe+Mu9oBNpM/hkYjKu?=
 =?us-ascii?Q?Q/aZbbkVzTMNNw/gEGfWJqXk1beJ84G3lKrGtiYMa4r4Sfvt75zWeUwvVC5H?=
 =?us-ascii?Q?TMPQOocNkJ3/v+ArJuCx+/lIYrn6qZOWXrSQKaqXSg8fwYcBCV9EkAoe58aL?=
 =?us-ascii?Q?rnaUD3XU8jcLz5rwk9kWMAlnmHH8kRVnXIIDufQp6fUvQug1L3WL47vz/6Le?=
 =?us-ascii?Q?KC0P+T+VQ1OlAWFS4+UdUfEymNcle9g8Z+E85d2PycSyn9/+frp01hlTKtrB?=
 =?us-ascii?Q?+G5oYgapjzB9NKVEWJ5uagD3ScCyRk+oCU7/nuPY+QIJAKcwGeDGbTRU0NOy?=
 =?us-ascii?Q?OiLEw71gwySyjZZOGHBz7tVaL7/qAI/Igcnpe1T73OE5iLJfcNp4aUjMQ1P5?=
 =?us-ascii?Q?ze+iBuUC/HHpTcbaVl4iugiroVBNP3RqkfGYWaaItNVouwHzfcXgapVd4TTL?=
 =?us-ascii?Q?IK87rOeyojJ9DTwI9ds3X29YvSZryJUYaindYFPqG9yWSVR9MSqvaB/xzTFv?=
 =?us-ascii?Q?WNz+VCkHIV2KOspP5W9Tfd3Tb5Zu6SJ8UUa70tV6a8H+LpmeaYDirbQsPJCb?=
 =?us-ascii?Q?z0jxVEGujyVdnH+bt0g2BcwvbiX7otSjFeAtd6I/9MrtDUoJ85QKsHLf9gHQ?=
 =?us-ascii?Q?t7M8HaEEftjC6UjNbXnRc6NXdtQg4bdi+c4XGtWnT0IXpAuYxMha5U4q53EA?=
 =?us-ascii?Q?4ULPXHDdQVknFNZtUIlp33MHbflS45TLb3lS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:24.1094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dc4be0-ebb3-434a-6932-08ddf554f7e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
This is a redundant field that is identically to optimized_required, so
just replace it.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                  | 5 +----
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 8 ++++----
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 8 ++++----
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 974d63af1c70..5f2d5638c819 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -460,7 +460,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	 * avoid conflicting with firmware updates.
 	 */
 	if (dc->ctx->dce_version > DCE_VERSION_MAX) {
-		if ((dc->optimized_required || dc->wm_optimized_required) &&
+		if (dc->optimized_required &&
 			(stream->adjust.v_total_max != adjust->v_total_max ||
 			stream->adjust.v_total_min != adjust->v_total_min)) {
 			stream->adjust.timing_adjust_pending = true;
@@ -2577,7 +2577,6 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 	}
 
 	dc->optimized_required = false;
-	dc->wm_optimized_required = false;
 }
 
 bool dc_set_generic_gpio_for_stereo(bool enable,
@@ -3056,8 +3055,6 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 		} else if (memcmp(&dc->current_state->bw_ctx.bw.dcn.clk, &dc->clk_mgr->clks, offsetof(struct dc_clocks, prev_p_state_change_support)) != 0) {
 			dc->optimized_required = true;
 		}
-
-		dc->optimized_required |= dc->wm_optimized_required;
 	}
 
 	return type;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 19c74f56aa5e..3bcc7a22355b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1736,7 +1736,6 @@ struct dc {
 
 	/* Require to optimize clocks and bandwidth for added/removed planes */
 	bool optimized_required;
-	bool wm_optimized_required;
 	bool idle_optimizations_allowed;
 	bool enable_c20_dtm_b0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 74f5e05f9cb4..e9fe97f0c4ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3347,7 +3347,7 @@ void dcn10_prepare_bandwidth(
 			context,
 			false);
 
-	dc->wm_optimized_required = hubbub->funcs->program_watermarks(hubbub,
+	dc->optimized_required = hubbub->funcs->program_watermarks(hubbub,
 			&context->bw_ctx.bw.dcn.watermarks,
 			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 			true);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 95af58cbb92a..717d2c4daa88 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2390,10 +2390,10 @@ void dcn20_prepare_bandwidth(
 	}
 
 	/* program dchubbub watermarks:
-	 * For assigning wm_optimized_required, use |= operator since we don't want
+	 * For assigning optimized_required, use |= operator since we don't want
 	 * to clear the value if the optimize has not happened yet
 	 */
-	dc->wm_optimized_required |= hubbub->funcs->program_watermarks(hubbub,
+	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					false);
@@ -2406,10 +2406,10 @@ void dcn20_prepare_bandwidth(
 	if (hubbub->funcs->program_compbuf_size) {
 		if (context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes) {
 			compbuf_size_kb = context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes;
-			dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.dml.ip.min_comp_buffer_size_kbytes);
+			dc->optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.dml.ip.min_comp_buffer_size_kbytes);
 		} else {
 			compbuf_size_kb = context->bw_ctx.bw.dcn.compbuf_size_kb;
-			dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.bw.dcn.compbuf_size_kb);
+			dc->optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.bw.dcn.compbuf_size_kb);
 		}
 
 		hubbub->funcs->program_compbuf_size(hubbub, compbuf_size_kb, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 1b0b772fc5dd..625653ce5556 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1383,22 +1383,22 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 			false);
 
 	/* program dchubbub watermarks:
-	 * For assigning wm_optimized_required, use |= operator since we don't want
+	 * For assigning optimized_required, use |= operator since we don't want
 	 * to clear the value if the optimize has not happened yet
 	 */
-	dc->wm_optimized_required |= hubbub->funcs->program_watermarks(hubbub,
+	dc->optimized_required |= hubbub->funcs->program_watermarks(hubbub,
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					false);
 	/* update timeout thresholds */
 	if (hubbub->funcs->program_arbiter) {
-		dc->wm_optimized_required |= hubbub->funcs->program_arbiter(hubbub, &context->bw_ctx.bw.dcn.arb_regs, false);
+		dc->optimized_required |= hubbub->funcs->program_arbiter(hubbub, &context->bw_ctx.bw.dcn.arb_regs, false);
 	}
 
 	/* decrease compbuf size */
 	if (hubbub->funcs->program_compbuf_segments) {
 		compbuf_size = context->bw_ctx.bw.dcn.arb_regs.compbuf_size;
-		dc->wm_optimized_required |= (compbuf_size != dc->current_state->bw_ctx.bw.dcn.arb_regs.compbuf_size);
+		dc->optimized_required |= (compbuf_size != dc->current_state->bw_ctx.bw.dcn.arb_regs.compbuf_size);
 
 		hubbub->funcs->program_compbuf_segments(hubbub, compbuf_size, false);
 	}
-- 
2.43.0

