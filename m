Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD230C55178
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440F310F406;
	Fri, 31 Jul 2026 21:16:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aP+23Jw/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56AD10E24B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bu4YCp8t6gbTRUEvqF0Edc5fg7ChU/stq3pVN/hgjmLkDf5ettopMvRhQnK6h3c6xx0Pa8GtlkPnjoxP1gyrwSMwnvuXYdauTyr4jHe/O1nqcs+pDXOC0yrLOYw4tCaYznzzXS1Ug7uKu7f8vt8EVAv9/QRSFVkvKtCGFjwA7ID8qvir4i7nZSlf+5qrcN658ru0SiHzsLoIHBbvUQi3fZxqpK/TgAr5HGNUdM1uFBQZsFujBQ432JkbUWSMGnnzc3hXkCcbv6C8AuqAJ/xvAJIn+CUXzbs5fe3RXTNrNwUD0uwdRePA00aEvqszEmcu9lNwAm69rPN56V3qXlzonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzg4YaLGjApRSyyuv8iU2K6/sJ1/jNipkwj7QoVYv28=;
 b=VxBCQ6/apGmi6oPOjpjvJPS1dPrxH6WY0AOdRvsZk9nL2X5/arr7G1cfaybgqkqNBpowVdvZcYKNpaCKyi9E9ebNAoKLks2JUS6e4faDVr0AUo5rccL2lqmfjR21f+ocTCWG4tQMy+KBm/JlJDWsmgcsCqBKcFGvtDg/tC8zrqtHQnSih19fkco7O1IVzmsIEvEbO4vGI3CW5OHYMCRALF6YzlzV56Ww1s57pB7qR7IQOxtJjwCD4FaJuUZMCZAPRb2vapp6rxbWUT8p/wn3UmW4tKGdNKNFeIhwBKPfHAGBWCezi00722SCTTFkZrEnmYsqZRau6t6T3adtzaCQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzg4YaLGjApRSyyuv8iU2K6/sJ1/jNipkwj7QoVYv28=;
 b=aP+23Jw/YhMoVYw91+3lkBE8FbFxuhhOCWuF6Mx7CmFaK2kkB7N3gKREWOgHLzOjShNra+gegzXmCkR3aU1mGKlJ3EOO6af/qRY+hJ9lOdtzPWRPwqiVXXUT/x6XwM1UoRUac5e++TE8XOcRjIIMP+zvcmlt9QyHenBg1FYLb5E=
Received: from MN0P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::8)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:15:53 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::1d) by MN0P222CA0005.outlook.office365.com
 (2603:10b6:208:531::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:51 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:50 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 23/41] drm/amd/display: Align connector KUnit tests with
 stream validation refactor
