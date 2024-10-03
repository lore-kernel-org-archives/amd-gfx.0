Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ACBCF34D7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9438810E249;
	Thu,  3 Oct 2024 23:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iKgtxz7Y";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7031A10E9B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyv41IWWsC+1TSAIT4E6JkuKgEFu4X5b32Lb+0SBR0vnSulN36P+Vj/fOeC9FNol8wFG8boG+LeaYFbJNqbMw5N7UxLqTnAKUMUVrJCzrx/z+gFNSA0BZ2u/XTfe9fb404BgDdFMtkD59RPN3Iu4fot+V2GrAFlsVWamOdjlETKLLuKwv2UV9z11e+FBCZIC7N3lYCUqbb40ANf5iFHWfW35EOZ0qApsgJMfOAoTD7ElGu+uMfRj1IOTmaH/PlZVM1Pt3KKiSpezQAwp74uGER/tspcv7SanOZIIJmhaxXy82XHrmvbmpXP99wj80RFrD+etB1BCwiaKfLQRK6D4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO6qPaCZyZ+KlJcq0PSy1UkXLniW3vAlLs1XmAOkV+Y=;
 b=Z3qH1zI+czmbMwN/+hm4kfi0I7buB3/yGDoJ/LEWu7Q7BEvu3lgQ8Qm1MFw+7rwN8Dll5r7pDvV4ReUgyl6dv6YlGuU9rEba0ainHD4IUW5I1Uuu2zqad02g0hGtnuNiPFke6tt1RShKaFcFhK6WE4OUw00NrOw9g7uS3cesm34b4nT+TlBgllpPWybMOCduvwCaYg9PMBfl0uJ+zw4PAFedctNHFIwfMpLbM9fKA16smfIeKAOX5TtJh/uCuSZy09mwrOe0/MoUXXndao+HQtJztiL8mmZx4DN4cW945iAVcfiuN5EheceXi2GauruX0sXdQZshqfZ40+gFdAjpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO6qPaCZyZ+KlJcq0PSy1UkXLniW3vAlLs1XmAOkV+Y=;
 b=iKgtxz7YD2AAaYaPIFD2+BEY6IBlJwM2v9cvsQiGBHPsvoeco1qrp7zqHvq/NbrL8wvRGb0Z9EpJQuI1NgyxYRE6yMuDaYcbErUpb/4rmqWwrtFvCMDdrbFzKN3CHEmnDyfe4svo1j7LYGk5Qwe6McEYyN9Gj7jdRGku2j/9k2A=
Received: from DM5PR07CA0101.namprd07.prod.outlook.com (2603:10b6:4:ae::30) by
 IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 23:36:19 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::1c) by DM5PR07CA0101.outlook.office365.com
 (2603:10b6:4:ae::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:13 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 23/26] drm/amd/display: Remove redundant assignments
