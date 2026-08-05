Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D15C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E135A10ECF6;
	Wed,  5 Aug 2026 06:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EArKbv95";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B8410ECF7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFOPsQvdxoepPrqJY3fumwlQ+ZfQQ35r5uIj4vElNpvQH5oUBIMay07PmgW8UkMoIJ5Y8EtnY6O4y9qVpcM/sMkibXvuQmFfmoUi6o27ijF/Bx2fYHZ59OKFCLpm9IvUseHrg4qP+HN3W1I8HKiSiKxS7oj6DG1V5Pw6g5efUsE6KWk/8JDZl0/xGlmpvttoFWxyFtCdL70ryBZvBnQz6TOiBb1djKvjnnD3OVwLVL34RnhfMauPO3tgzQTfJWbi4vfilX3PhzkjeDPpGp88QMCw9FQM6r/mh+QHEZyEvknaZ3qaz/ao5htgGSS/DybnMC0ZxlfCuDgsi9tvb/4GRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWa4xFk/2/VMSDqIdshBa86S2iyp4KRDIgCnUT/5L2s=;
 b=gKKkCBIbaon6oPji3tjClAa5RCa4DSXLZ0rIRQpeuyGfvf9beuUb1Gq8CQVWtHEFR/w6rs8ch81vlIc4FnvadPsfk7VlcNy5QyZzCOGim455ZKFG5RkIDK6OtBf8XD3/s8p10Gu00bxBAy59Y+PPORVRnvY5GRIZOy8uzVIjlx/C1OK3K4U514hTHbdPKiTWjwqC5m7LYvuV6FINB7kmqSKvuQDapn9QMtV+gIkjgPJCskIbBHosg848KpuPhoEc8ZHH6sBdcrVDSdN933cBc6Z1M2+1ccMHV0rLVklOAaZvj9dCOsayp9/aBzmGT8OugZls8ez1/KG92Z6b8p3ZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWa4xFk/2/VMSDqIdshBa86S2iyp4KRDIgCnUT/5L2s=;
 b=EArKbv95pwkWiVXn+EzlDwjTNJ67HmG1HZGr9Oq0JiP6mNdasGHs4jMuB9Bp+DEgLP1z/dg+v0sjNFTXif71uQ+432iwDhs04vdgz5omcYNIKVX4ZaIBX9zU1K3L7wsFjab7f2wt2S+8CpYEYs9yv5i8Y5eIstEp/hYBHkas/Kg=
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:39:58 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::b) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:39:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:39:56 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:39:52 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 01/34] drm/amd/display: Add support for overriding UTM client
 QC profile
