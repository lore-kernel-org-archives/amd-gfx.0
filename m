Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45117C433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14708206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QLnN9O0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14708206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D606B6EA0E;
	Fri, 24 Jul 2020 21:07:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B86486EA0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m99FA1byUa1nJliVQbX2kY8zNM4/9UrD+mXgRNddH/s0cMCee5kTiy2Zv/3rJBn/DVPEakVvY4FevNeObjTp/CIuo6OrkMmXQI48RkWRY+lP6CXhr30k7ZxiSYPUG2JnzIm3TdVnr/0JY+RjDXq/EFFIri5nyCNdvDf4PSqloMdCX4CTzX68wjJpa98pDxw4KzDaJ0Dz/9SRY1oFjBsIcScpYPAElM9bYyFdRRRjb2pA5Qdlx5XDzn0tMcDFeOGHwUtZnN7yNSEhWkXLSFPy/bFNAy6JpGBkg2Q0+J5AzX6Y/1lQ6RPAS73IhhXN1IDqQMyo3IVfjNzeY7i1WM+UnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgTJuy6KdpM4BjiK2C1jYa2Xur4t98yjXObVYQTcwpE=;
 b=FWoiW5B9PRUrLjzqyrF5mYDW4s8/XK1LPy039guVyS8Uu5NgMtK2+bHjqJMgPUITYKtqGEWIlcQn26lUUVT92ip/zDjL1r61zoIX3FaHbp5SCl+f8DeYUoNUIz9lpm8PJa03Uk+yVPsUSozE5vtCbgtprIazUfyJ/6VjbXxH0FaxUzV/5wvZYQX3ALBhJgXqkMfSIs4Hx9I3kPbrYO9ojVyWttQikOeyPXPA6UdhH5KyAzILK4K38+ur0X6TgGg1clcisgv0DJdWCutAAXeUmKPaxDIoTBiw4Yj81mfZJDUqU56e4vH9U59LhFA+zSEDHUaBfY9HDx/+oVnLdk118Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgTJuy6KdpM4BjiK2C1jYa2Xur4t98yjXObVYQTcwpE=;
 b=QLnN9O0xLPcEnP3PidMXFwEeCEQpl9x3n/+ug+plZbwwqaiK/SQKRkB488zES4uA9hQyCoiRrvGiUoaqYnNJPAbJfMFeULdBQJGwP/7B+qkUVla9ZnJZadAvOGxN55Z55G0nQv2byGvBlE55WEAjky44oaHDQ150M5frCtNrbqw=
Received: from BN6PR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:405:15::18) by MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 21:07:38 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::95) by BN6PR1701CA0008.outlook.office365.com
 (2603:10b6:405:15::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Fri, 24 Jul 2020 21:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:07:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:38 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:38 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:07:32 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/15] drm/amd/display: Allow asic specific FSFT timing
 optimization
Date: Fri, 24 Jul 2020 17:06:11 -0400
Message-ID: <20200724210618.2709738-9-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8758f62-fc40-4112-cd56-08d8301598ae
X-MS-TrafficTypeDiagnostic: MN2PR12MB3775:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3775DA18FB40F8526357EA5AE5770@MN2PR12MB3775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:267;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzsREU/kU2Ss5AD2HkuL3N2a11chJOVkuMj1vPv8FjJNY7r14jOIg9VYlJz7xqiQSJ3b0IHivqsRzV2pwDWQrsBZKqZpW+jxyrQM2v7pyJC3CEOIXvwIUZK+/P4gTbhRzoX6Zgmv19dZxZMwdveg24oLRrjAhF4Mhbkk7wYLDzN7eM7VBgpGIxOJtNyJvUAkar+KDj3jUPdpQw/B1b/QLVtKQlU8cjfYcAE2vQ5CqpspGL5TTusVBQDgoeamTRHQkOTfxAG0RYrXdkEVXj9Cm3jmmpgDXJh71+5zqQ1rIg96RFl6f91fQMsEB7BGSRZOTJWAREAkmyeb0STSwLktag5EK8+AyyuRV/jQV2Jr2P/S5VAzaZlC6jqjPG36IKqfwXaxg7tFwsjmT7petUogUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966005)(47076004)(83380400001)(316002)(86362001)(8676002)(36756003)(82740400003)(82310400002)(5660300002)(2616005)(44832011)(478600001)(4326008)(356005)(186003)(70586007)(54906003)(336012)(70206006)(8936002)(81166007)(26005)(1076003)(6916009)(426003)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:07:38.6524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8758f62-fc40-4112-cd56-08d8301598ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Reza Amini <Reza.Amini@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Reza Amini <Reza.Amini@amd.com>

[Why]
Each asic can optimize best based on its capabilities

[How]
Optimizing timing for a new pixel clock