Date: Thu, 3 Oct 2024 17:33:41 -0600
Message-ID: <20241003233509.210919-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 1331b7ae-22ab-4a0d-0737-08dce4042ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bJ8eic2BE5K3V+yzI8NSC0ocFlb6jYOQySYKfJIoFVrdk+f4NHAAmhjJagnW?=
 =?us-ascii?Q?DbR1D77RWRPTRbrohli1eHClmY11tfO+NpGIUibctrxiZguqC0x1FpaMauRU?=
 =?us-ascii?Q?nOmwiei067Qoyp9p0/9F5w4T0QRnKlYIuPtKzSubOarz7LNqD7c4AN2MNFQg?=
 =?us-ascii?Q?Ef6xzWnFdsLOSLGp1ldwqIKM/v2TSvsmR5pj4oW7tFPQIkN6BBfu0vJieGJt?=
 =?us-ascii?Q?nVhO1FW3WkiSHVvLbq4jHo2l2bGIKmvrLmiekKqiNnWnF+einjbh9AIMdV6F?=
 =?us-ascii?Q?+2/LgJ98HhSYv720hW4+RbMy9z2ldDvrXNEzxwgb76ms7okFZQtiQf/af8sa?=
 =?us-ascii?Q?cdU3k9NZyZJaFM+mThct1GbOcYBIyMxNt+MQb/Tfvbi1BQiHEQn40204qjYs?=
 =?us-ascii?Q?OpcoR0bHecY45t1FB09jG3D2iCPIlpAmnYeB5flX4auIDzpD8gDGTqKkblHy?=
 =?us-ascii?Q?Rghfrzk/j/bEs94A9p5OX6LmZwatPcVCssjM/HAbkenrH5lEDk3lS9mkn56J?=
 =?us-ascii?Q?/u1/D8vNXsZPy6hDIiz83caC3D0gWUyAqYsLGtcdOJbFs6pxFq0jIuFWVo4h?=
 =?us-ascii?Q?LbFx25ebHQ+raUsjvJBMEr19KIVHB7Inggd/ZEasMwS0zomw2nzQUmtPnKjR?=
 =?us-ascii?Q?S3FEzia35RU6NbvIqD5nbGLqpBIjLFRG3Mw5xJrjGMv6Q2mkT8QUoYdB/RYi?=
 =?us-ascii?Q?Z9t9jLqWp+piwuwx3NTV4QC0OJun3L1ibNYJN7UOdj6/UgqN2IDnrS9o5cyc?=
 =?us-ascii?Q?8sdt8DqIWTiflhTRMvZlWFa9BV19kuPJauuBJhRNjTtPqTzYYWsvrh7yhr+f?=
 =?us-ascii?Q?ERc9EPffn1NsHA5RdMfXdiWc/9aecpoTHvoOSaLE2Qzxui2CZxiPuYabUOgV?=
 =?us-ascii?Q?KFWpZ3pOdf8C7F4ehF6RQLe14/SU2TFA6TdalS3BvYhOA2+j7gXuGUj4msIS?=
 =?us-ascii?Q?+8FgFrFWVT+e546NIoJjaPHE7pVkbwtDdte2kHjhuYNLUy1U+Z5SIdFdVDxD?=
 =?us-ascii?Q?cy7T8Sazf1Nb74SLVhMhTsVJ4zM+JQVyLBZdBeuUediuJW0pN5tDzVTdEaAM?=
 =?us-ascii?Q?/1bGNg1efMeHxzcX3KCkmLtXMc14OYjEVZn8b62yxmFRWUCXKOK06yLHVS6V?=
 =?us-ascii?Q?D0E2aQoGr+bxVakPhYTBEyzajjZPg1tOIXp4iMv6Ab6JHL5kg6Rjexp7MOAn?=
 =?us-ascii?Q?EY9UfADeTL400NvLiDhmNwCfDCYG48mZhk+tM43b4Uzfmtm9UxlQg62xKmKW?=
 =?us-ascii?Q?A7ACk9WlAIrsWnXdMGvdmaKe53pnP4B9tw9UcHvVB9TEb5SXjjvU7Dz1jRwG?=
 =?us-ascii?Q?rtYQyI7RJ/yobeyvry7vo1U9X48r7zpPMd/I0vPJuwv6nSF0eSXa/wUKwtxQ?=
 =?us-ascii?Q?hKtFFPU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:19.4214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1331b7ae-22ab-4a0d-0737-08dce4042ecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
log2_blk_height and log2_blk_width are assigned to 0 and then
immediately are updated to other values. The assignments to zero are
redudant and removed.

This fixes 18 UNUSED_VALUE issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 4 ----
 .../drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c   | 4 ----
 .../gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c | 4 ----
 .../gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c | 4 ----
 .../gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c | 4 ----
 .../drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c   | 4 ----
 6 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 4fce64a030b6..390c1a77fda6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -443,8 +443,6 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 	blk_bytes = surf_linear ?
 			256 : get_blk_size_bytes((enum source_macro_tile_size) macro_tile_size);
 	log2_blk_bytes = dml_log2((double) blk_bytes);
-	log2_blk_height = 0;
-	log2_blk_width = 0;
 
 	// remember log rule
 	// "+" in log is multiply
@@ -491,8 +489,6 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 			- log2_meta_req_height;
 	meta_req_width = 1 << log2_meta_req_width;
 	meta_req_height = 1 << log2_meta_req_height;
-	log2_meta_row_height = 0;
-	meta_row_width_ub = 0;
 
 	// the dimensions of a meta row are meta_row_width x meta_row_height in elements.
 	// calculate upper bound of the meta_row_width
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 3fa9a5da02f6..843d6004258c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -443,8 +443,6 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 	blk_bytes = surf_linear ?
 			256 : get_blk_size_bytes((enum source_macro_tile_size) macro_tile_size);
 	log2_blk_bytes = dml_log2((double) blk_bytes);
