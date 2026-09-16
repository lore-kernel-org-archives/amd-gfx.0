Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C61C982D4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877A110ED0E;
	Wed, 16 Sep 2026 17:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="op+myocz";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9A310ECE0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ee9UGGXmrJT1aSxjv2Mmq5WtjuFYWTRsdUwDGFoNJPX31e+Vjos7tn5iaDY8oPFRxOjiZ6ux2a7tj+vaonVG+w8b9vJOgD7wWuaEPltHF9XaUbX3U6850D05KEDf/WJxAxXM4Jw1p1sqru6Jms7Y0EBsNtiNpsEWmDD2Gk7envNHTZqdK/8yQEvzUH8vYVKv0HPVT6upKUJktq98L2MjTAMCisq/lLUE3vCWSeLFOely2enHjJLZB5bwL37Xjzmdn8jIt6ArPYk7+pb2ilBZJ7ar/jqbNHQAhyQcYaAb1Vt3/ZB7mLV/cNPaoAKsItP88Ivmm4ge7mfud+yzZ7h8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICG8dgwhWhvSkEWkKjZaFAtIqVkVOsyFUS08BcDOvOM=;
 b=x7H242tVpXtos+cPDcsJAwvHahVoWdmDMsbfqFkD12ReaM8aIlkFj+/x7V5dWqRzFjxw2e0/N18CQcFF9Bjfa3I3qGrryo1n1WnkukdbGNhFM9Gno9NQDAmQxk78Y8PDcLtzQmgJ8HdB7l7z9UF7N/unws5sQK3b9XAQM3AUtKOa1iy5VXTw6pU/bTdoZfuYBDVny/rVOCalmSDf4oDD8W5cGbr+viTOXq79NeCdTf1CP7FZR6NWRgSmfqHEQU0omHTnlvKFvj4EH9ZuJK+iCPV37yU+oCGwdtg/K9bM3hsETEKtyVNscUj51bNDJDjsAnwG11hKwP3Cgs5Q+3d3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICG8dgwhWhvSkEWkKjZaFAtIqVkVOsyFUS08BcDOvOM=;
 b=op+myoczCR6sBt7/liRPi3CbihICPclgSBK3nbOaVKlCck7hMdKdXD96AHzw0am49U5hxebBuqcfp8/aBmarrOOAm1IBPJJORpSnveXUvzMyQbXlrcT68LGsxJApCxp/bCZkI7JLR1BGuVXNOBhmlfiQG0qFGtwj9EWK5O5wmw4=
Received: from CH5P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::19)
 by SA5PPF7D510B798.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:53:06 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::b) by CH5P220CA0021.outlook.office365.com
 (2603:10b6:610:1ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:06 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:55 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 53/64] drm/amd/display: Fix KUnit checkpatch warnings
