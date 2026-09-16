Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F3AC982D2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FF110ECAD;
	Wed, 16 Sep 2026 17:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c02I5R1T";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012027.outbound.protection.outlook.com
 [40.107.200.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3646310EBD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d554yE3hTAXkcszQaMpWhCs2pWaGU2V15wyhbvbdTr6DsaA5k+k5EWSuJt9iu7vNWMu2kyQ19pvKjJr7KCcI2mzUH5VaBJF11lHfjHNJSFOCLdzguqJIQDOjmdQi/TsLRWOFnJ3c3HYKuBZw9uuWZGeo66sgQir5bY3J4htkE9ViOcesERuw3IUNGmG8l69LQXg3Yry5+8+pZqG+/+EkNkuJOKErNRWUM4gUv1lHjtdyat0C7/lD1DopackGYbrM3aDPkl7Mh82QjAgUsX97J2X/o50E4Y7m2ljTiHQPRlVGtJKdIOzJ+VVXukeY2ap32HDYqnDzCmZY7Vm8Gnod6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Axfltm/cAzs+abrpBMyUInQgDN9qg/pVX0Zc8R1FG0E=;
 b=lzwr6iCwyrJwZSfM/QMcMNZ/zVpOp7H1go2Of4Cs+Doq0jeaok2vrpzCQwuWnyZ7GKiYsaOuUXatVTAeS2erKsZGrFV/ShQ8AwVjknV49YQP/lbJrTuNe1EoO2u9gtXhM1LICCzAwW3zZQSHkB/y9TpNLB+Ni+yvqMPSzFcRMJ3UPqaRqsadnxpfazucUEAxjI7396fqF5E4TZQqgG1+gh2wVW5AhqC8ud8ymJ36efllURy6erxeCddM108j2bLCnf4XvI6p6bHuz/NiN9kD0NnxMGN8RGcLlvL1rdtbzkKA6USi5FYDV6RhzrDLFsg2N+vu2SkvjHFIn6vt51sFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axfltm/cAzs+abrpBMyUInQgDN9qg/pVX0Zc8R1FG0E=;
 b=c02I5R1TKhz273PBWw2ULdazwCnvfUZnD3qrMaxxPRKqkrpgDhX2UfZ3LRBWhT6aXEyc4mG6kqRp511MVXp4+TR6l4q3nroQXPSdUz6dorFAcHQQjTCTQQ7C9w9tz0i+5cIdMd6Eb3uRviQxwjbzjbXFYLOJaA1W4jUs25I8iA0=
Received: from CH2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:610:4c::24)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:38 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::28) by CH2PR10CA0014.outlook.office365.com
 (2603:10b6:610:4c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 17:52:38 +0000
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
 2026 12:52:25 -0500
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
Subject: [PATCH 15/64] drm/amd/display: Fold modifier append tests
Date: Wed, 16 Sep 2026 13:51:30 -0400
Message-ID: <20260916175301.368306-16-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 48df004e-86c6-4573-d061-08df141b4c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|6133799003|18002099003|56012099006|5023799004|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: iZjTzi2EokMrEjISg8bvMrKRqeES/b66+ZewVuxYFkdzdTsRzv/+meHwwBu6Exb0wJenNJGytfVuY74FVLiMG+a/2n93RsDyjoLx/RgCU0I1PezuqKtWcBGRpAcL5i+P8EGZ8Ia3/3f8gS7LbDkqjC11/rp0TKbZTN5DuBevVJ6aM8mpUH43okFx2MSXLvxacOt/LxsDlRAJRFeLHku7D2GGqAs4XMABH47bKfHFxuYcniZUDPAHjIfBaVqyTh5Nj4djF3qaI1oV6QgGRLLBVupS8WilFAiy3sczP36hgGaoGCfZDFWgjzAKgEkTfho5Mwgc5mYGmco2wJEUwWjR3lxXBM5hrw/tu+sprXieOItbFBGWb99Q/0J77YsHFWmlpkjYoImWWRaZII7Nl1FYFj92fBTASbe8QGek3ggq24ijk4ZlzM0pLxDp5sAtz4R4IPSw0eqn1Aqqn4vBf04ZdbOTjSHlIT3I0U4CBO+JGzzRBhWxWiBkC3bzvwRP7jtQHxG/NgNHkGreGRBpL8gkYXsGeQ/dKspn3St22gzhn6kvDHz4AQeoLcVrE4hHVyi7H0capwPxeZNAPEzWqPWWbVSr/9M6rxZgOHEwFJ8uv791XyYIabnF7d94PV2OFBJRhtGoIwfFCojoIULKkMMW1CQKUlN/TD1uwhgs/j0eeIAtwqlmKfOvVzFVOlEYocskQgdIitta7G++h/eLUmV30w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(56012099006)(5023799004)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tfvkQG1Mt0tHn763/IbGrXZkD9OdSuv2fE23c7Z1Aa5HZKU0iI31cAewI8VSFyUmZ+FMzreaU5EtkzQlSgExNMDEvtQjtJ6jRnjWu5pFoTzqPZ8sfI4xcUv4Mb9A/yUSKXk/zEdXOufNIUrPiDHOcChzO0Xz2OmfugXnHgb86rVl/YhTYMPEGyW2oy89VcqD7w0MgJdE0yYZz6g5u9otrYaPXSSa6AECxWhJFPQ6v8Hftgdgz4k+C7LwzywWBSsZFQuSXSfO9GkgkyBevta188se5ZhyNcFb+28UoIMEVJswg7+0l/GCdh9DWGIFrnDj1OTIXaYFJArwQ9e9wwEkE4gu3tIsOALrU3dS5OUubxYGW3p0jHyY2q11r7CY/uY+60w6rsIlnQT9zyYp4NCvNg6ryAt9Dci5llPupo1J9aqESqjIczKQhVLvdtHsYwoT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:38.4469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48df004e-86c6-4573-d061-08df141b4c33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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
Reduce the four KUnit tests for amdgpu_dm_plane_add_modifier() to two,
and the two tests for amdgpu_dm_plane_add_modifier_dedup() to one.

[HOW]
Group the append and capacity-growth cases into one test and the
NULL-list and allocation-failure cases into another, and run the
duplicate-skip and NULL-list dedup cases in sequence within a single
test.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 96 +++++++------------
 1 file changed, 33 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index a96688beae89..e2afb84de454 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -855,12 +855,13 @@ static void dm_test_validate_dcc_independent_64b_mismatch_fails(struct kunit *te
 }
 
 /**
- * dm_test_add_modifier_appends_value() - Verify one modifier append.
+ * dm_test_add_modifier_appends_and_grows() - Verify append and capacity growth.
  * @test: KUnit test context.
  *
- * Verify if a modifier is appended and size is updated.
+ * Verify if a modifier is appended within the existing capacity, and if a full
+ * list is grown while preserving the modifiers already stored.
  */
-static void dm_test_add_modifier_appends_value(struct kunit *test)
+static void dm_test_add_modifier_appends_and_grows(struct kunit *test)
 {
 	uint64_t size = 0;
 	uint64_t cap = 2;
@@ -876,20 +877,10 @@ static void dm_test_add_modifier_appends_value(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, mods[0], 0x1234ULL);
 
 	kfree(mods);
-}
-
-/**
- * dm_test_add_modifier_grows_capacity() - Verify add triggers growth and preserves old data.
- * @test: KUnit test context.
- *
- * Verify if modifier array growth keeps old data and appends new data.
- */
-static void dm_test_add_modifier_grows_capacity(struct kunit *test)
-{
-	uint64_t size = 1;
-	uint64_t cap = 1;
-	uint64_t *mods = kmalloc_array(cap, sizeof(*mods), GFP_KERNEL);
 
+	size = 1;
+	cap = 1;
+	mods = kmalloc_array(cap, sizeof(*mods), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, mods);
 	mods[0] = 0xAAULL;
 
@@ -905,12 +896,14 @@ static void dm_test_add_modifier_grows_capacity(struct kunit *test)
 }
 
 /**
- * dm_test_add_modifier_noop_when_mods_null() - Verify helper is a no-op on NULL mods list.
+ * dm_test_add_modifier_failure_paths() - Verify the two failure paths.
  * @test: KUnit test context.
  *
- * Verify if add_modifier does nothing when the modifier list is NULL.
+ * Verify if the append is a no-op once the modifier list is NULL, and if a
+ * failed capacity growth releases and clears the list so the caller can detect
+ * the allocation failure.
  */
-static void dm_test_add_modifier_noop_when_mods_null(struct kunit *test)
+static void dm_test_add_modifier_failure_paths(struct kunit *test)
 {
 	uint64_t size = 3;
 	uint64_t cap = 7;
@@ -921,6 +914,17 @@ static void dm_test_add_modifier_noop_when_mods_null(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, mods, NULL);
 	KUNIT_EXPECT_EQ(test, size, 3ULL);
 	KUNIT_EXPECT_EQ(test, cap, 7ULL);
+
+	/* Doubling this capacity overflows the kmalloc_array() size product. */
+	cap = 1ULL << 62;
+	size = cap;
+	mods = kmalloc_array(1, sizeof(*mods), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mods);
+
+	amdgpu_dm_plane_add_modifier(&mods, &size, &cap, 0x1234ULL);
+
+	KUNIT_EXPECT_PTR_EQ(test, mods, NULL);
+	KUNIT_EXPECT_EQ(test, size, 1ULL << 62);
 }
 
 /**
@@ -3028,13 +3032,14 @@ static void dm_test_plane_destroy_state_releases_resources(struct kunit *test)
 }
 
 /**
- * dm_test_add_modifier_dedup_skips_duplicate() - Verify duplicates are not appended.
+ * dm_test_add_modifier_dedup() - Verify the de-duplicating append.
  * @test: KUnit test context.
  *
  * Verify if a modifier already present in the list is not appended a second
- * time.
+ * time, and if the append is a no-op once the list is NULL after an earlier
+ * allocation failure.
  */
-static void dm_test_add_modifier_dedup_skips_duplicate(struct kunit *test)
+static void dm_test_add_modifier_dedup(struct kunit *test)
 {
 	u64 size = 2;
 	u64 cap = 4;
@@ -3055,20 +3060,10 @@ static void dm_test_add_modifier_dedup_skips_duplicate(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, mods[2], 0xCCULL);
 
 	kfree(mods);
-}
 
-/**
- * dm_test_add_modifier_dedup_noop_when_mods_null() - Verify NULL list is a no-op.
- * @test: KUnit test context.
- *
- * Verify if the de-duplicating append does nothing when the modifier list is
- * NULL after an earlier allocation failure.
- */
-static void dm_test_add_modifier_dedup_noop_when_mods_null(struct kunit *test)
-{
-	u64 size = 3;
-	u64 cap = 7;
-	u64 *mods = NULL;
+	size = 3;
+	cap = 7;
+	mods = NULL;
 
 	amdgpu_dm_plane_add_modifier_dedup(&mods, &size, &cap, 0x55ULL);
 
@@ -3563,28 +3558,6 @@ static void dm_test_atomic_async_update_copies_state(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, cur_state->crtc_h, 64U);
 }
 
-/**
- * dm_test_add_modifier_alloc_failure() - Verify the growth allocation failure.
- * @test: KUnit test context.
- *
- * Verify if a failed capacity growth releases and clears the modifier list so
- * the caller can detect the allocation failure.
- */
-static void dm_test_add_modifier_alloc_failure(struct kunit *test)
-{
-	/* Doubling this capacity overflows the kmalloc_array() size product. */
-	u64 cap = 1ULL << 62;
-	u64 size = cap;
-	u64 *mods = kmalloc_array(1, sizeof(*mods), GFP_KERNEL);
-
-	KUNIT_ASSERT_NOT_NULL(test, mods);
-
-	amdgpu_dm_plane_add_modifier(&mods, &size, &cap, 0x1234ULL);
-
-	KUNIT_EXPECT_PTR_EQ(test, mods, NULL);
-	KUNIT_EXPECT_EQ(test, size, 1ULL << 62);
-}
-
 /**
  * dm_test_fill_plane_buffer_attributes_gfx6() - Verify the pre-GFX9 dispatch.
  * @test: KUnit test context.
@@ -3976,13 +3949,10 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_plane_destroy_state_minimal),
 	KUNIT_CASE(dm_test_plane_destroy_state_releases_resources),
 	/* amdgpu_dm_plane_add_modifier() */
-	KUNIT_CASE(dm_test_add_modifier_appends_value),
-	KUNIT_CASE(dm_test_add_modifier_grows_capacity),
-	KUNIT_CASE(dm_test_add_modifier_noop_when_mods_null),
-	KUNIT_CASE(dm_test_add_modifier_alloc_failure),
+	KUNIT_CASE(dm_test_add_modifier_appends_and_grows),
+	KUNIT_CASE(dm_test_add_modifier_failure_paths),
 	/* amdgpu_dm_plane_add_modifier_dedup() */
-	KUNIT_CASE(dm_test_add_modifier_dedup_skips_duplicate),
-	KUNIT_CASE(dm_test_add_modifier_dedup_noop_when_mods_null),
+	KUNIT_CASE(dm_test_add_modifier_dedup),
 	/* amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier() */
 	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_linear),
 	KUNIT_CASE(dm_test_fill_gfx6_tiling_info_rejects),
-- 
2.55.0

