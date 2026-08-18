Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66DDC5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744DE10ECF1;
	Tue, 18 Aug 2026 20:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n7wJO+yQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD71B10EC87
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1wvvfwpHU71r0nAVrOqtYoIvXKUjLCAAT9PSwZuYjwsdt0gsCUnylzUB1cCuJ4Is92OlGMZFsf3kH5hD0BrO69kzwD5xdhkTpiR8+by7jSstctk9XzNjXc+kSzLufZxqW8f3H1mxxzucaBr6tG9v5Pzj6+JXVZeDQHchXhLSvXEWtJ9VV2iTbzK0Rv3PoMXXd44o9zt5o1ZDo0VAkK25Q43OEG2PQCNoWRiIXIj8YHd/F6PSTPQTlfJ9obbObreVZwpdPRO6Q+4Bj/koU+N2UKeI4ChspaopEJ8QwLayDDxOS0On0dck6IdU3qXMOGWp2I+Is/YPgynyroakItWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCNd2jJH6MzAl2twAfA5tvUyHdynByiyaAVahuCxC/w=;
 b=VLKs4l1cX3rzDUSA/TRrL2Vqb7hVmaNePW5jREslB3P5MJPmOdbj1qxBxpg6nNdZhh7KjfFE4NNAaHtWWSJEaBTzE/alL2NZt0gxp9H4w4C8SWWsHczSTqqbLbjJtx/2qFwg8UuxcJDZGcjlZDOrNjyTv/8WrZJp4Dk0WRmZNhkgGt8H767zaT+QsRbcvFQKRvCuxLQc2UvaKlR1VNIOkFca87IZ2ZtOL1ejHDpOeLDlI6hThSQfBHshfeAHUd5JggHB5y9K1aAXjJ9d4FvP0Roz7pQPvbXoMMao2yKIvd0+rayoipT1BzdXu/c3BZ8IyZWFotlQkswloRQlWe2mnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCNd2jJH6MzAl2twAfA5tvUyHdynByiyaAVahuCxC/w=;
 b=n7wJO+yQ+IjQd8/o2zFq8A0akfreV2OMV4ax5vE4hPGeJgI/M93mm75sefOP58zrt6AO97NP17dMMZ3I4VWCQWneAyzvvvJ1x887iirT4XcwbQ+424u1p24pdzfRX9ZYxTKk4HcIw4ZOdR8U0MmC1O+hFFEKpjx0+hxLdFxFris=
Received: from IA1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::12)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:20 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::a3) by IA1P220CA0011.outlook.office365.com
 (2603:10b6:208:461::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:57 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:21:56 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 05/82] drm/amd/display: Split OPTC_PIPE_CONTROL_LOCK into
 smaller HWSS blocks
Date: Tue, 18 Aug 2026 16:14:57 -0400
Message-ID: <20260818202139.4172592-6-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c1844d-104d-482c-d841-08defd666792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1PUki5EV0YVVVcxDEvx7fQi1U3qJRjkApXE3W9ZxSsoUGhk/VzxqMXvD65bo6EcbGvrppvWfL0BzbgvGueH/OyZZ7fga6bJxMNpQVM3wjp+kYkAbLodylopu3sqfG26B3NgRgvA0EBYT14LdgxSdrHxeAlzdyYZigWNimAVBtgQmo+KbROKioz/GDkHnyDT9vFbmZavEFDH84sGs6HGO7HS/+HZncWIR7S15DVkmZB/G/FvSl+y3Wt7OyTZIgY3qY2KKiZrSS1d819GWgBi1A7yHouYT2EZ0uKrRazLS8I9+vf5bla3SfBwhNe+IXFmHx0XalFhtzjQvoqG2bMFFQn/Cxetqg1rAhRsgM4H45OIJMkKYRhh1ev+IqJOJnxpJgl4YqLsbr0ehenno2LHHT1jVHdFRkDd398FDkh0KisHt7foGAN00q+OAsthucqSbmCj5C4VBmROFwuroPm+mRzUFKBCTKZMrb3ywE6cwILc/R5uXl1ibBg6m80Q7EKNq9xU2738DFzxOk0v3muDB0Y33VQS5nazTNFqzNmaRX1BwbuzucMtiEnUVuyKN5V57Gs3U6Iji0a2wQ8zSTx7cYpvzofTLI2PmE68g6dSgPEibHoZu8uUQGEHuhmX7IH7CgptuMcJIahhDDrtAZBwwn93VSL7q/HPRrLqQ/6VXQN3/UiCsp6cJuafICEPtM1584ukfts5xwrAk9XsIfpryow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kpq1YD+xIaw2RZ3h13UoGcX/wL7mrLezxrUouoNuDt3P3I6d5NOL/Xyj8C7BU3dCjngdYWU5chHeEPMCj7s7hVeRx8Yq1bNevNuZYVnmqJnzEkCWIG1j6BJmEchKKbCCqqZ6PoTYqtoIQrGEkgi4m2CA3cfYWQ8mcAngNMhbN3XJ9UAqnlnOqYgUfV4bjVQ6Z31v50qMOOVoXEUAfpnVxfVZH1eICgld07NyvaCzhk8bKFN7X1sGzd+2bpEipbVVkR+miSB+mFhE+vnIGwiUt7N6+1wmweqt26t4XhWIQuSbJzMrJDoXXxqmLrmB/FEKIxy2Wz8ejP8/alEMXeTsteJNymuF0axAYL6r5d3IZPzRtdHZl9wI9sBb9hxUEM/aUslTMHSvkLLt7iw+wewpXVGBCo9ARWMulYb4sSbNbEAdXVllK9bggQPII097gopa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:19.8899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c1844d-104d-482c-d841-08defd666792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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
Block level sequence operations should not use global state structs such
as pipe_ctx. OPTC_PIPE_CONTROL_LOCK is a BLS with complex logic
dispatching a lot of smaller hardware programming operations.
BLS should be a simple and atomic hardware operation without performing
mutations or having an access to global state. All operations on global
state should be moved to build step in HWSS.

[how]
- Split OPTC_PIPE_CONTROL_LOCK into substeps:
	- HUBP_WAIT_FLIP_PENDING,
	- TG_SET_GSL,
	- TG_SET_GSL_SOURCE_SELECT,
	- TG_LOCK,
	- TG_3DLUT_WA_UNLOCK.
- Add hwss_pipe_control_lock - for in place build + execution.
- Remove timeout from HUBP_WAIT_FOR_FLIP_PENDING.
- Move software logic to builder. which fills pipe_control_lock_params
  containing data for programming actual hwss blocks.
- Due to differences in what pipe control lock means bettween
  asics following builder variants are added:
	- dce_build_pipe_control_lock_sequence for asics pre DCN20,
	- dcn20_build_pipe_control_lock_sequence.
- Rework gsl group programming to use builder / executor pattern.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 125 ++++++++++----
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.c   |  46 ++++--
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |  12 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dce60/dce60_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dce80/dce80_hwseq.c   |   3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  31 ++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   5 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |   4 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 153 +++++++++++-------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |  14 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |   3 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  34 ++--
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.h |   5 +-
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |   4 +-
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |   3 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   3 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   3 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 140 ++++------------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   3 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   3 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  43 +++--
 .../display/dc/hwss/hw_sequencer_private.h    |   3 +-
 32 files changed, 367 insertions(+), 316 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6f7b715d4717e..3c6936943960d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1221,7 +1221,7 @@ static void apply_ctx_interdependent_lock(struct dc *dc,
 			if (stream == pipe_ctx->stream) {
 				if (resource_is_pipe_type(pipe_ctx, OPP_HEAD) &&
 					(pipe_ctx->plane_state || old_pipe_ctx->plane_state))
-					dc->hwss.pipe_control_lock(dc, pipe_ctx, lock);
+					hwss_pipe_control_lock(dc, pipe_ctx, lock);
 			}
 		}
 	}
