Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D477C02199
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A023B10E3AD;
	Wed,  5 Feb 2025 18:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XY+eazm3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F8110E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDs8GsbVYdAM2Ed9t+GUXLDGCTDiSY+9VeeEbe0s0mgMZzOQH2ihhMEOxhKJ66e3LhSIBnvToOm881W1Gwr4rqm4upQtirVUCJobVLkfUuFX+rWARF80sfTpXk/JltfqByyziMnFuxEBe+pmNFsx59mk3HcUGWa1qTB3qfLA/ed6KMmJAaEP0GByulx0cE8BzUYQbU+4cTe7pO1DYCAKpwfUjusZEIKUQxJfChbEva8ERAtZ/5CGCkeNE1gx9XxnUsmjqeIKpcWyTy6PO8Pki0EIXkkAalmWrOw/GQWsJE28iJ0dLOJqqoXVXqYtaQ/EnYzVxBXhwM/ip8gYUImTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqAmANsTdDjJURzk9b8ocNrlbivqY5Yol8NPbpaGgrc=;
 b=ZdR7R+09b3Yg+P+F/rDdm/XfSvtVwFe+AxegariHh6cTqUBDvSOqfeDnCfZ9O0k1qL/8TApBNPfZbmm5ZCwrz4zu9Er3uaMFQa+8kSd61QpkfXKO5YA21HdnCLzkiNXvDcoeFoQLquSfjlqCODT72i9i8Hyrr6HnGNtdKwFPDA75juK3+4xiQRZ4nut21pgbufbtGxfX1nF8isoXEHt76A0cMm68i2wuXqPxOiNxtOibl0G+gCCSYsaLRNom7uJjaseEFLxScJfOlbfmi9GoXeSRb8E7WEKiQ8L2ufDD/qsMWBFuwrNfT3gPjGKuZUeMbQecicj0cS2MHKblGpesmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqAmANsTdDjJURzk9b8ocNrlbivqY5Yol8NPbpaGgrc=;
 b=XY+eazm3jfqsQ/Ih1kk5/AXcYYgEbW0+qXd0NOzWmnhWjNIv3/0PPxRSg9BWH5Dph8Xan8az7BR0D0e6mETfhcaUFIOtlo+ewczqOptu0TkMVEiRaC0JNRXtIWiVDIM0ugzJ/k3k1QfSZDw/dfOgezvMcYiuZm9u3cLP/4y0wQM=
Received: from PH0PR07CA0051.namprd07.prod.outlook.com (2603:10b6:510:e::26)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Wed, 5 Feb
 2025 18:40:54 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::5b) by PH0PR07CA0051.outlook.office365.com
 (2603:10b6:510:e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 18:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:40:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:52 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:51 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:40:51 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 01/14] drm/amd/display: Expose 3 secondary planes for
 supported ASICs
