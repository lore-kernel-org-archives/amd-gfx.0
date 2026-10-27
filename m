Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D9606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c6IbYRK7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FCAD10F8B5;
	Tue, 27 Oct 2026 23:26:09 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1514210F8BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOUFpLTEoQg8YqT2ALnSm0UZokZE7YvQ2gltQDyKNlnd9jovKBcVBKZSXq1g4LZR7E6q5wVzGY3bkuVkOMY1G3aWaovhRvUwOXlfnDQukAfL8Dku8wCW7ZcpF/A3Yz5LW0rS2aPGAJPIo/jugBa5GbcaINoqsKvfVIbvrCLLjEnTS1kpgs3GE7o5bjpwvQFjRW2v8nT+keIvNboIH7b/c6J6KVG7b8BUxz/lpzxhdr+YYCp0cvDZ559JevphMekpjWUxZSbcIccrvudSEXpNiEKIrafWIKd9bEzDm0zjdB989ZHLIu+UzeOFn7XKV54p7RTdJCCdYcD3F41YWkxKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKI2j33xavCKT/tCJviqvBBh+eJ8hEU0m29ueS8zZRs=;
 b=PeGKASGN4aikOPfuz5kL1I11YS/pYRMFhNKjxMs0Ixx4wOWVtgR2KB8u+60KoepX5jefWjJTEGIu/UFVvEXvMwJztkO6Oms9n06g1J+4yG9IkhPq/dEHa6FdKy4CrsA9Y6BlHRx7NoOmjLtUI6UYWebSGej2PrpkdqS1aj1J1g2LuqslmSoST1GNRMLvtHWVXG+mvR9Hb8qXB4zfR6DFEZ5UQAJibkNK8lwfMgqemA0qfksfbX1ICJOpvX9VUTkspPWVGJLjg2kvm/Xcg6fnCxuDorsj9nqhc9gP4aYpipXAdHHG0IBNuDIcf6jkbrRDUlvezxLbNK4+W5+tJ7lcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKI2j33xavCKT/tCJviqvBBh+eJ8hEU0m29ueS8zZRs=;
 b=c6IbYRK7vj9yINmC9XxZ6TtU9q9yfiIeNEnQ3usml9U3uBX/GAtN/l7qWa9uD50Km3Jrwbgtt+7tAsPa8OztZYGwpPJVWJYPN7OOQ8z64D+bSkrZSTRZu+rI6iAHERcRDoptkWhjcjzmONgMXjve/kHZN7/HAytdbQSNMN13T1g=
Received: from CH0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:610:e7::33)
 by PH5PR12MB989986.namprd12.prod.outlook.com (2603:10b6:510:501::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 23:25:58 +0000
Received: from CH01EPF000BE940.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::4e) by CH0PR03CA0238.outlook.office365.com
 (2603:10b6:610:e7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:25:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE940.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:25:58 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:25:56 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 25/28] drm/amd/display: Add more connector KUnit tests
