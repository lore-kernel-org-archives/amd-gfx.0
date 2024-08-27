Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2027AC54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C171010E397;
	Tue, 27 Aug 2024 16:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cVQK4Emr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5E010E395
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2sy9B+DA6s0XoJpXVE/Peh6OzHHmbuNehfSLyb4crmDws0abxwkoK4dkSuHRj1Ct2tGSq8Dw/a4E78yP77x+BuXitnSaICI3o8s77GT2uGB0B5Xdv+rGTHBtbciwjllsDdF/3qRB9xy6UlgjPuWwjPpNGQfsgYBQeNJLZMK+8h0NRI5JsmTWmbiv1OOR+JVxxgS3smwGJJ/7GJk9kffZ7yS/dTHQFQ8VxvkEYQ4Q3e+kpH2XF4oYaZg02olb2LinnZSZ0IHxIjL4nxtRgp7TeecasmT6MTdC2MIYtr7+ltCM2At1wEnkCPzNoeFXkZdfftSDYlhCHRtjByCeLb6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvZ2TsK9HXpJbLFojpyrLoW0kOz9toG0+aXLUXLuJyc=;
 b=F5BhiK1q+co0I1mT13iHqgdnHvO+BnAAccNtn5yLqPGjfH+tjOIV4ALqwW2WMzBD9QGkvkxZUUTnS32aQ5njBwlYA0UN8ndAx40V618rEAki3AlqqHTol/gwKydGiVYOXyir2DhGYu0YyW0HnSkcNz3iEos/FXDNPqL26JnjLwq3DxfUa86rr/ukpLcNZptvlnjDMQBZ4Jt1uoxfCi4zI7VTKBqC+cRy5xOteciTKf9aVijSkQyScQ5UUjiPB1KZCEjpBiMxFOgVsjSGKWz1G0b9v3JE1/CJb0Ds7HG0/WnuBpuaXxd27XOy/ZMl95vKoYhzlYSCKhFOt/V4xX/8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvZ2TsK9HXpJbLFojpyrLoW0kOz9toG0+aXLUXLuJyc=;
 b=cVQK4Emrm1xgkzp+w8N39opMc64TIW4bvczuIC1+yLYIroOJ+6dDXGlLWWlhWF7pG/MZtsa7Ue4oQWQZadOJTIxKiU9zN1Mg2WsSetZRxr2OUK2R8iwZ8x/o0iUEjbTkOZ71YZDHLBDgtbzUBY5Q/gDWpBvEmD2MSvtPu8ZYM44=
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Tue, 27 Aug
 2024 16:41:16 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::f7) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:15 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:11 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <Dillon.Varone@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 09/14] Revert "drm/amd/display: Wait for all pending cleared
 before full update"
