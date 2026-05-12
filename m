Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F44FCD4F3D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 14:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1050F10EB67;
	Tue, 12 May 2026 14:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0L0JsGdB";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010024.outbound.protection.outlook.com
 [40.93.198.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B92510EB67
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 14:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQTviR3jDM56WA0eNvj3/jXCLMbW8w7mz2xC5r7eI8/LLLGKgxL8bDFNx19glpyVMU9ShY7+ugus4T+PjEYnyT57AWAYgxWqIuXU/joky+ro8UKBM3eSPDlPnS6wN39IsY87/kAa6q1X41lJ3kXD6hGKRuMy4gvXdQsnq+eqUKGNk2CmTvdX4DxpmXSahYLpqIqUO6WuADqomR/6Z9ups+eEuzv7a/IuNrSSR9BamdbCCwCORyYD7XHy2WkkDbxHMJWWlgzM0eziYaxCEUIe0JxNM0vCkD+yTNNewlER2pHjtKmj5S3SS+tUl3I1o71qXJT75zfv1t5udBm/Mtqr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2PZNveA305WUIMS0ZOdVZRITtR2o5huBQQgHlAeikQ=;
 b=HCMZLiL1FKv5PMLTxRlP2RucwVVWEI7nlg5DT/rbSjOTSVZkg+f4006846HEJlWozpXGLW7LUpR4q5lKqC6IBhaFk8f3FRbsuvbXWXGFHUqr0+oDoUGoMFdTrFVf5murzkbvJvo41o7rQO1xugXcPGTCHMvgynaTbq+2N0JsgzFTmBWfGj6ALHM2T5VKESh2XXzfZ4Wr2omyVj/2ib36dSAImPt1VzcokVRNkiClH1cIbIicbycS9gzLT5Qzr5FonsIhizxbv5RINnPo3lfBbRTjuwhpbC0vxe2uTVghKqfiLhntTmInHO/f4arox2YFFyGj1sABQUflQfM4UNSuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2PZNveA305WUIMS0ZOdVZRITtR2o5huBQQgHlAeikQ=;
 b=0L0JsGdB5hbi6GsYWc8Xj4S1F2xufzV7BIVp9S3VPBgTGuEm8MHhPZEAAbDdcv3mNYtvFcC2LBtGadznk38ub4Rrr6TmAGIAqxeZ0KCQh0uVwvPwYCTG0egG72p4ZFuHX82ctJsfsW+M1of7DARPijYoW/yTZBd1Byry7tby0Zo=
Received: from MN2PR20CA0036.namprd20.prod.outlook.com (2603:10b6:208:e8::49)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 14:23:26 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::b3) by MN2PR20CA0036.outlook.office365.com
 (2603:10b6:208:e8::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 14:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 14:23:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 09:23:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 09:23:21 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 09:23:20 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v4 08/13] drm/amd/display Add DC link support for FRL
Date: Tue, 12 May 2026 10:23:02 -0400
Message-ID: <20260512142308.131260-9-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512142308.131260-1-harry.wentland@amd.com>
References: <20260512142308.131260-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: ac69f471-21f1-46f5-4424-08deb03207f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|11063799003|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 8zgsInEu6E1s17nz4vra6axqVEQ+zST5WB3r37yrZOY/znmb+GLZmIW3CnORx50yuoqMT65RiCyKi2PPgVUvnybOmHUJOL+nBQdnJg9zq7U5zUpxq5bnLdoNrpw8DuG7zy1dcYByR6RK1TvNwxuPZTcVGNYCzEhQJCa/xg0rl4B6SaUOBA/N3/PlcruSKCXrpuCosWHuqthN7XjjwpT6ugJSOY+3ZxN9e/aWqDKtU+YFWnVM8N6B8z2QkFGL4dkCzfKLnUqe4+XN9CZHEBan5pjR2bB2iP9Q1dqexKlATLEWkmkQZ3NQlhxrnt9zvKdOZUy6CMcltxSg/kHuRZGxHzAxDXEsnuvhn1uAagH834WLtLiSFkrOhWOzZU2sBtJ+RWY55HYD3LrK8g5CiyaaKaxX2Z1+6t3xBHhlH+JM3I9flwwhp4ITTlc+kxtUf8grQdG+snTZxoTySPUZadrAoZAzAdUHHElK210zjWqTt6uqp8HSkfKugMxgHzwA92nODUiP6HAAYmZLObk7HJxhRtrc0P/SgygipeaJX5itBphnVtP3p84JUnBh7hydl1O9+krqwHs9LKonvgU4xwRBMuk+uaYazp5RNj5tia0HB71Ol4eWiNLITlOIcLJbbAca+0+YyrXoasMBv4/Bl93oz6qnUe2HBslDKb+rlHIjvxUuUZP0cRFZmZZfcTWtzm9AlzKULH6VgGcknwyTzD3tjqsyvKiwfKaiYHaDlE8hYXE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(11063799003)(18002099003)(22082099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ETKcs4mUjyd49Gw31Ybt/QcxL2XJpWpyYqak1/4SsNFXtaHNPA9enOZ7KMB7ky/VYyBlZIQbEmGIAdQ2O3edYze3LfstfWrku419EYmCIa83prnAVjKphPmFRpKcOV99Z0eYnIbpC8VNWtFl64GtQHcFNNFqBkIud8/IEHYVMsa0DEe96/S6Vo1q9W3c/2BGsUg8Wwf4z6VqHl2EykbzHJMUvkexJtX05TYIdU+Htws/1MFH4r6x9KL3nGKlCasWg+hXn1kTEhDGS1TJ8WdjmV6/ZfdMWfnfgbkMPGV5cZYWKzyI0o5OsZvbR4ee8N8VKFcIvdSVGoH/PjUZAQ8Zmf/vxxevP508rlZSvn09bl8WC6axJJShPulAqUNBviiVuIqHHLoiwW8W3Ko9rBeozB6CUdzrawVF4xYCqrCqPxCDCcnCyytiVNINFttEBkkk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:23:26.0855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac69f471-21f1-46f5-4424-08deb03207f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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

Start bringing in the protocol layer for FRL in DC link.
This includes FRL training, timing validation, and other
protocol bits.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    2 +
 .../display/dc/link/hwss/link_hwss_hpo_frl.c  |  113 ++
 .../display/dc/link/hwss/link_hwss_hpo_frl.h  |   34 +
 .../drm/amd/display/dc/link/link_detection.c  |  111 ++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  185 ++-
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |    1 +
 .../drm/amd/display/dc/link/link_factory.c    |   44 +
 .../drm/amd/display/dc/link/link_validation.c |  298 +++++
 .../drm/amd/display/dc/link/link_validation.h |   13 +
 .../amd/display/dc/link/protocols/link_ddc.c  |   90 ++
 .../amd/display/dc/link/protocols/link_ddc.h  |    4 +
 .../display/dc/link/protocols/link_hdmi_frl.c | 1147 +++++++++++++++++
 .../display/dc/link/protocols/link_hdmi_frl.h |   53 +
 .../amd/display/dc/link/protocols/link_hpd.c  |    1 +
 14 files changed, 2094 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h

diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index 0f3670e30232..f558a20eceaa 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -45,6 +45,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_LINK_ACCESSORIES)
 LINK_HWSS = link_hwss_dio.o link_hwss_dpia.o link_hwss_hpo_dp.o \
 link_hwss_dio_fixed_vs_pe_retimer.o link_hwss_hpo_fixed_vs_pe_retimer_dp.o \
 link_hwss_virtual.o
+LINK_HWSS += link_hwss_hpo_frl.o
 
 AMD_DAL_LINK_HWSS = $(addprefix $(AMDDALPATH)/dc/link/hwss/, \
 $(LINK_HWSS))
@@ -58,6 +59,7 @@ link_dp_training.o link_dp_training_8b_10b.o link_dp_training_128b_132b.o \
 link_dp_training_dpia.o link_dp_training_auxless.o \
 link_dp_training_fixed_vs_pe_retimer.o link_dp_phy.o link_dp_capability.o \
 link_edp_panel_control.o link_dp_panel_replay.o link_dp_irq_handler.o link_dp_dpia_bw.o
+LINK_PROTOCOLS += link_hdmi_frl.o
 
 AMD_DAL_LINK_PROTOCOLS = $(addprefix $(AMDDALPATH)/dc/link/protocols/, \
 $(LINK_PROTOCOLS))
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
new file mode 100644
index 000000000000..a2c0fa21ee94
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+ * Authors: AMD
+ *
+ */
+#include "link_hwss_hpo_frl.h"
+#include "core_types.h"
+#include "link/hwss/link_hwss_virtual.h"
+
+static void setup_hpo_frl_stream_attribute(struct pipe_ctx *pipe_ctx)
+{
+	struct hpo_frl_stream_encoder *stream_enc = pipe_ctx->stream_res.hpo_frl_stream_enc;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct pipe_ctx *odm_pipe;
+	struct dc *dc = stream->link->ctx->dc;
+	struct dc_stream_state *temp_stream = &dc->scratch.temp_stream;
+	int odm_combine_num_segments = 1;
+
+	memcpy(temp_stream, stream, sizeof(struct dc_stream_state));
+
+	/* Modify patched_crtc_timing as required for padding */
+	if (pipe_ctx->dsc_padding_params.dsc_hactive_padding) {
+		temp_stream->timing.h_addressable = stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		temp_stream->timing.h_total = stream->timing.h_total + pipe_ctx->dsc_padding_params.dsc_htotal_padding;
+	}
+
+	/* get number of ODM combine input segments */
+	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		odm_combine_num_segments++;
+
+	stream_enc->funcs->hdmi_frl_set_stream_attribute(
+			stream_enc,
+			&temp_stream->timing,
+			&stream->link->frl_link_settings.borrow_params,
+			odm_combine_num_segments);
+}
+
+static void disable_hpo_frl_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	(void)link_res;
+	if (dc_is_hdmi_frl_signal(signal))
+		link->hpo_frl_link_enc->funcs->disable_link_encoder(link->hpo_frl_link_enc);
+	link->link_enc->funcs->disable_output(link->link_enc, signal);
+}
+
+static void setup_hpo_frl_audio_output(struct pipe_ctx *pipe_ctx,
+		struct audio_output *audio_output, uint32_t audio_inst)
+{
+	pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_audio_setup(
+			pipe_ctx->stream_res.hpo_frl_stream_enc,
+			audio_inst,
+			&pipe_ctx->stream->audio_info,
+			&audio_output->crtc_info);
+}
+
+static void enable_hpo_frl_audio_packet(struct pipe_ctx *pipe_ctx)
+{
+	pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->audio_mute_control(
+			pipe_ctx->stream_res.hpo_frl_stream_enc, false);
+}
+
+static void disable_hpo_frl_audio_packet(struct pipe_ctx *pipe_ctx)
+{
+	pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->audio_mute_control(
+		pipe_ctx->stream_res.hpo_frl_stream_enc, true);
+
+	if (pipe_ctx->stream_res.audio)
+		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_audio_disable(
+			pipe_ctx->stream_res.hpo_frl_stream_enc);
+}
+
+static const struct link_hwss hpo_frl_link_hwss = {
+	.setup_stream_encoder = virtual_setup_stream_encoder,
+	.reset_stream_encoder = virtual_reset_stream_encoder,
+	.setup_stream_attribute = setup_hpo_frl_stream_attribute,
+	.disable_link_output = disable_hpo_frl_link_output,
+	.setup_audio_output = setup_hpo_frl_audio_output,
+	.enable_audio_packet = enable_hpo_frl_audio_packet,
+	.disable_audio_packet = disable_hpo_frl_audio_packet,
+};
+
+bool can_use_hpo_frl_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res)
+{
+	(void)link;
+	return link_res->hpo_frl_link_enc != NULL;
+}
+
+const struct link_hwss *get_hpo_frl_link_hwss(void)
+{
+	return &hpo_frl_link_hwss;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.h b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.h
new file mode 100644
index 000000000000..ea8d9760132f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+ * Authors: AMD
+ *
+ */
+#ifndef __LINK_HWSS_HPO_FRL_H__
+#define __LINK_HWSS_HPO_FRL_H__
+
+#include "link_hwss.h"
+
+bool can_use_hpo_frl_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res);
+const struct link_hwss *get_hpo_frl_link_hwss(void);
+
+#endif /* __LINK_HWSS_HPO_FRL_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 1ac6a22fecfe..a3212fd151d1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -41,6 +41,7 @@
 #include "protocols/link_dp_dpia.h"
 #include "protocols/link_dp_phy.h"
 #include "protocols/link_dp_training.h"
+#include "protocols/link_hdmi_frl.h"
 #include "protocols/link_dp_dpia_bw.h"
 #include "accessories/link_dp_trace.h"
 
