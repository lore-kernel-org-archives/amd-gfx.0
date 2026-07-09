Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965E1C44508
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40C810F6F9;
	Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OeeEoXu0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C213310F6EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2iox1lDIJH4xFJOFguIF7azQq9++84eAznUTYuq5krEmhjQGyiNu6AWwZeS7kEQhdPffMqWLG+I3saaSxOf7Ve/wu+0p549tRnuaUWNuI27hawgeRSCO1pUGbtqz5IRiHvOD7yzbU0Nft4qgUGsu2NdHC2EQUYdZeeV++LGnTQdkv/AEP5r5DDqe0kMttOBILI1wOGAvueAjytNRS2Khu6WV9j7/XsikjNNvt1ULvStk+W0x2oRPrkpEaxX3qYOgX8FrmAVIzHXQY0EJDfS1IY5U3C33B2J4z6hZSDQ+m9eIAa8YNoDbAgwkFTUcxBLJadR5jDxKCeB9lrArf/0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8L+j7YCk+r6eu9GH2tMbBrNje6pwgxL+RL8kaN6DBQ=;
 b=YcJJREWcTYRJJC4W0+BIMACGNmQsQ8yc0Q9yKwuV2zgO84/lcxYuFzpVqAJq+sAvcmuo2wUOBkJJKsdIU9sdhO2r+8q2Fpzlzh+b7UFychzmMIDwb5wgtClCzR7HRDAB1UK/nP2BE6cJ2sV7Cx0STmd0JgYY3tj2UH/+esaZ5sO0+74dMRp5rEb3YKQMbW9iqfFI0/FpyvM2dmdcD2cpi3EyxdnjkqoiMShf2qhhkiSbEpHWzUMvw4ygec0HwVqT049V0Ctzn84KzCCvILJr7ygFdJptblgT5l6L9iMjaDc5oZpoWs4MpMedK8yvtYb7oUOhXRoDEJCUAJiOIoqa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8L+j7YCk+r6eu9GH2tMbBrNje6pwgxL+RL8kaN6DBQ=;
 b=OeeEoXu0QHRBd1PrPTBNOPlia1DC+Xv8pqnEXRyKrjVCDgo9OgXytcEmp8cqQFAoHbHUg5uIhrnEMmrZ0NiPtDWRveHqETk+v1ubIQm29m2HEdUs+R1a55It9USrTIN7HlBUpjAZfWbtta6Ou0HQxPgWEzueowCCoxe0JSt1SOY=
Received: from BLAPR03CA0097.namprd03.prod.outlook.com (2603:10b6:208:32a::12)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 21:02:27 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::24) by BLAPR03CA0097.outlook.office365.com
 (2603:10b6:208:32a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:27 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:07 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 42/80] drm/amd/display: Add subconnector property tests for
 connector
