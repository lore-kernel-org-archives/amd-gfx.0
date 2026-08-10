Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACB1C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB4810ECA4;
	Tue, 11 Aug 2026 15:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jSlG8bmg";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C831710ECA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btV9qQEU3gIVr9P+xrjM6MlxN+lZmDdh7Y8YebcwJy5IUbIVquT8qCPxH4XZ4CaUmqMINTD63xV+udrUxoN485dKzM6ZcPurdjMhsY8qXi1pJ673lu262tHYWGNQJw6x2MwdIWQkI70u0ieSHOCUXX0K+K2qFmGdCtJL8SUmqZWCmnxaVUk3GmAm/UvuWkcqZ8nrC9cWmqeMUcO4TQtiTfKNl7Pn+XtJmj+pvooamq6R5hii8B6Ll7gjLRdB9Wpahr4CmABcTvE3AZ5e0e0dL9pyPlrDvPKq98Q296THR+NgAXFYAEz956QE7mmO9CrRqd2wNBedCLJx68twVdH02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naGZM+lmvQVPBDblEsq/4X7i8uwvoSBK853n+SZ0BdI=;
 b=RlcTCOXHoHkV9tJzoHVO3mL1ZGFcEsnZdmxyNACkbmIAptEmDC3Ldai0CCeFznT9E4jrmzx8grCfpRIHYZH2K0f8obZMI0zpM5ScScbdqUQvc2b0vBjYPO/KkGhJveNcTLWcoBw3h3wVJqXmhVyUOYIWGeWIw8/YfZbfC2qp6FPM+dWlyPaq8yJHhDYSnL4NQ9uygC1XpSMbmG1xlS6zuYnWe9cfgJkZ3MUua8kBjpturtSOEwStt1/Wg/Di15wdsOcRWaerEald7SCDlrhRuYjmxsUU4unMMiMULFkLOB+KZ7LMXNpHvFiip4CtHZAq0zyTGt0EHiEJrU8zdQZQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naGZM+lmvQVPBDblEsq/4X7i8uwvoSBK853n+SZ0BdI=;
 b=jSlG8bmgecDQkBLR6FjyZvZFmiQmSvg5O5dV93rU7ztfB5Ns48wzJDISIsnUU7NvSqeIh8TaWEwooaDEt8GN5k0KsFeTJCgONTcuWO7NQEdnW0ClDw7CUJ4bPKHi3KpbnkhW1EK6keU3Crm+jZBeTlEacTNEqkVUGDd4egHI0M0=
Received: from CYZPR20CA0001.namprd20.prod.outlook.com (2603:10b6:930:a2::26)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 15:50:59 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:a2:cafe::87) by CYZPR20CA0001.outlook.office365.com
 (2603:10b6:930:a2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 15:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:50:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:50:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:50:45 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:50:36 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 17/24] drm/amd/display: Unify CalculateFlipSchedule Logic
