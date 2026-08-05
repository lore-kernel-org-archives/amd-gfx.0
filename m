Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11960C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E40210ED15;
	Wed,  5 Aug 2026 06:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TmkRhdUF";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783BF10ED1D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBtU8uJgsz3ccw27md8XbP2Jfxy6K2uP+7ldBUXUzMLStJ8dWNiwB88CpKuR6OutKTvaGlFFXVAQxW8/Y+WYTtYItDOd41cBXS7Ff4wHdBESJo0wz8MePzY3FclYxoj2LXvmxFxqQ64YXHzXTfbLQwtW0hPXryZSRYjcs+ltAERqO0T+cEikdKmZfBeVTWt5uXUPRu5+OBAVwMQM20FZtP3ZnUXatw2d4LMW5DSHgKZ+413JdC4rG7JnYl2eHFc7ydFhXS6ETu47t0IakEGAew9CS3T4k4jlO/rPEYfRTS8AaVYyuFh5qbB9UfCnuo8eiVUfLM5AIe0pbTyCJeg7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c04F1GBV1WF+IciLgbv5+OHEczTfWTz/4pKnSiX2bd4=;
 b=P13nba1Ftx1LzHw9UKDrUWjZL1IxrGB9M1ZC+dcLBNWX5A9fh7/nshKRwRSW6vWYvs82ytiYKhcSz4ejD/a3j7EpDJtD8doDzPJYz6WLj2fzyjN2d7g6ZLhULawBMg786TuqfMRd+IPfzZRZV4J+mXoUkRu1FCxtjkPoMwycGPtTw3UPuEwMOAAM936oMbKFlFbWNEXR27/4jCIvaPkIzzMrSjsH7kunvuScuKbg4b7G64sIp3BOXi2yswFWq47VskRRjcz/5deqhNF5QLkEyU2ZRC3eX3DUICUsa6kfwcXo0LIB/wLQDvF6R3fRUVMgPPq1uiRxNlJlf+jre7siWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c04F1GBV1WF+IciLgbv5+OHEczTfWTz/4pKnSiX2bd4=;
 b=TmkRhdUFogXA14LdBjGztfEN94VZjnt7MtYw5o4NdM8GPxilHqZMbl+2ReO3PmZJmOUQv/ikYgoBkf7/0dLQEPZRNuuje8sTvpnwPgLQQXi0rKEJRsAipvbmCqo6JtVnLZc/cpx9l4jDUr5rFfsvMTxxXkCCYx7ljUDw+DCZL1I=
Received: from BY3PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:217::22)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 06:41:26 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::92) by BY3PR04CA0017.outlook.office365.com
 (2603:10b6:a03:217::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:24 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:21 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 23/34] drm/amd/display: test native cursor state check
Date: Wed, 5 Aug 2026 14:36:35 +0800
Message-ID: <20260805063937.2145774-24-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: f56cfde0-1654-425f-82b3-08def2bc92c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G0+PRwfDNIPyrBq8znz0ja/JaQJPK/tQyGjoLOsMtzQkVzyZS/1k5PS8jjzt19kvXdzwxnUIM+jA0T14JRy17dCKIt9eZk6cFH53/HKAeQpNzkD1mjrNYARVZh3/mjixYylOkc2+RajH+GuJ94PKT4NNtPP6uDR0AEW5DedZroe16pO6+EJl7SkcN6lARmR9e/8vZgv22DKV2zWyQfWEusyjs9g4XbdMH4K9fA3T1Ovss6G/yCrZLicBla5tmKgV305NwK1faUZy4VXR9q7XCxDtB3HP8B92GIOzaWyvwJeYW9qEjtDMizmqP4EFJSLxB4sFF9egwR/GaWWdITnMmBHv+AfZB5LAUZZdcLzg+ABAt7eP+cY7CQI2+KJC0jOD7SoHAlhX1Hcn++7Nw9wEv6ISfy4nId0L/7U53+a/Mpf2mEtD5VBIE72gpvIutw9j8Ny5PaACC61r2fVWoU8bJRDfsZyEGfYIg224vH4yzMsJGs3Mw6Z03eQP73G7w6E+q2gDEmV4ffCS0HnAG8BHOsD+5r6YKPorp4X9Cz42FikI2Is1NlnLAEED36VaxpRVLrM/eyzxlDYGQAJk7C3IxDL7nUavaTMIEHA8TxNGkY1iP3+nRYobSYdf+BERNKByhrHQu9Buag9jChMkJVe1JU37M9yyIQ0AoyXP4To9uhaKSm0nMr+xYOtmXnkBEI7r6SkM4Ukiy5+8qE+GLSIklw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XOthxUj2sGo/YXusmysdavpCNPuPyGsaKALwDl4WdMfijt+iCKupBVfysxVilEUM7Z7H4txXzhVSH1jW/+DY3dzpOFmExYucjXpIrz+q0FmHNaxUA/Al/cNmm0wf+66TPEDf7nb2s+GBkGG74BkbP0Mk472NECLMrE+TPNvnvEeFNIz+KwvWeB0gFO21MoYUYc5ZC4pMQvfecRo6ZmM7w72T1wESSvd4aQbqdao9sF2RiNgG7HbmzpiH7uLYOMGctIG9f6L0+tBG0lBQL6kgZiR6tst5e2ORAWXutCemR2hNJz3vZZU5JG1zlkgHLv8OXVOlzkiaX6vyLdRKbpDuUiP3RTJ6JmQ0jbl3PMC94Jz2fPwDPUxH+qa+sh+aEMuWGxBLq8QVuDyw2H9Nqo6yOYc/hvQFFGUBAU2t9dysD9rRk4llFaH1jaWXHVvXbZAx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:26.2355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56cfde0-1654-425f-82b3-08def2bc92c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299
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
Add three KUnit tests for amdgpu_dm_check_native_cursor_state(), reusing
the cursor framebuffer fixture, covering the disabled-cursor path,
rejection of a non-zero source offset, and delegation to the framebuffer
check.

