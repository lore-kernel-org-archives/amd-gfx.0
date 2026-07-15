Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB16C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1690D10F060;
	Wed, 15 Jul 2026 13:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DPvqt4Q8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7952210F060
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3qp3A0jxjKQGSRV6se0e9S23vsJnLNR0U/2vPvGUuwIg6onPWkKV3jKQ2U7oZjceaeb8XRgJ1FEJ9G1r+V70lIsrHa49A79MIBH1xHZnqB5BulrADVhkjG/IWNF1yGZzHnKS6jzDGSAqrj+1m1m+Sw/D//yS5L+RkMbX8tC0By5wtqU8ihf9Fc57yEHknj3zkN9KLVhTUM7qtSPQCXwhQW7FLGWUpFUNVXvVgJTP8uzGH7WylJcF7YHAJKLy6wlMn695wu5kfrRg19mcqTg78usmelCpegHUb/wPvmk9l4Qh1yITAd57xQxqtSkf9MvuJlQExl2GcGU/WFgqfrPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eK/mkpSFAGfIHgx+xr0YVLrJ6lz5AV2Czk/JlCGDe1o=;
 b=D+PEnVei0TAA0NYfYmnIC34ITT4T2u01yeQRU0W8dJO/VrLE8jzU52nWSKT2f3wW8g2p1BkjhfJqFXuH0W0ff5F5gMzaEU9uBm7VBm6VvNabNTfe9wWtTU2K/ttkmg1VvD6E4xxQtWvsqbMI40/9LDwzixbJph8UVm0JZkEctkGSmv/LpnJLD++zwxoAFDMD4YJN9Z67vhLl/C1VfOKgx3bltGKry85SmGN0Ddt+1x6iBR6QBnMad3jLxCdrN7soY8Tfrl+DGX7RNNUTakm27JZfnmffwK/eGjz1i4cUtvj9STtrvAxnT7eB8u2lx9rnlOJ6drxhm4zSucjSeNCOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK/mkpSFAGfIHgx+xr0YVLrJ6lz5AV2Czk/JlCGDe1o=;
 b=DPvqt4Q8KNUVMA2ab1dRYYcq6hjzDlYhma+7rxvITEAd7KVlcRerwOXlmY0IL4eXXERUyJGUSFCUgVKhsJ8oM8mPAAx1vRkYWCjrKMRLx/sn4P5a/eM9AtCB5/8jMfM8ccKNtPAbnXokN0y3ZcPue5J/jomuvSP1sJdbv8ww+Fc=
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 13:44:52 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a2) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:44:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:44:50 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:44:42 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 02/70] drm/amd/display: Add Writeback Watermarks and Latency
 Fields
Date: Wed, 15 Jul 2026 21:37:12 +0800
Message-ID: <20260715134432.1975118-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 53471a5a-c8c2-4a53-8b9a-08dee2773ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|30052699003|82310400026|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kn3e5i5vOJjWnSD+V+1+23MMQg/lasyHAxzvcVeSyLMB6W9ASHGfLW+YZF4siV3DHc1OcgSdypjiqSBG+Ad079rllquZ93ktQGocwd43BtfM6oxZ/tUBSEXBmWV5jickrmTN8NnTjgEnZcD+Z7R5lSQpIvBhB/5UXI42HkZ3putEFaOGw+8IyXSjUq94/vfB/g44a5inK7UlhQ6sZzkhNY70u0VkYV2NfSG9/rg2oKroWlqAl5USczFLy1XNPYuuo/f89bXXZPa4jwrBndmUoNY4nZGH9i8SMh9LA3cjdlV65XLEasqpd8I4xWEy0KJUmBgrbD3erokfgC73ykBIHGEqCWhA9SWTfokFCPC5hp9ghJoSaQLtxDVEG4ABzR+X6atyuYbdZ/GsLqa1BHIuHUzjz5adierKs/LJ1RphCJM0MN5l8rFjqjgZYxjafm0mpwuJb/YK6pPv33Uwq6+qHNBNFGSWXiDMIE7l1cjLl5rEbHTYiETZJgIJnUbKZmqKOK9ADpyKf09p6RFkNSgt3psMXH5VnvQ0CP2XXro0I6MQG3QC+HijT9btBL7Fz6LjfdrzwjlC5EUrRSjJCMubSCr/TByRQO8OliUUstJrka2FxM/t8ehC+zXFgYIJdI3/EiEVajL9cOiM6nuEsXb6bYheEezsW7dWPoGju0IDZY8mzKM1WX5vqDLC5cLvbaavJl8dnaVCsMFJHKN3/H1nmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(30052699003)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V452IOcoFcUU5WwhFOszBc3W9iJPS/5ShweJxRE7HJBX4s3qDRz9hwCxfjvBb79CTOMiNwBs/Ai/ZY5I4i9lduQp0RRt8OZiVmRqDNqvlkyBDUHl9eDbjsAt2wM0iB916+FB2WBB08QPABO9qojhGfNCb+9Uk9F+3safuhC72Th/dHdEPt0zJ+GrbNfUVlL6+SDLDFuXynSIgClreZ5BOaBnvhoLcnxTcQbU9YZQ03deaofG6KjCJsD+FWre+m3oS88fcmBZ1Pc05UWFcdjVdUs4wMN6rE0S0k7RpDcUQJsNeqM+TGB2QQtWR4aiVN6GyEuiuZupA0dxEySnuu3zYm3xBXKFF92CUoBrlmSHIKLBxaLTw/DJOrlb3sURYNllKg4gapD5JgFvi5c9aJPZZyg3K7RSjvYO0xhVM0AJ1dOm8hYlPkJbkceyvMps7cdy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:44:51.7632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53471a5a-c8c2-4a53-8b9a-08dee2773ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
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

