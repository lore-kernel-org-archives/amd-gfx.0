Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03380C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4124710EC78;
	Wed, 16 Sep 2026 17:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QzpA6RJz";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD61D10E973
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1A+0RFnQiqMWUVPiQgM17bvwPvBR9O8N+LDpDGiQYWqszi77ytmhk/O16QLPV7PKNVYQBVs1cLvqtxoRLwGMbdcko/ThSeK/g/ccyvOj2ydpVAO6IQnk3v/JK3T8EBlTCavcGIIC5qGq+sKigHMCIyblf6x0U55Jc4GQEyKbYAtvlFo5gY1RwbMmjAF1sxLHArOkxOYLQa6kHVAk6hlt4ECLQ+H31y9MTmW+nj9py2pZ80HxjYZSAMTbdrLll/Ug8vVy9fy016pGaaQZOEYHmbbno6VqPBvtg8N+BqP9dSJBibyp/P7Bl8ptZSgt3IlhyUYZ2Edkl1BpJQBgluB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9R2FdzGc2IrjN1fEefZ5H0ISx+VAhxkLAF56V1LVIU=;
 b=Jk5gJqJB4NJ8GjUYZpLhPoSNd5D4Bl6p5R7XHg1iWsjD2G7LvFOluRnNCQt1YXC5vf+m2SAHOlcLkWGvCS0K1CK0rm9LO6u1lx5Y1p3IBatWcDqZPRXk5hKv4SWrURfYO8nUfbAzZak/t/Tt5rvLczpyIoGxGErZU4Lr3Y3EuCbMDLTyx7Ngs9iGa1mQ7kPEXrN4cSywEigHje4ft+ZjNG3GU6dRGPYcCWjOTPEDohKzpdpuRNR61w+fqj9A6Qxfw96wm6Hjl+iM13U6Z8t1VE/NZCk/7Yr3sVJORQzAdmeMGYrq0xja/Se5hPhxMATli+VdHKtthGaSBnLuZEhwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9R2FdzGc2IrjN1fEefZ5H0ISx+VAhxkLAF56V1LVIU=;
 b=QzpA6RJzH9S4FaRfCPoy8YYILe3DG4Clj196rBTqdz6l2jl7bHpDADy19KX9Yfgy84a7LbJ4y5E/C+AG5jpHgD3w6+Vhl2EJd9Il1n9Jpd5psJF/sC5TM1cP+/8yUqGXIQ+1dXONYpF/ZR7d0Z4Rvv2fUWHMGASVwNE4zlmX+b4=
Received: from CH2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:610:4c::18)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:39 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::a5) by CH2PR10CA0008.outlook.office365.com
 (2603:10b6:610:4c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:38 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:26 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 17/64] drm/amd/display: Fold GFX6-8 tiling and modifier tests
