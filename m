Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15209C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D4110E9C6;
	Wed, 28 Sep 2022 19:41:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA5F10E9AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeQmWdfa60/i6V+nmU5y2QMz9xXWbJS9AUCaSfKYUMeHuVx2THbtK0zab27ACTBwTGTU5Mkr9iCfg2Rv1XtG3GIJQ8EAC0knYdTSZe3WRcV4syzoGt5fZ9h/PL/MAGqibzSF/mnP4U4HNl7yQ2h0+Dm2v5R2eLgZ7GV2PAYkVdn75aJpfTgEeV1JWg/XCHtrL0pRlv/nL3g3OcNi52HbAiKrc8EN1N6fv71Z8S9H1TTk7ehcKrBnMtXdZ8Mfnovhah7likj1KwDncV+c2opyp23JTCC5W5r2raT6idutcEJD46XaSGjaG57TD+6yBHsu5nHIjzFzp3htC+C5r/7yzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SwFZ13Wnj86oSZR1/6Qk9LCGRKKk7qQ10sz1L1OoLE=;
 b=Ryu8slXZMK1FE7pSLZd0op7JHmGVwEgHze3H4pebzU9FLeL8LGVp19eK4y6YWPSqjr2R2sLzZHNdW9pqAVeJwvjtxAGnnp9vwBN7tC8Y3Zbn3CXFgwVkuasF8KMR4IB0OTCJLGA6Qxf5H/5m0GvSAdokzSgoLmkXa249LgnW7hUIb69Suz4XfBQzM4H/8khjWOA6BDMplPxwf+J2RldXh0YvgX8NfrToWCaCujLcG7qtQCljL86Gw7xN+xun2EvFJ9E3V+4AFfG1D8J0kQiXbs+oIhbUAo/K/oC7FxWyhBJNUSR7//0XUzTizZ+5wW97TajMdo4DqUA/3wLiZz2+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SwFZ13Wnj86oSZR1/6Qk9LCGRKKk7qQ10sz1L1OoLE=;
 b=bal+wakUncJM87KiDAaWUaWduNhq0wuskxWvO61lX8Sw5YNs/fqfFl/bLaOq/u9shMXVwgHb4DImhn37z+N9+czZTW4JR15+OCdGdRdXa+dXgF8Ge1C1i+UzFAUSiBAzThFsVjuJLVgDkUbS6tnXsaT7BaZYQHQpyfhuKBRSqto=
Received: from BN0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:e7::31)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 19:40:56 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::a9) by BN0PR03CA0056.outlook.office365.com
 (2603:10b6:408:e7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:40:56 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:40:54 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/36] drm/amd/display: Refactor edp ILR caps codes
Date: Wed, 28 Sep 2022 15:39:59 -0400
Message-ID: <20220928194028.144879-8-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ad5675-9a9e-40a5-affb-08daa1895cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9MadqMuFjhAhhemv29bBL7bP004LvNxHS3FAkaOuWo/LrubwpSDbUyQ5V+6YEU+0GFJDTGpa6ecSi9Bl0Bgr2GOEBM/w7HAWC4JdGrF/7RdyYgrn+Sgg6heFV/umW0lN6Y8W2sIkkiA2qlEHdEKdK3hUTbgSddNyjN4GZ/vaPhzxUn3tDXr3aGHxoSiqoc217a6IpBxrQUUWnXzEeW4mMySLH6AhHBJSxAuqmiPcQaMIkSoK7GxCdo8NhL9XoxeDzg09MYLjOrUH9t02QvdGDNUMTcQeh2ocb4uYsQsoh93pealJ8iJcwjyFtHTwwj18tCQM/4BHTMfsQJAynB9D8iWPJdR2CJ8zqHH5YIZTrLHl6mmJ7SIdu/9XMEpDJ5cYCLpICB/Gu2fPSaug7ZwFdNSfbkwCr0DOD5FyzlJ2jga1gQyeILHYhp9H4dFnX8f8z+EuM61IOALoXehAdTXj2i7IMq3nH5bIMe9L4xiRWyQewndDIunj7pxZ69eaVYhDupJ+57RSMcBQh7BSbOy1pHoMOXy9d0A1SieWm6ZLrU6oHQcMC1TR1OFBPaUX592xNymtjhP7gdM9YHxv/c2Y0NIeSEcs1SeKz36huprTEVGMIB217SqMF30gatT5Vn6W7NEmA+q1MwHgntlXcqtUVHg8xpAwtYC7GWZBbenKcXnFLv/YrRYG6O8M8iPFweQBxnDcw6aNAjUmxGRFK1yzq2PzpduSUgPGzA2oDCMToVszq0w3qR/Ja79DyCC2TIq8HmWQH0ud92cexWTqa/jDnLw0I6oTO8gVMCjaiWiHTgJDArBUivqzqlvaOzOXJ9w/kyUDM4vGp2+tgbphxSmHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(336012)(2616005)(1076003)(426003)(47076005)(82740400003)(16526019)(81166007)(356005)(186003)(36860700001)(30864003)(44832011)(41300700001)(2906002)(5660300002)(40480700001)(82310400005)(40460700003)(478600001)(4326008)(26005)(70206006)(8936002)(7696005)(8676002)(70586007)(316002)(6916009)(54906003)(86362001)(36756003)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:40:56.4288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ad5675-9a9e-40a5-affb-08daa1895cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

