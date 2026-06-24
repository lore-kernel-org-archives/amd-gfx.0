Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4FDCDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC92110F086;
	Wed, 24 Jun 2026 18:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AoqjUHGn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012029.outbound.protection.outlook.com
 [40.93.195.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE3FF10F096
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A96Js1F/fE3fbEhvg8R4TKL7vPuKJFWv/bxNkqS2olICi9xhyHaObLFKthMmnC3NS32BsPuoKoRQBq5baSSNiW5oJChY+ovRCT0neG2mxT3omcdPAOkd0D79ct5yXwvVShnck/1mfXfyBd1l/FohjT+mfqd4pG+eHNymOGEzBd1v1Kckt+OokXm3J8MzcZlEOlYw9gKaQGEyQmHyQbBWFE8ktC3WIAVcW1+fNTR8JgRZOCbZEFOIr9zVOT0iP+PdoUyuScLp4OgIPvkV3RXr61nnVgSu8J85wOgbPfd2Go4ju88JEcVctCJZf64heETGkVDI95WgCKFznmLhJO1N9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Trm8peSwJreb01KjRTEGB4AoLg5JYhQuo0Rsc1BRKG0=;
 b=ml/C99tBGg1aUYuj1E/Jf61LD5asTLGcX4uhkpGTUhqua9Ec3Q9yAvqxw2obNmdUUpgrmlP2pyFZGWRSuFm/GvgDUUKnfJFd1eHmc0TZah1vfTVDZ3npxmAyeBhVz0t8GzmS9+aS4ST1x7GtKk1/mJupEQwVdkCpqp9xaLzxfRLozBGEknbAbsEoMSF0vdkMVrW+GF9odnOyopIpJ4PuzWinsKIPmQeRsDI7VLd/fFDR9o7DYzFVuGX/MCVNJJeXg6usgVKVIUzOJkbWGYYWv1ft7G65I12y1x0GM12+zbjeBlQncv+uKUuNPUG3UJPRoan88ZywcXWZEjm6VJenRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Trm8peSwJreb01KjRTEGB4AoLg5JYhQuo0Rsc1BRKG0=;
 b=AoqjUHGn+WtWCRQVOWVMplmvPz1Ngl2JqUidLGtUa49h39jEoeNLleRIDQuzEbr4pKDCNeSWPopqFjrajm+nsw5560mFdnSHHRHfra9FrH7dD7m+KNB/Bv/boKe13oolHryDt9wBxeo7FzIY64okNdJhJR0CItnrmvhpyODqmSE=
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 18:09:39 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::6) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Wed,
 24 Jun 2026 18:09:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:38 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:28 -0500
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
Subject: [PATCH 18/28] drm/amd/display: Add KUnit tests for amdgpu_dm_replay
Date: Wed, 24 Jun 2026 14:03:16 -0400
Message-ID: <20260624180829.4775-19-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: db327cfe-ec14-4e10-911b-08ded21bc154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|6133799003|22082099003|18002099003|3023799007|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: ByPh0OH571NgpW301azLbLQP6Hy4dQMqW7kx52mfStLACHJKA/t52oW4mEjYtWIjmGj/itwicUaRFD+/1Y8pdWUTFmT6FcCMlV+w+t0JMVqwJTRx3pJArZuAXsQqjIcdH0FqVzVb603t2iLYDE92DB5LWizls6khukSKSDQ9Vqo6I6CaFE2CbiTHdzg9ujCcjImmoyMT5qMqfqRbIKe8BoFLZCdjzCzZ8vzu/mvp9BJfmDSSnOj2dmJ/FYVcTSUY+5Z8ckSdYGiNqCwLtA04Y4ylR75YDhKxGjfrzwGWkLGqHnrODilT7EwxTpbbeMPAFi5o/v0YXGEBP9cL4J+77O5Msgc1UwNrkyajCd3ul3DPr/oZYQ7f0Wy/tue0heW7Mga/WepiWGrULAAmot9rBRfCJQ1rlbCaxuBiUW159Opb3CD4shBCf8f3vzLkQTmQf3U6hZA5TAhbHmrFJ5PSNFyCPu1wXuw9/Ns8/BSgCk8LpGusZ7EJUxKQKslBfT36GHEjGYeFWULZReBCLWGs8iwUCphSg5/vmHUGn6r3WPyvf4myBouTwUbb13kZT4Bwk4c98tLnG/WIaiC4gA1pr5LcbGe0V+LqksnJD9CqONJvx9WKqNZR3JDbJ0qZ5Lu4uZlqPCBqSpz8OFEKQ5aku7ukpNLRV10qSlt/6shgKvIE/01oNH7nbZPM+wf0uymbpRIZXedWxdlYQvrtmMoc/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N2GeRjmRbN0nTMQ/6q4/6SWIidJe599X0HXmXXoMPxyamvJZRwU7LJ3U2U8Szfukj3Hew4CzfJn0eUXE08TyTfGMPYqogCJowilrfthLANWCqKuE3/fEoMX3kg8Rmj2rM88V+ESpppHCUvegoWgOnTL07RR7izpeVnfPcmt4QdhVnRXBDg3R/y9BCDRHMCTxw5OZOhj+2XX3jpeBpP24kUhHb/zYa8wOJJOk8xpVnEBsVNWDdbVEFd9jivaQizyfL6CBdxQh624/tqeRigNtcPhEWczh51Ef8jzlrxSwkjWIXl8qmEY6qOrnef15oO0ViwsbEx1I1cEYte93TCEEcwbnpiEMFrKrFnxmEVaa8ZG5u4Vw8w5pwxZS2sMsEnEDQgLhiCi+UYKWjJZVnJ1oqdM3I3RX4z8zSQHMouZiDrvPt117UWaa3huM3bt19p2R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:38.1584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db327cfe-ec14-4e10-911b-08ded21bc154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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
Add KUnit coverage for amdgpu_dm_set_replay_caps(),
amdgpu_dm_link_setup_replay(), and amdgpu_dm_replay_set_event()
including happy-path tests that exercise the configuration logic,
coasting vtotal calculations, and early-return when replay events
are already in the desired state.

