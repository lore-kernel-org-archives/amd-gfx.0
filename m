Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA205E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF6410F079;
	Fri, 13 Dec 2024 15:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mqArkJtN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34CA10F079
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IloMZ/+3BIHdGzTf+CxHJCyxMfXXSrsWUKndOQMW08guag8gxmjeZdmj0yCqlqYeSCTAw8xfuE8vn+abzsIl4KAGhPeTaA/LlpQqRferA2WY1yRnqrqrhPQFqxoRQ/twqXItNXzNvhvDpTQCE8uxyaRddhdlOLjbFj8puc50526AW2G06se+fQgIr9731bYnOrCtGIn89IeoLNKB99RptVetjDRBKhlwpQMatxzcLeqpk5TA0QjbIbodEeWtdl+trIEehCSt0TVvLds7yr+SsXvyfeCFRp7HOKgd09zgjOx7d+g1mMR4O1JRQxUJJFXiEyTv6bG0LAGAwFAuQ8Iiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MQhST/o5LjARhCkQgZbO84C9E//fyyvdojPAQE6EZE=;
 b=qXrTVnPbh7uew3epPKN14Gyg9KbwTLXY71TXK6+g/FvOmrC/SRMnrfMjGAAKRvZTg4mAhztexg3F8rH06AhCCcHWao1hLcSUGVeiECXia0RZrwIr9r7NA0lYi1W0nZYGdt6NvKc7JwRpbUFOHercPEXD83orO0ugrULZS6m72oCKRtZYuA/U6oyE9Wbkb/H5MxGGGLn7a8aUdGEr1rHRyUOP8noYQppXaG3XZpZiGfwZcUZvQslD7F+XANOmWdYUL6j/0NEWV40r5oQf2gmBy3cSF2Xe1Ey1NVHhbNDgjU1T40oetnX6STWo3ubNSd0sP/RJiHhL5dW6yXTZq4Dk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MQhST/o5LjARhCkQgZbO84C9E//fyyvdojPAQE6EZE=;
 b=mqArkJtNm2WO1qrF87aR9ZG8nMQqwoEaRRkDxnn2BoT1uY2vnrWmvFikULlZI3ygYUXtZAioPEEsfMdgSk4bzcwULOtKruQK2JP5nFETY3+LNtv/3A5SO2v0IWNw/TcXPyjeo5ZlAdPJkHkSbeOX1gOG1mh5TnvtIFVnyN3iXvY=
Received: from BN8PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:70::42)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:55:19 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::36) by BN8PR04CA0029.outlook.office365.com
 (2603:10b6:408:70::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 15:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:55:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:55:15 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, George Shen
 <george.shen@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 16/17] drm/amd/display: Disable MPC rate control on ODM pipe
 update
Date: Fri, 13 Dec 2024 08:52:48 -0700
Message-ID: <20241213155405.393252-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SN7PR12MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6c9888-5219-4b96-3874-08dd1b8e8b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VRT6+h8D6juKUj47Q5tfLiHyoImkeMcnCHY4INaswzrUEpkr46kUD2hMNmsa?=
 =?us-ascii?Q?g1/Kbi1wilvdp/vEbZ7hlHgu1f2+gLAr2BLX3v0SPyWKz5j8oOolBziOtpbW?=
 =?us-ascii?Q?e0EoG2FfL0ILnOoPOPuKhmWMJtrNGDqVhOD9ahr7LS/8V22abPSNjR+sUTTO?=
 =?us-ascii?Q?wSYSyNEeZjYZSExXKcgsFRE3YZ6GiE5bYfzNMAEABncn5BjQ6z7uxv9KFljf?=
 =?us-ascii?Q?9BAVJSadt21XYu1FtNcg1QwZKA/jLM8xgvZX4OhA9WbRDyk3P+Bub7ptfiaC?=
 =?us-ascii?Q?RBz018jyfLznGfnVbQ3DtKqmwB/4RnFZ35mvPN5cJIN7hAUICl5ldSMxfoHI?=
 =?us-ascii?Q?vp5+GIi75rTnACnw3v9WQhRTZ2+oiWOwDk2Tl214OfdBncV1Dd7H9qO09SEA?=
 =?us-ascii?Q?76iwYxu6GbPAJRGHafZM1bi2hCsBwzRhUZsLxSPsx/PHBZ7mkVdr7XsGT5RG?=
 =?us-ascii?Q?Ym3dXqJZ8aGPNc82r/mTg8v7Y5X9B47tHqKHOvVK7U/F4Gkwj/ZMVoMkaH9d?=
 =?us-ascii?Q?QkAJ7sc0fF/nJEtRyXGwslFD3tXgnRXzL3QEq3aXCuP+MRcKW5WuqDWwoQJN?=
 =?us-ascii?Q?0UzQEeZwbL+c24iYojLCfsRhPeAbiib9nGN8iMBYP1++BWUjwwtK2oxmezGr?=
 =?us-ascii?Q?uqpaWRWlugQmrZ3JpJvqyp8nucTfsPJVjoLiiLBpvI0Kuz4Lm3GZ4q97U37Y?=
 =?us-ascii?Q?iRliDY4HihtOWUxR0KXaO26N0JhJ2pp7UUmxei5o2dISQOlgXeaKtfnpVd2L?=
 =?us-ascii?Q?wzr1fy05jLY8PlVr3RTMP97pStPA7Vroby9a23cn/7n7/oL/9AjvjFNGInyE?=
 =?us-ascii?Q?/X7M8/tGEC84AY6aC0ZB+ryofBmV2TnZ3X8M/qLyeexhvPLhKpSuObT2x4Q9?=
 =?us-ascii?Q?FYWXDgBYR/sRSCrigpiWuoHsssmXFRuXT5DTEA4reYs2rPXd0Z9sfi89ZEAX?=
 =?us-ascii?Q?6fuKY7c3D3iAqK8O4hHQ0N9mYWgRQK5tTV7FMmBJ+yirAfYowqhaZp6xOMxF?=
 =?us-ascii?Q?jnMlAHTYzvRSbI/Wfr6Swg6ZhQgZ/gNrFeuUP9OPyQsty7+O5Bf2dbu4ETJA?=
 =?us-ascii?Q?zZphpngkO3KxFFBWYjKjic79mjSNeNpFiPPdp5sy1TwsV4UXUj6ZYNbzAWv0?=
 =?us-ascii?Q?3t3AsmbTngqo0rNpMUeaIKgzJ7pHcB5+KYkyJimZgembxOY8eY5/VE+xLsJn?=
 =?us-ascii?Q?TDOMNc9/9v2Sqyi+z91gPSwJKj5D20O8xj+jnCm4V0YIZ6LUbT6jYpOSpNxO?=
 =?us-ascii?Q?oGff9xufSGAb1RZ3OUyPgjUtRQ9a0RmuAkkyJZUac6fMMUpD4LqGp0ewIXs3?=
 =?us-ascii?Q?P3P6DGxQuIgyOqEh13ykjSXOCCWxJyQOSL531TdDzIBqkAMiwdi9uYGIcnMR?=
 =?us-ascii?Q?IBq+OYBOPvU5F4f3Kl+RXHmPkY7vcm+uDMmEEJk722+ypkRkA/Ui3tK3QZNS?=
 =?us-ascii?Q?o1hrm1aX3ioOoNBF7ma/GGQcUmQwmBod?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:55:19.2006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6c9888-5219-4b96-3874-08dd1b8e8b4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765
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
Seamless boot skips MPC init for the active pipe, resulting in stale MPC
rate control state being retained. This will cause issues since other
logic assumes it is disabled (as DCN30 and newer does not need it).

