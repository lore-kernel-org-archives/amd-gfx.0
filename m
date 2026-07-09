Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1800C44511
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8391710F705;
	Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mSVLadfz";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298CA10F6F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np9AhQrGSAmNziQoiHHC9q4c2aMA7h/tGZI75z4IHvdXgxYAiz3fwjOtEK+4xqWvujL3j5pNoRrGq1dAkOUVINjNo8R/4w/e68+RHRr+oYRZ/wBCA1ed+H0ozD7D0wj2un0X919xHACXmqdvQ2OQajCa9T5Qbi524WOmqYUltf+9bGUf9Hp+BcmPUN34hRV7UAjVE3NgBYeYxcM1EgGe1bTIN0rxk1E9JbxpoWOYeFRJVzVcmi74LvRoHIcMkyo7OBGoKQ8VKb01Krw9wu4CjUwdYTtE8/E2957bVhGorto1RJkbOslaiQa2hgf/1KIyIMZEdAgVIc0pIoApNWkYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjXic5IRr8OamAvav9x4svewtfKnBzcu4G7PZWddVpk=;
 b=RulvRrfSD9ckguwb+kGsLalciIn2gDHc+UWdx3GohPjqkPKDX1U8yUtOHUh9TtCVEwDbxhhnARSF7VcQK2QZHSJ0cyItfTOt4dVX1jTo06UUz60ulfDMVkeIU/x+43HBOku4Iuy0kEWETLvWydL1e+1Ik9dzUtDM8mLi8R5cnDbT1icpZh2HfwA9D36WCweJtlHQQNppcGtdzm2XYtoTkAoo0L3rcluLCD3B7pxreF9dJkZWbkkmmxz0EXurMTs8aoKYaP9vVM5me3IbaTd9dGCwUvACjQciyspulq4cXtOcIBVb1n3d8Q76Ni/VssTsSQJTph79BmcS/s3j1o6x1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjXic5IRr8OamAvav9x4svewtfKnBzcu4G7PZWddVpk=;
 b=mSVLadfzRRad6YJoaFjLRBr3X/+WjebDptMsVgAuK5GvuobCsS2u6JcK9XmQ5non4hGuXvqpWY0s978tvw799jGT4ib4RcQBrn0z5C7RPr5Kt9/mXfbvC0rtsfbyGmR0pM7KqqDz+AKrR1MzS5OoAHpPMndrcEqfh7kc9P4p8v0=
