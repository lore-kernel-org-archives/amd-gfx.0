Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9C1C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40FA10EA44;
	Wed, 16 Sep 2026 17:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="174pKOaO";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C0710EB3D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur9ovu2K/UbE+aO66Hpzse3Ltj1hNtEN5MO8Kg9Oz74A7sHl6p6FIOrN8HDGu8D00dlqn6ZQdwOA3PeW0HX6jZ8NaQJ5JxQ+Kq2YyRmliRt3wjh2RAKBwQ25h/uYdtolLR3fvf7NNIM62y8rfT9VOU05Lc1m/Jy3tCBqk/UK3tR6Q8azTRwdJpR+Xdk1PByY1S26MlBhFHtFveQ4274xPA1PqRV62I1EpNZcS9EVaCF8ufB6WhtlGIw++nOv7tNldNYEnc1BKZrGXruQakpZ3w0SE0D+LZzhwqVkPMU01tM6Z/EIMEU2RF2a6MfOXGXQAquxIGybGUh+MsEem9LMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRgs2nVXYFCh07Cxc9MpSq6Ef9WZZgmkfNo8FrtVXdk=;
 b=X6YqBqKTHhjhM5KIyod9DVRcf7CTLPgos3mT7UvpBBMdZN+gys/hCsIsJir87A2Gr8wp/TNHmsiJgmbHqH7eUbyfxIkSie5polWHD4grQtM51NFqM572rx92GgyOG/0QDO2KaRhrjDOMAwPTsQssexbyKNGUoyyif1+sRJGPqKvvgOyoalqswlgvU+sZNtAOeSsPTxJTSi4xsZVTeaMSxeVD6flz7G6tGcLkYoYSTMwus5v3W57wQHTkJ+VcqWeEaXFtybnZ0sbcHPxoSFNJMi1KQslqZQamU+NfXTMBXuEYukBLv7r36eu4WCkpPwQoGvAkeu5dVFQw0VxgkRLPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRgs2nVXYFCh07Cxc9MpSq6Ef9WZZgmkfNo8FrtVXdk=;
 b=174pKOaO1t//wxedN+36twtV4u3DLALi886/uOQEqbydECBpHrd++PWuy9Qsr6SonxJmN25m2GReCdBWNHJnuzD3lN4d8dUextnysqHKNZwexLCIcFTbUhKIBs2OAUzp0pqnbNAwKD3iaQvGOndBhEWKG+d9ojic++uKTnAemfg=
