Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6A6C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C65510EB4E;
	Tue,  8 Sep 2026 11:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SARNSss+";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C52410EB4E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipjobYMMOSW0w6I7SMprhtFnCVkAmLy7EGbGGO0rCciVbdjMgfSUXTGrDYioYuc988O/NXtuElkG4IHISedPOh/PKZZRaqDnI625KXQZqEUGL4Plc+Keu1HlTNHmgigx6D7C9FAH6MbzHwBHKnz0dPBSMP8js+vMiHapnwAKKB7FiyUs6U2boULuv4shxu0A1n8JeSlF2omJogBfs/osdO2KH5A+MyM0ul8m+E/vEva8/wknUw+7FN3iJ++E1u0ePl/AyzxOWWvHkxpJtRAwM+e3kEvMyVNyThkUcD0m3YXlaWWj+9sqHQf6A8GdaWa9CfEH4qxOkl4TxN/TauDh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if4RZ5BuGiH2g+U/QdQThr6MhPlTpm93wQ6ljbURfxs=;
 b=aN0IdSzpulbqANdbO1UgrJISle+MXM1pGp5KrgFmhXI5JLqob2MPwCBsqnCa99u7tA9vO5ZSKur437mZID9qkMm6aiGQaZJz3s0skw3I0soJOXtZxvGSXYsuDdzVHEyFWm/qNv/CW47YqLcHQN+vB/mjIuYNOyCPWA3iJzsH3xAzjLnU/lLFY4G8FDrASEokZtTNYMhNFO3xoiDU/+pnAzlbTtKnu6tl+769uvSzNjqHQWPcfpZu+KQdwhBL5f87exzmJ/5nfzWP+Ir6lFnT2XAr0NzsvH10L3TTIN9IMZly5GO4Wk6e9BDWhgkH5UGHJ8a2T42aceiDD3u6rvlG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if4RZ5BuGiH2g+U/QdQThr6MhPlTpm93wQ6ljbURfxs=;
 b=SARNSss+Vj15IdTHKc//xMFj76w+I6CZ4IKCJF2NjTFCSYtp/S9Jo7CaawQOggUfaPeaJGLzdnjIYZuHGKG8B5AZUzg6pYZWYQqrMVlUmckdNPbstfGdYqd8cIoBgqGCP9LvUaxaa1odHHxZeW6y8Nyt/WL0LL2PXZGBmBpCCHM=
Received: from MW4PR03CA0251.namprd03.prod.outlook.com (2603:10b6:303:b4::16)
 by IA0PPFAF883AE17.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 8 Sep
 2026 11:37:30 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::1f) by MW4PR03CA0251.outlook.office365.com
 (2603:10b6:303:b4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:37:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:37:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:37:28 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:37:20 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 25/66] drm/amd/display: Test MST port mode support
