Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A64C531FA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FCEC10F1C4;
	Thu, 23 Jul 2026 20:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENWmuGo+";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A457410E5EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhhZ3sCYTTP++U8+bGyG9M1EpbQkA5wt2+9KnZotNEZmpXt6ftgGiWCCfbXd1+TdazbaAFZpciEw0JhGsG0L2oakj9qx8DvYJB6ZDviAq0kmUkudWoBnioCh5pXcn1Ag53zQ3UwmpMkXzaar75b3ntEh5rntblR3C6XLB83nRjY2rlNP9sklR/xDB1aK7Nocipf+h3Y9nbVEwCEcVFUC3tlOrg8J48wwq+XGm7iIhnEAnQ5Qr40IuvHYZTwss9GxiIlOKAzEcdTNk4VG89R5pf9e64XclgQvnuAt76uUVncjkiy6p+LpLArYsUmKWKYOO+HmDeJElkYCklBPmMT6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9BtJxAC6qfHXG/k0oDhn8rwiDP07+VtEI2YAyh/gc8=;
 b=mA/mXK6G8uinf8d29aYk2z8pvNLZDRZcIQZKxvZ1d7vEIQCY1LUY3O3ZNMRFZko3AaDhxkVjLlbm7rQh3yO0drF8gs//8hFb9gyvDwBTN1zyew9IurSqm+Be01LRzRVSYzUXi92EwN0tWrSVRYacy1uR13tgoSZmWGJcXQ0d//N4uIFHUCIdx85YekofwAkqyx2VzupXv0ktLChFkRaDozOzH16fSb4q23MJShGJ3vxhawtTOosKDgSkOt5GYnoqXbuWQJV8gdpDiJTfPd01fX9tJDVI2JMZ0EFPwDPrd+Cd9TaIxSdY9jnV4evWcaEerQGn/dAIbGoVLHzOh3wdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9BtJxAC6qfHXG/k0oDhn8rwiDP07+VtEI2YAyh/gc8=;
 b=ENWmuGo+650I3gEpD2OkdSpxZXtbUgDfrneS4rpukxIqLxQBQ39K4HoiVGHhpjV5V73Xpige95ct4PBuT4DDQufkS4Obod58STTZtY0iBOunkYwu2S3TpqvBocyVTvwyDE9D7FgA5gecyfhnGIvZuodWeZcBH4YdUqu8D7/blYg=
Received: from MN0P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::8)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:18:52 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::1) by MN0P223CA0017.outlook.office365.com
 (2603:10b6:208:52b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:51 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:48 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 01/49] drm/amd/display: share common DM KUnit helpers
Date: Thu, 23 Jul 2026 16:13:09 -0400
Message-ID: <20260723201908.373300-2-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 779eeb17-1a92-4911-28b1-08dee8f79ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|11063799006|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 1WVDHi5FIq3YkL2X+0GyOe7t8aVhXlUcD0SdwFvXkMjH7STzXUXXWqbikPpSzopl4TVHyE1Vkh6ROw+xOldvn+JWpdeZ5P1bD1TCsAiGY1PD70sCEtIx4UX2PQ7bvknk2KAxe/TRK4b1VjjE3NIA50+Iq0jgS2mzWb48PHfmJ/REPeDsvD8l1CDLJblL4HSF6tOUggAF7RZXXMf5X2VKFokxjoo4aFCkksLzwP66FRJBfdCxlVBU6BJEe8/63IlSv1bX0tkep+ofTdW94YlzNGh/KnOT9smvQEXfGD6PAGvpx4kHqPXWosH07YsltF3iGBAJS9zazqnoSPFAs3xK+aczmEkjTmWVo4xzBmxJN37jvw6WIhkqVfya9mFrrCcWaPyYTed3If3755vGqVUScjvgk1I1IaGxHRHvTsBg2QLLpiFuN4pVVdMILmfFEMVv+ZZ0ILNSCvEPzjt3ydrQrCnkNGTqMkpWVhctrtsN96wMoVrfH+I1k6UYzWrJtU7F/gAsYNbQG1UulcOwXSrXeYqQTHHwacOZakKx9S0V40Oq3aw9+JN2Oghjw1yfoqBnNINVGDYWCk120MeFgTygzILPtEHZy8BJ1nCEodq6U75GJgsL5xIDGoKvyz2DFs9ubCb2immek/5SiiZfGYsgpQSJIWosICDuAeU9G18t+Z/9z5Stc54I132xhKxLZ2qf/B+7UzlKYyoHVX0/lMJ9vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(11063799006)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4YwZGSkLD5cqhX6Q7mBHwdzclz5xSEuBI/8zOielxTzFm3rS1lpD1yi1hWB0ZuRYn6NfS08TLKAey5vlyJ6m1KrYhCO+a76NGo4HFFj2+I8aEHoXu9A8X/sfrGiFMWonmEXXrL3dO4mNaeLe1i6jmPzupd56HAYSXY7zh03aIUwxKRCmtM9+RalmvOXCh9KfGqdOv3F5PXt7BYlGGPdohn7m3Fn4GY5ufYGl98+zO+Due4rAD5AQE72iaZETP6I4wFr1HIVE4r4iQBovxJmmcJui4ECZSLv/bDDoND/QByR336+wAPM7+tYYlFLXISQb3i5ri6gnzo/H7fB/tS16xrnIvG0LPIxP3A9Vn+48hhNF3MGdIDfRme0haD/H6WoZMwbss4yhOycIs2D91psi4QWcnj4MWfEPPwYjVrPTamLKQC8LqvLr8rPiZKpGi8dD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:51.9576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779eeb17-1a92-4911-28b1-08dee8f79ce5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
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

