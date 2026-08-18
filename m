Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB548C5DF96
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4ED10ECD2;
	Tue, 18 Aug 2026 20:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TLRhwXQH";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB30810ECD2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kG3OTrvMToMCGkzBQb2dgBoW2ckEz+RgJc/pcoTonVzrD+XWyFTytbwa14yjmnxjdguH1WLfQXQwhcbtLbl4Ra0TIYg0EknpfCRsoB6+itI5zcBv/9zVAnwgfyrs3w7RdxgEHrby0kie9mKS2JN+sKf87qpr0N8BiFShdtEXm6qAKQszfUEj5ivIu8gjg5GbDrmBpBTXRpj26l9eZXtV52cK3zcFgrliAlMbvN0h3tnBfywxxYeIAf5TY77M0s1m3EW3UEYCilxhrZb4cEIXvfWPk7CpkxjeXTeXpA06u3aOyBilHES5B6IUOOgM0fzwPIl3rpJ6BOhefnvuxLgTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+6lEG/66EDEe5W9n1fghUV4psaxwc+1bbUq241hDEc=;
 b=imOKZmDBrtG59lDMD6BUYIY7K5cGWAUkiJc2fUJJtUMZbuAR+tgVWyazr3bgaoX52OD94foy1PFBdI7Y6WU4pC/to/xv8OKIreSzGz+snA0p4w19ez+TBcBjn52p5F7ApS9I9Vw0PPGnhzqU56uL2yo7PWI6Ps7ZW2xRYCHAKC68MxhXw53RV5yrNkMJ+CaoxBH8YNpO4lsXStss+SUrfMi83mTTIHXDuG/tTeDCvS/L0toM4Uq2b9l2lXlGL3QpkjNJjMzmN8blpmSX6+gT+nooQkj4YUYQ9XylbDJUmcXeahjQ7kJD1aLXdpg8nXts0TqRpEujj9U2cpnj3Yscmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+6lEG/66EDEe5W9n1fghUV4psaxwc+1bbUq241hDEc=;
 b=TLRhwXQHl8fAPGH4R51eruXjnstm40FFoTbEX10qexY8O14v+KN8KTFwIbOnkyj1upEvpuMUcxwDonjpbMc0wkDiqsBoFm/wjANTAIHGKIVy5ogfla9EREdiKE51X7xW/cmFluhJy7B52LrfAjkD0ngNTEI2iyRZES+Ldjps+f0=
Received: from BN9PR03CA0351.namprd03.prod.outlook.com (2603:10b6:408:f6::26)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:42 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::a6) by BN9PR03CA0351.outlook.office365.com
 (2603:10b6:408:f6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:28 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:28 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 49/82] drm/amd/display: Test GFX6-8 modifier list generation
Date: Tue, 18 Aug 2026 16:15:41 -0400
Message-ID: <20260818202139.4172592-50-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: b6081c9b-4f93-4554-3263-08defd667494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xF52TmffATLjBhBlsVglx0xRMyL2DKbc+ZAy4fEIY13D/mYnfMWAL7DoEm8kzh46xIfnEOlsW0cpajOJX+yBqPU/YsX2R3mTcFytXOAfS006J2MopWmNL1D/SRA19jNQ00I+SXMLvSsfYxpL9NDM+mlMbcVW+eb1J+g4C6egnl7lS80uowAaFUEtYBIqyD4jbnzxfIcrJ735Zni4QwEekFp+FdpUJYdMM6Ace2UUIvF+dXH0FV1quuq0kMlYEIjRzkNsI6jdIc+8S35wYD1EthI0w6MX8za3SNv9tKM8hSGfVajVmmEowdaC3W4SGaI9NYEJiUstLiPk3Mz1XDC0QJtZlD88SnbQbi9VvNUsN5VYH8ubwfo57zkMDFjQ4jJbtjgyG+MZI93sHH3zoHczTLsUuvEj/uVpphgklw7gLfrUIBufIA0xnuntsr7T1SihliQqVQa0FABIH42XcJE5g1U8rXIFKWk0vQhRczY4eyyB1JQNNxgz1rJ5lgjzkngDc6Y2ZB3s2jx3B/IT0Kw6qcqh9t/iyFiAWNDu+5iBuyqQsuxSzU2S/L2geTl65civO8NWn2fOqgrpW7Q0Ydns1ftef6oKjD5mJIcjSRBw7lFvTwisiWF85qTQqyewJOBpyH0B4JS2gXf6G0g9kBfiE46ZLctoVq1a4/JB3TdXJouG/Rd9J1KBL9Z7+XZ8DDmKQo7baf3Nbrycg1KX47gdKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +SNoybIEwJN99P5MWZsAPgehotoZqi7/CK9v3ChuM/fN0VYM8wUnVBDIl/HwpDegeGvXKlWoJhJHXP6SVoUlzqYXwIYsrFRq1+SNZjAIi2ld+Rww78GL1TpsF98QEF0xKuRBFDrY9S2UlzbRKL7ZCOJD9nCcm63C26Qvq1CRixaJMnVi15xT/mwT6EcRf7iQsHcWqAG0nG1Z7a/f1S4UVamK72EmfZtPjvMIPLpwF8kje6wAe9wvMu05u8Ixt36fy3az4a98+iUFJH4qnY4twPRb6bcJWFKNXkz4HrzK2f1CO2VaDqGn7Hhe2CnJYXgHinbO+8GBy6gq0Yoc+G0f3SVr+QAipyMdrSyrnVZsODwRyPOJh8YM8uYqKg4BBqAfXZdBeSX4tA687RTKrjkX2l5hq09P4tmah0Z9ReiHI4XeCHwIkdBroNy1ZTsAM9sg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:41.7129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6081c9b-4f93-4554-3263-08defd667494
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
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
Add KUnit tests for amdgpu_dm_plane_get_plane_modifiers() and
amdgpu_dm_plane_format_mod_supported() on a GFX6-8 device. The exposed
list holds one macro tiled modifier per distinct bits per pixel plus a
micro tiled and a linear one, and a listed modifier is validated through
the GFX6-8 specific check.

