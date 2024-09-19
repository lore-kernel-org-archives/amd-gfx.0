Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA7BCF3963
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3ED210E766;
	Thu, 19 Sep 2024 18:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c1bhQDRe";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCB710E758
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDFhrsOjXbMw8s5V9Tb3sIjBNKqIekvFIPdU9ALkK4blKBzfpb1grcXtRRBlzEdaPnh1l2WNArcvkcj2d+W+Z8Gdk7izEvzC+33s8QDRdE0q71q37A6CN6ToUxIjobMGzLJNJS8hB82ZTjR6u4Bp/MocCT1Kr1CW0UOxn2mnQ4NUL33wFAyhR/QJZMFHeNiUN7kEBV/8QgkwO0wVVIRPByHm9SOEFzqizhB3XQw49XoSWxnuV8V0C9jX6tcuGqQPrFwHMl08zcKdcTz72kDs3ksGLeLbWwXt2x9PpjohCNU++lC5KSyuht16IE8pnFkAP51MLxhfa3saDESVqakbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B34WqtSC9jNcP0BzA6XzZzx0IvfCKdwaOMaVJ9EMx2U=;
 b=zPnit0THdtHUBAqLHjBGHarvMhyeXZQs+5AI7bpxmbFBcIhu88bsdujXK4h74l/+0dnqs9VnxgOdqys3SDa6Fc0zB2rqKwZKSeOlWnlsPM3N1HBPCG7ETs/ZxzXmo1O4X/9X20jPixVemfzynT3xH0Z+/HT9hX6OUZ/6dkQvydBr0FW/nDVfXK9s0n7HGhGaWuxYN5tiEzQJ9peHNnMkkthtOEgOTQgSJkcXposy9x7ICESR2kbSx3dzgGsH3zWrO461ZHLkT/3J8skm7E99RWjrLCMBNejmqCFyjDFH5AyPcKzjnFQkLxlw66gmmmkib43+3WqKe5vjhrwaV5Yjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B34WqtSC9jNcP0BzA6XzZzx0IvfCKdwaOMaVJ9EMx2U=;
 b=c1bhQDRecshn/Xx6CLMGL7IPzKVRoLZipND5a9BoGQf5f6YKUUNouxta9N/qcN9L9X8R+4jD5v6IZ4ODQQ9MiQx/Z2AVQE8F/tnoQhn+jsFUFJSUdJJDxoX0CLjwL3CMzC6BBh30f3rK+I4ZFS0N27SwqkKJaEDRGEqKK4G4N44=
Received: from MN0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:52c::30)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 18:35:07 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::d0) by MN0PR05CA0018.outlook.office365.com
 (2603:10b6:208:52c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7 via Frontend
 Transport; Thu, 19 Sep 2024 18:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:35:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:35:01 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:35:00 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 15/21] drm/amd/display: Update Interface to Check UCLK DPM
Date: Thu, 19 Sep 2024 14:33:33 -0400
Message-ID: <20240919183435.1896209-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b576ef4-8990-4e4f-162a-08dcd8d9c8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Vymey403E2LL0S4jJB4kAZ50ziuMfc0CvE7GrhzvH+D0Tp65JKE1XAoh0Oe?=
 =?us-ascii?Q?ymW3hbvDcezzUrsemDBJHl5jC5vSFaqrsYb0SrmzcFHrte60rhfrWmGRRLrH?=
 =?us-ascii?Q?d19n1MC0BIBja296vdTaugu/492ORtA5y0URoWSFNmyg3f/4bbwg5z4tZPlY?=
 =?us-ascii?Q?bzuU9UH7AL/BCicMC1+pcfyNEXWK0BSozeP9KJHI4k0+yZgGggydNpLKJhx2?=
 =?us-ascii?Q?1tCprnsBO7Fw0B53Tiz002TgCAbLCqH1onGpBAJUrxF8moQ9mWcqbeBv6tU9?=
 =?us-ascii?Q?q5to921LAPxayeV3CYV4yRfLGetROsKPdVthYyDzdN9FCpeqC78lbcmwOWsh?=
 =?us-ascii?Q?EkmquhdogFGCuI8nmpUL/BZLc6SaamcH5NaX7Pe0Kv9syPj4f2kw+HlIOIa0?=
 =?us-ascii?Q?Er6gmmg3yFFwcv4qdZuBLuFXIlUO05QtDPSLxJkRLRZLsteziWeGgUHSlu0l?=
 =?us-ascii?Q?y8QH48ej4yvYeUTo7S1xlyscJr9ITUz5aZxD1PaPLDquSyZmeRI7+5djKkRJ?=
 =?us-ascii?Q?Bi1Kv6Jx9EHS+WFur/MxgRTpHkJq47KO5V9fN6lI5kpgMNFfnMyDMcMP4Rz5?=
 =?us-ascii?Q?cF67pkpW89Lx/sgQAObjSFBh1C5BoR4K5AMBMwdTARu797hsEIThd3VwrCHh?=
 =?us-ascii?Q?GPucHekyfsbF1ZvlnaWVNkwFxMXStwbMeG0kPV01FfhDeeZvjGymaNev5tlI?=
 =?us-ascii?Q?FC34m1quiSFsamhQ7F679z8WQuOeymM6/H0YnD5ywYuetLo+ecpcXsxTNG9h?=
 =?us-ascii?Q?PQm4aU1eTvWJBLuQsFYrUrqECw5SmOOwsjq9OV9LgcVJUQpMA/yJGOoEt8r4?=
 =?us-ascii?Q?1avlge5cfwzvD7BXX/hRkCfNuw8JePEA+lvpYkJ/5SM85c//dC4H/FqdBE1t?=
 =?us-ascii?Q?apkh8oC3i5z5ak0tu3kF068pKtf5gygFn+CpUczJP9ltaJOzrKcQFegbKPZ3?=
 =?us-ascii?Q?H58sjWCcCd8ICTtaf4CFmV9UvRTHpwLdUh7e5VwxMmCPujgvNJuBcZv1X+wk?=
 =?us-ascii?Q?6eADPJWP2T722J4b0Pr4FutmJ8306wNGNH8IKpULuTfaBI+H/gKxZmpgGO7T?=
 =?us-ascii?Q?veB5HviBeL63mTibgj1YWvBL2U1NGlcZVis+svFMBOOfdRC60EpDsLfn7z3F?=
 =?us-ascii?Q?sq9DwRCDIL/So5K7MOVchWG23jFV/GXEpQk3o5UmJ7P3TEg4ZqEkJZrkpTpS?=
 =?us-ascii?Q?u9pOTUqnGEKPVwyfvEornEzJ/LvUPbrhjxFa6j7GPEPIXzt/ptFrJOeuGrys?=
 =?us-ascii?Q?jJZgZGMHN7cRqizBjmsIKadOACyBvwIXpImnheh+vl9X00eHj9qqeM2uj+JV?=
 =?us-ascii?Q?XY3WQY9RrAyHQdsGhYDJl3a7YS68L5yPHiQQtYP8Ap/hjiYQ3xph12mJL5uo?=
 =?us-ascii?Q?M9NrTsmAOP8xjWBJ0viouoXo/p27k7U7JoMhDEcOhPpZHUD1ATo7sqyvB7gQ?=
 =?us-ascii?Q?3JifcXKYeTCLhzJn7Z3Pq/ryz337FrcM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:35:06.4645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b576ef4-8990-4e4f-162a-08dcd8d9c8a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
