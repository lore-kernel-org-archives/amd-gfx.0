Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6C4C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E98410F093;
	Wed, 15 Jul 2026 13:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jd8GdVLc";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1795910F093
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yahyMVEVDJGszesZ2upjiUNnQ273lEv/hkbrUrOmIOflULFQMSqnQkrNZXi8w6JB7k+LHTDzZtYk/yAe1Znce5DfjseOVM1TSYqzl4d0M4CNfO7pzL4zNDRExoVm+KysVm2UqJCg8bJ/3YSeJjKYxg5tqKlZvA1Duo5wXJV0QywRkHbsIbGzfkIBLMlzWSzk5uul1sdmyJ7N/bJ68r3Q0sEn4LsyN4Fcb9dqF+jFPMfa1inGJdm5bjXiCxTQ89zg+AV8P8seIFMoeH7g4QD9bYqckDAQ1sZaXBLEukjtS7+r8UHeDAhInrTkhc7o54KBpWG1vp3aGEtL6h5sNx0hfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gASHtV7Q2z9S4uJHuE0hCT30KGEaaeZWmscSewnLRjE=;
 b=Q4wL5LWVm8UJzYJNHR26pXsh7pGyXEYep724fH5z/16aAAky2J6BH/XsVoi2WDkE5XGlOxc7txkCkdAnv3HcfgGXj6LGGDSXAPvX2Z+JU0M5OCk94eIH7hVfRvVXN243G7AETy+edIgBFNdVVZBEk4C/2sQJegmEZIFl71T0xe5A/R3TTHR56eagYxujtgK9m6E49yrc7N2+cn9D6YafO3+R9VMmnBFEoLj2Zd//wr+oD3O8AvbPah6o/sgSJonbsobjumwCbVl50IYkk3607G1BTzmmzL+IBgfb+kIEr4j7PHdF4UqjalW2x7ehsdGYBdVQeGrMArPP0KZRXDT7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gASHtV7Q2z9S4uJHuE0hCT30KGEaaeZWmscSewnLRjE=;
 b=jd8GdVLc51LtY44+8S5g5qwGXbyEM/s1uotrxqxF6oRNDI+0LZq+l9CLRYPFbWBb5yDSm6pRWTxxKkUcAw/TKHumX0TCFraypc/nzq7codGPQN2TY+JJGHzA822qITRBvcfpjilIlQYPPuOmA1H5JI/dCQJKezLo9n/SKgDLl1Y=
Received: from BY5PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:1e0::19)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Wed, 15 Jul
 2026 13:47:09 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9f) by BY5PR03CA0009.outlook.office365.com
 (2603:10b6:a03:1e0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:08 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 36/70] drm/amd/display: add KUnit tests for per-frame master
 sync