Date: Tue, 27 Oct 2026 17:17:21 -0600
Message-ID: <20261027232005.2879750-26-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE940:EE_|PH5PR12MB989986:EE_
X-MS-Office365-Filtering-Correlation-Id: eb990c81-0f1f-4cf4-f06a-08df3481a7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|22082099003|18002099003|3023799007|10067099003|261009223027099003|11063799006|5023799004|56012099006|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: KxDSDQDxevI1CORbOkgpb1WsROsC8oTktV+P9sFocBCUSz5qPQQAzogVjCYBd0+84sZ4YXCnZYG/SRc7g6ZVNnXeAdn+s08qTrza3+3Gnv46RixOB6717gRpnun71Grn66mm48HmyK3nQHNy+le0LKkjPmGlU9LuZgsOS3zMHflEI9lApBYKtpm5BWlNIZUu0vhGYIxdazPxYetDnOzFWjjLu2YxaQe2oPBneOqEDGR6BvDtH24pPEWmo7YzJHNos6FJN1nIauAk0n0cddL3alkKN7bLk7h53+a/ksz0R1gYmgrIeXiQ2mlSiyqntW7ih0yuuSgAIEZaVaxjC3jXN2EyZnWa50s7Lxy7iJPImOgv5V6d1k+eP0uYN2DzXzr6iEx2W3bbItI3WMOOyTlwdHA81j2Q09aaRJ6f16iP7sdbEhTOprj804EYsUlMDvhR+B3JGsKs6R7CjgKzCZhCLnXRkAZ1jZh7HlgBa0qBNNrAgXoqzQb6VkQYoPtvU3oN0Bl0g01McuPBZGbFzE2LXe1IHoOI73alEyx9o7wv98iAfoBIeMavT2FP7Bs7xnVXjaHxPhb55m0chYgar5NV3zclveHm3v3rMxl4yVMqO7N2CSYAOZhDzriHNYgXJoCfhZksExM0eW/CAgLMHL//2O7WQ7349D1IOvgwc7f3C/eCn54wn1PXY7HU2zJsWfBmK3TqSiX4dMoPWEyepiQj8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(261009223027099003)(11063799006)(5023799004)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R5tWEFRBsp0JlTwzUe/BHiNqDgC+2c61+X3rYpwXlOca3QgkuNJByPOctfjKLabpy/yUiammausoXsICepQiV5uG1EvnLmynDLyxZIjSbTTSAUHvljvUS/fsJKPokz9yb8U52JhXDWkiZbly0JlpHXZLVl6JHChxIXZPj7b9nM/fLFHgXtDk0zvk3hlnC0+pI4Fc5CnPZnArzNzw2kZYMLewSt+hOcBo7nHBj6O8mEz5T4NKqt77rrfsnR6NNQCnaOnC1HE3x72gKiu2BYGafHQwsW2w1agtLqFAwxhc4rTsW91fvF0Bi4Jb6pu1zlf4wQfCgEGbJEah9Rn3xGMOERxY7HWvpAM+QGXzVmFdiCAh0aTGGbh4oC1KnG0XamT28Kh9xveksVaurIO6DqEK7uJL3P3k52LrcexX0oR9W3lEZJil89374XRX644+3Nkj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:25:58.2191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb990c81-0f1f-4cf4-f06a-08df3481a7ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE940.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR12MB989986
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[WHAT]
Add KUnit tests for amdgpu_dm_connector.c:
- amdgpu_dm_initialize_hdmi_connector(): CEC setup skipped by
  DC_DISABLE_HDMI_CEC.
- amdgpu_dm_hdmi_cec_set_edid() and hdmi_cec_unset_edid(): forwarding
  to a registered CEC notifier.
- amdgpu_dm_connector_destroy(): releasing the pending HDMI HPD
  debounce sink and an unregistered backlight index.
- dm_encoder_helper_atomic_check(): an MST mode forced to YCbCr 4:2:0.
- amdgpu_dm_create_validate_stream_for_sink(): a YCbCr 4:2:0 capable
  mode and a sink-reported bpc that rules out every depth.
- amdgpu_dm_connector_atomic_check(): a connector missing from the
  commit.
- amdgpu_dm_connector_add_common_modes(): common modes already probed.
- parse_edid_displayid_vrr(): a 10-bit max refresh rate.
- hdmi_frl_status_polling_work(): skipping an inactive FRL link.

[HOW]
Extend the existing tests for these functions instead of adding new
cases. Add dm_test_set_420_also_mode() to load CEA VIC 16 and mark it
YCbCr 4:2:0 capable, shared by the encoder and stream tests.

Fix a use-after-free in the connector init tests: the i2c adapter
parent was freed by KUnit before devres deleted the adapter. Manage
the parent with devres on adev->dev so the adapter is deleted first.

Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 80 ++++++++++++++++---
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 7965a221e0e9..0a32f24e9132 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -29,6 +29,7 @@
 #include "amdgpu_dm_connector.h"
 #include "amdgpu_dm_backlight.h"
 #include "amdgpu_dm_hdcp.h"
+#include "amdgpu_dm_irq.h"
 #include "amdgpu_dm_psr.h"
 #include "include/grph_object_id.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
@@ -5128,6 +5129,11 @@ static void dm_test_destroy_releases_dc_sink(struct kunit *test)
 	/* Extra reference so the sink survives destroy for inspection. */
 	dc_sink_retain(sink);
 	aconnector->dc_sink = sink;
+	dc_sink_retain(sink);
+	aconnector->hdmi_prev_sink = sink;
+	aconnector->hdmi_hpd_debounce_delay_ms = 100;
+	INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, amdgpu_dm_hdmi_hpd_debounce_work);
+	aconnector->bl_idx = 0;
 
 	amdgpu_dm_connector_destroy(&aconnector->base);
 
@@ -5233,6 +5239,18 @@ struct dm_test_atomic_check_ctx {
 	struct drm_crtc_state *crtc_state;
 };
 
