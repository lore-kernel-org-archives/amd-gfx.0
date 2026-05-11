Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40764CD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 15:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC76610E7E6;
	Mon, 11 May 2026 15:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="414KHXui";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448CE10E7FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 15:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHthN7Vfx4c4j4F/z9xgo+5vlyZRHV9+S2aXIItPpFjbZUOiJP9BhbAFrxGDdQJGCtOh5BouI+jACykFA3amMzyxyUGCWbSgbhVNcuFSlEQRpLNLbK098uxvsMPvF3r4u3yPu5AatHKQxzjpAIg33/+xCKbXQmo4yALJzqNOp51wOrsYf6mp2bVroyLJhy+rS8wSa7I8wjVYqZTNmFFXHE2fXYU6gWYG8O2OvsREwu2/9JgmjCJ/Uwp7Sq0zv8OcvtvUsHZDQgYoHuQoYCF5I3sj3r0c6TRL31Pc5aCDgbB08ZjRX04mZ0qvm6TMXRLC0kyGWS46bZdsAzGpo1BSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNB+CV2ipL1E1PPeIp6Jo9/xXqiz9OoEnPpKvBzhDdU=;
 b=swYwcG3wC+G7+d43s3T4TVFVMjeBRW6pldCfsp5JwXGPpurqP3VqyxOGa/OmAKtW5sc3x55hvnw6MgbY7joATxtIj16JThJlKuFLzrA8TSsL/8nS4uiBJ7S/Io9yUOTFo8ocu6yJ7iSnd3lmAx2b5uQTMsAVERx2ZV/VIHo7MZIYbDgKxmrT/atLAKfJOJvFA7GFz6jePunJkl1pWvUgx1fts4F5g72vLOvZDG0nioomlHnlmSM1FfgiCgDL+afbkr0jf3pvsMDtUdOAMcRkrlPORetnlnvCgJkWSvAoq0xX8bf0xW4Rs4v3pAu+7cns9Owk1UcBHEMlwgV0GFi6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNB+CV2ipL1E1PPeIp6Jo9/xXqiz9OoEnPpKvBzhDdU=;
 b=414KHXui44z7Z0KSnkxWobcf3uX0Ly6yotg+I+8hIfaW1DxiOyWZdZyLs5bP4/MFHtRWUHUOMhIbidSArGk7ggsooWh/pvTgrc5Yjt5pXBPmu4TA6nIfXwpFc/1mAA4vNU4UoOxmr+1nxjAbYnKSlrAH3Vq45xQd/Ztd/VR54Fs=
Received: from MW4PR04CA0255.namprd04.prod.outlook.com (2603:10b6:303:88::20)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:52:26 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::b8) by MW4PR04CA0255.outlook.office365.com
 (2603:10b6:303:88::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 15:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 15:52:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Mon, 11 May
 2026 10:52:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 May
 2026 10:52:21 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 10:52:20 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jerry.Zuo@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH RESEND v3 05/14] drm/amd/display: Add FRL support to clk_mgr,
 dsc, hdcp