Date: Wed, 16 Sep 2026 13:51:32 -0400
Message-ID: <20260916175301.368306-18-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 641d2d29-dfc9-4569-6343-08df141b4c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: DxuzshR0EYocbdGd1X3O7Jkg+LnXcIw/bcxv4b/CbinNVj1UTfL56Omm611eALYX9PgmxkQLBwOTWOWEWgrnrF2MVcICvnqcC107kPu5qKF2FouvQny7EGyghovppOAQpT3sPbx83CMk5NTpJEdraX5FGkdfoc8fh87RPB1Nc/hzKjFE27JGyiJcP+ixDOcBoDwm4aIral27RVSmN2khPL7uVsWcVQcEk8GE8TKMxF7r623Elhn4qMdhg5qSpGHFyDib3n3T/b3K37YlJF7e6iycJ/Exf/8+VqdRzzYu5zgfVPRpk6EyYLGyLti+WeNr89H1Cj/OVz+wrPBtPXGfKLZ4Vud6+4wA9X7EkrMMXwxlGRFoc3+SRLVkvKX/5jWtoPWkQkk4S0fWRqdsqmeePeNJBOQHvRISnMAS3P2MB2LaoeTx/2sgBvt+yu4R2G7Z+wIIuls6+Dwa6B+fqqkfkvHPVeQSO9nNaubfKpjDhMmqAPV1BqaqKAep6iePz+dfZ4zvlo0si1AJBhiA5E4daQDb6oks87Q+/mbHMLHw+YDWlPHilj2kuRFrhvwJ19bZI7jJlGNI6kyf2w++h+Ha3fzN0bgIjBkkXbzXtoiXv1dzdiYsqsJIqD3ifPaIJoHZjHI1908YQ8k623w16bFTjkI6SEkxCfPgLi9FMdplSQxUkAfn7X7k/0jbdZxg9XCNxvM13ojKdYRxoaL8Vbi2iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K9HHjQ7wcFfxE8+EhcnRn8JIGNevKvGveb1mJQw5TS0LwaGyjtzrvOzjLCvuvzdr6kDQyU+2mvG5KMXFCz05fur59C5TqhQwDFnFn0kPME3R7a0/xYLVUnAB6DhcvVUkxsNb2bmI9nsGygK2SWpVglXpdYjcFZ8rE/TnvmZn5Dv7JwQt+oj16pR+LxXxtzdxHB2+VxMBbVxXC0nLJS6iQD5oyQrWyQtIqKPC15uLsQjJigX+vv+0PGn0VQHsQRi3rrHdgQQRhwDBILZa6kWLrgvq1MBsok9ZZZQ2Yz9B+WgqT2zB9Qe/q29u05WSRlz6B5BEohZdJvFiKlRtGK9KJkSGQ10U6cQZDU94J4JU5QBlvDcVBZ6CijjuXu8YNW0UweMTR0GxN11gk/Z8pdR3dEFHvsNERJJrWxuidrhIAU85Bl6JVTyhQ+0+uPh9DhaJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:38.8631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641d2d29-dfc9-4569-6343-08df141b4c73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
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

[WHAT]
Reduce the four KUnit tests for
amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier() to one, and the
three for amdgpu_dm_plane_calc_gfx6_mod() to one.

[HOW]
Build the linear, rejected, 1D tiled and 2D tiled modifiers as locals
and decode them in sequence, and drive the micro tiled, GFX7-8 and GFX6
modifier calculations from two devices inside a single test.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 148 ++++++------------
 1 file changed, 46 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 34eef4fbd833..b8489a0b185e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3035,80 +3035,50 @@ static int dm_test_gfx6_tiling(struct dc_tiling_info *tiling_info, u64 modifier)
 }
 
 /**
- * dm_test_fill_gfx6_tiling_info_linear() - Verify linear modifier decoding.
+ * dm_test_fill_gfx6_tiling_info_from_modifier() - Verify GFX6-8 modifier decoding.
  * @test: KUnit test context.
  *
- * Verify if a linear modifier maps to the generic linear array mode.
+ * Verify if a linear modifier maps to the generic linear array mode, if non-AMD
+ * modifiers and newer tile versions are rejected, if a 1D tiled modifier stops
+ * before the macro tiling fields, and if a 2D tiled modifier decodes them all.
  */
-static void dm_test_fill_gfx6_tiling_info_linear(struct kunit *test)
+static void dm_test_fill_gfx6_tiling_info_from_modifier(struct kunit *test)
 {
 	struct dc_tiling_info tiling_info = {0};
+	u64 not_amd_mod = DRM_FORMAT_MOD_VENDOR_AMD;
+	u64 gfx9_mod = AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9);
+	u64 mod_1d = AMD_FMT_MOD |
+		     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+		     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1) |
+		     AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY) |
+		     AMD_FMT_MOD_SET(NUM_BANKS, 3);
+	u64 mod_2d = AMD_FMT_MOD |
+		     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+		     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) |
+		     AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY) |
+		     AMD_FMT_MOD_SET(PIPE_CONFIG, 5) |
+		     AMD_FMT_MOD_SET(TILE_SPLIT, 4) |
+		     AMD_FMT_MOD_SET(BANK_WIDTH, 1) |
+		     AMD_FMT_MOD_SET(BANK_HEIGHT, 2) |
+		     AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, 3) |
+		     AMD_FMT_MOD_SET(NUM_BANKS, 2);
 
 	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, DRM_FORMAT_MOD_LINEAR), 0);
 	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.array_mode, (int)DC_ARRAY_LINEAR_GENERAL);
 	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxVersion8);