Assisted-by: Copilot:GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 79 +++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index 953ad34918af..2b4801fa26af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -143,6 +143,7 @@ int amdgpu_dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_check_native_cursor_state);
 
 bool amdgpu_dm_should_update_native_cursor(struct drm_atomic_commit *state,
 					   struct drm_crtc *old_plane_crtc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
index f2ac94805777..78a4b40fad3e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -203,6 +203,81 @@ static void dm_test_check_cursor_fb_modifier_skips_tiling(struct kunit *test)
 			0);
 }
 
+/* Tests for amdgpu_dm_check_native_cursor_state() */
+
+/**
+ * dm_test_check_native_cursor_state_disabled - Test disabled cursor needs no validation
+ * @test: The KUnit test context
+ */
+static void dm_test_check_native_cursor_state_disabled(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_check_native_cursor_state(NULL, NULL, NULL, false),
+			0);
+}
+
+/**
+ * dm_test_check_native_cursor_state_rejects_offset - Test source offset rejection
+ * @test: The KUnit test context
+ */
+static void dm_test_check_native_cursor_state_rejects_offset(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+	struct drm_plane *plane;
+	struct drm_plane_state *old_plane_state;
+	struct drm_plane_state *new_plane_state;
+	int ret;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	old_plane_state = kunit_kzalloc(test, sizeof(*old_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_plane_state);
+	new_plane_state = kunit_kzalloc(test, sizeof(*new_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_plane_state);
+
+	acrtc->base.dev = &adev->ddev;
+	old_plane_state->crtc = &acrtc->base;
+	new_plane_state->crtc = &acrtc->base;
+	new_plane_state->src_x = 1;
+	plane->state = old_plane_state;
+
+	ret = amdgpu_dm_check_native_cursor_state(&acrtc->base, plane,
+						  new_plane_state, true);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/**
+ * dm_test_check_native_cursor_state_checks_fb - Test framebuffer validation propagation
+ * @test: The KUnit test context
+ */
+static void dm_test_check_native_cursor_state_checks_fb(struct kunit *test)
+{
+	struct dm_cursor_fb_fixture fixture = dm_test_alloc_cursor_fb_fixture(test);
+	struct drm_plane *plane;
+	struct drm_plane_state *old_plane_state;
+	int ret;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	old_plane_state = kunit_kzalloc(test, sizeof(*old_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_plane_state);
+	old_plane_state->crtc = &fixture.acrtc->base;
+	fixture.plane_state->crtc = &fixture.acrtc->base;
+	plane->state = old_plane_state;
+
+	ret = amdgpu_dm_check_native_cursor_state(&fixture.acrtc->base, plane,
+						  fixture.plane_state, true);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	fixture.afb->base.width = fixture.acrtc->max_cursor_width + 1;
+	ret = amdgpu_dm_check_native_cursor_state(&fixture.acrtc->base, plane,
+						  fixture.plane_state, true);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
 /* Tests for amdgpu_dm_should_update_native_cursor() */
 
 /**
@@ -436,6 +511,10 @@ static struct kunit_case amdgpu_dm_cursor_tests[] = {
 	KUNIT_CASE(dm_test_check_cursor_fb_gfx12_tiling),
 	KUNIT_CASE(dm_test_check_cursor_fb_pre_ai_tiling),
 	KUNIT_CASE(dm_test_check_cursor_fb_modifier_skips_tiling),
+	/* amdgpu_dm_check_native_cursor_state */
+	KUNIT_CASE(dm_test_check_native_cursor_state_disabled),
+	KUNIT_CASE(dm_test_check_native_cursor_state_rejects_offset),
+	KUNIT_CASE(dm_test_check_native_cursor_state_checks_fb),
 	/* amdgpu_dm_should_update_native_cursor */
 	KUNIT_CASE(dm_test_should_update_native_cursor_without_crtc),
 	KUNIT_CASE(dm_test_should_update_native_cursor_disable_native),
-- 
2.43.0

