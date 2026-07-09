Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10B2C4450A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B36010F6F6;
	Thu,  9 Jul 2026 21:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UL1b0gM2";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9053310F6F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4LiGwgz5YKfLNASlyyFwtRoT3/2ttvHvjpqfk33QMel+OrPN9HBgg6bFQ/NU2K6C6k+gmvnYSVJiAiTG+L2uk5EDwj0sa8FTDwLgUhEjjyK4l43m/foNqimZXeehiK6tJHQ0AlbsZtY7IiIxW58JdRzIgwIrleHagTihKvkuIOv4M/OHLnxbcyIMCcpEC+3g67Ck8G8etQgUqiEzqIsvOaSHYWWYS1Ma8/YawCp1WwjFbkaq3lubYhtkwAXlX1ZqYDbMdfk2Uyp63JpL4F4UNdDP17gmO8hsDj7T4D8U8l+66kCjRZngb874s9YPn8/q+ehoUC7ulJIUf4o70OBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U7wF9iP04O63ZLlfc9IPztfK0tq6ZGmTGcYN8a56ew=;
 b=VXJjmEio6DsKNLpGrGtXQEeR6o8NK3mFw3erqDtEBr2TU61BUeHw/WXhiwZKVjFDUR9ZLBUrxproNhV64m1jwO6slKSheZYilc4BYnRFKgWBuMEGKVcWRXVm7orM5Rbm/OBggFu7c6qf7LD/FY1cKi3xRKacOG6opF2nvu7/Npg3PSNmVJIaMbryp4BQd6RkeE3Z1FAzHheEbHrQLbBlGw2Mf+eQ/dMfGEZxx08BJHbfJ1ly9B+Es620qKhTk/zuUQcsN5C+JW2A15h9RCiHW7fvJgr/TZZip5SSFUihBAaTIPbi2aqlD4o6ThIEYe5oDc7M3O1vuE4+GNdFBvKLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U7wF9iP04O63ZLlfc9IPztfK0tq6ZGmTGcYN8a56ew=;
 b=UL1b0gM29NhZDgzrduIDPh/PP2iS/XBpmnSJxUkcle/+CYgHGZeXdNnNJtZ/kQT9Bapm7rW3sDyQ6stppFQPN/FAbr2M9jTUcLuQF2/6bp/9cb1JDHz+u+7G1RpwQJ066pr8rGpYB9jADAef6SjtBiw0UCnbiBNjJA8NYnN+ljM=
