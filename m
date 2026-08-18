Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DA5C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A69810ECC1;
	Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TE1miG/L";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A8310ECB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8Y38o4xCBsO8RXexVRFeeySzNnd7wk5sfw1y69pAiwPw5FviH6HDR/sXIrA6zR3xdP//gZSzeE0M6egOOLsotjxlQNLESh9++xky9b3WgLOIAnwZtg6ZR3pokVpT6ImSC8N9d/M5aFEeQSfT+HYTYJ6TTIilFo6US+04d9Fim/HRc+0034XIUq5jYbOj9tp1JHADU5eD+TjcPuF2p8arlNwFK5QyqlkCGLSQi7s4qoxzYw+OWCSHZPAFYM6cFt+BJUxB5c0+NXmqy4yNbltSVh53KrNqe5N7lADvibdC4NQ1X4BJczSclxR1Kz96xziBhJlPOFl0Lmrqt+6jZedfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INjbDcFqmVeG9iv9HmtF+uKqKkuwQUSVFbsSgVnnrhg=;
 b=qtLX/PruigaM7cyqcArjJ1OCUNWelpLoEuOxBGlWuiI+rsXB+QfTjA70OAX4AJ03MwVvASEEZQSygO4Wsr+dHxwsOyaq0k7mIS+KCuJ/ydE+FDES1p7scDE11ENf+ihfUpRH9l2rmDapWS+SeJogfBkN6RbnP8fCxgmUIflbf7mSQLlSQjNVL7yzy73IEs+OND5nFGtV0HL2jRm1173oZ35y8Ni05ylpeuWBBv3WJWIkmEP0jOhAi0bInvf6EDTi8q+7lD1iZ6FMGOp9iaROyAWYAFJDf9HCO52o1czbnM+50JERkp2WAEsqDy5yW3DtXw8g/SrNXSaIoVgY99t2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INjbDcFqmVeG9iv9HmtF+uKqKkuwQUSVFbsSgVnnrhg=;
 b=TE1miG/LvyO3d7vz3xU73iNa+bqHq2lSxhkgAmhHAv6viUPetxxPbuFwfO6ClDRCu4N9gV+XwfQd1VYm/T9ezh3Z/0Z8Ddo6NyzfMvQwKzITDXxkCe2t94J63R3/2Woh4vMxVGmkvr4e301IYXYTzV5+s9bpcmgL2cXJI1YA0/Q=
Received: from CH5P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::19)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:39 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::13) by CH5P222CA0007.outlook.office365.com
 (2603:10b6:610:1ee::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:28 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:27 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 48/82] drm/amd/display: Test GFX6-8 modifier calculation
