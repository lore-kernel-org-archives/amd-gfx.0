Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C94FC5CFCF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A4F10ECA6;
	Tue, 11 Aug 2026 15:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mO9UZGMK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E96A10ECA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4pkxY7yyrWiQkCnT0Rs9wwNnses13NA9eAXC9nngvuuyu76Yeb3LEB4A78ZvnH0GwkiinQxUAPcsUKInOQutJUG5/CUILTwjbpwO1T41ZqG0FW051BTfYdVE/6nKWva5CqnneGb4TQ3ioUnDpG+q9mPIlVbqud4M9KCe+SKJQYFj2aEQ6CrT4O55JrFuECiL7oK+VTE6+UlzJ4ORsXhx/vCgSqZjc30T255mh94pKkAujBTz/RJZu8/a7+eRDUzK+Ar9zXgEYuvmPoGDr+3dHKx67wJEEZx/k6O2/VqxYk/b4jGsCs5bJluHFUsIG+RZQThT9X7ovo3/lhBYAUusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSev7Z2evDAPpxqYwUVV9PU7cOgjCdXeSiterNCaklQ=;
 b=PMIWrHTLaToUOjatweCE8jKAyMWzebWAjNSVAgGW0rTc+58/dbNdYNFUYQV5AAZJqHMvaProMNcazhQqsOHO07rkuknfeaBQrZf0ABacHh0BolBa5DvF/PzOvHHH2YGb/BDSBjzQ3habxvNfzvpKwAcQG/Nb/PuB30PQH6m1wwzirtor+unpFlI07m670SZPQnbWD6kV4SMg3InXis62Ftw2YPef52Lfo2UZRXXTBpQIfGj0yPVXHYmdPZQfzq1/I4oMojqoUAzqWLLWQYsRcaxktCGC7K6MiCg44isNYYRohdCEx7fbt7X3jaDaTA8Y1wTIPtHpOt3LZi4p38bYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSev7Z2evDAPpxqYwUVV9PU7cOgjCdXeSiterNCaklQ=;
 b=mO9UZGMKA2e8KWofMG8rQ62BDxRkTFaIwgsz81RtWxTPL5dF2xJXzfQJr3aPZYzbCWgch0bKTtsGzkmB+hZjHk8XOwAOXT8lfBJjBxKH2L4B/VGU1FoeDLFt3Wno9C7esvp4ylaI2KixRsNLZMrMyw/vB6HgcmGcu9/5lHDocE4=
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 15:50:28 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::8e) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 15:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:50:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:50:27 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:50:18 -0500
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
Subject: [PATCH 15/24] drm/amd/display: Refactor Per-DPM Derate Logic
Date: Tue, 11 Aug 2026 05:28:49 +0800
Message-ID: <20260810213010.1703162-16-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4a6274-eecf-4e76-89e4-08def7c04412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|30052699003|82310400026|1800799024|376014|36860700016|10067099003|11063799006|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mTyIqI1mfl2nzCXXAqkc15FRhsABWuCCymb3eGc1BXvjbjEZciUH2mMdMVa30PF11iAWWpVou/fkjwAf9sx50T7YydGImdMmxpzHL/MJzprl2P3rgNqt+ATZ4jmLAxPPSKxV5H4okDA+xrwHLuqL9Q0owhuaRl8NiQ+54+TS6KNDFcGwSM5a68fWyBw2K4xBKy3Vu2jQyaucgzo7KvGyP8eZc/qvG31kMjFIUEXoeuI7fCI63+/fZWfnQo//gFPJ+IoDzrt1yR0AXB5qpB4EA0oKa2eT+Helmt2M0VYe/DnogFlv5aP9JP9jcN6Rt0mvtatmOwulBtYoy+aUb4RmO8wSJlrUczKFzSfHqNpgaaMWBRo+cjocmSZBLBM3BS/ANsusnoKM8Cw0K0cPeYGN8NC+wNz5hZf+EXP0qunmIiSt9jYSgDnRLucvbY5XjM+IzL0VpvgHXUoRrePDEWDJ1api/+81rD1ejwyI/6n3kOtL/QMh20vggXSmwXT7juGjgLGgl5clzFNLpVtWhrf10Ge5+kKzccmdPXTqZam2iAjAErFZYSGY7yI04tdd88fCF1TPnTAHVei5jOQ7rwoznSO1P8865NQVXhHK68Za6cvuwoahEppdeHr1wIYEaysrorqkWBOCmALwcM+oFgv1Hx6Me2rIAMmD1GcmMLdpULZtbfmgq8WciChra06drYrX82NL3MgLzSuqO3TArBhnAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(30052699003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wcQ8KFU26kf5fd8Jvoz9IX5MYhMD/ecZhSaEt/zUN4Xuu7lhTBaDjZpnqbrarZ1P1Ss+a5Mq2XOGmmf5LbWQ66k+lyck/YdzcyWBs/7WVo02B2yEtgYxnw7yEDLEj0QVLeIDsLRcGcVAitYrbe5RXoXmsxnmBt8g7eMT4pg+f94taVEgnweMkCTY+dKtHShzkKxT4BaeyydMnCkeFJxAS6HBdCL8RLBBErhe51fmpocIgeP/NZtT6kTPXuqMa3j9fnjx+vCA5KHNnorbTItcIyVSxcrSSx2nOFreVIoosVIbbTx3dzY42QSZ5Pxn7xJNwcJlIyuk2/YCy34gLGBmvgk8uuoRlS25h9kGeAMrH2BMgz0p0o4qxRcOYThtRqevCrDSCVB6XTqvnr5D0/UwSptIUhzuj0rvrAgAAXtNftrmO1kDxOXLquujgBP+R/Nw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:50:28.0727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4a6274-eecf-4e76-89e4-08def7c04412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
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
1. DPMM also needs to consider the per-DPM derate when calculating the
clocks
that will be used by mode programming.
Otherwise DPMM calculations can result in rounding up to the next DPM
anyways.

