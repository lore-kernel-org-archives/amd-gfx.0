Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48490C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E2710EE07;
	Wed, 26 Aug 2026 23:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xhlgw1sw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B110310EE5F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcM25so0lwz7a/zcd2ron7vZfQWueiGt/q4HBxVabxIPblcuTj2JdYQuw3KwxkMQbrwxrokSBiATPpO8ynv7LBPXZRAEwJVd1MiezLGgdsuxorZpClkFUPb3+UYvRDq0E9RlclpaDjoHIKrbefZQ9naIGFtmA+gVxdYsziBWF9huT/XI8VwDaTYZLR5s2ioQxU3yXSTzyZYINi264wRr1SMkEtpZl3UDSgcAIHO9mR8MJKtjxujL2FKFGi77LI4+DK1mfe1qFdG8AJhKTuJzu3i9Z4ZnwEiaNJEVqa4A+oiJV9JP/Dx5dLjdM6VlkaqMh71aswysr+PXh1WB+5Wc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaFV5sZB417/7raKtr3yAmgtdi7vXIyZlmwJjEXRg7w=;
 b=A+/Vp9EnDrDUTsWM0IwEbhyjvU7aCUNMy+vRMVgIO/ZhWOs6eXiKOVJVMff7bTH6zGk62R+cLJHHB40j18oF5aMJql7/8+e15XdphOJdvKlvO8bmci//yXJ5iliVM7F3Kgad4XkqVWx6vQYsDFp36UZhXzUorEbR7MtVFkuAwI75yWbPAD4HO/UC37W9qERJDF4BEVtnqgagSCBeNUe9Oo8jKKO1ITf8uXTx1BBnoP8PYkZEIa9IbzVbZB2R0b14J3QcwB1vqLqrd3SuH/8qMfizYILYRAeeDeof9lGv890nWq6Nq3aD58Ve7MqlwbvcBhvm14kPvIoRqWBMra89ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaFV5sZB417/7raKtr3yAmgtdi7vXIyZlmwJjEXRg7w=;
 b=xhlgw1sw06ckJ4HUGq1/Bxf0WWKym1ZqLsTgIWNVFZSbZO9emWZ6jkVXvh8ttkyYJaAJ1fyOtjZtGfKT78TjJ+bcHgrMk+eUpWT6V9+mN/S1zdDiQHEVBMySJzf+iSyiuGCQVfPuDpyjIe8K2h0Wf72gL4XJNck5zjGXyqBTxkE=
Received: from SN7PR04CA0037.namprd04.prod.outlook.com (2603:10b6:806:120::12)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 23:30:49 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::ab) by SN7PR04CA0037.outlook.office365.com
 (2603:10b6:806:120::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.9 via Frontend Transport; Wed, 26
 Aug 2026 23:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:30:48 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:30:41 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 45/59] drm/amd/display: Test MMHUB config read
Date: Wed, 26 Aug 2026 17:05:16 -0600
Message-ID: <20260826231519.881949-46-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b03881-7019-4e91-c278-08df03ca0f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 12fM1KLnIf0XSm/imfs/Rsv44RuNRZ1psttzGXZelJmpyELbbknCfjd2fQbKOVl6tipY7BSwopYDFnwLCWtrUOIe25vjvtGf1B79gFRGT7hL/7CkExCwayhUbH8yZ8C53NevyrutYHgttG0BY9MymQpJ5vCjjx/RKwHwEg+uPVpUqr0bkdtFSd47bZiaMN5SvSlDuZeBISkJ7bBsAD5ZUpkBFtpGorzcKAcuMpHXMxWtM3NlozK/XfD3J2uiQG3XWAfQsogB0qik27ztGbAlLD4E46ogJ3PmaANMKUlB93kG+q6FHOrLqlbWYcUO53W8sSNuWfNizHR39sJMaaatxa5jKLreWCcx3nLpxFw8WrtU0cCftzNEtCOdw5OZgAS3Ox+lmg2aY6qxQCO/q6LoYRCXnjdO6mVWjT2ZWuu/V3dnygUkkJprDG2cBzKMMve17X0VRiUAis2hHU/qv4Ww0EFKnhQb5m0QIPmNOsZfqFdDA4++5mQH3B7qdSsEUedMfcW3sU1sWVY+BFviGeYcX6OI6DLfvAu62cvGrWOEiN7kh0VTgEDr3pr1EsfRHZlbBscUAqrw4Um12mADyciLlyFta238ANHmwgfEzqRV1Su6pK/KgHEhFrqXv0fEcBf/Wx9HJjGcUHE17DnlYdXOW6Mn4oxl6hpzKU8BmV2K560ZWsBmebRQTT+TJjrIAJX0lyVslj4NVmbqR0HJV0cZ1Q==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Stca0jRPhqwvs0eggaJoqIPS3sd1cmxVxvgBxzbsSjuJqCAoaq4fwN2SpqveQ0q49Q3WIN1RifdMal5j1YSC1g5Qp/TPxkkzU2rd9Eo1q1FxWFP6jHLgKff9sRETEEfoxY8UlH/0F+eatU9EYL9rJJtgcqyrYcgijdW2b/6QkeLb5VfXkX1h1FfwS85y5X+nQoVKCn6Bk5h3SkDauW/KYM4x2PAhZ33BUVQutQ4GHnScwiznCEEmBsh9aWM8nBjdDeD1g76gbOmgy00HzO4sgyNZONm6zmbgP3syP9mSWJ8Aw6+Ni0vDy6PdZ0t0loN9NRZCaXHXpEiFrQQ7IyU8z39sQTNk/ZX3z9Vx4l9Gs3nUfF22jFVlLKFj0O1PHqJgjetQEGrGT5/YLSBcsWKV0orONx9BXwiRVLMCgUdy3Au2HXg7+AhvGsthVY1DVRCq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:30:48.2618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b03881-7019-4e91-c278-08df03ca0f3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
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

