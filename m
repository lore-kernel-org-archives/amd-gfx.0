Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B09C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 652C010ED53;
	Thu, 30 Mar 2023 08:59:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F02EB10ED53
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMwRIVjmdL2I8NFacMWKLYrZGA9GFbHomYHI1gJkDBBVKa4KgBoEws25X7qwzuESFM75TbLI1YoGTYfj1Gh73va/jTvPGhQ/k2UaCd0QXOh3xX59S/jtFP9BfG57N8ZtAIu/XMoEcpM+0s/RChs5RB8jVEKRiP0naElBfDSMvCBif1EhGi0ObEIvIYcq2vbVUxYExqnWzV62lhp7oXgXt+sJjQQk2LoJ921WH5d0+Il8dDOuM5l9f1qtEO0d5mcgkzXcQKraN8ebWOr1VcNwsQ+CMULoR786qnDHSHYZNTwbkXXnea8Mk4xPFX3w2CcnReOFfVeLxLPqL4hEOnG77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQJfO6IERHTwrUHUZ5D2bNJHh5rsbDlwl+U+qZiq4K4=;
 b=jlY/ky65dbCJvAdR06UY7F11Tk8rdPdnhQlVkk4XkiUoQww7ip3c77bwsFH54YKpB8SjvR4yj9r51qHsER8c0rGq55liMCQ0wi2reEowzXEUgP0bPX6LrpHMuAy3ebKMjUp16UApuGqjRZ8ZmdxmDjn1RH482RAXE9fL6JsQu5Yh6c/TknX4/j46GZCGchPcoCpQBtoYcmBaIkx03rhtFGLD0r1QFKzjt3dlcW/vjY3MgsqlXpTnlLhiSTmkEhMfr3bt5yRrkf2wcU4llRGWteCmp4CGtdVFLvvoOiagXWTQb7ZoTeigbdbOL8KXPYI7qFBH70EsltyirlBDve46Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQJfO6IERHTwrUHUZ5D2bNJHh5rsbDlwl+U+qZiq4K4=;
 b=ebTkeq3PVnDe7S8Kjuvt91WA0jILAwBbqzNxymmMSAdDCu01A1bitbAWS3+FKKniVTa3pRq2trVUXhPbwIMwl9s2AU545VWjgP65kgmXnWz9rOPs0ig7n9BG/W/qiSq5qTDRh6B+wg3OxpNBjZpocz0U+uAS7zvZit4CxxAIKq4=
Received: from BN9PR03CA0564.namprd03.prod.outlook.com (2603:10b6:408:138::29)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.28; Thu, 30 Mar 2023 08:59:36 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::41) by BN9PR03CA0564.outlook.office365.com
 (2603:10b6:408:138::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 08:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Thu, 30 Mar 2023 08:59:36 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:59:05 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/10] drm/amd/display: Add FPO + VActive support