Date: Wed, 15 Jul 2026 21:37:46 +0800
Message-ID: <20260715134432.1975118-37-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: c9324a52-ebc9-43d0-e554-08dee2779137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|22082099003|18002099003|6133799003|10067099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: oClM/GGmbscN7F9rl4zgN9ZNTjKqEjvfnKCrgfoHORHuUGJqVYC5Vz+N/8gIgxhCPVqK4vKpM1jKkuiYc+bnGkQUDnM9qIPME+s+lHVvS08uSCWhpP3JURCrYq22UtuXXBuBFNufRMQ8H7gMnQqDvqdybzsblYkdb21GTlZff+TIbqyg4dIr4M0cBTBijxjPfk2/qg76kmQysldmCwr8872z1n6WGYiMJrQv7L7h3eCli8GhMK3ZFYogkMuuogm8yQOteiaXKz6/7fP8bZ3ghYla1m1uOyS2MLu0W8fixC0BDlBbmIS74xlr1ZYHQvoKCxyoiNpdL9Q731kFt20JkxV+x/dV1bN2aU4Kl1TMPtuqS/ndni0UKJYQ6w6YF8FE2+UbUEGx1d3bnQeVMDdl6eIwUO1csTgPQBrfuUgZaR9jbV5vZ89cPmtYmnS5wY4zYA4aw3BXrkdSHAzxDxMu0qn8aoyGkHuSSDykt4PZcuY7uqoIFMasbsKWq1GuWCcthvyZQQ8pBbtFcpeNQUyKsYBd9oL2oi3A1DWNFsse9JEZTFBZodWTdsbwMmsf4p+NBxUYYZd/VyPKAjikjKGOECfCWbgMcAIkhxP/5txHgYH57WK4VaU1GxLNlI0GURESOo5Q7frcLWJK2WNwdYwjkZrl2MAW9rfQ0KRk/qgxuWeqPgJxFSiliUdTTLkjDK2ngJ+TyPBojNp+wtpcRnz2Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cIQ/8p9vNkBYJzy88phZnTw1nMoNwoYQR5fqGM6tf2xnZC4kxindI0flyF0IPddy02hgJA6misE+Fnw7ZDVixi+jY1fbaVWxdKba8xxc28sXOYkDSQ7McUZTpBBacc+tCIuE2F2RmoQP4ZPU/Lq2FcgPYA82fPAqyy0MNZdMZi1OCNJaAnF4K+eL1XPAXZ3FQsdpFttAlPtLse2lTmJYSJw9qdB9gdMDX6LcmjYO6kKbkGXkM0CzQRIb+wyL8qUjDNR9KIBmD665eEV/XLSi/LXrxv2CYykVBY0+eyv9zIQl9KQ1jS/2Pw0BXn0FwATv8jn27xaiEJDwzqBxPpBoaP9C3hbKFQhxPcxTVML89/2kHcGjr/aX7IVnatLruQ2g07wZlSYlvLNKnoYpy2QQDB4roRbYEYufFQcMvFbXie6rAuYmmq+bjE97/nv/mI5o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:09.7259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9324a52-ebc9-43d0-e554-08dee2779137
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
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
Add KUnit tests for dm_enable_per_frame_crtc_master_sync covering the
single-stream no-op, the two-stream master selection with trigger
parameters, and the NULL-stream skip path.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 103 ++++++++++++++++++
 3 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fa0add5bcabf..8fe7e125e14a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -141,7 +141,7 @@ static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm);
 
 static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_state *state);
 static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
-static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context);
+STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context);
 
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_state *state);
@@ -5342,7 +5342,7 @@ STATIC_IFN_KUNIT void set_master_stream(struct dc_stream_state *stream_set[],
 }
 EXPORT_IF_KUNIT(set_master_stream);
 
-static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
+STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 {
 	int i = 0;
 	struct dc_stream_state *stream;
@@ -5370,6 +5370,7 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 		set_multisync_trigger_params(stream);
 	}
 }
