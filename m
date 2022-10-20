Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E3AC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B7910E252;
	Thu, 20 Oct 2022 15:47:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4845D10E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHqfhAfuyLi1xw9YF1JhZdtmq42oPcdMFVf/JwB+P4PzOhJqbvwkfi17ItGmttegq3fLksyHHIGM/dWL4KjPzAYAptuuLMwjZ+25o/zz98VeGk0Bn94WDYsJ6KoRdvh+0oQ3rvoSNKsiP6G+Z9HbrtLMTUGCvyAXh3y8XjoJGQe22KRSR4JnA+yz/ji7XrMseZLoTiVQgr9MEVy+bs4gq8Jbhib8Trfq/JOUMbw1k9yaTMKTozCbW7pTVL16dtBTZBOq66eh9/qCye105UL9SiT2wplSFWx1nwDXQfyqJZqwpBhyabUJWmPYnV3PELw+iJK4lnOMy6Jk8viIKpIB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju28Z5gyFj51bvqyrYlpxuqrBHfF79KPfBRr16KSrtI=;
 b=Y/rmzmEFRU81TY7hgXjHJwF/CUFYIndstjeZObjPcz8mUa8a1gbDmCIYSqBpg2MjsipsMOjRWwiNnB4Dons54aWGjNnZhdbu6f0x+NUtE2dysN60OfZBYlPt3sCVbv5bdsYw5lZIEwZeVPAlWal4PsaZ+d3FSS4tSqhGfYKzKJ07ViazdQrtZNHThVJ/MwvmPVemu8OBpOkQqaOb/WuiZBtE2ZJRo2AJAKPO+pQp9bIiHfC2Vn9vQau1YMCCp9rTMOC7oIxtyzPp4M+oMvY05dn4V0MBfRf1ySI9AZha4WMA7ByI0XPc7wghz1Rq2i89qa8pqpKN8BDk4tuOREiJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju28Z5gyFj51bvqyrYlpxuqrBHfF79KPfBRr16KSrtI=;
 b=0gORdF58LBjsvzuJaxqUijm1GKoFF/PDrG4OE3/xWpEO5f7cR4631C2sZ1+TD0oncnLRC9S//KiIIItiJZ5Q+gO96TY2FbUG/ebL4EWkspjhPcxSvdpZeXsq6j64pkWAlAt5DF3rr56sxmmxws1grxoeu4NQ/K6fOStvJuYc02Y=
Received: from DS7PR05CA0031.namprd05.prod.outlook.com (2603:10b6:8:2f::6) by
 CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 15:47:42 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::65) by DS7PR05CA0031.outlook.office365.com
 (2603:10b6:8:2f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.9 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:42 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:40 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/33] drm/amd/display: Refactor eDP PSR codes