clk index value used by mode support is not reliable when trying to
determine the actual
per-dpm derate.

2. Also update how per-dpm derates are stored so each derate applies until
an upper bound.
Upperbound of 0 signifies this derate is used for the remaining DPMs.

To simplify logic, all derates for all clocks should have the same number
of entries
and the last entry should have an upperbound of 0.

3. Deprecate system_active_average derates from the derate table and move
them to the per-DPM structure
The remaining derates (urgent, dcn_mall, system idle) are unchanged

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |  25 ++---
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |  25 ++---
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |  25 ++---
 .../dml21/inc/dml_top_soc_parameter_types.h   |  44 +++++++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  19 ++--
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      | 106 +++++++++++++++++-
 .../src/inc/dml2_internal_shared_types.h      |   1 +
 7 files changed, 181 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
index b21beebc52bd..52f906e41fb4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -16,13 +16,6 @@ static const struct dml2_soc_qos_parameters dml_dcn42_variant_a_soc_qos_params =
 			.fclk_derate_percent = 80,
 			.dcfclk_derate_percent = 80,
 		},
-		.system_active_average = {
-			.dram_derate_percent_pixel = 30,
-			.dram_derate_percent_vm = 30,
-			.dram_derate_percent_pixel_and_vm = 30,
-			.fclk_derate_percent = 60,
-			.dcfclk_derate_percent = 60,
-		},
 		.dcn_mall_prefetch_urgent = {
 			.dram_derate_percent_pixel = 65,
 			.dram_derate_percent_vm = 30,
@@ -45,6 +38,17 @@ static const struct dml2_soc_qos_parameters dml_dcn42_variant_a_soc_qos_params =
 			.dcfclk_derate_percent = 60,
 		},
 	},
+	.derate_table_per_dpm = {
+		.dram_per_dpm_derate_pixel = {
+			{.derate_percent = 30, .clk_upperbound_threshold_khz = 0},
+		},
+		.fclk_per_dpm_derate = {
+			{.derate_percent = 60, .clk_upperbound_threshold_khz = 0},
+		},
+		.dcfclk_per_dpm_derate = {
+			{.derate_percent = 60, .clk_upperbound_threshold_khz = 0},
+		},
+	},
 	.writeback = {
 		.base_latency_us = 12,
 		.scaling_factor_us = 0,
@@ -134,13 +138,6 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 				.fclk_derate_percent = 80,
 				.dcfclk_derate_percent = 80,
 			},
