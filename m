Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEAFD6AAEC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6F910F292;
	Thu,  2 Apr 2026 18:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="18ZoPlOS";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC4610F01C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOZApuGRbjIVhUTB2+qvIxSijpyApaSmP4g0yKj9FrNwl17rZARpmun3hARxWt8EewFGfRClNFGm6gKR47Ghv8/nMpWiLE7ibfVvIwZltKxKVfYb+rzjHuh/9irGkAB4N5ymc1cE1wfQDAW2RwPYXOk98Ot6KxD9oQdAtq3pDknMx0wVdaGOtegmuDBqmJN14wfqy98XkIbbyPm9inBOvsJs9doN1qoN0dOtTXoWH9MmuWGfX+Hhp38xWNmwR8S2f16We3Gw6JL/W8dTt5N5WcDVdAl2nT0DCydKxygd8DU7N0k4XF03bDr8IGJofYs1G/DbD4vxstSrFWhw0rm+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfIUAqHPbjIyRw+kEV1D5/78gSsVJUb+IfAMz5QVMlc=;
 b=fErsNXxkYmOzHv0wmmCKIfs7DjgBOrga2Gc9HyrRtp9eFqauiAHuqIaDQC2V2lpjEMldhoaKcm4xIRtURye0Wm3ttWtUAfvBFMJtVEBRvp/NyfI29Y9XMgy/67AmMh1ceeNx0nqINWC/N2TFWsT8X90gwnDilHPhzt5z/Gi5Pw5cn6NC6o9gR+uWG+5egqLI5FpQCv9N7rzozKSJICLHz47QtS838hbOcAui5c2R7bYwAmFWnufblAMqaL70ljMxVZIsk5j2m0prB5z6ioVVbZ7db1MbS4y86uddXwJbhwsh9IpqtQDQ8M3AL5wHTGsSFjhszfUdpV4kTL3LpKOiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfIUAqHPbjIyRw+kEV1D5/78gSsVJUb+IfAMz5QVMlc=;
 b=18ZoPlOSa+jvi3c7tceCs9u09AQdbUM4wt2nMgALD4Nq7XmvMoSTOpwkLRpylZeWvq7BgsmD7rL40FXRZUmn3kDfY/x2PKkcC7P3PV8tdy3DxTmpB2dmlWbr6dMaV0IjOXs6n5vr2EZmLeP9mFFKnyar7fOk27TgCaSPO/MGZ18=
Received: from CH2PR07CA0043.namprd07.prod.outlook.com (2603:10b6:610:5b::17)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 2 Apr
 2026 18:33:36 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::9b) by CH2PR07CA0043.outlook.office365.com
 (2603:10b6:610:5b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Thu,
 2 Apr 2026 18:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:33:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 13:33:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 13:33:34 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:33:28 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 02/22] drm/amd/display: Drop unused tiling formats from dml2
Date: Thu, 2 Apr 2026 14:32:54 -0400
Message-ID: <20260402183314.1388755-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 01797f63-0048-473e-0e2a-08de90e65943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6B9SgcH1rPO4+0WQSAJsHaNDg3ARLhJluG9bldETzhOUsQcJkznoAfaScbLEbuAqf5ythJ0amALwiNAQrgCN2cDB2M43mfEq8IDi30Gi7EVMBH9U96HDsuKepAgrNB3doKgXZjH6h3S4oVUuGz+RKXUai+c3g7V7ERyCEioukqeCDT9g4NodDbLEdf7/X45urxM/0qGGbaU+j1TQccKoRXgBa1LATGkfv3P8Vs8oRg5Z4JxnmqUUpsUWo88oFrCr2LOb+bHTo8t61mPfWXm5FxWFD0X+WHLqOzzRzzzmemyjvDltkaIme3IYuY/2K64T1DI+NZzjPeBS9yKdJ5eyjv8WvSApYUA5b8hfNReg/Lg7uSgnfuk58mQmM1FJbtpr55riT1LdKYPuG4q4tfcnQ1c5S9B4kgeTqDqrDwGOG/jvyyUewPp4prjqMO+y3lW4nO+jSnVgnBlBNSii534dMprCts0Fk/2W9FEQPKzLv1HyMXMFs/4k0sdDkKo+NaR/UdQCc3RGAo4zTQQ6sQDb1XadhWZU/m62exEkyK9pysOUN5KL0M5xS6NfakPrmSn86cPCH6a4tbcrAWl+81p7XOvIY62lIDatpqbHwcPSfBUmVJSQ8yEsMaOn9k12NMBDJxqtPl3py8RzFO8nhbZHlPsGOv+DtXW2O4dMkk0sPQJT/M5BrikiCcNPA5JqNRgSVeopRSmGYipii1ik6BOLVnkKWoQBkXjoP7p57HeqIzoY2Cs9eh7YkcLEEecsPwTtb8jJ9IeX+QbOEeQTi6FtPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F/Rz8nZyBQ7+NCUsgFLv0OzoggssTgsyU3hN5Va34k03fI/SO7elSMKapw1GIDOjyEJWeinbhrcvfcG7H+V2w/yh2iJV7CqbCaZ/gxuz1emCIlm/c3efL4xlcaz9JP3+vPlIATaM9Aav2wJno3hidkq0sb4q8A5VzTWN6dnUjAGM1Y2elKuVF5gNvcMNaG933UH6Kg1vPNv6h2WHXE7scIeYXxtlnA7YDmJOT387bQ3XuXblS+4e1oXy87rYG9VhciEOzV5FUCMsUl7RzI5MT4l/TTy0qHYb+UkdqA3euHLyTpt86QuIH4ZFWRBvnlJJeqeNJ1cb47lwr+NezcYgCZU+ISY+02X3ECwu6UqdxGrDa7DzsZIQc4az1r3ZqxDQjflbgM7ThJie8YWYtcJAnAT3BsSbLKOs6hUSlRnjM+Y12FUjvRSRPdb24yFB3LxX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:33:34.7082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01797f63-0048-473e-0e2a-08de90e65943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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

