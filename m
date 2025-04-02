Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEDEC36017
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 395B310E82C;
	Wed,  2 Apr 2025 16:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S1Z0qgl2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B7710E201
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLXkfZdYKUxP7uzCmNC0NCZky3GbOjpP2uZmCgPHJmXo7z95aOUNadnUzb2enysIETC6YubkmMJAPFSghAg2za3bJ8mKFBurdBCauXsYJlVgZaVibw+j1RXoO5HMW1DLA/Hj9FdhEoLCvcfhLF7258+0epA+xuT5wS4lTsGmu43aqusyUfXf3UjzASdtqHfnvUlkuL7QYBan46pnG/cpGOdJzHkEgP9R25WHvS490itDbg/n/R7O3lLZMKoazQuDNnKcSUxdDqAhI/dB0WCn02HzUr9eukvOy/UgYRP69WQyXxkQS7ekzrG0Tbut4CPx5R2HKCdtBx4QwZxLwF3zKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVKLjTLkiTvM9xQH3IR7V777zYimqT8DoKADSL7BRms=;
 b=MO0TiDjuB/RDxHFH3DH8oS3ARa9LARHs+OZuwOz+vW3Zkc4HZ9O5bwYksWOMPWvQzLLZiPa/jFJ+G8aRK3AsTRiaPJh0dgoF31NmsNwIOm/AKNtzoIAYCpnMuTrAisxc4l+4YawCmZIWyOFGADe0AirtY547RDlCYWOM4AZip+PvOy3B7im97OfdePfRC2mymRl5rjarYg8thTsme0A22CBbIYseZ1uDRKv2myVrPr5MMhnJhpJPtXJvn/RT6z5gr8k9f/tj285iXkTXOIZ/CsnZoZMDpOXuBhk5Xb7VXDMfnm8RprYFYu3nzyz/gNxZs0w/OZMq5N9vyO6wnsmz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVKLjTLkiTvM9xQH3IR7V777zYimqT8DoKADSL7BRms=;
 b=S1Z0qgl2CxlK1k+RSKoF4o2qvzJv9hEetGeQmPP2RKWIL9N/QFO6IGkdQjaydbYhO34ZoC6j+EJXm1Gq2jZB3GPrOVrdxGactuLWpjRhLxY3cwJWRPuBMQIFhQ4k69CP14BC4RXsGJkUX+dr1hd1HJQ5DBERHfBK4S0pZZACPn8=
Received: from CH5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:610:1f1::26)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Wed, 2 Apr
 2025 16:13:39 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::f5) by CH5PR03CA0008.outlook.office365.com
 (2603:10b6:610:1f1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 16:13:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:38 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:38 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Kevin Gao <kgao1003@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 02/16] drm/amd/display: Correct SSC enable detection for DCN351
Date: Wed, 2 Apr 2025 12:13:06 -0400
Message-ID: <20250402161320.983072-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f06ff34-ce59-44df-2792-08dd72015482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cN0o+rpkv3QoOa9PwGNNyJHxYJiDqsZ4dxFXAkr5uLM2aF2jPJQjBXSvw2b3?=
 =?us-ascii?Q?kdMnEJapXxjO8WScBskZafHSo0I5OuW12LiXfQZZz+RGPJpAhMA8R97GoMBv?=
 =?us-ascii?Q?zniM+Vr3qWvlsPwOS1EXUFdLZo+IUeTy7VBhlHXHgkylSC4O1YO8RKnN/nHq?=
 =?us-ascii?Q?Z0nH5YEAhbpLL6ZjQjmIiQrqRNkJrfn2z7Fgbzvwjvjq10ZoDVxWRlVcRQed?=
 =?us-ascii?Q?0SE8p1ebKiRIK3uYy/pBXPgBZqFT8hCDNYgtczjfbSlYX52ikANO3NCC/USY?=
 =?us-ascii?Q?35heBUshNC5CfylV0cd57/+8GeBgJCkp3CJ6TL1TaKJ2Gy0EItfGpMiRgLJp?=
 =?us-ascii?Q?JkmvsYOdpYn8n8Lasi+vPGeNrhgk7oRfyvoIIbydKfJq2VsMb3f5Zh2OE83i?=
 =?us-ascii?Q?65r19Fanl5Wq4/Atujk/fFxBsa5l5EED+IyPYCEEOzP2F6JCyvuyHx4AqI1R?=
 =?us-ascii?Q?HGmbph/SZP4Gh9onnWQKvKD/JHgUjeBwIHmhWgD+FLBCnqLI/jv5U1ijulYY?=
 =?us-ascii?Q?wnasfHuM5jYayyNkSGP8T9BrV1idGODvoNQmBZrofnHc9oic5q1sqARr5dvA?=
 =?us-ascii?Q?bB3+w1tEYomu+3fxtOIPXlzhJOvgDKMdEfAy1UczGJ8+6/jFMsm6ghCGNS4o?=
 =?us-ascii?Q?3SwyMKfhUo2J0mX12CKQct9CNMIsU3u5w98lkaQ9kLGppoobbH6Qgz06DcZk?=
 =?us-ascii?Q?zczyELuL+gdnUD+0kvCbAtSIhSGPWRwf7q5kYuVhM+l6vW6C8iQkFeMRU5aW?=
 =?us-ascii?Q?0xCPAs0MQl0EhzehrhoFKowyqgZtq5OAXYRyGfNBMWjeY8XVzpIDGDY7QawL?=
 =?us-ascii?Q?gh64y+U4lUF5T7pwKdRQLz/Gk3yvEqzOhFK1/D3weXoYig/ToXkfdZokqLpW?=
 =?us-ascii?Q?rQEdfPH+lhz959kqz6lJRjvlDHU3N93W70ZHUjJyd61Ht9XTgQ5+iLur6vlZ?=
 =?us-ascii?Q?eyFJf1DsQ8aVxV+RRRLIogB8dPNyf9f9t+CYQdO1fj9v05bNifb5zKOL9DuK?=
 =?us-ascii?Q?TY+v/Y1T5VP1ZodFazOLIQ7YQ6i2XT6oZwsNfjp1xfHGNUc5Af+jyOnyYSYt?=
 =?us-ascii?Q?19pxRHvXyzdClCHb5ND84ybn9UPpzoG6C6OWtNeqSZKb4BvBCveaFKjGYrPC?=
 =?us-ascii?Q?JcinIMfeAbe4+EDMTM/za9cirRKs7gCpPl32pl53rSJ5duwjld02yCroeOD7?=
 =?us-ascii?Q?0QWq0Csu0Qvs4l+PIDCNtOMfL1VF1V03+ZfJWprB55q2kF0QMlMG30CfjYnb?=
 =?us-ascii?Q?8O5FVsUftvQsG9QrtjH5j9THHKEY4jMlnqDzLc/AEMk3FFNHEfSZ6INEQfYT?=
 =?us-ascii?Q?3I8rjvkuyf8HuB7/qkjP8+JdEHEDWnDhzV7bjoOuHuNaXz25qfbPY6sCZg19?=
 =?us-ascii?Q?2ysoOgec6AW0Hwqgh/XHogUTwk/ZEQTeWLhpVg2eNqXHpQqEGbHzGVUoN0gw?=
 =?us-ascii?Q?8fhF/mDCidKKhh8G8akest/cGWuQvs4RHaiEG1p9MLp6hbt/PK40LKImizvG?=
 =?us-ascii?Q?Uq7Nf6iKpmQ0Aiw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:39.4203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f06ff34-ce59-44df-2792-08dd72015482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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

