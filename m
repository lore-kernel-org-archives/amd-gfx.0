Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58971C4450F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A4210F098;
	Wed, 15 Jul 2026 13:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zk8zMYJ3";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F29F10F098
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fT1phut0vIznuGx8x07+D63NdxsHBx6UgHbstcJ01jbz7J+MpKVRxqVzQ6+MXvgjyPkV2EbQl6gUMrHe89zBoWsxiyQ6eutMeU0WRfy57Gu9yeQfKXCPd7h8+xQ5+6J/fsg6JMqkg2zQc7ZRl1rCiUbWKzTAmn6EeM03efK4Z8LDavqS/aEmiv6sS9wG+mXmSMXAwhxatrYaPWRHgIT6NzDg95lRxO4nkEzUZePhIXUNjyluP//N0s/bTruIK1iQKvDelRD8V7hJOqmMgVR/j5nVXzht9TR4BEZ4aEiLN3H7K23snEnJZXaTun2iTd5G383NPLzPFzKrM+WLTlAGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKtLfiM0jdgOJVnE2XyA/iWS7bfUDSOgTkgLeAKHoZE=;
 b=W+FVK/A6m+karq+uRUblA/Fdd4fvtXzdppyMYLdUdamxiFGhn3SXI4yN6g/z4nqKNn6LKYXyeeGfnqSPgyCKxQ9uQjdzKx4IN2QFogUFNTm0lqHam10byM2uf7RgjBn0kjljZ+DiXCBpHljgUFa6L1YxxWAQGuJJO0/2I/K6IkjKyMIXEjjpflpGfK4ynAydmKCBhn60sPzEq+M+IHeFHPvyPTkBcVnn1zk/7Mgw92Dwn3sP82aBiXGkUE1g+9ED5yKlB9xVlAABxZojQme3qmPXXSqfyRinKSF2J+Nt5/FpQ04AKIlLWRebCiZ0nUFGz2rtfPWRMjUDqToShshxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKtLfiM0jdgOJVnE2XyA/iWS7bfUDSOgTkgLeAKHoZE=;
 b=zk8zMYJ3Ka8p//kuZm6fJ4UtesVPZZ+NTokCBW/0aw/AogbJusB37fZXS1gCEdvNpCX+lYSaLxlq5lpFyx2qBVwLSmuSlTutWUgCYKsNBSygjk7w8oP396rM/lclhUdGBTcOTGx/z3D5ClXUVFqSnWRT7mZUwiRJEXFIFE0uFfo=
Received: from SJ0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:a03:39e::15)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Wed, 15 Jul
 2026 13:47:31 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::9d) by SJ0PR03CA0280.outlook.office365.com
 (2603:10b6:a03:39e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:27 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:24 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 41/70] drm/amd/display: add CRC configure KUnit coverage
