Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF3C109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B8A10E93E;
	Thu, 26 Mar 2026 03:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nBupn0lE";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CA510E93E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqNTHhvttOr9hQM74e51DIEL/NW8HLCt7tSzMIZxdGkm3A1j2RzFQDdXnpSxT7OgGnUDB0NYGwJNQ9YAL08QgAe/Ii/cR5GRrt7oTlcmT15EIRVhcrGCUQrf79crLac2kUYOpYj8ucCSPzPCWXIg0cj9ykLbiUQgE+Av2pyAe0dyTABrGzNVvlPd4e4dJ0LRxoM+PdzdoGKC49hOxazweBe+1ud0AXJtkkBFcllnbb8Ye8+7qVaW280sOUqy1Boux0xK8Ff0WzyjoVLVoTVfhhlVPTMxtO3EulfapToNers9Q1WJZvYarxDprCarv6RymzAgOVp9jxI5nbpPI33LXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KE7XPXTDZrKUIV8Y2V+cq/zHxPSaQ/Lwa5upEXxXcw=;
 b=xm2Nk93yPSkIGP5ZesUm7KZ/09PrqrzeSwzjURDbE/npXZuIaYhATEe38bNJ6E096nFqO031QjLQkrPSyrPxBv/3mYoUR9HEHsEgx/nv5fm/ehy063Jmve6zaaHfx2yiCyNdO6Isn/OFsL4XeYIH1Od1PPBHqzjOLlj0f8My5PdP6ONqLQQ1ZfwbLl6sV8PDQu79WDIlQ/6nu/kLPoCZSmxDldhmUUW1w0oWzFfm8+O1jCC8G960Z5HqugLfLmNa27esIl/asigZXnDT6NkCmjVTcBIGyd8GmqTdYhbDLf2Gj2olaunTTSOU/GzPmLn8QuVTbSeQ96crP5jTGF11Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KE7XPXTDZrKUIV8Y2V+cq/zHxPSaQ/Lwa5upEXxXcw=;
 b=nBupn0lE+6F6yAme9DwjInuTapl75eeOVIhejtanQyOvu16vtEQEY/gdROwH2IbFIGm61AHE6+skTXQVFhLMkCI7Js8+lIGa8Iulv5jDhxm0yQMHnJtWSIyPBRHp9LCUuRl5hkNpCxFItPj1XE6ujbYDBS3EPCGgXO28CGpP9kU=
Received: from MN2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:208:239::15)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 03:01:48 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::8d) by MN2PR08CA0010.outlook.office365.com
 (2603:10b6:208:239::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 03:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:47 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:43 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Martin Leung
 <Martin.Leung@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 20/30] Revert "drm/amd/display: Add 3DLUT DMA broadcast
 support"
