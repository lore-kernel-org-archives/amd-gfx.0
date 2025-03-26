Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F98C3600E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC28110E18D;
	Wed, 26 Mar 2025 19:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MEJKrOnS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CBF10E1E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d270ESxvpT66FnEjXABhMhzbc1uZ+4eREfzQn/2a9VYEOaLkO32rUKpU1bsBJPEIvSL3M7p2XRMbhRBObsEr5hD4SUZK+WRe3BUSLiXtAUCcascAZb5NUPQTdlVBrhjBiMFH3/D4VGNmi0UZXA9rjT/VcypanvvotlaDs5CVwXVpHWigk5OdfN/btZ+hWDMChFhs2wuwkUh9zZ8/4J+jy6YytQi/xihFgy62apxt+pzW45qcqWsHXZNMW5DU3TvsFb0GomqHr4K32OFRi5iRDVXkM5JoxGpyEru45qMR3z4NzWpMhkcAt/RDKglvT4Cos8x1kvdRUioIufdoN8t8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7l2OT+gonoLRDEpE7ZA7egMNQeyHoI4RTbGzoi+2lg=;
 b=MwglS2AblQgIr3Pm8ZFlhcDD7x/jo9b6A1eytXexJ7A5tLtKBm/v2DsBGDw1ByhYjFsi1fvN7lU+1dabQiruccm7XLabOWTkwAO8vnhHTZhGx5vAr9BOxyvzio9VyFJbXOVxLMDsui90wPJqhF30xq244r1mSiO1EdZIoYRuKLH5igsgP2vumUS8gnnT6fabOJw6qiuv28og3LvbDvDSAzje5ldR7Clp/c/7BI82kklmjb1Tqpjf68ECi6GNvKhhJC6XBZAKIdUCgtXpQJIU36hzB6TV8p7ZwBjLFkCiA4HVMBOkSF5gHKS8xeOy20yEi9+ri5vWGUI6CMksThVcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7l2OT+gonoLRDEpE7ZA7egMNQeyHoI4RTbGzoi+2lg=;
 b=MEJKrOnShb7duiBT3UZyfQj4o9x58sJ7uAa0S0ZDfJ49Rq9kdEsENtM+PQz9DfeRLhnrUUabMl1SnSXmp9Ak8UL/SixesUTtWYP56GT1bMiauu+2NiWRo3eiIU0wtfSaQBbzI15AHR6JcGpAp7bZMQdLsmtP4RjuMOC15crUkZY=
