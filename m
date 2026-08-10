Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847F2C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E54710EC8A;
	Tue, 11 Aug 2026 15:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZrtcToel";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23ED10EC8A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA2ZsG8YwpDYUQ3+lkiYbN94mhcJhuKi8LK/rdJLvI7yTC8k3OldcsrIocoGmwjGiLoSfiBzWe8O8qBTitrJgCVeCBeVU1Tck8XYGDZ95P4W6WZ/MeTa15pgDuPJUbcViOBE9x69dl6KcQEn0niHxC97sjS9sTx3MGdc4+3MHUGg/hNrtAfrfmX7hFfDKSbvKJJ8IstS9aNpRjZXm9SzCGqKq6rvUBSRN8dYbRiD7zHgwXDACjce6PTDB3vywyK41pHPjrYQDmz+wWkOCSs0PKg4lz9K1oEGfWQo5vHrvDu97WWhObJ01ExR/mzRJsywfNaWi6AbJAHopgSK79D3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GND8RluGtboeo6kjpEyBUA0RpLNB+ma+heg2bdAJUZM=;
 b=H2cMeQmxr4V0gayY2sHVXHU1zEdxfB6LUDD3+RC33WpZAnjq9swicHapx98aycHn3biyPZvlYOjIBi3j5ZbrN06OsjHgEVtS9Yw7XWzn+B7rO9TDfFi6iKHPYxDVb7b+JyPQIEIeg2sHIo3Cm+UV6iuYP//GbMuTEj31k95GudHqeqNhQFJnsahvc+zGHvzvHNUBghPOMP/0Bn3GlmzbKnmvXEGI2/NaeUOOAFSeRTlD7BcJyHcd+NkNX/VRJZe3AoLW/gZMsgZp7Q8fBMBGU8++ZV4WyPVtyyr0JMWaN/+vBGJPuhANNltcA01sf13jiZmZzBqeYuhPb7nnXpKZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GND8RluGtboeo6kjpEyBUA0RpLNB+ma+heg2bdAJUZM=;
 b=ZrtcToellzNO21mjjvMmCk2LU6/9QYc4nyw0jGFgljvAMe+frHQnm1La6y7LfMmLgvyy7AVWD3ufsreR/4lw2oLJfp4lxhLS8uBsZwMYnWsr4x96SAdvXrehETRT9HBktVs4+qcabcXl4wleCsXAGVOsZCTbvmOYbSfPggDlBCw=
Received: from BN9PR03CA0721.namprd03.prod.outlook.com (2603:10b6:408:110::6)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 15:50:01 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::33) by BN9PR03CA0721.outlook.office365.com
 (2603:10b6:408:110::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 15:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:50:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:49:59 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:49:50 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 12/24] drm/amd/display: Use mpcc_id instead of hubp instance
Date: Tue, 11 Aug 2026 05:28:46 +0800
Message-ID: <20260810213010.1703162-13-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: a391f70f-e4d1-49df-b286-08def7c033df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|11063799006|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MAkDDt6cTnXL14L97Nbm2LGSq3VbnF+sa5lChjhBzsszw4eaIQFPU967MEIIRzgdtVnkdU3DSAkraT5IjkT3S4Vqjf/eJ/t8VB6fRKDKV0w26owB3JaICqqjoCMVdbMahDlCPAB2vzzWwfQghPXrKxcmQ4qidzbwKpDELPUgAWYuhE5Ko8BSR5wzvFJ8shIn6bGzTB39s27h5a9vX5ZVSB4bO+BNA7+YWg1b3ANCDrJHeFZlz7Vrb41fwt4AWJNJs4MBYC8/QJfTuMqq95bV+F70o8wp84PN1pPxBghBs11OpMvwqiqk7GWKBsC4cN/GNfC0NKJCxAWZR6mTukqc1exAV8RRNRzP42nM/WTZ8uHEQaGYcgP3DIhLkHgNkCzCVCzYhkxJYbYNFCNw5551DE5ehizdqf6Xav7p2lF4nl86lMvqrlPUkp8eX3iji8WGoM2KB+yzerkx9tDK/KV9wPmvd68sETHhFGF96RmTbGE04ngvsIGEJ2J6ebdtImPNiQQBCCp4y2RsGhIa+bAazsPjxklEcIk4aO3G8J+KMwUop3VC01aKPjv4WSQuUQLWu6YDA0miq8AKsCvc07Pph5BSZCc7idV1kXDZ6daG342zuUL1gGgOnXb3OZXO0cZ9yfzGADCDfibq7oqYQZqLnGddIWV+9L+o0/kNb7weOJyzr70ChX3L5ug21pmExC4kosHZ42UZhRrD4Qd2mQSfrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MCucsT64usPk/cQIoHP+UO8+M6OU3U3fO00UbZftuw8wqvfu+/bjfRrP0SyH+jdf5C2U7hkity+iFu4yfLImQUrnSusZvUgW3GTedp4DtnJdZKwwQ+qlte8A8WJ7TJTYxxR9bfY1FOJ8pJCxDfeCsBxbU07lUwmHIx6BaKdao3p6+OSkjJ+Wbv6eBKvyKlEU58DvGsYWD6X9A/ibWmkBSBNGxO3POHzxhWvMQqX+DMaQzyk37XSaXqYbSkTx2YgzlQICL5NDzPpKFDac9VYOmaCnYB+2frwHJFK2g/8v/63uAl6tM0gik+u/Ionh2frh5cZA0la90alSIPoZIXnRSJGbB8WXedwoQO5ib21Ys9loS0K3XACAFm3EMIcletFm463s98h3iJwPJ+ZFMu6GOFQwTBeZxdV0NVpZivYQt4hQzN0fIzlBO61zxdKxmUgK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:50:00.8873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a391f70f-e4d1-49df-b286-08def7c033df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