Date: Thu, 26 Mar 2026 10:57:11 +0800
Message-ID: <20260326030153.406612-21-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: b38006cf-6b30-44b7-223e-08de8ae4051c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ilZcnjhj1iBQV661nT/Box3+DmJwgE3gkiFq7KbEd22aCdbIGhehRkWRP3XORuAjJT5LviLKzhP3osQqZUm9VxDc31gA4Zl4/nNjjW4XERKCG38kgs6hyWV/5NgKkt2gsDb8mzK+1FY7xsm9YvzqKWjavCNyDOZ1sxw3bq7epBy09RziVK+V8v0T/jbMQzvfpz6PtuXj10LBfU96356aOFjYMXCcVdxD6OscuZqB8uiOsScEXAJiJAaIQKqhQk1oVqYDhTXN8hHrF3ck6jd04LFbsd921hy3LcpDqiQg53FMvHD5dtUrs5M2swWoF10TEaHVOt0Bg7upVVIjyt96zDl4skoyYRrUPpRFdWBXtzk76j+anc4ptE9ASpCY1pPaGlGCZnrkCODJFCv6S6tai30aX9OBRbR/gCZwxgJYJm5XgqTt7woLYajM/h0B4l4WGkFOLJmLF8Oh9hFF1RtJiVsMd9q37s2+DtqlMFmhW2vuMmfSHINLBnx0KoIgicu76jh/18JIZNVbEYAFC1LKIBnODHMR2F+tlYCMcUJzVbrffrzbVOg8H8a5rNUaxTeG+hPLFoFIx7nJFiSkHjvUE5Zo13IdBuSN7wp8yI9O1khj51TseEqrvZ9aw0oDLBR0v2xNwcWzbyGFRN4PlK0LLNkfTmsElN/xxa8JDniTH08B5iN9gY6lUwkHzH2ewMU6IbfxZDOEECue/BiABr8iovfvGsiSn5QnpKhYQGso+ekSESZV86sdLicVmrmilgTCYh9ak/smqmHbg4wHZpX/Lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kUPQ5CTY8VFSmMIXFNFm6iaRJceZYij4ljUYOJ3MV0wIuoX8HtgB1FbOp8L+WJ8O/WZfDPcwDmtxigTsUJftJzZcJWdrnkwmwCi0SSJ0lO//wHCnyOsXri7QPQ9cRIHZT7rBH/q3f1qaksAt+4FYo9P9HXD4chr+egpnw89oSy/vlmvm2KaKtZVm6pVDe4bbG+NQ+B2CfR1Nqnbrtpn2W7IyMGCeQH3/kMPSA/sZ99aKgCIurR7k+KAE07uq3QuXcwR4rL993zCC7ccC3yW7gs1VdGQkyyN0ZDnuua9izBsurIwp3/DMrV9dqMpJd1QoFJVRmIo/u6coOrGGpJvuasnOYDuLXYUKmn6so8yyNxkxV+9dKRFtYQ+GA1xStuBWBAMmVF4/N5SFKqhv6aEZvv38skCRNQIWLRdqh3wmiz7mVwg5OVS5XIIPQHbvs7S/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:47.5640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b38006cf-6b30-44b7-223e-08de8ae4051c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
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

Revert commit 14978d267e12 ("drm/amd/display: Add 3DLUT DMA broadcast support")

[WHY&HOW]
Dependencies of this change are still causing issues, so reverting until
those can be fixed.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 109 ++++++++----------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 4 files changed, 49 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1db99c14876a..e0eba1bf2dde 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4671,7 +4671,7 @@ static void commit_planes_for_stream(struct dc *dc,
 						srf_updates[i].cm->flags.bits.lut3d_enable &&
 						srf_updates[i].cm->flags.bits.lut3d_dma_enable &&
 						dc->hwss.trigger_3dlut_dma_load)
-					dc->hwss.trigger_3dlut_dma_load(pipe_ctx);
+					dc->hwss.trigger_3dlut_dma_load(dc, pipe_ctx);
 
 				/*program triple buffer after lock based on flip type*/
 				if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 56d4c350d8c9..a11dd9dd703b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -369,14 +369,13 @@ void dcn401_init_hw(struct dc *dc)
 	}
 }
 
-void dcn401_trigger_3dlut_dma_load(struct pipe_ctx *pipe_ctx)
+void dcn401_trigger_3dlut_dma_load(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
-	const struct pipe_ctx *primary_dpp_pipe_ctx = resource_get_primary_dpp_pipe(pipe_ctx);
-	struct hubp *primary_hubp = primary_dpp_pipe_ctx ?
-			primary_dpp_pipe_ctx->plane_res.hubp : NULL;
+	(void)dc;
+	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 
-	if (primary_hubp && primary_hubp->funcs->hubp_enable_3dlut_fl) {
-		primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
+	if (hubp->funcs->hubp_enable_3dlut_fl) {
+		hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
 	}
 }
 
@@ -384,11 +383,8 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 				const struct dc_plane_state *plane_state)
 {
 	struct dc *dc = pipe_ctx->plane_res.hubp->ctx->dc;
-	const struct pipe_ctx *primary_dpp_pipe_ctx = resource_get_primary_dpp_pipe(pipe_ctx);
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	struct hubp *primary_hubp =	primary_dpp_pipe_ctx ?
-			primary_dpp_pipe_ctx->plane_res.hubp : NULL;
 	const struct dc_plane_cm *cm = &plane_state->cm;
 	int mpcc_id = hubp->inst;
 	struct mpc *mpc = dc->res_pool->mpc;
@@ -486,41 +482,25 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 			mpc->funcs->program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, 12, mpcc_id);
 
 		if (mpc->funcs->update_3dlut_fast_load_select)
