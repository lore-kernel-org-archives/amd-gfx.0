Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45BAC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C2810F6C4;
	Thu,  9 Jul 2026 21:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WdVkUobY";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16EB210F6C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO9BhVHzJGTKdP3bNwKY7L0pQQffWy+VBhBizn++HYDVM9ocRcQ/Qx1I1nwjtB8J5zpPmIyuhnMFvlCpqSSSJIDROzo2WAYDg+nerl8RgKVcnJVRQEMyeKrkHIz5uXAhuru9I0PlRvcomvkyW09yAwfCGKhKyKilq4K+ggF4cPogX6I6jpumLFkjNqWAWsaUtNMPDTaypcmBpry34NM+5aAQ6ONUKOymoI1ICNM6v+nTBakhfFIHz2ufVihFMeyHPL91hYhiOLe4dEG2q8QoFmBA0SrPYiyHK9fYG4EKiErQEPkjS+L2w38VXadG4U6Qq10beVopuLkrlJU4PngLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6U+hgPEIqSkCsp521gGgVSevThoWtabk9j2B5SjVlY=;
 b=cxLLlsi8VbGkiXuhg5DbDCI+N6/NwTOYtRaNWJWZsTAATi3uXuyI9jVs7gtmmOF107PD9eMqwaXw2fNd71u6elBBJRNvvCQknSoWAywzE+OhiNZ49E5qUjQ7NFyLU6a9K3mhloFXSLYCnRwWatCYVahXd4IeuCMp6730XmhMo932d4Gv/x7zkCurI1hQiyGMHLpajz4kPxHhTfrlevUayXh4alRIFP0hP0+pm5kEX5Tq6DIcrHA8zgOyYnM2xrPyuQLJVCgdeC1D+iqefgXJX2kCrp0yn+JjDMkBCQuqKYtBoEchJsX5OB7UUN01FuO5yJuVJggnGqWAdX/fugePSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6U+hgPEIqSkCsp521gGgVSevThoWtabk9j2B5SjVlY=;
 b=WdVkUobYh9Qw2uLGExpTF1BszzBQNScsXZ1CrVyJAxZt2YZEEoGa8pH89gCnHn8l6rQAmeKAilPC/x7xc9vdZbqCCMJ92YmGGErsNXElKWUgrh0ECbILiKY9b+qZwr9zy30kx4Jd+sxsAvWPwgf1V7kaSyea5omERiFW8tmKokg=