Received: from MW4PR04CA0261.namprd04.prod.outlook.com (2603:10b6:303:88::26)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 19:53:14 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::26) by MW4PR04CA0261.outlook.office365.com
 (2603:10b6:303:88::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 19:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:12 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:11 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Austin Zheng
 <austin.zheng@amd.com>
Subject: [PATCH 08/17] drm/amd/display: Consider downspread against max clocks
 in DML2.1
Date: Wed, 26 Mar 2025 15:49:05 -0400
Message-ID: <20250326195202.17343-9-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e4bcd9-1a84-46c4-1e97-08dd6c9fd81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jQidrVTIXqxc7qhTtjxz2Kv5fEX3TmAnDmCLY/1mnmwVGLsmNhn07N4YcDJh?=
 =?us-ascii?Q?lk/ZAkaWIWTml/gZBjKcVsqSOUbxkeph6vjlEwZP2KEV/rQf36k1LRl5P/2r?=
 =?us-ascii?Q?kQGyUHmWTRB4R1Q4RDxrAEN8vvyIjE9vDliwNvl4v5FF89dCWG2QVlVu6qjJ?=
 =?us-ascii?Q?Dtd8e3uVWH28xc8Damhds7fJH9nGXT/ufoJeBxcvh4Dh4S0nh2bVw3ti8K8T?=
 =?us-ascii?Q?rijG2W9Y2+JSnTtkSyrP9R9aP3wvFNgmBg8jvWy6/V7eQml7BMk3VkhNJUEl?=
 =?us-ascii?Q?VLBtK9lJ3qoBZX1gSyQzJMXUOyrOvCx4EMF79/c7ksq/Vtb9Nl/R9PT1acGb?=
 =?us-ascii?Q?A+miceN9WrbknCV1WpN16nUUfJwUf8GWihx6nc8k94ChXtfIi3Y+jWjKqFuV?=
 =?us-ascii?Q?uODXqLpmjudY8SogzATUFeOdzF6GEHPgB/+hqQ0//mZxxPvv5XtmKBWsgYhy?=
 =?us-ascii?Q?7TY6v0/PXGZDyTi0JGltJAz6BnDeh6uLZ4DZTfwMr4NeIRMfVspU1JorTXu/?=
 =?us-ascii?Q?/ayymIHG4Pge2PwIWGkqFhmQBTpP5ODkGy9viFd/raJ53DoarzrPRvZkAIGV?=
 =?us-ascii?Q?iuvpT08shFSvKeAZc/y2FLF6rwObrYD2sZr3crzgLaq/W+NZshMoku2RgueR?=
 =?us-ascii?Q?KqFgSo8fmjMJipvfM3t/OiI0ocLKGfKica+Ztv8Ijkj3Hat4sw5AF0bFdd0O?=
 =?us-ascii?Q?cxsAUNHH9w3+M3AcD2+AJReZS6TTA+zp/HNej1TusNQfXtu6HrsWANdqUsM5?=
 =?us-ascii?Q?fi2HhESKxZyVD3EM15n7fc7mkrtrdQesMtfep94kD8p8USvHgwcHHpTDbklu?=
 =?us-ascii?Q?/vwjMOYdA81xcLi9kkfec4Y63d1z7fO6bvibOxbC2tVYX23uZD88/Cl2Elg7?=
 =?us-ascii?Q?gzMe5517hZssjvRutr/JQpjAiUY8t0dB9cMzhqi6dKcaIP0HAU8c3AU0uo7/?=
 =?us-ascii?Q?Hb82sIw3Be1lCawUtsdlGZlh7Tarsl1sA3o/KcuuihQvXevQammio5RuXBob?=
 =?us-ascii?Q?+VkE0p8SvVMN8NXcix4hTrDy3x5esAW23IOh8lJn47Ipi9CXjBt7yAe9N3Wj?=
 =?us-ascii?Q?3TjmKOaOFwrPvotz8sbf754XyIFkdhemutJig4MANxE0WWRo0t8MreGAsLyS?=
 =?us-ascii?Q?zzMXaX2mPpl2ixuWyaCMKyQA1NIBqHNkPn3nQL9Rutcr2l6B17DwuKyScWdd?=
 =?us-ascii?Q?ILS9ML1mHMlT9xkPLBHLFGRyahd6n2uEUyWdBiA4zUcxrhS8vR2etQCS95bx?=
 =?us-ascii?Q?C8n/nE4hgv3JsxXuldEFQ6kKzPN0utq4Z4zRaN8OFftjHj2A1/P70GO06n3F?=
 =?us-ascii?Q?/IfN16H8VExHkgWGuW9WpgNuhsSP/Dt1+LEsOewtBfVmpRSGnfQsRhIKFwqm?=
 =?us-ascii?Q?W4iDxxerYCmoUgmHY7L2YL0eh4/onq9d6o08xA34LqFkTe7BXf4Ku5nqp1Jz?=
 =?us-ascii?Q?ChE+U5vf8m+ijHIu3CiSFQPRnjz4zrn/Jnr/1mfeiqHxbr+8EW5/fYCme6sH?=
 =?us-ascii?Q?ThiJ73OzvO1IJoI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:13.6171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e4bcd9-1a84-46c4-1e97-08dd6c9fd81b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Core should evaluate support based on the max clocks after considering
downspread.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 6 +++---
 .../amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.c  | 4 ++++
 .../dc/dml2/dml21/src/inc/dml2_internal_shared_types.h      | 6 ++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 5d91f195397a..a27409464616 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7299,9 +7299,9 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	mode_lib->ms.FabricClock = ((double)min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].min_fclk_khz / 1000);
 	mode_lib->ms.MaxDCFCLK = (double)min_clk_table->max_clocks_khz.dcfclk / 1000;
 	mode_lib->ms.MaxFabricClock = (double)min_clk_table->max_clocks_khz.fclk / 1000;
