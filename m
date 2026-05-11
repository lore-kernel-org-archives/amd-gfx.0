Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EB7CD484A
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 15:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BEE610E7FD;
	Mon, 11 May 2026 15:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kLClCdxD";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A8710E7E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 15:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1b7asJku01JrhZ3BHX72rfeOtBJReHCV4Pehj6xmNdQPJ2dkcp/08SMF9KjoH2+UJ8Xn+hiGJWWl/CPwptCC++GZYbc7v7bsrzfHTJ0HWwO47AsxDcZwjJvoqhWH/YZ4Dw5RUiKmX4oRYa6bbcMmJcCht2vpXOFxD87ktmbbKbUpvG0g/A7KYPh6BHfw0aUbN72qcPqJFqfer0FEHcyzaTnVwbdk1kcxWEpoXAkcWwT4qqTZ5a/ebj2nC3tewxuIqXNqRuXWnuMEnKqYrVCQp9nnSNVm/XTUsqsgElqW7EBTg1axZVENy32wO5muZ/CZh7ISWXmOQFEAyVrToccwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j57WM9BHCjTZ6nDkSfe5bRioSOL/xyfgLtzYChkbPg=;
 b=FHPrOb2IZp9ybmBF+l1QLYtbRmzUliGy2XbRc6vH61umjc3W/i4rGAhxsX92liX+pvmN9U1mU7oqLp0I9B/u9Z+JN/iO6UmFG1IAnHghHPnOaYfmHZ+mzeWu44XbZxS2lmQJ0oGHFQy4+L+lKXSKDNTXvbg65HL3KLfz6fGzJEBPfm4Fvo/lnQkiR2x9c6oqPVjSCwUKwxO66MkOWF3u9nPZgI93ORmoGEvglX00REM/ytGlgE3d0FjpuA/98NHszslqWOfcB+LWVleomkw2k+d9ADQU/ZQf4dfuB0EQPp1YOmLrIS6eYEVC1YwqFcpyDwf6leUukH3dbuY3jvPS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j57WM9BHCjTZ6nDkSfe5bRioSOL/xyfgLtzYChkbPg=;
 b=kLClCdxD9+T4J2L1UALV1wJAQa57aaQvjZ4Ni3kgqXQXy6/poXAHCEnA7Xyua1YHOI20qgGYIvtj6E6FHYyNvW/QUvVzduRKw8F0CGZ5uEkWcYz8jA1RuU65XSNdyvkOrlo6Jv03B+3hjKDaSdbj8alJFPQqjeY0FlVVncHq16U=
Received: from MN2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:208:234::34)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:52:31 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::ed) by MN2PR16CA0065.outlook.office365.com
 (2603:10b6:208:234::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 15:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 15:52:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 10:52:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 10:52:26 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 10:52:26 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jerry.Zuo@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH RESEND v3 14/14] fixup! drm/amd/display: add HDMI 2.1 DSC over
 FRL support
Date: Mon, 11 May 2026 11:52:11 -0400
Message-ID: <20260511155212.73586-15-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511155212.73586-1-harry.wentland@amd.com>
References: <20260511155212.73586-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: b3866960-c178-4e7e-345c-08deaf754f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|3023799003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2m8Tk3s7L5vyWZz1hhqveKsOtxmQeVSNC+C2oeyRzlQN8SSLjbocjV9L2rafJ4DmkFtqAvhk952Ix+1CCZyMhN9A0Q7eeeLqS2ajgysNgOADqd6Ss4M0dN/ctc+7BxwOzUkWycIsDt47is6EnxLSSm1s1AuhI1UNqn02HT28pHaxN8AUQh9V47DV0HqXKBUMsQxOsQCiQA7GtRBs+Qv62VO6MxXA8+NQ2UiKqWMW4NJuixbjIENzSD2svYQGlrAinuk9D/odWcmXBNbc1u3ICzcvxxm12unr9n8dWaaF5IwZYCi/QziGGS2BKsBNLZYExG1qvNSKKG1N8piJPu1NyQCwQVejIMusH4REjJUkeqHWwFCRrqVncsjs913Cb62EyC/q4Li77p0xpftD0j7xk6SUXBk+YsnplzEU5EnhRHYHqKT3T5i7UzJcRiwQGi3/nY3cDQVZ4qSb4r7STFUe01zbrEudj4i5zXoh67ACr6bgUIhMC9+wtxEirPEYzp0JwsFqJi7+w7ErlgxzFACCmrwfe/nW00XhnZaD2Fp1Wtd8qAlTWslnjVHc7V8/GUVN/ZtLLWKgU/P/cxaCtEfIFh+2/sgveDfZqJ+uYpQjLAB4CjuxvfBWza3WrBZcTDDHeikpI6Vl6r29cNIZW4Lv0c/l+go8n/1ZBCeVZXC7IIfWJXkpIdZ0pp6QQxTbu9Rj4WeO35HcuogIjeNbvLvUtptAlhFEW8y0vZvpHlKgVOc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(3023799003)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OtNmGYsi1EmuUQjDmkANwVQVjWN+yDrpJGa7DUpwABbITCYtpf2rwR4U8MKavW1e8wJQ/znAJm3u1jYLo7llyeFPXp2KYOIGCVu+dn2Rlnx2+8WZ6tYqKhnKhE4JQWUDwqrnIuClL/nqERQL39iGJWxbN4tYx+dZtAPBHFpmAKEzoXbqtRpKtDDCPYwRoGFJEgI50L8VLrN8jFfXMaAc9Lpiqb592pCvH9XuGqwe3XfKKfSZ59Q7HIu9Z29NU7Gf7EAYbBN+/kU5azR38vH/Ho37BWJbmIYp038kDW+NXCezR0TDTs7eOf/1sd65rzfEQU+lj4lNXtFuJb8/NJAvUIrPoBMRtoD30mSoWzejir3GDjNmLMJOC63nlYGVO5C6rnUwBJV54/3SOxPf6p5StlCIPPBFpuL76FAXIKdnTEimLfLRWUpd35TxoglSWatv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:52:30.8207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3866960-c178-4e7e-345c-08deaf754f3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
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

