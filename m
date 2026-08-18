Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CD4C5DF8A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8CB610ECB2;
	Tue, 18 Aug 2026 20:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qLzx8BEl";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1F210ECB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmnyoTwPhJLOfaws3eLbZ7k1zQpKpwGDMgQdJaLu/fNsXns9p2W5/q1iHLBVFJPyE7NhJcO2oFMWP0zLgXwQtVtyyakRdlRGi2c7HjeQLslFyi5vkI/N9K8dvxZMqqoelQQvZBAlqPa6qd0P6zveFvI2ZBhAoCi23OdKwoBTiiSabqLqYxk6HFeQTXzF+JT5ORaTBAtRBJtQP2STjyYVZ+yX+u9NdHyF4jNV+XMvY+BZwZ5nyASikSlc2upkjWmI2k6TxnxHsh4yfeRcRoq1EAWVwkxc5gW5+dp5U0Ct3OzKXCJOljhoA97Z3rYY1lgjq3pb2p3iMJFckTZv9ZpzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK2I7Qra8tUNOgFGp8IhNtMnsWEqDNdVO3tzFdA/YXE=;
 b=x8boVHQmNiYLOEmjDv2dLO1iBJ7Ab9n2v997bog9k4hc/q08lkaBdyIQWNYnlQeXZQzNYAcGN3/4IzgQE/LPMq+QoYeW5BZHuTvMg1b2bySHuoo+O993Ht6y7jjZeajyIX9bpinAFdJhQtJv3ALg83fGqxlCZKfWfTq6co7QiFjg1qlSIeQi9eMaHL9IsvAuKnjzUg606n3uuz/s2WtsCyYoeJKIAc92UfMxSuEkpXpjorWnHBbmJFMVRdYjFPKP+FkadA2+4pBDoUQEteS2KisSJ0HZKrD4FVc4u9dP/2OHDqpHf6byZ5b/puxXHKzM58ySWwoivhfEjuiFqsiM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK2I7Qra8tUNOgFGp8IhNtMnsWEqDNdVO3tzFdA/YXE=;
 b=qLzx8BEl9ZDw8aF+LLZHpvS631tqEVC3G5hxIKjdKYeV3F4iPIpqCGlplgi9SL+A2lS292fr035dYj7lUHLIuQJTujTZbCS8+OmnF+KG6QYcjqgDh/7ddWDt87sy0IW6BAPxC/vVhQbk1hvkFziqJryYadXs+WTWBPKEbEqwwlY=
Received: from BN9PR03CA0568.namprd03.prod.outlook.com (2603:10b6:408:138::33)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:35 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::83) by BN9PR03CA0568.outlook.office365.com
 (2603:10b6:408:138::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:11 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:11 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 25/82] drm/amd/display: Test dp_handle_test_pattern_request
 patterns
Date: Tue, 18 Aug 2026 16:15:17 -0400
Message-ID: <20260818202139.4172592-26-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 27991b6f-b085-413e-7100-08defd6670da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bS9vCTnrzrZ6xP2xgZEP4oFOxEhQckfRgq3btX1QAlb6hH/1qmTUYLKv8mOoAs5b92KofBddVdlLe2pHuZYHpm2UnOWFs2h6uClk66Lg8kvqmV9Gfr0cKrvNMY1nWlhv6zvLyNQax4Rxln9c7+mqBzkKN38Gui11h45H+jPHXme0Y2xNr5xrREMhlg1iWPEUChtXVrWEMT16ONY3iPaPhAhcjjFELSLmgEzK2wnFaj9ArGr91zp9f0Jq6H77X5rCukPzf8as5MEzXbsK1OmiUJ43lF+3axaHezg65frQa0E7v4Wt4cyJLJTKN5WotpaLlxzAn7/O2W7OY35F2OO4u+1iLemZJm7OLNSWwVBtv/p0W6MaREc+8lJmGB9Fa42Jio57NxltOLN0YU0cVsB9c3XKVssrTJHzQ4EmlDp3U5/KZoMLd9X9GM5U3KxVBYsLys3zwi+loVDcv3cFL7SNsIFaxXIFNaq3t9ZPV/vhOyJFwI2OCzsRHUNXIzWNQVqr0WvXA9SdTF1yEnECUJTIhEd5QSzBYJShe6EERkEe5xH2tp40Zd0evlIIO8deNvp0EpkKwK8S5J7HFbULrS4gIkq0vKUXEHtN1TGtSWZOeOvR0SVGnRZ2L8Pd9NZPdAiBz0oqHSw1DhQcWX+F3u52WEVyyvLSkBM3fLVy3uLhp0DWpBU91WBWxaas7rIe9P37iwZIpTFLwceC1nSVXTAY7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LrpYja37ZtQ56Zd81EYlyGmoYVOYrp4VeP6ICVjgCGijcq8C7lTvOI/m1sWEoEgz4iZ4hBWa6Xy7MngJGPRe2QuO2HE/atZttPURNjk1q+jSaj1ygkx0GIZB43uoL0LEW4l1KqmCQIOhnn3w400RHq9ZkKMn7GfPo7nJ/fXEJ8oquaICou3qCFFMGZ7FwHsfI6mZwzGrrKk/Sij0UmBLr3G/duX34US4VYctSsmoVzxZcOKweGq8UhF1wRC4LK2jbB6Pk1smwZix+wPHkQyuCZi2MjJOVDkKArb9viqSb6yBm8VHF4yAcdzRlHGbuzkRNCxojW606zmTX/CWNqSTJZY0jlISfhpgvKzCF3lQMJunseBlpGotMsmNeNxVtukbeC4uSZzhTLYi3zC7KpWBdMGRp08HTD+RHnldD1Q8iwCIag/xhdituXQTAOew6zwA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:35.4610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27991b6f-b085-413e-7100-08defd6670da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564
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
Add KUnit tests for dm_helpers_dp_handle_test_pattern_request() covering
the link test pattern mapping, the colour space mapping, the bit depth
change that retimes the stream, and the case where no connector is
available to store the original timing.