-}
-
-/**
- * dm_test_fill_gfx6_tiling_info_rejects() - Verify unsupported modifiers fail.
- * @test: KUnit test context.
- *
- * Verify if non-AMD modifiers and AMD modifiers from a newer tile version are
- * rejected.
- */
-static void dm_test_fill_gfx6_tiling_info_rejects(struct kunit *test)
-{
-	struct dc_tiling_info tiling_info = {0};
-	u64 not_amd_mod = DRM_FORMAT_MOD_VENDOR_AMD;
-	u64 gfx9_mod = AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9);
 
 	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, not_amd_mod), -EINVAL);
 	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, gfx9_mod), -EINVAL);
-}
 
-/**
- * dm_test_fill_gfx6_tiling_info_1d() - Verify micro tiled modifier decoding.
- * @test: KUnit test context.
- *
- * Verify if a 1D tiled modifier stops before decoding the macro tiling fields.
- */
-static void dm_test_fill_gfx6_tiling_info_1d(struct kunit *test)
-{
-	struct dc_tiling_info tiling_info = {0};
-	u64 modifier = AMD_FMT_MOD |
-		       AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
-		       AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1) |
-		       AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY) |
-		       AMD_FMT_MOD_SET(NUM_BANKS, 3);
-
-	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, modifier), 0);
+	memset(&tiling_info, 0, sizeof(tiling_info));
+	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, mod_1d), 0);
 	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.array_mode,
 			(int)AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1);
 	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxVersion8);
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.num_banks, 0U);
-}
 
-/**
- * dm_test_fill_gfx6_tiling_info_2d() - Verify macro tiled modifier decoding.
- * @test: KUnit test context.
- *
- * Verify if a 2D tiled modifier decodes the full set of macro tiling fields.
- */
-static void dm_test_fill_gfx6_tiling_info_2d(struct kunit *test)
-{
-	struct dc_tiling_info tiling_info = {0};
-	u64 modifier = AMD_FMT_MOD |
-		       AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
-		       AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) |
-		       AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY) |
-		       AMD_FMT_MOD_SET(PIPE_CONFIG, 5) |
-		       AMD_FMT_MOD_SET(TILE_SPLIT, 4) |
-		       AMD_FMT_MOD_SET(BANK_WIDTH, 1) |
-		       AMD_FMT_MOD_SET(BANK_HEIGHT, 2) |
-		       AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, 3) |
-		       AMD_FMT_MOD_SET(NUM_BANKS, 2);
-
-	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, modifier), 0);
+	memset(&tiling_info, 0, sizeof(tiling_info));
+	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, mod_2d), 0);
 	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.array_mode,
 			(int)AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1);
 	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.tile_mode,
@@ -3235,35 +3205,26 @@ static void dm_test_get_gfx7_macro_tile_idx(struct kunit *test)
 }
 
 /**
- * dm_test_calc_gfx6_mod_1d() - Verify the micro tiled GFX6-8 modifier.
+ * dm_test_calc_gfx6_mod() - Verify the GFX6-8 modifier calculation.
  * @test: KUnit test context.
  *
  * Verify if a micro tiled array mode returns early with only the base modifier
- * fields set.
+ * fields set, if GFX7-8 combines the tile mode pipe config and computed tile
+ * split with the bank fields from the macro tile mode table, and if GFX6 takes
+ * the tile split and bank fields directly from the tile mode register.
  */