Signed-off-by: Reza Amini <Reza.Amini@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 18 ++++++-------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  4 +--
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 27 +++++++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  5 ++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  3 +++
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  3 +++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  5 ++++
 .../amd/display/modules/freesync/freesync.c   |  5 +++-
 8 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 10d69ada88e3..0257a900fe2b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -246,20 +246,18 @@ struct dc_stream_status *dc_stream_get_status(
 
 #ifndef TRIM_FSFT
 /**
- * dc_optimize_timing() - dc to optimize timing
+ * dc_optimize_timing_for_fsft() - dc to optimize timing
  */
-bool dc_optimize_timing(
-	struct dc_crtc_timing *timing,
+bool dc_optimize_timing_for_fsft(
+	struct dc_stream_state *pStream,
 	unsigned int max_input_rate_in_khz)
 {
-	//optimization is expected to assing a value to these:
-	//timing->pix_clk_100hz
-	//timing->v_front_porch
-	//timing->v_total
-	//timing->fast_transport_output_rate_100hz;
-	timing->fast_transport_output_rate_100hz = timing->pix_clk_100hz;
+	struct dc  *dc;
 
-	return true;
+	dc = pStream->ctx->dc;
+
+	return (dc->hwss.optimize_timing_for_fsft &&
+		dc->hwss.optimize_timing_for_fsft(dc, &pStream->timing, max_input_rate_in_khz));
 }
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index e4e85a159462..633442bc7ef2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -424,8 +424,8 @@ struct dc_stream_status *dc_stream_get_status(
 	struct dc_stream_state *dc_stream);
 
 #ifndef TRIM_FSFT
-bool dc_optimize_timing(
-	struct dc_crtc_timing *timing,
+bool dc_optimize_timing_for_fsft(
+	struct dc_stream_state *pStream,
 	unsigned int max_input_rate_in_khz);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 7725a406c16e..66180b4332f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2498,3 +2498,30 @@ void dcn20_fpga_init_hw(struct dc *dc)
 		tg->funcs->tg_init(tg);
 	}
 }
+#ifndef TRIM_FSFT
+bool dcn20_optimize_timing_for_fsft(struct dc *dc,
+		struct dc_crtc_timing *timing,
+		unsigned int max_input_rate_in_khz)
+{
+	unsigned int old_v_front_porch;
+	unsigned int old_v_total;
+	unsigned int max_input_rate_in_100hz;
+	unsigned long long new_v_total;
+
+	max_input_rate_in_100hz = max_input_rate_in_khz * 10;
+	if (max_input_rate_in_100hz < timing->pix_clk_100hz)
+		return false;
+
+	old_v_total = timing->v_total;
+	old_v_front_porch = timing->v_front_porch;
+
+	timing->fast_transport_output_rate_100hz = timing->pix_clk_100hz;
+	timing->pix_clk_100hz = max_input_rate_in_100hz;
+
+	new_v_total = div_u64((unsigned long long)old_v_total * max_input_rate_in_100hz, timing->pix_clk_100hz);
+
+	timing->v_total = new_v_total;
+	timing->v_front_porch = old_v_front_porch + (timing->v_total - old_v_total);
+	return true;
+}
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 63ce763f148e..83220e34c1a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -132,5 +132,10 @@ int dcn20_init_sys_ctx(struct dce_hwseq *hws,
 		struct dc *dc,
 		struct dc_phy_addr_space_config *pa_config);
 
+#ifndef TRIM_FSFT
+bool dcn20_optimize_timing_for_fsft(struct dc *dc,
+		struct dc_crtc_timing *timing,
+		unsigned int max_input_rate_in_khz);
+#endif
 #endif /* __DC_HWSS_DCN20_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 2380392b916e..3dde6f26de47 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -88,6 +88,9 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
+#ifndef TRIM_FSFT
+	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
+#endif
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 177d0dc8927a..b187f71afa65 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -92,6 +92,9 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
+#ifndef TRIM_FSFT
+	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
+#endif
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 720ce5e458d8..3c986717dcd5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -116,6 +116,11 @@ struct hw_sequencer_funcs {
 	void (*set_static_screen_control)(struct pipe_ctx **pipe_ctx,
 			int num_pipes,
 			const struct dc_static_screen_params *events);
+#ifndef TRIM_FSFT
+	bool (*optimize_timing_for_fsft)(struct dc *dc,
+			struct dc_crtc_timing *timing,
+			unsigned int max_input_rate_in_khz);
+#endif
 
 	/* Stream Related */
 	void (*enable_stream)(struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 7a2500fbf3f2..81820f3d6b3b 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -829,10 +829,13 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 	switch (packet_type) {
 	case PACKET_TYPE_FS_V3:
 #ifndef TRIM_FSFT
+		// always populate with pixel rate.
 		build_vrr_infopacket_v3(
 				stream->signal, vrr,
 				stream->timing.flags.FAST_TRANSPORT,
-				stream->timing.fast_transport_output_rate_100hz,
+				(stream->timing.flags.FAST_TRANSPORT) ?
+						stream->timing.fast_transport_output_rate_100hz :
+						stream->timing.pix_clk_100hz,
 				app_tf, infopacket);
 #else
 		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
