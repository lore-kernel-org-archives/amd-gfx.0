Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4673BC44509
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DE710F6FC;
	Thu,  9 Jul 2026 21:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MD62PPjU";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6462010F6E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NelJDJ2X+k242TW9+2Gs1mZZYYSDmxdI82E0wOK7gDYUnlXGieTZ70Pl8cKSKXXPmmmz8iOUN5xT6S0RT62zrdFMoMZnfToq1UpomAzXY/6xiHWRMmiyxP8y+asVvjZKcHnpRbDbIvk9fA2fpZ/UunpUmxe24qeuWFzpmHEIofMwiNItMvNgnbBlfVllZdY6wF8Ht09T02+/Nmv0Qyk6xBl/TMuez6sasJaZ3STGr7gyIbdJ4bTuN8gyQYbDkYQz9MkkAlMnh71xBxGAPUl6ZimFJmvtTGG/iL5kJFpIZ7ZTLHFTLrp2n4lqihulo74ZDPOkbVdyTmI2AxQ4sWTscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DB0xbij3mqeihTwG6of1N573CluW4RRQSuGttWAMrVw=;
 b=S71OUaU4gX57jg1ifrwcyd1kqo047fzXZZ9J3EbTDLZFsqgtPUWQowZ2QXEzgh7wlMz+umMoeE2Znv/rLVOVZ3rKmVFb5KFKpj09mA6NFJ/aX2Q0j08lru4TgBXlws+z+aS3yzksdNWer3cC70q50NIYu+GFcnb7maFekoPCmwprFLKisZTCydWFelnTOCOWFIM43uQHZqjWixHa5gEhSn/Wf/rI+bYrAnfBGKzzXHkro1TydI71ZRyJjZ44WqO+kHxtFJY01RhlRCyO+ZWASl2/wxbXlkesWywwBZoblvfgU1DoQGeLcNF6cOwPuInU9Bnv/Zi5+22PzMkp9J5KFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DB0xbij3mqeihTwG6of1N573CluW4RRQSuGttWAMrVw=;
 b=MD62PPjUm7xkeRA1X17k2GU5CRj9tPP3STz9f4rQBzoDxXGwxPPwpYjHuwuc96ZfJSDCb12RCksZle4sNWHrKAf5hw1NB25lDramKKZTV6XtvdSXkS5S/TGrWyF2zCfwdX2Wz+33rYIkoW8iLMwUc647EvvWtjLo1cZM5w9NulM=
Received: from MN2PR01CA0055.prod.exchangelabs.com (2603:10b6:208:23f::24) by
 MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:29 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::11) by MN2PR01CA0055.outlook.office365.com
 (2603:10b6:208:23f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:29 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:10 -0500
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
Subject: [PATCH 45/80] drm/amd/display: Test GFX9/GFX10 plane modifiers
Date: Thu, 9 Jul 2026 16:48:13 -0400
Message-ID: <20260709205936.5719-46-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe9c4cc-6a07-4b67-2313-08deddfd6324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Fvo2r2P2P3bOAXMlZrLHFhfjs1PNYPD1nty2eG+BO3dazRoZU3oP6Ml+PB4aGyl/16PqouzuiXKvjX1ki9ln/kjTp01qWS6u45er0mLRcJ9wse37Iwv1WJtv1gvxrn7rgL123N/N2A8NzAcSjyGaCfqzdFFeTl3qBd0vV34pwUzlTFILBqzK+zGzIPCP5Q0QCQWJEFbjGZnLAfeGrDHOS604dj+3ZSzI2AuEh+eQzE/cCSM+cXW4Arj8T3x4oWIGnrWlz4RGT5Gf0OXae3cczgJEK5VXeJHbc+MRXADg1uUQG0oUxyAekHBS87gQS2Bk5imU3kkTc8JTunY8yJ4DD/XdDbjPcGNvX0WKVm2g+4GL+WiMRWSWKyZFuO7aT8Dc2JoKwn1iuR5fgcGn8fA9oOcf56Rs1Pf2OsP3l8Bp3aWiao+wvFUpP+YG5lusxlsuTbejhpoLVugAx5ftv9fEQxzPMvRGig2UjFZLlx2uX7EfWiOSzXLTx72AX6h1aPl0XkGAK7RytwXEN66hnrXND2E+XEAoTGRa4OQcPswopkHHCOMF+3EyUD25VCodAD2wqfFhNayNvk1+MuqEHmWW3EoeaVE0mCsD4S80ZU0Ze9FopPaqEbmGlpLkFdOafkhpqWTuuGKm8FEBKL18tNEp/NyteJPIPoSKrxkz+BYdxJM9QQsZr/zPGt1cxKPfAl3/J6bA19RboS1VBgwF2E18DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0uGoVeOGnqwIXRP0D3tehwAjnK/TIl91V3r4XPlaLya14Gk6xqQqT/g116wipq4Kw3/mGTvO4/sovx2VECaEAyuE+oovQHjQoAjn+nnAmikqEqi0aW9m++s8OOVebTMQU0vosI8U76VazSm7pF+ZEiHqxfSvftNXmS+ifT8VgHy2aBT9PnyjGA0Hel83nbk+fVcoKpENmy6Uj6jrpJyFC+G5hl0WVtMUT6f15/PJC9h1I6m3ttp0pmtX9fEnw/N1yzWKoIWVKThXl9pKBObWxjb6GkUcW3VQcoLSOaIaKxZ0qdo3lse8agP2BL+7Tf5ClSKUAqQRBa6ljeqXvSBB68X8YYPG1GYf0Ku72nrdY4oxWmFdd5cLb7+vAmmgWtfMjSon3/EtlWtgHZZo3lBPZeXl8X7dPQK8cFLoOFpslWf/+XykF8b35Cnh5KZC2Ws3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:29.2530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe9c4cc-6a07-4b67-2313-08deddfd6324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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
Add KUnit tests for amdgpu_dm_plane_get_plane_modifiers() on GFX9,
Raven, Raven constant-encode, GFX10.1 and GFX10.3 devices.

Introduce the dm_test_expect_mods_terminated(), dm_test_mods_contain()
and dm_test_get_primary_mods() helpers used to validate the generated
modifier lists.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 219 ++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 512c51e60559..9cf43e732eb5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -1226,6 +1226,48 @@ static void dm_test_fill_blending_global_alpha_dcn42(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, global_alpha_value, 0x800);
 }
 
