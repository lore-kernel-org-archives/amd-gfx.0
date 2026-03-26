Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF165109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F1110E93F;
	Thu, 26 Mar 2026 03:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e7EOsui0";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A819310E940
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sollBnccygQ2QCBAfCSEAGgXCI3oMabN9cNe8rHGcKdSt/mTqonxRCsOxbjTbTbIh3V4XYElxxJG8G4djXHGMlVZM3b9Zg1lQrPyqn+4UCIw6tAdVovDtMsllZmH/ciGNhz4T5MUA/kwsPRb5/HiW8N4vLk6Q+Sxr6WjzVy1dbyDGwWmyMqPBHn2/9cVRFCQ/QUhSX4ZQINswZqctGgUwJ93WVL9KUn+0cetDBuUP9KDvTPDmkxFR1YDzEM4UJtSjEbyVQ+h+NoAxZlnL8ya01zmtl2+6Y6Sv12NGxN9T7wwp/l+mae17HlBo/JJ40dadnQlEgiu0rBpHLsQiM9UyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0lUBOm1O/EYH68xJw9fk3OBop5kSewVQb+50Eh4fc4=;
 b=abzfupMgMYF5JuDSobnSkogCnJ2TK+WvoZJE59EKI7usd7rSY3MIALm8jxrCr4JP89PwedgVb5Q3/o0u9bEsg5xai6DgPemJN/0FSSe/7Z4kd47668WYfFmHss4BRkAves+ssyIiL+gSdDt/RgppJfUxnY5W6aEK+pN+r41fLo2Ng45+/ZfTnrOVX7U2DY+fEshBZb4jIITylzdBK2StrF6jMopgrtjeDgwEumw36vNRMumu9xY0PxqAC/s/CCUdYaAp/cZFYmQ0lv036Tleig62Q+Ec93ujrr4FO8Zt/9T9yVImy4E/6i0XDdy8r/JJmHVZusbu0Vrzt463hz9p4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0lUBOm1O/EYH68xJw9fk3OBop5kSewVQb+50Eh4fc4=;
 b=e7EOsui0goXzvWhL4htdkgGFLB544cQx3F+ksWX7y/DDogq1XSIN1QlFx5WY1SRaH9zkkjXU/+a2JoL4AtB1aL7hy9DSstYMspv/5X8IWkLJhihXV/CnFuSXFgqd+wsiI1WmCgrQMd2EkBmNyFVvIIdF2AZyp/i95DtAig9OLYI=
Received: from MN2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:208:239::35)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 26 Mar
 2026 03:02:05 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::34) by MN2PR08CA0030.outlook.office365.com
 (2603:10b6:208:239::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 03:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:02:05 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:59 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH v2 23/30] drm/amd/display: Move FPU Guards From DML To DC -
 Part 1
