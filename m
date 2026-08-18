Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80926C5DF8D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD5210ECB3;
	Tue, 18 Aug 2026 20:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TnnF5Nli";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E9D10ECAF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjStGa6hOrMLxLfIveO1dx3kwk3I1tAe6T2oSVKNcXWMgK+i2OLkgykoFZEs4E2r9xuCiL12L89VmNJA2nXGQTPzgl5B3S1ZgcVGyM6ZiGgHSDeLAygXhqkR5s45nSDLxxAldKJ3XL/4kH1cW9YJfmtxAfKm7y6Es47d4wwVNNBtzj8PQRk/s1+u9jhHsANQ9e5WtuWWlwymgCgfrCzh0ImWD6/m5Pnzs0W+rT3nKmPpeOb0HYsMiKNavL5wNUEenfHawhR+yxkQspDnyUQS1KQOZ1xvJ7EYeXVlvA0C9Yccc6rA9AM+ikrrh6Bvw1La2bv3hsgf9vlYUlLxl9qORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q748nrQK1E2Gt38SYVvrqhh5KMfqqfffETY0TAQcXrA=;
 b=x/Z1LX5b7NUcKE/S6fjWWat8l3xHTdErPTTkgoQqhMSHs5yGKUtqU0GYjzn4vWtrwMOO67ccGjwGvF/ieSYsgipB71zR6n6SOJm6DTOYPiCoY3fsHzTXOXAO0mef1Am4HQCfc/aoF5nVWjF1mR0DWMiupdgL1YTaH7iRC88LVeZ+uBLT2UrNvtDsPgfdteGyfxCzf+Ui7l6lh+0/Urg35gRRVLilzFnJFosTbC7SEjpnrqR+tdm/K5hc3D3oO7dtz9VaRHJGP+Eh+7swy/SdIgPU5/wgZH1rPXWdssiXk/s9SPjXNVePtDxE84q6puv7nRB17xVhgMjMcHyPEtNkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q748nrQK1E2Gt38SYVvrqhh5KMfqqfffETY0TAQcXrA=;
 b=TnnF5NliYFSdKEoWILh6yzm3bXCTDFGNck1SMomykWGWbMiv/pt+o74QS1T96GNqRbg/C67h1v1EGQ4bk8bxKZHi/J/KNFOQbQT5aMQVSIzF4uAOZXZaUzl7PmoLaOhCKNLJI1NhSz/4963zlTUB8tlOe63xSDsFV+8EsXAqWfk=
Received: from BN9PR03CA0350.namprd03.prod.outlook.com (2603:10b6:408:f6::25)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:39 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::1) by BN9PR03CA0350.outlook.office365.com
 (2603:10b6:408:f6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:18 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:18 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 35/82] drm/amd/display: Cover dm_validate_stream_and_context
Date: Tue, 18 Aug 2026 16:15:27 -0400
Message-ID: <20260818202139.4172592-36-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: d341f83a-5a71-4e65-df33-08defd66731a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /olwqHyvYl8xEk7K/vTdP5+12+6KF3Qsx2ixks5EcQBDmH8YWitIYKhjimXNIi9v0JmnBykbST26ZY+3U43wHC6/pQMlF4OnXZD3C04PcAr+ma1CivGrMwnPI7otOVE1oi+eEDLaU7UsiAARgCOZ8LRMmoD/tALy5qPvPvImb4A59RMXbVrofSmmrt0PgH4QzB3Tvx1VbYUNTA8+X9DRMfRx6hdKqs6/gMxD/uqOTttWAWrTEOd9vpIZWjUhZ5Jkjsw+OThjWzWX5kI2uBLTsAd3YlfE/CjMXB/V4bD3ZvfixXW1vNgL1rXogW5m1SJ/QCUiV6dCXcFnVIa627veQrJCecVx9Xm4lir5wf0NimoIBz81mwzFnatxY++7V9GEoRy3H4WiC+mYDTR8t/4pBFO28UfBUe5SONbD0XEvDbTf8qkAdX6g+AXqol3ELACskGjixT+zNgjAcI/ks07fsxss6UuOzrQp/mHXDRAqnxgvF7cCzRkfyLzr6dp0k8GMZPGUSdpf2DWvI5HpmymyCjQu/u2HLliF2j5YAeIdFquD6zA3t3Imn/j2CQBHNrcxNszjjMa1wQ1+C0c3mMO0uw3XTvmSreGtvNbYwzEpy2vWB8/2z1gTrVQvg4OAEX4bAeKNbx8JQAFFJ/tYlng1eR8v+Ptpm1KTklidTGb3T0suTqVKfcS9eMM5YxhpZ25gmQ1B6fcuYOHIVI/mUeWhKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CjNvmRYh93+oRx3ES07R++uJ6+ER1/p8WVKkytTiZBSwSbZCpoq5EA7wyo8JCMKEhZV/GdhR4/xRqRIUFydvVaYZYSDyTWlWN5sUzg5ey0LaPWnVKXNvY6TsbAuFe47td4BIaTIDCgjLSvO/0RDM/c5mt57SOf6GVdmsNeo2AcIbVMkalowFwS9jld+ojNgglXErnZq+aFYwj78prYg9+LXQDKXK1ZNjGcbvlynmyftIp5OLZ2K2ghhTzXDc8Ovb0PVJJBEu53ScV+T07mHps0MqJie+VF4xdXPJsHYJ3buyb2c89wkxdCzDbyolEBBpqje+IdX3yILqj2ce9zPSZHzFrtHSosp8XHqkMT6m0EZbnyQ/LT+zAvIwGRXObliQY+zlMJXNrO0jeL8otMYbhpens7zWAT4Id0JzyiVnFfMHMPRRMtDX4oKDNC8JjWNS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:39.2312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d341f83a-5a71-4e65-df33-08defd66731a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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

