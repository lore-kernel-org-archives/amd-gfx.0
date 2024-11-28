Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAE5D69115
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CEC10ECA0;
	Thu, 28 Nov 2024 14:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HnbEuq5v";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E3D10ECAA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P80V0Y/ZvF3AgXCCBUGxfW0/y3qno9kjbA3nbrN6reoG9CNEE66/iiqWnV7EuBfMnuy8qbn+cNx90O5Q9CHemq12WQdHSF6dPOkzNHf7yxdbntQTKDoUDtEEJDU6rvvq+VhWQVhZ4v2WuTVfhOyKIZ0UVcrXilUtLnRTbnGfK4dwuDCPSZ/wVHyneKvP0DS1s7QT1k1tzYG+mAer7na2No3rY0jiNmpQjsd16nlD7QkFQY0jRvt49vc4wqx8N1yp0+fzTj6YMpIotOmQOx71TQfpqDaHiKD6N6bOj7xVsPfLJLMkWqZeCIZBstwrdLbofkkZvI4MDoYX/CPIUlqeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HzGKy62nQcwaJ46WZzhVHh1NGC8vSn0ZMgkftm4CLA=;
 b=wfJama0YGH2Ni3r+f5o3pa1ENmKyoFGYKo2+0Eozy65ANwLRVrc2+0Y6EYMORMiQdCQjupiKcIGX1A7mOXY3/W4Bf+hziZZQe81m6x0kRZFD5UL2VD7mjr9ai1UAM01+mhux4BSmXnI81jLUkBGd+FdosHr00zSRggQ9pZf5SnBVouplkJ2ePAhxtwdtyj54TyrmX7bMankVuNj1D8cDnXhGfNdxnEbn1CdZnbEDkwjI2u0gDOy1SPHSe0anEKwb++howgfbB8yuBiM6Mo9qDp+J9p42b782Ns/vhYTyhDLKpcGtL1kVYgj+EusH5MgMOBPelvkO85AK64GqE7smXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HzGKy62nQcwaJ46WZzhVHh1NGC8vSn0ZMgkftm4CLA=;
 b=HnbEuq5vpX55ws3Yyobyu0Cb1VOKSXY2PzJEnm9tM0wdiMl2IrRqg39mNgitB2HDaqC5waYX7x++TKjJknHLwRKOGdQQNYj/D8/WGP3EMyC3748D7Rd8kVzufShKr0/bm4U3lQQrM1x6lFWLBH3GzzUYMYelHejQxVjuT6rBcsw=
Received: from SN6PR05CA0003.namprd05.prod.outlook.com (2603:10b6:805:de::16)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Thu, 28 Nov
 2024 14:30:19 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::83) by SN6PR05CA0003.outlook.office365.com
 (2603:10b6:805:de::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 14:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 14:30:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:18 -0600
Received: from jzuo-linux.phub.net.cable.rogers.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Nov 2024 08:30:17 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ausef Yousof
 <Ausef.Yousof@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 3/9] drm/amd/display: Populate chroma prefetch parameters,
 DET buffer fix