+/* Load CEA VIC 16 (1080p60) into @mode and mark it YCbCr 4:2:0 capable on @conn. */
+static void dm_test_set_420_also_mode(struct kunit *test, struct drm_device *drm,
+				      struct drm_connector *conn, struct drm_display_mode *mode)
+{
+	struct drm_display_mode *cea = drm_display_mode_from_cea_vic(drm, 16);
+
+	KUNIT_ASSERT_NOT_NULL(test, cea);
+	drm_mode_copy(mode, cea);
+	drm_mode_destroy(drm, cea);
+	set_bit(16, conn->display_info.hdmi.y420_cmdb_modes);
+}
+
 static struct dm_test_atomic_check_ctx *
 dm_test_atomic_check_ctx_alloc(struct kunit *test, int connector_type)
 {
@@ -5501,6 +5519,9 @@ static void dm_test_atomic_check_mst_finds_vcpi_slots(struct kunit *test)
 	dm_test_atomic_check_mst_scaffold(test, ctx, &s, true);
 	s.state->duplicated = false;
 	ctx->dm_state->base.max_requested_bpc = 8;
+	dm_test_set_420_also_mode(test, ctx->drm, &ctx->aconnector->base,
+				  &ctx->crtc_state->adjusted_mode);
+	ctx->aconnector->force_yuv_pixel_format = PIXEL_ENCODING_YCBCR420;
 
 	KUNIT_EXPECT_EQ(test,
 		dm_encoder_helper_atomic_check(&ctx->aenc->base,
@@ -5999,6 +6020,8 @@ static void dm_test_add_common_modes_edp_adds(struct kunit *test)
 	mutex_lock(&ctx->drm->mode_config.mutex);
 	amdgpu_dm_connector_add_common_modes(&ctx->aenc->base,
 					     &ctx->aconnector->base);
+	/* A second pass finds every common mode already probed. */
+	amdgpu_dm_connector_add_common_modes(&ctx->aenc->base, &ctx->aconnector->base);
 	mutex_unlock(&ctx->drm->mode_config.mutex);
 
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 10);
@@ -6664,6 +6687,12 @@ static void dm_test_parse_displayid_vrr_sets_range(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.min_vfreq, 40);
 	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.max_vfreq, 144);
+
+	/* Flags bit 0 extends max vfreq with two bits from the next byte. */
+	ext[2] = 0x01;
+	ext[12] = 0x01;
+	parse_edid_displayid_vrr(connector, edid);
+	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.max_vfreq, 400);
 }
 
 /**
@@ -6923,15 +6952,23 @@ static void dm_test_create_validate_stream_no_valid_bpc(struct kunit *test)
 							   ctx->mode,
 							   ctx->dm_state, NULL);
 	KUNIT_EXPECT_NULL(test, stream);
+
+	/* Same result when the sink-reported bpc is the limiting cap. */
+	ctx->dm_state->base.max_requested_bpc = 16;
+	ctx->aconnector->base.display_info.bpc = 4;
+	stream = amdgpu_dm_create_validate_stream_for_sink(&ctx->aconnector->base, ctx->mode,
+							   ctx->dm_state, NULL);
+	KUNIT_EXPECT_NULL(test, stream);
 }
 
 /**
  * dm_test_create_validate_stream_hdmi_ycbcr - Test the HDMI encoding mask
  * @test: The KUnit test context
  *
- * A native HDMI sink advertising YCbCr 4:4:4 and 4:2:2 exercises HDMI endpoint
- * detection and the YCbCr444/YCbCr422 mask branches; the low bpc cap still
- * prunes every depth, so the helper returns NULL.
+ * A native HDMI sink advertising YCbCr 4:4:4 and 4:2:2, driving a YCbCr 4:2:0
+ * capable mode, exercises HDMI endpoint detection and the YCbCr444, YCbCr422
+ * and YCbCr420 mask branches; the low bpc cap still prunes every depth, so the
+ * helper returns NULL.
  */
 static void dm_test_create_validate_stream_hdmi_ycbcr(struct kunit *test)
 {
@@ -6943,6 +6980,7 @@ static void dm_test_create_validate_stream_hdmi_ycbcr(struct kunit *test)
 	ctx->aconnector->base.display_info.color_formats =
 		BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
 		BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
+	dm_test_set_420_also_mode(test, ctx->drm, &ctx->aconnector->base, ctx->mode);
 
 	stream = amdgpu_dm_create_validate_stream_for_sink(&ctx->aconnector->base,
 							   ctx->mode,
@@ -7371,6 +7409,11 @@ static void dm_test_conn_atomic_check_no_crtc(struct kunit *test)
 	ret = amdgpu_dm_connector_atomic_check(&ctx->aconn->base, ctx->state);
 
 	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	/* A connector missing from the commit is rejected (WARN only). */
+	ctx->state->connectors[0].old_state = NULL;
+	ret = amdgpu_dm_connector_atomic_check(&ctx->aconn->base, ctx->state);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
 }
 
 /**
@@ -8931,6 +8974,12 @@ static void dm_test_frl_skips_zero_rate(struct kunit *test)
 	dm_test_frl_run(ctx);
 
 	KUNIT_EXPECT_EQ(test, dm_test_frl_poll_calls, 0);
+
+	/* An inactive link is skipped as well. */
+	link->frl_link_settings.frl_link_rate = HDMI_FRL_LINK_RATE_3GBPS;
+	link->link_status.link_active = false;
+	dm_test_frl_run(ctx);
+	KUNIT_EXPECT_EQ(test, dm_test_frl_poll_calls, 0);
 }
 
 /**
@@ -9320,16 +9369,25 @@ static void dm_test_init_helper_hpd_debounce_disabled(struct kunit *test)
  * dm_test_initialize_hdmi_cec_registers - Test the CEC notifier is registered
  * @test: The KUnit test context
  *
- * Without DC_DISABLE_HDMI_CEC in the debug mask a CEC notifier is created for
- * the connector.
+ * With DC_DISABLE_HDMI_CEC in the debug mask CEC setup is skipped with -EINVAL.
+ * Without it a CEC notifier is created for the connector, and setting and
+ * unsetting the EDID are forwarded to that notifier.
  */
 static void dm_test_initialize_hdmi_cec_registers(struct kunit *test)
 {
 	struct dm_test_init_helper_ctx *ctx =
 		dm_test_init_helper_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask | DC_DISABLE_HDMI_CEC);
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_initialize_hdmi_connector(ctx->aconnector), -EINVAL);
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_initialize_hdmi_connector(ctx->aconnector), 0);
 	KUNIT_EXPECT_NOT_NULL(test, ctx->aconnector->notifier);