Date: Fri, 31 Jul 2026 17:12:44 -0400
Message-ID: <20260731211302.3040343-24-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 07072e21-b428-41b0-3c29-08deef48e691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: vrrYVkVTx+7CZIxqJlxIacDoN//u6QeVSeYfm/UxC+LCYBTrfkernwkF5leG55ShNu70KoiHS5MzTI8vlXJ7wemacNbr7xqG/dpoaAVQUTGi/u2hv8TnaPp+DT2kf/EBNDzpc+teZCHqUBG/QNOlpFQokAAM5gKu+/pz/St+AXiNWSYJ8gwnAr/jMe6tleB/2clfY6BKLMW3OSe2Wp8i8+AcCt1btvZ42i+auptHXng+rOGtuGYuVUIO37CePM1U9Jw2ozjDGm8RkojNVZPrpk5kiDMjS8WzUMozzrwfTHwRLYlU/2CRCzUV/4nA1KRM+ZcUzoorjEdhD27MnQUzQVfrF+w7KE9yIPGZhbr6pb+nEwFIiNbzLTOyTCa5zLLrmQmME23rKPXy8u1OYO1WIr8nEnRpVSm/Y1bpxnt/Wgj2hoSjXEmMhvl2Z2uxmw+a6jH3aKHDBT7JzDR6XssheevWN99NABYuyCP+XafD5dKQ4nDeNbSHirwMqvJM3ueENr+lmvpUwnH4e0GznzdjOD4q4iqCuvuPRqoF5yh0HUXD1JQb9YBoWzW6ZEmnBKCjJyKq6dVEE2kaOcNn9nNiVK5JsOYlpnqIxyveU4ca6c1/AvOtDXjOnbfK0h8ckAAJfyz2/iRO5GnkCGFWnqm+ZI8y0cDovuaLwQhcjokBLRLjdKhOtnJUiBiJGpqvmTGKyDFf/duDoD70UvJzVUhfFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bwuqnnbjYmIY4wxGsH9p6kFGN7AlcRFcDUdxxt/EypM7sbpNIGfVQwQl6foyNlFeNlYK3RSGmlmybhSMMSrsiSXOu3CcThceW98KUksggofQotXAQ5FushfE+i7lwMtXPTGq3wrAIRz3qiM7wEsevPe1u74W3beqOxyK4IUPxBOQ9TI6cYkIRXcAuZnn+WTcsIy/yO+5Vw0FwitHu/fd+wVMN+pAZUM2TFxYcDff6oR8bd9q2JZs2ASdrp5abmFny9gaLhYDPcV/YBo/lwHKfqZ1wKvqZbq4lo//GltEPupv1xiWp9ZFKJhlRGMhVJ1Q5gw4hrMpBbsD/hiU1/RraDi/fRsTwWr2cmr5hWymyKh8FfcHqxNWe3Wir29SFDpi1kU0XieGVgkTv83p23jUGrP8MjWt7hV3T9cts7yhaF+hiNJAkv+5ZGcg3Sq8HFJr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:51.7702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07072e21-b428-41b0-3c29-08deef48e691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Update the amdgpu_dm_connector KUnit tests for the new
fill_stream_properties_from_drm_display_mode() and create_stream_for_sink()
signatures, which now take an explicit pixel encoding and an is_hdmi_ep
flag instead of deriving the encoding from connector state.

- Pass PIXEL_ENCODING_RGB / is_hdmi_ep=false to all existing call sites.
- Add cases verifying the caller-selected encoding is applied verbatim
  (YCbCr420/422/444), replacing the old display-info-derived behaviour.
- Add cases covering the is_hdmi_ep TMDS colour-depth clamp: depth is
  reduced when over the sink limit on an HDMI endpoint and left untouched
  otherwise.

Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 155 ++++++++++++++++--
 1 file changed, 141 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 1a8f02c78c4d..1658d4d5997a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -3416,7 +3416,8 @@ static void dm_test_fill_stream_borders_zeroed(struct kunit *test)
 	timing->v_border_bottom = 8;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->h_border_left, 0);
 	KUNIT_EXPECT_EQ(test, (int)timing->h_border_right, 0);
@@ -3437,7 +3438,8 @@ static void dm_test_fill_stream_rgb_defaults(struct kunit *test)
 	struct dc_crtc_timing *timing = &ctx->stream->timing;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->pixel_encoding, (int)PIXEL_ENCODING_RGB);
 	KUNIT_EXPECT_EQ(test, (int)timing->timing_3d_format,
@@ -3463,7 +3465,8 @@ static void dm_test_fill_stream_sync_polarity_positive(struct kunit *test)
 	ctx->mode->flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->flags.HSYNC_POSITIVE_POLARITY, 1);
 	KUNIT_EXPECT_EQ(test, (int)timing->flags.VSYNC_POSITIVE_POLARITY, 1);
@@ -3482,7 +3485,8 @@ static void dm_test_fill_stream_sync_polarity_negative(struct kunit *test)
 	ctx->mode->flags = 0;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->flags.HSYNC_POSITIVE_POLARITY, 0);
 	KUNIT_EXPECT_EQ(test, (int)timing->flags.VSYNC_POSITIVE_POLARITY, 0);
