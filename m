Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B6FC982D0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF6C410E973;
	Wed, 16 Sep 2026 17:52:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E4pocBPx";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D677410E80C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srrhoWLdblXBdsc3zsV8Jza2MsofW0xPXgGgczQM6QEgJJMRxxkLKPuWqIYI6YZUXBwMc+BeOyK1/6nrEH1a3KeO62sOGAZs7COcWRohC4f0Gp1OzbBQ5uiN4Cf1hhm3NKZ8PCduWGhoIv4DYTbiQNjm4C1mYVUEuynoVD8EexZfZedWd3w7M2ePdVkeyDvtzE9U8+ulIh8pa1a5iMhXmtMBYrwHM8el9gfhxq2YjO98vdgNVDc+kpM7wMVLlp7ks2/HcN8D1EJ+yR5cIGN7IQPGAXUaaJ5gtZHWY9ZdrKHWvqES14/AtEPtKPV+RCokZRw8VZoFq0NCNaoNhNqwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvH4t4J4lisGSYwr3lyQnLaanD/FeXO4wlTCIFfXi1g=;
 b=K4zWN7Ol9lfgSKdXcGei2Ujo9IFjKMrGQMf3WC8zLB/yHZA5T8qR7X2X5lzaevevgQd6yAzI2No9+lRUKHBcLG0QcwU0vIuR8EP1bc1zu9GNMRaa7LnpeqH0nNKs0Wi74WCcFy5cavbMib0bC/+QuNyJIu/LtAzfqvtR+chkeK6Ls/dbQ/vM3O8YYhSwt/8pfrRMJROOpFZ1zRRq791HXJOuWwfvO1Abfk4gX6HxCeTPNMwSMJGw3q+3OeRzEt72L79GI4l74bZS6MtqEFcl6CyWwl6p2NX6KK/jisRtbbo0e5oDxphHOLNlen4Y8rczVPxj9YKqG/+j2CVlGUSSww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvH4t4J4lisGSYwr3lyQnLaanD/FeXO4wlTCIFfXi1g=;
 b=E4pocBPxoCIwvEGiLBtxABhRVq/6LuqlfGwrEXu4o5Lh+ZYD3FY3CBIO9MUiQHOp1i1aIdpCNsbpfSEp7tt4tSLQH2b9jVO1ZSrlZdO2WWPa6QkgBVxUFQKpJMLrbKn9PYKejzd0uwWX1Lpo3E2Kbhn5fJSpWf0lk76jQ63ohGQ=
