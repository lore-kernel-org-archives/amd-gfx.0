Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27A1C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3174510E05E;
	Wed, 19 Mar 2025 17:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Gt476Ku";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B13510E05E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/t0TdS0borDgUAk8MPtWe4IBzQoxl9ot3DTb0wRhqItt+P/iHD48HP4rj0H+mQBH1TYxDrMSbIopB2wLnveh0OdCawv3alARC6NNB8CR3aHfcZ56d+9ZMkfyXtGL550DEM456HJnqvHlOCI9dgI6bN5Gne55GXQ+Gk2P69XDWZbSxrqhIRY8rtiWGFmXQ4hisk1Cib4VfXygxytwHyXbjFqSYFu+PckHnTHyPACih3Z2+Qlv8rGMzEXDB7UxJj742x/wiXstPq6bIXyBSdGkhz844GUuaabS/5aIQ/3G8JRQyGAOBJaNua4e6AC3XsCrXAr7cQR8ZzA/YIO94djnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRq+qC90Nal/1Lex13wUrokod+VWDuhwaDCawBeFvYk=;
 b=ea4VHFffz4m86cagX8Ra9FixohF8Cc50ABAi7ShOsqKRWixoIzS8iti3+bqCZ723HK8EmN2PAE5y4wNCjut2o+iJFVWJKlufIT2zRxb+5kjGsLanQsc8p3gc5jyRnQrm17WKPceLHvnEiB61/wv6DgmZShcBpPw5JZjJmy3OPwWLa56QMMtsAZOfLj2FxjKtf/P7FRktKWEwBZUXNO2mv3eealupOTf9+SvcEeT5CVVKheqg5gp4rzmE5fk07wm786RzVXmPjot0/byaKI+0Em0GTdPQYMOAKJZqBJMmU8b3QPFhgfwnta87x7h0MS2TNTkeUz1t7hmMi3speFPFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRq+qC90Nal/1Lex13wUrokod+VWDuhwaDCawBeFvYk=;
 b=3Gt476KuY1gf2c/AfEIo0evgw1UTC/6JbaG3Jk5WDjzRzWHBDKQESBaM6wnzqprhEZXJemWSVTDMraxN0cwxMsQ4iDkU6TVnOMZtEAaoR7X4XSHfLt5a7JtPmZUKLIyeHUsWEf9bScZ88PQmlOtDXlpWz9y63PtyK3agR7CvWLk=
Received: from CH0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:610:76::6)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:21 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::45) by CH0PR04CA0001.outlook.office365.com
 (2603:10b6:610:76::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 17:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:57:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:20 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:19 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Leo Zeng <Leo.Zeng@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 02/16] drm/amd/display: Get visual confirm color for stream
Date: Wed, 19 Mar 2025 13:55:07 -0400
Message-ID: <20250319175718.2578234-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f49dd5-0d5a-4f53-0121-08dd670f7f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/F0vWcSItbsFmBOEWXfPBCa25Nx3iZ9CYQK8XyZXxZGY9CTx11eaLdt7epp2?=
 =?us-ascii?Q?DfHW5gzSb37Lh8j7lUW56odxh7XzxRH3zY4vtGUpIRSywleFRfYqdQRmcQuF?=
 =?us-ascii?Q?yaOUroCAzw3PA78GXKMmXRR78IjpId8r+4gsxl/JnCZ8IqoNyV7gsyeMYKnb?=
 =?us-ascii?Q?9Z/YUci58m5H9Xe1LchjxBPDcDQ8qNGh50Xbxl5jWGIv/pLb2vtS0qzgBai4?=
 =?us-ascii?Q?aP6Sc9qh7tpnZk5dUdn00D2B1+FfIwcAq1ccgU8QMIFTk3e2qP5Dh+2pmE6F?=
 =?us-ascii?Q?pPY/XJ5fhAwanysR6i/kpidQ14oOs/E4tTfA/bwf3S/9BDdtNgzVYJzD3bYb?=
 =?us-ascii?Q?dwD47oMHZE1CM4+5xlp1xF/FLpGQfqyjpGmSA5n8yosRmo5KtW6XP7KPtIUJ?=
 =?us-ascii?Q?t4XNfGzoMh/CpRZyURygOAJj6lBXCAnyQs/N85QTGr4tyuGu98Y5XGHIE89v?=
 =?us-ascii?Q?3EBmOe0gN/mszQJI7yO7Cu5uqHNYAfpStKdeojnHgp1b0zGGWkWWX4HFrRnh?=
 =?us-ascii?Q?6z/rsr3ZX3PFKS452MfN0RvAALpS4ujT5EnzcXbkiUkgEnbYu8h/xf/srO5n?=
 =?us-ascii?Q?SOvO4crNBJfRmP1CARYLKOyJyTpDePIc3qXwJrpq2wFhSjUL1ujArp/beumn?=
 =?us-ascii?Q?kaS0mpJQ0DzywfVu7VKD5/xC12luAWniTL5HwI31uuPdmu89jqhm24X1AZr8?=
 =?us-ascii?Q?+INS0ZbFMgppxA8hHIGeBQkvwKYrQjlfmpniU6GQFv0PZzZS6O2JeSu23sMe?=
 =?us-ascii?Q?TuTEUkuU3YsWaqWoF+SL0Fu9Nmx5rKUMzqLA8pOt4JCdL5cNCzSRBkiFuqio?=
 =?us-ascii?Q?RkQMOqtDpppMaFc6jfOslm//IYO592tDgL9qPR6QuBzGtL9km0D9KnCoLpKy?=
 =?us-ascii?Q?MyiNPPngn8d1eriZJquGLBqa21aPij+qJ2OKfMkQGRHhhW597RRXIrrnzGKW?=
 =?us-ascii?Q?bK65fVKvvWlOZkClDYmGFoWUlmXdsx1gPEpdZ8PmsVwMv9uaHxGYLBnpJMFT?=
 =?us-ascii?Q?Yd78eKlRTcxeyB/IkRzFOaGw34KTwzs1N4zIXIDl6st+WohzPRL0LWQ223XV?=
 =?us-ascii?Q?SJ10+DYhFtBhlRayJRq2kgD/WVaE5nz8LOlAiSz+CTOwEHUah0vKG++YrkG9?=
 =?us-ascii?Q?CpY+PtSOpOK7NquBxPf9WfP5MCr0YL/D0mQzWiXA1O7mFs2LuaBJFHMGY2/S?=
 =?us-ascii?Q?Dm8BZRDB5J18KXCOSNQ1yALkgX6rnbJeymNgRecI3Lja8ns1x+KRgfWoc/HP?=
 =?us-ascii?Q?+nkAhM787xZWrMR/wAjlKIh5Nuufmd5goL20ZL1ZIuyjK8a8Xb5BLswGrg10?=
 =?us-ascii?Q?VpZvOaTxaxCBB8NkpnWsEWEnRMDUQF8JAOeM4OgyhkmjzPtF5yK0IIYebzy8?=
 =?us-ascii?Q?qeVgowdi//8pW/RKj+uABLMDtPsgVZVlyP9wjvYS5LN2WXj5/GzpesHw5RQd?=
 =?us-ascii?Q?HK9ysSlzWpbkntHxFbuNd7HTgqnXORGpwTgY8jB62+F648/ukpgKnSQEIes6?=
 =?us-ascii?Q?PFFslju9jts4ukE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:21.2335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f49dd5-0d5a-4f53-0121-08dd670f7f37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198
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

