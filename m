Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABF4CD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E492810F4F6;
	Thu, 28 Mar 2024 19:51:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BGzlI8EP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E63410E652
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh7GtFvW6tLLnNB0lmw82yri1nncxJJ91ntCadcL9dYhGWm2OI6YpRkKedgWElZdlGWFstgUui+B3sOz7VqbGlQlDA6gEUUSAkF2muOW+ILM7XPP7YLRGxj8VHPOc59X+A8bJ+0C5em4PNy5KK7T1UyINlVhQ/Qi0nS6qAB9iv24YbqbCTLf27HfwvCWIUEAksEsvmjLV7bKEhliawsRklxs8C4B+b7utrONTkIcxasoC52xsVHEdeGt52SXimqWck2ZQSoRb6aGYZKdsDbTQec1ewpzhNyWVogE5v7RrraiCtr+MlR/dNkQ+cbalM22tLu7bd4grSlA9HoUsQJQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFA2uVBuM6cBk9lHqa+QSE5LkDgF6imLX6YfwmjiaHs=;
 b=T5UbmTo8m6PXXuL1JmR7b/SZ8mDsv5KKvM1WAjdJlOROQzkGqPXa0N1Xb1pN8IlW5W8Ug8y7cz5vuhrw9tIwBb8mGQ729sOv8EGZYfWBcxjU9/TTdyqcISkHgeEZ0HhU7Ns4qKDRrq+KoMxXQ5sfYUMxOCGMpEUWflWqUUrJEpm4w0zCYp7D3irGv3xhAYCOwkp6tu+WUP0VZ6j9Sw6YLUBuxGGUoIohFwTzeBM9LToCFxWa4Yb3Hooga+tGcPJ6QFDZZA2qknvL9M3WGa1Lu6ASoTZsUOpTQ0SmgNVzpyiSiokPXHdzlYfTrHL0NT10RV0Co7R76kP4vpjXFmAHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFA2uVBuM6cBk9lHqa+QSE5LkDgF6imLX6YfwmjiaHs=;
 b=BGzlI8EPu7KTu5GJBFw2eKoRv1Mb6P55XUs7v+ZOFghYMNo/ufNnZkLT7bMQ4x9vus8HDnn7n+eP2CFjxHWB/33+wrGab/QFXyfxAtMZhi1XvTjQeLgZUsXLWUu5SAYgT9LF3StehcajRh+QJjRa/k0Hvk/fNQhm9Sb7IJt2v1U=
Received: from SJ0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:a03:39c::25)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 19:51:40 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ee) by SJ0PR03CA0350.outlook.office365.com
 (2603:10b6:a03:39c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:37 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:37 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 12/43] drm/amd/display: Enable DTBCLK DTO earlier in the
 sequence
Date: Thu, 28 Mar 2024 15:50:16 -0400
Message-ID: <20240328195047.2843715-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 78361a1a-8e04-4112-36c9-08dc4f607c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xW/J/t9QgyJgvNoR3xmtNXmIBzR/m6+/5y7hsKX1OI4UCvzm5vIZ+QPJ5dmvFoirvcZozjkUAAQ8iuZMPOWPHCK55MIy1ABEu3VbuqSAoiomvYoNzrzDYlWhO8WBnTSoMD/Lw/ExfUpy41/tNW492EM885Aj3Y8MoPqqjEOCE+3qPCe/3ZAVi1U7hIFKqSEFsyjScmh5DN5ar5qNXDBRJin4hDthSuZfBU7mc03oeabXGnDbLl4g8gzdFxAQR5s9Ev/yoZTu9ONlzf7xIqL+53KCZqwOqOYCMVoY4MAqC4hIQl1ahr+lTux/TVz5e5MMQYpOaea8Tj6EwusHJqYVFucsmILE4Ycl3YimckWrj+H0ps0ClblAUnbcRWCfNXUHsn+HHsYOaFPywWAVrl1bokysuGv8K8Wmqw5sndzeSZZXEvMkBUuBnbVcD/HiX1js42WDbTRO1jWFjSZNyzsvb+laEH/Famjbgf4btx4eu04h5Jm9UVkVOEdj9KjCHQr+IuBLdGXXMGamGYYCHT1jIq+ay0AoaBwiWQtMgR5TnNdvzX+qadNVlx4SEe2lVB2JigBTHwafKA9gaj9Um9Mxl1yiDg2EhlHstMFaI1jnpxuZWg2OC2zGkncQ1EC2DkMpmNmmzjqkA8dymA+m//IdDhDCk/gcWpsYS1Q/wP5gswltQPiyU5tI0ccmF5gs/8iqZvMCchWGHfSFBntpQ5+9ilU1fFDx7CRJJ1+CaUyIo1K9T6azr2jHFU9pP/4Ku+fM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:39.8273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78361a1a-8e04-4112-36c9-08dc4f607c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why]
As per programming guide, we need to
enable the virtual pixel clock via DTBCLK
DTO and ungate the clock before we begin
programming OPP/OPTC control registers.
Otherwise, the double-buffered registers
will be left pending until the clocks are enabled.

[how]
Move the DTBCLK DTO programming up to
where we do the legacy DP DTO programming.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index f983041ce9a4..87b43cb50c1e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -873,6 +873,22 @@ enum dc_status dcn20_enable_stream_timing(
 		return DC_ERROR_UNEXPECTED;
 	}
 
+	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+		struct dccg *dccg = dc->res_pool->dccg;
+		struct timing_generator *tg = pipe_ctx->stream_res.tg;
+		struct dtbclk_dto_params dto_params = {0};
+
+		if (dccg->funcs->set_dtbclk_p_src)
+			dccg->funcs->set_dtbclk_p_src(dccg, DTBCLK0, tg->inst);
+
+		dto_params.otg_inst = tg->inst;
+		dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+		dto_params.num_odm_segments = get_odm_segment_count(pipe_ctx);
+		dto_params.timing = &pipe_ctx->stream->timing;
+		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
+		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+	}
+
 	if (dc_is_hdmi_tmds_signal(stream->signal)) {
 		stream->link->phy_state.symclk_ref_cnts.otg = 1;
 		if (stream->link->phy_state.symclk_state == SYMCLK_OFF_TX_OFF)
@@ -959,22 +975,6 @@ enum dc_status dcn20_enable_stream_timing(
 			pipe_ctx->stream_res.tg->funcs->phantom_crtc_post_enable(pipe_ctx->stream_res.tg);
 	}
 
-	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
-		struct dccg *dccg = dc->res_pool->dccg;
-		struct timing_generator *tg = pipe_ctx->stream_res.tg;
-		struct dtbclk_dto_params dto_params = {0};
-
-		if (dccg->funcs->set_dtbclk_p_src)
-			dccg->funcs->set_dtbclk_p_src(dccg, DTBCLK0, tg->inst);
-
-		dto_params.otg_inst = tg->inst;
-		dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
-		dto_params.num_odm_segments = get_odm_segment_count(pipe_ctx);
-		dto_params.timing = &pipe_ctx->stream->timing;
-		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
-		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
-	}
-
 	return DC_OK;
 }
 
-- 
2.34.1