Date: Wed, 5 Feb 2025 13:39:16 -0500
Message-ID: <20250205184036.2371098-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: a496dd1d-b817-434f-43b9-08dd46149e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XoB12Aa8EgkS5qDzu48s4i3fd3rwJITxamQw2RNh30qqiEPPrNHNsiTETOz2?=
 =?us-ascii?Q?TkoQXHjLTgcYnZge2TYXEonoPIslFRO1KOKgCCYcHfpJAJoitVCpA/5nyj8L?=
 =?us-ascii?Q?Y8Sln8oGYq4Dg2OrIXmCZYwnQKN246zK9xH8hpgAmK66ze+zgPtc/k3BvwTm?=
 =?us-ascii?Q?X+CTOoFV99opu+OrwAPLb6S0RLowFnwwC1aigf7KPBkqh7aC3s3F9yh/tQ5J?=
 =?us-ascii?Q?J/6Wd6LERlWJvcaHhEdi2VGgr6ua+2DUrAiKZwuAVn1whs/NXmFjJncE/Dr8?=
 =?us-ascii?Q?Uv5AGqJ1BIAy8efWvAVTlOKijpoAqFme5SnEn16Etfhd0pRqu8KLp0AJfOyF?=
 =?us-ascii?Q?F0UFj0IYZDpFs79AGcqoo8FN9xYoNYVcexy0M3VEF5y2TaiacWKclYU03K9X?=
 =?us-ascii?Q?7FCZq9Yhbqr8ZNx7Z9up1TnK8+tfEgobcUKLXp6Ks9O8+6ke7njGUgFcp732?=
 =?us-ascii?Q?Z08/lcThJra3idb+aFNn5RBbs38/fd7dgwUj4H1oWsZfXQmgW1pJRpmFzJVe?=
 =?us-ascii?Q?N5afHAJoQy828Td22EhVmqgTUFzzLYN9jmklFLnwvl9IUwgCLk3F2LOktlPy?=
 =?us-ascii?Q?JxyYuA0uKeyaqxJEjUGVyY4xrSXFLt7NMPGwZxW6/GDjBTO7DIDXpbN4N4Me?=
 =?us-ascii?Q?7PpMMRY9tTJQb/SZsQ9FmUubJRU5N5BeOynnvaPLBc7Elnb/1x+6Uu2SslYe?=
 =?us-ascii?Q?Lw+fa8JL3l7FDTp8Lu/LbVodbh2WwsNS1m4dgKFGNo8LrYN2GsQI4ICyX1+O?=
 =?us-ascii?Q?U0NFgi0JoT2UqS8Aq2v2L+g+uPpawnV5VPzzVKIMS9LUYB8GfZJFwEDoFZdV?=
 =?us-ascii?Q?kFF7+mqVXlbwvDCeDxhp2/6LVd6+tmxc/hrxIHcvDx+WQhXrA0GdaIkk8s86?=
 =?us-ascii?Q?f3CHihzfYdVhTDRhymjjFXMK2//SK/ytC4jSiRR6bnRwxTfxquWzqOu4pGtA?=
 =?us-ascii?Q?K6rtdx8xG7psZBkFGYPuOCBpPS2KKVF6NqmKpKUClkZz/Znw3OJWUgZhgA1T?=
 =?us-ascii?Q?6vQRrvRbDUOjxuEFzSRRAvP1Py97iMjPyYj941cWrsKJXioS9nYBBiVX0Ai2?=
 =?us-ascii?Q?B3R2mreNwloeEtmDaHal8sTjoxaCfEeifbHWhLgRTccyWJ+eDP52ywNtNMwM?=
 =?us-ascii?Q?FbnSQepayBnWQ4OFyzTbts1MLErDpdorfU8GUhkUETaCCzpS+rtdC18fyvT6?=
 =?us-ascii?Q?Ux064eYSclvkSIRb6p+lYD3xuq/TKM2rc4bFuDYg/Mg1G9AvWRyRh4e8H+R1?=
 =?us-ascii?Q?eQyCOFHbXBfhQytKdSMc5lDAXRz4hNdJ/ImvoeDt98g7N84IvFeTH5IKUQTL?=
 =?us-ascii?Q?yFAL40bvkyXeksSzWx7h2P4UpiXgHkx12+sh7sXsUQ/W4+4YMtD1q7PplW4S?=
 =?us-ascii?Q?An7KnhQrVSp/iSRD5eXnR/lqSlRCt4GX2FJgmsI9n7mhrpJdmen4pG+3kUJT?=
 =?us-ascii?Q?Og8838ztnP1SPllvD1FbdZ7p7e2t58I0Qh1StXYZOPfAU2FMpSF81gvjXNXv?=
 =?us-ascii?Q?FmpeSYCi/OC83x0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:40:52.7538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a496dd1d-b817-434f-43b9-08dd46149e76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
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

From: Zaeem Mohamed <zaeem.mohamed@amd.com>

[why]
For enabling 4-plane MPO, we need dc to expose 4 planes for DCN35 and
beyond, as well as DCN21

[how]
Set dc_caps.max_slave_*planes to 3 for appropriate ASICs

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c  | 6 +++---
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 6 +++---
 .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 6 +++---
 .../drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 2615c36d5ffe..4bd5c2278596 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -1413,9 +1413,9 @@ static bool dcn21_resource_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 
-	dc->caps.max_slave_planes = 1;
-	dc->caps.max_slave_yuv_planes = 1;
-	dc->caps.max_slave_rgb_planes = 1;
+	dc->caps.max_slave_planes = 3;
+	dc->caps.max_slave_yuv_planes = 3;
+	dc->caps.max_slave_rgb_planes = 3;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 8ee3d99ea2aa..6d163dcecde6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1839,9 +1839,9 @@ static bool dcn35_resource_construct(
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-	dc->caps.max_slave_planes = 2;
-	dc->caps.max_slave_yuv_planes = 2;
-	dc->caps.max_slave_rgb_planes = 2;
+	dc->caps.max_slave_planes = 3;
+	dc->caps.max_slave_yuv_planes = 3;
+	dc->caps.max_slave_rgb_planes = 3;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 14f7c3acdc96..4a03df5d760f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1811,9 +1811,9 @@ static bool dcn351_resource_construct(
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-	dc->caps.max_slave_planes = 2;
-	dc->caps.max_slave_yuv_planes = 2;
-	dc->caps.max_slave_rgb_planes = 2;
+	dc->caps.max_slave_planes = 3;
+	dc->caps.max_slave_yuv_planes = 3;
+	dc->caps.max_slave_rgb_planes = 3;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	if (dc->config.forceHBR2CP2520)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 5cb0e0191a16..6ab194a86cb9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1872,9 +1872,9 @@ static bool dcn401_resource_construct(
 	dc->caps.subvp_vertical_int_margin_us = 30;
 	dc->caps.subvp_drr_vblank_start_margin_us = 100; // 100us margin
 
-	dc->caps.max_slave_planes = 2;
-	dc->caps.max_slave_yuv_planes = 2;
-	dc->caps.max_slave_rgb_planes = 2;
+	dc->caps.max_slave_planes = 3;
+	dc->caps.max_slave_yuv_planes = 3;
+	dc->caps.max_slave_rgb_planes = 3;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
-- 
2.48.1