Date: Tue, 11 Aug 2026 05:28:51 +0800
Message-ID: <20260810213010.1703162-18-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d242ddd-773f-4f98-4f2a-08def7c0564d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|30052699003|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O3t4MTgP/iUxN6vtVrBN1N+QTlPWcAwJdJ9mNB9B5bi/LWo5uDeW1gCqyym63wS6uwJ5C7hVrHV0t7BH2Rw5R1eLQT3GWw2ZGjPlF13NrIPdvD60z4a2ru55Vu93E+ZSf804j/6rRq6cNxBklqI3auYidGRPIiBNy9LXqCpWZzR7olXhT07O84nUHP0OQZsg5L5n47oJKNbupCkft9SoUWPcIKduoM+2rhx3kjgwy/Y+DJ3f8weacz/Ern6t7QEZlKilZprs86S7wAftfqkFGOt/EQYILgmT+VPcRG7ofDjLxEUAbM+l90zr4WeNcgyxZ+yaET4Oh9PvQjYhgQiwmD04ZAV5iW8ExT9xSzS21r+iXTZYZpdVwW+DGzcPrQaDaQFS5osGVpq2ayMzOeT7HTMZf1gemAA5DbZWrck7NVxbGj+iFCoEzvnvypi9bjLE6wLZ8eSGp00MgBaZ40tG3EnOCgw8tmRq5eG4x4j4N4STDWMXOm/3+Lm9MSKYt1ggo/5LaBvoOQOFux/jdPkTFeOQqSmsA8azcu78tNlLG8CQxqB6idB572hj3j8Jw573ta05jWkBp3txi6eUiCoeay0k8D03DDfPTP3J6ueYcVo77GabsO/0F2UPA8lMDijpShFRPuHsvBwlUnbln0kFRI5ryrlgBOX51hEvyQlIHDtFucdgWewbSuBwvbJhPcCzvGPMMlu9Rd+zpNHKWJKDLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(30052699003)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5sGl3AKGtE9Jdjnr8TMB+HIOjtG5M06B1MdDVAF5SozPkM/BIlQ7XgrI5Xv7lR3aW+1LuD3bqmjYzUcxKFttGGsjuS/+ShPStYSu+vFzqXXozYd+uM6XabtdE1JQ+WSsCEE3iDyI3Ssdr0w7EMnOZu+KEblMh99HPNIJ2JiFlMRbJ6D7z1VYmQX8j8uKr5Xpg8O+uVlfv6ubBplBVqCQwj4EoZs4elnMtLNVrBmGuUb7dnlj3wQgYFjE6nY5E6rPXNn7jDWgF4B88gL/gHO2HTdP2YAd31XNplPaGUEYg/3BPkX8cgQcan36IdGYC4yJaVErGgjvi+JD06t1OZeJXYCFecYQBhK3D83ll/1EUEXzvAY8PzycecRneXahAfCs39KvbbEtg00eSxhSEzhdlUNyX7+vgEJOZ6mrLgCScQMPPAeWtSOasPGcAXW4Afq4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:50:58.6009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d242ddd-773f-4f98-4f2a-08def7c0564d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799
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
CalculateFlipSchedule has slightly different calculations depending on
if it was called by mode support or mode programming.

Mode support calculates the lower bound of the required bandwidth for
immediate flips.
This takes into the account of the register limits to ensure it is still
programmable.

Mode programming uses the required bandwidth for immediate flips on a
per-plane basis
to calculate the number of dst_y lines needed to achieve this bandwidth.

Usually the immediate flip bandwidth per plane determined by mode
programming is above the lower bound
calculated by mode support.
However, mode programming can fail if that isn't the case since a bandwidth
lower than the lower bound will
end up exceeding the register limit used by hardware.
e.g. The proportion of a single plane's flip bandwidth w.r.t to the total
bandwidth available for all planes
can result in one of the planes having a lower BW than the lower bound
calculated in mode support

[How]
Update function to always use the use_lb_flip_bw path.
Add calculations for dst_y_per_vm/row_flip lines.
Consolidate calculation of lb_flip_bw by having it consider register
limits:
Instead of doing two steps of:
1. Taking the max of the bandwidths without considering register limits.
2. Taking the max of itself with the bandwidths with register limits
accounted for.
Do it in one step as it is easy to miss either step 1 or 2.

Also add some local variables for intermediate values and remove no longer
referenced inputs to improve readability.

Also increase DCN401 max_flip_time_lines by 2 lines to ensure previously
supported configs remain supported as worst-case
bandwidth can increase compared to before.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |   2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 164 +++++++-----------
 .../src/dml2_core/dml2_core_shared_types.h    |   3 +
 3 files changed, 66 insertions(+), 103 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h
