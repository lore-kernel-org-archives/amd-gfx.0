Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AF4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E80E110E859;
	Tue, 10 May 2022 20:45:39 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18EC10E81A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtMdPEGwKuC8bDtl4YDIQeyBHC39lBPChMjGHnB0OTUGX146dFmXEQL8JDFeVw6vbwzyVUkTUeDAnTw0FyHN4pont47aK0SCUfnXyPV1RuEZzE2WNk+Rx0S4fgDoiYKkwBMV8YdLJ+WxsnhreRPGWtAjA4/eloHgjXtF/32Vbft3dc5f1kVaVdbE3qjIZunmlsw2rRGe2LXUX/fuJhT4l+R9BnJLey65g7+GZ9StralofVs2kAvVtbQ6MJzSPiIgBCtBPp+CVPFuULB35Tt/y3imE6obzV79EeGjZzX9yC6INS4wbilONbut8XFJyMApo+hukTJ2cX+wJJHI54NyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg3uCJysdDs0CPcQdJak+mN2ach2qzXk2h4N9pYTJko=;
 b=kQhCYqN+tf8CiGJJQCGXiCpglIqpYNJG+vjj+SKePin23M9yZ+hpRdM3nyAY4pr9S0oOXfa15+/2k7JvlO6CPu9fODJPUercShKIJ5HSfnV2SaPIXqIyihvGUQpbLmalLLURgWcvMu3BKafNykbYTumYEKFh+ZlzZ6p9nNZCMp+Ht+eV9Wa7ohlB+GTckEi3zuaxVVexjqdp29RANobQH1pTdh+RC7VcUMSkh5lpsgY8D7l4vkpEsOQA3lL20l9suGKscWXpUfGqHp8gje1POAAjL3eL0UudqwstHCqjiM91hOP+AtXEuQpy8MJrbEjCi1vbTamP/5wHAJy3X3+KtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg3uCJysdDs0CPcQdJak+mN2ach2qzXk2h4N9pYTJko=;
 b=FvSaQte5d5e2SIlte7f90+cPBTGNK6h+xuKc1jJhjEnOB+n0j9iyqL+jofIh98inXLJCWAWjkAGXx+oRT5zVf53RlvLjVSl60aYVcVT8KPAa1zFhiXUZMXfoQ7Q6c3G1X/MSiXo2qw7P/yzDQFyFr4a2HolAnEi+Kpxc/2MDuzU=
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 20:45:35 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::db) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Tue, 10 May 2022 20:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 20:45:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:32 -0500
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:45:28 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 03/19] drm/amd/display: combine dirty rectangles in DMUB FW
Date: Tue, 10 May 2022 16:44:52 -0400
Message-ID: <20220510204508.506089-4-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eef7cb36-bc6f-4e00-05ff-08da32c60812
X-MS-TrafficTypeDiagnostic: DM6PR12MB2603:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB260319E20B9227947CE396B28DC99@DM6PR12MB2603.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpEPqpwFCj5UCqcCNDG7VqcEHD4iYXvLMqXYgHo1bFXlcewLOW8RGLnZRk22e+tzEsc6TFOpFqN3yrnMdh1Eg5T4lhRnbKqceuk7B/L0sjelVaY/e6xHvercrOJtc3zhvSZEmDfnO3k1YD4v3I1X8qpjTJiDz3r4uDHMBF+YR7RvDfN+Hyyaxchj/ApOaqjQxD0Kn6lhDnb7nCM3iqUL9i9UwfTEWoZQXyefWBvWvwJSGIdikTkM7ygMyV+fBYx9nM89YnScWZ2O76D/V02H7vi8cyDkz4JY83/xePBnxEquRSjv8DkAXZOvGVmBMGGzlaQDtqyAvaqOMXPbS7/RnUh2jbQpIq8COrRVe/oXoEjJSIfwih3yL4K2nABZRjaXLtFesDgoMnLpqDyiM4hfrh/TfCwt1KMj5BXp+bOqbYxUwmK7/CndSF6J9zN9PyqQHbw2Rf93p5xIWPjvAQknMfccgegw//QxxL4S16XdVGhF3wHoTuHqbE4+f7jsaTUxaYUoha5F1x7sT7te/U7TVQF5/4miUne9AEPP/U7ERf3gts69KB3CIbpIHUn9lHeZ7IXsybnJf3xtK6pohMN23mOE3PlMjya+Ccs1aSvtnxTEeHohY8KKKyVFJR6LeQaEFBDF1FnLU569yLlZ2Cj2RyJbuMzKmPJsFTNJ4C0AQR7gGDfoWyWf6QNqpiuF0RfAQouAEZ0l87bAWqaDbSiq+rL6zp6tL9Xvf7jkP4RFRpY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(36860700001)(5660300002)(26005)(40460700003)(82310400005)(6916009)(508600001)(316002)(54906003)(2906002)(8936002)(47076005)(426003)(336012)(6666004)(356005)(36756003)(186003)(2616005)(4326008)(7696005)(1076003)(70586007)(70206006)(8676002)(81166007)(83380400001)(14143004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:45:34.4783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef7cb36-bc6f-4e00-05ff-08da32c60812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
In PSR-SU design, the DMUB FW handles the combination of multiple
dirty rectangles.

