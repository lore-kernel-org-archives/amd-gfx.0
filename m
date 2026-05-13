Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694BCCD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADCB10EECF;
	Wed, 13 May 2026 14:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vzd1DPei";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 220CD10EEDB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTuoytjGPdkoegAsTv6Mr+jAZPWNnJp0RqS97ISrXSnWBMmD1hXaR4xhDxHkIPLGm4R/6b3m+hqJWYd3gXwv31TdgpKqAPk5LnCfhmXqWPjZJ7DahzaIBvhWsKknjscfHllkKjxuw7klMq5aMznXks7xaD0GcXQU7HZ+98+l3XqGPYPlWdIjRko7F3zGaMsQNP1BFPt0eUpkQDTrHVZhPl12L6ve/g7H/RaUOuJBJ/8b/oPoNiC3Ss0PPB0WMoOLuyNo3hZIVOe4gYI+bRw2B0SefAAWLY01oKnjFVMWnwG9VYHOMZ+6KgBuPItM2nZ+ZBt6kE2vrp1I+omgYhrBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+ZRgzIhMCyyO+IyHQ0sY2K4vwd4a5S6KTvpN7n6UN0=;
 b=JXXFgS5p/6mbLFGVpITH5wClhfRuzCVsyG8dK0CZTJrJ0JWIYxRgq71H+BiCALxf5Pt9shl23i0U5NIBwufHlQF5LiA8RunL/XnKTTrLzTStRyzQIrFyq4HgywQn0Vyccfb6iv03rKsXhzLg976Zl4YlteEfTDspCRBoiiHc/gwOuR5W0KJru/H5iX1xML8Ju2dds53BkleH36C04DC0dJ9x8O/3VRv1xxaQ449UsFRZ48hBX/Mz4hcbF8Zy0gYMNH3fS5jnm4wlVWHf5s3ZFQWwBGUr9o4PnZJg4Dz4KkMdWU1xA3IeryPs2tNN+nD2AIzBj4mj4wXOIZqAvWBgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+ZRgzIhMCyyO+IyHQ0sY2K4vwd4a5S6KTvpN7n6UN0=;
 b=Vzd1DPeiRO/vbjJsUa/7lcK72asF7obadgIJ4GN9PicuGlGFgxE492gj4qc33m9lVMAkgsFuvKQUfjlQVSqsZd6yaWzYyb2pk7iMM6sS2I1iv6nR7/VPQeH/q/ARJQ2uWCi1XI9iBZRNttj52iIuoWZ9H3JBoo9bhNHDMNPRL+Q=
Received: from BY3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:254::24)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:13 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::33) by BY3PR05CA0019.outlook.office365.com
 (2603:10b6:a03:254::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 14:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:10 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:32:54 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, ChiaHsuan Chung <ChiaHsuan.Chung@amd.com>, Roman Li
 <Roman.Li@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 01/28] drm/amd/display: Add some missing code for dcn42
Date: Wed, 13 May 2026 10:29:23 -0400
Message-ID: <20260513143213.1852892-3-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f505926-65ae-4f8f-edf7-08deb0fc8f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: 668zrB/ZV2W12XCWMpgwM9fa+SowZLTFdS26CLV3KcnwnkzcNd8WgVlAdwQO62kO/my1JwYKfmSY7U/b1AfRwK0h0Wq8FzzhHYSVDB0Qrlm7DlEmYPtlURB8AumpIk2zwrJtuL/C9TMKSyJtKisOgu8HqmgYy0YA9lQ+JT50EkIEUsuoqsH/qfu1LMFg+1fYDjPEOx/3/WnKrdSQHzHwIRuCU6KPgTGwbAkww5g8fi1pYBwsVXYBq+9R5O9wlpv+9s/kp/XnB0ycAPDyWEDvxG7kn1D8tI2InLGAwwI6N5e8viv1eo4l+bDx/T2Pl4k1Q3Inzs2uJqys13nukJdgw0pNzrT43DBl3OlqH/FFtS4tVy7Va4XXpU8tk/GYlji+EinjsFifIZNDEPBDz7RaDIV76QyFdMFUljY/nROfcgEuoWhrN4bmT3DD9yzxhM6bLwjCuqBnEOEWaFjT1w3BiR8/4KgrHzB7M0HEGPjrOfoiW7SOU0rNXXzPgZZ3AX+9GEU9OU17DcKdbR7sipHFE2WCcdBITz4xZPjSQI9t/oMk/Fb9enIwwhJorngwUXArQeFiRNk+Wlbw7bFvfFHmC8VYJmcammYJWuwe0jLCdQjWSEIBCCMhSanqTeOSYBlINVO2fm+nUr9ZSbeVd+WnbXtFAkrVz3y8OUBjTTBeP27Wi0MNdxIqe1VGmKRcZkCiR24bkgObQ9zORIYn4AQ0wBTR6gAfsMBFUN+uwhsbCYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3nO7uFwCxrInQEjfQ6i+LKxe9OjdRYXXiK4TN6WNppxhcVYfWuuDjINH+aiilx3feoMbSCkObo+VLKDzXQg3aOroCsSffTrPXgZcO2X3XxjsmsQ0emvP7mm8EEseRAxXyU0qFAyX3s5aWHlhwUFKa+9OngYENrV90P0lqg9tVGPtTFm+1YSsEsdZA4/yG1E9BrsUqjcp3aLgbDj4tdwql3xzYiBSa02rWi/D4jxSvXxMHR4rn3PGwG6hvE+K2KEPsNWvmuMMkzrcxc/Q44vdh9det62GDhOj3Umu21/HcEyCRAdgLAsJHr45xtnCr3UQugW9fBCh4EvQXlsg8KLgSbK1C6R3ku0MKGcz6qBHX8xqfml2LAT0R65+QmBZzTY7y8QoVKhYV7nNocKmwFidk8F2ePqMJn2hilujIlIk7lOmiTSy0yrAnT0Mth0OA9Ju
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:11.3871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f505926-65ae-4f8f-edf7-08deb0fc8f46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
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

