Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98124C44508
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E44110F6D8;
	Thu,  9 Jul 2026 21:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TUN2eqQv";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DAE10F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W01ewxcwXebEc56Oj+o/lk2wheMWZyarSZdhdCS6BMUOc9b2zZAQVLImx6Orz3ynhM0V4uCVbhuyvPxC1PtWMZbcM+o7TH+r6hntVUpll8y9nppYBRUrGlvdpHliKjz6fHgRQTZVGLX7IIMyT+P8b4U+9IQPRAU5MMmrVugXZfg3d1O40Y+BHzl6ISPSp1U856F6ZQxkl4NX8fCVojeY3OnED01QXaq4ACWZU82AT3/yY4Eml0xt3UY1jayhdohQTkwSf+F3c36n/szKGJtROtbDygIoEY+bl0txEH8wamrdRzkKcken9Qe6ZOhX15p+rnm77dgNbasNjC254bwkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrfS25KkAOXt7eDY3Or0OPeYlSar+bAlqN69AU/T2uU=;
 b=qe9pnfXW/MzvJ0uByznfRakLxKbacBG3ldIPUxzhoV6gXmHQItn7J8kDzWtJvIFiETJfQx4IegHRwsD+tAqKy8dAwwS9FpNc0O4u3K2i5EjOx4YGPq0yiYJflmJTXospwpkNrEQMoc1cuXF2HkrVKWewPyPDRGisSQLR0O1d9SfaL/CPRFh9Nm22yyuABCzXE87LeefJA8oz10pu4cyvGUsiSZdHdvDi2CvXZ+CjW82xfzGpg5ujhiEjeSexldbZSI+zR7vbP43wndyd3Rcv4RibZana1iYtv9UxiqfcwaPoM1KsLNmeBdXEA6kda7Osl/trnVMU42YtHc2kl2Womg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrfS25KkAOXt7eDY3Or0OPeYlSar+bAlqN69AU/T2uU=;
 b=TUN2eqQvvMv2LZteRl9toBmNqN/XHmFq3ISYzduFsZphKpB9X+zxcE+NuS1hKsSerWd7KZbQ+CiSUvFzNZpvyEC03GPtkfAF9xMNO0WmiHz931ag9cN5+d/98rd51AmlKkwT6Lo2zu0ZqsyGTyb1Eu4nItaQRacNht4co463hMM=