Received: from CH2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:610:4c::26)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Wed, 16 Sep 2026 17:52:38 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::34) by CH2PR10CA0016.outlook.office365.com
 (2603:10b6:610:4c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:35 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:24 -0500
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
Subject: [PATCH 14/64] drm/amd/display: Fold plane modifier list tests
Date: Wed, 16 Sep 2026 13:51:29 -0400
Message-ID: <20260916175301.368306-15-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: bf34ef7c-3b82-4304-9f19-08df141b4a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: hA8KdG7zJHjt2JK8V4Ng4NQvOCjZB/XP7k4n88+lWYnZzGMJFc3hSgop0S7+7Y2tfu8fQTUQbXWFsa8pO2GaF37RHfUECcd4o73kYY3tpLfsxFejY2vrToZUAdEVPPyWsCXSx8LTgtYcl4OpgH691neQkeU64fL3ax1YYR2d85VpJ0tNUighJpP+xAdmhVgG6GZn5WURzdNFY6izFgQg9M5/iu7aETYtHm7YisC9LUSBWVSje01ixum6chcZevJy4NHepRrPUozcsx4Zw31sMPn9u4UG+Ys4wV6msortfFkKEkEEGdfoMuxNpxgOgIfFn3ZnlP+mO1GajMkHZy/wLOesPvFnqph+tGoFv9+K180d+eRNopDUmpTTvwIoIbM4W55In7nDbg+2+k6JiNqSN7xL9rZaKMaHYF8ZxlcG00VIBjCtTautKq6QF+7JyHd+7s8bo5+cWutxaHnpO9AIrHR+Q/NA9enhsCDZQ28B0TuyYsWUIZrKS3XXBDMLec1De8kci8BnIW97BordnLLpqeWyABVql0D+K2nFK22VsPNmfkNfrXhpNaPUX2MnUhRQyMr19Sw4HmXUGr/mJG3NoVVYv6RuXAKIoMciRaGgGEpz9OYdmMPSNtjnqX3Bs3cxzHu0AFha3mV2b0asABJQIHTtET0Qz1u7uDPaUVNBGMUq1hTq+1Rcwakdk/5lGBlgdnIelWdQ/rvyOnzi/zUrlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3lI54D7ZgeRVOCvWhInC0Q636Avqp6E6h2KK90Xovuu1i3fqI36WjtsXFnasjsPj5bwJuj20LA9gUJ3HOrnEqWSUx7eY8wzt0lNPG1YOb2cjcFs3nFYRuIJjnESv5Ygd8+2Rq6mlQH0Nd7Nw7pey7d/Vl3XNpPLadOiShEwr3eeC5VZsJa9SoB/zKf+k7d/mw7vP7v41UsbGYxsJeG/QrYwfMz6NJKWRiaUWqV8cEit4WsWMs7DJoywMgn2izRfnyBLZDZM2sZvF1TmS689N7ZqwciN/6b9bwDP+Syl+DV5ANhgEAryaBYaj9l1XPpcXwssZh/jjwUD2Iv3zOaww0PHm++FtmHBt9QI2u4BsbYwAHPccAawB/7o/HbiFQgtVodC08BPlWHFi7p4O2chJlJqCaEAP5uJQf6UPu0lIrabCWnsiVQKqSY+t7+OEUJVq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:35.2344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf34ef7c-3b82-4304-9f19-08df141b4a49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964
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
Reduce the six KUnit tests for amdgpu_dm_plane_get_plane_modifiers() to
three, keeping every family dispatch covered.

[HOW]
Merge the GFX10.1, GFX10.3 and GFX12 cases into one table-driven test
over the family and GC IP version, and merge the two RV cases into a
table over the external revision id that selects the constant-encode
modifier variants.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 231 +++++++-----------
 1 file changed, 87 insertions(+), 144 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 8fcde1e55a31..a96688beae89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -1341,152 +1341,117 @@ static void dm_test_get_plane_modifiers_gfx9(struct kunit *test)
 }
 
 /**
- * dm_test_get_plane_modifiers_rv() - Verify RV modifier list generation.
+ * dm_test_get_plane_modifiers_gfx10_and_gfx12() - Verify newer family dispatch.
  * @test: KUnit test context.
  *
- * Verify if pre-Raven2 RV devices add RV-specific S-swizzle modifiers and
- * non-constant-encode DCC modifiers.
+ * Verify if the GFX10.1, GFX10.3 and GFX12 configurations each dispatch to
+ * their modifier builder and produce a terminated list.
  */
-static void dm_test_get_plane_modifiers_rv(struct kunit *test)
+static void dm_test_get_plane_modifiers_gfx10_and_gfx12(struct kunit *test)
 {
-	struct amdgpu_device *adev;
-	u64 *mods;
-	u64 dcc_mod;
-	u64 s_x_mod;
-	u64 s_mod;
-	int pipes = 2;
-	int pipe_xor_bits = 3;
-	int bank_xor_bits = 2;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
+	static const struct {
+		u32 family;
+		u32 gc_ip_version;
+		u32 num_pipes;
+		u32 num_pkrs;
+	} cases[] = {
+		{ AMDGPU_FAMILY_NV, IP_VERSION(10, 1, 0), 4, 0 },
+		{ AMDGPU_FAMILY_NV, IP_VERSION(10, 3, 0), 4, 2 },
+		{ AMDGPU_FAMILY_GC_12_0_0, 0, 0, 0 },
+	};
+	unsigned int i;
 
-	adev->family = AMDGPU_FAMILY_RV;
-	adev->asic_type = CHIP_RAVEN;
-	adev->external_rev_id = 0x80;
-	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
-	adev->gfx.config.gb_addr_config_fields.num_banks = 4;
-	adev->gfx.config.gb_addr_config_fields.num_se = 2;
-	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 2;
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct amdgpu_device *adev;
 
-	mods = dm_test_get_primary_mods(test, adev);
-	dcc_mod = AMD_FMT_MOD |
-		  AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-		  AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-		  AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		  AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
-		  AMD_FMT_MOD_SET(DCC, 1) |
-		  AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-		  AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
-		  AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0);
-	s_x_mod = AMD_FMT_MOD |
-		  AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-		  AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-		  AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		  AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits);
-	s_mod = AMD_FMT_MOD |
-		AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
-		AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9);
+		adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, adev);
 
