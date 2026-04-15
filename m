Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD15FA0C3D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C6910E696;
	Wed, 15 Apr 2026 07:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SBabtdCa";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D5310E692
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6F2UPPz2dVYlyPWMkr0CCuUiwZO78aOpeYoS2q/GrRRAlz1O0wsq40IbQuEFpYMM3VpxFMTPevd3ZYMO/kYKIUh72NU4FpPnup0hkf7NI3p6kAd4bo3n2B0YsaCDznV+y8aT+XtJlI8rBePIPzf74Up44P/l8rM4p9XBdlg0i9DL7S/j5cg8RKrm+gYdVbB9as+0Niqsu49Puft/ytHFv6TXPXOxBOFGJ6pm2Yop9xiKi7RwLV6ijZatKNTNi48W8OpEqbsJxkn90MnL5bY3mIhfuCIEAbpdJSKgistcEMwQ0f4Vsnzqk1rC4akiEPVtQxFSSXZHEIgJnbk+USvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mMnUGTMBrk1W8HIpf1rVp34rMpfBEfBeUEGca926Vs=;
 b=t81qzlMWes4WdNPFgu1XWhux20Tx2YrUvgasA4ZQal91hJBcX57g0uFoMf89f796VVsWjXd7EF8IGvrEDFpFh0/u3wpauG6drX1WPAN+JITckOdwFV85T3xTJ3iMpQfRvvZFsr7BpRgMLezAUuJpnHe6i7vJx8WDCoiR6zv0CKSVg0fSuFOuU/f+0UoXsQ0sISyF4SG5MAgfV5cXQcmLyAUTh/plRKwOv8gkwI+HOifPovlewaIH5uc+WSFpTc4013SGh14HrwFs3MB13ckPW2vlTt0Y1n1QhDtiqrvG7soEnvnPWhu8ovme0Bv1ZkC0bMpRhgUMyb4dVsxBNsqrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mMnUGTMBrk1W8HIpf1rVp34rMpfBEfBeUEGca926Vs=;
 b=SBabtdCaNT3FNOt4kcZbXe4Zdl3rTWR1hJWpRpF0Rr5dXUplTJ1PditGvPNiZoomrOMcGuFkTzsqPjjkvgfpJMD++WuozQjPRU+PIY6q4aLVSgkWnwDodzJP2b4vYjV36NRnKdYTwSL62QZ0fPBNcf7vRNK6q4zRAHBYeXMvnlQ=
Received: from BL0PR02CA0061.namprd02.prod.outlook.com (2603:10b6:207:3d::38)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 07:42:59 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::50) by BL0PR02CA0061.outlook.office365.com
 (2603:10b6:207:3d::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:42:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:42:58 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:42:50 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Roman Li
 <Roman.Li@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 03/19] drm/amd/display: Remove unused dml2_project
Date: Wed, 15 Apr 2026 15:39:42 +0800
Message-ID: <20260415074223.34848-4-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2952b3-c5c3-411c-db08-08de9ac29d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yPcl4/EheDuuUEhu/NhMFnLTw2s2To3qumB0EkkumJ150SM1tkLgroEf2wxmQJogj/OyQgV4HFH1g23QES9tgMVvwa4WHhXmB+iAz56Ex/F7+xj76KcGwDwioAe5fnRdHfD3WRJ32HvLmhdijwCXnBcWsB/xr6lAtdMHj8mn6nQUHUNt33Yqm/cOWgNZ+i9Ek+t2psPdZtsMbj1UCNx03vydJl9DMe0DRvAzgqYpJq/dy+b+/Mexthk/VVYA+C1SixEoBEkfVt9cdKLqFUEcIGJ5ACroaaArUvyoQ7zxNQ3v6oPySlP12PqKfmfkJOACrlnfjEvvu5OauW9jpYcWMl24mmTeyfPkXERsA8i/J75MGlOt8lIENyVvr1o7cNe6xVBrn3afvd5VPMzB9fRQ4YfHN8TLwRyizheFN354grBKhtHLrA/Nb+uxFMUP8egLT02YL3oAg/+vnnYB2AqJec5vhKBN24LL30BCTgFdyFrSUr3XMvSH2f9wrB0hHOGqLr9EiVxIbimNW+rZ+58auxR/tuZ5z14qSQb+9NT8hr5Xb1QOAPH3+gpHpmAk9t1asrdKhiDOe6bpq8g6h7obMMLIVbvJrmm+8tRnnEk/ZCPpqMtVGT5WMiynSpivv5/vemd0Bwg5wMAV21dUS0A6TUiefC/IqxwiAES1FPrYqoJkkVDYgL6ubVkebVZJJOckH8U4z/Npln9zo2Fg6l7hZ6qbRdR6/e3f6MxKvRKF2WkqjSo0qu46UhaF3Qhc5tDzyJTLt8DrrvnnzMj9crpN6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8+eLeFGGBRvJn50InZnfHI0Yhj3c4X3FEZ/J8SCnoTFSy2InUWwLGH4MujiD1tIEizuf4sfTQcFLXl6QwyxKFCrjJ2vvcJdC/8tNbOn35J5SOgnbQguTZclkR/abZyfUqIIkb6eQ+SbACGMnxfgX/9rnbwwz9D8VnWE0JmjCH+8hCre4Ikq6wiOB40WTEhrBUgSFOlNjRL4iUs9QJtYrQVsQroMgO9YZL6b/mcB5NNzDOmM0JhMoq8R9V5aI15Vowm2HRhdYv9oW9bQHmwz5NDVdrFn9gx3uCBXW63uDz7fn8m2n8KEaoYthcZLcL2v7TXnrdfSNH9KWJb3CU8CjiJIpNJQdI9R8BwstENeB3KA0AAjuNQQSkB2/Z9ZdANQppUBeqHQQd882IbsQQOREPgs7KhFGw4sHpWMFP8EtmNJOyp7E+vO9gFh0dy4T7ZHK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:42:59.1416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2952b3-c5c3-411c-db08-08de9ac29d9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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