[How]
Disable MPC rate control on ODM pipe update to cover the seamless boot
case.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c  | 12 ++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c    | 12 ++++++++++++
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   | 18 ++++++++++++++++++
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h   |  7 +++++++
 4 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 9b88eb72086d..be26c925fdfa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -162,6 +162,8 @@ void dcn314_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx
 	int opp_inst[MAX_PIPES] = {0};
 	int odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
 	int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
+	struct mpc *mpc = dc->res_pool->mpc;
+	int i;
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -174,6 +176,16 @@ void dcn314_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
+	if (mpc->funcs->set_out_rate_control) {
+		for (i = 0; i < opp_cnt; ++i) {
+			mpc->funcs->set_out_rate_control(
+					mpc, opp_inst[i],
+					false,
+					0,
+					NULL);
+		}
+	}
+
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
 				odm_pipe->stream_res.opp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index e599cdc465bf..d5f76cc69c73 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -426,6 +426,8 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	int opp_inst[MAX_PIPES] = {0};
 	int odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
 	int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
+	struct mpc *mpc = dc->res_pool->mpc;
+	int i;
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
 
@@ -438,6 +440,16 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
+	if (mpc->funcs->set_out_rate_control) {
+		for (i = 0; i < opp_cnt; ++i) {
+			mpc->funcs->set_out_rate_control(
+					mpc, opp_inst[i],
+					false,
+					0,
+					NULL);
+		}
+	}
+
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
 				odm_pipe->stream_res.opp,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
index fe26fde12eeb..85298b8a1b5e 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
@@ -110,6 +110,23 @@ void mpc3_disable_dwb_mux(
 		MPC_DWB0_MUX, 0xf);
 }
 
+void mpc3_set_out_rate_control(
+	struct mpc *mpc,
+	int opp_id,
+	bool enable,
+	bool rate_2x_mode,
+	struct mpc_dwb_flow_control *flow_control)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+
+	/* Always disable mpc out rate and flow control.
+	 * MPC flow rate control is not needed for DCN30 and above.
+	 */
+	REG_UPDATE_2(MUX[opp_id],
+			MPC_OUT_RATE_CONTROL_DISABLE, 1,
+			MPC_OUT_RATE_CONTROL, 0);
+}
+
 enum dc_lut_mode mpc3_get_ogam_current(struct mpc *mpc, int mpcc_id)
 {
 	/*Contrary to DCN2 and DCN1 wherein a single status register field holds this info;
@@ -1519,6 +1536,7 @@ static const struct mpc_funcs dcn30_mpc_funcs = {
 	.set_dwb_mux = mpc3_set_dwb_mux,
 	.disable_dwb_mux = mpc3_disable_dwb_mux,
 	.is_dwb_idle = mpc3_is_dwb_idle,
+	.set_out_rate_control = mpc3_set_out_rate_control,
 	.set_gamut_remap = mpc3_set_gamut_remap,
 	.program_shaper = mpc3_program_shaper,
 	.acquire_rmu = mpcc3_acquire_rmu,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h
index ce93003dae01..103f29900a2c 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h
@@ -1085,6 +1085,13 @@ bool mpc3_is_dwb_idle(
 	struct mpc *mpc,
 	int dwb_id);
 
+void mpc3_set_out_rate_control(
+	struct mpc *mpc,
+	int opp_id,
+	bool enable,
+	bool rate_2x_mode,
+	struct mpc_dwb_flow_control *flow_control);
+
 void mpc3_power_on_ogam_lut(
 	struct mpc *mpc, int mpcc_id,
 	bool power_on);
-- 
2.45.2