Date: Thu, 20 Oct 2022 11:46:36 -0400
Message-ID: <20221020154702.503934-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4e6d65-2145-410b-8ee3-08dab2b26cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxBs/Oj3focsr/XfAd+wHfvSZno9A9vvlsC2iDEzFISgRTh4jjSqvv6cMn+aAVt78p2MuRS19O1/Y/iqdaH7d66uoVPzx9j8OovPd6ELzUa7Q1QeBDMERO7Dr49+doWjmMskWMRBLzUIgzb1Gygn13mNCwr1Cm3SUfY3+ynsppD6zAF4n42dZvs1X81FZ4ZFtTqe5Mj/OvjcdIsmd/q5F9QwgaRwwMhdHu3hlB4PGyVT3xDdudqZsRfb2iHWunckTcsbO1rz5G1/04SArlVwyL+pK0K+f6S3xKfsOzDM9ufXl+2Cfy8AF1RcCjm2JA7XvymKsVhsrAegnfmJvfjOAfof7R6aWP6nlywx13xBibibhYcwkedq1+wQ0q8oi00dfwEhL9FxUgzNhJWBAWBMRN65c8m3vvV57FSQzIBvdVOZCvsO3IqmYkcMo7Emv7TB/uWUNjt51eYmjBcHrSnNsV0NR9XqMKW1CUH4VBek6ftx0k73tTu/cfrRgVNgCgytNY2MHzuv4qd3qSqDoKJC8MGjSuJSHf89FPNFC4Zj9hxVPvA3rRB1i43s87Rv6Zcu/3j/wQ8ox9bWezhWCOLkA5l6swStCXafxvg9jrt3fwEcs8Bg0qBY+l+s3oZN6B0AfxQSJRhbX8umQQicL5wkP/GW7JR3uyyle8CPeAlti6jI4N9bpANByYnHEgRwaMcYe+kvdYMkc5yyhkXiFXqGxgtzvft7A6tCaptEVOpOC8y8sRhRRndKWK7BgcNb0RSPAb82H13hn9eJPGwWej9JCN9I+T9VsCCNAVRXe2FRi3rzzDTBGCjon9cQijKLtBhj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(82310400005)(86362001)(82740400003)(41300700001)(356005)(426003)(47076005)(36860700001)(2616005)(83380400001)(81166007)(40460700003)(16526019)(1076003)(186003)(336012)(40480700001)(6666004)(7696005)(478600001)(5660300002)(2906002)(316002)(8936002)(6916009)(70206006)(8676002)(4326008)(30864003)(26005)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:42.7127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4e6d65-2145-410b-8ee3-08dab2b26cef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Robin Chen <robin.chen@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

We split out PSR config from "global" to "per-panel" config settings.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h               |  1 -
 drivers/gpu/drm/amd/display/dc/dc_link.h          | 14 +++++++++++---
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c |  5 ++++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 15 +++++++++++++--
 .../drm/amd/display/dc/dcn302/dcn302_resource.c   | 14 +++++++++++++-
 .../drm/amd/display/dc/dcn303/dcn303_resource.c   | 13 ++++++++++++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c |  4 ++++
 .../drm/amd/display/dc/dcn314/dcn314_resource.c   |  4 ++++
 .../drm/amd/display/dc/dcn315/dcn315_resource.c   |  4 ++++
 .../drm/amd/display/dc/dcn316/dcn316_resource.c   |  4 ++++
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  2 +-
 11 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 54d34017e329..bd7a896fab49 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -764,7 +764,6 @@ struct dc_debug_options {
 	bool disable_mem_low_power;
 	bool pstate_enabled;
 	bool disable_dmcu;
-	bool disable_psr;
 	bool force_abm_enable;
 	bool disable_stereo_support;
 	bool vsr_support;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index caf0c7af2d0b..17f080f8af6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -117,7 +117,7 @@ struct psr_settings {
  * Add a struct dc_panel_config under dc_link
  */
 struct dc_panel_config {
-	// extra panel power sequence parameters
+	/* extra panel power sequence parameters */
 	struct pps {
 		unsigned int extra_t3_ms;
 		unsigned int extra_t7_ms;
@@ -127,13 +127,21 @@ struct dc_panel_config {
 		unsigned int extra_t12_ms;
 		unsigned int extra_post_OUI_ms;
 	} pps;
-	// ABM
+	/* PSR */
+	struct psr {
+		bool disable_psr;
+		bool disallow_psrsu;
+		bool rc_disable;
+		bool rc_allow_static_screen;
+		bool rc_allow_fullscreen_VPB;
+	} psr;
+	/* ABM */
 	struct varib {
 		unsigned int varibright_feature_enable;
 		unsigned int def_varibright_level;
 		unsigned int abm_config_setting;
 	} varib;
-	// edp DSC
+	/* edp DSC */
 	struct dsc {
 		bool disable_dsc_edp;
 		unsigned int force_dsc_edp_policy;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 887081472c0d..ce6c70e25703 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -671,12 +671,15 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.disable_pplib_wm_range = true,
 		.disable_stutter = true,
 		.disable_48mhz_pwrdwn = true,
-		.disable_psr = true,
 		.enable_tri_buf = true,
 		.use_max_lb = true
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+		.psr = {
+			.disable_psr = false,
+			.disallow_psrsu = false,
+		},
 		.ilr = {
 			.optimize_edp_link_rate = true,
 		},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 020f512e9690..af4fe695535e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -723,7 +723,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
-	.disable_psr = false,
 	.use_max_lb = true,
 	.exit_idle_opt_for_cursor_updates = true
 };
@@ -742,11 +741,17 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.scl_reset_length10 = true,
 	.dwb_fi_phase = -1, // -1 = disable
 	.dmub_command_table = true,
-	.disable_psr = true,
 	.enable_tri_buf = true,
 	.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
+};
+
 static void dcn30_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN20_DPP(*dpp));
@@ -2212,6 +2217,11 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	}
 }
 
