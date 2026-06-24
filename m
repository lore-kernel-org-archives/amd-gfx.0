Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DABCDE000
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5423610F09E;
	Wed, 24 Jun 2026 18:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0sg21zyG";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A6B710F0A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsDgwTYJT4jNsvZ6cv8vvoKY7XvVZT9xNyqSNzc5oPSYQuEw4E52CrmzdcBO4SUoUetuyM9cSvjJRWIFF+mUsa83KCqjTp+GiIJvxq/b9dFUQQM/uxhXvUQsjIEBDtmZ1TYDXc+RFRPxQbJxKS42qLzsl1vzqZ7qBpxc3XU1HH0utZD9Zrtup7FI6wWClgqvrx4+cvD2quyOwKqpIsU4Ad5N3ZY7iIeeHZKAeBsvcuH9OY6MPDEZA2OmY87LQfrSh4EP7EjSIMPz13wd3AbEsoKJLz5wU4JTVkGJ+KODK7O9Fo6UQz4d56efbsD8C+1/ZfTEDlO87x0UfNxzuXO88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EAHFIB4uHONGcanjopQaCur36ISr68i1WQDxZl8Auk=;
 b=thIfEKBBZP61LLbEs3KA9FPjFv0y+8eWDIIDWZcaaAlfNjijTtnX+v6ATxVfh1Tih+Q7Y+lcj2Zu4fpoxPFX+DJyWkPFIkm1xgfMTMtxz18waVdlgdZKF1LSDFuKFeqamjK9eLVHCqp061lhv+tddOMWQbG1ZYPYgIjShaMhS6DDxYcVwK5SxwSOoaHBCTc9GdNfsyMEA7AeeyioxDUHQGlajFlV7V0vl7DziZA0pFzBeMn5rqpLvBaNqdpjrpQw/Al3Tt3rS7VMGIQ8yIzj2op+OHH4JIdWVGS5KAMuUkSIjWZVjHwrnICkWXedB6ASPBAfBXdIlljG4apVEmeWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EAHFIB4uHONGcanjopQaCur36ISr68i1WQDxZl8Auk=;
 b=0sg21zyGMrptG0lh1GgYalEWyRiJstsUKiUEF6xhGz8/hJxs7hSsJExyFG7qIc0U05VZ6EABAS0E/kcX28phVZL/UWW1TjdIJZasVQvBNIzPvDicX98+q9z+bTcvyZ+KWqyYrRktMTfizMKWDocArl8aXvsP6ud/YsOMx/XYY2E=
Received: from MW4PR03CA0218.namprd03.prod.outlook.com (2603:10b6:303:b9::13)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 18:09:49 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::18) by MW4PR03CA0218.outlook.office365.com
 (2603:10b6:303:b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 18:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:48 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:41 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, kernel test robot <lkp@intel.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 27/28] drm/amd/amdgpu: Fix stack frame size warnings in KUnit
 tests
