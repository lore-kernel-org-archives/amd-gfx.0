Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28325606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YgppZQJz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48EB10F834;
	Tue, 17 Nov 2026 17:16:09 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001EA10F834
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLpNe421sDVMn+TCwxChUxdYR/b5y3HE3hsh6ZEkEpxAq+9FetSXdTaPWLK57Flh8WeThjjPrD8CrOe3OTE5CGh8WvkBolX85FT93BfG8g6+Rx0h40lBHiyoSRkXk/89tWrlOCfGEPr3Na+C9T5NsAgq4f5RiDbcGja+IUzRYb+rgdHA2w6dhyoWcjatIZ9EgEXWexnWCVZ96PqIH4XoZXjCdxMIN3JhQakq1tTFl/FE4LpaQj1ys42yg4tfrZrX5T0uckXgxVY/6elc7oXY7Zrf7dOjM7yy72p7vpvSQCEgV/lvT7yWGeXhatYu77ZIDQ/HHFXSgKuSwjppuZErrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM50lt6NxZosP8kpcrJgbbhZKPXFbAIL7jRhbn9C1Y0=;
 b=dT+ABa/FAcdRsrE3YIchFwqnTO0RL+JpfvNagVPAaTVmEcJpWjGmvW3CgtnX4IiyBGqp1aWQvg5IRWXegs5iL6ODFPZI1k9nmKKc9qruPXhcsVXjqyRs27tLODr1oC/yK9UDtPz+4OjxOu5i/c5588e/x+yEu+Rzb6aMFL7yJPu8MbytY/RdFiB8cGZDz0LZqKWcbKAIqsetrIFsdHpYdatVNk0eH2qx0WweiOto17IzuWx2ySAv8yWo9gKZQHdfjpq7rAwEyYjrlKo/W+q3k9IRZw5wW2JDRbljArpmPB58sSFKtpSOMKbcZxi7tV0NKobwRfoqNa0rLGoDQamWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM50lt6NxZosP8kpcrJgbbhZKPXFbAIL7jRhbn9C1Y0=;
 b=YgppZQJz7CR4EuOqhXFKOAMabsWGpRAjC3i8au2MBtaf1+KSSQDPGNgzUgQWVp2qkrpqxbe7XDP5BsMDx2odDAwqllVJx5mXNGIiG6+mnunWKdJW5uLtOOQQ79+IZ5NGBlMSljncqBuGiMs7cMwxwZwgC0VBUmokEPsrpaVTAUU=
