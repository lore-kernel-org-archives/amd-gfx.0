Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015C1FED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8997210E654;
	Wed, 18 Mar 2026 01:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cip/I3W4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4081B10E654
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6ZlHArwfjH8dUqfECwoT83uwUfymP4NPqjBKVsqoIqB9KgWaAUVnFYh5fQ5vCGFl5dff1YkhrGMqbQG8ljeLciN3ge5b9qPUF29C9zrBHwj17O3yKVlfnroyx8lLMZ4jmPa3egg1dDstwBpoSd1Ck8lbXUNUKwTqGORN1eBp75okV208wd2lXhbWv1escz8+REP0iofiVBymXRD2NUjfS+HcSBQ9FNikNxI2snMwEfDJJsChvjmuOW0tuk58t/eOM+bpHVr5Cw8n8WFhk+z59N8fh7pwkTJDcCDqZbd+ZgPWsI8FStAOeQaXrdnjHopJMocuhfh123q69EMdKeOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KHa+sgoygCfvD+BzPbrRSdomxLw97S/d9AA1FWlh54=;
 b=sd4cQRxk9eGtvsO3aZ5C5CVit54sy44wu/hK/P/la9dVg++tG1vV9nkCjmxqdmU1zE+fCU4uJb/pj4YiGV0Qt/UmsNqVcephAIBbPIIgfSCZSFNVi3iZUcSNVUJ8ifdia7qSpkg6Wsw/Tnw9AveiEeccRF16LCnA0NBjJFpXP4+k28jhcC8WBUrrAN3aJMGKjHR2FO2QRH7PTjGOLp8nLhu/z3PgUPc5wN/vq4Ez37sGPO5k0PlzInbCsXQpaqRLctlteexiYm7F6Y7k5Bvir+CmaaXFAPNod68varQTSE2gayV7oJS1Er3++4ZrAYs5/+V9TQtxNr+iexLKqZdtMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KHa+sgoygCfvD+BzPbrRSdomxLw97S/d9AA1FWlh54=;
 b=Cip/I3W4rf7LVJ6IzR5zgpvaLuHj3Inw2y88jE93TBxMzgaNG2wRSMd8Q37+3hysgwfrEOeRwfa3pzh/gQbqUOfueJmddVCXvnZBJB5GZxcYl1Hr7w78MXST6xbOIKr8dMxMrV5ICfpOxAjLEyt9D3CscRVJpX60owD5URO1duM=
Received: from SN6PR2101CA0012.namprd21.prod.outlook.com
 (2603:10b6:805:106::22) by DSVPR12MB999149.namprd12.prod.outlook.com
 (2603:10b6:8:383::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:17 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::a7) by SN6PR2101CA0012.outlook.office365.com
 (2603:10b6:805:106::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.8 via Frontend Transport; Wed,
 18 Mar 2026 01:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:15 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:11 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 20/31] drm/amd/display: Add 3DLUT DMA broadcast support