Add fields that can used for writeback watermarks and latency margin

Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h    | 1 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c       | 3 +++
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h     | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index 8d7960a340c2..cdfb5cd09edb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -457,6 +457,7 @@ struct dml2_display_cfg_programming {
 			double fclk_pstate_change_us;
 			double usr_retraining_us;
 			double temp_read_or_ppt_watermark_us;
+			double writeback_temp_read_or_ppt_watermark_us;
 		} watermarks;
 
 		struct {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 51a66e1be7a1..b667fc9ad75f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -317,6 +317,7 @@ dml_get_var_func(meta_trip_memory_us, double, mode_lib->mp.MetaTripToMemory);
 dml_get_var_func(wm_fclk_change, double, mode_lib->mp.Watermark.FCLKChangeWatermark);
 dml_get_var_func(wm_usr_retraining, double, mode_lib->mp.Watermark.USRRetrainingWatermark);
 dml_get_var_func(wm_temp_read_or_ppt, double, mode_lib->mp.Watermark.temp_read_or_ppt_watermark_us);
+dml_get_var_func(wm_writeback_temp_read_or_ppt, double, mode_lib->mp.Watermark.writeback_temp_read_or_ppt_watermark_us);
 dml_get_var_func(wm_dram_clock_change, double, mode_lib->mp.Watermark.DRAMClockChangeWatermark);
 dml_get_var_func(fraction_of_urgent_bandwidth, double, mode_lib->mp.FractionOfUrgentBandwidth);
 dml_get_var_func(fraction_of_urgent_bandwidth_imm_flip, double, mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip);
@@ -13230,6 +13231,8 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 	out->informative.watermarks.fclk_pstate_change_us = dml_get_wm_fclk_change(mode_lib);
 	out->informative.watermarks.usr_retraining_us = dml_get_wm_usr_retraining(mode_lib);
 	out->informative.watermarks.temp_read_or_ppt_watermark_us = dml_get_wm_temp_read_or_ppt(mode_lib);
+	out->informative.watermarks.writeback_temp_read_or_ppt_watermark_us = dml_get_wm_writeback_temp_read_or_ppt(mode_lib);
+
 
 	out->informative.mall.total_surface_size_in_mall_bytes = 0;
 	out->informative.dpp.total_num_dpps_required = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index e9f970794488..131cec64aa48 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -212,6 +212,7 @@ struct dml2_core_internal_watermarks {
 	double Z8StutterEnterPlusExitWatermark;
 	double USRRetrainingWatermark;
 	double temp_read_or_ppt_watermark_us;
+	double writeback_temp_read_or_ppt_watermark_us;
 };
 
 struct dml2_core_internal_mode_support_info {
@@ -1269,6 +1270,7 @@ struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_local
 	double FullDETBufferingTimeC;
 	double WritebackDRAMClockChangeLatencyMargin;
 	double WritebackFCLKChangeLatencyMargin;
+	double WritebackTempReadOrPptLatencyMargin;
 	double WritebackLatencyHiding;
 
 	unsigned int TotalActiveWriteback;
-- 
2.43.0

