Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA779C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39DD110E308;
	Wed,  2 Sep 2026 05:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wxv7jAg/";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DF010E308
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U44XWlH5mq9Je4CAi/L5z5Jd2Yp9b33xEwFwQ1npBgRlZHTSPFbTPGIhYu2j32AFEuQSczB8nLn6EFvRWuwEJ5mZTw/xd22UzD437p/9/DaonpXIix05DkhQuVCaMJ+zC7mu9F0AaSN10Y+TqxWxMTZeq+w58qhlGWENt1EUbSqKcvgLg1qwO8bhaaEV9C3GdgdJExtPx+5S6veBJKjdDF80waxdZ6yOvA6lmojcUzj8icA3/LOAWW0P4xr49U+m2ZN/EXaVGY5PTBLyhk3/ZPuG2Dty/4uFQ1FWt3b3cFDLWp7PjWszbOXwsSXpzfns+SjwTikbbQb261/w4e5oxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2mk/FIWJjsW5Lg3JUAoJ/Vm4iyCwJymigCo9rv8lFo=;
 b=PkDh2dkpv27L/w7uKV0mPRwBCx7MnFcwoG+ryOfGce9QsuErI2SYN/U5vIfDrp7UEhYi31lxF/4pflV03rwi7Z4a3LkgPuW8tqpg5+bKoxwgHto6stz3EsY549CiQKWYj5L2CditGQZWmRdfYV9nHWiVEcdWPqEHBfGj7mdIYec2HULoc1M/b8la3lM4N0Xbmn/jKK5A2xHlvwH3qoVcoxL9RDRdTbYd0+sHaZr7+IxlTFgwfPhwzaa0IOVYYUpvDswmGJZdL3FcTR3EU+8QAbZtuOI4f+63MvdSIzDMlVkXSoPxRX5EPYJV8fKOTQAUC738FnPjMdw6/BmW0ezblQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2mk/FIWJjsW5Lg3JUAoJ/Vm4iyCwJymigCo9rv8lFo=;
 b=Wxv7jAg/3Gk5E0GXQOEbh7tpDoq5i5s4mdtIS/ET2+8H5bH1nfHSj/22aEv7IAj1oz1R+GPZXBKaMEPpJgilrKqdkmdK3HfDhAFb555nsbgFfhq3EOpwCywWIf5alI9UJ5ESKPyxOtTTGkJwee0yPhgunxcD9cDgYcF/6YJVAUQ=
Received: from BN9PR03CA0057.namprd03.prod.outlook.com (2603:10b6:408:fb::32)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:05:45 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::72) by BN9PR03CA0057.outlook.office365.com
 (2603:10b6:408:fb::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 05:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:05:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:05:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:05:43 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:05:35 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 09/40] drm/amd/display: Test cached suspend state
Date: Wed, 2 Sep 2026 12:58:31 +0800
Message-ID: <20260902050411.3473916-10-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aebfd8d-1543-41a5-3554-08df08afd844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 1KeAwjt7dmBAqcRIlJY45YDvUBYWn28/v+74qrxvQSzp+fYH0BHM/M7SeBCkM9syA+mMolp84DiUEjUU/PD7LJ1MNtUiyC8ABlGY86Fn9VOj6yWBIfz9APBfmGTBFHU/DqHTCc4C8ZId61WYhwX/z55pPW0GdtQXTzss4L/taYf/oYPrgV+Z8XJa9X1v42psBJUNS4LQZa9b2zsX+zpGZNPi+bVO2EZtMS4o4TcvpzxoFF3PDVtUaSvDs8DbmkHNbUNgJOTgl96gb1QsNrGizDv3fGQ4Wlq8I1khVEtWjFK9jFiYZ2SDa2i+onWFjneRGzuqfWAqFwULUc7ofy+wI0uBouF16AjLMbWopoypxitGAxjWWpeumlMuZJsoU/K+H0gpPXlv4UQO61z71bKCknYfdcL/TIKK8BrOIjKHqrN0Izwq8506y7/JQ+9Pvc9rtk55XPQRGFA5prVyKmlX+axZ1dyYGa7RMAaF29AtLy/EvnyWcy6nbkhs/+qHkf4KeBqa1sN9x1+Ne6HqKA6G8K7RK2adSjk1LaroTKfouTWD+rXy/gGYRoFqOAL15NmoYLJwM9PTt5YKb9s1DDklABydXC4OZdVsuDSeBTS7szJDlfWgWxSQKXMu5R4dcvx3JVpz3OYSRrpUxsDaazS/atcqfkUqdIPsujgW5leiJcITwDzZ218+BCQ74RJIaJMnV2/se3OHQSPfAAQY6AD3mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FWDjU5+Jkt+sn2E29xC1/mNNDGHp2IkU6AvLV2m6XZ0LrHr+3C8Yf7sf2zH45/dTg+lTw5jogmMp2r96YLUZyZVVexKn6nXAUs/H5s8nweEDQCiCrP0BsXpC2+eKLi7JL8QUVYfzoo8J7+qqFcOTh726kKMaAXhw4662hLwZOXFtHfh/I/IzkegEyTmCZtS/lZ8dRwBnm10Lu45ShiKMvDy8hR3c4np/R1+J8nE8aIoSRLg3+8Kna6b6yDEjgr35zVGJPV7peRR/cWr4V8Ro1U3ZxUm+4vX3KTG4LbbB8q3SA/PukU7+faoXIYYgke4cNa/cKGPuwwzNLA4DzR7wxwQpDIFbndy8CWR93oMQSb7TJ2HlhmxQ+hx2oUIru1Mu8CRtzVVcydGx3e9M51lXXyRabUKn5wZpXSjsblYPv6WENPzvGeTddPvPBM2H5Srb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:05:45.0157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aebfd8d-1543-41a5-3554-08df08afd844
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423
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