Date: Wed, 18 Mar 2026 08:59:29 +0800
Message-ID: <20260318010224.513094-21-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DSVPR12MB999149:EE_
X-MS-Office365-Filtering-Correlation-Id: bbdef95f-6db1-49f5-3ab0-08de8489ff0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: vJOc2CtKm7pkI1xrUtBYYWm2Zs8BSB2pcatBx6JJJQgvEaW1Yp7A33Od54kr34y5hCY/Q00mIsAjKee0kaUypW/3ht1YDaR7H3NrffmBqXSJ5pUGctS68nIJSV1gHyK7Y+VzBw0p3qiN7jMaUq1BJ3Wo8joBS8/8EWLmaYX6scMsTDYPOE2xs1awf2FkJU3YlSjHkyR1V4JOMkDEhgWgY+p4XApdXYPHq0uSkb3nyOd9Z7gtbRj3vcKMnMDZJwsyYqv4BR+NRgKfhCqH66H96ou7AOLin7J+kWHyu40NYiUZPMQHPjs7N9cqZ8rRqlrz+0HFV+DXooRNcq3UEketY4D4BLLcwLgK8XjJPZaInqvf4vlMJTN42M4kBxPO9vnX+ttMLmmu0Ss73qYYsQToEnXHY3DhIzqPePdMf1M6Gy2MJ5xi+sW7iMBEDJKD5AKMuuUj1pqyYf6XTgUsAaPDiSK8zzwIdXoz8xa07B21+b1m8dwd4Q9ZBDtR3d7wUiBmnAQWeoconSPWOUc/HS9t6TSgTmS3pRMxDJq4btCedSRXHwUaju0k3t3t3TdGgCdeAuz5drTkZgAYR9JJT2p3rQklY49il8Vrvr4T91mzqY/d6DMw4NL1fUOR1W2SbFTtFc1Rt7V5N0cXyWjFpm9SAc8+kI28nOTIWG7acgD43BNiqVOCSHyEo2D+uAjsmElJU8f1yfNUKOg2pUahNe5NEhS0s2k7v3hkE5zEbubm/xA9WsHtypddPyTyc4UwabOQhLHzW68qatkWne3z7Ukwlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6D0AOpdfMmfYxU+IrNLb9fhSJTaf6Eq1mcD4nf+0Ok0dxnLpGHvtSGTko7MfzEpszqRo/gIXQuEnMjozUXRfkuuZ/ls4OB4GQ/3/OErPrEnYsUGLvSUelTvwdqQicT6o/Ci7BoPFsHYAC56bo76zLUD961uwKxD4ja7nmAzKQXHHCUoyHMZeCJj7mbnprkTIuuLkWssAu0rBiOTE0CSW8G/3HfudTdqRxCLnlpY48TxqG6lgSfnntdiPxhZDPlY+6hsMhIW/CQ058v114KRXOpMKlOWlJNdN8Sq7lVpkKjZQaPqAdyJh7mRydlzPO+LriBBrOwyY+aq0OF0LArGLIc3ogFlM2F7QvzrtkA9pFWMbDdq5U0MmHzDyC0vFT/n7Ww29qdD/4FLF1F2guU10j+iyNUjkQHz2gbHS3YPrB02R4HuL73sMpqXaisa8jAlC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:15.7124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdef95f-6db1-49f5-3ab0-08de8489ff0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999149
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
A single HUBP can be used to fetch 3DLUT and broadcast to a
single HUBP.  Add logic to select the top pipe for a given
plane and use it's HUBP as the broadcast source for multiple
MPC's.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 108 +++++++++++-------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 4 files changed, 67 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 414c9a0e8922..db74f088705a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4618,7 +4618,7 @@ static void commit_planes_for_stream(struct dc *dc,
 						srf_updates[i].cm->flags.bits.lut3d_enable &&
 						srf_updates[i].cm->flags.bits.lut3d_dma_enable &&
 						dc->hwss.trigger_3dlut_dma_load)
-					dc->hwss.trigger_3dlut_dma_load(dc, pipe_ctx);
+					dc->hwss.trigger_3dlut_dma_load(pipe_ctx);
 
 				/*program triple buffer after lock based on flip type*/
 				if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 357899116ecd..a72284c3fa1c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -369,12 +369,14 @@ void dcn401_init_hw(struct dc *dc)
 	}
 }
 
