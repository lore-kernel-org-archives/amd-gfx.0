Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F54FEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C085A10E7AB;
	Wed, 25 Mar 2026 07:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WwRWpwRU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012019.outbound.protection.outlook.com
 [40.93.195.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48BE10E7AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVKmw4ZBlTeB4vEcwUz3nhF9YrXmEbKYOKnSWB9hU0Av4MYQRc3pjNzYMqE23+IH7+LyeRxWusN4+jvMHCDeb9I/SFja6QLf57NfEz08RztRra+IQXnzO14tUxcjLY2i9wq0cJKLVkT2184SxhKb4SuG/ng3vGTmmp/jRGjMj4YU3/+RUB9TNFzcHAaLuZXONbLnX8iHXgvC6jl3FdNUtKAxSZktPsSh5GsN1qFACqr0Na7/SzzGdTdPY347EoVpqG8cpFXkYt7gNsjr74TxejBlnGVGBoijCHYjVLTnDKmMNCbHgb/KB8ZFbmsn4I2cU7ef6I+W6AqzZmC94tMndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KE7XPXTDZrKUIV8Y2V+cq/zHxPSaQ/Lwa5upEXxXcw=;
 b=XOOziScybLckdcgEvKQHDwx/kL2UsFtUPh/I5cLSrrMKHVhMyGujKb/0YsBUiQW9aFtsXchBK9immywI6OGzDCb7CAbEvtxExWSTKiYtwqzGQRpawgXnuzJC83N23+Lulb6+RhnGY3t+lL5aYCy0SjFgC+5Gszt9nY1WQGlkZIzWWybLSQhthIWbM8cwA6jaNClI/SO1YF+hE53DwqkgLpWzvAsMDUScIqdrlH4sGqP6hPz+GR3BLWGAp3HpZ3r38c8AAZ6eu1rMo9UHEuKqhScC+HD5GdwJq6VfNbGUTJwRptLm3NRQ/Q55LLHpZMJotlmtlKako5JMw2VxgDXUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KE7XPXTDZrKUIV8Y2V+cq/zHxPSaQ/Lwa5upEXxXcw=;
 b=WwRWpwRUJ2O21LQlFOyHbmmvOXfEXsTucfzlvqKq+pGTcxrLICwoOr6wtZAb0/Phlr5l7hH8aF2bwMICJu6bzZKYfwcyCmwvIiUZ3JnJkdOlIeT1z8vAlEANPqSgUzsoYI13SppXFMXktZFmlRAx0uJn9j1szbWXuw9gQufizM0=
Received: from BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::26)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 07:09:47 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::80) by BLAP220CA0021.outlook.office365.com
 (2603:10b6:208:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 07:09:47 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:43 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Martin Leung
 <Martin.Leung@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 19/29] Revert "drm/amd/display: Add 3DLUT DMA broadcast
 support"
Date: Wed, 25 Mar 2026 15:06:25 +0800
Message-ID: <20260325071003.4022594-20-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef0e4ea-d879-46c7-6a12-08de8a3d7fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WbPJ9/b3PnM8OcU6mApyAv8CenZOS+InoFZwsAxxeRYdO4RW2aYY/H6pMQOsH0YBCa1u5Ly3+Er4bBlu5l400ZbQUQJZbj1XvZ4rYtzHHSgcZgeQRjiJQj10e21NaS1xVp6ZjfbBKofsfPRv1k4Ah8mOAQ9Yi1wluDNrGtboCF9Ty1/cz9fTFOp0wqTXS0SQSfgupOlmpIrpuPnc6LOtFMEAX5/0hBJAdwVZ4dZZz9IXuH2rpmBoP+k3DUohL2TQHdYdQXuHPsVinXD5bX5IWbpoqYZ1rW6Joo6LTlECuX1rScr7TQsMsYakmlq+f/qs5DlZWmoOpuEoKNb/E/T8rCLE+7Pg2BfXHlPKlghgewnIICldfHRJv5zcheh5ABK2oCZ3m1kHD+SI3TjVGF3TOuG7w6MFzhdv2fRARgPhqaWoUx2OydMAHXU3BdWmT8o4nx7mGZjZcASb5NimEXEWqJJWwZE+1eZ2K7baMkBCcY4B4CfKyM+58lD+6V8k3x48iaOa/wTPi3ngHrRRKwbuN10KMJ2pTAr4p0ccDcCwlRDzIoVTiG3yp4mXdPHf603ZhB+b2HNCbm1VluTG5AU+z6Jz1SpnEI1kA1S5k9QXJPp6hxw7vPoP7QVTh/uhGDFZJQteu41yxF13qfFKfX4cTACA2OqH3bkzZg3tq0z4gKd6QmAsPaSjTHVIAOxdkWIuA0p7tG5nWHnvC8RQH9a5XOiHZiII3X408lVpu8pkovTtr7dAZ7/YUvQaIGLGx4F/lB0GI85Wk0ZxhFTVSAW5rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RU2xyvTE9gcr4yuKX+8WRqzwk/kkZDWrx/mXWtRiD8F1ZbZMUbfKvitmq3gzm8dkBXVNQ/YSMk33TX9/XzDDkK37OR+7jMId4GjX4VAPcW63UGQ8ZHpbRWUWimxLganUAIFBvqmUy+A06WG31rQ6h3IsqRqX846ni3pzxOBx+Q8OP83GZYtb/a26PydiTEhrJcYUvxcbwNL45BjlAGZD5tvqVBN+KCNGFzSiFMki2dPpTo8IHQem4r08srV1nr8JOA20i61EPwVwqtirRQW5vLOfaILBdY0Xc2ludPPiPJ1VVAACD0fBL9SyoBtO90udfI3j7g77wRGLBbk+DB3IkviwIJ+d+H3MPL9mmfM/CQ4xjzAdFd00w4KPCDcoxkQJZry3NGxCZk1E7L43w7x8eDctYX6viAVhWjzrbBgCEgGXVNO4aBueaI4dG5FOpdY1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:47.3892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef0e4ea-d879-46c7-6a12-08de8a3d7fc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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