Received: from BLAPR03CA0101.namprd03.prod.outlook.com (2603:10b6:208:32a::16)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 21:02:38 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::47) by BLAPR03CA0101.outlook.office365.com
 (2603:10b6:208:32a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:38 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:31 -0500
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
Subject: [PATCH 72/80] drm/amd/display: Add stream property tests for connector
Date: Thu, 9 Jul 2026 16:48:40 -0400
Message-ID: <20260709205936.5719-73-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: c633b1bd-9cdf-4e9f-5ef5-08deddfd6860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|56012099006|18002099003|18092099006|22082099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: 3/WkGNZgGqtcYUcpF1wSTZJU/RV3lQ0/CTJ8CYKQAmmiLFU3svRAQ/QABATEGdaSzrlwGA6oDoeKCTDuMB8jMEU93AzQwrmguBVOYfFf+wB6g6CW4pyBz8a6lOdG7qPt7vDN7hodDJR43ifjzHM3GjMoZMQrhAFbn75C5vtSYVLJNjp0ahxd9q5y6kJaO83UGhkiix2U+uOslWa3eqhXHrJiETeApDzTPvsCs3gC1AwccO3pyGUEG3q5Cxf+JY6vMUqdHWlJ4bEG7dCGy2zHGULKyoQp29KA6Oi0sbsp9y1aCIlaJvLyBE6P2P6PecVxxrTGrfX9/QmtMEmbckryrFlExHCv+igFB7JJyo11ArcuoQgqKfwFZ3CxjUb9Amj03dGFWLYFzOxPxF1GCuA083WDUEMHKgypwBJqFrlBmgQX7dNgnafjyGmkqVm3zGkqk7jcJY4QCxezUQ7hTyU3ZiXCInDNiZa7eklJTQcQFz20m/rK5JTbQmEkMW1gPzi9ET6MkhsTtV0AQJ/qV6fW5UmuHAIfAT7U7AOxN7c9/uTMW0fSGXIkLUpoTe6czL3S8jX1VQw2Mr2UVHx6QxTQu62XZroZuiq4U2OvGF+l3tQtOgUNESm2NV9d8aYKigzDhbHI6hTCGSklhA5SAagaW6AZ+357aMDCqb5uiL1CIxpdXgMhNKyFpX2A6+jXGYXeKV7CUHy3yZQPVwG55cmcyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(56012099006)(18002099003)(18092099006)(22082099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hBs+9blugHu0Wr4Pw8aC5UmnB6FNTqvGXxcsDEr/+RDXE4PzxaPQi3DL54PBVzibk9iEKs58sLlENio6T0p5f5hjdbk/0tzpzFcHUxQ8mm2aetdyWV0BqzWssmbvaqM1KIMuH9uvvnLuobbJlomscRR88IRjx5x6dFKk2NkcXF3xPwNG3m4BPaPCTQUonqBOD65Oy4C1o/hajCVh0e1M41Wv6EqzxKciUmHm5ZMZmr1s77tyz4cnUPKbkA/WDksL1FOEJNVdzw+gjcStTkwn9ge2cfnyWRozTpciLmgua7P224LQBFySrDMymynZMKdlT46y5Pw+fW9pg95ijX1gjHozP/YRceBt04p4ifIfUffu5zTPCbG4AG/kZKxrJKCNM8faloK0FR8q0XAIO0dXR19PZuBNBEXDlN0bvQaqQboM985pOqKLcJ+mfA+k4QSt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:38.0420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c633b1bd-9cdf-4e9f-5ef5-08deddfd6860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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

Add KUnit coverage for fill_stream_properties_from_drm_display_mode():
zeroed borders, RGB defaults, sync polarity handling, inheriting from
an old stream, timing from the crtc, requested bpc colour depth,
content type and aspect ratio.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   7 +
 .../tests/amdgpu_dm_connector_test.c          | 273 ++++++++++++++++++
 3 files changed, 282 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 7ce2efb9aaa1..5b358df3a5f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -835,7 +835,7 @@ STATIC_IFN_KUNIT bool adjust_colour_depth_from_display_info(
 }
 EXPORT_IF_KUNIT(adjust_colour_depth_from_display_info);
 
-static void fill_stream_properties_from_drm_display_mode(
+STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 	struct dc_stream_state *stream,
 	const struct drm_display_mode *mode_in,
 	const struct drm_connector *connector,
@@ -951,6 +951,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	stream->output_color_space = amdgpu_dm_get_output_color_space(timing_out, connector_state);
 	stream->content_type = get_output_content_type(connector_state);
 }
+EXPORT_IF_KUNIT(fill_stream_properties_from_drm_display_mode);
 
 STATIC_IFN_KUNIT void
 copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index b85083926188..ad277fff57de 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -151,6 +151,13 @@ void update_subconnector_property(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_fbc_init(struct drm_connector *connector);
 void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector);
+void fill_stream_properties_from_drm_display_mode(
+	struct dc_stream_state *stream,
+	const struct drm_display_mode *mode_in,
+	const struct drm_connector *connector,
+	const struct drm_connector_state *connector_state,
+	const struct dc_stream_state *old_stream,
+	int requested_bpc);
 enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state);
 bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 8f3460dcf2f0..b3d16123402d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -3341,6 +3341,269 @@ static void dm_test_cacp_caps_lcd_unsupported(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, ctx->link->panel_config.cacp.cacp_supported);
 }
 
