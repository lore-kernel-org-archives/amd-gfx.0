Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CB7C531FA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBAF10F1F1;
	Thu, 23 Jul 2026 20:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C4+g521b";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD54610F1EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxP+acbDj1GFQ37jbfBLge/qCLkb+Nrw4+r7pTHHjRe8+XkPfkNqV+O+XRvbNyZnC9UonuyFog9Iqm0UxEEEn+sGqsPqZUM1RSoJ8176PwQ8DVpxxid6U0X3C7VDhrPB68WjGcG+brJJCuuybdMMq/Y1fX15dtXRhkVZp1S/M00rHCcO2JBhy3kJjq0rQocjXoxCRzJCOidDsQV7T0uvtYMRlEoPByXItm8TRID8ErrD0o2YG2wGMydJttZHayw6exk2w535APp5Kudf/GwAuSNywt59FncKxp/H39YjOoTtlN62bdtzh69MdwvaxIjPy1OajfG88PHMO1Y/NBB7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCS0+EzX5vfuoHqRs479Aqp9Cl9DMnANXRkbko/PjC0=;
 b=gclgpas/2ad5FQVF25XOFvAFeSwqn2S+iGUjAgpA7vI98xmMUahERhsVfj4kj2NypNPePytVqL29qC1YGdZmMn0CC0Fox5uyxhI8gjL3BtvftS7MhwmrCUBCrAZyGbT2A8u9giRQae04eaQdn2sKehcdXUlRneVMSPwEDepNdHjOkt5ocBX3OmnIG8d67sfaQ3/1QGko5DnnNo0aCBXQoKsxcsOVASSwK9wSJuajn6ThPSoDhyqMIlQ6+qnBqiompS+uQuzrQq8kTVx7OeFA6/DM7vO51NxZ2/GPbjNVRcZmrt355anhHT1SMT6NAuzQI4yyc3Io2j/q0hkQ3x2nVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCS0+EzX5vfuoHqRs479Aqp9Cl9DMnANXRkbko/PjC0=;
 b=C4+g521bVbjaVnZQSVGeaAcdkbZVzrNjWuMmDjVjz/lNI+PrDrKYZ0TQZ9dS1+J35gSSshVvrRFYuCMWIa8uMrAmUYJvAMtREsAfXLJaMHYtM+oFKHV6gl5PrYe1zN/S9HBXtt/TlCg6JlWgAKS1h3gy2ITjoQL6wi55FufMdOU=
Received: from MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7) by
 DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.18; Thu, 23 Jul 2026 20:19:38 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::60) by MN2PR01CA0038.outlook.office365.com
 (2603:10b6:208:23f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 20:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:33 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:14 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 35/49] drm/amd/display: Add deeper event_property_update tests
Date: Thu, 23 Jul 2026 16:13:43 -0400
Message-ID: <20260723201908.373300-36-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: ea722b77-7914-4521-99f0-08dee8f7b579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5aMVcybl0nBnQ1fHj4gVaC/NPo8w7kn6Go45w+JVFaI1PsMnfJqSZNOV8OYOO6MDYCDV0P8KujeMhKLWy9tJMnrQ68J8xvAjUPjMWYwyITBhvCQXL3Kh1XgYwTIhcwc6EE4IK6bXG5b5jWKMqzvS8ohgYOIl4iK5MTplFyXJgX4nF+X2ibHS1DMru/5NnvxjT93Nrw/x+ypNUgjCgWQkw9b1yP99/vr0LGLmcBscMpSIce/UWdBJTm9KapUGez4+Se+UJ11L0WBz2WSoQSSBkZcuCYNZetJOS2Tu/4ROVWnHn/36PEUv0nrrkEAwZgOQVYHGABnqqnTc3xPTsjGvS+UDPH/SHjgRwfBK3rJTJzrsSZxZmTw70Pc/cFI9q5Do7S1Q1LRFa2hAuSTJOeONya2ejZeic9ItqgN4DI3cgFCkw8hGRQ5T3zQDybeGeCWF8fdAud2fi/VshUDKmyYAJ3CGNy19jZRAQUQqjoqeT4CjrCOPbmfFKNUOJd3z4wIG2aM5v9rVCYpGMPDFSYyKZr7SoVenOz5c/58ANiEqVLNUQCHerJzovXUqE9ANpJJ4RSiwUmM7oBsUBurACwu6UotOQcDSTYIS2dg9jiUX96LeNvyhBB9BlTkJibdyKab7y/QsS+hOMZxqslOeS+5pJDGUu1D8fcewLF53WULzCnClGNxCsja+k6NCp4BWVreN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GSvrQ7B33bCttm6wp3tYaRPv2cDZNju4Synq7XoleLHmqYtOJicBJeAlN8hB/3lOaPC5ci5CDc91kljCumwuHXCzVdB5PO9V0Gvvmpmul1eM9W2KEthWFJMkQ2adlQd15S9OJGUYsHizK0iA4fupjvN9dKVkbZPq1eaxjJtU0FSNOKST1VQB1v5EKlhqy7hof40VLvnYK3S6t743SuSHDX66+a42k4xkTyICnKXWVEByUb4IHKjVhXZcOPGLRSXmceb68Z/9+V4WiZFzziXhKJBfkmFGWUUus3Q4eW+djhLPbT7rR58WqouIvb1aEOT123YHZ66lJCkv6sKePtuB++k7HavBvRTJrZa0WnZ2BZrnB6V0eQ86EX65JtEexZCv+1OscpH1nqW+LEaLlkmLv6Q0T7ofR7eC+kkDgW+B2aAHIbDu2eCauTBGfI0T0i4+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:33.1962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea722b77-7914-4521-99f0-08dee8f7b579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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