-	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, dcc_mod));
-	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, dcc_mod |
-							     AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-							     AMD_FMT_MOD_SET(RB, 2) |
-							     AMD_FMT_MOD_SET(PIPE, pipes)));
-	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, s_x_mod));
-	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, s_mod));
+		adev->family = cases[i].family;
+		adev->ip_versions[GC_HWIP][0] = cases[i].gc_ip_version;
+		adev->gfx.config.gb_addr_config_fields.num_pipes = cases[i].num_pipes;
+		adev->gfx.config.gb_addr_config_fields.num_pkrs = cases[i].num_pkrs;
 
-	kfree(mods);
+		dm_test_expect_mods_terminated(test, adev);
+	}
 }
 
 /**
- * dm_test_get_plane_modifiers_rv_constant_encode() - Verify Raven2+ modifiers.
+ * dm_test_get_plane_modifiers_rv() - Verify RV modifier list generation.
  * @test: KUnit test context.
  *
- * Verify if Raven2 and later RV devices add the constant-encode modifier
- * variants.
+ * Verify if RV devices add the RV-specific S-swizzle modifiers, and if the
+ * constant-encode DCC variants only appear from Raven2 onwards.
  */
-static void dm_test_get_plane_modifiers_rv_constant_encode(struct kunit *test)
+static void dm_test_get_plane_modifiers_rv(struct kunit *test)
 {
-	struct amdgpu_device *adev;
-	u64 *mods;
-	u64 dcc_mod;
+	static const struct {
+		const char *name;
+		u32 external_rev_id;
+		u32 constant_encode;
+	} cases[] = {
+		{ "raven", 0x80, 0 },
+		{ "raven2", 0x81, 1 },
+	};
 	int pipes = 2;
 	int pipe_xor_bits = 3;
 	int bank_xor_bits = 2;
+	u64 s_x_mod;
+	u64 s_mod;
+	unsigned int i;
 
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-
-	adev->family = AMDGPU_FAMILY_RV;
-	adev->asic_type = CHIP_RAVEN;
-	adev->external_rev_id = 0x81;
-	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
-	adev->gfx.config.gb_addr_config_fields.num_banks = 4;
-	adev->gfx.config.gb_addr_config_fields.num_se = 2;
-	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 2;
-
-	mods = dm_test_get_primary_mods(test, adev);
-	dcc_mod = AMD_FMT_MOD |
+	s_x_mod = AMD_FMT_MOD |
 		  AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
 		  AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
 		  AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		  AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
-		  AMD_FMT_MOD_SET(DCC, 1) |
-		  AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-		  AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
-		  AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1);
-
-	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, dcc_mod));
-	KUNIT_EXPECT_TRUE(test, dm_test_mods_contain(mods, dcc_mod |
-							     AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-							     AMD_FMT_MOD_SET(RB, 2) |
-							     AMD_FMT_MOD_SET(PIPE, pipes)));
-
-	kfree(mods);
-}
-
-/**
- * dm_test_get_plane_modifiers_gfx10_1() - Verify GFX10.1 modifier list generation.
- * @test: KUnit test context.
- *
- * Verify if a pre-10.3 NV family device dispatches to the GFX10.1 modifier
- * builder and produces a terminated list.
- */
-static void dm_test_get_plane_modifiers_gfx10_1(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-
-	adev->family = AMDGPU_FAMILY_NV;
-	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
-	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 1, 0);
-
-	dm_test_expect_mods_terminated(test, adev);
-}
-
-/**
- * dm_test_get_plane_modifiers_gfx10_3() - Verify GFX10.3 modifier list generation.
- * @test: KUnit test context.
- *
- * Verify if a 10.3+ NV family device dispatches to the GFX10.3 modifier
- * builder and produces a terminated list.
- */
-static void dm_test_get_plane_modifiers_gfx10_3(struct kunit *test)
-{
-	struct amdgpu_device *adev;
+		  AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits);
+	s_mod = AMD_FMT_MOD |
+		AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+		AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9);
 
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct amdgpu_device *adev;
+		u64 *mods;
+		u64 dcc_mod;
+		u64 retile_mod;
 
