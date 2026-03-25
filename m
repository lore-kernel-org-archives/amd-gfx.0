Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64B3FEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A0AD10E7B4;
	Wed, 25 Mar 2026 07:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dKSns3PX";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AAA10E7B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kkg7R1YAYwh2cStTnm+DcOghDyjAJL61ikpvlybKMrTP66VjAOfUCans9pcMnDHX/NjjuCT5mEXumZPrA5FmPbQJ4gqraljf35ONuauBsnbQrpU8S6nEqnrgTTDPeJb8UxJmQLv66ohJ7qeffaGONtl9uOtHfQOBqNkW24qN2nnDRLIit8paHZdSsieHM9wqR5SnWl74tv1Ce8WqjTsWBgSH6Bslv3Lk6TJl1tENLpSEjebDXs1ZspDphilZyFgUrxKEl8y/95+Yum5Em1LYbCL5QQ/SZXPCxQ1LZMp8QMJd/fr8W6hkptUl0tAtkjYAtg76jsp4EtY3kIB94s5k5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lIMt+xtGATjCF9hOh2lynMHw40cMDkYpcDf3JYptc4=;
 b=NJzMFiK817tWyJ2tDmOlc27R7+YeEK7VauecABKNyUQGHhUVGm9YC+wR2KVXQ0JI0PFvUyRPfnNMrApRYmFkq09Pd9qa4oSGUD/dMrm6buEMj6e5uOo1iGoEcHiM0pMYKOLvptkBROaan+c6H4XaOUH/ElcjU/20DqejSRoR9rZVZu7/p4OeSZlqWeN2Kd1W7OhjvNvum7JDbeaE+MEcVRQaH1B07bZAFULxX2tDT/81vFSDHMOP69ZJ+aGmxUvlLvi1RfnBXgQtkxjv+VBQFSH2IhmNAW8Tbxfn0E4E2HrxnxAq3Uqbggch+C3WG8EVra3/JGNwyzh9tJ4NatNF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lIMt+xtGATjCF9hOh2lynMHw40cMDkYpcDf3JYptc4=;
 b=dKSns3PXvgng3RucnhvhhcusM5cZwyIyZ96tr6kd96IyPgUcdlehCIKKBamY1YwEyb+kDXZgxrNVtaARHLmakjnv+3cHa7QaChVODjqYU3r4h6eHhuO+6tmH8nGc0c991Z4of8TKFk9ehLyvm9Lsj5gimUrHQeVVRqMGCg1iRGo=