Date: Tue, 8 Sep 2026 19:31:18 +0800
Message-ID: <20260908113338.2433445-26-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|IA0PPFAF883AE17:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cbd32f-ccd3-4c7e-15ef-08df0d9d90d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|5023799004|6133799003|56012099006|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IczoxvrcfBohZn2ydzRpxdx0Qf3A+bsKwAHbTlfb2SncKlVIEqWoFnQdHUsf6+ixC/bc5i7MD92d2rmJyqhig6tSF1EUoQVyG6ZySyN6+5oRTlR7k2l1FqHqWKEWfqcY+8TLq9R1rbItBgkFWKtxhcHpbpJm8Z7Dt87rwS9C6lcmh23RiZqCEyZCxnfkfLnNvHhVOwGSDaG+NK21dcA/MR8a0v6LYppYyBEwQ4AvMnQG8fdWRxJLsi41W271DJIosjGRHYVCpnhUt0+z9SXyTgMFPt8hzZ6F4afc7tx0kdToOtFoznrsGhVLYqgIkJn2MZZQrfh8gWtUuj9hSBw4wZwKur6NfxdBVZR2uvy8CmknZaGHtMM3T8VBuvlnr8WY6LfsN6GpqyC+UdTyt7DchdpnVrm94XhQyjnPVcde2Rs+b6xI7oU90ZE5VE2Mca17gtavwZiOHeg19Glig3AWOLOYYkpPLCMUX1JnUMD+e0l0qt6tmqF8bU+XYtRzLvrPVpTint7BuXOVaVxFgaSHdRXV3WrXNubvb2oEPx3g4f8F1+7FiIKRGSGKs8hTssSJUQGob4/cpynrojqk0cNOnTn8MomcjW5HsLsSurShABge9iNs6Ka9MHAfgPdrcCHRCkduB1WvxTqAM6AJFDkZI7C2s2KUUkcRD2Q/oApt/2puycHyzpbAwIeoIN8iHG+KTrCd0HBT5X+D2LVTcTTS9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(5023799004)(6133799003)(56012099006)(3023799007)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fWAlqIhKC6JcMqLShZNhYRGLj4PGTyixLIzr7/jv9AfeQpI7mcfdwrNn/Q+gXLaJanfO3t7tCz+ZKZjgum7dHYxV6Uz6WG2fnl05nNh7kGtb5HyInTLk/MAHPe0jNkDH3eXilQfGdYuIKfJpjh+ZcrLqPcKk6C1irkQdoU040QjliWyXR/uogW1VfdXP4HoolSNviTuT9Wfqcx0pQj9JP4Th38OI0M1p3s9i4d5Q2fLP8tFA/yA6BfVDy1nrKnh5AZg5i1OFdeLj2DyYLArBDZvgUA14z1rWZM98zZ655C71o6mjVOnRr8ifPfj4EDwrJCOnrs2i63AOtrLSUthwbS5UkU7R3aLNwPIyzt4uwItR7/jYhpcpbjdGWkIxCHaoKrjWJmUj5aKCBT5uapYY52b9dOrCChAWDrslZVx30C5s1pf0iLSxns36rFlwdWOi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:37:29.9747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cbd32f-ccd3-4c7e-15ef-08df0d9d90d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF883AE17
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
Add KUnit tests for dm_dp_mst_is_port_support_mode() covering a mode
that fits uncompressed, a port without a DSC AUX channel, a link with
no common DSC config, the DSC passthrough accept and reject paths, the
last link bandwidth check with a fresh read, a cached value and the
Synaptics quirk, the upstream virtual channel limit and the branch
throughput limit.

[HOW]
Build an MST connector with a stream and a DSC capable encoder, using a
fake dsc_funcs that reports encoder capabilities so the DC bandwidth
range helpers produce usable values. Each path is then selected by
varying the timing, the port DSC capabilities, the full and available
PBN of the topology and the branch descriptor.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../tests/amdgpu_dm_mst_types_test.c          | 370 ++++++++++++++++++
 1 file changed, 370 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index f74d263cfabf..13c141d9963a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -29,6 +29,8 @@
 #include "amdgpu_dm_hdcp.h"
 #include "amdgpu_dm_mst_types.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