@@ -3511,7 +3515,8 @@ static void dm_test_fill_stream_inherits_old_stream(struct kunit *test)
 	ctx->mode->flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, old_stream, 8);
+		&ctx->aconnector->base, ctx->conn_state, old_stream, 8,
+		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->vic, 16);
 	KUNIT_EXPECT_EQ(test, (int)timing->flags.HSYNC_POSITIVE_POLARITY, 1);
@@ -3541,7 +3546,8 @@ static void dm_test_fill_stream_timing_from_crtc(struct kunit *test)
 	ctx->mode->crtc_clock = 148500;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->h_addressable, 1920);
 	KUNIT_EXPECT_EQ(test, (int)timing->h_total, 2200);
@@ -3568,7 +3574,8 @@ static void dm_test_fill_stream_color_depth_requested_bpc(struct kunit *test)
 	ctx->aconnector->base.display_info.bpc = 12;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 10);
+		&ctx->aconnector->base, ctx->conn_state, NULL, 10,
+		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->display_color_depth,
 			(int)COLOR_DEPTH_101010);
@@ -3585,7 +3592,8 @@ static void dm_test_fill_stream_content_type(struct kunit *test)
 	ctx->conn_state->content_type = DRM_MODE_CONTENT_TYPE_GRAPHICS;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)ctx->stream->content_type,
 			(int)DISPLAY_CONTENT_TYPE_GRAPHICS);
@@ -3603,12 +3611,121 @@ static void dm_test_fill_stream_aspect_ratio(struct kunit *test)
 	ctx->mode->picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9;
 
 	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
-		&ctx->aconnector->base, ctx->conn_state, NULL, 8);
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_RGB, false);
 
 	KUNIT_EXPECT_EQ(test, (int)timing->aspect_ratio,
 			(int)ASPECT_RATIO_16_9);
 }
 