Date: Thu, 26 Mar 2026 10:57:14 +0800
Message-ID: <20260326030153.406612-24-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: ff67fb07-d3ee-486f-3706-08de8ae40fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9Fgy2126y5dNC00ofx9odM1a+tOkrVRxUg551ZXDV/dm9lHaBzKqBqoIK9DH/KERv2ehTgzUIRSweHe3V1ln2q/VkIzKnHto+bpDl6onRwvr5w8Az+uNCMHZmut+MQKUuKcIKrxoPOVrbFG4hDARrHOppiZar+HPRWbWEvIFb/TlvBafACkp8UANSmu2Fxr7mlN5t81TUN7E8sLNnpFP5zi8ADV3Ja5V8yarpdFBNQzYXyGTWxIG3jKA5zgUQ9oCRviwuUJcAgXDY8RqX5n1AbYDmdKbkI1YdE5Orpixk30iolCPf8/HLXd1EZCJlfd+inOiojbiCbDy0fVGW9c3fFdawXQoCPSzNvBJOAPjUKzbfpvXFQwJTRaYHMOFY54ovAWBTRBofL6yHIkDR/+wUGJ3o+CW7zwNwp0JYdEIho5NBxtc8NADXphl1p32NJ7qG96f+b5jajmDp8wVNlZJo+3VxRUSpfpHHXl4vBlPODTYgoOc64BmY2o9Zkw+CSigPzYKtRX8CRjtTWluUjEOU27AaHdKbjoyEPubppcYjDWmwGa/DP2cGRuPIJjm7yXy/0RjnnK9TExNnAOCT3Txhj0Uha8o05GRIu27PxBC5b+8Dioale4+5B1tRt0WcoLhaQRAuLPNXs6FWmm52lKRKHXCgWY51NTsFeCcgDtwIAwyZtxmjX9YeCSYxpQs0tqucwKZIaDoORxJeOQ/Ds6xv1a438Ejo78JhMSqnrk1U8hD3cZYybFGFb29Ixqfa9OlVH/g8JPc5hdltLsBO/JbLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xdN0ZQQn8f6wETCps4jY9d93959BydIkpYZDn1lFTRsOAeG5f76qYznhEWG0/mC7dQYHXZk5X7YAClT3f5BNuHrhSDsEyy4+zr1Kwc5OHWBNC9baz1A0ad+hLgSn1AwKU56M5ernOjBTR2UI7Nbyid1hm9BtwwtWpwnRdOx20iXi7RRgWQNcPz0yHTk6M8VKvUzdWOrRJyQnLTkC+/CGkGYcSMEP904uiqaFy7u3/7XKAbRXnbbb3yVVtkEQjrHUwnEHOAuGQFJVncTE40Rtt7tPZHxKD90dinuEyNowyrpVHXLdcFaO4T6DRAbGCn0DA+Wew1JHPlocp/cZnHMnlgmvMLRaCYVhq6p4lv6r2qPgPZGNfvxWDGOaUfwNcLNMX0LVQPgejQQKHT87W3WrIt/zpkQ92WXqiVLxdgL73w6yUI6F3L4bI4ggLlRLrzj0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:02:05.4675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff67fb07-d3ee-486f-3706-08de8ae40fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why]
FPU guards (DC_FP_START/DC_FP_END) are required to wrap around code that
can manipulates floats. To do this properly, the FPU guards must be used
in a file that is not compiled as a FPU unit. If the guards are used in
a file that is a FPU unit, other sections in the file that aren't guarded
may be end up being compiled to use FPU operations.

[How]
Added DC_FP_START and DC_FP_END to DC functions that call DML functions
using FPU.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 25 ++++++-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.h    | 17 ++++-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  2 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 75 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 13 +++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  3 +-
 .../dc/resource/dcn35/dcn35_resource.c        | 10 ++-
 .../dc/resource/dcn35/dcn35_resource.h        |  1 +
 .../dc/resource/dcn351/dcn351_resource.c      | 10 ++-
 .../dc/resource/dcn36/dcn36_resource.c        |  4 +-
 .../dc/resource/dcn401/dcn401_resource.c      | 30 ++++++--
 .../dc/resource/dcn42/dcn42_resource.c        | 25 +++++--
 14 files changed, 169 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index e46f8ce41d87..8ba9b4f56f87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -53,11 +53,30 @@ inline void dc_assert_fp_enabled(void)
 {
 	int depth;
 
-	depth = __this_cpu_read(fpu_recursion_depth);
+	depth = this_cpu_read(fpu_recursion_depth);
 
 	ASSERT(depth >= 1);
 }
 