Expand KUnit coverage for event_property_update() beyond the null
connector skip. Add cases for the disconnected, missing-state and
missing-device skip branches, plus the fully connected path where
hdcp_get_content_protection_from_status() maps HDCP_OFF to DESIRED and
HDCP1 TYPE0 encryption to ENABLED.

The connected-path tests use dm_kunit_alloc_adev() so the drm_device has
an initialised mode_config connection_mutex, and pre-set the connector
state to the expected content protection value so
drm_hdcp_update_content_protection() takes its no-change early return.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 174 +++++++++++++++++-
 1 file changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index b359ba5d524b..cfdcc44581b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -473,7 +473,8 @@ static void dm_test_process_output_watchdog_stop_and_needed_requeues(struct kuni
  * @test: KUnit test context for managed allocation
  *
  * Allocates a minimal hdcp_workqueue with property_update_work initialised
- * so event_property_update() can resolve container_of() safely.
+ * so event_property_update() can resolve container_of() safely. The mutex is
+ * initialised as well because the connected path takes guard(mutex).
  */
 static struct hdcp_workqueue *alloc_test_workqueue_for_property_update(struct kunit *test)
 {
@@ -482,11 +483,41 @@ static struct hdcp_workqueue *alloc_test_workqueue_for_property_update(struct ku
 	work = kunit_kzalloc(test, sizeof(*work), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, work);
 
+	mutex_init(&work->mutex);
 	INIT_WORK(&work->property_update_work, dummy_work_fn);
 
 	return work;
 }
 
+/**
+ * alloc_update_connector - connector for event_property_update() tests
+ * @test: KUnit test context for managed allocation
+ * @status: drm connector detection status to assign
+ * @conn_state: drm_connector_state to attach (may be NULL)
+ * @dev: drm_device to attach as connector->dev (may be NULL)
+ *
+ * Allocates an amdgpu_dm_connector wired for the traversal in
+ * event_property_update(). The caller supplies the state and device so the
+ * various skip branches (disconnected, no state, no device) and the fully
+ * connected path can all be exercised.
+ */
+static struct amdgpu_dm_connector *alloc_update_connector(struct kunit *test,
+							  enum drm_connector_status status,
+							  struct drm_connector_state *conn_state,
+							  struct drm_device *dev)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	aconnector->base.status = status;
+	aconnector->base.state = conn_state;
+	aconnector->base.dev = dev;
+
+	return aconnector;
+}
+
 /**
  * dm_test_event_property_update_skips_null_connector - null connector is ignored
  * @test: KUnit test context
@@ -507,6 +538,142 @@ static void dm_test_event_property_update_skips_null_connector(struct kunit *tes
 	KUNIT_EXPECT_EQ(test, work->encryption_status[0], before);
 }
 
+/**
+ * dm_test_event_property_update_skips_disconnected - disconnected is skipped
+ * @test: KUnit test context
+ *
+ * A connector whose status is not connector_status_connected must be skipped
+ * before any modeset lock is taken, leaving encryption_status untouched.
+ */
+static void dm_test_event_property_update_skips_disconnected(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_update(test);
+	struct drm_connector_state *conn_state;
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	work->aconnector[1] = alloc_update_connector(test, connector_status_disconnected,
+						     conn_state, NULL);
+	work->encryption_status[1] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
+
+	event_property_update(&work->property_update_work);
+
+	KUNIT_EXPECT_EQ(test, work->encryption_status[1],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON);
+}
+
+/**
+ * dm_test_event_property_update_skips_null_state - missing state is skipped
+ * @test: KUnit test context
+ *
+ * A connected connector without a drm_connector_state must be skipped before
+ * the modeset lock, leaving encryption_status unchanged.
+ */
+static void dm_test_event_property_update_skips_null_state(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_update(test);
+
+	work->aconnector[2] = alloc_update_connector(test, connector_status_connected,
+						     NULL, NULL);
+	work->encryption_status[2] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
+
+	event_property_update(&work->property_update_work);
+
+	KUNIT_EXPECT_EQ(test, work->encryption_status[2],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON);
+}
+
+/**
+ * dm_test_event_property_update_skips_null_dev - missing device is skipped
+ * @test: KUnit test context
+ *
+ * A connected connector with state but no drm_device must be skipped before
+ * the modeset lock, leaving encryption_status unchanged.
+ */
+static void dm_test_event_property_update_skips_null_dev(struct kunit *test)
+{
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_update(test);
+	struct drm_connector_state *conn_state;
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	work->aconnector[3] = alloc_update_connector(test, connector_status_connected,
+						     conn_state, NULL);
+	work->encryption_status[3] = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
+
+	event_property_update(&work->property_update_work);
+
+	KUNIT_EXPECT_EQ(test, work->encryption_status[3],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON);
+}
+
+/**
+ * dm_test_event_property_update_desired_when_off - HDCP off maps to DESIRED
+ * @test: KUnit test context
+ *
+ * A fully connected display with HDCP_OFF encryption drives the connected
+ * path: the modeset lock is taken, hdcp_get_content_protection_from_status()
+ * reports DRM_MODE_CONTENT_PROTECTION_DESIRED and
+ * drm_hdcp_update_content_protection() is called. The connector state is
+ * pre-set to DESIRED so the value is unchanged (no sysfs event) and the deep
+ * path completes cleanly.
+ */
+static void dm_test_event_property_update_desired_when_off(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_update(test);
+	struct drm_connector_state *conn_state;
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+	conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+
+	work->aconnector[0] = alloc_update_connector(test, connector_status_connected,
+						     conn_state, &adev->ddev);
+	work->encryption_status[0] = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+
+	event_property_update(&work->property_update_work);
+
+	KUNIT_EXPECT_EQ(test, conn_state->content_protection,
+			(unsigned int)DRM_MODE_CONTENT_PROTECTION_DESIRED);
+	KUNIT_EXPECT_EQ(test, work->encryption_status[0],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF);
+}
+
+/**
+ * dm_test_event_property_update_enabled_when_encrypted - encrypted maps to ENABLED
+ * @test: KUnit test context
+ *
+ * A fully connected display with TYPE0 content and HDCP1 encryption drives
+ * the connected path where hdcp_get_content_protection_from_status() reports
+ * DRM_MODE_CONTENT_PROTECTION_ENABLED. The connector state is pre-set to
+ * ENABLED so drm_hdcp_update_content_protection() leaves it unchanged.
+ */
+static void dm_test_event_property_update_enabled_when_encrypted(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct hdcp_workqueue *work = alloc_test_workqueue_for_property_update(test);
+	struct drm_connector_state *conn_state;
+
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+	conn_state->hdcp_content_type = DRM_MODE_HDCP_CONTENT_TYPE0;
+	conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+
+	work->aconnector[0] = alloc_update_connector(test, connector_status_connected,
+						     conn_state, &adev->ddev);
+	work->encryption_status[0] = MOD_HDCP_ENCRYPTION_STATUS_HDCP1_ON;
+
+	event_property_update(&work->property_update_work);
+
+	KUNIT_EXPECT_EQ(test, conn_state->content_protection,
+			(unsigned int)DRM_MODE_CONTENT_PROTECTION_ENABLED);
+	KUNIT_EXPECT_EQ(test, work->encryption_status[0],
+			MOD_HDCP_ENCRYPTION_STATUS_HDCP1_ON);
+}
+
 /* End of tests for event_property_update() */
 
 /* Tests for event_callback() */
@@ -2367,6 +2534,11 @@ static struct kunit_case dm_hdcp_test_cases[] = {
 	KUNIT_CASE(dm_test_process_output_watchdog_stop_and_needed_requeues),
 	/* event_property_update() */
 	KUNIT_CASE(dm_test_event_property_update_skips_null_connector),
+	KUNIT_CASE(dm_test_event_property_update_skips_disconnected),
+	KUNIT_CASE(dm_test_event_property_update_skips_null_state),
+	KUNIT_CASE(dm_test_event_property_update_skips_null_dev),
+	KUNIT_CASE(dm_test_event_property_update_desired_when_off),
+	KUNIT_CASE(dm_test_event_property_update_enabled_when_encrypted),
 	/* event_callback() */
 	KUNIT_CASE(dm_test_event_callback_cancels_callback_dwork),
 	KUNIT_CASE(dm_test_event_callback_schedules_property_validate),
-- 
2.53.0

