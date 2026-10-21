Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A9606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rMQJWTaw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B23E10F954;
	Wed, 21 Oct 2026 06:26:58 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20CA10F952
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWkNls92y0N7KMVP2FmH0/HHZ7AslulVW7tFA2M9VVxT8vmHzcw2D2wKHI7uHSjKfToLmgZUbA4+C4umcQ1k+KevoNd9fAN95K6DsHYMFYf1HyiOMYn9B2bzqHbvBiPKEgWNnQn7qorTmGgbNxlkTFzDytVujERoxnaVDKto/WTSd7QSWuWk4F3Cy/EIetbOe9RyOPBfbFC3WSZn0pMF0zFf+7Z7qusuGX4mAQPjFZ3D7O0Zysbz4v3ez1Z+hG3SOaD1K1ZK2/qF1sbclUQldnIye9RFMMUwXIIsKmadCmhWqBPZJn+nPYblWJCSvrHhCS8PD09424MkulpjEK44Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2VuSEtnhp/P8HIH1/yUUfog555tHzOv6FT4rMoHlt8=;
 b=XAWeF45Q6CIV3FIHvJOSPjv8X/HJD7fbuJX2AmxAV2P5+QsGAP6m0Mn/ptRLbeE+0lD+gWuW1a1/kdbIndRl3F4ffKQuDsSTU0vCGrWk/XbPZvkpPgXNkTupGrHP8hOCkDKNsFSgu/cYnGxeoEdFP2NznAHp5kAQ2FGlhb+EJLSNj6FXHgxesn2wVap4GuGVBnRNkvYwBud3C3/F/2IYWHsotqxqr75iWu1KtBeCvvqgYXR9/+9XzxKEDX+DbV/Seo8PeCudirYoXk7VJSO0RF7KrzVXCOmK6gVfkcT3DFzkxkzRHLHV0WA9W+W+jAbnHh+SXqt6hQzLOvw6zBkMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2VuSEtnhp/P8HIH1/yUUfog555tHzOv6FT4rMoHlt8=;
 b=rMQJWTawFKO8/ZuVtgigCba/eAJ8K0Zph254+0NauCKFCEkS7NrB6XXy42/DQa5AOyybGdhd43adZkTFjSltYLp0Loz0aQcXnyFMgLbhUHNfU8cBYGA3QOrEYvbYoExQPqIwWyzLUoD+IFQT1U7WHvs3ELzlgX2Z2AYZhYzko+c=
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:26:47 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::79) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:26:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:46 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:43 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 23/49] drm/amd/display: Split dcn401 init register writes into
 hwseq funcs
Date: Wed, 21 Oct 2026 14:22:29 +0800
Message-ID: <20261021062519.674697-24-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 799c02d1-b3bc-469d-6d80-08df2f3c48e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|6133799003|22082099003|18002099003|3023799007|11063799006|5023799004|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Vsj6v/UPfZ3ETeZi0jZfaj7u+K9awBP36xm8W5oCXhwiO+ix0KkFLw+/neX71m6Sdsygt8DSGPR1dDsgT1wlfiyxGwftE7OzQ0uAmn8FeBnw0Fw5J36+ylJFUv4fKl2PvSpO9gdKDVvS37SwjbGi6RUgq1pmyxQpZu8WQHLZ7mrQ/3EGmGXRCHZ+9m+GWPa6C8sTQISlNQKl6ViEhwW/OXtxLXtUPDKLB07kTDSukqGylTrTq5ywCOD+KB3yTYNFw9uwihRfBiTAFKARZwcAwWTTo1UP0nl7b96zP1dovI9OwwqU0VVx1VDkYSVPFaDxrnbcLQNy6YCHLUoXowhaHT4NBSncV9FxVQ9BODBdhGT4kuKBeNwe5MzeN+n6Yfz8u6EUYYUB3WzBE5vbql6Ju3Qacwi7fbCx3nHE6GKDeTcbAW0JpgOZSAGkWTJ8vtRQ4y5vWoow8s/gUB+U+I9A5LFMbGRW1wDo68p5il23g4He6RqcftsW/x1fSebFG9nrJJuYEXPz4ioXVyn2skUyqrOjwLxcXCfziroPO7dSpLoe9xyWEGQVuHnlBgjw7uIi3piIYZFTTMUixT0B3JsuFPk4sJ7C6n7fJTFaS4aglqiHhyC9CIuJlZHdESvxEJXft1zeefotWrxKpb46Gb290168zNltjQHStUIz/irFWedXtv/tAaIjbKPtMsANLQc4dIsvoJxUg7qnEMNql7bFnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(5023799004)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UeJXc7BasokC4URbxUZbuzu8eAx5vXEuddd7TivG6zffFrBbY/1Vnc/rxlx8qZqWuWPZAFuJMT2pwZVgEl9hhOUGnbklc6QankOA0WsCyMvjtwfFU6xfbE5L6bwXyKfSnos4u/GF3tO16/afjBy7mf30ALthB++LhfBnpKHENuLSNCAtLx0HLL/PFeZNOJRi9DHI8iYxG3SIK1k8vhdKYl0lmuJy19EpL+p2qUPifDg1s1Yrz5FDiACLuidkHtLoQcLqykwY7VIvT9fPCGtWFpEaIM5fKN+gseqK8W74q8wGwSDSHHUzWzscPlx0yUgHaGrNEpTSAoemWb2rlmCC5DjlFzwNoVsrcp/tKjboJBmrwiu8ZU/G1IfutgMu4t7Pd4fpTArGyo6bLg4zVKRpZayOk+x0OMvU6cQAnRyO615S8FMDnGtFrx4BNdRfyuqU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:47.6749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 799c02d1-b3bc-469d-6d80-08df2f3c48e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183
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