+/**
+ * dc_assert_fp_enabled - Check if FPU protection is enabled
+ *
+ * This function tells if the code is already under FPU protection or not. A
+ * function that works as an API for a set of FPU operations can use this
+ * function for checking if the caller invoked it after DC_FP_START(). For
+ * example, take a look at dcn20_fpu.c file.
+ *
+ * Similar to dc_assert_fp_enabled, but does not assert, returns status instead.
+ */
+inline bool dc_is_fp_enabled(void)
+{
+	int depth;
+
+	depth = this_cpu_read(fpu_recursion_depth);
+
+	return (depth >= 1);
+}
+
 /**
  * dc_fpu_begin - Enables FPU protection
  * @function_name: A string containing the function name for debug purposes
@@ -77,7 +96,7 @@ void dc_fpu_begin(const char *function_name, const int line)
 
 	WARN_ON_ONCE(!in_task());
 	preempt_disable();
-	depth = __this_cpu_inc_return(fpu_recursion_depth);
+	depth = this_cpu_inc_return(fpu_recursion_depth);
 	if (depth == 1) {
 		BUG_ON(!kernel_fpu_available());
 		kernel_fpu_begin();
@@ -100,7 +119,7 @@ void dc_fpu_end(const char *function_name, const int line)
 {
 	int depth;
 
-	depth = __this_cpu_dec_return(fpu_recursion_depth);
+	depth = this_cpu_dec_return(fpu_recursion_depth);
 	if (depth == 0) {
 		kernel_fpu_end();
 	} else {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
index 4e921632bc4e..5e95419d3798 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
@@ -28,15 +28,30 @@
 #define __DC_FPU_H__
 
 void dc_assert_fp_enabled(void);
+bool dc_is_fp_enabled(void);
 void dc_fpu_begin(const char *function_name, const int line);
 void dc_fpu_end(const char *function_name, const int line);
 
 #ifndef _LINUX_FPU_COMPILATION_UNIT
 #define DC_FP_START()	dc_fpu_begin(__func__, __LINE__)
 #define DC_FP_END()	dc_fpu_end(__func__, __LINE__)
+#ifdef CONFIG_DRM_AMD_DC_FP
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) \
+	do { \
+		bool dc_fp_enabled = dc_is_fp_enabled(); \
+		if (dc_fp_enabled) \
+			DC_FP_END(); \
+		code; \
+		if (dc_fp_enabled) \
+			DC_FP_START(); \
+	} while (0)
+#else
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif // !CONFIG_DRM_AMD_DC_FP
 #else
 #define DC_FP_START()	BUILD_BUG()
 #define DC_FP_END()	BUILD_BUG()
-#endif
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif // !_LINUX_FPU_COMPILATION_UNIT
 
 #endif /* __DC_FPU_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index f2a716e1e732..4ad09b877b6e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -421,10 +421,8 @@ static void dcn3_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 	clk_mgr_base->bw_params->dc_mode_softmax_memclk = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_UCLK);
 
 	/* Refresh bounding box */
-	DC_FP_START();
 	clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
 			clk_mgr->base.ctx->dc, clk_mgr_base->bw_params);
-	DC_FP_END();
 }
 
 static bool dcn3_is_smu_present(struct clk_mgr *clk_mgr_base)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 7da7b41bd092..36d0c1e2014d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -1059,11 +1059,9 @@ static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 	if (!clk_mgr->dpm_present)
 		dcn32_patch_dpm_table(clk_mgr_base->bw_params);
 
-	DC_FP_START();
 	/* Refresh bounding box */
 	clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
 			clk_mgr->base.ctx->dc, clk_mgr_base->bw_params);
