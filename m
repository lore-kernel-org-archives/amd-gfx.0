Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D61C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A78D10F07B;
	Wed, 15 Jul 2026 13:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sWp3CwLU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5640210F081
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5l5ZWA0xzcPQZrIIDcqamH2YCRfh12bSAvaeSMfvAbZMp66KjHlG841RYPTVpjp8KiMH//1XN/FIEj8yYa0o0ENR5oecJ4UW/jgfZGUDPmmXf+a/EQ+2yR9d3bUoR64fMk5XUrIj6jk13Bcu1GWWW2St5whNAmobxV32XFE+2PpOXfRjqr/ZmbfXi/WSHn7zImNfK7xEzzV9a+wvrpNvNloaBf+hKlSerVBJrz087f9ucKjBPrloKz6RGY1wqCoy/L3E3h1WCvJK6CeDgM7Z+oVldHxPkAmWtaqTYzigWr+BA2TDUVtWz9dea9B/DkqgtG58yfQajNmIFlzrQWflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaUAkBsii6HVs7P856+sruJsG3Pg0zwNDi8dreNvP1M=;
 b=EyhtSanVp7SmpYQDoAm+TEmd1R2ntXPjs+54lWOezaS6urFDLwrMI5mK0KZ2hSluWhAkn985ELG0k/waKVRJTQxb5x+WWnuoNnm8k22WFnv6yTSxRrKVIkdbl7XPmlt6qSPbTylEw4BQ/OLNzHLJBzUDoHPQn8FdeVKkVupqcd81ErTzPAvV4agBaYSu754KUKXKfbxW10ngwM/8MsJVR6wsiEpAxpoWPeaypoCtLSKDrvyWChstfSkoQODCh7oXevzgqAl2vzEhu2benrzQq9ixUJ3f9k4zJwuvG4r9uOrqbOsTGetadxIe6/i2lGm1yVXny5K1i8wU6L73y17U9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaUAkBsii6HVs7P856+sruJsG3Pg0zwNDi8dreNvP1M=;
 b=sWp3CwLUIx1LzOXJAvpnYVqzBhzk8eHVdPYkqOazzjRXqI2f4w7vJ3fvVdk5YVQwLi19CpWWHqbd6LMWLHPxLQSppIGWCdJMPR1oJID8rV/fpkHXgsmw5poWZlnb7rNEVCRMBzSRY+r0uKp5k6ROwa7CrzCEEyGfeOZIhv+noeI=
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:46:17 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::53) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:01 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 18/70] drm/amd/display: Add register and unregister tests for
 connector
Date: Wed, 15 Jul 2026 21:37:28 +0800
Message-ID: <20260715134432.1975118-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ba9315-13de-41a2-0d50-08dee27771a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|22082099003|18002099003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5iH8+vo96uRH7EUKkvCPCturybb6eWO5THolX63gs0Eg/j2SHBx0hGXPeAWjqtD3nX9BB9MY15viXKSzEN2U1cedrlzAWwXJWj+tcYWVelFeqw5RYGjgoXP/27gf5B9nHjQreP5RloIdcBot5ueaplGoP6zdIjdXt4+lY3yPs3nsU8MJ45FByUk/1KVciTjwPjPq0IrGfzRfLBviwPpPWWkKlhZW+8Qt2AN0zutRy3jGpsYbsOpI1CeJDMZ51U8mfoWAgU2Mk1maup1n66qIgg6ed5phBQSdyMTOFb0zxm3zLTuvMLnFdNKyDPoSoMiMKYL5LJvHeOLunO7IdWOMzkaBdgsp6WM+a8cYa6TXYbqsG8lLyALRMtv1O63+pPXCN0tHSqjq3568ttbT6IcuIYKqGAgEUcCpA2RcrGWoXsyxRyYTVM0FFlnEjDZE0VplY+mxNRPyVQVm69tBKW/LvO60W6sO7761ItB397FgyTmQsQlbtC25YPMJ0drF85M6LD+cTe/NV8AupmX/Y/LP6WgVDQWxRFRD7a4t007gOc0kqhNsC7p+bVIdqweeT+PmdvEmZ5NIuLdY4ivDR6cTokSZhTobqnWeOoNliJrM8VPgPri1NmSkeZMEDKh1EJOzOODB7KI+FaLbb75Jq1OUKSJTfIvaw6x1dwhpTzyjtV6mNr2hjrMWcl09JIbIQsIoD3lh2pV01ockGGBc7bWrsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m+AOjG1/lN2xxxewrNRp2DAYesbPNMWHPiWXGIz6HrDzejg/eWk8ITFwhok8tZuCbG7NliN6yOndbR9JYrcQSTxUHOck5NJ2sOP16doonUL7VCWxZsUGvfVmFAXaHEV93K7WGfx2aRwxEICmTbg3/i4bwtgidDcfIfhSf3DTgTZf3HQlNSP4dSpbBwCCLf5hj+8bkfOfPh1gpG103JH5sZE4ISVJvxoCSRgSZGsBI4X96J+KNeyCquR6TQdJN4uL/YaoxDUh4AKZ+4E6LqhGKzBf4NL4glGi6Q/ZGuWYKRcyLxglAgprNn1H9/gEIdTq2LRysjA95w1ywiVZJm6hqtKbfqfKz5djuqKOImF7cv5eWapYjAYPEVtHa/Z9mUaXH5CVW1xi4MNLcuLS+PTdb2jKcMxWImcvoH8f6EePQ6XsRmuZ2No0IQdjnyOGtYEO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:16.7812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ba9315-13de-41a2-0d50-08dee27771a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238
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