-	mode_lib->ms.max_dispclk_freq_mhz = (double)min_clk_table->max_clocks_khz.dispclk / 1000;
+	mode_lib->ms.max_dispclk_freq_mhz = (double)min_clk_table->max_ss_clocks_khz.dispclk / 1000;
 	mode_lib->ms.max_dscclk_freq_mhz = (double)min_clk_table->max_clocks_khz.dscclk / 1000;
-	mode_lib->ms.max_dppclk_freq_mhz = (double)min_clk_table->max_clocks_khz.dppclk / 1000;
+	mode_lib->ms.max_dppclk_freq_mhz = (double)min_clk_table->max_ss_clocks_khz.dppclk / 1000;
 	mode_lib->ms.uclk_freq_mhz = dram_bw_kbps_to_uclk_mhz(min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].pre_derate_dram_bw_kbps, &mode_lib->soc.clk_table.dram_config);
 	mode_lib->ms.dram_bw_mbps = ((double)min_clk_table->dram_bw_table.entries[in_out_params->min_clk_index].pre_derate_dram_bw_kbps / 1000);
 	mode_lib->ms.max_dram_bw_mbps = ((double)min_clk_table->dram_bw_table.entries[min_clk_table->dram_bw_table.num_entries - 1].pre_derate_dram_bw_kbps / 1000);
@@ -8061,7 +8061,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 				display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.audio_sample_rate,
 				display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.audio_sample_layout);
 
-			if (mode_lib->ms.RequiredDTBCLK[k] > ((double)min_clk_table->max_clocks_khz.dtbclk / 1000)) {
+			if (mode_lib->ms.RequiredDTBCLK[k] > ((double)min_clk_table->max_ss_clocks_khz.dtbclk / 1000)) {
 				mode_lib->ms.support.DTBCLKRequiredMoreThanSupported = true;
 			}
 		} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
index f4b1a7d02d42..a265f254152c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
@@ -182,6 +182,10 @@ static bool build_min_clock_table(const struct dml2_soc_bb *soc_bb, struct dml2_
 	min_table->max_clocks_khz.dtbclk = soc_bb->clk_table.dtbclk.clk_values_khz[soc_bb->clk_table.dtbclk.num_clk_values - 1];
 	min_table->max_clocks_khz.phyclk = soc_bb->clk_table.phyclk.clk_values_khz[soc_bb->clk_table.phyclk.num_clk_values - 1];
 
+	min_table->max_ss_clocks_khz.dispclk = (unsigned int)((double)min_table->max_clocks_khz.dispclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
+	min_table->max_ss_clocks_khz.dppclk = (unsigned int)((double)min_table->max_clocks_khz.dppclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
+	min_table->max_ss_clocks_khz.dtbclk = (unsigned int)((double)min_table->max_clocks_khz.dtbclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
+
 	min_table->max_clocks_khz.dcfclk = soc_bb->clk_table.dcfclk.clk_values_khz[soc_bb->clk_table.dcfclk.num_clk_values - 1];
 	min_table->max_clocks_khz.fclk = soc_bb->clk_table.fclk.clk_values_khz[soc_bb->clk_table.fclk.num_clk_values - 1];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
index d8d01dceacdd..00688b9f1df4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h
@@ -37,6 +37,12 @@ struct dml2_mcg_min_clock_table {
 		unsigned int dcfclk;
 	} max_clocks_khz;
 
+	struct {
+		unsigned int dispclk;
+		unsigned int dppclk;
+		unsigned int dtbclk;
+	} max_ss_clocks_khz;
+
 	struct {
 		unsigned int dprefclk;
 		unsigned int xtalclk;
-- 
2.43.0