-void dcn401_trigger_3dlut_dma_load(struct dc *dc, struct pipe_ctx *pipe_ctx)
+void dcn401_trigger_3dlut_dma_load(struct pipe_ctx *pipe_ctx)
 {
-	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+	const struct pipe_ctx *primary_dpp_pipe_ctx = resource_get_primary_dpp_pipe(pipe_ctx);
+	struct hubp *primary_hubp = primary_dpp_pipe_ctx ?
+			primary_dpp_pipe_ctx->plane_res.hubp : NULL;
 
-	if (hubp->funcs->hubp_enable_3dlut_fl) {
-		hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
+	if (primary_hubp && primary_hubp->funcs->hubp_enable_3dlut_fl) {
+		primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
 	}
 }
 
@@ -382,8 +384,11 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 				const struct dc_plane_state *plane_state)
 {
 	struct dc *dc = pipe_ctx->plane_res.hubp->ctx->dc;
+	const struct pipe_ctx *primary_dpp_pipe_ctx = resource_get_primary_dpp_pipe(pipe_ctx);
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+	struct hubp *primary_hubp =	primary_dpp_pipe_ctx ?
+			primary_dpp_pipe_ctx->plane_res.hubp : NULL;
 	const struct dc_plane_cm *cm = &plane_state->cm;
 	int mpcc_id = hubp->inst;
 	struct mpc *mpc = dc->res_pool->mpc;
@@ -481,25 +486,41 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 			mpc->funcs->program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, 12, mpcc_id);
 
 		if (mpc->funcs->update_3dlut_fast_load_select)
-			mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, hubp->inst);
+			mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, primary_hubp->inst);
 
 		/* HUBP */
-		if (hubp->funcs->hubp_program_3dlut_fl_config)
-			hubp->funcs->hubp_program_3dlut_fl_config(hubp, &cm->lut3d_dma);
+		if (primary_hubp->inst == hubp->inst) {
+			/* only program if this is the primary dpp pipe for the given plane */
+			if (hubp->funcs->hubp_program_3dlut_fl_config)
+				hubp->funcs->hubp_program_3dlut_fl_config(hubp, &cm->lut3d_dma);
 
-		if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
-			hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp, cm->lut3d_dma.format);
+			if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
+				hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp, cm->lut3d_dma.format);
 
-		if (hubp->funcs->hubp_program_3dlut_fl_addr)
-			hubp->funcs->hubp_program_3dlut_fl_addr(hubp, &cm->lut3d_dma.addr);
+			if (hubp->funcs->hubp_program_3dlut_fl_addr)
+				hubp->funcs->hubp_program_3dlut_fl_addr(hubp, &cm->lut3d_dma.addr);
 
-		if (hubp->funcs->hubp_enable_3dlut_fl) {
-			hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
+			if (hubp->funcs->hubp_enable_3dlut_fl) {
+				hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
+			} else {
+				/* GPU memory only supports fast load path */
+				BREAK_TO_DEBUGGER();
+				lut_enable = false;
+				result = false;
+			}
 		} else {
-			/* GPU memory only supports fast load path */
-			BREAK_TO_DEBUGGER();
-			lut_enable = false;
-			result = false;
+			/* re-trigger priamry HUBP to load 3DLUT */
+			if (primary_hubp->funcs->hubp_enable_3dlut_fl) {
+				primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
+			}
+
+			/* clear FL setup on this pipe's HUBP */
+			memset(&lut3d_dma, 0, sizeof(lut3d_dma));
+			if (hubp->funcs->hubp_program_3dlut_fl_config)
+				hubp->funcs->hubp_program_3dlut_fl_config(hubp, &lut3d_dma);
+
+			if (hubp->funcs->hubp_enable_3dlut_fl)
+				hubp->funcs->hubp_enable_3dlut_fl(hubp, false);
 		}
 	} else {
 		/* Legacy (Host) Load Mode */
@@ -1809,42 +1830,41 @@ void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx)
 	 * This is meant to work around a known HW issue where VREADY will cancel the pending 3DLUT_ENABLE signal regardless
 	 * of whether OTG lock is currently being held or not.
 	 */
