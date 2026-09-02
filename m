Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3195AC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55D010EFE1;
	Wed,  2 Sep 2026 05:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0yjIjntx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FEE10EFE1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:09:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9di8k5aW11TuBLmyQBnmXJOo8ZPxkh6RVh04gEHb3+nn9lFVHcD1LK/DIw4xDltobXzvE5HQ5wzmT6VGJNck7pDDgU7AGXKffQ15OSCML76nzf9gOiQKqP85PVRfQIYTpCM1YwOaUqcsjXcc5HddZVSy5mm5f45/6Pji3GrtIAwa4WJuqb77IkFwyaE3EPjGcW3PnqSfoewnoUnegLjoaQx5pB3w78Z36C3YMqqm7u1gBtodyaqrb6Tv6AvwLbvdFEAskIxAwhBlJ1ldmrEBRwmUOJDd0xUbD97hD3zHT28fYr/szHY4dodXfp1e1fM/dNM3CgkiuWrXjJIZo81Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZRR47tzEc94yFrnyUjQwhGqFFHZfbNM86F5ypDfCKA=;
 b=IyhbxGgVjjFTbnuX4II4PHe6J8/qhEhy636SfZfUwVHqIN913ici1kdo3YoCRg0p90N5pwidCEw1lguWfzmjKvIZU2b/Ny6uU2ArZMrw8PTEOl9hkpydUirRsFWBgEg5ZfdFsgglP5g5zW0Dza71gacI7Zbl+xQZxU6ZKRp70VtdgMb+155kjdobJWDMtRSNQ8gTaoWeLmMUqnxQsmaKnAWQbuc4FQFCIbG08RRVe2ftZViFngP5Vj61POHS/jR6qtXiK1vd+5VKoyRs6v+7gAvENVjfpVZrIp+YcK2fXBY15ea7p8wUvAoqfFGatvw7aMaPOTIGsZVstu4Aytuikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZRR47tzEc94yFrnyUjQwhGqFFHZfbNM86F5ypDfCKA=;
 b=0yjIjntx7Stamsr7uDN2yr/nDRbDFq6KQF/P8UPRwRtLVJJiIBtm6bShrYoyceODFUgjhCU916sjMA//StFoNzJGkH1v82nSimi8xbgNUp0AMHyPGMTa08oeuESFQ6JHnKk72VxGeg9Im5WryUPV20jiJXOB2ygeDkatA5DZHXY=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by EAYPR12MB999131.namprd12.prod.outlook.com (2603:10b6:303:2be::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:09:51 +0000
Received: from LV8PEPF0000006C.namprd03.prod.outlook.com
 (2603:10b6:408:fc:cafe::34) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 05:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000006C.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:09:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:09:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:09:46 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:09:38 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 36/40] drm/amd/display: Update DML fields used for mode support
Date: Wed, 2 Sep 2026 12:58:58 +0800
Message-ID: <20260902050411.3473916-37-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006C:EE_|EAYPR12MB999131:EE_
X-MS-Office365-Filtering-Correlation-Id: 46628d86-00d0-4dc0-e0f9-08df08b06a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|30052699003|11063799006|10067099003|6133799003|5023799004|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: agpe7w7ldBCxmT4Bg4g0xTwSt9bl/x/B9j/BvHJ2HI26oG9amBPIkvsHKgn3v8LQ66J1SlsYwL7UXGX7w/FhEID698FiCIRL7kVJyC0K+ITk/f8z4pTUxuNmsKitZDcwoGL/1SnWZ+McFbVGn2qdTByPCeqQmtvyOazjdBKd4yDQBQdDZJ9lGvSxpUqsM3oBTUNZ8D6cq65/QO6SNhNx1syamEicCAQRcioc9G3jInUlKuneng3TI6gD1CCxgx/823DSpDX8MiHHAMAoPX/rnjxMILioAKpa6uRD4w+JWiDQ+hSxCO5Y3gMWFV0MghV0NOOyHO9JkJBn7J4LMw5/CXE1qjp8BiE/qXruRTYAuzZ128GK6cQbvrTVB83bLMZ4dP7QVKju+qHvHlOUVK9fpok4ho5w9KfGnjHHK1KN40HMwemEHxiAKqValOeUoc56DusNO7qNk3ZcoLB19i7whJVcokqofIWvpKTgkyYhCBD3502rZ95lOKCgSagOWwQxqoeyhqV0TCD/CI9q7qJTb2aC6F8KJ4Buph/ASIEhSQ1ztNrDARYl1xz8EljS65w7KzkTJWioYzG9t2x/CjwEaS679fu19QoX2LXoT77I7pvfj4TtXh+z9lkLM6Tf8AiXzNOy5hRd+kiEw1PsXjP1E1ERkbJK2r8gNLovgC+W/4a+Rl/G5vNXt/pxieAOsWYKnzVKAXHDACXbBu4N0w157w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(30052699003)(11063799006)(10067099003)(6133799003)(5023799004)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kNswaTgGD6XJDY/uFr6GzKKQpiymL2SkauTCcGLNIgsHVwHkvKXGM8+CRKS74hVqagAIQKHXIWu43LxzygDpb/DZfH7T3hFQKunsJ/0VQSMK/+v7LmxIywD0/0gF9HVE82MnBqFGRr/nCRAJoiIWkxWGa5O718yfvdC9+ckHZIxNOllbpe5xkv1/iXdBODMoWx3Y69zDD6LnsQJVleyTqEy6PHWP4ludO4LW3mcciFrZwjH4i+F71z57syGJITcaHOeIrMpVW50kuL1qh/SV8shDGTxjGDXNE1IcmGVZTnO+dVKor9B/MCK+CYvDc25S5LiUz9qNrpATv522N+RJ4UwA9brA2qzj6MzdQtICYIn0ol8FGGWJD2Ro7bxv0kxHwVU+SURuziEba/F4yM8m+cTwf9gsEGLYdVrl3a/MsT7gTxtEn52n9FUe6/W74WAd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:09:50.4979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46628d86-00d0-4dc0-e0f9-08df08b06a95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000006C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999131
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

