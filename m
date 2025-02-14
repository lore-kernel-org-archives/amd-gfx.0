Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7397C021A9
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF6F10ECCB;
	Fri, 14 Feb 2025 15:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ccg2AN5U";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5CBF10ECBA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVPARDKmaVZHJpnqMPGVYplwaeozXLYI08yEdlgK+nmMSp4M7DBL7HBG739Beb0pR89Ddw9J2+g4gblcamVRWhKNOyBHmkHLAn9jwpib7/nqo+6VHtV9+qLXluUQRNolt5HrLDlqvegAh93iZXogM8ldc2uM/KpJOO3JjvvmfDSo4+UwnioAFk8/+XLQJ5wM2VxN0CiSEhigbhWuWEX/PPR4rdcrszSAYJAYeQmAsF5Y0BBTty7pfDOLvzYeNb0okw9O4ObQNZktZ99LAD8j5d/2MHkmEr/OTb/lTbCXRuaR2THZCp+OHmmBZ/9TtgqzK7G4eGJUkwaPKARUmZm8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/inZCg3WaUhNdu5TzryluzPqE6qACEDFLwKYeqeL6/U=;
 b=WN399bskxoNXlWiR2ZPeC64keOfPq6Xo8PZALzrGqD1OTOx5JC9vAHqfuMFToi2UE9m4uHMPT2weDW8xKecjPA7+If0/t9pLnyK/2xb/LaFUABebMt/g0BP0QPiUpQIsi0lX29Vo4IP61JsyNfwaL+2yyoBzWy/WQFGD0j08WEA96EdSOGOnMAvqeuLz7xxlvt5tM6puQupuspHm4TB3HowfLG60rjAKBHvI8xx1eA1YE1b1czKSOCLULZ1RK8VbZ/p3oRqDPQEIswCx+5Xl5Xy4Do0+XVLOWYAX6J6P7BKROw3oWcBszYPJ1UXLynTokpCucCEBsiXGRDejTbFNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/inZCg3WaUhNdu5TzryluzPqE6qACEDFLwKYeqeL6/U=;
 b=Ccg2AN5UIOgGgoVemLB0lVtIumVvfNHaONO6g1kFqIWzHAqGLufloRX9f/RMpqkeO5yRu3vIsVtmxWXH9cI3Fv98a4YGAzi8cD8lP3iW0A5LxdQNsng2uv41jKu0/GfoWw+CZxZyKYYpaub4QpSrDIRohYce1fXbm3YJoQp9Ay0=