+
+	amdgpu_dm_hdmi_cec_set_edid(ctx->aconnector);
+	hdmi_cec_unset_edid(ctx->aconnector);
 }
 
 /* Tests for amdgpu_dm_update_freesync_caps() */
@@ -9734,11 +9792,13 @@ static void dm_test_fs_caps_disables_replay(struct kunit *test)
 /*
  * amdgpu_dm_create_i2c() parents the adapter on adev->pdev->dev, so
  * devm_i2c_add_adapter() needs a registered device there. Provide one by
- * registering the device embedded in a KUnit allocated pci_dev.
+ * registering the device embedded in a pci_dev managed by adev->dev's devres.
+ * The adapter is devres managed on adev->dev too and is added later, so it is
+ * deleted before its parent is unregistered and freed.
  */
 static void dm_test_conn_init_release_dev(struct device *dev)
 {
-	/* Backing storage is KUnit managed, so there is nothing to free. */
+	/* Backing storage is devres managed, so there is nothing to free. */
 }
 
 static void dm_test_conn_init_unregister_dev(void *data)
@@ -9781,7 +9841,7 @@ dm_test_conn_init_ctx_alloc(struct kunit *test, enum signal_type signal)
 	ctx->adev->mode_info.num_crtc = 1;
 	dm_test_create_mode_props(test, ctx->adev);
 
-	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	pdev = devm_kzalloc(dev, sizeof(*pdev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, pdev);
 	device_initialize(&pdev->dev);
 	pdev->dev.parent = dev;
@@ -9789,8 +9849,8 @@ dm_test_conn_init_ctx_alloc(struct kunit *test, enum signal_type signal)
 	KUNIT_ASSERT_EQ(test, dev_set_name(&pdev->dev, "dm-test-i2c-parent"), 0);
 	KUNIT_ASSERT_EQ(test, device_add(&pdev->dev), 0);
 	KUNIT_ASSERT_EQ(test,
-			kunit_add_action_or_reset(test, dm_test_conn_init_unregister_dev,
-						  &pdev->dev), 0);
+			devm_add_action_or_reset(dev, dm_test_conn_init_unregister_dev,
+						 &pdev->dev), 0);
 	ctx->adev->pdev = pdev;
 
 	ctx->dm = &ctx->adev->dm;
-- 
2.53.0