[Why & How]
Update fields used for mode support.
Also expose some functions so they can be re-used for future products

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml21/inc/dml_top_dchub_registers.h       |   1 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   1 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   4 +
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   3 +-
 .../dml2_core/dml2_core_dcn5_calcs_dchub.h    |  21 ++
 .../dml2_core_dcn6_funcs_mode_programming.c   |  14 +-
 .../dml2_core_dcn6_funcs_mode_programming.h   |  31 ++
 .../dml2_core_dcn6_funcs_mode_support.c       | 158 ++++-----
 .../dml2_core_dcn6_funcs_mode_support.h       | 324 ++++++++++++++++++
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |   1 +
 .../src/inc/dml2_internal_shared_types.h      |   1 +
 12 files changed, 472 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
index 5a5f7b92c324..cfa014ddfbeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_dchub_registers.h
@@ -87,6 +87,7 @@ struct dml2_display_arb_regs {
 	uint32_t hvm_max_qos_commit_threshold;
 	uint32_t hvm_min_req_outstand_commit_threshold;
 	uint32_t compbuf_reserved_space_kbytes;
+	uint32_t compbuf_reserved_space_zs;
 	uint32_t compbuf_size;
 	uint32_t sdpif_request_rate_limit;
 	uint32_t allow_sdpif_rate_limit_when_cstate_req;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index 80d652bab5e3..100d162811f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -172,6 +172,7 @@ struct dml2_soc_bb {
 	double lower_bound_bandwidth_dchub;
 	double fraction_of_urgent_bandwidth_nominal_target;
 	double fraction_of_urgent_bandwidth_flip_target;
+	double hostvm_inefficiency_fraction;
 	unsigned int max_lsdma_bandwidth_kbps;
 	unsigned int dprefclk_mhz;
 	unsigned int xtalclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index 5e056839aaf7..5a8550f592ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -383,7 +383,7 @@ struct dml2_mode_support_info {
 	bool alternate_channel_size_support;
 	bool EnoughUrgentLatencyHidingSupport;
 	bool DSCSlicesODMModeSupported;
-	bool HActiveForDSCSupported;
+	bool ODMSupport;
 }; // dml2_mode_support_info
 
 struct dml2_memory_path_latency {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 9c71caee832f..47d63dd69a90 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -13248,6 +13248,10 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 	out->informative.mode_support_info.InvalidCombinationOfMALLUseForPState = mode_lib->ms.support.InvalidCombinationOfMALLUseForPState;
 	out->informative.mode_support_info.ExceededMALLSize = mode_lib->ms.support.ExceededMALLSize;
 	out->informative.mode_support_info.EnoughWritebackUnits = mode_lib->ms.support.EnoughWritebackUnits;
+	out->informative.mode_support_info.EnoughUrgentLatencyHidingSupport = mode_lib->ms.support.EnoughUrgentLatencyHidingSupport;
+	out->informative.mode_support_info.alternate_channel_size_support = mode_lib->ms.support.alternate_channel_size_support;
+	out->informative.mode_support_info.DSCSlicesODMModeSupported = mode_lib->ms.support.DSCSlicesODMModeSupported;
+	out->informative.mode_support_info.ODMSupport = mode_lib->ms.support.ODMSupport;
 	out->informative.mode_support_info.temp_read_or_ppt_support = mode_lib->ms.support.global_temp_read_or_ppt_supported;
 	out->informative.mode_support_info.g6_temp_read_support = mode_lib->ms.support.g6_temp_read_support;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index f00a45f87101..f407afefb37f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -1813,7 +1813,6 @@ void dcn5_calculate_urgent_burst_factor(
 		double BytePerPixelInDETC,
 		bool UnboundedRequestEnabled,
 		unsigned int CompressedBufferSizeInkByte,
-
 		unsigned int DETBufferSizeY,
 		unsigned int DETBufferSizeC,
 		// Output
@@ -2637,7 +2636,7 @@ double dcn5_calculate_t_wait(
 	return TWait;
 }
 
-static void dcn5_calculate_v_update_and_dynamic_metadata_parameters(
+void dcn5_calculate_v_update_and_dynamic_metadata_parameters(
 		unsigned int MaxInterDCNTileRepeaters,
 		double Dppclk,
 		double Dispclk,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h
index 7b5268e100ed..18a2268a255f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h
@@ -425,4 +425,25 @@ void dcn5_get_per_dwb_params(const struct dml2_display_cfg *display_cfg,
 		int stream_index,
 		int dwb_index);
 
+void dcn5_calculate_v_update_and_dynamic_metadata_parameters(
+		unsigned int MaxInterDCNTileRepeaters,
+		double Dppclk,
+		double Dispclk,
+		double DCFClkDeepSleep,
+		double PixelClock,
+		unsigned int HTotal,
+		unsigned int VBlank,
+		unsigned int DynamicMetadataTransmittedBytes,
+		unsigned int DynamicMetadataLinesBeforeActiveRequired,
+		unsigned int InterlaceEnable,
+		bool ProgressiveToInterlaceUnitInOPP,
+
+		// Output
+		double *TSetup,
+		double *Tdmbf,
+		double *Tdmec,
+		double *Tdmsks,
+		unsigned int *VUpdateOffsetPix,
+		unsigned int *VUpdateWidthPix,
+		unsigned int *VReadyOffsetPix);
 #endif /* __DML2_CORE_DCN5_CALCS_DCHUB_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
index 9382745fc2a2..aeddd113b7a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
@@ -539,7 +539,7 @@ static void dcn6_mp_calculate_dcfclk_deep_sleep_hysteresis(struct dml2_core_calc
 					- min_return_latency_in_DCFCLK_cycles);
 }
 
-static void dcn6_calculate_mode_programming(struct dml2_core_calculate_mp_context *ctx,
+void dcn6_calculate_mode_programming(struct dml2_core_calculate_mp_context *ctx,
 		struct dml2_core_internal_mode_program *states)
 {
 	dcn6_mp_calculate_fraction_of_urgent_bandwidth(ctx, states);
@@ -567,7 +567,7 @@ static void dcn6_calculate_mode_programming(struct dml2_core_calculate_mp_contex
 	DML_LOG_VERBOSE("DML::%s: --- END --- \n", __func__);
 }
 
-static void dcn6_get_global_sync_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, union dml2_global_sync_programming *out, int pipe_index)
+void dcn6_get_global_sync_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, union dml2_global_sync_programming *out, int pipe_index)
 {
 	out->dcn4x.vready_offset_pixels = mode_lib->mp.VReadyOffsetPix[mode_lib->mp.pipe_plane[pipe_index]];
 	out->dcn4x.vstartup_lines = mode_lib->mp.VStartup[mode_lib->mp.pipe_plane[pipe_index]];
@@ -576,7 +576,7 @@ static void dcn6_get_global_sync_programming(const struct dml2_core_internal_dis
 	out->dcn4x.pstate_keepout_start_lines = mode_lib->mp.pstate_keepout_dst_lines[mode_lib->mp.pipe_plane[pipe_index]];
 }
 
-static void dcn6_get_stream_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_per_stream_programming *out, int pipe_index)
+void dcn6_get_stream_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_per_stream_programming *out, int pipe_index)
 {
 	dcn6_get_global_sync_programming(mode_lib, &out->global_sync, pipe_index);
 }
@@ -961,7 +961,7 @@ static void dcn6_populate_qos_bound(struct dml2_display_cfg_programming *program
 	programming->qos_bound.lsdma_bandwidth_lb_kbps = solution->validation_result.mode_support.global.lsdma_bw_req_for_alt_kbps;
 }
 
-static void dcn6_populate_mode_programming(struct dml2_core_calculate_mp_context *ctx,
+void dcn6_populate_mode_programming(struct dml2_core_calculate_mp_context *ctx,
 		struct dml2_display_cfg_programming *programming,
 		struct dml2_core_internal_scratch *s,
 		const struct dml2_core_internal_display_mode_lib *mode_lib,
@@ -1066,7 +1066,7 @@ static void dcn6_populate_mode_programming(struct dml2_core_calculate_mp_context
  * To move mode support result to mode programming, the data needs to be saved in cfg_support_info in the end of
  * mode support, so we can access cfg_support_info and populate mode programming data in this function based on it.
  */
-static void dcn6_mp_initialize_from_solution(struct dml2_core_internal_mode_program *outputs,
+void dcn6_mp_initialize_from_solution(struct dml2_core_internal_mode_program *outputs,
 		const struct dml2_display_solution *solution,
 		const struct dml2_utm_soc_bb *utm_soc_bb)
 {
@@ -1133,7 +1133,7 @@ static void dcn6_mp_initialize_from_solution(struct dml2_core_internal_mode_prog
 			sizeof(solution->uclk_pstate_params.pstate_switch_modes));
 }
 
-static void dcn6_mp_build_calculate_mp_context(struct dml2_core_calculate_mp_context *ctx,
+void dcn6_mp_build_calculate_mp_context(struct dml2_core_calculate_mp_context *ctx,
 		struct dml2_core_instance *core,
 		const struct dml2_display_solution *solution)
 {
@@ -1148,7 +1148,7 @@ static void dcn6_mp_build_calculate_mp_context(struct dml2_core_calculate_mp_con
 	ctx->calcs = &core->calcs;
 }
 
-static void dcn6_mp_initialize_from_ms(struct dml2_core_internal_mode_program *outputs,
+void dcn6_mp_initialize_from_ms(struct dml2_core_internal_mode_program *outputs,
 		const struct dml2_core_internal_mode_support *ms)
 {
 	outputs->DCFCLKDeepSleep = ms->dcfclk_deepsleep;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.h
index f182c27aea7b..542d96c648dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.h
@@ -5,7 +5,38 @@
 #ifndef __DML2_CORE_DCN6_FUNCS_MODE_PROGRAMMING_H__
 #define __DML2_CORE_DCN6_FUNCS_MODE_PROGRAMMING_H__
 #include "dml2_internal_shared_types.h"
+
 enum dml2_status dml2_core_dcn6_funcs_populate_programming(struct dml2_core_instance *core,
 		const struct dml2_display_solution *solution,
 		struct dml2_display_cfg_programming *programming);
+
+void dcn6_mode_programming(struct dml2_core_calculate_mp_context *ctx,
+		struct dml2_core_internal_mode_program *states);
+
+void dcn6_get_global_sync_programming(const struct dml2_core_internal_display_mode_lib *mode_lib,
+		union dml2_global_sync_programming *out, int pipe_index);
+
+void dcn6_get_stream_programming(const struct dml2_core_internal_display_mode_lib *mode_lib,
+		struct dml2_per_stream_programming *out, int pipe_index);
+
+void dcn6_populate_mode_programming(struct dml2_core_calculate_mp_context *ctx,
+		struct dml2_display_cfg_programming *programming,
+		struct dml2_core_internal_scratch *s,
+		const struct dml2_core_internal_display_mode_lib *mode_lib,
+		const struct dml2_display_solution *solution,
+		const struct dml2_utm_soc_bb *utm_soc_bb);
+
+void dcn6_mp_initialize_from_ms(struct dml2_core_internal_mode_program *outputs,
+		const struct dml2_core_internal_mode_support *ms);
+
+void dcn6_mp_initialize_from_solution(struct dml2_core_internal_mode_program *outputs,
+		const struct dml2_display_solution *solution,
+		const struct dml2_utm_soc_bb *utm_soc_bb);
+
+void dcn6_mp_build_calculate_mp_context(struct dml2_core_calculate_mp_context *ctx,
+		struct dml2_core_instance *core,
+		const struct dml2_display_solution *solution);
+
+void dcn6_calculate_mode_programming(struct dml2_core_calculate_mp_context *ctx,
+		struct dml2_core_internal_mode_program *states);
 #endif /* __DML2_CORE_DCN6_FUNCS_MODE_PROGRAMMING_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index abb1c90cfad2..71d14fb8c830 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -11,7 +11,7 @@ static const struct dml2_core_dcn6_calcs *get_calcs(const struct dml2_core_calcu
 	return ctx->calcs->dcn6;
 }
 
-static void dcn6_ms_check_input_sanity(
+void dcn6_ms_check_input_sanity(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -46,7 +46,7 @@ static void dcn6_ms_check_input_sanity(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_desired_output_bpp(
+void dcn6_ms_calculate_desired_output_bpp(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -60,7 +60,7 @@ static void dcn6_ms_calculate_desired_output_bpp(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_max_det_and_min_compressed_buffer_size(
+void dcn6_ms_calculate_max_det_and_min_compressed_buffer_size(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -89,7 +89,7 @@ static void dcn6_ms_calculate_max_det_and_min_compressed_buffer_size(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_effective_pixel_clock(
+void dcn6_ms_calculate_effective_pixel_clock(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -109,7 +109,7 @@ static void dcn6_ms_calculate_effective_pixel_clock(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_scaler_support(
+bool dcn6_ms_check_scaler_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -163,7 +163,7 @@ static bool dcn6_ms_check_scaler_support(
 	return outputs->support.ScaleRatioAndTapsSupport;
 }
 
-static bool dcn6_ms_check_source_format_and_scan_direction(
+bool dcn6_ms_check_source_format_and_scan_direction(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -189,7 +189,7 @@ static bool dcn6_ms_check_source_format_and_scan_direction(
 	return outputs->support.SourceFormatPixelAndScanSupport;
 }
 
-static void dcn6_ms_calculate_byte_per_pixel_and_block_sizes(
+void dcn6_ms_calculate_byte_per_pixel_and_block_sizes(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -240,7 +240,7 @@ static void dcn6_ms_calculate_byte_per_pixel_and_block_sizes(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_read_bandwidth(
+void dcn6_ms_calculate_read_bandwidth(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -292,7 +292,7 @@ static void dcn6_ms_calculate_read_bandwidth(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_writeback_bandwidth(
+void dcn6_ms_calculate_writeback_bandwidth(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -332,7 +332,7 @@ static void dcn6_ms_calculate_writeback_bandwidth(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_writeback_bandwidth_latency_support(
+bool dcn6_ms_check_writeback_bandwidth_latency_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -372,7 +372,7 @@ static bool dcn6_ms_check_writeback_bandwidth_latency_support(
 	return outputs->support.WritebackLatencySupport;
 }
 
-static bool dcn6_ms_check_writeback_scale_ratio_and_taps_support(
+bool dcn6_ms_check_writeback_scale_ratio_and_taps_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -449,7 +449,7 @@ static bool dcn6_ms_check_writeback_scale_ratio_and_taps_support(
 	return outputs->support.WritebackScaleRatioAndTapsSupport;
 }
 
-static void dcn6_ms_calculate_single_pipe_dppclk_and_pscl_factor(
+void dcn6_ms_calculate_single_pipe_dppclk_and_pscl_factor(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -490,7 +490,7 @@ static void dcn6_ms_calculate_single_pipe_dppclk_and_pscl_factor(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_max_swath_widths(
+void dcn6_ms_calculate_max_swath_widths(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -574,7 +574,7 @@ static void dcn6_ms_calculate_max_swath_widths(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_cursor_support(
+bool dcn6_ms_check_cursor_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -603,7 +603,7 @@ static bool dcn6_ms_check_cursor_support(
 	return outputs->support.CursorSupport;
 }
 
-static bool dcn6_ms_check_surface_alginment_requirements(
+bool dcn6_ms_check_surface_alginment_requirements(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -758,7 +758,7 @@ static void dcn6_ms_calculate_swath_and_det_configuration_for_single_dpp(
 
 }
 
-static void dcn6_ms_calculate_estimated_num_of_dsc_slices(
+void dcn6_ms_calculate_estimated_num_of_dsc_slices(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -798,7 +798,7 @@ static void dcn6_ms_calculate_estimated_num_of_dsc_slices(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_output_link(
+void dcn6_ms_calculate_output_link(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -853,7 +853,7 @@ static void dcn6_ms_calculate_output_link(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_odm_mode(
+void dcn6_ms_calculate_odm_mode(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -906,7 +906,7 @@ static void dcn6_ms_calculate_odm_mode(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_num_of_dsc_slices(
+void dcn6_ms_calculate_num_of_dsc_slices(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -939,7 +939,7 @@ static void dcn6_ms_calculate_num_of_dsc_slices(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_num_of_dsc_slices_support(
+bool dcn6_ms_check_num_of_dsc_slices_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1026,7 +1026,7 @@ static void dcn6_ms_calculate_num_of_dpp_required(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_total_available_pipes_support(
+bool dcn6_ms_check_total_available_pipes_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1064,7 +1064,7 @@ static bool dcn6_ms_check_total_available_pipes_support(
 	return outputs->support.TotalAvailablePipesSupport;
 }
 
-static bool dcn6_ms_check_total_available_TDLUT_33cube_support(
+bool dcn6_ms_check_total_available_TDLUT_33cube_support(
 	const struct dml2_core_calculate_ms_context *ctx,
 	struct dml2_core_internal_mode_support *states)
 {
@@ -1087,7 +1087,7 @@ static bool dcn6_ms_check_total_available_TDLUT_33cube_support(
 	return outputs->support.NumberOfTDLUT33cubeSupport;
 }
 
-static void dcn6_ms_calculate_total_num_of_single_dpp_surfaces(
+void dcn6_ms_calculate_total_num_of_single_dpp_surfaces(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1106,7 +1106,7 @@ static void dcn6_ms_calculate_total_num_of_single_dpp_surfaces(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_dispclk_and_dppclk_required(
+void dcn6_ms_calculate_dispclk_and_dppclk_required(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1165,7 +1165,7 @@ static void dcn6_ms_calculate_dispclk_and_dppclk_required(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_dispclk_and_dppclk_support(
+bool dcn6_ms_check_dispclk_and_dppclk_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1183,7 +1183,7 @@ static bool dcn6_ms_check_dispclk_and_dppclk_support(
 	return outputs->support.DISPCLK_DPPCLK_Support;
 }
 
-static bool dcn6_ms_check_otg_count_support(
+bool dcn6_ms_check_otg_count_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1211,7 +1211,7 @@ static bool dcn6_ms_check_otg_count_support(
 	return outputs->support.NumberOfOTGSupport;
 }
 
-static bool dcn6_ms_check_hpo_frl_encoder_count_support(
+bool dcn6_ms_check_hpo_frl_encoder_count_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1240,7 +1240,7 @@ static bool dcn6_ms_check_hpo_frl_encoder_count_support(
 	return outputs->support.NumberOfHDMIFRLSupport;
 }
 
-static bool dcn6_ms_check_hpo_dp_encoder_count_support(
+bool dcn6_ms_check_hpo_dp_encoder_count_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1275,7 +1275,7 @@ static bool dcn6_ms_check_hpo_dp_encoder_count_support(
 	return outputs->support.NumberOfDP2p0Support;
 }
 
-static bool dcn6_ms_check_writeback_count_support(
+bool dcn6_ms_check_writeback_count_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1306,7 +1306,7 @@ static bool dcn6_ms_check_writeback_count_support(
 	return outputs->support.EnoughWritebackUnits;
 }
 
-static bool dcn6_ms_check_link_bandwidth_support(
+bool dcn6_ms_check_link_bandwidth_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1334,7 +1334,7 @@ static bool dcn6_ms_check_link_bandwidth_support(
 	return outputs->support.LinkCapacitySupport;
 }
 
-static void dcn6_ms_check_misc_link_supports(
+void dcn6_ms_check_misc_link_supports(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1390,7 +1390,7 @@ static void dcn6_ms_check_misc_link_supports(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_dtbclk_required(
+void dcn6_ms_calculate_dtbclk_required(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1426,7 +1426,7 @@ static void dcn6_ms_calculate_dtbclk_required(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_dtbclk_support(
+bool dcn6_ms_check_dtbclk_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1450,7 +1450,7 @@ static bool dcn6_ms_check_dtbclk_support(
 	return support;
 }
 
-static void dcn6_ms_calculate_dscclk_required(
+void dcn6_ms_calculate_dscclk_required(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1504,7 +1504,7 @@ static void dcn6_ms_calculate_dscclk_required(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_dscclk_support(
+bool dcn6_ms_check_dscclk_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1529,7 +1529,7 @@ static bool dcn6_ms_check_dscclk_support(
 	return !outputs->support.DSCCLKRequiredMoreThanSupported;
 }
 
-static void dcn6_ms_check_dsc_engine_supports(
+void dcn6_ms_check_dsc_engine_supports(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1587,7 +1587,7 @@ static void dcn6_ms_check_dsc_engine_supports(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_dsc_delay(
+void dcn6_ms_calculate_dsc_delay(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1712,7 +1712,7 @@ static void dcn6_ms_calculate_swath_and_det_configuration(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_total_num_of_dcc_active_dpp(
+void dcn6_ms_calculate_total_num_of_dcc_active_dpp(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1736,7 +1736,7 @@ static void dcn6_ms_calculate_total_num_of_dcc_active_dpp(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_vm_row_and_swath_and_calculate_dcc_meta_cache_requirements(
+void dcn6_ms_calculate_vm_row_and_swath_and_calculate_dcc_meta_cache_requirements(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1921,7 +1921,7 @@ static void dcn6_ms_calculate_vm_row_and_swath_and_calculate_dcc_meta_cache_requ
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_pte_buffer_size_support(
+bool dcn6_ms_check_pte_buffer_size_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -1946,7 +1946,7 @@ static bool dcn6_ms_check_pte_buffer_size_support(
 	return outputs->support.PTEBufferSizeNotExceeded;
 }
 
-static bool dcn6_ms_check_dcc_meta_cache_support(
+bool dcn6_ms_check_dcc_meta_cache_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2001,7 +2001,7 @@ static double dcn6_ms_pstate_type_to_blackout_us(
 	return blackout_us;
 }
 
-static void dcn6_ms_calculate_vactive_pstate_requirements(
+void dcn6_ms_calculate_vactive_pstate_requirements(
 	const struct dml2_core_calculate_ms_context *ctx,
 	struct dml2_core_internal_mode_support *states)
 {
@@ -2086,7 +2086,7 @@ static void dcn6_ms_calculate_vactive_pstate_requirements(
 }
 
 /* FIXME - break it down according the function name */
-static void dcn6_ms_calculate_det_buffer_time_value_urgent_burst_factor_and_urgent_latency_hiding(
+void dcn6_ms_calculate_det_buffer_time_value_urgent_burst_factor_and_urgent_latency_hiding(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2168,7 +2168,7 @@ static void dcn6_ms_calculate_det_buffer_time_value_urgent_burst_factor_and_urge
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_min_dcfclk_deepsleep_clock(
+void dcn6_ms_calculate_min_dcfclk_deepsleep_clock(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2202,7 +2202,7 @@ static void dcn6_ms_calculate_min_dcfclk_deepsleep_clock(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_writeback_delay(
+void dcn6_ms_calculate_writeback_delay(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2240,7 +2240,7 @@ static void dcn6_ms_calculate_writeback_delay(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_alternate_params(const struct dml2_core_calculate_ms_context *ctx,
+void dcn6_ms_calculate_alternate_params(const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
 	struct dml2_core_internal_scratch *func_params = ctx->func_params;
@@ -2342,7 +2342,7 @@ static void dcn6_ms_calculate_alternate_params(const struct dml2_core_calculate_
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_alternate_svp_lines(const struct dml2_core_calculate_ms_context *ctx,
+void dcn6_ms_calculate_alternate_svp_lines(const struct dml2_core_calculate_ms_context *ctx,
 	struct dml2_core_internal_mode_support *states)
 {
 	struct dml2_core_internal_scratch *func_params = ctx->func_params;
@@ -2371,7 +2371,7 @@ static void dcn6_ms_calculate_alternate_svp_lines(const struct dml2_core_calcula
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_max_vstartup(
+void dcn6_ms_calculate_max_vstartup(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2403,7 +2403,7 @@ static void dcn6_ms_calculate_max_vstartup(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_check_average_latency_supports(
+void dcn6_ms_check_average_latency_supports(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2459,7 +2459,7 @@ static void dcn6_ms_check_average_latency_supports(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_mcache_setting(
+void dcn6_ms_calculate_mcache_setting(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2561,7 +2561,7 @@ static void dcn6_ms_calculate_mcache_setting(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_avg_bandwidth_and_dcfclk_lb_required(
+void dcn6_ms_calculate_avg_bandwidth_and_dcfclk_lb_required(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2588,7 +2588,7 @@ static void dcn6_ms_calculate_avg_bandwidth_and_dcfclk_lb_required(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_urgent_latency_hiding_support(
+bool dcn6_ms_check_urgent_latency_hiding_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2613,7 +2613,7 @@ static bool dcn6_ms_check_urgent_latency_hiding_support(
 	return outputs->support.EnoughUrgentLatencyHidingSupport;
 }
 
-static void dcn6_ms_calculate_t_calc(
+void dcn6_ms_calculate_t_calc(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2628,7 +2628,7 @@ static void dcn6_ms_calculate_t_calc(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_hostvm_inefficiency_factor(
+void dcn6_ms_calculate_hostvm_inefficiency_factor(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2655,7 +2655,7 @@ static void dcn6_ms_calculate_hostvm_inefficiency_factor(
 
 // Using approximate ratio for VM bandwidth
 
-static void dcn6_ms_calculate_3dlut_settings(
+void dcn6_ms_calculate_3dlut_settings(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2703,7 +2703,7 @@ static void dcn6_ms_calculate_3dlut_settings(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_urgent_latency(
+void dcn6_ms_calculate_urgent_latency(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2923,7 +2923,7 @@ static void dcn6_ms_calculate_prefetch_schedule(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_prefetch_support(
+bool dcn6_ms_check_prefetch_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2956,7 +2956,7 @@ static bool dcn6_ms_check_prefetch_support(
 	return outputs->support.PrefetchScheduleSupported;
 }
 
-static bool dcn6_ms_check_dynamic_metadata_support(
+bool dcn6_ms_check_dynamic_metadata_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -2979,7 +2979,7 @@ static bool dcn6_ms_check_dynamic_metadata_support(
 	return outputs->support.DynamicMetadataSupported;
 }
 
-static bool dcn6_ms_check_v_ratio_in_prefetch_support(
+bool dcn6_ms_check_v_ratio_in_prefetch_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3006,7 +3006,7 @@ static bool dcn6_ms_check_v_ratio_in_prefetch_support(
 	return outputs->support.VRatioInPrefetchSupported;
 }
 
-static void dcn6_ms_calculate_urgent_burst_factor_for_prefetch(
+void dcn6_ms_calculate_urgent_burst_factor_for_prefetch(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3119,7 +3119,7 @@ static void dcn6_ms_calculate_peak_bandwidth_required(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_final_prefetch_support(
+bool dcn6_ms_check_final_prefetch_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3144,7 +3144,7 @@ static bool dcn6_ms_check_final_prefetch_support(
 	return outputs->support.PrefetchSupported;
 }
 
-static void dcn6_ms_calculate_flip_schedule(
+void dcn6_ms_calculate_flip_schedule(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3201,7 +3201,7 @@ static void dcn6_ms_calculate_flip_schedule(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_immediate_flip_support(const struct dml2_core_calculate_ms_context *ctx,
+bool dcn6_ms_check_immediate_flip_support(const struct dml2_core_calculate_ms_context *ctx,
 	struct dml2_core_internal_mode_support *states)
 {
 	const struct dml2_display_cfg *display_cfg = ctx->display_cfg;
@@ -3224,7 +3224,7 @@ static bool dcn6_ms_check_immediate_flip_support(const struct dml2_core_calculat
 	return outputs->support.ImmediateFlipSupport;
 }
 
-static void dcn6_ms_calculate_bandwidth_upper_bound(const struct dml2_core_calculate_ms_context *ctx,
+void dcn6_ms_calculate_bandwidth_upper_bound(const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
 	struct dml2_core_internal_mode_support *inputs = states;
@@ -3245,7 +3245,7 @@ static void dcn6_ms_calculate_bandwidth_upper_bound(const struct dml2_core_calcu
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_qos_bandwidth_support(
+bool dcn6_ms_check_qos_bandwidth_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3263,7 +3263,7 @@ static bool dcn6_ms_check_qos_bandwidth_support(
 	return outputs->support.qos_bandwidth_support;
 }
 
-static bool dcn6_ms_check_reordering_support(
+bool dcn6_ms_check_reordering_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3291,7 +3291,7 @@ static bool dcn6_ms_check_reordering_support(
 	return outputs->support.ROBSupport;
 }
 
-static void dcn6_ms_calculate_vactive_det_fill_latency(
+void dcn6_ms_calculate_vactive_det_fill_latency(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3325,7 +3325,7 @@ static void dcn6_ms_calculate_vactive_det_fill_latency(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_mode_support(
+bool dcn6_ms_check_mode_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states,
 		enum dml2_status status)
@@ -3442,7 +3442,7 @@ static bool dcn6_ms_check_mode_support(
 	return outputs->support.ModeSupport;
 }
 
-static void dcn6_ms_populate_informative(
+void dcn6_ms_populate_informative(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3478,7 +3478,7 @@ static void dcn6_ms_populate_informative(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_get_plane_support_info(
+void dcn6_ms_get_plane_support_info(
 		const struct dml2_core_calculate_ms_context *ctx,
 		const struct dml2_core_internal_mode_support *states,
 		struct core_plane_support_info *plane_support,
@@ -3511,7 +3511,7 @@ static void dcn6_ms_get_plane_support_info(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_get_stream_support_info(
+void dcn6_ms_get_stream_support_info(
 		const struct dml2_core_calculate_ms_context *ctx,
 		const struct dml2_core_internal_mode_support *states,
 		struct core_stream_support_info *stream_support,
@@ -3525,7 +3525,7 @@ static void dcn6_ms_get_stream_support_info(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_populate_mode_support_result(
+void dcn6_ms_populate_mode_support_result(
 		const struct dml2_core_calculate_ms_context *ctx,
 		const struct dml2_core_internal_mode_support *states,
 		struct dml2_core_mode_support_result *result)
@@ -3639,7 +3639,7 @@ static void dcn6_ms_populate_mode_support_result(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_dcfclk_support(
+bool dcn6_ms_check_dcfclk_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3669,7 +3669,7 @@ static bool dcn6_ms_check_dcfclk_support(
 	return outputs->support.dcfclk_support;
 }
 
-static void dcn6_ms_check_alternate_channel_size_support(
+void dcn6_ms_check_alternate_channel_size_support(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3695,7 +3695,7 @@ static void dcn6_ms_check_alternate_channel_size_support(
 	return;
 }
 
-static void dcn6_ms_calculate_watermarks(
+void dcn6_ms_calculate_watermarks(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3808,7 +3808,7 @@ static void dcn6_ms_calculate_watermarks(
 	DML_LOG_FUNC_EXIT();
 }
 
-static void dcn6_ms_calculate_pstate_schedule_windows(
+void dcn6_ms_calculate_pstate_schedule_windows(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3891,7 +3891,7 @@ static void dcn6_ms_calculate_pstate_schedule_windows(
 	DML_LOG_FUNC_EXIT();
 }
 
-static bool dcn6_ms_check_pstate_schedule_admissibility(
+bool dcn6_ms_check_pstate_schedule_admissibility(
 		const struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_internal_mode_support *states)
 {
@@ -3989,7 +3989,7 @@ static bool dcn6_ms_check_pstate_schedule_admissibility(
 			&& (!inputs->temp_read_pstate_required || outputs->support.temp_read_pstate_schedule_admissible);
 }
 
-static void dcn6_ms_initialize_from_solution(struct dml2_core_internal_mode_support *outputs,
+void dcn6_ms_initialize_from_solution(struct dml2_core_internal_mode_support *outputs,
 		const struct dml2_display_solution *solution,
 		const struct dml2_utm_soc_bb *utm_soc_bb)
 {
@@ -4233,7 +4233,7 @@ static enum dml2_status dcn6_mode_support(
 	return status;
 }
 
-static void dcn6_ms_build_calculate_ms_context(struct dml2_core_calculate_ms_context *ctx,
+void dcn6_ms_build_calculate_ms_context(struct dml2_core_calculate_ms_context *ctx,
 		struct dml2_core_instance *core,
 		const struct dml2_display_solution *solution)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.h
index c035cd099cc6..bfa5f9f583ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.h
@@ -8,4 +8,328 @@
 enum dml2_status dml2_core_dcn6_funcs_validate_solution(struct dml2_core_instance *core,
 		const struct dml2_display_solution *solution,
 		struct dml2_validation_result *result);
+
+void dcn6_ms_initialize_from_solution(struct dml2_core_internal_mode_support *outputs,
+		const struct dml2_display_solution *solution,
+		const struct dml2_utm_soc_bb *utm_soc_bb);
+
+// Exposed for Higher DCN versions
+void dcn6_ms_populate_mode_support_result(
+	const struct dml2_core_calculate_ms_context *ctx,
+	const struct dml2_core_internal_mode_support *states,
+	struct dml2_core_mode_support_result *result);
+
+void dcn6_ms_build_calculate_ms_context(struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_instance *core,
+		const struct dml2_display_solution *solution);
+
+void dcn6_ms_check_input_sanity(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_scaler_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_source_format_and_scan_direction(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_byte_per_pixel_and_block_sizes(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_read_bandwidth(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_writeback_bandwidth(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_writeback_bandwidth_latency_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_writeback_scale_ratio_and_taps_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_single_pipe_dppclk_and_pscl_factor(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_max_swath_widths(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_cursor_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_surface_alginment_requirements(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_effective_pixel_clock(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_estimated_num_of_dsc_slices(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_desired_output_bpp(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_output_link(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_odm_mode(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_num_of_dsc_slices(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_num_of_dsc_slices_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_max_det_and_min_compressed_buffer_size(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_total_available_pipes_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_total_available_TDLUT_33cube_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_total_num_of_single_dpp_surfaces(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_dispclk_and_dppclk_required(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_dispclk_and_dppclk_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_dtbclk_required(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_dtbclk_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_otg_count_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_hpo_frl_encoder_count_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_hpo_dp_encoder_count_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_writeback_count_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_link_bandwidth_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_check_misc_link_supports(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_dscclk_required(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_dscclk_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_check_dsc_engine_supports(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_dsc_delay(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_total_num_of_dcc_active_dpp(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_det_buffer_time_value_urgent_burst_factor_and_urgent_latency_hiding(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_min_dcfclk_deepsleep_clock(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_writeback_delay(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_alternate_svp_lines(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_max_vstartup(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_mcache_setting(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_avg_bandwidth_and_dcfclk_lb_required(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_check_average_latency_supports(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_t_calc(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_hostvm_inefficiency_factor(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_3dlut_settings(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_urgent_latency(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_urgent_latency_hiding_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_dynamic_metadata_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_prefetch_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_v_ratio_in_prefetch_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_urgent_burst_factor_for_prefetch(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_final_prefetch_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_flip_schedule(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_immediate_flip_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_bandwidth_upper_bound(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_qos_bandwidth_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_dcfclk_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_watermarks(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_reordering_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_vactive_det_fill_latency(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_alternate_params(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_check_alternate_channel_size_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_pstate_schedule_windows(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_pstate_schedule_admissibility(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_mode_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states,
+		enum dml2_status status);
+
+void dcn6_ms_populate_informative(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_vm_row_and_swath_and_calculate_dcc_meta_cache_requirements(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_pte_buffer_size_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+bool dcn6_ms_check_dcc_meta_cache_support(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_calculate_vactive_pstate_requirements(
+		const struct dml2_core_calculate_ms_context *ctx,
+		struct dml2_core_internal_mode_support *states);
+
+void dcn6_ms_get_plane_support_info(
+		const struct dml2_core_calculate_ms_context *ctx,
+		const struct dml2_core_internal_mode_support *states,
+		struct core_plane_support_info *plane_support,
+		unsigned int plane_idx);
+
+void dcn6_ms_get_stream_support_info(
+		const struct dml2_core_calculate_ms_context *ctx,
+		const struct dml2_core_internal_mode_support *states,
+		struct core_stream_support_info *stream_support,
+		unsigned int plane_index);
+
 #endif /* __DML2_CORE_DCN6_FUNCS_MODE_SUPPORT_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
index 67722c45c224..c69a0c44eccc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
@@ -332,6 +332,7 @@ static void dcn6_initialize_from_soc_bb(struct dml2_utm_soc_bb *utm_soc_bb,
 	utm_soc_bb->lower_bound_bandwidth_dchub = soc_bb->lower_bound_bandwidth_dchub;
 	utm_soc_bb->fraction_of_urgent_bandwidth_nominal_target = soc_bb->fraction_of_urgent_bandwidth_nominal_target;
 	utm_soc_bb->fraction_of_urgent_bandwidth_flip_target = soc_bb->fraction_of_urgent_bandwidth_flip_target;
+	utm_soc_bb->hostvm_inefficiency_fraction = soc_bb->hostvm_inefficiency_fraction;
 	utm_soc_bb->max_lsdma_bandwidth_kbps = soc_bb->max_lsdma_bandwidth_kbps;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index 8e83e81a5f3e..dc9d4be9d7f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -119,6 +119,7 @@ struct dml2_utm_soc_bb {
 	double lower_bound_bandwidth_dchub;
 	double fraction_of_urgent_bandwidth_nominal_target;
 	double fraction_of_urgent_bandwidth_flip_target;
+	double hostvm_inefficiency_fraction;
 	unsigned int max_lsdma_bandwidth_kbps;
 	unsigned int dchub_refclk_mhz;
 	unsigned int max_outstanding_reqs;
-- 
2.43.0

