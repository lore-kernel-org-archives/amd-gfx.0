Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3610CC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C801D10EB3B;
	Tue,  8 Sep 2026 11:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t+09jgV2";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261C810EB3B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjYraFBg6wG6PMwAXKWClSDvFklkvEEQBpIV4pK+71R3LFeL2mdv4nF9YDsKEr3PznDH10qD4XyXcwl3l4eJ9bBh4Iq9a5HBygdQn55l81dXaa+mw17GN4MWdrPWFhL8X422WiL/5fWuYrcS7Dzm8H2BJ7QTzFb8P52OHkwiaG9Iq+TMtj7uRpi1pLwGWhlolbvKvLEpHRQL0VS+vWK5p0dRkrh5PrhJNDQbHFVnY71HMTCOcJ890ZA/ca5EukNIiOA47JGn5ND6I8b9duwEKr3zFyY4tUoxX7D5Jv2coJKpaZcMnG+Dq6FqTMwhFr4zBy0NfiHVOetrwr+zm6Ku1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqAI6jNpNxlQnBi1/gjABt1zBmslJH1Nx7j+YV0FNaY=;
 b=Q/Q2N2PuymlMmNUPSy8dbhrmADa+BsQGNp2/xkj0bxrflYjD/S97IVMSNDx9Rao6AxpPM0NPEJi4IbWRlGryU8lsW2w+FFJ6ixdceni546xjK9bWRUsebMURtRm+750/Uw19G2R6wQiyS7283M/XfxfnAy+amtDDcYwZFbgztPacZq5NZxXIw8ukbV1kDxHcjxs9XBdIGSIpzgI9ZBH2//dV6p1AuvysfDydLmaxoeyxkNgk3d1+ZfDjxtxYEjZ3PuBJ+TCLUlEygejo0NMgBn3zodfh6MP7izMRaE+lOZAk2fzYSlUW1VIFzOUsL+5/x4EkFHAki/TV1IXZOr/lpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqAI6jNpNxlQnBi1/gjABt1zBmslJH1Nx7j+YV0FNaY=;
 b=t+09jgV2QrmYU7nXD1rOqAyWaaWEp5kq5/+nHIYT8yjm9FeWzKBJiJyuZVM8Xv+7xRtV+jz53pE3A6oyEnkp0CCyBdlNdO879AHnDw8NJeaDDjLpIQCkChRHshs7eXgKKJhM1hLMEtj0dcVtuXmP/e6CNg7hUwgnFuB9ycrir+4=
Received: from MN2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:208:239::15)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 8 Sep
 2026 11:35:36 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::78) by MN2PR08CA0010.outlook.office365.com
 (2603:10b6:208:239::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:35:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:35:33 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:35:24 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 12/66] drm/amd/display: Test modifier list growth failure