Date: Wed, 24 Jun 2026 14:03:25 -0400
Message-ID: <20260624180829.4775-28-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d9fcc9-f80d-4c6a-c76e-08ded21bc77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mOMT+NQp/qOn3dcFbGZlNVSOy/IbGKRzJ3IhIdaRhlenDm59kmAKkvm1AD9trndwkDeeIWnCBroTEyVH1Y1Fpd+PTKHNAf0mDW6Ng8JenGGfHaVckWO5Mt11zCo8cHzm2+jc7MjIbkVIhD6g411+UaNMb3UjYZa2OH8JKHO4Y+AOXG32GCv69VAx5ugh1mZtZo2o5BfFeKc0IRn1EHdygGq2FLdm6/BJ6Aq5tKO0ephublUv9OOIehxHeUIspX2yfuWyKdor6ChLqu41ReP0weoe9PBsY6W1HBue76mVVOzUtdskRdxKuVHqNoD2FKVeeru3rURnku39P0iOhzer76p5XNGIgfxcS5atCVjhmFh3wBWzIi6wWkWUg1XXMufxgPTjKfl4K8/ycXSBjcBwZDkAdd1wVSlYnHyPmNgAzg7nobbu6OYM/KZg0/gHMlUZzwx4NPT+aGJJg53R9H8+VwqmqQCI/iu0uzPOU6O9mrS1yIlp6kIoNN0YfZvj7TKXDdlaalI8Fv1U1G8cvLKBWYSNt43eAHdwuhK6zzVmUMJ1TQwTRhwD5XCsiyq1UP7s3hJWm/nMLKPENv8AWccF18CuqGgSQZwhKuN7hTPhcIVwz3fi4ahMFvWLjrQ7NcHDF8vqMgcy0FOVqOBkUYRyI9YxG5oB4i71L5TnepMOlY4euoAe+dtsl/BoR1PC4I4NEt9hsqCEqtjQyAmSO4Pv7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 60S7Y7gJwiWAxUgXXG1mP9WL+jh3mUrzgQGXGkV6BYX+dO5pURIjyfpBh+JJ4lJUQX/MpHa9I3rnsxM1RKlP5SVH0/eXGXb0dBoTU4cSviCe+pKgFWkDR9WfgF8HE7Y+R4fNmqi8XLwpRT10iD79DtlgsCG09RjC+C4fSz7hGNdTw/IOSPFVdAyM37l4x+Qt/kB92EShym7eIkdbrg5DhFflRI+99YXZIxtVgGv1JEQwVrYmjxnEEYeEmhPuwKR8fxFMy2SnnJefv/a9cBKMldFAFKR+8c6Z0o6ZPTE3kFsOZ2E/3UG+46GuWuCI4M5dbb7uyuIfR6pbhbTRGvTbUssps5K/Ch+PMEM5A2Xgy5U4UaghIskLyFbCMfnNjLdMxV7Xi6iQ1Qu3yGkBqgHHX5u3MvWUxmBaQIpMKYVMsNYvEBy48csKIbxsvFMDpAha
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:48.4749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d9fcc9-f80d-4c6a-c76e-08ded21bc77a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
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
Replace stack-allocated large structs with kunit_kzalloc() in KUnit
test functions that exceed the kernel 1280-byte stack frame limit.
Also add CONFIG_FRAME_WARN=1024 to .kunitconfig to enforce the limit.

Affected structs and files:
- struct dc_link in amdgpu_dm_connector_test.c and
  amdgpu_dm_mst_types_test.c
- struct drm_plane, drm_plane_state, drm_framebuffer in
  amdgpu_dm_plane_test.c
- struct drm_connector_state, drm_atomic_state in
  amdgpu_dm_mst_types_test.c
- struct dm_connector_state in amdgpu_dm_test.c

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606230825.9qMV9L0g-lkp@intel.com/
Assisted-by: Copilot:Claude-Opus-4.6
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |   3 +
 .../tests/amdgpu_dm_connector_test.c          |  64 +++++++----
 .../tests/amdgpu_dm_mst_types_test.c          | 104 ++++++++++--------
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  99 ++++++++++-------
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |  72 +++++++-----
 5 files changed, 208 insertions(+), 134 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
index 1e93bd8b44ce..c7c8527dbb10 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
@@ -15,6 +15,9 @@ CONFIG_I2C=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_CRC16=y
 