Date: Mon, 11 May 2026 11:52:02 -0400
Message-ID: <20260511155212.73586-6-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511155212.73586-1-harry.wentland@amd.com>
References: <20260511155212.73586-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd1ce1b-3b55-4185-3118-08deaf754c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|11063799003|20052099010|56012099003;
X-Microsoft-Antispam-Message-Info: 3JLVE9sU+7MzHwVX9MM/BSPVa+/2MU4aBqAwV8twNR/h7OUDfQpWgyZRP3qV5xS3K62IWw2SwhfsqJtjY0vPtJfXMHN2jjK/Qtxl62oxD1BiT0I/E1w8u48XkLds5avWcI0rdLVSJSwtLV59wQrmkFV128ouEeJRfNR8hjRWokHxrq3AHodd2Asr06ixAbanrlMZNk01G1is9JLIYwWAKLkmDX/Dga7YcJN/4zxhy+Sc13GDkS6pXPWJCpuo8oOrRmwjxTvyercfL4FMHvwo2ur+WNBKHzU3ZkrOPlI+DoxJwHqem5tMScsjLkzwx34cvSxED6bSsv5T4FoLeeGVe6z7wZbL87i/2F5dlYe+lq6rUaSzUHM0le3jPkG1UZt3ZnowSXy0+gJ3OFuOLl+5Zc2xT5h9qyhYI4vaqYNiCK8GZWFjA1pZ/U0y69I3I7fxpQIFh/VjRp7ZZZ276CiADy9rJKx86M3On9CbKkNLIc5abUK6hSx7yjlgq7WgxspeiEUEqMHUxTI2UTUUantQmxDARxiP2FhIJ5R56wSpBMjGXknaYbP3EzymAufUmA3KxJAjHwCY7nGcKKABFj0Nr4sLMRGCmtnCcTLJc3eF2NEU7H1jMFczq/42TTcooDlKoE//AAWvFcCnH/KIq3QaWXae6prJJ+OlDwe9OOK7zIOgaNEQhUIVvihf7tp2hcFXWqA9WMcqMMLcE8EVvFFiEVZ9yVa5wiau0WUoIHndpz8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(11063799003)(20052099010)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VMKtJ/F1REkkX3nDf1Iv1/qVzxuIYvrn8WJaionmqmFkTQbmr8Z9Nc56nulgvXyv5l5pXOtB2RncNtM4sUpshX6ubL0fJlEOVeE+qy7TYNgz3/bonSOsXH6u1/lX8Qm2tnLL5UdOQMQ87KWjfHLgpfdWgk/v76vYPpgex3Y+4SCckcqcXddvPxDo4guzw/4yta4RWCVaxvOUSguKyn1C0Efdsp2gPdI1r/ORDh7s5/Naj7nZwDvZ6A5fxuIMaEMqCW9qB1kHefdSrdV+4IdlS7mvZLjvWNqQX1zWHFp76NvIcBS3+mpkvlsz7t41HVKvDruBajY/1pVEL6qAoa+jHuwPV1DKGrcT9bUX9616SG+rS2PWUDX8kUG3ABluXuTOQ6HQYZrqsjGvFcsqAlT8+Bf7xj1eTDMmL27WwjmOv+CnoiLHVdcn9NojBf1wh4pT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:52:25.3953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd1ce1b-3b55-4185-3118-08deaf754c07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
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

This adds a few, relatively minor, changes for FRL to
clk_mgr, DSC, and HDCP blocks.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |  3 +++
 .../display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |  3 +++
 .../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |  3 +++
 .../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |  3 +++
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   | 12 ++++++++++++
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 14 ++++++++++++++
 .../display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h       |  5 +++++
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c |  1 +
 9 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 68a121dbb489..e88355c15bfa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -93,6 +93,9 @@ static int dcn31_get_active_display_cnt_wa(
 		if (dc_is_dp_signal(stream->signal) && !stream->dpms_off)
 			display_count++;
 
+		/* FRL can't be tracked by DIG enablement */
+		if (dc_is_hdmi_frl_signal(stream->signal))
+			display_count++;
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 0d5892266112..21ab94b09c10 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -127,6 +127,9 @@ static int dcn314_get_active_display_cnt_wa(
 		if (dc_is_dp_signal(stream->signal) && !stream->dpms_off)
 			display_count++;
 
+		/* FRL can't be tracked by DIG enablement */
+		if (dc_is_hdmi_frl_signal(stream->signal))
+			display_count++;
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index ef184f28e426..b88e5ebe66ad 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -69,6 +69,9 @@ static int dcn315_get_active_display_cnt_wa(
 				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
 				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
 			tmds_present = true;
+		/* FRL can't be tracked by DIG enablement */
+		if (dc_is_hdmi_frl_signal(stream->signal))
+			display_count++;
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index aa8f2a5edc21..a591cb45f4fa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -81,6 +81,9 @@ static int dcn316_get_active_display_cnt_wa(
 				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
 				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
 			tmds_present = true;
+		/* FRL can't be tracked by DIG enablement */
+		if (dc_is_hdmi_frl_signal(stream->signal))
+			display_count++;
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 8773a8321735..68d86b949c03 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -283,6 +283,18 @@ static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
 			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
 
+			if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) ||
+					dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+				dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+
+				if (pipe_ctx->stream_res.audio != NULL)
+					dto_params.req_audio_dtbclk_khz = 24000;
+			}
+
+			if (dc_is_hdmi_signal(pipe_ctx->stream->signal) ||
+					dc_is_dvi_signal(pipe_ctx->stream->signal))
+				dto_params.is_hdmi = true;
+
 			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
 			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index ddcde2433211..85dcfa67fe17 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -232,6 +232,8 @@ void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context
 		if (old_pipe->stream && new_pipe->stream && old_pipe->stream == new_pipe->stream) {
 			has_active_hpo =  dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(old_pipe) &&
 			dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(new_pipe);
+				has_active_hpo = has_active_hpo || (old_pipe->stream->signal == SIGNAL_TYPE_HDMI_FRL &&
+				new_pipe->stream->signal == SIGNAL_TYPE_HDMI_FRL);
 
 		}
 
@@ -271,6 +273,18 @@ static void dcn35_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
 			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
 
+			if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) ||
+					dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+				dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+
+				if (pipe_ctx->stream_res.audio != NULL)
+					dto_params.req_audio_dtbclk_khz = 24000;
+			}
+
+			if (dc_is_hdmi_signal(pipe_ctx->stream->signal) ||
+					dc_is_dvi_signal(pipe_ctx->stream->signal))
+				dto_params.is_hdmi = true;
+
 			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
 			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 2b7718336135..860215e0f191 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -542,6 +542,7 @@ static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr
 		ASSERT(otg_master->stream_res.pix_clk_params.controller_id >= CONTROLLER_ID_D0);
 
 		use_hpo_encoder = dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(otg_master);