Date: Wed, 5 Aug 2026 14:36:13 +0800
Message-ID: <20260805063937.2145774-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 7178135d-1af5-4cff-93c0-08def2bc5dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|82310400026|1800799024|376014|36860700016|23010399003|22082099003|6133799003|18002099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: D2VwvWrdsFMyqp8pt7+dDmTwHurPNFtqXxVmCxpPByVNW9PWtlJrSv5QETfzz5Z8DxvajfedqSOzHdoDj7a+FM5caSrgoi3xB0CH0t1QwVqI9pZqslY1DNPh/p1PElvhxDopn9+seJPXk22WfXuga3ZD7oq5PrAmTY3/z3r1oKmmrH/RcXLLcyoIXJRKsU+wY2/OR2K9J+71/sStMfyA/cU8xz9DLJRdeix5Y2H9qEWNUQEHQ7O0iWlon5thQHzd5S86hBpsHcwsSjk/7rCK91vvz4R1WEjz4DlTv4q6FblRRJJQSrbCyxKf7j7oO6z4v5v+K2QB+lxr9hkALdv7L4hRoyHcPPYKrTtaPHm8K6ix3u9ul7jZRTljQ+AclotI9WQA6tsC5zmqRE2fMiCRM00kmKKX0vHJJQEw2GMJDWozb62Vy5l50jGxWtS/5012HUH+o2Wwb7VdewPQ7cz9mnBjF3PIXiYggCoHl7N2/vDbAblQmRVeIPyRtDG+UCV1c8xcTm/ZEsczUA+54QMRxP4ELt+wJd61kXcHEcRamC0/CmzN/siv9KC9mlw5JQ4znccOmzJ5WOmo/sq1jsHIEyc05PA6MRerT4VDRb7JFGTlAt47DaHeMAVYEooHDE0PP7zEbOaDykXUMtg4AYj5FfZMgkBZR4Xa70YhcPortaLU+3N+kclnr62t/r5QkzsNv6hsDQKziEtoKxF0xpwvag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QthiTtZZtNZvXOD9TWwrwToujPlX/z3Zp5Sdk+93LwZBarMgSV5g8JzRRd2v3NQw3tdkpJM4jtx7MeWClFZ6b22D8J7zseyOujLZ3/eSkQRBV+rOq5BztlUCKD3flk4uKr6br2UJKhJPqgMT0/FMr9ZP9ZEDunF4qCBu+tPfYhdOWdf4DFx1VGACMMC4iE8nNPtVimrfAVSN2plvmFYSWgKGdF6/EIBmQxdHXY4QA6XwYeFYM2KW6us+pZCT6axMDO37Gj2ehGNuj+8SOiTOUBSAqhMFhGROT0sGaDyQbc9jS2wuk2XGLMc9COAjdCH5DbPAHiF3+RvtV1IBTUlS0Sfj77wL0OUr4HtdzkCO4Zkig6Db50GS6n0jVL48Az/MlTdcK7ryigBYpvC6iAdoG2lNe1SgWLwm3bkS92RWvZFFfMRcwaiYShFNFSDLZJl6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:39:57.2715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7178135d-1af5-4cff-93c0-08def2bc5dc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Support overriding UTM client QC profiles for testing.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  7 ++++++-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    | 21 +++++++++++++++++++
 .../display/dc/hubbub/dcn60/dcn60_hubbub.h    |  6 +++++-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  6 ++++++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  1 +
 .../dc/resource/dcn60/dcn60_resource.h        |  3 ++-
 7 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 705c500ad711..6e45a484a9ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1321,6 +1321,8 @@ struct dc_debug_options {
 	bool disable_dynamic_expansion_for_test_pattern;
 	uint32_t dml21_custom_derate_num_dpms;
 	uint32_t dml21_custom_derate_at_dpm[DML2_MAX_NUM_DPM_LVL];
+	bool override_utm_client_qc_profile;
+	uint8_t utm_client_qc_profiles[4];
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
index accb79c6dde5..5f065b4045ee 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
@@ -215,6 +215,7 @@ struct dcn_hubbub_registers {
 	uint32_t DC_PERFMON5_PERFMON_HI;
 	uint32_t DC_PERFMON5_PERFMON_LOW;
 	uint32_t FMON_CTRL;
+	uint32_t UTM_CLIENT_TO_SYSTEM_PROFILE_MAPPING_0;
 };
 
 #define HUBBUB_REG_FIELD_LIST_DCN32(type) \
@@ -545,7 +546,11 @@ struct dcn_hubbub_registers {
 
 #define HUBBUB_REG_FIELD_LIST_DCN60(type) \
 		type DCHUBBUB_ARB_BUFFER_FULLNESS_WATERMARK_A;\
-		type DCHUBBUB_ARB_BUFFER_FULLNESS_WATERMARK_B
+		type DCHUBBUB_ARB_BUFFER_FULLNESS_WATERMARK_B;\
+		type SYSTEM_PROFILE_QC0;\
+		type SYSTEM_PROFILE_QC1;\
+		type SYSTEM_PROFILE_QC2;\
+		type SYSTEM_PROFILE_QC3
 
 struct dcn_hubbub_shift {
 	DCN_HUBBUB_REG_FIELD_LIST(uint8_t);
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
index 3994e73a2992..e2a457ab13bb 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
@@ -1730,6 +1730,26 @@ static void hubbub60_reset_display_qos_profile(struct hubbub *hubbub)
 	REG_UPDATE(DCHUBBUB_ARB_QOS_FORCE, DCHUBBUB_ARB_UTM_FORCE_URGENT, 0);
 }
 
+static void hubbub60_override_utm_client_qc_profile(struct hubbub *hubbub, uint8_t qc_profile, int index)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	switch (index) {
+	case 0:
+		REG_UPDATE(UTM_CLIENT_TO_SYSTEM_PROFILE_MAPPING_0, SYSTEM_PROFILE_QC0, qc_profile);
+		break;
+	case 1:
+		REG_UPDATE(UTM_CLIENT_TO_SYSTEM_PROFILE_MAPPING_0, SYSTEM_PROFILE_QC1, qc_profile);
+		break;
+	case 2:
+		REG_UPDATE(UTM_CLIENT_TO_SYSTEM_PROFILE_MAPPING_0, SYSTEM_PROFILE_QC2, qc_profile);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+}
+
 static const struct hubbub_funcs hubbub60_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub3_init_dchub_sys_ctx,
@@ -1755,6 +1775,7 @@ static const struct hubbub_funcs hubbub60_funcs = {
 	.program_compbuf_segments = dcn60_program_compbuf_segments,
 	.wait_for_det_update = dcn60_wait_for_det_update,
 	.program_arbiter = dcn401_program_arbiter,
+	.override_utm_client_qc_profile = hubbub60_override_utm_client_qc_profile,
 	.hubbub_read_reg_state = hubbub3_read_reg_state,
 	.perfmon = {
 		.reset = hubbub60_perfmon_reset,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h
index 204f422c3383..03b5182d233c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.h
@@ -193,7 +193,11 @@
 	HUBBUB_SF(DCHUBBUB_ARB_QOS_FORCE, DCHUBBUB_ARB_UTM_FORCE_URGENT, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_QOS_FORCE, DCHUBBUB_ARB_UTM_FORCE_BANDWIDTH_OVERHEAD, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_QOS_FORCE, DCHUBBUB_ARB_UTM_FORCE_ENABLE, mask_sh), \
-	HUBBUB_SF(DCHUBBUB_ARB_QOS_FORCE, DCHUBBUB_ARB_DO_NOT_FORCE_URGENCY_DURING_PSTATE_CHANGE_REQUEST, mask_sh)
+	HUBBUB_SF(DCHUBBUB_ARB_QOS_FORCE, DCHUBBUB_ARB_DO_NOT_FORCE_URGENCY_DURING_PSTATE_CHANGE_REQUEST, mask_sh), \
+	HUBBUB_SF(UTM_CLIENT_TO_SYSTEM_PROFILE_MAPPING_0, SYSTEM_PROFILE_QC0, mask_sh), \
+	HUBBUB_SF(UTM_CLIENT_TO_SYSTEM_PROFILE_MAPPING_0, SYSTEM_PROFILE_QC1, mask_sh), \
+	HUBBUB_SF(UTM_CLIENT_TO_SYSTEM_PROFILE_MAPPING_0, SYSTEM_PROFILE_QC2, mask_sh), \
+	HUBBUB_SF(UTM_CLIENT_TO_SYSTEM_PROFILE_MAPPING_0, SYSTEM_PROFILE_QC3, mask_sh)
 
 void hubbub60_construct(struct dcn20_hubbub *hubbub2,
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index 72c2d3ca52f6..14adf1a3a1e0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -753,6 +753,12 @@ void dcn60_init_hw(struct dc *dc)
 	if (dc->res_pool->hubbub->funcs->set_request_limit && dc->config.sdpif_request_limit_words_per_umc > 0)
 		dc->res_pool->hubbub->funcs->set_request_limit(dc->res_pool->hubbub, dc->ctx->dc_bios->vram_info.num_chans, dc->config.sdpif_request_limit_words_per_umc);
 
+	if (dc->res_pool->hubbub->funcs->override_utm_client_qc_profile && dc->debug.override_utm_client_qc_profile) {
+		dc->res_pool->hubbub->funcs->override_utm_client_qc_profile(dc->res_pool->hubbub, dc->debug.utm_client_qc_profiles[0], 0);
+		dc->res_pool->hubbub->funcs->override_utm_client_qc_profile(dc->res_pool->hubbub, dc->debug.utm_client_qc_profiles[1], 1);
+		dc->res_pool->hubbub->funcs->override_utm_client_qc_profile(dc->res_pool->hubbub, dc->debug.utm_client_qc_profiles[2], 2);
+	}
+
 	// Get DMCUB capabilities
 	if (dc->ctx->dmub_srv) {
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 02bc0010e565..22a0e3dcb25c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -253,6 +253,7 @@ struct hubbub_funcs {
 	void (*wait_for_det_update)(struct hubbub *hubbub, int hubp_inst);
 	bool (*program_arbiter)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower);
 	void (*dchvm_init)(struct hubbub *hubbub);
+	void (*override_utm_client_qc_profile)(struct hubbub *hubbub, uint8_t qc_profile, int index);
 
 	/* Performance monitoring related functions */
 	struct hubbub_perfmon_funcs {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
index c4b6df4838c6..913f049deeb3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.h
@@ -140,7 +140,8 @@ bool dcn50_program_mcache_pipe_config(struct dc_state *context,
 	SR(DC_PERFMON5_PERFMON_HI),                                              \
 	SR(DC_PERFMON5_PERFMON_LOW),                                             \
 	SR(FMON_CTRL),                                                           \
-	SR(DCHUBBUB_ARB_QOS_FORCE)
+	SR(DCHUBBUB_ARB_QOS_FORCE),                                              \
+	SR(UTM_CLIENT_TO_SYSTEM_PROFILE_MAPPING_0)
 
 /* HUBP */
 #define HUBP_REG_LIST_DCN60_RI(id)                                               \
-- 
2.43.0