[HOW]
Fake link service and clock manager callbacks record the requested
pattern instead of programming the PHY or the clocks.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 254 ++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 3531d52da1591..d4232648d8e62 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -14,6 +14,7 @@
 
 #include "dc.h"
 #include "core_types.h"
+#include "clk_mgr.h"
 #include "link_service.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
@@ -4283,6 +4284,255 @@ static void dm_test_read_local_edid_test_request(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, aux->response_written, expected_response.raw);
 }
 
+/*
+ * Fake link service and clock manager for the test-pattern request path, which
+ * would otherwise reach the DSC config update, the clock update and the PHY
+ * test pattern programming.
+ */
+struct dm_test_pattern_state {
+	unsigned int dsc_config_calls;
+	unsigned int set_pattern_calls;
+	unsigned int update_clocks_calls;
+	enum dp_test_pattern last_pattern;
+	enum dp_test_pattern_color_space last_color_space;
+};
+
+static struct dm_test_pattern_state dm_test_pattern;
+
+static bool dm_test_link_update_dsc_config(struct pipe_ctx *pipe_ctx)
+{
+	dm_test_pattern.dsc_config_calls++;
+	return true;
+}
+
+static bool dm_test_link_dp_set_test_pattern(struct dc_link *link,
+					     enum dp_test_pattern test_pattern,
+					     enum dp_test_pattern_color_space color_space,
+					     const struct link_training_settings *settings,
+					     const unsigned char *custom_pattern,
+					     unsigned int custom_pattern_size)
+{
+	dm_test_pattern.set_pattern_calls++;
+	dm_test_pattern.last_pattern = test_pattern;
+	dm_test_pattern.last_color_space = color_space;
+	return true;
+}
+
+static void dm_test_update_clocks(struct clk_mgr *clk_mgr,
+				  struct dc_state *context, bool safe_to_lower)
+{
+	dm_test_pattern.update_clocks_calls++;
+}
+
+static struct clk_mgr_funcs dm_test_clk_mgr_funcs = {
+	.update_clocks = dm_test_update_clocks,
+};
+
+struct dm_test_pattern_fixture {
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc_stream_state *stream;
+};
+
+static struct dm_test_pattern_fixture dm_test_setup_pattern(struct kunit *test)
+{
+	struct dm_test_pattern_fixture fixture = {0};
+	struct clk_bw_params *bw_params;
+	struct amdgpu_device *adev;
+	struct link_service *link_srv;
+	struct clk_mgr *clk_mgr;
+	struct dc_state *state;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	fixture.ctx = kunit_kzalloc(test, sizeof(*fixture.ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.ctx);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	clk_mgr = kunit_kzalloc(test, sizeof(*clk_mgr), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, clk_mgr);
+	bw_params = kunit_kzalloc(test, sizeof(*bw_params), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, bw_params);
+	fixture.link = dm_kunit_alloc_link(test);
+	fixture.aconnector = dm_kunit_alloc_connector(test, adev, fixture.link);
+	fixture.stream = dm_kunit_alloc_stream(test, fixture.link);
+
+	link_srv->update_dsc_config = dm_test_link_update_dsc_config;
+	link_srv->dp_set_test_pattern = dm_test_link_dp_set_test_pattern;
+	clk_mgr->funcs = &dm_test_clk_mgr_funcs;
+	clk_mgr->bw_params = bw_params;
+
+	dc->link_srv = link_srv;
+	dc->clk_mgr = clk_mgr;
+	dc->current_state = state;
+	fixture.ctx->dc = dc;
+	fixture.link->dc = dc;
+	fixture.link->priv = fixture.aconnector;
+
+	/* the first pipe drives the link under test */
+	state->res_ctx.pipe_ctx[0].stream = fixture.stream;
+
+	dm_test_pattern = (struct dm_test_pattern_state) {0};
+
+	return fixture;
+}
+
+/**
+ * dm_test_dp_handle_test_pattern_patterns - Test the requested pattern mapping
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_handle_test_pattern_patterns(struct kunit *test)
+{
+	static const struct {
+		u8 pattern;
+		u8 dyn_range;
+		enum dp_test_pattern expected;
+	} cases[] = {
+		{ LINK_TEST_PATTERN_COLOR_RAMP, 0, DP_TEST_PATTERN_COLOR_RAMP },
+		{ LINK_TEST_PATTERN_VERTICAL_BARS, 0, DP_TEST_PATTERN_VERTICAL_BARS },
+		{ LINK_TEST_PATTERN_COLOR_SQUARES, TEST_DYN_RANGE_VESA, DP_TEST_PATTERN_COLOR_SQUARES },
+		{ LINK_TEST_PATTERN_COLOR_SQUARES, TEST_DYN_RANGE_CEA,  DP_TEST_PATTERN_COLOR_SQUARES_CEA },
+		/* PATTERN is 2 bits wide, so NONE is the only unhandled value */
+		{ LINK_TEST_PATTERN_NONE, 0, DP_TEST_PATTERN_VIDEO_MODE },
+	};
+	struct dm_test_pattern_fixture fixture = dm_test_setup_pattern(test);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		union link_test_pattern test_pattern = {0};
+		union test_misc test_params = {0};
+		bool ret;
+
+		dm_test_pattern = (struct dm_test_pattern_state) {0};
+		test_pattern.bits.PATTERN = cases[i].pattern;
+		test_params.bits.DYN_RANGE = cases[i].dyn_range;
+
+		ret = dm_helpers_dp_handle_test_pattern_request(fixture.ctx, fixture.link,
+								test_pattern, test_params);
+
+		KUNIT_EXPECT_FALSE(test, ret);
+		KUNIT_EXPECT_EQ_MSG(test, (int)dm_test_pattern.last_pattern,
+				    (int)cases[i].expected, "pattern %u", cases[i].pattern);
+		KUNIT_EXPECT_EQ(test, dm_test_pattern.set_pattern_calls, 1U);
+		KUNIT_EXPECT_EQ(test, dm_test_pattern.update_clocks_calls, 1U);
+	}
+}
+
+/**
+ * dm_test_dp_handle_test_pattern_color_spaces - Test the colour space mapping
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_handle_test_pattern_color_spaces(struct kunit *test)
+{
+	static const struct {
+		u8 clr_format;
+		u8 ycbcr_coefs;
+		enum dp_test_pattern_color_space expected;
+	} cases[] = {
+		{ 0, 0, DP_TEST_PATTERN_COLOR_SPACE_RGB },
+		{ 1, 0, DP_TEST_PATTERN_COLOR_SPACE_YCBCR601 },
+		{ 2, 1, DP_TEST_PATTERN_COLOR_SPACE_YCBCR709 },
+	};
+	struct dm_test_pattern_fixture fixture = dm_test_setup_pattern(test);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		union link_test_pattern test_pattern = {0};
+		union test_misc test_params = {0};
+
+		dm_test_pattern = (struct dm_test_pattern_state) {0};
+		test_params.bits.CLR_FORMAT = cases[i].clr_format;
+		test_params.bits.YCBCR_COEFS = cases[i].ycbcr_coefs;
+
+		dm_helpers_dp_handle_test_pattern_request(fixture.ctx, fixture.link,
+							  test_pattern, test_params);
+
+		KUNIT_EXPECT_EQ_MSG(test, (int)dm_test_pattern.last_color_space,
+				    (int)cases[i].expected, "format %u", cases[i].clr_format);
+	}
+}
+
+/**
+ * dm_test_dp_handle_test_pattern_timing_change - Test the timing update branch
+ * @test: The KUnit test context
+ *
+ * A requested colour depth or pixel encoding that differs from the current
+ * stream timing reprograms the timing and updates the DSC config.
+ */
+static void dm_test_dp_handle_test_pattern_timing_change(struct kunit *test)
+{
+	static const struct {
+		u8 bpc;
+		u8 clr_format;
+		enum dc_color_depth depth;
+		enum dc_pixel_encoding encoding;
+	} cases[] = {
+		{ 2, 1, COLOR_DEPTH_101010, PIXEL_ENCODING_YCBCR422 },
+		{ 3, 2, COLOR_DEPTH_121212, PIXEL_ENCODING_YCBCR444 },
+	};
+	struct dm_test_pattern_fixture fixture = dm_test_setup_pattern(test);
+	struct dc_crtc_timing requested = {0};
+	unsigned int i;
+
+	fixture.aconnector->timing_requested = &requested;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		union link_test_pattern test_pattern = {0};
+		union test_misc test_params = {0};
+
+		dm_test_pattern = (struct dm_test_pattern_state) {0};
+		fixture.stream->timing.display_color_depth = COLOR_DEPTH_888;
+		fixture.stream->timing.pixel_encoding = PIXEL_ENCODING_RGB;
+		test_params.bits.BPC = cases[i].bpc;
+		test_params.bits.CLR_FORMAT = cases[i].clr_format;
+
+		dm_helpers_dp_handle_test_pattern_request(fixture.ctx, fixture.link,
+							  test_pattern, test_params);
+
+		KUNIT_EXPECT_EQ_MSG(test, (int)fixture.stream->timing.display_color_depth,
+				    (int)cases[i].depth, "bpc %u", cases[i].bpc);
+		KUNIT_EXPECT_EQ_MSG(test, (int)fixture.stream->timing.pixel_encoding,
+				    (int)cases[i].encoding, "format %u", cases[i].clr_format);
+		KUNIT_EXPECT_EQ(test, dm_test_pattern.dsc_config_calls, 1U);
+		KUNIT_EXPECT_TRUE(test, fixture.aconnector->timing_changed);
+		KUNIT_EXPECT_EQ(test, (int)requested.display_color_depth,
+				(int)cases[i].depth);
+	}
+}
+
+/**
+ * dm_test_dp_handle_test_pattern_no_timing_storage - Test the missing storage path
+ * @test: The KUnit test context
+ *
+ * Without a timing_requested buffer the helper still reprograms the timing but
+ * reports that it could not store it.
+ */
+static void dm_test_dp_handle_test_pattern_no_timing_storage(struct kunit *test)
+{
+	struct dm_test_pattern_fixture fixture = dm_test_setup_pattern(test);
+	union link_test_pattern test_pattern = {0};
+	union test_misc test_params = {0};
+
+	fixture.aconnector->timing_requested = NULL;
+	fixture.stream->timing.display_color_depth = COLOR_DEPTH_888;
+
+	/* 6 bpc differs from the current 8 bpc timing */
+	test_params.bits.BPC = 0;
+
+	dm_helpers_dp_handle_test_pattern_request(fixture.ctx, fixture.link,
+						  test_pattern, test_params);
+
+	KUNIT_EXPECT_EQ(test, (int)fixture.stream->timing.display_color_depth,
+			(int)COLOR_DEPTH_666);
+	KUNIT_EXPECT_TRUE(test, fixture.aconnector->timing_changed);
+}
+
 /**
  * dm_test_read_local_edid_i2c_no_response - Test the I2C DDC path with no sink
  * @test: The KUnit test context
@@ -4502,6 +4752,10 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_dp_write_dsc_enable_pcon_disable),
 	/* dm_helpers_dp_handle_test_pattern_request */
 	KUNIT_CASE(dm_test_dp_handle_test_pattern_no_pipe),
+	KUNIT_CASE(dm_test_dp_handle_test_pattern_patterns),
+	KUNIT_CASE(dm_test_dp_handle_test_pattern_color_spaces),
+	KUNIT_CASE(dm_test_dp_handle_test_pattern_timing_change),
+	KUNIT_CASE(dm_test_dp_handle_test_pattern_no_timing_storage),
 	/* dm_helpers_submit_i2c_over_aux */
 	KUNIT_CASE(dm_test_submit_i2c_over_aux_unimplemented),
 	/* dm_helpers_allocate_gpu_mem / dm_helpers_free_gpu_mem */
-- 
2.43.0