+/* Tests for fill_stream_properties_from_drm_display_mode() */
+
+/*
+ * Build the inputs for fill_stream_properties_from_drm_display_mode(). The
+ * connector is registered against a real kunit drm_device so that
+ * to_amdgpu_dm_connector(), connector->display_info and the drm debug helpers
+ * all resolve. Large structs are heap-allocated to keep the stack small.
+ *
+ * The stream signal defaults to DisplayPort so the HDMI infoframe paths are
+ * skipped, keeping the exercised behaviour deterministic.
+ */
+struct dm_test_fill_ctx {
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *conn_state;
+	struct dc_stream_state *stream;
+	struct drm_display_mode *mode;
+};
+
+static struct dm_test_fill_ctx *dm_test_fill_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx;
+	struct device *dev;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	ctx->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						       sizeof(*ctx->drm), 0,
+						       DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
+
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	KUNIT_ASSERT_EQ(test,
+		drmm_connector_init(ctx->drm, &ctx->aconnector->base,
+				    &dm_test_connector_funcs,
+				    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
+
+	ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx->conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
+	ctx->stream = kunit_kzalloc(test, sizeof(*ctx->stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->stream);
+	ctx->mode = kunit_kzalloc(test, sizeof(*ctx->mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->mode);
+
+	ctx->stream->signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	return ctx;
+}
+
+/**
+ * dm_test_fill_stream_borders_zeroed - Test the timing borders are cleared
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_stream_borders_zeroed(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	/* Pre-seed nonzero borders to prove they get reset. */
+	timing->h_border_left = 5;
+	timing->h_border_right = 6;
+	timing->v_border_top = 7;
+	timing->v_border_bottom = 8;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->h_border_left, 0);
+	KUNIT_EXPECT_EQ(test, (int)timing->h_border_right, 0);
+	KUNIT_EXPECT_EQ(test, (int)timing->v_border_top, 0);
+	KUNIT_EXPECT_EQ(test, (int)timing->v_border_bottom, 0);
+}
+
+/**
+ * dm_test_fill_stream_rgb_defaults - Test the default RGB/sRGB output
+ * @test: The KUnit test context
+ *
+ * A plain DisplayPort sink with no YCbCr color formats produces RGB encoding
+ * and the sRGB color space, with a predefined sRGB transfer function.
+ */
+static void dm_test_fill_stream_rgb_defaults(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->pixel_encoding, (int)PIXEL_ENCODING_RGB);
+	KUNIT_EXPECT_EQ(test, (int)timing->timing_3d_format,
+			(int)TIMING_3D_FORMAT_NONE);
+	KUNIT_EXPECT_EQ(test, (int)timing->scan_type, (int)SCANNING_TYPE_NODATA);
+	KUNIT_EXPECT_EQ(test, (int)ctx->stream->output_color_space,
+			(int)COLOR_SPACE_SRGB);
+	KUNIT_EXPECT_EQ(test, (int)ctx->stream->out_transfer_func.type,
+			(int)TF_TYPE_PREDEFINED);
+	KUNIT_EXPECT_EQ(test, (int)ctx->stream->out_transfer_func.tf,
+			(int)TRANSFER_FUNCTION_SRGB);
+}
+
+/**
+ * dm_test_fill_stream_sync_polarity_positive - Test sync polarity from mode flags
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_stream_sync_polarity_positive(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	ctx->mode->flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->flags.HSYNC_POSITIVE_POLARITY, 1);
+	KUNIT_EXPECT_EQ(test, (int)timing->flags.VSYNC_POSITIVE_POLARITY, 1);
+}
+
+/**
+ * dm_test_fill_stream_sync_polarity_negative - Test negative sync polarity default
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_stream_sync_polarity_negative(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	/* No sync flags set on the mode → polarity stays negative (0). */
+	ctx->mode->flags = 0;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->flags.HSYNC_POSITIVE_POLARITY, 0);
+	KUNIT_EXPECT_EQ(test, (int)timing->flags.VSYNC_POSITIVE_POLARITY, 0);
+}
+
+/**
+ * dm_test_fill_stream_inherits_old_stream - Test vic/polarity copied from old stream
+ * @test: The KUnit test context
+ *
+ * When an old stream is supplied its vic and sync polarities are reused instead
+ * of being derived from the mode.
+ */
+static void dm_test_fill_stream_inherits_old_stream(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+	struct dc_stream_state *old_stream;
+
+	old_stream = kunit_kzalloc(test, sizeof(*old_stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_stream);
+	old_stream->timing.vic = 16;
+	old_stream->timing.flags.HSYNC_POSITIVE_POLARITY = 1;
+	old_stream->timing.flags.VSYNC_POSITIVE_POLARITY = 0;
+
+	/* Mode flags would force positive polarity if the old stream were ignored. */
+	ctx->mode->flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, old_stream, 8);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->vic, 16);
+	KUNIT_EXPECT_EQ(test, (int)timing->flags.HSYNC_POSITIVE_POLARITY, 1);
+	KUNIT_EXPECT_EQ(test, (int)timing->flags.VSYNC_POSITIVE_POLARITY, 0);
+}
+
+/**
+ * dm_test_fill_stream_timing_from_crtc - Test timing taken from crtc_* fields
+ * @test: The KUnit test context
+ *
+ * Without a freesync video match the function uses the mode's crtc_* timing
+ * fields and scales the pixel clock to 100Hz units.
+ */
+static void dm_test_fill_stream_timing_from_crtc(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	ctx->mode->crtc_hdisplay = 1920;
+	ctx->mode->crtc_htotal = 2200;
+	ctx->mode->crtc_hsync_start = 2008;
+	ctx->mode->crtc_hsync_end = 2052;
+	ctx->mode->crtc_vdisplay = 1080;
+	ctx->mode->crtc_vtotal = 1125;
+	ctx->mode->crtc_vsync_start = 1084;
+	ctx->mode->crtc_vsync_end = 1089;
+	ctx->mode->crtc_clock = 148500;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->h_addressable, 1920);
+	KUNIT_EXPECT_EQ(test, (int)timing->h_total, 2200);
+	KUNIT_EXPECT_EQ(test, (int)timing->h_sync_width, 44);
+	KUNIT_EXPECT_EQ(test, (int)timing->h_front_porch, 88);
+	KUNIT_EXPECT_EQ(test, (int)timing->v_addressable, 1080);
+	KUNIT_EXPECT_EQ(test, (int)timing->v_total, 1125);
+	KUNIT_EXPECT_EQ(test, (int)timing->v_sync_width, 5);
+	KUNIT_EXPECT_EQ(test, (int)timing->v_front_porch, 4);
+	KUNIT_EXPECT_EQ(test, (int)timing->pix_clk_100hz, 1485000);
+}
+
+/**
+ * dm_test_fill_stream_color_depth_requested_bpc - Test bpc capping
+ * @test: The KUnit test context
+ *
+ * The requested bpc caps the display bpc and is rounded down to an even value.
+ */
+static void dm_test_fill_stream_color_depth_requested_bpc(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	ctx->aconnector->base.display_info.bpc = 12;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 10);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->display_color_depth,
+			(int)COLOR_DEPTH_101010);
+}
+
+/**
+ * dm_test_fill_stream_content_type - Test content type forwarded from state
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_stream_content_type(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+
+	ctx->conn_state->content_type = DRM_MODE_CONTENT_TYPE_GRAPHICS;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+
+	KUNIT_EXPECT_EQ(test, (int)ctx->stream->content_type,
+			(int)DISPLAY_CONTENT_TYPE_GRAPHICS);
+}
+
+/**
+ * dm_test_fill_stream_aspect_ratio - Test aspect ratio mapped from the mode
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_stream_aspect_ratio(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	ctx->mode->picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->aspect_ratio,
+			(int)ASPECT_RATIO_16_9);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -3525,6 +3788,16 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_cacp_caps_ip_3_1_6_unsupported),
 	KUNIT_CASE(dm_test_cacp_caps_non_edp_lvds_unsupported),
 	KUNIT_CASE(dm_test_cacp_caps_lcd_unsupported),
+	/* fill_stream_properties_from_drm_display_mode */
+	KUNIT_CASE(dm_test_fill_stream_borders_zeroed),
+	KUNIT_CASE(dm_test_fill_stream_rgb_defaults),
+	KUNIT_CASE(dm_test_fill_stream_sync_polarity_positive),
+	KUNIT_CASE(dm_test_fill_stream_sync_polarity_negative),
+	KUNIT_CASE(dm_test_fill_stream_inherits_old_stream),
+	KUNIT_CASE(dm_test_fill_stream_timing_from_crtc),
+	KUNIT_CASE(dm_test_fill_stream_color_depth_requested_bpc),
+	KUNIT_CASE(dm_test_fill_stream_content_type),
+	KUNIT_CASE(dm_test_fill_stream_aspect_ratio),
 	{}
 };
 
-- 
2.55.0

