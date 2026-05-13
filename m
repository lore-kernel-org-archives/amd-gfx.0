Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03683CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9138410EEEE;
	Wed, 13 May 2026 14:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j0HZqyrp";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B6210EED2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4JlJoOSfhFSaSVhzIkwSFvFqBoqUR/gPIe3c/zdOrdFdteHeHAx/keVIQvL7eQb2r08IZIhKnMwd4aW1TqoqVlrdapQ3FasuwLwMSjh2qvKTDja87iZv1m0XDVkPCeqOrC5difh+Y5tN8UjMwio7norgZ6Kx/nRkMK3YQzDg590ve31trbStuKdorxb4j0q8KmGW30po5X8TRSX8aqocHv5jn56OOlqyN4doTjMLNGWJp6GBut4t60ufQU3sezGBaySp7YE+KK5ymq64WdjY0tIPTYWlMQ8Bc0tJ9FuNm6puSPqs2VK4WRo3j/yZnU50GRi5r22I3EX6eXDL2s++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyHX6o446zfIpFlMd+oC94Wv4ZW/KC8SctW1xc1r8Y4=;
 b=y1dJK5N+IJvWb3bUGAxCEiPmVo5cgsbzlN7HknMarg8ttxo1PsVeAGyQycpUAGVEODLkBT18+gy9ViyftBUbLlrpus9Klhv3DGMto2ps13hr7RBZazzDEMseM0+BNJYfDdbbCObqa6mWsTmc8BUhgUxXSNF4/pbduXaYogy6oC0GapXeg6fDbIppEEVt1noWdruOjO1cBpiDXZMBPcJLz01ouCdBmXW7+rc3Mo/1n958b+XXNOSASU2loiYR5+aUykgqtDHTi5eRP6kcPHrHpTnhNrcLn03yai1EqHQzjLCyIYqosmpkCio7bZv09OlpzBqTrfhNogaBquub2XTz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyHX6o446zfIpFlMd+oC94Wv4ZW/KC8SctW1xc1r8Y4=;
 b=j0HZqyrpm/VXNVjhTO2ByAcfkNSo6/LGXjFBUQXjjpJcK36jQsuzLSpERyU80JmQHQ1l6Z5CRYvApKeQS618TIOgIAo6oc/iZXR/mfjf3978fpL/xb1Sia1gnSwRg5QN1bLhiAOaaxvqyU6+a1KZp3w6KrOweusj3MxZ0XFz20w=
Received: from CH2PR18CA0043.namprd18.prod.outlook.com (2603:10b6:610:55::23)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:33:19 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::d5) by CH2PR18CA0043.outlook.office365.com
 (2603:10b6:610:55::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 07:33:16 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:16 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 03/28] drm/amd/display: Enable DCN42 PMO policy
