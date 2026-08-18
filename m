Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE69C5DF8C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBDEF10ECAE;
	Tue, 18 Aug 2026 20:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZEFxY1qV";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0AA10ECB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTT/FmbyvD2SaBtZiacJhZYd1yti1TLeHJ4ZA2XUUkE5gMzMDdDVSWOlDXgudWMCvzV5Adj1Y8mtkePJNzhp1PO3lnVZvPiTo1ARpTB2zBAPG+hBmskJ2xgdrEj0qoBQweOIplKSa9/TcMYrDrb/cEpgLtLwPoKmdef3+AjZJZcQQSiq+9MN43kujS8ZbPq4R5eNj+U5pM1uBEOzbWZ7daxE8/+hRVA4C8eT33CG6TkRLrPuFGlm+1WwLP46hfEBTi8s3i+HIpaZQjCrFtHW5f/lmpgSDTCAqkMehE96B5RNXPn4jf8NUh0QaqqU9KSwv4aayMfgXNFB/Gq1AXtsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMzd7lWRN1eU/hApDsI9COD3+QoILFNp7HFFpMpTpLE=;
 b=L4ZjxkGFxTDmQbES6Wifxa2RkaFu3z1yLZQt5r3ymCY2UvU2zKwgcBp4oc+z5wfxbVdlZCXvuPt+XofoKdP07SahGU4HQH9U5Z8u03jyM5W1KDkLcykefsdMgupvQh6tBWhykD3x/n8PD6TVMNoFh3AQTs38j7zUKqWL+KRY5bf255eRiin5DBjr4nyNUfHch9/GiT1NwDTN+H8bPS/bfgXXQpgduOydI8Zsh6x+/HI5ELSJVMH4r6DgbeF+YBSfZhL9DjV3ViCw5+QLermvsd4VhyZ1JS71FzuPM4DFDiBu/UFYS6Wi6SoiaIRnozvuTvOP7+pjDChRNfjKjQvopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMzd7lWRN1eU/hApDsI9COD3+QoILFNp7HFFpMpTpLE=;
 b=ZEFxY1qVy2gUrWoizE8ooi2V0qDBQBaOok66OcXolxBaPfjgL2658+7fIkIcXLZfurt1+ksEKFYpbxv713H4IJ+DXxcAzPt0PF3txYeJnztanFEIdyQI7bvuPTv+vfie7Oc+v1RxK4ZwZmpNx0sCMkAv+SoX0JPgsaWlJcXNK30=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:35 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::82) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:26 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:26 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:26 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 46/82] drm/amd/display: Test GFX6-8 tiling info from modifiers
Date: Tue, 18 Aug 2026 16:15:38 -0400
Message-ID: <20260818202139.4172592-47-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aab4cad-f09d-4631-c529-08defd6670ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HgZXArwnwGdv/cVzwuBtK4mb0ri+jryPBTSgnkJWJqWX4vk9BtXJ4LfuXCudqJ1zMHfsybDa3Xj8rt8aJKoLQ1pCxkp/mCNDWNB078wT8GdqkgKZu3L061UqLC4B/EFMtakWAL8996RQtoBsOnWKLTju/B4oH3lBxHT0TqpptYzqrYV0fqATNkKgqkzrcbK3bAUISqJVu5chug21GwAMwWhnwUZ3fyC1srMPI0QrM9sSf9T+S/2jjvAI5znaLKcM3sySaPSrb700bPl9Q/2fEd4jZB1oF8Hb1VO8FkqvQ+x/1vNsdIVJ3TrcTcT2GHPEePuExv4uRSgTDnUu+/CK8Gj4FAJbNSiDBXi3JfU9VnyuG3ztpTt20uBfX6gnDzL8J7lj92+ug7BN3Augwq2vlzzxqPLnSeNzwTSHXVVpx7zRwui8F5/ivoqvzlJxSULpH8wZD8zjyT2C1eHvIfUD1wfehUNwd9rSGzWZ2/IrJGfDugpRXwaEQ+skOZtHLIHGSvNxmxqNQqmiGoyRUkME2wVABW/tqPp7XeV99nNUAdZihd0tqpK52G8pT96njTUtKEcd0FzD+fHf12lq/K+dZKrW9JMrAXCYz2Cnyfb+bqHeu5f3BQBTjKmoiQnxJQEhtfawDAjVXMCR+TxYYja/mcPiLy5OXqcxHHuF/FSJuhpoiZyXksZ05En++avjgwhIytBIqnHXmgT4XLny3ZraJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Znem1cvUn9oxz3BFeHOSZn9DY/jWWp1b9+WZlgHcPWjXwNdSGafvxKlX4JYfyDe4tKZQ8EDnA0dFU65Y0dLw/+BHeuYg1cYiZkZq7gXLiO0ag6t9/jb9ims1ng4QOKJLe6NVl0hyhSGG1MbS5XWAvvIjAfi/wv0vURtwCop0u2d/f+GTbsZABDARc6k+dGpE61CSuZd+69sLLfBQ8GXJOXsGMpJieL2JqeFNR8tXvoL3qnaj9J6BGVdxHMTunB1tvwZE3b3IAJZ3AKliV0fQtBgCvr+AlDUGpjPN3OanW9m9/mAW+fvBuFRa0rzp/aNZLFAFMPuPoV4iGEQwUv/dszPOMnmjwaH/AJsB9Y0oFWQ7i3b53a7fqXJRr93J2ksifZ2k/uF+1HEipuvJkIJDryMYCEnzJMaN7ANa1Aj81cZSrUrsf9+niwP8pMFu/ycC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:35.1547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aab4cad-f09d-4631-c529-08defd6670ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
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
Add KUnit tests for amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier()
covering the linear, micro tiled and macro tiled modifiers, and the
rejection of a modifier that is not of the GFX6 tile version.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 4017dc1d6a771..aaec65d7431ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3185,6 +3185,98 @@ static void dm_test_add_modifier_dedup_noop_when_mods_null(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, cap, 7ULL);
 }
 