Assisted-by: Copilot:Claude-Opus-4.6 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   3 +
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c   | 437 +++++++++++++++++-
 2 files changed, 436 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index f3cea2aba901..42e17119461d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -128,6 +128,7 @@ bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector
 
 	return true;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_replay_caps);
 
 /*
  * amdgpu_dm_link_setup_replay() - config replay settings
@@ -166,6 +167,7 @@ bool amdgpu_dm_link_setup_replay(struct dc_stream_state *stream,
 			static_coasting_vtotal);
 	return true;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_link_setup_replay);
 
 /*
  * amdgpu_dm_replay_set_event() - set or clear replay event for a stream
@@ -205,3 +207,4 @@ bool amdgpu_dm_replay_set_event(struct amdgpu_display_manager *dm,
 	return mod_power_set_replay_event(dm->power_module, stream,
 					 set_event, event, wait_for_disable);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_replay_set_event);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
index 28ff8bbcc0f7..68f2f4d70407 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
@@ -8,12 +8,12 @@
 #include <kunit/test.h>
 
 #include "dc.h"
+#include "dc_dmub_srv.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
-
-/* Extern declaration for the function under test */
-extern bool amdgpu_dm_link_supports_replay(struct dc_link *link,
-					   struct amdgpu_dm_connector *aconnector);
+#include "amdgpu_dm_replay.h"
+#include "modules/power/power_helpers.h"
+#include "dmub/dmub_srv.h"
 
 /*
  * Helper: allocate a dc_link, amdgpu_dm_connector, and dm_connector_state
@@ -23,6 +23,9 @@ struct replay_test_ctx {
 	struct dc_link *link;
 	struct amdgpu_dm_connector *aconnector;
 	struct dm_connector_state *dm_state;
+	struct dc *dc;
+	struct dc_context *dc_ctx;
+	struct dc_stream_state *stream;
 };
 
 static struct replay_test_ctx *alloc_replay_ctx(struct kunit *test)
@@ -41,8 +44,21 @@ static struct replay_test_ctx *alloc_replay_ctx(struct kunit *test)
 	ctx->dm_state = kunit_kzalloc(test, sizeof(*ctx->dm_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->dm_state);
 
+	ctx->dc = kunit_kzalloc(test, sizeof(*ctx->dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc);
+
+	ctx->dc_ctx = kunit_kzalloc(test, sizeof(*ctx->dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc_ctx);
+
+	ctx->stream = kunit_kzalloc(test, sizeof(*ctx->stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->stream);
+
 	/* Wire connector state so to_dm_connector_state() works */
 	ctx->aconnector->base.state = &ctx->dm_state->base;