-	DC_FP_END();
 }
 
 static bool dcn32_are_clock_states_equal(struct dc_clocks *a,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e55ffdade662..2f938379aec7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1096,11 +1096,8 @@ static bool dc_construct(struct dc *dc,
 #ifdef CONFIG_DRM_AMD_DC_FP
 	dc->clk_mgr->force_smu_not_present = init_params->force_smu_not_present;
 
-	if (dc->res_pool->funcs->update_bw_bounding_box) {
-		DC_FP_START();
+	if (dc->res_pool->funcs->update_bw_bounding_box)
 		dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
-		DC_FP_END();
-	}
 	dc->soc_and_ip_translator = dc_create_soc_and_ip_translator(dc_ctx->dce_version);
 	if (!dc->soc_and_ip_translator)
 		goto fail;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 2de8ef4a58ec..4b2d5a174fa9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -205,19 +205,33 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 	state->power_source = params ? params->power_source : DC_POWER_SOURCE_AC;
 
 #ifdef CONFIG_DRM_AMD_DC_FP
+	bool status;
+
 	if (dc->debug.using_dml2) {
-		if (!dml2_create(dc, &dc->dml2_options, &state->bw_ctx.dml2)) {
+		DC_FP_START();
+		status = dml2_create(dc, &dc->dml2_options, &state->bw_ctx.dml2);
+		DC_FP_END();
+
+		if (!status) {
 			dc_state_release(state);
 			return NULL;
 		}
 
-		if (dc->caps.dcmode_power_limits_present && !dml2_create(dc, &dc->dml2_dc_power_options, &state->bw_ctx.dml2_dc_power_source)) {
-			dc_state_release(state);
-			return NULL;
+		if (dc->caps.dcmode_power_limits_present) {
+			bool status;
+
+			DC_FP_START();
+			status = dml2_create(dc, &dc->dml2_dc_power_options, &state->bw_ctx.dml2_dc_power_source);
+			DC_FP_END();
+
+			if (!status) {
+				dc_state_release(state);
+				return NULL;
+			}
 		}
-	}
-#endif
 
+	}
+#endif // CONFIG_DRM_AMD_DC_FP
 	kref_init(&state->refcount);
 
 	return state;
@@ -235,14 +249,20 @@ void dc_state_copy(struct dc_state *dst_state, struct dc_state *src_state)
 
 #ifdef CONFIG_DRM_AMD_DC_FP
 	dst_state->bw_ctx.dml2 = dst_dml2;
-	if (src_state->bw_ctx.dml2)
+	if (src_state->bw_ctx.dml2) {
+		DC_FP_START();
 		dml2_copy(dst_state->bw_ctx.dml2, src_state->bw_ctx.dml2);
+		DC_FP_END();
+	}
 
 	dst_state->bw_ctx.dml2_dc_power_source = dst_dml2_dc_power_source;
-	if (src_state->bw_ctx.dml2_dc_power_source)
-		dml2_copy(dst_state->bw_ctx.dml2_dc_power_source, src_state->bw_ctx.dml2_dc_power_source);
-#endif
 
+	if (src_state->bw_ctx.dml2_dc_power_source) {
+		DC_FP_START();
+		dml2_copy(dst_state->bw_ctx.dml2_dc_power_source, src_state->bw_ctx.dml2_dc_power_source);
+		DC_FP_END();
+	}
+#endif // CONFIG_DRM_AMD_DC_FP
 	/* context refcount should not be overridden */
 	dst_state->refcount = refcount;
 }
@@ -259,22 +279,35 @@ struct dc_state *dc_state_create_copy(struct dc_state *src_state)
 	dc_state_copy_internal(new_state, src_state);
 
 #ifdef CONFIG_DRM_AMD_DC_FP
+	bool status;
+
 	new_state->bw_ctx.dml2 = NULL;
 	new_state->bw_ctx.dml2_dc_power_source = NULL;
 
-	if (src_state->bw_ctx.dml2 &&
-			!dml2_create_copy(&new_state->bw_ctx.dml2, src_state->bw_ctx.dml2)) {
-		dc_state_release(new_state);
-		return NULL;
-	}
+	if (src_state->bw_ctx.dml2) {
+		DC_FP_START();
+		status = dml2_create_copy(&new_state->bw_ctx.dml2, src_state->bw_ctx.dml2);
+		DC_FP_END();
 
-	if (src_state->bw_ctx.dml2_dc_power_source &&
-			!dml2_create_copy(&new_state->bw_ctx.dml2_dc_power_source, src_state->bw_ctx.dml2_dc_power_source)) {
-		dc_state_release(new_state);
-		return NULL;
+		if (!status) {
+			dc_state_release(new_state);
+			return NULL;
+		}
 	}
-#endif
 
+
+	if (src_state->bw_ctx.dml2_dc_power_source) {
+		DC_FP_START();
+		status = dml2_create_copy(&new_state->bw_ctx.dml2_dc_power_source,
+					  src_state->bw_ctx.dml2_dc_power_source);
+		DC_FP_END();
+
+		if (!status) {
+			dc_state_release(new_state);
+			return NULL;
+		}
+	}
+#endif // CONFIG_DRM_AMD_DC_FP
 	kref_init(&new_state->refcount);
 
 	return new_state;
@@ -352,11 +385,13 @@ static void dc_state_free(struct kref *kref)
 	dc_state_destruct(state);
 
 #ifdef CONFIG_DRM_AMD_DC_FP
+	DC_FP_START();
 	dml2_destroy(state->bw_ctx.dml2);
 	state->bw_ctx.dml2 = 0;
 
 	dml2_destroy(state->bw_ctx.dml2_dc_power_source);
 	state->bw_ctx.dml2_dc_power_source = 0;
+	DC_FP_END();
 #endif
 
 	kvfree(state);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 87ecef6e699f..473fe959f5c7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -42,6 +42,13 @@
 #define MAX(x, y) ((x > y) ? x : y)
 #endif
 
+#include "dc_fpu.h"
+
+#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif // !DC_RUN_WITH_PREEMPTION_ENABLED
+
+
 /*******************************************************************************
  * Private functions
  ******************************************************************************/
@@ -170,12 +177,14 @@ struct dc_stream_state *dc_create_stream_for_sink(
 	if (sink == NULL)
 		goto fail;
 
-	stream = kzalloc(sizeof(struct dc_stream_state), GFP_ATOMIC);
+	DC_RUN_WITH_PREEMPTION_ENABLED(stream = kzalloc(sizeof(struct dc_stream_state), GFP_ATOMIC));
 
 	if (stream == NULL)
 		goto fail;
 
-	stream->update_scratch = kzalloc((int32_t) dc_update_scratch_space_size(), GFP_ATOMIC);
+	DC_RUN_WITH_PREEMPTION_ENABLED(stream->update_scratch =
+					kzalloc((int32_t) dc_update_scratch_space_size(),
+						GFP_ATOMIC));
 
 	if (stream->update_scratch == NULL)
 		goto fail;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index a11dd9dd703b..f28a522ea6cd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -363,8 +363,7 @@ void dcn401_init_hw(struct dc *dc)
 			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
 			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
 			if (dc->clk_mgr)
-				dc->res_pool->funcs->update_bw_bounding_box(dc,
-									    dc->clk_mgr->bw_params);
+				dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 2d8a5f157988..e87feb2d1fa8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1741,9 +1741,11 @@ static enum dc_status dcn35_validate_bandwidth(struct dc *dc,
 {
 	bool out = false;
 
+	DC_FP_START();
 	out = dml2_validate(dc, context,
 			context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
 			validate_mode);
+	DC_FP_END();
 
 	if (validate_mode != DC_VALIDATE_MODE_AND_PROGRAMMING)
 		return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
@@ -1777,6 +1779,12 @@ static int populate_dml_pipes_from_context_fpu(struct dc *dc,
 	return ret;
 }
 
+void dcn35_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	DC_FP_START();
+	dcn35_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
 static struct resource_funcs dcn35_res_pool_funcs = {
 	.destroy = dcn35_destroy_resource_pool,
 	.link_enc_create = dcn35_link_encoder_create,
@@ -1798,7 +1806,7 @@ static struct resource_funcs dcn35_res_pool_funcs = {
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
-	.update_bw_bounding_box = dcn35_update_bw_bounding_box_fpu,
+	.update_bw_bounding_box = dcn35_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn35_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn35_get_preferred_eng_id_dpia,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
index 9c56ae76e0c7..6c2c61c711b9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
@@ -312,4 +312,5 @@ struct resource_pool *dcn35_create_resource_pool(
 #define DPP_REG_LIST_DCN35_RI(id)\
 	DPP_REG_LIST_DCN30_COMMON_RI(id)
 
+void dcn35_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 #endif /* _DCN35_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 9ed3d4879f76..c3454755a40f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1721,9 +1721,11 @@ static enum dc_status dcn351_validate_bandwidth(struct dc *dc,
 {
 	bool out = false;
 
+	DC_FP_START();
 	out = dml2_validate(dc, context,
 			context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
 			validate_mode);
+	DC_FP_END();
 
 	if (validate_mode != DC_VALIDATE_MODE_AND_PROGRAMMING)
 		return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
@@ -1750,6 +1752,12 @@ static int populate_dml_pipes_from_context_fpu(struct dc *dc,
 
 }
 
+static void dcn351_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	DC_FP_START();
+	dcn351_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
 static struct resource_funcs dcn351_res_pool_funcs = {
 	.destroy = dcn351_destroy_resource_pool,
 	.link_enc_create = dcn35_link_encoder_create,
@@ -1771,7 +1779,7 @@ static struct resource_funcs dcn351_res_pool_funcs = {
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
-	.update_bw_bounding_box = dcn351_update_bw_bounding_box_fpu,
+	.update_bw_bounding_box = dcn351_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn35_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn351_get_preferred_eng_id_dpia,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index d849d9eeb121..d8ec832940cb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1728,9 +1728,11 @@ static enum dc_status dcn35_validate_bandwidth(struct dc *dc,
 {
 	bool out = false;
 
+	DC_FP_START();
 	out = dml2_validate(dc, context,
 			context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
 			validate_mode);
+	DC_FP_END();
 
 	if (validate_mode != DC_VALIDATE_MODE_AND_PROGRAMMING)
 		return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
@@ -1778,7 +1780,7 @@ static struct resource_funcs dcn36_res_pool_funcs = {
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
-	.update_bw_bounding_box = dcn35_update_bw_bounding_box_fpu,
+	.update_bw_bounding_box = dcn35_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn36_get_preferred_eng_id_dpia,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 78bb1def9a0c..5a3684307c6b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1647,8 +1647,10 @@ static struct dc_cap_funcs cap_funcs = {
 	.get_subvp_en = dcn32_subvp_in_use,
 };
 
-static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+static void dcn401_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
 {
+	dc_assert_fp_enabled();
+
 	/* re-calculate the available MALL size if required */
 	if (bw_params->num_channels > 0) {
 		dc->caps.max_cab_allocation_bytes = dcn401_calc_num_avail_chans_for_mall(
@@ -1657,17 +1659,19 @@ static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 		dc->caps.mall_size_total = dc->caps.max_cab_allocation_bytes;
 	}
 
-	DC_FP_START();
-
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
 		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
 
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
 		dml2_reinit(dc, &dc->dml2_dc_power_options, &dc->current_state->bw_ctx.dml2_dc_power_source);
+}
 
+static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	DC_FP_START();
+	dcn401_update_bw_bounding_box_fpu(dc, bw_params);
 	DC_FP_END();
 }
-
 enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *plane_state)
 {
 	plane_state->tiling_info.gfxversion = DcGfxAddr3;
@@ -1692,10 +1696,13 @@ enum dc_status dcn401_validate_bandwidth(struct dc *dc,
 		}
 	}
 
-	if (dc->debug.using_dml2)
+	if (dc->debug.using_dml2) {
+		DC_FP_START();
 		status = dml2_validate(dc, context,
 				context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
 				validate_mode) ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
+		DC_FP_END();
+	}
 
 	if (validate_mode == DC_VALIDATE_MODE_AND_PROGRAMMING && status == DC_OK && dc_state_is_subvp_in_use(context)) {
 		/* check new stream configuration still supports cursor if subvp used */
@@ -1714,10 +1721,13 @@ enum dc_status dcn401_validate_bandwidth(struct dc *dc,
 
 	if (validate_mode == DC_VALIDATE_MODE_AND_PROGRAMMING && status == DC_FAIL_HW_CURSOR_SUPPORT) {
 		/* attempt to validate again with subvp disabled due to cursor */
-		if (dc->debug.using_dml2)
+		if (dc->debug.using_dml2) {
+			DC_FP_START();
 			status = dml2_validate(dc, context,
 					context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
 					validate_mode) ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
+			DC_FP_END();
+		}
 	}
 
 	return status;
@@ -1726,9 +1736,13 @@ enum dc_status dcn401_validate_bandwidth(struct dc *dc,
 void dcn401_prepare_mcache_programming(struct dc *dc,
 		struct dc_state *context)
 {
-	if (dc->debug.using_dml21)
+	if (dc->debug.using_dml21) {
+		DC_FP_START();
 		dml2_prepare_mcache_programming(dc, context,
-				context->power_source == DC_POWER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2);
+			context->power_source == DC_POWER_SOURCE_DC ?
+			context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2);
+		DC_FP_END();
+	}
 }
 
 static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 9d6a989d6dd2..b9532ebcced4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1696,37 +1696,50 @@ static void dcn42_destroy_resource_pool(struct resource_pool **pool)
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap};
 
-static void dcn42_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+static void dcn42_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	DC_FP_START();
+	dc_assert_fp_enabled();
+
 	if (dc->current_state && dc->current_state->bw_ctx.dml2)
 		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
-	DC_FP_END();
 }
 
+static void dcn42_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	DC_FP_START();
+	dcn42_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
 enum dc_status dcn42_validate_bandwidth(struct dc *dc,
 							  struct dc_state *context,
 							  enum dc_validate_mode validate_mode)
 {
 	bool out = false;
 
+	DC_FP_START();
+
 	out = dml2_validate(dc, context, context->bw_ctx.dml2,
 						validate_mode);
-	DC_FP_START();
+
 	if (validate_mode == DC_VALIDATE_MODE_AND_PROGRAMMING) {
 		/*not required for mode enumeration*/
 		dcn42_decide_zstate_support(dc, context);
 	}
+
 	DC_FP_END();
+
 	return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 void dcn42_prepare_mcache_programming(struct dc *dc,
 									  struct dc_state *context)
 {
-	if (dc->debug.using_dml21)
+	if (dc->debug.using_dml21) {
+		DC_FP_START();
 		dml2_prepare_mcache_programming(dc, context,
 			context->power_source == DC_POWER_SOURCE_DC ?
-				context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2);
+			context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2);
+		DC_FP_END();
+	}
 }
 /* Create a minimal link encoder object not associated with a particular
  * physical connector.
-- 
2.43.0