Received: from CH0PR03CA0248.namprd03.prod.outlook.com (2603:10b6:610:e5::13)
 by DS1PR12MB999190.namprd12.prod.outlook.com (2603:10b6:8:495::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:52:39 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::21) by CH0PR03CA0248.outlook.office365.com
 (2603:10b6:610:e5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:39 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:28 -0500
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
Subject: [PATCH 19/64] drm/amd/display: Fold DCC block mode tests
Date: Wed, 16 Sep 2026 13:51:34 -0400
Message-ID: <20260916175301.368306-20-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS1PR12MB999190:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4d271f-9c66-43ad-553c-08df141b4ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|56012099006|11063799006|5023799004|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sflNg0ce5LgP9hovWpZ89tlhB3Yq8YoBPz0alN3uygreAW4lHZxwWCJmxUln6jys+QUJmT12Hu+VpYyKeq0EShMg+LkReFUtAasKPSv17fvcB+i1WHJRDNndB2L18JEinC4qESvrJ1ahqUW8ssC/RB1To+U9k8zJkk9W6GQyvrpcBLVseKUcm9KY56Elu3NegktnSo6eKHGULLlIXf9bZnju44QAIUChc/fC/HmIiGtC2p9HRWbaQUGwrSquIkHklemQL2FO4E1xWoQt9GqqlPvtpreK/ebhQ7J2VVlPBrNIm7wfPnP+8D5Ngv2couoVWtSxXrL0S+q/VCQADPnoyobvuu0h8JF8QNPPVjJaIogaxf1VLE2gctMrX5+dFzlJoVxcm5d4aiZhHEX/XkAUA4C5jwVUv7snmdV9nLwOoeEW3CGg8hhKjWcuS9M5wg9eITfDT98EKdwBRMK98QlOmKOlu/8RaHZm/MN9g8r0EQLZ5JvPugWgAq0/RRRlD5F/x4Y8tvlJ1pDDjIO2qvL60RlTOOyEsgKwaPagur7bEs2biyPHtlUzl45zx2U6DGR3EJdUfZml06eLOaHMIbxulJI8SPqmH9RgEySUW1JBN9Gax3UPno1qkzp3Hkj6jJRhYqUQENsJTArnKSRyJhVRoYTl7hiPh+gTh7aTYvJaCOKXHMWwP2XlD71afNVHWjEsSaDVief5GjJNlJEroOqeYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(11063799006)(5023799004)(3023799007)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eZ4aUWSTFMJB3ddyvXYesEglbqTyrkQdU+ujJ+0Zqq6Vv86OvlFSpvye3nuhkjgfkawcfajJ/WnF7zlpFDeUQuqtn6W+Q9h5lI1nlJ+ixBNYFtCm/uzsYoG2MLtdpsdDK0mHgdOQskrVwUz3jXhXBltXMIKMRUn2fvsAAd/8Q3y4I9TNiNAd+AL2ll4xzXurBIAQMdn1/VvZIhXQH1ZztF+9p8V39URqXOyTY6hd6cJ62Z8m8ZLMv71FISfEtC62IGHIAuhMvYWQIOnDRSs64gRXb48PHA1o5pPL+qYadtkbih9cfAp9Fl9mUfycK6ozwb4nHdqQa5IJv0ReL2Zj1tG3oLnWZvYbjnMoRfMCwksbMNEh0GnZIS1tqAfWYNM6MydzY3JyVvkHqM2tfJOaDSFYGqEZMpJlD8b/a6YRJ4+PduLy3CqFv5cp6pzPMPC5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:39.4485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4d271f-9c66-43ad-553c-08df141b4ccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999190
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
Reduce the five KUnit tests for the GFX9 DCC block modes of
amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers() to one, and the three
for amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers() to one.

[HOW]
Drive both from a table of modifier bits and the expected HUBP
independent block mode, allocating the device, DC and framebuffer once
and resetting the tiling, DCC and address outputs per row.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 414 ++++--------------
 1 file changed, 86 insertions(+), 328 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 807c91bd8ab1..0d0a3199b464 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -492,65 +492,6 @@ static void dm_test_format_mod_supported(struct kunit *test)
 								listed_mod));
 }
 