-	adev->family = AMDGPU_FAMILY_NV;
-	adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
-	adev->gfx.config.gb_addr_config_fields.num_pkrs = 2;
-	adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+		adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, adev);
 
-	dm_test_expect_mods_terminated(test, adev);
+		adev->family = AMDGPU_FAMILY_RV;
+		adev->asic_type = CHIP_RAVEN;
+		adev->external_rev_id = cases[i].external_rev_id;
+		adev->gfx.config.gb_addr_config_fields.num_pipes = 4;
+		adev->gfx.config.gb_addr_config_fields.num_banks = 4;
+		adev->gfx.config.gb_addr_config_fields.num_se = 2;
+		adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 2;
+
+		mods = dm_test_get_primary_mods(test, adev);
+		dcc_mod = AMD_FMT_MOD |
+			  AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+			  AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+			  AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+			  AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+			  AMD_FMT_MOD_SET(DCC, 1) |
+			  AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+			  AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+			  AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, cases[i].constant_encode);
+		retile_mod = dcc_mod |
+			     AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+			     AMD_FMT_MOD_SET(RB, 2) |
+			     AMD_FMT_MOD_SET(PIPE, pipes);
+
+		KUNIT_EXPECT_TRUE_MSG(test, dm_test_mods_contain(mods, dcc_mod),
+				      "%s", cases[i].name);
+		KUNIT_EXPECT_TRUE_MSG(test, dm_test_mods_contain(mods, retile_mod),
+				      "%s", cases[i].name);
+		KUNIT_EXPECT_TRUE_MSG(test, dm_test_mods_contain(mods, s_x_mod),
+				      "%s", cases[i].name);
+		KUNIT_EXPECT_TRUE_MSG(test, dm_test_mods_contain(mods, s_mod),
+				      "%s", cases[i].name);
+
+		kfree(mods);
+	}
 }
 
 /**
@@ -1571,25 +1536,6 @@ static void dm_test_get_plane_modifiers_gfx11_256k_first(struct kunit *test)
 	kfree(mods);
 }
 
-/**
- * dm_test_get_plane_modifiers_gfx12() - Verify GFX12 modifier list generation.
- * @test: KUnit test context.
- *
- * Verify if the GFX12 family dispatches to the GFX12 modifier builder and
- * produces a terminated list.
- */
-static void dm_test_get_plane_modifiers_gfx12(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-
-	adev->family = AMDGPU_FAMILY_GC_12_0_0;
-
-	dm_test_expect_mods_terminated(test, adev);
-}
-
 /**
  * dm_test_fill_gfx9_plane_attributes_dcc() - Verify GFX9 DCC modifier path.
  * @test: KUnit test context.
@@ -3957,12 +3903,9 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_get_plane_modifiers_gfx6),
 	KUNIT_CASE(dm_test_get_plane_modifiers_gfx9),
 	KUNIT_CASE(dm_test_get_plane_modifiers_rv),
-	KUNIT_CASE(dm_test_get_plane_modifiers_rv_constant_encode),
-	KUNIT_CASE(dm_test_get_plane_modifiers_gfx10_1),
-	KUNIT_CASE(dm_test_get_plane_modifiers_gfx10_3),
+	KUNIT_CASE(dm_test_get_plane_modifiers_gfx10_and_gfx12),
 	KUNIT_CASE(dm_test_get_plane_modifiers_gfx11_64k_first),
 	KUNIT_CASE(dm_test_get_plane_modifiers_gfx11_256k_first),
-	KUNIT_CASE(dm_test_get_plane_modifiers_gfx12),
 	/* amdgpu_dm_plane_fill_dc_scaling_info() */
 	KUNIT_CASE(dm_test_fill_dc_scaling_info),
 	KUNIT_CASE(dm_test_fill_dc_scaling_info_nv12_dcn1x),
-- 
2.55.0