Add dm_test_validate_stream_dc_ok_no_pipe which builds a minimal fake
dc so stream and plane validation both pass, then lets
dc_state_add_stream() bail out early via timing_generator_count == 0 to
avoid deep pipe allocation, raising coverage from 24% to 90%.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 55cf9c3708394..54d6d2acdd7dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -30,6 +30,8 @@
 #include "include/grph_object_id.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 #include "inc/link_service.h"
+#include "inc/resource.h"
+#include "inc/hw/timing_generator.h"
 
 /* Tests for get_subconnector_type() */
 
@@ -5202,6 +5204,87 @@ static void dm_test_validate_stream_null_stream(struct kunit *test)
 			(int)DC_ERROR_UNEXPECTED);
 }
 
+static bool dm_test_vs_validate_timing_true(struct timing_generator *tg,
+					     const struct dc_crtc_timing *timing)
+{
+	return true;
+}
+
+static enum dc_status dm_test_vs_validate_mode_timing_ok(
+		const struct dc_stream_state *stream,
+		struct dc_link *link,
+		const struct dc_crtc_timing *timing)
+{
+	return DC_OK;
+}
+
+/**
+ * dm_test_validate_stream_dc_ok_no_pipe - Exercise the full validation body
+ * @test: The KUnit test context
+ *
+ * Build a minimal fake dc so stream and plane validation both pass, then
+ * let dc_state_add_stream() bail out early (timing_generator_count == 0) so
+ * the deep pipe-allocation paths are avoided. This drives plane population,
+ * dc_validate_stream(), dc_validate_plane() and cleanup.
+ */
+static void dm_test_validate_stream_dc_ok_no_pipe(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct dc *dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	struct dc_context *ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	struct dal_logger *logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
+	struct resource_pool *pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
+	struct resource_funcs *rfuncs = kunit_kzalloc(test, sizeof(*rfuncs), GFP_KERNEL);
+	struct resource_caps *rcaps = kunit_kzalloc(test, sizeof(*rcaps), GFP_KERNEL);
+	struct timing_generator *tg = kunit_kzalloc(test, sizeof(*tg), GFP_KERNEL);
+	struct timing_generator_funcs *tgfuncs =
+		kunit_kzalloc(test, sizeof(*tgfuncs), GFP_KERNEL);
+	struct link_service *link_srv =
+		kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	struct dc_stream_state *stream =
+		kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, logger);
+	KUNIT_ASSERT_NOT_NULL(test, pool);
+	KUNIT_ASSERT_NOT_NULL(test, rfuncs);
+	KUNIT_ASSERT_NOT_NULL(test, rcaps);
+	KUNIT_ASSERT_NOT_NULL(test, tg);
+	KUNIT_ASSERT_NOT_NULL(test, tgfuncs);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	logger->dev = drm;
+	ctx->logger = logger;
+
+	tgfuncs->validate_timing = dm_test_vs_validate_timing_true;
+	tg->funcs = tgfuncs;
+
+	pool->funcs = rfuncs;
+	pool->res_cap = rcaps;
+	pool->timing_generators[0] = tg;
+	pool->timing_generator_count = 0;
+
+	link_srv->validate_mode_timing = dm_test_vs_validate_mode_timing_ok;
+
+	dc->ctx = ctx;
+	dc->res_pool = pool;
+	dc->link_srv = link_srv;
+
+	link->ep_type = DISPLAY_ENDPOINT_UNKNOWN;
+	stream->link = link;
+	stream->src.width = 1920;
+	stream->src.height = 1080;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_validate_stream_and_context(dc, stream),
+			(int)DC_ERROR_UNEXPECTED);
+}
+
 /**
  * dm_test_to_encoder_no_encoder - Test connector with no encoder returns NULL
  * @test: The KUnit test context
@@ -6589,6 +6672,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_funcs_force_no_edid),
 	/* dm_validate_stream_and_context */
 	KUNIT_CASE(dm_test_validate_stream_null_stream),
+	KUNIT_CASE(dm_test_validate_stream_dc_ok_no_pipe),
 	/* amdgpu_dm_connector_to_encoder */
 	KUNIT_CASE(dm_test_to_encoder_no_encoder),
 	KUNIT_CASE(dm_test_to_encoder_returns_attached),
-- 
2.43.0

