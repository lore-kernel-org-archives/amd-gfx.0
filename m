Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1431C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CE110EB52;
	Tue,  8 Sep 2026 11:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TwcRIX7m";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C3C10EB52
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elvlzvv6X9gd3X6hgbJsjSLDWjajvkT6VMeLQCx30AVbQTefG+yrfU6If92MySDIZpcZHNFlGLLNmBWTZCUwnJhAm/n67amR6klVgYdhOfTWs4TaHzHgzFQDiqzqqtT2f128h40G7DfYpZMIxl9hxmIWIOe1uo91QMJwT/c7wSj+EzF3SOXhFsur4uo8yZaHDQ6XhcQZoVu3mNUfZnm0oCSqV/u8+SyUQiyB0yYqEBgUnorPqI7a0J75hmdLXczmNstlVQquTVhrseAPqElIpkPa/QVQC/2CG+GEksrzRJAmrcnvLU9E13QPkbKQP7+dgKxAyyALN7deNG8P+DB4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3JtqzsR/++56fujn+jdnrQpBqI5CplPdigwoLjppzA=;
 b=GS5/uWLOCkbs2Y7r9eFDR9vJN/ZHG+pQ7BizyZtazbYPcYS4nhhaMbHdBF9UPkNFGSQnMLmaSWFg6/NWcb83yXUkHuIGpnjf5fOt+yRvIUpkNNXaLbFsg3RF8UDFrr1nB8iImahHnXpSBfImaUK7CchytaI3dheTadsFrQ9lxUnYj097geXhUY6v3b2bhhETkTIig/++LBjhmvnuvl3enwd2LTzNr8wp1ovWIgmpD6392VHTck7gYan2jmPVVXwX0DZIs0IOsfUr48+rOtqqD7y4tXSs+WDHamb1xQKk9sXko28p0b0wKKKGvaKDF5+e1hTC7uiPskiDBlDZ9NjFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3JtqzsR/++56fujn+jdnrQpBqI5CplPdigwoLjppzA=;
 b=TwcRIX7mx/2irF9uz7O88DMbA39wpTH+1NraKxg4eQd3bKVOrzhaYxAaYQboQz/uLjmxkN3t/1JAp+he5qPWlCzIafT/EyQsqTWYhZjp8YEc7qUeCEwQcEFlMCwJnF2tyueXNGAJPzTvWa5ojjhULwX3y0+3mUeXqDRNyDX4Vuw=
Received: from BL1PR13CA0332.namprd13.prod.outlook.com (2603:10b6:208:2c6::7)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:38:05 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::1) by BL1PR13CA0332.outlook.office365.com
 (2603:10b6:208:2c6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:38:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:38:04 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:37:56 -0500
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
Subject: [PATCH 29/66] drm/amd/display: Test DSC config computation
Date: Tue, 8 Sep 2026 19:31:22 +0800
Message-ID: <20260908113338.2433445-30-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 724e254f-a8ef-4717-2b11-08df0d9da5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|3023799007|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KHgnXH0TZeoeXA/coUucXuCsT4fQJcWRQvfuol7ttoT82tQHuIDqxVN1lAx+HKC8vRWZgIKh8utBPCylvRgJ+L6nAog7irYMOwFUGPZ9a+P5SoHdlfhxPUAvaNUD65THNndswBab7r3bK/9X+eVoJQD8YIxZVciOoIgoUq015YFW4becNCwNws0Yz17WZeURqpTMrddNwasebJsm8Ls1tuZCKoWYDnoeZ+bgjrP4qIGdbMED52ji5A4YqctvM/SZ4G9nylEpUkApy1Q38w2EAqWjqNehNv5/7M4hxp5983ugRfx6u44pco5WGGknqJ5ECmSgXUNSRnjpRBciPN4c8IKkpOq2fP10om7Rfc4GK/uNawrKukpMlFu0vn9cbtg+Izq3qZXMd5gMN+ss5Cv/wc1ELS3AHxo3OakVe3CkZPdr1p2egku11Ki0ydZNDWDoy/RireW5v8Z84ZQ18F5Kz4Wai0NR9uv+p5+FUdq1418Oxgb9r/9L+g976tH26QpxmdsANsr05rLAx0XTv7hhG4O79Ewbzd3LoTIlqIdS08l3VST0c+/G6o2V4Nj0wgG2Z6FhlPjiyvB6j9GC+S+jdXzjTsWjZS1FuBVuJ62H5q94P64p+0MoOPNaKAYQ5+II7YlrUnH6M87SNpgLfS8jo6v/7gi2lnXg6WCYWN819KehIbd6XSb/F4l0BR8wPB8tdzr2+Ej6O3GmVp81QW09Eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QS5XXpdl25rdP2J60+b/+cgTzbnyJVcqwg5AtnlBtVl5jxMc3cxq613T5HmqZuNoc7QUz2YQ35OrlzPi8qAI+/iRF7RuoGtINbU2PYRZU004rkjZfIlrWxlR0uBJvywCDkU2WVMCSDqNIVVrWam6K/sw6jzWNni2JWbOs7dGX9I8yn0kELLClyX21GJ1hkm1d0ycswSVnJP00oqOnHXMLfoaxx3OKY9fow+Sml8ySzzDTFyc/bb7b8iY0dLsa8AlnDOC+1AxgOXkDI/w8NMdIsnXAa58i+74gg+e2ceXLcpGBpsRB4PSE40b1HykHVHKh20p+pfbp0hkMdz1M/exQgBAEvFtrA+qzeBGz/xiJZx+Y8FkWCPOcQQODRiuU+PM/JK6L+oHpSlfr67k3EARRbUdbWKZw/otMbpWXhfvnlk4Kjzr0C6KnwhVGV8RkP92
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:38:05.1891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 724e254f-a8ef-4717-2b11-08df0d9da5c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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
Add KUnit tests for compute_mst_dsc_configs_for_state() covering an SST
stream, a stream with an incomplete topology, a failing stream removal
and a link that does not need a recompute, plus a test for
pre_validate_dsc() when no precompute pass is required.

[HOW]
Add a helper that appends an MST stream with a DSC capable link to a DC
state, including the resource pool functions the compute pass calls
unconditionally, and let each test supply its own stream removal
callback to reach the error path.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 +
 .../tests/amdgpu_dm_mst_types_test.c          | 150 ++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index fc71f8e567c9..8dc4f81f1716 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1687,6 +1687,7 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
 
 	return ret;
 }