Date: Tue, 27 Aug 2024 12:37:29 -0400
Message-ID: <20240827164045.167557-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: dc10a0fd-700b-42c0-c6ae-08dcc6b71194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rrRne2e2RR1MGlSfykXuNO1BobxrIm4tlSzD9gynHeyLdTl84Z1Jv9B/4B3S?=
 =?us-ascii?Q?q1GUhVGOLNC3sSmygca60zkDGyn2kCEHR/n0YESOFgjYHGxm3Q4EWgs5948k?=
 =?us-ascii?Q?IhSwzVnCXeh2W7bZA/j2fwDSSWO0yQyz56yROulyTDBMbMg0xcNXqclv3p9X?=
 =?us-ascii?Q?zPcMCKz8Pz/LQ9zSbIsFGWjRtT/2NC0KzoJV3eibLFJZ6sVcvxVsacUwn9LQ?=
 =?us-ascii?Q?ii5LIij3RtCBOsExF+qP6/4Qwm/FAh9p4DxUCRpL1obT3ucl6iiBdG/O6ozH?=
 =?us-ascii?Q?KOgUcxlk0Iwv7RasJnJurUsvh16LnHzFECivZw9TpLZo/Wswncg9+M/LQh84?=
 =?us-ascii?Q?j5E/6eWVFPBInju2k/Ll8WK41pzmd4wrhFxysdDcwa9b/+1JpfaKWrFsq+ne?=
 =?us-ascii?Q?iStTWtPMKjzAdtTh51i4eYM/sJYjntWrIIJ78mPXvlfsX2Zbz/zrl/bjqm66?=
 =?us-ascii?Q?sBkkY5ifNBp/vUe2M228qzz7ZdzCU8yy2Gn+CnC3Dt6FyJkWvBC/pr8WOK/4?=
 =?us-ascii?Q?6e2+ivDbgkjZJ8pvzlxQq+XZ3MgGGQz83V7B0ZWi8A8Jw1WlTMukapZkN3Os?=
 =?us-ascii?Q?2ZOMd9ZWtsbmsa0zTC9E2Ks1/zoDtxxLHrCyB7BfmXtZUOHTEMYOObkCd1sg?=
 =?us-ascii?Q?e8PZCljH6XBigL3IpGLHsRxhtJ4X2Snr28qQCF743iLjOHdg+Lb4pBk7q4AR?=
 =?us-ascii?Q?U1pq4Tn2IlInPuvycIKpau8F8U278ZJudEoFUIMp7rAg4ZThabDGsu3H2wWs?=
 =?us-ascii?Q?ZcfO9l3j/OfuvnuiT/rW2Fv5IgsqClcokbrWSpYeisMLliJFFjdxbLsVHD4N?=
 =?us-ascii?Q?/92AOO+V0ejtG46jPOhrbO+d8ZYbh/E/A0slYIib+RmiMqpsESm3xeDnFHLL?=
 =?us-ascii?Q?s4KOG8/N9qQsF5Igydt3TC7gidJDw3rpoTYh6GV3vGg9FRTqDX4aT4btRocr?=
 =?us-ascii?Q?aeNQrw1jQYEHT0cd5/nB70aLUoCR8Ztg40uIE+kOigvtieJljJllQ3HZmGqv?=
 =?us-ascii?Q?I92CPIO/lLiA1S6GZXWlz2Bft7lfkUv/hhlUR29CVkUsxfyxauszjQihvglr?=
 =?us-ascii?Q?Ay8YLURKExrjthUOwNMbR79wPWP9WQfnd6EV1xYHWUvxg+vXlYlRTJAlDMeP?=
 =?us-ascii?Q?LcIxhLIQzAhNRQpKYq7ALl23PwuIHXhihz/uw2kONPr5yhDpu0DfUxBsXlrS?=
 =?us-ascii?Q?yu0tIbmqreG+a5dSrgR0faPwQ/8pkfTuNns6/9Fc6ChbpazWdjOjKPWoV7zo?=
 =?us-ascii?Q?mRLudzTXeQUQOmmn+2GixwvgVOzQ7W3jL1AoaOH8hls/UCND857uSDp4o8lu?=
 =?us-ascii?Q?AG5GNnPVc6pQw3xuQCsuM+xD2XdDeVkVrKCx1ERqLZa7nQnip1t8UkQBlCUa?=
 =?us-ascii?Q?PM/LQfOU1AaDf95TlkOsgetMYCC7hCUAt6dDve2n9wcuX5bc/Yc8x6wIEVUR?=
 =?us-ascii?Q?sDCLxOZkRCqTMnc2TSgVip5i3UlIe3bO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:15.5264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc10a0fd-700b-42c0-c6ae-08dcc6b71194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019
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

This reverts commit 3b837c45668c3026fd09145904692ba1130c5d12.

It is causing graphics hangs.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  9 +---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 27 -----------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  2 -
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |  1 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 -
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 -
 .../amd/display/dc/inc/hw/timing_generator.h  |  4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  9 ----
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |  7 +--
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    | 45 -------------------
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    | 13 +-----
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |  3 --
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  9 +---
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |  9 +---
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    | 16 +++++--
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |  7 +--
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |  6 +--
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  4 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  6 +--
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  5 +--
 24 files changed, 34 insertions(+), 161 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 2cb9253c9bde..7ee2be8f82c4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1071,13 +1071,8 @@ void hwss_wait_for_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_con
 		if (!pipe_ctx->stream)
 			continue;
 