From: Tony Cheng <tony.cheng@amd.com>

[Why]
DC2_DC1_Wrapped replays dcn401_init_hw as BLS entries, and the
Executor may only call component functions, not program registers.
dcn401_init_hw writes ODM_MEM_PWR_CTRL3, MMHUBBUB_MEM_PWR_CNTL and
DCFCLK_CNTL inline, so the Executor has nothing to call for them.

[How]
Move each inline write into a dcn401 hwseq function with the same
REG_* call, and call it from dcn401_init_hw:
- dcn401_init_odm_mem_power
- dcn401_power_down_vga_mem
- dcn401_dcfclk_gating_control (GATE_DIS = !enable)

Expose them, plus init_hpo_hw_control for the HPO_IO_EN write, as
hwseq_private_funcs. init_hpo_hw_control is separate from
setup_hpo_hw_control because setup also runs on every commit.

No functional change: the register writes, values and order in
dcn401_init_hw are the same.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 30 +++++++++++++------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  3 ++
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  4 +++
 .../display/dc/hwss/hw_sequencer_private.h    |  8 +++++
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f2391d45d4c5..e1f391dbf15c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -169,15 +169,11 @@ void dcn401_init_hw(struct dc *dc)
 	//}
 
 	// Set default OPTC memory power states
-	if (dc->debug.enable_mem_low_power.bits.optc) {
-		// Shutdown when unassigned and light sleep in VBLANK
-		REG_SET_2(ODM_MEM_PWR_CTRL3, 0, ODM_MEM_UNASSIGNED_PWR_MODE, 3, ODM_MEM_VBLANK_PWR_MODE, 1);
-	}
+	if (dc->debug.enable_mem_low_power.bits.optc)
+		dcn401_init_odm_mem_power(hws);
 
-	if (dc->debug.enable_mem_low_power.bits.vga) {
-		// Power down VGA memory
-		REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
-	}
+	if (dc->debug.enable_mem_low_power.bits.vga)
+		dcn401_power_down_vga_mem(hws);
 
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
@@ -367,7 +363,7 @@ void dcn401_init_hw(struct dc *dc)
 		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
 			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
-		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
+		dcn401_dcfclk_gating_control(hws, true);
 	}
 
 	dcn401_setup_hpo_hw_control(hws, true);
@@ -981,6 +977,22 @@ void dcn401_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable)
 	REG_UPDATE(HPO_TOP_HW_CONTROL, HPO_IO_EN, enable);
 }
 
+void dcn401_init_odm_mem_power(struct dce_hwseq *hws)
+{
+	// Shutdown when unassigned and light sleep in VBLANK
+	REG_SET_2(ODM_MEM_PWR_CTRL3, 0, ODM_MEM_UNASSIGNED_PWR_MODE, 3, ODM_MEM_VBLANK_PWR_MODE, 1);
+}
+
+void dcn401_power_down_vga_mem(struct dce_hwseq *hws)
+{
+	REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
+}
+
+void dcn401_dcfclk_gating_control(struct dce_hwseq *hws, bool enable)
+{
+	REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, !enable);
+}
+
 void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct dc_cursor_position *pos_cpy)
 {
 	if (cursor_width <= 128) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 9df72e980e7a..d5853cd01a93 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -50,6 +50,9 @@ enum dc_status dcn401_enable_stream_timing(
 				struct dc *dc);
 void dcn401_enable_stream(struct pipe_ctx *pipe_ctx);
 void dcn401_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable);
+void dcn401_init_odm_mem_power(struct dce_hwseq *hws);
+void dcn401_power_down_vga_mem(struct dce_hwseq *hws);
+void dcn401_dcfclk_gating_control(struct dce_hwseq *hws, bool enable);
 
 void dcn401_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 1a387e52218d..dbeda44ebc8e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -150,6 +150,10 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.plane_atomic_power_down = dcn401_plane_atomic_power_down,
 	.plane_atomic_power_down_sequence = dcn401_plane_atomic_power_down_sequence,
 	.enable_power_gating_plane = dcn32_enable_power_gating_plane,
+	.init_hpo_hw_control = dcn401_setup_hpo_hw_control,
+	.init_odm_mem_power = dcn401_init_odm_mem_power,
+	.power_down_vga_mem = dcn401_power_down_vga_mem,
+	.dcfclk_gating_control = dcn401_dcfclk_gating_control,
 	.hubp_pg_control = dcn32_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.program_all_writeback_pipes_in_tree_sequence = dcn401_program_all_writeback_pipes_in_tree_sequence,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 9c5e9abf5a95..91a84fb50b59 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -203,6 +203,14 @@ struct hwseq_private_funcs {
 	void (*PLAT_58856_wa)(struct dc_state *context,
 			struct pipe_ctx *pipe_ctx);
 	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
+	/*
+	 * Init-time only. setup_hpo_hw_control also drives the HPO toggle
+	 * on every commit, so a DCN that leaves it unset keeps it unset.
+	 */
+	void (*init_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
+	void (*init_odm_mem_power)(struct dce_hwseq *hws);
+	void (*power_down_vga_mem)(struct dce_hwseq *hws);
+	void (*dcfclk_gating_control)(struct dce_hwseq *hws, bool enable);
 	void (*enable_plane)(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			       struct dc_state *context);
 	void (*program_mall_pipe_config)(struct dc *dc, struct dc_state *context);
-- 
2.43.0

