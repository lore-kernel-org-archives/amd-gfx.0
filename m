Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C67C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F3D10E1B0;
	Wed, 15 Jul 2026 13:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OBV78bmf";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6052810F081
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXe8Pa0TCSOgZuFYRgsKYHXFt3i138RAt+QBXbwaC13/0WBXUpikpT5iyCn7uWtaO4iV+eZedsHN8QKAZwQxbQyck7EazogV4ZX9jbsyneLUBGntZjhL3vXGJf+og8MTZ6/gg0BVWNPssWsJjCCsYbADdNlUpsMVpE9TSeM5A80imLDrbJIoPx/P7NBcXzXi/d8/R/dREcKTwvQ5NqDOiDAEMDn0YsHSKexzzk8JKL4fUU1MSep3Vxp1DUa0Tr9OQJ8+4Xy5CK7+mrBck5MxqdODytFkk6hVM8CX/LIw0FeaVg6KJo3ST9aPJ5jrxNz48h79hpwNpHsrf5K7XJgNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6UBp6og1oiuZSebowyGBjPVIrMPAi6yAi+2GWYLZF8=;
 b=JFvaqG9Od4xld0zfwfIWjYkBAZx2Ieqa7FIlIOSIEigUY/KKexeU0oht27b0jJBS+QWs/uPunIUhxy3TPUjoUyQf9aLA/upkRt98NlImFujvUef2aoPUXGruoe8mGDEzCWZfCIzKbU3EmhMYo+BWLsGeqWAEfWq3MD5dWMPxDVL/P0ml2y+UASjR2DBlCEK6+HQKYoIk/37gRxdZb3WMYruECs8WK3//w9LU/dJPFdNafTD/+y6nirCUopkVubmUVGaA51rMr7U5+gaBsMahJuDHxGYYSkv0AkUKlUGvrhVPvlOG/KWzINqb5xaoDxIzLEfSrEgTHJ8GY0SRwkJ18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6UBp6og1oiuZSebowyGBjPVIrMPAi6yAi+2GWYLZF8=;
 b=OBV78bmfHhKRcN7OXuehzP8iPGZV3AN8RBvaflRE6dnuE7I6SKEkJxN7pse1cfmCG1RdhuN1ZVn48hfQhq62aidIbLhy7g3g/0KZt0SbNGTlZpV2Gmf1hnmOpHg7uRnB8zL94MsKbWRQIDmYoN2U+5wBWqHhtW2TWsE8vORWOcE=
Received: from CYZPR20CA0011.namprd20.prod.outlook.com (2603:10b6:930:a2::22)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:46:14 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::2e) by CYZPR20CA0011.outlook.office365.com
 (2603:10b6:930:a2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:57 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:54 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 17/70] drm/amd/display: Add detect and poll tests for connector
