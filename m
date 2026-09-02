Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C538AC61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FB610EFE4;
	Wed,  2 Sep 2026 05:09:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUyMfY+o";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010030.outbound.protection.outlook.com
 [40.93.198.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E7E10EFDC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdBFq/H6rEAsMFdjML5UccelW/hL8bZMMIXqtm7egIwkwISTstqivQ0lE9eF6aR/05gU7rGhuzHBvHwjlo/4VsV/sECiny+PLUXy4d5lvsiUr4deX5h4jguFuYDPd0atAS2EoxWQiaKsqfSByq/aICabGGB3v+0RNwE2tacn9naWBpMebPbzB9SkgloRG+qatAXyKsv6jTp1Gm+sFcewTSu3gRjM6shFUGYU5XLVFGmwdKiq3wkjKhfAsQuG6ZorFPpYkgH5E9a/NQDGYyj5D7prhFPCwJFxsuIGvtWIetCkpMZkJLVMg6LbxHGzfQ0iHQLMOtIUrBeMuYeVkDl+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alGq5VXcz/ndO4cG4cCoZn+OAGeHcqD8K3zR/WGHUp8=;
 b=A/b+a7eZwXawSovpG2lZ5sNF1JP3NcYNLNX2HELiYk2XOcRV0s5FjFGBCXBKgUBATrvIyrN7IuKzQojwhtoDvVSEyWmGF691s2hZ9ImT/rifyzcMoh151lPnAONGbyaVwAaioMrTs4o/om44Azw/x4ke7LwWnEn+mrlL7t4Z8elpME1IvWYun9iuSW4s8JZWN2M6T5FG6QWbtZSI9bFefW4Wu4LT+6Yr2SZWKepTmmh9o5ffA1lZpMZp7PGibt4+YQhhoyGyOxzSGqv2giWLRwuQudYsK1e6zxgt5A/um+J2C2ttTXMAgNH3H71LjonyNvKG+TPrqTWZ2V9zU6o9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alGq5VXcz/ndO4cG4cCoZn+OAGeHcqD8K3zR/WGHUp8=;
 b=DUyMfY+oL2veBPlVawkF0XM1rCLY3cZMv9cNH4/AouAV0wMPLCu+ppNlgCgSPfRRS9nnuqyLXz6Z1IysGCJr+LxOe6YHnrsUKsjdtc8ThmYLHXUGrbZntxn/Q+Po/0KD8nJKAfl8ZlppO9eFXnvCBnyE9ZneadUeNoBDhj0CVCs=
Received: from BN9PR03CA0241.namprd03.prod.outlook.com (2603:10b6:408:ff::6)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:09:11 +0000
Received: from LV8PEPF0000006C.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::8a) by BN9PR03CA0241.outlook.office365.com
 (2603:10b6:408:ff::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000006C.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:09:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:09:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:09:10 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:09:01 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Dillon Varone <dillon.varone@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 32/40] Revert "drm/amd/display: Unify CalculateFlipSchedule
 Logic"