Received: from MN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:208:52d::13)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:38 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::6c) by MN0PR04CA0002.outlook.office365.com
 (2603:10b6:208:52d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:37 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:30 -0500
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
Subject: [PATCH 71/80] drm/amd/display: Add CACP caps tests for connector
Date: Thu, 9 Jul 2026 16:48:39 -0400
Message-ID: <20260709205936.5719-72-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a9ff6d-3b9e-441c-ed0a-08deddfd6829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|6133799003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: bJu2WJgTqbvXPShVsRivYaJJoyQMA/UijyL0lCemasgRuVPaEJcdXsCwkQ16YFpzetP/ms2H8YDLWX7Q+ipCwbDfGXYQ0NiZ9ck4n96Lhguam6hhChCDHdz1UPHK0jJaz6j5brznKzMcTuwF/Gw/35E0VofnUNEwesfydMGmfiJ6RngX19iuOiwzZwLGzoDh6pgxTNKFCQ8igGyN3TnMy5ik/zqKI7YoAmAF4KsfM8QfSFtyieGSjRSAoiNK45355FRj3e2NTr1VKb1O+agVbY/IOE2Lz/oxqGiddpTubdTAHBI8t0W4DWMy7+U4UmOlt4e+bnPJCWVTkKu+oZ2ussasXg+8cQEb6TYGcwoEF/fXsCghiklL878p5I73lvcKOGBpq1b67umgLBVqzEK0RihTU46eeO7ZrYGSjmPEoOz1qlx1P5d9IpuRNolu1cHjyP3gHlUS6L7GRH0NwL+JNKDNGq0x+MXeXAjSOOGsluYWbW0fCBMj03tjHVacOh2Dc5PhF0TkaR+ebOFNxe/HSvzpv61vwemNkxKmz6LBH6ofufT7uLmNluEdTkM41/m/EmlILLFwbJ40bclvFQFOwwfMaiD5cUqZddBkPSDAwek9+MvjksJ/Ff4uPndZr3zS1dXNgWe9xMFXM+zsXvr/YbyDmmKgTDxs1Zstttsz1AW2Kkcr1TqsXT6ZeCljsMY8m6H8lUleR7Ek23B15tMGlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yqrZdH++1EykvcK/BOUvTWI669Jt3ZLCaorW3eEBEKft/ZOxJOJkqyGqYgLwHno+LmQsCQ1L+3FzNPKOCdiAwTSdA4+2BgC2qAEqHPqM1xVRQtKbpQLxOjRgZ+tE7QwNzIYbsl14I1hFhVgip/GDx5h/HLETVO4SSgMdQuHey7MZiSvMI0DuKF8N6NRD8jfZAVS7avxUSU315pHnmtqUnFUOMzCbbjO4I78y3y0IOPyFyNqCFP9qvREHR83uGWp3ZKcvQ1D9fP6hGTfBCRX+uYVBSWHTEwfUID6ouhX6Rfb0aWxLMplczEppZnrBbUlHKR6dj/oouyRhE6mshnS6BBUVL63wRwkxEfbi+zXkqQtawfdmeooqjb0xHxPleQN88xDQ4csucSDvqxZ9Oma2oC+3htkFNeeiSf4wpinfaSWSSR23hRiH+ZoyIVixH2Xl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:37.6877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a9ff6d-3b9e-441c-ed0a-08deddfd6829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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

Add KUnit coverage for amdgpu_dm_update_cacp_caps(): eDP and LVDS
supported, old/3.1.6 IP versions unsupported, non-eDP/LVDS and LCD
panels unsupported.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 149 ++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 99b5f20699b4..b85083926188 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -150,6 +150,7 @@ enum drm_mode_subconnector get_subconnector_type(struct dc_link *link);
 void update_subconnector_property(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_fbc_init(struct drm_connector *connector);
 void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector);
+void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector);
 enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state);
 bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 6639962dd289..8f3460dcf2f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -3199,6 +3199,148 @@ static void dm_test_set_panel_type_default_lcd(struct kunit *test)
 			(uint64_t)DRM_MODE_PANEL_TYPE_LCD);
 }
 