@@ -4991,7 +4991,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		 *  plane addr update event triggers to be synchronized.
 		 *  top_pipe_to_program is expected to never be NULL
 		 */
-		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
+		hwss_pipe_control_lock(dc, top_pipe_to_program, true);
 	}
 
 	dc_dmub_update_dirty_rect(dc, surface_count, stream, srf_updates, context);
@@ -5013,7 +5013,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 			dc->hwss.interdependent_update_lock(dc, context, false);
 		} else {
-			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+			hwss_pipe_control_lock(dc, top_pipe_to_program, false);
 		}
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
@@ -5200,7 +5200,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		dc->hwss.interdependent_update_lock(dc, context, false);
 	} else {
-		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+		hwss_pipe_control_lock(dc, top_pipe_to_program, false);
 	}
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index d61c4d9488c59..8b723c3ca933d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1051,7 +1051,7 @@ void hwss_build_post_unlock_full_sequence(struct dc *dc,
 
 			unsigned int polling_interval_us;
 				polling_interval_us = 1;
-			hwss_add_hubp_wait_flip_pending(&seq_state, pipe->plane_res.hubp, 100000, polling_interval_us);
+			hwss_add_hubp_wait_flip_pending(&seq_state, pipe->plane_res.hubp, polling_interval_us);
 		}
 	}
 
@@ -1212,13 +1212,9 @@ void hwss_build_fast_sequence(struct dc *dc,
 		block_sequence[*num_steps].func = DMUB_HW_CONTROL_LOCK_FAST;
 		(*num_steps)++;
 	}