We split out ILR config from "global" to "per-panel" config settings.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c       |  5 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c    |  4 ++--
 drivers/gpu/drm/amd/display/dc/dc.h                 |  1 -
 drivers/gpu/drm/amd/display/dc/dc_link.h            |  4 ++++
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 13 ++++++++++++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 13 ++++++++++++-
 .../gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 13 ++++++++++++-
 .../gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 13 ++++++++++++-
 .../gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 13 ++++++++++++-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h     |  1 +
 10 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f9479c3ace97..cd14ec5a5c25 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1307,7 +1307,10 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		}
 
 		if (link->connector_signal == SIGNAL_TYPE_EDP) {
-			// Init dc_panel_config
+			/* Init dc_panel_config by HW config */
+			if (dc_ctx->dc->res_pool->funcs->get_panel_config_defaults)
+				dc_ctx->dc->res_pool->funcs->get_panel_config_defaults(&link->panel_config);
+			/* Pickup base DM settings */
 			dm_helpers_init_panel_settings(dc_ctx, &link->panel_config, sink);
 			// Override dc_panel_config if system has specific settings
 			dm_helpers_override_panel_settings(dc_ctx, &link->panel_config);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d9cdce8f695d..2093120867eb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5795,7 +5795,7 @@ void detect_edp_sink_caps(struct dc_link *link)
 	 * Per VESA eDP spec, "The DPCD revision for eDP v1.4 is 13h"
 	 */
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_13 &&
-			(link->dc->debug.optimize_edp_link_rate ||
+			(link->panel_config.ilr.optimize_edp_link_rate ||
 			link->reported_link_cap.link_rate == LINK_RATE_UNKNOWN)) {
 		// Read DPCD 00010h - 0001Fh 16 bytes at one shot
 		core_link_read_dpcd(link, DP_SUPPORTED_LINK_RATES,
@@ -6744,7 +6744,7 @@ bool is_edp_ilr_optimization_required(struct dc_link *link, struct dc_crtc_timin
 	ASSERT(link || crtc_timing); // invalid input
 
 	if (link->dpcd_caps.edp_supported_link_rates_count == 0 ||
-			!link->dc->debug.optimize_edp_link_rate)
+			!link->panel_config.ilr.optimize_edp_link_rate)
 		return false;
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2ecf36e6329b..458a4f431ac6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -821,7 +821,6 @@ struct dc_debug_options {
 	/* Enable dmub aux for legacy ddc */
 	bool enable_dmub_aux_for_legacy_ddc;
 	bool disable_fams;
-	bool optimize_edp_link_rate; /* eDP ILR */
 	/* FEC/PSR1 sequence enable delay in 100us */
 	uint8_t fec_enable_delay_in100us;
 	bool enable_driver_sequence_debug;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index bf5f9e2773bc..caf0c7af2d0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -138,6 +138,10 @@ struct dc_panel_config {
 		bool disable_dsc_edp;
 		unsigned int force_dsc_edp_policy;
 	} dsc;
+	/* eDP ILR */
+	struct ilr {
+		bool optimize_edp_link_rate; /* eDP ILR */
+	} ilr;
 };
 /*
  * A link contains one or more sinks and their connected status.
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 7cb35bb1c0f1..887081472c0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -657,7 +657,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.usbc_combo_phy_reset_wa = true,
 		.dmub_command_table = true,
 		.use_max_lb = true,
-		.optimize_edp_link_rate = true
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -677,6 +676,12 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+		.ilr = {
+			.optimize_edp_link_rate = true,
+		},
+};
+
 enum dcn20_clk_src_array_id {
 	DCN20_CLK_SRC_PLL0,
 	DCN20_CLK_SRC_PLL1,
@@ -1367,6 +1372,11 @@ static struct panel_cntl *dcn21_panel_cntl_create(const struct panel_cntl_init_d
 	return &panel_cntl->base;
 }
 
+static void dcn21_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 #define CTX ctx
 
 #define REG(reg_name) \
@@ -1408,6 +1418,7 @@ static const struct resource_funcs dcn21_res_pool_funcs = {
 	.set_mcif_arb_params = dcn20_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.update_bw_bounding_box = dcn21_update_bw_bounding_box,
+	.get_panel_config_defaults = dcn21_get_panel_config_defaults,
 };
 
 static bool dcn21_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 8c1a6fb36306..ce993e8bdd24 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -888,7 +888,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.disable_z10 = true,
-	.optimize_edp_link_rate = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
 	.dml_hostvm_override = DML_HOSTVM_NO_OVERRIDE,
 };
@@ -911,6 +910,12 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+	.ilr = {
+		.optimize_edp_link_rate = true,
+	},
+};
+
 static void dcn31_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -1803,6 +1808,11 @@ bool dcn31_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
+static void dcn31_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -1829,6 +1839,7 @@ static struct resource_funcs dcn31_res_pool_funcs = {
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn31_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+	.get_panel_config_defaults = dcn31_get_panel_config_defaults,
 };
 
 static struct clock_source *dcn30_clock_source_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 24ec71cbd3e3..70b647b9b4d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -914,7 +914,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
-	.optimize_edp_link_rate = true,
 	.seamless_boot_odm_combine = true
 };
 
@@ -936,6 +935,12 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+	.ilr = {
+		.optimize_edp_link_rate = true,
+	},
+};
+
 static void dcn31_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -1675,6 +1680,11 @@ static void dcn314_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 	DC_FP_END();
 }
 
+static void dcn314_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 static struct resource_funcs dcn314_res_pool_funcs = {
 	.destroy = dcn314_destroy_resource_pool,
 	.link_enc_create = dcn31_link_encoder_create,
@@ -1697,6 +1707,7 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn314_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+	.get_panel_config_defaults = dcn314_get_panel_config_defaults,
 };
 
 static struct clock_source *dcn30_clock_source_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 07c59f8eefce..58746c437554 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -885,7 +885,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
-	.optimize_edp_link_rate = true,
 	.psr_power_use_phy_fsm = 0,
 };
 
@@ -907,6 +906,12 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+	.ilr = {
+		.optimize_edp_link_rate = true,
+	},
+};
+
 static void dcn31_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -1708,6 +1713,11 @@ static int dcn315_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
+static void dcn315_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -1734,6 +1744,7 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn315_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+	.get_panel_config_defaults = dcn315_get_panel_config_defaults,
 };
 
 static bool dcn315_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index f4b52a35ad84..6b40a11ac83a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -885,7 +885,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.afmt = true,
 		}
 	},
-	.optimize_edp_link_rate = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
@@ -906,6 +905,12 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+	.ilr = {
+		.optimize_edp_link_rate = true,
+	},
+};
+
 static void dcn31_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -1710,6 +1715,11 @@ static int dcn316_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
+static void dcn316_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -1736,6 +1746,7 @@ static struct resource_funcs dcn316_res_pool_funcs = {
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn316_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+	.get_panel_config_defaults = dcn316_get_panel_config_defaults,
 };
 
 static bool dcn316_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 8919a2092ac5..4ff1392633a7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -232,6 +232,7 @@ struct resource_funcs {
             unsigned int index);
 
 	bool (*remove_phantom_pipes)(struct dc *dc, struct dc_state *context);
+	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
 };
 
 struct audio_support{
-- 
2.37.2