Received: from BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::8)
 by DS5PPF4A654669B.namprd12.prod.outlook.com (2603:10b6:f:fc00::64b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 25 Mar
 2026 07:10:52 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::ee) by BLAP220CA0003.outlook.office365.com
 (2603:10b6:208:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 07:10:52 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:10:47 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Austin
 Zheng" <austin.zheng@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 27/29] drm/amd/display: Silence type conversion warnings in
 dml2
Date: Wed, 25 Mar 2026 15:06:33 +0800
Message-ID: <20260325071003.4022594-28-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DS5PPF4A654669B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2973199c-07ec-4dc6-faea-08de8a3da657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|30052699003|56012099003|20052099010|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lind4+Fw8nbnbWKeaMYsLGRRaV5p9OaZI4pfGn+MGnfo6419qF3/2HeuWcnGkV1LLnHOMZf5mgv+xPSb0Cp4v36hrSWl/C/cpZ1n7vLeVHf6K6Mm2jHzPfYIWwrnC9aAQERVQzwmCIMXZvJL7m48nvDCRv5w46ko3Sk4EbiA1pwoR+6h6MP29DxRqFyHpMYd6p5fpofmuH5jSj02r18jVPKe3mvR8pGJdDUoJcd1AMMJglEsRpucuOS1SLZZnMoh5eua3m843zhhOuJ8fiRvgZklK9/WrZfVk5pSaH+g8tYxxhiGSfViWSBxhwwtMl+bDSVAAiUnGvlEJ0VoeYR5I1q09KbepGEawryJypl3UKckLn8UOp382Mw2HKTVyisdxX7vKz1UUz79SolG+POBNICfFAOGy7V/Sfb65wN51W0g1wVQd6EfNpFCJDyfRC+2z9HVf2aFmEJOq65M/oA1wJjGR19n/EySZF1qjsdDd3d+h87l5bnxVegRxBQVOXzNEemyQoxQGkXiklW+ZXsBQBO9grWOpFmfPAtadFDAzf8rRIWwujqeuOVpzGBy34VrZ5ag0zRotIdNg7iwdjpVE04hg0FXkDkMv0KYHT623HfiON5io9lY2mndAVeNjQiBkZFoCbIQWUWijqxBYZS5LdYvIgZuglHEJep9YUSrKE9r1Z9lFvK1xP5kHDRSNb3ouv1N2BsLS0AiyTkWr1ui3yNhrJKxk5aUz4Lk6jcUptE5cYYbLCrtjlSfsRjQR/eJX7F4blmyyygPVNtjbukdzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(30052699003)(56012099003)(20052099010)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1JXp1dnTYgas6K5bnIrsWvqZfFQtsR6kVmNfvHnLLAsN7aKwLBk7JZxURR9b4kv5laIZTvxq7P6EZorZh8IK1PPhWGV0hYyJo8E5fbpz7IVP+i3TFVh9NDMoFnRvr2/WzQ0MhyxISI/kBaoVmnQ0lijb3+a2Ce1IqfvqKISP8BNcJ5uNdwPC2FudGbETIYgdiQ4tzrxpG6MTFsSfMWiqrgjzW235xSTTLak9+tihmz5gBiHq0y1XLoWzYoa6JaMeYkS5TWyuKiRP3bHrrmziyXXe1h1kRzbQYxxRSSM9fSkq0FaOa3uFRXFN09jCKKgqOOWtnyeOEQdGDO4sHUBRTuspFmiWs5TmCPrwvvQcX26zsGpPVY3k+kTPw3+Dc5Y3WFqpQ04jI23uUbFHUp0mt+w9/LO4ZNuX37MfmXw9qsxYgJrBg/h5SGboYP8ahTs8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:10:52.1168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2973199c-07ec-4dc6-faea-08de8a3da657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4A654669B
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
Compiler build generates type conversion warnings throughout dc/dml2_0
where values are implicitly narrowed (e.g. int/uint32_t/uint64_t assigned
to uint8_t, unsigned char, char, bool, or dml_bool_t), cluttering build
output and masking genuine issues.

[How]
Add explicit casts at each narrowing assignment with ASSERT guards
to catch out-of-range values in debug builds:
- uint8_t: otg_inst, num_planes, pipe_idx, vblank_index fields
- unsigned char: pipe_dlg_param.otg_inst from tg->inst
- char: mcache num_pipes from num_dpps_required
- bool/dml_bool_t: INTERLACE bitfield and fams2 enable flag use != 0
- uint64_t: widen min_hardware_refresh_in_uhz to hold div64_u64 result,
  then cast to unsigned long for min_refresh_uhz with ASSERT

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../dc/dml2_0/dml21/dml21_translation_helper.c | 13 +++++++++----
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c  | 15 +++++++++++----
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c        |  6 ++++--
 .../display/dc/dml2_0/dml2_dc_resource_mgmt.c  | 18 ++++++++++++------
 .../amd/display/dc/dml2_0/dml2_mall_phantom.c  |  3 ++-
 .../dc/dml2_0/dml2_translation_helper.c        |  2 +-
 .../gpu/drm/amd/display/dc/dml2_0/dml2_utils.c |  3 ++-
 7 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index eadf84842ca0..2f0e0048bea8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -90,7 +90,8 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 		struct pipe_ctx *pipe_ctx,
 		struct dml2_context *dml_ctx)
 {
-	unsigned int hblank_start, vblank_start, min_hardware_refresh_in_uhz;
+	unsigned int hblank_start, vblank_start;
+	uint64_t min_hardware_refresh_in_uhz;
 	uint32_t pix_clk_100hz;
 
 	timing->h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->dsc_padding_params.dsc_hactive_padding;
@@ -105,7 +106,7 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	timing->h_total = stream->timing.h_total + pipe_ctx->dsc_padding_params.dsc_htotal_padding;
 	timing->v_total = stream->timing.v_total;
 	timing->h_sync_width = stream->timing.h_sync_width;
-	timing->interlaced = stream->timing.flags.INTERLACE;
+	timing->interlaced = (stream->timing.flags.INTERLACE != 0);
 
 	hblank_start = stream->timing.h_total - stream->timing.h_front_porch;
 
@@ -137,7 +138,11 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 				(timing->h_total * (long long)calc_max_hardware_v_total(stream)));
 	}
 
