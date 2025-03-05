Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C18BC282D3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FE610E4E9;
	Wed,  5 Mar 2025 05:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cp+Z6SmO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8A110E4E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCR1NHoplNaUSQzVbv7FYwnE8t0hjT4dRXmeHjWYzC7CMqiCC589G0nM9zUEbDoVI3DGE3kD3NJtBGs7KO4yoG9KqJtjcqIoXiYoppqSbzxTdBWr/D9V76I3cUFd6ayySIXZnGvwZMbqknVj4lLXXvCVaDNDaFMPwYeafetdua0OML4kGAhNAy/amQlFlXcMp028zcz/xFGWIQ6zjZkY74SPrg5zL8BMm3JcxpgZ+MKpeVdnd9fdw6u3CHti1oOFBrtJ8EzcrhfC1Tlu2/C1f6YCzb654XM36f2UM/Pcpe5H1S16LhI7xnEbJngEje6QWAJP8ErusGF2rXy651mFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5LH24/glM8xkF+5rVAWBPif8zj//FoW6lD8G+v8Mg4=;
 b=DOjEDkFaN99mpvTgsTzusR7CIDqTkntE82Bdj0QmLs8qYk+fwC3uhX0CNow/Fk1A6y6jJY4qvZHe5dh+CWlBDdDL1Xdo8GaroRscib91E7kN9e/JsHDYR+pTxq1pn/ZKzaz6Gaz3alGCrrvaV4Bcp1KM9IagfoXxFzta8NrSIqQvvn+Tju3G4GFa6nNKzLgbMMQm48MJ252y8M28ZfcfIcLU1qwDNGN47/ZKw2pF4c7ZmHjBBg9Oqk34R7eyXKFcbm9yi5BoYjlI//aKHieC9DtZ0MUuC1amWMrQ6qYTFvDZgeAC1hSlmFbAI0qk4H+r2igbYzyl0GVveJlOysxlZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5LH24/glM8xkF+5rVAWBPif8zj//FoW6lD8G+v8Mg4=;
 b=Cp+Z6SmOK47eYt93Fxb7DetjEU8+HUESPbFcju/REK1gUXCbVEv+gd/Of/PaDIHdu0kecWN20GEY/Ieb82hw6hwG2YDSNmRuNRyKpCUjR+v/hzqNXLMmE0GLhrjp4ZUi5w9uUHy9KWUhpslBzW29mwvUtO7WfyeWfGo2aT7z5+o=