From: Roman Li <Roman.Li@amd.com>

Remove all references to dml2_project_dcn40 from dml2.
The project is not used.

Signed-off-by: Roman Li <roman.li@amd.com>
Acked-by: Chenyu Chen <chen-yu.chen@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h    | 1 -
 .../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c  | 1 -
 .../display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c  | 1 -
 .../display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c    | 1 -
 .../display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c    | 3 +--
 .../display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c | 1 -
 6 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index 98b26116cdc1..dff903a103db 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -19,7 +19,6 @@ enum dml2_project_id {
 	dml2_project_dcn4x_stage1,
 	dml2_project_dcn4x_stage2,
 	dml2_project_dcn4x_stage2_auto_drr_svp,
-	dml2_project_dcn40,
 	dml2_project_dcn42,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
index 6cad99c21139..67e307fa4310 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
@@ -21,7 +21,6 @@ bool dml2_core_create(enum dml2_project_id project_id, struct dml2_core_instance
 	case dml2_project_dcn4x_stage1:
 		result = false;
 		break;
-	case dml2_project_dcn40:
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
 		out->initialize = &core_dcn4_initialize;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
index 39965ff2e111..be0517e10104 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
@@ -33,7 +33,6 @@ bool dml2_dpmm_create(enum dml2_project_id project_id, struct dml2_dpmm_instance
 		out->map_watermarks = &dummy_map_watermarks;
 		result = true;
 		break;
-	case dml2_project_dcn40:
 	case dml2_project_dcn4x_stage2:
 		out->map_mode_to_soc_dpm = &dpmm_dcn3_map_mode_to_soc_dpm;
 		out->map_watermarks = &dummy_map_watermarks;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
index fb0b0ac547c7..270283332cc1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
@@ -27,7 +27,6 @@ bool dml2_mcg_create(enum dml2_project_id project_id, struct dml2_mcg_instance *
 		out->build_min_clock_table = &dummy_build_min_clock_table;
 		result = true;
 		break;
-	case dml2_project_dcn40:
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
 		out->build_min_clock_table = &mcg_dcn4_build_min_clock_table;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
index 83802aac11cd..af2ba7d08a61 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
@@ -3,8 +3,8 @@
 // Copyright 2024 Advanced Micro Devices, Inc.
 
 #include "dml2_pmo_factory.h"
-#include "dml2_pmo_dcn3.h"
 #include "dml2_pmo_dcn4_fams2.h"
+#include "dml2_pmo_dcn3.h"
 #include "dml2_external_lib_deps.h"
 
 static bool dummy_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in_out)
@@ -40,7 +40,6 @@ bool dml2_pmo_create(enum dml2_project_id project_id, struct dml2_pmo_instance *
 		out->optimize_dcc_mcache = pmo_dcn4_fams2_optimize_dcc_mcache;
 		result = true;
 		break;
-	case dml2_project_dcn40:
 	case dml2_project_dcn4x_stage2:
 		out->initialize = pmo_dcn3_initialize;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
index a6c5031f69c1..04860b6790df 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
@@ -17,7 +17,6 @@ bool dml2_initialize_instance(struct dml2_initialize_instance_in_out *in_out)
 	case dml2_project_dcn4x_stage1:
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
-	case dml2_project_dcn40:
 	case dml2_project_dcn42:
 		return dml2_top_soc15_initialize_instance(in_out);
 	case dml2_project_invalid:
-- 
2.43.0

