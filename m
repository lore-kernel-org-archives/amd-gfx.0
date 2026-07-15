Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B24C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49DA610F080;
	Wed, 15 Jul 2026 13:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w/OMRuzc";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B4410F07C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6CY9TceLCeussk9LgzNUufjSIfKCAjpcHc2LN0wXf3UaWXVZk1Rf/AMocpbM7PqqaP6gqJF0msdeuiIMrGZYM0t6T26GzPz9vPaESXPwPv9p4I4cW8KZ79h/kj/mhDXVbD8a6mLgsZBpRu1/yl1+ZImITWb/1jPDB0XBqsOqPVmbYN/z1hskc/l1wZAsyM8BVFy77brxMdGXY+sddZSxehT5zagaF9ZoxqJnoHPLfPOYu5gZ2t0thf1JVCe3aZlO9YsrE6NNCbJRFbMBfTW8Wrb0mK4AnOlSyFKjKWJZ2USaX0tuOXn4EqTCEOiBCuWnMF4opgpfDHSsWmkFL8Edg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXyN1vEeGNGz9a6drXG5Z5AVth/Ehp/wIuPRthcbksk=;
 b=CJGdT6mW6JVehHwHMdkqmbSwML1+4pkZP6WazCMXnR85GGqYp/Cmvd344KKS/JoY4BeXZweFVIF03h6+RMMe/0BC/PdTrCSIhb6ZCajgakFarYzHzoKJsA+f1AzcLSJpLnLKpkTkrIFm33I7CwKcNYfMHZHAW/Rbl8pxSa974zx453QxKTntUpfVz9ldrLKY3zaG6eaBy4u64W3e63QCjB1zPS4XS7X/ptcS67CkMZiBS+5EOFPK6uva7WYaAU3PyT6KImRULKwPlMLLNVx8tddPthHTyeld1fEuGZlT+111sETEHHen8P4sNr6sKHXPGdshcMaRKuLFq282W/acyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXyN1vEeGNGz9a6drXG5Z5AVth/Ehp/wIuPRthcbksk=;
 b=w/OMRuzcqmcTZlNjfmzaDvTtIgClK7TlA03uGsuiQohjZJbSB0Y3yVkZOyq7eiPR7MEvIlpMUdXG8iMu4Z01uc8xHnqYQXg6mN59a2enJ/0kk8VtG3Bnx9aAPgFwxvef9c6PtbkXiRvOhw8YiOWDJgRgpr5NCZRfmON/jTVd5Zg=
Received: from SJ2P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::18)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:46:07 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::a4) by SJ2P220CA0008.outlook.office365.com
 (2603:10b6:a03:5da::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:45:54 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 16/70] drm/amd/display: Add stream creation tests for connector
Date: Wed, 15 Jul 2026 21:37:26 +0800
Message-ID: <20260715134432.1975118-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: d801ad66-e68e-48b1-c2ee-08dee2776b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|56012099006|11063799006|3023799007|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: YGqFT4dOs1GIOLUaGqUbbyOxy0F9xbbidEWSHhLZanW9P4a4zc2eBDuTmHTpcBLLJ/ZCqi0w6dxC+jgEIcGmldixo0mXoARNwnErTug8hcb6uVCZyvZTENKqpnUJ7kBDui4XQ7o9KJWPuy+B8DYNIv7mK95SG3J6o7kBDrbwqReU0a7Q8MLqxB5J9ZwwCLYhtXzqaHPoMgt8xWug+7sIDRGLsVCVqdROsNT4KNZwiy9+8UCtVfI/AX7GFXwTr5kjI6LG/3FEFxNtFhrj+qHSoEwi6ssyNX+AOQLjBc+e+UrI4Er3vf7nkSWXc5QfgUODacVjk6yD0klD8IY9hBqgfq3EHht+CSjJQGMFlGk8itZOibBlfuHI5Pr9PaD1WWUg0yXVfYHK1ZDjFtDyFQrqWuNG7iXNJdsREvplWJdDKy1KgyREAiAZPktpUi+B7obVzvPOTpddD7RAj1uTC78aBjNo6KjXTxoconfam9Xse/2c+dclv89p1xJrl4RLpWoPZJtdSwt8eBNWKDL107UlnuDHVO/KwZaLhSUHoNfJG9hDr9uJvFMsavdA0kMFXbZDlxPIE12jTaClww8IidO68hEF6Lm2ulLlpM6+HQd/y5djUHlMlOevdVwcds0BbTBXIKqFhdFTevzYIcdcTICPxO3dE26ehF260indgq3zHwPuI2QmL0ssvcMH8zsV2hC+8yjMgEM7Ahz4aHKSkp70Hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YqzrY3ROqtPv8RNvsDzInpdDVlfpISPZFBvbeZRjoLjDNt3fXrvjrALh3rD1DxNx8f6ERz3FUxkJbZfhLx7uZ6MTgSzmiARgaT1RgfLuF0Vt/5coJPDkvLNsmFWsRHq5KMWgg7l1x1KVw1hsoSOUsj4pT9GhVypux7wHXbwSnHt4MY7X2tF8jaKWm1gzG0oRYtgz7a+cCpaebcvGuOx6adrZxHefBmbhByYfartEqe1YTOKdkZQevdMisQv2LC6ucGTzWlKgWerGOg/SqpPu8BburSrrxrF1IwTqs1RAxEu1yRvCgsMp6jrjwncvoNO5YgDjVdwtrxesVkfYsy5tRs9vHFyIxhRrT/FayMjTBT1e29iAzyhikzt1QKVSq3Ri61cfPECU1TBZKqUrNXEP1JnKz3rRNpYGXkR+Tr8a4z3jx6RgzoSFc+zJaz93ke8h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:06.3722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d801ad66-e68e-48b1-c2ee-08dee2776b74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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

