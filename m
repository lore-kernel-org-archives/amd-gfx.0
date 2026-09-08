Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3FDC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9672410EB2A;
	Tue,  8 Sep 2026 11:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NCnsf8TD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA3F10EB2A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZvFiYe2OgSOGFlxbyQgS9dBA/I70Rwn+Rj4WnYxw5FOpkYMObKlVScN2KEn6iwFzXVJ9TazAHNe1kpPQn23iQqUlaO3PtEqFMesgGCs39G8u8zJN/L54HiSs+FCcmrj+lCGcSPGV7CR52nAH5FOhYRU/PA9CAfVCyOIO1oWU72Ej+eze+5ywxxWtnGluhxji9fy2iZFIwEIU+lD6Gr1t9zoPdNltPQIRsJdwUK/r6NBg1y0L32XBl3Gx69KgkGbs/IwASHapiyUTo1ju3E+Kj8463exJhnJnlOqGPDM329TT/UJXk9g0KU++TM9a+R4tX3Lyi6IIucW8opliC2H6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNJK2ZJ9LVYLm0cpWL0SRKBDgEpv7Q3PtN3DoljGbBc=;
 b=Qvst84PWh4P5pt5tPrNEYVMuHDCzaiT8EsDLgWdMrUuoUHRN0Z79EJkUhK2Zh0yylJ6JWvjNX4Fuw/oziDIuyjaj8HW9ynGHf6O6GKdtkgxBQKT8CYrbwwO8gVOTz6Op7N4k/7tPjAeuEl/9pdjAhCIe/jHF7QE8/UdGd0O5lrVIr/+CuJXhjQODY1tvDY/QvQdYniIHWbBIZs64GblZiGPdu4+8sc5MmzlpRbU/qCZwMA5I+2JOF1xHe6g4lCoTBq/b0QaWe4OrcXogmFtS2EarpCMyVH5MOL0cRoS4NcvtcKLhENduN5ED6K7RB7il7zWZRMfduZ48h3WgoAJkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNJK2ZJ9LVYLm0cpWL0SRKBDgEpv7Q3PtN3DoljGbBc=;
 b=NCnsf8TDymEuEjJMdgBG5trKElEu8EwYfY9c0RYr/X2/xaoZW9xvl38rrt+/PHDdSHBOn1Y1nvDwaW6QUOCXjic7EaPNhW5cdoO5FQE3Y2vpVM75wqhP5koUV8ENIWWozVk0OdvV1fbOMC+xZGHyR2sSI0pdqnmbQx0jayZzpjw=
Received: from BL1PR13CA0214.namprd13.prod.outlook.com (2603:10b6:208:2bf::9)
 by DSVPR12MB073533.namprd12.prod.outlook.com (2603:10b6:8:3ea::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:34:42 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a9) by BL1PR13CA0214.outlook.office365.com
 (2603:10b6:208:2bf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:34:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:34:39 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:34:31 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 06/66] drm/amd/display: Test connector init helper
