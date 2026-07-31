Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D560C55174
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17DC10F3FA;
	Fri, 31 Jul 2026 21:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5hLbTec/";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6DD10E24B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhvbcNrxHg7OK18ZeQpeJLCRUk9CCm653dpzfWkCcdEEKDklgHtJ2BN0ImVqOxwkE6sDHsHSNhyh1srhsD30PoErSpruhqDIuCAYEyDe4Y5JQJB2tSk7Gx2lF/vM3ayv2B2I1t5c3V5DhVBo6fSCYW/oBXtU8LN8K5OCe0OdPSp9CuC7gfihcFjXspQp7eKhf0fUX+p36xDoYOOuvdIS/RKmSZNoFRHW7qEujDDWIbsI5txSgoFe/6ZWCHCjJUPb3iIw7cUMuafIAUmT9ccTLp60/zUkvvTs7qOiNw9zbxo16zFVB7ilnABvHhsuFPai2Xp2hWLCyT9fbleiJEQxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FayqrPBMexJawCgyr5KLqRF1MA3kHL6rRTnuG3YE+2o=;
 b=VFFPKrhJpQEDr89+VOMBK/wD8K/LqZ3N7QnOMfsKXD1vuZjNpDssdg52UD1p5cpCPa4WuW/9E3GBe9xWL7B3TrTmB/eJbGKTP3K0pg0zVuMfteYVeabUbhuskr6HBFBmD7O76q4F05rpBtdJTiykRTnP25swUdyaeVpLtaw0AqribkiCVh6g5IDSe5L8XtZXQWbK4F3A5axddEfjtG32xeFQvCBCRR3AjioXRsrOekBKBD5MHB6kkhyMcO8VwVBiVnGO4Itj1y7ereHjSimw/eFuLI5DrqJzXvYOHMSzeLtpbPpSAFtVrR+DSwKoELtoUG37tPtcEi6dmP0PxRNVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FayqrPBMexJawCgyr5KLqRF1MA3kHL6rRTnuG3YE+2o=;
 b=5hLbTec/R8P55RQsEZfuCH9RCwYIXumu8QoYXqK06XULhdl1iLqxXbmh/5TOrQe5M8CavQF7N25Tyz17HhcmYpuOT1x+UWCE2DyNwgBoftkgccBje7PFnigklA1jv1eFzBG3XPVcaImjV13pVFlE2hm4k6maNkrBLn3NxX69jxY=
Received: from CH0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:610:32::28)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:15:45 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::19) by CH0PR07CA0023.outlook.office365.com
 (2603:10b6:610:32::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:44 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:43 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 16/41] drm/amd/display: Add idle worker tests for crtc