From: Kevin Gao <kgao1003@amd.com>

[Why]
Due to very small clock register delta between DCN35 and DCN351, clock
spread is being checked on the wrong register for DCN351, causing the
display driver to believe that DPREFCLK downspread to be disabled when
in some stacks it is enabled. This causes the clock values for audio to
be incorrect.

[How]
Both DCN351 and DCN35 use the same clk_mgr, so we modify the DCN35
function that checks for SSC enable to read CLK6 instead of CLK5 when
using DCN351. This allows us to read for DPREFCLK downspread correctly
so the clock can properly compensate when setting values.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Kevin Gao <kgao1003@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c | 1 +
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 8 +++++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h  | 3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c
index 6a6ae618650b..4607eff07253 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c
@@ -65,6 +65,7 @@
 #define mmCLK1_CLK5_ALLOW_DS 0x16EB1
 
 #define mmCLK5_spll_field_8 0x1B04B
+#define mmCLK6_spll_field_8 0x1B24B
 #define mmDENTIST_DISPCLK_CNTL 0x0124
 #define regDENTIST_DISPCLK_CNTL 0x0064
 #define regDENTIST_DISPCLK_CNTL_BASE_IDX 1
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 142de8938d7c..bb1ac12a2b09 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -90,6 +90,7 @@
 #define mmCLK1_CLK5_ALLOW_DS 0x16EB1
 
 #define mmCLK5_spll_field_8 0x1B24B
+#define mmCLK6_spll_field_8 0x1B24B
 #define mmDENTIST_DISPCLK_CNTL 0x0124
 #define regDENTIST_DISPCLK_CNTL 0x0064
 #define regDENTIST_DISPCLK_CNTL_BASE_IDX 1
@@ -116,6 +117,7 @@
 #define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER_MASK 0x7F000000L
 
 #define CLK5_spll_field_8__spll_ssc_en_MASK 0x00002000L
+#define CLK6_spll_field_8__spll_ssc_en_MASK 0x00002000L
 
 #define SMU_VER_THRESHOLD 0x5D4A00 //93.74.0
 #undef FN
@@ -596,7 +598,11 @@ static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
 
 	uint32_t ssc_enable;
 
-	ssc_enable = REG_READ(CLK5_spll_field_8) & CLK5_spll_field_8__spll_ssc_en_MASK;
+	if (clk_mgr_base->ctx->dce_version == DCN_VERSION_3_51) {
+		ssc_enable = REG_READ(CLK6_spll_field_8) & CLK6_spll_field_8__spll_ssc_en_MASK;
+	} else {
+		ssc_enable = REG_READ(CLK5_spll_field_8) & CLK5_spll_field_8__spll_ssc_en_MASK;
+	}
 
 	return ssc_enable != 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 221645c023b5..bac8febad69a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -199,6 +199,7 @@ enum dentist_divider_range {
 	CLK_SR_DCN35(CLK1_CLK4_ALLOW_DS), \
 	CLK_SR_DCN35(CLK1_CLK5_ALLOW_DS), \
 	CLK_SR_DCN35(CLK5_spll_field_8), \
+	CLK_SR_DCN35(CLK6_spll_field_8), \
 	SR(DENTIST_DISPCLK_CNTL), \
 
 #define CLK_COMMON_MASK_SH_LIST_DCN32(mask_sh) \
@@ -307,7 +308,7 @@ struct clk_mgr_registers {
 	uint32_t CLK1_CLK4_ALLOW_DS;
 	uint32_t CLK1_CLK5_ALLOW_DS;
 	uint32_t CLK5_spll_field_8;
-
+	uint32_t CLK6_spll_field_8;
 };
 
 struct clk_mgr_shift {
-- 
2.34.1

