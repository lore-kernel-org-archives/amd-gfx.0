Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F391CC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AAAD10ECFB;
	Wed,  5 Aug 2026 06:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z3VtM/o/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF4010ECFB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vy35igyQWeysLoSmZgAJzfB2DXYM8/ZTwuyTmIGys6vEt9B0aJKs4Ro6dv1QvEr839t3VVSmGG/RP/moOXfW+Cudzb5vz9Tp5pxTk5PzH+salfH7jf9TTxAXkDZ9hS0lVnWVkxlSuoKQ533vGJ4kuRrbGmgd90RPLTsV/a4+n6j99i4SAeoBcADcf6VFy5y8j0GG3kQ7yhi0yONlGN5iloTkbHYl6iLX7dMRsZoGu0Oxu0tXjXbVQPSreYAmJpotWoO+/fHfPLTDZVllA2WkTR0crLA0Khc22oYu3cBc/0tWWx1YhK5U5YMmXgKo5Q7gpWvh/kF6HP/UJEuUcreClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+X5j1rfHUCb3jrB0T7T1KJBcw513AkX5+xA+7qfFGs=;
 b=l3b7TSJyzeazRv99n10+aQjt6VFujE5lc4fAL7GZfJbKijw22Q+bSXV3XtKHle+6ZhRRll5fWP1YprxsT9/7+AhPrGl9AmR4lttHROd9M8f/BlE7V4K30K54Wn3Bgtg6b6urRwHaitfI8BY0kthR8G8NQBUHkIIsJEDZWFQmV4edlpnFCfI/4jVIMJJzCnj6qZZJn2TkdlQXzo1IZgUiwui6+J+L6JaC2IWgV4NfyfIONZ5M6pAIVUUnSMz7C/8kwztP0ZtLTKHiR/O5ll/4pSraTOjEYv9uJMprww+Qx1a6kSDFcuxu7BbMrOkPGQcR9sj9cd0op8hLEp7PmZlLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+X5j1rfHUCb3jrB0T7T1KJBcw513AkX5+xA+7qfFGs=;
 b=Z3VtM/o/eiUxC/rRpZvMYb4y/Zu/0TpmhMenhHzT3cou2iJITvXXqv53WoB9Lrn51hC1N0rBTsnYybWB520Y4LdfFG2/9lc6QhhSsXMydcLAcWoocl/fg/Ywqe5++AKQLD7njT052mPKCerOBm5Se9pNt3fbABWm2uqs4DQaUoE=
Received: from BN0PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:e7::16)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:40:18 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::6e) by BN0PR03CA0041.outlook.office365.com
 (2603:10b6:408:e7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:11 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:08 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH 05/34] drm/amd/display: Cover crtc destroy callback
Date: Wed, 5 Aug 2026 14:36:17 +0800
Message-ID: <20260805063937.2145774-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5986fe-9798-4b6e-f93a-08def2bc6973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZkUxQ5wRa0hzxzYICS3ousetP9FP+WSt5V7l/g9L3MR3vA4ahcnDbc4UhwAbelcSxSnc2qzvx5STv6IdN4d6RKg5sYFve2NMPFF0vf6DcJhudu86E/gZnjaNDsvst0+N3FlniGbV8ZveFXrBI6BKQlTli0lnD963ya041Rzm0LzLSLgwt8CI0zVtwtW1HGV6yOgV9MSFnBxC/BSuP34Ka9nU47iEZCEfGb1O+StdSxTq4HGM+1iXqvD//0f380LQtkrAj33ExHsQ7RgjlwRJ+iXaP29/Sgnr7wozLkaoPMTa+N2pQI0ZKTVjEw1LMcOLddK70otC+DxKWmGSTg03wTO8/dN9nUSSqfGtlKikadHESVxJgms8EzX/sK5EwRmHHW7/gNex1Zkqt1QsA67VB6VQ2avW9HKvWlr2s3VnNqxV6KQBZ/ywQ5uOGAR79+RZ9g8Cc2hDLGXscRbjSELz0zHGXl+Nh/fkdl6/AgTJsK1rlieH+Gv32m/zZktsG2yNJgFXx1G2ozXhjNrFr9LqkKWQbY+TyJinv/uTJQYjTxmLr1HHG3gENdxQ9mrK32ZxcDXT6HQXKlW4NpFZw1UdJ5fj3PKYtbWTKFwCWVI3Rd264jURSfaQxD8AIwtmepjQd5VRPwzjZeOqm3fLNzX9rCiG+RHwFgpkZWu2Frcyl+K6IlZnWzgOAMSoS2jWG9NQaCKa3acOJz2AAMywyU27GA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Mhv3wBWusUmC2rnSO5EeQv0TqVNodllb0S5GZIqNds7+SnOzMucAf++xsemYPluR2PvwWel2b0A4T0yY5mwR4RhajdvZrw4dnhrjrwpBe88msLNYcCBvbWvSc1xb13OD+fBtY/PxozK7GqAS6URW7ZsiBZWfeJ5WfuUVnkl3zzLrrl5L/d1iT2vdeN0kBwMlzTbBf0fIjXFGYb1wzhhBVWeJL/5dpRt/ns6hfxlJfGIkoq/XSaAeWhj3LRWpJjy1pYb8FSHwdqC/Or2uJaRBEjBCbsE9MEuuQF/t9HaDHNYSdj7IBw2WPL9x5kiW0z33Qcj2xyvQkeVnm4OvoO1X/7RVLrE+7nMpsMJSAn5d8t1Z5vz0ovyobalBjTcLJFMiMXdUsmeRb8FKAgzxhmBk0RZcCZ9c4fMv1fsc6x3nLMdR1hOnCGD8JOyCIdbos9W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:16.9796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5986fe-9798-4b6e-f93a-08def2bc6973
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[why]
The amdgpu_dm_crtc_destroy() .destroy callback, which runs
drm_crtc_cleanup() and frees the CRTC, was not exercised by the KUnit
suite.