Received: from MN0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:208:52d::6)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 9 Jul
 2026 21:02:30 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::4) by MN0PR04CA0004.outlook.office365.com
 (2603:10b6:208:52d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:29 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:11 -0500
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
Subject: [PATCH 46/80] drm/amd/display: Test GFX11/GFX12 plane modifiers
Date: Thu, 9 Jul 2026 16:48:14 -0400
Message-ID: <20260709205936.5719-47-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: f194ea89-0f83-4d75-3680-08deddfd6379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|56012099006|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RQstCQ7EcNWVyTcbHCmwgIgkc0aKBqLOQTk7pp5xhvi73OyHCMiKHvcej0vAhj0yGoWsLQ1wazdPRcpBrs0T9aiEcLcPP3wSsmerPcodSQve96J8gcI5oKqQofnxB9DAKzLkqKkpnVa8nzAPDo3muXLF+haBYiqWs/eqoyjrfdKPOGO2ReEZnchQ+Ulxvd1W73Ae9+cNFIYAChxb3B3RgzLRn8lcjqPQZjaj4dijBqO181/RhW7EhKVKaLtt3PJn8F/hMbsAHQCcjQGXTtEd8tbOBm2spbWKti/nDdg+ItejUZLZ9/3EEw+JOD8hSJ2R/2OZ5g6E2zqX8R2Q5ysiDkoxsb1QUFMaV42J4nQpWKUmtngvIh6VzUuYWVs9lFrzb7CPKlHRV9CLZHMANP1exWTENDclTkP/8PusjRc6FjzAjJpxjH+LXVdgNqfjHoWU8Abv7SnrveR4sBcJOaHmsq8Pk5AJUtobLwDPGVA9Lm5lhrEEyWzHoSBuTaOaLeaJit/wXvMG9/cGPyRLKAqjLlc5LDynrUSqJD8DYQjZJ2EmLpQavfEkzGlVJG62YVbrRa5EC17pS+56K9AcL3M/YuJUNVBg8X51pxSaUEEbeckOCcuy4hEyPmVTx5j4TRQAqNv67ZYyFoFEzP0b5WqN9iYTLRe7eU699dYqaiWgCGXTfj8O0r30fiZ0PytOunWnR4K7gSF0ltDltszrtYl6+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wli5h0RCCGrSkzXwAph+OFX50t1e4aau5slg7c4YDLn062aVJP2LZrocOuRe7VC2EOg6zoWZDVq2Kldi5MIc+uC712CjyGgAwcx3mSlarHnRmiAtsv4TakQ7+hy9yTYi4yvftQdhT4ivEgAdVSHtN5UyQBfIs8JbcjB0IXvtNzVKmJz7EO0CB3/IyAy6bHECwy+cLfLtzX2o9v4iMW2fAxA6JCm8GKChm7U8ucr8orTTB6NYt9P59EZF3L9y0l3YWhv2f2rC6FafYjYxZsCx5wDDqOyk7ipwUhx3YsX8edVFsTCqQLAhye+pzEgCtZAFFblJxxahriGExGGtxgkKAfrVmIw6vZm1ayPAl7gfMGPnIfnkb3XY/3gsTuYugHPRjygPSkG50PeJQFyX3qpqC6vpn4ckO8OW2nd/dgleE2niqkob1Cn8PFtztmRv1tSA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:29.8175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f194ea89-0f83-4d75-3680-08deddfd6379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093
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
Add KUnit tests for amdgpu_dm_plane_get_plane_modifiers() on GFX11
(64K-first and 256K-first) and GFX12 devices.

Add a register-read mock (dm_test_gfx11_reg_ctx and friends) and
device-setup helpers so the GFX11 DCC modifier ordering can be checked
without real hardware.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 179 ++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 9cf43e732eb5..e1171c6dafe3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -26,6 +26,39 @@ struct dm_test_dcc_cap_ctx {
 
 static struct dm_test_dcc_cap_ctx *dm_test_dcc_ctx;
 
+struct dm_test_gfx11_reg_ctx {
+	u32 gb_addr_config;
+	u32 gc_reg_offsets[1];
+	u32 expected_reg;
+	u32 captured_reg;
+	u32 captured_acc_flags;
+	u32 captured_hwip;
+	u32 captured_xcc_id;
+	bool called;
+};
+
+static struct dm_test_gfx11_reg_ctx *dm_test_gfx11_reg_ctx;
+
+static u32 dm_test_gfx11_rreg32(struct amdgpu_device *adev,
+				u32 reg, u32 acc_flags, u32 hwip,
+				u32 xcc_id)
+{
+	if (!dm_test_gfx11_reg_ctx)
+		return 0;
+
+	dm_test_gfx11_reg_ctx->called = true;
+	dm_test_gfx11_reg_ctx->captured_reg = reg;
+	dm_test_gfx11_reg_ctx->captured_acc_flags = acc_flags;
+	dm_test_gfx11_reg_ctx->captured_hwip = hwip;
+	dm_test_gfx11_reg_ctx->captured_xcc_id = xcc_id;
+
+	return dm_test_gfx11_reg_ctx->gb_addr_config;
+}
+
+static const struct amdgpu_rlc_reg_funcs dm_test_gfx11_reg_funcs = {
+	.rreg32 = dm_test_gfx11_rreg32,
+};
+
 static bool dm_test_get_dcc_compression_cap(const struct dc *dc,
 					    const struct dc_dcc_surface_param *input,
 					    struct dc_surface_dcc_cap *output)
@@ -1268,6 +1301,48 @@ static u64 *dm_test_get_primary_mods(struct kunit *test, struct amdgpu_device *a
 	return mods;
 }
 
+static void dm_test_setup_gfx11_device(struct amdgpu_device *adev,
+				       struct dm_test_gfx11_reg_ctx *ctx,
+				       u32 num_pkrs_log2, u32 num_pipes_log2)
+{
+	ctx->gb_addr_config =
+		REG_SET_FIELD(0, GB_ADDR_CONFIG, NUM_PKRS, num_pkrs_log2) |
+		REG_SET_FIELD(0, GB_ADDR_CONFIG, NUM_PIPES, num_pipes_log2);
+	ctx->gc_reg_offsets[regGB_ADDR_CONFIG_BASE_IDX] = 0;
+	ctx->expected_reg = ctx->gc_reg_offsets[regGB_ADDR_CONFIG_BASE_IDX] +
+			    regGB_ADDR_CONFIG;
+	dm_test_gfx11_reg_ctx = ctx;
+
+	adev->family = AMDGPU_FAMILY_GC_11_0_0;
+	adev->reg_offset[GC_HWIP][0] = ctx->gc_reg_offsets;
+	adev->gfx.rlc.reg_funcs = &dm_test_gfx11_reg_funcs;
+}
+
+static u64 dm_test_gfx11_dcc_best_modifier(u32 pipe_xor_bits, u32 pkrs, u32 tile)
+{
+	return AMD_FMT_MOD |
+	       AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
+	       AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+	       AMD_FMT_MOD_SET(TILE, tile) |
+	       AMD_FMT_MOD_SET(PACKERS, pkrs) |
+	       AMD_FMT_MOD_SET(DCC, 1) |
+	       AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+	       AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B);
+}
+
+static u64 dm_test_gfx11_dcc_4k_modifier(u32 pipe_xor_bits, u32 pkrs, u32 tile)
+{
+	return AMD_FMT_MOD |
+	       AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
+	       AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+	       AMD_FMT_MOD_SET(TILE, tile) |
+	       AMD_FMT_MOD_SET(PACKERS, pkrs) |
+	       AMD_FMT_MOD_SET(DCC, 1) |
+	       AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+	       AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+	       AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B);
+}
+
 /**
  * dm_test_get_plane_formats_overlay_universal_cap() - Verify universal overlay.
  * @test: KUnit test context.
@@ -1466,6 +1541,107 @@ static void dm_test_get_plane_modifiers_gfx10_3(struct kunit *test)
 	dm_test_expect_mods_terminated(test, adev);
 }
 
+/**
+ * dm_test_get_plane_modifiers_gfx11_64k_first() - Verify GFX11 small-pipe order.
+ * @test: KUnit test context.
+ *
+ * Verify if GFX11 modifier generation reads GB_ADDR_CONFIG through the RLC
+ * register callback and prefers 64K_R_X when the pipe count is 16 or lower.
+ */
+static void dm_test_get_plane_modifiers_gfx11_64k_first(struct kunit *test)
+{
+	struct dm_test_gfx11_reg_ctx ctx = {0};
+	struct amdgpu_device *adev;
+	u64 *mods;
+	u32 pipe_xor_bits = 4;
+	u32 pkrs = 1;
+	u32 tile = AMD_FMT_MOD_TILE_GFX9_64K_R_X;
+	u64 dcc_best;
+	u64 dcc_4k;
+	u64 d_mod;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	dm_test_setup_gfx11_device(adev, &ctx, pkrs, pipe_xor_bits);
+
+	mods = dm_test_get_primary_mods(test, adev);
+	dcc_best = dm_test_gfx11_dcc_best_modifier(pipe_xor_bits, pkrs, tile);
+	dcc_4k = dm_test_gfx11_dcc_4k_modifier(pipe_xor_bits, pkrs, tile);
+	d_mod = AMD_FMT_MOD |
+		AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
+		AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D);
+
+	KUNIT_EXPECT_TRUE(test, ctx.called);
+	KUNIT_EXPECT_EQ(test, ctx.captured_reg, ctx.expected_reg);
+	KUNIT_EXPECT_EQ(test, ctx.captured_acc_flags, 0U);
+	KUNIT_EXPECT_EQ(test, ctx.captured_hwip, (u32)GC_HWIP);
+	KUNIT_EXPECT_EQ(test, ctx.captured_xcc_id, 0U);
+	KUNIT_EXPECT_EQ(test, mods[0], dcc_best);
+	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, dcc_4k));
+	KUNIT_EXPECT_TRUE(test,
+			  dm_test_mods_contain(mods,
+					       dcc_best | AMD_FMT_MOD_SET(DCC_RETILE, 1)));
+	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, d_mod));
+
+	dm_test_gfx11_reg_ctx = NULL;
+	kfree(mods);
+}
+
+/**
+ * dm_test_get_plane_modifiers_gfx11_256k_first() - Verify GFX11 large-pipe order.
+ * @test: KUnit test context.
+ *
+ * Verify if GFX11 modifier generation prefers 256K_R_X when more than 16 pipes
+ * are reported by GB_ADDR_CONFIG.
+ */
+static void dm_test_get_plane_modifiers_gfx11_256k_first(struct kunit *test)
+{
+	struct dm_test_gfx11_reg_ctx ctx = {0};
+	struct amdgpu_device *adev;
+	u64 *mods;
+	u32 pipe_xor_bits = 5;
+	u32 pkrs = 2;
+	u32 tile = AMD_FMT_MOD_TILE_GFX11_256K_R_X;
+	u32 fallback_tile = AMD_FMT_MOD_TILE_GFX9_64K_R_X;
+	u64 dcc_best;
+	u64 fallback_dcc_best = dm_test_gfx11_dcc_best_modifier(pipe_xor_bits, pkrs,
+								  fallback_tile);
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	dm_test_setup_gfx11_device(adev, &ctx, pkrs, pipe_xor_bits);
+
+	mods = dm_test_get_primary_mods(test, adev);
+	dcc_best = dm_test_gfx11_dcc_best_modifier(pipe_xor_bits, pkrs, tile);
+
+	KUNIT_EXPECT_TRUE(test, ctx.called);
+	KUNIT_EXPECT_EQ(test, ctx.captured_reg, ctx.expected_reg);
+	KUNIT_EXPECT_EQ(test, mods[0], dcc_best);
+	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, fallback_dcc_best));
+
+	dm_test_gfx11_reg_ctx = NULL;
+	kfree(mods);
+}
+
+/**
+ * dm_test_get_plane_modifiers_gfx12() - Verify GFX12 modifier list generation.
+ * @test: KUnit test context.
+ *
+ * Verify if the GFX12 family dispatches to the GFX12 modifier builder and
+ * produces a terminated list.
+ */
+static void dm_test_get_plane_modifiers_gfx12(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_GC_12_0_0;
+
+	dm_test_expect_mods_terminated(test, adev);
+}
+
 /**
  * dm_test_format_mod_supported_d_swizzle_reject() - Verify D swizzle rejection.
  * @test: KUnit test context.
@@ -1522,6 +1698,9 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_get_plane_modifiers_rv_constant_encode),
 	KUNIT_CASE(dm_test_get_plane_modifiers_gfx10_1),
 	KUNIT_CASE(dm_test_get_plane_modifiers_gfx10_3),
+	KUNIT_CASE(dm_test_get_plane_modifiers_gfx11_64k_first),
+	KUNIT_CASE(dm_test_get_plane_modifiers_gfx11_256k_first),
+	KUNIT_CASE(dm_test_get_plane_modifiers_gfx12),
 	/* amdgpu_dm_plane_fill_dc_scaling_info() */
 	KUNIT_CASE(dm_test_fill_dc_scaling_info),
 	/* amdgpu_dm_plane_get_min_max_dc_plane_scaling() */
-- 
2.55.0