Add KUnit coverage for amdgpu_dm_connector_late_register() and
amdgpu_dm_connector_unregister(): non-DP late register succeeds and
non-DP unregister is a no-op.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  6 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |  2 +
 .../tests/amdgpu_dm_connector_test.c          | 70 +++++++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 94118f7f67c6..131387524aa9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1764,7 +1764,7 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_get_property);
 
-static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
@@ -1774,6 +1774,7 @@ static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 	cec_notifier_conn_unregister(amdgpu_dm_connector->notifier);
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_unregister);
 
 static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 {
@@ -1877,7 +1878,7 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_duplicate_state);
 
-static int
+STATIC_IFN_KUNIT int
 amdgpu_dm_connector_late_register(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -1907,6 +1908,7 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_late_register);
 
 static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 8c4ba5a90ade..f7057e83b4d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -168,6 +168,8 @@ enum drm_connector_status
 amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force);
 enum drm_connector_status
 amdgpu_dm_connector_detect(struct drm_connector *connector, bool force);
+void amdgpu_dm_connector_unregister(struct drm_connector *connector);
+int amdgpu_dm_connector_late_register(struct drm_connector *connector);
 enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state);
 bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index f38706e4d1c2..645347994734 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -3923,6 +3923,72 @@ static void dm_test_poll_dac_load_returns_cached(struct kunit *test)
 		(int)connector_status_connected);
 }
 
+/* Tests for amdgpu_dm_connector_late_register() and _unregister() */
+
+/*
+ * Build an amdgpu_dm_connector embedded in an amdgpu_device so drm_to_adev()
+ * resolves. A VGA connector keeps amdgpu_dm_should_create_sysfs() false (sysfs
+ * and DP AUX branches skipped) and bl_idx == -1 turns backlight registration
+ * into a no-op, leaving the register/unregister bookkeeping safe to exercise.
+ */
+static struct amdgpu_dm_connector *dm_test_reg_connector(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*adev),
+						  offsetof(struct amdgpu_device, ddev),
+						  DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_EQ(test,
+		drmm_connector_init(drm, &aconnector->base,
+				    &dm_test_connector_funcs,
+				    DRM_MODE_CONNECTOR_VGA, NULL), 0);
+
+	aconnector->bl_idx = -1;
+
+	return aconnector;
+}
+
+/**
+ * dm_test_late_register_non_dp_succeeds - Test late_register on a plain connector
+ * @test: The KUnit test context
+ *
+ * With sysfs, backlight and DP AUX registration all skipped, late_register
+ * completes successfully.
+ */
+static void dm_test_late_register_non_dp_succeeds(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_reg_connector(test);
+
+	KUNIT_EXPECT_EQ(test,
+		amdgpu_dm_connector_late_register(&aconnector->base), 0);
+}
+
+/**
+ * dm_test_unregister_non_dp_noop - Test unregister tolerates an unregistered connector
+ * @test: The KUnit test context
+ *
+ * No sysfs group was created, the CEC notifier is NULL and the DP AUX channel
+ * was never registered, so unregister must be a safe no-op.
+ */
+static void dm_test_unregister_non_dp_noop(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_reg_connector(test);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_should_create_sysfs(aconnector));
+
+	amdgpu_dm_connector_unregister(&aconnector->base);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -4131,6 +4197,10 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_detect_no_sink),
 	/* amdgpu_dm_connector_poll */
 	KUNIT_CASE(dm_test_poll_dac_load_returns_cached),
+	/* amdgpu_dm_connector_late_register */
+	KUNIT_CASE(dm_test_late_register_non_dp_succeeds),
+	/* amdgpu_dm_connector_unregister */
+	KUNIT_CASE(dm_test_unregister_non_dp_noop),
 	{}
 };
 
-- 
2.43.0