+/* Tests for amdgpu_dm_update_cacp_caps() */
+
+/*
+ * Build an amdgpu_dm_connector wired to a real kunit drm_device embedded in an
+ * amdgpu_device, so drm_to_adev() resolves and drm_dbg_kms() has a valid
+ * device. Defaults are seeded to the fully-supported configuration so each
+ * test only flips a single knob.
+ */
+struct dm_test_cacp_ctx {
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+};
+
+static struct dm_test_cacp_ctx *dm_test_cacp_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_cacp_ctx *ctx;
+	struct drm_device *drm;
+	struct device *dev;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						  sizeof(*ctx->adev),
+						  offsetof(struct amdgpu_device, ddev),
+						  DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	ctx->adev = drm_to_adev(drm);
+
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	ctx->aconnector->base.dev = drm;
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	ctx->aconnector->dc_link = ctx->link;
+
+	/* Fully-supported defaults: new enough DCE, eDP, non-LCD panel. */
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 4);
+	ctx->link->connector_signal = SIGNAL_TYPE_EDP;
+	ctx->link->panel_type = PANEL_TYPE_OLED;
+
+	return ctx;
+}
+
+/**
+ * dm_test_cacp_caps_edp_supported - Test CACP supported on a new eDP panel
+ * @test: The KUnit test context
+ */
+static void dm_test_cacp_caps_edp_supported(struct kunit *test)
+{
+	struct dm_test_cacp_ctx *ctx = dm_test_cacp_ctx_alloc(test);
+
+	amdgpu_dm_update_cacp_caps(ctx->aconnector);
+
+	KUNIT_EXPECT_TRUE(test, ctx->link->panel_config.cacp.cacp_supported);
+}
+
+/**
+ * dm_test_cacp_caps_lvds_supported - Test CACP supported on an LVDS panel
+ * @test: The KUnit test context
+ */
+static void dm_test_cacp_caps_lvds_supported(struct kunit *test)
+{
+	struct dm_test_cacp_ctx *ctx = dm_test_cacp_ctx_alloc(test);
+
+	ctx->link->connector_signal = SIGNAL_TYPE_LVDS;
+
+	amdgpu_dm_update_cacp_caps(ctx->aconnector);
+
+	KUNIT_EXPECT_TRUE(test, ctx->link->panel_config.cacp.cacp_supported);
+}
+
+/**
+ * dm_test_cacp_caps_old_ip_unsupported - Test CACP unsupported on old DCE
+ * @test: The KUnit test context
+ *
+ * DCE versions older than 3.1.4 do not support CACP.
+ */
+static void dm_test_cacp_caps_old_ip_unsupported(struct kunit *test)
+{
+	struct dm_test_cacp_ctx *ctx = dm_test_cacp_ctx_alloc(test);
+
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 3);
+
+	amdgpu_dm_update_cacp_caps(ctx->aconnector);
+
+	KUNIT_EXPECT_FALSE(test, ctx->link->panel_config.cacp.cacp_supported);
+}
+
+/**
+ * dm_test_cacp_caps_ip_3_1_6_unsupported - Test CACP unsupported on DCE 3.1.6
+ * @test: The KUnit test context
+ *
+ * DCE 3.1.6 is explicitly excluded even though it is newer than 3.1.4.
+ */
+static void dm_test_cacp_caps_ip_3_1_6_unsupported(struct kunit *test)
+{
+	struct dm_test_cacp_ctx *ctx = dm_test_cacp_ctx_alloc(test);
+
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 6);
+
+	amdgpu_dm_update_cacp_caps(ctx->aconnector);
+
+	KUNIT_EXPECT_FALSE(test, ctx->link->panel_config.cacp.cacp_supported);
+}
+
+/**
+ * dm_test_cacp_caps_non_edp_lvds_unsupported - Test CACP unsupported on a
+ * non-eDP/LVDS signal
+ * @test: The KUnit test context
+ */
+static void dm_test_cacp_caps_non_edp_lvds_unsupported(struct kunit *test)
+{
+	struct dm_test_cacp_ctx *ctx = dm_test_cacp_ctx_alloc(test);
+
+	ctx->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	amdgpu_dm_update_cacp_caps(ctx->aconnector);
+
+	KUNIT_EXPECT_FALSE(test, ctx->link->panel_config.cacp.cacp_supported);
+}
+
+/**
+ * dm_test_cacp_caps_lcd_unsupported - Test CACP unsupported on an LCD panel
+ * @test: The KUnit test context
+ */
+static void dm_test_cacp_caps_lcd_unsupported(struct kunit *test)
+{
+	struct dm_test_cacp_ctx *ctx = dm_test_cacp_ctx_alloc(test);
+
+	ctx->link->panel_type = PANEL_TYPE_LCD;
+
+	amdgpu_dm_update_cacp_caps(ctx->aconnector);
+
+	KUNIT_EXPECT_FALSE(test, ctx->link->panel_config.cacp.cacp_supported);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -3376,6 +3518,13 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_set_panel_type_samsung_miniled),
 	KUNIT_CASE(dm_test_set_panel_type_samsung_below_threshold),
 	KUNIT_CASE(dm_test_set_panel_type_default_lcd),
+	/* amdgpu_dm_update_cacp_caps */
+	KUNIT_CASE(dm_test_cacp_caps_edp_supported),
+	KUNIT_CASE(dm_test_cacp_caps_lvds_supported),
+	KUNIT_CASE(dm_test_cacp_caps_old_ip_unsupported),
+	KUNIT_CASE(dm_test_cacp_caps_ip_3_1_6_unsupported),
+	KUNIT_CASE(dm_test_cacp_caps_non_edp_lvds_unsupported),
+	KUNIT_CASE(dm_test_cacp_caps_lcd_unsupported),
 	{}
 };
 
-- 
2.55.0