-/**
- * dm_test_fill_gfx12_plane_attributes_from_modifiers() - Verify GFX12 DCC mapping path.
- * @test: KUnit test context.
- *
- * Verify if GFX12 modifier parsing enables DCC and sets expected DCC block mode.
- */
-static void dm_test_fill_gfx12_plane_attributes_from_modifiers(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct amdgpu_framebuffer *afb;
-	struct plane_size plane_size = {0};
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct dm_test_dcc_cap_ctx ctx = {
-		.callback_ret = true,
-		.capable = true,
-		.output_independent_64b_blks = false,
-	};
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-	KUNIT_ASSERT_NOT_NULL(test, afb);
-
-	adev->family = AMDGPU_FAMILY_GC_12_0_0;
-	adev->dm.dc = dc;
-	adev->gfx.config.gb_addr_config_fields.num_pipes = 2;
-	adev->gfx.config.gb_addr_config_fields.num_banks = 4;
-	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 256;
-	adev->gfx.config.gb_addr_config_fields.num_se = 1;
-	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 2;
-	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 1;
-	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
-	dm_test_dcc_ctx = &ctx;
-
-	afb->base.modifier = AMD_FMT_MOD |
-			     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D) |
-			     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
-			     AMD_FMT_MOD_SET(DCC, 1) |
-			     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, 1);
-	plane_size.surface_size.width = 1920;
-	plane_size.surface_size.height = 1080;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(
-			adev, afb, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
-			ROTATION_ANGLE_0, &plane_size, &tiling_info, &dcc, &address),
-			0);
-	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxAddr3);
-	KUNIT_EXPECT_TRUE(test, dcc.enable);
-	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk, (int)hubp_ind_block_128b);
-
-	dm_test_dcc_ctx = NULL;
-}
-
 /**
  * dm_test_fill_gfx9_plane_attributes_from_modifiers() - Verify basic GFX9 linear modifier path.
  * @test: KUnit test context.
@@ -1502,148 +1443,36 @@ static void dm_test_fill_gfx9_plane_attributes_validate_fails(struct kunit *test
 }
 
 /**
- * dm_test_fill_gfx9_plane_attributes_dcc_rbplus_64b_no_128bcl() - Verify block mode.
+ * dm_test_fill_gfx9_plane_attributes_dcc_ind_blk() - Verify DCC block modes.
  * @test: KUnit test context.
  *
- * Verify if a GFX10-RBPLUS modifier with both 64B and 128B independent block
- * bits selects the 64B-no-128BCL block mode.
+ * Verify if the independent 64B and 128B block bits of a GFX9 or GFX10-RBPLUS
+ * DCC modifier select the matching HUBP independent block mode.
  */