[WHAT]
Add KUnit tests for the system aperture and GART configuration built by
mmhub_read_system_context(), covering the enabled and disabled AGP
aperture branches, the Raven2 and Renoir aperture workarounds, and the
GPUVM support flag.

[HOW]
Add struct amdgpu_dm_kunit_ops, a KUnit-only indirection table for
amdgpu_gmc_pd_addr(), which walks a live TTM buffer object back to its
device. Tests install a stub returning a fixed page directory address,
which makes the arithmetic reachable in the UML test environment. The
default table points at the existing AMDGPU function, so no test-only
wrapper is introduced.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  24 +++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  11 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 128 ++++++++++++++++++
 3 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 71fe85498766..ffc5cea6b6df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -309,8 +309,27 @@ EXPORT_IF_KUNIT(dm_set_powergating_state);
 /* Prototypes of private functions */
 static int dm_early_init(struct amdgpu_ip_block *ip_block);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+static const struct amdgpu_dm_kunit_ops amdgpu_dm_default_ops = {
+	.gmc_pd_addr = amdgpu_gmc_pd_addr,
+};
+
+static const struct amdgpu_dm_kunit_ops *amdgpu_dm_ops = &amdgpu_dm_default_ops;
+
+void amdgpu_dm_kunit_set_ops(const struct amdgpu_dm_kunit_ops *ops)
+{
+	amdgpu_dm_ops = ops ? ops : &amdgpu_dm_default_ops;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_kunit_set_ops);
+
+#define dm_gmc_pd_addr		amdgpu_dm_ops->gmc_pd_addr
+#else
+#define dm_gmc_pd_addr		amdgpu_gmc_pd_addr
+#endif
+
 /* Allocate memory for FBC compressed data  */
-static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
+STATIC_IFN_KUNIT void mmhub_read_system_context(struct amdgpu_device *adev,
+						struct dc_phy_addr_space_config *pa_config)
 {
 	u64 pt_base;
 	u32 logical_addr_low;
@@ -355,7 +374,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 			logical_addr_high = max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18;
 	}
 
-	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+	pt_base = dm_gmc_pd_addr(adev->gart.bo);
 
 	page_table_start.high_part = upper_32_bits(adev->gmc.gart_start >>
 						   AMDGPU_GPU_PAGE_SHIFT);
@@ -386,6 +405,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	pa_config->is_hvm_enabled = adev->mode_info.gpu_vm_support;
 
 }
+EXPORT_IF_KUNIT(mmhub_read_system_context);
 
 static int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 5ffaca8a6efe..a53246040948 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1241,6 +1241,17 @@ struct amdgpu_dm_services_kunit_ops {
 };
 
 void amdgpu_dm_services_kunit_set_ops(const struct amdgpu_dm_services_kunit_ops *ops);
+
+struct amdgpu_dm_kunit_ops {
+	uint64_t (*gmc_pd_addr)(struct amdgpu_bo *bo);
+};
+
+void amdgpu_dm_kunit_set_ops(const struct amdgpu_dm_kunit_ops *ops);
+
+struct dc_phy_addr_space_config;
+
+void mmhub_read_system_context(struct amdgpu_device *adev,
+			       struct dc_phy_addr_space_config *pa_config);
 #endif
 
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index a8140747c25d..bb52da037e69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3399,6 +3399,129 @@ static void dm_test_atomic_setup_commit_bad_lut(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_atomic_setup_commit(ctx->state), -EINVAL);
 }
 