-			mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, primary_hubp->inst);
+			mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, hubp->inst);
 
 		/* HUBP */
-		if (primary_hubp->inst == hubp->inst) {
-			/* only program if this is the primary dpp pipe for the given plane */
-			if (hubp->funcs->hubp_program_3dlut_fl_config)
-				hubp->funcs->hubp_program_3dlut_fl_config(hubp, &cm->lut3d_dma);
+		if (hubp->funcs->hubp_program_3dlut_fl_config)
+			hubp->funcs->hubp_program_3dlut_fl_config(hubp, &cm->lut3d_dma);
 
-			if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
-				hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp, cm->lut3d_dma.format);
+		if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
+			hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp, cm->lut3d_dma.format);
 
-			if (hubp->funcs->hubp_program_3dlut_fl_addr)
-				hubp->funcs->hubp_program_3dlut_fl_addr(hubp, &cm->lut3d_dma.addr);
+		if (hubp->funcs->hubp_program_3dlut_fl_addr)
+			hubp->funcs->hubp_program_3dlut_fl_addr(hubp, &cm->lut3d_dma.addr);
 
-			if (hubp->funcs->hubp_enable_3dlut_fl) {
-				hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
-			} else {
-				/* GPU memory only supports fast load path */
-				BREAK_TO_DEBUGGER();
-				lut_enable = false;
-				result = false;
-			}
+		if (hubp->funcs->hubp_enable_3dlut_fl) {
+			hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
 		} else {
-			/* re-trigger priamry HUBP to load 3DLUT */
-			if (primary_hubp->funcs->hubp_enable_3dlut_fl) {
-				primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
-			}
-
-			/* clear FL setup on this pipe's HUBP */
-			memset(&lut3d_dma, 0, sizeof(lut3d_dma));
-			if (hubp->funcs->hubp_program_3dlut_fl_config)
-				hubp->funcs->hubp_program_3dlut_fl_config(hubp, &lut3d_dma);
-
-			if (hubp->funcs->hubp_enable_3dlut_fl)
-				hubp->funcs->hubp_enable_3dlut_fl(hubp, false);
+			/* GPU memory only supports fast load path */
+			BREAK_TO_DEBUGGER();
+			lut_enable = false;
+			result = false;
 		}
 	} else {
 		/* Legacy (Host) Load Mode */
@@ -1830,41 +1810,42 @@ void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx)
 	 * This is meant to work around a known HW issue where VREADY will cancel the pending 3DLUT_ENABLE signal regardless
 	 * of whether OTG lock is currently being held or not.
 	 */