Date: Thu, 9 Jul 2026 16:48:10 -0400
Message-ID: <20260709205936.5719-43-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ab65c4-407f-401b-ae33-08deddfd61ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: bhe3U2nY+Gd7+IE0ppCLi2mi+RZTzfD0DpKxpFu51gPM/dCzaWb8yagrL/hm3nEMHnRUhCOFeCQ9VxJZuTA9O5e3JYZ3vkfL+PATNJcWkF3zaKksalOq1ooVPmhIHnv7CnoGLEE+vv1Fsc1nN7MRJ9x6bo0ID4EmiTw2Jy9uvp4gokFEmjj81M8QRsSy4deKDOx2Ji3g4AqTjlISAulNDt0pb6m4kH8fbSeSlESvTWqDKAh3c5s8pEj16OqA/VnSFD671aNM4ZIcxe6Y43Vl8En+NW6nY298eAeJJWmI0eGbkx4ya/9s1Az/Ukry+mSveyZUrriHr7LPQj47KXMSVOouNR/dKiCxhur8xX7eqSsYhGYsvODc4Lm/FlZtgpgr26+wSRLP/G3KgT4v1teSfCy196tm3v683HEpFfXtYHhTpoYdS6kvLWYEYw+luA3g/yhjmFkL/CvKrMsFW7ZqkN56Kk2ae0c7AQKeRkOJE20gywltG7W3/bblNPOX8VevnyajuM9giqwVHnPq9rEmEZCUag3iZwsO74X4AmZJoWvJ3i6LR7Bbsm3Yi+kxQ0vuN+T7WBFyKhwFhOvIght0GZmfZ/WYtsXpemtee57GkJM7n13afJ1I38qgpZFVhtlsCnjGlE5/Iq8JGnNijRerv6wQQxmsXTScr/bK8NghseBIiuGDaZtqJbYRcVY1ms0cSPWse6OlrA1Q+cJygwl9/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bQhnvHuwk9MYmTisOrvuRLx6h1IBig7gu3cS/Gh4ZVOFj+GHAT5bkjJcZMBuEG6anrspbs3y4EG4kSMmdEjF6Jy3E9xTR9z1+1ORCBDgHPPdOeQ/Zpf1tYcJf+JsWTlmNtV6oFYaz72P9TjJHff0g3ep9FixX8u226H29TYf5a7q3ApBsvJ13/GAGS73/JDwDQ7Lm73DVP0qULKp59tYWA4AY6iMYb0grXmkHblIhM49sM4yEbH2I2093gc4m5MbfumRT5wnjx8jLT64QGrf0emUulNKvt2Eld/8uL2QQuN0gG9Nvk1x7q52RsCnsaktUv46MqrgibFDqFR8Gtx2fAs5IGWm4UqYsuMdsVGz0ADwaCHG9W9rs3IG1qP5z4iIuo2ggHbceykAsR4PQ7AiZJ0QNg4FJ6VaM6Zo4V8vBD9APCXdftEAhxr5GkLutcVz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:27.2397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ab65c4-407f-401b-ae33-08deddfd61ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868
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

Add KUnit coverage for update_subconnector_property() on the
amdgpu_dm_connector suite:

- DP connector with a sink: subconnector property is resolved from
  the dongle type (VGA converter -> VGA).
- DP connector without a sink: dongle type is ignored and the
  property stays Unknown.
- Non-DP connector: function early-returns and leaves a pre-seeded
  property value untouched.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 142 ++++++++++++++++++
 3 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 96f7bf446570..4ae58d5c5264 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -235,7 +235,7 @@ STATIC_IFN_KUNIT enum drm_mode_subconnector get_subconnector_type(struct dc_link
 }
 EXPORT_IF_KUNIT(get_subconnector_type);
 
-static void update_subconnector_property(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_link *link = aconnector->dc_link;
 	struct drm_connector *connector = &aconnector->base;
@@ -251,6 +251,7 @@ static void update_subconnector_property(struct amdgpu_dm_connector *aconnector)
 			connector->dev->mode_config.dp_subconnector_property,
 			subconnector);
 }
+EXPORT_IF_KUNIT(update_subconnector_property);
 
 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index e9ee4a4ad30e..10fe0bf48c02 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -147,6 +147,7 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 enum drm_mode_subconnector get_subconnector_type(struct dc_link *link);
+void update_subconnector_property(struct amdgpu_dm_connector *aconnector);
 enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state);
 bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 91f9543dd7bb..782a22e4f074 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -2527,6 +2527,144 @@ static void dm_test_set_panel_type_defaults_to_lcd(struct kunit *test)
 			(int)PANEL_TYPE_LCD);
 }
 
