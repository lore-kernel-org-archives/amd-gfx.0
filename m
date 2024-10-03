Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB82CF34D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CAD710E996;
	Thu,  3 Oct 2024 23:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pc2jSgNd";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C150510E995
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydVaJIDy09nzxjqV8u5bIqmRxjCUrdZxFgPxqmJqYmP4FP9uZJ3v5pSVBKWY5M233RatrwdO2hoOBwCDlBVfkJOGvoEXLCesm4YulrwbwpHsJ/Z+4VgCRCPO1S9KYFS7p8JXpYoX92Mdmwe+n4vpVH4I1fJ/AUf6rcGHgj5E++p26/t3QaJBa4m3cQftgSIdvdbTYB+ljbgFW6ScxCHLM4xKTE26LybD3DDUV33XT7Q2Jr0/EeFO96hLp+0O08ZxoUPHsTca8EjAvcM+1EPgw7uJ3jtDfr6Id1SjNqT97OZpiW1BeL3uC0Mam82TBMolBa1AaEdevRNHaQW7C7z12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0D6GbPWlNiBCxWLcGkj3xF16Er9VzKjjO8NlCRi4Xg=;
 b=DAXATWFb2h/lV6bl7NZRuo1RaNCy6wbmZUuErQ3zpc1OdsE4Y4TM35YWSYzHPjNkdRLModfFZubQKlaUN+rfXnTggqKVckweIUuGgrwZmZ7+wOZqOfQug+l2Kf/XKOc1vaT3QliPkOirxuyxzvHeENFdd479u3c1Wsrx2LhseoFtBTt1xxKDYTdZZvhMhZg4mR/HVcXw/rHvW3KGbcHTM1dsH8EaZbezlCfleh6poEHiQS19G+qSGhINq4YLxldpgiW6smiHsCuZZshM3XXIpydfPbnTlzliFCDEEAzD2njYhm4auZLu5iimU2Uh57M6hazB1/ac4YS4AyCzdJAaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0D6GbPWlNiBCxWLcGkj3xF16Er9VzKjjO8NlCRi4Xg=;
 b=Pc2jSgNd5yKV+DgccKLsz8UJPJQK8juVuRpqwbcGLSw9P+kgsg97LAagMqY7OiRPkJU9OL5yGbyW82Fkb1Nq4aSolDV2jm91Z489HqNGoxfo1prspMqXGc1WUZmEb3gp8t/IIVQGqpaYNkK5LmnM1jU5UtgAtxsZH0v5TKbT6T0=
Received: from DS7PR03CA0300.namprd03.prod.outlook.com (2603:10b6:5:3ad::35)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:35:44 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::a3) by DS7PR03CA0300.outlook.office365.com
 (2603:10b6:5:3ad::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:44 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:41 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 04/26] drm/amd/display: Revert commit Update Interface to
 Check UCLK DPM
Date: Thu, 3 Oct 2024 17:33:22 -0600
Message-ID: <20241003233509.210919-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: e443639b-2889-484d-f410-08dce40419d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U1X80ijkyGeaQDo7hoyixdDLE8f56wYZ/yEvNdlFkDx4XDRuD1dLSurp+7mO?=
 =?us-ascii?Q?1H2vOeUOzYLVgJU4PQA/ta6hZPGbn5ZXYO+hwulrX5uUh1J+4Tnat1ooAL9r?=
 =?us-ascii?Q?iP4CtOt8m2adukOsAdLT5PuPLgYHaxpxpPY+9yP4qr/JhrENAte99ChoKvxK?=
 =?us-ascii?Q?6unYq4B/JojHU10FgTf2hAjNkgZ9URbnX8/2rvLQskc/kli0cZZ1tD2PKilv?=
 =?us-ascii?Q?dXBlfaE211aFNhXCJxsbzEfLJovh1iATiSSGKtf79iGvsMNPX8UicqkR7lVC?=
 =?us-ascii?Q?ya2EIQl8VN85zg7Z7bN201ohFGUXQz+A7ED7mRrHTeb/v9lzQ2q5Pru7G+H5?=
 =?us-ascii?Q?H2pwwAEKBqAimmlQEXa8U+ZO/w6rYpnrLH9QDOa0y+P71y61P9VCissS1wYt?=
 =?us-ascii?Q?VhW/Ety1p2G4n4d1hEokOe6eGCg1jz0+s7iP5XPxU7vKio+fPM5r7E4B7/N5?=
 =?us-ascii?Q?BhVDvbz3Spg+9x+yS+rzExkucZHrnqkVjRXrRz/1eR+fgqND6gQ9fCwPTueS?=
 =?us-ascii?Q?boC1FLK6M2tj+fpPsz8QP5owV4VZUTzql7sYoxXZ+KLvIuwi3Y5aNL9U93IV?=
 =?us-ascii?Q?MO1G/nVW1hJia8b4qTN5P9lNSUMfMe0wV8n2cc/cqNBnk/kzAWS2YVlOhB/h?=
 =?us-ascii?Q?zGOhNBizt+a3ceLMrXKeyiN9FOHWDWnDSntETzk1AmAPozs8vd0l5o+VOGm3?=
 =?us-ascii?Q?3NdVReT5HuTcf/QYfY09QHoTgJn3Dosm5/FDBDJbq5ZY2DD4xXScIrMmluMA?=
 =?us-ascii?Q?dQxiEkS25LN2IVjFMK1GZto+j4IkNZcKFAwEvJWT/RTchVJpEIeGnuN6ouIY?=
 =?us-ascii?Q?gnbHWFiPdAJQBH87PaI2c50Kjqj9US5DEJUcT2Zs+ZWIBspRFVhSaFmGJuK6?=
 =?us-ascii?Q?u9R12WmtXn0mTx/KNZBAIj/24Ze4m43+rw9Ou+otYkjo4VHqbW/gcp3OnMTl?=
 =?us-ascii?Q?tbZyYtGGLNPPz4lgwAvoV0ty2pRYTVU1plXEDRGC/1Qo0Sq4DNWC2K3UXxUH?=
 =?us-ascii?Q?zgU3ZzUBYvI7q590/YAmVrYX3KCiiQPA3v73OJf5UPVeC8O135Qhl5XudnYk?=
 =?us-ascii?Q?fuIa5v+YrJFgSI7UYxZGD2qEC33KL7RHOw3bXP/Mk11QB3OY99PfGtMcQuHA?=
 =?us-ascii?Q?lQND9ntGLVC3XX8nPJ/tvuFYD52bz9awe9u7l2GB8Fotf85kDd/mALeNMOef?=
 =?us-ascii?Q?ZTabmR0ccUaRv0vnHiTg2r+bFy2rpfiA8irOSczYeIYfMuUzSyAHBu4SRjYR?=
 =?us-ascii?Q?ZWC5f8MyldKcw9zmmsOk805a73qZK1b74KP0OyT5cwUYBtKPXjM/QI+Jvpo6?=
 =?us-ascii?Q?XzIV5uCSPTBYJmDPKDK+2hPDRnWIs4ni0s+ZbvNwe+FWEys35BAJevz05AWq?=
 =?us-ascii?Q?+iMXTWP071OPPGkinvelxpI+ThHK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:44.2452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e443639b-2889-484d-f410-08dce40419d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
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