-	log2_blk_height = 0;
-	log2_blk_width = 0;
 
 	// remember log rule
 	// "+" in log is multiply
@@ -491,8 +489,6 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 			- log2_meta_req_height;
 	meta_req_width = 1 << log2_meta_req_width;
 	meta_req_height = 1 << log2_meta_req_height;
-	log2_meta_row_height = 0;
-	meta_row_width_ub = 0;
 
 	// the dimensions of a meta row are meta_row_width x meta_row_height in elements.
 	// calculate upper bound of the meta_row_width
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 9e1c18b90805..5718000627b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -435,8 +435,6 @@ static void get_meta_and_pte_attr(
 	blk_bytes = surf_linear ?
 			256 : get_blk_size_bytes((enum source_macro_tile_size) macro_tile_size);
 	log2_blk_bytes = dml_log2((double) blk_bytes);
-	log2_blk_height = 0;
-	log2_blk_width = 0;
 
 	// remember log rule
 	// "+" in log is multiply
@@ -485,8 +483,6 @@ static void get_meta_and_pte_attr(
 			- log2_meta_req_height;
 	meta_req_width = 1 << log2_meta_req_width;
 	meta_req_height = 1 << log2_meta_req_height;
-	log2_meta_row_height = 0;
-	meta_row_width_ub = 0;
 
 	// the dimensions of a meta row are meta_row_width x meta_row_height in elements.
 	// calculate upper bound of the meta_row_width
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index b28fcc8608ff..76d3bb3c9155 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -392,8 +392,6 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 	blk_bytes = surf_linear ?
 		256 : get_blk_size_bytes((enum source_macro_tile_size) macro_tile_size);
 	log2_blk_bytes = dml_log2((double)blk_bytes);
-	log2_blk_height = 0;
-	log2_blk_width = 0;
 
 	// remember log rule
 	// "+" in log is multiply
@@ -464,8 +462,6 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 		- log2_meta_req_height;
 	meta_req_width = 1 << log2_meta_req_width;
 	meta_req_height = 1 << log2_meta_req_height;
-	log2_meta_row_height = 0;
-	meta_row_width_ub = 0;
 
 	// the dimensions of a meta row are meta_row_width x meta_row_height in elements.
 	// calculate upper bound of the meta_row_width
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index b57b095cd4a8..c46bda2141ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -413,8 +413,6 @@ static void get_meta_and_pte_attr(
 	log2_blk256_height = dml_log2((double) blk256_height);
 	blk_bytes = surf_linear ? 256 : get_blk_size_bytes((enum source_macro_tile_size) macro_tile_size);
 	log2_blk_bytes = dml_log2((double) blk_bytes);
-	log2_blk_height = 0;
-	log2_blk_width = 0;
 
 	// remember log rule
 	// "+" in log is multiply
@@ -481,8 +479,6 @@ static void get_meta_and_pte_attr(
 	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element - log2_meta_req_height;
 	meta_req_width = 1 << log2_meta_req_width;
 	meta_req_height = 1 << log2_meta_req_height;
-	log2_meta_row_height = 0;
-	meta_row_width_ub = 0;
 
 	// the dimensions of a meta row are meta_row_width x meta_row_height in elements.
 	// calculate upper bound of the meta_row_width
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index 61b3bebf24c9..b7d2a0caec11 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -501,8 +501,6 @@ static void get_meta_and_pte_attr(
 	log2_blk256_height = dml_log2((double) blk256_height);
 	blk_bytes = surf_linear ? 256 : get_blk_size_bytes((enum source_macro_tile_size) macro_tile_size);
 	log2_blk_bytes = dml_log2((double) blk_bytes);
-	log2_blk_height = 0;
-	log2_blk_width = 0;
 
 	// remember log rule
 	// "+" in log is multiply
@@ -569,8 +567,6 @@ static void get_meta_and_pte_attr(
 	log2_meta_req_width = log2_meta_req_bytes + 8 - log2_bytes_per_element - log2_meta_req_height;
 	meta_req_width = 1 << log2_meta_req_width;
 	meta_req_height = 1 << log2_meta_req_height;
-	log2_meta_row_height = 0;
-	meta_row_width_ub = 0;
 
 	// the dimensions of a meta row are meta_row_width x meta_row_height in elements.
 	// calculate upper bound of the meta_row_width
-- 
2.45.2