[how]
Exposed amdgpu_dm_crtc_destroy() via STATIC_IFN_KUNIT/EXPORT_IF_KUNIT and a
KUnit-only declaration, and added dm_test_crtc_destroy_cleans_up_and_frees
which initializes a CRTC with a primary plane and verifies
mode_config.num_crtc drops from 1 to 0 after destroy. Registered the case
in amdgpu_dm_crtc_tests.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 43 +++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 82a30097072e..470abe9cc8f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -459,7 +459,7 @@ STATIC_IFN_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct dr
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_duplicate_state);
 
-static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
+STATIC_IFN_KUNIT void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 {
 	/*
 	 * amdgpu_dm_ism_fini() is intentionally called in amdgpu_dm_fini().
@@ -470,6 +470,7 @@ static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 	drm_crtc_cleanup(crtc);
 	kfree(crtc);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_destroy);
 
 STATIC_IFN_KUNIT void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index 93c6d0d8d7fd..06bb22d4c3b7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -49,6 +49,7 @@ bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 				  struct drm_crtc_state *state);
 struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc);
+void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc);
 void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc);
 int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state);
 void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index a23281a33422..1af819113168 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -1463,6 +1463,47 @@ static void dm_test_crtc_duplicate_state_null_state_returns_null(struct kunit *t
 	KUNIT_EXPECT_NULL(test, amdgpu_dm_crtc_duplicate_state(crtc));
 }
 
+/* Tests for amdgpu_dm_crtc_destroy() */
+
+/**
+ * dm_test_crtc_destroy_cleans_up_and_frees - Test destroy tears down the CRTC
+ * @test: The KUnit test context
+ *
+ * amdgpu_dm_crtc_destroy() is the drm_crtc .destroy callback: it must run
+ * drm_crtc_cleanup() and free the CRTC. Initialise a CRTC with a primary plane
+ * so it is registered on the device (num_crtc == 1), then destroy it and verify
+ * the CRTC was unregistered (num_crtc back to 0). The CRTC is a plain (unmanaged)
+ * allocation because amdgpu_dm_crtc_destroy() kfree()s it.
+ */
+static void dm_test_crtc_destroy_cleans_up_and_frees(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct drm_plane *plane;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	plane = drm_kunit_helper_create_primary_plane(test, &adev->ddev,
+						      NULL, NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
+
+	/* amdgpu_dm_crtc_destroy() kfree()s the CRTC, so use a plain alloc. */
+	acrtc = kzalloc_obj(*acrtc, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	ret = drm_crtc_init_with_planes(&adev->ddev, &acrtc->base, plane,
+					NULL, &dm_test_crtc_funcs, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, adev->ddev.mode_config.num_crtc, 1);
+
+	amdgpu_dm_crtc_destroy(&acrtc->base);
+
+	/* drm_crtc_cleanup() ran: the CRTC was unregistered from the device. */
+	KUNIT_EXPECT_EQ(test, adev->ddev.mode_config.num_crtc, 0);
+}
+
 /* Tests for amdgpu_dm_crtc_reset_state() */
 
 /**
@@ -1968,6 +2009,8 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_duplicate_state_copies_fields),
 	KUNIT_CASE(dm_test_crtc_duplicate_state_retains_stream),
 	KUNIT_CASE(dm_test_crtc_duplicate_state_null_state_returns_null),
+	/* amdgpu_dm_crtc_destroy */
+	KUNIT_CASE(dm_test_crtc_destroy_cleans_up_and_frees),
 	/* amdgpu_dm_crtc_reset_state */
 	KUNIT_CASE(dm_test_crtc_reset_state_allocates_state),
 	/* amdgpu_dm_crtc_destroy_state */
-- 
2.43.0

