Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21372C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE4910E1C9;
	Thu,  5 May 2022 14:23:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6416E10E158
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+KYW8g2laIRKyKaJE50VOfn9JhzVEjA5IxQhuJBDU0e/VCUI9/7hNc1v2T7dLhpngGoqS0y2HQTwrfKnDYPXbwjqM/YZb7tZga8tUn3cxuPQsVubgiNKAd835aObf81y7dT86hiLK/1H5f7/Pg5B8+Kccyh9wDaA3QJFed/tSui/DPxsK1QkBvt0kjXXvGIfXsgCxvhUbX9jMJR0eW4tOHGuFMgV0Tu40dTSgnqX1iupMho06ZLj0ZiQvIHZiAikabO7V6+928numy4lCiXixjoy4bkom4j+8Fy//Ei8MQLIS3gO0bI0K5DIOeCX0tvMLWAbSlcyspsNEoq6NA92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQrvAaptgmZjzxOVz7IJfatcBTdQOb1sQCubR57chK8=;
 b=SRSoqv3wIioRJmmeVn3E+RgEz2qu91AenuR/Uc3c17w/22kco/PU8o/mm2VTxrvkIBz/7luZWIoOYtBZJqE/WonBOo936+2yH2KVQAACCze89YkB1zOjZh6nPptdoPz0EYFxmZmbOaVTumNxy8C73e/vjIBe7dJrbRayB+D6zmKt3M8D3HMaCD2xUS9nxw7kc5/xSLShgC2i7Kr6pVO9eg9RG7zr0DwkqGBRyaJ9erxLy35j6Fps5Wez1DNh0R5nm1NFeNO3L/odDvLtMILBapiMkzY6/xQC8rbSZTPqHtlgqnTO/I9+cQlqdCtHWOSkdXsK2GZT57EpSH1a8CZ7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQrvAaptgmZjzxOVz7IJfatcBTdQOb1sQCubR57chK8=;
 b=aZccQ13uYCnGuUUK5FDzMWF4EKYXvPKUwOJpzK+jHMkJzPbBtIp2wMyvs0t/l86BodNlHiCJ3+TlSLyIiyG+ONVHXAJiHFAz/DlaygPzST6mXc85QXIlDakbOw4nWN82OoA6IRcRwURxd6WAt5TTmdJl80suKi5cXX5ZdwFryQ8=
Received: from DM6PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:40::34) by
 CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 14:23:43 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::23) by DM6PR03CA0021.outlook.office365.com
 (2603:10b6:5:40::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 14:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:43 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:41 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/17] drm/amd/display: combine dirty rectangles in DMUB FW
Date: Thu, 5 May 2022 10:23:09 -0400
Message-ID: <20220505142323.2566949-4-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a455644-29ea-486f-6dee-08da2ea2dbe0
X-MS-TrafficTypeDiagnostic: CO6PR12MB5492:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54923B02C66D2ED52835FA218DC29@CO6PR12MB5492.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUGUz+Ei30R3elmeKcx8dLCnpDzXP0qyskObBpd0damyKqpbTdFDoPyBhXB0/yewSpXv/zzufLniNwtR669/VQ4PFh6PifcHFzU+9ELJQbkOesSGcmoI34c0ic69UHY9GcpoE7B6PasVeifLWis+BfwoWn6aYlQYj0O4lMiPc522Ttox4uvAdSa0fUs1sK4vGSq1ZdEI7RHKywIfCSjMv3XvB6tuQxd/vp20vqsKVLInynTr2dsmOIL98uyFYxIAw270N42jYY+uwxWKAtx052DcXQlNjF8VNGdG2lR3vtSpTX4Ncp51I/qrlfcyJsXh6nokUmuR/0l1bHn+gDpHWyPn0IJfXbUWBuIqVUkLnuUQ8niq02dAMnhpou/+Xyj8TcwI+E64IW3Z1ZMXaL9s/t+fBxNqTJ5dUlQDPY6k/90HFjCiKg5FLInZaGy2HbfyZRAlpTaTwQqvZMo/5QOMs40+Z3QT8Bd121UCBPvI2zO2kRPiozzatdY4HlPTSjI8AhyYOiQhEiaBNw4cQNzGoyr9ennNL3q1IHC3kEI5rWDGcrC1NgOxYUrVrFF2/SSAVLyXrq6UmXuk5eRzWSLB5KodcUEvyhtkxq72GUYNa+tM++3nBzCdwh4+G/rPjW5hkFI7M12fUc1shCc9GcoL6dRsi73xDcJvgT1Ps5WFnnreLTfFZOfFemzg9Bce2ific7D95mPUaWBLrnyl4+HOVWfMNEg14Rr1tUL68OHVA1k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(508600001)(7696005)(2616005)(8936002)(36756003)(26005)(1076003)(83380400001)(16526019)(186003)(36860700001)(336012)(426003)(47076005)(356005)(86362001)(40460700003)(81166007)(82310400005)(316002)(4326008)(5660300002)(8676002)(70586007)(2906002)(70206006)(6916009)(54906003)(14143004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:43.3594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a455644-29ea-486f-6dee-08da2ea2dbe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
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
 drivers/gpu/drm/amd/display/dc/dc.h        |  3 ++
 drivers/gpu/drm/amd/display/dc/dc_stream.h |  5 ++
 3 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c2fcd67bcc4d..0649d84b71b6 100644
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
@@ -2842,6 +2845,55 @@ static void commit_planes_do_stream_update(struct dc *dc,
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
@@ -2934,6 +2986,8 @@ static void commit_planes_for_stream(struct dc *dc,
 		 */
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
 
+	dc_dmub_update_dirty_rect(dc, surface_count, stream, srf_updates, context);
+
 	// Stream updates
 	if (stream_update)
 		commit_planes_do_stream_update(dc, stream, stream_update, update_type, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 942bfb8fd851..85f3303e7843 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1134,12 +1134,15 @@ void dc_3dlut_func_retain(struct dc_3dlut *lut);
  * in cases such as Stereo 3D, Planar YUV, etc.  Other per-flip attributes such
  * as frame durations and DCC format can also be set.
  */
+#define DC_MAX_DIRTY_RECTS 3
 struct dc_flip_addrs {
 	struct dc_plane_address address;
 	unsigned int flip_timestamp_in_us;
 	bool flip_immediate;
 	/* TODO: add flip duration for FreeSync */
 	bool triplebuffer_flips;
+	unsigned int dirty_rect_count;
+	struct rect dirty_rects[DC_MAX_DIRTY_RECTS];
 };
 
 void dc_post_update_surfaces_to_stream(
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