Date: Wed, 13 May 2026 10:29:25 -0400
Message-ID: <20260513143213.1852892-5-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4b55c7-2c69-48a9-7db3-08deb0fc9389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|11063799003|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: IhNhaNkUz7hHi0w5Ir/Xb6rvJ0NL/vVt/5hCt35wMhbHxr71ZfaH/Ek1j9xy4I83m2iueG4he2mcrMKrnF8f3pJGOqvJ9NSoQT4VN6Jo25dtiIJ01Iw2Aaci5Xw3CwlkfuUrIKZPfvXieW7j93GYxykjW/xOaz4LBSwQPLnj3Gbv3f2lDgClS6QH0az3ggeTxZmTCVdu8ySeMiOmIwi6j+MIcjmFBy7SATteCi/IIFBUvkKm0o07EqO4h/NczOzozwx67W6ryE8RzC3CT9DG1D+GsipC8KLOx/h+03nXsevZle1fCNOk5ghhUUQ/JaB1oZuQs8RD3h4FT8uujBD0nGObP6Ay2qINu0XB+f+5o/GdTNlopY5aSGua/OWHqpcaPlOQA8zPHtUwN+0N59JN6oK3zJisa+cFJeEpgQIHSjLuOrM6iIb3R3s1YfdzjwQ/T2zp4v0m0rb/O5SVymCuf7nSgAcPLgP8I2yx4VVJcUNQeR1PkPujMon7yVYsqHDAxpuvq9cS2ROD5nC3lVBvDVDslMI8VNctLyRKkDAtYRzmShE+6l1ZmbH69RZcukyOtWp71EA1hIw5TSSEWA0r7ssH0leu0paUMIzvPjelU/xriIK4pb1jks8WTNFBM9pI5XVlTCCK4EqmxQeq3lxkc+ZYEcj8mQuEcFwxjtkF/qQaxNahHWzfFox+MKeex1qElM8YArygZn6tpLyrj1bSi5lPM4fcAXywuaA/2Djl9FQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799003)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zXXYm7Yv/0LDkMX0VvMHFru5JO6PkG7dritzvTPkUi7XEI27ZSPUnD6wIu0fZCs1wByRA341k8N39GKSkTzUCId3yt7m/zoBTwrDubHm/jZCgt+VBVYZ7AEQv+pym7rb6xl/KbzWC7U0l2Zn2izQEPgjjP9Gki1n1x68XqsEalWPkPtsMI1VlUBrkjR0jaWaJ9uLn6jNzoUY3S9nSsgg5FRR6yFlHJ4MRfY38nq4n3rd3E8OM9r89LC2QlmqOv4NHfj/exdyvfTqWQTOcU9O0wr9QlscKPAZW4tyEzuDUex71H6L/HlfkfkcIseLfsyntzFaXyxZvdO7VsXpIhb9KTVlSvrq23DuBRhnHBId1daiDNdgkVijSlinXvVvl+va1qEqcuyQyZYMFmf3NKT0WLgSNqxdFZZSDWrLARkIxUOWFov881B4jBi2Ohv8C+dY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:18.6461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4b55c7-2c69-48a9-7db3-08deb0fc9389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The MinTTU policy in DML2.1 does not guarantee that we support p-state
in blank. This is a delta vs dml2 and earlier revisions as the prefetch
mode override has been removed in favor of a more configurable pstate
optimizer.

[How]
The policy has been added in a prior patch, this patch enables it based
on pmo flag.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dml2_0/dml21/dml21_translation_helper.c   |   5 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       | 144 ++++++++++++++++--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.h       |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   4 -
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |  16 ++
 .../dml21/src/dml2_top/dml2_top_soc15.c       |  30 +++-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |   1 +
 8 files changed, 184 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 25557c99a28e..f849fb882b2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -36,6 +36,8 @@ static void dml21_populate_pmo_options(struct dml2_pmo_options *pmo_options,
 	pmo_options->disable_drr_var_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE ||
 			in_dc->debug.disable_fams_gaming == INGAME_FAMS_MULTI_DISP_CLAMPED_ONLY;
 	pmo_options->disable_drr_clamped_when_var_active = in_dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE;
+
+	pmo_options->force_mandatory_uclk_pstate_support = config->pmo.force_mandatory_uclk_pstate_support;
 }
 
 static enum dml2_project_id dml21_dcn_revision_to_dml2_project_id(enum dce_version dcn_version)
@@ -690,7 +692,8 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 	plane->overrides.gpuvm_min_page_size_kbytes = soc_bb->gpuvm_min_page_size_kbytes;
 	plane->overrides.hostvm_min_page_size_kbytes = soc_bb->hostvm_min_page_size_kbytes;
 