Date: Fri, 31 Jul 2026 17:12:37 -0400
Message-ID: <20260731211302.3040343-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: ae886d81-e16d-488a-bce0-08deef48e2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|6133799003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5AExm/zYBB1F/uNXaGVMeEuQplyPtIQnJVfSGuuBbKZx7tierbTT9RiKIrY82qz0w/2X4E117I6XdVZMcR74Jlaxc4jMieT3qMWUUgNaACqvs0on1t/Fni64c0Z2M1Z6L4JbmlL2Nt9KjvKrLWFyvgNUxSy8+TjMfAIUUDSD1rAMfPzyMzhRyLHgOn4VRlmmFQBJQjXUr92iDDIIlp8QDR+OIQfArlfr0fjxVOel3wRqn1yTMHe57n1rX9TKqEh9DRdeXOtrlrlEOsv2maBlF0FAo32J6VmY+KQIQmDONqhR2RT00JA04sHYSZS6OnT+SjHjEapCIxbd+bnzaWu0t1sNTAcEVsZ0qkA6ii+hNUQcotA6NTU1qhZsfxsKU+Fs0TchQJK7zRVXFzFusECccUtPUN8pZRvuTxNNC89GzFpFOvfMaX2QlLZHhL5DndkgxZyoCx1KN0MLNdVkoEZb36XlDGZLqhla+Ok8N6fifG3R9U+5rDS8m+7drPjoUCh63lnlfmAiaY3Gg9nS5WmTg66ClhGMmejJOsnl4XLPp0kFMyX4NzYPLqRR/hxXotgDRxDxmbf+bD8bYN43g2YcwxU+OllSi8Br6AHyC+Jx+jUwOvOO65Z7dRtyjF+xuYU7Rla8IJZJyBWXvOjq8PNu7j8DlGghT9Mhv7xvUuHl02/QBFEYjJ0WPALpbLET0LC7TLp0MInqwmBTHWD4Hcmyaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pwIYjUC9x8iqqQn+WqJjDY/KrKJIlni/Qb7o1aGcIPr9FStiQkqA0cFkFkhuO1uOHbfAcKkDGv28SWw7YVP8nCD3U0iaw4MlCChZqd/uE2TAnWNKjR39bWuyqCX6BsSHOE1JHs0ZSHbvl/vN92MptFXTwYTI6ddRa7h+CJBQbz5j+LTr/A2BwJFs/Rst2iBrUN0/fuc55hWritUKtIk4J8gcLGvTSPKTAzMgtpCeNtGU7Q55uUYpDSYbKHk1X1RUnPPHEhqnR+4z5IbTz8emoj1dMYIM30GxD6CPpl7mMeayhq88FVyUunWP4xohcN0rg2R6Q7XuMZ67NgNUYnzE2msfT21m4uQB1oAfeN2KnFg15hOFzIhopxZ8rCxJ+owakAQzjd8FgdBuo1K/lxPOcDVkxu2NPqCAMDGWHwvOh6Ae62vZjN9tRNyEmLXl/UZk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:45.2160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae886d81-e16d-488a-bce0-08deef48e2aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Expose amdgpu_dm_idle_worker() for KUnit and add tests covering the
disabled exit, both loop break paths, and the enable-body path. Add
dm_kunit_alloc_dc_state() and dm_kunit_alloc_clk_mgr() helpers to
support the new tests.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 181 ++++++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |  29 +++
 .../tests/amdgpu_dm_kunit_test_helpers.h      |   3 +
 5 files changed, 216 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 2a4e241350f0..fd816be907c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -165,7 +165,7 @@ bool amdgpu_dm_is_headless(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_is_headless);
 
-static void amdgpu_dm_idle_worker(struct work_struct *work)
+STATIC_IFN_KUNIT void amdgpu_dm_idle_worker(struct work_struct *work)
 {
 	struct idle_workqueue *idle_work;
 
@@ -199,6 +199,7 @@ static void amdgpu_dm_idle_worker(struct work_struct *work)
 	}
 	idle_work->dm->idle_workqueue->running = false;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_idle_worker);
 
 struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index c68b7b2e1916..d1e2cb4efc54 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -53,6 +53,7 @@ void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc);
 void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 					      struct drm_crtc_state *new_crtc_state);
 void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work);
+void amdgpu_dm_idle_worker(struct work_struct *work);
 #endif
 
 bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 4d4b4061c789..f5d9424171e8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -457,6 +457,182 @@ static void dm_test_idle_create_workqueue(struct kunit *test)
 	kfree(idle_work);
 }
 