-static void dm_test_fill_gfx9_plane_attributes_dcc_rbplus_64b_no_128bcl(struct kunit *test)
+static void dm_test_fill_gfx9_plane_attributes_dcc_ind_blk(struct kunit *test)
 {
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct amdgpu_framebuffer *afb;
+	static const struct {
+		const char *name;
+		u64 tile_version;
+		bool independent_64b_blks;
+		bool independent_128b_blks;
+		int expected_ind_blk;
+	} cases[] = {
+		{ "rbplus 64B no 128BCL", AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS, true, true,
+		  hubp_ind_block_64b_no_128bcl },
+		{ "rbplus 128B", AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS, false, true,
+		  hubp_ind_block_128b },
+		{ "rbplus unconstrained", AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS, false, false,
+		  hubp_ind_block_unconstrained },
+		{ "gfx9 64B", AMD_FMT_MOD_TILE_VER_GFX9, true, false, hubp_ind_block_64b },
+		{ "gfx9 unconstrained", AMD_FMT_MOD_TILE_VER_GFX9, false, false,
+		  hubp_ind_block_unconstrained },
+	};
 	struct plane_size plane_size = {0};
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct dm_test_dcc_cap_ctx ctx = {0};
-	u64 tile_version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
-	int ret;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-	KUNIT_ASSERT_NOT_NULL(test, afb);
-
-	dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, true);
-	afb->base.modifier = dm_test_gfx9_dcc_modifier(tile_version, true, true);
-	plane_size.surface_size.width = 1920;
-	plane_size.surface_size.height = 1080;
-
-	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
-				 &address);
-	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_TRUE(test, dcc.enable);
-	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk,
-			(int)hubp_ind_block_64b_no_128bcl);
-
-	dm_test_dcc_ctx = NULL;
-}
-
-/**
- * dm_test_fill_gfx9_plane_attributes_dcc_rbplus_128b() - Verify 128B block mode.
- * @test: KUnit test context.
- *
- * Verify if a GFX10-RBPLUS modifier with only the 128B independent block bit
- * selects the 128B block mode.
- */
-static void dm_test_fill_gfx9_plane_attributes_dcc_rbplus_128b(struct kunit *test)
-{
 	struct amdgpu_device *adev;
-	struct dc *dc;
 	struct amdgpu_framebuffer *afb;
-	struct plane_size plane_size = {0};
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct dm_test_dcc_cap_ctx ctx = {0};
-	u64 tile_version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
-	int ret;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-	KUNIT_ASSERT_NOT_NULL(test, afb);
-
-	dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, false);
-	afb->base.modifier = dm_test_gfx9_dcc_modifier(tile_version, false, true);
-	plane_size.surface_size.width = 1920;
-	plane_size.surface_size.height = 1080;
-
-	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
-				 &address);
-	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_TRUE(test, dcc.enable);
-	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk, (int)hubp_ind_block_128b);
-
-	dm_test_dcc_ctx = NULL;
-}
-
-/**
- * dm_test_fill_gfx9_plane_attributes_dcc_rbplus_unconstrained() - Verify block mode.
- * @test: KUnit test context.
- *
- * Verify if a GFX10-RBPLUS modifier without independent block bits selects the
- * unconstrained block mode.
- */
-static void dm_test_fill_gfx9_plane_attributes_dcc_rbplus_unconstrained(struct kunit *test)
-{
-	struct amdgpu_device *adev;
 	struct dc *dc;
-	struct amdgpu_framebuffer *afb;
-	struct plane_size plane_size = {0};
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct dm_test_dcc_cap_ctx ctx = {0};
-	u64 tile_version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
-	int ret;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-	KUNIT_ASSERT_NOT_NULL(test, afb);
-
-	dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, false);
-	afb->base.modifier = dm_test_gfx9_dcc_modifier(tile_version, false, false);
-	plane_size.surface_size.width = 1920;
-	plane_size.surface_size.height = 1080;
-
-	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
-				 &address);
-	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_TRUE(test, dcc.enable);
-	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk,
-			(int)hubp_ind_block_unconstrained);
-
-	dm_test_dcc_ctx = NULL;
-}
-
-/**
- * dm_test_fill_gfx9_plane_attributes_dcc_gfx9_64b() - Verify legacy 64B mode.
- * @test: KUnit test context.
- *
- * Verify if a pre-RBPLUS GFX9 modifier with the 64B independent block bit
- * selects the 64B block mode.
- */
-static void dm_test_fill_gfx9_plane_attributes_dcc_gfx9_64b(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct amdgpu_framebuffer *afb;
-	struct plane_size plane_size = {0};
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct dm_test_dcc_cap_ctx ctx = {0};
-	int ret;
+	unsigned int i;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
@@ -1652,138 +1481,62 @@ static void dm_test_fill_gfx9_plane_attributes_dcc_gfx9_64b(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, dc);
 	KUNIT_ASSERT_NOT_NULL(test, afb);
 
-	dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, true);
-	afb->base.modifier = dm_test_gfx9_dcc_modifier(AMD_FMT_MOD_TILE_VER_GFX9,
-						       true, false);
 	plane_size.surface_size.width = 1920;
 	plane_size.surface_size.height = 1080;
 
-	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
-				 &address);
-	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_TRUE(test, dcc.enable);
-	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk, (int)hubp_ind_block_64b);
-
-	dm_test_dcc_ctx = NULL;
-}
-
-/**
- * dm_test_fill_gfx9_plane_attributes_dcc_gfx9_unconstrained() - Verify legacy mode.
- * @test: KUnit test context.
- *
- * Verify if a pre-RBPLUS GFX9 modifier without the 64B independent block bit
- * selects the unconstrained block mode.
- */
-static void dm_test_fill_gfx9_plane_attributes_dcc_gfx9_unconstrained(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct amdgpu_framebuffer *afb;
-	struct plane_size plane_size = {0};
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct dm_test_dcc_cap_ctx ctx = {0};
-	int ret;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-	KUNIT_ASSERT_NOT_NULL(test, afb);
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct dc_tiling_info tiling_info = {0};
+		struct dc_plane_dcc_param dcc = {0};
+		struct dc_plane_address address = {0};
+		struct dm_test_dcc_cap_ctx ctx = {0};
+		int ret;
 
-	dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, false);
-	afb->base.modifier = dm_test_gfx9_dcc_modifier(AMD_FMT_MOD_TILE_VER_GFX9,
-						       false, false);
-	plane_size.surface_size.width = 1920;
-	plane_size.surface_size.height = 1080;
+		dm_test_setup_gfx9_dcc_device(adev, dc, &ctx, cases[i].independent_64b_blks);
+		afb->base.modifier = dm_test_gfx9_dcc_modifier(cases[i].tile_version,
+							       cases[i].independent_64b_blks,
+							       cases[i].independent_128b_blks);
 
