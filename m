Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8E0C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B962224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PZhqAsKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B962224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3DA6EDBD;
	Wed, 21 Oct 2020 14:23:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876966EDD3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYYGFleanqDjDfVYWNZhV/FPzmLGlre5q9jMkf5rfPPgeFy2aDRs5Pp/FABHq3TytktZhUOPuilw+KEeBxdVWPCAJAy+vbGZ5mQEKDXCbfDo8kUu0U/kO1coGW+cU5tZDcKCby1BuV5ZwmtYnHX4QLatkyEMQCmnfKUWvgMrb1SwiMKwdXaKE4smlPUAELEWPQ/pU1Kj2IrvOKK2A7ZpMlSSYQQsV5GBP3xdr4zsldbNUK1Is0jZc1/iseTBK/R9d24nQBtxn+5BUovLuFrjOoANwzdXuzATzFoZXSACcmYn+fowvCGU23qC9iXvYAn0YzVv0TSfCnOH0iqb3O9KCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dENlmuOd4D/E1TlYSbkPUMDell96Ou3rgaXxYBZRXw8=;
 b=LERtWBfZKvw5Fe6b3ef64K+hgskTchI5n58VP1Jr6mDTQHhN3mXNI6QqX309rOuP2S0Ua5NvmvXfTqn0UbTVSiTS1vmUbaXPxMIzKZqR363JSqlV1t3deEWvl6D2UnKMiMZr/NY82MmjfDkbKM6UMSiNV4gwLAKKC848iAvDUKxIsEN+Aw7z7eGnuw9UyxFJOzcmIK2DJ0YhI8hvZ1fsR5CpnayY+qgeGR9IrKMVn1wgzcQvxlBakwmDI8mpf1T6wBo7E+r7e1lIYH8A3PNB88NxhEZWDlq8S1OqBJ/GernheryK5E9SSF8E2OKJZHPLdOUJoyJwlzqTP1YjJYOCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dENlmuOd4D/E1TlYSbkPUMDell96Ou3rgaXxYBZRXw8=;
 b=PZhqAsKHortFerywQq91Kqij1Nhw9jdLBvrWza+LxT/Y709oLi9k/6xSkd9soUqbrvHsKxAbQmy/i1Q0oid7dYH0fklB8K9lCH9dEZ0cU6N0karx67v2kNNcMqBs/LqBSN5mB6ox0vRMMFE++lDD8XDVdNmL3EgF4h5LaNUog5w=
Received: from BN4PR11CA0004.namprd11.prod.outlook.com (2603:10b6:403:1::14)
 by DM6PR12MB3819.namprd12.prod.outlook.com (2603:10b6:5:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:23:27 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:1:cafe::aa) by BN4PR11CA0004.outlook.office365.com
 (2603:10b6:403:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:27 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:26 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/33] drm/amd/display: Add pipe_state tracepoint
Date: Wed, 21 Oct 2020 10:22:52 -0400
Message-ID: <20201021142257.190969-29-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 661ccfb6-e241-4ce5-9628-08d875cce0a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3819:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3819302DC879AAA1B1F603658B1C0@DM6PR12MB3819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+1+HFHexoGutdhN5dcQMgHJHrJP8CKmZnXwSGxOpJXAib3VjMO7PJPDngaV60HH7t6Rk3BQEKIDdDlH1us+wSl3fFjYr3bPBdOJbDanpWpYsE5m+qLaYD10rVAl+jjorPRitYFT1/y0KWNgdMvnt76coPTlIdezSLYtNCGufA98n4xC+aIp6/DJEu1Bd0DWcu1XpkE6K1wRQkMWQtKBwPH0CaeWb9Ti0/FMwfvPV9Hu1EBDZdeZOf9kkZPMrAuaynYUjR9xaUp/01vozBFigxZf/gE+nf9PQpGXJhHik08XXiwyPKfyGzEZEbE3C4Lm6sS9IDO5fOKL1RReHlUjVYfQrsNxlSiFu10Ey86dvpPfmHcHBGeMZcJy8j0duqHWguKb3kSBVKwV2M3kc/zpvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966005)(2616005)(478600001)(26005)(54906003)(8936002)(316002)(83380400001)(6916009)(186003)(82310400003)(82740400003)(1076003)(8676002)(47076004)(81166007)(356005)(2906002)(36756003)(44832011)(4326008)(70586007)(5660300002)(426003)(6666004)(70206006)(7696005)(86362001)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:27.5166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661ccfb6-e241-4ce5-9628-08d875cce0a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3819
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit introduces a trace mechanism for struct pipe_ctx by adding a
middle layer struct in the amdgpu_dm_trace.h for capturing the most
important data from struct pipe_ctx and showing its data via tracepoint.
This tracepoint was added to dc.c and dcn10_hw_sequencer, however, it
can be added to other DCN architecture.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 108 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +
 drivers/gpu/drm/amd/display/dc/dc_trace.h     |  33 ++++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   9 +-
 4 files changed, 151 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_trace.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 6f07c43ef794..dd7a879c0ec6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -37,6 +37,8 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_atomic.h>
 
