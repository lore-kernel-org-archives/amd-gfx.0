Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A664C83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 07:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4CE10E1D8;
	Thu, 24 Jul 2025 07:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OyER3n89";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D4C10E1D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 07:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MksvjTG9rCypwlJYCnC+rHzTGu7RPDZ/4RE0Hsdfm7VFbO41olAWF60wIWvb9c80s1Pqy7n/2q0WlC8ntb65QqXz7x7WOJ6jlkL7WmyJEaZ6N4zhYfsj5Q1GKR3J0LEYQAR5+knu2E+9luaVhdqaHuHSQuaRPjKX0qCgVVe2adzkkzg9TFuf04FfHw8ybsNSuQydcDS7vPWbsbX0JvC8VeqgZv+g/d2DFkVGWwnhgBQfV5EqpbCU8JOwwsxehJ9cKKJVoshsfwLStmRlUhMl43oqQ7JievX4d/hr+rkeQZAfx3oJxHDHq1IVhkpjgfDR9fUUZfYJ8fn4ZFSbiGwv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdQtQ5ipS2vCoR7StplXAub8Bi5n55/TDX26+LZM/7I=;
 b=bi1yx7bPmhIlc5rYwhCyRiBJx0Jgjz9DF/FjT2qELYwxhl8bqpKMP5OEopa+rPWakPf+kdf9hUCosVg/LNZxfECW6thLEsJ10ga1f2VVW5j/J0e8/6BtLaKU5kVriCpeh5bSGsGeHL9N54ahm5SqDtpwFOGcorz7RNWXZaNAxFNXC47Ed4MU4bm1yMkE8dG8+h81IjoMSATmvj9iQRCSrfFJjxP/6jaACzfKoTX70XcvdVhFaPJu8aa058N066myAfZYfkdu+ZIwnZe1bMLkvKMFWAM9TuvDn2u0BrvoLvhVUnVMT3kJ5mDOwxjYwDiPyBGvu8b2RJIXB0oPt9/4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdQtQ5ipS2vCoR7StplXAub8Bi5n55/TDX26+LZM/7I=;
 b=OyER3n89upL9s+zK3fvG+hscBZh3peGgaHbdxD40RJWuAPv+PrL0p4agwR+PIfPrvy+5AHWrHjU0PklMD5N+jQDe63YYxlHorIp0YWupHeG0/PnefxVNe1n9yr98eEapkpOSPVgRUsIbeamNMAloZJaOCi83wgvcwkRyHwJ9Qzc=