@@ -78,6 +79,7 @@ static enum ddc_transaction_type get_ddc_transaction_type(enum signal_type sink_
 	case SIGNAL_TYPE_DVI_SINGLE_LINK:
 	case SIGNAL_TYPE_DVI_DUAL_LINK:
 	case SIGNAL_TYPE_HDMI_TYPE_A:
+	case SIGNAL_TYPE_HDMI_FRL:
 	case SIGNAL_TYPE_LVDS:
 	case SIGNAL_TYPE_RGB:
 		transaction_type = DDC_TRANSACTION_TYPE_I2C;
@@ -769,6 +771,60 @@ static bool should_prepare_phy_clocks_for_link_verification(const struct dc *dc,
 	return !can_apply_seamless_boot && reason != DETECT_REASON_BOOT;
 }
 
+static bool is_hdmi_frl_in_use(struct dc_link *link)
+{
+	int i;
+	unsigned int hdmi_conn_count = 0;
+	unsigned int hdmi_stream_count = 0;
+	bool hdmi_frl_in_use = false;
+	bool incoming_link_identical = false;
+
+	/*Enumerate HDMI connector from all present links */
+	for (i = 0; i < link->dc->link_count; i++) {
+		if (link->dc->links[i] != NULL &&
+				dc_is_hdmi_signal(link->dc->links[i]->connector_signal))
+			hdmi_conn_count++;
+	}
+	/* If less than 2 HDMI Connector, assume HPO is always available*/
+	if (hdmi_conn_count < 2)
+		return false;
+
+	/*Enumerate existing HDMI stream count*/
+	for (i = 0; i < link->dc->current_state->stream_count; i++) {
+		if (dc_is_hdmi_signal(link->dc->current_state->streams[i]->signal))
+			hdmi_stream_count++;
+		if (link == link->dc->current_state->streams[i]->link &&
+				(dc_is_hdmi_frl_signal(link->dc->current_state->streams[i]->signal)))
+			incoming_link_identical = true;
+	}
+
+	if (hdmi_stream_count > 1 || (hdmi_stream_count == 1 && !incoming_link_identical)) {
+		for (i = 0; i < link->dc->current_state->stream_count; i++) {
+			if (dc_is_hdmi_frl_signal(
+					link->dc->current_state->streams[i]->signal)) {
+				hdmi_frl_in_use = true;
+				break;
+			}
+		}
+	}
+
+	/* Check if previous link already has been assigned with FRL*/
+	if (!hdmi_frl_in_use && !incoming_link_identical) {
+		for (i = 0; i < link->dc->link_count; i++) {
+			if (link->dc->links[i] != NULL &&
+					link->dc->links[i]->local_sink != NULL &&
+					link != link->dc->links[i] &&
+					dc_is_hdmi_frl_signal(
+							link->dc->links[i]->local_sink->sink_signal)) {
+				hdmi_frl_in_use = true;
+				break;
+			}
+		}
+	}
+
+	return hdmi_frl_in_use;
+}
+
 static void prepare_phy_clocks_for_destructive_link_verification(const struct dc *dc)
 {
 	dc_z10_restore(dc);
@@ -796,6 +852,16 @@ static void verify_link_capability_destructive(struct dc_link *link,
 		dp_verify_link_cap_with_retries(
 				link, &known_limit_link_setting,
 				LINK_TRAINING_MAX_VERIFY_RETRY);
+	} else if (dc_is_hdmi_signal(link->local_sink->sink_signal)) {
+		if (!is_hdmi_frl_in_use(link)) {
+			link_set_all_streams_dpms_off_for_link(link);
+			hdmi_frl_verify_link_cap(link, &link->frl_reported_link_cap);
+			link->local_sink->sink_signal = (link->frl_verified_link_cap.frl_link_rate != HDMI_FRL_LINK_RATE_DISABLE)
+												? SIGNAL_TYPE_HDMI_FRL : SIGNAL_TYPE_HDMI_TYPE_A;
+		} else {
+			link->local_sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+			link->frl_verified_link_cap.frl_link_rate = HDMI_FRL_LINK_RATE_DISABLE;
+		}
 	} else {
 		ASSERT(0);
 	}
@@ -815,6 +881,13 @@ static void verify_link_capability_non_destructive(struct dc_link *link)
 			link->verified_link_cap = link->reported_link_cap;
 		else
 			link->verified_link_cap = dp_get_max_link_cap(link);
+	} else if (dc_is_hdmi_signal(link->local_sink->sink_signal)) {
+		link->verified_link_cap = link->reported_link_cap;
+
+		if (is_hdmi_frl_in_use(link)) {
+			link->local_sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+			link->frl_verified_link_cap.frl_link_rate = HDMI_FRL_LINK_RATE_DISABLE;
+		}
 	}
 }
 
@@ -850,6 +923,27 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
 				destrictive = false;
 			}
 		}
+	} else if (dc_is_hdmi_signal(link->local_sink->sink_signal) && link->link_enc &&
+				link->link_enc->features.flags.bits.IS_HDMI_FRL_CAPABLE &&
+				link->local_sink->edid_caps.max_frl_rate != 0) {
+		int i = 0;
+		struct pipe_ctx *pipes =
+				link->dc->current_state->res_ctx.pipe_ctx;
+
+		destrictive = true;
+		if (is_hdmi_frl_in_use(link)) {
+			destrictive = false;
+		} else if (link->dc->config.skip_frl_pretraining) {
+			for (i = 0; i < MAX_PIPES; i++) {
+				if (pipes[i].stream != NULL &&
+					pipes[i].stream->link == link) {
+					/*If link is already active, skip PHY programming*/
+					if (link->link_status.link_active) {
+						destrictive = false;
+					}
+				}
+			}
+		}
 	}
 
 	return destrictive;
@@ -1007,6 +1101,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 
 		/* From Disconnected-to-Connected. */
 		switch (link->connector_signal) {
+		case SIGNAL_TYPE_HDMI_FRL:
 		case SIGNAL_TYPE_HDMI_TYPE_A: {
 			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
 			if (aud_support->hdmi_audio_native)
@@ -1234,6 +1329,13 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		if (dc_is_hdmi_signal(link->connector_signal))
 			read_scdc_caps(link->ddc, link->local_sink);
 
+		if (dc_is_hdmi_signal(link->connector_signal) && dc->debug.enable_hdmi_idcc) {
+			memset(&link->hdmi_cable_id, 0, sizeof(union hdmi_idcc_cable_id));
+			read_idcc_data(link->ddc, HDMI_IDCC_SCOPE_RW_CA,
+				link->hdmi_cable_id.raw, 0, 4);
+		}
+		if (sink->edid_caps.rr_capable)
+			hdmi_frl_write_read_request_enable(link->ddc);
 		/* When FreeSync is toggled through OSD,
 		 * we see same EDID no matter what. Check MCCS caps
 		 * to see if we should update FreeSync caps now.
@@ -1248,6 +1350,12 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 				same_edid = false;
 		}
 
+		if (reason != DETECT_REASON_FALLBACK && dc_is_hdmi_signal(link->connector_signal) &&
+				link->link_enc->features.flags.bits.IS_HDMI_FRL_CAPABLE && sink->edid_caps.max_frl_rate != 0) {
+			hdmi_frl_retrieve_link_cap(link, link->local_sink);
+		}
+		if (reason == DETECT_REASON_FALLBACK && sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)
+			same_edid = false;
 		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
 		    sink_caps.transaction_type ==
 		    DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
@@ -1262,6 +1370,8 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 				link_disconnect_remap(prev_sink, link);
 				sink = prev_sink;
 				prev_sink = NULL;
+				if (reason == DETECT_REASON_FALLBACK && sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)
+						sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 			}
 
 			if (!sink->edid_caps.analog)
@@ -1529,6 +1639,7 @@ bool link_is_hdcp22(struct dc_link *link, enum signal_type signal)
 	case SIGNAL_TYPE_DVI_SINGLE_LINK:
 	case SIGNAL_TYPE_DVI_DUAL_LINK:
 	case SIGNAL_TYPE_HDMI_TYPE_A:
+	case SIGNAL_TYPE_HDMI_FRL:
 		ret = (link->hdcp_caps.rx_caps.fields.version == 0x4) ? 1:0;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index d52155e86f0f..9096b34fc35f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -48,6 +48,7 @@
 #include "protocols/link_edp_panel_control.h"
 #include "protocols/link_dp_panel_replay.h"
 #include "protocols/link_dp_dpia_bw.h"
+#include "link/protocols/link_hdmi_frl.h"
 
 #include "dm_helpers.h"
 #include "link_enc_cfg.h"
@@ -71,6 +72,10 @@
 	DC_LOG_RETIMER_REDRIVER(  \
 		__VA_ARGS__)
 
+#define FRL_INFO(...) \
+	DC_LOG_HDMI_FRL_LTP(  \
+		__VA_ARGS__)
+
 #define MAX_MTP_SLOT_COUNT 64
 #define LINK_TRAINING_ATTEMPTS 4
 #define PEAK_FACTOR_X1000 1006
@@ -550,14 +555,21 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 	if (dp_is_128b_132b_signal(pipe_ctx))
 		config.stream_enc_idx =
 				(uint8_t)(pipe_ctx->stream_res.hpo_dp_stream_enc->id - ENGINE_ID_HPO_DP_0);
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		config.stream_enc_idx =
+				(uint8_t)(pipe_ctx->stream_res.hpo_frl_stream_enc->id - ENGINE_ID_HPO_0);
 
 	/* dig back end */
 	config.dig_be = pipe_ctx->stream->link->link_enc_hw_inst;
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		config.dig_be = (uint8_t)pipe_ctx->stream_res.hpo_frl_stream_enc->stream_enc_inst;
 
 	/* link encoder index */
 	config.link_enc_idx = (uint8_t)(link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	if (dp_is_128b_132b_signal(pipe_ctx))
 		config.link_enc_idx = (uint8_t)pipe_ctx->link_res.hpo_dp_link_enc->inst;
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		config.link_enc_idx = (uint8_t)pipe_ctx->stream->link->hpo_frl_link_enc->inst;
 
 	/* dio output index is dpia index for DPIA endpoint & dcio index by default */
 	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
@@ -577,6 +589,7 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 	config.assr_enabled = (panel_mode == DP_PANEL_MODE_EDP) ? 1 : 0;
 	config.mst_enabled = (pipe_ctx->stream->signal ==
 			SIGNAL_TYPE_DISPLAY_PORT_MST) ? 1 : 0;
+	config.frl_enabled = dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) ? 1 : 0;
 	config.dp2_enabled = dp_is_128b_132b_signal(pipe_ctx) ? 1 : 0;
 	config.usb4_enabled = (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) ?
 			1 : 0;
@@ -588,6 +601,38 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 	cp_psp->funcs.update_stream_config(cp_psp->handle, &config);
 }
 
+void link_wait_for_unlocked(struct dc_link *link)
+{
+	unsigned long long enter_timestamp;
+	unsigned long long finish_timestamp;
+	unsigned long long time_taken_in_ns;
+	bool waited = false;
+
+	DC_LOGGER_INIT(link->ctx->logger);
+
+	enter_timestamp = dm_get_timestamp(link->ctx);
+
+	while (link->is_link_locked) { // busy wait
+		if (!waited) {
+			DC_LOG_DC("%s: 0x%p ...", __func__, link);
+
+			waited = true;
+		}
+
+		udelay(1);
+	}
+
+	if (!waited)
+		return;
+
+	finish_timestamp = dm_get_timestamp(link->ctx);
+	time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx,
+							finish_timestamp, enter_timestamp);
+
+	DC_LOG_DC("%s: 0x%p took %llu ms.", __func__,
+			link, div_u64(time_taken_in_ns, 1000000));
+}
+
 static void set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct dc  *dc = pipe_ctx->stream->ctx->dc;
@@ -595,6 +640,9 @@ static void set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 	if (!dc_is_hdmi_signal(pipe_ctx->stream->signal))
 		return;
 
+	if (pipe_ctx->stream->timing.flags.DSC)
+		return;
+
 	dc->hwss.set_avmute(pipe_ctx, enable);
 }
 
@@ -1813,6 +1861,13 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 			stream->phy_pix_clk,
 			(stream->timing.flags.LTE_340MCSC_SCRAMBLE != 0));
 
+	if (dc->debug.enable_hdmi_idcc) {
+		union hdmi_idcc_source_id source_id;
+
+		source_id.raw = 0xff;
+		write_idcc_data(stream->link->ddc, HDMI_IDCC_SCOPE_WRITE,
+				&source_id.raw, 0, 1);
+	}
 	memset(&stream->link->cur_link_settings, 0,
 			sizeof(struct dc_link_settings));
 
@@ -1838,6 +1893,109 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 		read_scdc_data(link->ddc);
 }
 