Date: Wed, 16 Sep 2026 13:52:08 -0400
Message-ID: <20260916175301.368306-54-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SA5PPF7D510B798:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d686897-dc23-468d-1403-08df141b5cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fMKtiSlgriCvdvm4by1s3B1CCpaxIZh9WVpcbMXmW2jpHpFFZsksf3zcemCMLfy1QdnebwO5GlpUyVjJtb6ytefu4uEeLAfigkLHvdnTl73yql2CBf9cRmiftO0J9Ovsm0NjKN3l+3eGW+KvIZFjJfo2Y+MjBLSpdljp8eLcUgu+LEcGKspmYxH+xlciUvrXBbgOQGEOi5cbHO9AbSapR0omqvFfoxnO4gzYrAP/N2a+ds5Oi46lVwRxPHuCVw6WnnbWnDDQLcVbLBqXiCTiTSo75xpbu1yPWsQh7UCueHLbOivMdIbOOey6qmaVr9KMOOpRAFaU9mLfOOcW7gHAQf48iTqavR4YhVAPculb5+aXpI/1ugTkgaHcnRtNatyXXX6TpqWG1VTZ1IOsGRTTu0N/AtKnxdZv7LBiCXR+6Fa8qCx5meqPY+ov0iYDw77Y/nQHJjeNmDIkrPdko7EUftj8o35JKsCknsJF2gLo/XnyQddMzvcaVoO08m48P72KuAXkDeytlcqCGzNC+vhqSZwOELMN2lkrQBI+GY/jb8oNc8P6FzR1pEr3/hqsoM6fSwRwW6ZHxpHRXvmG/w3u8AlFmZrp3Gbk/LDq/52ht8cNc9PN9smU9/pJtfD9Zm64v8XY86am9N5sLkTz8nNov4b7AuJ/MU771DucnheDQg/+nXfqHu6k9/650Ddxw15O8gX3p1eqwOofHVV/3HB46Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZfnN3S8vxyjyaGxs4YzyG7o6CklYaZ8pDlAhevlDC2O4AMy96glMdqsbpca2YtGk6lPQHWeO/u1HmyvwrOsvNxkEU+YNGLswS0fs3SzBtKK9VTNXcKg3xIkS5L3rK5n5/B9Rt9SdPzmIK2B2GWZ02sVSLLRVaeQhRpsegTi4e08Ec8nNGE+3PSntAex8UJovsVjWo2J6nT3zGWBYL/wvkp97oyKq7+xGdSHbQdeZufiEqIAlGMISHpGEUoI8Z5jI5X13VACB6mE91fGbnJhLfpG62+GgZRkUksNt5iQqrFswy1qkrmccqX2kRk/5v00kZV5DA8paGck7Y/3PpQ/4QBPTpsFxk5FHZs66I/exbv7YYlN8dWP+WTe7mJsjYIv/tCbs1SVRoFJss2PIbJtW85QgHfN3KVB+/7TWgGTNDwtZoiHXANJrPVSFyDZ/rF5z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:06.4012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d686897-dc23-468d-1403-08df141b5cdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7D510B798
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

[WHY]
Clean up the AMDGPU DM KUnit tests after checkpatch reported an
invalid sizeof(void) allocation, typed kzalloc patterns, and a
repeated word in a kernel-doc summary. Clarify the test name that
covers an active CRTC state transition.

[HOW]
- Use sizeof(cpu_ptr) for the fake CPU pointer allocation.
- Replace typed kzalloc(sizeof(*object), ...) calls with
  kzalloc_obj(*object, ...) in the connector, IRQ, plane, and
  atomic-state tests.
- Rename the CRTC active-state test and update its kernel-doc and
  suite registration.