From: James Lin <PingLei.Lin@amd.com>

[why & how]
Some DCN4.2 related code is missing from upstream

Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")
Acked-by: ChiaHsuan Chung <ChiaHsuan.Chung@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |  2 ++
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    |  5 +++--
 .../drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 10 ++++------
 .../drm/amd/display/dc/resource/dcn42/dcn42_resource.h |  7 +++++++
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index d856a7a807b1..d01e5969a670 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -309,6 +309,8 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
+	if (new_clocks->dppclk_khz < 100000)
+		new_clocks->dppclk_khz = 100000;
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index cbc20f214f9e..cabfac151940 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -470,9 +470,9 @@ static bool is_rmcm_3dlut_fl_supported(struct dc *dc, enum dc_cm2_gpu_mem_size s
 	if (!dc->caps.color.mpc.rmcm_3d_lut_caps.dma_3d_lut)
 		return false;
 	if (size == DC_CM2_GPU_MEM_SIZE_171717)
-		return (dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_17);
+		return dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_17 != 0u;
 	else if (size == DC_CM2_GPU_MEM_SIZE_333333)
-		return (dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_33);
+		return dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_33 != 0u;
 	return false;
 }
 
@@ -945,6 +945,7 @@ bool dcn42_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 void dcn42_hardware_release(struct dc *dc)
 {
 	dcn35_hardware_release(dc);
+	dc_dmub_srv_release_hw(dc);
 
 }
 static int count_active_streams(const struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 52a1996a654f..1fc457cec293 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1520,6 +1520,10 @@ static void dcn42_resource_destruct(struct dcn42_resource_pool *pool)
 
 	if (pool->base.pg_cntl != NULL)
 		dcn_pg_cntl_destroy(&pool->base.pg_cntl);
+
+	if (pool->base.replay != NULL)
+		dmub_replay_destroy(&pool->base.replay);
+
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
 
@@ -1921,12 +1925,6 @@ static bool dcn42_resource_construct(
 	dc->caps.max_v_total = (1 << 15) - 1;
 	dc->caps.vtotal_limited_by_fp2 = true;
 
-	dc->caps.seamless_odm = true;
-	dc->caps.zstate_support = true;
-	dc->caps.ips_support = true;
-	dc->caps.max_v_total = (1 << 15) - 1;
-	dc->caps.vtotal_limited_by_fp2 = true;
-
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
 	dc->caps.color.dpp.input_lut_shared = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
index 60acf0e423d9..fe960542d7bd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
@@ -456,6 +456,8 @@
 		SRI_ARR(OTG_V_SYNC_A, OTG, inst), \
 		SRI_ARR(OTG_V_SYNC_A_CNTL, OTG, inst), \
 		SRI_ARR(OTG_CONTROL, OTG, inst), \
+		SRI_ARR(OTG_MASTER_EN, OTG, inst), \
+		SRI_ARR(OTG_LONG_VBLANK_STATUS, OTG, inst), \
 		SRI_ARR(OTG_STEREO_CONTROL, OTG, inst), \
 		SRI_ARR(OTG_3D_STRUCTURE_CONTROL, OTG, inst),                            \
 		SRI_ARR(OTG_STEREO_STATUS, OTG, inst),                                   \
@@ -472,6 +474,11 @@
 		SRI_ARR(OTG_M_CONST_DTO0, OTG, inst),                                    \
 		SRI_ARR(OTG_M_CONST_DTO1, OTG, inst),                                    \
 		SRI_ARR(OTG_CLOCK_CONTROL, OTG, inst),                                   \
+		SRI_ARR(OTG_COUNT_CONTROL, OTG, inst),                                   \
+		SRI_ARR(OTG_COUNT_RESET, OTG, inst),                                   \
+		SRI_ARR(OTG_CRC_SIG_BLUE_CONTROL_MASK, OTG, inst),                      \
+		SRI_ARR(OTG_CRC_SIG_RED_GREEN_MASK, OTG, inst),                      \
+		SRI_ARR(OTG_DRR_TIMING_INT_STATUS, OTG, inst),                      \
 		SRI_ARR(OTG_VERTICAL_INTERRUPT0_CONTROL, OTG, inst),                     \
 		SRI_ARR(OTG_VERTICAL_INTERRUPT0_POSITION, OTG, inst),                    \
 		SRI_ARR(OTG_VERTICAL_INTERRUPT1_CONTROL, OTG, inst),                     \
-- 
2.43.0