Date: Thu, 28 Nov 2024 09:26:25 -0500
Message-ID: <20241128142958.28370-4-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128142958.28370-1-Jerry.Zuo@amd.com>
References: <20241128142958.28370-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: e6602fca-b5b2-411b-ed08-08dd0fb92f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|30052699003|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?epGLip5Q/ucrQYbrLWvN0p8suYtmjynwdKZNOI4If1k/BCHIfhc+z94y7hvw?=
 =?us-ascii?Q?z1hUpxY5H2e9ZU/aVawnS4BkKUJsu8IyqQb8dhRRKRULBDba5fgpZZZrcpx2?=
 =?us-ascii?Q?h0p1Q/nDU2CG1rGgtBR7f0TBHeQ/P85IiQDszkYeKrsetBEuRiQQUgm2Huma?=
 =?us-ascii?Q?Q491YifffGIiyl+Rl0WyKs4xMFa61iKDw2cADYK2W9RvrlKMX4Tnh6/li4cA?=
 =?us-ascii?Q?8TOx73TwRcBG6pWjAMt2N7Ju2h3PJ9TsvRymgI1z7qPnDucQIZFCTIgG9xso?=
 =?us-ascii?Q?1mqZ/B+t6EPt9VOJRD87dQBm3tMTM1S6sZG4UXdlU5acGi+D2APqmus+gblg?=
 =?us-ascii?Q?EPADj93LqhRJypXfFke7bsZzT809krqYiFwHp6dMowgz9p1rvu4MEajaC01L?=
 =?us-ascii?Q?O8f9Oat/ecWPew6kwdcuaGuABMIrUwiRZl9itzhD4ZaUjH9kSY4UON9T28pf?=
 =?us-ascii?Q?C6aKP3FZ8OFtFqQr3b3TD2Oj8lrK6q+/L4iQSmGD0/k/89lu/NSM5MbxIKmw?=
 =?us-ascii?Q?J5uDaqvx6uxOFefgJdOFzUZs3k+RUjEUvDerLgmZvNec0WKy4pngcafr9IY6?=
 =?us-ascii?Q?aiyxV5u41PmtX/zJKVZgMSnFgLqd8/yyViq2rn2uSgtS/IXPu3kBMHFK+93a?=
 =?us-ascii?Q?kfdATIbSB5z9sa+2pjZ7YDnQLOYqubIXvngZMEeSzjlvWX42Yxh4rlYp0XeN?=
 =?us-ascii?Q?TR8IGigMPrMGeqNN/KyIU9zoEgG5doen2uSBBPz6pRzMPU3xiopqXYvk3cXL?=
 =?us-ascii?Q?Dk+EcA1b3g2rm5edGYg9HlZo0trMcTNJn+pMyBUccAAE4Io9hWolHH8IjloW?=
 =?us-ascii?Q?f7VV5aEgU7S3VKdPeXE4nWCCWWrUhvZqSRuqUsGgBIIFciSneB8XCMjMDHbU?=
 =?us-ascii?Q?OaeDprjN3aB39CiULlpffoXSi9GZaEOTKcn79c/mrcVQWbDTgj1AdkxyJoQc?=
 =?us-ascii?Q?wDklAHTUbVucVkeH0wLyd2p3erkKJVQgQadCE+9u/8rIlLIkd0Hsobkx4B/r?=
 =?us-ascii?Q?hIjxayoYIThkQJjGXVK9lufL008tZq+5KOLZLV22yxGGSu32MeJhA0ls/x7j?=
 =?us-ascii?Q?N1dKdSeQQDBaTN2rU+AJpdZCTT9ctqJDQbVVFDSoJkHxbkzfEr5GP1ZzClL+?=
 =?us-ascii?Q?ZOdxNW5ubhM62UFozl7hQ/259ISIe5pL7NZ5NkXRsXPXEvkZFMas83+k0qVA?=
 =?us-ascii?Q?H+eENyADINlGGAIKYFe+L2KSflt88d7byr3PZHKVgJOmRT0wnZdR/1TlKmJq?=
 =?us-ascii?Q?QFEWDxeItfI/Bgi6ckPgIsq2PSFngAaIDeWmtjgX9FbeJ2G+ueGCLmn6ADbi?=
 =?us-ascii?Q?jjFBEz7a/RqWODUp46QhxjOqS02Iik/hyZyjxDCNDO2ox6jcQNtglQh1Vrvt?=
 =?us-ascii?Q?UihP/yO1xkBALje94AeqgKfDLiu4AT6COVN/Ewqu9Ps+rW808iTcoNTFQN0p?=
 =?us-ascii?Q?6FBPnvojvR7MF9LGzsWylqRrRa1q1JEq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(30052699003)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:30:19.1323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6602fca-b5b2-411b-ed08-08dd0fb92f38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[WHY]

Soft hang/lag observed during 10bit playback + moving cursor, corruption
observed in other tickets for same reason, also failing MPO.

1. Currently, we are always running
   calculate_lowest_supported_state_for_temp_read which is only
   necessary on dGPU
2. Fast validate path does not apply DET buffer allocation policy
3. Prefetch UrgBFactor chroma parameter not populated in prefetch
   calculation

[HOW]
1. Add a check to see if we are on APU, if so, skip the code
2. Add det buffer alloc policy checks to fast validate path
3. Populate UrgentBurstChroma param in call to calculate
   UrgBChroma prefetch values

-revision commits: small formatting/brackets/null check addition + remove test change + dGPU code

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../amd/display/dc/dml2/display_mode_core.c   |  5 ++-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 35 +++++++++++++------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 8dabb1ac0b68..be87dc0f0779 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6434,7 +6434,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 							/* Output */
 							&mode_lib->ms.UrgentBurstFactorCursorPre[k],
 							&mode_lib->ms.UrgentBurstFactorLumaPre[k],
-							&mode_lib->ms.UrgentBurstFactorChroma[k],
+							&mode_lib->ms.UrgentBurstFactorChromaPre[k],
 							&mode_lib->ms.NotUrgentLatencyHidingPre[k]);
 
 					mode_lib->ms.cursor_bw_pre[k] = mode_lib->ms.cache_display_cfg.plane.NumberOfCursors[k] * mode_lib->ms.cache_display_cfg.plane.CursorWidth[k] *