[how]
- create DC dmub update dirty rectangle helper which sends the
  dirty rectangles per pipe from DC to DMUB, and DMUB FW will
  handle to combine the dirty RECTs
- call the helper from DC commit plane update function.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c   | 54 ++++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h |  5 ++
 2 files changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e41a48f596a3..a4a5a78e82f3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -72,6 +72,9 @@
 #include "dmub/dmub_srv.h"
 
 #include "i2caux_interface.h"
+
+#include "dce/dmub_psr.h"
+
 #include "dce/dmub_hw_lock_mgr.h"
 
 #include "dc_trace.h"
@@ -2824,6 +2827,55 @@ static void commit_planes_do_stream_update(struct dc *dc,
 	}
 }
 
+void dc_dmub_update_dirty_rect(struct dc *dc,
+			       int surface_count,
+			       struct dc_stream_state *stream,
+			       struct dc_surface_update *srf_updates,
+			       struct dc_state *context)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc_ctx = dc->ctx;
+	struct dmub_cmd_update_dirty_rect_data *update_dirty_rect;
+	unsigned int i, j;
+
+	if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_SU_1)
+		return;
+
+	memset(&cmd, 0x0, sizeof(cmd));
+	cmd.update_dirty_rect.header.type = DMUB_CMD__UPDATE_DIRTY_RECT;
+	cmd.update_dirty_rect.header.sub_type = 0;
+	cmd.update_dirty_rect.header.payload_bytes =
+		sizeof(cmd.update_dirty_rect) -
+		sizeof(cmd.update_dirty_rect.header);
+	update_dirty_rect = &cmd.update_dirty_rect.update_dirty_rect_data;
+	for (i = 0; i < surface_count; i++) {
+		struct dc_plane_state *plane_state = srf_updates[i].surface;
+		const struct dc_flip_addrs *flip_addr = srf_updates[i].flip_addr;
+
+		if (!srf_updates[i].surface || !flip_addr)
+			continue;
+		/* Do not send in immediate flip mode */
+		if (srf_updates[i].surface->flip_immediate)
+			continue;
+
+		update_dirty_rect->dirty_rect_count = flip_addr->dirty_rect_count;
+		memcpy(update_dirty_rect->src_dirty_rects, flip_addr->dirty_rects,
+				sizeof(flip_addr->dirty_rects));
+		for (j = 0; j < dc->res_pool->pipe_count; j++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+			if (pipe_ctx->stream != stream)
+				continue;
+			if (pipe_ctx->plane_state != plane_state)
+				continue;
+
+			update_dirty_rect->pipe_idx = j;
+			dc_dmub_srv_cmd_queue(dc_ctx->dmub_srv, &cmd);
+			dc_dmub_srv_cmd_execute(dc_ctx->dmub_srv);
+		}
+	}
+}
+
 static void commit_planes_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
@@ -2910,6 +2962,8 @@ static void commit_planes_for_stream(struct dc *dc,
 		 */
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
 
+	dc_dmub_update_dirty_rect(dc, surface_count, stream, srf_updates, context);
+
 	// Stream updates
 	if (stream_update)
 		commit_planes_do_stream_update(dc, stream, stream_update, update_type, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 58941f4defb3..58036469c62a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -529,4 +529,9 @@ bool dc_stream_get_crtc_position(struct dc *dc,
 
 struct pipe_ctx *dc_stream_get_pipe_ctx(struct dc_stream_state *stream);
 
+void dc_dmub_update_dirty_rect(struct dc *dc,
+			       int surface_count,
+			       struct dc_stream_state *stream,
+			       struct dc_surface_update *srf_updates,
+			       struct dc_state *context);
 #endif /* DC_STREAM_H_ */
-- 
2.25.1

