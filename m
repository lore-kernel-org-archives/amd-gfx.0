Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C294ACD3439
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 15:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5053810F1D9;
	Thu,  7 May 2026 15:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lKn8MDoE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D1510F1D9
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 15:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMDl1wonjYJnO4TA6NFgbsyj3d+rE1BJLE9A0/H/sJ7LLKMFvA61q2xNha34UIrAT2qxJUN5DRe3XyBvd2i7/ph6e7b/ceYK5Vl0ras1PrHGygdsrEFmjOX+q0SMsJpxnXxdA4bDVPz/cKR/Kv37wVGkNmFhIKkkcj0cuMxtGZkGB+8Y95UwSg3H1ryziVicdhOzk2IukSZUA5i8UitlzQLgOnveMnpc8iFVGbfAIuMJsJcIbEV7AsoSBvZhOcZm5S0IG7luHQIfc9m8EffalLH45y95Cr4UU2K9FDYrTTIAoT6Bs0brJshpHuz4Kxpul7uoduO+BE5UA3f2nglkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNB+CV2ipL1E1PPeIp6Jo9/xXqiz9OoEnPpKvBzhDdU=;
 b=k9u+PQhhVfs3kAbeCr6Nm3kSQLIE5T4a/CoLulFqs7vhsfQOdpMqxQK5w5e2jS1zT5qQnOPuyjPP+Z0FVIABvtCkPnjwbtaOhCtTe5tSrXJVBOuC2YI9NOhGlh+Yvf0vgSELB0ePANQ8mRO8Sk0Qih0ucxFUYovZgXMTmCbxdUJX9yJVuUJeE7I21FYx2n2n9Cx+xacbQI1Ml1lp9B2t9ja9Gx/iOPZKIXKnimCtUZQeB8SrlQHcgPRhMoU//EZ3VPzJOFentPx2Gq0+CCVXhr6SuMrXcB/JzV6VXchkCMvLYHF2H6FQ5GDRCHYlESwTq/FelSpwQxS98vVoii4+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNB+CV2ipL1E1PPeIp6Jo9/xXqiz9OoEnPpKvBzhDdU=;
 b=lKn8MDoE6ZwvQ7Guu7EpivEuVTdXt6XvZI1VcHeAhBAAOlhUF4yPeAEIZffJGkdfg0huWahP6RMLCMWbCR+e8M+FDmd/bKoEU/aWMjiRQr/dhGiL5SSjLNvklJLuRkSgSn3ggqCpdAnxzrXy5I1OUWVFsdLBrAt0KG79CR6kiLk=
Received: from SJ0PR03CA0372.namprd03.prod.outlook.com (2603:10b6:a03:3a1::17)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:52:10 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::1a) by SJ0PR03CA0372.outlook.office365.com
 (2603:10b6:a03:3a1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 15:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:52:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 7 May
 2026 10:51:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 May
 2026 10:51:58 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 10:51:58 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 14/22] drm/amd/display: Add FRL support to clk_mgr, dsc,
 hdcp
Date: Thu, 7 May 2026 11:51:36 -0400
Message-ID: <20260507155147.182540-15-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507155147.182540-1-harry.wentland@amd.com>
References: <20260507155147.182540-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: de6be9cd-fc9e-484e-2b88-08deac509984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003|20052099010;
X-Microsoft-Antispam-Message-Info: bW4q2xv3EMtYETdKUzmS29iauMV7hynlUNevkQAFiBNhNYd64Q/BWuDPeVzN+SgFPYBDVbZcGhOh8IOgjkMprrpv8SrEIx2K/x+QQsxqUJ3txtVqPDFbOwB4P+1TUP3+Ixef9m7jbkw8VC92fKISWvHWSxekSMuQHkpxGwK5AkoJpVaeLxMJtJdIcUT7qOUk34EPX8VVgXy7N+lZazZCKv7pgbmwIcCqJkG8Xpu5WaCQGWv6ODWY0XwkU+K4NPWT/BUXRrLIHqgZrvRWZVGZYsFYpqacFSO/xGaKxktoFHnjMN45/tGASEQjKiDx0ragKEuZynTnA+G/kuxaroDBW9UW2L24f+ZHffaMuFYFeX6orH16ll+A6lbvyZZurEhXGXqXmH0baoEvFTFf2TWan06pbOWvsuNr8slPCmS+SXEB2m6Ipva/keXmlOPYPlJbCWqeGyQQJnRAx7SFYAaCPVpYK5xP5tAPCY9YA1rRZIgcNqG8KOda9CUEdpMHQUXQnG2AvwehyQzPMWzvFFPL1eowXn9gWyd/ypfy3AkT2FK4BgUBvEbzhOie2TZqavymKSLVL/gfwEpREFmJy7gt7DTNLZ1bLjN+dRX62S03kRJgsYw5XKKjsHjgioQnsQ3Pi44EE8u7To9zpqHf2v9J4e2UoYJyoNOG7E5Ol01fUGTu+oGXE0GtKUbUTQZOJC0NiCDaDRMaQRpGeVVB2KjRNpFA+i4zjII0eQeKol8dLXo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LZcqdC5H4yX7+E/dw2fPXBn0b/6hFlsS8asL7m7S6hpC8A6ZuFcydcmw9/DI6VM46eS1aWuLEz96G6/VxskE/EOb5nX9ZiLNtmgnBc30vaMdEIA744gfQYj/h370a7W6RIELzspeFwqGIo5FzIJ2MC2sIYykXHZNTy1a6YhGMBq37pNhBs/xv6DSoFf3nE3PBgtGbxDEVQWZ57ww7IvQOrQtopAlPCdg1OZ9N1hJo2ErqKGkemllW7OZmS1Y9Xeinfi9IySgL/lUM+WwVFLdQ3jd1wGeoQvHD4C3Udl0fYslnHVjdSk0xTGR2PRtnycy4WNIJBHHEY26qWikJQ4CiFwczTrW2loHx+oPHp+grNt+7Taqw6DuQYxC/quXvXM1Y0a/N8PIzT7pg1yotBmZJbDON+YI27pBGtP7J6HW9Tr/tiYLjQRh02OFMRnWmznC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:52:10.5013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de6be9cd-fc9e-484e-2b88-08deac509984
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172
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