+#include "dc/inc/core_types.h"
+
 DECLARE_EVENT_CLASS(amdgpu_dc_reg_template,
 		    TP_PROTO(unsigned long *count, uint32_t reg, uint32_t value),
 		    TP_ARGS(count, reg, value),
@@ -376,6 +378,112 @@ TRACE_EVENT(amdgpu_dm_atomic_check_finish,
 		      __entry->async_update, __entry->allow_modeset)
 );
 
+TRACE_EVENT(amdgpu_dm_dc_pipe_state,
+	    TP_PROTO(int pipe_idx, const struct dc_plane_state *plane_state,
+		     const struct dc_stream_state *stream,
+		     const struct plane_resource *plane_res,
+		     int update_flags),
+	    TP_ARGS(pipe_idx, plane_state, stream, plane_res, update_flags),
+
+	    TP_STRUCT__entry(
+			     __field(int, pipe_idx)
+			     __field(const void *, stream)
+			     __field(int, stream_w)
+			     __field(int, stream_h)
+			     __field(int, dst_x)
+			     __field(int, dst_y)
+			     __field(int, dst_w)
+			     __field(int, dst_h)
+			     __field(int, src_x)
+			     __field(int, src_y)
+			     __field(int, src_w)
+			     __field(int, src_h)
+			     __field(int, clip_x)
+			     __field(int, clip_y)
+			     __field(int, clip_w)
+			     __field(int, clip_h)
+			     __field(int, recout_x)
+			     __field(int, recout_y)
+			     __field(int, recout_w)
+			     __field(int, recout_h)
+			     __field(int, viewport_x)
+			     __field(int, viewport_y)
+			     __field(int, viewport_w)
+			     __field(int, viewport_h)
+			     __field(int, flip_immediate)
+			     __field(int, surface_pitch)
+			     __field(int, format)
+			     __field(int, swizzle)
+			     __field(unsigned int, update_flags)
+	),
+
+	TP_fast_assign(
+		       __entry->pipe_idx = pipe_idx;
+		       __entry->stream = stream;
+		       __entry->stream_w = stream->timing.h_addressable;
+		       __entry->stream_h = stream->timing.v_addressable;
+		       __entry->dst_x = plane_state->dst_rect.x;
+		       __entry->dst_y = plane_state->dst_rect.y;
+		       __entry->dst_w = plane_state->dst_rect.width;
+		       __entry->dst_h = plane_state->dst_rect.height;
+		       __entry->src_x = plane_state->src_rect.x;
+		       __entry->src_y = plane_state->src_rect.y;
+		       __entry->src_w = plane_state->src_rect.width;
+		       __entry->src_h = plane_state->src_rect.height;
+		       __entry->clip_x = plane_state->clip_rect.x;
+		       __entry->clip_y = plane_state->clip_rect.y;
+		       __entry->clip_w = plane_state->clip_rect.width;
+		       __entry->clip_h = plane_state->clip_rect.height;
+		       __entry->recout_x = plane_res->scl_data.recout.x;
+		       __entry->recout_y = plane_res->scl_data.recout.y;
+		       __entry->recout_w = plane_res->scl_data.recout.width;
+		       __entry->recout_h = plane_res->scl_data.recout.height;
+		       __entry->viewport_x = plane_res->scl_data.viewport.x;
+		       __entry->viewport_y = plane_res->scl_data.viewport.y;
+		       __entry->viewport_w = plane_res->scl_data.viewport.width;
+		       __entry->viewport_h = plane_res->scl_data.viewport.height;
+		       __entry->flip_immediate = plane_state->flip_immediate;
+		       __entry->surface_pitch = plane_state->plane_size.surface_pitch;
+		       __entry->format = plane_state->format;
+		       __entry->swizzle = plane_state->tiling_info.gfx9.swizzle;
+		       __entry->update_flags = update_flags;
+	),
+	TP_printk("pipe_idx=%d stream=%p rct(%d,%d) dst=(%d,%d,%d,%d) "
+		  "src=(%d,%d,%d,%d) clip=(%d,%d,%d,%d) recout=(%d,%d,%d,%d) "
+		  "viewport=(%d,%d,%d,%d) flip_immediate=%d pitch=%d "
+		  "format=%d swizzle=%d update_flags=%x",
+		  __entry->pipe_idx,
+		  __entry->stream,
+		  __entry->stream_w,
+		  __entry->stream_h,
+		  __entry->dst_x,
+		  __entry->dst_y,
+		  __entry->dst_w,
+		  __entry->dst_h,
+		  __entry->src_x,
+		  __entry->src_y,
+		  __entry->src_w,
+		  __entry->src_h,
+		  __entry->clip_x,
+		  __entry->clip_y,
+		  __entry->clip_w,
+		  __entry->clip_h,
+		  __entry->recout_x,
+		  __entry->recout_y,
+		  __entry->recout_w,
+		  __entry->recout_h,
+		  __entry->viewport_x,
+		  __entry->viewport_y,
+		  __entry->viewport_w,
+		  __entry->viewport_h,
+		  __entry->flip_immediate,
+		  __entry->surface_pitch,
+		  __entry->format,
+		  __entry->swizzle,
+		  __entry->update_flags
+	)
+);
+
 #endif /* _AMDGPU_DM_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 166dbaa251e9..764cae604203 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -70,6 +70,8 @@
 
 #include "dce/dmub_hw_lock_mgr.h"
 