From: Tomasz Siemek <tomasz.siemek@amd.com>

[why]
Hubp pointer is not initialized for older asics.

[how]
Use mpcc_id field from plane resources instead of instance number
by dereferencing hupb pointer.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c   | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index a8ff59f619c5..b3f3f7362663 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1537,7 +1537,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 					params->dpp = current_mpc_pipe->plane_res.dpp;
 					params->mpc = dc->res_pool->mpc;
 					params->xfm = current_mpc_pipe->plane_res.xfm;
-					params->mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+					params->mpcc_id = current_mpc_pipe->plane_res.mpcc_inst;
 					params->plane = current_mpc_pipe->plane_state;
 					params->stream = current_mpc_pipe->stream;
 					params->is_top_pipe = current_mpc_pipe->top_pipe == NULL;
@@ -1582,7 +1582,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 				otf_params->dpp = current_mpc_pipe->plane_res.dpp;
 				otf_params->xfm = current_mpc_pipe->plane_res.xfm;
 				otf_params->mpc = dc->res_pool->mpc;
-				otf_params->mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+				otf_params->mpcc_id = current_mpc_pipe->plane_res.mpcc_inst;
 				otf_params->is_top_pipe = resource_is_pipe_type(current_mpc_pipe, OPP_HEAD);
 				otf_params->stream = current_mpc_pipe->stream;
 				block_sequence[*num_steps].func = DPP_SET_OUTPUT_TRANSFER_FUNC;
@@ -2306,7 +2306,7 @@ void hwss_add_dpp_program_gamut_remap(struct block_sequence_state *seq_state,
 		params->xfm = pipe_ctx->plane_res.xfm;
 		params->dpp = pipe_ctx->plane_res.dpp;
 		params->mpc = pipe_ctx->stream->ctx->dc->res_pool->mpc;
-		params->mpcc_id = pipe_ctx->plane_res.hubp->inst;
+		params->mpcc_id = pipe_ctx->plane_res.mpcc_inst;
 		params->plane = pipe_ctx->plane_state;
 		params->stream = pipe_ctx->stream;
 		params->is_top_pipe = pipe_ctx->top_pipe == NULL;
@@ -2352,7 +2352,7 @@ void hwss_add_dpp_set_output_transfer_func(struct block_sequence_state *seq_stat
 			.xfm = pipe_ctx->plane_res.xfm,
 			.dpp = pipe_ctx->plane_res.dpp,
 			.mpc = dc->res_pool->mpc,
-			.mpcc_id = pipe_ctx->plane_res.hubp->inst,
+			.mpcc_id = pipe_ctx->plane_res.mpcc_inst,
 			.is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD),
 			.stream = pipe_ctx->stream,
 		};
@@ -2369,8 +2369,7 @@ void hwss_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx)
 				.xfm = pipe_ctx->plane_res.xfm,
 				.dpp = pipe_ctx->plane_res.dpp,
 				.mpc = dc->res_pool->mpc,
-				.mpcc_id = pipe_ctx->plane_res.hubp ?
-						pipe_ctx->plane_res.hubp->inst : 0,
+				.mpcc_id = pipe_ctx->plane_res.mpcc_inst,
 				.is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD),
 				.stream = pipe_ctx->stream,
 			}
@@ -4317,7 +4316,7 @@ void hwss_program_gamut_remap(struct pipe_ctx *pipe_ctx)
 			.xfm = pipe_ctx->plane_res.xfm,
 			.dpp = pipe_ctx->plane_res.dpp,
 			.mpc = dc->res_pool->mpc,
-			.mpcc_id = pipe_ctx->plane_res.hubp->inst,
+			.mpcc_id = pipe_ctx->plane_res.mpcc_inst,
 			.stream = pipe_ctx->stream,
 			.plane = pipe_ctx->plane_state,
 			.is_top_pipe = pipe_ctx->top_pipe == NULL,
-- 
2.43.0