Date: Wed, 15 Jul 2026 21:37:51 +0800
Message-ID: <20260715134432.1975118-42-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a666f04-3b4e-4659-c2ac-08dee2779c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|11063799006|6133799003|22082099003|18002099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: epw0cfRl61cw3WaHBb9Zs6RujgDzfZ652T4DT8inbeIiYoCtWrSDqd7W1Q8Fa8uSnSbk/qMKL3hNnR0uyKNMwtF/1BjcsTQP+I3G2J894PzRL/p2oXdaFkNihBM5tiBF5blAJbZyUAaS9tnVxCBswghD2hcdkeIOTG/YopEKKokuiNxdujCmsMI1SHDN2BiJdVB+Rtc7qCVzO/ypT4nnfkn3WolAGK//au1HELQLJcUcDZ+ZML1fUmMsbCsxoJol1/6IHUVk0iYxhwDEfrU7WXiUZOUfhCAlpESSgn660TFRpwRJyHv8tS9L01PjZ46emWIWBAHNBaMKxPtohemn2e2at2HRzgJr+fnufu4BSWlJDDjbbcBMiwB5k2jklEHYJWYE1gG2i9Kmjh9bvZhZHHi8lwoU2q/Sk5Zle5f8lbImZ/yJ6iqojm61DinoPkpMz94UM+TInWNaBlWIh72f6UkcTElmUBbLBlCb21LEYC6o8CCH3CSbqXOsxXFcYp5XhBDy0gui0AafRh2UF08lfEeYgDDdXtH2/EgtWcK3wysYpgdCk2mDHjpoReZ7TOcDw147c4cJ8j/AlE/HCKFUcGT7O9KHahjyyc053nUfX03WOLkwxsj7LSvmoOSWsPFuesR5eWu5iA/Jp8ohecjMlULMmZS0okX2/Gz19uCVB5M6qwSK9pZeFD4u3ImO4R0O
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dyE+dc/yyONFL9BHBQCr8RVYCIDEWPcE0lg25NUnOGiJdte9I8DE8NqAvV3Rn9yK8WulM6qIqkuqcbNmgVgS2sPhgvmhyBXhTqLJDKCFb7MEbcMbpJXcYR1WAqeU10j27kKHP2FpZ9RjVf2hpmDWa7Z/i/AV/FFEPdgVHxGm6zvWUObYWstidiWQbdKWdfxI1d2tap5WVk/nZwH+mOBwkjsgMgOpHlPOH26sU/e9XsfmoxSwvznPw772dVH/dgJ1GK1kmpFdgsQ7kiIWrXhBhMfTP0v/l0ax+QhUhgJ17SApjtIYhH2PvNhurMuNpePpmabsFsIr9i8eiupTpWIduOWlqerP9GWm4u67xn3kcz7EcaNUPcjOv7Qk15ComfrIbtMR6rtfmTJteaqXWcc0LTySBQsDdHvXA0r8eZKH4mGAYRB1VAZRwprMgkxjUpPi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:28.5217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a666f04-3b4e-4659-c2ac-08dee2779c6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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
Expose amdgpu_dm_crtc_configure_crc_source() for KUnit and add tests for
the CRTC-enable, disable (NONE), DPRX, DPRX-dither, DCN3.6 polynomial
select, and DC-configure-failure paths.

Introduce a small fake DC fixture (timing-generator and OPP callbacks
over an empty resource context) so the configure path can be exercised
without real hardware. The fixture is shared with the CRC IRQ tests.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 343 ++++++++++++++++++
 2 files changed, 344 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 6600cc6ecf8e..47beee584dbf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -638,6 +638,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_configure_crc_source);
 
 int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
index 4fa0bd9669c4..383646ad7005 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -10,12 +10,150 @@
 #include <drm/drm_modeset_lock.h>
 
 #include "dc.h"