[Why]
Add KUnit tests for dm_cache_state() covering successful caching
on an empty DRM device and propagation of an atomic suspend error.

[How]
Use the standard DRM KUnit device for the success path and the
shared DM ops table to inject the suspend failure.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6 Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 40 +++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9b1ffc04c761..42e2ef74c687 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1540,11 +1540,11 @@ STATIC_IFN_KUNIT enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_commit_zero_streams);
 
-static int dm_cache_state(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT int dm_cache_state(struct amdgpu_device *adev)
 {
 	int r;
 
-	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
+	adev->dm.cached_state = dm_atomic_helper_suspend(adev_to_drm(adev));
 	if (IS_ERR(adev->dm.cached_state)) {
 		r = PTR_ERR(adev->dm.cached_state);
 		adev->dm.cached_state = NULL;
@@ -1552,6 +1552,7 @@ static int dm_cache_state(struct amdgpu_device *adev)
 
 	return adev->dm.cached_state ? 0 : r;
 }
+EXPORT_IF_KUNIT(dm_cache_state);
 
 STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 739171d5365c..4d12632d048f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1276,6 +1276,7 @@ void mmhub_read_system_context(struct amdgpu_device *adev,
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
 void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev, struct dc_state *state, bool enable);
 enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc);
+int dm_cache_state(struct amdgpu_device *adev);
 void dm_destroy_cached_state(struct amdgpu_device *adev);
 int dm_early_init(struct amdgpu_ip_block *ip_block);
 int fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 833f73972ab2..61fa553c7a99 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -4371,6 +4371,44 @@ static void dm_test_commit_zero_streams_empty(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_commit_zero_streams(dc), (int)DC_OK);
 }
 
+/**
+ * dm_test_cache_state_empty_device - Test caching an empty DRM atomic state
+ * @test: The KUnit test context
+ */
+static void dm_test_cache_state_empty_device(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	KUNIT_ASSERT_EQ(test, dm_cache_state(adev), 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->dm.cached_state);
+
+	dm_destroy_cached_state(adev);
+	KUNIT_EXPECT_NULL(test, adev->dm.cached_state);
+}
+
+static struct drm_atomic_commit *dm_test_atomic_helper_suspend_error(struct drm_device *dev)
+{
+	return ERR_PTR(-EIO);
+}
+
+static const struct amdgpu_dm_kunit_ops dm_test_cache_state_ops = {
+	.atomic_helper_suspend = dm_test_atomic_helper_suspend_error,
+};
+
+/**
+ * dm_test_cache_state_error - Test atomic suspend errors are returned and cleared
+ * @test: The KUnit test context
+ */
+static void dm_test_cache_state_error(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	dm_test_install_dm_ops(test, &dm_test_cache_state_ops);
+
+	KUNIT_EXPECT_EQ(test, dm_cache_state(adev), -EIO);
+	KUNIT_EXPECT_NULL(test, adev->dm.cached_state);
+}
+
 /**
  * dm_test_destroy_cached_state_none - Test no cached state is a no-op
  * @test: The KUnit test context
@@ -5196,6 +5234,8 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_early_init_unsupported_version),
 	/* suspend and resume helpers */
 	KUNIT_CASE(dm_test_commit_zero_streams_empty),
+	KUNIT_CASE(dm_test_cache_state_empty_device),
+	KUNIT_CASE(dm_test_cache_state_error),
 	KUNIT_CASE(dm_test_destroy_cached_state_none),
 	/* dm_update_mst_vcpi_slots_for_dsc */
 	KUNIT_CASE(dm_test_mst_vcpi_slots_no_connector),
-- 
2.43.0