Date: Tue, 8 Sep 2026 19:30:59 +0800
Message-ID: <20260908113338.2433445-7-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|DSVPR12MB073533:EE_
X-MS-Office365-Filtering-Correlation-Id: ae77ed65-7d1b-486d-dda6-08df0d9d2cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Df+/sqcibdunI23BRNzh7K6n2i1EEke2wd86vyCIzNe68/GtHeuxLKQoTlSl8lFxM0jIyG229RqfYVWEQyRcehxOA9YU3t66zNo9rLKsFuk0h20UD47xSul75llnid7WcDaSU3gK1Ga0UaEhZCHzjxj8HLYELVSJUOCeExpJF5DocnRWbxvHcO5yffGZyNoWE6dVs27fFftDvcJ4Wvlba64MZ/t/TIUw1iS2uzo58wsxPbFcrdgwXL2SNjQWNkebvFhL8raeVU7V37cOBRwgC5UENuS3LyT502kZD9NnKipROJ5JCi2yfkca7vkHyfBWLRJ7kuC03sRWJblcYIg3NwnH4vluOg2X06VuQ/oYNCia8TdEWRYfOCnBBBWWXYtqH1Ir+N2IOQQR250Wr4J7x91keDfrhv+ZtJ7f2HKy6qNQydtVumyxWIbzGlOP2xMUGYYFNIOksoJdDrvX5xe12D8p2QBannjBQ62LGxXzNPGAmMbXxdo5pXvrX8SbcYJYDb6o/QZEjfr6/30FnOJ3t6XoR0e4jwMogRizAE89vkBhqhTqZanQfGJajD0PhgUZnr5w3ENvl0P+qTftu3/VwZwEUew8EzcfWWLUL2DgMQiLXAoMtTB7Y2UBwopi4fYyqYfhStRDbQ/n63aTgdNKkGvX+0xyXbi0RAsuHGw4rkB6NILCzCIaxoVWpehm5wUGZ7Ne0Tay3rRmpWLTAD14Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: weczWiS0O3kEbbkmQ2SWr4ahWHSzDqAkooBNTRJdqXgKjuQHFrzD/gsIw/u9ftxjaxH7nmGx8zWZz4gA8cJCxsGEvFHicyHPXSdQHSJRg5XqMufs2rC3UK64Fsx7NeeUEdML15WkqaW8FHnFtskiPSR73HEPtcrP/cNZF+bfRm+V+p+svstq9Cv/GtP0T8/8uxp2ZKRmM8UJxXqVo/M1P71Kvly5oLukfhEftb7SkzqS8ESOBI6czcuZJZUEls5upUp19Pqg1VpZsbLGdKzp4HfVKSc8XF4SdVgSfyVOwWpGCKVhQ7DAr7PUmebbvBo0aIbRDAPnD3kPwBRuGQ2YntajM6mlw8ObMkEx9cBYSP6UKzCUwghy2L9aTd5dBjrVE8vNWyxsy6E0d35BxK6eaBaO2oL6cbWgzRqPmWlX7rh1NciCfW+Vsw4hs1BQ2Cct
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:34:42.0842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae77ed65-7d1b-486d-dda6-08df0d9d2cb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB073533
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
Add KUnit tests for amdgpu_dm_connector_init_helper() covering the
common connector defaults and attached properties, the HDMI,
DisplayPort, DVI-D, VGA, eDP and unhandled connector types, an MST
branch connector that skips the root-only properties, the content
protection property and the default HPD debounce delay.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 355 ++++++++++++++++++
 2 files changed, 356 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index fa462ee0b053..a80d5426bd9f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3263,6 +3263,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		}
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_init_helper);
 
 STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 			      struct i2c_msg *msgs, int num)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 4c965a6496f8..2fe55f07e464 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -27,6 +27,7 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_connector.h"
 #include "amdgpu_dm_backlight.h"
+#include "amdgpu_dm_hdcp.h"
 #include "amdgpu_dm_psr.h"
 #include "include/grph_object_id.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
@@ -9078,6 +9079,349 @@ static void dm_test_frl_poll_retrains(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_test_frl_detect_calls, 1);
 }
 