-		/* For full update we must wait for all double buffer updates, not just DRR updates. This
-		 * is particularly important for minimal transitions. Only check for OTG_MASTER pipes,
-		 * as non-OTG Master pipes share the same OTG as
-		 */
-		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) && dc->hwss.wait_for_all_pending_updates) {
-			dc->hwss.wait_for_all_pending_updates(pipe_ctx);
-		}
+		if (pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear)
+			pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear(pipe_ctx->stream_res.tg);
 
 		hubp = pipe_ctx->plane_res.hubp;
 		if (!hubp)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index b383ed8cb4d4..a80c08582932 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2255,9 +2255,9 @@ void dcn20_post_unlock_program_front_end(
 			struct timing_generator *tg = pipe->stream_res.tg;
 
 
-			if (tg->funcs->get_optc_double_buffer_pending) {
+			if (tg->funcs->get_double_buffer_pending) {
 				for (j = 0; j < TIMEOUT_FOR_PIPE_ENABLE_US / polling_interval_us
-				&& tg->funcs->get_optc_double_buffer_pending(tg); j++)
+				&& tg->funcs->get_double_buffer_pending(tg); j++)
 					udelay(polling_interval_us);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index d5458dae6d30..42c52284a868 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -1185,30 +1185,3 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 	if (!dc->clk_mgr->clks.fw_based_mclk_switching)
 		dc_dmub_srv_p_state_delegate(dc, false, context);
 }
-
-void dcn30_wait_for_all_pending_updates(const struct pipe_ctx *pipe_ctx)
-{
-	struct timing_generator *tg = pipe_ctx->stream_res.tg;
-	bool pending_updates = false;
-	unsigned int i;
-
-	if (tg && tg->funcs->is_tg_enabled(tg)) {
-		// Poll for 100ms maximum
-		for (i = 0; i < 100000; i++) {
-			pending_updates = false;
-			if (tg->funcs->get_optc_double_buffer_pending)
-				pending_updates |= tg->funcs->get_optc_double_buffer_pending(tg);
-
-			if (tg->funcs->get_otg_double_buffer_pending)
-				pending_updates |= tg->funcs->get_otg_double_buffer_pending(tg);
-
-			if (tg->funcs->get_pipe_update_pending)
-				pending_updates |= tg->funcs->get_pipe_update_pending(tg);
-
-			if (!pending_updates)
-				break;
-
-			udelay(1);
-		}
-	}
-}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 4b90b781c4f2..6a153e7ce910 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -96,6 +96,4 @@ void dcn30_set_hubp_blank(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
 	struct dc_state *context);
 
-void dcn30_wait_for_all_pending_updates(const struct pipe_ctx *pipe_ctx);
-
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index 0e8d32e3dbae..2a8dc40d2847 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -108,8 +108,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
-	.is_abm_supported = dcn21_is_abm_supported,
-	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
+	.is_abm_supported = dcn21_is_abm_supported
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index 780ce4c064aa..93e49d87a67c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -107,7 +107,6 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
-	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 8e0946fd5b7f..3422b564ae98 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -121,7 +121,6 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.program_outstanding_updates = dcn32_program_outstanding_updates,
-	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 73a632b5ff89..a2ca07235c83 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -100,7 +100,6 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.fams2_update_config = dcn401_fams2_update_config,
 	.fams2_global_control_lock_fast = dcn401_fams2_global_control_lock_fast,
 	.program_outstanding_updates = dcn401_program_outstanding_updates,
-	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
 };
 
 static const struct hwseq_private_funcs dcn401_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index b8c47e4c51c1..ac9205625623 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -462,7 +462,6 @@ struct hw_sequencer_funcs {
 	void (*program_outstanding_updates)(struct dc *dc,
 			struct dc_state *context);
 	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
-	void (*wait_for_all_pending_updates)(const struct pipe_ctx *pipe_ctx);
 };
 
 void color_space_to_black_color(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 4e08e80eafe8..3d4c8bd42b49 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -342,9 +342,7 @@ struct timing_generator_funcs {
 	void (*wait_drr_doublebuffer_pending_clear)(struct timing_generator *tg);
 	void (*set_long_vtotal)(struct timing_generator *optc, const struct long_vtotal_params *params);
 	void (*wait_odm_doublebuffer_pending_clear)(struct timing_generator *tg);
-	bool (*get_optc_double_buffer_pending)(struct timing_generator *tg);
-	bool (*get_otg_double_buffer_pending)(struct timing_generator *tg);
-	bool (*get_pipe_update_pending)(struct timing_generator *tg);
+	bool (*get_double_buffer_pending)(struct timing_generator *tg);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 40757f20d73f..b7a57f98553d 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -202,7 +202,6 @@ struct dcn_optc_registers {
 	uint32_t OPTC_CLOCK_CONTROL;
 	uint32_t OPTC_WIDTH_CONTROL2;
 	uint32_t OTG_PSTATE_REGISTER;
-	uint32_t OTG_PIPE_UPDATE_STATUS;
 };
 
 #define TG_COMMON_MASK_SH_LIST_DCN(mask_sh)\
@@ -567,12 +566,6 @@ struct dcn_optc_registers {
 	type OTG_H_TIMING_DIV_MODE_DB_UPDATE_PENDING;\
 	type OPTC_DOUBLE_BUFFER_PENDING;\
 
-#define TG_REG_FIELD_LIST_DCN2_0(type) \
-	type OTG_FLIP_PENDING;\
-	type OTG_DC_REG_UPDATE_PENDING;\
-	type OTG_CURSOR_UPDATE_PENDING;\
-	type OTG_VUPDATE_KEEPOUT_STATUS;\
-
 #define TG_REG_FIELD_LIST_DCN3_2(type) \
 	type OTG_H_TIMING_DIV_MODE_MANUAL;
 
@@ -607,7 +600,6 @@ struct dcn_optc_registers {
 
 struct dcn_optc_shift {
 	TG_REG_FIELD_LIST(uint8_t)
-	TG_REG_FIELD_LIST_DCN2_0(uint8_t)
 	TG_REG_FIELD_LIST_DCN3_2(uint8_t)
 	TG_REG_FIELD_LIST_DCN3_5(uint8_t)
 	TG_REG_FIELD_LIST_DCN401(uint8_t)
@@ -615,7 +607,6 @@ struct dcn_optc_shift {
 
 struct dcn_optc_mask {
 	TG_REG_FIELD_LIST(uint32_t)
-	TG_REG_FIELD_LIST_DCN2_0(uint32_t)
 	TG_REG_FIELD_LIST_DCN3_2(uint32_t)
 	TG_REG_FIELD_LIST_DCN3_5(uint32_t)
 	TG_REG_FIELD_LIST_DCN401(uint32_t)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
index 928e110b95fb..364034b19028 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.h
@@ -43,8 +43,7 @@
 	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
 	SR(DWB_SOURCE_SELECT),\
 	SRI(OTG_MANUAL_FLOW_CONTROL, OTG, inst), \
-	SRI(OTG_DRR_CONTROL, OTG, inst),\
-	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
+	SRI(OTG_DRR_CONTROL, OTG, inst)
 
 #define TG_COMMON_MASK_SH_LIST_DCN2_0(mask_sh)\
 	TG_COMMON_MASK_SH_LIST_DCN(mask_sh),\
@@ -54,10 +53,6 @@
 	SF(OTG0_OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, mask_sh),\
 	SF(OTG0_OTG_GLOBAL_CONTROL2, DIG_UPDATE_LOCATION, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_RANGE_TIMING_DBUF_UPDATE_MODE, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
 	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_START_X, mask_sh),\
 	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_END_X, mask_sh), \
 	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_START_Y, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
index 4c95c0958612..abcd03d78668 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
@@ -271,48 +271,6 @@ void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 	optc1->opp_count = opp_cnt;
 }
 
-/* OTG status register that indicates OPTC update is pending */
-bool optc3_get_optc_double_buffer_pending(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	uint32_t update_pending = 0;
-
-	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
-			OPTC_DOUBLE_BUFFER_PENDING,
-			&update_pending);
-
-	return (update_pending == 1);
-}
-
-/* OTG status register that indicates OTG update is pending */
-bool optc3_get_otg_update_pending(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	uint32_t update_pending = 0;
-
-	REG_GET(OTG_DOUBLE_BUFFER_CONTROL,
-			OTG_UPDATE_PENDING,
-			&update_pending);
-
-	return (update_pending == 1);
-}
-
-/* OTG status register that indicates surface update is pending */
-bool optc3_get_pipe_update_pending(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	uint32_t flip_pending = 0;
-	uint32_t dc_update_pending = 0;
-
-	REG_GET_2(OTG_PIPE_UPDATE_STATUS,
-			OTG_FLIP_PENDING,
-			&flip_pending,
-			OTG_DC_REG_UPDATE_PENDING,
-			&dc_update_pending);
-
-	return (flip_pending == 1 || dc_update_pending == 1);
-}
-
 /**
  * optc3_set_timing_double_buffer() - DRR double buffering control
  *
@@ -417,9 +375,6 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.get_hw_timing = optc1_get_hw_timing,
 		.wait_drr_doublebuffer_pending_clear = optc3_wait_drr_doublebuffer_pending_clear,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
-		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
-		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
-		.get_pipe_update_pending = optc3_get_pipe_update_pending,
 };
 
 void dcn30_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
index e2303f9eaf13..bda974d432ea 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
@@ -109,8 +109,7 @@
 	SRI(OPTC_BYTES_PER_PIXEL, ODM, inst),\
 	SRI(OPTC_WIDTH_CONTROL, ODM, inst),\
 	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
-	SR(DWB_SOURCE_SELECT),\
-	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
+	SR(DWB_SOURCE_SELECT)
 
 #define DCN30_VTOTAL_REGS_SF(mask_sh)
 
@@ -210,7 +209,6 @@
 	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_GATE_DIS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
-	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_DOUBLE_BUFFER_PENDING, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_VCOUNT_INIT, mask_sh),\
@@ -321,11 +319,7 @@
 	SF(OTG0_OTG_DRR_V_TOTAL_CHANGE, OTG_DRR_V_TOTAL_CHANGE_LIMIT, mask_sh),\
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh)
 
 void dcn30_timing_generator_init(struct optc *optc1);
 
@@ -362,7 +356,4 @@ void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_c
 void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc);
 void optc3_tg_init(struct timing_generator *optc);
 void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max);
-bool optc3_get_optc_double_buffer_pending(struct timing_generator *optc);
-bool optc3_get_otg_update_pending(struct timing_generator *optc);
-bool optc3_get_pipe_update_pending(struct timing_generator *optc);
 #endif /* __DC_OPTC_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
index d7a45ef2d01b..1a22ae89fb55 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn301/dcn301_optc.c
@@ -169,9 +169,6 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.get_hw_timing = optc1_get_hw_timing,
 		.wait_drr_doublebuffer_pending_clear = optc3_wait_drr_doublebuffer_pending_clear,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
-		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
-		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
-		.get_pipe_update_pending = optc3_get_pipe_update_pending,
 };
 
 void dcn301_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
index fbbe86d00c2e..30b81a448ce2 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
@@ -99,8 +99,7 @@
 	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
 	SRI(OTG_CRC_CNTL2, OTG, inst),\
 	SR(DWB_SOURCE_SELECT),\
-	SRI(OTG_DRR_CONTROL, OTG, inst),\
-	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
+	SRI(OTG_DRR_CONTROL, OTG, inst)
 
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_1(mask_sh)\
 	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
@@ -255,11 +254,7 @@
 	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_COMBINE_MODE, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_SPLIT_MODE, mask_sh),\
 	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_FORMAT, mask_sh),\
-	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
 
 void dcn31_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
index 0ff72b97b465..99c098e76116 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
@@ -98,8 +98,7 @@
 	SRI(OPTC_BYTES_PER_PIXEL, ODM, inst),\
 	SRI(OPTC_WIDTH_CONTROL, ODM, inst),\
 	SRI(OPTC_MEMORY_CONFIG, ODM, inst),\
-	SRI(OTG_DRR_CONTROL, OTG, inst),\
-	SRI(OTG_PIPE_UPDATE_STATUS, OTG, inst)
+	SRI(OTG_DRR_CONTROL, OTG, inst)
 
 #define OPTC_COMMON_MASK_SH_LIST_DCN3_14(mask_sh)\
 	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
@@ -249,11 +248,7 @@
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE_MANUAL, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
-	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh),\
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
 
 void dcn314_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index c217f653b3c8..00094f0e8470 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -297,6 +297,18 @@ static void optc32_set_drr(
 	optc32_setup_manual_trigger(optc);
 }
 
+bool optc32_get_double_buffer_pending(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t update_pending = 0;
+
+	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
+			OPTC_DOUBLE_BUFFER_PENDING,
+			&update_pending);
+
+	return (update_pending == 1);
+}
+
 static struct timing_generator_funcs dcn32_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -361,9 +373,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
-		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
-		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
-		.get_pipe_update_pending = optc3_get_pipe_update_pending,
+		.get_double_buffer_pending = optc32_get_double_buffer_pending,
 };
 
 void dcn32_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
index 0b0964a9da74..665d7c52f67c 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
@@ -177,11 +177,7 @@
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
 	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE_MANUAL, mask_sh),\
 	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
-	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh)
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
 
 void dcn32_timing_generator_init(struct optc *optc1);
 void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode);
@@ -189,5 +185,6 @@ void optc32_get_odm_combine_segments(struct timing_generator *tg, int *odm_combi
 void optc32_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing);
 void optc32_wait_odm_doublebuffer_pending_clear(struct timing_generator *tg);
+bool optc32_get_double_buffer_pending(struct timing_generator *optc);
 
 #endif /* __DC_OPTC_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
index be749ab41dce..d077e2392379 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
@@ -67,11 +67,7 @@
 	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL_READBACK, OTG_CRC1_WINDOWB_Y_END_READBACK, mask_sh),\
 	SF(OPTC_CLOCK_CONTROL, OPTC_FGCG_REP_DIS, mask_sh),\
 	SF(OTG0_OTG_V_COUNT_STOP_CONTROL, OTG_V_COUNT_STOP, mask_sh),\
-	SF(OTG0_OTG_V_COUNT_STOP_CONTROL2, OTG_V_COUNT_STOP_TIMER, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh)
+	SF(OTG0_OTG_V_COUNT_STOP_CONTROL2, OTG_V_COUNT_STOP_TIMER, mask_sh)
 
 void dcn35_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index db670fc17264..a5d6a7dca554 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -493,9 +493,7 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
-		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
-		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
-		.get_pipe_update_pending = optc3_get_pipe_update_pending,
+		.get_double_buffer_pending = optc32_get_double_buffer_pending,
 };
 
 void dcn401_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index 1be89571986f..bb13a645802d 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -159,11 +159,7 @@
 	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_KEEPOUT_START, mask_sh),\
 	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_EXTEND, mask_sh),\
 	SF(OTG0_OTG_PSTATE_REGISTER, OTG_UNBLANK, mask_sh),\
-	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_ALLOW_WIDTH_MIN, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_FLIP_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_DC_REG_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_CURSOR_UPDATE_PENDING, mask_sh),\
-	SF(OTG0_OTG_PIPE_UPDATE_STATUS, OTG_VUPDATE_KEEPOUT_STATUS, mask_sh)
+	SF(OTG0_OTG_PSTATE_REGISTER, OTG_PSTATE_ALLOW_WIDTH_MIN, mask_sh)
 
 void dcn401_timing_generator_init(struct optc *optc1);
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 86c6e5e8c42e..7901792afb7b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -1054,8 +1054,7 @@ unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned
       SRI_ARR(OPTC_BYTES_PER_PIXEL, ODM, inst),                                \
       SRI_ARR(OPTC_WIDTH_CONTROL, ODM, inst),                                  \
       SRI_ARR(OPTC_MEMORY_CONFIG, ODM, inst),                                  \
-      SRI_ARR(OTG_DRR_CONTROL, OTG, inst),                                     \
-	  SRI_ARR(OTG_PIPE_UPDATE_STATUS, OTG, inst)
+      SRI_ARR(OTG_DRR_CONTROL, OTG, inst)
 
 /* HUBP */
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index bdafa7496cea..514d1ce20df9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -536,9 +536,8 @@ void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 	SRI_ARR(OPTC_WIDTH_CONTROL, ODM, inst),                                  \
 	SRI_ARR(OPTC_WIDTH_CONTROL2, ODM, inst),                                 \
 	SRI_ARR(OPTC_MEMORY_CONFIG, ODM, inst),                                  \
-	SRI_ARR(OTG_DRR_CONTROL, OTG, inst),                                     \
-	SRI_ARR(OTG_PSTATE_REGISTER, OTG, inst),                                 \
-	SRI_ARR(OTG_PIPE_UPDATE_STATUS, OTG, inst)
+	SRI_ARR(OTG_DRR_CONTROL, OTG, inst),										 \
+	SRI_ARR(OTG_PSTATE_REGISTER, OTG, inst)
 
 /* HUBBUB */
 #define HUBBUB_REG_LIST_DCN4_01_RI(id)                                       \
-- 
2.46.0

