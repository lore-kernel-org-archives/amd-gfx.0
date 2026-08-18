Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F41C5DF85
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AAFE10EC96;
	Tue, 18 Aug 2026 20:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="19WKNqVE";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B4D10EC93
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4UFoOEBVxwok0RIlvTLp400OrUhFOP6gtMwzP0z42teC+5hDuFv9u41EQML0KaEQWSGmy6qqGckU5a7zARxgyUhD0zve8A10yhmTxv0UeVK579ncdWDTmJENWY/dgC/HRcVxMkZneKdI19+8rMsnqW2ATevoQ0NVjeoRoCdlMMij1zKBcsbq/ozOMHKJLcuxpfXoDxPqdKbdr3G+s/HXhi4Q83zQjs0HujwYDZ9xghllyO23zvebuhk3pH29bAlcQpkCpMzwHUOsPOVv1vW4oYIexahiETj957cJJisSfSNMjCFL1SO9Vymorufrx7G23q4yBn2rTX54UBsK6Cq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E2LAlapTfBGXUbDwo0601SIifdkGpgp6nsE2DGScVg=;
 b=a1cls3btBHNXoKxXYBil6BmzcnLGuVmj/1g1gjt8MIVljA+jtlRAT9+Od9cEfBmgwll2i4vu8zviZudBppeDPiH9/biQa60t5be3AmHiFLsp2/5r43JIOCuthcN8W5WLb912pQI8oL2u7PmkXC4tu30PLKgUn4MsTl63U6dXo0IeWrbs9NSxQiRQp0GwtCmLpsbvqcvKG63hGrZPr6GDZWuzT7vRXLv9e4lr+jcsVOlUqsLWeMT3HYxxjejAhRpjMk4+4XLdmDkJFEhRVL6Wub54Ds4psdv/kUL2/Vo+HY5aO2D8dx4C8KnZ0oyR8HlzptF9UtlZRrLuNifXdStDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E2LAlapTfBGXUbDwo0601SIifdkGpgp6nsE2DGScVg=;
 b=19WKNqVELlWNDI48MtwSVQXxqM08FaROfYWnrJCMdITNDX/FFyTqbHErRG5k80jir6ixcP1RqA1EKFE20B+iSi3f1diRgVgmvDqf6afM1t0/6UdkeqDH+UOow7v/7ilNp5B4G9riZzOJjVnmNT37bGuXRnDT9afkwsLm+8B4Q4U=
Received: from BN1PR10CA0005.namprd10.prod.outlook.com (2603:10b6:408:e0::10)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:11 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::56) by BN1PR10CA0005.outlook.office365.com
 (2603:10b6:408:e0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:03 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:02 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 13/82] drm/amd/display: Cover HDMI infoframe/freesync timing
 paths
Date: Tue, 18 Aug 2026 16:15:05 -0400
Message-ID: <20260818202139.4172592-14-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 311d8c3b-f043-4cba-25c2-08defd6662af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rK9NsHgEe4sI6oXx0P4eYHhMTrphcU1/YR7mY4YmqCVeXCOEdattuULlryP68mix3cDb5gx8sxlRQHJKhXeykERlPhhxyzBTg6cvT4q8qX6Lm/LK/brDquo/hEnNttB8GzbDEQkCvIqPzAVdcCh65hnCd7coH1PpOy7kx+fT5TQC2PYugmunWFIzybEzZT62Hcpf50ROYDfBOyTMeU43A/BScH2V22XZ6kDK6m1mV9yorhO8Tp5vYCMzWH9CDg3Xkp2WaASTxfKJVMCAoU4darLaWlu216LJtizsT7XJtJSqHmIBfypG3FFFi/MBFIDz7MKtybm0vzQrqU8TNkAik1M45AqeK7vdIqN4pq9Xt1hfNuk1KDa9Sgrj1tVjBQP/OwShkYsLx8B+37egoZCtpkugO66a7+EHv13sEquXGPNI1ULq2Y6AcAIjQQFFHUBxq9VJpTe+wGx8vSbxrBS5ze++sV7/LXgYFM+k5qw8+3BBMozZ4/uOsHjcsc1dwcYko2Pur1EWNz/GFh13Z7+syagZmdD2PhMb3UJBq5ah9Wd1OPhchjky1yw2OrLs+sMfXYbDrI76o1CBMP6kMXUTCoXydpQPu2/GAfPfsu/DUFIpzz4CyrNdRDq0f91n0hQ8VTqCvw6DXswBdcBOemCDUiufhjDLYXwoXSmO/xZs36O2+2QbO0T5lANTYYmrmLifQcqf8ue7r/JjmjgB6YPrGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vXGyjzkEe9EJ4kTbSd2NaUNhmn4lZ73YXPs3pHUqZC33wt7qkkURF8vmsx7RY9iRviRQAS8leOwvXv0S2fR8KNitE4amKk+89pWQ+RlVU8W8Fr+oyqpHAKbNjAMxb9PEDisFS5mPbvuiMSuke5QGtXcFPC6tWrpnlcc8CxkZp6izFwHJjDzPgNNHw+/BzHgiuCkbKLCXyUG4R5jnB0pvDRuqkw4e4IHUXs8x3RSviT5yaVN765UQIaT8+4kD/yZCT2XrfuN6j8KVM1ZMHhOWcuzNDahxf9q/GVrbSxPru42QS0ukXrMhZJhZnAkIuV5ayTBVB/XQx5RJ5pLgGmL+6pQNqkFd7NMQwGmLIc+n3C5EvfJATh7E3LVJTC/XCRCZ/2q7UG4DMGW4IP7fUbH2rIyfquPy80aJdPDls8tzWSvOLBOAnBcVdmP23qVzFZ2A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:11.6845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311d8c3b-f043-4cba-25c2-08defd6662af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627
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

