Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92C2C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD0611395F;
	Wed, 24 Apr 2024 08:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d+MquG6x";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C14A11395F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPQ6e9BqtNG0luPKaxs0lpViFIeRBJg5jia3sEqGR1vcHdtagMJW9SZ7bshBkea/P3XlQQ7huLCmCTyThxbdYwDzPkZDZpVUaove8aH+O1Y5N823BxT+cauulWBQkJXnXYpH5KVmV1p1jFdSHNnjZFC/B52bfjWtYOnGTXqXv25FShQJCtdZbC6ybgRV0XRmtiVjMbpbjJCYsJRWGEaSN5b8UACnqmUR/qvYhVS6g4q55LjDq1Ix78MJKmwew1RZ1e/jDLy4eS/P+H51PIau222yyjdbkw41ka7UhhF+3AwVyl8tGA6yD/ROulIU1QXxRHQiUed/DZysHeQZsrAk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOrfDeCb4aBuoc8K38JwEgHB2LZQCCZfujsO3SueO2w=;
 b=aAWmMysbEy2175bc5YGMKSYeyHZXzdqckAb5rKLipJQWrzsL+xxN6H1O9j8q1/jTkSb3ip8tSdIsQz5Nw9IS4jh0V/FSEi+0opESXxs3dRu5tts4a+vEyqMuWlodFytgIUiluNHG4BouiiEwzNQJqJs5V9Jj60lPmPXfjA93Kkmq92bRqSgofU1WUHXvYUu8xiCP5LHL3yM+1iJr1t0Kt2WG+7RhLmYPgi+dGimuyhTOLRQs92LV/2KLuba7id3K6lfAt/QqKYuQFdl1qJOoE3CyzEdOdeAjALyQXmFsq6LbAbxPrfTg5AI6ShwLREg4U3v0dsMTR56u3xqD/UxAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOrfDeCb4aBuoc8K38JwEgHB2LZQCCZfujsO3SueO2w=;
 b=d+MquG6x8s3Y8oh8MraCAQ8kLeJQUaMvaowkhN5vYDWb/ZzgiD772INV1pwD2GNNd2ONY4Ld43zd+F7P5+8kAHpvdZp/7jAMNy98Y96yi8FTsFpFNzLjnzY4h+pJ4rf6YJi+dcksAv/3e0DGxvQM705Yk8xt7Dlq4N8m2dfdnjg=
Received: from MW4PR03CA0130.namprd03.prod.outlook.com (2603:10b6:303:8c::15)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:51:56 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::a8) by MW4PR03CA0130.outlook.office365.com
 (2603:10b6:303:8c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:51:56 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:51:54 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:51:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 15/46] drm/amd/display: Adjust functions prefix for some of
 the dcn301 fpu functions
