Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788B2C44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B6510F6D9;
	Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o348n8DH";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C5310F6DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwXRGrQIGThCGR52f/k0aRksp5NS2gHIHclFbXPRIrJTSaHT+pjGGV/eDcjUX/wHriqBAmDVbjLeq3jKMMBWs6OmJob4YCWRK5Dh5XjkNpdCC51F/f3AhEOGaz01fSS/mfJx+Q1BpG2V4/duOSLZQuaCbyd69gs4ee94DPCgOX/968BG6ZuvHkuhH8GGXoELCAA7JGrhEm7wftveVj395+y2MA0Jbyn0DzIhcIEZjy3P0yFVRtx0SZgHC3rrwrB19xbj6cxE8sc6eWstAhUX0cxTgSp/sfCgct60P5jsBrI81q4MogY3C1ub8Mcwo2Vm9RgW7RB7hh2UeIUfchDhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luz6q3Lx/rlAgQdZGleKsGWLEjjLrWa7YQygb5eQ16k=;
 b=kwJfPX0Ja5iJ/mTIPxR+FzTuqXBKrhb1ypcwNJM2aqeJRDaEaRpeCkyB18XQB7bspc+bFjEu1L+ZKzzFgWMdW7nMj0JUPA+46WLWTMOvLbgFUbddHbNIiqN2mrSpWnQNA4gSljai25bBZuUAg+QKa9iJg+q701AtWd+jVKLWPLFmyvud7RLju97cXHDvDddi6xAhGzRmZe9WY/jJPP9yWkXsFl4y57c/2dfdZqXVhzDFAPi9KtLG/J74fVmGAixxpYEucT1RTLtWwbOXyfDn2sq0vN7HtemwiUnixipmkgsxyFZKJp3dmLrz4w5mi0tjlngoPvIYsm/rIsaGnihcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luz6q3Lx/rlAgQdZGleKsGWLEjjLrWa7YQygb5eQ16k=;
 b=o348n8DHwi5LAKoAvlDjBN6kVZpuetdrHbwzrbTksiZw2shPPEc5DFiYKY/t1lRe/SEtsZfNT5jWWyTN0shtNApXC+tkcOJt/AaX84eq9hhB363+Jo9/12PsuMxSCg1hsFPzPyaOW7MNKKF7vAtO8SvxdDrJR2l3d9fai5hrxq4=
Received: from MN0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:208:52d::10)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 21:02:26 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::2b) by MN0PR04CA0017.outlook.office365.com
 (2603:10b6:208:52d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:26 +0000
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
Subject: [PATCH 41/80] drm/amd/display: Add color space and timing tests for
 connector
Date: Thu, 9 Jul 2026 16:48:09 -0400
Message-ID: <20260709205936.5719-42-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0a101c-3475-44cd-c764-08deddfd6173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: daHs34MXThGIp4nZz8Rn4KYC/zhnQKD9lrdQVaw5jsiSUFoNgu0A49ABOGPeITzQG3qqhYyyxVw31G2TdEiwLbUfve0FHDqTsLezakTT693/iuneAW/i36wkQN11oSroDw9shy+DJroT0HEmm8nAwDscpM2mmbu6yKYV3E8DBgI8ku4eTBdk4FDugu11lwGTzKyIjcKoA2fcGs06DguX0xxPIXAEkmRMtHZAg6jIZnV88b6LINwZfdEG7VWA/Njk+bV2ZkYziGJ8Y0kSFBGlIAQ4rWloETTkjYbANEaN+pHjGKeYUZw7EiDxwI7Reai06XWmRcrqmMz/pTywf6bgImBlfv50oiSBf/5dS6y/kmtKXq1LkcL2DH2713tJFrb8bImUFUSMd5CwPxCC9f04/dAsOadCz5fkCpNLrFFkJ18S+OBZwcQ9HG431VIgjurydEa0ncq4dz8J+nhHKIX3FKyMtxc4qNuqywDWqxVjdMO8FoPCXzjXzc6dPTL7TlqxrZFQ/KDJtE5tCo+7LtNw4zwz4BZA3E0RY6fVpkQp+KbDE7uVIJUw3xvoWTNFfk8qNalhsK+Y+04ZJN7tR1/ouDrOZje+WKNTRO+vB4R80s64MLVEGuGTOZ6osx+Lmk1YfRzu9Cw3JID0SN2e/ZucyjVwH5jUNJl3iUMTX0zhz/OoN+aqfQbmxyGNARWD3s0cfartHG1PCLiHx5P/6+Zv8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MOGxvCoV5JVKPbzVq7cStRFgym4zsx/jGUZXtIaklZ42AetU8FC8v4su9vPet2AGk7a8FCyeLy0t8N8TJP7edb/kSRzMVjGc6DN2Wj1s3BagRydTJFRXvSXtEWk74rS9PzY+78XA5doWCmxHTJbAfaqsL5ey5LcPXDtr3kLAy3ZRNZgpDTfJQHPcrVCFLIZUTk4aIFVu4kqLWg3EFCkt2ljvVxuy/m99itV5+Rb0dO82UIUVc6L7hUxzk+3bmYaXZeQWhZtW6o7+7OO5RFrLRh9KxAyIaqor53B8kl4PWcKfsoi98GU+rSJ+xhWSJyDZOv+XE+Zwpc6XetGUk9yF8rS/fYBbBj6I76z4rsUo0LSzfIodjY8cQlcWSbUFiOp5Lf12B4EYOnKU1NDOuQWZ10meEebGirMDfe35HdQjahE1ax8dWCzYcbo5Luciqyl2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:26.4187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0a101c-3475-44cd-c764-08deddfd6173
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
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

Add KUnit coverage for adjust_colour_depth_from_display_info() 420
reduction, amdgpu_dm_get_output_color_space() Y_ONLY/YCbCr601/BT2020
fallbacks, to_drm_connector_type() dual-link DVI-D, and
copy_crtc_timing_for_drm_display_mode().

Export copy_crtc_timing_for_drm_display_mode via EXPORT_IF_KUNIT so
the tests can reach it.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   2 +
 .../tests/amdgpu_dm_connector_test.c          | 186 ++++++++++++++++++
 3 files changed, 190 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 56e4bbff383f..96f7bf446570 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -948,7 +948,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	stream->content_type = get_output_content_type(connector_state);
 }
 