Received: from SA9PR11CA0007.namprd11.prod.outlook.com (2603:10b6:806:6e::12)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:01:46 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::aa) by SA9PR11CA0007.outlook.office365.com
 (2603:10b6:806:6e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 9
 Jul 2026 21:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:45 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:37 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Ovidiu
 (Ovi) Bunea" <ovidiu.bunea@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 06/80] drm/amd/display: Fix DCN42B null registers & register
 masks
Date: Thu, 9 Jul 2026 16:47:34 -0400
Message-ID: <20260709205936.5719-7-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 11758fd4-b192-4d09-baa8-08deddfd4949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|22082099003|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: Sj8npii8j9DrqCICx4TcOntftd3EEZSDTeGa/Lx2V/gzX4NFhSF8r8WjRaL+99D6iPKjTeR6Vc//pX5LYjJikCOfpk3FUV6qCQtxp66LNWNHWpVuKDrh0WUtTMTBpc9RNUjkG/+N+vyedyrlNMFpjyF6ovidSVrw54DiMZVXE55iw1sFC1xAwD4J6MKbyGHPC+b++8vdQjBWaH7DeRqLZ2jlo8/jiirVcuvkntCKM/GetYYnUTgagEQSq7Bq/QFJHsASUDxMtyAIa7/pRoxjGO4YCmwWTRH6FudMGf7NYed28JPan/9eTCnbWW2tF9SpaUayQ6MkmY8x0FzOTqMdvNicCreGOcjAm45w7G192zzTqwqggUHU/sZDxADRnHwtvzqVixAduWv4bNW+RuFg1FqzFzQhX30Tq9XCulGkLLezty91vk00hkBh6Pi1rkX9CgpXeCBllrP76dT7sdhR5kBxOTKoQjxvsmXQj2uJyAEa8TW0ERTpnTEbP8JYGFS2Zx7OGbcWro0ytRGHPCP07HPnldOxkdelbFVDnb+IwKrRpHyRrmWf62oSJXEFqJ2M8LbD5+9+/DF6tzbRTffiqh+RUblnNWv9ct0tgoRJIUMAegJgoUd+z5IfOpp7exKgx8ml+nqfVXCGrFk1Jwu49sRKjQXfRLKszmTyThn7sBoyqC7JmL+fBR0irJgWN6z7jVIxM9qytmBOyhkydDBY+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(22082099003)(18002099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sW4lWZnIuxLEaHJ4xIoU96ICl6sPV0FXAnydTL3nJc+4pwhCDJzhlJhE7de1C5L5hISCoT0Pi3C5p0Nv3DR14cb+wGbSO75rUvt7/tgIzqKOAd1Z7GTgTtBkFsu1dQr1H96r/ECpy47FlLaXo+395PCtHo7KalN6I7G8ESqEaN6eI6MSIIJZyWV0ILfnjazttJuX5DX4cm+XBAqGEIHjvmwUnHrGJ0TpyIDvuXOSUJIu5cfuaEQzc65NHZHk4PgE12Bd3zlyWtCqW4IRDQxem5JnWcFlnWogxc+SDa3GVJ3qLISSf1m8rYybZmJi56yBbcFfKZslZVTHGlSXOpX0303Ljqc2NapVqw6dz5LcXqJ6VGWwhmLcwp/Yn8vNcVhY/7XgtVD25kVX2OQAf//CA21TTkHsgxMWKRmTptPta9sE1c2Cdt+amJO6dxIwXVAP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:45.7699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11758fd4-b192-4d09-baa8-08deddfd4949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[why]

DCN42B is missing some register masks, which are causing errors in dmesg.

[how]

Make DCN42B reuse the DCN42 register lists, and add the missing defines manually.

Fixes: 620081faa027 ("drm/amd/display: Fix DCN42 null registers & register masks")
Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../dc/resource/dcn42b/dcn42b_resource.c      |  20 ++-
 .../dc/resource/dcn42b/dcn42b_resource.h      | 116 +-----------------
 2 files changed, 20 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 1bc2452b271f..18a7fd9136af 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -22,6 +22,7 @@
 #include "dcn35/dcn35_resource.h"
 #include "dcn321/dcn321_resource.h"
 #include "dcn401/dcn401_resource.h"
+#include "dcn42/dcn42_resource.h"
 #include "dcn42/dcn42_resource_fpu.h"

 #include "dcn10/dcn10_ipp.h"
@@ -116,6 +117,23 @@
 #define regAPG9_APG_DBG_GEN_CONTROL             0x38ae
 #define regAPG9_APG_DBG_GEN_CONTROL_BASE_IDX    2

+#define regHUBP0_HUBPREQ_DEBUG_DB             0x05f8
+#define regHUBP0_HUBPREQ_DEBUG_DB_BASE_IDX    2
+#define regHUBP0_HUBPREQ_DEBUG                0x05f9
+#define regHUBP0_HUBPREQ_DEBUG_BASE_IDX       2
+#define regHUBP1_HUBPREQ_DEBUG_DB             0x06d4
+#define regHUBP1_HUBPREQ_DEBUG_DB_BASE_IDX    2
+#define regHUBP1_HUBPREQ_DEBUG                0x06d5
+#define regHUBP1_HUBPREQ_DEBUG_BASE_IDX       2
+#define regHUBP2_HUBPREQ_DEBUG_DB             0x07b0
+#define regHUBP2_HUBPREQ_DEBUG_DB_BASE_IDX    2
+#define regHUBP2_HUBPREQ_DEBUG                0x07b1
+#define regHUBP2_HUBPREQ_DEBUG_BASE_IDX       2
+#define regHUBP3_HUBPREQ_DEBUG_DB             0x088c
+#define regHUBP3_HUBPREQ_DEBUG_DB_BASE_IDX    2
+#define regHUBP3_HUBPREQ_DEBUG                0x088d
+#define regHUBP3_HUBPREQ_DEBUG_BASE_IDX       2
+
 enum dcn401_clk_src_array_id {
 	DCN401_CLK_SRC_PLL0,
 	DCN401_CLK_SRC_PLL1,
@@ -461,7 +479,7 @@ static const struct dcn_optc_mask optc_mask = {
 	OPTC_COMMON_MASK_SH_LIST_DCN42B(_MASK)};

 #define hubp_regs_init(id) \
-	HUBP_REG_LIST_DCN42B_RI(id)
+	HUBP_REG_LIST_DCN42_RI(id)

 static struct dcn_hubp2_registers hubp_regs[4];

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
index 2da3e3c8304a..2824a0e1acc9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
@@ -344,7 +344,6 @@
  *  DCCG_SRII(PHASE, DP_DTO, 3),
  *  DCCG_SRII(MODULO, DP_DTO, 3),
  *	SR(DSCCLK3_DTO_PARAM),
- *	SR(HDMISTREAMCLK_CNTL),
  *  SR(SYMCLKD_CLOCK_ENABLE),
  *  SR(SYMCLKE_CLOCK_ENABLE)
  */
@@ -360,6 +359,7 @@
 	SR(PHYBSYMCLK_CLOCK_CNTL), \
 	SR(PHYCSYMCLK_CLOCK_CNTL), \
 	SR(DPSTREAMCLK_CNTL), \
+	SR(HDMISTREAMCLK_CNTL), \
 	SR(SYMCLK32_SE_CNTL), \
 	SR(SYMCLK32_LE_CNTL), \
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 0), \
@@ -542,120 +542,6 @@
 		SRI_ARR(DC_ABM1_ACE_OFFSET_SLOPE_DATA, ABM, id),        \
 		SRI_ARR(DC_ABM1_ACE_PWL_CNTL, ABM, id)

-/* HUBP */
-/* Not in DCN42B: HUBPREQ_DEBUG_DB and HUBPREQ_DEBUG */
-#define HUBP_REG_LIST_DCN42B_RI(id)                                         \
-	SRI_ARR(DCN_DMDATA_VM_CNTL, HUBPREQ, id),                               \
-	SRI_ARR(FLIP_PARAMETERS_3, HUBPREQ, id),                               \
-	SRI_ARR(FLIP_PARAMETERS_4, HUBPREQ, id),                               \
-	SRI_ARR(FLIP_PARAMETERS_5, HUBPREQ, id),                               \
-	SRI_ARR(FLIP_PARAMETERS_6, HUBPREQ, id),                               \
-	SRI_ARR(VBLANK_PARAMETERS_5, HUBPREQ, id),                             \
-	SRI_ARR(VBLANK_PARAMETERS_6, HUBPREQ, id),                             \
-	HUBP_REG_LIST_DCN_VM_RI(id),                                            \
-	SRI_ARR(PREFETCH_SETTINGS, HUBPREQ, id),                               \
-	SRI_ARR(PREFETCH_SETTINGS_C, HUBPREQ, id),                             \
-	SRI_ARR(DCN_VM_SYSTEM_APERTURE_LOW_ADDR, HUBPREQ, id),                 \
-	SRI_ARR(DCN_VM_SYSTEM_APERTURE_HIGH_ADDR, HUBPREQ, id),                \
-	SRI_ARR(CURSOR_SETTINGS, HUBPREQ, id),                                 \
-	SRI_ARR(CURSOR_SURFACE_ADDRESS_HIGH, CURSOR0_, id),                    \
-	SRI_ARR(CURSOR_SURFACE_ADDRESS, CURSOR0_, id),                         \
-	SRI_ARR(CURSOR_SIZE, CURSOR0_, id),                                    \
-	SRI_ARR(CURSOR_CONTROL, CURSOR0_, id),                                 \
-	SRI_ARR(CURSOR_POSITION, CURSOR0_, id),                                \
-	SRI_ARR(CURSOR_HOT_SPOT, CURSOR0_, id),                                \
-	SRI_ARR(CURSOR_DST_OFFSET, CURSOR0_, id),                              \
-	SRI_ARR(DMDATA_ADDRESS_HIGH, CURSOR0_, id),                            \
-	SRI_ARR(DMDATA_ADDRESS_LOW, CURSOR0_, id),                             \
-	SRI_ARR(DMDATA_CNTL, CURSOR0_, id),                                    \
-	SRI_ARR(DMDATA_SW_CNTL, CURSOR0_, id),                                 \
-	SRI_ARR(DMDATA_QOS_CNTL, CURSOR0_, id),                                \
-	SRI_ARR(DMDATA_SW_DATA, CURSOR0_, id),                                 \
-	SRI_ARR(DMDATA_STATUS, CURSOR0_, id),                                  \
-	SRI_ARR(FLIP_PARAMETERS_0, HUBPREQ, id),                               \
-	SRI_ARR(FLIP_PARAMETERS_1, HUBPREQ, id),                               \
-	SRI_ARR(FLIP_PARAMETERS_2, HUBPREQ, id),                               \
-	SRI_ARR(DCN_CUR1_TTU_CNTL0, HUBPREQ, id),                              \
-	SRI_ARR(DCN_CUR1_TTU_CNTL1, HUBPREQ, id),                              \
-	SRI_ARR(DCSURF_FLIP_CONTROL2, HUBPREQ, id),                            \
-	SRI_ARR(VMID_SETTINGS_0, HUBPREQ, id),                                 \
-	SRI_ARR(DCHUBP_CNTL, HUBP, id),                                        \
-	SRI_ARR(DCSURF_ADDR_CONFIG, HUBP, id),                                 \
-	SRI_ARR(DCSURF_TILING_CONFIG, HUBP, id),                               \
-	SRI_ARR(DCSURF_SURFACE_PITCH, HUBPREQ, id),                            \
-	SRI_ARR(DCSURF_SURFACE_PITCH_C, HUBPREQ, id),                          \
-	SRI_ARR(DCSURF_SURFACE_CONFIG, HUBP, id),                              \
-	SRI_ARR(DCSURF_FLIP_CONTROL, HUBPREQ, id),                             \
-	SRI_ARR(DCSURF_PRI_VIEWPORT_DIMENSION, HUBP, id),                      \
-	SRI_ARR(DCSURF_PRI_VIEWPORT_START, HUBP, id),                          \
-	SRI_ARR(DCSURF_SEC_VIEWPORT_DIMENSION, HUBP, id),                      \
-	SRI_ARR(DCSURF_SEC_VIEWPORT_START, HUBP, id),                          \
-	SRI_ARR(DCSURF_PRI_VIEWPORT_DIMENSION_C, HUBP, id),                    \
-	SRI_ARR(DCSURF_PRI_VIEWPORT_START_C, HUBP, id),                        \
-	SRI_ARR(DCSURF_SEC_VIEWPORT_DIMENSION_C, HUBP, id),                    \
-	SRI_ARR(DCSURF_SEC_VIEWPORT_START_C, HUBP, id),                        \
-	SRI_ARR(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, HUBPREQ, id),             \
-	SRI_ARR(DCSURF_PRIMARY_SURFACE_ADDRESS, HUBPREQ, id),                  \
-	SRI_ARR(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH, HUBPREQ, id),           \
-	SRI_ARR(DCSURF_SECONDARY_SURFACE_ADDRESS, HUBPREQ, id),                \
-	SRI_ARR(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH, HUBPREQ, id),        \
-	SRI_ARR(DCSURF_PRIMARY_META_SURFACE_ADDRESS, HUBPREQ, id),             \
-	SRI_ARR(DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH, HUBPREQ, id),      \
-	SRI_ARR(DCSURF_SECONDARY_META_SURFACE_ADDRESS, HUBPREQ, id),           \
-	SRI_ARR(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C, HUBPREQ, id),           \
-	SRI_ARR(DCSURF_PRIMARY_SURFACE_ADDRESS_C, HUBPREQ, id),                \
-	SRI_ARR(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH_C, HUBPREQ, id),         \
-	SRI_ARR(DCSURF_SECONDARY_SURFACE_ADDRESS_C, HUBPREQ, id),              \
-	SRI_ARR(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C, HUBPREQ, id),      \
-	SRI_ARR(DCSURF_PRIMARY_META_SURFACE_ADDRESS_C, HUBPREQ, id),           \
-	SRI_ARR(DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH_C, HUBPREQ, id),    \
-	SRI_ARR(DCSURF_SECONDARY_META_SURFACE_ADDRESS_C, HUBPREQ, id),         \
-	SRI_ARR(DCSURF_SURFACE_INUSE, HUBPREQ, id),                            \
-	SRI_ARR(DCSURF_SURFACE_INUSE_HIGH, HUBPREQ, id),                       \
-	SRI_ARR(DCSURF_SURFACE_INUSE_C, HUBPREQ, id),                          \
-	SRI_ARR(DCSURF_SURFACE_INUSE_HIGH_C, HUBPREQ, id),                     \
-	SRI_ARR(DCSURF_SURFACE_EARLIEST_INUSE, HUBPREQ, id),                   \
-	SRI_ARR(DCSURF_SURFACE_EARLIEST_INUSE_HIGH, HUBPREQ, id),              \
-	SRI_ARR(DCSURF_SURFACE_EARLIEST_INUSE_C, HUBPREQ, id),                 \
-	SRI_ARR(DCSURF_SURFACE_EARLIEST_INUSE_HIGH_C, HUBPREQ, id),            \
-	SRI_ARR(DCSURF_SURFACE_CONTROL, HUBPREQ, id),                          \
-	SRI_ARR(DCSURF_SURFACE_FLIP_INTERRUPT, HUBPREQ, id),                   \
-	SRI_ARR(HUBPRET_CONTROL, HUBPRET, id),                                 \
-	SRI_ARR(HUBPRET_READ_LINE_STATUS, HUBPRET, id),                        \
-	SRI_ARR(DCN_EXPANSION_MODE, HUBPREQ, id),                              \
-	SRI_ARR(DCHUBP_REQ_SIZE_CONFIG, HUBP, id),                             \
-	SRI_ARR(DCHUBP_REQ_SIZE_CONFIG_C, HUBP, id),                           \
-	SRI_ARR(BLANK_OFFSET_0, HUBPREQ, id),                                  \
-	SRI_ARR(BLANK_OFFSET_1, HUBPREQ, id),                                  \
-	SRI_ARR(DST_DIMENSIONS, HUBPREQ, id),                                  \
-	SRI_ARR(DST_AFTER_SCALER, HUBPREQ, id),                                \
-	SRI_ARR(VBLANK_PARAMETERS_0, HUBPREQ, id),                             \
-	SRI_ARR(REF_FREQ_TO_PIX_FREQ, HUBPREQ, id),                            \
-	SRI_ARR(VBLANK_PARAMETERS_1, HUBPREQ, id),                             \
-	SRI_ARR(VBLANK_PARAMETERS_3, HUBPREQ, id),                             \
-	SRI_ARR(NOM_PARAMETERS_4, HUBPREQ, id),                                \
-	SRI_ARR(NOM_PARAMETERS_5, HUBPREQ, id),                                \
-	SRI_ARR(PER_LINE_DELIVERY_PRE, HUBPREQ, id),                           \
-	SRI_ARR(PER_LINE_DELIVERY, HUBPREQ, id),                               \
-	SRI_ARR(VBLANK_PARAMETERS_2, HUBPREQ, id),                             \
-	SRI_ARR(VBLANK_PARAMETERS_4, HUBPREQ, id),                             \
-	SRI_ARR(NOM_PARAMETERS_6, HUBPREQ, id),                                \
-	SRI_ARR(NOM_PARAMETERS_7, HUBPREQ, id),                                \
-	SRI_ARR(DCN_TTU_QOS_WM, HUBPREQ, id),                                  \
-	SRI_ARR(DCN_GLOBAL_TTU_CNTL, HUBPREQ, id),                             \
-	SRI_ARR(DCN_SURF0_TTU_CNTL0, HUBPREQ, id),                             \
-	SRI_ARR(DCN_SURF0_TTU_CNTL1, HUBPREQ, id),                             \
-	SRI_ARR(DCN_SURF1_TTU_CNTL0, HUBPREQ, id),                             \
-	SRI_ARR(DCN_SURF1_TTU_CNTL1, HUBPREQ, id),                             \
-	SRI_ARR(DCN_CUR0_TTU_CNTL0, HUBPREQ, id),                              \
-	SRI_ARR(DCN_CUR0_TTU_CNTL1, HUBPREQ, id),                              \
-	SRI_ARR(HUBP_CLK_CNTL, HUBP, id),                                      \
-	SRI_ARR(HUBPRET_READ_LINE_VALUE, HUBPRET, id),                         \
-	SRI_ARR(DCHUBP_MALL_CONFIG, HUBP, id),                                 \
-	SRI_ARR(DCHUBP_VMPG_CONFIG, HUBP, id),                                 \
-	SRI_ARR(UCLK_PSTATE_FORCE, HUBPREQ, id),                               \
-	SRI_ARR(HUBP_3DLUT_DLG_PARAM, CURSOR0_, id),                           \
-	HUBP_3DLUT_FL_REG_LIST_DCN401(id)
 struct dcn42b_resource_pool {
 	struct resource_pool base;
 };
--
2.55.0