+#include "dc_trace.h"
+
 #define CTX \
 	dc->ctx
 
@@ -2709,6 +2711,8 @@ void dc_commit_updates_for_stream(struct dc *dc,
 		}
 	}
 
+	TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
+
 	commit_planes_for_stream(
 				dc,
 				srf_updates,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_trace.h b/drivers/gpu/drm/amd/display/dc/dc_trace.h
new file mode 100644
index 000000000000..783256914596
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_trace.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu_dm_trace.h"
+
+#define TRACE_DC_PIPE_STATE(pipe_ctx, index, max_pipes) \
+	for (index = 0; index < max_pipes; ++index) { \
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[index]; \
+		if (pipe_ctx->plane_state) \
+			trace_amdgpu_dm_dc_pipe_state(pipe_ctx->pipe_idx, pipe_ctx->plane_state, \
+						      pipe_ctx->stream, &pipe_ctx->plane_res, \
+						      pipe_ctx->update_flags.raw); \
+	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 08227f0d13f2..8eb88a50af51 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -52,6 +52,7 @@
 #include "dpcd_defs.h"
 #include "dsc.h"
 #include "dce/dmub_hw_lock_mgr.h"
+#include "dc_trace.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1020,15 +1021,17 @@ static bool dcn10_hw_wa_force_recovery(struct dc *dc)
 
 }
 
-
 void dcn10_verify_allow_pstate_change_high(struct dc *dc)
 {
 	static bool should_log_hw_state; /* prevent hw state log by default */
 
 	if (!hubbub1_verify_allow_pstate_change_high(dc->res_pool->hubbub)) {
-		if (should_log_hw_state) {
+		int i = 0;
+
+		if (should_log_hw_state)
 			dcn10_log_hw_state(dc, NULL);
-		}
+
+		TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
 		BREAK_TO_DEBUGGER();
 		if (dcn10_hw_wa_force_recovery(dc)) {
 		/*check again*/
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