-	timing->drr_config.min_refresh_uhz = max(stream->timing.min_refresh_in_uhz, min_hardware_refresh_in_uhz);
+	{
+		uint64_t min_refresh = max((uint64_t)stream->timing.min_refresh_in_uhz, min_hardware_refresh_in_uhz);
+		ASSERT(min_refresh <= ULONG_MAX);
+		timing->drr_config.min_refresh_uhz = (unsigned long)min_refresh;
+	}
 
 	if (dml_ctx->config.callbacks.get_max_flickerless_instant_vtotal_increase &&
 			stream->ctx->dc->config.enable_fpo_flicker_detection == 1)
@@ -697,7 +702,7 @@ unsigned int map_plane_to_dml21_display_cfg(const struct dml2_context *dml_ctx,
 
 	if (!dml21_wrapper_get_plane_id(context, stream_id, plane, &plane_id)) {
 		ASSERT(false);
-		return -1;
+		return UINT_MAX;
 	}
 
 	for (i = 0; i < __DML2_WRAPPER_MAX_STREAMS_PLANES__; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index ab7ec24268be..4724b08c77e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -420,8 +420,12 @@ static unsigned int dml21_build_fams2_stream_programming_v2(const struct dc *dc,
 			type = static_base_state->stream_v1.base.type;
 
 			/* get information from context */
-			static_base_state->stream_v1.base.num_planes = context->stream_status[dc_stream_idx].plane_count;
-			static_base_state->stream_v1.base.otg_inst = context->stream_status[dc_stream_idx].primary_otg_inst;
+			ASSERT(context->stream_status[dc_stream_idx].plane_count >= 0 &&
+					context->stream_status[dc_stream_idx].plane_count <= 0xFF);
+			ASSERT(context->stream_status[dc_stream_idx].primary_otg_inst >= 0 &&
+					context->stream_status[dc_stream_idx].primary_otg_inst <= 0xFF);
+			static_base_state->stream_v1.base.num_planes = (uint8_t)context->stream_status[dc_stream_idx].plane_count;
+			static_base_state->stream_v1.base.otg_inst = (uint8_t)context->stream_status[dc_stream_idx].primary_otg_inst;
 
 			/* populate pipe masks for planes */
 			for (dc_plane_idx = 0; dc_plane_idx < context->stream_status[dc_stream_idx].plane_count; dc_plane_idx++) {
@@ -458,7 +462,9 @@ static unsigned int dml21_build_fams2_stream_programming_v2(const struct dc *dc,
 			switch (dc->debug.fams_version.minor) {
 			case 1:
 			default:
-				static_sub_state->stream_v1.sub_state.subvp.phantom_otg_inst = phantom_status->primary_otg_inst;
+				ASSERT(phantom_status->primary_otg_inst >= 0 &&
+						phantom_status->primary_otg_inst <= 0xFF);
+				static_sub_state->stream_v1.sub_state.subvp.phantom_otg_inst = (uint8_t)phantom_status->primary_otg_inst;
 
 				/* populate pipe masks for phantom planes */
 				for (dc_plane_idx = 0; dc_plane_idx < phantom_status->plane_count; dc_plane_idx++) {
@@ -516,7 +522,8 @@ void dml21_build_fams2_programming(const struct dc *dc,
 		context->bw_ctx.bw.dcn.fams2_global_config.num_streams = num_fams2_streams;
 	}
 
-	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
+	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching =
+			(context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable != 0);
 }
 
 bool dml21_is_plane1_enabled(enum dml2_source_format_class source_format)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
index f3abfdbe6805..cc992af6ac9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
@@ -297,7 +297,8 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		memset(mcache_config, 0, sizeof(struct dml2_plane_mcache_configuration_descriptor));
 		mcache_config->plane_descriptor = pln_prog->plane_descriptor;
 		mcache_config->mcache_allocation = &context->bw_ctx.bw.dcn.mcache_allocations[dml_prog_idx];
-		mcache_config->num_pipes = pln_prog->num_dpps_required;
+		ASSERT(pln_prog->num_dpps_required <= 0x7F);
+		mcache_config->num_pipes = (char)pln_prog->num_dpps_required;
 		l->build_mcache_programming_params.num_configurations++;
 
 		if (pln_prog->num_dpps_required == 0) {
@@ -324,7 +325,8 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 			memset(mcache_config, 0, sizeof(struct dml2_plane_mcache_configuration_descriptor));
 			mcache_config->plane_descriptor = pln_prog->plane_descriptor;
 			mcache_config->mcache_allocation = &context->bw_ctx.bw.dcn.mcache_allocations[dml_phantom_prog_idx];
-			mcache_config->num_pipes = pln_prog->num_dpps_required;
+			ASSERT(pln_prog->num_dpps_required <= 0x7F);
+			mcache_config->num_pipes = (char)pln_prog->num_dpps_required;
 			l->build_mcache_programming_params.num_configurations++;
 
 			for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
index 40f2f1ebab3a..6ef93c6fc1cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
@@ -366,7 +366,8 @@ static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 		if (!is_plane_using_pipe(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			pipe->pipe_idx = preferred_pipe_candidates[i];
+			ASSERT(preferred_pipe_candidates[i] <= 0xFF);
+			pipe->pipe_idx = (uint8_t)preferred_pipe_candidates[i];
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
@@ -382,7 +383,8 @@ static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 		if (!is_plane_using_pipe(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			pipe->pipe_idx = i;
+			ASSERT(i >= 0 && i <= 0xFF);
+			pipe->pipe_idx = (uint8_t)i;
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
@@ -393,7 +395,8 @@ static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 		if (!is_plane_using_pipe(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			pipe->pipe_idx = last_resort_pipe_candidates[i];
+			ASSERT(last_resort_pipe_candidates[i] <= 0xFF);
+			pipe->pipe_idx = (uint8_t)last_resort_pipe_candidates[i];
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
@@ -432,7 +435,8 @@ static bool find_more_free_pipes(struct dml2_context *ctx,
 		if (is_pipe_free(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			pipe->pipe_idx = preferred_pipe_candidates[i];
+			ASSERT(preferred_pipe_candidates[i] <= 0xFF);
+			pipe->pipe_idx = (uint8_t)preferred_pipe_candidates[i];
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
@@ -448,7 +452,8 @@ static bool find_more_free_pipes(struct dml2_context *ctx,
 		if (is_pipe_free(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			pipe->pipe_idx = i;
+			ASSERT(i >= 0 && i <= 0xFF);
+			pipe->pipe_idx = (uint8_t)i;
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
@@ -459,7 +464,8 @@ static bool find_more_free_pipes(struct dml2_context *ctx,
 		if (is_pipe_free(pipe)) {
 			pipes_needed--;
 			// TODO: This doens't make sense really, pipe_idx should always be valid
-			pipe->pipe_idx = last_resort_pipe_candidates[i];
+			ASSERT(last_resort_pipe_candidates[i] <= 0xFF);
+			pipe->pipe_idx = (uint8_t)last_resort_pipe_candidates[i];
 			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
index d56e58ce26c7..9bbe4e058be7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
@@ -555,7 +555,8 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 
 		if (!found && pipe_mall_type == SUBVP_NONE) {
 			// Found pipe which is not SubVP or Phantom (i.e. the VBLANK pipe).
-			vblank_index = i;
+			ASSERT(i <= 0xFF);
+			vblank_index = (uint8_t)i;
 			found = true;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
index 57f45b27de1d..cf3a69aba638 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
@@ -765,7 +765,7 @@ static void populate_dml_timing_cfg_from_stream_state(struct dml_timing_cfg_st *
 		out->PixelClock[location] *= 2;
 	out->HTotal[location] = in->timing.h_total;
 	out->VTotal[location] = in->timing.v_total;
-	out->Interlace[location] = in->timing.flags.INTERLACE;
+	out->Interlace[location] = (in->timing.flags.INTERLACE != 0);
 	hblank_start = in->timing.h_total - in->timing.h_front_porch;
 	out->HBlankEnd[location] = hblank_start
 					- in->timing.h_addressable
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
index 9a33158b63bf..6c7cdf102906 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
@@ -255,7 +255,8 @@ static void populate_pipe_ctx_dlg_params_from_dml(struct pipe_ctx *pipe_ctx, str
 	pipe_ctx->pipe_dlg_param.vupdate_width = dml_get_vupdate_width(mode_lib, pipe_idx);
 	pipe_ctx->pipe_dlg_param.vready_offset = dml_get_vready_offset(mode_lib, pipe_idx);
 
-	pipe_ctx->pipe_dlg_param.otg_inst = pipe_ctx->stream_res.tg->inst;
+	ASSERT(pipe_ctx->stream_res.tg->inst >= 0 && pipe_ctx->stream_res.tg->inst <= 0xFF);
+	pipe_ctx->pipe_dlg_param.otg_inst = (unsigned char)pipe_ctx->stream_res.tg->inst;
 
 	pipe_ctx->pipe_dlg_param.hactive = hactive;
 	pipe_ctx->pipe_dlg_param.vactive = vactive;
-- 
2.43.0