Received: from SA1P222CA0195.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::8)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 15:01:35 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::85) by SA1P222CA0195.outlook.office365.com
 (2603:10b6:806:3c4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 15:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:35 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:34 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Rodrigo
 Siqueira" <Rodrigo.Siqueira@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 06/16] drm/amd/display: Add clear DCC and Tiling callback for
 DCN
Date: Fri, 14 Feb 2025 10:00:23 -0500
Message-ID: <20250214150033.767978-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e3c8e0-a11e-4ce6-e73c-08dd4d087a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v1Zh5Fiw7ItlaRiWyKH15gLXwFcdJxQD8a1stiQ0wAT+Qr4cd1XUH9wZPaV4?=
 =?us-ascii?Q?VaXk7lNHhIZQ128ndMGcO0NDK+g26kXhW4WO0hsmVbrth5CNtWueRzb4G+nz?=
 =?us-ascii?Q?nOeOzQSR7j/2PhwvWVB/1TRXRqPqVVpyqDJc//G1SLKt/d1C7EYonuoW+M0M?=
 =?us-ascii?Q?sDS35yGdpeFEAkdrj5fz/iJOmgBRL7xcMHwhigMN9yF4U8CFmFCtOLFg9aDN?=
 =?us-ascii?Q?vmdtwkQHjNC5HmB5aUJavUZBXrS/XyVzoRfoR9uyyeUBcPWMuXt+oPuGmAs2?=
 =?us-ascii?Q?wIuMjw+LrPXzfOmvHL4H0ak+4dygYKA2UsewsqkMNPSCPYoopYYaaI8hvret?=
 =?us-ascii?Q?RFaYIqXnOlUH6FcRI9e88/rR0v+yEnb1wmDXudzPAf3SJ0QWU90YD6PwCaZY?=
 =?us-ascii?Q?g1pZMp7n8YbTLQSdVM5XgW3bzI4/hnL3nnI6zx78DklqO0arK2vn9qzHH9m5?=
 =?us-ascii?Q?t6KR03m1uReCefVOx63UeR0K3vQhtdQHNu6hra7oq4D/fcs/dNu8CINth1m3?=
 =?us-ascii?Q?uZl7CAjm1f2u61CUPn9FyOsxD3Dl54n7BTGmdb1NOtKqcVXIv3l7HF7qejuc?=
 =?us-ascii?Q?hxjGn9EPFmHHDzfd3JG5gXt4HnDW64hF6YLDYb32sEgOasNTkuPDujXEihbV?=
 =?us-ascii?Q?cZyrgwoKUbczhmVmQaasnpN1baU78b6CZuu1KEgFd+q9yZq50Yljc+E3Nad1?=
 =?us-ascii?Q?dGIqgMW01I4Ov0HqFl6RF5QDg19KM+pmBWWd4rsWL+PCdHldYWeKNE3sr4k2?=
 =?us-ascii?Q?Y3+bbp6ikqrMlEH6rjgBGdZ1yDencVlsieycapBJCSHIacNuS5eZsOO+QULX?=
 =?us-ascii?Q?OP4a16HZpq08F64IsHcRirZwzzbMq488bqUfyn68fANIBQPRW0O8LkjwKBkk?=
 =?us-ascii?Q?L/lhlmHqUdtv29dL03PuG9kIpfud1/5LR9puw+p7rCdHjAj2Z61lRcuVOtW0?=
 =?us-ascii?Q?ccwNUbcg6D2FfZMi089koNdG4yIfk8vkVWUex1XnX2w5UPqiDa9D1GAn+RUs?=
 =?us-ascii?Q?ux79LHDvRh7z1PRKuQDdty0AgKG+SPTLQCPr2PBQLZpRcnwGVywfsjd0vH8B?=
 =?us-ascii?Q?nt7E0ayAr5d2CP2CbcYy72SPXLIjPuuKs4HR4ykWqu8QO4tFNdVa9PeS5RVK?=
 =?us-ascii?Q?WQjnXorlIlvyhZ/eIrGnOUKpgm7key3Otfzje1ZKFseQe8EG4ihgkxoutOvx?=
 =?us-ascii?Q?JcWINTuziq2EwxkvezN0IksAOXbyBEtFLJVmroukIKNE5ptp81vFC1MAVCkL?=
 =?us-ascii?Q?+hU1yVg9ZSy4YKQNmG064vXI1XvvyVaswSCWrLT8xVKANFYrKo21Fgl3nlBP?=
 =?us-ascii?Q?zznEYe88FUI0/InigWWnXl3kXzIBt2FkggiFgJMA+zTwTQDyZ18fDS9zU9JC?=
 =?us-ascii?Q?96Dy+mpVnPsCC4y56E7fdAWTQ09aTb68y0jHVJlUc4GQ8C31JtsM7bWbx3GH?=
 =?us-ascii?Q?jnmYeTRqBTNQPkp5CRFz/eTUyfLfQyAC25moiTvRMk/CYxcpLhdHHhd/+ZOz?=
 =?us-ascii?Q?P9nCF2OHz9WlkD8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:35.7956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e3c8e0-a11e-4ce6-e73c-08dd4d087a07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
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

Introduce the DCC and Tiling reset callback to all DCN versions that can
call it.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c    | 13 ++-----------
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c  |  1 +
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c  |  1 +
 .../drm/amd/display/dc/hwss/dcn201/dcn201_init.c    |  1 +
 .../gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c  |  1 +
 .../gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c  |  1 +
 .../drm/amd/display/dc/hwss/dcn301/dcn301_init.c    |  1 +
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c  |  1 +
 .../drm/amd/display/dc/hwss/dcn314/dcn314_init.c    |  1 +
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c  |  1 +
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c  |  1 +
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c    |  1 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_init.c    |  1 +
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h  |  1 +
 14 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index aa4184dd0e53..691b4a68d8ac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -291,17 +291,8 @@ void dc_plane_force_dcc_and_tiling_disable(struct dc_plane_state *plane_state,
 			continue;
 
 		if (dc->ctx->dce_version >= DCE_VERSION_MAX) {
-			struct hubp *hubp = pipe_ctx->plane_res.hubp;
-			if (!hubp)
-				continue;
-			/* if framebuffer is tiled, disable tiling */
-			if (clear_tiling && hubp->funcs->hubp_clear_tiling)
-				hubp->funcs->hubp_clear_tiling(hubp);
-
-			/* force page flip to see the new content of the framebuffer */
-			hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
-									&plane_state->address,
-									true);
+			if (dc->hwss.clear_surface_dcc_and_tiling)
+				dc->hwss.clear_surface_dcc_and_tiling(pipe_ctx, plane_state, clear_tiling);
 		} else {
 			struct mem_input *mi = pipe_ctx->plane_res.mi;
 			if (!mi)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
index 5e51e1761707..079c226c1097 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
@@ -40,6 +40,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.update_plane_addr = dcn10_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.program_output_csc = dcn10_program_output_csc,
 	.enable_accelerated_mode = dce110_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
index 32707b344f0b..ad253c586ea1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
@@ -36,6 +36,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
index 78351408e864..dec57fb4c05c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
@@ -36,6 +36,7 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn10_post_unlock_program_front_end,
 	.update_plane_addr = dcn201_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
index e044e9e0a3a1..c7701a8b574a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
@@ -37,6 +37,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index c32764aef884..2ac5d54d1626 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -37,6 +37,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index dcb27cdbce73..8d7ceb7b32b8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -39,6 +39,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index fb2ffb637931..556f4fe57eda 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -40,6 +40,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 21ef03a76229..f5112742edf9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -42,6 +42,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index e4d149eff10f..b971356d30b1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -39,6 +39,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index c7acaf97974c..6a82a865209c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -44,6 +44,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 4f73e7f551ac..902a96940a01 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -43,6 +43,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index a4e3501fadbb..fe7aceb2f510 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -18,6 +18,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn401_program_front_end_for_ctx,
+	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn401_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index a7d66cfd93c9..599fa41fd75f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -240,6 +240,7 @@ struct hw_sequencer_funcs {
 		struct pipe_ctx *pipe_ctx, bool enableTripleBuffer);
 	void (*update_pending_status)(struct pipe_ctx *pipe_ctx);
 	void (*update_dsc_pg)(struct dc *dc, struct dc_state *context, bool safe_to_disable);
+	void (*clear_surface_dcc_and_tiling)(struct pipe_ctx *pipe_ctx, struct dc_plane_state *plane_state, bool clear_tiling);
 
 	/* Pipe Lock Related */
 	void (*pipe_control_lock)(struct dc *dc,
-- 
2.34.1