Date: Tue, 18 Aug 2026 16:15:40 -0400
Message-ID: <20260818202139.4172592-49-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 45204952-6bac-47f8-d8ea-08defd667344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 20nLBLVv8dMwZPnz5181h14bdJxKUse/SALVF4K8yFFyS2jqZylBsyvQcOGQx/Yz8UE5aGOCrTul6mJE4btJpQ3QEvwqjRBrQwxBFzLfzw3QqqIibbXtGXIwCZ2b+XSpTXPed+1adJrcNMifZ/vaQDcNGm6RdDFyEosENtNbfXOWhloIEu4VC4fNzmurq21TrM6PMet68bzF2FLHzugpw1SIsGaSdjreXs03e5Txs9AkqT/RAQRJ3AR28p8jf+1RpGN2z20X8z062r6vu8BVhiiSkBUiEw9Kg3/QIbEGwlUpr/iTQGG+1iRxZaGmjn0w2E1tTbi9stN+zXhUAjrRLWEUYQKhBrq8kRbYOhMDfK/lM9UaozCRMaf/TiXTlM+6EvyAsSilcLWOsELqqTCjB70z/LrYqB9LFgseHIVZF1VNa1ILo7mbqc922+YkDXnjuF+rQRrNmJLJGChrxJ3aswWk6nsttcQgEbQuwgxdsKozXonKBWB7gmUgRiAR5MqpAkr+juz41qbdfqsnUeBG3rdEjk8DA3K+Vhzyncat9wo3btdo4KVxigN7ZYi2711xKqFerZOOsN+K/v7dvVrOJioGd8T45OjVBqpCbvzA45liKvDvClwSAh2nO5A6DSMeY9ogmW3cExwYqe38Nqs0PcaHt1vuX0MZRbcKQx3ThfSJ9BFQVpRoddPJywhm5htr5N9z21JvpQhjImLr30Qmyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 98z/P5027vsi7kOhwZMFc4y0bJFFBShEYv4CMO5vmcEHmdqAZh0KPvzS93HHFWhFDtvHys/ypTNnlGnW3dWKjqS9Y757ka5dk4LG1iAuaMS6jG5MIEZJCTJJUwlI0v0/WLasrB2VgLLYFjM8Rk7kTAWjimzSNTKhWUv5MA66k2EmiBWW66tuduLTATkivfsM0sNfPgN7kgDkJvvbaWafz1ZJGwmLPlPT5MC6HGgZVnVsKlHUJoRbyDPcV3UeKoJ/kQyxezmI4aQ3zhDlUf5YoTOkrQmnLJrmcyYJTPl4D8Uu8JRv3/0YgntvjRew2LD5+LyW6RgsYgdJxIvFXfftlEtorZxrtDrNSST2vvF3FvWPWCQjvXO4UNhDF8YUoovJUwklUuDSYXMqDedkfhwzbplRrDLyMT1/geAmv1UlAq+vVKRGoXj5ovBgQoKUqBuT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:39.5148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45204952-6bac-47f8-d8ea-08defd667344
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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
Add KUnit tests for amdgpu_dm_plane_calc_gfx6_mod() and
amdgpu_dm_plane_gfx6_format_mod_supported() covering the micro tiled
early return, the GFX7-8 macro tile mode table lookup, the GFX6 tile
mode register fields, and the rejection of foreign, DCC, newer tile
version, GFX9+ and non-displayable modifiers.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   4 +
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 146 ++++++++++++++++++
 3 files changed, 158 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index d6b80c380db85..b736cd13baaeb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -597,9 +597,9 @@ EXPORT_IF_KUNIT(amdgpu_dm_plane_get_gfx7_macro_tile_idx);
  * Select suitable micro and macro tile modes for the given bits per pixel,
  * and calculate the corresponding DRM format modifier.
  */
-static u64 amdgpu_dm_plane_calc_gfx6_mod(const struct amdgpu_device *adev,
-					 const u32 bpp,
-					 const enum array_mode_values arr)
+STATIC_IFN_KUNIT u64 amdgpu_dm_plane_calc_gfx6_mod(const struct amdgpu_device *adev,
+						   const u32 bpp,
+						   const enum array_mode_values arr)
 {
 	u32 array_mode, micro_tile_mode, tile_split_bytes;
 	u32 gb_macrotile_mode, macrotile_idx;
@@ -649,6 +649,7 @@ static u64 amdgpu_dm_plane_calc_gfx6_mod(const struct amdgpu_device *adev,
 		AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, (gb_macrotile_mode >> 4) & 0x3) |
 		AMD_FMT_MOD_SET(NUM_BANKS, (gb_macrotile_mode >> 6) & 0x3);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_calc_gfx6_mod);
 
 /**
  * amdgpu_dm_plane_gfx6_format_mod_supported() - Check if a modifier is supported on GFX6-8
@@ -660,9 +661,9 @@ static u64 amdgpu_dm_plane_calc_gfx6_mod(const struct amdgpu_device *adev,
  * On GFX6-8, not all DRM format modifier can be used with all image formats.
  * Check whether the specified modifier is supported with the given bits per pixel value.
  */