+# Limit stack size to 1280
+CONFIG_FRAME_WARN=1280
+
 # Treat warnings as errors
 CONFIG_WERROR=y
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 34e40d2a9d2c..aa451064b30c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -29,10 +29,12 @@
  */
 static void dm_test_subconnector_type_none(struct kunit *test)
 {
-	struct dc_link link = {};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
-	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_Native);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_NONE;
+	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_Native);
 }
 
 /**
@@ -41,10 +43,12 @@ static void dm_test_subconnector_type_none(struct kunit *test)
  */
 static void dm_test_subconnector_type_vga(struct kunit *test)
 {
-	struct dc_link link = {};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 
-	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_VGA_CONVERTER;
-	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_VGA);
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_VGA_CONVERTER;
+	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_VGA);
 }
 
 /**
@@ -53,10 +57,12 @@ static void dm_test_subconnector_type_vga(struct kunit *test)
  */
 static void dm_test_subconnector_type_dvi_converter(struct kunit *test)
 {
-	struct dc_link link = {};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_DVI_CONVERTER;
-	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_DVID);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_DVI_CONVERTER;
+	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_DVID);
 }
 
 /**
@@ -65,10 +71,12 @@ static void dm_test_subconnector_type_dvi_converter(struct kunit *test)
  */
 static void dm_test_subconnector_type_dvi_dongle(struct kunit *test)
 {
-	struct dc_link link = {};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 
-	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_DVI_DONGLE;
-	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_DVID);
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_DVI_DONGLE;
+	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_DVID);
 }
 
 /**
@@ -77,10 +85,12 @@ static void dm_test_subconnector_type_dvi_dongle(struct kunit *test)
  */
 static void dm_test_subconnector_type_hdmi_converter(struct kunit *test)
 {
-	struct dc_link link = {};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
-	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_HDMIA);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_HDMIA);
 }
 
 /**
@@ -89,10 +99,12 @@ static void dm_test_subconnector_type_hdmi_converter(struct kunit *test)
  */
 static void dm_test_subconnector_type_hdmi_dongle(struct kunit *test)
 {
-	struct dc_link link = {};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 
-	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_DONGLE;
-	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_HDMIA);
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_DONGLE;
+	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_HDMIA);
 }
 
 /**
@@ -101,10 +113,12 @@ static void dm_test_subconnector_type_hdmi_dongle(struct kunit *test)
  */
 static void dm_test_subconnector_type_mismatched(struct kunit *test)
 {
-	struct dc_link link = {};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	link.dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_MISMATCHED_DONGLE;
-	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_Unknown);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_MISMATCHED_DONGLE;
+	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_Unknown);
 }
 
 /**
@@ -113,10 +127,12 @@ static void dm_test_subconnector_type_mismatched(struct kunit *test)
  */
 static void dm_test_subconnector_type_default_unknown(struct kunit *test)
 {
-	struct dc_link link = {};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 
-	link.dpcd_caps.dongle_type = (typeof(link.dpcd_caps.dongle_type))0x7f;
-	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(&link), (int)DRM_MODE_SUBCONNECTOR_Unknown);
+	link->dpcd_caps.dongle_type = (typeof(link->dpcd_caps.dongle_type))0x7f;
+	KUNIT_EXPECT_EQ(test, (int)get_subconnector_type(link), (int)DRM_MODE_SUBCONNECTOR_Unknown);
 }
 
 /* Tests for get_output_content_type() */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 99d9fdaa4a4a..3f591e3914d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -129,13 +129,15 @@ static ssize_t dm_mst_test_desc_aux_transfer(struct drm_dp_aux *aux,
  */
 static void dm_mst_test_needs_dsc_aux_workaround_match(struct kunit *test)
 {
-	struct dc_link link = {0};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
-	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
-	link.dpcd_caps.sink_count.bits.SINK_COUNT = 2;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 
-	KUNIT_EXPECT_TRUE(test, needs_dsc_aux_workaround(&link));
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
+	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
+	link->dpcd_caps.sink_count.bits.SINK_COUNT = 2;
+
+	KUNIT_EXPECT_TRUE(test, needs_dsc_aux_workaround(link));
 }
 
 /**
@@ -147,13 +149,15 @@ static void dm_mst_test_needs_dsc_aux_workaround_match(struct kunit *test)
  */
 static void dm_mst_test_needs_dsc_aux_workaround_rev12(struct kunit *test)
 {
-	struct dc_link link = {0};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
-	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_12;
-	link.dpcd_caps.sink_count.bits.SINK_COUNT = 3;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 
-	KUNIT_EXPECT_TRUE(test, needs_dsc_aux_workaround(&link));
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
+	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_12;
+	link->dpcd_caps.sink_count.bits.SINK_COUNT = 3;
+
+	KUNIT_EXPECT_TRUE(test, needs_dsc_aux_workaround(link));
 }
 
 /**
@@ -165,13 +169,15 @@ static void dm_mst_test_needs_dsc_aux_workaround_rev12(struct kunit *test)
  */
 static void dm_mst_test_needs_dsc_aux_workaround_wrong_dev_id(struct kunit *test)
 {
-	struct dc_link link = {0};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 
-	link.dpcd_caps.branch_dev_id = 0x123456;
-	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
-	link.dpcd_caps.sink_count.bits.SINK_COUNT = 2;
+	link->dpcd_caps.branch_dev_id = 0x123456;
+	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
+	link->dpcd_caps.sink_count.bits.SINK_COUNT = 2;
 
-	KUNIT_EXPECT_FALSE(test, needs_dsc_aux_workaround(&link));
+	KUNIT_EXPECT_FALSE(test, needs_dsc_aux_workaround(link));
 }
 
 /**
@@ -183,13 +189,15 @@ static void dm_mst_test_needs_dsc_aux_workaround_wrong_dev_id(struct kunit *test
  */
 static void dm_mst_test_needs_dsc_aux_workaround_wrong_rev(struct kunit *test)
 {
-	struct dc_link link = {0};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 
-	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
-	link.dpcd_caps.dpcd_rev.raw = 0x11; /* DPCD 1.1 */
-	link.dpcd_caps.sink_count.bits.SINK_COUNT = 2;
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
+	link->dpcd_caps.dpcd_rev.raw = 0x11; /* DPCD 1.1 */
+	link->dpcd_caps.sink_count.bits.SINK_COUNT = 2;
 
-	KUNIT_EXPECT_FALSE(test, needs_dsc_aux_workaround(&link));
+	KUNIT_EXPECT_FALSE(test, needs_dsc_aux_workaround(link));
 }
 
 /**
@@ -201,13 +209,15 @@ static void dm_mst_test_needs_dsc_aux_workaround_wrong_rev(struct kunit *test)
  */
 static void dm_mst_test_needs_dsc_aux_workaround_low_sink_count(struct kunit *test)
 {
-	struct dc_link link = {0};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
-	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
-	link.dpcd_caps.sink_count.bits.SINK_COUNT = 1;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
+	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
+	link->dpcd_caps.sink_count.bits.SINK_COUNT = 1;
 
-	KUNIT_EXPECT_FALSE(test, needs_dsc_aux_workaround(&link));
+	KUNIT_EXPECT_FALSE(test, needs_dsc_aux_workaround(link));
 }
 
 /**
@@ -219,13 +229,15 @@ static void dm_mst_test_needs_dsc_aux_workaround_low_sink_count(struct kunit *te
  */
 static void dm_mst_test_needs_dsc_aux_workaround_zero_sink_count(struct kunit *test)
 {
-	struct dc_link link = {0};
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
 
-	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
-	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
-	link.dpcd_caps.sink_count.bits.SINK_COUNT = 0;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
 
-	KUNIT_EXPECT_FALSE(test, needs_dsc_aux_workaround(&link));
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
+	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
+	link->dpcd_caps.sink_count.bits.SINK_COUNT = 0;
+
+	KUNIT_EXPECT_FALSE(test, needs_dsc_aux_workaround(link));
 }
 
 /* Tests for dm_mst_get_pbn_divider */
@@ -943,17 +955,23 @@ static void dm_mst_test_create_fake_mst_encoders(struct kunit *test)
  */
 static void dm_mst_test_atomic_check_no_old_crtc(struct kunit *test)
 {
-	struct drm_connector_state old_conn_state = { 0 };
-	struct drm_connector_state new_conn_state = { 0 };
-	struct drm_atomic_state state = { 0 };
+	struct drm_connector_state *old_conn_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_atomic_state *state;
 	struct amdgpu_dm_connector *aconnector;
 	struct amdgpu_dm_connector *root;
 	struct drm_dp_mst_port *port;
 	unsigned int connector_index = 2;
 
+	old_conn_state = kunit_kzalloc(test, sizeof(*old_conn_state), GFP_KERNEL);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
 	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
 	root = kunit_kzalloc(test, sizeof(*root), GFP_KERNEL);
 	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 	KUNIT_ASSERT_NOT_NULL(test, root);
 	KUNIT_ASSERT_NOT_NULL(test, port);
@@ -962,18 +980,18 @@ static void dm_mst_test_atomic_check_no_old_crtc(struct kunit *test)
 	aconnector->mst_root = root;
 	aconnector->mst_output_port = port;
 	port->connector = &aconnector->base;
-	old_conn_state.connector = &aconnector->base;
-	new_conn_state.connector = &aconnector->base;
-	state.num_connector = connector_index + 1;
-	state.connectors = kunit_kzalloc(test,
-					 sizeof(*state.connectors) * state.num_connector,
+	old_conn_state->connector = &aconnector->base;
+	new_conn_state->connector = &aconnector->base;
+	state->num_connector = connector_index + 1;
+	state->connectors = kunit_kzalloc(test,
+					 sizeof(*state->connectors) * state->num_connector,
 					 GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, state.connectors);
-	state.connectors[connector_index].ptr = &aconnector->base;
-	state.connectors[connector_index].old_state = &old_conn_state;
-	state.connectors[connector_index].new_state = &new_conn_state;
+	KUNIT_ASSERT_NOT_NULL(test, state->connectors);
+	state->connectors[connector_index].ptr = &aconnector->base;
+	state->connectors[connector_index].old_state = old_conn_state;
+	state->connectors[connector_index].new_state = new_conn_state;
 
-	KUNIT_EXPECT_EQ(test, dm_dp_mst_atomic_check(&aconnector->base, &state), 0);
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_atomic_check(&aconnector->base, state), 0);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 071c28abaa8a..46c9af432e37 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -185,22 +185,26 @@ static void dm_test_fill_blending_coverage_alpha_format(struct kunit *test)
 static void dm_test_fill_blending_global_alpha(struct kunit *test)
 {
 	struct amdgpu_device *adev;
-	struct drm_plane plane = {0};
-	struct drm_plane_state state = { 0 };
+	struct drm_plane *plane;
+	struct drm_plane_state *state;
 	bool per_pixel_alpha;
 	bool pre_multiplied_alpha;
 	bool global_alpha;
 	int global_alpha_value;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, state);
 
-	plane.dev = &adev->ddev;
-	state.plane = &plane;
-	state.pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
-	state.alpha = 0x8000;
+	plane->dev = &adev->ddev;
+	state->plane = plane;
+	state->pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
+	state->alpha = 0x8000;
 
-	amdgpu_dm_plane_fill_blending_from_plane_state(&state,
+	amdgpu_dm_plane_fill_blending_from_plane_state(state,
 						       &per_pixel_alpha,
 						       &pre_multiplied_alpha,
 						       &global_alpha,
@@ -250,23 +254,28 @@ static void dm_test_modifier_gfx9_swizzle_mode(struct kunit *test)
  */
 static void dm_test_get_plane_formats(struct kunit *test)
 {
-	struct drm_plane plane = {0};
-	struct dc_plane_cap cap = {0};
+	struct drm_plane *plane;
+	struct dc_plane_cap *cap;
 	uint32_t formats[32] = {0};
 
-	plane.type = DRM_PLANE_TYPE_PRIMARY;
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(&plane, NULL, formats, 32), 14);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	cap = kunit_kzalloc(test, sizeof(*cap), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, cap);
+
+	plane->type = DRM_PLANE_TYPE_PRIMARY;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 14);
 
-	cap.pixel_format_support.nv12 = true;
-	cap.pixel_format_support.p010 = true;
-	cap.pixel_format_support.fp16 = true;
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(&plane, &cap, formats, 32), 20);
+	cap->pixel_format_support.nv12 = true;
+	cap->pixel_format_support.p010 = true;
+	cap->pixel_format_support.fp16 = true;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, cap, formats, 32), 20);
 
