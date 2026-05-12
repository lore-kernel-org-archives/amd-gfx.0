Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F27CD4F3F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 15:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216EB10E294;
	Tue, 12 May 2026 15:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mq/R+nBL";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD25410EB4D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 15:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyXmmDvMjWjTIA8yTQzNLe9O/S72qwgfNcnNkvW0Ks/Xw05vtPKKPzBAhrR0HZ+FdIzqKCVKPR/WGPO0pxMUQSMX6t6KLx/P/wxyiPaTGhaqbVsMDmdmXqN85AjnNTeOvwu9U3Sspg3dRNMiEETaite6oHmM9LwIHAZJ8uL6rMcDhTi0xjWe0Jo/K9w09MOKn8vCyXgQtLteMz6Yo9VPwixAy52aam2RCzW2BnSnQIIM4rvSdfEGB0lgMFIoHtVBK5qcV/xPt+cBWSED65VUiIGCTWThm9X30GExUvpByGC3zm74tK56fFRR/JLUyi2YBQgVYelqso48TywV7oHEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmTjkatHi+Q+hKPV83wEbU26QM1Rt4Ib+itqrHjcTt8=;
 b=VHl3/4n8upYGRJSAJq5TbbQfLbKY4bglGA4AezvELJ4UHa0rdERMIV7x0lcjxGa9XTsyVA1yi3jF/Mn36rhQ7MU1PVAKKwMIYGs6aV8XHqLpZjXtNwykg3FNxB+hGqZvxj+MgMbzfE7QB7V3ZJqTRvrbePjjki1A407c3TBoGdIrsJV7ywxPKdfIpMitnr21h716CY2o1e/1oiZVw5UIN2c9/sAXbgWXzX10oCLCYgbWDycM1f7+tJtehmjRR3nLm3cAL8fsJKf/WoEodRUb7GA/8Ii5DzA/QI7IHe76Y2YB4uSWPRmXX0MRBtqDqncOY4DZNq9SuG4vIsDNqC7sHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmTjkatHi+Q+hKPV83wEbU26QM1Rt4Ib+itqrHjcTt8=;
 b=Mq/R+nBLgmZGbHVrsd7q3QtpOKBGGKOyMEJiKhXgr1srDb5LfcmxWuOH1U08ZGwfSR1ihgL9ofOkVjWI9pMMMGXxPHUyIGz+VaruuJW7WyAjTPOxWzpAF+StV+y5bW38ezf9zI4W42+kj9eQYev5RkX/g9gHZNGH2KT1xI39ftw=
Received: from MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:52:53 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::1d) by MN2PR20CA0043.outlook.office365.com
 (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 15:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 15:52:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 10:52:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 08:52:50 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 10:52:49 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v5 05/13] drm/amd/display: Add FRL support to clk_mgr, dsc,
 hdcp
Date: Tue, 12 May 2026 11:52:36 -0400
Message-ID: <20260512155244.403854-6-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512155244.403854-1-harry.wentland@amd.com>
References: <20260512155244.403854-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: e330fd87-eb49-4ca0-712b-08deb03e85a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|20052099010|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: wVsTG7GzGyOO4WDJWtRXL0qwdODXU7Xt7NNw/gPE+F20MslYcTwKGLssDBkJyK3TB1LX8HlKYNdULgxyCOQkV7ishfJbgg5rLjWr599BlbNpyuAXG3i+oKDKlCx9NlkzItXXbE08LVtMPKM5E1dbC+N7srJ5GDQTQpkqBg4lIdD3frMeiQUcS/Knn4pE6Tppj826NTl1ESbSpZdVu/46l+zPTXWahFsjRxvhxquDWVCbXj7v8J5mTAkxZTQYOVQYXgAUhdyezXptki0+H40sxPexOgrN7H/rf6aUfPN7GAtlT/sKAsDzoi5yW0qsG1kYoI5x/ovh0Pn0JeOBrm1gDE5+gOIN2TxnaoL/8ZxGp9DA/e80goYxN78KEpeW9jRsmqoUf/rrkotcUWsiC3ZpwzPMeNr1TigbSbDZcuAbkBSXqlT0qxew93ZG9Fk9pCgiQqdH7iLqc+wgQkjhXgaiW1uCNYutyJ++eS1OaVDgwRRaJdm85oGfZn7OC+2rDXbVI0p2i75RDm1sgteiJRQzR+Cuzi1G1+eI9PQveNV8OIDjXl6uzEaD6OPgKKpmVDG67D2XFMz5m92S/ptJt26dHEaIu5X2XtjjANP4Up1Rlg72le6pdYhv5t8q/0geu5HjjYwv98DGh8ML8lXTFQKaYZzRHav4vX+txWuD/OiJSd0zKCTdSbAgLVg4BHfRVlqtBWPSABLe389UuCSDRDbfRIqc0MUx+xca8Tnv71pTkVw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(20052099010)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mcRsunVR/ZUX+G9BGxYsXttrw3x07LSiROaI2g/1ywiXVD5K4fdnopcHTxbqpN1L1GZ9Edi7/j4szob3Xt+NqNlydj02zMom7ecsXnJdt3NI70xMM+YDPTi4jNvabFi5mI2vBM3hhv3X2EjLCTL0JqmocM9aoj7G+eCnaWtYEf+PmpYJsGDl2k7V4r2gmleLaDWGWr7T4iZ6AKREcCJ3DeCw8uJhwZZsl68GsLvWSdd9NZeKey+p1N1E7wp3pxZ2wGnMti5KpjTcp+Z1GtTbSF2FGppIgxkzyrDalL2NzzHRfz5LoIbKTpp0DhhLHKptQT3CkvHrCusKRBwNxQeChBPrilvn+796eRs79PnfZRGOOKenDMkRyzdRJsN2Si2VdHbEPoZwUHhzoIMDrCV2IDCmw8fBDht9S8GSJtIw2TJgjGE2bJGkstPNMUK22QEs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:52:50.9619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e330fd87-eb49-4ca0-712b-08deb03e85a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529
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
Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
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
index dc7f50095a13..00c4be7c3aa4 100644
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
index 5fe59adc862f..dd6f11ecb9c9 100644
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
index b6f26475ac16..75d39cb26dba 100644
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
index 72a38f7a761c..c7fecbdfda2c 100644
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
index 2dc244d5a55f..be0e3836a6c1 100644
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
index 6c6848e375e1..103013e2a0de 100644
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
index 7c2b716d5d2a..5f9398745a38 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -542,6 +542,7 @@ static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr
 		ASSERT(otg_master->stream_res.pix_clk_params.controller_id >= CONTROLLER_ID_D0);
 
 		use_hpo_encoder = dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(otg_master);
+		use_hpo_encoder |= dc_is_hdmi_frl_signal(otg_master->stream->signal);
 		if (!use_hpo_encoder)
 			continue;
 
@@ -1095,6 +1096,9 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
 	bool update_dispclk = false;
 	bool update_dppclk = false;
 	bool dppclk_lowered = false;
+	struct pipe_ctx *otg_master;
+	bool frl_present = false;
+	unsigned int i;
 
 	unsigned int num_steps = 0;
 
@@ -1127,6 +1131,20 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
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