Date: Wed, 2 Sep 2026 12:58:54 +0800
Message-ID: <20260902050411.3473916-33-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006C:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: a86c6e64-f872-46f8-5af6-08df08b05307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|30052699003|36860700016|82310400026|23010399003|11063799006|6133799003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: sCTvph7eqgmgffrUQ1n2lIyTWaoIMdKjmHam8CzxAQyoevPFxssDtMdsw1rNEI/3EVGFnAOrEUgQeGBlWgRfu3Ay5CJyFFswx5g0nK9TiNDDrr58qjIDUrfKA4VM+1FCEkdgaOa56hFXUjQ7N4lLODINZClcC2CkQtE9+aM3QEfufhkQ7C1c9f96BYpLHLSRhhsWcLgXWqI/jO0bc6bqp6n2RMSBxsxjDP+xd2gBk4H60OIEHA4BV48u+Hyd9+J7Oged6yYdr8/E/IaAAr/1NvlsWG5HqwatGo5WBEdsOKfMAmbn41i0aa9RuRWfJFdIl4W/ju4DMPMDThDarcla+n/xBMB9M3gvkAn9PPLkqrnvkayP7ls2FC5ygUzG5vUM9ze6NTObCkcX/sSwa6+6cQBPRem2w8DSnQ3xAMF5A0DpP0l+CwaHVQkYlWmT1yr1CdnYRC3j4bnLtmUAfGypagTfgzelZApGhxJ+mbcHZM/ABynk0EOFfJ/k9tzSSIKkxesP6OSwleibYMmSjdPgXicb7fi2tuqkzBhOUrB8kw1n1TApGSwPYsNDKr4+R+pPV+9mDXrxyCCjRJpI1QDeVnl7z7CGQbT/Q177iJTGlOcNN5tdXrmNEjX2BopIg256SyWsSzsTmq9KQj0q3Twhloz4e5XohDSK6odeCwElpRfLIl2K3mCpjMvz16SguWKw/g1nOZ5hrxGCXN2/ygEjlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(30052699003)(36860700016)(82310400026)(23010399003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NRyAR+KXyRZx14P5bhTbanDH2vFJmZFMRBLTM9J38czMlCc+X0d9f2TjJDXUFDBLtIpBu9KaVV7AhFx9YUEs0/6VZctmg9utXNCAlKPz7bK58K9bDY5Rq55z4JrOGaf3WOOJ/qlf6qu5S2oJY6ZFsOYrErxkYDdTk7HxKHOuhfae5KJuyos43H0M0PXnADSLOD55pVLBxSxHwsfi4zrSLVu1zrDNDAUJ0P2zGS/4jSf4uSahDbO/TfPZHuimNxXIy4W0HOZ+IlIAvQMZeuAnPyNXILUMy/uTizNC+7Giy95DfX4Tarn6aF276JnY0ra6aR9ZX0Xky8iDP8iY4UET0S87GkCUOPqyzgXlIQDDzdFWkjifvo0xWVsfjpUmaNEowoHlEIMNyZzoGOyt1XHb6QwVHNSJmhSlfA8ArD6I6gpCuzempbCW7zd8cZV9AaxL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:09:10.9757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86c6e64-f872-46f8-5af6-08df08b05307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000006C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

Revert commit c3ae66ed0ee3 ("drm/amd/display: Unify CalculateFlipSchedule Logic")

Because it causes some regression

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |   2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 164 +++++++++++-------
 .../src/dml2_core/dml2_core_shared_types.h    |   3 -
 3 files changed, 103 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h
index ed82ef55b651..f26366ebeeda 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h
@@ -342,7 +342,7 @@ static const struct dml2_ip_capabilities dml2_dcn401_max_ip_caps = {
 	.compressed_buffer_segment_size_in_kbytes = 64,
 	.cursor_buffer_size = 24,
 	.max_flip_time_us = 80,
-	.max_flip_time_lines = 34,
+	.max_flip_time_lines = 32,
 	.hostvm_mode = 0,
 	.subvp_drr_scheduling_margin_us = 100,
 	.subvp_prefetch_end_to_mall_start_us = 15,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 4f5c95648834..9c71caee832f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -6551,6 +6551,7 @@ static void CalculateFlipSchedule(
 	bool GPUVMEnable,
 	double vm_bytes, // vm_bytes
 	double DPTEBytesPerRow, // dpte_row_bytes
+	double BandwidthAvailableForImmediateFlip,
 	unsigned int TotImmediateFlipBytes,
 	enum dml2_source_format_class SourcePixelFormat,
 	double LineTime,
@@ -6562,6 +6563,7 @@ static void CalculateFlipSchedule(
 	bool use_one_row_for_frame_flip,
 	unsigned int max_flip_time_us,
 	unsigned int max_flip_time_lines,
+	unsigned int per_pipe_flip_bytes,
 	unsigned int meta_row_bytes,
 	unsigned int meta_row_height,
 	unsigned int meta_row_height_chroma,
@@ -6583,6 +6585,7 @@ static void CalculateFlipSchedule(
 	DML_LOG_VERBOSE("DML::%s: GPUVMEnable = %u\n", __func__, GPUVMEnable);
 	DML_LOG_VERBOSE("DML::%s: ip.max_flip_time_us = %d\n", __func__, max_flip_time_us);
 	DML_LOG_VERBOSE("DML::%s: ip.max_flip_time_lines = %d\n", __func__, max_flip_time_lines);
+	DML_LOG_VERBOSE("DML::%s: BandwidthAvailableForImmediateFlip = %f\n", __func__, BandwidthAvailableForImmediateFlip);
 	DML_LOG_VERBOSE("DML::%s: TotImmediateFlipBytes = %u\n", __func__, TotImmediateFlipBytes);
 	DML_LOG_VERBOSE("DML::%s: use_lb_flip_bw = %u\n", __func__, use_lb_flip_bw);
 	DML_LOG_VERBOSE("DML::%s: iflip_enable = %u\n", __func__, iflip_enable);
@@ -6630,71 +6633,104 @@ static void CalculateFlipSchedule(
 #endif
 		DML_ASSERT(l->min_row_time > 0);
 
-		// For mode check, calculation the flip bw requirement with worst case flip time
-		l->max_flip_time = math_min2(math_min2(l->min_row_time, (double)max_flip_time_lines * LineTime / VRatio),
-			math_max2(Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded, (double)max_flip_time_us));
-
-		//The lower bound on flip bandwidth
-		// Note: The get_urgent_bandwidth_required already consider dpte_row_bw and meta_row_bw in bandwidth calculation, so leave final_flip_bw = 0 if iflip not required
-		l->lb_flip_bw = 0;
-
-		l->vm_and_row_time_budget = l->max_flip_time - Tno_bw_flip;
-		l->vm_time_budget = l->max_flip_time - Tno_bw_flip - 2 * Tr0_trips_flip_rounded;
-		l->row_time_budget = l->max_flip_time - Tvm_trips_flip_rounded;
-
-		if (iflip_enable) {
-			l->hvm_scaled_vm_bytes = vm_bytes * HostVMInefficiencyFactor;
-			l->num_rows = 2;
-			l->hvm_scaled_row_bytes = (l->num_rows * l->dpte_row_bytes * HostVMInefficiencyFactor + l->num_rows * meta_row_bytes);
-			l->hvm_scaled_vm_row_bytes = l->hvm_scaled_vm_bytes + l->hvm_scaled_row_bytes;
-			l->lb_flip_bw = math_max3(
-				l->hvm_scaled_vm_row_bytes / l->vm_and_row_time_budget,
-				l->hvm_scaled_vm_bytes / math_min2(l->vm_time_budget, 31.75 * LineTime - Tno_bw_flip),
-				l->dpte_row_bytes * HostVMInefficiencyFactor / math_min2(l->row_time_budget, 15.75 * LineTime));
-#ifdef __DML_VBA_DEBUG__
-			DML_LOG_VERBOSE("DML::%s: max_flip_time = %f\n", __func__, l->max_flip_time);
-			DML_LOG_VERBOSE("DML::%s: total vm bytes (hvm ineff scaled) = %f\n", __func__, l->hvm_scaled_vm_bytes);
-			DML_LOG_VERBOSE("DML::%s: total row bytes (%f row, hvm ineff scaled) = %f\n", __func__, l->num_rows, l->hvm_scaled_row_bytes);
-			DML_LOG_VERBOSE("DML::%s: total vm+row bytes (hvm ineff scaled) = %f\n", __func__, l->hvm_scaled_vm_row_bytes);
-			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm and row = %f\n", __func__, l->hvm_scaled_vm_row_bytes / l->vm_and_row_time_budget);
-			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm = %f\n", __func__, l->hvm_scaled_vm_bytes / l->vm_time_budget);
-			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for row = %f\n", __func__, l->hvm_scaled_row_bytes / l->row_time_budget);
-			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm reg limit = %f\n", __func__, l->hvm_scaled_vm_bytes / (31.75 * LineTime - Tno_bw_flip));
-			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for row reg limit = %f\n", __func__, (l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / (15.75 * LineTime));
-#endif
-		}
-
-		*final_flip_bw = l->lb_flip_bw;
-
-		if (l->lb_flip_bw > 0) {
-			DML_LOG_VERBOSE("DML::%s: mode_support est Tvm_flip = %f (bw-based)\n", __func__, Tno_bw_flip + l->hvm_scaled_vm_bytes / l->lb_flip_bw);
-			DML_LOG_VERBOSE("DML::%s: mode_support est Tr0_flip = %f (bw-based)\n", __func__, l->hvm_scaled_row_bytes / l->lb_flip_bw / l->num_rows);
-			DML_LOG_VERBOSE("DML::%s: mode_support est dst_y_per_vm_flip = %f (bw-based)\n", __func__, Tno_bw_flip + l->hvm_scaled_vm_bytes / l->lb_flip_bw / LineTime);
-			DML_LOG_VERBOSE("DML::%s: mode_support est dst_y_per_row_flip = %f (bw-based)\n", __func__, l->hvm_scaled_row_bytes / l->lb_flip_bw / LineTime / l->num_rows);
-			DML_LOG_VERBOSE("DML::%s: Tvm_trips_flip_rounded + 2*Tr0_trips_flip_rounded = %f\n", __func__, (Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded));
-
-			l->Tvm_flip = math_max3(Tvm_trips_flip,
-					Tno_bw_flip + vm_bytes * HostVMInefficiencyFactor / l->lb_flip_bw,
-					LineTime / 4.0);
-			l->Tr0_flip = math_max3(Tr0_trips_flip,
-					l->dpte_row_bytes * HostVMInefficiencyFactor / l->lb_flip_bw,
-					LineTime / 4.0);
-
-			*dst_y_per_vm_flip = math_ceil2(4.0 * l->Tvm_flip / LineTime, 1.0) / 4.0;
-			*dst_y_per_row_flip = math_ceil2(4.0 * l->Tr0_flip / LineTime, 1.0) / 4.0;
-
-			if (*dst_y_per_vm_flip >= 32 || *dst_y_per_row_flip >= 16 || l->Tvm_flip + 2 * l->Tr0_flip > l->min_row_time) {
-				*ImmediateFlipSupportedForPipe = false;
+		if (use_lb_flip_bw) {
+			// For mode check, calculation the flip bw requirement with worst case flip time
+			l->max_flip_time = math_min2(math_min2(l->min_row_time, (double)max_flip_time_lines * LineTime / VRatio),
+				math_max2(Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded, (double)max_flip_time_us));
+
+			//The lower bound on flip bandwidth
+			// Note: The get_urgent_bandwidth_required already consider dpte_row_bw and meta_row_bw in bandwidth calculation, so leave final_flip_bw = 0 if iflip not required
+			l->lb_flip_bw = 0;
+
+			if (iflip_enable) {
+				l->hvm_scaled_vm_bytes = vm_bytes * HostVMInefficiencyFactor;
+				l->num_rows = 2;
+				l->hvm_scaled_row_bytes = (l->num_rows * l->dpte_row_bytes * HostVMInefficiencyFactor + l->num_rows * meta_row_bytes);
+				l->hvm_scaled_vm_row_bytes = l->hvm_scaled_vm_bytes + l->hvm_scaled_row_bytes;
+				l->lb_flip_bw = math_max3(
+					l->hvm_scaled_vm_row_bytes / (l->max_flip_time - Tno_bw_flip),
+					l->hvm_scaled_vm_bytes / (l->max_flip_time - Tno_bw_flip - 2 * Tr0_trips_flip_rounded),
+					l->hvm_scaled_row_bytes / (l->max_flip_time - Tvm_trips_flip_rounded));
+#ifdef __DML_VBA_DEBUG__
+				DML_LOG_VERBOSE("DML::%s: max_flip_time = %f\n", __func__, l->max_flip_time);
+				DML_LOG_VERBOSE("DML::%s: total vm bytes (hvm ineff scaled) = %f\n", __func__, l->hvm_scaled_vm_bytes);
+				DML_LOG_VERBOSE("DML::%s: total row bytes (%f row, hvm ineff scaled) = %f\n", __func__, l->num_rows, l->hvm_scaled_row_bytes);
+				DML_LOG_VERBOSE("DML::%s: total vm+row bytes (hvm ineff scaled) = %f\n", __func__, l->hvm_scaled_vm_row_bytes);
+				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm and row = %f\n", __func__, l->hvm_scaled_vm_row_bytes / (l->max_flip_time - Tno_bw_flip));
+				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm = %f\n", __func__, l->hvm_scaled_vm_bytes / (l->max_flip_time - Tno_bw_flip - 2 * Tr0_trips_flip_rounded));
+				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for row = %f\n", __func__, l->hvm_scaled_row_bytes / (l->max_flip_time - Tvm_trips_flip_rounded));
+
+				if (l->lb_flip_bw > 0) {
+					DML_LOG_VERBOSE("DML::%s: mode_support est Tvm_flip = %f (bw-based)\n", __func__, Tno_bw_flip + l->hvm_scaled_vm_bytes / l->lb_flip_bw);
+					DML_LOG_VERBOSE("DML::%s: mode_support est Tr0_flip = %f (bw-based)\n", __func__, l->hvm_scaled_row_bytes / l->lb_flip_bw / l->num_rows);
+					DML_LOG_VERBOSE("DML::%s: mode_support est dst_y_per_vm_flip = %f (bw-based)\n", __func__, Tno_bw_flip + l->hvm_scaled_vm_bytes / l->lb_flip_bw / LineTime);
+					DML_LOG_VERBOSE("DML::%s: mode_support est dst_y_per_row_flip = %f (bw-based)\n", __func__, l->hvm_scaled_row_bytes / l->lb_flip_bw / LineTime / l->num_rows);
+					DML_LOG_VERBOSE("DML::%s: Tvm_trips_flip_rounded + 2*Tr0_trips_flip_rounded = %f\n", __func__, (Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded));
+				}
+#endif
+				l->lb_flip_bw = math_max3(l->lb_flip_bw,
+						l->hvm_scaled_vm_bytes / (31 * LineTime) - Tno_bw_flip,
+						(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / (15 * LineTime));
+
+#ifdef __DML_VBA_DEBUG__
+				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm reg limit = %f\n", __func__, l->hvm_scaled_vm_bytes / (31 * LineTime) - Tno_bw_flip);
+				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for row reg limit = %f\n", __func__, (l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / (15 * LineTime));
+#endif
+			}
+
+			*final_flip_bw = l->lb_flip_bw;
+
+			*dst_y_per_vm_flip = 1; // not used
+			*dst_y_per_row_flip = 1; // not used
+			*ImmediateFlipSupportedForPipe = l->min_row_time >= (Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded);
+		} else {
+			if (iflip_enable) {
+				l->ImmediateFlipBW = (double)per_pipe_flip_bytes * BandwidthAvailableForImmediateFlip / (double)TotImmediateFlipBytes; // flip_bw(i)
+
+#ifdef __DML_VBA_DEBUG__
+				DML_LOG_VERBOSE("DML::%s: per_pipe_flip_bytes = %d\n", __func__, per_pipe_flip_bytes);
+				DML_LOG_VERBOSE("DML::%s: BandwidthAvailableForImmediateFlip = %f\n", __func__, BandwidthAvailableForImmediateFlip);
+				DML_LOG_VERBOSE("DML::%s: ImmediateFlipBW = %f\n", __func__, l->ImmediateFlipBW);
+				DML_LOG_VERBOSE("DML::%s: portion of flip bw = %f\n", __func__, (double)per_pipe_flip_bytes / (double)TotImmediateFlipBytes);
+#endif
+				if (l->ImmediateFlipBW == 0) {
+					l->Tvm_flip = 0;
+					l->Tr0_flip = 0;
+				} else {
+					l->Tvm_flip = math_max3(Tvm_trips_flip,
+						Tno_bw_flip + vm_bytes * HostVMInefficiencyFactor / l->ImmediateFlipBW,
+						LineTime / 4.0);
+
+					l->Tr0_flip = math_max3(Tr0_trips_flip,
+						(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / l->ImmediateFlipBW,
+						LineTime / 4.0);
+				}
+#ifdef __DML_VBA_DEBUG__
+				DML_LOG_VERBOSE("DML::%s: total vm bytes (hvm ineff scaled) = %f\n", __func__, vm_bytes * HostVMInefficiencyFactor);
+				DML_LOG_VERBOSE("DML::%s: total row bytes (hvm ineff scaled, one row) = %f\n", __func__, (l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes));
+
+				DML_LOG_VERBOSE("DML::%s: Tvm_flip = %f (bw-based), Tvm_trips_flip = %f (latency-based)\n", __func__, Tno_bw_flip + vm_bytes * HostVMInefficiencyFactor / l->ImmediateFlipBW, Tvm_trips_flip);
+				DML_LOG_VERBOSE("DML::%s: Tr0_flip = %f (bw-based), Tr0_trips_flip = %f (latency-based)\n", __func__, (l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / l->ImmediateFlipBW, Tr0_trips_flip);
+#endif
+				*dst_y_per_vm_flip = math_ceil2(4.0 * (l->Tvm_flip / LineTime), 1.0) / 4.0;
+				*dst_y_per_row_flip = math_ceil2(4.0 * (l->Tr0_flip / LineTime), 1.0) / 4.0;
+
+				*final_flip_bw = math_max2(vm_bytes * HostVMInefficiencyFactor / (*dst_y_per_vm_flip * LineTime),
+					(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / (*dst_y_per_row_flip * LineTime));
+
+				if (*dst_y_per_vm_flip >= 32 || *dst_y_per_row_flip >= 16 || l->Tvm_flip + 2 * l->Tr0_flip > l->min_row_time) {
+					*ImmediateFlipSupportedForPipe = false;
+				} else {
+					*ImmediateFlipSupportedForPipe = iflip_enable;
+				}
 			} else {
+				l->Tvm_flip = 0;
+				l->Tr0_flip = 0;
+				*dst_y_per_vm_flip = 0;
+				*dst_y_per_row_flip = 0;
+				*final_flip_bw = 0;
 				*ImmediateFlipSupportedForPipe = iflip_enable;
 			}
-		} else {
-			l->Tvm_flip = 0;
-			l->Tr0_flip = 0;
-			*dst_y_per_vm_flip = 0;
-			*dst_y_per_row_flip = 0;
-			*final_flip_bw = 0;
-			*ImmediateFlipSupportedForPipe = iflip_enable;
 		}
 	} else {
 		l->Tvm_flip = 0;
@@ -7851,6 +7887,7 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 				display_cfg->gpuvm_enable,
 				mode_lib->ms.vm_bytes[k],
 				mode_lib->ms.DPTEBytesPerRow[k],
+				mode_lib->ms.BandwidthAvailableForImmediateFlip,
 				mode_lib->ms.TotImmediateFlipBytes,
 				display_cfg->plane_descriptors[k].pixel_format,
 				(display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000)),
@@ -7862,6 +7899,7 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 				mode_lib->ms.use_one_row_for_frame_flip[k],
 				mode_lib->ip.max_flip_time_us,
 				mode_lib->ip.max_flip_time_lines,
+				s->per_pipe_flip_bytes[k],
 				mode_lib->ms.meta_row_bytes[k],
 				s->meta_row_height_luma[k],
 				s->meta_row_height_chroma[k],
@@ -11650,6 +11688,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 					display_cfg->gpuvm_enable,
 					mode_lib->mp.vm_bytes[k],
 					mode_lib->mp.PixelPTEBytesPerRow[k],
+					mode_lib->mp.BandwidthAvailableForImmediateFlip,
 					mode_lib->mp.TotImmediateFlipBytes,
 					display_cfg->plane_descriptors[k].pixel_format,
 					display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000),
@@ -11661,6 +11700,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 					mode_lib->mp.use_one_row_for_frame_flip[k],
 					mode_lib->ip.max_flip_time_us,
 					mode_lib->ip.max_flip_time_lines,
+					s->per_pipe_flip_bytes[k],
 					mode_lib->mp.meta_row_bytes[k],
 					mode_lib->mp.meta_row_height[k],
 					mode_lib->mp.meta_row_height_chroma[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 9eabee1fc001..d4e6464640ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -1659,9 +1659,6 @@ struct dml2_core_shared_CalculateFlipSchedule_locals {
 	double num_rows;
 	double hvm_scaled_row_bytes;
 	double hvm_scaled_vm_row_bytes;
-	double vm_time_budget;
-	double row_time_budget;
-	double vm_and_row_time_budget;
 	bool dual_plane;
 };
 
-- 
2.43.0