+/**
+ * dm_test_fill_stream_encoding_from_caller_ycbcr420 - Test caller-selected 420
+ * @test: The KUnit test context
+ *
+ * The helper no longer derives the pixel encoding from the display info; it
+ * applies whatever the caller selected. Passing YCbCr420 must be honoured even
+ * though the DisplayPort sink advertises no YCbCr color formats.
+ */
+static void dm_test_fill_stream_encoding_from_caller_ycbcr420(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_YCBCR420, false);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->pixel_encoding,
+			(int)PIXEL_ENCODING_YCBCR420);
+}
+
+/**
+ * dm_test_fill_stream_encoding_from_caller_ycbcr422 - Test caller-selected 422
+ * @test: The KUnit test context
+ *
+ * A caller-selected YCbCr422 encoding is applied verbatim.
+ */
+static void dm_test_fill_stream_encoding_from_caller_ycbcr422(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_YCBCR422, false);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->pixel_encoding,
+			(int)PIXEL_ENCODING_YCBCR422);
+}
+
+/**
+ * dm_test_fill_stream_encoding_from_caller_ycbcr444 - Test caller-selected 444
+ * @test: The KUnit test context
+ *
+ * A caller-selected YCbCr444 encoding is applied verbatim.
+ */
+static void dm_test_fill_stream_encoding_from_caller_ycbcr444(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_YCBCR444, false);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->pixel_encoding,
+			(int)PIXEL_ENCODING_YCBCR444);
+}
+
+/**
+ * dm_test_fill_stream_hdmi_ep_clamps_depth - Test HDMI TMDS depth clamp applied
+ * @test: The KUnit test context
+ *
+ * With is_hdmi_ep set the colour depth is clamped to what the sink's max TMDS
+ * clock allows: a 10bpc request that exceeds the limit is reduced to 8bpc.
+ */
+static void dm_test_fill_stream_hdmi_ep_clamps_depth(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	ctx->aconnector->base.display_info.bpc = 10;
+	/* 10bpc RGB needs 185625 KHz, over the sink's 160 MHz TMDS limit. */
+	ctx->aconnector->base.display_info.max_tmds_clock = 160000;
+	ctx->mode->crtc_clock = 148500;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 10,
+		PIXEL_ENCODING_RGB, true);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->display_color_depth,
+			(int)COLOR_DEPTH_888);
+}
+
+/**
+ * dm_test_fill_stream_non_hdmi_ep_keeps_depth - Test no TMDS clamp off HDMI
+ * @test: The KUnit test context
+ *
+ * With is_hdmi_ep clear the TMDS clamp is skipped, so the same over-limit
+ * 10bpc request is left untouched. The clamp is HDMI-specific.
+ */
+static void dm_test_fill_stream_non_hdmi_ep_keeps_depth(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	ctx->aconnector->base.display_info.bpc = 10;
+	ctx->aconnector->base.display_info.max_tmds_clock = 160000;
+	ctx->mode->crtc_clock = 148500;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 10,
+		PIXEL_ENCODING_RGB, false);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->display_color_depth,
+			(int)COLOR_DEPTH_101010);
+}
+
 /* Tests for create_stream_for_sink() */
 
 /*
@@ -3687,7 +3804,8 @@ static void dm_test_create_stream_fake_sink_success(struct kunit *test)
 	struct dc_stream_state *stream;
 
 	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
-					ctx->dm_state, NULL, 8);
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
 
 	KUNIT_ASSERT_NOT_NULL(test, stream);
 	dc_stream_release(stream);
@@ -3703,7 +3821,8 @@ static void dm_test_create_stream_sets_dm_context(struct kunit *test)
 	struct dc_stream_state *stream;
 
 	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
-					ctx->dm_state, NULL, 8);
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
 
 	KUNIT_ASSERT_NOT_NULL(test, stream);
 	KUNIT_EXPECT_PTR_EQ(test, stream->dm_stream_context, ctx->aconnector);
@@ -3720,7 +3839,8 @@ static void dm_test_create_stream_virtual_signal(struct kunit *test)
 	struct dc_stream_state *stream;
 
 	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
-					ctx->dm_state, NULL, 8);
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
 
 	KUNIT_ASSERT_NOT_NULL(test, stream);
 	KUNIT_EXPECT_EQ(test, (int)stream->signal, (int)SIGNAL_TYPE_VIRTUAL);
@@ -3739,7 +3859,8 @@ static void dm_test_create_stream_scaling_src(struct kunit *test)
 	struct dc_stream_state *stream;
 
 	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
-					ctx->dm_state, NULL, 8);
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
 
 	KUNIT_ASSERT_NOT_NULL(test, stream);
 	KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
@@ -3770,7 +3891,8 @@ static void dm_test_create_stream_existing_sink(struct kunit *test)
 	ctx->aconnector->dc_sink = sink;
 
 	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
-					ctx->dm_state, NULL, 8);
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
 
 	KUNIT_ASSERT_NOT_NULL(test, stream);
 	KUNIT_EXPECT_PTR_EQ(test, stream->sink, sink);
@@ -5456,6 +5578,11 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_fill_stream_color_depth_requested_bpc),
 	KUNIT_CASE(dm_test_fill_stream_content_type),
 	KUNIT_CASE(dm_test_fill_stream_aspect_ratio),
+	KUNIT_CASE(dm_test_fill_stream_encoding_from_caller_ycbcr420),
+	KUNIT_CASE(dm_test_fill_stream_encoding_from_caller_ycbcr422),
+	KUNIT_CASE(dm_test_fill_stream_encoding_from_caller_ycbcr444),
+	KUNIT_CASE(dm_test_fill_stream_hdmi_ep_clamps_depth),
+	KUNIT_CASE(dm_test_fill_stream_non_hdmi_ep_keeps_depth),
 	/* create_stream_for_sink */
 	KUNIT_CASE(dm_test_create_stream_fake_sink_success),
 	KUNIT_CASE(dm_test_create_stream_sets_dm_context),
-- 
2.34.1