-	ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
-				 &address);
-	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_TRUE(test, dcc.enable);
-	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk,
-			(int)hubp_ind_block_unconstrained);
+		ret = dm_test_gfx9_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+					 &address);
+		dm_test_dcc_ctx = NULL;
 
-	dm_test_dcc_ctx = NULL;
+		KUNIT_EXPECT_EQ_MSG(test, ret, 0, "%s", cases[i].name);
+		KUNIT_EXPECT_TRUE_MSG(test, dcc.enable, "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, (int)dcc.dcc_ind_blk, cases[i].expected_ind_blk,
+				    "%s", cases[i].name);
+	}
 }
 
 /**
- * dm_test_fill_gfx12_plane_attributes_block0() - Verify GFX12 64B max-compressed-block path.
+ * dm_test_fill_gfx12_plane_attributes_dcc_blocks() - Verify GFX12 DCC blocks.
  * @test: KUnit test context.
  *
- * Verify if a zero max-compressed-block modifier selects the 64B independent
- * block mode on GFX12.
+ * Verify if the max-compressed-block field of a GFX12 DCC modifier selects the
+ * matching HUBP independent block mode and independent 64B flag, and if the
+ * GFX addr3 tiling version is reported.
  */
-static void dm_test_fill_gfx12_plane_attributes_block0(struct kunit *test)
+static void dm_test_fill_gfx12_plane_attributes_dcc_blocks(struct kunit *test)
 {
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct amdgpu_framebuffer *afb;
-	struct plane_size plane_size = {0};
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
+	static const struct {
+		const char *name;
+		u64 max_compressed_block;
+		bool independent_64b_blks;
+		int expected_ind_blk;
+	} cases[] = {
+		{ "64B", 0, true, hubp_ind_block_64b },
+		{ "128B", 1, false, hubp_ind_block_128b },
+		{ "unconstrained", 2, false, hubp_ind_block_unconstrained },
+	};
 	struct dm_test_dcc_cap_ctx ctx = {
 		.callback_ret = true,
 		.capable = true,
 		.output_independent_64b_blks = false,
 	};
-	int ret;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-	KUNIT_ASSERT_NOT_NULL(test, afb);
-
-	adev->family = AMDGPU_FAMILY_GC_12_0_0;
-	adev->dm.dc = dc;
-	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
-	dm_test_dcc_ctx = &ctx;
-
-	afb->base.modifier = AMD_FMT_MOD |
-			     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D) |
-			     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
-			     AMD_FMT_MOD_SET(DCC, 1) |
-			     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, 0);
-	plane_size.surface_size.width = 1920;
-	plane_size.surface_size.height = 1080;
-
-	ret = dm_test_gfx12_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
-				  &address);
-	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_TRUE(test, dcc.enable);
-	KUNIT_EXPECT_TRUE(test, dcc.independent_64b_blks);
-	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk, (int)hubp_ind_block_64b);
-
-	dm_test_dcc_ctx = NULL;
-}
-
-/**
- * dm_test_fill_gfx12_plane_attributes_block_unconstrained() - Verify block path.
- * @test: KUnit test context.
- *
- * Verify if a max-compressed-block value above one selects the unconstrained
- * independent block mode on GFX12.
- */
-static void dm_test_fill_gfx12_plane_attributes_block_unconstrained(struct kunit *test)
-{
+	struct plane_size plane_size = {0};
 	struct amdgpu_device *adev;
-	struct dc *dc;
 	struct amdgpu_framebuffer *afb;
-	struct plane_size plane_size = {0};
-	struct dc_tiling_info tiling_info = {0};
-	struct dc_plane_dcc_param dcc = {0};
-	struct dc_plane_address address = {0};
-	struct dm_test_dcc_cap_ctx ctx = {
-		.callback_ret = true,
-		.capable = true,
-		.output_independent_64b_blks = false,
-	};
-	int ret;
+	struct dc *dc;
+	unsigned int i;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
@@ -1795,25 +1548,36 @@ static void dm_test_fill_gfx12_plane_attributes_block_unconstrained(struct kunit
 	adev->family = AMDGPU_FAMILY_GC_12_0_0;
 	adev->dm.dc = dc;
 	dc->cap_funcs.get_dcc_compression_cap = dm_test_get_dcc_compression_cap;
-	dm_test_dcc_ctx = &ctx;
-
-	afb->base.modifier = AMD_FMT_MOD |
-			     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D) |
-			     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
-			     AMD_FMT_MOD_SET(DCC, 1) |
-			     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, 2);
 	plane_size.surface_size.width = 1920;
 	plane_size.surface_size.height = 1080;
 
