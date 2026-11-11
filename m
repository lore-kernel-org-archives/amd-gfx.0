Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD6606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AifXzX9z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23AB410F8F1;
	Wed, 11 Nov 2026 01:44:36 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012019.outbound.protection.outlook.com
 [40.93.195.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E4210F8F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFOioVCfLpqNgNFXMNTJy7qMFC23xjSA/y9I6CTLmK5FCD5lClUbBSwKQ9T5mBtCkktWyQ0JckBz9hvJvvkgSIAXYScEU7Rr+nj84gHoRPtrqSvNWSxE6fSy4k8Kk+rkueyni69c966m/uNc6Bsn7Cr8xTqjfVqL7jwV4ywW8uiwaevGAw/uGHekEmGg8B6911VX5/fAr11y9wVdYkVsvOqiJXHslLipMEpiFNlCQuZ37D182EniMJ0yK/J8HqZ1P8iT+kBwSsFWbokV/XcUwSqQRjCKKULn7S+t0T9SJMO/vM4BbTXxogF3q/hzmeeVM4fJXrnHsMkJBJ/wJCpEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovD4xgbE8ysv9MFk3JVtFNTOc0ofGsp2rPq8XxXWB18=;
 b=v/wax5/CyrZ7kpA9FnOkXJ5qLc3NjWyKJH8evLCxSyBmHz3Co4wNqgMMcMNphYQOAGrJQLtWpoRTgfwYZ2crp9k4QJxPJykCIctwLrT+CI1TUw9wCq+K3qTNmqibr2e2iFZTv/Y2oP/+DCYxxbm1tIx9SA0voZe/FoDbMeqn3r+/1+X+oz2nXwT4edxKCiD5qMo6d2gd5UscUu/MyGy3+caF9R53lcoSp/MgulBR8+2YwPSLlXq3OZuBUw6UhIMv4VWFhr/zUk4kbBSxMyYRgLuEPoArjVv+miVYqTuqgcaVwLHLjuZpy1/TZa+dSyz3w7XfMW005JVHvOdnRyJRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovD4xgbE8ysv9MFk3JVtFNTOc0ofGsp2rPq8XxXWB18=;
 b=AifXzX9zQR9HI39w8Zen0btxggx3/dC6sAYZuuHGB8AirD3IFrkPqY2OIS18WMBOV7ZViP9Zk5pBao1ZPJABnJZFoXJJ8MvAL43YPoM2wcOlgB3Lk0BN6iLw4ZSUWViZGIYaa/6CaVkD63Qvboj2QYOG9AtRseNQjgP5yVlp/68=
Received: from MW4PR04CA0184.namprd04.prod.outlook.com (2603:10b6:303:86::9)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:44:24 +0000
Received: from EA8PEPF0000000B.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::1e) by MW4PR04CA0184.outlook.office365.com
 (2603:10b6:303:86::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:44:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000B.mail.protection.outlook.com (10.167.249.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:44:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:23 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:22 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:44:19 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 60/74] drm/amd/display: Add effective_number_of_dpp parameter
Date: Wed, 11 Nov 2026 09:29:06 +0800
Message-ID: <20261111014100.3596072-61-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000B:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3044f9-049d-4ccd-bc27-08df3f955038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|30052699003|261009223027099003|3023799007|10067099003|261026121527099003|261026140227099003|261102123227099003|261021123027099003|261021121427099003|261028144727099003|261022105027099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: chdLGiYEuDHVDBhiajuah52FRRc+BMg+O6CHt8drejg7F9fuCfnTMH65J/e8micJkLnLjB0HF38/bypMnx8bMMQskhjKrKzPL2gj0fRmdkOfB6+sG+6+NSZWlQLHW4iAILygXewnJty/gLIHlRBr/KVWimKP8WhSblNVvJSgrerxeet4CnbzeABg43bo+dguDKIiSn+BQXfUx2sIH0ER3AD2LHKy7UP5BPL9k+g5CRVHQlU2+817rVo0YjYjfeEAAMrsMUefKec1c0Tqw5gGRxZMzrMlmjPFfjRtgK+sYEZH8Jr4IrsdoHqZTkoYMIuAIVvM0sTdm2cD837TrlFb7q98xTKY6MjLh/6zWTU+k9oFkKDfAjX+iM+nj9Ll+4mZeL/YCFo2ypTRAH4GjAHOt5lYxx5tSPIYlqnVNk8sIBZOXwSQZyYrGVwMCW1Bg7wJXsSONhDzXoDfPHNn5a15wrrAS2laiuHTkxnh4Wxiz7mOcAYIBbhcLiBgVqPve9lypk2oVB52/IRBIsYUXoCKL7kf9obC2OgCJ/JuQPctDgR98TpRAga6ZMjW2ajL7nboDiq+xnG3vWrkjQjoygkKAj8rWdi65/DyECUz8mx92xAd9CbBFEjGflnqGeCW5S2pupHIQSxFbDRYZZZ0dIDwKEJhKjz4JbuadurGnDIIY9nCaJ/py1KUmiBiyHTH82qBI6EyIqxFbw7fyPNXb9ByiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(30052699003)(261009223027099003)(3023799007)(10067099003)(261026121527099003)(261026140227099003)(261102123227099003)(261021123027099003)(261021121427099003)(261028144727099003)(261022105027099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: in/NsGzUAxjQdzMYtLHVKbqUwJohXEXys/ZVy56INPw27NBOmHuPpGIPAWrDva68OE7xbtU3E3FjvQIG3Alg6sROdw2g68IC92K4qoDNtHrnmvvUJkkazd2zXdBTjVYpXreZLzg5x5/2ULCTQKtY87dyeNLlZyBFpoD9cMBIVDwspK+BaRxayUsT9OMpq7nEvvEOmtWSGKOeCHuaOBAuhHONJFxgvFgQUz/r5fZNqscFPStjbcVKfLNnm+0cxrKvlp1J2qH88PGc3GNLIDZrfzZ0eLlPTXP/WciW23aManJ1TR428vBYxejADiBbmQLqeRBFxfcjac3vkyx0HwiWbL74bl/4GSCe4fiBnrlk9ZfSZLHufjEjJGRFv/K9BBLJl/d/v7qiICLBl3eNsGRfJsiM04qiJsIx9H0DKGrf2yPvj+Ojprdw7GKazQXaKGXL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:44:23.7370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3044f9-049d-4ccd-bc27-08df3f955038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
New parameter to track DPPs effectively in-use per-plane
vs total number of DPPs assigned to a plane

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c  | 5 +++--
 .../src/dml2_core/dml2_core_dcn6_funcs_mode_support.c      | 7 ++++---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h | 2 ++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
index 372691a263d5..0bec9baf809e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
@@ -101,7 +101,7 @@ static void dcn6_mp_calculate_pixel_delivery_times(struct dml2_core_calculate_mp
 	//Display Pipeline Delivery Time in Prefetch, Groups
 	get_calcs(ctx)->calculate_pixel_delivery_times(
 			display_cfg,
-			inputs->NoOfDPP,
+			inputs->effective_number_of_dpp,
 			display_cfg->num_planes,
 			inputs->VRatioPrefetchY,
 			inputs->VRatioPrefetchC,
@@ -403,7 +403,7 @@ static void dcn6_mp_calculate_stutter_efficiency(struct dml2_core_calculate_mp_c
 	p->Z8StutterEnterPlusExitWatermark = inputs->Watermark.Z8StutterEnterPlusExitWatermark;
 	p->ProgressiveToInterlaceUnitInOPP = ip->ptoi_supported;
 	p->MinTTUVBlank = inputs->MinTTUVBlank;
-	p->DPPPerSurface = inputs->NoOfDPP;
+	p->DPPPerSurface = inputs->effective_number_of_dpp;
 	p->DETBufferSizeY = inputs->DETBufferSizeY;
 	p->BytePerPixelY = inputs->BytePerPixelY;
 	p->BytePerPixelDETY = inputs->BytePerPixelInDETY;
@@ -1079,6 +1079,7 @@ void dcn6_mp_initialize_from_solution(struct dml2_core_internal_mode_program *ou
 		outputs->immediate_flip_required = outputs->immediate_flip_required
 				|| plane->immediate_flip;
 		outputs->NoOfDPP[k] = plane_support_info->dpps_used;
+		outputs->effective_number_of_dpp[k] = outputs->NoOfDPP[k];
 		outputs->dsc_enable[k] = stream_support_info->dsc_enable;
 		outputs->num_dsc_slices[k] = stream_support_info->num_dsc_slices;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index c1cb43386473..ef56428d373e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -1018,6 +1018,7 @@ static void dcn6_ms_calculate_num_of_dpp_required(
 				outputs->NoOfDPP[k] = 2;
 			}
 		}
+		outputs->effective_number_of_dpp[k] = outputs->NoOfDPP[k];
 		DML_LOG_VERBOSE("DML::%s: k=%d, NoOfDPP = %d\n", __func__, k,
 			outputs->NoOfDPP[k]);
 	}
@@ -2205,7 +2206,7 @@ void dcn6_ms_calculate_min_dcfclk_deepsleep_clock(
 			inputs->BytePerPixelC,
 			inputs->SwathWidthY,
 			inputs->SwathWidthC,
-			inputs->NoOfDPP,
+			inputs->effective_number_of_dpp,
 			inputs->PSCL_FACTOR,
 			inputs->PSCL_FACTOR_CHROMA,
 			inputs->RequiredDPPCLK,
@@ -2742,7 +2743,7 @@ void dcn6_ms_calculate_urgent_latency(
 			ip->pixel_chunk_size_kbytes,
 			inputs->min_available_urgent_bandwidth_MBps,
 			display_cfg->num_planes,
-			inputs->NoOfDPP,
+			inputs->effective_number_of_dpp,
 			inputs->dpte_group_bytes,
 			inputs->tdlut_bytes_per_group,
 			inputs->HostVMInefficiencyFactor,
@@ -3781,7 +3782,7 @@ void dcn6_ms_calculate_watermarks(
 	//CalculateWatermarks_params->LBBitPerPixel = 57; // FIXME_STAGE2, need a new ip param?
 	p->SwathWidthY = inputs->SwathWidthY;
 	p->SwathWidthC = inputs->SwathWidthC;
-	p->DPPPerSurface = inputs->NoOfDPP;
+	p->DPPPerSurface = inputs->effective_number_of_dpp;
 	p->BytePerPixelDETY = inputs->BytePerPixelInDETY;
 	p->BytePerPixelDETC = inputs->BytePerPixelInDETC;
 	p->DSTXAfterScaler = inputs->DSTXAfterScaler;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 4848dbffc184..dbc59c308762 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -586,6 +586,7 @@ struct dml2_core_internal_mode_support {
 	double surface_avg_vactive_required_bw[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max][DML2_MAX_PLANES];
 	double surface_peak_required_bw[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max][DML2_MAX_PLANES];
 
+	unsigned int effective_number_of_dpp[DML2_MAX_PLANES];
 	// Something that should be feedback to caller
 	enum dml2_odm_mode ODMMode[DML2_MAX_PLANES];
 	unsigned int SurfaceSizeInMALL[DML2_MAX_PLANES];
@@ -779,6 +780,7 @@ struct dml2_core_internal_mode_program {
 	double prefetch_vmrow_bw[DML2_MAX_PLANES];
 	double cursor_bw[DML2_MAX_PLANES];
 	double prefetch_cursor_bw[DML2_MAX_PLANES];
+	unsigned int effective_number_of_dpp[DML2_MAX_PLANES];
 	double WritebackDelay[DML2_MAX_PLANES];
 	unsigned int dpte_row_height[DML2_MAX_PLANES];
 	unsigned int dpte_row_height_linear[DML2_MAX_PLANES];
-- 
2.43.0