+EXPORT_IF_KUNIT(dm_enable_per_frame_crtc_master_sync);
 
 /**
  * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 29cefa4d8468..897434504459 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1181,6 +1181,7 @@ void set_master_stream(struct dc_stream_state *stream_set[], int stream_count);
 void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
 void get_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state,
 				  struct dm_connector_state *new_con_state);
+void dm_enable_per_frame_crtc_master_sync(struct dc_state *context);
 struct hdcp_workqueue;
 bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
 				     struct drm_crtc_state *old_crtc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 1464eeda704b..b988198418c6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1838,6 +1838,105 @@ static void dm_test_reset_freesync_config(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, crtc_state->vrr_infopacket.valid);
 }
 
+/* Tests for dm_enable_per_frame_crtc_master_sync() */
+
+/**
+ * dm_test_per_frame_master_sync_single_stream - Test fewer than two streams is a no-op
+ * @test: The KUnit test context
+ */
+static void dm_test_per_frame_master_sync_single_stream(struct kunit *test)
+{
+	struct dc_state *context;
+	struct dc_stream_state *stream;
+
+	context = kunit_kzalloc(test, sizeof(*context), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, context);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	stream->triggered_crtc_reset.enabled = true;
+	context->streams[0] = stream;
+	context->stream_count = 1;
+
+	dm_enable_per_frame_crtc_master_sync(context);
+
+	/* < 2 streams: early return, event_source stays NULL */
+	KUNIT_EXPECT_NULL(test, stream->triggered_crtc_reset.event_source);
+}
+
+/**
+ * dm_test_per_frame_master_sync_two_streams - Test the master is picked and applied
+ * @test: The KUnit test context
+ */
+static void dm_test_per_frame_master_sync_two_streams(struct kunit *test)
+{
+	struct dc_state *context;
+	struct dc_stream_state *stream0, *stream1;
+
+	context = kunit_kzalloc(test, sizeof(*context), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, context);
+	stream0 = kunit_kzalloc(test, sizeof(*stream0), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream0);
+	stream1 = kunit_kzalloc(test, sizeof(*stream1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream1);
+
+	/* stream0 60Hz, stream1 120Hz, both trigger-reset enabled */
+	stream0->triggered_crtc_reset.enabled = true;
+	stream0->timing.pix_clk_100hz = 1485000;
+	stream0->timing.h_total = 2200;
+	stream0->timing.v_total = 1125;
+	stream1->triggered_crtc_reset.enabled = true;
+	stream1->timing.pix_clk_100hz = 2970000;
+	stream1->timing.h_total = 2200;
+	stream1->timing.v_total = 1125;
+	stream1->timing.flags.VSYNC_POSITIVE_POLARITY = 1;
+
+	context->streams[0] = stream0;
+	context->streams[1] = stream1;
+	context->stream_count = 2;
+
+	dm_enable_per_frame_crtc_master_sync(context);
+
+	/* set_master_stream picks the highest refresh (stream1) as event source */
+	KUNIT_EXPECT_PTR_EQ(test, stream0->triggered_crtc_reset.event_source,
+			    stream1);
+	KUNIT_EXPECT_PTR_EQ(test, stream1->triggered_crtc_reset.event_source,
+			    stream1);
+	/* set_multisync_trigger_params applied to enabled streams */
+	KUNIT_EXPECT_EQ(test, (int)stream0->triggered_crtc_reset.event,
+			(int)CRTC_EVENT_VSYNC_RISING);
+	KUNIT_EXPECT_EQ(test, (int)stream0->triggered_crtc_reset.delay,
+			(int)TRIGGER_DELAY_NEXT_PIXEL);
+}
+
+/**
+ * dm_test_per_frame_master_sync_skips_null_stream - Test NULL stream entries are skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_per_frame_master_sync_skips_null_stream(struct kunit *test)
+{
+	struct dc_state *context;
+	struct dc_stream_state *stream;
+
+	context = kunit_kzalloc(test, sizeof(*context), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, context);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	stream->triggered_crtc_reset.enabled = true;
+	stream->timing.pix_clk_100hz = 1485000;
+	stream->timing.h_total = 2200;
+	stream->timing.v_total = 1125;
+	context->streams[0] = stream;
+	context->streams[1] = NULL;
+	context->stream_count = 2;
+
+	dm_enable_per_frame_crtc_master_sync(context);
+
+	KUNIT_EXPECT_PTR_EQ(test, stream->triggered_crtc_reset.event_source,
+			    stream);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_is_idle),
@@ -1939,6 +2038,10 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_freesync_config_active_fixed),
 	/* reset_freesync_config_for_crtc */
 	KUNIT_CASE(dm_test_reset_freesync_config),
+	/* dm_enable_per_frame_crtc_master_sync */
+	KUNIT_CASE(dm_test_per_frame_master_sync_single_stream),
+	KUNIT_CASE(dm_test_per_frame_master_sync_two_streams),
+	KUNIT_CASE(dm_test_per_frame_master_sync_skips_null_stream),
 	{}
 };
 
-- 
2.43.0