Date: Thu, 30 Mar 2023 04:57:15 -0400
Message-ID: <20230330085720.3863-6-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c68b5b3-1b40-406d-443b-08db30fd167d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8h14GY8Jg8qEQlB+FC6fFkPMVl/ThVyonNbvB4k128OTNtxLcMM9DJfdBumDByRFESPVkRm/MMXiHGN3hs7xjyTj23AtrS0Id7nAeANHaBuc9XF05LBQQgweTn2OZYpj8//ocN87WwxEG/uwYHWrU7Ip38FPgEcPxQVhheJzwQvKNB2ZAS82U2E7UiOqm3/pm/A3hAPLv7HjE+cbfwwcrmRdgBYjVjDLkgISK0OqoXGmOtNsX27G7z6pooOVlZpeLECP9bY/X161uIcdtqULx0iGgn91g9jc95LY2yScx/Nqj51+l20wCyWesP7RRt36KckE/SrGrZbvLno9M0g9rDVPLm7Yn5Pkit/8XDal6S/WCzaGzOxJTdZNMxTcOMbeQm5muv4niYcMkLjpDT5WJY3lLxHsuJxEYSAmPwd9BVOCeEj4UJ9AirddZEjD+cdCJXBcrjnAxgEWhSj1heeN5+/ojFV3pSXTuEdRDURkT0B7v+RdQaW6LyGsNYe9YjltcIVAW0KOISKwEMvkoG/VxJOw7CilKsccJViP6mxncJHcgHUhIl1hwcx0gfZghltr4+HLA8znHQswLx+CatQdq67Ed/1vOMRnzCbEa1NRV5PONC89S0BulvxBi6tNVuCzFSWwkCPDZXt1EYgRirqheE3HJtYyq2Sah6cMxzcN1v3v9ZcalzhTwrU2BtGH2CLtWrT2kP+d8mrVObZBIcSzSF1RKspWDHFZ0V4UvDrsSGQEViy3C4LOfXwvTcx80zAm2N6JCRpMUUHXEPtyMQbAAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(2906002)(83380400001)(426003)(336012)(2616005)(86362001)(36860700001)(36756003)(82740400003)(41300700001)(5660300002)(81166007)(40460700003)(40480700001)(356005)(478600001)(30864003)(8676002)(54906003)(6916009)(70206006)(70586007)(4326008)(82310400005)(6666004)(186003)(1076003)(16526019)(26005)(316002)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:59:36.4287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c68b5b3-1b40-406d-443b-08db30fd167d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- When determining FPO support, include FPO + VActive support
- Support FPO + VActive if one display meets regular requirements
  for FPO and the second display is able to switch in VACTIVE with
  a given amount of margin

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  20 +++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   2 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   3 +
 .../display/dc/dcn32/dcn32_resource_helpers.c | 156 ++++++++++++++++++
 .../amd/display/dc/dcn321/dcn321_resource.c   |   2 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  81 ++++++++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   4 +
 8 files changed, 267 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e363a3c88250..719727a2f939 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -875,6 +875,8 @@ struct dc_debug_options {
 	bool override_dispclk_programming;
 	bool disable_fpo_optimizations;
 	bool support_eDP1_5;
+	uint32_t fpo_vactive_margin_us;
+	bool disable_fpo_vactive;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index dd6f643254fe..a9b9490a532c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -327,6 +327,7 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	int i = 0, k = 0;
 	int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
 	uint8_t visual_confirm_enabled;
+	int pipe_idx = 0;
 
 	if (dc == NULL)
 		return false;
@@ -339,6 +340,25 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	cmd.fw_assisted_mclk_switch.config_data.fams_enabled = should_manage_pstate;
 	cmd.fw_assisted_mclk_switch.config_data.visual_confirm_enabled = visual_confirm_enabled;
 
+	if (should_manage_pstate) {
+		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+			if (!pipe->stream)
+				continue;
+
+			/* If FAMS is being used to support P-State and there is a stream
+			 * that does not use FAMS, we are in an FPO + VActive scenario.
+			 * Assign vactive stretch margin in this case.
+			 */
+			if (!pipe->stream->fpo_in_use) {
+				cmd.fw_assisted_mclk_switch.config_data.vactive_stretch_margin_us = dc->debug.fpo_vactive_margin_us;
+				break;
+			}
+			pipe_idx++;
+		}
+	}
+
 	for (i = 0, k = 0; context && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 502f990346b1..99d417fa6458 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -726,6 +726,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_unbounded_requesting = false,
 	.override_dispclk_programming = true,
 	.disable_fpo_optimizations = false,
+	.fpo_vactive_margin_us = 2000, // 2000us
+	.disable_fpo_vactive = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 3f5e92ef0c99..3937dbc1e552 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -39,6 +39,7 @@
 #define DCN3_2_MBLK_HEIGHT_8BPE 64
 #define DCN3_2_VMIN_DISPCLK_HZ 717000000
 #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
+#define DCN3_2_MIN_ACTIVE_SWITCH_MARGIN_FPO_US 100 // Only allow FPO + Vactive if active margin >= 100
 
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
@@ -146,6 +147,8 @@ void dcn32_restore_mall_state(struct dc *dc,
 		struct dc_state *context,
 		struct mall_temp_config *temp_config);
 
+struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, const struct dc_state *context);
+
 bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe);
 
 unsigned int dcn32_calc_num_avail_chans_for_mall(struct dc *dc, int num_chans);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 47fa51c1d3f4..eeca16faf31a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -27,6 +27,7 @@
 #include "dcn32_resource.h"
 #include "dcn20/dcn20_resource.h"
 #include "dml/dcn32/display_mode_vba_util_32.h"
+#include "dml/dcn32/dcn32_fpu.h"
 
 static bool is_dual_plane(enum surface_pixel_format format)
 {
@@ -500,3 +501,158 @@ void dcn32_restore_mall_state(struct dc *dc,
 			pipe->plane_state->is_phantom = temp_config->is_phantom_plane[i];
 	}
 }