Move fixture setup that was duplicated across several amdgpu_dm
KUnit tests into amdgpu_dm_kunit_helpers.c:

- dm_kunit_alloc_dc_with_ctx() allocates a dc and its dc_context.
- dm_kunit_alloc_drm_with_connector_list() allocates a drm_device
  with an initialized connector list.

Update the irq, psr, crtc and backlight tests to use these helpers.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../tests/amdgpu_dm_backlight_test.c          |  9 +----
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 30 +++-----------
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 32 ++++-----------
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c | 39 +++++++++++++++----
 .../tests/amdgpu_dm_kunit_test_helpers.h      |  4 ++
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      | 15 ++-----
 6 files changed, 52 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index f55f93747df7..618fd5142da0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -56,14 +56,7 @@ static void setup_test_connector(struct kunit *test,
 
 static void setup_test_dm_ddev(struct kunit *test, struct amdgpu_display_manager *dm)
 {
-	struct drm_device *ddev;
-
-	ddev = kunit_kzalloc(test, sizeof(*ddev), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ddev);
-
-	INIT_LIST_HEAD(&ddev->mode_config.connector_list);
-	spin_lock_init(&ddev->mode_config.connector_list_lock);
-	dm->ddev = ddev;
+	dm->ddev = dm_kunit_alloc_drm_with_connector_list(test);
 }
 
 /* Tests for dm_find_stream_with_link() */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 0edaf969f16b..ac21bbec92ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -296,13 +296,9 @@ static void dm_test_crtc_is_headless_null_adev(struct kunit *test)
 static void dm_test_crtc_is_headless_no_connectors(struct kunit *test)
 {
 	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	struct drm_device *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	struct drm_device *dev = dm_kunit_alloc_drm_with_connector_list(test);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
-
-	INIT_LIST_HEAD(&dev->mode_config.connector_list);
-	spin_lock_init(&dev->mode_config.connector_list_lock);
 	adev->dm.ddev = dev;
 
 	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_headless(adev));
@@ -315,15 +311,11 @@ static void dm_test_crtc_is_headless_no_connectors(struct kunit *test)
 static void dm_test_crtc_is_headless_writeback_only(struct kunit *test)
 {
 	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	struct drm_device *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	struct drm_device *dev = dm_kunit_alloc_drm_with_connector_list(test);
 	struct drm_connector *wb = kunit_kzalloc(test, sizeof(*wb), GFP_KERNEL);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb);
-
-	INIT_LIST_HEAD(&dev->mode_config.connector_list);
-	spin_lock_init(&dev->mode_config.connector_list_lock);
 	adev->dm.ddev = dev;
 
 	dm_test_add_connector(dev, wb, DRM_MODE_CONNECTOR_WRITEBACK,
@@ -339,15 +331,11 @@ static void dm_test_crtc_is_headless_writeback_only(struct kunit *test)
 static void dm_test_crtc_is_headless_disconnected_display(struct kunit *test)
 {
 	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	struct drm_device *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	struct drm_device *dev = dm_kunit_alloc_drm_with_connector_list(test);
 	struct drm_connector *display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
-
-	INIT_LIST_HEAD(&dev->mode_config.connector_list);
-	spin_lock_init(&dev->mode_config.connector_list_lock);
 	adev->dm.ddev = dev;
 
 	dm_test_add_connector(dev, display, DRM_MODE_CONNECTOR_HDMIA,
@@ -363,15 +351,11 @@ static void dm_test_crtc_is_headless_disconnected_display(struct kunit *test)
 static void dm_test_crtc_is_headless_connected_display(struct kunit *test)
 {
 	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	struct drm_device *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	struct drm_device *dev = dm_kunit_alloc_drm_with_connector_list(test);
 	struct drm_connector *display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
-
-	INIT_LIST_HEAD(&dev->mode_config.connector_list);
-	spin_lock_init(&dev->mode_config.connector_list_lock);
 	adev->dm.ddev = dev;
 
 	dm_test_add_connector(dev, display, DRM_MODE_CONNECTOR_HDMIA,
@@ -387,17 +371,13 @@ static void dm_test_crtc_is_headless_connected_display(struct kunit *test)
 static void dm_test_crtc_is_headless_mixed_connectors(struct kunit *test)
 {
 	struct amdgpu_device *adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	struct drm_device *dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	struct drm_device *dev = dm_kunit_alloc_drm_with_connector_list(test);
 	struct drm_connector *wb = kunit_kzalloc(test, sizeof(*wb), GFP_KERNEL);
 	struct drm_connector *display = kunit_kzalloc(test, sizeof(*display), GFP_KERNEL);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, display);
-
-	INIT_LIST_HEAD(&dev->mode_config.connector_list);
-	spin_lock_init(&dev->mode_config.connector_list_lock);
 	adev->dm.ddev = dev;
 
 	dm_test_add_connector(dev, wb, DRM_MODE_CONNECTOR_WRITEBACK,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index dc7ef0523b8f..28c36217f6a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -202,22 +202,6 @@ static void dm_test_dmub_notify_callback(struct amdgpu_device *adev,
 	dm_test_dmub_notify_count++;
 }
 
-static struct dc *dm_test_alloc_dc_with_ctx(struct kunit *test)
-{
-	struct dc_context *ctx;
-	struct dc *dc;
-
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-
-	dc->ctx = ctx;
-	ctx->dc = dc;
-
-	return dc;
-}
-
 static enum dc_irq_source dm_test_to_dal_irq_source_dce110(
 		struct irq_service *irq_service,
 		uint32_t src_id,
@@ -299,7 +283,7 @@ static struct dc *dm_test_alloc_dc_with_irq_service(struct kunit *test,
 	struct dc *dc;
 	int i;
 
-	dc = dm_test_alloc_dc_with_ctx(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
 	irqs = kunit_kzalloc(test, sizeof(*irqs), GFP_KERNEL);
@@ -3283,7 +3267,7 @@ static void dm_test_register_hpd_handlers_dmub_outbox(struct kunit *test)
 
 	adev = dm_kunit_alloc_adev(test);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
-	dc = dm_test_alloc_dc_with_ctx(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
 	adev->dm.dc = dc;
 
 	/* Make dc_is_dmub_outbox_supported() return true. */
@@ -3495,7 +3479,7 @@ static void dm_test_dmub_outbox1_low_irq_empty(struct kunit *test)
 	struct dc *dc;
 
 	adev = dm_kunit_alloc_adev(test);
-	dc = dm_test_alloc_dc_with_ctx(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
 	dc_dmub_srv = kunit_kzalloc(test, sizeof(*dc_dmub_srv), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_dmub_srv);
 	dmub = kunit_kzalloc(test, sizeof(*dmub), GFP_KERNEL);
@@ -3529,7 +3513,7 @@ static struct amdgpu_device *dm_test_alloc_adev_outbox_notify(struct kunit *test
 	struct dc *dc;
 
 	adev = dm_kunit_alloc_adev(test);
-	dc = dm_test_alloc_dc_with_ctx(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
 	dc_dmub_srv = kunit_kzalloc(test, sizeof(*dc_dmub_srv), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_dmub_srv);
 	dmub = kunit_kzalloc(test, sizeof(*dmub), GFP_KERNEL);
@@ -3635,7 +3619,7 @@ static void dm_test_dce110_register_irq_handlers_rejects_uninitialized_sources(s
 	struct dc *dc;
 
 	adev = dm_kunit_alloc_adev(test);
-	dc = dm_test_alloc_dc_with_ctx(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
 	adev->dm.dc = dc;
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), -EINVAL);
@@ -3696,7 +3680,7 @@ static void dm_test_dcn10_register_irq_handlers_zero_crtc(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_irq_sources,
 							 adev), 0);
-	dc = dm_test_alloc_dc_with_ctx(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
 	adev->dm.dc = dc;
 	adev->mode_info.num_hpd = 1;
 	amdgpu_dm_set_irq_funcs(adev);
@@ -3759,7 +3743,7 @@ static void dm_test_register_outbox_irq_handlers_without_dmub(struct kunit *test
 	adev = dm_kunit_alloc_adev(test);
 	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_irq_sources,
 							 adev), 0);
-	dc = dm_test_alloc_dc_with_ctx(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
 	adev->dm.dc = dc;
 	amdgpu_dm_set_irq_funcs(adev);
 
@@ -3899,7 +3883,7 @@ static void dm_test_handle_vmin_vmax_update(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
 	mutex_init(&adev->dm.dc_lock);
 
-	dc = dm_test_alloc_dc_with_ctx(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
 	dc->current_state = kunit_kzalloc(test, sizeof(*dc->current_state),
 					  GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc->current_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
index 58615cdbe854..75cd4fef3076 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
@@ -45,23 +45,32 @@ struct dc_link *dm_kunit_alloc_link(struct kunit *test)
 }
 EXPORT_SYMBOL(dm_kunit_alloc_link);
 
-struct dc_link *dm_kunit_alloc_link_with_ctx(struct kunit *test)
+struct dc *dm_kunit_alloc_dc_with_ctx(struct kunit *test)
 {
-	struct dc_link *link;
 	struct dc_context *ctx;
 	struct dc *dc;
 
-	link = dm_kunit_alloc_link(test);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx);
 
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-
-	link->ctx = ctx;
-	ctx->dc = dc;
 	dc->ctx = ctx;
+	ctx->dc = dc;
+
+	return dc;
+}
+EXPORT_SYMBOL(dm_kunit_alloc_dc_with_ctx);
+
+struct dc_link *dm_kunit_alloc_link_with_ctx(struct kunit *test)
+{
+	struct dc_link *link;
+	struct dc *dc;
+
+	link = dm_kunit_alloc_link(test);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	link->ctx = dc->ctx;
 
 	return link;
 }
@@ -138,5 +147,19 @@ struct amdgpu_dm_connector *dm_kunit_alloc_connector(struct kunit *test,
 }
 EXPORT_SYMBOL(dm_kunit_alloc_connector);
 
+struct drm_device *dm_kunit_alloc_drm_with_connector_list(struct kunit *test)
+{
+	struct drm_device *dev;
+
+	dev = kunit_kzalloc(test, sizeof(*dev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	INIT_LIST_HEAD(&dev->mode_config.connector_list);
+	spin_lock_init(&dev->mode_config.connector_list_lock);
+
+	return dev;
+}
+EXPORT_SYMBOL(dm_kunit_alloc_drm_with_connector_list);
+
 MODULE_LICENSE("Dual MIT/GPL");
 MODULE_DESCRIPTION("KUnit test helpers for amdgpu_dm tests");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h
index 0f1c48fa2128..49b358681d60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h
@@ -13,14 +13,18 @@
 struct amdgpu_device;
 struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
+struct dc;
 struct dc_link;
 struct dc_state;
 struct dc_stream_state;
+struct drm_device;
 
 struct amdgpu_device *dm_kunit_alloc_adev(struct kunit *test);
+struct dc *dm_kunit_alloc_dc_with_ctx(struct kunit *test);
 struct dc_link *dm_kunit_alloc_link(struct kunit *test);
 struct dc_link *dm_kunit_alloc_link_with_ctx(struct kunit *test);
 struct amdgpu_display_manager *dm_kunit_alloc_dm(struct kunit *test);
+struct drm_device *dm_kunit_alloc_drm_with_connector_list(struct kunit *test);
 struct dc_stream_state *dm_kunit_alloc_stream(struct kunit *test,
 					      struct dc_link *link);
 void dm_kunit_add_stream_to_state(struct kunit *test, struct dc_state *state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
index 09bd98e93047..0a484ea7c0e8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
@@ -46,19 +46,10 @@ static struct core_power *create_test_power_module(struct kunit *test,
 
 static struct dc_link *alloc_test_psrsu_link(struct kunit *test)
 {
-	struct dc_link *link = dm_kunit_alloc_link(test);
-	struct dc_context *ctx;
-	struct dc *dc;
-
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, ctx);
-
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
+	struct dc_link *link = dm_kunit_alloc_link_with_ctx(test);
+	struct dc_context *ctx = link->ctx;
+	struct dc *dc = ctx->dc;
 
-	link->ctx = ctx;
-	ctx->dc = dc;
-	dc->ctx = ctx;
 	dc->caps.dmcub_support = true;
 	ctx->dce_version = DCN_VERSION_3_1;
 	link->dpcd_caps.edp_rev = DP_EDP_14;
-- 
2.53.0