Add dm_test_mods_count() for the list length and use it in the existing
sentinel scans.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 83 +++++++++++++++++--
 1 file changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 312fe34eb7105..a0e7d012ccbab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -1191,29 +1191,39 @@ static void dm_test_fill_blending_global_alpha_dcn42(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, global_alpha_value, 0x800);
 }
 
+/* Modifier lists are terminated by DRM_FORMAT_MOD_INVALID, which is not counted. */
+static int dm_test_mods_count(const u64 *mods)
+{
+	int i = 0;
+
+	while (mods[i] != DRM_FORMAT_MOD_INVALID)
+		i++;
+
+	return i;
+}
+
 static void dm_test_expect_mods_terminated(struct kunit *test, struct amdgpu_device *adev)
 {
 	u64 *mods = NULL;
 	int ret;
-	int i;
+	int count;
 
 	ret = amdgpu_dm_plane_get_plane_modifiers(adev, DRM_PLANE_TYPE_PRIMARY, &mods);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	KUNIT_ASSERT_NOT_NULL(test, mods);
 
-	for (i = 0; mods[i] != DRM_FORMAT_MOD_INVALID; i++)
-		;
-
-	KUNIT_EXPECT_GT(test, i, 0);
-	KUNIT_EXPECT_EQ(test, mods[i - 1], DRM_FORMAT_MOD_LINEAR);
+	count = dm_test_mods_count(mods);
+	KUNIT_EXPECT_GT(test, count, 0);
+	KUNIT_EXPECT_EQ(test, mods[count - 1], DRM_FORMAT_MOD_LINEAR);
 	kfree(mods);
 }
 
 static bool dm_test_mods_contain(const u64 *mods, u64 expected)
 {
+	int count = dm_test_mods_count(mods);
 	int i;
 
-	for (i = 0; mods[i] != DRM_FORMAT_MOD_INVALID; i++) {
+	for (i = 0; i < count; i++) {
 		if (mods[i] == expected)
 			return true;
 	}
@@ -3492,6 +3502,63 @@ static void dm_test_gfx6_format_mod_supported(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, amdgpu_dm_plane_gfx6_format_mod_supported(adev, 32, modifier));
 }
 
+/**
+ * dm_test_get_plane_modifiers_gfx6() - Verify GFX6-8 modifier list generation.
+ * @test: KUnit test context.
+ *
+ * Verify if a GFX6-8 family device exposes one macro tiled modifier per
+ * distinct bits per pixel plus a micro tiled one, and that the duplicate 32 bpp
+ * modifier is de-duplicated.
+ */
+static void dm_test_get_plane_modifiers_gfx6(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_gfx7_device(test);
+	u64 *mods = dm_test_get_primary_mods(test, adev);
+	u64 mod_1d = AMD_FMT_MOD |
+		     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+		     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1) |
+		     AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY);
+
+	/* 16 bpp, 64 bpp, micro tiled and linear; the 32 bpp duplicate is dropped. */
+	KUNIT_EXPECT_EQ(test, dm_test_mods_count(mods), 4);
+	KUNIT_EXPECT_EQ(test, mods[0],
+			dm_test_gfx6_mod(AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1, 2, 2, 1, 2, 3, 2));
+	KUNIT_EXPECT_EQ(test, mods[1],
+			dm_test_gfx6_mod(AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1, 2, 3, 2, 2, 2, 0));
+	KUNIT_EXPECT_EQ(test, mods[2], mod_1d);
+	KUNIT_EXPECT_EQ(test, mods[3], DRM_FORMAT_MOD_LINEAR);
+
+	kfree(mods);
+}
+
+/**
+ * dm_test_format_mod_supported_gfx6() - Verify dispatch to the GFX6-8 check.
+ * @test: KUnit test context.
+ *
+ * Verify if a listed GFX6 tile version modifier is validated through the
+ * GFX6-8 specific helper.
+ */
+static void dm_test_format_mod_supported_gfx6(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_gfx7_device(test);
+	struct drm_plane *plane;
+	u64 listed_mod = amdgpu_dm_plane_calc_gfx6_mod(adev, 32, DC_ARRAY_2D_TILED_THIN1);
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+
+	plane->dev = &adev->ddev;
+	plane->modifiers = &listed_mod;
+	plane->modifier_count = 1;
+
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_plane_format_mod_supported(plane, DRM_FORMAT_XRGB8888,
+							       listed_mod));
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_plane_format_mod_supported(plane, DRM_FORMAT_XRGB16161616,
+								listed_mod));
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3511,6 +3578,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_get_plane_formats_overlay_universal_cap),
 	/* amdgpu_dm_plane_get_plane_modifiers() */
 	KUNIT_CASE(dm_test_get_plane_modifiers),
+	KUNIT_CASE(dm_test_get_plane_modifiers_gfx6),
 	KUNIT_CASE(dm_test_get_plane_modifiers_gfx9),
 	KUNIT_CASE(dm_test_get_plane_modifiers_rv),
 	KUNIT_CASE(dm_test_get_plane_modifiers_rv_constant_encode),
@@ -3535,6 +3603,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_format_mod_supported() */
 	KUNIT_CASE(dm_test_format_mod_supported),
 	KUNIT_CASE(dm_test_format_mod_supported_d_swizzle_reject),
+	KUNIT_CASE(dm_test_format_mod_supported_gfx6),
 	/* amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers() */
 	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
 	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_block0),
-- 
2.43.0