@@ -9190,6 +9190,8 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 			&locals->FractionOfUrgentBandwidth,
 			&s->dummy_boolean[0]); // dml_bool_t *PrefetchBandwidthSupport
 
+
+
 		if (s->VRatioPrefetchMoreThanMax != false || s->DestinationLineTimesForPrefetchLessThan2 != false) {
 			dml_print("DML::%s: VRatioPrefetchMoreThanMax                   = %u\n", __func__, s->VRatioPrefetchMoreThanMax);
 			dml_print("DML::%s: DestinationLineTimesForPrefetchLessThan2    = %u\n", __func__, s->DestinationLineTimesForPrefetchLessThan2);
@@ -9204,6 +9206,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 			}
 		}
 
+
 		if (locals->PrefetchModeSupported == true && mode_lib->ms.support.ImmediateFlipSupport == true) {
 			locals->BandwidthAvailableForImmediateFlip = CalculateBandwidthAvailableForImmediateFlip(
 																	mode_lib->ms.num_active_planes,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 9190c1328d5b..340791d40ecb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -531,14 +531,21 @@ static bool optimize_pstate_with_svp_and_drr(struct dml2_context *dml2, struct d
 static bool call_dml_mode_support_and_programming(struct dc_state *context)
 {
 	unsigned int result = 0;
-	unsigned int min_state;
+	unsigned int min_state = 0;
 	int min_state_for_g6_temp_read = 0;
+
+
+	if (!context)
+		return false;
+
 	struct dml2_context *dml2 = context->bw_ctx.dml2;
 	struct dml2_wrapper_scratch *s = &dml2->v20.scratch;
 
-	min_state_for_g6_temp_read = calculate_lowest_supported_state_for_temp_read(dml2, context);
+	if (!context->streams[0]->sink->link->dc->caps.is_apu) {
+		min_state_for_g6_temp_read = calculate_lowest_supported_state_for_temp_read(dml2, context);
 
-	ASSERT(min_state_for_g6_temp_read >= 0);
+		ASSERT(min_state_for_g6_temp_read >= 0);
+	}
 
 	if (!dml2->config.use_native_pstate_optimization) {
 		result = optimize_pstate_with_svp_and_drr(dml2, context);
@@ -549,14 +556,20 @@ static bool call_dml_mode_support_and_programming(struct dc_state *context)
 	/* Upon trying to sett certain frequencies in FRL, min_state_for_g6_temp_read is reported as -1. This leads to an invalid value of min_state causing crashes later on.
 	 * Use the default logic for min_state only when min_state_for_g6_temp_read is a valid value. In other cases, use the value calculated by the DML directly.
 	 */
-	if (min_state_for_g6_temp_read >= 0)
-		min_state = min_state_for_g6_temp_read > s->mode_support_params.out_lowest_state_idx ? min_state_for_g6_temp_read : s->mode_support_params.out_lowest_state_idx;
-	else
-		min_state = s->mode_support_params.out_lowest_state_idx;
-
-	if (result)
-		result = dml_mode_programming(&dml2->v20.dml_core_ctx, min_state, &s->cur_display_config, true);
+	if (!context->streams[0]->sink->link->dc->caps.is_apu) {
+		if (min_state_for_g6_temp_read >= 0)
+			min_state = min_state_for_g6_temp_read > s->mode_support_params.out_lowest_state_idx ? min_state_for_g6_temp_read : s->mode_support_params.out_lowest_state_idx;
+		else
+			min_state = s->mode_support_params.out_lowest_state_idx;
+	}
 
+	if (result) {
+		if (!context->streams[0]->sink->link->dc->caps.is_apu) {
+			result = dml_mode_programming(&dml2->v20.dml_core_ctx, min_state, &s->cur_display_config, true);
+		} else {
+			result = dml_mode_programming(&dml2->v20.dml_core_ctx, s->mode_support_params.out_lowest_state_idx, &s->cur_display_config, true);
+		}
+	}
 	return result;
 }
 
@@ -685,6 +698,8 @@ static bool dml2_validate_only(struct dc_state *context)
 	build_unoptimized_policy_settings(dml2->v20.dml_core_ctx.project, &dml2->v20.dml_core_ctx.policy);
 
 	map_dc_state_into_dml_display_cfg(dml2, context, &dml2->v20.scratch.cur_display_config);
+	 if (!dml2->config.skip_hw_state_mapping)
+		 dml2_apply_det_buffer_allocation_policy(dml2, &dml2->v20.scratch.cur_display_config);
 
 	result = pack_and_call_dml_mode_support_ex(dml2,
 		&dml2->v20.scratch.cur_display_config,
-- 
2.43.0