Received: from BN9PR03CA0947.namprd03.prod.outlook.com (2603:10b6:408:108::22)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 07:48:51 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::10) by BN9PR03CA0947.outlook.office365.com
 (2603:10b6:408:108::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Thu,
 24 Jul 2025 07:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.1 via Frontend Transport; Thu, 24 Jul 2025 07:48:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 02:48:47 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Michael Strauss <michael.strauss@amd.com>, Alex Hung
 <alex.hung@amd.com>, George Shen <george.shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wayne Lin <wayne.lin@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>, Ray Wu <ray.wu@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
Subject: [PATCH] drm/amd/display: Reduce Stack Usage by moving 'audio_output'
 into 'stream_res'
Date: Thu, 24 Jul 2025 13:18:33 +0530
Message-ID: <20250724074833.1385215-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: c05529d4-f469-4b78-1ff0-08ddca8687c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JRH/o1bnkBgfPz6b3epKUTX3fAivrYpcd5wrIrPK1b3Z5BIxyO1F3c/446Jx?=
 =?us-ascii?Q?3g+wSuN0+zrYsGIluYub1roVkDBxfHDPdmN+9uzLO8zIUeztnW+Wt7srCJlM?=
 =?us-ascii?Q?Yt4pcG7R/cF4VcfhSFxDOVOddSqCkwyQkojBYpJ3FCwux8btMX+X3JWXSI9I?=
 =?us-ascii?Q?OsW2wtAGwcAWYuDrtLoIDNUakLzDZgycxWwdzAIQcRWyIJIsXf9LPtLPGM4c?=
 =?us-ascii?Q?3hL+8s1Z6WJZIHBz8HDRwwilk2Pm7ckf0xuPcVgz2wrMvGU18xQgVN8eUhGV?=
 =?us-ascii?Q?IRs0CQ4U+JqQDXFPMvZnBcrko0MdhQzKE3eunqF1AisAODj+h5jFS4QHwHW2?=
 =?us-ascii?Q?ZRYWtownQTlKQ2s/+Ca4zczONZnUChQ219Cp+DMjk6JFKcTho1pK8upmoKLr?=
 =?us-ascii?Q?AWmuAlKBH5h23Y2VScWaw/vO3hggNnzwdW7yNkWbUJnm42D8Mw4I1oANdKJj?=
 =?us-ascii?Q?rnLYZo5mGQd62ZJfiukeDaiiwbpr+cQ09ydDc9HGz4mM4cqWfIL3zGtPAmnT?=
 =?us-ascii?Q?5Sfvjoo/pkjo5jSsnGOWqyU1u+f5u1ZFLuebgH7NNz3M+cO/GdNH3AzvC++9?=
 =?us-ascii?Q?Vlk4vbXc6AxkJ5Fvzjp0BOYNbwocL8kCrcPJkqzBnk05AA0L7q/M8DVbOOWm?=
 =?us-ascii?Q?q+F9Pg/Zir2pVp2nqZdAt24JXVT+NCL/GvZZduc/7SY3wIaXOZ1tNgCgpTlx?=
 =?us-ascii?Q?vz9j1bpBFukmQh9aaPAcx0pgQzDi6kJCn94AGgMdphiuRxT5NyjgdJm0uH+D?=
 =?us-ascii?Q?TXsEPwq6QQ7Ulm8WYJKCFz7gxP7gkI8IcE+UuP7aigrn3oiXofaFGyKAExAf?=
 =?us-ascii?Q?2k0KYp5Z83+726CgUOa8X0VnfBYioofl0tkcXjtWszn5Kp661PgUdIXUb0f/?=
 =?us-ascii?Q?F2GHkOcfds/dxscOyyxDvX8jTkMP3KtD5lAKjJ21oi+wHlPWiLDPreYSD1Se?=
 =?us-ascii?Q?wPucQcjPH6C+svskET3EkOvZuspYPIRHfGF9HpaAkcfqToVmJ0TRIaDeDg/G?=
 =?us-ascii?Q?5DQGWM8tGbZ2jmTRLGpmxQ1zGnxvOzCMDMeuq86HWIApfn1KNuSvISXmQFyh?=
 =?us-ascii?Q?hGRnkhOIx5lK+LNBPI1pJoWHRPeuc46RgVHxGVIXZq4GbotmPei8vnDfztG3?=
 =?us-ascii?Q?Pn0W9b6W94YfILPuNqMYv7LSbTm3yNtiL2K8eClo5yyt8+cbh3N+VL2fFCs+?=
 =?us-ascii?Q?pyiuiiQyEh5ksrqMhALwp2wlU5XDixTO5hqG2/VOt/E5Sbuo8puW8bwmvz/y?=
 =?us-ascii?Q?Z1nuBdr8LY+nXqIxIImaTKqYs5Xk2plvzHFZuf9Txh0vu7RGTSakTNWN57KZ?=
 =?us-ascii?Q?IXEryD37io5beI8DxKGj4nJ8owTBLvAyrpviNjsW961KPPn6iKS8gq5SJJlJ?=
 =?us-ascii?Q?qM0lRfaEs7zp/nx0ZrHfKlzoSCm0CsLsdNu+g1vkQHFZwkVfSxR7PpLz09ys?=
 =?us-ascii?Q?GAiMXxoc2UPN8FS/jR5zRv/xb44qVYEepEKftccuaLwq7Uh74gVv4I0+LHDh?=
 =?us-ascii?Q?FIXXYhZ4iUlOII5f1gMhO+T/6w56H3LRQIO1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:48:50.8526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c05529d4-f469-4b78-1ff0-08ddca8687c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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

The function `dp_retrain_link_dp_test` currently allocates a large
audio_output array on the stack, causing the stack frame size to exceed
the compiler limit (1080 bytes > 1024 bytes).

This change prevents stack overflow issues:
amdgpu/../display/dc/link/accessories/link_dp_cts.c:65:13: warning: stack frame size (1080) exceeds limit (1024) in 'dp_retrain_link_dp_test' [-Wframe-larger-than]
static void dp_retrain_link_dp_test(struct dc_link *link,

v2: Move audio-related data like `audio_output` is kept "per pipe" to
    manage the audio for that specific display pipeline/display output path
    (stream). (Wenjing)

'Fixes: 9437059b4bfb ("drm/amd/display: Fix Link Override Sequencing When
Switching Between DIO/HPO")'
Cc: Wayne Lin <wayne.lin@amd.com>
Cc: George Shen <george.shen@amd.com>
Cc: Michael Strauss <michael.strauss@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/core_types.h      |  5 +++--
 .../amd/display/dc/link/accessories/link_dp_cts.c    | 12 ++++++------
 .../amd/display/dc/resource/dcn31/dcn31_resource.c   |  5 ++---
 .../amd/display/dc/resource/dcn31/dcn31_resource.h   |  3 +--
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index f0d7185153b2..f896cce87b8d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -228,8 +228,7 @@ struct resource_funcs {
 	enum dc_status (*update_dc_state_for_encoder_switch)(struct dc_link *link,
 		struct dc_link_settings *link_setting,
 		uint8_t pipe_count,
-		struct pipe_ctx *pipes,
-		struct audio_output *audio_output);
+		struct pipe_ctx *pipes);
 };
 
 struct audio_support{
@@ -361,6 +360,8 @@ struct stream_resource {
 	uint8_t gsl_group;
 
 	struct test_pattern_params test_pattern_params;
+
+	struct audio_output audio_output;
 };
 
 struct plane_resource {
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 2956c2b3ad1a..b12d61701d4d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -75,7 +75,6 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	bool is_hpo_acquired;
 	uint8_t count;
 	int i;
-	struct audio_output audio_output[MAX_PIPES];
 
 	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
 	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
@@ -99,7 +98,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	if (needs_divider_update && link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
 		link->dc->res_pool->funcs->update_dc_state_for_encoder_switch(link,
 				link_setting, count,
-				*pipes, &audio_output[0]);
+				*pipes);
 		for (i = 0; i < count; i++) {
 			pipes[i]->clock_source->funcs->program_pix_clk(
 					pipes[i]->clock_source,
@@ -111,15 +110,16 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 				const struct link_hwss *link_hwss = get_link_hwss(
 					link, &pipes[i]->link_res);
 
-				link_hwss->setup_audio_output(pipes[i], &audio_output[i],
-						pipes[i]->stream_res.audio->inst);
+				link_hwss->setup_audio_output(pipes[i],
+							      &pipes[i]->stream_res.audio_output,
+							      pipes[i]->stream_res.audio->inst);
 
 				pipes[i]->stream_res.audio->funcs->az_configure(
 						pipes[i]->stream_res.audio,
 						pipes[i]->stream->signal,
-						&audio_output[i].crtc_info,
+						&pipes[i]->stream_res.audio_output.crtc_info,
 						&pipes[i]->stream->audio_info,
-						&audio_output[i].dp_link_info);
+						&pipes[i]->stream_res.audio_output.dp_link_info);
 
 				if (link->dc->config.disable_hbr_audio_dp2 &&
 						pipes[i]->stream_res.audio->funcs->az_disable_hbr_audio &&
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 3ed7f50554e2..ca17e5d8fdc2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -2239,8 +2239,7 @@ struct resource_pool *dcn31_create_resource_pool(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 	struct dc_link_settings *link_setting,
 	uint8_t pipe_count,
-	struct pipe_ctx *pipes,
-	struct audio_output *audio_output)
+	struct pipe_ctx *pipes)
 {
 	struct dc_state *state = link->dc->current_state;
 	int i;
@@ -2255,7 +2254,7 @@ enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 
 		// Setup audio
 		if (pipes[i].stream_res.audio != NULL)
-			build_audio_output(state, &pipes[i], &audio_output[i]);
+			build_audio_output(state, &pipes[i], &pipes[i].stream_res.audio_output);
 	}
 #else
 	/* This DCN requires rate divider updates and audio reprogramming to allow DP1<-->DP2 link rate switching,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
index c32c85ef0ba4..7e8fde65528f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
@@ -69,8 +69,7 @@ unsigned int dcn31_get_det_buffer_size(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 	struct dc_link_settings *link_setting,
 	uint8_t pipe_count,
-	struct pipe_ctx *pipes,
-	struct audio_output *audio_output);
+	struct pipe_ctx *pipes);
 
 /*temp: B0 specific before switch to dcn313 headers*/
 #ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL
-- 
2.34.1