+static void dcn30_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 static const struct resource_funcs dcn30_res_pool_funcs = {
 	.destroy = dcn30_destroy_resource_pool,
 	.link_enc_create = dcn30_link_encoder_create,
@@ -2231,6 +2241,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn30_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+	.get_panel_config_defaults = dcn30_get_panel_config_defaults,
 };
 
 #define CTX ctx
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index b925b6ddde5a..d3945876aced 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -112,10 +112,16 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.dwb_fi_phase = -1, // -1 = disable
 		.dmub_command_table = true,
 		.enable_tri_buf = true,
-		.disable_psr = true,
 		.use_max_lb = true
 };
 
+static const struct dc_panel_config panel_config_defaults = {
+		.psr = {
+			.disable_psr = false,
+			.disallow_psrsu = false,
+		},
+};
+
 enum dcn302_clk_src_array_id {
 	DCN302_CLK_SRC_PLL0,
 	DCN302_CLK_SRC_PLL1,
@@ -1132,6 +1138,11 @@ void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	DC_FP_END();
 }
 
+static void dcn302_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
+
 static struct resource_funcs dcn302_res_pool_funcs = {
 		.destroy = dcn302_destroy_resource_pool,
 		.link_enc_create = dcn302_link_encoder_create,
@@ -1151,6 +1162,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 		.update_bw_bounding_box = dcn302_update_bw_bounding_box,
 		.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+		.get_panel_config_defaults = dcn302_get_panel_config_defaults,
 };
 
 static struct dc_cap_funcs cap_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 527d5c902878..7e7f18bef098 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -96,7 +96,13 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.dwb_fi_phase = -1, // -1 = disable
 		.dmub_command_table = true,
 		.enable_tri_buf = true,
-		.disable_psr = true,
+};
+
+static const struct dc_panel_config panel_config_defaults = {
+		.psr = {
+			.disable_psr = false,
+			.disallow_psrsu = false,
+		},
 };
 
 enum dcn303_clk_src_array_id {
@@ -1055,6 +1061,10 @@ static void dcn303_destroy_resource_pool(struct resource_pool **pool)
 	*pool = NULL;
 }
 
+static void dcn303_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = panel_config_defaults;
+}
 
 void dcn303_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
@@ -1082,6 +1092,7 @@ static struct resource_funcs dcn303_res_pool_funcs = {
 		.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 		.update_bw_bounding_box = dcn303_update_bw_bounding_box,
 		.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
+		.get_panel_config_defaults = dcn303_get_panel_config_defaults,
 };
 
 static struct dc_cap_funcs cap_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index fddc21a5a04c..8729d6305996 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -911,6 +911,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index d0ad72caead2..92eb56873eee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -937,6 +937,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 58746c437554..31cbc5762eab 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -907,6 +907,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 6b40a11ac83a..af3eddc0cf32 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -906,6 +906,10 @@ static const struct dc_debug_options debug_defaults_diags = {
 };
 
 static const struct dc_panel_config panel_config_defaults = {
+	.psr = {
+		.disable_psr = false,
+		.disallow_psrsu = false,
+	},
 	.ilr = {
 		.optimize_edp_link_rate = true,
 	},
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index d680f1c5b69f..ec2eae99b892 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -989,7 +989,7 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 
 		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
-		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !dc->debug.disable_psr)
+		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
 		else
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
-- 
2.35.1