+static enum dc_status enable_link_hdmi_frl(struct pipe_ctx *pipe_ctx)
+{
+	enum link_result link_stat = LINK_RESULT_UNKNOWN;
+	enum dc_status status = DC_OK;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc *core_dc = pipe_ctx->stream->ctx->dc;
+	enum clock_source_id frl_phy_clock_source_id;
+	bool frl_poll_start = true;
+
+	DC_LOGGER_INIT(stream->ctx->logger);
+
+	if ((!stream->link->link_enc) ||
+			(!stream->link->hpo_frl_link_enc) ||
+			(!core_dc->res_pool->dccg->funcs->enable_hdmicharclk) ||
+			(!(pipe_ctx->stream_res.hpo_frl_stream_enc)))
+		return DC_ERROR_UNEXPECTED;
+
+	/* get link settings for video mode timing */
+	hdmi_frl_decide_link_settings(stream, &stream->link->frl_link_settings, &pipe_ctx->dsc_padding_params);
+
+	switch (stream->link->frl_link_settings.frl_link_rate) {
+	case HDMI_FRL_LINK_RATE_3GBPS:
+		pipe_ctx->stream_res.pix_clk_params.requested_sym_clk = 166667;
+		break;
+	case HDMI_FRL_LINK_RATE_6GBPS:
+	case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+		pipe_ctx->stream_res.pix_clk_params.requested_sym_clk = 333333;
+		break;
+	case HDMI_FRL_LINK_RATE_8GBPS:
+		pipe_ctx->stream_res.pix_clk_params.requested_sym_clk = 444444;
+		break;
+	case HDMI_FRL_LINK_RATE_10GBPS:
+		pipe_ctx->stream_res.pix_clk_params.requested_sym_clk = 555555;
+		break;
+	case HDMI_FRL_LINK_RATE_12GBPS:
+		pipe_ctx->stream_res.pix_clk_params.requested_sym_clk = 666667;
+		break;
+	case HDMI_FRL_LINK_RATE_16GBPS:
+		pipe_ctx->stream_res.pix_clk_params.requested_sym_clk = 888889;
+		break;
+	case HDMI_FRL_LINK_RATE_20GBPS:
+		pipe_ctx->stream_res.pix_clk_params.requested_sym_clk = 1111111;
+		break;
+	case HDMI_FRL_LINK_RATE_24GBPS:
+		pipe_ctx->stream_res.pix_clk_params.requested_sym_clk = 1333333;
+		break;
+	default:
+		break;
+	}
+
+	stream->phy_pix_clk = pipe_ctx->stream_res.pix_clk_params.requested_sym_clk;
+
+	memset(&stream->link->cur_link_settings, 0,
+			sizeof(struct dc_link_settings));
+
+	/* Find proper clock source in HDMI FRL mode for phy used for DCCG */
+	frl_phy_clock_source_id = hdmi_frl_find_matching_phypll(stream->link);
+
+	FRL_INFO("FRL LINK TRAINING:  LTS:P Start\n");
+	/* Setup FRL PHY, enable HDMI character clock and HPO link encoder */
+	core_dc->hwss.setup_hdmi_frl_link(stream->link,
+			(pipe_ctx->stream_res.hpo_frl_stream_enc->id - ENGINE_ID_HPO_0),
+			frl_phy_clock_source_id);
+
+	link_stat = hdmi_frl_perform_link_training_with_retries(stream->link);
+
+	if (core_dc->res_pool->dccg->funcs->set_valid_pixel_rate)
+		core_dc->res_pool->dccg->funcs->set_valid_pixel_rate(
+						core_dc->res_pool->dccg,
+						core_dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(core_dc->clk_mgr),
+						pipe_ctx->stream_res.tg->inst,
+						(stream->timing.pix_clk_100hz / 10));
+
+	/* Enable FRL packet transmission */
+	if (link_stat == LINK_RESULT_SUCCESS) {
+		stream->link->hpo_frl_link_enc->funcs->enable_output(
+				stream->link->hpo_frl_link_enc);
+		if (stream->link->frl_flags.apply_vsdb_rcc_wa)
+			stream->link->hpo_frl_link_enc->funcs->apply_vsdb_rcc_wa(stream->link->hpo_frl_link_enc);
+		if (frl_poll_start)
+			hdmi_frl_poll_start(stream->link->ddc);
+
+		FRL_INFO("FRL LINK TRAINING:  LTS:P Success\n");
+
+		/* Set HDMISTREAMCLK source to DTBCLK0 and bypass DTO */
+		if (core_dc->res_pool->dccg->funcs->set_hdmistreamclk) {
+			core_dc->res_pool->dccg->funcs->set_hdmistreamclk(
+					core_dc->res_pool->dccg,
+					DTBCLK0,
+					pipe_ctx->stream_res.tg->inst);
+		}
+
+		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_enable(
+			pipe_ctx->stream_res.hpo_frl_stream_enc,
+			pipe_ctx->stream_res.tg->inst);
+	} else {
+		status = DC_FAIL_HDMI_FRL_LINK_TRAINING;
+		stream->link->frl_link_settings.frl_link_rate = 0;
+	}
+
+	return status;
+}
+
 static enum dc_status enable_link_dp(struct dc_state *state,
 				     struct pipe_ctx *pipe_ctx)
 {
@@ -2076,6 +2234,14 @@ static enum dc_status enable_link(
 		enable_link_hdmi(pipe_ctx);
 		status = DC_OK;
 		break;
+	case SIGNAL_TYPE_HDMI_FRL:
+		if (link->local_sink &&
+			link->local_sink->edid_caps.panel_patch.delay_hdmi_link_training &&
+			stream->timing.pix_clk_100hz == 6627500) {
+			msleep(link->local_sink->edid_caps.panel_patch.delay_hdmi_link_training);
+		}
+		status = enable_link_hdmi_frl(pipe_ctx);
+		break;
 	case SIGNAL_TYPE_LVDS:
 		enable_link_lvds(pipe_ctx);
 		status = DC_OK;
@@ -2179,6 +2345,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 
 	if (dp_is_128b_132b_signal(pipe_ctx))
 		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		vpg = pipe_ctx->stream_res.hpo_frl_stream_enc->vpg;
 	if (dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
@@ -2191,6 +2359,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
+	link_wait_for_unlocked(link);
+
 	if (!pipe_ctx->stream->sink->edid_caps.panel_patch.skip_avmute) {
 		if (dc_is_hdmi_signal(pipe_ctx->stream->signal))
 			set_avmute(pipe_ctx, true);
@@ -2293,6 +2463,8 @@ void link_set_dpms_on(
 
 	if (dp_is_128b_132b_signal(pipe_ctx))
 		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		vpg = pipe_ctx->stream_res.hpo_frl_stream_enc->vpg;
 	if (dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
@@ -2307,11 +2479,13 @@ void link_set_dpms_on(
 		}
 	}
 
+	link_wait_for_unlocked(stream->link);
 	if (!dc->config.unify_link_enc_assignment)
 		link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
 	if (!dc_is_virtual_signal(pipe_ctx->stream->signal)
+			&& !dc_is_hdmi_frl_signal(pipe_ctx->stream->signal)
 			&& !dp_is_128b_132b_signal(pipe_ctx)) {
 		if (link_enc)
 			link_enc->funcs->setup(
@@ -2321,9 +2495,14 @@ void link_set_dpms_on(
 
 	pipe_ctx->stream->link->link_state_valid = true;
 
+	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+		hdmi_frl_decide_link_settings(stream, &stream->link->frl_link_settings, &pipe_ctx->dsc_padding_params);
+
 	if (pipe_ctx->stream_res.tg->funcs->set_out_mux) {
 		if (dp_is_128b_132b_signal(pipe_ctx))
 			otg_out_dest = OUT_MUX_HPO_DP;
+		else if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
+			otg_out_dest = OUT_MUX_HPO_FRL;
 		else
 			otg_out_dest = OUT_MUX_DIO;
 		pipe_ctx->stream_res.tg->funcs->set_out_mux(pipe_ctx->stream_res.tg, otg_out_dest);
@@ -2414,8 +2593,9 @@ void link_set_dpms_on(
 		 * show the stream anyway. But MST displays can't proceed
 		 * without link training.
 		 */
-		if (status != DC_FAIL_DP_LINK_TRAINING ||
-				pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+			if ((status != DC_FAIL_DP_LINK_TRAINING &&
+					status != DC_FAIL_HDMI_FRL_LINK_TRAINING) ||
+					pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
 			if (false == stream->link->link_status.link_active)
 				disable_link(stream->link, &pipe_ctx->link_res,
 						pipe_ctx->stream->signal);
@@ -2435,6 +2615,7 @@ void link_set_dpms_on(
 	 * from transmitter control.
 	 */
 	if (!(dc_is_virtual_signal(pipe_ctx->stream->signal) ||
+			dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) ||
 			dp_is_128b_132b_signal(pipe_ctx))) {
 
 			if (link_enc)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.h b/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
index bd6fc63064a3..e8662147dd8e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
@@ -50,4 +50,5 @@ struct fixed31_32 link_calculate_sst_avg_time_slots_per_mtp(
 void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool link_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
 bool link_update_dsc_config(struct pipe_ctx *pipe_ctx);
+void link_wait_for_unlocked(struct dc_link *link);
 #endif /* __DC_LINK_DPMS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 2cc646425207..36c0df83aa5b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -42,6 +42,7 @@
 #include "protocols/link_dp_training.h"
 #include "protocols/link_edp_panel_control.h"
 #include "protocols/link_dp_panel_replay.h"
+#include "protocols/link_hdmi_frl.h"
 #include "protocols/link_hpd.h"
 #include "gpio_service_interface.h"
 #include "atomfirmware.h"
@@ -101,6 +102,8 @@ static void construct_link_service_validation(struct link_service *link_srv)
 	link_srv->validate_mode_timing = link_validate_mode_timing;
 	link_srv->dp_link_bandwidth_kbps = dp_link_bandwidth_kbps;
 	link_srv->validate_dp_tunnel_bandwidth = link_validate_dp_tunnel_bandwidth;
+	link_srv->frl_link_bandwidth_kbps = frl_link_bandwidth_kbps;
+	link_srv->frl_margin_check_uncompressed_video = frl_capacity_computations_uncompressed_video;
 	link_srv->dp_required_hblank_size_bytes = dp_required_hblank_size_bytes;
 }
 
@@ -121,6 +124,7 @@ static void construct_link_service_dpms(struct link_service *link_srv)
 	link_srv->set_dsc_on_stream = link_set_dsc_on_stream;
 	link_srv->set_dsc_enable = link_set_dsc_enable;
 	link_srv->update_dsc_config = link_update_dsc_config;
+	link_srv->wait_for_unlocked = link_wait_for_unlocked;
 }
 
 /* link ddc implements generic display communication protocols such as i2c, aux
@@ -243,6 +247,25 @@ static void construct_link_service_dp_panel_replay(struct link_service *link_srv
 	link_srv->dp_pr_get_state = dp_pr_get_state;
 }
 
+/* link hdmi frl implements FRL link capability and link training related
+ * functions. FRL link is established by order of retrieve_link, verify_link,
+ * and poll_status. Other helper functions exist to obtain information required
+ * to maintain the correct sequence according to HDMI specification. Each
+ * sequence and state inside link training functions are timing sensitive and order sensitive.
+ * It is mandatory that these functions are debugged with FRL_LTP output message
+ * configurable in DSAT.  Any changes in the LT sequence should follow the HDMI
+ * specification as much as possible and tested through HDMI electrical and
+ * link layer compliance.
+ */
+static void construct_link_service_hdmi_frl(struct link_service *link_srv)
+{
+	link_srv->hdmi_frl_poll_status_flag = hdmi_frl_poll_status_flag;
+	link_srv->hdmi_frl_get_verified_link_cap =
+			hdmi_frl_get_verified_link_cap;
+	link_srv->hdmi_frl_set_preferred_link_settings =
+			hdmi_frl_set_preferred_link_settings;
+}
+
 /* link dp cts implements dp compliance test automation protocols and manual
  * testing interfaces for debugging and certification purpose.
  */
@@ -296,6 +319,7 @@ static void construct_link_service(struct link_service *link_srv)
 	construct_link_service_dp_irq_handler(link_srv);
 	construct_link_service_edp_panel_control(link_srv);
 	construct_link_service_dp_panel_replay(link_srv);
+	construct_link_service_hdmi_frl(link_srv);
 	construct_link_service_dp_cts(link_srv);
 	construct_link_service_dp_trace(link_srv);
 }
@@ -401,6 +425,8 @@ static void link_destruct(struct dc_link *link)
 		link->link_enc->funcs->destroy(&link->link_enc);
 	}
 
+	if (link->hpo_frl_link_enc)
+		link->hpo_frl_link_enc->funcs->destroy(&link->hpo_frl_link_enc);
 	if (link->local_sink)
 		dc_sink_release(link->local_sink);
 
@@ -622,6 +648,7 @@ static bool construct_phy(struct dc_link *link,
 
 	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
 	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
+	DC_LOG_DC("BIOS object table - IS_HDMI_FRL_CAPABLE: %d", link->link_enc->features.flags.bits.IS_HDMI_FRL_CAPABLE);
 
 	switch (link->link_id.id) {
 	case CONNECTOR_ID_HDMI_TYPE_A:
@@ -825,12 +852,29 @@ static bool construct_phy(struct dc_link *link,
 	 */
 	program_hpd_filter(link);
 
+	/* If the connector is HDMI FRL capable, also create an HPO link encoder */
+	if ((link->link_enc->features.flags.bits.IS_HDMI_FRL_CAPABLE) &&
+		(!link->link_enc->features.flags.bits.DP_IS_USB_C) &&
+			(link->dc->res_pool->funcs->hpo_frl_link_enc_create)) {
+		enum engine_id hpo_eng_id;
+		hpo_eng_id = ENGINE_ID_HPO_0;
+
+		link->hpo_frl_link_enc = link->dc->res_pool->funcs->hpo_frl_link_enc_create(
+				hpo_eng_id,
+				dc_ctx);
+		if (link->hpo_frl_link_enc == NULL) {
+			DC_ERROR("Failed to create HPO link encoder!\n");
+			goto hpo_enc_create_fail;
+		}
+	}
+
 	link->psr_settings.psr_vtotal_control_support = false;
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 	link->replay_settings.config.replay_version = DC_REPLAY_VERSION_UNSUPPORTED;
 
 	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
 	return true;
+hpo_enc_create_fail:
 device_tag_fail:
 link_enc_create_fail:
 panel_cntl_create_fail:
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index ec083e8b75b4..d7bd352880b3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -31,6 +31,7 @@
 #include "link_validation.h"
 #include "protocols/link_dp_capability.h"
 #include "protocols/link_dp_dpia_bw.h"
+#include "protocols/link_hdmi_frl.h"
 #include "resource.h"
 
 #define DC_LOGGER_INIT(logger)
@@ -263,6 +264,195 @@ uint32_t dp_link_bandwidth_kbps(
 	return link_rate_per_lane_kbps * link_settings->lane_count / 10000 * total_data_bw_efficiency_x10000;
 }
 
+uint32_t frl_link_bandwidth_kbps(enum hdmi_frl_link_rate link_rate)
+{
+	switch (link_rate) {
+	case HDMI_FRL_LINK_RATE_3GBPS:
+		return 9000000;
+	case HDMI_FRL_LINK_RATE_6GBPS:
+		return 18000000;
+	case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+		return 24000000;
+	case HDMI_FRL_LINK_RATE_8GBPS:
+		return 32000000;
+	case HDMI_FRL_LINK_RATE_10GBPS:
+		return 40000000;
+	case HDMI_FRL_LINK_RATE_12GBPS:
+		return 48000000;
+	case HDMI_FRL_LINK_RATE_16GBPS:
+		return 64000000;
+	case HDMI_FRL_LINK_RATE_20GBPS:
+		return 80000000;
+	case HDMI_FRL_LINK_RATE_24GBPS:
+		return 96000000;
+	default:
+		return 0;
+	}
+}
+
+bool frl_capacity_computations_common(struct frl_cap_chk_params_fixed31_32 *params,
+	struct frl_cap_chk_intermediates_fixed31_32 *inter)
+{
+	struct fixed31_32 audio_bw_reserve = dc_fixpt_from_int((params->compressed ? 192000 : 0));
+	struct fixed31_32 pixel_rate_tolerance = dc_fixpt_div_int(dc_fixpt_from_int(5), 1000);
+	struct fixed31_32 max_audio_tol_rate;
+	struct fixed31_32 overhead_m;
+
+	inter->c_frl_sb = 4 * C_FRL_CB + params->lanes;
+	inter->overhead_sb = dc_fixpt_div_int(dc_fixpt_from_int(params->lanes), inter->c_frl_sb);
+	inter->overhead_rs = dc_fixpt_div_int(dc_fixpt_from_int(32), inter->c_frl_sb);
+	inter->overhead_map = dc_fixpt_div_int(dc_fixpt_from_int(25), (inter->c_frl_sb * 10));
+
+	inter->overhead_min = dc_fixpt_add(inter->overhead_sb, inter->overhead_rs);
+	inter->overhead_min = dc_fixpt_add(inter->overhead_min, inter->overhead_map);
+	overhead_m = dc_fixpt_div_int(dc_fixpt_from_int(3), 1000);
+	inter->overhead_max = dc_fixpt_add(inter->overhead_min, overhead_m);
+
+	pixel_rate_tolerance = dc_fixpt_add_int(pixel_rate_tolerance, 1);
+
+	inter->f_pixel_clock_max = dc_fixpt_mul(params->f_pixel_clock_nominal, pixel_rate_tolerance);
+	inter->t_line = dc_fixpt_div(dc_fixpt_from_int(params->h_active + params->h_blank), inter->f_pixel_clock_max);
+	inter->r_bit_min = dc_fixpt_div_int(dc_fixpt_from_int(TOLERANCE_FRL_BIT), 1000000);
+	inter->r_bit_min = dc_fixpt_sub(dc_fixpt_from_int(1), inter->r_bit_min);
+	inter->r_bit_min = dc_fixpt_mul(params->r_bit_nominal, inter->r_bit_min);
+
+	inter->r_frl_char_min = dc_fixpt_div_int(inter->r_bit_min, 18);
+	inter->c_frl_line = dc_fixpt_mul(inter->t_line, inter->r_frl_char_min);
+	inter->c_frl_line = dc_fixpt_mul_int(inter->c_frl_line, params->lanes);
+
+	switch (params->audio_packet_type) {
+	case 0x02:
+		if (params->layout == 0)
+			inter->ap = dc_fixpt_div_int(dc_fixpt_from_int(25), 100);
+		else if (params->layout == 1)
+			inter->ap = dc_fixpt_from_int(1);
+		break;
+	case 0x08:
+		inter->ap = dc_fixpt_div_int(dc_fixpt_from_int(25), 100);
+		break;
+	case 0x09:
+		inter->ap = dc_fixpt_from_int(1);
+		break;
+	case 0x07:
+	case 0x0e:
+	case 0x0f:
+	case 0x0b:
+	case 0x0c:
+		/* Unsupported audio format */
+		return false;
+	default:
+		inter->ap = dc_fixpt_from_int(0);
+	}
+
+	inter->r_ap = dc_fixpt_max(audio_bw_reserve, dc_fixpt_mul(params->f_audio, inter->ap));
+	inter->r_ap = dc_fixpt_add(inter->r_ap, dc_fixpt_from_int(2 * ACR_RATE_MAX));
+	max_audio_tol_rate = dc_fixpt_div_int(dc_fixpt_from_int(TOLERANCE_AUDIO_CLOCK), 1000000);
+	max_audio_tol_rate = dc_fixpt_add(dc_fixpt_from_int(1), max_audio_tol_rate);
+	inter->r_ap = dc_fixpt_mul(inter->r_ap, max_audio_tol_rate);
+
+	inter->avg_audio_packets_line = dc_fixpt_mul(inter->r_ap, inter->t_line);
+	inter->avg_audio_packets_line = dc_fixpt_div_int(inter->avg_audio_packets_line, 1000000);
+	inter->audio_packets_line = dc_fixpt_ceil(inter->avg_audio_packets_line);
+
+	inter->blank_audio_min = 32 + 32 * inter->audio_packets_line;
+
+	params->borrow_params.audio_packets_line = inter->audio_packets_line;
+
+	return true;
+}
+
+bool frl_capacity_computations_uncompressed_video(struct frl_cap_chk_params_fixed31_32 *params,
+	struct frl_cap_chk_intermediates_fixed31_32 *inter)
+{
+	bool res;
+	int k_420;
+	struct fixed31_32 k_cd;
+	struct fixed31_32 c_frl_free;
+	int c_frl_free_int;
+	int c_frl_rc_margin;
+	struct fixed31_32 c_frl_rc_savings;
+	int c_frl_rc_savings_int;
+	int bpp;
+	struct fixed31_32 bytes_line;
+	int tb_active;
+	int tb_blank;
+	struct fixed31_32 f_tb_average;
+	struct fixed31_32 t_active_ref;
+	struct fixed31_32 t_blank_ref;
+	struct fixed31_32 t_active_min;
+	struct fixed31_32 t_blank_min;
+	int c_frl_actual_payload;
+	struct fixed31_32 utilization;
+
+	res = frl_capacity_computations_common(params, inter);
+	if (res != true)
+		return res;
+
+	k_420 = params->pixel_encoding == HDMI_FRL_PIXEL_ENCODING_420 ? 2 : 1;
+	if (params->pixel_encoding == HDMI_FRL_PIXEL_ENCODING_422)
+		k_cd = dc_fixpt_from_int(1);
+	else
+		k_cd = dc_fixpt_div_int(dc_fixpt_from_int(params->bpc), 8);
+
+	c_frl_free = dc_fixpt_div_int(dc_fixpt_mul_int(k_cd, params->h_blank), k_420);
+	c_frl_free = dc_fixpt_sub_int(c_frl_free, 32 * (1 + inter->audio_packets_line) + 7);
+	c_frl_free = dc_fixpt_max(c_frl_free, dc_fixpt_from_int(0));
+	c_frl_free_int = dc_fixpt_ceil(c_frl_free);
+	c_frl_rc_margin  = 4;
+	c_frl_rc_savings = dc_fixpt_mul_int(dc_fixpt_div_int(dc_fixpt_from_int(7), 8), c_frl_free_int);
+	c_frl_rc_savings = dc_fixpt_sub_int(c_frl_rc_savings, c_frl_rc_margin);
+	c_frl_rc_savings_int = dc_fixpt_floor(dc_fixpt_max(c_frl_rc_savings, dc_fixpt_from_int(0)));
+
+	bpp              = dc_fixpt_ceil(dc_fixpt_mul_int(dc_fixpt_div_int(k_cd, k_420), 24));
+	bytes_line       = dc_fixpt_div_int(dc_fixpt_from_int(bpp * params->h_active), 8);
+	tb_active        = dc_fixpt_ceil(dc_fixpt_div_int(bytes_line, 3));
+	tb_blank         = dc_fixpt_ceil(dc_fixpt_div_int(dc_fixpt_mul_int(k_cd, params->h_blank), k_420));
+
+	if (!(inter->blank_audio_min <= tb_blank)) {
+		return false;
+	}
+
+	f_tb_average = dc_fixpt_div_int(inter->f_pixel_clock_max, (params->h_active + params->h_blank));
+	f_tb_average = dc_fixpt_mul_int(f_tb_average, (tb_active + tb_blank));
+
+	t_active_ref = dc_fixpt_div(dc_fixpt_from_int(params->h_active), dc_fixpt_from_int(params->h_active + params->h_blank));
+	t_active_ref = dc_fixpt_mul(inter->t_line, t_active_ref);
+
+	t_blank_ref = dc_fixpt_div(dc_fixpt_from_int(params->h_blank), dc_fixpt_from_int(params->h_active + params->h_blank));
+	t_blank_ref = dc_fixpt_mul(inter->t_line, t_blank_ref);
+
+	t_active_min = dc_fixpt_sub(dc_fixpt_from_int(1), inter->overhead_max);
+	t_active_min = dc_fixpt_mul(t_active_min, inter->r_frl_char_min);
+	t_active_min = dc_fixpt_mul_int(t_active_min, params->lanes);
+	t_active_min = dc_fixpt_div_int(t_active_min, 1000);
+	t_blank_min = t_active_min;
+
+	t_active_min = dc_fixpt_div(dc_fixpt_mul_int(dc_fixpt_div(dc_fixpt_from_int(3), dc_fixpt_from_int(2)), tb_active), t_active_min);
+
+	t_blank_min = dc_fixpt_div(dc_fixpt_from_int(tb_blank), t_blank_min);
+
+	if (dc_fixpt_le(t_active_min, t_active_ref) && dc_fixpt_le(t_blank_min, t_blank_ref)) {
+		params->borrow_params.borrow_mode = FRL_BORROW_MODE_NONE;
+	} else if (dc_fixpt_lt(t_active_ref, t_active_min) && dc_fixpt_le(t_blank_min, t_blank_ref)) {
+		params->borrow_params.borrow_mode = FRL_BORROW_MODE_FROM_BLANK;
+	} else {
+		return false;
+	}
+
+
+	c_frl_actual_payload = dc_fixpt_ceil(dc_fixpt_mul_int(dc_fixpt_div(dc_fixpt_from_int(3), dc_fixpt_from_int(2)), tb_active)) + tb_blank - c_frl_rc_savings_int;
+
+	utilization = dc_fixpt_div(dc_fixpt_from_int(c_frl_actual_payload), inter->c_frl_line);
+	utilization = dc_fixpt_mul_int(utilization, 1000);
+
+	inter->margin = dc_fixpt_sub(dc_fixpt_from_int(1), dc_fixpt_add(utilization, inter->overhead_max));
+
+	if (dc_fixpt_lt(inter->margin, dc_fixpt_from_int(0)) && dc_fixpt_lt(dc_fixpt_from_fraction(1, 100), dc_fixpt_abs(inter->margin)))
+		return false;
+
+	return true;
+}
+
 static uint32_t dp_get_timing_bandwidth_kbps(
 	const struct dc_crtc_timing *timing,
 	const struct dc_link *link)
@@ -331,6 +521,86 @@ static bool dp_validate_mode_timing(
 		return false;
 }
 
+bool frl_validate_mode_timing(
+	struct dc_link *link,
+	const struct dc_crtc_timing *timing,
+	struct dc_hdmi_frl_link_settings *frl_link_settings)
+{
+	uint32_t req_bw;
+	uint32_t max_bw;
+	enum engine_id hpo_eng_id;
+	unsigned int i;
+	unsigned int hpo_frl_stream_enc_index = 0;
+	bool frl_output_valid = false;
+
+	if (!link)
+		return false;
+	if (!link->local_sink)
+		return false;
+
+	req_bw = dc_bandwidth_in_kbps_from_timing(timing, dc_link_get_highest_encoding_format(link));
+	max_bw = frl_link_bandwidth_kbps(frl_link_settings->frl_link_rate);
+
+	/* Use Engine ID to determine which hpo stream
+	 * encoder should be used.
+	 */
+	if (link->connector_signal == SIGNAL_TYPE_VIRTUAL)
+		frl_output_valid = true;
+	else {
+		struct audio_check audio_frl_check = {0};
+		struct audio_info audio_info = {0};
+		hpo_eng_id = ENGINE_ID_HPO_0;
+
+		for (i = 0; i < link->dc->res_pool->hpo_frl_stream_enc_count; i++) {
+			if (link->dc->res_pool->hpo_frl_stream_enc[i]->id == hpo_eng_id) {
+				hpo_frl_stream_enc_index = i;
+				break;
+			}
+		}
+		/*add audio check*/
+		for (i = 0; i < (link->local_sink->edid_caps.audio_mode_count); i++) {
+			audio_info.modes[i].channel_count = link->local_sink->edid_caps.audio_modes[i].channel_count;
+			audio_info.modes[i].format_code = link->local_sink->edid_caps.audio_modes[i].format_code;
+			audio_info.modes[i].sample_rates.all = link->local_sink->edid_caps.audio_modes[i].sample_rate;
+			audio_info.modes[i].sample_size = link->local_sink->edid_caps.audio_modes[i].sample_size;
+		}
+		audio_info.mode_count = link->local_sink->edid_caps.audio_mode_count;
+		get_audio_check(&audio_info, &audio_frl_check);
+
+		frl_output_valid =
+			link->dc->res_pool->hpo_frl_stream_enc[hpo_frl_stream_enc_index]->funcs->validate_hdmi_frl_output(
+				link->dc->res_pool->hpo_frl_stream_enc[hpo_frl_stream_enc_index],
+				timing, &audio_frl_check,
+				frl_link_settings,
+				link->local_sink->edid_caps.frl_dsc_max_frl_rate);
+	}
+
+	if (req_bw <= max_bw && frl_output_valid) {
+		/* remember the biggest mode here, during
+		 * initial link training (to get
+		 * verified_link_cap), LS sends event about
+		 * cannot train at reported cap to upper
+		 * layer and upper layer will re-enumerate modes.
+		 * this is not necessary if the lower
+		 * verified_link_cap is enough to drive
+		 * all the modes
+		 */
+
+		/* TODO: DYNAMIC_VALIDATION needs to be implemented */
+		/* if (flags.DYNAMIC_VALIDATION == 1)
+		 * dpsst->max_req_bw_for_verified_linkcap = dal_max(
+		 * dpsst->max_req_bw_for_verified_linkcap, req_bw);
+		 */
+		return true;
+	} else if (frl_output_valid && timing->dsc_cfg.is_frl) {
+		/* HDMI DSC calculation is validated within frl_output_valid
+		 * and req_bw may exceed max_bw
+		 */
+		return true;
+	} else
+		return false;
+}
+
 enum dc_status link_validate_mode_timing(
 		const struct dc_stream_state *stream,
 		struct dc_link *link,
@@ -345,6 +615,15 @@ enum dc_status link_validate_mode_timing(
 	if (link->remote_sinks[0] && link->remote_sinks[0]->sink_signal == SIGNAL_TYPE_VIRTUAL)
 		return DC_OK;
 
+	/* If DSC is supported, but native 422 DSC is not supported,
+	 * HDMI 2.1a specification requires that all 422 format be disabled (7.7.1)
+	*/
+	if (dc_is_hdmi_signal(stream->signal)) {
+		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422 && link->dc->config.no_native422_support) {
+			return DC_SURFACE_PIXEL_FORMAT_UNSUPPORTED;
+		}
+	}
+
 	/* Passive Dongle */
 	if (max_pix_clk != 0 && get_tmds_output_pixel_clock_100hz(timing) > max_pix_clk)
 		return DC_EXCEED_DONGLE_CAP;
@@ -362,6 +641,25 @@ enum dc_status link_validate_mode_timing(
 			return DC_NO_DP_LINK_BANDWIDTH;
 		break;
 
+	case SIGNAL_TYPE_HDMI_FRL:
+		{
+			uint32_t pxl_clk_mhz;
+			/* Limit pixel clock to DTBCLK Limit (Base Pix > 4 * DTBCLK) */
+			pxl_clk_mhz = (timing->pix_clk_100hz + 10000 - 1) / 10000 ;
+			if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
+				pxl_clk_mhz /= 2;
+			else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
+				pxl_clk_mhz = pxl_clk_mhz * 2 / 3;
+			if (pxl_clk_mhz > DTBCLK_LIMIT && link->ctx->dce_version < DCN_VERSION_3_1)
+				return DC_NO_HDMI_FRL_LINK_BANDWIDTH;
+		}
+
+		if (!frl_validate_mode_timing(
+				link,
+				timing,
+				hdmi_frl_get_verified_link_cap(link)))
+			return DC_NO_HDMI_FRL_LINK_BANDWIDTH;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.h b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
index 595774e76453..ccea329c556c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
@@ -26,6 +26,8 @@
 #define __LINK_VALIDATION_H__
 #include "link_service.h"
 
+#define TOLERANCE_AUDIO_CLOCK 1000
+
 enum dc_status link_validate_mode_timing(
 		const struct dc_stream_state *stream,
 		struct dc_link *link,
@@ -33,9 +35,20 @@ enum dc_status link_validate_mode_timing(
 enum dc_status link_validate_dp_tunnel_bandwidth(
 		const struct dc *dc,
 		const struct dc_state *new_ctx);
+bool frl_validate_mode_timing(
+		struct dc_link *link,
+		const struct dc_crtc_timing *timing,
+		struct dc_hdmi_frl_link_settings *frl_link_settings);
 uint32_t dp_link_bandwidth_kbps(
 	const struct dc_link *link,
 	const struct dc_link_settings *link_settings);
+uint32_t frl_link_bandwidth_kbps(enum hdmi_frl_link_rate link_rate);
+uint32_t link_timing_bandwidth_kbps(const struct dc_crtc_timing *timing);
+bool frl_capacity_computations_common(struct frl_cap_chk_params_fixed31_32 *params,
+	struct frl_cap_chk_intermediates_fixed31_32 *inter);
+bool frl_capacity_computations_uncompressed_video(
+	struct frl_cap_chk_params_fixed31_32 *params,
+	struct frl_cap_chk_intermediates_fixed31_32 *inter);
 
 
 uint32_t dp_required_hblank_size_bytes(
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index 70f854cca029..a596f1b02ec5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -31,6 +31,7 @@
  * link training.
  */
 #include "link_ddc.h"
+#include "link_hdmi_frl.h"
 #include "vector.h"
 #include "dce/dce_aux.h"
 #include "dal_asic_id.h"
@@ -546,6 +547,8 @@ void write_scdc_data(struct ddc_service *ddc_service,
 		(ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite ||
 		!ddc_service->link->local_sink->edid_caps.scdc_present))
 		return;
+	hdmi_frl_LTS_clear_Link_Setting(ddc_service);
+	hdmi_frl_LTS_clear_Update_flag(ddc_service);
 
 	link_query_ddc_data(ddc_service, slave_address, &offset,
 			sizeof(offset), &sink_version, sizeof(sink_version));
@@ -596,3 +599,90 @@ void read_scdc_data(struct ddc_service *ddc_service)
 				sizeof(status_data.byte));
 	}
 }
+void write_idcc_data(struct ddc_service *ddc_service, enum hdmi_idcc_scope idcc_scope,
+		uint8_t *write_buf, uint8_t offset, uint8_t write_len)
+{
+	uint8_t slave_address = HDMI_IDCC_ADDRESS;
+	uint8_t idcc_header[5] = {0};
+	uint8_t dummy_buf[1] = {0};
+	uint8_t checksum = 0;
+	int i;
+
+	idcc_header[0] = HDMI_IDCC_MARKER0;
+	idcc_header[1] = HDMI_IDCC_MARKER1;
+	idcc_header[2] = (uint8_t)(HDMI_IDCC_MARKER2 | idcc_scope);
+	idcc_header[3] = offset;
+	idcc_header[4] = write_len;
+
+	/* Write the IDCC header */
+	for (i = 0; i < sizeof(idcc_header); ++i) {
+		link_query_ddc_data(ddc_service, slave_address,
+				&idcc_header[i], 1,
+				&dummy_buf[0], 1);
+		checksum += idcc_header[i];
+	}
+
+	/* Write the payload */
+	for (i = 0; i < write_len; ++i) {
+		link_query_ddc_data(ddc_service, slave_address,
+				&write_buf[i], 1,
+				&dummy_buf[0], 1);
+		checksum += write_buf[i];
+	}
+
+	/* Write the checksum */
+	if (write_len > 0) {
+		checksum = 0xff - checksum + 1;
+		link_query_ddc_data(ddc_service, slave_address,
+			&checksum, 1,
+			&dummy_buf[0], 1);
+	}
+}
+
+int read_idcc_data(struct ddc_service *ddc_service, enum hdmi_idcc_scope idcc_scope,
+		uint8_t *read_buf, uint8_t offset, uint8_t read_len)
+{
+	uint8_t slave_address = HDMI_IDCC_ADDRESS;
+	uint8_t idcc_header[5] = {0};
+	uint8_t dummy_buf[1] = {0};
+	uint8_t read_buf_local[6] = {0};
+	uint8_t checksum = 0;
+	int i;
+
+	idcc_header[0] = HDMI_IDCC_MARKER0;
+	idcc_header[1] = HDMI_IDCC_MARKER1;
+	idcc_header[2] = (uint8_t)(HDMI_IDCC_MARKER2 | idcc_scope);
+	idcc_header[3] = offset;
+	idcc_header[4] = read_len;
+
+	/* Write the IDCC header */
+	for (i = 0; i < sizeof(idcc_header); ++i) {
+		link_query_ddc_data(ddc_service, slave_address,
+				&idcc_header[i], 1,
+				&dummy_buf[0], 1);
+		checksum += idcc_header[i];
+	}
+
+	/* Read the payload */
+	if (read_len > 0) {
+		dummy_buf[0] = 0x01;
+		if (read_len > 5)
+			read_len = 5;
+		link_query_ddc_data(ddc_service, slave_address,
+				&dummy_buf[0], 1,
+				&read_buf_local[0], read_len + 1);
+
+		memcpy(read_buf, read_buf_local, read_len);
+
+		/* Check checksum */
+		checksum = read_buf_local[read_len];
+		for (i = 0; i < 5; ++i)
+			checksum += idcc_header[i];
+		for (i = 0; i < read_len; ++i)
+			checksum += read_buf_local[i];
+		if (checksum != 0)
+			return -1;
+	}
+
+	return read_len;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
index d3e6f01a6a90..f2a80e12494b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
@@ -94,6 +94,10 @@ void write_scdc_data(
 void read_scdc_data(
 		struct ddc_service *ddc_service);
 
+void write_idcc_data(struct ddc_service *ddc_service, enum hdmi_idcc_scope idcc_scope,
+		uint8_t *write_buf, uint8_t offset, uint8_t write_len);
+int read_idcc_data(struct ddc_service *ddc_service, enum hdmi_idcc_scope idcc_scope,
+		uint8_t *read_buf, uint8_t offset, uint8_t read_len);
 void set_dongle_type(struct ddc_service *ddc,
 		enum display_dongle_type dongle_type);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
new file mode 100644
index 000000000000..6db1f07fdb79
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -0,0 +1,1147 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+ * Authors: AMD
+ *
+ */
+
+/* FILE POLICY AND INTENDED USAGE:
+ * This file implements FRL link capability and link training related functions.
+ * FRL link is established by order of retrieve_link, verify_link, and poll_status.
+ * Other helper functions exist to obtain information required to maintain
+ * the correct sequence according to HDMI specification. Each sequence and state
+ * inside link training functions are timing sensitive and order sensitive.
+ * It is mandatory that these functions are debugged with FRL_LTP output message
+ * configurable in DSAT.  Any changes in the LT sequence should follow the HDMI
+ * specification as much as possible and tested through HDMI electrical and
+ * link layer compliance.
+ */
+#include "link_hdmi_frl.h"
+#include "link_ddc.h"
+#include "link/link_dpms.h"
+#include "link/link_validation.h"
+#include "resource.h"
+#include "dccg.h"
+
+#include "dml/dml1_frl_cap_chk.h"
+
+#define DC_LOGGER \
+	dc_logger
+#define DC_LOGGER_INIT(logger) \
+	struct dal_logger *dc_logger = logger
+
+#define FRL_INFO(...) \
+	DC_LOG_HDMI_FRL_LTP(  \
+		__VA_ARGS__)
+
+static bool hdmi_frl_test_max_rate(struct ddc_service *ddc_service)
+{
+	uint8_t slave_address = HDMI_SCDC_ADDRESS;
+	uint8_t offset = HDMI_SCDC_SOURCE_TEST_REQ;
+	union hdmi_scdc_source_test_req test_req = {0};
+
+	DC_LOGGER_INIT(ddc_service->link->ctx->logger);
+
+	link_query_ddc_data(ddc_service, slave_address,
+					&offset, sizeof(offset), &test_req.byte,
+					sizeof(test_req.byte));
+	if (test_req.fields.FRL_MAX) {
+		FRL_INFO("FRL TEST REQ:  FRL_MAX = 1");
+		return true;
+	}
+
+	return false;
+}
+
+static void hdmi_return_preeshoot_and_deemphasis(struct dc_link *link,
+		union hdmi_scdc_source_test_req *test_req, bool *de_emphasis_only,
+		bool *pre_shoot_only, bool *no_ffe)
+{
+	/* check if cable_id is valid */
+	if (link->hdmi_cable_id.raw[0] && link->frl_link_settings.frl_link_rate >=
+		HDMI_FRL_LINK_RATE_16GBPS) {
+		*de_emphasis_only = (test_req->fields.TXFFE_DEEMPHASIS && link->hdmi_cable_id.bits.no_DeEmphasis_n) ||
+					!link->hdmi_cable_id.bits.no_PreShoot_n;
+		*pre_shoot_only = (test_req->fields.TXFFE_PRESHOOT && link->hdmi_cable_id.bits.no_PreShoot_n) ||
+					!link->hdmi_cable_id.bits.no_DeEmphasis_n;
+		*no_ffe = test_req->fields.TXFFE_NOFFE ||
+					(!link->hdmi_cable_id.bits.no_PreShoot_n &&
+					 !link->hdmi_cable_id.bits.no_DeEmphasis_n);
+	} else {
+		*de_emphasis_only = test_req->fields.TXFFE_DEEMPHASIS;
+		*pre_shoot_only = test_req->fields.TXFFE_PRESHOOT;
+		*no_ffe = test_req->fields.TXFFE_NOFFE;
+	}
+}
+
+enum clock_source_id hdmi_frl_find_matching_phypll(
+		struct dc_link *link)
+{
+	switch (link->link_enc->transmitter) {
+	case TRANSMITTER_UNIPHY_A:
+		return CLOCK_SOURCE_COMBO_PHY_PLL0;
+	case TRANSMITTER_UNIPHY_B:
+		return CLOCK_SOURCE_COMBO_PHY_PLL1;
+	case TRANSMITTER_UNIPHY_C:
+		return CLOCK_SOURCE_COMBO_PHY_PLL2;
+	case TRANSMITTER_UNIPHY_D:
+		return CLOCK_SOURCE_COMBO_PHY_PLL3;
+	case TRANSMITTER_UNIPHY_E:
+		return CLOCK_SOURCE_COMBO_PHY_PLL4;
+	case TRANSMITTER_UNIPHY_F:
+		return CLOCK_SOURCE_COMBO_PHY_PLL5;
+	default:
+		return CLOCK_SOURCE_ID_UNDEFINED;
+	};
+}
+
+void hdmi_frl_retrieve_link_cap(struct dc_link *link, struct dc_sink *sink)
+{
+	enum hdmi_frl_link_rate encoder_link_rate = HDMI_FRL_LINK_RATE_6GBPS_4LANE;
+
+	if (link->link_enc->features.flags.bits.IS_FRL_8G_CAPABLE)
+		encoder_link_rate = HDMI_FRL_LINK_RATE_8GBPS;
+
+	if (link->link_enc->features.flags.bits.IS_FRL_10G_CAPABLE)
+		encoder_link_rate = HDMI_FRL_LINK_RATE_10GBPS;
+
+	if (link->link_enc->features.flags.bits.IS_FRL_12G_CAPABLE)
+		encoder_link_rate = HDMI_FRL_LINK_RATE_12GBPS;
+
+	if (link->dc->debug.max_frl_rate != 0 && encoder_link_rate > link->dc->debug.max_frl_rate)
+		encoder_link_rate = link->dc->debug.max_frl_rate;
+
+	if (link->frl_flags.force_frl_rate != 0 &&
+			link->frl_flags.force_frl_rate != 0xF)
+		encoder_link_rate = link->frl_flags.force_frl_rate;
+
+	link->frl_reported_link_cap.frl_link_rate =
+			(encoder_link_rate < sink->edid_caps.max_frl_rate) ?
+					encoder_link_rate : sink->edid_caps.max_frl_rate;
+
+	if (sink->edid_caps.max_frl_rate < HDMI_FRL_LINK_RATE_6GBPS_4LANE)
+		link->frl_reported_link_cap.frl_num_lanes = 3;
+	else
+		link->frl_reported_link_cap.frl_num_lanes = 4;
+}
+
+struct dc_hdmi_frl_link_settings *hdmi_frl_get_verified_link_cap(
+		struct dc_link *link)
+{
+	// TODO: rework hdmi_frl_get_verified_link_cap to be a const interface
+	return &link->frl_verified_link_cap;
+}
+
+
+void hdmi_frl_LTS_clear_Update_flag(struct ddc_service *ddc_service)
+{
+	uint8_t slave_address = HDMI_SCDC_ADDRESS;
+	uint8_t offset = HDMI_SCDC_UPDATE_0;
+	uint8_t write_buffer[2] = { 0 };
+	union hdmi_scdc_update_read_data scdc_update = {0};
+	DC_LOGGER_INIT(ddc_service->link->ctx->logger);
+
+	/*Check FLT_update flag*/
+	link_query_ddc_data(ddc_service, slave_address,
+					&offset, sizeof(offset), &scdc_update.byte[0],
+					sizeof(scdc_update.byte[0]));
+
+	if (scdc_update.fields.FLT_UPDATE != 0) {
+		FRL_INFO("FRL LINK TRAINING:  LTS:L Clear FLT_UPDATE.\n");
+		write_buffer[0] = HDMI_SCDC_UPDATE_0;
+		/*FLT_update - bit 5*/
+		write_buffer[1] = (scdc_update.fields.FLT_UPDATE << 5);
+		link_query_ddc_data(ddc_service, slave_address,
+				write_buffer, sizeof(write_buffer), NULL, 0);
+	}
+}
+
+
+bool hdmi_frl_poll_status_flag(struct dc_link *link)
+{
+	uint8_t slave_address = HDMI_SCDC_ADDRESS;
+	uint8_t offset = 0;
+	uint32_t ln0_pattern = 0;
+	uint32_t ln1_pattern = 0;
+	uint32_t ln2_pattern = 0;
+	uint32_t ln3_pattern = 0;
+	uint8_t write_buffer[2] = {0};
+	union hdmi_scdc_update_read_data scdc_update = {0};
+	union hdmi_scdc_source_test_req test_req = {0};
+	union hdmi_scdc_LTP_req_data ltp_req = {0};
+	struct hpo_frl_link_encoder *hpo_frl_link_enc = link->hpo_frl_link_enc;
+	struct link_encoder *dio_link_enc = link->link_enc;
+	bool flt_no_timeout = false;
+	bool link_update = false;
+
+	/*Test Condition - FLT_no_timeout avoid link training*/
+	offset = HDMI_SCDC_SOURCE_TEST_REQ;
+	link_query_ddc_data(link->ddc, slave_address, &offset,
+			sizeof(offset), &test_req.byte, sizeof(test_req.byte));
+	if (test_req.fields.FLT_NO_TIMEOUT)
+		flt_no_timeout = true;
+
+	offset = HDMI_SCDC_UPDATE_0;
+
+	/*Check FLT_update flag*/
+	link_query_ddc_data(link->ddc, slave_address,
+					&offset, sizeof(offset), &scdc_update.byte[0],
+					sizeof(scdc_update.byte[0]));
+
+	if (scdc_update.fields.FRL_START == 1) {
+		write_buffer[0] = HDMI_SCDC_UPDATE_0;
+		/*FLT_START - bit 4*/
+		write_buffer[1] = (scdc_update.fields.FRL_START << 4);
+		link_query_ddc_data(link->ddc, slave_address,
+				write_buffer, sizeof(write_buffer), NULL, 0);
+	}
+	if (scdc_update.fields.FLT_UPDATE) {
+		offset = HDMI_SCDC_LTP_REQ;
+
+		link_query_ddc_data(link->ddc, slave_address,
+						&offset, sizeof(offset), ltp_req.byte,
+						sizeof(ltp_req.byte));
+
+		ln0_pattern = ltp_req.fields.LN0_LTP_REQ;
+		ln1_pattern = ltp_req.fields.LN1_LTP_REQ;
+		ln2_pattern = ltp_req.fields.LN2_LTP_REQ;
+		ln3_pattern = ltp_req.fields.LN3_LTP_REQ;
+
+		if (ln0_pattern == 0x03 || ln1_pattern == 0x03 ||
+				ln2_pattern == 0x03 || ln3_pattern == 0x03) {
+			if (flt_no_timeout) {
+				hpo_frl_link_enc->funcs->set_hdmi_training_pattern(
+					hpo_frl_link_enc,
+					ln0_pattern - 1,
+					ln1_pattern - 1,
+					ln2_pattern - 1,
+					ln3_pattern - 1);
+			} else
+				hpo_frl_link_enc->funcs->set_hdmi_training_pattern(
+					hpo_frl_link_enc,
+					(ln0_pattern == 0x03) ? 0xF : ln0_pattern - 1,
+					(ln1_pattern == 0x03) ? 0xF : ln1_pattern - 1,
+					(ln2_pattern == 0x03) ? 0xF : ln2_pattern - 1,
+					(ln3_pattern == 0x03) ? 0xF : ln3_pattern - 1);
+		} else
+			hpo_frl_link_enc->funcs->set_hdmi_training_pattern(
+				hpo_frl_link_enc,
+				ln0_pattern - 1,
+				ln1_pattern - 1,
+				ln2_pattern - 1,
+				ln3_pattern - 1);
+		if (ln0_pattern == 0x0E || ln1_pattern == 0x0E ||
+								ln2_pattern == 0x0E  || ln3_pattern == 0x0E) {
+			if (scdc_update.fields.FLT_UPDATE) {
+				if (link->dc->debug.limit_ffe == 0)
+					return false;
+
+				bool de_emphasis_only = false;
+				bool pre_shoot_only = false;
+				bool no_ffe = false;
+
+				hdmi_return_preeshoot_and_deemphasis(link, &test_req,
+					&de_emphasis_only, &pre_shoot_only, &no_ffe);
+
+				dio_link_enc->funcs->prog_eq_setting(dio_link_enc, 0xEE,
+						de_emphasis_only,
+						pre_shoot_only,
+						no_ffe,
+						&link->frl_link_settings);
+			}
+		} else
+			if (!flt_no_timeout) {
+				hdmi_frl_LTS_clear_Link_Setting(link->ddc);
+				hdmi_frl_LTS_clear_Update_flag(link->ddc);
+				hpo_frl_link_enc->funcs->set_hdmi_training_pattern(hpo_frl_link_enc, 0, 0, 0, 0);
+				hdmi_frl_perform_link_training_with_retries(link);
+				link_update = true;
+			}
+
+		write_buffer[0] = HDMI_SCDC_UPDATE_0;
+		/*Clear SCDC Update Flags*/
+		write_buffer[1] = (scdc_update.fields.FLT_UPDATE << 5);
+		link_query_ddc_data(link->ddc, slave_address,
+				write_buffer, sizeof(write_buffer), NULL, 0);
+	}
+	if (scdc_update.fields.SOURCE_TEST_UPDATE) {
+		offset = HDMI_SCDC_SOURCE_TEST_REQ;
+		bool de_emphasis_only = false;
+		bool pre_shoot_only = false;
+		bool no_ffe = false;
+
+		link_query_ddc_data(link->ddc, slave_address,
+						&offset, sizeof(offset), &test_req.byte,
+						sizeof(test_req.byte));
+
+		hdmi_return_preeshoot_and_deemphasis(link, &test_req,
+			&de_emphasis_only, &pre_shoot_only, &no_ffe);
+
+		dio_link_enc->funcs->prog_eq_setting(dio_link_enc, 0xFF,
+				de_emphasis_only,
+				pre_shoot_only,
+				no_ffe,
+				&link->frl_link_settings);
+
+
+		write_buffer[0] = HDMI_SCDC_UPDATE_0;
+		/*Clear SCDC Update Flags*/
+		write_buffer[1] = (scdc_update.fields.SOURCE_TEST_UPDATE << 3);
+		link_query_ddc_data(link->ddc, slave_address,
+				write_buffer, sizeof(write_buffer), NULL, 0);
+
+	}
+
+	return link_update;
+}
+
+void hdmi_frl_poll_start(struct ddc_service *ddc_service)
+{
+	uint8_t slave_address = HDMI_SCDC_ADDRESS;
+	uint8_t offset = HDMI_SCDC_UPDATE_0;
+	uint8_t write_buffer[2] = {0};
+	union hdmi_scdc_source_test_req test_req = {0};
+	union hdmi_scdc_update_read_data scdc_update = {0};
+	uint16_t num_polls = 100;
+	uint16_t wait_time = 2000;
+	bool flt_no_timeout = false;
+
+	DC_LOGGER_INIT(ddc_service->link->ctx->logger);
+
+	/*Test Condition - FLT_no_timeout avoid link training*/
+	offset = HDMI_SCDC_SOURCE_TEST_REQ;
+	link_query_ddc_data(ddc_service, slave_address, &offset,
+			sizeof(offset), &test_req.byte, sizeof(test_req.byte));
+	if (test_req.fields.FLT_NO_TIMEOUT)
+		flt_no_timeout = true;
+
+	/*Test Condition - No need to poll FRL_START if FLT_no_timeout*/
+	if (flt_no_timeout)
+		return;
+
+	offset = HDMI_SCDC_UPDATE_0;
+	/*LTS:P: Check FRL_START, poll for 200ms */
+	for (; num_polls; num_polls--) {
+		udelay(wait_time);
+		/*Check FLT_update flag*/
+		link_query_ddc_data(ddc_service, slave_address,
+						&offset, sizeof(offset), &scdc_update.byte[0],
+						sizeof(scdc_update.byte[0]));
+		FRL_INFO("FRL LINK TRAINING:  Read FRL_START = %d, FLT_UPDATE = %d.  num_polls = %d\n",
+				scdc_update.fields.FRL_START, scdc_update.fields.FLT_UPDATE, num_polls);
+		if (scdc_update.fields.FRL_START == 1) {
+			write_buffer[0] = HDMI_SCDC_UPDATE_0;
+			/*FLT_update - bit 5*/
+			write_buffer[1] = (scdc_update.fields.FRL_START << 4);
+			link_query_ddc_data(ddc_service, slave_address,
+					write_buffer, sizeof(write_buffer), NULL, 0);
+			break;
+		}
+		if (scdc_update.fields.FLT_UPDATE == 1) {
+			write_buffer[0] = HDMI_SCDC_UPDATE_0;
+				/*FLT_update - bit 5*/
+			write_buffer[1] = (scdc_update.fields.FLT_UPDATE << 5);
+			link_query_ddc_data(ddc_service, slave_address,
+					write_buffer, sizeof(write_buffer), NULL, 0);
+			break;
+		}
+	}
+	return;
+}
+
+void hdmi_frl_LTS_clear_Link_Setting(struct ddc_service *ddc_service)
+{
+	uint8_t slave_address = HDMI_SCDC_ADDRESS;
+	uint8_t offset = HDMI_SCDC_CONFIG_1;
+	uint8_t write_buffer[2] = { 0 };
+	union hdmi_scdc_configuration scdc_config = {0};
+	DC_LOGGER_INIT(ddc_service->link->ctx->logger);
+
+	/*Check FRL_Rate for fallback*/
+	link_query_ddc_data(ddc_service, slave_address,
+					&offset, sizeof(offset), &scdc_config.byte[1],
+					sizeof(scdc_config.byte[1]));
+	if (scdc_config.fields.FRL_RATE != 0) {
+		/*LTS:L FRL_Rate = 0*/
+		write_buffer[0] = HDMI_SCDC_CONFIG_1;
+		/*FRL_RATE*/
+		write_buffer[1] = 0;
+		link_query_ddc_data(ddc_service, slave_address,
+				write_buffer, sizeof(write_buffer), NULL, 0);
+		FRL_INFO("FRL LINK TRAINING: LTS:L - Clear FRL_Rate.\n");
+	}
+
+}
+
+static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_service,
+		struct dc_hdmi_frl_link_settings *link_settings)
+{
+	enum link_result result = LINK_RESULT_UNKNOWN;
+	uint8_t slave_address = HDMI_SCDC_ADDRESS;
+	uint8_t offset = HDMI_SCDC_STATUS_FLAGS;
+	uint32_t ln0_pattern = 0, pre_ln0_pattern = 0;
+	uint32_t ln1_pattern = 0, pre_ln1_pattern = 0;
+	uint32_t ln2_pattern = 0, pre_ln2_pattern = 0;
+	uint32_t ln3_pattern = 0, pre_ln3_pattern = 0;
+	uint8_t write_buffer[2] = {0};
+	union hdmi_scdc_update_read_data scdc_update = {0};
+	union hdmi_scdc_status_flags_data status_data = {0};
+	union hdmi_scdc_source_test_req test_req = {0};
+	union hdmi_scdc_LTP_req_data ltp_req = {0};
+	uint16_t num_polls = 0;
+	uint16_t max_polls = 105;
+	unsigned long long wait_time_ns = 2000000;
+	struct hpo_frl_link_encoder *hpo_frl_link_enc = ddc_service->link->hpo_frl_link_enc;
+	struct link_encoder *dio_link_enc = ddc_service->link->link_enc;
+	uint8_t sink_version = 0;
+	uint8_t FFE_Levels = (uint8_t)ddc_service->link->dc->debug.limit_ffe;
+	uint8_t current_FFE = 0;
+	bool override_FFE = false;
+	bool flt_no_timeout = false;
+	unsigned long long flt_poll_cur_time = 0, flt_poll_last_time = 0, flt_poll_elapsed_time_ns = 0;
+
+	DC_LOGGER_INIT(ddc_service->link->ctx->logger);
+	FRL_INFO("FRL LINK TRAINING:  Starting FRL Link Training.\n");
+
+	hdmi_frl_LTS_clear_Link_Setting(ddc_service);
+
+	offset = HDMI_SCDC_SINK_VERSION;
+	link_query_ddc_data(ddc_service, slave_address, &offset,
+			sizeof(offset), &sink_version, sizeof(sink_version));
+
+	FRL_INFO("FRL LINK TRAINING:  Read Sink Version = %d.\n", sink_version);
+
+	if (sink_version == 0) {
+		FRL_INFO("FRL LINK TRAINING: SKIP - FRL not supported by sink.\n");
+		return LINK_RESULT_FALLBACK;
+	}
+
+	if (sink_version == 1) {
+		/*Source Version = 1*/
+		write_buffer[0] = HDMI_SCDC_SOURCE_VERSION;
+		write_buffer[1] = 1;
+		link_query_ddc_data(ddc_service, slave_address,
+				write_buffer, sizeof(write_buffer), NULL, 0);
+		FRL_INFO("FRL LINK TRAINING:  Set Source Version = 1.\n");
+	}
+
+	FRL_INFO("FRL LINK TRAINING:  Poll for FLT_READY.\n");
+	offset = HDMI_SCDC_STATUS_FLAGS;
+
+	/*LTS:2: Check FLT Ready, poll for 200ms */
+	while (num_polls < max_polls) {
+		flt_poll_cur_time = dm_get_timestamp(ddc_service->ctx);
+		flt_poll_elapsed_time_ns = dm_get_elapse_time_in_ns(ddc_service->ctx, flt_poll_cur_time, flt_poll_last_time);
+		if (flt_poll_elapsed_time_ns < wait_time_ns)
+			continue;
+		flt_poll_last_time = dm_get_timestamp(ddc_service->ctx);
+		num_polls++;
+
+		link_query_ddc_data(ddc_service, slave_address,
+				&offset, sizeof(offset), &status_data.byte,
+				sizeof(status_data.byte));
+		FRL_INFO("FRL LINK TRAINING:  Read FLT_READY = %d.  num_polls = %d\n",
+				status_data.fields.FLT_READY, num_polls);
+		if (status_data.fields.FLT_READY) {
+			/* Spec recommends to clear update flag, but QD980 has problem */
+			hdmi_frl_LTS_clear_Update_flag(ddc_service);
+			dio_link_enc->funcs->prog_eq_setting(dio_link_enc, 0,
+					test_req.fields.TXFFE_DEEMPHASIS,
+					test_req.fields.TXFFE_PRESHOOT,
+					test_req.fields.TXFFE_NOFFE,
+					link_settings);
+			break;
+		}
+	}
+
+	/*Test Condition - FLT_no_timeout avoid link training*/
+	offset = HDMI_SCDC_SOURCE_TEST_REQ;
+	link_query_ddc_data(ddc_service, slave_address, &offset,
+			sizeof(offset), &test_req.byte, sizeof(test_req.byte));
+	FRL_INFO("FRL TEST REQ:  FLT_no_timeout = %d \n", test_req.fields.FLT_NO_TIMEOUT);
+	if (test_req.fields.FLT_NO_TIMEOUT)
+		flt_no_timeout = true;
+
+	if (status_data.fields.FLT_READY) {
+		/*Specify FRL rate*/
+		write_buffer[0] = HDMI_SCDC_CONFIG_1;
+		/*FRL_RATE*/
+		write_buffer[1] = (uint8_t)(link_settings->frl_link_rate | (FFE_Levels << 4));
+		link_query_ddc_data(ddc_service, slave_address,
+				write_buffer, sizeof(write_buffer), NULL, 0);
+		FRL_INFO("FRL LINK TRAINING:  Write link rate = %d.  Max FFE_Levels = %d\n",
+				link_settings->frl_link_rate, FFE_Levels);
+
+		FRL_INFO("FRL LINK TRAINING:  Poll for FLT_UPDATE.\n");
+		/*LTS:3: Start Link Training*/
+		/*Start FLT Timer = 200 ms*/
+		num_polls = 0;
+		if (flt_no_timeout)
+			max_polls = 500;
+
+		while (num_polls < max_polls) {
+			flt_poll_cur_time = dm_get_timestamp(ddc_service->ctx);
+			flt_poll_elapsed_time_ns = dm_get_elapse_time_in_ns(ddc_service->ctx, flt_poll_cur_time, flt_poll_last_time);
+			if (flt_poll_elapsed_time_ns < wait_time_ns)
+				continue;
+			flt_poll_last_time = flt_poll_cur_time;
+
+			num_polls++;
+
+			offset = HDMI_SCDC_UPDATE_0;
+			/*Check FLT_update flag*/
+			link_query_ddc_data(ddc_service, slave_address,
+							&offset, sizeof(offset), &scdc_update.byte[0],
+							sizeof(scdc_update.byte[0]));
+
+			FRL_INFO("FRL LINK TRAINING:  Read FLT_UPDATE = %d.  num_polls = %d\n",
+					scdc_update.fields.FLT_UPDATE, num_polls);
+			/*Set TxFFE = TxFFE0*/
+			/*Program FFE_Levels - scdc_config has this field at 0 */
+			if (override_FFE) {
+				if (flt_no_timeout)
+					current_FFE = 0;
+				if (current_FFE == 0)
+					dio_link_enc->funcs->prog_eq_setting(dio_link_enc, current_FFE,
+							test_req.fields.TXFFE_DEEMPHASIS,
+							test_req.fields.TXFFE_PRESHOOT,
+							test_req.fields.TXFFE_NOFFE,
+							link_settings);
+				else {
+					if (scdc_update.fields.FLT_UPDATE)
+						dio_link_enc->funcs->prog_eq_setting(dio_link_enc, current_FFE,
+								test_req.fields.TXFFE_DEEMPHASIS,
+								test_req.fields.TXFFE_PRESHOOT,
+								test_req.fields.TXFFE_NOFFE,
+								link_settings);
+				}
+				FRL_INFO("FRL LINK TRAINING:  TxFFE = %d.\n", current_FFE);
+				override_FFE = false;
+			}
+			if (scdc_update.fields.FLT_UPDATE) {
+				offset = HDMI_SCDC_LTP_REQ;
+				link_query_ddc_data(ddc_service, slave_address,
+								&offset, sizeof(offset), ltp_req.byte,
+								sizeof(ltp_req.byte));
+
+				pre_ln0_pattern = ln0_pattern;
+				pre_ln1_pattern = ln1_pattern;
+				pre_ln2_pattern = ln2_pattern;
+				pre_ln3_pattern = ln3_pattern;
+
+				ln0_pattern = ltp_req.fields.LN0_LTP_REQ;
+				ln1_pattern = ltp_req.fields.LN1_LTP_REQ;
+				ln2_pattern = ltp_req.fields.LN2_LTP_REQ;
+				ln3_pattern = ltp_req.fields.LN3_LTP_REQ;
+
+				FRL_INFO("FRL LINK TRAINING:  Read LN0_LTP_REQ = %d.  LN1_LTP_REQ = %d\n",
+						ltp_req.fields.LN0_LTP_REQ,
+						ltp_req.fields.LN1_LTP_REQ);
+				FRL_INFO("FRL LINK TRAINING:  Read LN2_LTP_REQ = %d.  LN3_LTP_REQ = %d\n",
+						ltp_req.fields.LN2_LTP_REQ,
+						ltp_req.fields.LN3_LTP_REQ);
+
+				/*Clear FLT_update flag*/
+				FRL_INFO("FRL LINK TRAINING:  Clear FLT_UPDATE flag.\n");
+				write_buffer[0] = HDMI_SCDC_UPDATE_0;
+				/*FLT_update - bit 5*/
+				write_buffer[1] = (scdc_update.fields.FLT_UPDATE << 5);
+				link_query_ddc_data(ddc_service, slave_address,
+						write_buffer, sizeof(write_buffer), NULL, 0);
+
+				if (ln0_pattern == 0x03 || ln1_pattern == 0x03 ||
+						ln2_pattern == 0x03 || ln3_pattern == 0x03)
+					if (!flt_no_timeout)
+						continue;
+
+				if (link_settings->frl_num_lanes == 3) {
+					ln3_pattern = 1;
+					if (!ln0_pattern && !ln1_pattern && !ln2_pattern) {
+						/*Link Training is done*/
+						FRL_INFO("FRL LINK TRAINING:  PASSED\n");
+						return LINK_RESULT_SUCCESS;
+					}
+					if (ln0_pattern == 0x0F || ln1_pattern == 0x0F || ln2_pattern == 0x0F) {
+						/*sink requesting to lower link rate*/
+						FRL_INFO("FRL LINK TRAINING:  Sink requesting lower link rate.\n");
+						return LINK_RESULT_LOWER_LINKRATE;
+					}
+					if (ln0_pattern == 0x0E || ln1_pattern == 0x0E || ln2_pattern == 0x0E) {
+						/*sink requesting to next FFE*/
+						FRL_INFO("FRL LINK TRAINING:  Sink requesting next FFE.\n");
+						if (ddc_service->link->dc->debug.limit_ffe == 0) {
+							return LINK_RESULT_LOWER_LINKRATE;
+						}
+						current_FFE++;
+						override_FFE = true;
+						if (current_FFE > 3)
+							current_FFE = 0;
+						if (flt_no_timeout)
+							current_FFE = 0;
+					}
+				} else {
+					if (!ln0_pattern && !ln1_pattern && !ln2_pattern && !ln3_pattern) {
+						/*Link Training is done*/
+						FRL_INFO("FRL LINK TRAINING:  PASSED\n");
+						return LINK_RESULT_SUCCESS;
+					}
+					if (ln0_pattern == 0x0F || ln1_pattern == 0x0F ||
+						ln2_pattern == 0x0F || ln3_pattern == 0x0F) {
+						/*sink requesting to lower link rate*/
+						FRL_INFO("FRL LINK TRAINING:  Sink requesting lower link rate.\n");
+						return LINK_RESULT_LOWER_LINKRATE;
+					}
+					if (ln0_pattern == 0x0E || ln1_pattern == 0x0E ||
+						ln2_pattern == 0x0E  || ln3_pattern == 0x0E) {
+						/*sink requesting to next FFE*/
+						FRL_INFO("FRL LINK TRAINING:  Sink requesting next FFE.\n");
+						if (ddc_service->link->dc->debug.limit_ffe == 0) {
+							return LINK_RESULT_LOWER_LINKRATE;
+						}
+						current_FFE++;
+						override_FFE = true;
+						if (current_FFE > 3)
+							current_FFE = 0;
+						if (flt_no_timeout)
+							current_FFE = 0;
+					}
+				}
+
+				if (override_FFE) {
+					ln0_pattern = pre_ln0_pattern;
+					ln1_pattern = pre_ln1_pattern;
+					ln2_pattern = pre_ln2_pattern;
+					ln3_pattern = pre_ln3_pattern;
+				}
+
+				FRL_INFO("FRL LINK TRAINING:  Setting Training Pattern [ln0,ln1,ln2,ln3] = [%d,%d,%d,%d].\n",
+						ln0_pattern, ln1_pattern, ln2_pattern, ln3_pattern);
+
+				hpo_frl_link_enc->funcs->set_hdmi_training_pattern(
+					hpo_frl_link_enc,
+					ln0_pattern - 1,
+					ln1_pattern - 1,
+					ln2_pattern - 1,
+					ln3_pattern - 1);
+				/* Workaround for DEDCN3AG-111
+				 * HDMI-FRL Incorrect Serialization Order for LTP4
+				 */
+			}
+
+		}
+		if (flt_no_timeout) {
+			return LINK_RESULT_SUCCESS;
+		} else {
+			FRL_INFO("FRL LINK TRAINING:  FAILED - Timeout waiting for FLT_UPDATE to be set by sink.\n");
+			write_buffer[0] = HDMI_SCDC_CONFIG_1;
+			/*FRL_RATE*/
+			write_buffer[1] = HDMI_FRL_LINK_RATE_DISABLE | (0 << 4);
+			link_query_ddc_data(ddc_service, slave_address,
+					write_buffer, sizeof(write_buffer), NULL, 0);
+			hdmi_frl_LTS_clear_Link_Setting(ddc_service);
+			result = LINK_RESULT_TIMEOUT;
+		}
+	} else {
+		FRL_INFO("FRL LINK TRAINING:  FAILED - FLT_READY not set by sink.\n");
+		result = LINK_RESULT_TIMEOUT;
+	}
+
+	return result;
+}
+
+enum link_result hdmi_frl_perform_link_training_with_retries(
+	struct dc_link *link)
+{
+	enum link_result status = LINK_RESULT_UNKNOWN;
+	unsigned int retry_count = 0;
+	unsigned int max_retries = 3;
+
+	DC_LOGGER_INIT(link->ctx->logger);
+
+	if (link->preferred_hdmi_frl_settings.valid)
+		max_retries = link->preferred_hdmi_frl_settings.max_retries;
+
+	/* FRL Link Training */
+	while (status != LINK_RESULT_FALLBACK) {
+		if (status == LINK_RESULT_SUCCESS) {
+			break;
+		} else if (status == LINK_RESULT_LOWER_LINKRATE) {
+			FRL_INFO("FRL LINK TRAINING:  Sink requested lower link rate during link enable. \n");
+			break;
+		} else {
+			if (retry_count > 0)
+				msleep(200);
+			status = hdmi_frl_perform_link_training(link->ddc,
+					&link->frl_link_settings);
+		};
+		retry_count++;
+		FRL_INFO("FRL LINK TRAINING: Retry count = %u out of %u\n", retry_count, max_retries);
+		if (retry_count > max_retries) {
+			status = LINK_RESULT_FALLBACK;
+			break;
+		}
+	}
+
+	return status;
+}
+
+enum link_result hdmi_frl_perform_link_training_with_fallback(
+	struct dc_link *link, struct link_resource *link_res,
+	enum clock_source_id frl_phy_clock_source_id)
+{
+	enum link_result status = LINK_RESULT_UNKNOWN;
+
+	DC_LOGGER_INIT(link->ctx->logger);
+
+	/* FRL Link Training */
+	while (status != LINK_RESULT_FALLBACK) {
+		if (link->frl_link_settings.frl_link_rate ==
+				HDMI_FRL_LINK_RATE_DISABLE) {
+			FRL_INFO("FRL LINK TRAINING:  Cannot Link Train.  Fall back to TMDS \n");
+			status = LINK_RESULT_FALLBACK;
+			break;
+		}
+
+		msleep(200);
+
+		link->ctx->dc->hwss.setup_hdmi_frl_link(link, 0,
+				frl_phy_clock_source_id);
+
+		status = hdmi_frl_perform_link_training(link->ddc,
+				&link->frl_link_settings);
+
+		link->dc->hwss.disable_link_output(link, link_res, SIGNAL_TYPE_HDMI_FRL);
+
+		if (status == LINK_RESULT_SUCCESS)
+			break;
+
+		link->frl_link_settings.frl_link_rate--;
+		if (link->frl_link_settings.frl_link_rate <
+				HDMI_FRL_LINK_RATE_6GBPS_4LANE)
+			link->frl_link_settings.frl_num_lanes = 3;
+	}
+
+	return status;
+}
+
+void hdmi_frl_verify_link_cap(struct dc_link *link,
+		struct dc_hdmi_frl_link_settings *known_limit_link_setting)
+{
+	struct dc_hdmi_frl_link_settings cur_link_setting = {0};
+	struct dc_hdmi_frl_link_settings *cur = &cur_link_setting;
+	bool success = false;
+	enum link_result status = LINK_RESULT_UNKNOWN;
+	enum clock_source_id frl_phy_clock_source_id;
+	unsigned int t_id = link->link_enc->transmitter;
+	struct link_resource link_res = {.hpo_frl_link_enc = link->hpo_frl_link_enc};
+	struct dc_stream_state *link_stream = NULL;
+	struct dc_stream_state *stream = NULL;
+	int i;
+
+	DC_LOGGER_INIT(link->ctx->logger);
+
+	link->frl_flags.force_frl_rate =
+			link->ctx->dc->debug.force_frl_rate;
+	link->frl_flags.force_frl_always =
+			link->preferred_hdmi_frl_settings.force_frl_always ||
+			link->ctx->dc->debug.force_frl_always;
+	link->frl_flags.force_frl_max =
+			link->preferred_hdmi_frl_settings.force_frl_max ||
+			link->ctx->dc->debug.force_frl_max ? true :
+			hdmi_frl_test_max_rate(link->ddc);
+	link->frl_flags.apply_vsdb_rcc_wa =
+			link->ctx->dc->debug.apply_vsdb_rcc_wa;
+
+	if (link->frl_flags.force_frl_rate == 0xF)
+		return;
+
+	if (link->local_sink &&
+		link->local_sink->edid_caps.panel_patch.force_frl)
+			link->frl_flags.force_frl_always = true;
+
+	if (!link->frl_flags.force_frl_max &&
+			link->local_sink->edid_caps.panel_patch.hdmi_comp_auto) {
+		link->frl_flags.force_frl_max = true;
+	}
+
+	if (link->local_sink &&
+		link->local_sink->edid_caps.panel_patch.vsdb_rcc_wa)
+			link->frl_flags.apply_vsdb_rcc_wa = true;
+
+	frl_phy_clock_source_id = hdmi_frl_find_matching_phypll(link);
+
+	cur_link_setting = *known_limit_link_setting;
+
+	if (link->frl_flags.force_frl_rate != 0) {
+		cur->frl_link_rate = (cur_link_setting.frl_link_rate <
+				link->frl_flags.force_frl_rate) ?
+						cur_link_setting.frl_link_rate :
+						link->frl_flags.force_frl_rate;
+		link->frl_verified_link_cap = *cur;
+		return;
+	}
+
+	if (link->local_sink) {
+		if (link->local_sink->edid_caps.panel_patch.hdmi_spe_handling) {
+			link->dc->hwss.disable_link_output(link, &link_res, link->connector_signal);
+			link->dc->res_pool->clock_sources[t_id]->funcs->cs_power_down(
+				link->dc->res_pool->clock_sources[t_id]);
+			link->frl_verified_link_cap = *cur;
+			return;
+		}
+		/* Monitor patch do decrease 10G to 8G*/
+		if (link->local_sink->edid_caps.panel_patch.block_10g) {
+			if (cur->frl_link_rate == HDMI_FRL_LINK_RATE_10GBPS)
+				cur->frl_link_rate--;
+		}
+	}
+
+	link->frl_link_settings = cur_link_setting;
+	/* disable PHY first for PNP */
+	if (link->dc->ctx->dce_version <= DCN_VERSION_3_0)
+		link->dc->hwss.disable_link_output(link, &link_res, SIGNAL_TYPE_HDMI_FRL);
+	else
+		link->dc->hwss.disable_link_output(link, &link_res, link->connector_signal);
+
+	link->dc->res_pool->clock_sources[t_id]->funcs->cs_power_down(
+			link->dc->res_pool->clock_sources[t_id]);
+	/*Either enable PHY ourselves or use VBIOS*/
+
+	FRL_INFO("FRL LINK TRAINING: Validation\n");
+
+	status = hdmi_frl_perform_link_training_with_fallback(link, &link_res, frl_phy_clock_source_id);
+
+	if (status == LINK_RESULT_SUCCESS) {
+		cur->frl_link_rate = link->frl_link_settings.frl_link_rate;
+		cur->frl_num_lanes = link->frl_link_settings.frl_num_lanes;
+		success = true;
+		link->frl_verified_link_cap = *cur;
+	}
+	if (!success) {
+		link->frl_verified_link_cap.frl_link_rate = HDMI_FRL_LINK_RATE_DISABLE;
+		link->frl_verified_link_cap.frl_num_lanes = 3;
+	}
+
+	for (i = 0; i < MAX_STREAMS; i++) {
+		stream = link->dc->current_state->streams[i];
+		if (stream && stream->link == link) {
+			link_stream = stream;
+			break;
+		}
+	}
+
+	if (link_stream) {
+		link->dc->hwss.disable_link_output(link, &link_res, link_stream->signal);
+	}
+}
+
+void hdmi_frl_set_preferred_link_settings(struct dc *dc,
+		struct dc_hdmi_frl_link_settings *link_setting,
+		struct dc_hdmi_frl_link_training_overrides *lt_overrides,
+		struct dc_link *link)
+{
+	int i;
+	struct pipe_ctx *pipe;
+	struct dc_stream_state *link_stream = 0;
+	struct pipe_ctx *link_pipe = 0;
+	struct pipe_ctx *odm_pipe;
+	int opp_cnt = 1;
+	enum link_result link_stat = LINK_RESULT_UNKNOWN;
+	enum clock_source_id frl_phy_clock_source_id;
+	struct dc_stream_state *temp_stream = &dc->scratch.temp_stream;
+
+	DC_LOGGER_INIT(link->ctx->logger);
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe->stream && pipe->stream->link) {
+			if (pipe->stream->link == link) {
+				link_stream = pipe->stream;
+				link_pipe = pipe;
+				break;
+			}
+		}
+	}
+
+	/* Stream not found */
+	if (i == MAX_PIPES)
+		return;
+
+	FRL_INFO("FRL LINK TRAINING:  Preferred link Update = %d.\n", link_setting->frl_link_rate);
+
+	frl_validate_mode_timing(link, &link_stream->timing, link_setting);
+
+	if (lt_overrides)
+		link->preferred_hdmi_frl_settings = *lt_overrides;
+	else
+		memset(&link->preferred_hdmi_frl_settings, 0, sizeof(link->preferred_hdmi_frl_settings));
+
+	link_stream->link->frl_link_settings = *link_setting;
+	link_stream->link->frl_verified_link_cap = *link_setting;
+
+	while (link_stat != LINK_RESULT_SUCCESS) {
+		link_set_dpms_off(pipe);
+		/* For DCN3.0, can also have 4:1 combine mode.
+		 * TODO: Add function get_odm_combine_mode that has different
+		 *       implementation for DCN2/DCN3AG and DCN3.0
+		 */
+		for (odm_pipe = pipe->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+			opp_cnt++;
+
+		memcpy(temp_stream, link_stream, sizeof(struct dc_stream_state));
+		/* Modify patched_crtc_timing as required for padding */
+		if (link_pipe->dsc_padding_params.dsc_hactive_padding) {
+			temp_stream->timing.h_addressable = link_stream->timing.h_addressable + link_pipe->dsc_padding_params.dsc_hactive_padding;
+			temp_stream->timing.h_total = link_stream->timing.h_total + link_pipe->dsc_padding_params.dsc_htotal_padding;
+		}
+
+		pipe->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_stream_attribute(
+			pipe->stream_res.hpo_frl_stream_enc,
+			&temp_stream->timing,
+			&link_stream->link->frl_link_settings.borrow_params,
+			opp_cnt);
+
+		if (pipe->stream_res.tg->funcs->set_out_mux)
+			pipe->stream_res.tg->funcs->set_out_mux(pipe->stream_res.tg, OUT_MUX_HPO_FRL);
+
+		if ((!link_stream->link->link_enc) ||
+				(!link_stream->link->hpo_frl_link_enc) ||
+				(!link_stream->ctx->dc->res_pool->dccg->funcs->enable_hdmicharclk) ||
+				(!(pipe->stream_res.hpo_frl_stream_enc)))
+			return;
+
+		switch (link_stream->link->frl_link_settings.frl_link_rate) {
+		case HDMI_FRL_LINK_RATE_3GBPS:
+			pipe->stream_res.pix_clk_params.requested_sym_clk = 166667;
+			break;
+		case HDMI_FRL_LINK_RATE_6GBPS:
+		case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+			pipe->stream_res.pix_clk_params.requested_sym_clk = 333333;
+			break;
+		case HDMI_FRL_LINK_RATE_8GBPS:
+			pipe->stream_res.pix_clk_params.requested_sym_clk = 444444;
+			break;
+		case HDMI_FRL_LINK_RATE_10GBPS:
+			pipe->stream_res.pix_clk_params.requested_sym_clk = 555555;
+			break;
+		case HDMI_FRL_LINK_RATE_12GBPS:
+			pipe->stream_res.pix_clk_params.requested_sym_clk = 666667;
+			break;
+		case HDMI_FRL_LINK_RATE_16GBPS:
+			pipe->stream_res.pix_clk_params.requested_sym_clk = 888889;
+			break;
+		case HDMI_FRL_LINK_RATE_20GBPS:
+			pipe->stream_res.pix_clk_params.requested_sym_clk = 1111111;
+			break;
+		case HDMI_FRL_LINK_RATE_24GBPS:
+			pipe->stream_res.pix_clk_params.requested_sym_clk = 1333333;
+			break;
+		default:
+			break;
+		}
+
+		link_stream->phy_pix_clk = pipe->stream_res.pix_clk_params.requested_sym_clk;
+
+		memset(&link_stream->link->cur_link_settings, 0,
+				sizeof(struct dc_link_settings));
+
+		/* Find proper clock source in HDMI FRL mode for phy used for DCCG */
+		frl_phy_clock_source_id = hdmi_frl_find_matching_phypll(link);
+
+		dc->hwss.setup_hdmi_frl_link(link,
+				(pipe->stream_res.hpo_frl_stream_enc->id - ENGINE_ID_HPO_0),
+				frl_phy_clock_source_id);
+
+		FRL_INFO("FRL LINK TRAINING:  Start forced link training at %d. \n",
+				link_stream->link->frl_link_settings.frl_link_rate);
+		link_stat = hdmi_frl_perform_link_training_with_retries(link_stream->link);
+
+		/* Enable FRL packet transmission */
+		if (link_stat == LINK_RESULT_SUCCESS) {
+			link_stream->link->hpo_frl_link_enc->funcs->enable_output(
+					link_stream->link->hpo_frl_link_enc);
+			if (link_stream->link->frl_flags.apply_vsdb_rcc_wa)
+				link_stream->link->hpo_frl_link_enc->funcs->apply_vsdb_rcc_wa(link_stream->link->hpo_frl_link_enc);
+			hdmi_frl_poll_start(link_stream->link->ddc);
+
+			/* Set HDMISTREAMCLK source to DTBCLK0 and bypass DTO */
+			if (dc->res_pool->dccg->funcs->set_hdmistreamclk) {
+				dc->res_pool->dccg->funcs->set_hdmistreamclk(
+						dc->res_pool->dccg,
+						DTBCLK0,
+						pipe->stream_res.tg->inst);
+			}
+
+			pipe->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_enable(
+				pipe->stream_res.hpo_frl_stream_enc,
+				pipe->stream_res.tg->inst);
+			resource_build_info_frame(pipe);
+			link_stream->ctx->dc->hwss.update_info_frame(pipe);
+
+			link_stream->ctx->dc->hwss.enable_audio_stream(pipe);
+			link_stream->ctx->dc->hwss.enable_stream(pipe);
+			link_stream->ctx->dc->hwss.unblank_stream(pipe,
+				&pipe->stream->link->cur_link_settings);
+			FRL_INFO("FRL LINK TRAINING:  Forced link training successful. \n");
+		}
+		if (link_stat == LINK_RESULT_LOWER_LINKRATE) {
+			link_stream->link->frl_link_settings.frl_link_rate--;
+			if (link_stream->link->frl_link_settings.frl_link_rate >
+				 HDMI_FRL_LINK_RATE_6GBPS)
+				link_stream->link->frl_link_settings.frl_num_lanes = 4;
+			else
+				link_stream->link->frl_link_settings.frl_num_lanes = 3;
+			FRL_INFO("FRL LINK TRAINING:  Lower link rate = %d.\n",
+				link_stream->link->frl_link_settings.frl_link_rate);
+		}
+		if (link_stat == LINK_RESULT_FALLBACK) {
+			FRL_INFO("FRL LINK TRAINING: Forced Link Training failed.  Fallback to TMDS. \n");
+			break;
+		}
+	}
+}
+
+static void update_borrow_mode_from_dsc_padding(struct dsc_padding_params *dsc_padding_params,
+	struct dc_crtc_timing *timing,
+	struct dc_hdmi_frl_link_settings *frl_link_settings)
+{
+	uint32_t h_active = timing->h_addressable + timing->h_border_left + timing->h_border_right;
+	uint32_t h_blank = timing->h_total - h_active;
+	struct frl_borrow_params *borrow_params = &frl_link_settings->borrow_params;
+
+	borrow_params->borrow_mode = frl_modify_borrow_mode_for_dsc_padding(timing->pix_clk_100hz,
+		h_active,
+		h_active + dsc_padding_params->dsc_hactive_padding,
+		h_blank,
+		h_blank + dsc_padding_params->dsc_htotal_padding,
+		borrow_params->hc_active_target,
+		borrow_params->hc_blank_target,
+		frl_link_settings->frl_num_lanes,
+		frl_link_settings->frl_link_rate);
+}
+
+void hdmi_frl_decide_link_settings(struct dc_stream_state *stream,
+	struct dc_hdmi_frl_link_settings *frl_link_settings,
+	struct dsc_padding_params *dsc_padding_params)
+{
+	bool success = false;
+	struct dc_hdmi_frl_link_settings temp_settings = {0};
+
+	temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_3GBPS;
+	temp_settings.frl_num_lanes = 3;
+
+	/* Verify FRL and fill in borrow_params to verified_link_cap*/
+	frl_validate_mode_timing(
+		stream->link,
+		&stream->timing,
+		&stream->link->frl_verified_link_cap);
+
+	if (stream->link->frl_flags.force_frl_rate != 0 &&
+		stream->link->frl_flags.force_frl_rate < stream->link->frl_verified_link_cap.frl_link_rate) {
+		switch (stream->link->frl_flags.force_frl_rate) {
+		case HDMI_FRL_LINK_RATE_3GBPS:
+			temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_3GBPS;
+			temp_settings.frl_num_lanes = 3;
+			break;
+		case HDMI_FRL_LINK_RATE_6GBPS:
+			temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_6GBPS;
+			temp_settings.frl_num_lanes = 3;
+			break;
+		case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+			temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_6GBPS;
+			temp_settings.frl_num_lanes = 4;
+			break;
+		case HDMI_FRL_LINK_RATE_8GBPS:
+			temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_8GBPS;
+			temp_settings.frl_num_lanes = 4;
+			break;
+		case HDMI_FRL_LINK_RATE_10GBPS:
+			temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_10GBPS;
+			temp_settings.frl_num_lanes = 4;
+			break;
+		case HDMI_FRL_LINK_RATE_12GBPS:
+			temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_12GBPS;
+			temp_settings.frl_num_lanes = 4;
+			break;
+		case HDMI_FRL_LINK_RATE_16GBPS:
+			temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_16GBPS;
+			temp_settings.frl_num_lanes = 4;
+			break;
+		case HDMI_FRL_LINK_RATE_20GBPS:
+			temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_20GBPS;
+			temp_settings.frl_num_lanes = 4;
+			break;
+		case HDMI_FRL_LINK_RATE_24GBPS:
+			temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_24GBPS;
+			temp_settings.frl_num_lanes = 4;
+			break;
+		default:
+			break;
+		}
+		*frl_link_settings = temp_settings;
+		return;
+	}
+	/*test equipment requires max rate, identified at FRL_Max = 1*/
+	if (stream->link->frl_flags.force_frl_max) {
+		*frl_link_settings = stream->link->frl_verified_link_cap;
+		return;
+	}
+
+	if (stream->link->local_sink)
+		if (stream->link->local_sink->edid_caps.panel_patch.hdmi_spe_handling) {
+			*frl_link_settings = stream->link->frl_verified_link_cap;
+			return;
+		}
+
+	do {
+		success = frl_validate_mode_timing(
+					stream->link,
+					&stream->timing,
+					&temp_settings);
+		if (temp_settings.frl_link_rate ==
+			 stream->link->frl_verified_link_cap.frl_link_rate)
+			break;
+		if (!success)
+			temp_settings.frl_link_rate++;
+		if (temp_settings.frl_link_rate > HDMI_FRL_LINK_RATE_6GBPS)
+			temp_settings.frl_num_lanes = 4;
+	} while (!success);
+
+	*frl_link_settings = temp_settings;
+}
+
+void hdmi_frl_write_read_request_enable(struct ddc_service *ddc_service)
+{
+	uint8_t slave_address = HDMI_SCDC_ADDRESS;
+	uint8_t offset = HDMI_SCDC_CONFIG_0;
+	uint8_t scdc_config = 0;
+	uint8_t write_buffer[2] = {0};
+
+	link_query_ddc_data(ddc_service, slave_address, &offset,
+			sizeof(offset), &scdc_config, sizeof(scdc_config));
+
+	write_buffer[0] = HDMI_SCDC_CONFIG_0;
+	write_buffer[1] = scdc_config;
+	write_buffer[1] |= 0x1;
+
+	link_query_ddc_data(ddc_service, slave_address, write_buffer,
+		sizeof(write_buffer), NULL, 0);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h
new file mode 100644
index 000000000000..abeec56c6528
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+ * Authors: AMD
+ *
+ */
+#ifndef __LINK_HDMI_FRL_H__
+#define __LINK_HDMI_FRL_H__
+#include "link_service.h"
+enum clock_source_id hdmi_frl_find_matching_phypll(
+		struct dc_link *link);
+void hdmi_frl_LTS_clear_Update_flag(struct ddc_service *ddc_service);
+void hdmi_frl_poll_start(struct ddc_service *ddc_service);
+void hdmi_frl_LTS_clear_Link_Setting(struct ddc_service *ddc_service);
+void hdmi_frl_retrieve_link_cap(struct dc_link *link, struct dc_sink *sink);
+enum link_result hdmi_frl_perform_link_training_with_retries(
+	struct dc_link *link);
+enum link_result hdmi_frl_perform_link_training_with_fallback(
+	struct dc_link *link, struct link_resource *link_res,
+	enum clock_source_id frl_phy_clock_source_id);
+void hdmi_frl_verify_link_cap(struct dc_link *link,
+		struct dc_hdmi_frl_link_settings *known_limit_link_setting);
+void hdmi_frl_decide_link_settings(struct dc_stream_state *stream,
+	struct dc_hdmi_frl_link_settings *frl_link_settings,
+	struct dsc_padding_params *dsc_paddding_params);
+bool hdmi_frl_poll_status_flag(struct dc_link *link);
+struct dc_hdmi_frl_link_settings *hdmi_frl_get_verified_link_cap(
+		struct dc_link *link);
+void hdmi_frl_set_preferred_link_settings(struct dc *dc,
+		struct dc_hdmi_frl_link_settings *link_setting,
+		struct dc_hdmi_frl_link_training_overrides *lt_overrides,
+		struct dc_link *link);
+void hdmi_frl_write_read_request_enable(
+		struct ddc_service *ddc_service);
+#endif /* __LINK_HDMI_FRL_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
index b157d05b67ad..cfb5ef0523a7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
@@ -80,6 +80,7 @@ bool program_hpd_filter(const struct dc_link *link)
 	case SIGNAL_TYPE_DVI_SINGLE_LINK:
 	case SIGNAL_TYPE_DVI_DUAL_LINK:
 	case SIGNAL_TYPE_HDMI_TYPE_A:
+	case SIGNAL_TYPE_HDMI_FRL:
 		/* Program hpd filter */
 		delay_on_connect_in_ms = 500;
 		delay_on_disconnect_in_ms = 100;
-- 
2.54.0