+		use_hpo_encoder |= dc_is_hdmi_frl_signal(otg_master->stream->signal);
 		if (!use_hpo_encoder)
 			continue;
 
@@ -1092,6 +1093,9 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
 	bool update_dispclk = false;
 	bool update_dppclk = false;
 	bool dppclk_lowered = false;
+	struct pipe_ctx *otg_master;
+	bool frl_present = false;
+	unsigned int i;
 
 	unsigned int num_steps = 0;
 
@@ -1124,6 +1128,20 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
 		/* DCCG requires KHz precision for DTBCLK */
 		block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_DTBCLK;
 		block_sequence[num_steps].params.update_hardmin_params.freq_mhz = (uint16_t)khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz);
+		for (i = 0; i < context->stream_count; i++) {
+			otg_master = resource_get_otg_master_for_stream(
+					&context->res_ctx, context->streams[i]);
+			if (otg_master != NULL &&
+					otg_master->stream != NULL &&
+					dc_is_hdmi_frl_signal(otg_master->stream->signal)) {
+				 frl_present = true;
+				 break;
+			}
+		}
+		if (frl_present)
+			block_sequence[num_steps].params.update_hardmin_params.freq_mhz =
+				(uint16_t)clk_mgr_base->bw_params->clk_table.entries[
+					clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels - 1].dtbclk_mhz;
 		block_sequence[num_steps].params.update_hardmin_params.response = &clk_mgr_base->clks.ref_dtbclk_khz;
 		block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
 		num_steps++;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
index a16c60d8532f..ab37a7eaaf01 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
@@ -102,6 +102,11 @@ struct dsc_enc_caps {
 	int32_t max_total_throughput_mps; /* Maximum total throughput with all the slices combined */
 	int32_t max_slice_width;
 	uint32_t bpp_increment_div; /* bpp increment divisor, e.g. if 16, it's 1/16th of a bit */
+	bool is_frl;
+	bool is_vic_all_bpp;
+	uint32_t total_chunk_kbytes;
+	uint32_t num_lanes;
+	uint32_t frl_rate;
 	uint32_t edp_sink_max_bits_per_pixel;
 	bool is_dp;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 73a1e6a03719..34fc9f56dbef 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -365,6 +365,7 @@ static const struct protection_properties *get_protection_properties_by_signal(
 		case SIGNAL_TYPE_DVI_SINGLE_LINK:
 		case SIGNAL_TYPE_DVI_DUAL_LINK:
 		case SIGNAL_TYPE_HDMI_TYPE_A:
+		case SIGNAL_TYPE_HDMI_FRL:
 			return &hdmi_14_protection; //todo version2.2
 		case SIGNAL_TYPE_DISPLAY_PORT:
 		case SIGNAL_TYPE_DISPLAY_PORT_MST:
-- 
2.54.0