-static void
+STATIC_IFN_KUNIT void
 copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
 				      struct drm_display_mode *dst_mode)
 {
@@ -967,6 +967,7 @@ copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
 	dst_mode->crtc_vsync_end = src_mode->crtc_vsync_end;
 	dst_mode->crtc_vtotal = src_mode->crtc_vtotal;
 }
+EXPORT_IF_KUNIT(copy_crtc_timing_for_drm_display_mode);
 
 STATIC_IFN_KUNIT void
 decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 865646303dcb..e9ee4a4ad30e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -155,6 +155,8 @@ bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
 int to_drm_connector_type(enum signal_type st, uint32_t connector_id);
 bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector, struct drm_display_mode *mode);
 enum dc_aspect_ratio get_aspect_ratio(const struct drm_display_mode *mode_in);
+void copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
+					   struct drm_display_mode *dst_mode);
 void decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					     const struct drm_display_mode *native_mode,
 					     bool scale_enabled);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 45210c64a000..91f9543dd7bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -290,6 +290,30 @@ static void dm_test_adjust_colour_depth_420_halves_clk(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)timing.display_color_depth, (int)COLOR_DEPTH_101010);
 }
 
+/**
+ * dm_test_adjust_colour_depth_420_reduces - Test Adjust colour depth 420 reduces
+ * @test: The KUnit test context
+ */
+static void dm_test_adjust_colour_depth_420_reduces(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_display_info info = {};
+
+	/* 4K @ 594000 KHz = 5940000 in 100Hz units */
+	timing.pix_clk_100hz = 5940000;
+	timing.display_color_depth = COLOR_DEPTH_121212;
+	timing.pixel_encoding = PIXEL_ENCODING_YCBCR420;
+	/*
+	 * With 420: effective = 594000/2 = 297000.
+	 * 12bpc = 297000*36/24 = 445500 (exceeds limit),
+	 * 10bpc = 297000*30/24 = 371250 (fits).
+	 */
+	info.max_tmds_clock = 400000;
+
+	KUNIT_EXPECT_TRUE(test, adjust_colour_depth_from_display_info(&timing, &info));
+	KUNIT_EXPECT_EQ(test, (int)timing.display_color_depth, (int)COLOR_DEPTH_101010);
+}
+
 /**
  * dm_test_adjust_colour_depth_reduces_12bpc_to_10bpc - Test Adjust colour
  * depth reduces 12bpc to 10bpc
@@ -550,6 +574,78 @@ static void dm_test_output_color_space_bt2020_ycc(struct kunit *test)
 			(int)COLOR_SPACE_2020_YCBCR_LIMITED);
 }
 
+/**
+ * dm_test_output_color_space_default_ycbcr709_y_only - Test Output color space
+ * default ycbcr709 limited via Y_ONLY at high pixel clock
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_default_ycbcr709_y_only(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+
+	timing.pixel_encoding = PIXEL_ENCODING_YCBCR444;
+	timing.pix_clk_100hz = 300000;
+	timing.flags.Y_ONLY = 1;
+	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_YCBCR709_LIMITED);
+}
+
+/**
+ * dm_test_output_color_space_default_ycbcr601 - Test Output color space default
+ * ycbcr601 full range at low pixel clock
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_default_ycbcr601(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+
+	timing.pixel_encoding = PIXEL_ENCODING_YCBCR444;
+	timing.pix_clk_100hz = 270300;
+	timing.flags.Y_ONLY = 0;
+	state.colorspace = DRM_MODE_COLORIMETRY_DEFAULT;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_YCBCR601);
+}
+
+/**
+ * dm_test_output_color_space_bt2020_ycc_rgb_encoding - Test Output color space
+ * bt2020 ycc with rgb pixel encoding falls back to full range rgb
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_bt2020_ycc_rgb_encoding(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+
+	timing.pixel_encoding = PIXEL_ENCODING_RGB;
+	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_YCC;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_2020_RGB_FULLRANGE);
+}
+
+/**
+ * dm_test_output_color_space_bt2020_rgb_ycc_encoding - Test Output color space
+ * bt2020 rgb with non-rgb pixel encoding falls back to limited ycbcr
+ * @test: The KUnit test context
+ */
+static void dm_test_output_color_space_bt2020_rgb_ycc_encoding(struct kunit *test)
+{
+	struct dc_crtc_timing timing = {};
+	struct drm_connector_state state = {};
+
+	timing.pixel_encoding = PIXEL_ENCODING_YCBCR444;
+	state.colorspace = DRM_MODE_COLORIMETRY_BT2020_RGB;
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_get_output_color_space(&timing, &state),
+			(int)COLOR_SPACE_2020_YCBCR_LIMITED);
+}
+
 /* Tests for amdgpu_dm_convert_dc_color_depth_into_bpc() */
 
 /**
@@ -834,6 +930,17 @@ static void dm_test_to_connector_type_dvi_dvid(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, type, DRM_MODE_CONNECTOR_DVID);
 }
 
+/**
+ * dm_test_to_connector_type_dual_link_dvid - Test To connector type dual link dvid
+ * @test: The KUnit test context
+ */
+static void dm_test_to_connector_type_dual_link_dvid(struct kunit *test)
+{
+	int type = to_drm_connector_type(SIGNAL_TYPE_DVI_DUAL_LINK, CONNECTOR_ID_DUAL_LINK_DVID);
+
+	KUNIT_EXPECT_EQ(test, type, DRM_MODE_CONNECTOR_DVID);
+}
+
 /**
  * dm_test_to_connector_type_virtual - Test To connector type virtual
  * @test: The KUnit test context
@@ -1124,6 +1231,76 @@ static void dm_test_aspect_ratio_256_135(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)get_aspect_ratio(&mode), (int)ASPECT_RATIO_256_135);
 }
 
+/* Tests for copy_crtc_timing_for_drm_display_mode() */
+
+/**
+ * dm_test_copy_crtc_timing_copies_all_fields - Test all crtc timing fields copied
+ * @test: The KUnit test context
+ */
+static void dm_test_copy_crtc_timing_copies_all_fields(struct kunit *test)
+{
+	struct drm_display_mode src = {};
+	struct drm_display_mode dst = {};
+
+	src.crtc_hdisplay = 1920;
+	src.crtc_vdisplay = 1080;
+	src.crtc_clock = 148500;
+	src.crtc_hblank_start = 1920;
+	src.crtc_hblank_end = 2200;
+	src.crtc_hsync_start = 2008;
+	src.crtc_hsync_end = 2052;
+	src.crtc_htotal = 2200;
+	src.crtc_hskew = 1;
+	src.crtc_vblank_start = 1080;
+	src.crtc_vblank_end = 1125;
+	src.crtc_vsync_start = 1084;
+	src.crtc_vsync_end = 1089;
+	src.crtc_vtotal = 1125;
+
+	copy_crtc_timing_for_drm_display_mode(&src, &dst);
+
+	KUNIT_EXPECT_EQ(test, dst.crtc_hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, dst.crtc_vdisplay, 1080);
+	KUNIT_EXPECT_EQ(test, dst.crtc_clock, 148500);
+	KUNIT_EXPECT_EQ(test, dst.crtc_hblank_start, 1920);
+	KUNIT_EXPECT_EQ(test, dst.crtc_hblank_end, 2200);
+	KUNIT_EXPECT_EQ(test, dst.crtc_hsync_start, 2008);
+	KUNIT_EXPECT_EQ(test, dst.crtc_hsync_end, 2052);
+	KUNIT_EXPECT_EQ(test, dst.crtc_htotal, 2200);
+	KUNIT_EXPECT_EQ(test, dst.crtc_hskew, 1);
+	KUNIT_EXPECT_EQ(test, dst.crtc_vblank_start, 1080);
+	KUNIT_EXPECT_EQ(test, dst.crtc_vblank_end, 1125);
+	KUNIT_EXPECT_EQ(test, dst.crtc_vsync_start, 1084);
+	KUNIT_EXPECT_EQ(test, dst.crtc_vsync_end, 1089);
+	KUNIT_EXPECT_EQ(test, dst.crtc_vtotal, 1125);
+}
+
+/**
+ * dm_test_copy_crtc_timing_leaves_non_crtc_fields - Test non-crtc fields untouched
+ * @test: The KUnit test context
+ */
+static void dm_test_copy_crtc_timing_leaves_non_crtc_fields(struct kunit *test)
+{
+	struct drm_display_mode src = {};
+	struct drm_display_mode dst = {};
+
+	src.crtc_hdisplay = 1280;
+	src.crtc_vdisplay = 720;
+
+	/* Non-crtc geometry on dst must be preserved by the copy */
+	dst.hdisplay = 1920;
+	dst.vdisplay = 1080;
+	dst.clock = 148500;
+
+	copy_crtc_timing_for_drm_display_mode(&src, &dst);
+
+	KUNIT_EXPECT_EQ(test, dst.crtc_hdisplay, 1280);
+	KUNIT_EXPECT_EQ(test, dst.crtc_vdisplay, 720);
+	KUNIT_EXPECT_EQ(test, dst.hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, dst.vdisplay, 1080);
+	KUNIT_EXPECT_EQ(test, dst.clock, 148500);
+}
+
 /* Tests for decide_crtc_timing_for_drm_display_mode() */
 
 /**
@@ -2372,6 +2549,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_adjust_colour_depth_reduces_to_888),
 	KUNIT_CASE(dm_test_adjust_colour_depth_10bpc_passes),
 	KUNIT_CASE(dm_test_adjust_colour_depth_420_halves_clk),
+	KUNIT_CASE(dm_test_adjust_colour_depth_420_reduces),
 	KUNIT_CASE(dm_test_adjust_colour_depth_reduces_12bpc_to_10bpc),
 	KUNIT_CASE(dm_test_adjust_colour_depth_16bpc_no_fallback),
 	KUNIT_CASE(dm_test_adjust_colour_depth_none_fits),
@@ -2388,6 +2566,10 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_output_color_space_oprgb),
 	KUNIT_CASE(dm_test_output_color_space_bt2020_rgb),
 	KUNIT_CASE(dm_test_output_color_space_bt2020_ycc),
+	KUNIT_CASE(dm_test_output_color_space_default_ycbcr709_y_only),
+	KUNIT_CASE(dm_test_output_color_space_default_ycbcr601),
+	KUNIT_CASE(dm_test_output_color_space_bt2020_ycc_rgb_encoding),
+	KUNIT_CASE(dm_test_output_color_space_bt2020_rgb_ycc_encoding),
 	/* Tests for amdgpu_dm_convert_dc_color_depth_into_bpc */
 	KUNIT_CASE(dm_test_convert_color_depth_bpc_mappings),
 	KUNIT_CASE(dm_test_convert_color_depth_bpc_unknown),
@@ -2412,6 +2594,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_to_connector_type_dvi_dvii),
 	KUNIT_CASE(dm_test_to_connector_type_dual_link_dvii),
 	KUNIT_CASE(dm_test_to_connector_type_dvi_dvid),
+	KUNIT_CASE(dm_test_to_connector_type_dual_link_dvid),
 	KUNIT_CASE(dm_test_to_connector_type_virtual),
 	KUNIT_CASE(dm_test_to_connector_type_unknown),
 	/* is_duplicate_mode */
@@ -2433,6 +2616,9 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_aspect_ratio_16_9),
 	KUNIT_CASE(dm_test_aspect_ratio_64_27),
 	KUNIT_CASE(dm_test_aspect_ratio_256_135),
+	/* copy_crtc_timing_for_drm_display_mode */
+	KUNIT_CASE(dm_test_copy_crtc_timing_copies_all_fields),
+	KUNIT_CASE(dm_test_copy_crtc_timing_leaves_non_crtc_fields),
 	/* decide_crtc_timing_for_drm_display_mode */
 	KUNIT_CASE(dm_test_decide_crtc_timing_scale_enabled),
 	KUNIT_CASE(dm_test_decide_crtc_timing_matching_mode),
-- 
2.55.0

