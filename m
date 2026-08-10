Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4338EC5CFE7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18DA10ECA9;
	Tue, 11 Aug 2026 15:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3qc5cGms";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EBBD10ECA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfO61YIB7OUvhfc1dErbFzQ+SpvQIj4oUag3zllcrLNlMweJ0iGK3Oh19gKcEif2lhMr0xgzhBfuGomhVMnH1rbKaMgBS0DxgHt25I8EV1VTJFFXOUjEGjlR+Vq1g1z4kpnRktmKZJs9hn29P8r4XSfqeHYO3Vbma1Jie2f4S/7JWzJQF3pfVZMJIFdbY6L2Q8nOA73BY/H1QXe8HVgF3+ykW4E/fv+62e4iP7xwWaPyZQo7cNbN3PLm+E2EMLXSGcvxx83SqrR9cRiqTkQQEq5uNW3GvuPdnzm+OFz6/KhV4BFTq1f1I02ZQLsh5+hqkCbVhUI56yJIt4FgdZ0J8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtFhiszDLGL6SPh51m1cbDCuA61Ho7eVprRU6b/yA70=;
 b=UmQvBugmvEUoJN0G8Jr7PufWVTRo/hIukAmNe85UiofxUL5W/JY1u/bsh0Lm6gs9ViVn5D1x/HGujbp7xfDe+DXnGp+IpBZMJnd5dem2amEH5gGPtmo+0XrCPJcfhXB4fHnmn2gTuckODlb2VLwl6usa4QXxex29JzoClJ9PgMnJYuU3obXMACvcRjPWbjaOu3OtNGys2aGzoK2aFYJyClyj+SVbSMyhZHOErystnvvJ0rx+yE+hopcSKn506StgcZZ6Dv1fVDl892GJLaXcoEJo+sgm/z+t4k27dapEeTznCzzskImwRl7uOLp9Ar0cvFCw9N6Z5Tqn5yS9Ct2TjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtFhiszDLGL6SPh51m1cbDCuA61Ho7eVprRU6b/yA70=;
 b=3qc5cGmsc5xQ1gkP5IA+4dC4ImDiefxIM+5iGYkKTgjf1AXrvTsgqfMWBw+izmjftdpG/DQSOwZfWPUTvT6betR6utYoV/LiCInfD4CmkOr8C9+VLtl6k5aIw21lEiwsnHITtfOmyil67VzQyrOJ2yPRFa+V7DA+0X0FFQfUKDU=
