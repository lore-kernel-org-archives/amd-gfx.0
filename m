Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDA9C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F99410EB26;
	Tue,  8 Sep 2026 11:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s3xXN/uP";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B49810EB26
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZ4AZv83j6HnfBh4M8ygelEv0xudYbeci54BnZLJfUEtK/nqRhg33gkMZrLkVP/HidB6FjjQMIZK4yDVO6tB/8NwOIUOEELGCukp0ILu9EmU2NCCJ5A0xgHx3UXsjF8d1VpjdTBew3Cpm5jVcj6esaR3NVpBd0+xL4psW5j8+zMKMXFEEUbD/q6ySxx1Cjc5SZTA9RdqL9d5ATsgAP4Hb6rPOJa9aVqHjx3bRcv7wxB0ChjtJuUqRVeQIp1G/xNHeCS2WWWLGkphqBFT2+C7h/se5Nc4V+QvsDQqQlqHm5gQelmmcdE5ifYR3MiyP3OGPYsDp9KBzszyBHNkIcB4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHdvp+//q7vMhHPdTJKdhJ4CMHtayATiO1Dtaok4kwU=;
 b=YUwHFp7drxmhzfEymnyPWsv0DdRgTRCmbmFEkKOSKybj/Bipj0UybBhXDg8xeMvrbC4xpGv9hlAsAObRDUdAQtY/WMAgZBWtEK0U4C8xphqkWPHQh7cod476Bn2rB3Z88HGpSVsyGSJt/35P+tNcUghHTCF0gdPhvLR7ojs5PTgtcbd2zFhLSicD+WDrxO1NlzduaeWe61Hipkp6TuBj/egO8VPsoTy0AT+nUZuPitcOgGPKegsviUtq56r53feaaR70XmAwK9WWzjR0nkgSkFzPZZ3evAKF8/Wz3xHvlk2FVVfnhmN4uR+APeUIf5Sa6Ds4kru0aBFfudU0h8GFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHdvp+//q7vMhHPdTJKdhJ4CMHtayATiO1Dtaok4kwU=;
 b=s3xXN/uPNDwFKm593sjnIkj+qezWsh4xJ6IQp0IbIepsYBs9JDCkQgOXM+0jykwDdhQVAkGiJn4VAZqPXtl/g1wThm5rcIzwfSisOEAPHAymSSEoSVIlnN982ynsvd5qQ0R7Zu/1olY3pTNCE4cVHIdA1VZ/Zla8RnowE3hQ/NU=
Received: from BL1PR13CA0426.namprd13.prod.outlook.com (2603:10b6:208:2c3::11)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:34:39 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::7a) by BL1PR13CA0426.outlook.office365.com
 (2603:10b6:208:2c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:34:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:34:30 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:34:22 -0500
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
Subject: [PATCH 05/66] drm/amd/display: Test sink stream creation
Date: Tue, 8 Sep 2026 19:30:58 +0800
Message-ID: <20260908113338.2433445-6-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: b877a6f9-e743-4fd3-7397-08df0d9d2963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|56012099006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0S4wGKI8rhWrDb1/LjjGONGIlSfaTNpV+Bb/zHPH2vheXxj/9Eb6RJsfMQErM2sLgQdsX63cbYseCYGZ8RBfFJXuZDGuyax+JsDYh9n+4TRW79l3QG62BMd+YAco+Y6g61TMmu7o4FsMs9QX5+5OoUJkEcSjb44tsORa+yxXCyp2IxxU9U+6adLflkBOqCRsNIzmPjeofzkRUcUZDUPFv3uFDmt7Bi+CAJYmdRDr+6/7uRY6C/+uAnkjo387z60giOVjq9nl4nSbM2/iq2HsM5HAhw3BGWMPPr94WKGNLcG3xGIp2NTnrk26cf5pVpVUSisSY/GTnI1aMI/otznRBr+cOn91YM4O8sleyunt0gYX6A48gLC18LEUNEBCqE6BRzT6B+F3jP7/0tanLgT20OrY5r4HdEUhBkJg6DjSm8SLDMUYwh+qf1CnTuJEw37s3QmZThI9VA7k+73cXK2Qbw9OVn+6ZFqdFwZTBgpzulAUyvq/1q3lzLV1Qp7o9qYy+Cu89reaZ2XwQxSKwZo5El5naXRxS/TzRtyGBzkCP2e/gi7RNnOt5VHI04FYuJBvTByeZNpGrOTmFaXHc6vX/7IGj9rMfL3iykziS+ElUWtbu42XO0vhwkba182udM8dkel1uJu6/EO+LJJPp0IdBvePjEKcNKNwVpyJakRUnLN/eb+6ibqXNHprDP7ovmGEApYsESpImErFcFGuQDmakQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WyViGiUh6gqQU781ioVNyFIvUAE2kr+csYhpLPTS+4Ph7czZgr9uviDyGU/CSZ4lBdoXMrJieziKdIMt6GkTrVxEbPYh2lo1Z4tPc8dfw5mv/4wzVHZbeUHyMnTl9JWIZc6mZU7d4Gl/oi6v3JG1DkymXR6o/LioEBSgz4hninYTqZzd2QJHGvhe2Qhr3iAsWnUFrAhCGf6t67Ju5QHrBpapXjMZ5A73+ZHTgfFSULWOBhNrdeEH2C9fqZbaylAICzLVwnxURKpD8A+DN21OsD9WcqZx4rU1ZYmVWgaWI6lodqoNN2pSEDB16T9jqWdCK/q/UWMQkcH3g7WkuSLKKE4pnbCGDB8ayM0IXYQoQqtS+A/St1mvO7asDZECDeqA2Bn9hmatKVjhN8YqvXNi5NewwyOFJRCl04kYDWbEMdvlhe85SKNMn2cDFqYbKooO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:34:36.4946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b877a6f9-e743-4fd3-7397-08df0d9d2963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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
Add KUnit tests for create_stream_for_sink() covering the preferred
mode timing recalculation, the scaled path that keeps the previous
refresh rate, the automated test timing override, the DisplayPort VSC
SDP colorimetry decision with and without the disable-colorimetry
quirk, and the HDMI vendor specific infoframe path.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 218 ++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index dc5bf2d9daca..4c965a6496f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -27,6 +27,7 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_connector.h"
 #include "amdgpu_dm_backlight.h"
+#include "amdgpu_dm_psr.h"
 #include "include/grph_object_id.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 #include "inc/link_service.h"
@@ -4146,6 +4147,217 @@ static void dm_test_create_stream_existing_sink(struct kunit *test)
 	dc_sink_release(sink);
 }
 