From: Leo Zeng <Leo.Zeng@amd.com>

[WHY]
We want to output visual confirm color based on stream.

[HOW]
If visual confirm is for DMUB, use DMUB to get color.
Otherwise, find plane with highest layer index, output visual confirm color
of pipe that contains plane with highest index.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Leo Zeng <Leo.Zeng@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 45 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  5 +++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  1 -
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5a44f5da68dc..be63cc4aca1f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1231,6 +1231,51 @@ static void dc_update_visual_confirm_color(struct dc *dc, struct dc_state *conte
 	}
 }
 
+void dc_get_visual_confirm_for_stream(
+	struct dc *dc,
+	struct dc_stream_state *stream_state,
+	struct tg_color *color)
+{
+	struct dc_stream_status *stream_status = dc_stream_get_status(stream_state);
+	struct pipe_ctx *pipe_ctx;
+	int i;
+	struct dc_plane_state *plane_state = NULL;
+
+	if (!stream_status)
+		return;
+
+	switch (dc->debug.visual_confirm) {
+	case VISUAL_CONFIRM_DISABLE:
+		return;
+	case VISUAL_CONFIRM_PSR:
+	case VISUAL_CONFIRM_FAMS:
+		pipe_ctx = dc_stream_get_pipe_ctx(stream_state);
+		if (!pipe_ctx)
+			return;
+		dc_dmub_srv_get_visual_confirm_color_cmd(dc, pipe_ctx);
+		memcpy(color, &dc->ctx->dmub_srv->dmub->visual_confirm_color, sizeof(struct tg_color));
+		return;
+
+	default:
+		/* find plane with highest layer_index */
+		for (i = 0; i < stream_status->plane_count; i++) {
+			if (stream_status->plane_states[i]->visible)
+				plane_state = stream_status->plane_states[i];
+		}
+		if (!plane_state)
+			return;
+		/* find pipe that contains plane with highest layer index */
+		for (i = 0; i < MAX_PIPES; i++) {
+			struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+			if (pipe->plane_state == plane_state) {
+				memcpy(color, &pipe->visual_confirm_color, sizeof(struct tg_color));
+				return;
+			}
+		}
+	}
+}
+
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 {
 	int i, j;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 78dd4d1f51dc..be2518e07c14 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2590,6 +2590,11 @@ unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *context);
 /* DSC Interfaces */
 #include "dc_dsc.h"
 
+void dc_get_visual_confirm_for_stream(
+	struct dc *dc,
+	struct dc_stream_state *stream_state,
+	struct tg_color *color);
+
 /* Disable acc mode Interfaces */
 void dc_disable_accelerated_mode(struct dc *dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 912f96323ed6..e34a93b703a7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2664,7 +2664,6 @@ void dcn10_update_visual_confirm_color(struct dc *dc,
 	struct mpc *mpc = dc->res_pool->mpc;
 
 	if (mpc->funcs->set_bg_color) {
-		memcpy(&pipe_ctx->plane_state->visual_confirm_color, &(pipe_ctx->visual_confirm_color), sizeof(struct tg_color));
 		mpc->funcs->set_bg_color(mpc, &(pipe_ctx->visual_confirm_color), mpcc_id);
 	}
 }
-- 
2.49.0