Add KUnit coverage for create_stream_for_sink(): fake sink success,
dm context setup, virtual signal handling, scaling source, and reuse
of an existing sink.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   6 +
 .../tests/amdgpu_dm_connector_test.c          | 176 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c |   2 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   2 +
 5 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index c7d8810958f6..5c3dd1eb7878 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1345,7 +1345,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 }
 #endif
 
-static struct dc_stream_state *
+STATIC_IFN_KUNIT struct dc_stream_state *
 create_stream_for_sink(struct drm_connector *connector,
 		       const struct drm_display_mode *drm_mode,
 		       const struct dm_connector_state *dm_state,
@@ -1529,6 +1529,7 @@ create_stream_for_sink(struct drm_connector *connector,
 
 	return stream;
 }
+EXPORT_IF_KUNIT(create_stream_for_sink);
 
 /**
  * amdgpu_dm_connector_poll - Poll a connector to see if it's connected to a display
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index ad277fff57de..51858c92f922 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -158,6 +158,12 @@ void fill_stream_properties_from_drm_display_mode(
 	const struct drm_connector_state *connector_state,
 	const struct dc_stream_state *old_stream,
 	int requested_bpc);
+struct dc_stream_state *
+create_stream_for_sink(struct drm_connector *connector,
+		       const struct drm_display_mode *drm_mode,
+		       const struct dm_connector_state *dm_state,
+		       const struct dc_stream_state *old_stream,
+		       int requested_bpc);
 enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state);
 bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index b3d16123402d..2d58021b48f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -3604,6 +3604,176 @@ static void dm_test_fill_stream_aspect_ratio(struct kunit *test)
 			(int)ASPECT_RATIO_16_9);
 }
 
+/* Tests for create_stream_for_sink() */
+
+/*
+ * Build the inputs for create_stream_for_sink(). The connector is registered
+ * against a real kunit drm_device so that to_amdgpu_dm_connector() and the drm
+ * debug helpers resolve. The DC link carries a zeroed dc_context so that
+ * dc_create_stream_for_sink() can allocate and construct a stream.
+ *
+ * By default no dc_sink is attached, so create_stream_for_sink() builds a fake
+ * VIRTUAL sink. The VIRTUAL signal keeps the DSC, audio and DP/HDMI infoframe
+ * paths as no-ops, making the exercised behaviour deterministic.
+ */
+struct dm_test_stream_ctx {
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_context *dc_ctx;
+	struct dc_link *link;
+	struct dm_connector_state *dm_state;
+	struct drm_display_mode *mode;
+};
+
+static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx;
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
+	ctx->dc_ctx = kunit_kzalloc(test, sizeof(*ctx->dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc_ctx);
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	ctx->link->ctx = ctx->dc_ctx;
+	ctx->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	ctx->aconnector->dc_link = ctx->link;
+	ctx->aconnector->dc_sink = NULL;
+
+	ctx->dm_state = kunit_kzalloc(test, sizeof(*ctx->dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dm_state);
+	ctx->dm_state->scaling = RMX_OFF;
+
+	ctx->mode = kunit_kzalloc(test, sizeof(*ctx->mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->mode);
+	ctx->mode->hdisplay = 1920;
+	ctx->mode->vdisplay = 1080;
+	ctx->mode->clock = 148500;
+
+	return ctx;
+}
+
+/**
+ * dm_test_create_stream_fake_sink_success - Test a stream is built from a fake sink
+ * @test: The KUnit test context
+ */
+static void dm_test_create_stream_fake_sink_success(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_stream_state *stream;
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_sets_dm_context - Test dm_stream_context points to aconnector
+ * @test: The KUnit test context
+ */
+static void dm_test_create_stream_sets_dm_context(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_stream_state *stream;
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_PTR_EQ(test, stream->dm_stream_context, ctx->aconnector);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_virtual_signal - Test the fake sink yields a VIRTUAL signal
+ * @test: The KUnit test context
+ */
+static void dm_test_create_stream_virtual_signal(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_stream_state *stream;
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_EQ(test, (int)stream->signal, (int)SIGNAL_TYPE_VIRTUAL);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_scaling_src - Test the source rect follows the mode
+ * @test: The KUnit test context
+ *
+ * With scaling off the full-screen source viewport matches the requested mode.
+ */
+static void dm_test_create_stream_scaling_src(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_stream_state *stream;
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
+	KUNIT_EXPECT_EQ(test, (int)stream->src.height, 1080);
+	dc_stream_release(stream);
+}
+
+/**
+ * dm_test_create_stream_existing_sink - Test the existing-sink retain path
+ * @test: The KUnit test context
+ *
+ * When the connector already has a dc_sink, create_stream_for_sink() reuses it
+ * instead of building a fake sink.
+ */
+static void dm_test_create_stream_existing_sink(struct kunit *test)
+{
+	struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc(test);
+	struct dc_sink_init_data sink_init = { 0 };
+	struct dc_stream_state *stream;
+	struct dc_sink *sink;
+
+	sink_init.link = ctx->link;
+	sink_init.sink_signal = SIGNAL_TYPE_VIRTUAL;
+	sink = dc_sink_create(&sink_init);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	sink->sink_signal = SIGNAL_TYPE_VIRTUAL;
+
+	ctx->aconnector->dc_sink = sink;
+
+	stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+					ctx->dm_state, NULL, 8);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_PTR_EQ(test, stream->sink, sink);
+
+	dc_stream_release(stream);
+	dc_sink_release(sink);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -3798,6 +3968,12 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_fill_stream_color_depth_requested_bpc),
 	KUNIT_CASE(dm_test_fill_stream_content_type),
 	KUNIT_CASE(dm_test_fill_stream_aspect_ratio),
+	/* create_stream_for_sink */
+	KUNIT_CASE(dm_test_create_stream_fake_sink_success),
+	KUNIT_CASE(dm_test_create_stream_sets_dm_context),
+	KUNIT_CASE(dm_test_create_stream_virtual_signal),
+	KUNIT_CASE(dm_test_create_stream_scaling_src),
+	KUNIT_CASE(dm_test_create_stream_existing_sink),
 	{}
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
index 455fa5dd1420..436d033361ab 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
@@ -73,6 +73,7 @@ void dc_sink_release(struct dc_sink *sink)
 {
 	kref_put(&sink->refcount, dc_sink_free);
 }
+EXPORT_IF_KUNIT(dc_sink_release);
 
 struct dc_sink *dc_sink_create(const struct dc_sink_init_data *init_params)
 {
@@ -94,6 +95,7 @@ struct dc_sink *dc_sink_create(const struct dc_sink_init_data *init_params)
 alloc_fail:
 	return NULL;
 }
+EXPORT_IF_KUNIT(dc_sink_create);
 
 /*******************************************************************************
  * Protected functions - visible only inside of DC (not visible in DM)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index ce045ef6347c..a32b6eb796f7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -24,6 +24,7 @@
  */
 
 #include "dm_services.h"
+#include "dm_helpers.h"
 #include "basics/dc_common.h"
 #include "dc.h"
 #include "core_types.h"
@@ -203,6 +204,7 @@ void dc_stream_release(struct dc_stream_state *stream)
 		kref_put(&stream->refcount, dc_stream_free);
 	}
 }
+EXPORT_IF_KUNIT(dc_stream_release);
 
 struct dc_stream_state *dc_create_stream_for_sink(
 		struct dc_sink *sink)
-- 
2.43.0