+	ctx->link->ctx = ctx->dc_ctx;
+	ctx->dc_ctx->dc = ctx->dc;
+	ctx->dc->ctx = ctx->dc_ctx;
+	ctx->stream->link = ctx->link;
 
 	return ctx;
 }
@@ -55,6 +71,7 @@ static void set_all_replay_caps(struct replay_test_ctx *ctx)
 {
 	ctx->dm_state->freesync_capable = true;
 	ctx->aconnector->vsdb_info.replay_mode = true;
+	ctx->link->connector_signal = SIGNAL_TYPE_EDP;
 	ctx->link->dpcd_caps.edp_rev = EDP_REVISION_13;
 	ctx->link->dpcd_caps.alpm_caps.bits.AUX_WAKE_ALPM_CAP = 1;
 	ctx->link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT = 1;
@@ -181,7 +198,398 @@ static void dm_test_replay_both_deviations_zero(struct kunit *test)
 
 /* End of tests for amdgpu_dm_link_supports_replay() */
 
+/* Tests for amdgpu_dm_set_replay_caps() */
+
+/**
+ * dm_test_replay_set_caps_already_supported - Verify cached Replay support
+ * @test: KUnit test context
+ *
+ * When replay_supported is already set, amdgpu_dm_set_replay_caps() should
+ * return true without revalidating the link capabilities.
+ */
+static void dm_test_replay_set_caps_already_supported(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	ctx->link->replay_settings.config.replay_supported = true;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_set_replay_caps(ctx->link, ctx->aconnector));
+}
+
+/**
+ * dm_test_replay_set_caps_non_embedded_signal - Verify non-eDP rejection
+ * @test: KUnit test context
+ *
+ * When the link signal is not embedded, amdgpu_dm_set_replay_caps() should
+ * reject Replay even if the sink capability fields are otherwise valid.
+ */
+static void dm_test_replay_set_caps_non_embedded_signal(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_replay_caps(ctx->link, ctx->aconnector));
+}
+
+/**
+ * dm_test_replay_set_caps_disallowed_by_panel - Verify panel policy rejection
+ * @test: KUnit test context
+ *
+ * When the panel configuration disallows Replay, amdgpu_dm_set_replay_caps()
+ * should return false before accepting the capability set.
+ */
+static void dm_test_replay_set_caps_disallowed_by_panel(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->link->panel_config.psr.disallow_replay = true;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_replay_caps(ctx->link, ctx->aconnector));
+}
+
+/**
+ * dm_test_replay_set_caps_link_not_supported - Verify capability rejection
+ * @test: KUnit test context
+ *
+ * When amdgpu_dm_link_supports_replay() rejects the link, the higher-level
+ * Replay setup helper should also return false.
+ */
+static void dm_test_replay_set_caps_link_not_supported(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->dm_state->freesync_capable = false;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_replay_caps(ctx->link, ctx->aconnector));
+}
+
+/**
+ * dm_test_replay_set_caps_missing_dmub_srv - Verify missing DMUB rejection
+ * @test: KUnit test context
+ *
+ * When the link and connector support Replay but no DMUB service is available,
+ * amdgpu_dm_set_replay_caps() should return false.
+ */
+static void dm_test_replay_set_caps_missing_dmub_srv(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_replay_caps(ctx->link, ctx->aconnector));
+}
+
+/**
+ * dm_test_replay_set_caps_success - Verify successful Replay configuration
+ * @test: KUnit test context
+ *
+ * When all prerequisites are met (embedded signal, panel allows replay, link
+ * supports replay, DMUB present with replay support), amdgpu_dm_set_replay_caps()
+ * should configure the link replay settings and return true.
+ */
+static void dm_test_replay_set_caps_success(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct dc_dmub_srv *dmub_srv;
+	struct dmub_srv *dmub;
+
+	set_all_replay_caps(ctx);
+
+	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dmub_srv);
+
+	dmub = kunit_kzalloc(test, sizeof(*dmub), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dmub);
+
+	dmub->feature_caps.replay_supported = 1;
+	dmub_srv->dmub = dmub;
+	ctx->dc_ctx->dmub_srv = dmub_srv;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_set_replay_caps(ctx->link, ctx->aconnector));
+	KUNIT_EXPECT_TRUE(test, ctx->link->replay_settings.config.replay_supported);
+}
+
+/* Tests for amdgpu_dm_link_setup_replay() */
+
+/**
+ * dm_test_replay_link_setup_null_stream - Verify NULL stream rejection
+ * @test: KUnit test context
+ *
+ * amdgpu_dm_link_setup_replay() should return false when no stream is provided.
+ */
+static void dm_test_replay_link_setup_null_stream(struct kunit *test)
+{
+	struct mod_vrr_params vrr_params = { 0 };
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_link_setup_replay(NULL, &vrr_params));
+}
+
+/**
+ * dm_test_replay_link_setup_null_link - Verify NULL stream link rejection
+ * @test: KUnit test context
+ *
+ * amdgpu_dm_link_setup_replay() should return false when the stream has no
+ * associated link.
+ */
+static void dm_test_replay_link_setup_null_link(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct mod_vrr_params vrr_params = { 0 };
+
+	ctx->stream->link = NULL;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_link_setup_replay(ctx->stream, &vrr_params));
+}
+
+/**
+ * dm_test_replay_link_setup_null_vrr_params - Verify NULL VRR params rejection
+ * @test: KUnit test context
+ *
+ * amdgpu_dm_link_setup_replay() should return false when VRR parameters are
+ * not supplied.
+ */
+static void dm_test_replay_link_setup_null_vrr_params(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_link_setup_replay(ctx->stream, NULL));
+}
+
+/**
+ * dm_test_replay_link_setup_not_supported - Verify unsupported Replay rejection
+ * @test: KUnit test context
+ *
+ * amdgpu_dm_link_setup_replay() should return false when Replay is not marked
+ * supported on the link configuration.
+ */
+static void dm_test_replay_link_setup_not_supported(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct mod_vrr_params vrr_params = { 0 };
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_link_setup_replay(ctx->stream, &vrr_params));
+}
+
+/**
+ * dm_test_replay_link_setup_already_enabled - Verify enabled Replay success
+ * @test: KUnit test context
+ *
+ * When Replay is already enabled, amdgpu_dm_link_setup_replay() should return
+ * true without recalculating coasting vtotal state.
+ */
+static void dm_test_replay_link_setup_already_enabled(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct mod_vrr_params vrr_params = { 0 };
+
+	ctx->link->replay_settings.config.replay_supported = true;
+	ctx->link->replay_settings.replay_feature_enabled = true;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_link_setup_replay(ctx->stream, &vrr_params));
+}
+
+/**
+ * dm_test_replay_link_setup_success - Verify coasting vtotal configuration
+ * @test: KUnit test context
+ *
+ * When Replay is supported but not yet enabled, amdgpu_dm_link_setup_replay()
+ * should calculate the link-off frame count and set the coasting vtotal values,
+ * then return true.
+ */
+static void dm_test_replay_link_setup_success(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct mod_vrr_params vrr_params = { 0 };
+
+	ctx->link->replay_settings.config.replay_supported = true;
+	ctx->link->replay_settings.config.replay_version = DC_FREESYNC_REPLAY;
+
+	/* Set timing so calculate_replay_link_off_frame_count computes */
+	ctx->stream->timing.v_total = 1125;
+	ctx->stream->timing.h_total = 2200;
+	ctx->stream->timing.pix_clk_100hz = 1485000;
+	ctx->link->dpcd_caps.pr_info.pixel_deviation_per_line = 4;
+	ctx->link->dpcd_caps.pr_info.max_deviation_line = 10;
+
+	/* min_refresh_in_uhz = 0 makes calc return v_total directly */
+	vrr_params.min_refresh_in_uhz = 0;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_link_setup_replay(ctx->stream, &vrr_params));
+
+	/* Verify coasting vtotal was set */
+	KUNIT_EXPECT_EQ(test,
+			ctx->link->replay_settings.coasting_vtotal_table[PR_COASTING_TYPE_NOM],
+			(uint32_t)1125);
+	KUNIT_EXPECT_EQ(test,
+			ctx->link->replay_settings.coasting_vtotal_table[PR_COASTING_TYPE_STATIC],
+			(uint32_t)1125);
+
+	/* Verify link_off_frame_count was calculated: 2200*10/(4*1125) = 4 */
+	KUNIT_EXPECT_EQ(test,
+			ctx->link->replay_settings.link_off_frame_count,
+			(uint32_t)4);
+}
+
+/* Tests for amdgpu_dm_replay_set_event() */
+
+/**
+ * dm_test_replay_set_event_null_stream - Verify NULL stream rejection
+ * @test: KUnit test context
+ *
+ * amdgpu_dm_replay_set_event() should return false when no stream is provided.
+ */
+static void dm_test_replay_set_event_null_stream(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_replay_set_event(dm, NULL, true,
+							    replay_event_vsync, false));
+}
+
+/**
+ * dm_test_replay_set_event_null_link - Verify NULL stream link rejection
+ * @test: KUnit test context
+ *
+ * amdgpu_dm_replay_set_event() should return false when the stream has no
+ * associated link.
+ */
+static void dm_test_replay_set_event_null_link(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
+
+	ctx->stream->link = NULL;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_replay_set_event(dm, ctx->stream, true,
+							    replay_event_vsync, false));
+}
+
+/**
+ * dm_test_replay_set_event_feature_disabled - Verify disabled Replay rejection
+ * @test: KUnit test context
+ *
+ * amdgpu_dm_replay_set_event() should return false when Replay is not enabled
+ * on the stream link.
+ */
+static void dm_test_replay_set_event_feature_disabled(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_replay_set_event(dm, ctx->stream, true,
+							    replay_event_vsync, false));
+}
+
+/**
+ * dm_test_replay_set_event_missing_power_module - Verify missing power rejection
+ * @test: KUnit test context
+ *
+ * When Replay is enabled but no power module is available, the event helper
+ * should return false after failing to read the current Replay events.
+ */
+static void dm_test_replay_set_event_missing_power_module(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
+
+	ctx->link->replay_settings.replay_feature_enabled = true;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_replay_set_event(dm, ctx->stream, true,
+							    replay_event_vsync, false));
+}
+
+/**
+ * dm_test_replay_set_event_already_set - Verify no-op when event already active
+ * @test: KUnit test context
+ *
+ * When the requested event is already in the desired state, the function should
+ * return true without calling mod_power_set_replay_event().
+ */
+static void dm_test_replay_set_event_already_set(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct core_power *core_power;
+	struct power_entity *map;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
+
+	core_power = kunit_kzalloc(test, sizeof(*core_power), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, core_power);
+
+	map = kunit_kzalloc(test, sizeof(*map), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, map);
+
+	/* Wire the power module so mod_power_get_replay_event() succeeds */
+	map->stream = ctx->stream;
+	map->replay_events = replay_event_vsync;
+	core_power->map = map;
+	core_power->num_entities = 1;
+	dm->power_module = &core_power->mod_public;
+
+	ctx->link->replay_settings.replay_feature_enabled = true;
+
+	/* Event already set — should return true without calling set */
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_replay_set_event(dm, ctx->stream, true,
+							   replay_event_vsync, false));
+}
+
+/**
+ * dm_test_replay_set_event_already_clear - Verify no-op when event already cleared
+ * @test: KUnit test context
+ *
+ * When clearing an event that is not currently active, the function should
+ * return true without calling mod_power_set_replay_event().
+ */
+static void dm_test_replay_set_event_already_clear(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct core_power *core_power;
+	struct power_entity *map;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
+
+	core_power = kunit_kzalloc(test, sizeof(*core_power), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, core_power);
+
+	map = kunit_kzalloc(test, sizeof(*map), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, map);
+
+	/* Wire the power module — replay_events has NO vsync bit */
+	map->stream = ctx->stream;
+	map->replay_events = 0;
+	core_power->map = map;
+	core_power->num_entities = 1;
+	dm->power_module = &core_power->mod_public;
+
+	ctx->link->replay_settings.replay_feature_enabled = true;
+
+	/* Clearing an event that's already clear — should return true */
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_replay_set_event(dm, ctx->stream, false,
+							   replay_event_vsync, false));
+}
+
 static struct kunit_case dm_replay_test_cases[] = {
+	/* amdgpu_dm_link_supports_replay */
 	KUNIT_CASE(dm_test_replay_supports_all_caps),
 	KUNIT_CASE(dm_test_replay_no_freesync),
 	KUNIT_CASE(dm_test_replay_no_vsdb_replay_mode),
@@ -191,6 +599,27 @@ static struct kunit_case dm_replay_test_cases[] = {
 	KUNIT_CASE(dm_test_replay_zero_pixel_deviation),
 	KUNIT_CASE(dm_test_replay_zero_max_deviation_line),
 	KUNIT_CASE(dm_test_replay_both_deviations_zero),
+	/* amdgpu_dm_set_replay_caps */
+	KUNIT_CASE(dm_test_replay_set_caps_already_supported),
+	KUNIT_CASE(dm_test_replay_set_caps_non_embedded_signal),
+	KUNIT_CASE(dm_test_replay_set_caps_disallowed_by_panel),
+	KUNIT_CASE(dm_test_replay_set_caps_link_not_supported),
+	KUNIT_CASE(dm_test_replay_set_caps_missing_dmub_srv),
+	KUNIT_CASE(dm_test_replay_set_caps_success),
+	/* amdgpu_dm_link_setup_replay */
+	KUNIT_CASE(dm_test_replay_link_setup_null_stream),
+	KUNIT_CASE(dm_test_replay_link_setup_null_link),
+	KUNIT_CASE(dm_test_replay_link_setup_null_vrr_params),
+	KUNIT_CASE(dm_test_replay_link_setup_not_supported),
+	KUNIT_CASE(dm_test_replay_link_setup_already_enabled),
+	KUNIT_CASE(dm_test_replay_link_setup_success),
+	/* amdgpu_dm_replay_set_event */
+	KUNIT_CASE(dm_test_replay_set_event_null_stream),
+	KUNIT_CASE(dm_test_replay_set_event_null_link),
+	KUNIT_CASE(dm_test_replay_set_event_feature_disabled),
+	KUNIT_CASE(dm_test_replay_set_event_missing_power_module),
+	KUNIT_CASE(dm_test_replay_set_event_already_set),
+	KUNIT_CASE(dm_test_replay_set_event_already_clear),
 	{}
 };
 
-- 
2.53.0