Date: Tue, 8 Sep 2026 19:31:05 +0800
Message-ID: <20260908113338.2433445-13-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 712094b0-339d-45ac-7eee-08df0d9d4cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Wb86OyRvJVrbU3rpArKjth7ghpNY3v5wwQmuQuIPapCWfxkUwfRsZo13/h/TyAFWFeqMiuxhmSuChPARx8C719ThsVEZi/mvy0Ie0RdfhQOVCn8ibcoF/4SKRUWwrkVVbWmJ7mT8i1g4Kg0C66ft0iFyLd2/eZLq7qBCZx1fS3+gNoM+m09JnL/w7a8CqJ3gTZVbPwcnfIAYoQKDjNYS2EBzWSC/UdYMPrTTXAKdA1HWx33ZdEVd8RFvaQTe4vOZHddipB9Ja64F3jKLuB3WJRfA5cldIZy1B+TOs7n9WceaADC/vt8s96QZ0BLX3VphRZuecET9LpWDzruJKR9NuG8Vlcj4VmM/FwehdWgczw5c+kAVyp3L2+HjJckaJEA1K6SQZzFYwvU2yJv8uUkYCl+oi81cgxfNT0P8tdtNDyP4kEhckmlrczIYH36x5F7LNAc9axQJom9UmDH6SeUBKJBV32Sbeh56cx+YScDQ85GHxOLuSrorWf/3e6m0zYi8p9fVH3DtzGwB1RJj+8YhMcGUIYQOu7GXeQN7x69DTnC4YW+YUsHtFnm1c2Z3d/Z9Wcik9qhs9meie9kcqH1BBgxcimWe307VvdgIQy6sgmB1FyCknBO1eTFkucK4Nc0TdQhL1+x8n12FU1HmksLpa3UG5jiLd8RWbgXDWBDnwukwKt8tetC5oKNww2PakJ8q/ku79PIbCK3n+F8stNb+Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Rt3bwbL4H5vPV52n73pALezF4wQc5ewiPV/MOmciw4C8x5Edu81vfJxWrctnTNUFv18nGr6/+7kndEFiG3iIINtAuohH2wVlemKL38zba3sRMVhbCLZtoEY1nNJsKDubEdbFwB+7bwVlXJYMxOoVSr8nEVwvMdUpD2/WuSIKcPZlm5gh+62e2kJ4UQfMGMyf2q5okMAjDh+VoKsfGOWxRHOgT2kBojzNPY7L2Wu6PsLL29w4oz3LJVdEzZo8qpUTwjiuec83HiQ++a0NqMtRXHBnl0/eZnzLk+/UZM6PFp704r7MzFDXC7W2s3LOkpz7AEL44jgmDest6MZG+CjcKpeHG5ik73CFgC4fbq4GOzUckgL116GVkQiWIZZ3Dn/oTAJwdQzm2V+pjqw9Tjm8jTvqGbp5BodNejWAwSorIcOmcB2HegODnxRRkNz7pR0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:35:35.9727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712094b0-339d-45ac-7eee-08df0d9d4cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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
Add a KUnit test for amdgpu_dm_plane_add_modifier() covering the
allocation failure that happens while growing the modifier list.

[HOW]
Seed a capacity whose doubling overflows the kmalloc_array() size
product, so the allocation fails without fault injection, and assert
the list is released and cleared for the caller.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 939f79422d7e..13e07c4fc0c7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3686,6 +3686,28 @@ static void dm_test_atomic_async_update_copies_state(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, cur_state->crtc_h, 64U);
 }
 
+/**
+ * dm_test_add_modifier_alloc_failure() - Verify the growth allocation failure.
+ * @test: KUnit test context.
+ *
+ * Verify if a failed capacity growth releases and clears the modifier list so
+ * the caller can detect the allocation failure.
+ */
+static void dm_test_add_modifier_alloc_failure(struct kunit *test)
+{
+	/* Doubling this capacity overflows the kmalloc_array() size product. */
+	u64 cap = 1ULL << 62;
+	u64 size = cap;
+	u64 *mods = kmalloc_array(1, sizeof(*mods), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, mods);
+
+	amdgpu_dm_plane_add_modifier(&mods, &size, &cap, 0x1234ULL);
+
+	KUNIT_EXPECT_PTR_EQ(test, mods, NULL);
+	KUNIT_EXPECT_EQ(test, size, 1ULL << 62);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3782,6 +3804,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_add_modifier_appends_value),
 	KUNIT_CASE(dm_test_add_modifier_grows_capacity),
 	KUNIT_CASE(dm_test_add_modifier_noop_when_mods_null),
+	KUNIT_CASE(dm_test_add_modifier_alloc_failure),
 	/* amdgpu_dm_plane_add_modifier_dedup() */
 	KUNIT_CASE(dm_test_add_modifier_dedup_skips_duplicate),
 	KUNIT_CASE(dm_test_add_modifier_dedup_noop_when_mods_null),
-- 
2.43.0