-	plane.type = DRM_PLANE_TYPE_OVERLAY;
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(&plane, NULL, formats, 32), 9);
+	plane->type = DRM_PLANE_TYPE_OVERLAY;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 9);
 
-	plane.type = DRM_PLANE_TYPE_CURSOR;
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(&plane, NULL, formats, 32), 1);
+	plane->type = DRM_PLANE_TYPE_CURSOR;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_get_plane_formats(plane, NULL, formats, 32), 1);
 }
 
 /**
@@ -433,30 +442,36 @@ static void dm_test_get_cursor_position(struct kunit *test)
 {
 	struct amdgpu_device *adev;
 	struct amdgpu_crtc *amdgpu_crtc;
-	struct drm_plane plane = {0};
-	struct drm_plane_state state = {0};
-	struct drm_framebuffer fb = {0};
+	struct drm_plane *plane;
+	struct drm_plane_state *state;
+	struct drm_framebuffer *fb;
 	struct dc_cursor_position position = {0};
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
 	amdgpu_crtc = kunit_kzalloc(test, sizeof(*amdgpu_crtc), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, adev);
 	KUNIT_ASSERT_NOT_NULL(test, amdgpu_crtc);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
 
 	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 0);
 	amdgpu_crtc->max_cursor_width = 64;
 	amdgpu_crtc->max_cursor_height = 64;
 
-	plane.dev = &adev->ddev;
-	plane.state = &state;
-	state.fb = &fb;
-	state.crtc_x = -5;
-	state.crtc_y = -7;
-	state.crtc_w = 32;
-	state.crtc_h = 32;
+	plane->dev = &adev->ddev;
+	plane->state = state;
+	state->fb = fb;
+	state->crtc_x = -5;
+	state->crtc_y = -7;
+	state->crtc_w = 32;
+	state->crtc_h = 32;
 
 	KUNIT_ASSERT_EQ(test,
-			amdgpu_dm_plane_get_cursor_position(&plane, &amdgpu_crtc->base, &position),
+			amdgpu_dm_plane_get_cursor_position(plane, &amdgpu_crtc->base, &position),
 			0);
 	KUNIT_EXPECT_TRUE(test, position.enable);
 	KUNIT_EXPECT_EQ(test, position.x, 0);
@@ -466,10 +481,10 @@ static void dm_test_get_cursor_position(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, position.translate_by_source);
 
 	memset(&position, 0, sizeof(position));
-	state.crtc_x = -64;
-	state.crtc_y = 0;
+	state->crtc_x = -64;
+	state->crtc_y = 0;
 	KUNIT_ASSERT_EQ(test,
-			amdgpu_dm_plane_get_cursor_position(&plane, &amdgpu_crtc->base, &position),
+			amdgpu_dm_plane_get_cursor_position(plane, &amdgpu_crtc->base, &position),
 			0);
 	KUNIT_EXPECT_FALSE(test, position.enable);
 }
@@ -483,35 +498,37 @@ static void dm_test_get_cursor_position(struct kunit *test)
 static void dm_test_format_mod_supported(struct kunit *test)
 {
 	struct amdgpu_device *adev;
-	struct drm_plane plane = {0};
+	struct drm_plane *plane;
 	uint64_t listed_mod;
 
 	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
 
 	adev->family = AMDGPU_FAMILY_NV;
-	plane.dev = &adev->ddev;
+	plane->dev = &adev->ddev;
 
 	KUNIT_EXPECT_TRUE(test,
-			  amdgpu_dm_plane_format_mod_supported(&plane, DRM_FORMAT_XRGB8888,
+			  amdgpu_dm_plane_format_mod_supported(plane, DRM_FORMAT_XRGB8888,
 							       DRM_FORMAT_MOD_LINEAR));
 	KUNIT_EXPECT_TRUE(test,
-			  amdgpu_dm_plane_format_mod_supported(&plane, DRM_FORMAT_XRGB8888,
+			  amdgpu_dm_plane_format_mod_supported(plane, DRM_FORMAT_XRGB8888,
 							       DRM_FORMAT_MOD_INVALID));
 
 	KUNIT_EXPECT_FALSE(test,
-			   amdgpu_dm_plane_format_mod_supported(&plane, DRM_FORMAT_XRGB8888,
+			   amdgpu_dm_plane_format_mod_supported(plane, DRM_FORMAT_XRGB8888,
 								DRM_FORMAT_MOD_VENDOR_AMD));
 
 	listed_mod = AMD_FMT_MOD |
 		     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
 		     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
 		     AMD_FMT_MOD_SET(DCC, 1);
-	plane.modifiers = &listed_mod;
-	plane.modifier_count = 1;
+	plane->modifiers = &listed_mod;
+	plane->modifier_count = 1;
 
 	KUNIT_EXPECT_FALSE(test,
-			   amdgpu_dm_plane_format_mod_supported(&plane, DRM_FORMAT_NV12, listed_mod));
+			   amdgpu_dm_plane_format_mod_supported(plane, DRM_FORMAT_NV12, listed_mod));
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 31194ab42f04..0b29bf0a7d04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -452,14 +452,19 @@ static void dm_test_get_plane_scale_zero_src_width(struct kunit *test)
  */
 static void dm_test_scaling_state_same(struct kunit *test)
 {
-	struct dm_connector_state a = { 0 };
-	struct dm_connector_state b = { 0 };
+	struct dm_connector_state *a;
+	struct dm_connector_state *b;
 
-	a.scaling = RMX_FULL;
-	a.underscan_enable = false;
-	b = a;
+	a = kunit_kzalloc(test, sizeof(*a), GFP_KERNEL);
+	b = kunit_kzalloc(test, sizeof(*b), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, a);
+	KUNIT_ASSERT_NOT_NULL(test, b);
 
-	KUNIT_EXPECT_FALSE(test, is_scaling_state_different(&a, &b));
+	a->scaling = RMX_FULL;
+	a->underscan_enable = false;
+	*b = *a;
+
+	KUNIT_EXPECT_FALSE(test, is_scaling_state_different(a, b));
 }
 
 /**
@@ -468,13 +473,18 @@ static void dm_test_scaling_state_same(struct kunit *test)
  */
 static void dm_test_scaling_state_scaling_changed(struct kunit *test)
 {
-	struct dm_connector_state a = { 0 };
-	struct dm_connector_state b = { 0 };
+	struct dm_connector_state *a;
+	struct dm_connector_state *b;
+
+	a = kunit_kzalloc(test, sizeof(*a), GFP_KERNEL);
+	b = kunit_kzalloc(test, sizeof(*b), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, a);
+	KUNIT_ASSERT_NOT_NULL(test, b);
 
-	a.scaling = RMX_FULL;
-	b.scaling = RMX_CENTER;
+	a->scaling = RMX_FULL;
+	b->scaling = RMX_CENTER;
 
-	KUNIT_EXPECT_TRUE(test, is_scaling_state_different(&a, &b));
+	KUNIT_EXPECT_TRUE(test, is_scaling_state_different(a, b));
 }
 
 /**
@@ -483,16 +493,21 @@ static void dm_test_scaling_state_scaling_changed(struct kunit *test)
  */
 static void dm_test_scaling_state_underscan_enabled(struct kunit *test)
 {
-	struct dm_connector_state old_state = { 0 };
-	struct dm_connector_state new_state = { 0 };
+	struct dm_connector_state *old_state;
+	struct dm_connector_state *new_state;
+
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_state);
 
 	/* new enables underscan with non-zero borders, old has it disabled */