+
+#define MAX_STRETCHED_V_BLANK 1000 // in micro-seconds (must ensure to match value in FW)
+/*
+ * Scaling factor for v_blank stretch calculations considering timing in
+ * micro-seconds and pixel clock in 100hz.
+ * Note: the parenthesis are necessary to ensure the correct order of
+ * operation where V_SCALE is used.
+ */
+#define V_SCALE (10000 / MAX_STRETCHED_V_BLANK)
+
+static int get_frame_rate_at_max_stretch_100hz(
+		struct dc_stream_state *fpo_candidate_stream,
+		uint32_t fpo_vactive_margin_us)
+{
+	struct dc_crtc_timing *timing = NULL;
+	uint32_t sec_per_100_lines;
+	uint32_t max_v_blank;
+	uint32_t curr_v_blank;
+	uint32_t v_stretch_max;
+	uint32_t stretched_frame_pix_cnt;
+	uint32_t scaled_stretched_frame_pix_cnt;
+	uint32_t scaled_refresh_rate;
+	uint32_t v_scale;
+
+	if (fpo_candidate_stream == NULL)
+		return 0;
+
+	/* check if refresh rate at least 120hz */
+	timing = &fpo_candidate_stream->timing;
+	if (timing == NULL)
+		return 0;
+
+	v_scale = 10000 / (MAX_STRETCHED_V_BLANK + fpo_vactive_margin_us);
+
+	sec_per_100_lines = timing->pix_clk_100hz / timing->h_total + 1;
+	max_v_blank = sec_per_100_lines / v_scale + 1;
+	curr_v_blank = timing->v_total - timing->v_addressable;
+	v_stretch_max = (max_v_blank > curr_v_blank) ? (max_v_blank - curr_v_blank) : (0);
+	stretched_frame_pix_cnt = (v_stretch_max + timing->v_total) * timing->h_total;
+	scaled_stretched_frame_pix_cnt = stretched_frame_pix_cnt / 10000;
+	scaled_refresh_rate = (timing->pix_clk_100hz) / scaled_stretched_frame_pix_cnt + 1;
+
+	return scaled_refresh_rate;
+
+}
+
+static bool is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(
+		struct dc_stream_state *fpo_candidate_stream, uint32_t fpo_vactive_margin_us)
+{
+	int refresh_rate_max_stretch_100hz;
+	int min_refresh_100hz;
+
+	if (fpo_candidate_stream == NULL)
+		return false;
+
+	refresh_rate_max_stretch_100hz = get_frame_rate_at_max_stretch_100hz(fpo_candidate_stream, fpo_vactive_margin_us);
+	min_refresh_100hz = fpo_candidate_stream->timing.min_refresh_in_uhz / 10000;
+
+	if (refresh_rate_max_stretch_100hz < min_refresh_100hz)
+		return false;
+
+	return true;
+}
+
+static int get_refresh_rate(struct dc_stream_state *fpo_candidate_stream)
+{
+	int refresh_rate = 0;
+	int h_v_total = 0;
+	struct dc_crtc_timing *timing = NULL;
+
+	if (fpo_candidate_stream == NULL)
+		return 0;
+
+	/* check if refresh rate at least 120hz */
+	timing = &fpo_candidate_stream->timing;
+	if (timing == NULL)
+		return 0;
+
+	h_v_total = timing->h_total * timing->v_total;
+	if (h_v_total == 0)
+		return 0;
+
+	refresh_rate = ((timing->pix_clk_100hz * 100) / (h_v_total)) + 1;
+	return refresh_rate;
+}
+
+/**
+ * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch - Determines if config can support FPO
+ *
+ * @param [in]: dc - current dc state
+ * @param [in]: context - new dc state
+ *
+ * Return: Pointer to FPO stream candidate if config can support FPO, otherwise NULL
+ */
+struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, const struct dc_state *context)
+{
+	int refresh_rate = 0;
+	const int minimum_refreshrate_supported = 120;
+	struct dc_stream_state *fpo_candidate_stream = NULL;
+	bool is_fpo_vactive = false;
+	uint32_t fpo_vactive_margin_us = 0;
+
+	if (context == NULL)
+		return NULL;
+
+	if (dc->debug.disable_fams)
+		return NULL;
+
+	if (!dc->caps.dmub_caps.mclk_sw)
+		return NULL;
+
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching_shut_down)
+		return NULL;
+
+	/* For FPO we can support up to 2 display configs if:
+	 * - first display uses FPO
+	 * - Second display switches in VACTIVE */
+	if (context->stream_count > 2)
+		return NULL;
+	else if (context->stream_count == 2) {
+		DC_FP_START();
+		dcn32_assign_fpo_vactive_candidate(dc, context, &fpo_candidate_stream);
+		DC_FP_END();
+
+		DC_FP_START();
+		is_fpo_vactive = dcn32_find_vactive_pipe(dc, context, DCN3_2_MIN_ACTIVE_SWITCH_MARGIN_FPO_US);
+		DC_FP_END();
+		if (!is_fpo_vactive || dc->debug.disable_fpo_vactive)
+			return NULL;
+	} else
+		fpo_candidate_stream = context->streams[0];
+
+	if (!fpo_candidate_stream)
+		return NULL;
+
+	if (fpo_candidate_stream->sink->edid_caps.panel_patch.disable_fams)
+		return NULL;
+
+	refresh_rate = get_refresh_rate(fpo_candidate_stream);
+	if (refresh_rate < minimum_refreshrate_supported)
+		return NULL;
+
+	fpo_vactive_margin_us = is_fpo_vactive ? dc->debug.fpo_vactive_margin_us : 0; // For now hardcode the FPO + Vactive stretch margin to be 2000us
+	if (!is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(fpo_candidate_stream, fpo_vactive_margin_us))
+		return NULL;
+
+	// check if freesync enabled
+	if (!fpo_candidate_stream->allow_freesync)
+		return NULL;
+
+	if (fpo_candidate_stream->vrr_active_variable)
+		return NULL;
+
+	return fpo_candidate_stream;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 79664ba7e7af..7ebd14fb9698 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -724,6 +724,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_unbounded_requesting = false,
 	.override_dispclk_programming = true,
 	.disable_fpo_optimizations = false,