-static void dm_test_calc_gfx6_mod_1d(struct kunit *test)
+static void dm_test_calc_gfx6_mod(struct kunit *test)
 {
 	struct amdgpu_device *adev = dm_test_alloc_gfx7_device(test);
-	u64 expected = AMD_FMT_MOD |
-		       AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
-		       AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1) |
-		       AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY);
+	struct amdgpu_device *si_adev;
+	u64 expected_1d = AMD_FMT_MOD |
+			  AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+			  AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1) |
+			  AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY);
 
 	KUNIT_EXPECT_EQ(test,
 			amdgpu_dm_plane_calc_gfx6_mod(adev, 0, DC_ARRAY_1D_TILED_THIN1),
-			expected);
-}
-
-/**
- * dm_test_calc_gfx6_mod_gfx7() - Verify the macro tiled GFX7-8 modifier.
- * @test: KUnit test context.
- *
- * Verify if the modifier combines the tile mode pipe config and computed tile
- * split with the bank fields taken from the macro tile mode table.
- */
-static void dm_test_calc_gfx6_mod_gfx7(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_test_alloc_gfx7_device(test);
+			expected_1d);
 
 	/* 32 bpp: 256 byte tile split (log2 of 4 units), macro tile mode 2. */
 	KUNIT_EXPECT_EQ(test,
@@ -3274,30 +3235,18 @@ static void dm_test_calc_gfx6_mod_gfx7(struct kunit *test)
 	KUNIT_EXPECT_EQ(test,
 			amdgpu_dm_plane_calc_gfx6_mod(adev, 64, DC_ARRAY_2D_TILED_THIN1),
 			dm_test_gfx6_mod(AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1, 2, 3, 2, 2, 2, 0));
-}
 
-/**
- * dm_test_calc_gfx6_mod_si() - Verify the macro tiled GFX6 modifier.
- * @test: KUnit test context.
- *
- * Verify if GFX6 takes the tile split and bank fields directly from the tile
- * mode register instead of the macro tile mode table.
- */
-static void dm_test_calc_gfx6_mod_si(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
+	si_adev = kunit_kzalloc(test, sizeof(*si_adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, si_adev);
 
-	adev->family = AMDGPU_FAMILY_SI;
+	si_adev->family = AMDGPU_FAMILY_SI;
 	/* 2D_TILED_THIN1, pipe config 3, 256 byte tile split, banks 1/2/3/1. */
-	adev->gfx.config.tile_mode_array[12] = (4u << 2) | (3u << 6) | (2u << 11) |
-					       (1u << 14) | (2u << 16) | (3u << 18) |
-					       (1u << 20);
+	si_adev->gfx.config.tile_mode_array[12] = (4u << 2) | (3u << 6) | (2u << 11) |
+						  (1u << 14) | (2u << 16) | (3u << 18) |
+						  (1u << 20);
 
 	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TILED_THIN1),
+			amdgpu_dm_plane_calc_gfx6_mod(si_adev, 32, DC_ARRAY_2D_TILED_THIN1),
 			dm_test_gfx6_mod(AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1, 3, 2, 1, 2, 3, 1));
 }
 
@@ -3911,10 +3860,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_add_modifier_dedup() */
 	KUNIT_CASE(dm_test_add_modifier_dedup),
 	/* amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier() */
-	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_linear),
-	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_rejects),
-	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_1d),
-	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_2d),
+	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_from_modifier),
 	/* amdgpu_dm_plane_get_gfx6_tile_idx() */
 	KUNIT_CASE(dm_test_get_gfx6_tile_idx),
 	/* amdgpu_dm_plane_calc_gfx7_tile_split() */
@@ -3922,9 +3868,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_get_gfx7_macro_tile_idx() */
 	KUNIT_CASE(dm_test_get_gfx7_macro_tile_idx),
 	/* amdgpu_dm_plane_calc_gfx6_mod() */
-	KUNIT_CASE(dm_test_calc_gfx6_mod_1d),
-	KUNIT_CASE(dm_test_calc_gfx6_mod_gfx7),
-	KUNIT_CASE(dm_test_calc_gfx6_mod_si),
+	KUNIT_CASE(dm_test_calc_gfx6_mod),
 	/* amdgpu_dm_plane_gfx6_format_mod_supported() */
 	KUNIT_CASE(dm_test_gfx6_format_mod_supported),
 	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_device() */
-- 
2.55.0