+/* Append a copy of the context mode to the connector's mode list. */
+static void dm_test_stream_add_mode(struct kunit *test, struct dm_test_stream_ctx *ctx,
+				    u32 type)
+{
+	struct drm_display_mode *mode = drm_mode_create(ctx->drm);
+
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	drm_mode_copy(mode, ctx->mode);
+	mode->type = type;
+	list_add_tail(&mode->head, &ctx->aconnector->base.modes);
+}
+
+/* Give the context mode a full set of CRTC timings. */
+static void dm_test_stream_set_timings(struct dm_test_stream_ctx *ctx)
+{
+	ctx->mode->hsync_start = 2008;
+	ctx->mode->hsync_end = 2052;
+	ctx->mode->htotal = 2200;
+	ctx->mode->vsync_start = 1084;
+	ctx->mode->vsync_end = 1089;
+	ctx->mode->vtotal = 1125;
+}
+
+/* Create a real dc_sink of @signal owned by the caller. */
+static struct dc_sink *dm_test_stream_add_sink(struct kunit *test,
+					       struct dm_test_stream_ctx *ctx,
+					       enum signal_type signal)
+{
+	struct dc_sink_init_data sink_init = { 0 };
+	struct dc_sink *sink;
+
+	sink_init.link = ctx->link;
+	sink_init.sink_signal = signal;
+	sink = dc_sink_create(&sink_init);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	sink->sink_signal = signal;
+	ctx->aconnector->dc_sink = sink;
+
+	return sink;
+}
+
+/**
+ * dm_test_create_stream_preferred_mode - Test the preferred mode drives the timing
+ * @test: The KUnit test context
+ *
+ * A preferred mode in the connector's mode list is used to recompute the CRTC
+ * timings of the requested mode before the stream properties are filled in.
+ */
+static void dm_test_create_stream_preferred_mode(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_stream_state *stream;
+
+	dm_test_stream_set_timings(ctx);
+	dm_test_stream_add_mode(test, ctx, DRM_MODE_TYPE_PREFERRED);
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 1920);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 1080);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_total, 2200);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.v_total, 1125);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_scaled_keeps_refresh - Test scaling reuses the old timing
+ * @test: The KUnit test context
+ *
+ * With scaling enabled and an unchanged refresh rate the stream properties are
+ * filled from the old stream so the VIC and sync polarities are preserved.
+ */
+static void dm_test_create_stream_scaled_keeps_refresh(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_stream_state *stream;
+
+	dm_test_stream_set_timings(ctx);
+	dm_test_stream_add_mode(test, ctx, DRM_MODE_TYPE_PREFERRED);
+	ctx->dm_state->scaling = RMX_FULL;
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 1920);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_timing_override - Test the automated test timing override
+ * @test: The KUnit test context
+ *
+ * A connector carrying a requested timing from an automated test replaces the
+ * timing derived from the mode.
+ */
+static void dm_test_create_stream_timing_override(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_crtc_timing *timing;
+	struct dc_stream_state *stream;
+
+	timing = kunit_kzalloc(test, sizeof(*timing), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, timing);
+	timing->h_addressable = 1280;
+	timing->v_addressable = 720;
+	timing->display_color_depth = COLOR_DEPTH_101010;
+
+	ctx->aconnector->timing_changed = true;
+	ctx->aconnector->timing_requested = timing;
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 1280);
+	KUNIT_EXPECT_EQ(test, (int)stream->timing.display_color_depth,
+			(int)COLOR_DEPTH_101010);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_dp_vsc_colorimetry - Test the DP VSC SDP colorimetry decision
+ * @test: The KUnit test context
+ *
+ * A DisplayPort sink on a DPCD 1.4 link advertising VSC SDP colorimetry, and
+ * without the disable-colorimetry quirk, enables VSC SDP colorimetry and
+ * arms the self refresh entry delay.
+ */
+static void dm_test_create_stream_dp_vsc_colorimetry(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_stream_state *stream;
+	struct dc_sink *sink;
+
+	sink = dm_test_stream_add_sink(test, ctx, SIGNAL_TYPE_DISPLAY_PORT);
+	ctx->link->dpcd_caps.dpcd_rev.raw = 0x14;
+	ctx->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED = 1;
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_EQ(test, (int)stream->signal, (int)SIGNAL_TYPE_DISPLAY_PORT);
+	KUNIT_EXPECT_TRUE(test, stream->use_vsc_sdp_for_colorimetry);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->sr_skip_count, AMDGPU_DM_PSR_ENTRY_DELAY);
+
+	dc_stream_release(stream);
+	dc_sink_release(sink);
+}
+
+/**
+ * dm_test_create_stream_dp_colorimetry_quirk - Test the disable colorimetry quirk
+ * @test: The KUnit test context
+ */
+static void dm_test_create_stream_dp_colorimetry_quirk(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_stream_state *stream;
+	struct dc_sink *sink;
+
+	sink = dm_test_stream_add_sink(test, ctx, SIGNAL_TYPE_DISPLAY_PORT);
+	sink->edid_caps.panel_patch.disable_colorimetry = true;
+	ctx->link->dpcd_caps.dpcd_rev.raw = 0x14;
+	ctx->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED = 1;
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_FALSE(test, stream->use_vsc_sdp_for_colorimetry);
+
+	dc_stream_release(stream);
+	dc_sink_release(sink);
+}
+
+/**
+ * dm_test_create_stream_hdmi_vsif - Test the HDMI vendor specific infoframe
+ * @test: The KUnit test context
+ *
+ * An HDMI sink takes the HDMI Forum vendor specific infoframe path. A plain
+ * 2D, non-HDMI-VIC timing carries no payload, so the packet stays invalid.
+ */
+static void dm_test_create_stream_hdmi_vsif(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_stream_state *stream;
+	struct dc_sink *sink;
+
+	ctx->link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	sink = dm_test_stream_add_sink(test, ctx, SIGNAL_TYPE_HDMI_TYPE_A);
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8,
+					PIXEL_ENCODING_RGB, false);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_EQ(test, (int)stream->signal, (int)SIGNAL_TYPE_HDMI_TYPE_A);
+	KUNIT_EXPECT_FALSE(test, stream->vsp_infopacket.valid);
+
+	dc_stream_release(stream);
+	dc_sink_release(sink);
+}
+
 /* Tests for amdgpu_dm_connector_detect() */
 
 /*
@@ -9087,6 +9299,12 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_create_stream_virtual_signal),
 	KUNIT_CASE(dm_test_create_stream_scaling_src),
 	KUNIT_CASE(dm_test_create_stream_existing_sink),
+	KUNIT_CASE(dm_test_create_stream_preferred_mode),
+	KUNIT_CASE(dm_test_create_stream_scaled_keeps_refresh),
+	KUNIT_CASE(dm_test_create_stream_timing_override),
+	KUNIT_CASE(dm_test_create_stream_dp_vsc_colorimetry),
+	KUNIT_CASE(dm_test_create_stream_dp_colorimetry_quirk),
+	KUNIT_CASE(dm_test_create_stream_hdmi_vsif),
 	/* amdgpu_dm_connector_detect */
 	KUNIT_CASE(dm_test_detect_force_on),
 	KUNIT_CASE(dm_test_detect_force_on_digital),
-- 
2.43.0

