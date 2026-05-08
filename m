Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB28CD37B7
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 18:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1043310F5CA;
	Fri,  8 May 2026 18:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wAS/tFeY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECBE10F5C4
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 18:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylVb1YIDxBpNw/NuepI25VB4VnBvb67/LcXINsVSZmvHLEraOYDc/pVWGZPlFJcw1oVs8KB6XcfkxuIbvhBrL6K9zUO3XnVJgrrkj+buzrXbCMVToJPDFc8HrY5xTrtLdffw4zP13qbWH0Vft7R1yu9z7YcuXcrjUfpUOXCrFGiCJ0fDis/SnwACmub3YnkRRvHqcHP1GE1mB9rMTMz1sFWF7WsQc/34vywheb9XG+m6sxo7WHo9w1PJJBpMxGGloKpYvPLmYdzhYI8T13uUhvbyy/onJtgY9d+8jZeF9m43q6fpfbMiTpDs0wB4eviIaSYNp14rrLvXv9ElPLgAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j57WM9BHCjTZ6nDkSfe5bRioSOL/xyfgLtzYChkbPg=;
 b=PXRILBXBf2I8Mj61ujNwfl/lrPs0zgylKr41N1ubGAS2guNkEL4LLzmvJ7Gta536X3I3e+lrTmz6HnLivfoSpX8i+YmpNEas2y+3PqCOCUb7tgvCy7/siW+6bHTsNcz2qtLdIR1XdJ7eUsV7v3MxlNX/I7wwFc5TePFQIdNPbAQPQC3fH+YnyaTLqdrYfX6QjYVnYALRZDnlpsDK6l/A7ZRvi09ipTU7Ov3SdV4lD8cBPUJppxbrAjfrTKTafTfDMCXePYtL7l8YZC4vRDq/sO1HkhdpYgt4uCh3JpCmU0HBXl74bexdJ5nKNyEcfurSlTLuvl6SOQCd1hbvyUU76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j57WM9BHCjTZ6nDkSfe5bRioSOL/xyfgLtzYChkbPg=;
 b=wAS/tFeYXEB4QAoa6Ff1HuhrIxGyAfkLNJQepDWUAlUx5z/2nZFYvctxqpdPHm9OOLIPA4Ep331Zgov8Y+uKi2emn+YuvrU7ldUPHtpvjLwlBmqHJezn1cW4kMFHjZvHX5+hbqRehLrpt+6zjYLv6AN74uDf8JOVoNLQM7rTBrs=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 18:28:25 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::71) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 18:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Fri, 8 May 2026 18:28:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 13:28:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 13:28:20 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 13:28:20 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v3 14/14] fixup! drm/amd/display: add HDMI 2.1 DSC over FRL
 support
Date: Fri, 8 May 2026 14:28:06 -0400
Message-ID: <20260508182808.520863-15-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508182808.520863-1-harry.wentland@amd.com>
References: <20260508182808.520863-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 4daa6633-da2c-4a74-03e2-08dead2f97cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|22082099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info: 1tG17GNMytx4hmu10dqjutn77q3ImltLYRcLCX5Ge4TG2W1zcWmVOjDJFixABzII+9eGdV5ndc/V84Pj3wckefgk7R6KxvLPh91BPHi/YMMOUagYEUWa6gHuFKYO/0ZaguYlcc6106baToqdHJfJZOn8fClf9h04qLKI4ky5YcvRUfwTPux/40oSVXs2YEqetgwvV35o+imrkpq99AzPHenhEQhZcv95RrKyBzTcnHXnAmJSj0Zu0+rFPxx7jVKuIkBenKsIwrbWSdgBa9nrF1rpYDlIq4XjIYO0ByShMv3jM4mbyqaygvbrF8JJJF7Lhabm3li7vchen/HqQC0t1aRXjJQLIBVWuKZQ+n+bmS/huXJaKxhUWwzme/l8UM4LptyOPsbbCT25IjVvLDpUiTYQChsSpp4qjU2CjIXNcjRYQ7x3yc0JkHj6xe0zVJhH+TZPCD81stO5ek0YhvmGDIQsfV2IqlIQP+1Yt3LM7lW2xGMx/GRJ3mpV/mIDRd1HdkQgE7s1uD//pg1zeQjUDp32aAdnYMzZVf1TSnOiQwyxVkJ/w4Kkft+d4DYnMbUaAb8X6fyZkh3W1PCKJFJYlN9ZCBckQp85CzEDOGKkbdkFhgrgwJSZA+Nqdg5HgG+Rvuw4ckHpMbTUgdgMLLfnoZjOVz+RwHQoKbO9AcVBMFcZY6XHVGDoQXi+LhBHUL86g1H1qbZYy6XEpeVM3OuuvX2lpMq47OawKQUwvM67Rak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: maAjaNQ/lm81XjxBOKECRGldSsgen4KYAtneLe92BJRndafMJ2AKXXr3X5w1gxLBxt8LoTOaLn1oTlLRxhwX8O3udO5K5oES2BWGCoC+CjjTo4lDdWJkf26gMeGMpBORrglWRpHz6n4MtjhDvAhzkWdT5dJ3bL9ISlwRKCUDQLGA4sLEqnHV+IPYNtQPPtKFIu7dk4mILkN7pOUJj737NPfcoEFBniohDXgdz5UvUyQ5wiaAZroNAzNEV4+96Ln/pNPPQskWG786qtmArGvv7HJXw1KNrWmC4t6crt96MNSt5bUCR1Qe/4AKiSLCcy4GehwuMwPOsvb/r+E2/axw5RvFfHR4bqCwxqIRYwQBjGMvfcBayK4KHsWK83O0nrrtxm9k7+jhKA8GM8js0bz2K/8Hmc45qnO1ntkzvsE0x0t/AtORkWouO2LOnNuXZ/JV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:28:25.3726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daa6633-da2c-4a74-03e2-08dead2f97cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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