+/* Tests for amdgpu_dm_connector_init_helper() */
+
+/*
+ * Build an amdgpu_dm_connector on a kunit drm_device embedded in an
+ * amdgpu_device, with the amdgpu mode properties created exactly as
+ * amdgpu_dm_mode_config_init() does so the helper has real properties to
+ * attach. The dc_link carries a link encoder and leaves DIG mapping
+ * inflexible, so link_enc_cfg_get_link_enc() resolves without a dc instance.
+ */
+struct dm_test_init_helper_ctx {
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct amdgpu_display_manager *dm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+};
+
+/*
+ * Stand in for amdgpu_display_modeset_create_props(), which the test module
+ * cannot link against. Only the properties the init helper attaches are
+ * created; underscan is a plain range because only attachment is under test.
+ */
+static void dm_test_create_mode_props(struct kunit *test, struct amdgpu_device *adev)
+{
+	struct amdgpu_mode_info *mode_info = &adev->mode_info;
+	struct drm_device *drm = adev_to_drm(adev);
+
+	KUNIT_ASSERT_EQ(test, drm_mode_create_scaling_mode_property(drm), 0);
+
+	mode_info->underscan_property =
+		drm_property_create_range(drm, 0, "underscan", 0, 1);
+	KUNIT_ASSERT_NOT_NULL(test, mode_info->underscan_property);
+	mode_info->underscan_hborder_property =
+		drm_property_create_range(drm, 0, "underscan hborder", 0, 128);
+	KUNIT_ASSERT_NOT_NULL(test, mode_info->underscan_hborder_property);
+	mode_info->underscan_vborder_property =
+		drm_property_create_range(drm, 0, "underscan vborder", 0, 128);
+	KUNIT_ASSERT_NOT_NULL(test, mode_info->underscan_vborder_property);
+}
+
+static struct dm_test_init_helper_ctx *
+dm_test_init_helper_ctx_alloc(struct kunit *test, int connector_type)
+{
+	struct dm_test_init_helper_ctx *ctx;
+	struct device *dev;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	ctx->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						       sizeof(struct amdgpu_device),
+						       offsetof(struct amdgpu_device, ddev),
+						       DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
+
+	ctx->adev = drm_to_adev(ctx->drm);
+	ctx->adev->dev = dev;
+	dm_test_create_mode_props(test, ctx->adev);
+
+	ctx->dm = &ctx->adev->dm;
+	ctx->dm->adev = ctx->adev;
+	ctx->dm->ddev = ctx->drm;
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	ctx->link->link_enc = kunit_kzalloc(test, sizeof(*ctx->link->link_enc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link->link_enc);
+	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	KUNIT_ASSERT_EQ(test,
+			drmm_connector_init(ctx->drm, &ctx->aconnector->base,
+					    &dm_test_connector_funcs, connector_type,
+					    NULL), 0);
+
+	return ctx;
+}
+
+/* True when @prop is attached to the connector's mode object. */
+static bool dm_test_has_prop(struct drm_connector *connector, struct drm_property *prop)
+{
+	struct drm_object_properties *props = connector->base.properties;
+	int i;
+
+	if (!prop)
+		return false;
+
+	for (i = 0; i < props->count; i++)
+		if (props->properties[i] == prop)
+			return true;
+
+	return false;
+}
+
+/**
+ * dm_test_init_helper_common_defaults - Test the connector defaults and properties
+ * @test: The KUnit test context
+ *
+ * The helper resets the connector state, records the link and its index, and
+ * attaches the scaling mode and the three underscan properties that every
+ * connector type receives.
+ */
+static void dm_test_init_helper_common_defaults(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct drm_connector *connector = &ctx->aconnector->base;
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_HDMIA, ctx->link, 3);
+
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->connector_id, 3);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->bl_idx, -1);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_link, ctx->link);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->audio_inst, -1);
+	KUNIT_EXPECT_FALSE(test, ctx->aconnector->pack_sdp_v1_3);
+	KUNIT_EXPECT_EQ(test, (int)ctx->aconnector->as_type, (int)ADAPTIVE_SYNC_TYPE_NONE);
+	KUNIT_EXPECT_FALSE(test, connector->interlace_allowed);
+	KUNIT_EXPECT_FALSE(test, connector->doublescan_allowed);
+	KUNIT_EXPECT_FALSE(test, connector->stereo_allowed);
+	KUNIT_EXPECT_EQ(test, connector->dpms, DRM_MODE_DPMS_OFF);
+	KUNIT_EXPECT_EQ(test, (int)ctx->aconnector->hpd.hpd, (int)AMDGPU_HPD_NONE);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->hdmi_hpd_debounce_delay_ms, 0);
+
+	/* The link encoder advertises no YCbCr 4:2:0 support. */
+	KUNIT_EXPECT_FALSE(test, connector->ycbcr_420_allowed);
+
+	KUNIT_EXPECT_TRUE(test,
+			  dm_test_has_prop(connector, ctx->drm->mode_config.scaling_mode_property));
+	KUNIT_EXPECT_TRUE(test,
+			  dm_test_has_prop(connector, ctx->adev->mode_info.underscan_property));
+	KUNIT_EXPECT_TRUE(test,
+			  dm_test_has_prop(connector,
+					   ctx->adev->mode_info.underscan_hborder_property));
+	KUNIT_EXPECT_TRUE(test,
+			  dm_test_has_prop(connector,
+					   ctx->adev->mode_info.underscan_vborder_property));
+}
+
+/**
+ * dm_test_init_helper_hdmi - Test the HDMI connector wiring
+ * @test: The KUnit test context
+ *
+ * HDMI polls on hotplug, takes YCbCr 4:2:0 support straight from the link
+ * encoder features and gets the max bpc, content type, colorspace, HDR
+ * metadata and VRR capable properties.
+ */
+static void dm_test_init_helper_hdmi(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct drm_connector *connector = &ctx->aconnector->base;
+
+	ctx->link->link_enc->features.hdmi_ycbcr420_supported = true;
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_HDMIA, ctx->link, 0);
+
+	KUNIT_EXPECT_EQ(test, (int)connector->polled, (int)DRM_CONNECTOR_POLL_HPD);
+	KUNIT_EXPECT_TRUE(test, connector->ycbcr_420_allowed);
+	KUNIT_ASSERT_NOT_NULL(test, connector->state);
+	KUNIT_EXPECT_EQ(test, connector->state->max_bpc, 16);
+	KUNIT_EXPECT_EQ(test, connector->state->max_requested_bpc, 16);
+	KUNIT_EXPECT_NOT_NULL(test, connector->max_bpc_property);
+	KUNIT_EXPECT_NOT_NULL(test, connector->broadcast_rgb_property);
+	KUNIT_EXPECT_NOT_NULL(test, connector->colorspace_property);
+	KUNIT_EXPECT_NOT_NULL(test, connector->vrr_capable_property);
+	KUNIT_EXPECT_TRUE(test,
+			  dm_test_has_prop(connector, ctx->drm->mode_config.content_type_property));
+	KUNIT_EXPECT_TRUE(test,
+			  dm_test_has_prop(connector,
+					   ctx->drm->mode_config.hdr_output_metadata_property));
+}
+
+/**
+ * dm_test_init_helper_dp - Test the DisplayPort connector wiring
+ * @test: The KUnit test context
+ *
+ * DisplayPort re-resolves the link encoder through the encoder configuration
+ * and takes YCbCr 4:2:0 support from its DP feature bit.
+ */
+static void dm_test_init_helper_dp(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct drm_connector *connector = &ctx->aconnector->base;
+
+	ctx->link->link_enc->features.dp_ycbcr420_supported = true;
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_DisplayPort, ctx->link, 1);
+
+	KUNIT_EXPECT_EQ(test, (int)connector->polled, (int)DRM_CONNECTOR_POLL_HPD);
+	KUNIT_EXPECT_TRUE(test, connector->ycbcr_420_allowed);
+	KUNIT_EXPECT_NOT_NULL(test, connector->broadcast_rgb_property);
+	KUNIT_EXPECT_NOT_NULL(test, connector->colorspace_property);
+	KUNIT_EXPECT_NOT_NULL(test, connector->vrr_capable_property);
+}
+
+/**
+ * dm_test_init_helper_dp_mst_root - Test an MST branch connector skips properties
+ * @test: The KUnit test context
+ *
+ * A connector below an MST root gets neither the broadcast RGB, max bpc,
+ * colorspace nor VRR capable property, because those live on the root.
+ */
+static void dm_test_init_helper_dp_mst_root(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct drm_connector *connector = &ctx->aconnector->base;
+
+	ctx->aconnector->mst_root = ctx->aconnector;
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_DisplayPort, ctx->link, 0);
+
+	KUNIT_EXPECT_NULL(test, connector->broadcast_rgb_property);
+	KUNIT_EXPECT_NULL(test, connector->max_bpc_property);
+	KUNIT_EXPECT_NULL(test, connector->colorspace_property);
+	KUNIT_EXPECT_NULL(test, connector->vrr_capable_property);
+}
+
+/**
+ * dm_test_init_helper_dvid - Test DVI-D polls on hotplug
+ * @test: The KUnit test context
+ */
+static void dm_test_init_helper_dvid(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_DVID);
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_DVID, ctx->link, 0);
+
+	KUNIT_EXPECT_EQ(test, (int)ctx->aconnector->base.polled, (int)DRM_CONNECTOR_POLL_HPD);
+	KUNIT_EXPECT_FALSE(test, ctx->aconnector->base.ycbcr_420_allowed);
+}
+
+/**
+ * dm_test_init_helper_vga - Test VGA polls on connect and disconnect
+ * @test: The KUnit test context
+ */
+static void dm_test_init_helper_vga(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_VGA);
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_VGA, ctx->link, 0);
+
+	KUNIT_EXPECT_EQ(test, (int)ctx->aconnector->base.polled,
+			(int)(DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT));
+}
+
+/**
+ * dm_test_init_helper_unpolled_default - Test an unhandled type is left unpolled
+ * @test: The KUnit test context
+ */
+static void dm_test_init_helper_unpolled_default(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_Composite);
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_Composite, ctx->link, 0);
+
+	KUNIT_EXPECT_EQ(test, (int)ctx->aconnector->base.polled, 0);
+	KUNIT_EXPECT_NULL(test, ctx->aconnector->base.colorspace_property);
+	KUNIT_EXPECT_NULL(test, ctx->aconnector->base.vrr_capable_property);
+}
+
+/**
+ * dm_test_init_helper_edp - Test eDP gets the panel type property
+ * @test: The KUnit test context
+ *
+ * eDP shares the DisplayPort colorspace and HDR property set and additionally
+ * receives the panel type property. No privacy screen provider is registered
+ * in the test environment, so the lookup fails with -ENODEV and is ignored.
+ */
+static void dm_test_init_helper_edp(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_eDP);
+	struct drm_connector *connector = &ctx->aconnector->base;
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_eDP, ctx->link, 0);
+
+	KUNIT_EXPECT_EQ(test, (int)connector->polled, 0);
+	KUNIT_EXPECT_NOT_NULL(test, connector->colorspace_property);
+	KUNIT_EXPECT_NOT_NULL(test, connector->vrr_capable_property);
+	KUNIT_EXPECT_TRUE(test,
+			  dm_test_has_prop(connector, ctx->drm->mode_config.panel_type_property));
+	KUNIT_EXPECT_NULL(test, connector->privacy_screen);
+}
+
+/**
+ * dm_test_init_helper_hdcp_property - Test the content protection property
+ * @test: The KUnit test context
+ *
+ * The content protection property is only attached when a HDCP workqueue was
+ * created for the device.
+ */
+static void dm_test_init_helper_hdcp_property(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct drm_connector *connector = &ctx->aconnector->base;
+
+	ctx->adev->dm.hdcp_workqueue = kunit_kzalloc(test, sizeof(struct hdcp_workqueue),
+						     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->adev->dm.hdcp_workqueue);
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_HDMIA, ctx->link, 0);
+
+	KUNIT_EXPECT_TRUE(test,
+			  dm_test_has_prop(connector,
+					   ctx->drm->mode_config.content_protection_property));
+}
+
+/**
+ * dm_test_init_helper_hpd_debounce_disabled - Test the default HPD debounce delay
+ * @test: The KUnit test context
+ *
+ * With the hdmi_hpd_debounce_delay_ms module parameter left at its default the
+ * debounce work is not armed and the delay stays zero.
+ */
+static void dm_test_init_helper_hpd_debounce_disabled(struct kunit *test)
+{
+	struct dm_test_init_helper_ctx *ctx =
+		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+
+	amdgpu_dm_connector_init_helper(ctx->dm, ctx->aconnector,
+					DRM_MODE_CONNECTOR_HDMIA, ctx->link, 0);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->hdmi_hpd_debounce_delay_ms, 0);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -9475,6 +9819,17 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_frl_skips_zero_rate),
 	KUNIT_CASE(dm_test_frl_poll_no_update),
 	KUNIT_CASE(dm_test_frl_poll_retrains),
+	/* amdgpu_dm_connector_init_helper */
+	KUNIT_CASE(dm_test_init_helper_common_defaults),
+	KUNIT_CASE(dm_test_init_helper_hdmi),
+	KUNIT_CASE(dm_test_init_helper_dp),
+	KUNIT_CASE(dm_test_init_helper_dp_mst_root),
+	KUNIT_CASE(dm_test_init_helper_dvid),
+	KUNIT_CASE(dm_test_init_helper_vga),
+	KUNIT_CASE(dm_test_init_helper_unpolled_default),
+	KUNIT_CASE(dm_test_init_helper_edp),
+	KUNIT_CASE(dm_test_init_helper_hdcp_property),
+	KUNIT_CASE(dm_test_init_helper_hpd_debounce_disabled),
 	{}
 };
 
-- 
2.43.0

