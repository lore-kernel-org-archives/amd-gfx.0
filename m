Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3819DC5DF96
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A6010ECBC;
	Tue, 18 Aug 2026 20:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y7uhcREu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82AB10ECAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vqwi9oS0z1vhbkSGrWeO1BU/ZhmBbLgIjT3aFW+koKT+20jS9lzozyacnazhpARKZEeR/52AFhgQkxzWktm5VgruXOc3hOLc1PNTrukp/OQVlcb94mF28d9OqGQsA+WWYKmY+79CLyYdeA5+WRPt484TpLR5XSW0cYX1vm0WMFC/XfW3NM3tGSSmS/DvtDrqJ0v+hXAaBiSMfC56zCAyNopSTChfoVphy6Ff9ktgo7pMF9BvriKAkrnNvIx6Zgu7O6Ab8k+2IBge1K/WqE8ZI8f1NRpHDzuK2fJ/W9Z5JQJwwgzTMt46PtQN6bHRb4hnjiLlv47TD5WTOGoobO9yiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxVysfL+4xH3pL7B9a340Wkguev790T4VFEw9LkjE6s=;
 b=O5fvutmvzOsjX7Eslih0beFyDqEq6/SnvPfy6pVSM27QHXw25AQEu3GExSee6bdoexXjPWDJm5+AABdV1wfo+v5SETBjM9OmNA4ccFWwISiUOgPP9CJw1f4YuQWx2IWcSOkRAzH6AJxmf83X2KoO0SL+RqURDNLG63hJVlXiQ8NDTlwPv9UZANQ3W/k9gt0QNSiiie8oQu4fbhoUd5UiV/yU8f9K2tXDQ4ZUVx9C8FlHam/wnr3vZ7b8fwIUkzhnbcudmWSryH6DAcjTXFMADE1krPuCG6XaPbUxOE3+sXYGxiT7y0abeVWJCcqr81D0wWGFZmOvkHizhGa/z6WxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxVysfL+4xH3pL7B9a340Wkguev790T4VFEw9LkjE6s=;
 b=y7uhcREuE/R43HnWT/OIHc3lRFm8EIUU/+s/n3JUTVUvrCz0K/efVZAUTBti9f45rJoHxpbzjko79gboIFAUYjPD8p3BWPrAZ2w9pKjC6R+jTxHQamHrSmf+8Bge/s5U6NX4ORF+DTrwihBwkXnDSXrAO+jG4Ak3cZtrD/2ed+8=
Received: from CH5P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::13)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:34 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::48) by CH5P222CA0015.outlook.office365.com
 (2603:10b6:610:1ee::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:26 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:25 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:25 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 45/82] drm/amd/display: Test modifier list de-duplication
Date: Tue, 18 Aug 2026 16:15:37 -0400
Message-ID: <20260818202139.4172592-46-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: ad87874c-aa36-4cf0-68bf-08defd66706f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|56012099006|10067099003|22082099003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: rm0STNObUHSSakpT40B1pWLnv1j5zI4c0WHa8qVlgNFWygk19ianOX6HFjLEATrs7b9JjNTibgCxV01oCtLc9q4767oFuqy3duCVofpcnvNKTZzrtegWyrMkPVrhx1/yhujvHvdcHZfmB40XSv1dLNz+8T12PfYjfPMLOZUoifCPGUu8EQLnw4diXIegRNHaea/IS9BHD4n7sdwRE8v7Maz19aqpdNC1EStemthk6X/Mqnye/WumRzgWUEMoBKT0iMIUOmA8jwIgorm92Yzb6MWT4uaDy4oWU3Vb/n+6q+6n65DRWfngSfkH4JrPMQ5VVm1dWvfpKLC42BrDoUDF4AGiEyKu5sMcK14FRbAuxEV59/9kOg/Q4Q4nw/fP4cr20006KiF24N1OIw+Gt4l17GatMWpol59RpRkyCO0+I7BLfZdlXKBg8IGBUjHADSW+HyuRWbLX3nUqPvZlUzN77wXyl5gv/bOM1+azPPaMqljiM9FR5AxuJ/bShwkablcV2irinoCNMdaCGOhpKV9JYad7oSFpXlw1kG5pZ3temK8hzcXm4aTiH/AYmoBJW8pTmG4sJFvxB9PAR9bwmEQaQaMwaBxrCfsn69wn6vcFS79gMJxlb+FH8v0cvsSuGgVSF97gVBm4aAbV8WB2TRQZJpf9i6pZ3OMqHdbh12QxOMJnaqVhZEhZRHlC4dgAl+/9zcw6t/q5dP1k4im2YS89SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6ckFYDCcf0nwYZKuBtBjAN3cMea+XtRCzpJU3l9pGqfVHhItEvbHm55GHYY6KUELZ23go70+aaYSrstY+WNR6FmGjgWC/uvO0NMmLVsM4A7xNyQqW5s/cfBWiJIqDJeEixRt6yfPBZriL4ZsWgz8alLk5Yx2q8uU+sN3pSSzx9zKVO2Cjeu9Zp4YZot1AOCeG+Pok7X67amOodBLIwAfBJgU1rDTvOmEBPsasY3dSFUi/Da++55JJfvKCyGlVI/DRsZQvAEm3ayv7ZSJ+8SIamS+LzXorvPRLNGgZBJfLbvjnsthFwqIDda8FIzI4xzUpfhq1EZTU/VCq2vpc0SURgF6QfmQyTmdQFDvijfGdbecAuPdgAz4GFPBpbRNnQaPT8f2HeOSw0Yro7GaZYG8yabcjoupDCd7YJ6rP87KrhbJ0BqgiqoJJZtNGzJtozqv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:34.7606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad87874c-aa36-4cf0-68bf-08defd66706f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
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
Add KUnit tests for amdgpu_dm_plane_add_modifier_dedup() covering a
modifier already present in the list, which is not appended a second
time, a new modifier, which is appended, and a NULL list left over from
an earlier allocation failure, which is a no-op.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 17789b3845b77..4017dc1d6a771 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3135,6 +3135,56 @@ static void dm_test_plane_destroy_state_releases_resources(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, kref_read(&dc_plane_state->refcount), 1U);
 }
 