---
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  9 --------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  3 ---
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  1 -
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  1 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 -
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 -
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |  1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  3 ---
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 -
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    | 22 -------------------
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |  1 -
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |  1 -
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |  1 -
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  1 -
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |  1 -
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  1 -
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    |  1 -
 20 files changed, 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index a416efcc9325..cfca7af6cd1f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -955,15 +955,6 @@ enum dc_status dcn30_setup_hdmi_frl_link(
 	return status;
 }
 
-void dcn30_hw_set_vstartup_dsc_frl(struct dc *dc,
-		struct pipe_ctx *pipe_ctx)
-{
-	(void)dc;
-	if (pipe_ctx->stream_res.tg->funcs->set_vstartup_dsc_frl)
-		pipe_ctx->stream_res.tg->funcs->set_vstartup_dsc_frl(
-			pipe_ctx->stream_res.tg);
-}
-
 bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
 	union dmub_rb_cmd cmd;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 2306354e90af..a963d360a368 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -85,9 +85,6 @@ int dcn30_hw_get_max_fva_factor(struct dc *dc,
 		struct dc_crtc_timing *timing,
 		unsigned int max_pixel_clock);
 
-void dcn30_hw_set_vstartup_dsc_frl(struct dc *dc,
-		struct pipe_ctx *pipe_ctx);
-
 bool dcn30_does_plane_fit_in_mall(struct dc *dc,
 		unsigned int pitch,
 		unsigned int height,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index cd151c75f59e..26c7386a8a36 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -106,7 +106,6 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.enable_dp_link_output = dce110_enable_dp_link_output,
 	.disable_link_output = dce110_disable_link_output,
 	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
-	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 69b8e7030fa4..23b30d6f3956 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -99,7 +99,6 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
-	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 8c50604a4895..98771fc443c7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -101,7 +101,6 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
-	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 203c4f7ecd2b..0b3e8512ebf1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
-	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
 	.get_max_dispclk_mhz = dcn32_get_max_dispclk_mhz,
 	.apply_idle_power_optimizations = dcn32_apply_idle_power_optimizations,
 	.does_plane_fit_in_mall = NULL,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index c0cefeff6e85..fc18d2207711 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -108,7 +108,6 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
-	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
 	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index a852a2345296..19ec5b4edfdc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -101,7 +101,6 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
-	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
 	.set_backlight_level = dcn31_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index e1cc16aa207c..d24a352937b4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -85,7 +85,6 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
-	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
 	.apply_idle_power_optimizations = dcn401_apply_idle_power_optimizations,
 	.does_plane_fit_in_mall = NULL,
 	.set_backlight_level = dcn31_set_backlight_level,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index e54d814b3ea9..49c13611a518 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -86,7 +86,6 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
-	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
 	.apply_idle_power_optimizations = dcn35_apply_idle_power_optimizations,
 	.does_plane_fit_in_mall = NULL,
 	.set_backlight_level = dcn31_set_backlight_level,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 34e386e16d0c..2d74186844d4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1437,9 +1437,6 @@ struct hw_sequencer_funcs {
 	unsigned int (*get_max_dispclk_mhz)(struct dc *dc,
 			struct dc_state *context);
 
-	void (*set_vstartup_dsc_frl)(struct dc *dc,
-			struct pipe_ctx *pipe_ctx);
-
 	/* Idle Optimization Related */
 	bool (*apply_idle_power_optimizations)(struct dc *dc, bool enable);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index cf124838f354..8f72322aab4b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -498,7 +498,6 @@ struct timing_generator_funcs {
 	int (*get_max_hw_supported_fva_factor)(struct timing_generator *optc,
 		struct dc_crtc_timing *timing,
 		unsigned int max_pixclk_100hz);
-	void (*set_vstartup_dsc_frl)(struct timing_generator *optc);
 	void (*set_vtotal_change_limit)(struct timing_generator *optc,
 			uint32_t limit);
 	void (*align_vblanks)(struct timing_generator *master_optc,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
index 78fd8d262de3..90ec4cb8a9dd 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
@@ -320,27 +320,6 @@ bool optc3_get_pipe_update_pending(struct timing_generator *optc)
 	return (flip_pending == 1 || dc_update_pending == 1);
 }
 
-void optc3_set_vstartup_dsc_frl(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	unsigned int vblank_end = 0;
-	unsigned int vstartup_start = 0;
-
-	REG_GET(OTG_V_BLANK_START_END, OTG_V_BLANK_END, &vblank_end);
-	REG_GET(OTG_VSTARTUP_PARAM, VSTARTUP_START, &vstartup_start);
-
-	/* In FRL+DSC mode the VSYNC is generated in OTG at start of HBALNK
-	 * before frame start (VCOUNT=0 and HCOUNT=0). We need to program
-	 *  VSTARTUP at least one line before frame start to ensure the VSYNC
-	 *  will be generated in VRR mode. We need to program
-	 *  VSTARTUP_START >= V_BLANK_END + 1.
-	 *  When fullscreen = false,
-	 *  global_sync will restore VSTARTUP_START to normal value
-	 */
-	if (vblank_end >= vstartup_start)
-		REG_SET(OTG_VSTARTUP_PARAM, 0, VSTARTUP_START,
-				vblank_end+1);
-}
 /**
  * optc3_set_timing_double_buffer() - DRR double buffering control
  *
@@ -436,7 +415,6 @@ static const struct timing_generator_funcs dcn30_tg_funcs = {
 		.get_optc_source = optc2_get_optc_source,
 		.set_out_mux = optc3_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
 		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
index 8a88867f4361..16c5610b49ac 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
@@ -349,7 +349,6 @@ void optc3_triplebuffer_lock(struct timing_generator *optc);
 void optc3_program_blank_color(struct timing_generator *optc,
 		const struct tg_color *blank_color);
 
-void optc3_set_vstartup_dsc_frl(struct timing_generator *optc);
 void optc3_set_vtotal_change_limit(struct timing_generator *optc,
 		uint32_t limit);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index bbf703777f72..98aaa22ce81c 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -500,7 +500,6 @@ static const struct timing_generator_funcs dcn31_tg_funcs = {
 		.get_optc_source = optc2_get_optc_source,
 		.set_out_mux = optc3_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
 		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
index 4d4b517575e2..a7cf34937b2f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
@@ -244,7 +244,6 @@ static const struct timing_generator_funcs dcn314_tg_funcs = {
 		.get_optc_source = optc2_get_optc_source,
 		.set_out_mux = optc3_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
 		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 99258b2fb14e..60e546b69a05 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -354,7 +354,6 @@ static const struct timing_generator_funcs dcn32_tg_funcs = {
 		.get_optc_source = optc2_get_optc_source,
 		.set_out_mux = optc3_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
 		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index f6183c2e78e4..a880e4a6d165 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -595,7 +595,6 @@ static const struct timing_generator_funcs dcn35_tg_funcs = {
 		.set_h_timing_div_manual_mode = optc32_set_h_timing_div_manual_mode,
 		.set_out_mux = optc3_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
 		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 581517c9cec4..a6d76f451cf8 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -521,7 +521,6 @@ static const struct timing_generator_funcs dcn401_tg_funcs = {
 		.get_optc_source = optc2_get_optc_source,
 		.set_out_mux = optc401_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
 		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
index f5280bc3c7ec..ed66a2bbb8ae 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
@@ -250,7 +250,6 @@ static struct timing_generator_funcs dcn42_tg_funcs = {
 		.wait_otg_disable = optc35_wait_otg_disable,
 		.set_out_mux = optc401_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
 		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
 		.set_gsl = optc2_set_gsl,
 		.set_gsl_source_select = optc2_set_gsl_source_select,
-- 
2.54.0