+#include "dsc/dsc.h"
+#include "inc/core_types.h"
 #include "inc/link_service.h"
 
 /*
@@ -2620,6 +2622,363 @@ static void dm_mst_test_validate_dsc_caps_unsupported(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, ctx.sink->dsc_caps.dsc_dec_caps.is_dsc_supported);
 }
 
+/* Tests for dm_dp_mst_is_port_support_mode */
+
+static uint32_t dm_mst_test_root_link_bw_kbps;
+
+static uint32_t dm_mst_test_root_bandwidth_kbps(const struct dc_link *link,
+						const struct dc_link_settings *link_settings)
+{
+	return dm_mst_test_root_link_bw_kbps;
+}
+
+struct dm_mst_test_port_mode_ctx {
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_stream_state *stream;
+	struct drm_dp_mst_port *port;
+	struct dc_sink *sink;
+	struct dc_link *link;
+	struct dc *dc;
+};
+
+/*
+ * Build the minimum needed to price a mode: a link whose root bandwidth is
+ * faked, a virtual channel sized by the port's full_pbn, and a 24bpp timing
+ * that needs pix_clk_100hz / 10 * 24 kbps uncompressed.
+ */
+static void dm_mst_test_init_port_mode_ctx(struct kunit *test,
+					   struct dm_mst_test_port_mode_ctx *ctx,
+					   uint32_t root_link_bw_kbps, u32 full_pbn,
+					   uint32_t pix_clk_100hz)
+{
+	struct link_service *link_srv;
+	struct resource_pool *res_pool;
+
+	dm_mst_test_reset_dsc_dpcd();
+
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	ctx->sink = kunit_kzalloc(test, sizeof(*ctx->sink), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->sink);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
+
+	dm_mst_test_root_link_bw_kbps = root_link_bw_kbps;
+	link_srv->dp_link_bandwidth_kbps = dm_mst_test_root_bandwidth_kbps;
+
+	ctx->dc = dm_kunit_alloc_dc_with_ctx(test);
+	ctx->dc->link_srv = link_srv;
+	ctx->dc->res_pool = res_pool;
+
+	ctx->link = dm_kunit_alloc_link(test);
+	ctx->link->dc = ctx->dc;
+	ctx->link->ctx = ctx->dc->ctx;
+
+	ctx->sink->ctx = ctx->dc->ctx;
+	ctx->port = dm_mst_test_alloc_mgr_port(test);
+	ctx->port->full_pbn = full_pbn;
+
+	ctx->stream = dm_kunit_alloc_stream(test, ctx->link);
+	ctx->stream->sink = ctx->sink;
+	ctx->stream->timing.display_color_depth = COLOR_DEPTH_888;
+	ctx->stream->timing.pix_clk_100hz = pix_clk_100hz;
+
+	ctx->aconnector->dc_link = ctx->link;
+	ctx->aconnector->dc_sink = ctx->sink;
+	ctx->aconnector->mst_output_port = ctx->port;
+}
+
+/**
+ * dm_mst_test_port_mode_fits_without_dsc - sufficient bandwidth needs no DSC
+ * @test: KUnit test context
+ *
+ * When the uncompressed stream fits into the smaller of the root link and the
+ * virtual channel bandwidth, the mode is accepted before any DSC evaluation.
+ */
+static void dm_mst_test_port_mode_fits_without_dsc(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 1000000, 1000, 100000);
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream), DC_OK);
+	KUNIT_EXPECT_EQ(test, (u32)ctx.stream->timing.flags.DSC, 0U);
+}
+
+/**
+ * dm_mst_test_port_mode_no_dsc_aux - DSC is required but unavailable
+ * @test: KUnit test context
+ *
+ * A mode that exceeds the end-to-end bandwidth on a connector without a DSC
+ * AUX channel cannot be compressed, so validation must fail.
+ */
+static void dm_mst_test_port_mode_no_dsc_aux(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 100000, 10, 100000);
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream),
+			DC_FAIL_BANDWIDTH_VALIDATE);
+}
+
+/**
+ * dm_mst_test_port_mode_no_common_dsc_config - no shared DSC config is fatal
+ * @test: KUnit test context
+ *
+ * With a DSC AUX but no DSC encoder in the resource pool, source and sink share
+ * no usable DSC configuration and the mode must be rejected.
+ */
+static void dm_mst_test_port_mode_no_common_dsc_config(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 100000, 10, 100000);
+	ctx.aconnector->dsc_aux = ctx.port->mgr->aux;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream),
+			DC_FAIL_BANDWIDTH_VALIDATE);
+}
+
+/*
+ * 1920x1080@60 RGB 8bpc needs 3564000 kbps uncompressed, and roughly 1188000
+ * kbps at the 8bpp DSC policy minimum.
+ */
+#define DM_MST_TEST_DSC_PIX_CLK_100HZ	1485000
+
+/* Enough of dsc2_get_enc_caps() for the DSC policy and bandwidth maths. */
+static void dm_mst_test_dsc_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
+{
+	dsc_enc_caps->dsc_version = 0x21;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_1 = 1;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_2 = 1;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_4 = 1;
+	dsc_enc_caps->lb_bit_depth = 13;
+	dsc_enc_caps->is_block_pred_supported = true;
+	dsc_enc_caps->color_formats.bits.RGB = 1;
+	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
+	dsc_enc_caps->max_total_throughput_mps = 4800;
+	dsc_enc_caps->max_slice_width = 5184;
+	dsc_enc_caps->bpp_increment_div = 16;
+}
+
+static const struct dsc_funcs dm_mst_test_dsc_funcs = {
+	.dsc_get_enc_caps = dm_mst_test_dsc_get_enc_caps,
+};
+
+/* Install the DSC encoder fake and matching sink decoder capabilities. */
+static void dm_mst_test_setup_dsc_caps(struct kunit *test, struct dc *dc, struct dc_sink *sink)
+{
+	struct dsc_dec_dpcd_caps *dec = &sink->dsc_caps.dsc_dec_caps;
+	struct display_stream_compressor *dsc;
+
+	dsc = kunit_kzalloc(test, sizeof(*dsc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dsc);
+
+	dsc->funcs = &dm_mst_test_dsc_funcs;
+	dsc->ctx = dc->ctx;
+	dc->res_pool->dscs[0] = dsc;
+
+	dec->is_dsc_supported = true;
+	dec->dsc_version = 0x21;
+	dec->rc_buffer_size = 16 * 1024;
+	dec->slice_caps1.bits.NUM_SLICES_1 = 1;
+	dec->slice_caps1.bits.NUM_SLICES_2 = 1;
+	dec->slice_caps1.bits.NUM_SLICES_4 = 1;
+	dec->lb_bit_depth = 13;
+	dec->is_block_pred_supported = true;
+	dec->color_formats.bits.RGB = 1;
+	dec->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
+	dec->throughput_mode_0_mps = 1000;
+	dec->throughput_mode_1_mps = 1000;
+	dec->max_slice_width = 5120;
+	dec->bpp_increment_div = 16;
+}
+
+static void dm_mst_test_set_dsc_timing(struct dc_crtc_timing *timing)
+{
+	timing->display_color_depth = COLOR_DEPTH_888;
+	timing->pixel_encoding = PIXEL_ENCODING_RGB;
+	timing->h_addressable = 1920;
+	timing->v_addressable = 1080;
+	timing->pix_clk_100hz = DM_MST_TEST_DSC_PIX_CLK_100HZ;
+}
+
+/*
+ * Give the source a DSC encoder and the sink matching decoder capabilities so
+ * is_dsc_common_config_possible() succeeds, and switch to a timing that does
+ * not fit uncompressed.
+ */
+static void dm_mst_test_enable_dsc(struct kunit *test, struct dm_mst_test_port_mode_ctx *ctx)
+{
+	struct drm_dp_mst_branch *branch;
+
+	branch = kunit_kzalloc(test, sizeof(*branch), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, branch);
+
+	dm_mst_test_setup_dsc_caps(test, ctx->dc, ctx->sink);
+	dm_mst_test_set_dsc_timing(&ctx->stream->timing);
+
+	ctx->port->parent = branch;
+	dm_mst_test_init_dsc_aux(&ctx->port->aux, "dm_mst_test_port_mode_aux");
+	ctx->aconnector->dsc_aux = ctx->port->mgr->aux;
+}
+
+/**
+ * dm_mst_test_port_mode_dsc_passthrough_fits - DSC passthrough accepts the mode
+ * @test: KUnit test context
+ *
+ * With DSC passthrough the compressed stream travels the whole path, so a
+ * minimum compression that fits the end-to-end bandwidth enables DSC.
+ */
+static void dm_mst_test_port_mode_dsc_passthrough_fits(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 2500000, 1000, 100000);
+	dm_mst_test_enable_dsc(test, &ctx);
+	ctx.port->passthrough_aux = ctx.port->mgr->aux;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream), DC_OK);
+	KUNIT_EXPECT_EQ(test, (u32)ctx.stream->timing.flags.DSC, 1U);
+}
+
+/**
+ * dm_mst_test_port_mode_dsc_passthrough_too_narrow - max compression still too big
+ * @test: KUnit test context
+ *
+ * When even the smallest DSC bitstream exceeds the end-to-end bandwidth the
+ * mode must be rejected instead of enabling DSC.
+ */
+static void dm_mst_test_port_mode_dsc_passthrough_too_narrow(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 1000000, 1000, 100000);
+	dm_mst_test_enable_dsc(test, &ctx);
+	ctx.port->passthrough_aux = ctx.port->mgr->aux;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream),
+			DC_FAIL_BANDWIDTH_VALIDATE);
+	KUNIT_EXPECT_EQ(test, (u32)ctx.stream->timing.flags.DSC, 0U);
+}
+
+/**
+ * dm_mst_test_port_mode_last_link_too_slow - the uncompressed last link is checked
+ * @test: KUnit test context
+ *
+ * DSC is decoded at the endpoint, so the last DP link still carries the
+ * uncompressed stream. Its current link settings are read from DPCD and cached
+ * on the connector, and a mode that does not fit is rejected.
+ */
+static void dm_mst_test_port_mode_last_link_too_slow(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 2500000, 1000, 100000);
+	dm_mst_test_enable_dsc(test, &ctx);
+	ctx.port->pdt = DP_PEER_DEVICE_SST_SINK;
+	/* RBR x1: 1257120 kbps, far below the 3564000 kbps the mode needs. */
+	dm_mst_test_set_link_settings(DP_LINK_BW_1_62, 1, DP_8b_10b_ENCODING);
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream),
+			DC_FAIL_BANDWIDTH_VALIDATE);
+	KUNIT_EXPECT_EQ(test, ctx.aconnector->mst_local_bw, 1257120U);
+	KUNIT_EXPECT_EQ(test, ctx.aconnector->vc_full_pbn, ctx.port->full_pbn);
+}
+
+/**
+ * dm_mst_test_port_mode_last_link_cached_bw - a cached last link bandwidth is reused
+ * @test: KUnit test context
+ *
+ * While the virtual channel allocation is unchanged the previously read link
+ * bandwidth is reused instead of going out to DPCD again.
+ */
+static void dm_mst_test_port_mode_last_link_cached_bw(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 2500000, 1000, 100000);
+	dm_mst_test_enable_dsc(test, &ctx);
+	ctx.port->pdt = DP_PEER_DEVICE_SST_SINK;
+	ctx.aconnector->vc_full_pbn = ctx.port->full_pbn;
+	ctx.aconnector->mst_local_bw = 100000;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream),
+			DC_FAIL_BANDWIDTH_VALIDATE);
+	KUNIT_EXPECT_EQ(test, ctx.aconnector->mst_local_bw, 100000U);
+}
+
+/**
+ * dm_mst_test_port_mode_last_link_synaptics_quirk - Synaptics hubs skip the check
+ * @test: KUnit test context
+ *
+ * Synaptics branch devices misreport their last link settings, so the last
+ * link bandwidth check is skipped for them and the mode is accepted.
+ */
+static void dm_mst_test_port_mode_last_link_synaptics_quirk(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 2500000, 1000, 100000);
+	dm_mst_test_enable_dsc(test, &ctx);
+	ctx.port->pdt = DP_PEER_DEVICE_SST_SINK;
+	ctx.aconnector->branch_ieee_oui = DP_BRANCH_DEVICE_ID_90CC24;
+	dm_mst_test_set_link_settings(DP_LINK_BW_1_62, 1, DP_8b_10b_ENCODING);
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream), DC_OK);
+	KUNIT_EXPECT_EQ(test, (u32)ctx.stream->timing.flags.DSC, 1U);
+}
+
+/**
+ * dm_mst_test_port_mode_upstream_vc_too_small - the upstream hop is the bottleneck
+ * @test: KUnit test context
+ *
+ * For a nested topology the virtual channel of the link before the last one
+ * caps the compressed bandwidth, and a mode that exceeds it is rejected.
+ */
+static void dm_mst_test_port_mode_upstream_vc_too_small(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+	struct drm_dp_mst_port *upstream;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 2500000, 1000, 100000);
+	dm_mst_test_enable_dsc(test, &ctx);
+	ctx.port->pdt = DP_PEER_DEVICE_NONE;
+
+	upstream = kunit_kzalloc(test, sizeof(*upstream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, upstream);
+	/* 100 PBN is about 670950 kbps, below the DSC minimum for this mode. */
+	upstream->full_pbn = 100;
+	ctx.port->parent->port_parent = upstream;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream),
+			DC_FAIL_BANDWIDTH_VALIDATE);
+}
+
+/**
+ * dm_mst_test_port_mode_branch_throughput_exceeded - branch decoder limit applies
+ * @test: KUnit test context
+ *
+ * Even with a valid DSC configuration the branch decoder's overall throughput
+ * for RGB must be able to carry the pixel rate.
+ */
+static void dm_mst_test_port_mode_branch_throughput_exceeded(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 2500000, 1000, 100000);
+	dm_mst_test_enable_dsc(test, &ctx);
+	ctx.port->passthrough_aux = ctx.port->mgr->aux;
+	/* 100 Mpix/s cannot carry the 148.5 Mpix/s this mode needs. */
+	ctx.sink->dsc_caps.dsc_dec_caps.branch_overall_throughput_0_mps = 100;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream),
+			DC_FAIL_BANDWIDTH_VALIDATE);
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -2714,6 +3073,17 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_validate_dsc_caps_cascaded_hub),
 	KUNIT_CASE(dm_mst_test_validate_dsc_caps_read_error),
 	KUNIT_CASE(dm_mst_test_validate_dsc_caps_unsupported),
+	/* dm_dp_mst_is_port_support_mode tests */
+	KUNIT_CASE(dm_mst_test_port_mode_fits_without_dsc),
+	KUNIT_CASE(dm_mst_test_port_mode_no_dsc_aux),
+	KUNIT_CASE(dm_mst_test_port_mode_no_common_dsc_config),
+	KUNIT_CASE(dm_mst_test_port_mode_dsc_passthrough_fits),
+	KUNIT_CASE(dm_mst_test_port_mode_dsc_passthrough_too_narrow),
+	KUNIT_CASE(dm_mst_test_port_mode_last_link_too_slow),
+	KUNIT_CASE(dm_mst_test_port_mode_last_link_cached_bw),
+	KUNIT_CASE(dm_mst_test_port_mode_last_link_synaptics_quirk),
+	KUNIT_CASE(dm_mst_test_port_mode_upstream_vc_too_small),
+	KUNIT_CASE(dm_mst_test_port_mode_branch_throughput_exceeded),
 	{}
 };
 
-- 
2.43.0