+static int dm_test_gfx6_tiling(struct dc_tiling_info *tiling_info, u64 modifier)
+{
+	return amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(tiling_info, modifier);
+}
+
+/**
+ * dm_test_fill_gfx6_tiling_info_linear() - Verify linear modifier decoding.
+ * @test: KUnit test context.
+ *
+ * Verify if a linear modifier maps to the generic linear array mode.
+ */
+static void dm_test_fill_gfx6_tiling_info_linear(struct kunit *test)
+{
+	struct dc_tiling_info tiling_info = {0};
+
+	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, DRM_FORMAT_MOD_LINEAR), 0);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.array_mode, (int)DC_ARRAY_LINEAR_GENERAL);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxVersion8);
+}
+
+/**
+ * dm_test_fill_gfx6_tiling_info_rejects() - Verify unsupported modifiers fail.
+ * @test: KUnit test context.
+ *
+ * Verify if non-AMD modifiers and AMD modifiers from a newer tile version are
+ * rejected.
+ */
+static void dm_test_fill_gfx6_tiling_info_rejects(struct kunit *test)
+{
+	struct dc_tiling_info tiling_info = {0};
+	u64 not_amd_mod = DRM_FORMAT_MOD_VENDOR_AMD;
+	u64 gfx9_mod = AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9);
+
+	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, not_amd_mod), -EINVAL);
+	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, gfx9_mod), -EINVAL);
+}
+
+/**
+ * dm_test_fill_gfx6_tiling_info_1d() - Verify micro tiled modifier decoding.
+ * @test: KUnit test context.
+ *
+ * Verify if a 1D tiled modifier stops before decoding the macro tiling fields.
+ */
+static void dm_test_fill_gfx6_tiling_info_1d(struct kunit *test)
+{
+	struct dc_tiling_info tiling_info = {0};
+	u64 modifier = AMD_FMT_MOD |
+		       AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+		       AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1) |
+		       AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY) |
+		       AMD_FMT_MOD_SET(NUM_BANKS, 3);
+
+	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, modifier), 0);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.array_mode,
+			(int)AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxVersion8);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.num_banks, 0U);
+}
+
+/**
+ * dm_test_fill_gfx6_tiling_info_2d() - Verify macro tiled modifier decoding.
+ * @test: KUnit test context.
+ *
+ * Verify if a 2D tiled modifier decodes the full set of macro tiling fields.
+ */
+static void dm_test_fill_gfx6_tiling_info_2d(struct kunit *test)
+{
+	struct dc_tiling_info tiling_info = {0};
+	u64 modifier = AMD_FMT_MOD |
+		       AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX6) |
+		       AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) |
+		       AMD_FMT_MOD_SET(MICROTILE, AMD_FMT_MOD_MICROTILE_DISPLAY) |
+		       AMD_FMT_MOD_SET(PIPE_CONFIG, 5) |
+		       AMD_FMT_MOD_SET(TILE_SPLIT, 4) |
+		       AMD_FMT_MOD_SET(BANK_WIDTH, 1) |
+		       AMD_FMT_MOD_SET(BANK_HEIGHT, 2) |
+		       AMD_FMT_MOD_SET(MACRO_TILE_ASPECT, 3) |
+		       AMD_FMT_MOD_SET(NUM_BANKS, 2);
+
+	KUNIT_EXPECT_EQ(test, dm_test_gfx6_tiling(&tiling_info, modifier), 0);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.array_mode,
+			(int)AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1);
+	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfx8.tile_mode,
+			(int)AMD_FMT_MOD_MICROTILE_DISPLAY);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.pipe_config, 5U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.tile_split, 4U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.bank_width, 1U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.bank_height, 2U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.tile_aspect, 3U);
+	KUNIT_EXPECT_EQ(test, tiling_info.gfx8.num_banks, 2U);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3274,6 +3366,11 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_add_modifier_dedup() */
 	KUNIT_CASE(dm_test_add_modifier_dedup_skips_duplicate),
 	KUNIT_CASE(dm_test_add_modifier_dedup_noop_when_mods_null),
+	/* amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier() */
+	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_linear),
+	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_rejects),
+	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_1d),
+	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_2d),
 	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_device() */
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_pre_10_3),
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_10_3_plus),
-- 
2.43.0