Date: Wed, 24 Apr 2024 16:49:00 +0800
Message-ID: <20240424084931.2656128-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2134e4-0624-4d9d-e658-08dc643bcbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HQUP/13wr8LHjFiD1AOIkHG0gV4Eqt5DDJLsY6c+thlPgtXLSfTFPZXtNg80?=
 =?us-ascii?Q?k2cZdAs7HgHSt6t2bfy2j70VwaCYBGvOz5eSeAx0W5o92ksMg5IhC1ULKj5b?=
 =?us-ascii?Q?Unfqd7QG1v8GIGLZ7zN86OH9jriKlv1RelQZ4BuV2Z0DbTa/Z3maI61/dluq?=
 =?us-ascii?Q?HImlUJz0n1TaueYp/+dMhQA+zVAQDfGhdsNGQXE4uT1lU/6P5VoWOXEjyaxA?=
 =?us-ascii?Q?XrLKV+b0RqZ5Yb8I0rGnFeeK4rAkJJrjIyKQwImEwz6FP4nl8y2hyKPPAYqN?=
 =?us-ascii?Q?gG4yK/cI6MbKAWPkZ5l4v7l9dvFHYmUZKjoTbvN+yU589w838fbqbQuBmoG+?=
 =?us-ascii?Q?DjVa+YFg/J2eI+N4SlWK5Tpq9U0meInXrENACMq+qJAxsgAgZV/FfuBc8Ook?=
 =?us-ascii?Q?jci95Muv7/xFpTB0K8oEfL6O95h89A3FvK7W55aio9FJ0ko4Ul0kR89d5k46?=
 =?us-ascii?Q?db7TyQ+qDOQjuJ87CGK2N5C5G/P+AnRvCgaEhQEr/XxJEKynsfPwnIkOLqLr?=
 =?us-ascii?Q?MwVNt1G1io9eVZNeFX/9n7RN0RD1ANsq/b133acZzjjlDY7EH4ODyoOlk8yp?=
 =?us-ascii?Q?t4J1XRiXlaWxq2Tqspt5aso7A4mYVJxJjFoB2N38DP0zTMU6sh8BNinoEDg1?=
 =?us-ascii?Q?rTG54IsKPkNAPUQOJBXBjM8t2zBwmN9fAowLahcv93lzoEPo2pYPM/XubvLW?=
 =?us-ascii?Q?cOojYe03sJsQxUy9nr/5fkISQXMz9ymhtpTbqJNnMR5Z8rYFutX5UmiGPy/0?=
 =?us-ascii?Q?JlLKt8xdhpDg9IOJgXilqewL9aNV1jU7VjtbnwHGM0a6BYFebefrFI4y8RWQ?=
 =?us-ascii?Q?rwl+5HOed02DZlVKFhpcK/V6hJ4GWI54hENtIFc6aqylqRIImScQZJTCzv5O?=
 =?us-ascii?Q?lzDvjIZCebGdqtrpUY/Py2QXfMYgh/QoUL0SCkWBVnhpOwXV4XcwFZ4dn9XK?=
 =?us-ascii?Q?So52m+8Ekz0MYd8PTIi6Wz0TZaNKZMtwaQURj4L5YKebODgiHZcuOgUqv9xm?=
 =?us-ascii?Q?jiiiza0L2a+Cupi94CQYFnAR0CUD8Q92LHUj4BTLaIl60oD+WPph1/9kTWun?=
 =?us-ascii?Q?IhTTHNxyPje4GlaTRkB/SoNFUxdLSlTXSqSd6whMsHG4gWzcoq7DjUyhlJGm?=
 =?us-ascii?Q?rlvxQi5GzIV1yoCrNqdA8sxwXy67+uPV7L70BCWkE7gmPJQ2xGd3bxDhs9oc?=
 =?us-ascii?Q?pGfvmflgbmJ5XGjLFM1fnDI2UYSk00CzDIR60j/8b7/XhGZQgg7ffZrqLkS7?=
 =?us-ascii?Q?c/Kc+05AcsIRqD1jSnokRAggKnP9zCUQvkJ3IvuDZhhV7y7HMB/MzyGKmD35?=
 =?us-ascii?Q?hSMWDtjw7antixQvNaXnsoKyMFPPZ1fQ8nIVUuZm6jckEDzGlvZY3eVoBGUK?=
 =?us-ascii?Q?mkI5t5utfbxvH/pHXJRjK9wOnUO2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:51:56.2379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2134e4-0624-4d9d-e658-08dc643bcbc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Add dcn301_fpu prefix to some of the FPU function with the required
adjustments.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |  4 ++--
 .../amd/display/dc/dml/dcn301/dcn301_fpu.h    |  7 +++----
 .../dc/resource/dcn301/dcn301_resource.c      | 19 +++++++++++++------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 6ce90678b33c..0c0b2d67c9cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -320,7 +320,7 @@ static void calculate_wm_set_for_vlevel(int vlevel,
 
 }
 
-void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+void dcn301_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct _vcs_dpi_voltage_scaling_st *s = dc->scratch.update_bw_bounding_box.clock_limits;
 	struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
@@ -409,7 +409,7 @@ void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info)
 		dcn3_01_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
 }
 
-void dcn301_calculate_wm_and_dlg_fp(struct dc *dc,
+void dcn301_fpu_calculate_wm_and_dlg(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
index 774b0fdfc80b..3e103e23dc6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
@@ -26,15 +26,14 @@
 #ifndef __DCN301_FPU_H__
 #define __DCN301_FPU_H__
 
-void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);
+void dcn301_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 
 void dcn301_fpu_set_wm_ranges(int i,
 	struct pp_smu_wm_range_sets *ranges,
 	struct _vcs_dpi_soc_bounding_box_st *loaded_bb);
 
-void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);
-
-void dcn301_calculate_wm_and_dlg_fp(struct dc *dc,
+void dcn301_fpu_calculate_wm_and_dlg(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 7538b548c572..346cec70de96 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -1363,14 +1363,21 @@ static void set_wm_ranges(
 	pp_smu->nv_funcs.set_wm_ranges(&pp_smu->nv_funcs.pp_smu, &ranges);
 }
 
-static void dcn301_calculate_wm_and_dlg(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel)
+static void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	DC_FP_START();
-	dcn301_calculate_wm_and_dlg_fp(dc, context, pipes, pipe_cnt, vlevel);
+	dcn301_fpu_update_bw_bounding_box(dc, bw_params);
+	DC_FP_END();
+}
+
+static void dcn301_calculate_wm_and_dlg(struct dc *dc,
+					struct dc_state *context,
+					display_e2e_pipe_params_st *pipes,
+					int pipe_cnt,
+					int vlevel_req)
+{
+	DC_FP_START();
+	dcn301_fpu_calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel_req);
 	DC_FP_END();
 }
 
-- 
2.37.3