-	if (dc->hwss.pipe_control_lock) {
-		block_sequence[*num_steps].params.pipe_control_lock_params.dc = dc;
-		block_sequence[*num_steps].params.pipe_control_lock_params.lock = true;
-		block_sequence[*num_steps].params.pipe_control_lock_params.pipe_ctx = pipe_ctx;
-		block_sequence[*num_steps].func = OPTC_PIPE_CONTROL_LOCK;
-		(*num_steps)++;
-	}
+	hwss_add_optc_pipe_control_lock(
+			&(struct block_sequence_state){ block_sequence, num_steps },
+			dc, pipe_ctx, true);
 
 	for (i = 0; i < dmub_cmd_count; i++) {
 		block_sequence[*num_steps].params.send_dmcub_cmd_params.ctx = dc->ctx;
@@ -1646,13 +1642,9 @@ void hwss_build_fast_sequence(struct dc *dc,
 		current_pipe = current_pipe->next_odm_pipe;
 	}
 
-	if (dc->hwss.pipe_control_lock) {
-		block_sequence[*num_steps].params.pipe_control_lock_params.dc = dc;
-		block_sequence[*num_steps].params.pipe_control_lock_params.lock = false;
-		block_sequence[*num_steps].params.pipe_control_lock_params.pipe_ctx = pipe_ctx;
-		block_sequence[*num_steps].func = OPTC_PIPE_CONTROL_LOCK;
-		(*num_steps)++;
-	}
+	hwss_add_optc_pipe_control_lock(
+			&(struct block_sequence_state){ block_sequence, num_steps },
+			dc, pipe_ctx, false);
 	if (dc->hwss.subvp_pipe_control_lock_fast) {
 		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.dc = dc;
 		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.lock = false;
@@ -1710,10 +1702,14 @@ void hwss_execute_sequence(struct dc *dc,
 		case DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST:
 			dc->hwss.subvp_pipe_control_lock_fast(params);
 			break;
-		case OPTC_PIPE_CONTROL_LOCK:
-			dc->hwss.pipe_control_lock(params->pipe_control_lock_params.dc,
-					params->pipe_control_lock_params.pipe_ctx,
-					params->pipe_control_lock_params.lock);
+		case TG_LOCK:
+			dc->hwss.tg_lock(&params->tg_lock_params);
+			break;
+		case TG_3DLUT_WA_UNLOCK:
+			if (dc->hwseq->funcs.perform_3dlut_wa_unlock)
+				dc->hwseq->funcs.perform_3dlut_wa_unlock(
+						params->tg_3dlut_wa_unlock_params.tg,
+						params->tg_3dlut_wa_unlock_params.hubp);
 			break;
 		case HUBP_SET_FLIP_CONTROL_GSL:
 			params->set_flip_control_gsl_params.hubp->funcs->hubp_set_flip_control_surface_gsl(
@@ -1925,7 +1921,8 @@ void hwss_execute_sequence(struct dc *dc,
 			hwss_tg_set_gsl_source_select(params);
 			break;
 		case HUBP_WAIT_FLIP_PENDING:
-			hwss_hubp_wait_flip_pending(params);
+			hwss_hubp_wait_flip_pending(params->hubp_wait_flip_pending_params.hubp,
+				params->hubp_wait_flip_pending_params.polling_interval_us);
 			break;
 		case TG_WAIT_DOUBLE_BUFFER_PENDING:
 			hwss_tg_wait_double_buffer_pending(params);
@@ -2234,23 +2231,85 @@ void hwss_execute_sequence(struct dc *dc,
 	}
 }
 
-/*
- * Helper function to add OPTC pipe control lock to block sequence
- */
 void hwss_add_optc_pipe_control_lock(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		bool lock)
 {
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.pipe_control_lock_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.pipe_control_lock_params.pipe_ctx = pipe_ctx;
-		seq_state->steps[*seq_state->num_steps].params.pipe_control_lock_params.lock = lock;
-		seq_state->steps[*seq_state->num_steps].func = OPTC_PIPE_CONTROL_LOCK;
-		(*seq_state->num_steps)++;
+	struct pipe_control_lock_params params = { 0 };
+	unsigned int hubp_idx;
+	unsigned int polling_interval_us = 1;
+
+	if (!dc->hwss.build_pipe_control_lock_sequence ||
+			!dc->hwss.build_pipe_control_lock_sequence(dc, pipe_ctx, lock, &params))
+		return;
+
+	for (hubp_idx = 0; hubp_idx < MAX_PIPES; hubp_idx++)
+		if (params.hubps_to_wait_for_flip[hubp_idx])
+			hwss_add_hubp_wait_flip_pending(seq_state, params.hubps_to_wait_for_flip[hubp_idx],
+				polling_interval_us);
+
+	if (params.gsl_lock) {
+		hwss_add_tg_set_gsl(seq_state, params.gsl.tg, params.gsl.gsl);
+		hwss_add_tg_set_gsl_source_select(seq_state, params.gsl_source_select.tg,
+			params.gsl_source_select.group_idx, params.gsl_source_select.gsl_ready_signal);
+	}
+
+	if (params.tg_3dlut_wa_unlock) {
+		if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+			seq_state->steps[*seq_state->num_steps].params.tg_3dlut_wa_unlock_params =
+					params.tg_3dlut_wa_unlock_params;
+			seq_state->steps[*seq_state->num_steps].func = TG_3DLUT_WA_UNLOCK;
+			(*seq_state->num_steps)++;
+		}
+	} else {
+		if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+			seq_state->steps[*seq_state->num_steps].params.tg_lock_params = params.tg_lock;
+			seq_state->steps[*seq_state->num_steps].func = TG_LOCK;
+			(*seq_state->num_steps)++;
+		}
 	}
 }
 
+void hwss_pipe_control_lock(struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool lock)
+{
+	struct pipe_control_lock_params params = { 0 };
+	unsigned int hubp_idx;
+	unsigned int polling_interval_us = 1;
+
+	if (!dc->hwss.build_pipe_control_lock_sequence ||
+			!dc->hwss.build_pipe_control_lock_sequence(dc, pipe_ctx, lock, &params))
+		return;
+
+	for (hubp_idx = 0; hubp_idx < MAX_PIPES; hubp_idx++)
+		if (params.hubps_to_wait_for_flip[hubp_idx])
+			hwss_hubp_wait_flip_pending(
+					params.hubps_to_wait_for_flip[hubp_idx],
+					polling_interval_us);
+
+	if (params.gsl_lock) {
+		if (params.gsl.tg->funcs->set_gsl)
+			params.gsl.tg->funcs->set_gsl(params.gsl.tg, &params.gsl.gsl);
+		if (params.gsl_source_select.tg->funcs->set_gsl_source_select)
+			params.gsl_source_select.tg->funcs->set_gsl_source_select(
+					params.gsl_source_select.tg,
+					params.gsl_source_select.group_idx,
+					params.gsl_source_select.gsl_ready_signal);
+	}
+
+	if (params.tg_3dlut_wa_unlock) {
+		dc->hwseq->funcs.perform_3dlut_wa_unlock(
+				params.tg_3dlut_wa_unlock_params.tg,
+				params.tg_3dlut_wa_unlock_params.hubp);
+		return;
+	}
+
+	if (dc->hwss.tg_lock)
+		dc->hwss.tg_lock(&params.tg_lock);
+}
+
 /*
  * Helper function to add HUBP set flip control GSL to block sequence
  */
@@ -2853,12 +2912,10 @@ void hwss_add_tg_enable_crtc(struct block_sequence_state *seq_state,
  */
 void hwss_add_hubp_wait_flip_pending(struct block_sequence_state *seq_state,
 		struct hubp *hubp,
-		unsigned int timeout_us,
 		unsigned int polling_interval_us)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].params.hubp_wait_flip_pending_params.hubp = hubp;
-		seq_state->steps[*seq_state->num_steps].params.hubp_wait_flip_pending_params.timeout_us = timeout_us;
 		seq_state->steps[*seq_state->num_steps].params.hubp_wait_flip_pending_params.polling_interval_us = polling_interval_us;
 		seq_state->steps[*seq_state->num_steps].func = HUBP_WAIT_FLIP_PENDING;
 		(*seq_state->num_steps)++;
@@ -3611,11 +3668,9 @@ void hwss_tg_set_gsl_source_select(union block_sequence_params *params)
 		tg->funcs->set_gsl_source_select(tg, group_idx, gsl_ready_signal);
 }
 
-void hwss_hubp_wait_flip_pending(union block_sequence_params *params)
+void hwss_hubp_wait_flip_pending(struct hubp *hubp, unsigned int polling_interval_us)
 {
-	struct hubp *hubp = params->hubp_wait_flip_pending_params.hubp;
-	unsigned int timeout_us = params->hubp_wait_flip_pending_params.timeout_us;
-	unsigned int polling_interval_us = params->hubp_wait_flip_pending_params.polling_interval_us;
+	const unsigned int timeout_us = 100000U;
 	unsigned int j = 0;
 
 	for (j = 0; j < timeout_us / polling_interval_us
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
index 4202fadb2c0e9..0f44577572fbe 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
@@ -44,20 +44,36 @@ void dce_enable_fe_clock(struct dce_hwseq *hws,
 			DCFE_CLOCK_ENABLE, enable);
 }
 
-void dce_pipe_control_lock(struct dc *dc,
+bool dce_build_pipe_control_lock_sequence(struct dc *dc,
 		struct pipe_ctx *pipe,
-		bool lock)
+		bool lock,
+		struct pipe_control_lock_params *params)
 {
-	uint32_t lock_val = lock ? 1 : 0;
+	if (!pipe || pipe->top_pipe)
+		return false;
+
+	params->lock = lock;
+	params->tg_lock.dc = dc;
+	params->tg_lock.tg = pipe->stream_res.tg;
+	params->tg_lock.lock = lock;
+	params->tg_lock.triplebuffer_flips = pipe->plane_state &&
+			pipe->plane_state->triplebuffer_flips;
+	return true;
+}
+
+void dce_tg_lock(struct tg_lock_params *params)
+{
+	uint32_t lock_val = params->lock ? 1 : 0;
 	uint32_t dcp_grph, scl, blnd, update_lock_mode, val;
-	struct dce_hwseq *hws = dc->hwseq;
+	struct dce_hwseq *hws = params->dc->hwseq;
+	unsigned int tg_inst = params->tg->inst;
 
 	/* Not lock pipe when blank */
-	if (lock && pipe->stream_res.tg->funcs->is_blanked &&
-	    pipe->stream_res.tg->funcs->is_blanked(pipe->stream_res.tg))
+	if (params->lock && params->tg->funcs->is_blanked &&
+			params->tg->funcs->is_blanked(params->tg))
 		return;
 
-	val = REG_GET_4(BLND_V_UPDATE_LOCK[pipe->stream_res.tg->inst],
+	val = REG_GET_4(BLND_V_UPDATE_LOCK[tg_inst],
 			BLND_DCP_GRPH_V_UPDATE_LOCK, &dcp_grph,
 			BLND_SCL_V_UPDATE_LOCK, &scl,
 			BLND_BLND_V_UPDATE_LOCK, &blnd,
@@ -68,28 +84,28 @@ void dce_pipe_control_lock(struct dc *dc,
 	blnd = lock_val;
 	update_lock_mode = lock_val;
 
-	REG_SET_2(BLND_V_UPDATE_LOCK[pipe->stream_res.tg->inst], val,
+	REG_SET_2(BLND_V_UPDATE_LOCK[tg_inst], val,
 			BLND_DCP_GRPH_V_UPDATE_LOCK, dcp_grph,
 			BLND_SCL_V_UPDATE_LOCK, scl);
 
 	if (hws->masks->BLND_BLND_V_UPDATE_LOCK != 0)
-		REG_SET_2(BLND_V_UPDATE_LOCK[pipe->stream_res.tg->inst], val,
+		REG_SET_2(BLND_V_UPDATE_LOCK[tg_inst], val,
 				BLND_BLND_V_UPDATE_LOCK, blnd,
 				BLND_V_UPDATE_LOCK_MODE, update_lock_mode);
 
 	if (hws->wa.blnd_crtc_trigger) {
-		if (!lock) {
-			uint32_t value = REG_READ(CRTC_H_BLANK_START_END[pipe->stream_res.tg->inst]);
-			REG_WRITE(CRTC_H_BLANK_START_END[pipe->stream_res.tg->inst], value);
+		if (!params->lock) {
+			uint32_t value = REG_READ(CRTC_H_BLANK_START_END[tg_inst]);
+
+			REG_WRITE(CRTC_H_BLANK_START_END[tg_inst], value);
 		}
 	}
 }
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
-void dce60_pipe_control_lock(struct dc *dc,
-		struct pipe_ctx *pipe,
-		bool lock)
+void dce60_tg_lock(struct tg_lock_params *params)
 {
+	(void)params;
 	/* DCE6 has no BLND_V_UPDATE_LOCK register */
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
index 2cc4e7516a5d7..0b9b418626110 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
@@ -26,6 +26,7 @@
 #define __DCE_HWSEQ_H__
 
 #include "dc_types.h"
+#include "hw_sequencer_private.h"
 
 #define HWSEQ_DCEF_REG_LIST_DCE8() \
 	.DCFE_CLOCK_CONTROL[0] = mmCRTC0_CRTC_DCFE_CLOCK_CONTROL, \
@@ -1299,17 +1300,16 @@ struct clock_source;
 void dce_enable_fe_clock(struct dce_hwseq *hwss,
 		unsigned int inst, bool enable);
 
-void dce_pipe_control_lock(struct dc *dc,
-		struct pipe_ctx *pipe,
-		bool lock);
+bool dce_build_pipe_control_lock_sequence(struct dc *dc,
+		struct pipe_ctx *pipe, bool lock,
+		struct pipe_control_lock_params *params);
+void dce_tg_lock(struct tg_lock_params *params);
 
 void dce_set_blender_mode(struct dce_hwseq *hws,
 	unsigned int blnd_inst, enum blnd_mode mode);
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
-void dce60_pipe_control_lock(struct dc *dc,
-		struct pipe_ctx *pipe,
-		bool lock);
+void dce60_tg_lock(struct tg_lock_params *params);
 #endif
 
 void dce_clock_gating_power_up(struct dce_hwseq *hws,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index ef91c61033a33..bb46d72490259 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3640,9 +3640,10 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dce110_power_down_fe,
-	.pipe_control_lock = dce_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dce_build_pipe_control_lock_sequence,
+	.tg_lock = dce_tg_lock,
 	.interdependent_update_lock = NULL,
-	.cursor_lock = dce_pipe_control_lock,
+	.cursor_lock = hwss_pipe_control_lock,
 	.prepare_bandwidth = dce110_prepare_bandwidth,
 	.optimize_bandwidth = dce110_optimize_bandwidth,
 	.set_drr = set_drr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
index 1652e47716a0a..b73a10b0acbd7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
@@ -423,8 +423,9 @@ void dce60_hw_sequencer_construct(struct dc *dc)
 
 	dc->hwseq->funcs.enable_display_power_gating = dce100_enable_display_power_gating;
 	dc->hwss.apply_ctx_for_surface = dce60_apply_ctx_for_surface;
-	dc->hwss.cursor_lock = dce60_pipe_control_lock;
-	dc->hwss.pipe_control_lock = dce60_pipe_control_lock;
+	dc->hwss.cursor_lock = hwss_pipe_control_lock;
+	dc->hwss.build_pipe_control_lock_sequence = dce_build_pipe_control_lock_sequence;
+	dc->hwss.tg_lock = dce60_tg_lock;
 	dc->hwss.prepare_bandwidth = dce100_prepare_bandwidth;
 	dc->hwss.optimize_bandwidth = dce100_optimize_bandwidth;
 	dc->hwss.clear_surface_dcc_and_tiling = dce100_reset_surface_dcc_and_tiling;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c
index 76fd45550c5e7..f44f41b13007d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c
@@ -47,7 +47,8 @@ void dce80_hw_sequencer_construct(struct dc *dc)
 	dce110_hw_sequencer_construct(dc);
 
 	dc->hwseq->funcs.enable_display_power_gating = dce100_enable_display_power_gating;
-	dc->hwss.pipe_control_lock = dce_pipe_control_lock;
+	dc->hwss.build_pipe_control_lock_sequence = dce_build_pipe_control_lock_sequence;
+	dc->hwss.tg_lock = dce_tg_lock;
 	dc->hwss.prepare_bandwidth = dce100_prepare_bandwidth;
 	dc->hwss.optimize_bandwidth = dce100_optimize_bandwidth;
 	dc->hwss.clear_surface_dcc_and_tiling = dce100_reset_surface_dcc_and_tiling;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index d76fc6ef38c4e..b1679791f903f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -246,9 +246,9 @@ void dcn10_lock_all_pipes(struct dc *dc,
 			continue;
 
 		if (lock)
-			dc->hwss.pipe_control_lock(dc, pipe_ctx, true);
+			hwss_pipe_control_lock(dc, pipe_ctx, true);
 		else
-			dc->hwss.pipe_control_lock(dc, pipe_ctx, false);
+			hwss_pipe_control_lock(dc, pipe_ctx, false);
 	}
 }
 
@@ -2202,29 +2202,20 @@ bool dcn10_set_output_transfer_func(struct set_output_transfer_func_params *para
 	return true;
 }
 
-void dcn10_pipe_control_lock(
-	struct dc *dc,
-	struct pipe_ctx *pipe,
-	bool lock)
+void dcn10_tg_lock(struct tg_lock_params *params)
 {
-	struct dce_hwseq *hws = dc->hwseq;
-
-	/* use TG master update lock to lock everything on the TG
-	 * therefore only top pipe need to lock
-	 */
-	if (!pipe || pipe->top_pipe)
-		return;
+	struct dce_hwseq *hws = params->dc->hwseq;
 
-	if (dc->debug.sanity_checks)
-		hws->funcs.verify_allow_pstate_change_high(dc);
+	if (params->dc->debug.sanity_checks)
+		hws->funcs.verify_allow_pstate_change_high(params->dc);
 
-	if (lock)
-		pipe->stream_res.tg->funcs->lock(pipe->stream_res.tg);
+	if (params->lock)
+		params->tg->funcs->lock(params->tg);
 	else
-		pipe->stream_res.tg->funcs->unlock(pipe->stream_res.tg);
+		params->tg->funcs->unlock(params->tg);
 
-	if (dc->debug.sanity_checks)
-		hws->funcs.verify_allow_pstate_change_high(dc);
+	if (params->dc->debug.sanity_checks)
+		hws->funcs.verify_allow_pstate_change_high(params->dc);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 1f36bd58beb24..30c213f2e8d6c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -57,10 +57,7 @@ void dcn10_wait_for_pipe_update_if_needed(
 void dcn10_set_wait_for_update_needed_for_pipe(
 	struct dc *dc,
 	struct pipe_ctx *pipe_ctx);
-void dcn10_pipe_control_lock(
-	struct dc *dc,
-	struct pipe_ctx *pipe,
-	bool lock);
+void dcn10_tg_lock(struct tg_lock_params *params);
 void dcn10_cursor_lock(struct dc *dc, struct pipe_ctx *pipe, bool lock);
 void dcn10_blank_pixel_data(
 		struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
index b5e82e1901247..47ab50a3fab1c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
@@ -27,6 +27,7 @@
 #include "dce110/dce110_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
+#include "dc/hwss/dce/dce_hwseq.h"
 
 static const struct hw_sequencer_funcs dcn10_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
@@ -54,7 +55,8 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn10_disable_plane,
-	.pipe_control_lock = dcn10_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dce_build_pipe_control_lock_sequence,
+	.tg_lock = dcn10_tg_lock,
 	.cursor_lock = dcn10_cursor_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.prepare_bandwidth = dcn10_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 23e191d472991..38d587af9dd82 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -217,15 +217,18 @@ static int find_free_gsl_group(const struct dc *dc)
  * gsl_0 <=> pipe_ctx->stream_res.gsl_group == 1
  * Using a magic value like -1 would require tracking all inits/resets
  */
-void dcn20_setup_gsl_group_as_lock(
+void dcn20_build_gsl_group_as_lock(
 		const struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
-		bool enable)
+		bool enable,
+		struct tg_set_gsl_params *gsl_params,
+		struct tg_set_gsl_source_select_params *gsl_source_select_params)
 {
-	struct gsl_params gsl;
 	int group_idx;
 
-	memset(&gsl, 0, sizeof(struct gsl_params));
+	memset(&gsl_params->gsl, 0, sizeof(gsl_params->gsl));
+	gsl_params->tg = pipe_ctx->stream_res.tg;
+	gsl_source_select_params->tg = pipe_ctx->stream_res.tg;
 
 	if (enable) {
 		/* return if group already assigned since GSL was set up
@@ -241,22 +244,22 @@ void dcn20_setup_gsl_group_as_lock(
 		/* set gsl group reg field and mark resource used */
 		switch (group_idx) {
 		case 1:
-			gsl.gsl0_en = 1;
+			gsl_params->gsl.gsl0_en = 1;
 			dc->res_pool->gsl_groups.gsl_0 = 1;
 			break;
 		case 2:
-			gsl.gsl1_en = 1;
+			gsl_params->gsl.gsl1_en = 1;
 			dc->res_pool->gsl_groups.gsl_1 = 1;
 			break;
 		case 3:
-			gsl.gsl2_en = 1;
+			gsl_params->gsl.gsl2_en = 1;
 			dc->res_pool->gsl_groups.gsl_2 = 1;
 			break;
 		default:
 			BREAK_TO_DEBUGGER();
 			return; // invalid case
 		}
-		gsl.gsl_master_en = 1;
+		gsl_params->gsl.gsl_master_en = 1;
 	} else {
 		group_idx = pipe_ctx->stream_res.gsl_group;
 		if (group_idx == 0)
@@ -267,32 +270,46 @@ void dcn20_setup_gsl_group_as_lock(
 		/* unset gsl group reg field and mark resource free */
 		switch (group_idx) {
 		case 1:
-			gsl.gsl0_en = 0;
 			dc->res_pool->gsl_groups.gsl_0 = 0;
 			break;
 		case 2:
-			gsl.gsl1_en = 0;
 			dc->res_pool->gsl_groups.gsl_1 = 0;
 			break;
 		case 3:
-			gsl.gsl2_en = 0;
 			dc->res_pool->gsl_groups.gsl_2 = 0;
 			break;
 		default:
 			BREAK_TO_DEBUGGER();
 			return;
 		}
-		gsl.gsl_master_en = 0;
 	}
 
+	gsl_source_select_params->group_idx = group_idx;
+	gsl_source_select_params->gsl_ready_signal = enable ? 4 : 0;
+}
+
+void dcn20_setup_gsl_group_as_lock(
+		const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool enable)
+{
+	struct tg_set_gsl_params gsl_params = { 0 };
+	struct tg_set_gsl_source_select_params gsl_source_select_params = { 0 };
+
+	dcn20_build_gsl_group_as_lock(dc, pipe_ctx, enable,
+			&gsl_params, &gsl_source_select_params);
+	if (!gsl_source_select_params.group_idx)
+		return;
+
 	/* at this point we want to program whether it's to enable or disable */
 	if (pipe_ctx->stream_res.tg->funcs->set_gsl != NULL) {
 		pipe_ctx->stream_res.tg->funcs->set_gsl(
 			pipe_ctx->stream_res.tg,
-			&gsl);
+			&gsl_params.gsl);
 		if (pipe_ctx->stream_res.tg->funcs->set_gsl_source_select != NULL)
 			pipe_ctx->stream_res.tg->funcs->set_gsl_source_select(
-				pipe_ctx->stream_res.tg, group_idx, enable ? 4 : 0);
+				pipe_ctx->stream_res.tg, gsl_source_select_params.group_idx,
+				gsl_source_select_params.gsl_ready_signal);
 	} else
 		BREAK_TO_DEBUGGER();
 }
@@ -1386,19 +1403,30 @@ void dcn20_enable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx,
 //	}
 }
 
-void dcn20_pipe_control_lock(
-	struct dc *dc,
-	struct pipe_ctx *pipe,
-	bool lock)
+bool dcn20_build_pipe_control_lock_sequence(
+		struct dc *dc,
+		struct pipe_ctx *pipe,
+		bool lock,
+		struct pipe_control_lock_params *params)
 {
 	struct pipe_ctx *temp_pipe;
 	bool flip_immediate = false;
+	unsigned int hubp_count = 0;
 
 	/* use TG master update lock to lock everything on the TG
 	 * therefore only top pipe need to lock
 	 */
 	if (!pipe || pipe->top_pipe)
-		return;
+		return false;
+
+	params->lock = lock;
+	params->tg_lock.dc = dc;
+	params->tg_lock.lock = lock;
+	params->tg_lock.tg = pipe->stream_res.tg;
+	params->tg_lock.use_dmub_inbox1 = pipe->stream &&
+			should_use_dmub_inbox1_lock(dc, pipe->stream->link);
+	params->tg_lock.triplebuffer_flips = pipe->plane_state &&
+			pipe->plane_state->triplebuffer_flips;
 
 	if (pipe->plane_state != NULL)
 		flip_immediate = pipe->plane_state->flip_immediate;
@@ -1413,22 +1441,10 @@ void dcn20_pipe_control_lock(
 	}
 
 	if (flip_immediate && lock) {
-		const unsigned int TIMEOUT_FOR_FLIP_PENDING_US = 100000U;
-		unsigned int polling_interval_us = 1;
-		unsigned int i;
-
 		temp_pipe = pipe;
 		while (temp_pipe) {
-			if (temp_pipe->plane_state && temp_pipe->plane_state->flip_immediate) {
-				for (i = 0; i < TIMEOUT_FOR_FLIP_PENDING_US / polling_interval_us; ++i) {
-					if (!temp_pipe->plane_res.hubp->funcs->hubp_is_flip_pending(temp_pipe->plane_res.hubp))
-						break;
-					udelay(polling_interval_us);
-				}
-
-				/* no reason it should take this long for immediate flips */
-				ASSERT(i != TIMEOUT_FOR_FLIP_PENDING_US);
-			}
+			if (temp_pipe->plane_state && temp_pipe->plane_state->flip_immediate)
+				params->hubps_to_wait_for_flip[hubp_count++] = temp_pipe->plane_res.hubp;
 			temp_pipe = temp_pipe->bottom_pipe;
 		}
 	}
@@ -1438,8 +1454,11 @@ void dcn20_pipe_control_lock(
 	 */
 	if (lock && (pipe->bottom_pipe != NULL || !flip_immediate))
 		if ((flip_immediate && pipe->stream_res.gsl_group == 0) ||
-		    (!flip_immediate && pipe->stream_res.gsl_group > 0))
-			dcn20_setup_gsl_group_as_lock(dc, pipe, flip_immediate);
+		    (!flip_immediate && pipe->stream_res.gsl_group > 0)) {
+			params->gsl_lock = true;
+			dcn20_build_gsl_group_as_lock(dc, pipe, flip_immediate,
+					&params->gsl, &params->gsl_source_select);
+		}
 
 	if (pipe->plane_state != NULL)
 		flip_immediate = pipe->plane_state->flip_immediate;
@@ -1452,37 +1471,53 @@ void dcn20_pipe_control_lock(
 	}
 
 	if (!lock && pipe->stream_res.gsl_group > 0 && pipe->plane_state &&
-		!flip_immediate)
-	    dcn20_setup_gsl_group_as_lock(dc, pipe, false);
+			!flip_immediate) {
+		params->gsl_lock = true;
+		dcn20_build_gsl_group_as_lock(dc, pipe, false,
+				&params->gsl, &params->gsl_source_select);
+	}
+
+	if (!lock && !params->tg_lock.use_dmub_inbox1 &&
+			!params->tg_lock.triplebuffer_flips &&
+			dc->hwseq->funcs.perform_3dlut_wa_unlock) {
+		const struct pipe_ctx *otg_master_pipe = resource_get_otg_master(pipe);
+		const struct pipe_ctx *primary_dpp_pipe = resource_is_pipe_type(pipe, DPP_PIPE) ?
+				resource_get_primary_dpp_pipe(pipe) : pipe;
+
+		if (otg_master_pipe && otg_master_pipe->stream_res.tg &&
+			 primary_dpp_pipe && primary_dpp_pipe->plane_state &&
+				primary_dpp_pipe->plane_state->cm.flags.bits.lut3d_enable &&
+				primary_dpp_pipe->plane_state->cm.flags.bits.lut3d_dma_enable) {
+			params->tg_3dlut_wa_unlock = true;
+			params->tg_3dlut_wa_unlock_params.tg = otg_master_pipe->stream_res.tg;
+			params->tg_3dlut_wa_unlock_params.hubp = primary_dpp_pipe->plane_res.hubp;
+		}
+	}
+
+	return true;
+}
 
-	if (pipe->stream && should_use_dmub_inbox1_lock(dc, pipe->stream->link)) {
+void dcn20_tg_lock(struct tg_lock_params *params)
+{
+	if (params->use_dmub_inbox1) {
 		union dmub_hw_lock_flags hw_locks = { 0 };
 		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
 		hw_locks.bits.lock_pipe = 1;
-		inst_flags.otg_inst = (uint8_t)pipe->stream_res.tg->inst;
-
-		if (pipe->plane_state != NULL)
-			hw_locks.bits.triple_buffer_lock = pipe->plane_state->triplebuffer_flips;
-
-		dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
-					lock,
-					&hw_locks,
-					&inst_flags);
-	} else if (pipe->plane_state != NULL && pipe->plane_state->triplebuffer_flips) {
-		if (lock)
-			pipe->stream_res.tg->funcs->triplebuffer_lock(pipe->stream_res.tg);
+		inst_flags.otg_inst = (uint8_t)params->tg->inst;
+		hw_locks.bits.triple_buffer_lock = params->triplebuffer_flips;
+		dmub_hw_lock_mgr_cmd(params->dc->ctx->dmub_srv, params->lock,
+				&hw_locks, &inst_flags);
+	} else if (params->triplebuffer_flips) {
+		if (params->lock)
+			params->tg->funcs->triplebuffer_lock(params->tg);
 		else
-			pipe->stream_res.tg->funcs->triplebuffer_unlock(pipe->stream_res.tg);
+			params->tg->funcs->triplebuffer_unlock(params->tg);
 	} else {
-		if (lock)
-			pipe->stream_res.tg->funcs->lock(pipe->stream_res.tg);
-		else {
-			if (dc->hwseq->funcs.perform_3dlut_wa_unlock)
-				dc->hwseq->funcs.perform_3dlut_wa_unlock(pipe);
-			else
-				pipe->stream_res.tg->funcs->unlock(pipe->stream_res.tg);
-		}
+		if (params->lock)
+			params->tg->funcs->lock(params->tg);
+		else
+			params->tg->funcs->unlock(params->tg);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
index 9312c88e31ad9..c7bf79fda54c7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
@@ -61,10 +61,16 @@ void dcn20_blank_pixel_data(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		bool blank);
-void dcn20_pipe_control_lock(
-	struct dc *dc,
-	struct pipe_ctx *pipe,
-	bool lock);
+bool dcn20_build_pipe_control_lock_sequence(struct dc *dc,
+		struct pipe_ctx *pipe, bool lock,
+		struct pipe_control_lock_params *params);
+void dcn20_build_gsl_group_as_lock(
+		const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool enable,
+		struct tg_set_gsl_params *gsl_params,
+		struct tg_set_gsl_source_select_params *gsl_source_select_params);
+void dcn20_tg_lock(struct tg_lock_params *params);
 void dcn20_prepare_bandwidth(
 		struct dc *dc,
 		struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
index 1797a91b0186e..1c6c4e19bdda3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
@@ -56,7 +56,8 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index 7b820bdae55b4..9f4bc2a498730 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -525,35 +525,27 @@ void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	hubp->mpcc_id = mpcc_id;
 }
 
-void dcn201_pipe_control_lock(
-	struct dc *dc,
-	struct pipe_ctx *pipe,
-	bool lock)
+void dcn201_tg_lock(struct tg_lock_params *params)
 {
-	struct dce_hwseq *hws = dc->hwseq;
-	/* use TG master update lock to lock everything on the TG
-	 * therefore only top pipe need to lock
-	 */
-	if (pipe->top_pipe)
-		return;
+	struct dce_hwseq *hws = params->dc->hwseq;
 
-	if (dc->debug.sanity_checks)
-		hws->funcs.verify_allow_pstate_change_high(dc);
+	if (params->dc->debug.sanity_checks)
+		hws->funcs.verify_allow_pstate_change_high(params->dc);
 
-	if (pipe->plane_state != NULL && pipe->plane_state->triplebuffer_flips) {
-		if (lock)
-			pipe->stream_res.tg->funcs->triplebuffer_lock(pipe->stream_res.tg);
+	if (params->triplebuffer_flips) {
+		if (params->lock)
+			params->tg->funcs->triplebuffer_lock(params->tg);
 		else
-			pipe->stream_res.tg->funcs->triplebuffer_unlock(pipe->stream_res.tg);
+			params->tg->funcs->triplebuffer_unlock(params->tg);
 	} else {
-		if (lock)
-			pipe->stream_res.tg->funcs->lock(pipe->stream_res.tg);
+		if (params->lock)
+			params->tg->funcs->lock(params->tg);
 		else
-			pipe->stream_res.tg->funcs->unlock(pipe->stream_res.tg);
+			params->tg->funcs->unlock(params->tg);
 	}
 
-	if (dc->debug.sanity_checks)
-		hws->funcs.verify_allow_pstate_change_high(dc);
+	if (params->dc->debug.sanity_checks)
+		hws->funcs.verify_allow_pstate_change_high(params->dc);
 }
 
 void dcn201_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h
index 6a50a9894be6a..bab5d9e6912e4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h
@@ -36,10 +36,7 @@ void dcn201_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn201_plane_atomic_disconnect(struct dc *dc, struct dc_state *state, struct pipe_ctx *pipe_ctx);
 void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn201_set_cursor_attribute(struct pipe_ctx *pipe_ctx);
-void dcn201_pipe_control_lock(
-	struct dc *dc,
-	struct pipe_ctx *pipe,
-	bool lock);
+void dcn201_tg_lock(struct tg_lock_params *params);
 void dcn201_init_blank(
 		struct dc *dc,
 		struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
index dec57fb4c05c9..95dda06b6b175 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include "dce/dce_hwseq.h"
 #include "dce110/dce110_hwseq.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
@@ -55,7 +56,8 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn10_disable_plane,
-	.pipe_control_lock = dcn201_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dce_build_pipe_control_lock_sequence,
+	.tg_lock = dcn201_tg_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
index c7701a8b574aa..b8ed664e1babf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
@@ -56,7 +56,8 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index d5aa58462855c..b655c01f013bc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -57,7 +57,8 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn30_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index a570333aeac18..dfacc59166cdd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -58,7 +58,8 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 7197414e5bd69..3c2e2162da117 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -60,7 +60,8 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 4966c044a8644..b50ab468b8f8f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -62,7 +62,8 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index ec38fc2ba65cc..79be5c385280c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1867,9 +1867,9 @@ void dcn32_interdependent_update_lock(struct dc *dc,
 			continue;
 
 		if (lock)
-			dc->hwss.pipe_control_lock(dc, pipe, true);
+			hwss_pipe_control_lock(dc, pipe, true);
 		else
-			dc->hwss.pipe_control_lock(dc, pipe, false);
+			hwss_pipe_control_lock(dc, pipe, false);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 364b4108f5d6f..2251289622167 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -60,7 +60,8 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn32_interdependent_update_lock,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn32_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index fc18d2207711f..c9125cc25d157 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -64,7 +64,8 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn35_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn35_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 19ec5b4edfdc9..e6f7d57cbfed5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -63,7 +63,8 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn35_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn35_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0e107754c891e..8e0ccc9d58199 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -32,6 +32,7 @@
 #include "dcn10/dcn10_cm_common.h"
 #include "dcn10/dcn10_hubbub.h"
 #include "dcn20/dcn20_optc.h"
+#include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_cm_common.h"
 #include "dcn32/dcn32_hwseq.h"
 #include "dcn401_hwseq.h"
@@ -1935,7 +1936,7 @@ void dcn401_interdependent_update_lock(struct dc *dc,
 					!tg->funcs->is_tg_enabled(tg) ||
 					dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
 				continue;
-			dc->hwss.pipe_control_lock(dc, pipe, true);
+			hwss_pipe_control_lock(dc, pipe, true);
 		}
 	} else {
 		/* Need to free DET being used first and have pipe update, then unlock the remaining pipes*/
@@ -1951,7 +1952,7 @@ void dcn401_interdependent_update_lock(struct dc *dc,
 
 			if (dc->scratch.pipes_to_unlock_first[i]) {
 				struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-				dc->hwss.pipe_control_lock(dc, pipe, false);
+				hwss_pipe_control_lock(dc, pipe, false);
 				/* Assumes pipe of the same index in current_state is also an OTG_MASTER pipe*/
 				dcn401_wait_for_det_buffer_update_under_otg_master(dc, dc->current_state, old_pipe);
 			}
@@ -1970,12 +1971,13 @@ void dcn401_interdependent_update_lock(struct dc *dc,
 				continue;
 			}
 
-			dc->hwss.pipe_control_lock(dc, pipe, false);
+			hwss_pipe_control_lock(dc, pipe, false);
 		}
 	}
 }
 
-void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx)
+void dcn401_perform_3dlut_wa_unlock(struct timing_generator *tg,
+		struct hubp *primary_hubp)
 {
 	/* If 3DLUT FL is enabled and 3DLUT is in use, follow the workaround sequence for pipe unlock to make sure that
 	 * HUBP will properly fetch 3DLUT contents after unlock.
@@ -1983,45 +1985,24 @@ void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx)
 	 * This is meant to work around a known HW issue where VREADY will cancel the pending 3DLUT_ENABLE signal regardless
 	 * of whether OTG lock is currently being held or not.
 	 */
-	if (!pipe_ctx)
+	if (!tg)
 		return;
 
-	const struct pipe_ctx *otg_master_pipe_ctx = resource_get_otg_master(pipe_ctx);
-	struct timing_generator *tg = otg_master_pipe_ctx ?
-			otg_master_pipe_ctx->stream_res.tg : NULL;
-	const struct pipe_ctx *primary_dpp_pipe_ctx = resource_is_pipe_type(pipe_ctx, DPP_PIPE) ?
-			resource_get_primary_dpp_pipe(pipe_ctx) : pipe_ctx;
-	struct hubp *primary_hubp = primary_dpp_pipe_ctx ?
-			primary_dpp_pipe_ctx->plane_res.hubp : NULL;
-
-	if (!otg_master_pipe_ctx || !tg) {
-		return;
-	}
-
-	if (primary_dpp_pipe_ctx &&
-			primary_dpp_pipe_ctx->plane_state &&
-			primary_dpp_pipe_ctx->plane_state->cm.flags.bits.lut3d_enable &&
-			primary_dpp_pipe_ctx->plane_state->cm.flags.bits.lut3d_dma_enable) {
-		if (tg->funcs->set_vupdate_keepout)
-			tg->funcs->set_vupdate_keepout(tg, true);
+	if (tg->funcs->set_vupdate_keepout)
+		tg->funcs->set_vupdate_keepout(tg, true);
 
-		if (primary_hubp && primary_hubp->funcs->hubp_enable_3dlut_fl) {
-			primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
-		}
+	if (primary_hubp && primary_hubp->funcs->hubp_enable_3dlut_fl)
+		primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
 
-		tg->funcs->unlock(tg);
-		if (tg->funcs->wait_update_lock_status)
-			tg->funcs->wait_update_lock_status(tg, false);
+	tg->funcs->unlock(tg);
+	if (tg->funcs->wait_update_lock_status)
+		tg->funcs->wait_update_lock_status(tg, false);
 
-		if (primary_hubp && primary_hubp->funcs->hubp_enable_3dlut_fl) {
-			primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
-		}
+	if (primary_hubp && primary_hubp->funcs->hubp_enable_3dlut_fl)
+		primary_hubp->funcs->hubp_enable_3dlut_fl(primary_hubp, true);
 
-		if (tg->funcs->set_vupdate_keepout)
-			tg->funcs->set_vupdate_keepout(tg, false);
-	} else {
-		tg->funcs->unlock(tg);
-	}
+	if (tg->funcs->set_vupdate_keepout)
+		tg->funcs->set_vupdate_keepout(tg, false);
 }
 
 void dcn401_program_outstanding_updates(struct dc *dc,
@@ -3462,89 +3443,24 @@ void dcn401_update_writeback_sequence(
 	hwss_add_mcif_wb_config_buf(seq_state, mcif_wb, &wb_info->mcif_buf_params, wb_info->dwb_params.dest_height);
 }
 
-static int find_free_gsl_group(const struct dc *dc)
-{
-	if (dc->res_pool->gsl_groups.gsl_0 == 0)
-		return 1;
-	if (dc->res_pool->gsl_groups.gsl_1 == 0)
-		return 2;
-	if (dc->res_pool->gsl_groups.gsl_2 == 0)
-		return 3;
-
-	return 0;
-}
-
 void dcn401_setup_gsl_group_as_lock_sequence(
 		const struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		bool enable,
 		struct block_sequence_state *seq_state)
 {
-	struct gsl_params gsl;
-	int group_idx;
-
-	memset(&gsl, 0, sizeof(struct gsl_params));
+	struct tg_set_gsl_params gsl_params = { 0 };
+	struct tg_set_gsl_source_select_params gsl_source_select_params = { 0 };
 
-	if (enable) {
-		/* return if group already assigned since GSL was set up
-		 * for vsync flip, we would unassign so it can't be "left over"
-		 */
-		if (pipe_ctx->stream_res.gsl_group > 0)
-			return;
-
-		group_idx = find_free_gsl_group(dc);
-		ASSERT(group_idx != 0);
-		pipe_ctx->stream_res.gsl_group = (uint8_t)group_idx;
-
-		/* set gsl group reg field and mark resource used */
-		switch (group_idx) {
-		case 1:
-			gsl.gsl0_en = 1;
-			dc->res_pool->gsl_groups.gsl_0 = 1;
-			break;
-		case 2:
-			gsl.gsl1_en = 1;
-			dc->res_pool->gsl_groups.gsl_1 = 1;
-			break;
-		case 3:
-			gsl.gsl2_en = 1;
-			dc->res_pool->gsl_groups.gsl_2 = 1;
-			break;
-		default:
-			BREAK_TO_DEBUGGER();
-			return; // invalid case
-		}
-		gsl.gsl_master_en = 1;
-	} else {
-		group_idx = pipe_ctx->stream_res.gsl_group;
-		if (group_idx == 0)
-			return; // if not in use, just return
-
-		pipe_ctx->stream_res.gsl_group = 0;
-
-		/* unset gsl group reg field and mark resource free */
-		switch (group_idx) {
-		case 1:
-			gsl.gsl0_en = 0;
-			dc->res_pool->gsl_groups.gsl_0 = 0;
-			break;
-		case 2:
-			gsl.gsl1_en = 0;
-			dc->res_pool->gsl_groups.gsl_1 = 0;
-			break;
-		case 3:
-			gsl.gsl2_en = 0;
-			dc->res_pool->gsl_groups.gsl_2 = 0;
-			break;
-		default:
-			BREAK_TO_DEBUGGER();
-			return;
-		}
-		gsl.gsl_master_en = 0;
-	}
+	dcn20_build_gsl_group_as_lock(dc, pipe_ctx, enable,
+			&gsl_params, &gsl_source_select_params);
+	if (!gsl_source_select_params.group_idx)
+		return;
 
-	hwss_add_tg_set_gsl(seq_state, pipe_ctx->stream_res.tg, gsl);
-	hwss_add_tg_set_gsl_source_select(seq_state, pipe_ctx->stream_res.tg, group_idx, enable ? 4 : 0);
+	hwss_add_tg_set_gsl(seq_state, gsl_params.tg, gsl_params.gsl);
+	hwss_add_tg_set_gsl_source_select(seq_state, gsl_source_select_params.tg,
+			gsl_source_select_params.group_idx,
+			gsl_source_select_params.gsl_ready_signal);
 }
 
 void dcn401_disable_plane_sequence(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index c08fd359b38b0..756b2d98a9309 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -109,7 +109,8 @@ void dcn401_program_pipe_sequence(
 	struct pipe_ctx *pipe_ctx,
 	struct dc_state *context,
 	struct block_sequence_state *seq_state);
-void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx);
+void dcn401_perform_3dlut_wa_unlock(struct timing_generator *tg,
+		struct hubp *primary_hubp);
 void dcn401_program_front_end_for_ctx(struct dc *dc, struct dc_state *context);
 void dcn401_post_unlock_program_front_end(struct dc *dc, struct dc_state *context);
 bool dcn401_update_bandwidth(struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 7039f40ea880d..783415e4e3a10 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -40,7 +40,8 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_plane_sequence = dcn401_disable_plane_sequence,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn401_interdependent_update_lock,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn401_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index ba12a97a220fe..aad1885cc9887 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -42,7 +42,8 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn35_disable_plane,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn401_interdependent_update_lock,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn42_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
index 1c908964153b7..37e88d45409be 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
@@ -42,7 +42,8 @@ static const struct hw_sequencer_funcs dcn60_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.disable_plane_sequence = dcn401_disable_plane_sequence,
-	.pipe_control_lock = dcn20_pipe_control_lock,
+	.build_pipe_control_lock_sequence = dcn20_build_pipe_control_lock_sequence,
+	.tg_lock = dcn20_tg_lock,
 	.interdependent_update_lock = dcn401_interdependent_update_lock,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn401_prepare_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 169f3420ac6dd..4f0d000eab948 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -66,10 +66,17 @@ struct subvp_pipe_control_lock_fast_params {
 	bool subvp_immediate_flip;
 };
 
-struct pipe_control_lock_params {
+struct tg_lock_params {
 	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct timing_generator *tg;
 	bool lock;
+	bool use_dmub_inbox1;
+	bool triplebuffer_flips;
+};
+
+struct tg_3dlut_wa_unlock_params {
+	struct timing_generator *tg;
+	struct hubp *hubp;
 };
 
 struct set_flip_control_gsl_params {
@@ -342,6 +349,17 @@ struct tg_set_gsl_source_select_params {
 	uint32_t gsl_ready_signal;
 };
 
+struct pipe_control_lock_params {
+	bool lock;
+	struct hubp *hubps_to_wait_for_flip[MAX_PIPES];
+	bool gsl_lock;
+	struct tg_set_gsl_params gsl;
+	struct tg_set_gsl_source_select_params gsl_source_select;
+	struct tg_lock_params tg_lock;
+	bool tg_3dlut_wa_unlock;
+	struct tg_3dlut_wa_unlock_params tg_3dlut_wa_unlock_params;
+};
+
 struct setup_vupdate_interrupt_params {
 	struct dc *dc;
 	struct pipe_ctx *pipe_ctx;
@@ -487,7 +505,6 @@ struct tg_enable_crtc_params {
 
 struct hubp_wait_flip_pending_params {
 	struct hubp *hubp;
-	unsigned int timeout_us;
 	unsigned int polling_interval_us;
 };
 
@@ -1026,7 +1043,8 @@ struct link_set_dpms_on_params {
 union block_sequence_params {
 	struct update_plane_addr_params update_plane_addr_params;
 	struct subvp_pipe_control_lock_fast_params subvp_pipe_control_lock_fast_params;
-	struct pipe_control_lock_params pipe_control_lock_params;
+	struct tg_lock_params tg_lock_params;
+	struct tg_3dlut_wa_unlock_params tg_3dlut_wa_unlock_params;
 	struct set_flip_control_gsl_params set_flip_control_gsl_params;
 	struct program_triplebuffer_params program_triplebuffer_params;
 	struct set_input_transfer_func_params set_input_transfer_func_params;
@@ -1200,7 +1218,8 @@ union block_sequence_params {
 
 enum block_sequence_func {
 	DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST = 0,
-	OPTC_PIPE_CONTROL_LOCK,
+	TG_LOCK,
+	TG_3DLUT_WA_UNLOCK,
 	HUBP_SET_FLIP_CONTROL_GSL,
 	HUBP_PROGRAM_TRIPLEBUFFER,
 	HUBP_UPDATE_PLANE_ADDR,
@@ -1432,8 +1451,10 @@ struct hw_sequencer_funcs {
 	void (*clear_surface_dcc_and_tiling)(struct pipe_ctx *pipe_ctx, struct dc_plane_state *plane_state, bool clear_tiling);
 
 	/* Pipe Lock Related */
-	void (*pipe_control_lock)(struct dc *dc,
-			struct pipe_ctx *pipe, bool lock);
+	bool (*build_pipe_control_lock_sequence)(struct dc *dc,
+			struct pipe_ctx *pipe, bool lock,
+			struct pipe_control_lock_params *params);
+	void (*tg_lock)(struct tg_lock_params *params);
 	void (*interdependent_update_lock)(struct dc *dc,
 			struct dc_state *context, bool lock);
 	void (*set_flip_control_gsl)(struct pipe_ctx *pipe_ctx,
@@ -1959,7 +1980,8 @@ void hwss_tg_set_gsl(union block_sequence_params *params);
 
 void hwss_tg_set_gsl_source_select(union block_sequence_params *params);
 
-void hwss_hubp_wait_flip_pending(union block_sequence_params *params);
+void hwss_hubp_wait_flip_pending(struct hubp *hubp,
+		unsigned int polling_interval_us);
 
 void hwss_tg_wait_double_buffer_pending(union block_sequence_params *params);
 
@@ -2130,6 +2152,9 @@ void hwss_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void hwss_add_optc_pipe_control_lock(struct block_sequence_state *seq_state,
 		struct dc *dc, struct pipe_ctx *pipe_ctx, bool lock);
 
+void hwss_pipe_control_lock(struct dc *dc,
+		struct pipe_ctx *pipe_ctx, bool lock);
+
 void hwss_add_hubp_set_flip_control_gsl(struct block_sequence_state *seq_state,
 		struct hubp *hubp, bool flip_immediate);
 
@@ -2243,7 +2268,7 @@ void hwss_add_tg_enable_crtc(struct block_sequence_state *seq_state,
 		struct timing_generator *tg);
 
 void hwss_add_hubp_wait_flip_pending(struct block_sequence_state *seq_state,
-		struct hubp *hubp, unsigned int timeout_us, unsigned int polling_interval_us);
+		struct hubp *hubp, unsigned int polling_interval_us);
 
 void hwss_add_tg_wait_double_buffer_pending(struct block_sequence_state *seq_state,
 		struct timing_generator *tg, unsigned int timeout_us, unsigned int polling_interval_us);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 956513125be0b..9730f51cf3c04 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -217,7 +217,8 @@ struct hwseq_private_funcs {
 	void (*reset_back_end_for_pipe)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			struct dc_state *context);
-	void (*perform_3dlut_wa_unlock)(struct pipe_ctx *pipe_ctx);
+	void (*perform_3dlut_wa_unlock)(struct timing_generator *tg,
+			struct hubp *primary_hubp);
 	void (*wait_for_pipe_update_if_needed)(struct dc *dc, struct pipe_ctx *pipe_ctx, bool is_surface_update_only);
 	void (*set_wait_for_update_needed_for_pipe)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*dc_ip_request_cntl)(struct dc *dc, bool enable);
-- 
2.43.0