Add KUnit tests for fill_stream_properties_from_drm_display_mode(): an
HDMI stream signal that runs the AVI/vendor infoframe block and
overwrites the VIC, and a mode matching the connector freesync base
mode that takes timing from the drm mode fields with a 10x pixel clock.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 61cd1ebe9fcd1..1a95694ea35cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -3775,6 +3775,82 @@ static void dm_test_fill_stream_non_hdmi_ep_keeps_depth(struct kunit *test)
 			(int)COLOR_DEPTH_101010);
 }
 
+/**
+ * dm_test_fill_stream_hdmi_infoframe - Test HDMI signal fills VIC from infoframe
+ * @test: The KUnit test context
+ *
+ * With an HDMI stream signal the AVI/vendor infoframe path runs and overwrites
+ * the VIC (seeded via an old stream) with the value derived from the mode.
+ */
+static void dm_test_fill_stream_hdmi_infoframe(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+	struct dc_stream_state *old_stream;
+	struct drm_display_mode *cea;
+
+	old_stream = kunit_kzalloc(test, sizeof(*old_stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_stream);
+	old_stream->timing.vic = 99;
+
+	/* A real CEA-16 (1080p60) mode so the AVI infoframe resolves VIC 16. */
+	cea = drm_display_mode_from_cea_vic(ctx->drm, 16);
+	KUNIT_ASSERT_NOT_NULL(test, cea);
+	*ctx->mode = *cea;
+	drm_mode_destroy(ctx->drm, cea);
+
+	ctx->stream->signal = SIGNAL_TYPE_HDMI_TYPE_A;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, old_stream, 8,
+		PIXEL_ENCODING_RGB, false);
+
+	/* The HDMI block overwrote the old stream's VIC of 99 with the AVI code. */
+	KUNIT_EXPECT_EQ(test, (int)timing->vic, 16);
+}
+
+/**
+ * dm_test_fill_stream_freesync_video - Test timing taken from the mode for FS video
+ * @test: The KUnit test context
+ *
+ * When the mode matches the connector's cached freesync base mode the timing is
+ * taken from the drm mode fields (not crtc_*), including a 10x pixel clock.
+ */
+static void dm_test_fill_stream_freesync_video(struct kunit *test)
+{
+	struct dm_test_fill_ctx *ctx = dm_test_fill_ctx_alloc(test);
+	struct dc_crtc_timing *timing = &ctx->stream->timing;
+
+	/* Cached high mode == the mode passed in => freesync video mode. */
+	ctx->aconnector->freesync_vid_base.clock = 148500;
+	ctx->aconnector->freesync_vid_base.hdisplay = 1920;
+	ctx->aconnector->freesync_vid_base.vdisplay = 1080;
+	ctx->aconnector->freesync_vid_base.hsync_start = 2008;
+	ctx->aconnector->freesync_vid_base.hsync_end = 2052;
+	ctx->aconnector->freesync_vid_base.htotal = 2200;
+	ctx->aconnector->freesync_vid_base.vsync_start = 1084;
+	ctx->aconnector->freesync_vid_base.vsync_end = 1089;
+	ctx->aconnector->freesync_vid_base.vtotal = 1125;
+
+	ctx->mode->clock = 148500;
+	ctx->mode->hdisplay = 1920;
+	ctx->mode->vdisplay = 1080;
+	ctx->mode->hsync_start = 2008;
+	ctx->mode->hsync_end = 2052;
+	ctx->mode->htotal = 2200;
+	ctx->mode->vsync_start = 1084;
+	ctx->mode->vsync_end = 1089;
+	ctx->mode->vtotal = 1125;
+
+	fill_stream_properties_from_drm_display_mode(ctx->stream, ctx->mode,
+		&ctx->aconnector->base, ctx->conn_state, NULL, 8,
+		PIXEL_ENCODING_RGB, false);
+
+	KUNIT_EXPECT_EQ(test, (int)timing->h_addressable, 1920);
+	KUNIT_EXPECT_EQ(test, (int)timing->v_addressable, 1080);
+	KUNIT_EXPECT_EQ(test, (int)timing->pix_clk_100hz, 1485000);
+}
+
 /* Tests for create_stream_for_sink() */
 
 /*
@@ -6239,6 +6315,8 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_fill_stream_encoding_from_caller_ycbcr444),
 	KUNIT_CASE(dm_test_fill_stream_hdmi_ep_clamps_depth),
 	KUNIT_CASE(dm_test_fill_stream_non_hdmi_ep_keeps_depth),
+	KUNIT_CASE(dm_test_fill_stream_hdmi_infoframe),
+	KUNIT_CASE(dm_test_fill_stream_freesync_video),
 	/* create_stream_for_sink */
 	KUNIT_CASE(dm_test_create_stream_fake_sink_success),
 	KUNIT_CASE(dm_test_create_stream_sets_dm_context),
-- 
2.43.0

