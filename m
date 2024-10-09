Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC04CEE342
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F7A10E7DD;
	Wed,  9 Oct 2024 19:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gHgFVkoD";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C726010E7DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOFodSaVnaBMIlmdC43dnfEN+acepjnM1y2J65BpnOoGv+wdvLKp/Uc0jqLHxxT/ThbJ07qiLm0vW2o53Zahy1AM0K9yMmL8g0MmSzGgyan7jh/XuHuUdTPabcWe7QDz2+MSxn0ShrtZR0/0F6ba4vhssDI37S/+uUhqx+sZXxNzP75nTR9QTEzEv8sLliWZeLNR/E0VVJzPpEZLP4ArMFjwXcwMUVEqJ67d0N7v3a2z5yr3fiZPpJhRLnZbBbchqyaP4pee476g2YVltlFf93fxPFhHtkD+H6syoC9p/Q4zvJyH2ebs2BtbclNgfI05vdViIPXUu6GpWbclrTcJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWCBClkTtRkmWQFxN3ZveNxhxMsnh862CNaq73Db8KA=;
 b=lGEo/svIO/QB9mlVbMVq+/BGUEGKRph5VXDUGxgU5MWqpoJUmLgIsf3F52rowo5dbsMrU+CXLTbf6KMX2EtdaeCaOPfSD1b7M9Ukpi4JLjSofBVEm12xOmB7BF+8WKyeD0ZDJYz+gtGklPfeuRMLRfCDYfXnbU2PKew7lBnRvXGPzCgx3W2IeFbRh60qvzH0ldhArWJSBUlVEwmwzP4tDg6nojTzrMa29c9vIDWnnVoaN9IcasdJizonhWmIYgRwjyOeSEXvoJRK/TaYZEYETYEPz4Y/YbZeGlGScHFp5WrQSmNGIwjbdn+fiX/57mXzJkLY1MeYavIGd8ljuW3V5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWCBClkTtRkmWQFxN3ZveNxhxMsnh862CNaq73Db8KA=;
 b=gHgFVkoDM2CLs2p7fChhR1BWM1mH79JqzxReCuaLxP5r38g14cs62i0CpjkhpszVUzXJMUrpwwsk3+nZh5o5VtGRP9K54Wp2U8jYm26nh1l+Z9ASeRnjzPiiqm4fBzFZ1rX5IrN4NA/dcuz4Sv6fYy0WQmLmI/wjwliiN743G0w=
Received: from BL1PR13CA0438.namprd13.prod.outlook.com (2603:10b6:208:2c3::23)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 19:26:05 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::2d) by BL1PR13CA0438.outlook.office365.com
 (2603:10b6:208:2c3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 19:26:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:05 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:04 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Dillon Varone <dillon.varone@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 11/16] drm/amd/display: resolve correct MALL size for dcn401
Date: Wed, 9 Oct 2024 15:23:39 -0400
Message-ID: <20241009192344.650118-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: e4641520-26d1-4406-ad91-08dce8983848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rIeOM8/Y7jO/G4I9mgS0Qf69GMFG6ZK0YFUkfEjNIGNov8jyHxDt+0thIRRL?=
 =?us-ascii?Q?zLkLs0SBL8QpTP/ax6oET5xXSUujC6fy7SsgQWRsXQ0iG4QR/8MClcEWb3Xb?=
 =?us-ascii?Q?fQjZTVxHMRliNaDxSK3x5NqAifvtbbFL2jx17s5ze26Addfnuvdum323HtrI?=
 =?us-ascii?Q?K1bJfeSD5dIYGmMdNkuXa9Gld2AoD9OEatZCabGNO5naVXMORZiariyqGAFN?=
 =?us-ascii?Q?mn9xdCY4ucV5JGljde35DFg+9hxQxyLRvDU+EW8aSkQbXFHUK0afahSfrBF2?=
 =?us-ascii?Q?GwUwyz/6gloqLSfK9wdRy8DnOyVFELXj2jktPFO7zJCMP9zMbjelDgJ9HOBC?=
 =?us-ascii?Q?7uonaOfJq3hToBsT2M7ye2CM66JRuj2sTkYI/IFsoiWoJ0OHC1pXTdPMXm2j?=
 =?us-ascii?Q?8mnBgV+QdT2C3FdcVj+z+XsXbUtz+VxYOfwY6j45kuDIv98V7PC1kit1jNhI?=
 =?us-ascii?Q?Iv+ceBtTt5C53K3zgdlc8iIdACoLMBJlzd03FfxNnxEdavbmO4L7CaUSlLfn?=
 =?us-ascii?Q?K6Ykcv/UgeBbYvAaBlSVHabzsoHpib6s4ULG3MKwOpm6Gs2WCOrTugm7vXPA?=
 =?us-ascii?Q?nvCB2UUbTjw1wsnpqIxe0Rfut4vOPIR89OomsUlwgtUB5lkiyTQWE7JwpPDb?=
 =?us-ascii?Q?yYMGcIavn+a4s9zckY0hp3VMLGvaIpFFCDleRdVRJ212srBWpLLg8JRmYD5i?=
 =?us-ascii?Q?Tz3e3B/SCwV6tRl5ljSaIK7FQ14TGSGMj43g/DQ5DjN5JJQYSj89w5JfqXk1?=
 =?us-ascii?Q?qyTosP7KDHyj8b4ce1Oh8/Y6rzvpdL7s/JlbAI5q/r2VQ9N6/Hio8jqlrBxZ?=
 =?us-ascii?Q?mEc692Wj76r2MMbhVNpHNy9DwVdgFaHT58wImrDmwZavgbFM7whlrnKHcKwi?=
 =?us-ascii?Q?8YuDc9lw9x9kU8UJS270Vkg+igPVsOTk1gZV6Hvyn34qFVsBG3UPt6v4Z5T5?=
 =?us-ascii?Q?HEjWAaXz2sKj1+bP2yyjqfxzXrZi5KTXX4+P2eOZ8y2TAzsc3dGoxXyMcxjS?=
 =?us-ascii?Q?Y2nXAhP3gUkptzXR0X93wi5hBSq1T5HIXNVJO6ON36R29FyT2sSJjZymMQ/M?=
 =?us-ascii?Q?kcBV+zjtVACC6Q/U+DTB/ariO/1bdZIeEHD16ouZ7W8xZ5L6IU8tkws4LKL+?=
 =?us-ascii?Q?g1mRO2QTMNAbs/9uHgUChLSI9aIPLOLcmxro4GO3myPXZBImTWIL+VRIAdAC?=
 =?us-ascii?Q?u14y+oiC95Eyr6Jr0+IIISYsQPdNC+r22SlzrwPMeqmQ6hc56ZCsEyZRX//1?=
 =?us-ascii?Q?hzlMzsM7cXX8oZ7Aw2Qv1X3RulM9RdAf5eEuh30SA3CukA6zTW/3/LLAJ6OR?=
 =?us-ascii?Q?oTsqEvyEWhc1GBetZcRG6EBkQ8MbvpyzLvyJGJnpPGXG0RT1y9nfim9tc3RQ?=
 =?us-ascii?Q?wybet1UK0SsSpBrQGINYUIlXXyg0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:05.6102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4641520-26d1-4406-ad91-08dce8983848
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
Code for dcn401 to calculate available MALL size for display was shared
with dcn32 and did not provide the correct result for all ASICs.