-			.system_active_average = {
-				.dram_derate_percent_pixel = 30,
-				.dram_derate_percent_vm = 30,
-				.dram_derate_percent_pixel_and_vm = 30,
-				.fclk_derate_percent = 60,
-				.dcfclk_derate_percent = 60,
-			},
 			.dcn_mall_prefetch_urgent = {
 				.dram_derate_percent_pixel = 65,
 				.dram_derate_percent_vm = 30,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
index 5d844ff4b671..33eb583e3365 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
@@ -17,13 +17,6 @@ static const struct dml2_soc_qos_parameters dml_dcn42b_variant_a_soc_qos_params
 			.fclk_derate_percent = 80,
 			.dcfclk_derate_percent = 80,
 		},
-		.system_active_average = {
-			.dram_derate_percent_pixel = 30,
-			.dram_derate_percent_vm = 30,
-			.dram_derate_percent_pixel_and_vm = 30,
-			.fclk_derate_percent = 60,
-			.dcfclk_derate_percent = 60,
-		},
 		.dcn_mall_prefetch_urgent = {
 			.dram_derate_percent_pixel = 65,
 			.dram_derate_percent_vm = 30,
@@ -46,6 +39,17 @@ static const struct dml2_soc_qos_parameters dml_dcn42b_variant_a_soc_qos_params
 			.dcfclk_derate_percent = 60,
 		},
 	},
+	.derate_table_per_dpm = {
+		.dram_per_dpm_derate_pixel = {
+			{.derate_percent = 30, .clk_upperbound_threshold_khz = 0},
+		},
+		.fclk_per_dpm_derate = {
+			{.derate_percent = 60, .clk_upperbound_threshold_khz = 0},
+		},
+		.dcfclk_per_dpm_derate = {
+			{.derate_percent = 60, .clk_upperbound_threshold_khz = 0},
+		},
+	},
 	.writeback = {
 		.base_latency_us = 12,
 		.scaling_factor_us = 0,
@@ -134,13 +138,6 @@ static const struct dml2_soc_bb dml2_socbb_dcn42b = {
 				.fclk_derate_percent = 80,
 				.dcfclk_derate_percent = 80,
 			},
-			.system_active_average = {
-				.dram_derate_percent_pixel = 30,
-				.dram_derate_percent_vm = 30,
-				.dram_derate_percent_pixel_and_vm = 30,
-				.fclk_derate_percent = 60,
-				.dcfclk_derate_percent = 60,
-			},
 			.dcn_mall_prefetch_urgent = {
 				.dram_derate_percent_pixel = 65,
 				.dram_derate_percent_vm = 30,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h
index 16a4f97bca4e..f26366ebeeda 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn4_soc_bb.h
@@ -16,13 +16,6 @@ static const struct dml2_soc_qos_parameters dml_dcn4_variant_a_soc_qos_params =
 			.fclk_derate_percent = 76,
 			.dcfclk_derate_percent = 100,
 		},
-		.system_active_average = {
-			.dram_derate_percent_pixel = 17,
-			.dram_derate_percent_vm = 0,
-			.dram_derate_percent_pixel_and_vm = 0,
-			.fclk_derate_percent = 57,
-			.dcfclk_derate_percent = 75,
-		},
 		.dcn_mall_prefetch_urgent = {
 			.dram_derate_percent_pixel = 40,
 			.dram_derate_percent_vm = 0,
@@ -45,6 +38,17 @@ static const struct dml2_soc_qos_parameters dml_dcn4_variant_a_soc_qos_params =
 			.dcfclk_derate_percent = 100,
 		},
 	},