+EXPORT_IF_KUNIT(compute_mst_dsc_configs_for_state);
 
 static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
 						 struct dc_state *dc_state,
@@ -1905,6 +1906,7 @@ int pre_validate_dsc(struct drm_atomic_commit *state,
 
 	return ret;
 }
+EXPORT_IF_KUNIT(pre_validate_dsc);
 
 static uint32_t kbps_from_pbn(unsigned int pbn)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 9af4fd84e69c..9bd33317ec1e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -3495,6 +3495,149 @@ static void dm_mst_test_recompute_connector_without_crtc(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, is_dsc_need_re_compute(ctx.state, ctx.dc_state, ctx.link));
 }
 
+/* Tests for compute_mst_dsc_configs_for_state and pre_validate_dsc */
+
+typedef enum dc_status (*dm_mst_test_remove_stream_fn)(struct dc *dc, struct dc_state *new_ctx,
+						       struct dc_stream_state *stream);
+
+static enum dc_status dm_mst_test_remove_stream_fails(struct dc *dc, struct dc_state *new_ctx,
+						      struct dc_stream_state *stream)
+{
+	return DC_ERROR_UNEXPECTED;
+}
+
+/*
+ * Add a stream to @ctx that walks as far into the DSC config helpers as the
+ * caller allows: an MST signal, a DM connector, an MST output port and a DSC
+ * capable sink. The helpers dereference res_pool->funcs unconditionally, so
+ * the pool is always given one, carrying @remove_stream.
+ */
+static struct dc_stream_state *
+dm_mst_test_add_mst_dsc_stream(struct kunit *test, struct dm_mst_test_recompute_ctx *ctx,
+			       dm_mst_test_remove_stream_fn remove_stream)
+{
+	struct dc_stream_state *stream;
+	struct resource_pool *res_pool;
+	struct drm_dp_mst_port *port;
+	struct resource_funcs *funcs;
+	struct dc_sink *sink;
+
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	funcs = kunit_kzalloc(test, sizeof(*funcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
+	KUNIT_ASSERT_NOT_NULL(test, funcs);
+
+	funcs->remove_stream_from_ctx = remove_stream;
+	res_pool->funcs = funcs;
+	ctx->dc->res_pool = res_pool;
+	sink->dsc_caps.dsc_dec_caps.is_dsc_supported = true;
+	ctx->aconnector->dc_sink = sink;
+	ctx->aconnector->mst_output_port = port;
+
+	stream = dm_mst_test_add_link_stream(test, ctx->dc_state, ctx->link, ctx->aconnector);
+	stream->ctx = ctx->dc->ctx;
+	stream->signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
+
+	return stream;
+}
+
+/**
+ * dm_mst_test_compute_configs_skips_sst - non-MST streams are not considered
+ * @test: KUnit test context
+ */
+static void dm_mst_test_compute_configs_skips_sst(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dc_stream_state *stream;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	stream = dm_mst_test_add_link_stream(test, ctx.dc_state, ctx.link, ctx.aconnector);
+	stream->ctx = ctx.dc->ctx;
+	stream->signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	KUNIT_EXPECT_EQ(test, compute_mst_dsc_configs_for_state(ctx.state, ctx.dc_state, vars), 0);
+}
+
+/**
+ * dm_mst_test_compute_configs_skips_incomplete - streams without a sink are skipped
+ * @test: KUnit test context
+ *
+ * An MST stream whose connector has neither a sink nor an output port yet is
+ * not ready for DSC bandwidth sharing.
+ */
+static void dm_mst_test_compute_configs_skips_incomplete(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dc_stream_state *stream;
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	stream = dm_mst_test_add_link_stream(test, ctx.dc_state, ctx.link, ctx.aconnector);
+	stream->ctx = ctx.dc->ctx;
+	stream->signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
+
+	KUNIT_EXPECT_EQ(test, compute_mst_dsc_configs_for_state(ctx.state, ctx.dc_state, vars), 0);
+}
+
+/**
+ * dm_mst_test_compute_configs_remove_stream_fails - a DC resource failure aborts
+ * @test: KUnit test context
+ */
+static void dm_mst_test_compute_configs_remove_stream_fails(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	dm_mst_test_add_mst_dsc_stream(test, &ctx, dm_mst_test_remove_stream_fails);
+
+	KUNIT_EXPECT_EQ(test, compute_mst_dsc_configs_for_state(ctx.state, ctx.dc_state, vars),
+			-EINVAL);
+}
+
+/**
+ * dm_mst_test_compute_configs_no_recompute - an unchanged topology is left alone
+ * @test: KUnit test context
+ *
+ * The stream is DSC capable but is_dsc_need_re_compute() reports no change, so
+ * the existing configuration is kept and no DSC resource is requested.
+ */
+static void dm_mst_test_compute_configs_no_recompute(struct kunit *test)
+{
+	struct dm_mst_test_recompute_ctx ctx;
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+
+	dm_mst_test_init_recompute_ctx(test, &ctx);
+	ctx.link->type = dc_connection_single;
+	dm_mst_test_add_mst_dsc_stream(test, &ctx, NULL);
+
+	KUNIT_EXPECT_EQ(test, compute_mst_dsc_configs_for_state(ctx.state, ctx.dc_state, vars), 0);
+}
+
+/**
+ * dm_mst_test_pre_validate_dsc_not_needed - precompute is skipped when unneeded
+ * @test: KUnit test context
+ *
+ * Without a DSC capable MST hub in the state there is nothing to precompute,
+ * so pre_validate_dsc() must succeed without touching the DM atomic state.
+ */
+static void dm_mst_test_pre_validate_dsc_not_needed(struct kunit *test)
+{
+	struct dm_mst_test_crtc_state_ctx ctx;
+	struct dsc_mst_fairness_vars vars[MAX_PIPES] = {};
+	struct dm_atomic_state *dm_state = NULL;
+
+	dm_mst_test_init_crtc_state_ctx(test, &ctx, 1);
+
+	KUNIT_EXPECT_EQ(test, pre_validate_dsc(ctx.state, &dm_state, vars), 0);
+	KUNIT_EXPECT_NULL(test, dm_state);
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -3621,6 +3764,13 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_recompute_stream_removed),
 	KUNIT_CASE(dm_mst_test_recompute_stream_without_connector),
 	KUNIT_CASE(dm_mst_test_recompute_connector_without_crtc),
+	/* compute_mst_dsc_configs_for_state tests */
+	KUNIT_CASE(dm_mst_test_compute_configs_skips_sst),
+	KUNIT_CASE(dm_mst_test_compute_configs_skips_incomplete),
+	KUNIT_CASE(dm_mst_test_compute_configs_remove_stream_fails),
+	KUNIT_CASE(dm_mst_test_compute_configs_no_recompute),
+	/* pre_validate_dsc tests */
+	KUNIT_CASE(dm_mst_test_pre_validate_dsc_not_needed),
 	{}
 };
 
-- 
2.43.0