+#include "core_types.h"
+#include "logger_types.h"
+#include "opp.h"
+#include "timing_generator.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_crc.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 
+struct dm_test_crc_dc_fixture {
+	struct dc *dc;
+	struct dc_context *dc_ctx;
+	struct dc_state *dc_state;
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+	struct timing_generator *tg;
+	struct output_pixel_processor *opp;
+	struct dal_logger *logger;
+	struct dm_crtc_state *dm_state;
+	struct crc_params crc_params;
+	enum dc_dynamic_expansion dyn_expansion;
+	enum dc_dither_option dither_option;
+	uint32_t crc_r;
+	uint32_t crc_g;
+	uint32_t crc_b;
+	bool configure_crc_called;
+	bool dyn_expansion_called;
+	bool bit_depth_reduction_called;
+	bool configure_crc_return;
+	bool get_crc_called;
+	bool get_crc_return;
+};
+
+static struct dm_test_crc_dc_fixture *dm_test_crc_dc_ctx;
+
+static bool dm_test_configure_crc(struct timing_generator *tg,
+					  const struct crc_params *params)
+{
+	if (!dm_test_crc_dc_ctx)
+		return false;
+
+	dm_test_crc_dc_ctx->configure_crc_called = true;
+	dm_test_crc_dc_ctx->crc_params = *params;
+
+	return dm_test_crc_dc_ctx->configure_crc_return;
+}
+
+static bool dm_test_get_crc(struct timing_generator *tg, uint8_t idx,
+				    uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb)
+{
+	if (!dm_test_crc_dc_ctx)
+		return false;
+
+	dm_test_crc_dc_ctx->get_crc_called = true;
+	*r_cr = dm_test_crc_dc_ctx->crc_r;
+	*g_y = dm_test_crc_dc_ctx->crc_g;
+	*b_cb = dm_test_crc_dc_ctx->crc_b;
+
+	return dm_test_crc_dc_ctx->get_crc_return;
+}
+
+static void dm_test_opp_set_dyn_expansion(struct output_pixel_processor *opp,
+						  enum dc_color_space color_sp,
+						  enum dc_color_depth color_dpth,
+						  enum signal_type signal)
+{
+	if (!dm_test_crc_dc_ctx)
+		return;
+
+	dm_test_crc_dc_ctx->dyn_expansion_called = true;
+	dm_test_crc_dc_ctx->dyn_expansion = opp->dyn_expansion;
+}
+
+static void dm_test_opp_program_bit_depth_reduction(struct output_pixel_processor *opp,
+							    const struct bit_depth_reduction_params *params)
+{
+	if (!dm_test_crc_dc_ctx)
+		return;
+
+	dm_test_crc_dc_ctx->bit_depth_reduction_called = true;
+}
+
+static const struct timing_generator_funcs dm_test_tg_funcs = {
+	.configure_crc = dm_test_configure_crc,
+	.get_crc = dm_test_get_crc,
+};
+
+static const struct opp_funcs dm_test_opp_funcs = {
+	.opp_set_dyn_expansion = dm_test_opp_set_dyn_expansion,
+	.opp_program_bit_depth_reduction = dm_test_opp_program_bit_depth_reduction,
+};
+
+static struct dm_test_crc_dc_fixture *dm_test_alloc_crc_dc_fixture(struct kunit *test,
+								   struct amdgpu_device *adev)
+{
+	struct dm_test_crc_dc_fixture *fixture;
+	struct pipe_ctx *pipe;
+
+	fixture = kunit_kzalloc(test, sizeof(*fixture), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture);
+
+	fixture->dm_state = kunit_kzalloc(test, sizeof(*fixture->dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->dm_state);
+	fixture->dc = kunit_kzalloc(test, sizeof(*fixture->dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->dc);
+	fixture->dc_ctx = kunit_kzalloc(test, sizeof(*fixture->dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->dc_ctx);
+	fixture->dc_state = kunit_kzalloc(test, sizeof(*fixture->dc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->dc_state);
+	fixture->tg = kunit_kzalloc(test, sizeof(*fixture->tg), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->tg);
+	fixture->opp = kunit_kzalloc(test, sizeof(*fixture->opp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->opp);
+	fixture->logger = kunit_kzalloc(test, sizeof(*fixture->logger), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture->logger);
+	fixture->link = dm_kunit_alloc_link(test);
+	fixture->stream = dm_kunit_alloc_stream(test, fixture->link);
+
+	mutex_init(&adev->dm.dc_lock);
+	adev->dm.dc = fixture->dc;
+	fixture->dc->ctx = fixture->dc_ctx;
+	fixture->dc->current_state = fixture->dc_state;
+	fixture->dc_ctx->dc = fixture->dc;
+	fixture->dc_ctx->logger = fixture->logger;
+	fixture->link->dc = fixture->dc;
+	fixture->stream->ctx = fixture->dc_ctx;
+	fixture->stream->link = fixture->link;
+	fixture->stream->timing.h_addressable = 1920;
+	fixture->stream->timing.v_addressable = 1080;
+	fixture->configure_crc_return = true;
+	fixture->tg->funcs = &dm_test_tg_funcs;
+	fixture->opp->funcs = &dm_test_opp_funcs;
+	fixture->dm_state->stream = fixture->stream;
+
+	pipe = &fixture->dc_state->res_ctx.pipe_ctx[0];
+	pipe->stream = fixture->stream;
+	pipe->pipe_idx = 0;
+	pipe->stream_res.tg = fixture->tg;
+	pipe->stream_res.opp = fixture->opp;
+
+	return fixture;
+}
+
 static struct amdgpu_crtc *dm_test_alloc_crc_crtc(struct kunit *test,
 							 struct amdgpu_device *adev)
 {
@@ -182,6 +320,203 @@ static void dm_test_crtc_verify_crc_source_invalid(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, values_cnt, 7);
 }
 
+/**
+ * dm_test_crtc_configure_crc_source_no_stream() - Test missing stream handling.
+ * @test: KUnit test context.
+ *
+ * Verifies that configuration is deferred/rejected before any DC access when
+ * the CRTC state does not have a stream.
+ */
+static void dm_test_crtc_configure_crc_source_no_stream(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_crtc_state *dm_state;
+	int ret;
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+
+	ret = amdgpu_dm_crtc_configure_crc_source(&acrtc->base, dm_state,
+						   AMDGPU_DM_PIPE_CRC_SOURCE_CRTC);
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/**
+ * dm_test_crtc_configure_crc_source_dprx() - Test DPRX configure path.
+ * @test: KUnit test context.
+ *
+ * Verifies that a DPRX source can be configured with an empty DC resource
+ * state, covering the non-CRTC path that only updates dither/dynamic expansion.
+ */
+static void dm_test_crtc_configure_crc_source_dprx(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_test_crc_dc_fixture *fixture;
+	int ret;
+
+	fixture = dm_test_alloc_crc_dc_fixture(test, adev);
+	dm_test_crc_dc_ctx = fixture;
+
+	ret = amdgpu_dm_crtc_configure_crc_source(&acrtc->base, fixture->dm_state,
+						   AMDGPU_DM_PIPE_CRC_SOURCE_DPRX);
+	dm_test_crc_dc_ctx = NULL;
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, fixture->configure_crc_called);
+	KUNIT_EXPECT_TRUE(test, fixture->dyn_expansion_called);
+	KUNIT_EXPECT_EQ(test, fixture->dyn_expansion, DYN_EXPANSION_DISABLE);
+	KUNIT_EXPECT_TRUE(test, fixture->bit_depth_reduction_called);
+}
+
+/**
+ * dm_test_crtc_configure_crc_source_dprx_dither() - Test DPRX dither path.
+ * @test: KUnit test context.
+ *
+ * Verifies that a DPRX dither source reaches the default dither/dynamic
+ * expansion path without requiring timing-generator callbacks.
+ */
+static void dm_test_crtc_configure_crc_source_dprx_dither(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_test_crc_dc_fixture *fixture;
+	int ret;
+
+	fixture = dm_test_alloc_crc_dc_fixture(test, adev);
+	dm_test_crc_dc_ctx = fixture;
+
+	ret = amdgpu_dm_crtc_configure_crc_source(&acrtc->base, fixture->dm_state,
+						   AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER);
+	dm_test_crc_dc_ctx = NULL;
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, fixture->configure_crc_called);
+	KUNIT_EXPECT_TRUE(test, fixture->dyn_expansion_called);
+	KUNIT_EXPECT_EQ(test, fixture->dyn_expansion, DYN_EXPANSION_AUTO);
+	KUNIT_EXPECT_TRUE(test, fixture->bit_depth_reduction_called);
+}
+
+/**
+ * dm_test_crtc_configure_crc_source_crtc() - Test CRTC enable path.
+ * @test: KUnit test context.
+ *
+ * Verifies that a CRTC source enables DC CRC capture and disables dither.
+ */
+static void dm_test_crtc_configure_crc_source_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_test_crc_dc_fixture *fixture;
+	int ret;
+
+	fixture = dm_test_alloc_crc_dc_fixture(test, adev);
+	dm_test_crc_dc_ctx = fixture;
+
+	ret = amdgpu_dm_crtc_configure_crc_source(&acrtc->base, fixture->dm_state,
+						   AMDGPU_DM_PIPE_CRC_SOURCE_CRTC);
+	dm_test_crc_dc_ctx = NULL;
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, fixture->configure_crc_called);
+	KUNIT_EXPECT_TRUE(test, fixture->crc_params.enable);
+	KUNIT_EXPECT_TRUE(test, fixture->crc_params.continuous_mode);
+	KUNIT_EXPECT_TRUE(test, fixture->crc_params.reset);
+	KUNIT_EXPECT_EQ(test, fixture->crc_params.windowa_x_end, 1920);
+	KUNIT_EXPECT_EQ(test, fixture->crc_params.windowa_y_end, 1080);
+	KUNIT_EXPECT_TRUE(test, fixture->dyn_expansion_called);
+	KUNIT_EXPECT_EQ(test, fixture->dyn_expansion, DYN_EXPANSION_DISABLE);
+	KUNIT_EXPECT_TRUE(test, fixture->bit_depth_reduction_called);
+}
+
+/**
+ * dm_test_crtc_configure_crc_source_crtc_dcn36_poly() - Test CRC poly select.
+ * @test: KUnit test context.
+ *
+ * Verifies that DCN3.6+ configurations use the CRTC-selected CRC polynomial.
+ */
+static void dm_test_crtc_configure_crc_source_crtc_dcn36_poly(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_test_crc_dc_fixture *fixture;
+	int ret;
+
+	fixture = dm_test_alloc_crc_dc_fixture(test, adev);
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 6, 0);
+	acrtc->dm_irq_params.crc_poly_mode = CRC_POLY_MODE_32;
+	dm_test_crc_dc_ctx = fixture;
+
+	ret = amdgpu_dm_crtc_configure_crc_source(&acrtc->base, fixture->dm_state,
+						   AMDGPU_DM_PIPE_CRC_SOURCE_CRTC);
+	dm_test_crc_dc_ctx = NULL;
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, fixture->configure_crc_called);
+	KUNIT_EXPECT_EQ(test, fixture->crc_params.crc_poly_mode, CRC_POLY_MODE_32);
+}
+
+/**
+ * dm_test_crtc_configure_crc_source_crtc_configure_fails() - Test failure path.
+ * @test: KUnit test context.
+ *
+ * Verifies that a DC CRC configuration failure is reported as -EINVAL and
+ * stops before dither/dynamic expansion programming.
+ */
+static void dm_test_crtc_configure_crc_source_crtc_configure_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_test_crc_dc_fixture *fixture;
+	int ret;
+
+	fixture = dm_test_alloc_crc_dc_fixture(test, adev);
+	fixture->configure_crc_return = false;
+	dm_test_crc_dc_ctx = fixture;
+
+	ret = amdgpu_dm_crtc_configure_crc_source(&acrtc->base, fixture->dm_state,
+						   AMDGPU_DM_PIPE_CRC_SOURCE_CRTC);
+	dm_test_crc_dc_ctx = NULL;
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	KUNIT_EXPECT_TRUE(test, fixture->configure_crc_called);
+	KUNIT_EXPECT_FALSE(test, fixture->dyn_expansion_called);
+	KUNIT_EXPECT_FALSE(test, fixture->bit_depth_reduction_called);
+}
+
+/**
+ * dm_test_crtc_configure_crc_source_none() - Test CRC disable path.
+ * @test: KUnit test context.
+ *
+ * Verifies that source NONE disables DC CRC capture and restores default
+ * dither/dynamic expansion.
+ */
+static void dm_test_crtc_configure_crc_source_none(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_test_crc_dc_fixture *fixture;
+	int ret;
+
+	fixture = dm_test_alloc_crc_dc_fixture(test, adev);
+	dm_test_crc_dc_ctx = fixture;
+
+	ret = amdgpu_dm_crtc_configure_crc_source(&acrtc->base, fixture->dm_state,
+						   AMDGPU_DM_PIPE_CRC_SOURCE_NONE);
+	dm_test_crc_dc_ctx = NULL;
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, fixture->configure_crc_called);
+	KUNIT_EXPECT_FALSE(test, fixture->crc_params.enable);
+	KUNIT_EXPECT_FALSE(test, fixture->crc_params.continuous_mode);
+	KUNIT_EXPECT_TRUE(test, fixture->crc_params.reset);
+	KUNIT_EXPECT_TRUE(test, fixture->dyn_expansion_called);
+	KUNIT_EXPECT_EQ(test, fixture->dyn_expansion, DYN_EXPANSION_AUTO);
+	KUNIT_EXPECT_TRUE(test, fixture->bit_depth_reduction_called);
+}
+
 /**
  * dm_test_need_dp_aux() - Test dm_need_dp_aux().
  * @test: KUnit test context.
@@ -314,6 +649,14 @@ static struct kunit_case dm_crc_test_cases[] = {
 	/* amdgpu_dm_crtc_verify_crc_source() */
 	KUNIT_CASE(dm_test_crtc_verify_crc_source_valid),
 	KUNIT_CASE(dm_test_crtc_verify_crc_source_invalid),
+	/* amdgpu_dm_crtc_configure_crc_source() */
+	KUNIT_CASE(dm_test_crtc_configure_crc_source_no_stream),
+	KUNIT_CASE(dm_test_crtc_configure_crc_source_dprx),
+	KUNIT_CASE(dm_test_crtc_configure_crc_source_dprx_dither),
+	KUNIT_CASE(dm_test_crtc_configure_crc_source_crtc),
+	KUNIT_CASE(dm_test_crtc_configure_crc_source_crtc_dcn36_poly),
+	KUNIT_CASE(dm_test_crtc_configure_crc_source_crtc_configure_fails),
+	KUNIT_CASE(dm_test_crtc_configure_crc_source_none),
 	/* dm_need_dp_aux() */
 	KUNIT_CASE(dm_test_need_dp_aux),
 	/* dm_crc_source_should_start_dprx() */
-- 
2.43.0