-static bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device *adev,
-						      const u32 bpp,
-						      const u64 modifier)
+STATIC_IFN_KUNIT bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device *adev,
+								const u32 bpp,
+								const u64 modifier)
 {
 	const u32 array_mode = AMD_FMT_MOD_GET(TILE, modifier);
 	const u32 micro_tile_mode = AMD_FMT_MOD_GET(MICROTILE, modifier);
@@ -701,6 +702,7 @@ static bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device
 	/* Verify that the modifier is the same that we'd expose for this bpp */
 	return amdgpu_dm_plane_calc_gfx6_mod(adev, bpp, array_mode) == modifier;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_gfx6_format_mod_supported);
 
 /**
  * amdgpu_dm_plane_add_gfx6_modifiers() - Expose modifiers for GFX6-8
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 7c5d0a7dadb1d..b396b3ea78bae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -130,5 +130,9 @@ u32 amdgpu_dm_plane_get_gfx6_tile_idx(const struct amdgpu_device *adev, const u3
 u32 amdgpu_dm_plane_calc_gfx7_tile_split(const struct amdgpu_device *adev, const u32 bpp,
 					 const u32 gb_tile_mode);
 u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp, const u32 tile_split_bytes);
+u64 amdgpu_dm_plane_calc_gfx6_mod(const struct amdgpu_device *adev, const u32 bpp,
+				  const enum array_mode_values arr);
+bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device *adev, const u32 bpp,
+					       const u64 modifier);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 420b053d2e3dc..312fe34eb7105 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3277,6 +3277,44 @@ static void dm_test_fill_gfx6_tiling_info_2d(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.num_banks, 2U);
 }
 
+static u64 dm_test_gfx6_mod(u32 tile, u32 pipe_config, u32 tile_split, u32 bank_width,
+			    u32 bank_height, u32 aspect, u32 num_banks)
+{
+	return AMD_FMT_MOD |
+	       AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+	       AMD_FMT_MOD_SET(TILE, tile) |
+	       AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY) |
+	       AMD_FMT_MOD_SET(PIPE_CONFIG, pipe_config) |
+	       AMD_FMT_MOD_SET(TILE_SPLIT, tile_split) |
+	       AMD_FMT_MOD_SET(BANK_WIDTH, bank_width) |
+	       AMD_FMT_MOD_SET(BANK_HEIGHT, bank_height) |
+	       AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, aspect) |
+	       AMD_FMT_MOD_SET(NUM_BANKS, num_banks);
+}
+
+static struct amdgpu_device *dm_test_alloc_gfx7_device(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_VI;
+	adev->gfx.config.mem_row_size_in_kb = 4;
+	/* 2D_TILED_THIN1 array mode (bits 5:2) and pipe config 2 (bits 10:6). */
+	adev->gfx.config.tile_mode_array[10] = (4u << 2) | (2u << 6);
+	/*
+	 * Bank width (bits 1:0), bank height (bits 3:2), macro tile aspect
+	 * (bits 5:4) and num banks (bits 7:6). Entries 1 and 2 are identical so
+	 * the 16 and 32 bpp modifiers collide and the dedup path is taken.
+	 */
+	adev->gfx.config.macrotile_mode_array[1] = 0xb9u;
+	adev->gfx.config.macrotile_mode_array[2] = 0xb9u;
+	adev->gfx.config.macrotile_mode_array[3] = 0x2au;
+
+	return adev;
+}
+
 /**
  * dm_test_get_gfx6_tile_idx() - Verify GFX6-8 tile mode index selection.
  * @test: KUnit test context.
@@ -3352,6 +3390,108 @@ static void dm_test_get_gfx7_macro_tile_idx(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_gfx7_macro_tile_idx(64, 256), 2U);
 }
 
+/**
+ * dm_test_calc_gfx6_mod_1d() - Verify the micro tiled GFX6-8 modifier.
+ * @test: KUnit test context.
+ *
+ * Verify if a micro tiled array mode returns early with only the base modifier
+ * fields set.
+ */
+static void dm_test_calc_gfx6_mod_1d(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_gfx7_device(test);
+	u64 expected = AMD_FMT_MOD |
+		       AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+		       AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1) |
+		       AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_calc_gfx6_mod(adev, 0, DC_ARRAY_1D_TILED_THIN1),
+			expected);
+}
+
+/**
+ * dm_test_calc_gfx6_mod_gfx7() - Verify the macro tiled GFX7-8 modifier.
+ * @test: KUnit test context.
+ *
+ * Verify if the modifier combines the tile mode pipe config and computed tile
+ * split with the bank fields taken from the macro tile mode table.
+ */
+static void dm_test_calc_gfx6_mod_gfx7(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_gfx7_device(test);
+
+	/* 32 bpp: 256 byte tile split (log2 of 4 units), macro tile mode 2. */
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TILED_THIN1),
+			dm_test_gfx6_mod(AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1, 2, 2, 1, 2, 3, 2));
+
+	/* 64 bpp: 512 byte tile split (log2 of 8 units), macro tile mode 3. */
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_calc_gfx6_mod(adev, 64, DC_ARRAY_2D_TILED_THIN1),
+			dm_test_gfx6_mod(AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1, 2, 3, 2, 2, 2, 0));
+}
+
+/**
+ * dm_test_calc_gfx6_mod_si() - Verify the macro tiled GFX6 modifier.
+ * @test: KUnit test context.
+ *
+ * Verify if GFX6 takes the tile split and bank fields directly from the tile
+ * mode register instead of the macro tile mode table.
+ */
+static void dm_test_calc_gfx6_mod_si(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_SI;
+	/* 2D_TILED_THIN1, pipe config 3, 256 byte tile split, banks 1/2/3/1. */
+	adev->gfx.config.tile_mode_array[12] = (4u << 2) | (3u << 6) | (2u << 11) |
+					       (1u << 14) | (2u << 16) | (3u << 18) |
+					       (1u << 20);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TILED_THIN1),
+			dm_test_gfx6_mod(AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1, 3, 2, 1, 2, 3, 1));
+}
+
+/**
+ * dm_test_gfx6_format_mod_supported() - Verify GFX6-8 modifier support checks.
+ * @test: KUnit test context.
+ *
+ * Verify if only the canonical modifier for a given bits per pixel is accepted,
+ * and that non-AMD modifiers, newer tile versions, GFX9+ devices, DCC, and
+ * non-displayable tile modes are rejected.
+ */
+static void dm_test_gfx6_format_mod_supported(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_gfx7_device(test);
+	u64 modifier = amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TILED_THIN1);
+	u64 gfx9_mod = AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9);
+	/* Neither 1D nor 2D THIN array mode. */
+	u64 bad_tile_mod = AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE, 3);
+	/* Non-displayable micro tile mode. */
+	u64 bad_micro_mod = AMD_FMT_MOD |
+			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) |
+			    AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_THIN);
+	u64 not_amd_mod = DRM_FORMAT_MOD_VENDOR_AMD;
+	u64 dcc_mod = modifier | AMD_FMT_MOD_SET(DCC, 1);
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_plane_gfx6_format_mod_supported(adev, 32, modifier));
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_plane_gfx6_format_mod_supported(adev, 64, modifier));
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_plane_gfx6_format_mod_supported(adev, 32, not_amd_mod));
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_plane_gfx6_format_mod_supported(adev, 32, gfx9_mod));
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_plane_gfx6_format_mod_supported(adev, 32, dcc_mod));
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_plane_gfx6_format_mod_supported(adev, 32, bad_tile_mod));
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_plane_gfx6_format_mod_supported(adev, 32, bad_micro_mod));
+
+	adev->family = AMDGPU_FAMILY_AI;
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_plane_gfx6_format_mod_supported(adev, 32, modifier));
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3452,6 +3592,12 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_calc_gfx7_tile_split),
 	/* amdgpu_dm_plane_get_gfx7_macro_tile_idx() */
 	KUNIT_CASE(dm_test_get_gfx7_macro_tile_idx),
+	/* amdgpu_dm_plane_calc_gfx6_mod() */
+	KUNIT_CASE(dm_test_calc_gfx6_mod_1d),
+	KUNIT_CASE(dm_test_calc_gfx6_mod_gfx7),
+	KUNIT_CASE(dm_test_calc_gfx6_mod_si),
+	/* amdgpu_dm_plane_gfx6_format_mod_supported() */
+	KUNIT_CASE(dm_test_gfx6_format_mod_supported),
 	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_device() */
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_pre_10_3),
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_10_3_plus),
-- 
2.43.0