+/**
+ * dm_test_idle_worker_disabled_clears_running - Test worker exits when disabled
+ * @test: The KUnit test context
+ *
+ * With the idle workqueue disabled, amdgpu_dm_idle_worker() must skip the idle
+ * optimization loop entirely and leave the shared running flag cleared.
+ */
+static void dm_test_idle_worker_disabled_clears_running(struct kunit *test)
+{
+	struct idle_workqueue *idle_work;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, idle_work);
+
+	idle_work->dm = &adev->dm;
+	idle_work->enable = false;
+	idle_work->running = true;
+	/* The worker toggles running through dm->idle_workqueue. */
+	adev->dm.idle_workqueue = idle_work;
+
+	amdgpu_dm_idle_worker(&idle_work->work);
+
+	KUNIT_EXPECT_FALSE(test, idle_work->running);
+}
+
+/**
+ * dm_test_idle_worker_enabled_breaks_when_idle_disallowed - Test loop entry/exit
+ * @test: The KUnit test context
+ *
+ * With the workqueue enabled but idle optimizations disallowed, the worker enters
+ * the detection loop once, takes the early break, and clears the running flag.
+ */
+static void dm_test_idle_worker_enabled_breaks_when_idle_disallowed(struct kunit *test)
+{
+	struct idle_workqueue *idle_work;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	mutex_init(&adev->dm.dc_lock);
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.dc);
+	/* First loop iteration breaks before any dc_allow_idle_optimizations(). */
+	adev->dm.dc->idle_optimizations_allowed = false;
+
+	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, idle_work);
+
+	idle_work->dm = &adev->dm;
+	idle_work->enable = true;
+	adev->dm.idle_workqueue = idle_work;
+
+	amdgpu_dm_idle_worker(&idle_work->work);
+
+	KUNIT_EXPECT_FALSE(test, idle_work->running);
+}
+
+/**
+ * dm_test_idle_worker_enabled_breaks_when_not_headless - Test second break path
+ * @test: The KUnit test context
+ *
+ * With idle optimizations allowed, the worker passes the first branch and runs
+ * dc_allow_idle_optimizations(). A connected display makes the device non-headless
+ * while no PSR is active, so the worker takes the second break and stops running.
+ */
+static void dm_test_idle_worker_enabled_breaks_when_not_headless(struct kunit *test)
+{
+	struct idle_workqueue *idle_work;
+	struct drm_connector *display;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	mutex_init(&adev->dm.dc_lock);
+	adev->dm.adev = adev;
+	adev->dm.ddev = dm_kunit_alloc_drm_with_connector_list(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.ddev);
+
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.dc);
+	/* Allow idle so the first branch is skipped and dc_allow() is exercised. */
+	adev->dm.dc->idle_optimizations_allowed = true;
+	/* is_apu path avoids DC_LOG_DC()'s NULL-logger dereference. */
+	adev->dm.dc->caps.is_apu = true;
+	/* Empty stream list -> amdgpu_dm_psr_is_active_allowed() returns false. */
+	adev->dm.dc->current_state = dm_kunit_alloc_dc_state(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.dc->current_state);
+
+	/* A connected display makes amdgpu_dm_is_headless() false. */
+	display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
+	dm_test_add_connector(adev->dm.ddev, display, DRM_MODE_CONNECTOR_HDMIA,
+			      connector_status_connected);
+
+	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, idle_work);
+	idle_work->dm = &adev->dm;
+	idle_work->enable = true;
+	adev->dm.idle_workqueue = idle_work;
+
+	amdgpu_dm_idle_worker(&idle_work->work);
+
+	KUNIT_EXPECT_FALSE(test, idle_work->running);
+}
+
+/*
+ * Report success only when disabling idle. dc_allow_idle_optimizations() then
+ * clears dc->idle_optimizations_allowed on the disable call but leaves it clear
+ * on the re-enable call inside the worker's enable-body, so the next loop
+ * iteration breaks at the first branch instead of looping forever.
+ */
+static bool dm_test_idle_apply_flip(struct dc *dc, bool enable)
+{
+	return !enable;
+}
+
+/**
+ * dm_test_idle_worker_enabled_runs_body - Test the enable-body path
+ * @test: The KUnit test context
+ *
+ * A headless device makes the second branch false so the worker runs the
+ * enable-body (dc_post_update_surfaces_to_stream() + re-enable). An injected
+ * hwss.apply_idle_power_optimizations() callback lets dc_allow_idle_optimizations()
+ * clear idle_optimizations_allowed on the disable half, so the following loop
+ * iteration breaks at the first branch and the worker stops.
+ */
+static void dm_test_idle_worker_enabled_runs_body(struct kunit *test)
+{
+	struct idle_workqueue *idle_work;
+	struct amdgpu_device *adev;
+	struct dal_logger *logger;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	mutex_init(&adev->dm.dc_lock);
+	adev->dm.adev = adev;
+	/* Empty connector list keeps the device headless -> second branch false. */
+	adev->dm.ddev = dm_kunit_alloc_drm_with_connector_list(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.ddev);
+
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.dc);
+	/* Allow idle so the first branch is skipped and dc_allow() is exercised. */
+	adev->dm.dc->idle_optimizations_allowed = true;
+	/* is_apu path avoids DC_LOG_DC()'s NULL-logger dereference. */
+	adev->dm.dc->caps.is_apu = true;
+	/* dc_allow() logs via DC_LOG_DEBUG() when it flips the flag. */
+	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, logger);
+	logger->dev = &adev->ddev;
+	adev->dm.dc->ctx->logger = logger;
+	/* dc_allow() only flips the flag when clk_mgr and apply() are present. */
+	adev->dm.dc->clk_mgr = dm_kunit_alloc_clk_mgr(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.dc->clk_mgr);
+	adev->dm.dc->hwss.apply_idle_power_optimizations = dm_test_idle_apply_flip;
+
+	idle_work = kunit_kzalloc(test, sizeof(*idle_work), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, idle_work);
+	idle_work->dm = &adev->dm;
+	idle_work->enable = true;
+	adev->dm.idle_workqueue = idle_work;
+
+	amdgpu_dm_idle_worker(&idle_work->work);
+
+	/* Enable-body ran, then the next iteration disabled idle and stopped. */
+	KUNIT_EXPECT_FALSE(test, adev->dm.dc->idle_optimizations_allowed);
+	KUNIT_EXPECT_FALSE(test, idle_work->running);
+}
+
 /* Tests for amdgpu_dm_crtc_set_static_screen_optimze() */
 
 /**
@@ -857,6 +1033,11 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_set_vupdate_irq_no_otg),
 	/* idle_create_workqueue */
 	KUNIT_CASE(dm_test_idle_create_workqueue),