-	plane->immediate_flip = plane_state->flip_immediate;
+	//Always true for DAL, we want to validate the worst case scenario as we have to switch b/w the two without possibility of failure.
+	plane->immediate_flip = true;
 
 	plane->composition.rect_out_height_spans_vactive =
 		plane_state->dst_rect.height >= stream->src.height &&
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index dff903a103db..8d7960a340c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -71,6 +71,7 @@ struct dml2_pmo_options {
 	bool disable_dyn_odm;
 	bool disable_dyn_odm_for_multi_stream;
 	bool disable_dyn_odm_for_stream_with_svp;
+	bool force_mandatory_uclk_pstate_support;
 	struct dml2_pmo_pstate_strategy *override_strategy_lists[DML2_MAX_PLANES];
 	unsigned int num_override_strategies_per_list[DML2_MAX_PLANES];
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
index 30fd5efe4b87..4e0d757388ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
@@ -13,10 +13,12 @@
  * configurations, ensuring p-state watermark support in the blank period only.
  */
 
+static const double MIN_VACTIVE_MARGIN_PCT = 0.25; // We need more than non-zero margin because DET buffer granularity can alter vactive latency hiding
+
 static const struct dml2_pmo_pstate_strategy dcn42_strategy_list_1_display[] = {
 	// VBlank only
 	{
-		.per_stream_pstate_method = { dml2_pstate_method_vblank, dml2_pstate_method_na, dml2_pstate_method_na, dml2_pstate_method_na },
+		.per_stream_pstate_method = { dml2_pstate_method_vactive, dml2_pstate_method_na, dml2_pstate_method_na, dml2_pstate_method_na },
 		.allow_state_increase = true,
 	},
 };
@@ -26,7 +28,7 @@ static const int dcn42_strategy_list_1_display_size = sizeof(dcn42_strategy_list
 static const struct dml2_pmo_pstate_strategy dcn42_strategy_list_2_display[] = {
 	// VBlank only for both displays
 	{
-		.per_stream_pstate_method = { dml2_pstate_method_vblank, dml2_pstate_method_vblank, dml2_pstate_method_na, dml2_pstate_method_na },
+		.per_stream_pstate_method = { dml2_pstate_method_vactive, dml2_pstate_method_vactive, dml2_pstate_method_na, dml2_pstate_method_na },
 		.allow_state_increase = true,
 	},
 };
@@ -36,7 +38,7 @@ static const int dcn42_strategy_list_2_display_size = sizeof(dcn42_strategy_list
 static const struct dml2_pmo_pstate_strategy dcn42_strategy_list_3_display[] = {
 	// VBlank only for all three displays
 	{
-		.per_stream_pstate_method = { dml2_pstate_method_vblank, dml2_pstate_method_vblank, dml2_pstate_method_vblank, dml2_pstate_method_na },
+		.per_stream_pstate_method = { dml2_pstate_method_vactive, dml2_pstate_method_vactive, dml2_pstate_method_vactive, dml2_pstate_method_na },
 		.allow_state_increase = true,
 	},
 };
@@ -46,31 +48,149 @@ static const int dcn42_strategy_list_3_display_size = sizeof(dcn42_strategy_list
 static const struct dml2_pmo_pstate_strategy dcn42_strategy_list_4_display[] = {
 	// VBlank only for all four displays
 	{
-		.per_stream_pstate_method = { dml2_pstate_method_vblank, dml2_pstate_method_vblank, dml2_pstate_method_vblank, dml2_pstate_method_vblank },
+		.per_stream_pstate_method = { dml2_pstate_method_vactive, dml2_pstate_method_vactive, dml2_pstate_method_vactive, dml2_pstate_method_vactive },
 		.allow_state_increase = true,
 	},
 };
 
 static const int dcn42_strategy_list_4_display_size = sizeof(dcn42_strategy_list_4_display) / sizeof(struct dml2_pmo_pstate_strategy);
 
+static bool is_bit_set_in_bitfield(unsigned int bit_field, unsigned int bit_offset)
+{
+	if (bit_field & (0x1 << bit_offset))
+		return true;
+
+	return false;
+}
+
+static void setup_planes_for_vactive_by_mask(struct display_configuation_with_meta *display_config,
+	struct dml2_pmo_instance *pmo,
+	int plane_mask)
+{
+	unsigned int plane_index;
+	unsigned int stream_index;
+	struct dml2_plane_parameters *plane;
+
+	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
+		if (is_bit_set_in_bitfield(plane_mask, plane_index)) {
+			plane = &display_config->display_config.plane_descriptors[plane_index];
+			stream_index = display_config->display_config.plane_descriptors[plane_index].stream_index;
+
+			plane->overrides.reserved_vblank_time_ns = (long)math_max2(pmo->soc_bb->power_management_parameters.dram_clk_change_blackout_us * 1000.0,
+					plane->overrides.reserved_vblank_time_ns);
+			if (!pmo->options->disable_vactive_det_fill_bw_pad) {
+				display_config->display_config.plane_descriptors[plane_index].overrides.max_vactive_det_fill_delay_us[dml2_pstate_type_uclk] =
+					(unsigned int)math_floor(pmo->scratch.pmo_dcn4.stream_pstate_meta[stream_index].method_vactive.max_vactive_det_fill_delay_us);
+			}
+
+			display_config->stage3.pstate_switch_modes[plane_index] = dml2_pstate_method_vactive;
+		}
+	}
+}
+
+static void reset_display_configuration(struct display_configuation_with_meta *display_config)
+{
+	unsigned int plane_index;
+	unsigned int stream_index;
+	struct dml2_plane_parameters *plane;
+
+	for (stream_index = 0; stream_index < display_config->display_config.num_streams; stream_index++) {
+		display_config->stage3.stream_svp_meta[stream_index].valid = false;
+	}
+
+	for (plane_index = 0; plane_index < display_config->display_config.num_planes; plane_index++) {
+		plane = &display_config->display_config.plane_descriptors[plane_index];
+
+		// Unset SubVP
+		plane->overrides.legacy_svp_config = dml2_svp_mode_override_auto;
+
+		// Remove reserve time
+		plane->overrides.reserved_vblank_time_ns = 0;
+
+		// Reset strategy to auto
+		plane->overrides.uclk_pstate_change_strategy = dml2_uclk_pstate_change_strategy_auto;
+
+		display_config->stage3.pstate_switch_modes[plane_index] = dml2_pstate_method_na;
+	}
+}
+
+static bool setup_display_config(struct display_configuation_with_meta *display_config, struct dml2_pmo_instance *pmo, int strategy_index)
+{
+	struct dml2_pmo_scratch *scratch = &pmo->scratch;
+
+	bool fams2_required = false;
+	bool success = true;
+	unsigned int stream_index;
+
+	reset_display_configuration(display_config);
+
+	for (stream_index = 0; stream_index < display_config->display_config.num_streams; stream_index++) {
+
+		if (pmo->scratch.pmo_dcn4.pstate_strategy_candidates[strategy_index].per_stream_pstate_method[stream_index] == dml2_pstate_method_na) {
+			success = false;
+			break;
+		} else if (scratch->pmo_dcn4.pstate_strategy_candidates[strategy_index].per_stream_pstate_method[stream_index] == dml2_pstate_method_vactive) {
+			setup_planes_for_vactive_by_mask(display_config, pmo, scratch->pmo_dcn4.stream_plane_mask[stream_index]);
+		}
+	}
+
+	/* copy FAMS2 meta */
+	if (success) {
+		display_config->stage3.fams2_required = fams2_required;
+		memcpy(&display_config->stage3.stream_pstate_meta,
+			&scratch->pmo_dcn4.stream_pstate_meta,
+			sizeof(struct dml2_pstate_meta) * DML2_MAX_PLANES);
+	}
+
+	return success;
+}
+
+bool pmo_dcn42_fams2_optimize_for_pstate_support(struct dml2_pmo_optimize_for_pstate_support_in_out *in_out)
+{
+	bool success = false;
+	struct dml2_pmo_scratch *s = &in_out->instance->scratch;
+
+	memcpy(in_out->optimized_display_config, in_out->base_display_config, sizeof(struct display_configuation_with_meta));
+
+	if (in_out->last_candidate_failed) {
+		if (s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.cur_pstate_candidate].allow_state_increase &&
+			s->pmo_dcn4.cur_latency_index < s->pmo_dcn4.max_latency_index - 1) {
+			s->pmo_dcn4.cur_latency_index++;
+
+			success = true;
+		}
+	}
+
+	if (!success) {
+		s->pmo_dcn4.cur_latency_index = s->pmo_dcn4.min_latency_index;
+		s->pmo_dcn4.cur_pstate_candidate++;
+
+		if (s->pmo_dcn4.cur_pstate_candidate < s->pmo_dcn4.num_pstate_candidates) {
+			success = true;
+		}
+	}
+
+	if (success) {
+		in_out->optimized_display_config->stage3.min_clk_index_for_latency = s->pmo_dcn4.cur_latency_index;
+		setup_display_config(in_out->optimized_display_config, in_out->instance, in_out->instance->scratch.pmo_dcn4.cur_pstate_candidate);
+	}
+
+	return success;
+}
+
 bool pmo_dcn42_test_for_pstate_support(struct dml2_pmo_test_for_pstate_support_in_out *in_out)
 {
 	const struct dml2_pmo_scratch *s = &in_out->instance->scratch;
-	const int REQUIRED_RESERVED_TIME =
-		(int)in_out->instance->soc_bb->power_management_parameters.dram_clk_change_blackout_us;
 	bool p_state_supported = true;
 	unsigned int stream_index;
 
-	if (in_out->base_display_config->display_config.overrides.all_streams_blanked)
-		return true;
-
 	if (s->pmo_dcn4.cur_pstate_candidate < 0)
 		return false;
 
 	for (stream_index = 0; stream_index < in_out->base_display_config->display_config.num_streams; stream_index++) {
-		if (s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.cur_pstate_candidate].per_stream_pstate_method[stream_index] == dml2_pstate_method_vblank) {
-			if (dcn4_get_minimum_reserved_time_us_for_planes(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < REQUIRED_RESERVED_TIME ||
-			    dcn4_get_vactive_pstate_margin(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) > 0) {
+		if (s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.cur_pstate_candidate].per_stream_pstate_method[stream_index] == dml2_pstate_method_vactive) {
+			if (dcn4_get_minimum_reserved_time_us_for_planes(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < (int)in_out->instance->soc_bb->power_management_parameters.dram_clk_change_blackout_us ||
+			    dcn4_get_vactive_pstate_margin(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < (int)(MIN_VACTIVE_MARGIN_PCT * in_out->instance->soc_bb->power_management_parameters.dram_clk_change_blackout_us)) {
 				p_state_supported = false;
 				break;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h
index 31ba8575351d..5db7877bb8ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h
@@ -12,6 +12,7 @@ struct dml2_pmo_initialize_in_out;
 struct dml2_pmo_test_for_pstate_support_in_out;
 
 bool pmo_dcn42_initialize(struct dml2_pmo_initialize_in_out *in_out);
+bool pmo_dcn42_fams2_optimize_for_pstate_support(struct dml2_pmo_optimize_for_pstate_support_in_out *in_out);
 bool pmo_dcn42_test_for_pstate_support(struct dml2_pmo_test_for_pstate_support_in_out *in_out);
 
 #endif /* __DML2_PMO_DCN42_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index b348c65a0f75..8301e23ab89f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1884,10 +1884,6 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 
 	memset(s, 0, sizeof(struct dml2_pmo_scratch));
 
-	if (display_config->display_config.overrides.all_streams_blanked) {
-		return true;
-	}
-
 	pmo->scratch.pmo_dcn4.min_latency_index = in_out->base_display_config->stage1.min_clk_index_for_latency;
 	pmo->scratch.pmo_dcn4.max_latency_index = pmo->mcg_clock_table_size;
 	pmo->scratch.pmo_dcn4.cur_latency_index = in_out->base_display_config->stage1.min_clk_index_for_latency;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
index af2ba7d08a61..a1164de13a05 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
@@ -5,6 +5,7 @@
 #include "dml2_pmo_factory.h"
 #include "dml2_pmo_dcn4_fams2.h"
 #include "dml2_pmo_dcn3.h"
+#include "dml2_pmo_dcn42.h"
 #include "dml2_external_lib_deps.h"
 
 static bool dummy_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in_out)
@@ -60,6 +61,21 @@ bool dml2_pmo_create(enum dml2_project_id project_id, struct dml2_pmo_instance *
 		result = true;
 		break;
 	case dml2_project_dcn42:
+		out->initialize = pmo_dcn42_initialize;
+
+		out->init_for_vmin = pmo_dcn4_fams2_init_for_vmin;
+		out->test_for_vmin = pmo_dcn4_fams2_test_for_vmin;
+		out->optimize_for_vmin = pmo_dcn4_fams2_optimize_for_vmin;
+
+		out->init_for_uclk_pstate = pmo_dcn4_fams2_init_for_pstate_support;
+		out->test_for_uclk_pstate = pmo_dcn42_test_for_pstate_support;
+		out->optimize_for_uclk_pstate = pmo_dcn42_fams2_optimize_for_pstate_support;
+
+		out->init_for_stutter = pmo_dcn4_fams2_init_for_stutter;
+		out->test_for_stutter = pmo_dcn4_fams2_test_for_stutter;
+		out->optimize_for_stutter = pmo_dcn4_fams2_optimize_for_stutter;
+		result = true;
+		break;
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
 		out->initialize = pmo_dcn4_fams2_initialize;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c
index fa20a91c6e16..e6c49c27035c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c
@@ -782,6 +782,7 @@ static bool dml2_top_soc15_check_mode_supported(struct dml2_check_mode_supported
 
 	bool result = false;
 	bool mcache_success = false;
+	bool uclk_pstate_success = false;
 	memset(dpmm_programming, 0, sizeof(struct dml2_display_cfg_programming));
 
 	setup_unoptimized_display_config_with_meta(dml, &l->base_display_config_with_meta, in_out->display_config);
@@ -805,6 +806,24 @@ static bool dml2_top_soc15_check_mode_supported(struct dml2_check_mode_supported
 		mcache_success = dml2_top_optimization_perform_optimization_phase(&l->optimization_phase_locals, &mcache_phase);
 	}
 
+	if (result) {
+		if (dml->pmo_options.force_mandatory_uclk_pstate_support) {
+			struct optimization_phase_params uclk_phase =	{
+			.dml = dml,
+			.display_config = &l->base_display_config_with_meta,
+			.init_function = dml2_top_optimization_init_function_uclk_pstate,
+			.test_function = dml2_top_optimization_test_function_uclk_pstate,
+			.optimize_function = dml2_top_optimization_optimize_function_uclk_pstate,
+			.optimized_display_config = &l->optimized_display_config_with_meta,
+			.all_or_nothing = false,
+			};
+
+			uclk_pstate_success = dml2_top_optimization_perform_optimization_phase(&l->optimization_phase_locals, &uclk_phase);
+		} else {
+			uclk_pstate_success = true;
+		}
+	}
+
 	/*
 	* Call DPMM to map all requirements to minimum clock state
 	*/
@@ -817,7 +836,7 @@ static bool dml2_top_soc15_check_mode_supported(struct dml2_check_mode_supported
 		result = dml->dpmm_instance.map_mode_to_soc_dpm(&l->dppm_map_mode_params);
 	}
 
-	in_out->is_supported = mcache_success;
+	in_out->is_supported = mcache_success & uclk_pstate_success;
 	result = result && in_out->is_supported;
 
 	return result;
@@ -928,6 +947,15 @@ static bool dml2_top_soc15_build_mode_programming(struct dml2_build_mode_program
 	if (uclk_pstate_success) {
 		memcpy(&l->base_display_config_with_meta, &l->optimized_display_config_with_meta, sizeof(struct display_configuation_with_meta));
 		l->base_display_config_with_meta.stage3.success = true;
+	} else if (dml->pmo_options.force_mandatory_uclk_pstate_support) {
+		l->informative_params.instance = &dml->core_instance;
+		l->informative_params.programming = in_out->programming;
+		l->informative_params.mode_is_supported = false;
+
+		dml->core_instance.populate_informative(&l->informative_params);
+
+		in_out->programming->informative.failed_mcache_validation = true;
+		return false;
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
index 5ee489682f2e..2f2ae05dd59c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.h
@@ -232,6 +232,7 @@ struct dml2_configuration_options {
 	/* Only for debugging purposes when initializing SOCBB params via tool for DML21. */
 	struct socbb_ip_params_external *external_socbb_ip_params;
 	struct {
+		bool force_mandatory_uclk_pstate_support;
 		bool force_pstate_method_enable;
 		enum dml2_force_pstate_methods force_pstate_method_values[MAX_PIPES];
 	} pmo;
-- 
2.43.0