+/* Tests for update_subconnector_property() */
+
+/**
+ * dm_test_update_subconnector_dp_with_sink - Test subconnector property is set
+ * from the dongle type for a DisplayPort connector with a sink
+ * @test: The KUnit test context
+ */
+static void dm_test_update_subconnector_dp_with_sink(struct kunit *test)
+{
+	struct device *dev;
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	uint64_t val = 0;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*drm), 0,
+						   DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	drmm_connector_init(drm, &aconnector->base, &dm_test_connector_funcs,
+			    DRM_MODE_CONNECTOR_DisplayPort, NULL);
+	drm_connector_attach_dp_subconnector_property(&aconnector->base);
+
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_VGA_CONVERTER;
+	aconnector->dc_link = link;
+	/* Any non-NULL sink enables dongle-type resolution */
+	aconnector->dc_sink = kunit_kzalloc(test, sizeof(*aconnector->dc_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
+
+	update_subconnector_property(aconnector);
+
+	KUNIT_EXPECT_EQ(test, drm_object_property_get_value(&aconnector->base.base,
+				aconnector->base.dev->mode_config.dp_subconnector_property,
+				&val), 0);
+	KUNIT_EXPECT_EQ(test, (int)val, (int)DRM_MODE_SUBCONNECTOR_VGA);
+}
+
+/**
+ * dm_test_update_subconnector_dp_no_sink - Test subconnector property stays
+ * unknown for a DisplayPort connector without a sink
+ * @test: The KUnit test context
+ */
+static void dm_test_update_subconnector_dp_no_sink(struct kunit *test)
+{
+	struct device *dev;
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	uint64_t val = 0;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*drm), 0,
+						   DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	drmm_connector_init(drm, &aconnector->base, &dm_test_connector_funcs,
+			    DRM_MODE_CONNECTOR_DisplayPort, NULL);
+	drm_connector_attach_dp_subconnector_property(&aconnector->base);
+
+	/* Dongle type is set, but no sink means it must not be consulted */
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+	aconnector->dc_link = link;
+	aconnector->dc_sink = NULL;
+
+	update_subconnector_property(aconnector);
+
+	KUNIT_EXPECT_EQ(test, drm_object_property_get_value(&aconnector->base.base,
+				aconnector->base.dev->mode_config.dp_subconnector_property,
+				&val), 0);
+	KUNIT_EXPECT_EQ(test, (int)val, (int)DRM_MODE_SUBCONNECTOR_Unknown);
+}
+
+/**
+ * dm_test_update_subconnector_non_dp_noop - Test non-DisplayPort connector is
+ * left untouched (early return)
+ * @test: The KUnit test context
+ */
+static void dm_test_update_subconnector_non_dp_noop(struct kunit *test)
+{
+	struct device *dev;
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	uint64_t val = 0;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*drm), 0,
+						   DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	drmm_connector_init(drm, &aconnector->base, &dm_test_connector_funcs,
+			    DRM_MODE_CONNECTOR_HDMIA, NULL);
+	drm_connector_attach_dp_subconnector_property(&aconnector->base);
+
+	/* Pre-seed the property to a non-default value */
+	drm_object_property_set_value(&aconnector->base.base,
+			aconnector->base.dev->mode_config.dp_subconnector_property,
+			DRM_MODE_SUBCONNECTOR_VGA);
+
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+	aconnector->dc_link = link;
+	aconnector->dc_sink = kunit_kzalloc(test, sizeof(*aconnector->dc_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
+
+	update_subconnector_property(aconnector);
+
+	/* Non-DP connector: value must remain what we seeded */
+	KUNIT_EXPECT_EQ(test, drm_object_property_get_value(&aconnector->base.base,
+				aconnector->base.dev->mode_config.dp_subconnector_property,
+				&val), 0);
+	KUNIT_EXPECT_EQ(test, (int)val, (int)DRM_MODE_SUBCONNECTOR_VGA);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -2664,6 +2802,10 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_is_freesync_video_mode_null_mode),
 	KUNIT_CASE(dm_test_is_freesync_video_mode_match),
 	KUNIT_CASE(dm_test_is_freesync_video_mode_no_match),
+	/* update_subconnector_property */
+	KUNIT_CASE(dm_test_update_subconnector_dp_with_sink),
+	KUNIT_CASE(dm_test_update_subconnector_dp_no_sink),
+	KUNIT_CASE(dm_test_update_subconnector_non_dp_noop),
 	/* amdgpu_dm_update_cacp_caps */
 	KUNIT_CASE(dm_test_cacp_caps_unsupported_ip),
 	KUNIT_CASE(dm_test_cacp_caps_excluded_ip_316),
-- 
2.55.0