-	new_state.underscan_enable = true;
-	new_state.underscan_hborder = 16;
-	new_state.underscan_vborder = 16;
-	old_state.underscan_enable = false;
+	new_state->underscan_enable = true;
+	new_state->underscan_hborder = 16;
+	new_state->underscan_vborder = 16;
+	old_state->underscan_enable = false;
 
-	KUNIT_EXPECT_TRUE(test, is_scaling_state_different(&new_state, &old_state));
+	KUNIT_EXPECT_TRUE(test, is_scaling_state_different(new_state, old_state));
 }
 
 /**
@@ -501,16 +516,21 @@ static void dm_test_scaling_state_underscan_enabled(struct kunit *test)
  */
 static void dm_test_scaling_state_underscan_border_changed(struct kunit *test)
 {
-	struct dm_connector_state a = { 0 };
-	struct dm_connector_state b = { 0 };
+	struct dm_connector_state *a;
+	struct dm_connector_state *b;
+
+	a = kunit_kzalloc(test, sizeof(*a), GFP_KERNEL);
+	b = kunit_kzalloc(test, sizeof(*b), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, a);
+	KUNIT_ASSERT_NOT_NULL(test, b);
 
-	a.underscan_enable = true;
-	a.underscan_hborder = 16;
-	a.underscan_vborder = 16;
-	b = a;
-	b.underscan_hborder = 32;
+	a->underscan_enable = true;
+	a->underscan_hborder = 16;
+	a->underscan_vborder = 16;
+	*b = *a;
+	b->underscan_hborder = 32;
 
-	KUNIT_EXPECT_TRUE(test, is_scaling_state_different(&a, &b));
+	KUNIT_EXPECT_TRUE(test, is_scaling_state_different(a, b));
 }
 
 /* Tests for is_timing_unchanged_for_freesync() */
-- 
2.53.0