Received: from CH2PR18CA0031.namprd18.prod.outlook.com (2603:10b6:610:55::11)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:50:38 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::60) by CH2PR18CA0031.outlook.office365.com
 (2603:10b6:610:55::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 15:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:50:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:50:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:50:36 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:50:27 -0500
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
Subject: [PATCH 16/24] drm/amd/display: Update Derates And Set Default Per-DPM
 Derates
Date: Tue, 11 Aug 2026 05:28:50 +0800
Message-ID: <20260810213010.1703162-17-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4e4e14-bfe5-494e-6c7c-08def7c04985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|11063799006|56012099006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q27DrwEpJ6jAvCJxHndlmZkQZ+CW81adpJo35U3M3Z+tG/lKQGyOwH+ADMbcQrlWM2nqfRIyGb0M+Ex6Fsr4lBN8zZnz21S4f7TJ3dY7AxnOELyLjlCGErUWU4VL7Axs0Mz2YQm6A0+x48QgA02OeB9keND2qugMufsvu1pm+zOHWfQlX377sJ3FbclN6ACZMJIxdr0LRlaOfP9WVM8iGe8k9gw2yi6+rZMMSRGyfspmT7YeLjjIpMVf7/rDTYTboi5dgtDl4df26rQwRS4SSCzoh7VqLXIa/fhvhUVLCDfevdNwIkIJR4pZg60KkzAHRKWopVe3EMxyWNgPJ51emKdK49kWX5ZMbeX5Pa+9DR/pLUmVmn7Vv9ezuId3XwQJ07eA6JTUMwdE5g5JzDjkZqPdd1UVB2fKYnEuNtsPuJpSOM7YpXaqjN1LD6usGSqYaz5+VgsuHS/Sh9IaKZLj8j64I5Ki+X2Jmr3lGP69p/mJ4MhFlOq7f5yAoy/1EGqKdrKwdbcrHsCP1RISAXYq2lP6g+jeVmXkaXRwlMEoBbeSZ57U7UqX+93R1dF3R1oZnKrCL9fkfD3crPm+VKilYjadgw+Orl72DGS112as45RlQi9s+/t9O1X4uIvuUQGxWhWIggWCHn48BYuBm+EqFkfzv6QzYqyh+LYPXqldO8kVFag5u9Dbh7kF7x1QBQadfhctE0gb7FooBhISIqwVvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tN47aau/64GyDgs1RUPYm0jretikSefoTHfFHIrjttgN8vRhcZhFGi5ojkevWd3niqChniHcfnovdvJzqmjtEw41w67Rqm/8hJs5O88brv2NzOWCrBx7C0f/vi90DwWTIAM4/edc3aK0D38QB5QfjWgZz5Sd0MyjkgcN8XlUZDHt3vhUJP2nqC9uq+IuBos1WD2j5WoPnPxLFdH5TiwckULqpo/2rBASGx1cRBPJreKkAKQvcIZm9Z9be49ZagA++NfqVdXP7Bv0HBREIg1I+rbID6ScC5mQA9YaZ9kqCjrTG+4WPl1Daa4UigQmr/Vu/IHPUwGp5ik057d3+xlrdmFqAYf6q5P0/fAqM2CTg2wsZzSgpLPyORHHoF36Zz8LMsqaKELCH8TXvL0VEYXete10tMKWDWsT7TdUxRlSrA2LG9RW8PBcqYgY4bfSUOWN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:50:37.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4e4e14-bfe5-494e-6c7c-08def7c04985
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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

[Why/How]
Adjusted derates to allow DPM0 to be used on certain display configs.
For DCN42, MALL derates are not relevant so they can be modified to
prevent DPMM from rounding up to the next DPM level.

Also set the default DPM0 derates that can be used.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h   | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
index 52f906e41fb4..04c5f09499ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -11,7 +11,7 @@ static const struct dml2_soc_qos_parameters dml_dcn42_variant_a_soc_qos_params =
 	.derate_table = {
 		.system_active_urgent = {
 			.dram_derate_percent_pixel = 65,
-			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_vm = 50,
 			.dram_derate_percent_pixel_and_vm = 60,
 			.fclk_derate_percent = 80,
 			.dcfclk_derate_percent = 80,
@@ -24,11 +24,11 @@ static const struct dml2_soc_qos_parameters dml_dcn42_variant_a_soc_qos_params =
 			.dcfclk_derate_percent = 80,
 		},
 		.dcn_mall_prefetch_average = {
-			.dram_derate_percent_pixel = 30,
+			.dram_derate_percent_pixel = 33,
 			.dram_derate_percent_vm = 30,
 			.dram_derate_percent_pixel_and_vm = 30,
-			.fclk_derate_percent = 60,
-			.dcfclk_derate_percent = 60,
+			.fclk_derate_percent = 66,
+			.dcfclk_derate_percent = 66,
 		},
 		.system_idle_average = {
 			.dram_derate_percent_pixel = 30,
@@ -39,13 +39,17 @@ static const struct dml2_soc_qos_parameters dml_dcn42_variant_a_soc_qos_params =
 		},
 	},
 	.derate_table_per_dpm = {
+		// DPM0 can have slightly higher derate values. Rest of the DPMs should match the global values.
 		.dram_per_dpm_derate_pixel = {
+			{.derate_percent = 33, .clk_upperbound_threshold_khz = 400000},
 			{.derate_percent = 30, .clk_upperbound_threshold_khz = 0},
 		},
 		.fclk_per_dpm_derate = {
+			{.derate_percent = 66, .clk_upperbound_threshold_khz = 400000},
 			{.derate_percent = 60, .clk_upperbound_threshold_khz = 0},
 		},
 		.dcfclk_per_dpm_derate = {
+			{.derate_percent = 66, .clk_upperbound_threshold_khz = 200000},
 			{.derate_percent = 60, .clk_upperbound_threshold_khz = 0},
 		},
 	},
-- 
2.43.0