Received: from BN7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:408:34::29)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 5 Mar
 2025 05:15:19 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:34:cafe::ca) by BN7PR06CA0052.outlook.office365.com
 (2603:10b6:408:34::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Wed,
 5 Mar 2025 05:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:15:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:15:19 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:15:15 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Danny Wang <danny.wang@amd.com>, Anthony Koo
 <anthony.koo@amd.com>, Robin Chen <robin.chen@amd.com>, Zhongwei Zhang
 <Zhongwei.Zhang@amd.com>
Subject: [PATCH 07/22] drm/amd/display: Do not enable replay when vtotal
 update is pending.
Date: Wed, 5 Mar 2025 13:13:47 +0800
Message-ID: <20250305051402.1550046-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebd6456-beb5-43cc-c6e1-08dd5ba4b943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ET5L/5iLfkfpUrzIccw9E2qtPsNyUu8qDmTeITCUnldu7YCqCNqS6jA3Gj/C?=
 =?us-ascii?Q?kl34KVIwDchGKb4ZopFtjqa+iYsHWDAtE+0Um4s4X+UQdlmfVERVLtNpzpvj?=
 =?us-ascii?Q?Os2+gbtMk24EhnEWBqPMaqR74WE+1SkusCHxYiEjDupBgwz1gKz55j7zW64z?=
 =?us-ascii?Q?/VIHd1TMVR+U9cuOl1g+JEQcokMkQGizuLfaSrf3i1sObo2/GVRCKUn/NYka?=
 =?us-ascii?Q?v3HmT4NiXAsJFhaNu93RFBrZQAGdCv+uu070VSgHCNGjhNw9phN2vLgga1yB?=
 =?us-ascii?Q?BM+pIFvZTnW47TmuJSn5mYOHmOT2ygNmTJjTDo3nit+4jrOiwJpZVMbPoBpG?=
 =?us-ascii?Q?ypUE3U+rOQSjrH5rcxtCLQN6M0dtaWIqOwEHisuZ2QbCA85Kn/dFwrnK+npD?=
 =?us-ascii?Q?2q7qECZT74sB398jeBNdcZv2x0c2OVTmfTsTTSRbvJbW1tNuh+5G8H7rmlap?=
 =?us-ascii?Q?a1eV5W95bTgnC6ERrilzbA+IlzJ63RARGQJXrVVeMte/9vLVQUU9XbyPSxkW?=
 =?us-ascii?Q?FG+UhpJoehBSXaHxq3J6qppu9+tZML8BDFrHFXr7jacKAAd6kz0XeLwEGi+x?=
 =?us-ascii?Q?yYmv4C+Pd1BpNOv8tDjWF7ognajsoj1gyKjNBcBP7DoYvSsVpH/+FH7URiLh?=
 =?us-ascii?Q?6jnJ31ImujcOY1Ub2MvDVbdN0/JobuQDf4UlV9TB9lEtgKu1X8fSg1wDEu2W?=
 =?us-ascii?Q?nnTGAWD88VyhtITHY+FLOigUHSVnXophR0txgiueP5RSDWMQI6040Cx9Fg7f?=
 =?us-ascii?Q?Dp87TkVSVcPGhCnsNEaXZ4oa65ETrWatvwyvVZRwum/AnF9yF67fpP/sGUDz?=
 =?us-ascii?Q?oe7hes2lJ+dDrN+IX7vlx78fOAWTx81kjAoVyi/oXCOkaOZ//CmLoqQoMz43?=
 =?us-ascii?Q?Od0jueIdnG9pF42RT6hAAtF/32gijT9YMyhwD/tZ3BzdV/yiAQ6noT28BSLT?=
 =?us-ascii?Q?f6Z/t1VAPBKbyPAFRSzw9TVW0LgQqb02vZ4NTYKaxltc7nQ9h6fPzh3zRPGO?=
 =?us-ascii?Q?y5NWhmWNNXcA8l+7aRbz2XBIHc0tpQiqas6I93DVDAqEncKU6PK87bodqxS5?=
 =?us-ascii?Q?wtBTJytWGxUZwzdjODa5vKeDHwNZaWfvi1FTfiZUR29m8ctpiYOST06iJgIX?=
 =?us-ascii?Q?i142nOd4LVECZgAYc1vkNWUkXOQuTV3B+1TPGKLZdW8PGX1nxj9XbEfcQnVx?=
 =?us-ascii?Q?49KXb+uzgksxou1SViElpWEi4M0oHSWSJrrXlJeJBTOKp5Zgf4iEHmIkf6Oc?=
 =?us-ascii?Q?vbOWH8YkZIM5DVWlFd19MD4q9ozk8uv1oSRddNw6j1O9SAchX2vocL89QhwF?=
 =?us-ascii?Q?cZDeu+yjQrWaUNAbMV8Z2V5DGugi5rADCtW4qP7h3BuGUxNN/gPK+xUnjqrU?=
 =?us-ascii?Q?NujsERviLqxXWgAgsUxqLdyNPpijOo/KGo56rpcjKHasksNzo1CP589trxZ8?=
 =?us-ascii?Q?Mhf3eYhX8Q+1Lr99YMYvy/UOmyi3DgMz7nQ9UO7FvY08OGYh99VHtSgLwIJg?=
 =?us-ascii?Q?h6PwrkcvuAo25KE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:15:19.7156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebd6456-beb5-43cc-c6e1-08dd5ba4b943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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

From: Danny Wang <danny.wang@amd.com>

[Why&How]
Vtotal is not applied to HW when handling vsync interrupt.
Make sure vtotal is aligned before enable replay.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Danny Wang <danny.wang@amd.com>
Signed-off-by: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          |  9 +++++++--
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h      |  1 +
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |  7 ++-----
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  7 ++-----
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  8 ++------
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  4 +---
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  3 +--
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 10 +++-------
 .../gpu/drm/amd/display/dc/hwss/hw_sequencer.h    |  6 ++++++
 10 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e71ea21401f5..5a43e4901cc0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -453,6 +453,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 
 	if (dc->caps.max_v_total != 0 &&
 		(adjust->v_total_max > dc->caps.max_v_total || adjust->v_total_min > dc->caps.max_v_total)) {
+		stream->adjust.timing_adjust_pending = false;
 		if (adjust->allow_otg_v_count_halt)
 			return set_long_vtotal(dc, stream, adjust);
 		else
@@ -466,7 +467,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 			dc->hwss.set_drr(&pipe,
 					1,
 					*adjust);
-
+			stream->adjust.timing_adjust_pending = false;
 			return true;
 		}
 	}