-	ret = dm_test_gfx12_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
-				  &address);
-	KUNIT_EXPECT_EQ(test, ret, 0);
-	KUNIT_EXPECT_TRUE(test, dcc.enable);
-	KUNIT_EXPECT_FALSE(test, dcc.independent_64b_blks);
-	KUNIT_EXPECT_EQ(test, (int)dcc.dcc_ind_blk,
-			(int)hubp_ind_block_unconstrained);
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct dc_tiling_info tiling_info = {0};
+		struct dc_plane_dcc_param dcc = {0};
+		struct dc_plane_address address = {0};
+		int ret;
 
-	dm_test_dcc_ctx = NULL;
+		afb->base.modifier = AMD_FMT_MOD |
+				     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D) |
+				     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
+				     AMD_FMT_MOD_SET(DCC, 1) |
+				     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
+						     cases[i].max_compressed_block);
+		dm_test_dcc_ctx = &ctx;
+
+		ret = dm_test_gfx12_attrs(adev, afb, &plane_size, &tiling_info, &dcc,
+					  &address);
+		dm_test_dcc_ctx = NULL;
+
+		KUNIT_EXPECT_EQ_MSG(test, ret, 0, "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, (int)tiling_info.gfxversion, (int)DcGfxAddr3,
+				    "%s", cases[i].name);
+		KUNIT_EXPECT_TRUE_MSG(test, dcc.enable, "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, (bool)dcc.independent_64b_blks,
+				    cases[i].independent_64b_blks, "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, (int)dcc.dcc_ind_blk, cases[i].expected_ind_blk,
+				    "%s", cases[i].name);
+	}
 }
 
 /**
@@ -3712,19 +3476,13 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_format_mod_supported_d_swizzle_reject),
 	KUNIT_CASE(dm_test_format_mod_supported_gfx6),
 	/* amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers() */
-	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
-	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_block0),
-	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_block_unconstrained),
+	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_dcc_blocks),
 	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_validate_fails),
 	/* amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers() */
 	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_from_modifiers),
 	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc),
 	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_validate_fails),
-	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_rbplus_64b_no_128bcl),
-	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_rbplus_128b),
-	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_rbplus_unconstrained),
-	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_gfx9_64b),
-	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_gfx9_unconstrained),
+	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_ind_blk),
 	/* amdgpu_dm_plane_helper_check_state() */
 	KUNIT_CASE(dm_test_helper_check_state_viewport_reject),
 	KUNIT_CASE(dm_test_helper_check_state_small_viewport_width),
-- 
2.55.0