+static void dm_test_expect_mods_terminated(struct kunit *test, struct amdgpu_device *adev)
+{
+	u64 *mods = NULL;
+	int ret;
+	int i;
+
+	ret = amdgpu_dm_plane_get_plane_modifiers(adev, DRM_PLANE_TYPE_PRIMARY, &mods);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_NULL(test, mods);
+
+	for (i = 0; mods[i] != DRM_FORMAT_MOD_INVALID; i++)
+		;
+
+	KUNIT_EXPECT_GT(test, i, 0);
+	KUNIT_EXPECT_EQ(test, mods[i - 1], DRM_FORMAT_MOD_LINEAR);
+	kfree(mods);
+}
+
+static bool dm_test_mods_contain(const u64 *mods, u64 expected)
+{
+	int i;
+
+	for (i = 0; mods[i] != DRM_FORMAT_MOD_INVALID; i++) {
+		if (mods[i] == expected)
+			return true;
+	}
+
+	return false;
+}
+
+static u64 *dm_test_get_primary_mods(struct kunit *test, struct amdgpu_device *adev)
+{
+	u64 *mods = NULL;
+	int ret;
+
+	ret = amdgpu_dm_plane_get_plane_modifiers(adev, DRM_PLANE_TYPE_PRIMARY, &mods);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_NULL(test, mods);
+
+	return mods;
+}
+
 /**
  * dm_test_get_plane_formats_overlay_universal_cap() - Verify universal overlay.
  * @test: KUnit test context.
@@ -1252,6 +1294,178 @@ static void dm_test_get_plane_formats_overlay_universal_cap(struct kunit *test)
 			14);
 }
 
+/**
+ * dm_test_get_plane_modifiers_gfx9() - Verify GFX9 modifier list generation.
+ * @test: KUnit test context.
+ *
+ * Verify if the GFX9 family produces a non-empty modifier list terminated by
+ * LINEAR and INVALID entries.
+ */
+static void dm_test_get_plane_modifiers_gfx9(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_AI;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
+	adev->gfx.config.gb_addr_config_fields.num_banks = 8;
+	adev->gfx.config.gb_addr_config_fields.num_se = 2;
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 2;
+
+	dm_test_expect_mods_terminated(test, adev);
+}
+
+/**
+ * dm_test_get_plane_modifiers_rv() - Verify RV modifier list generation.
+ * @test: KUnit test context.
+ *
+ * Verify if pre-Raven2 RV devices add RV-specific S-swizzle modifiers and
+ * non-constant-encode DCC modifiers.
+ */
+static void dm_test_get_plane_modifiers_rv(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	u64 *mods;
+	u64 dcc_mod;
+	u64 s_x_mod;
+	u64 s_mod;
+	int pipes = 2;
+	int pipe_xor_bits = 3;
+	int bank_xor_bits = 2;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_RV;
+	adev->asic_type = CHIP_RAVEN;
+	adev->external_rev_id = 0x80;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
+	adev->gfx.config.gb_addr_config_fields.num_banks = 4;
+	adev->gfx.config.gb_addr_config_fields.num_se = 2;
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 2;
+
+	mods = dm_test_get_primary_mods(test, adev);
+	dcc_mod = AMD_FMT_MOD |
+		  AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+		  AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+		  AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		  AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+		  AMD_FMT_MOD_SET(DCC, 1) |
+		  AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		  AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+		  AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0);
+	s_x_mod = AMD_FMT_MOD |
+		  AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+		  AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+		  AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		  AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits);
+	s_mod = AMD_FMT_MOD |
+		AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+		AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9);
+
+	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, dcc_mod));
+	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, dcc_mod |
+							     AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+							     AMD_FMT_MOD_SET(RB, 2) |
+							     AMD_FMT_MOD_SET(PIPE, pipes)));
+	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, s_x_mod));
+	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, s_mod));
+
+	kfree(mods);
+}
+
+/**
+ * dm_test_get_plane_modifiers_rv_constant_encode() - Verify Raven2+ modifiers.
+ * @test: KUnit test context.
+ *
+ * Verify if Raven2 and later RV devices add the constant-encode modifier
+ * variants.
+ */
+static void dm_test_get_plane_modifiers_rv_constant_encode(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	u64 *mods;
+	u64 dcc_mod;
+	int pipes = 2;
+	int pipe_xor_bits = 3;
+	int bank_xor_bits = 2;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_RV;
+	adev->asic_type = CHIP_RAVEN;
+	adev->external_rev_id = 0x81;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
+	adev->gfx.config.gb_addr_config_fields.num_banks = 4;
+	adev->gfx.config.gb_addr_config_fields.num_se = 2;
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 2;
+
+	mods = dm_test_get_primary_mods(test, adev);
+	dcc_mod = AMD_FMT_MOD |
+		  AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+		  AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+		  AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		  AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+		  AMD_FMT_MOD_SET(DCC, 1) |
+		  AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		  AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+		  AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1);
+
+	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, dcc_mod));
+	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, dcc_mod |
+							     AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+							     AMD_FMT_MOD_SET(RB, 2) |
+							     AMD_FMT_MOD_SET(PIPE, pipes)));
+
+	kfree(mods);
+}
+
+/**
+ * dm_test_get_plane_modifiers_gfx10_1() - Verify GFX10.1 modifier list generation.
+ * @test: KUnit test context.
+ *
+ * Verify if a pre-10.3 NV family device dispatches to the GFX10.1 modifier
+ * builder and produces a terminated list.
+ */
+static void dm_test_get_plane_modifiers_gfx10_1(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 1, 0);
+
+	dm_test_expect_mods_terminated(test, adev);
+}
+
+/**
+ * dm_test_get_plane_modifiers_gfx10_3() - Verify GFX10.3 modifier list generation.
+ * @test: KUnit test context.
+ *
+ * Verify if a 10.3+ NV family device dispatches to the GFX10.3 modifier
+ * builder and produces a terminated list.
+ */
+static void dm_test_get_plane_modifiers_gfx10_3(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->family = AMDGPU_FAMILY_NV;
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
+	adev->gfx.config.gb_addr_config_fields.num_pkrs = 2;
+	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+
+	dm_test_expect_mods_terminated(test, adev);
+}
+
 /**
  * dm_test_format_mod_supported_d_swizzle_reject() - Verify D swizzle rejection.
  * @test: KUnit test context.
@@ -1303,6 +1517,11 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_get_plane_formats_overlay_universal_cap),
 	/* amdgpu_dm_plane_get_plane_modifiers() */
 	KUNIT_CASE(dm_test_get_plane_modifiers),
+	KUNIT_CASE(dm_test_get_plane_modifiers_gfx9),
+	KUNIT_CASE(dm_test_get_plane_modifiers_rv),
+	KUNIT_CASE(dm_test_get_plane_modifiers_rv_constant_encode),
+	KUNIT_CASE(dm_test_get_plane_modifiers_gfx10_1),
+	KUNIT_CASE(dm_test_get_plane_modifiers_gfx10_3),
 	/* amdgpu_dm_plane_fill_dc_scaling_info() */
 	KUNIT_CASE(dm_test_fill_dc_scaling_info),
 	/* amdgpu_dm_plane_get_min_max_dc_plane_scaling() */
-- 
2.55.0