Date: Wed, 15 Jul 2026 21:37:27 +0800
Message-ID: <20260715134432.1975118-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 149859f2-f021-4623-4879-08dee2776fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: ouYXKdGM1ubzFGsXceI1lkw9/ujydMbRYRNrQPwHSaqDbyiUSYYVZ1cn5AlNul5wXDujQUM4WcKpJbSxXvSIqu8xzG+LqW1t8DXuJEnyAGvirwCFfcjjsmqI3/Ys+lFwKoi1ldycmIJ33YqRBG7Lkium7c01zo8ahYwwGOyT8CFD788XY/qGO3y7S40cd1zJOk+EOy6gaSfz6soebEF3bWRFCRbAnRNLOTLr/9lDB7HW8k3s1y+gVByLOKmQFcf6DMlWNFOlV1FvTDGXwaa2Dv020k0mUpZDzOZsLW3fyJlqBg90yZIAxk8BDK3GvpX2rItdEPMaHRx7E/dnn0IqKUvggFh13RetqWgyAkhrdGiCptI3X+8xTg46b60VVSPkAujzL76G0wPAmBOTI4gCKC+TBD+8TUxGvqqKVx93hmlifXTNX8MMDwAq9CpsqMdvq3q2b+dukgvyI1+S2OTvuiqK8EaZn01TAUzExQc4v/YJZHJVfEtkvropwwNGM03rAJUTHYkHsWfbMfxQvYICd7gjH0zGYT4L1gJco3gI3W0c0aFC5TYIO3nF2YKwnrXW0uCvKNvUwkNGDwfLFXa0WHDg5RWEMQfosSnJ2bPx3ubVzHuI9cBqpbkvcMOZt+P8QPI6I09mHf1dDe4+XL+8I1AeiCCaa1uJqCmV8cueqA0rigGE9Sd2jxBI34pT4b8aFXbc4hImky4pvSxMeZ+f0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0qwCl+NnQ2/JWKa1EKT4LWWklBa0x71tMaNips0rJXhMHps80Z9Vwgs+rJaB1nKWmrGg6mFvcfJl72B5GqcW5Tw9TKxPXom0tJX/4fWVlzl6ZCFJgTNRTW4g9CRdzUDabw015dqVyDJuvrDvR6ZQgKUAXsYCsVLTw91jnLyHV865Surf16/n+px5mIqxjIPHEw/kx56eNqi29JgOgO2+vCzoy/X08oQPxDxLaAACr98AO6GzZBWiY6DtW011oV4shtUY3GOgwskCcVo2MA/ri+vShQe8/+cwVlgCk1a+VoAJayytFfIc6wo2pSCU+6ivIEjjml11QaAM/mimCbKGUu+nB4OJF8VPIkiCiy/rshHjDb7WiZdvM4KF2+GJFf3P5Smn7krnNt+Pm5od8tutqYZEIX78UYF/RZaH99QUsDCHN9oplMif602TYFBHuICI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:13.9179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149859f2-f021-4623-4879-08dee2776fe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
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

Add KUnit coverage for amdgpu_dm_connector_detect() and
amdgpu_dm_connector_poll(): force on (analog/digital), force off,
sink present/absent, and the DAC-load cached status path.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   4 +
 .../tests/amdgpu_dm_connector_test.c          | 157 ++++++++++++++++++
 3 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 5c3dd1eb7878..94118f7f67c6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1545,7 +1545,7 @@ EXPORT_IF_KUNIT(create_stream_for_sink);
  *
  * Return: The probed connector status (connected/disconnected/unknown).
  */
-static enum drm_connector_status
+STATIC_IFN_KUNIT enum drm_connector_status
 amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -1597,6 +1597,7 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
 	mutex_unlock(&aconnector->hpd_lock);
 	return status;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_poll);
 
 /**
  * amdgpu_dm_connector_detect() - Detect whether a DRM connector is connected to a display
@@ -1620,7 +1621,7 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
  * Return: The connector status (connected, disconnected, or unknown).
  *
  */
-static enum drm_connector_status
+STATIC_IFN_KUNIT enum drm_connector_status
 amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -1644,6 +1645,7 @@ amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 	return (aconnector->dc_sink ? connector_status_connected :
 			connector_status_disconnected);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_detect);
 
 int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
 					    struct drm_connector_state *connector_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 51858c92f922..8c4ba5a90ade 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -164,6 +164,10 @@ create_stream_for_sink(struct drm_connector *connector,
 		       const struct dm_connector_state *dm_state,
 		       const struct dc_stream_state *old_stream,
 		       int requested_bpc);
+enum drm_connector_status
+amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force);
+enum drm_connector_status
+amdgpu_dm_connector_detect(struct drm_connector *connector, bool force);
 enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state);
 bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 2d58021b48f3..f38706e4d1c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -3774,6 +3774,155 @@ static void dm_test_create_stream_existing_sink(struct kunit *test)
 	dc_sink_release(sink);
 }
 