Received: from MN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:52f::34)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:15:50 +0000
Received: from BN1PEPF00018075.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::ae) by MN0PR03CA0029.outlook.office365.com
 (2603:10b6:208:52f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:15:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018075.mail.protection.outlook.com (10.167.245.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:15:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:15:47 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:15:33 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 21/33] drm/amd/display: Disable Replay when link off frame
 count is below 2
Date: Tue, 17 Nov 2026 05:50:58 +0800
Message-ID: <20261116215641.2800595-22-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018075:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 00acb01f-5146-46d3-8aa4-08df44ce6dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|5023799004|11063799006|56012099006|261102130727099003|10067099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: yg3ppwHaooCsqFMDXuPtZuhaS2Ww4IWoUnn6ttf8UMuV2W1mp9TMsrf4tK9G+6wsbAWcWOXrD5HjYj2gptY4J9qX/IygyYdWnuT/+3qrFdlWU3faacjNXjEDDZYuzTOwQacWNcGw+R0fDJ8IglSAiWgEMtaJpjP5L+nXF17vFVo1EMFdUCcVPUeAib5OcyvuR+xQMGRmoJgTLQEQFJLVYFEdX8MFu5JgtYyF3fy4xyVMD/ZOY/VG56YdudjTw0sL6mtuL/N+9lw3ERd4iTvYW0OHf12wnmvk62M8Uq0QSN0XjYYRuPomytuhSpC8463NDPmohJBIT/6FOYhdHMLd9rbY8aN9p9taRmt0dd7C8PoDrQQOhreWVNaVdK4XwyMxSJGngXrln9DSVM5NGd15A2UJyh0MNhsrN+6daAbsjYOw+6LkEKhztJBfHUpDdvEEdblIDf06iELNFRK1P98owUriTM1FftVpbuuxoAs1RXUNXtq1jfH+neOypYGThBdGdvgY8DqewIZutNW1+fXIzFvqQcP5CQF3qFXsIrzlPBsxItjpjf3UjQ4QpzBWKPNTz85+VKhjnt92q8NAdtGyXyVso+dkh9W3pPs3VZTAgIXQgQkQQOslHwyOKkkgGVyP1GC5gGhicmBD2E5GWSB7nVABu8l5Jb09rDVbiLnXe7qs0Y0yNyAnlnDnF9ms0Zayp25OxugDMREqi+KJ5a/VSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(5023799004)(11063799006)(56012099006)(261102130727099003)(10067099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K8fsLYUZ+iKasAfJ0MYYZ/N9dIUzd+e9EHtT8QlLzkjT//eoWwzOryoTjZuFNIDa90lCdAwIJ5/k7S/X7meuAHOdzgKadfqiXOL5DD+NLrN5G9RUfyb31zf+kaRg+6aZhsUlGz3TvAUAKbUm0Pk8dAMqKI9OTO8KMYoGB8c7noFN+vpiLgNtSVVOD1KQ18p6urjo7vEEMuw2FwQSbdLhQnsIhE6zyV5oQ9MozZYIdT2B6yNyhLrJDVmJteSVVfE4R1NmY/YJQOmm+ON2FE3FxwuwOWbNxIoaaF8WsYLHOnk7coWSEAxaQl5vwqpzTVR49283lwQVBriBx9jlW+XZNJt6XXj435m0JheaaUNORgG5KlR+iPOtJiJ3p9+hH504wru2P6TR1+tkEquxZgqZztlKDj7BWeVfL+gsXfMs04Y5CbwJSqwiPioN/Ri5u1vR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:15:50.5525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00acb01f-5146-46d3-8aa4-08df44ce6dcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ray Wu <ray.wu@amd.com>

[Why]
Replay must be disabled when the link off frame count of the selected
timing, computed from the sink max deviation lines, is less than 2.
amdgpu_dm_link_setup_replay() computed it but never used it.

[How]
Clear replay_supported on a modeset when link_off_frame_count is below
PR_LINK_OFF_FRAME_COUNT_GOOD. Re-evaluate it on a later timing while
keeping the disallow_edp_enter_replay and freesync caps disables.

Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |  23 +++-
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c   | 129 ++++++++++++++++++
 2 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index ee2e4754b089..2106122d4031 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -142,6 +142,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_set_replay_caps);
 bool amdgpu_dm_link_setup_replay(struct dc_stream_state *stream,
 		struct mod_vrr_params *vrr_params)
 {
+	struct amdgpu_dm_connector *aconnector;
 	struct dc_link *link;
 	unsigned int static_coasting_vtotal;
 
@@ -149,7 +150,8 @@ bool amdgpu_dm_link_setup_replay(struct dc_stream_state *stream,
 		return false;
 
 	link = stream->link;
-	if (!link->replay_settings.config.replay_supported)
+	aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
+	if (!link->replay_settings.config.replay_cap_support || !aconnector)
 		return false;
 
 	if (link->replay_settings.replay_feature_enabled)
@@ -158,6 +160,25 @@ bool amdgpu_dm_link_setup_replay(struct dc_stream_state *stream,
 	calculate_replay_link_off_frame_count(link, stream->timing.v_total,
 			stream->timing.h_total);
 
+	/* FreeSync Replay must stay off for timings with link off frame count < 2 */
+	if (link->replay_settings.config.replay_version == DC_FREESYNC_REPLAY &&
+	    link->replay_settings.link_off_frame_count < PR_LINK_OFF_FRAME_COUNT_GOOD) {
+		link->replay_settings.config.replay_supported = false;
+		return false;
+	}
+
+	/*
+	 * replay_supported may have been cleared by the link off check of a
+	 * previous timing, by disallow_edp_enter_replay or by a freesync caps
+	 * update. Re-evaluate it so only the first case is restored here.
+	 */
+	if (!link->replay_settings.config.replay_supported)
+		link->replay_settings.config.replay_supported =
+			!aconnector->disallow_edp_enter_replay &&
+			amdgpu_dm_link_supports_replay(link, aconnector);
+	if (!link->replay_settings.config.replay_supported)
+		return false;
+
 	static_coasting_vtotal = mod_freesync_calc_v_total_from_refresh(stream,
 			vrr_params->min_refresh_in_uhz);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
index 6f633b1bbaca..bdbf11bfc785 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
@@ -47,6 +47,7 @@ static struct replay_test_ctx *alloc_replay_ctx(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, ctx->dm_state);
 
 	ctx->stream = dm_kunit_alloc_stream(test, ctx->link);
+	ctx->stream->dm_stream_context = ctx->aconnector;
 
 	/* Wire connector state so to_dm_connector_state() works */
 	ctx->aconnector->base.state = &ctx->dm_state->base;
@@ -377,6 +378,7 @@ static void dm_test_replay_link_setup_already_enabled(struct kunit *test)
 	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
 	struct mod_vrr_params vrr_params = { 0 };
 
+	ctx->link->replay_settings.config.replay_cap_support = true;
 	ctx->link->replay_settings.config.replay_supported = true;
 	ctx->link->replay_settings.replay_feature_enabled = true;
 
@@ -396,6 +398,8 @@ static void dm_test_replay_link_setup_success(struct kunit *test)
 	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
 	struct mod_vrr_params vrr_params = { 0 };
 
+	set_all_replay_caps(ctx);
+	ctx->link->replay_settings.config.replay_cap_support = true;
 	ctx->link->replay_settings.config.replay_supported = true;
 	ctx->link->replay_settings.config.replay_version = DC_FREESYNC_REPLAY;
 
@@ -425,6 +429,126 @@ static void dm_test_replay_link_setup_success(struct kunit *test)
 			(uint32_t)4);
 }
 
+/*
+ * Helper: prepare a FreeSync Replay capable link with a 1125/2200 timing and
+ * the given max deviation line, so link off frame count is
+ * 2200 * max_deviation_line / (4 * 1125).
+ */
+static void setup_link_off_ctx(struct replay_test_ctx *ctx, uint16_t max_deviation_line)
+{
+	set_all_replay_caps(ctx);
+	ctx->link->replay_settings.config.replay_cap_support = true;
+	ctx->link->replay_settings.config.replay_supported = true;
+	ctx->link->replay_settings.config.replay_version = DC_FREESYNC_REPLAY;
+
+	ctx->stream->timing.v_total = 1125;
+	ctx->stream->timing.h_total = 2200;
+	ctx->stream->timing.pix_clk_100hz = 1485000;
+	ctx->link->dpcd_caps.pr_info.pixel_deviation_per_line = 4;
+	ctx->link->dpcd_caps.pr_info.max_deviation_line = max_deviation_line;
+}
+
+/**
+ * dm_test_replay_link_setup_link_off_below_good - Verify link off gate
+ * @test: KUnit test context
+ *
+ * When the link off frame count of the timing is below
+ * PR_LINK_OFF_FRAME_COUNT_GOOD, Replay must be disabled for this timing.
+ */
+static void dm_test_replay_link_setup_link_off_below_good(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct mod_vrr_params vrr_params = { 0 };
+
+	/* 2200*3/(4*1125) = 1 */
+	setup_link_off_ctx(ctx, 3);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_link_setup_replay(ctx->stream, &vrr_params));
+	KUNIT_EXPECT_EQ(test, ctx->link->replay_settings.link_off_frame_count, (uint32_t)1);
+	KUNIT_EXPECT_FALSE(test, ctx->link->replay_settings.config.replay_supported);
+}
+
+/**
+ * dm_test_replay_link_setup_link_off_at_good - Verify link off gate boundary
+ * @test: KUnit test context
+ *
+ * A link off frame count equal to PR_LINK_OFF_FRAME_COUNT_GOOD keeps Replay
+ * supported.
+ */
+static void dm_test_replay_link_setup_link_off_at_good(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct mod_vrr_params vrr_params = { 0 };
+
+	/* 2200*5/(4*1125) = 2 */
+	setup_link_off_ctx(ctx, 5);
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_link_setup_replay(ctx->stream, &vrr_params));
+	KUNIT_EXPECT_EQ(test, ctx->link->replay_settings.link_off_frame_count, (uint32_t)2);
+	KUNIT_EXPECT_TRUE(test, ctx->link->replay_settings.config.replay_supported);
+}
+
+/**
+ * dm_test_replay_link_setup_link_off_restored - Verify Replay is restored
+ * @test: KUnit test context
+ *
+ * After a timing disabled Replay by the link off gate, a later timing with a
+ * sufficient link off frame count must make Replay supported again.
+ */
+static void dm_test_replay_link_setup_link_off_restored(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct mod_vrr_params vrr_params = { 0 };
+
+	setup_link_off_ctx(ctx, 3);
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_link_setup_replay(ctx->stream, &vrr_params));
+	KUNIT_EXPECT_FALSE(test, ctx->link->replay_settings.config.replay_supported);
+
+	ctx->link->dpcd_caps.pr_info.max_deviation_line = 10;
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_link_setup_replay(ctx->stream, &vrr_params));
+	KUNIT_EXPECT_TRUE(test, ctx->link->replay_settings.config.replay_supported);
+}
+
+/**
+ * dm_test_replay_link_setup_disallowed_by_debugfs - Verify debugfs is honored
+ * @test: KUnit test context
+ *
+ * A sufficient link off frame count must not re-enable Replay while
+ * disallow_edp_enter_replay is set.
+ */
+static void dm_test_replay_link_setup_disallowed_by_debugfs(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct mod_vrr_params vrr_params = { 0 };
+
+	setup_link_off_ctx(ctx, 10);
+	ctx->aconnector->disallow_edp_enter_replay = true;
+	ctx->link->replay_settings.config.replay_supported = false;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_link_setup_replay(ctx->stream, &vrr_params));
+	KUNIT_EXPECT_FALSE(test, ctx->link->replay_settings.config.replay_supported);
+}
+
+/**
+ * dm_test_replay_link_setup_freesync_not_capable - Verify freesync is honored
+ * @test: KUnit test context
+ *
+ * A sufficient link off frame count must not re-enable Replay while the
+ * connector is not freesync capable.
+ */
+static void dm_test_replay_link_setup_freesync_not_capable(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+	struct mod_vrr_params vrr_params = { 0 };
+
+	setup_link_off_ctx(ctx, 10);
+	ctx->dm_state->freesync_capable = false;
+	ctx->link->replay_settings.config.replay_supported = false;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_link_setup_replay(ctx->stream, &vrr_params));
+	KUNIT_EXPECT_FALSE(test, ctx->link->replay_settings.config.replay_supported);
+}
+
 /* Tests for amdgpu_dm_replay_set_event() */
 
 /**
@@ -604,6 +728,11 @@ static struct kunit_case dm_replay_test_cases[] = {
 	KUNIT_CASE(dm_test_replay_link_setup_not_supported),
 	KUNIT_CASE(dm_test_replay_link_setup_already_enabled),
 	KUNIT_CASE(dm_test_replay_link_setup_success),
+	KUNIT_CASE(dm_test_replay_link_setup_link_off_below_good),
+	KUNIT_CASE(dm_test_replay_link_setup_link_off_at_good),
+	KUNIT_CASE(dm_test_replay_link_setup_link_off_restored),
+	KUNIT_CASE(dm_test_replay_link_setup_disallowed_by_debugfs),
+	KUNIT_CASE(dm_test_replay_link_setup_freesync_not_capable),
 	/* amdgpu_dm_replay_set_event */
 	KUNIT_CASE(dm_test_replay_set_event_null_stream),
 	KUNIT_CASE(dm_test_replay_set_event_null_link),
-- 
2.43.0