+	.derate_table_per_dpm = {
+		.dram_per_dpm_derate_pixel = {
+			{.derate_percent = 17, .clk_upperbound_threshold_khz = 0},
+		},
+		.fclk_per_dpm_derate = {
+			{.derate_percent = 57, .clk_upperbound_threshold_khz = 0},
+		},
+		.dcfclk_per_dpm_derate = {
+			{.derate_percent = 75, .clk_upperbound_threshold_khz = 0},
+		},
+	},
 	.writeback = {
 		.base_latency_us = 12,
 		.scaling_factor_us = 0,
@@ -142,13 +146,6 @@ static const struct dml2_soc_bb dml2_socbb_dcn401 = {
 				.fclk_derate_percent = 76,
 				.dcfclk_derate_percent = 100,
 			},
-			.system_active_average = {
-				.dram_derate_percent_pixel = 15,
-				.dram_derate_percent_vm = 0,
-				.dram_derate_percent_pixel_and_vm = 0,
-				.fclk_derate_percent = 57,
-				.dcfclk_derate_percent = 75,
-			},
 			.dcn_mall_prefetch_urgent = {
 				.dram_derate_percent_pixel = 40,
 				.dram_derate_percent_vm = 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
index b830e95b27c8..45208f804d2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_soc_parameter_types.h
@@ -20,7 +20,6 @@ struct dml2_soc_derate_values {
 
 struct dml2_soc_derates {
 	struct dml2_soc_derate_values system_active_urgent;
-	struct dml2_soc_derate_values system_active_average;
 	struct dml2_soc_derate_values dcn_mall_prefetch_urgent;
 	struct dml2_soc_derate_values dcn_mall_prefetch_average;
 	struct dml2_soc_derate_values system_idle_average;
@@ -71,8 +70,22 @@ enum dml2_qos_param_type {
 	dml2_qos_param_type_dcn4x
 };
 
-//Indicies mapped to DPM level
-// Unpopulated indicies should fallback to the global derate value.
+// Per-DPM derate structure: each element pairs a derate percentage with its clock threshold
+// Requirements:
+// - Index 0 must always be populated (the base/default derate)
+// - Last populated entry must have clk_upperbound_threshold_khz = 0
+// - All clock arrays within a power state should have the same number of entries
+// - If a non-zero DPM index has derate_percent = 0, fall back to index 0
+// Unpopulated derates should fallback to the global derate value.
+// Each element pairs a derate percentage with its threshold
+struct dml2_soc_derate_values_per_dpm_v2 {
+	unsigned int derate_percent;
+	unsigned int clk_upperbound_threshold_khz;
+};
+
+// Legacy structure - for backward compatibility as driver debug values can override the values. (will temporarily break driver overrides)
+// Per-DPM derate arrays for system_active_average (the only power state that varies by DPM)
+// Urgent derates are constant across DPMs and come from derate_table.system_active_urgent
 struct dml2_soc_derate_values_per_dpm {
 	unsigned int dram_derate_percent_pixel[DML_MAX_CLK_TABLE_SIZE];
 	unsigned int fclk_derate_percent[DML_MAX_CLK_TABLE_SIZE];
@@ -80,12 +93,31 @@ struct dml2_soc_derate_values_per_dpm {
 };
 
 struct dml2_soc_derates_per_dpm {
-	struct dml2_soc_derate_values_per_dpm system_active_derates_per_dpm;
+	// Union allows both layouts to coexist without increasing struct size
+	// Anonymous structs allow direct member access without .v1 or .v2 prefix
+	union {
+		// Legacy layout - used by soc_and_ip_translator (unchanged access pattern)
+		// TODO: Remove after soc_and_ip_translator migration is complete
+		struct {
+			struct dml2_soc_derate_values_per_dpm system_active_derates_per_dpm;
+			unsigned int min_uclk_khz_threshold[DML_MAX_CLK_TABLE_SIZE];
+			unsigned int min_fclk_khz_threshold[DML_MAX_CLK_TABLE_SIZE];
+			unsigned int min_dcfclk_khz_threshold[DML_MAX_CLK_TABLE_SIZE];
+		};
+
+		// New layout - used by DML internally
+		// Arrays of derate/threshold pairs, one per DPM level
+		struct {
+			struct dml2_soc_derate_values_per_dpm_v2 dram_per_dpm_derate_pixel[DML_MAX_CLK_TABLE_SIZE];
+			struct dml2_soc_derate_values_per_dpm_v2 fclk_per_dpm_derate[DML_MAX_CLK_TABLE_SIZE];
+			struct dml2_soc_derate_values_per_dpm_v2 dcfclk_per_dpm_derate[DML_MAX_CLK_TABLE_SIZE];
+		};
+	};
 };
 
 struct dml2_soc_qos_parameters {
-	struct dml2_soc_derates derate_table;
-	struct dml2_soc_derates_per_dpm derate_table_per_dpm;
+	struct dml2_soc_derates derate_table; // Single-value derates (source of truth for urgent, idle, mall_prefetch)
+	struct dml2_soc_derates_per_dpm derate_table_per_dpm; // Per-DPM derates for system_active_average only
 	struct {
 		unsigned int base_latency_us;
 		unsigned int scaling_factor_us;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index d943cc8bf60e..475bdeb39d21 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -2739,16 +2739,15 @@ static double dml_get_return_bandwidth_available(
 			derate_fabric_factor = soc->qos_parameters.derate_table.dcn_mall_prefetch_average.fclk_derate_percent / 100.0;
 			derate_dram_factor = soc->qos_parameters.derate_table.dcn_mall_prefetch_average.dram_derate_percent_pixel / 100.0;
 		} else { // just assume sys_active
-			// use per dpm derates if the values are populated. Otherwise use global derates
-			derate_sdp_factor = soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dcfclk_derate_percent[uclk_dpm_level] != 0 ?
-				soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dcfclk_derate_percent[uclk_dpm_level] / 100.0 :
-				soc->qos_parameters.derate_table.system_active_average.dcfclk_derate_percent / 100.0;
-			derate_fabric_factor = soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.fclk_derate_percent[uclk_dpm_level] != 0 ?
-				soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.fclk_derate_percent[uclk_dpm_level] / 100.0 :
-				soc->qos_parameters.derate_table.system_active_average.fclk_derate_percent / 100.0;
-			derate_dram_factor = soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dram_derate_percent_pixel[uclk_dpm_level] != 0 ?
-				soc->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dram_derate_percent_pixel[uclk_dpm_level] / 100.0 :
-				soc->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100.0;
+			derate_sdp_factor = (soc->qos_parameters.derate_table_per_dpm.dcfclk_per_dpm_derate[uclk_dpm_level].derate_percent != 0 ?
+				soc->qos_parameters.derate_table_per_dpm.dcfclk_per_dpm_derate[uclk_dpm_level].derate_percent :
+				soc->qos_parameters.derate_table_per_dpm.dcfclk_per_dpm_derate[0].derate_percent) / 100.0;
+			derate_fabric_factor = (soc->qos_parameters.derate_table_per_dpm.fclk_per_dpm_derate[uclk_dpm_level].derate_percent != 0 ?
+				soc->qos_parameters.derate_table_per_dpm.fclk_per_dpm_derate[uclk_dpm_level].derate_percent :
+				soc->qos_parameters.derate_table_per_dpm.fclk_per_dpm_derate[0].derate_percent) / 100.0;
+			derate_dram_factor = (soc->qos_parameters.derate_table_per_dpm.dram_per_dpm_derate_pixel[uclk_dpm_level].derate_percent != 0 ?
+				soc->qos_parameters.derate_table_per_dpm.dram_per_dpm_derate_pixel[uclk_dpm_level].derate_percent :
+				soc->qos_parameters.derate_table_per_dpm.dram_per_dpm_derate_pixel[0].derate_percent) / 100.0;
 		}
 	} else { // urgent bw
 		if (state_type == dml2_core_internal_soc_state_svp_prefetch) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index 22c757cdac07..54a1f9c13dbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -6,6 +6,8 @@
 #include "dml2_internal_shared_types.h"
 #include "dml_top_types.h"
 #include "lib_float_math.h"
+#include "dml2_debug.h"
+
 
 static double dram_bw_kbps_to_uclk_khz(unsigned long long bandwidth_kbps, const struct dml2_dram_params *dram_config, struct dml2_mcg_dram_bw_to_min_clk_table *dram_bw_table)
 {
@@ -55,16 +57,101 @@ static unsigned long dml_round_up(double a)
 	return (unsigned long)a;
 }
 
+/* Calculate DPM index to use for per-DPM derates
+ * Iterates through DPM levels - if calculated clocks exceed thresholds increment to next DPM level
+ */
+static void calculate_derate_index(struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out *in_out)
+{
+	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
+	double required_bw_dram_kbps, required_bw_sdp_kbps;
+	int i;
+
+	/* Default to DPM 0 (lowest power state) */
+	in_out->derate_dpm_index = 0;
+
+	/* Get required bandwidths from mode support */
+	required_bw_dram_kbps = mode_support_result->global.active.average_bw_dram_kbps;
+	required_bw_sdp_kbps = mode_support_result->global.active.average_bw_sdp_kbps;
+
+	/* Iterate through DPM levels from lowest to highest to find the first level
+	 * whose available bandwidth can satisfy the requirements.
+	 */
+	for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
+		unsigned int dram_threshold = in_out->soc_bb->qos_parameters.derate_table_per_dpm.dram_per_dpm_derate_pixel[i].clk_upperbound_threshold_khz;
+		unsigned int fclk_threshold = in_out->soc_bb->qos_parameters.derate_table_per_dpm.fclk_per_dpm_derate[i].clk_upperbound_threshold_khz;
+		unsigned int dcfclk_threshold = in_out->soc_bb->qos_parameters.derate_table_per_dpm.dcfclk_per_dpm_derate[i].clk_upperbound_threshold_khz;
+		unsigned int uclk_derate = in_out->soc_bb->qos_parameters.derate_table_per_dpm.dram_per_dpm_derate_pixel[i].derate_percent;
+		unsigned int fclk_derate = in_out->soc_bb->qos_parameters.derate_table_per_dpm.fclk_per_dpm_derate[i].derate_percent;
+		unsigned int dcfclk_derate = in_out->soc_bb->qos_parameters.derate_table_per_dpm.dcfclk_per_dpm_derate[i].derate_percent;
+		double max_dram_bw_for_dpm = 0, max_fclk_bw_for_dpm = 0, max_dcfclk_bw_for_dpm = 0;
+
+		/* Skip entries with 0 derate (use fallback logic) */
+		if (uclk_derate == 0 || fclk_derate == 0 || dcfclk_derate == 0) {
+			DML_ASSERT(0); // derate should be populated (at least 1 entry in the per_dpm table that can be applied for all DPMs
+		}
+
+		/* Threshold of 0 indicates last entry - this DPM level handles all higher bandwidths */
+		if (dram_threshold == 0 && fclk_threshold == 0 && dcfclk_threshold == 0) {
+			in_out->derate_dpm_index = i;
+			break;
+		}
+
+		/* Calculate maximum available bandwidth at this DPM level
+			* Available BW = max_clock_at_threshold * derate * conversion_factor */
+
+			/* For DRAM: convert threshold clock to bandwidth */
+		if (!in_out->soc_bb->clk_table.dram_config.alt_clock_bw_conversion) {
+			unsigned long uclk_bytes_per_tick = in_out->soc_bb->clk_table.dram_config.channel_count
+				* in_out->soc_bb->clk_table.dram_config.channel_width_bytes
+				* in_out->soc_bb->clk_table.dram_config.transactions_per_clock;
+			max_dram_bw_for_dpm = (double)dram_threshold * uclk_bytes_per_tick * ((double)uclk_derate / 100.0);
+		} else {
+			/* use pre-computed table - find bandwidth at threshold clock */
+			for (unsigned int j = 0; j < in_out->min_clk_table->dram_bw_table.num_entries; j++) {
+				if (in_out->min_clk_table->dram_bw_table.entries[j].min_uclk_khz >= dram_threshold) {
+					max_dram_bw_for_dpm = (double)in_out->min_clk_table->dram_bw_table.entries[j].pre_derate_dram_bw_kbps;
+					break;
+				}
+			}
+		}
+
+		max_fclk_bw_for_dpm = (double)fclk_threshold
+			* in_out->soc_bb->fabric_datapath_to_dcn_data_return_bytes
+			* ((double)fclk_derate / 100.0);
+
+		max_dcfclk_bw_for_dpm = (double)dcfclk_threshold
+			* in_out->soc_bb->return_bus_width_bytes
+			* ((double)dcfclk_derate / 100.0);
+
+		/* Check if this DPM level's available bandwidth satisfies all requirements
+			* All bandwidth paths must be satisfied to use this DPM level */
+		if (((dram_threshold == 0) || (required_bw_dram_kbps <= max_dram_bw_for_dpm)) &&
+			((fclk_threshold == 0) || (required_bw_sdp_kbps <= max_fclk_bw_for_dpm)) &&
+			((dcfclk_threshold == 0) || (required_bw_sdp_kbps <= max_dcfclk_bw_for_dpm))) {
+			in_out->derate_dpm_index = i;
+			break;
+		}
+	}
+}
+
 static void calculate_system_active_minimums(struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out *in_out)
 {
 	double min_uclk_avg, min_uclk_urgent, min_uclk_bw;
 	double min_fclk_avg, min_fclk_urgent, min_fclk_bw;
 	double min_dcfclk_avg, min_dcfclk_urgent, min_dcfclk_bw;
 	double min_uclk_latency, min_fclk_latency, min_dcfclk_latency;
+	int dpm_index, uclk_avg_derate_percent, fclk_avg_derate_percent, dcfclk_avg_derate_percent;
 	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
 
+	dpm_index = in_out->derate_dpm_index;
+
+	/* Get average derates from system_active_average per-DPM table */
+	uclk_avg_derate_percent = (in_out->soc_bb->qos_parameters.derate_table_per_dpm.dram_per_dpm_derate_pixel[dpm_index].derate_percent != 0 || dpm_index == 0) ?
+		in_out->soc_bb->qos_parameters.derate_table_per_dpm.dram_per_dpm_derate_pixel[dpm_index].derate_percent :
+		in_out->soc_bb->qos_parameters.derate_table_per_dpm.dram_per_dpm_derate_pixel[0].derate_percent;
+
 	min_uclk_avg = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.active.average_bw_dram_kbps
-											/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100)),
+											/ ((double)uclk_avg_derate_percent / 100)),
 							&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	if (in_out->display_cfg->display_config.hostvm_enable)
@@ -78,16 +165,22 @@ static void calculate_system_active_minimums(struct dml2_dpmm_map_mode_to_soc_dp
 
 	min_uclk_bw = min_uclk_urgent > min_uclk_avg ? min_uclk_urgent : min_uclk_avg;
 
+	fclk_avg_derate_percent = (in_out->soc_bb->qos_parameters.derate_table_per_dpm.fclk_per_dpm_derate[dpm_index].derate_percent != 0 || dpm_index == 0) ?
+		in_out->soc_bb->qos_parameters.derate_table_per_dpm.fclk_per_dpm_derate[dpm_index].derate_percent :
+		in_out->soc_bb->qos_parameters.derate_table_per_dpm.fclk_per_dpm_derate[0].derate_percent;
 	min_fclk_avg = (double)mode_support_result->global.active.average_bw_sdp_kbps / in_out->soc_bb->fabric_datapath_to_dcn_data_return_bytes;
-	min_fclk_avg = (double)min_fclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.fclk_derate_percent / 100);
+	min_fclk_avg = (double)min_fclk_avg / ((double)fclk_avg_derate_percent / 100);
 
 	min_fclk_urgent = (double)mode_support_result->global.active.urgent_bw_sdp_kbps / in_out->soc_bb->fabric_datapath_to_dcn_data_return_bytes;
 	min_fclk_urgent = (double)min_fclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.fclk_derate_percent / 100);
 
 	min_fclk_bw = min_fclk_urgent > min_fclk_avg ? min_fclk_urgent : min_fclk_avg;
 
+	dcfclk_avg_derate_percent = (in_out->soc_bb->qos_parameters.derate_table_per_dpm.dcfclk_per_dpm_derate[dpm_index].derate_percent != 0 || dpm_index == 0) ?
+		in_out->soc_bb->qos_parameters.derate_table_per_dpm.dcfclk_per_dpm_derate[dpm_index].derate_percent :
+		in_out->soc_bb->qos_parameters.derate_table_per_dpm.dcfclk_per_dpm_derate[0].derate_percent;
 	min_dcfclk_avg = (double)mode_support_result->global.active.average_bw_sdp_kbps / in_out->soc_bb->return_bus_width_bytes;
-	min_dcfclk_avg = (double)min_dcfclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dcfclk_derate_percent / 100);
+	min_dcfclk_avg = (double)min_dcfclk_avg / ((double)dcfclk_avg_derate_percent / 100);
 
 	min_dcfclk_urgent = (double)mode_support_result->global.active.urgent_bw_sdp_kbps / in_out->soc_bb->return_bus_width_bytes;
 	min_dcfclk_urgent = (double)min_dcfclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dcfclk_derate_percent / 100);
@@ -145,7 +238,7 @@ static void calculate_svp_prefetch_minimums(struct dml2_dpmm_map_mode_to_soc_dpm
 
 	/* assumes DF throttling is disabled */
 	min_uclk_avg = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.svp_prefetch.average_bw_dram_kbps
-										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100)),
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table_per_dpm.dram_per_dpm_derate_pixel[in_out->derate_dpm_index].derate_percent / 100)),
 								&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	min_uclk_urgent = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.svp_prefetch.urgent_bw_dram_kbps