-	struct pipe_ctx *wa_pipes[MAX_PIPES] = { NULL };
-	struct pipe_ctx *odm_pipe, *mpc_pipe;
-	int i, wa_pipe_ct = 0;
-
-	for (odm_pipe = pipe_ctx; odm_pipe != NULL; odm_pipe = odm_pipe->next_odm_pipe) {
-		for (mpc_pipe = odm_pipe; mpc_pipe != NULL; mpc_pipe = mpc_pipe->bottom_pipe) {
-			if (mpc_pipe->plane_state &&
-					mpc_pipe->plane_state->cm.flags.bits.lut3d_enable &&
-					mpc_pipe->plane_state->cm.flags.bits.lut3d_dma_enable) {
-				wa_pipes[wa_pipe_ct++] = mpc_pipe;
-			}
-		}
+	const struct pipe_ctx *otg_master_pipe_ctx = resource_get_otg_master(pipe_ctx);
+	struct timing_generator *tg = otg_master_pipe_ctx ?
+			otg_master_pipe_ctx->stream_res.tg : NULL;
+	const struct pipe_ctx *primary_dpp_pipe_ctx = resource_is_pipe_type(pipe_ctx, DPP_PIPE) ?
+			resource_get_primary_dpp_pipe(pipe_ctx) : pipe_ctx;
+	struct hubp *primary_hubp = primary_dpp_pipe_ctx ?
+			primary_dpp_pipe_ctx->plane_res.hubp : NULL;
+
+	if (!otg_master_pipe_ctx && !tg) {
+		return;
 	}
 
-	if (wa_pipe_ct > 0) {
-		if (pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout)
-			pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout(pipe_ctx->stream_res.tg, true);
+	if (primary_dpp_pipe_ctx &&
+			primary_dpp_pipe_ctx->plane_state &&
+			primary_dpp_pipe_ctx->plane_state->cm.flags.bits.lut3d_enable &&
+			primary_dpp_pipe_ctx->plane_state->cm.flags.bits.lut3d_dma_enable) {
+		if (tg->funcs->set_vupdate_keepout)
+			tg->funcs->set_vupdate_keepout(tg, true);
 
-		for (i = 0; i < wa_pipe_ct; ++i) {
-			if (wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl)
-				wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl(wa_pipes[i]->plane_res.hubp, true);
+		if (primary_hubp->funcs->hubp_enable_3dlut_fl) {
+			primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
 		}
 
-		pipe_ctx->stream_res.tg->funcs->unlock(pipe_ctx->stream_res.tg);
-		if (pipe_ctx->stream_res.tg->funcs->wait_update_lock_status)
-			pipe_ctx->stream_res.tg->funcs->wait_update_lock_status(pipe_ctx->stream_res.tg, false);
+		tg->funcs->unlock(tg);
+		if (tg->funcs->wait_update_lock_status)
+			tg->funcs->wait_update_lock_status(tg, false);
 
-		for (i = 0; i < wa_pipe_ct; ++i) {
-			if (wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl)
-				wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl(wa_pipes[i]->plane_res.hubp, true);
+		if (primary_hubp->funcs->hubp_enable_3dlut_fl) {
+			primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
 		}
 
-		if (pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout)
-			pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout(pipe_ctx->stream_res.tg, false);
+		if (tg->funcs->set_vupdate_keepout)
+			tg->funcs->set_vupdate_keepout(tg, false);
 	} else {
-		pipe_ctx->stream_res.tg->funcs->unlock(pipe_ctx->stream_res.tg);
+		tg->funcs->unlock(tg);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index f78162ab859b..b9a03ffa2717 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -41,8 +41,7 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 bool dcn401_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream);
-void dcn401_trigger_3dlut_dma_load(struct dc *dc,
-				struct pipe_ctx *pipe_ctx);
+void dcn401_trigger_3dlut_dma_load(struct pipe_ctx *pipe_ctx);
 void dcn401_calculate_dccg_tmds_div_value(struct pipe_ctx *pipe_ctx,
 				unsigned int *tmds_div);
 enum dc_status dcn401_enable_stream_timing(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index d1dba7ffcd9b..98abe0d2d30f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1120,7 +1120,7 @@ struct hw_sequencer_funcs {
 	void (*program_output_csc)(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			enum dc_color_space colorspace,
 			uint16_t *matrix, int opp_id);
-	void (*trigger_3dlut_dma_load)(struct dc *dc, struct pipe_ctx *pipe_ctx);
+	void (*trigger_3dlut_dma_load)(struct pipe_ctx *pipe_ctx);
 
 	/* VM Related */
 	int (*init_sys_ctx)(struct dce_hwseq *hws,
-- 
2.43.0