This reverts commit 1b4ef7a2d5bcf9ab7e58e7c1efacd458f645b824.

Reverting as regression discovered on certain systems and golden values
need to updated.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  9 +--------
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c    |  1 -
 drivers/gpu/drm/amd/display/dc/inc/core_types.h |  4 ----
 .../dc/resource/dcn315/dcn315_resource.c        |  6 ------
 .../dc/resource/dcn401/dcn401_resource.c        | 17 -----------------
 5 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 48057ac22cbd..57ad6ce88f3f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6038,15 +6038,8 @@ void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state *context)
 {
 	struct dc_power_profile profile = { 0 };
-	struct dc *dc = NULL;
 
-	if (!context || !context->clk_mgr || !context->clk_mgr->ctx || !context->clk_mgr->ctx->dc)
-		return profile;
-
-	dc = context->clk_mgr->ctx->dc;
-
-	if (dc->res_pool->funcs->get_power_profile)
-		profile.power_level = dc->res_pool->funcs->get_power_profile(context);
+	profile.power_level += !context->bw_ctx.bw.dcn.clk.p_state_change_support;
 
 	return profile;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 2e9c59e9e0c1..1cf9015e854a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1798,7 +1798,6 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 	}
 
 	if (s->pmo_dcn4.num_pstate_candidates > 0) {
-		s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.num_pstate_candidates-1].allow_state_increase = true;
 		s->pmo_dcn4.cur_pstate_candidate = -1;
 		return true;
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 8597e866bfe6..bfb8b8502d20 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -215,10 +215,6 @@ struct resource_funcs {
 
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
 	void (*build_pipe_pix_clk_params)(struct pipe_ctx *pipe_ctx);
-	/*
-	 * Get indicator of power from a context that went through full validation
-	 */
-	int (*get_power_profile)(const struct dc_state *context);
 };
 
 struct audio_support{
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index f6b840f046a5..3f4b9dba4112 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1812,11 +1812,6 @@ static void dcn315_get_panel_config_defaults(struct dc_panel_config *panel_confi
 	*panel_config = panel_config_defaults;
 }
 
-static int dcn315_get_power_profile(const struct dc_state *context)
-{
-	return !context->bw_ctx.bw.dcn.clk.p_state_change_support;
-}
-
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -1845,7 +1840,6 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.update_bw_bounding_box = dcn315_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn315_get_panel_config_defaults,
-	.get_power_profile = dcn315_get_power_profile,
 };
 
 static bool dcn315_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 59184abab1a7..f2653a86d3e7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1688,22 +1688,6 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 	}
 }
 
-static int dcn401_get_power_profile(const struct dc_state *context)
-{
-	int uclk_mhz = context->bw_ctx.bw.dcn.clk.dramclk_khz / 1000;
-	int dpm_level = 0;
-
-	for (int i = 0; i < context->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels; i++) {
-		if (context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz == 0 ||
-			uclk_mhz < context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz)
-			break;
-		if (uclk_mhz > context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz)
-			dpm_level++;
-	}
-
-	return dpm_level;
-}
-
 static struct resource_funcs dcn401_res_pool_funcs = {
 	.destroy = dcn401_destroy_resource_pool,
 	.link_enc_create = dcn401_link_encoder_create,
@@ -1730,7 +1714,6 @@ static struct resource_funcs dcn401_res_pool_funcs = {
 	.prepare_mcache_programming = dcn401_prepare_mcache_programming,
 	.build_pipe_pix_clk_params = dcn401_build_pipe_pix_clk_params,
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
-	.get_power_profile = dcn401_get_power_profile,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
-- 
2.45.2