@@ -155,7 +248,7 @@ static void calculate_svp_prefetch_minimums(struct dml2_dpmm_map_mode_to_soc_dpm
 	min_uclk_bw = min_uclk_urgent > min_uclk_avg ? min_uclk_urgent : min_uclk_avg;
 
 	min_fclk_avg = (double)mode_support_result->global.svp_prefetch.average_bw_sdp_kbps / in_out->soc_bb->fabric_datapath_to_dcn_data_return_bytes;
-	min_fclk_avg = (double)min_fclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.fclk_derate_percent / 100);
+	min_fclk_avg = (double)min_fclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table_per_dpm.fclk_per_dpm_derate[in_out->derate_dpm_index].derate_percent / 100);
 
 	min_fclk_urgent = (double)mode_support_result->global.svp_prefetch.urgent_bw_sdp_kbps / in_out->soc_bb->fabric_datapath_to_dcn_data_return_bytes;
 	min_fclk_urgent = (double)min_fclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.fclk_derate_percent / 100);
@@ -163,7 +256,7 @@ static void calculate_svp_prefetch_minimums(struct dml2_dpmm_map_mode_to_soc_dpm
 	min_fclk_bw = min_fclk_urgent > min_fclk_avg ? min_fclk_urgent : min_fclk_avg;
 
 	min_dcfclk_avg = (double)mode_support_result->global.svp_prefetch.average_bw_sdp_kbps / in_out->soc_bb->return_bus_width_bytes;
-	min_dcfclk_avg = (double)min_dcfclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dcfclk_derate_percent / 100);
+	min_dcfclk_avg = (double)min_dcfclk_avg / ((double)in_out->soc_bb->qos_parameters.derate_table_per_dpm.dcfclk_per_dpm_derate[in_out->derate_dpm_index].derate_percent / 100);
 
 	min_dcfclk_urgent = (double)mode_support_result->global.svp_prefetch.urgent_bw_sdp_kbps / in_out->soc_bb->return_bus_width_bytes;
 	min_dcfclk_urgent = (double)min_dcfclk_urgent / ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dcfclk_derate_percent / 100);
@@ -633,6 +726,7 @@ static bool map_mode_to_soc_dpm(struct dml2_dpmm_map_mode_to_soc_dpm_params_in_o
 	double dispclk_khz;
 	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
 
+	calculate_derate_index(in_out);
 	calculate_system_active_minimums(in_out);
 	calculate_svp_prefetch_minimums(in_out);
 	calculate_idle_minimums(in_out);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index a18f067fe53f..8ddf58da2eed 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -246,6 +246,7 @@ struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out {
 	* Output
 	*/
 	struct dml2_display_cfg_programming *programming;
+	int derate_dpm_index;
 };
 
 struct dml2_dpmm_map_watermarks_params_in_out {
-- 
2.43.0