Assisted-by: Copilot:GPT-5.6-Luna
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c |  2 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |  6 +++---
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   | 10 +++++-----
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |  6 +++---
 .../display/amdgpu_dm/tests/amdgpu_dm_services_test.c  |  2 +-
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 0f7cf32373d3..bd55d943e4e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4897,7 +4897,7 @@ dm_test_destroy_connector(struct kunit *test, struct drm_device *drm)
 {
 	struct amdgpu_dm_connector *aconnector;
 
-	aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
+	aconnector = kzalloc_obj(*aconnector, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 
 	KUNIT_ASSERT_EQ(test,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 4c379adfec85..3fdff1cab243 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -42,10 +42,10 @@ static void dm_test_crtc_modeset_required_active_mode_changed(struct kunit *test
 }
 
 /**
- * dm_test_crtc_modeset_required_active_active_changed - Test Crtc modeset required active active changed
+ * dm_test_crtc_modeset_required_active_state_changed - Test modeset required when the active state changes
  * @test: The KUnit test context
  */
-static void dm_test_crtc_modeset_required_active_active_changed(struct kunit *test)
+static void dm_test_crtc_modeset_required_active_state_changed(struct kunit *test)
 {
 	struct drm_crtc_state state = {};
 
@@ -2622,7 +2622,7 @@ static void dm_test_crtc_atomic_check_invalid_stream_fails(struct kunit *test)
 static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	/* amdgpu_dm_crtc_modeset_required */
 	KUNIT_CASE(dm_test_crtc_modeset_required_active_mode_changed),
-	KUNIT_CASE(dm_test_crtc_modeset_required_active_active_changed),
+	KUNIT_CASE(dm_test_crtc_modeset_required_active_state_changed),
 	KUNIT_CASE(dm_test_crtc_modeset_required_active_connectors_changed),
 	KUNIT_CASE(dm_test_crtc_modeset_required_inactive),
 	KUNIT_CASE(dm_test_crtc_modeset_required_no_changes),
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index c130f0d07315..a139890b7cd5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -2231,7 +2231,7 @@ static void dm_test_hpd_rx_offload_work_no_connector(struct kunit *test)
 	offload_wq = kunit_kzalloc(test, sizeof(*offload_wq), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_wq);
 
-	offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
+	offload_work = kzalloc_obj(*offload_work, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, offload_work);
 	offload_work->offload_wq = offload_wq;
 	offload_work->adev = adev;
@@ -4285,9 +4285,9 @@ static void dm_test_handle_hpd_work_out_of_range(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = dm_kunit_alloc_adev(test);
-	hpd_work = kzalloc(sizeof(*hpd_work), GFP_KERNEL);
+	hpd_work = kzalloc_obj(*hpd_work, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hpd_work);
-	hpd_work->dmub_notify = kzalloc(sizeof(*hpd_work->dmub_notify), GFP_KERNEL);
+	hpd_work->dmub_notify = kzalloc_obj(*hpd_work->dmub_notify, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hpd_work->dmub_notify);
 	hpd_work->dmub_notify->type =
 		(enum dmub_notification_type)ARRAY_SIZE(adev->dm.dmub_callback);
@@ -5059,9 +5059,9 @@ static void dm_test_handle_vmin_vmax_update(struct kunit *test)
 	kref_get(&stream->refcount);
 
 	/* The worker kfree()s both, so they must come from the slab. */
-	work = kzalloc(sizeof(*work), GFP_KERNEL);
+	work = kzalloc_obj(*work, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, work);
-	adjust = kzalloc(sizeof(*adjust), GFP_KERNEL);
+	adjust = kzalloc_obj(*adjust, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adjust);
 
 	work->adev = adev;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 9491ae883d3c..0a8bebed0c66 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -2266,7 +2266,7 @@ static void dm_test_plane_reset_initializes_state(struct kunit *test)
 	 * destroy-existing-state path. The destroy hook frees this state, so it
 	 * must be a plain (non-KUnit-managed) allocation.
 	 */
-	old_state = kzalloc(sizeof(*old_state), GFP_KERNEL);
+	old_state = kzalloc_obj(*old_state, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, old_state);
 	plane->funcs = &dm_test_plane_reset_funcs;
 	plane->state = &old_state->base;
@@ -2428,7 +2428,7 @@ static void dm_test_plane_destroy_state_minimal(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, plane);
 
 	/* destroy_state frees the state itself, so use a plain allocation. */
-	dm_plane_state = kzalloc(sizeof(*dm_plane_state), GFP_KERNEL);
+	dm_plane_state = kzalloc_obj(*dm_plane_state, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dm_plane_state);
 
 	amdgpu_dm_plane_drm_plane_destroy_state(plane, &dm_plane_state->base);
@@ -2456,7 +2456,7 @@ static void dm_test_plane_destroy_state_releases_resources(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, dc_plane_state);
 
 	/* destroy_state frees the state itself, so use a plain allocation. */
-	dm_plane_state = kzalloc(sizeof(*dm_plane_state), GFP_KERNEL);
+	dm_plane_state = kzalloc_obj(*dm_plane_state, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dm_plane_state);
 
 	/* Hold an extra reference so the release does not free KUnit memory. */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
index 4ff430e4b23b..bdbceb83a8a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
@@ -337,7 +337,7 @@ static int dm_test_gpu_mem_init(struct kunit *test)
 {
 	void *cpu_ptr;
 
-	cpu_ptr = kunit_kzalloc(test, sizeof(*cpu_ptr), GFP_KERNEL);
+	cpu_ptr = kunit_kzalloc(test, sizeof(cpu_ptr), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, cpu_ptr);
 
 	dm_test_bo_ctx = (struct dm_test_bo_ops_ctx) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 11be3a267ce9..7bf5a0529c94 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -247,7 +247,7 @@ static void dm_test_atomic_destroy_state_no_context(struct kunit *test)
 	 * Use kzalloc(), not kunit_kzalloc(): dm_atomic_destroy_state() frees
 	 * the state itself, so KUnit-managed memory would be double-freed.
 	 */
-	dm_state = kzalloc(sizeof(*dm_state), GFP_KERNEL);
+	dm_state = kzalloc_obj(*dm_state, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dm_state);
 
 	/* context == NULL: dc_state_release() is skipped and the state is freed. */
-- 
2.55.0