@@ -3165,8 +3166,12 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_active_fixed)
 		stream->vrr_active_fixed = *update->vrr_active_fixed;
 
-	if (update->crtc_timing_adjust)
+	if (update->crtc_timing_adjust) {
+		if (stream->adjust.v_total_min != update->crtc_timing_adjust->v_total_min ||
+			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max)
+			stream->adjust.timing_adjust_pending = true;
 		stream->adjust = *update->crtc_timing_adjust;
+	}
 
 	if (update->dpms_off)
 		stream->dpms_off = *update->dpms_off;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index e0277728268a..52ee2225e132 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -659,6 +659,21 @@ void set_p_state_switch_method(
 	}
 }
 
+void set_drr_and_clear_adjust_pending(
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream,
+		struct drr_params *params)
+{
+	/* params can be null.*/
+	if (pipe_ctx && pipe_ctx->stream_res.tg &&
+			pipe_ctx->stream_res.tg->funcs->set_drr)
+		pipe_ctx->stream_res.tg->funcs->set_drr(
+				pipe_ctx->stream_res.tg, params);
+
+	if (stream)
+		stream->adjust.timing_adjust_pending = false;
+}
+
 void get_fams2_visual_confirm_color(
 		struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 9f3dd8824ed5..d562ddeca512 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -1017,6 +1017,7 @@ struct dc_crtc_timing_adjust {
 	uint32_t v_total_mid;
 	uint32_t v_total_mid_frame_num;
 	uint32_t allow_otg_v_count_halt;
+	uint8_t timing_adjust_pending;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 9c9947fc5d44..bfd734e15731 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1658,9 +1658,7 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 
 	params.vertical_total_min = stream->adjust.v_total_min;
 	params.vertical_total_max = stream->adjust.v_total_max;
-	if (pipe_ctx->stream_res.tg->funcs->set_drr)
-		pipe_ctx->stream_res.tg->funcs->set_drr(
-			pipe_ctx->stream_res.tg, &params);
+	set_drr_and_clear_adjust_pending(pipe_ctx, stream, &params);
 
 	// DRR should set trigger event to monitor surface update event
 	if (stream->adjust.v_total_min != 0 && stream->adjust.v_total_max != 0)
@@ -2109,8 +2107,7 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
 		struct timing_generator *tg = pipe_ctx[i]->stream_res.tg;
 
 		if ((tg != NULL) && tg->funcs) {
-			if (tg->funcs->set_drr)
-				tg->funcs->set_drr(tg, &params);
+			set_drr_and_clear_adjust_pending(pipe_ctx[i], pipe_ctx[i]->stream, &params);
 			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
 				if (tg->funcs->set_static_screen_control)
 					tg->funcs->set_static_screen_control(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 301ef36d3d05..912f96323ed6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1113,9 +1113,7 @@ static void dcn10_reset_back_end_for_pipe(
 		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
 		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
-		if (pipe_ctx->stream_res.tg->funcs->set_drr)
-			pipe_ctx->stream_res.tg->funcs->set_drr(
-					pipe_ctx->stream_res.tg, NULL);
+		set_drr_and_clear_adjust_pending(pipe_ctx, pipe_ctx->stream, NULL);
 		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
 			pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 	}
@@ -3218,8 +3216,7 @@ void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
 		struct timing_generator *tg = pipe_ctx[i]->stream_res.tg;
 
 		if ((tg != NULL) && tg->funcs) {
-			if (tg->funcs->set_drr)
-				tg->funcs->set_drr(tg, &params);
+			set_drr_and_clear_adjust_pending(pipe_ctx[i], pipe_ctx[i]->stream, &params);
 			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
 				if (tg->funcs->set_static_screen_control)
 					tg->funcs->set_static_screen_control(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index a5a3e0823e21..926c08e790c1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -952,9 +952,7 @@ enum dc_status dcn20_enable_stream_timing(
 	params.vertical_total_max = stream->adjust.v_total_max;
 	params.vertical_total_mid = stream->adjust.v_total_mid;
 	params.vertical_total_mid_frame_num = stream->adjust.v_total_mid_frame_num;
-	if (pipe_ctx->stream_res.tg->funcs->set_drr)
-		pipe_ctx->stream_res.tg->funcs->set_drr(
-			pipe_ctx->stream_res.tg, &params);
+	set_drr_and_clear_adjust_pending(pipe_ctx, stream, &params);
 
 	// DRR should set trigger event to monitor surface update event
 	if (stream->adjust.v_total_min != 0 && stream->adjust.v_total_max != 0)
@@ -2856,9 +2854,7 @@ void dcn20_reset_back_end_for_pipe(
 			pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
-		if (pipe_ctx->stream_res.tg->funcs->set_drr)
-			pipe_ctx->stream_res.tg->funcs->set_drr(
-					pipe_ctx->stream_res.tg, NULL);
+		set_drr_and_clear_adjust_pending(pipe_ctx, pipe_ctx->stream, NULL);
 		/* TODO - convert symclk_ref_cnts for otg to a bit map to solve
 		 * the case where the same symclk is shared across multiple otg
 		 * instances
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 288e9dd9205d..f38340aa3f15 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -543,9 +543,7 @@ static void dcn31_reset_back_end_for_pipe(
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 
-	if (pipe_ctx->stream_res.tg->funcs->set_drr)
-		pipe_ctx->stream_res.tg->funcs->set_drr(
-				pipe_ctx->stream_res.tg, NULL);
+	set_drr_and_clear_adjust_pending(pipe_ctx, pipe_ctx->stream, NULL);
 
 	/* DPMS may already disable or */
 	/* dpms_off status is incorrect due to fastboot
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index b907ad1acedd..922b8d71cf1a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1473,8 +1473,7 @@ void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 					num_frames = 2 * (frame_rate % 60);
 				}
 			}
-			if (tg->funcs->set_drr)
-				tg->funcs->set_drr(tg, &params);
+			set_drr_and_clear_adjust_pending(pipe_ctx[i], pipe_ctx[i]->stream, &params);
 			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
 				if (tg->funcs->set_static_screen_control)
 					tg->funcs->set_static_screen_control(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 39668d8cc13a..8f5da0ded850 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -830,10 +830,7 @@ enum dc_status dcn401_enable_stream_timing(
 	}
 
 	hws->funcs.wait_for_blank_complete(pipe_ctx->stream_res.opp);
-
-	if (pipe_ctx->stream_res.tg->funcs->set_drr)
-		pipe_ctx->stream_res.tg->funcs->set_drr(
-			pipe_ctx->stream_res.tg, &params);
+	set_drr_and_clear_adjust_pending(pipe_ctx, stream, &params);
 
 	/* Event triggers and num frames initialized for DRR, but can be
 	 * later updated for PSR use. Note DRR trigger events are generated
@@ -1820,9 +1817,8 @@ void dcn401_reset_back_end_for_pipe(
 			pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
-		if (pipe_ctx->stream_res.tg->funcs->set_drr)
-			pipe_ctx->stream_res.tg->funcs->set_drr(
-					pipe_ctx->stream_res.tg, NULL);
+		set_drr_and_clear_adjust_pending(pipe_ctx, pipe_ctx->stream, NULL);
+
 		/* TODO - convert symclk_ref_cnts for otg to a bit map to solve
 		 * the case where the same symclk is shared across multiple otg
 		 * instances
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 2b1a2a00648a..c8b5ed834579 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -46,6 +46,7 @@ struct dce_hwseq;
 struct link_resource;
 struct dc_dmub_cmd;
 struct pg_block_update;
+struct drr_params;
 
 struct subvp_pipe_control_lock_fast_params {
 	struct dc *dc;
@@ -527,6 +528,11 @@ void set_p_state_switch_method(
 		struct dc_state *context,
 		struct pipe_ctx *pipe_ctx);
 
+void set_drr_and_clear_adjust_pending(
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream,
+		struct drr_params *params);
+
 void hwss_execute_sequence(struct dc *dc,
 		struct block_sequence block_sequence[],
 		int num_steps);
-- 
2.34.1