+	.fpo_vactive_margin_us = 2000, // 2000us
+	.disable_fpo_vactive = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index c252fdf2c0e8..4548320217fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1927,6 +1927,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	unsigned int min_dram_speed_mts_margin;
 	bool need_fclk_lat_as_dummy = false;
 	bool is_subvp_p_drr = false;
+	struct dc_stream_state *fpo_candidate_stream = NULL;
 
 	dc_assert_fp_enabled();
 
@@ -1968,8 +1969,11 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	if (!pstate_en || (!dc->debug.disable_fpo_optimizations &&
 			pstate_en && vlevel != 0)) {
 		/* only when the mclk switch can not be natural, is the fw based vblank stretch attempted */
-		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching =
-			dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(dc, context);
+		fpo_candidate_stream = dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch(dc, context);
+		if (fpo_candidate_stream) {
+			fpo_candidate_stream->fpo_in_use = true;
+			context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = true;
+		}
 
 		if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
 			dummy_latency_index = dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(dc,
@@ -2161,7 +2165,13 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 		 * DCFCLK: Min, as reported by PM FW, when available
 		 * UCLK: Min, as reported by PM FW, when available
 		 */
-		dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
+
+		/* For set A set the correct latency values (i.e. non-dummy values) unconditionally
+		 */
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
+
 		context->bw_ctx.bw.dcn.watermarks.a.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
@@ -2796,3 +2806,68 @@ double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *conte
 	}
 	return max_vratio_pre;
 }
+
+/**
+ * dcn32_assign_fpo_vactive_candidate - Assign the FPO stream candidate for FPO + VActive case
+ *
+ * This function chooses the FPO candidate stream for FPO + VActive cases (2 stream config).
+ * For FPO + VAtive cases, the assumption is that one display has ActiveMargin > 0, and the
+ * other display has ActiveMargin <= 0. This function will choose the pipe/stream that has
+ * ActiveMargin <= 0 to be the FPO stream candidate if found.
+ *
+ *
+ * @param [in]: dc - current dc state
+ * @param [in]: context - new dc state
+ * @param [out]: fpo_candidate_stream - pointer to FPO stream candidate if one is found
+ *
+ * Return: void
+ */
+void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *context, struct dc_stream_state **fpo_candidate_stream)
+{
+	unsigned int i, pipe_idx;
+	const struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		const struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] <= 0) {
+			*fpo_candidate_stream = pipe->stream;
+			break;
+		}
+		pipe_idx++;
+	}
+}
+
+/**
+ * dcn32_find_vactive_pipe - Determines if the config has a pipe that can switch in VACTIVE
+ *
+ * @param [in]: dc - current dc state
+ * @param [in]: context - new dc state
+ * @param [in]: vactive_margin_req_us - The vactive marign required for a vactive pipe to be
+ *                                      considered "found"
+ *
+ * Return: True if VACTIVE display is found, false otherwise
+ */
+bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint32_t vactive_margin_req_us)
+{
+	unsigned int i, pipe_idx;
+	const struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+	bool vactive_found = false;
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		const struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] >= vactive_margin_req_us) {
+			vactive_found = true;
+			break;
+		}
+		pipe_idx++;
+	}
+	return vactive_found;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index ab010e7e840b..9a0806a0e2ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -76,4 +76,8 @@ void dcn32_patch_dpm_table(struct clk_bw_params *bw_params);
 void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
 				  int pipe_cnt);
 
+void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *context, struct dc_stream_state **fpo_candidate_stream);
+
+bool dcn32_find_vactive_pipe(struct dc *dc, const struct dc_state *context, uint32_t vactive_margin_req);
+
 #endif
-- 
2.34.1