-	const struct pipe_ctx *otg_master_pipe_ctx = resource_get_otg_master(pipe_ctx);
-	struct timing_generator *tg = otg_master_pipe_ctx ?
-			otg_master_pipe_ctx->stream_res.tg : NULL;
-	const struct pipe_ctx *primary_dpp_pipe_ctx = resource_is_pipe_type(pipe_ctx, DPP_PIPE) ?
-			resource_get_primary_dpp_pipe(pipe_ctx) : pipe_ctx;
-	struct hubp *primary_hubp = primary_dpp_pipe_ctx ?
-			primary_dpp_pipe_ctx->plane_res.hubp : NULL;
-
-	if (!otg_master_pipe_ctx && !tg) {
-		return;
+	struct pipe_ctx *wa_pipes[MAX_PIPES] = { NULL };
+	struct pipe_ctx *odm_pipe, *mpc_pipe;
+	int i, wa_pipe_ct = 0;
+
+	for (odm_pipe = pipe_ctx; odm_pipe != NULL; odm_pipe = odm_pipe->next_odm_pipe) {
+		for (mpc_pipe = odm_pipe; mpc_pipe != NULL; mpc_pipe = mpc_pipe->bottom_pipe) {
+			if (mpc_pipe->plane_state &&
+					mpc_pipe->plane_state->cm.flags.bits.lut3d_enable &&
+					mpc_pipe->plane_state->cm.flags.bits.lut3d_dma_enable) {
+				wa_pipes[wa_pipe_ct++] = mpc_pipe;
+			}
+		}
 	}
 
-	if (primary_dpp_pipe_ctx &&
-			primary_dpp_pipe_ctx->plane_state &&
-			primary_dpp_pipe_ctx->plane_state->cm.flags.bits.lut3d_enable &&
-			primary_dpp_pipe_ctx->plane_state->cm.flags.bits.lut3d_dma_enable) {
-		if (tg->funcs->set_vupdate_keepout)
-			tg->funcs->set_vupdate_keepout(tg, true);
+	if (wa_pipe_ct > 0) {
+		if (pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout)
+			pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout(pipe_ctx->stream_res.tg, true);
 
-		if (primary_hubp->funcs->hubp_enable_3dlut_fl) {
-			primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
+		for (i = 0; i < wa_pipe_ct; ++i) {
+			if (wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl)
+				wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl(wa_pipes[i]->plane_res.hubp, true);
 		}
 
-		tg->funcs->unlock(tg);
-		if (tg->funcs->wait_update_lock_status)
-			tg->funcs->wait_update_lock_status(tg, false);
+		pipe_ctx->stream_res.tg->funcs->unlock(pipe_ctx->stream_res.tg);
+		if (pipe_ctx->stream_res.tg->funcs->wait_update_lock_status)
+			pipe_ctx->stream_res.tg->funcs->wait_update_lock_status(pipe_ctx->stream_res.tg, false);
 
-		if (primary_hubp->funcs->hubp_enable_3dlut_fl) {
-			primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
+		for (i = 0; i < wa_pipe_ct; ++i) {
+			if (wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl)
+				wa_pipes[i]->plane_res.hubp->funcs->hubp_enable_3dlut_fl(wa_pipes[i]->plane_res.hubp, true);
 		}
 
-		if (tg->funcs->set_vupdate_keepout)
-			tg->funcs->set_vupdate_keepout(tg, false);
+		if (pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout)
+			pipe_ctx->stream_res.tg->funcs->set_vupdate_keepout(pipe_ctx->stream_res.tg, false);
 	} else {
-		tg->funcs->unlock(tg);
+		pipe_ctx->stream_res.tg->funcs->unlock(pipe_ctx->stream_res.tg);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index b9a03ffa2717..f78162ab859b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -41,7 +41,8 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 bool dcn401_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream);
-void dcn401_trigger_3dlut_dma_load(struct pipe_ctx *pipe_ctx);
+void dcn401_trigger_3dlut_dma_load(struct dc *dc,
+				struct pipe_ctx *pipe_ctx);
 void dcn401_calculate_dccg_tmds_div_value(struct pipe_ctx *pipe_ctx,
 				unsigned int *tmds_div);
 enum dc_status dcn401_enable_stream_timing(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 98abe0d2d30f..d1dba7ffcd9b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1120,7 +1120,7 @@ struct hw_sequencer_funcs {
 	void (*program_output_csc)(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			enum dc_color_space colorspace,
 			uint16_t *matrix, int opp_id);
-	void (*trigger_3dlut_dma_load)(struct pipe_ctx *pipe_ctx);
+	void (*trigger_3dlut_dma_load)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 
 	/* VM Related */
 	int (*init_sys_ctx)(struct dce_hwseq *hws,
-- 
2.43.0