+/**
+ * dm_test_add_modifier_dedup_skips_duplicate() - Verify duplicates are not appended.
+ * @test: KUnit test context.
+ *
+ * Verify if a modifier already present in the list is not appended a second
+ * time.
+ */
+static void dm_test_add_modifier_dedup_skips_duplicate(struct kunit *test)
+{
+	u64 size = 2;
+	u64 cap = 4;
+	u64 *mods = kmalloc_array(cap, sizeof(*mods), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, mods);
+	mods[0] = 0xAAULL;
+	mods[1] = 0xBBULL;
+
+	amdgpu_dm_plane_add_modifier_dedup(&mods, &size, &cap, 0xAAULL);
+	KUNIT_EXPECT_EQ(test, size, 2ULL);
+
+	amdgpu_dm_plane_add_modifier_dedup(&mods, &size, &cap, 0xBBULL);
+	KUNIT_EXPECT_EQ(test, size, 2ULL);
+
+	amdgpu_dm_plane_add_modifier_dedup(&mods, &size, &cap, 0xCCULL);
+	KUNIT_ASSERT_EQ(test, size, 3ULL);
+	KUNIT_EXPECT_EQ(test, mods[2], 0xCCULL);
+
+	kfree(mods);
+}
+
+/**
+ * dm_test_add_modifier_dedup_noop_when_mods_null() - Verify NULL list is a no-op.
+ * @test: KUnit test context.
+ *
+ * Verify if the de-duplicating append does nothing when the modifier list is
+ * NULL after an earlier allocation failure.
+ */
+static void dm_test_add_modifier_dedup_noop_when_mods_null(struct kunit *test)
+{
+	u64 size = 3;
+	u64 cap = 7;
+	u64 *mods = NULL;
+
+	amdgpu_dm_plane_add_modifier_dedup(&mods, &size, &cap, 0x55ULL);
+
+	KUNIT_EXPECT_PTR_EQ(test, mods, NULL);
+	KUNIT_EXPECT_EQ(test, size, 3ULL);
+	KUNIT_EXPECT_EQ(test, cap, 7ULL);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3221,6 +3271,9 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_add_modifier_appends_value),
 	KUNIT_CASE(dm_test_add_modifier_grows_capacity),
 	KUNIT_CASE(dm_test_add_modifier_noop_when_mods_null),
+	/* amdgpu_dm_plane_add_modifier_dedup() */
+	KUNIT_CASE(dm_test_add_modifier_dedup_skips_duplicate),
+	KUNIT_CASE(dm_test_add_modifier_dedup_noop_when_mods_null),
 	/* amdgpu_dm_plane_fill_gfx9_tiling_info_from_device() */
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_pre_10_3),
 	KUNIT_CASE(dm_test_fill_gfx9_tiling_info_from_device_10_3_plus),
-- 
2.43.0