[HOW]
Add dcn401 specific function to properly calculate the available MALL
for display.

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../dc/resource/dcn32/dcn32_resource.c        |  4 +++
 .../dc/resource/dcn401/dcn401_resource.c      | 27 ++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index a124ad9bd108..f758d463e460 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1990,6 +1990,10 @@ unsigned int dcn32_calculate_mall_ways_from_bytes(const struct dc *dc, unsigned
 		return 0;
 	}
 
+	if (dc->caps.max_cab_allocation_bytes == 0) {
+		return 0xffffffff;
+	}
+
 	/* add 2 lines for worst case alignment */
 	cache_lines_used = total_size_in_mall_bytes / dc->caps.cache_line_size + 2;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 59184abab1a7..7da81966b4df 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1704,6 +1704,29 @@ static int dcn401_get_power_profile(const struct dc_state *context)
 	return dpm_level;
 }
 
+static unsigned int dcn401_calc_num_avail_chans_for_mall(struct dc *dc, unsigned int num_chans)
+{
+	unsigned int num_available_chans = 1;
+
+	/* channels for MALL must be a power of 2 */
+	while (num_chans > 1) {
+		num_available_chans = (num_available_chans << 1);
+		num_chans = (num_chans >> 1);
+	}
+
+	/* cannot be odd */
+	num_available_chans &= ~1;
+
+	/* clamp to max available channels for MALL per ASIC */
+	if (ASICREV_IS_GC_12_0_0_A0(dc->ctx->asic_id.hw_internal_rev)) {
+		num_available_chans = num_available_chans > 16 ? 16 : num_available_chans;
+	} else if (ASICREV_IS_GC_12_0_1_A0(dc->ctx->asic_id.hw_internal_rev)) {
+		num_available_chans = num_available_chans > 8 ? 8 : num_available_chans;
+	}
+
+	return num_available_chans;
+}
+
 static struct resource_funcs dcn401_res_pool_funcs = {
 	.destroy = dcn401_destroy_resource_pool,
 	.link_enc_create = dcn401_link_encoder_create,
@@ -1812,14 +1835,12 @@ static bool dcn401_resource_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 	dc->caps.mall_size_per_mem_channel = 4;
-	/* total size = mall per channel * num channels * 1024 * 1024 */
-	dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel * dc->ctx->dc_bios->vram_info.num_chans * 1048576;
 	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
 	dc->caps.cache_line_size = 64;
 	dc->caps.cache_num_ways = 16;
 
 	/* Calculate the available MALL space */
-	dc->caps.max_cab_allocation_bytes = dcn32_calc_num_avail_chans_for_mall(
+	dc->caps.max_cab_allocation_bytes = dcn401_calc_num_avail_chans_for_mall(
 		dc, dc->ctx->dc_bios->vram_info.num_chans) *
 		dc->caps.mall_size_per_mem_channel * 1024 * 1024;
 	dc->caps.mall_size_total = dc->caps.max_cab_allocation_bytes;
-- 
2.34.1