Videos using YUV420 format may result in high power being used.
Disabling MPO may result in lower power usage.
Update interface that can be used to check power profile of a dc_state.

[How]
Allow pstate switching in VBlank as last entry in strategy candidates.
Add helper functions that can be used to determine power level:
-get power profile after a dc_state has undergone full validation

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  9 ++++++++-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c    |  1 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h |  4 ++++
 .../dc/resource/dcn315/dcn315_resource.c        |  6 ++++++
 .../dc/resource/dcn401/dcn401_resource.c        | 17 +++++++++++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 98b94415e86c..024d2d0bf457 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6018,8 +6018,15 @@ void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state *context)
 {
 	struct dc_power_profile profile = { 0 };
+	struct dc *dc = NULL;
 
-	profile.power_level += !context->bw_ctx.bw.dcn.clk.p_state_change_support;
+	if (!context || !context->clk_mgr || !context->clk_mgr->ctx || !context->clk_mgr->ctx->dc)
+		return profile;
+
+	dc = context->clk_mgr->ctx->dc;
+
+	if (dc->res_pool->funcs->get_power_profile)
+		profile.power_level = dc->res_pool->funcs->get_power_profile(context);
 
 	return profile;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 1cf9015e854a..2e9c59e9e0c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1798,6 +1798,7 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 	}
 
 	if (s->pmo_dcn4.num_pstate_candidates > 0) {
+		s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.num_pstate_candidates-1].allow_state_increase = true;
 		s->pmo_dcn4.cur_pstate_candidate = -1;
 		return true;
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index bfb8b8502d20..8597e866bfe6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -215,6 +215,10 @@ struct resource_funcs {
 
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
 	void (*build_pipe_pix_clk_params)(struct pipe_ctx *pipe_ctx);
+	/*
+	 * Get indicator of power from a context that went through full validation
+	 */
+	int (*get_power_profile)(const struct dc_state *context);
 };
 
 struct audio_support{
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 3f4b9dba4112..f6b840f046a5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1812,6 +1812,11 @@ static void dcn315_get_panel_config_defaults(struct dc_panel_config *panel_confi
 	*panel_config = panel_config_defaults;
 }
 
+static int dcn315_get_power_profile(const struct dc_state *context)
+{
+	return !context->bw_ctx.bw.dcn.clk.p_state_change_support;
+}
+
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -1840,6 +1845,7 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.update_bw_bounding_box = dcn315_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn315_get_panel_config_defaults,
+	.get_power_profile = dcn315_get_power_profile,
 };
 
 static bool dcn315_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index f2653a86d3e7..59184abab1a7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1688,6 +1688,22 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 	}
 }
 
+static int dcn401_get_power_profile(const struct dc_state *context)
+{
+	int uclk_mhz = context->bw_ctx.bw.dcn.clk.dramclk_khz / 1000;
+	int dpm_level = 0;
+
+	for (int i = 0; i < context->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels; i++) {
+		if (context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz == 0 ||
+			uclk_mhz < context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz)
+			break;
+		if (uclk_mhz > context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz)
+			dpm_level++;
+	}
+
+	return dpm_level;
+}
+
 static struct resource_funcs dcn401_res_pool_funcs = {
 	.destroy = dcn401_destroy_resource_pool,
 	.link_enc_create = dcn401_link_encoder_create,
@@ -1714,6 +1730,7 @@ static struct resource_funcs dcn401_res_pool_funcs = {
 	.prepare_mcache_programming = dcn401_prepare_mcache_programming,
 	.build_pipe_pix_clk_params = dcn401_build_pipe_pix_clk_params,
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
+	.get_power_profile = dcn401_get_power_profile,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
-- 
2.46.0