+	/* amdgpu_dm_idle_worker */
+	KUNIT_CASE(dm_test_idle_worker_disabled_clears_running),
+	KUNIT_CASE(dm_test_idle_worker_enabled_breaks_when_idle_disallowed),
+	KUNIT_CASE(dm_test_idle_worker_enabled_breaks_when_not_headless),
+	KUNIT_CASE(dm_test_idle_worker_enabled_runs_body),
 	/* amdgpu_dm_crtc_set_static_screen_optimze */
 	KUNIT_CASE(dm_test_crtc_set_static_screen_optimze_no_sr_entry),
 	/* amdgpu_dm_crtc_enable_vblank */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index 862ada873fbb..aad122c7229f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
@@ -12,6 +12,7 @@
 
 #include "dc.h"
 #include "core_types.h"
+#include "clk_mgr.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
@@ -114,6 +115,34 @@ struct dc_stream_state *dm_kunit_alloc_stream(struct kunit *test,
 }
 EXPORT_SYMBOL(dm_kunit_alloc_stream);
 
+struct dc_state *dm_kunit_alloc_dc_state(struct kunit *test)
+{
+	struct dc_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	return state;
+}
+EXPORT_SYMBOL(dm_kunit_alloc_dc_state);
+
+struct clk_mgr *dm_kunit_alloc_clk_mgr(struct kunit *test)
+{
+	struct clk_mgr *clk_mgr;
+	struct clk_mgr_funcs *funcs;
+
+	clk_mgr = kunit_kzalloc(test, sizeof(*clk_mgr), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, clk_mgr);
+
+	funcs = kunit_kzalloc(test, sizeof(*funcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, funcs);
+
+	clk_mgr->funcs = funcs;
+
+	return clk_mgr;
+}
+EXPORT_SYMBOL(dm_kunit_alloc_clk_mgr);
+
 void dm_kunit_add_stream_to_state(struct kunit *test, struct dc_state *state,
 				  unsigned int index, struct dc_link *link)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h
index 49b358681d60..7d7bcd321775 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h
@@ -13,6 +13,7 @@
 struct amdgpu_device;
 struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
+struct clk_mgr;
 struct dc;
 struct dc_link;
 struct dc_state;
@@ -25,6 +26,8 @@ struct dc_link *dm_kunit_alloc_link(struct kunit *test);
 struct dc_link *dm_kunit_alloc_link_with_ctx(struct kunit *test);
 struct amdgpu_display_manager *dm_kunit_alloc_dm(struct kunit *test);
 struct drm_device *dm_kunit_alloc_drm_with_connector_list(struct kunit *test);
+struct dc_state *dm_kunit_alloc_dc_state(struct kunit *test);
+struct clk_mgr *dm_kunit_alloc_clk_mgr(struct kunit *test);
 struct dc_stream_state *dm_kunit_alloc_stream(struct kunit *test,
 					      struct dc_link *link);
 void dm_kunit_add_stream_to_state(struct kunit *test, struct dc_state *state,
-- 
2.34.1