+/* Tests for amdgpu_dm_connector_detect() */
+
+/*
+ * A non-DisplayPort connector keeps update_subconnector_property() a no-op and,
+ * because the kunit thread is not the poll worker, the analog poll branch is
+ * skipped. That leaves the forced-state and dc_sink presence branches as the
+ * deterministic behaviour to exercise.
+ */
+static struct amdgpu_dm_connector *dm_test_detect_connector(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+
+	return dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_HDMIA);
+}
+
+/**
+ * dm_test_detect_force_on - Test DRM_FORCE_ON reports connected
+ * @test: The KUnit test context
+ */
+static void dm_test_detect_force_on(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_detect_connector(test);
+
+	aconnector->base.force = DRM_FORCE_ON;
+
+	KUNIT_EXPECT_EQ(test,
+		(int)amdgpu_dm_connector_detect(&aconnector->base, false),
+		(int)connector_status_connected);
+}
+
+/**
+ * dm_test_detect_force_on_digital - Test DRM_FORCE_ON_DIGITAL reports connected
+ * @test: The KUnit test context
+ */
+static void dm_test_detect_force_on_digital(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_detect_connector(test);
+
+	aconnector->base.force = DRM_FORCE_ON_DIGITAL;
+
+	KUNIT_EXPECT_EQ(test,
+		(int)amdgpu_dm_connector_detect(&aconnector->base, false),
+		(int)connector_status_connected);
+}
+
+/**
+ * dm_test_detect_force_off - Test DRM_FORCE_OFF reports disconnected
+ * @test: The KUnit test context
+ */
+static void dm_test_detect_force_off(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_detect_connector(test);
+
+	aconnector->base.force = DRM_FORCE_OFF;
+
+	KUNIT_EXPECT_EQ(test,
+		(int)amdgpu_dm_connector_detect(&aconnector->base, false),
+		(int)connector_status_disconnected);
+}
+
+/**
+ * dm_test_detect_sink_present - Test a present dc_sink reports connected
+ * @test: The KUnit test context
+ */
+static void dm_test_detect_sink_present(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_detect_connector(test);
+	struct dc_sink *sink;
+
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	aconnector->base.force = DRM_FORCE_UNSPECIFIED;
+	aconnector->dc_sink = sink;
+
+	KUNIT_EXPECT_EQ(test,
+		(int)amdgpu_dm_connector_detect(&aconnector->base, false),
+		(int)connector_status_connected);
+}
+
+/**
+ * dm_test_detect_no_sink - Test a missing dc_sink reports disconnected
+ * @test: The KUnit test context
+ */
+static void dm_test_detect_no_sink(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector = dm_test_detect_connector(test);
+
+	aconnector->base.force = DRM_FORCE_UNSPECIFIED;
+	aconnector->dc_sink = NULL;
+
+	KUNIT_EXPECT_EQ(test,
+		(int)amdgpu_dm_connector_detect(&aconnector->base, false),
+		(int)connector_status_disconnected);
+}
+
+/* Tests for amdgpu_dm_connector_poll() */
+
+/**
+ * dm_test_poll_dac_load_returns_cached - Test the DAC load detection shortcut
+ * @test: The KUnit test context
+ *
+ * When the previous connection was established by analog DAC load detection and
+ * polling is not forced, the connector is not re-detected and its cached status
+ * is returned unchanged. The connector is embedded in an amdgpu_device so that
+ * drm_to_adev() resolves.
+ */
+static void dm_test_poll_dac_load_returns_cached(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	struct dc_sink *local_sink;
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
+	adev = drm_to_adev(drm);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_EQ(test,
+		drmm_connector_init(drm, &aconnector->base,
+				    &dm_test_connector_funcs,
+				    DRM_MODE_CONNECTOR_VGA, NULL), 0);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	local_sink = kunit_kzalloc(test, sizeof(*local_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, local_sink);
+
+	link->local_sink = local_sink;
+	link->type = dc_connection_analog_load;
+	aconnector->dc_link = link;
+
+	/* The cached status that the shortcut must return unchanged. */
+	aconnector->base.status = connector_status_connected;
+
+	KUNIT_EXPECT_EQ(test,
+		(int)amdgpu_dm_connector_poll(aconnector, false),
+		(int)connector_status_connected);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -3974,6 +4123,14 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_create_stream_virtual_signal),
 	KUNIT_CASE(dm_test_create_stream_scaling_src),
 	KUNIT_CASE(dm_test_create_stream_existing_sink),
+	/* amdgpu_dm_connector_detect */
+	KUNIT_CASE(dm_test_detect_force_on),
+	KUNIT_CASE(dm_test_detect_force_on_digital),
+	KUNIT_CASE(dm_test_detect_force_off),
+	KUNIT_CASE(dm_test_detect_sink_present),
+	KUNIT_CASE(dm_test_detect_no_sink),
+	/* amdgpu_dm_connector_poll */
+	KUNIT_CASE(dm_test_poll_dac_load_returns_cached),
 	{}
 };
 
-- 
2.43.0