index f26366ebeeda..ed82ef55b651 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h
@@ -342,7 +342,7 @@ static const struct dml2_ip_capabilities dml2_dcn401_max_ip_caps = {
 	.compressed_buffer_segment_size_in_kbytes = 64,
 	.cursor_buffer_size = 24,
 	.max_flip_time_us = 80,
-	.max_flip_time_lines = 32,
+	.max_flip_time_lines = 34,
 	.hostvm_mode = 0,
 	.subvp_drr_scheduling_margin_us = 100,
 	.subvp_prefetch_end_to_mall_start_us = 15,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 475bdeb39d21..5a1b710b9ec8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -6555,7 +6555,6 @@ static void CalculateFlipSchedule(
 	bool GPUVMEnable,
 	double vm_bytes, // vm_bytes
 	double DPTEBytesPerRow, // dpte_row_bytes
-	double BandwidthAvailableForImmediateFlip,
 	unsigned int TotImmediateFlipBytes,
 	enum dml2_source_format_class SourcePixelFormat,
 	double LineTime,
@@ -6567,7 +6566,6 @@ static void CalculateFlipSchedule(
 	bool use_one_row_for_frame_flip,
 	unsigned int max_flip_time_us,
 	unsigned int max_flip_time_lines,
-	unsigned int per_pipe_flip_bytes,
 	unsigned int meta_row_bytes,
 	unsigned int meta_row_height,
 	unsigned int meta_row_height_chroma,
@@ -6589,7 +6587,6 @@ static void CalculateFlipSchedule(
 	DML_LOG_VERBOSE("DML::%s: GPUVMEnable = %u\n", __func__, GPUVMEnable);
 	DML_LOG_VERBOSE("DML::%s: ip.max_flip_time_us = %d\n", __func__, max_flip_time_us);
 	DML_LOG_VERBOSE("DML::%s: ip.max_flip_time_lines = %d\n", __func__, max_flip_time_lines);
-	DML_LOG_VERBOSE("DML::%s: BandwidthAvailableForImmediateFlip = %f\n", __func__, BandwidthAvailableForImmediateFlip);
 	DML_LOG_VERBOSE("DML::%s: TotImmediateFlipBytes = %u\n", __func__, TotImmediateFlipBytes);
 	DML_LOG_VERBOSE("DML::%s: use_lb_flip_bw = %u\n", __func__, use_lb_flip_bw);
 	DML_LOG_VERBOSE("DML::%s: iflip_enable = %u\n", __func__, iflip_enable);
@@ -6637,104 +6634,71 @@ static void CalculateFlipSchedule(
 #endif
 		DML_ASSERT(l->min_row_time > 0);
 
-		if (use_lb_flip_bw) {
-			// For mode check, calculation the flip bw requirement with worst case flip time
-			l->max_flip_time = math_min2(math_min2(l->min_row_time, (double)max_flip_time_lines * LineTime / VRatio),
-				math_max2(Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded, (double)max_flip_time_us));
-
-			//The lower bound on flip bandwidth
-			// Note: The get_urgent_bandwidth_required already consider dpte_row_bw and meta_row_bw in bandwidth calculation, so leave final_flip_bw = 0 if iflip not required
-			l->lb_flip_bw = 0;
-
-			if (iflip_enable) {
-				l->hvm_scaled_vm_bytes = vm_bytes * HostVMInefficiencyFactor;
-				l->num_rows = 2;
-				l->hvm_scaled_row_bytes = (l->num_rows * l->dpte_row_bytes * HostVMInefficiencyFactor + l->num_rows * meta_row_bytes);
-				l->hvm_scaled_vm_row_bytes = l->hvm_scaled_vm_bytes + l->hvm_scaled_row_bytes;
-				l->lb_flip_bw = math_max3(
-					l->hvm_scaled_vm_row_bytes / (l->max_flip_time - Tno_bw_flip),
-					l->hvm_scaled_vm_bytes / (l->max_flip_time - Tno_bw_flip - 2 * Tr0_trips_flip_rounded),
-					l->hvm_scaled_row_bytes / (l->max_flip_time - Tvm_trips_flip_rounded));
-#ifdef __DML_VBA_DEBUG__
-				DML_LOG_VERBOSE("DML::%s: max_flip_time = %f\n", __func__, l->max_flip_time);
-				DML_LOG_VERBOSE("DML::%s: total vm bytes (hvm ineff scaled) = %f\n", __func__, l->hvm_scaled_vm_bytes);
-				DML_LOG_VERBOSE("DML::%s: total row bytes (%f row, hvm ineff scaled) = %f\n", __func__, l->num_rows, l->hvm_scaled_row_bytes);
-				DML_LOG_VERBOSE("DML::%s: total vm+row bytes (hvm ineff scaled) = %f\n", __func__, l->hvm_scaled_vm_row_bytes);
-				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm and row = %f\n", __func__, l->hvm_scaled_vm_row_bytes / (l->max_flip_time - Tno_bw_flip));
-				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm = %f\n", __func__, l->hvm_scaled_vm_bytes / (l->max_flip_time - Tno_bw_flip - 2 * Tr0_trips_flip_rounded));
-				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for row = %f\n", __func__, l->hvm_scaled_row_bytes / (l->max_flip_time - Tvm_trips_flip_rounded));
-
-				if (l->lb_flip_bw > 0) {
-					DML_LOG_VERBOSE("DML::%s: mode_support est Tvm_flip = %f (bw-based)\n", __func__, Tno_bw_flip + l->hvm_scaled_vm_bytes / l->lb_flip_bw);
-					DML_LOG_VERBOSE("DML::%s: mode_support est Tr0_flip = %f (bw-based)\n", __func__, l->hvm_scaled_row_bytes / l->lb_flip_bw / l->num_rows);
-					DML_LOG_VERBOSE("DML::%s: mode_support est dst_y_per_vm_flip = %f (bw-based)\n", __func__, Tno_bw_flip + l->hvm_scaled_vm_bytes / l->lb_flip_bw / LineTime);
-					DML_LOG_VERBOSE("DML::%s: mode_support est dst_y_per_row_flip = %f (bw-based)\n", __func__, l->hvm_scaled_row_bytes / l->lb_flip_bw / LineTime / l->num_rows);
-					DML_LOG_VERBOSE("DML::%s: Tvm_trips_flip_rounded + 2*Tr0_trips_flip_rounded = %f\n", __func__, (Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded));
-				}
-#endif
-				l->lb_flip_bw = math_max3(l->lb_flip_bw,
-						l->hvm_scaled_vm_bytes / (31 * LineTime) - Tno_bw_flip,
-						(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / (15 * LineTime));
-
-#ifdef __DML_VBA_DEBUG__
-				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm reg limit = %f\n", __func__, l->hvm_scaled_vm_bytes / (31 * LineTime) - Tno_bw_flip);
-				DML_LOG_VERBOSE("DML::%s: lb_flip_bw for row reg limit = %f\n", __func__, (l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / (15 * LineTime));
-#endif
-			}
-
-			*final_flip_bw = l->lb_flip_bw;
-
-			*dst_y_per_vm_flip = 1; // not used
-			*dst_y_per_row_flip = 1; // not used
-			*ImmediateFlipSupportedForPipe = l->min_row_time >= (Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded);
-		} else {
-			if (iflip_enable) {
-				l->ImmediateFlipBW = (double)per_pipe_flip_bytes * BandwidthAvailableForImmediateFlip / (double)TotImmediateFlipBytes; // flip_bw(i)
-
-#ifdef __DML_VBA_DEBUG__
-				DML_LOG_VERBOSE("DML::%s: per_pipe_flip_bytes = %d\n", __func__, per_pipe_flip_bytes);
-				DML_LOG_VERBOSE("DML::%s: BandwidthAvailableForImmediateFlip = %f\n", __func__, BandwidthAvailableForImmediateFlip);
-				DML_LOG_VERBOSE("DML::%s: ImmediateFlipBW = %f\n", __func__, l->ImmediateFlipBW);
-				DML_LOG_VERBOSE("DML::%s: portion of flip bw = %f\n", __func__, (double)per_pipe_flip_bytes / (double)TotImmediateFlipBytes);
-#endif
-				if (l->ImmediateFlipBW == 0) {
-					l->Tvm_flip = 0;
-					l->Tr0_flip = 0;
-				} else {
-					l->Tvm_flip = math_max3(Tvm_trips_flip,
-						Tno_bw_flip + vm_bytes * HostVMInefficiencyFactor / l->ImmediateFlipBW,
-						LineTime / 4.0);
-
-					l->Tr0_flip = math_max3(Tr0_trips_flip,
-						(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / l->ImmediateFlipBW,
-						LineTime / 4.0);
-				}
-#ifdef __DML_VBA_DEBUG__
-				DML_LOG_VERBOSE("DML::%s: total vm bytes (hvm ineff scaled) = %f\n", __func__, vm_bytes * HostVMInefficiencyFactor);
-				DML_LOG_VERBOSE("DML::%s: total row bytes (hvm ineff scaled, one row) = %f\n", __func__, (l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes));
-
-				DML_LOG_VERBOSE("DML::%s: Tvm_flip = %f (bw-based), Tvm_trips_flip = %f (latency-based)\n", __func__, Tno_bw_flip + vm_bytes * HostVMInefficiencyFactor / l->ImmediateFlipBW, Tvm_trips_flip);
-				DML_LOG_VERBOSE("DML::%s: Tr0_flip = %f (bw-based), Tr0_trips_flip = %f (latency-based)\n", __func__, (l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / l->ImmediateFlipBW, Tr0_trips_flip);
-#endif
-				*dst_y_per_vm_flip = math_ceil2(4.0 * (l->Tvm_flip / LineTime), 1.0) / 4.0;
-				*dst_y_per_row_flip = math_ceil2(4.0 * (l->Tr0_flip / LineTime), 1.0) / 4.0;
-
-				*final_flip_bw = math_max2(vm_bytes * HostVMInefficiencyFactor / (*dst_y_per_vm_flip * LineTime),
-					(l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / (*dst_y_per_row_flip * LineTime));
-
-				if (*dst_y_per_vm_flip >= 32 || *dst_y_per_row_flip >= 16 || l->Tvm_flip + 2 * l->Tr0_flip > l->min_row_time) {
-					*ImmediateFlipSupportedForPipe = false;
-				} else {
-					*ImmediateFlipSupportedForPipe = iflip_enable;
-				}
+		// For mode check, calculation the flip bw requirement with worst case flip time
+		l->max_flip_time = math_min2(math_min2(l->min_row_time, (double)max_flip_time_lines * LineTime / VRatio),
+			math_max2(Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded, (double)max_flip_time_us));
+
+		//The lower bound on flip bandwidth
+		// Note: The get_urgent_bandwidth_required already consider dpte_row_bw and meta_row_bw in bandwidth calculation, so leave final_flip_bw = 0 if iflip not required
+		l->lb_flip_bw = 0;
+
+		l->vm_and_row_time_budget = l->max_flip_time - Tno_bw_flip;
+		l->vm_time_budget = l->max_flip_time - Tno_bw_flip - 2 * Tr0_trips_flip_rounded;
+		l->row_time_budget = l->max_flip_time - Tvm_trips_flip_rounded;
+
+		if (iflip_enable) {
+			l->hvm_scaled_vm_bytes = vm_bytes * HostVMInefficiencyFactor;
+			l->num_rows = 2;
+			l->hvm_scaled_row_bytes = (l->num_rows * l->dpte_row_bytes * HostVMInefficiencyFactor + l->num_rows * meta_row_bytes);
+			l->hvm_scaled_vm_row_bytes = l->hvm_scaled_vm_bytes + l->hvm_scaled_row_bytes;
+			l->lb_flip_bw = math_max3(
+				l->hvm_scaled_vm_row_bytes / l->vm_and_row_time_budget,
+				l->hvm_scaled_vm_bytes / math_min2(l->vm_time_budget, 31.75 * LineTime - Tno_bw_flip),
+				l->dpte_row_bytes * HostVMInefficiencyFactor / math_min2(l->row_time_budget, 15.75 * LineTime));
+#ifdef __DML_VBA_DEBUG__
+			DML_LOG_VERBOSE("DML::%s: max_flip_time = %f\n", __func__, l->max_flip_time);
+			DML_LOG_VERBOSE("DML::%s: total vm bytes (hvm ineff scaled) = %f\n", __func__, l->hvm_scaled_vm_bytes);
+			DML_LOG_VERBOSE("DML::%s: total row bytes (%f row, hvm ineff scaled) = %f\n", __func__, l->num_rows, l->hvm_scaled_row_bytes);
+			DML_LOG_VERBOSE("DML::%s: total vm+row bytes (hvm ineff scaled) = %f\n", __func__, l->hvm_scaled_vm_row_bytes);
+			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm and row = %f\n", __func__, l->hvm_scaled_vm_row_bytes / l->vm_and_row_time_budget);
+			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm = %f\n", __func__, l->hvm_scaled_vm_bytes / l->vm_time_budget);
+			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for row = %f\n", __func__, l->hvm_scaled_row_bytes / l->row_time_budget);
+			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for vm reg limit = %f\n", __func__, l->hvm_scaled_vm_bytes / (31.75 * LineTime - Tno_bw_flip));
+			DML_LOG_VERBOSE("DML::%s: lb_flip_bw for row reg limit = %f\n", __func__, (l->dpte_row_bytes * HostVMInefficiencyFactor + meta_row_bytes) / (15.75 * LineTime));
+#endif
+		}
+
+		*final_flip_bw = l->lb_flip_bw;
+
+		if (l->lb_flip_bw > 0) {
+			DML_LOG_VERBOSE("DML::%s: mode_support est Tvm_flip = %f (bw-based)\n", __func__, Tno_bw_flip + l->hvm_scaled_vm_bytes / l->lb_flip_bw);
+			DML_LOG_VERBOSE("DML::%s: mode_support est Tr0_flip = %f (bw-based)\n", __func__, l->hvm_scaled_row_bytes / l->lb_flip_bw / l->num_rows);
+			DML_LOG_VERBOSE("DML::%s: mode_support est dst_y_per_vm_flip = %f (bw-based)\n", __func__, Tno_bw_flip + l->hvm_scaled_vm_bytes / l->lb_flip_bw / LineTime);
+			DML_LOG_VERBOSE("DML::%s: mode_support est dst_y_per_row_flip = %f (bw-based)\n", __func__, l->hvm_scaled_row_bytes / l->lb_flip_bw / LineTime / l->num_rows);
+			DML_LOG_VERBOSE("DML::%s: Tvm_trips_flip_rounded + 2*Tr0_trips_flip_rounded = %f\n", __func__, (Tvm_trips_flip_rounded + 2 * Tr0_trips_flip_rounded));
+
+			l->Tvm_flip = math_max3(Tvm_trips_flip,
+					Tno_bw_flip + vm_bytes * HostVMInefficiencyFactor / l->lb_flip_bw,
+					LineTime / 4.0);
+			l->Tr0_flip = math_max3(Tr0_trips_flip,
+					l->dpte_row_bytes * HostVMInefficiencyFactor / l->lb_flip_bw,
+					LineTime / 4.0);
+
+			*dst_y_per_vm_flip = math_ceil2(4.0 * l->Tvm_flip / LineTime, 1.0) / 4.0;
+			*dst_y_per_row_flip = math_ceil2(4.0 * l->Tr0_flip / LineTime, 1.0) / 4.0;
+
+			if (*dst_y_per_vm_flip >= 32 || *dst_y_per_row_flip >= 16 || l->Tvm_flip + 2 * l->Tr0_flip > l->min_row_time) {
+				*ImmediateFlipSupportedForPipe = false;
 			} else {
-				l->Tvm_flip = 0;
-				l->Tr0_flip = 0;
-				*dst_y_per_vm_flip = 0;
-				*dst_y_per_row_flip = 0;
-				*final_flip_bw = 0;
 				*ImmediateFlipSupportedForPipe = iflip_enable;
 			}
+		} else {
+			l->Tvm_flip = 0;
+			l->Tr0_flip = 0;
+			*dst_y_per_vm_flip = 0;
+			*dst_y_per_row_flip = 0;
+			*final_flip_bw = 0;
+			*ImmediateFlipSupportedForPipe = iflip_enable;
 		}
 	} else {
 		l->Tvm_flip = 0;
@@ -7891,7 +7855,6 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 				display_cfg->gpuvm_enable,
 				mode_lib->ms.vm_bytes[k],
 				mode_lib->ms.DPTEBytesPerRow[k],
-				mode_lib->ms.BandwidthAvailableForImmediateFlip,
 				mode_lib->ms.TotImmediateFlipBytes,
 				display_cfg->plane_descriptors[k].pixel_format,
 				(display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000)),
@@ -7903,7 +7866,6 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 				mode_lib->ms.use_one_row_for_frame_flip[k],
 				mode_lib->ip.max_flip_time_us,
 				mode_lib->ip.max_flip_time_lines,
-				s->per_pipe_flip_bytes[k],
 				mode_lib->ms.meta_row_bytes[k],
 				s->meta_row_height_luma[k],
 				s->meta_row_height_chroma[k],
@@ -11684,7 +11646,6 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 					display_cfg->gpuvm_enable,
 					mode_lib->mp.vm_bytes[k],
 					mode_lib->mp.PixelPTEBytesPerRow[k],
-					mode_lib->mp.BandwidthAvailableForImmediateFlip,
 					mode_lib->mp.TotImmediateFlipBytes,
 					display_cfg->plane_descriptors[k].pixel_format,
 					display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000),
@@ -11696,7 +11657,6 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 					mode_lib->mp.use_one_row_for_frame_flip[k],
 					mode_lib->ip.max_flip_time_us,
 					mode_lib->ip.max_flip_time_lines,
-					s->per_pipe_flip_bytes[k],
 					mode_lib->mp.meta_row_bytes[k],
 					mode_lib->mp.meta_row_height[k],
 					mode_lib->mp.meta_row_height_chroma[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 0f1f58471cff..55118fd484ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -1658,6 +1658,9 @@ struct dml2_core_shared_CalculateFlipSchedule_locals {
 	double num_rows;
 	double hvm_scaled_row_bytes;
 	double hvm_scaled_vm_row_bytes;
+	double vm_time_budget;
+	double row_time_budget;
+	double vm_and_row_time_budget;
 	bool dual_plane;
 };
 
-- 
2.43.0