+/* Tests for mmhub_read_system_context() */
+
+#define DM_TEST_PD_ADDR		0x1234000ULL
+
+/*
+ * Stub for the page directory address read: amdgpu_gmc_pd_addr() walks a live
+ * TTM buffer object back to its device, so return a fixed address instead.
+ */
+static uint64_t dm_test_gmc_pd_addr(struct amdgpu_bo *bo)
+{
+	return DM_TEST_PD_ADDR;
+}
+
+static const struct amdgpu_dm_kunit_ops dm_test_dm_ops = {
+	.gmc_pd_addr = dm_test_gmc_pd_addr,
+};
+
+static void dm_test_restore_dm_ops(void *ctx)
+{
+	amdgpu_dm_kunit_set_ops(NULL);
+}
+
+/*
+ * A device whose AGP aperture is disabled (bot above top), so the frame buffer
+ * alone decides the logical address range.
+ */
+static struct amdgpu_device *dm_test_mmhub_adev(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	amdgpu_dm_kunit_set_ops(&dm_test_dm_ops);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_restore_dm_ops, NULL), 0);
+
+	adev->gmc.agp_start = 0x2000000;
+	adev->gmc.agp_end = 0x1000000;
+	adev->gmc.fb_start = 0x40000000;
+	adev->gmc.fb_end = 0x7fffffff;
+	adev->gmc.gart_start = 0x100000000ULL;
+	adev->gmc.gart_end = 0x1ffffffffULL;
+	adev->vm_manager.vram_base_offset = 0x800000;
+
+	return adev;
+}
+
+/**
+ * dm_test_mmhub_agp_disabled - Test a disabled AGP aperture uses the frame buffer
+ * @test: The KUnit test context
+ */
+static void dm_test_mmhub_agp_disabled(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_mmhub_adev(test);
+	struct dc_phy_addr_space_config pa_config;
+
+	mmhub_read_system_context(adev, &pa_config);
+
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.start_addr, 0x40000000ULL);
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.end_addr, 0x7ffc0000ULL);
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.agp_base, 0ULL);
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.agp_bot, 0x2000000ULL);
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.agp_top, 0x1000000ULL);
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.fb_base, 0x40000000ULL);
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.fb_offset, 0x800000ULL);
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.fb_top, 0x7fffffffULL);
+	KUNIT_EXPECT_EQ(test, pa_config.gart_config.page_table_start_addr, 0x100000000ULL);
+	KUNIT_EXPECT_EQ(test, pa_config.gart_config.page_table_end_addr, 0x1fffff000ULL);
+	KUNIT_EXPECT_EQ(test, pa_config.gart_config.page_table_base_addr, DM_TEST_PD_ADDR);
+	KUNIT_EXPECT_FALSE(test, pa_config.is_hvm_enabled);
+}
+
+/**
+ * dm_test_mmhub_agp_disabled_raven2 - Test the Raven2 aperture workaround
+ * @test: The KUnit test context
+ */
+static void dm_test_mmhub_agp_disabled_raven2(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_mmhub_adev(test);
+	struct dc_phy_addr_space_config pa_config;
+
+	adev->apu_flags = AMD_APU_IS_RAVEN2;
+
+	mmhub_read_system_context(adev, &pa_config);
+
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.end_addr, 0x80000000ULL);
+}
+
+/**
+ * dm_test_mmhub_agp_enabled - Test an enabled AGP aperture widens the range
+ * @test: The KUnit test context
+ */
+static void dm_test_mmhub_agp_enabled(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_mmhub_adev(test);
+	struct dc_phy_addr_space_config pa_config;
+
+	adev->gmc.agp_start = 0x1000000;
+	adev->gmc.agp_end = 0x2000000;
+	adev->mode_info.gpu_vm_support = true;
+
+	mmhub_read_system_context(adev, &pa_config);
+
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.start_addr, 0x1000000ULL);
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.end_addr, 0x7ffc0000ULL);
+	KUNIT_EXPECT_TRUE(test, pa_config.is_hvm_enabled);
+}
+
+/**
+ * dm_test_mmhub_agp_enabled_renoir - Test the Renoir aperture workaround
+ * @test: The KUnit test context
+ */
+static void dm_test_mmhub_agp_enabled_renoir(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_mmhub_adev(test);
+	struct dc_phy_addr_space_config pa_config;
+
+	adev->gmc.agp_start = 0x1000000;
+	adev->gmc.agp_end = 0x2000000;
+	adev->apu_flags = AMD_APU_IS_RENOIR;
+
+	mmhub_read_system_context(adev, &pa_config);
+
+	KUNIT_EXPECT_EQ(test, pa_config.system_aperture.end_addr, 0x80000000ULL);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3571,6 +3694,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_oem_i2c_hw_init_no_device),
 	KUNIT_CASE(dm_test_gpureset_commit_state_no_streams),
 	KUNIT_CASE(dm_test_emulated_link_detect_bad_signal),
+	/* mmhub_read_system_context */
+	KUNIT_CASE(dm_test_mmhub_agp_disabled),
+	KUNIT_CASE(dm_test_mmhub_agp_disabled_raven2),
+	KUNIT_CASE(dm_test_mmhub_agp_enabled),
+	KUNIT_CASE(dm_test_mmhub_agp_enabled_renoir),
 	{}
 };
 
-- 
2.43.0