Remove unused legacy tiling format support from dml2.
Legacy asics don't use dml2.

Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 .../dml21/inc/dml_top_display_cfg_types.h     | 14 ----
 .../dml21/src/dml2_core/dml2_core_utils.c     | 64 +------------------
 .../dml21/src/dml2_core/dml2_core_utils.h     |  2 -
 3 files changed, 2 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
index 4e9abe1a568d..79dfba54344c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
@@ -26,20 +26,6 @@ enum dml2_swizzle_mode {
 	dml2_gfx11_sw_64kb_r_x,
 	dml2_gfx11_sw_256kb_d_x,
 	dml2_gfx11_sw_256kb_r_x,
-
-	dml2_sw_linear_256b, // GFX10 SW_LINEAR only accepts 256 byte aligned pitch
-	dml2_gfx10_sw_64kb_r_x,
-	dml2_gfx102_sw_64kb_s,
-	dml2_gfx102_sw_64kb_s_t,
-	dml2_gfx102_sw_64kb_s_x,
-	dml2_gfx102_sw_64kb_r_x,
-
-	dml2_linear_64elements, // GFX7 LINEAR_ALIGNED accepts pitch alignment of the maximum of 64 elements or 256 bytes
-	dml2_gfx7_1d_thin,
-	dml2_gfx7_2d_thin_gen_zero,
-	dml2_gfx7_2d_thin_gen_one,
-	dml2_gfx7_2d_thin_arlene,
-	dml2_gfx7_2d_thin_anubis
 };
 
 enum dml2_source_format_class {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
index cd9bf190cb1a..5dc846802c53 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
@@ -428,10 +428,6 @@ bool dml2_core_utils_is_phantom_pipe(const struct dml2_plane_parameters *plane_c
 
 unsigned int dml2_core_utils_get_tile_block_size_bytes(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel)
 {
-	if (dml2_core_utils_get_gfx_version(sw_mode) == 10 || dml2_core_utils_get_gfx_version(sw_mode) == 7) {
-		return dml2_core_utils_get_tile_block_size_bytes_backcompat(sw_mode, byte_per_pixel);
-	}
-
 	if (sw_mode == dml2_sw_linear)
 		return 256;
 	else if (sw_mode == dml2_sw_256b_2d)
@@ -462,56 +458,14 @@ unsigned int dml2_core_utils_get_tile_block_size_bytes(enum dml2_swizzle_mode sw
 	};
 }
 
-unsigned int dml2_core_utils_get_tile_block_size_bytes_backcompat(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel)
-{
-	if (sw_mode == dml2_sw_linear_256b)
-		return 256;
-	else if (sw_mode == dml2_gfx10_sw_64kb_r_x)
-		return 65536;
-	else if (sw_mode == dml2_gfx102_sw_64kb_s)
-		return 65536;
-	else if (sw_mode == dml2_gfx102_sw_64kb_s_t)
-		return 65536;
-	else if (sw_mode == dml2_gfx102_sw_64kb_s_x)
-		return 65536;
-	else if (sw_mode == dml2_gfx102_sw_64kb_r_x)
-		return 65536;
-	else if (sw_mode == dml2_linear_64elements)
-		return 256;
-	else if (sw_mode == dml2_gfx7_1d_thin)
-		return 256;
-	else if (sw_mode == dml2_gfx7_2d_thin_gen_zero)
-		return (128 * 64 * byte_per_pixel);
-	else if (sw_mode == dml2_gfx7_2d_thin_gen_one)
-		return (128 * 128 * byte_per_pixel);
-	else if (sw_mode == dml2_gfx7_2d_thin_arlene)
-		return (64 * 32 * byte_per_pixel);
-	else if (sw_mode == dml2_gfx7_2d_thin_anubis)
-		return (128 * 128 * byte_per_pixel);
-	else {
-		DML_ASSERT(0);
-		return 256;
-	};
-}
-
 bool dml2_core_utils_get_segment_horizontal_contiguous(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel)
 {
-	if (dml2_core_utils_get_gfx_version(sw_mode) == 10 || dml2_core_utils_get_gfx_version(sw_mode) == 7) {
-		return dml2_core_utils_get_segment_horizontal_contiguous_backcompat(sw_mode, byte_per_pixel);
-	} else {
-		return (byte_per_pixel != 2);
-	}
-}
-
-bool dml2_core_utils_get_segment_horizontal_contiguous_backcompat(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel)
-{
-	return !((byte_per_pixel == 4) &&
-		((sw_mode == dml2_gfx10_sw_64kb_r_x) || (sw_mode == dml2_gfx102_sw_64kb_s) || (sw_mode == dml2_gfx102_sw_64kb_s_t) || (sw_mode == dml2_gfx102_sw_64kb_s_x)));
+	return (byte_per_pixel != 2);
 }
 
 bool dml2_core_utils_is_linear(enum dml2_swizzle_mode sw_mode)
 {
-	return (sw_mode == dml2_sw_linear || sw_mode == dml2_sw_linear_256b || sw_mode == dml2_linear_64elements);
+	return sw_mode == dml2_sw_linear;
 };
 
 
@@ -544,20 +498,6 @@ int unsigned dml2_core_utils_get_gfx_version(enum dml2_swizzle_mode sw_mode)
 		sw_mode == dml2_gfx11_sw_256kb_d_x ||
 		sw_mode == dml2_gfx11_sw_256kb_r_x)
 		version = 11;
-	else if (sw_mode == dml2_sw_linear_256b ||
-		sw_mode == dml2_gfx10_sw_64kb_r_x ||
-		sw_mode == dml2_gfx102_sw_64kb_s ||
-		sw_mode == dml2_gfx102_sw_64kb_s_t ||
-		sw_mode == dml2_gfx102_sw_64kb_s_x ||
-		sw_mode == dml2_gfx102_sw_64kb_r_x)
-		version = 10;
-	else if (sw_mode == dml2_linear_64elements ||
-		sw_mode == dml2_gfx7_1d_thin ||
-		sw_mode == dml2_gfx7_2d_thin_gen_zero ||
-		sw_mode == dml2_gfx7_2d_thin_gen_one ||
-		sw_mode == dml2_gfx7_2d_thin_arlene ||
-		sw_mode == dml2_gfx7_2d_thin_anubis)
-		version = 7;
 	else {
 		DML_LOG_VERBOSE("ERROR: Invalid sw_mode setting! val=%u\n", sw_mode);
 		DML_ASSERT(0);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
index 471e73ed671c..95f0d017add4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
@@ -22,8 +22,6 @@ void dml2_core_utils_pipe_plane_mapping(const struct core_display_cfg_support_in
 bool dml2_core_utils_is_phantom_pipe(const struct dml2_plane_parameters *plane_cfg);
 unsigned int dml2_core_utils_get_tile_block_size_bytes(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel);
 bool dml2_core_utils_get_segment_horizontal_contiguous(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel);
-unsigned int dml2_core_utils_get_tile_block_size_bytes_backcompat(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel);
-bool dml2_core_utils_get_segment_horizontal_contiguous_backcompat(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel);
 bool dml2_core_utils_is_vertical_rotation(enum dml2_rotation_angle Scan);
 bool dml2_core_utils_is_linear(enum dml2_swizzle_mode sw_mode);
 int unsigned dml2_core_utils_get_gfx_version(enum dml2_swizzle_mode sw_mode);
-- 
2.34.1

