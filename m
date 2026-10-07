Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5ECCA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAADB10F6D6;
	Wed,  7 Oct 2026 17:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0KbkUvtF";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D44B10F6FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLvBGtJvgWA+6n1fcgr8nYugn2NEkrUjCIPlk6TsNyhYSOpcFeQG3LP8ZftStd6K1KqEyTyBxdgYi/hYkAo5HmnVO5xUirK/bHLNdQbvqBLAHluGwRVSZrkXiEuo+P9W6dXRAC3cTUn5TkMbKD7vVW+fVCJRVtv0vKLGohQh2qs4klNqY40VvU9vOJIMOGbTuAEmQ3DySBExIFvMyGvJxRwyBmwHTEy+WWdqEFQAx1Pz5knv5O0G+UrWTCdGGtIKA+gSVn1V6qa/vCaOUUPTSqRev6LKF6pICxEF+8sOBH1B7pc9Yx1+D9CBc5N4P94eVDAhoOepGdmDb1C4qdlaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfNmwDoHwr0nQQkxzycZeQEtgzmayZ4EKa1eZUsWBk8=;
 b=V//0BlRB0ZTuk3scay+WcEYSEuHDl1Lt7+WwhmKFa+Uu2ylRFMoeZB+zPYUlhis91RGjwBceR6iv84ccUvZ17xE4SjQ0of46pHG5CFqWH5VSi4VbKLWrTGaZqTWjLyQWqYSKBchxl8qdJq/Oxp+gLSiGllufW3H0JFnc01b7UkC0znP/1f5OIl8aA+3+/l/vRXNHUTnCn3gGlJywWaNfeuJ3H6dsSrK5Vwc9BimfWZEc9U9QXqzy01RDM5+Ulx0gaumabNd79JBV2m8tomUvTHiMU+Jw4XaxEcmfdw/Sa+EhIuK7rZWd+W0Od7+olaINDcq8lrcBDE4t6yZLbbcTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfNmwDoHwr0nQQkxzycZeQEtgzmayZ4EKa1eZUsWBk8=;
 b=0KbkUvtFeWlyLtonr/Q+qGpBunZTDKvddqedMcyD13C9RlKXOSffTnZkU0WfBl7sg4V2UIgFrnskDm80OXMFFypz1uxl+3JEASri85ftavr5PI8ILzzRN3IaEV6Hqkb8xqmGaDhGum4oP/DEqfaHBGrFwvz3b4EXvjJCb6NWjko=
Received: from SJ0PR03CA0072.namprd03.prod.outlook.com (2603:10b6:a03:331::17)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:04:41 +0000
Received: from MW1PEPF00018893.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::1c) by SJ0PR03CA0072.outlook.office365.com
 (2603:10b6:a03:331::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018893.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:33 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:32 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Shen <george.shen@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 15/19] drm/amd/display: Program DSC prior to OTG enable
 starting DCN60
Date: Wed, 7 Oct 2026 12:59:48 -0400
Message-ID: <20261007170412.1898315-16-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018893:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4177b0-e1b3-405f-437c-08df249511de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JQAhYqMoAK8sIu4yw6Vz3BYsauB7CMs6hgcms9MY/1EIusB+lsnFsQo6Pcxb4yqUVnwLMdrfObcwKKqzrF4dGFKLrvHKshyGzHTPnqkEf4fu6wNvh5lXoKk2EcyJHX15LcImE7EIhdWKNQOCxhYl/8by5F6Gos8/n6nTksJDOdKKOEupU9kbRGozKjOAYfxQQxR/velBazdhJVZT1ZumGbWOLYUqeT4kIb4uFOGKf/OE7UGTZH2m5BD7Fges259+vAWbn2Y9UeLDrMkeW7AfgfgjAtlW5kpkWmhV+QX5fsHisJYJUfDREDPIXygEzYVWqKxxUhIsJObMNXYLXQinPek3PoYxZzGBk/z5s0DwLq4Gr5Hlz7XU5jkOl2xW0Jk3D+d8WMV2w/hj3hMBH3/ewQqvoJBER2xwrHo1+scyeCd/xmpUEr2shEP6Syg5W61fMgLFi4QRGS6nin8kx9P6H4Q2l8wuPDQMO9ZOJI6aLn+L4Oy94FHEpK5XUndvZdWu/CbmjMp8ElPyhddXcMC7FoFbBx1qdfRgeYsNYqQchhes0hAPtPr3w8oqdKbkycDeJ7p1EPTbqDuj7+zkwSPOXThb/eGmCkz0/ZmTAC3rCRnYCVQ7wNTMFdo+Bp+9CYzbmLyJ+nNkATTDHIu11B1BBfHBAqW9ksPORz4C0XUrbQZIUnMgudedm1RZIEPFTktzVtGWILh78ePNHRpXlnCDTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aiq8TTW3nF8H09nd38/KY/P7osrWHcun4Ur6YcYH2xXFNXoNhINfskIylX0yBuCKiYRGY2TdUnHWF7Og7Nwgc+URgj0ImH65JrqT17bQD351Eae75Mey5vbT11BOquOeONkEKLgEjskkv9fhXNXQXR8gBzsnT3byMt9miyEfyE7rJMX2HGRGlkcGlCMmUiTShfvLjnyOWRe9Og40yg8VjH52iroyAcddYmKCO+9lFLKUH6wLqDqwdDvwxuhvDf8mVpl0hRxG3lDQMr+jztkhyvnMGLAepzfdeSJYriXzZPvUEBM5ckIwhucKIQn2ytGc/ABmSeWdBIYBcm3AQElkLXH69vQ7IYrVehhDBdRGEKAFdmdgcMTJlR9z2AOCOoJOI8dEBYqQUigBevVOg/4B6yd2qsYoDVHcT3hxlDqrvsHAda6fOjUiC6ac6FZrHg+l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:37.7554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4177b0-e1b3-405f-437c-08df249511de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231
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

From: George Shen <george.shen@amd.com>

[Why]
Current DSC enable sequence is intertwined with the DPMS on sequence.
The sequence has become unnecessarily confusing, and resulted in cases
where DSC is programmed unexpectedly, or in an incorrect sequence.

Current sequence enables OTG before DSC. After discussing with HW team,
there should be no issue with enabling DSC first before OTG.

[How]
Starting with DCN60, skip DSC HW programming in the DPMS sequences.

Add enable DSC function call prior to OTG enable, and similarly for the
disable case.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 18 ++++++++++++++++++
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  2 ++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 19 ++++++++++++++-----
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index d237061236af..a843e216a6b0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -818,6 +818,15 @@ enum dc_status dcn401_enable_stream_timing(
 
 	hws->funcs.blank_pixel_data(dc, pipe_ctx, true);
 
+	/* Legacy code path will enable DSC during DPMS on sequence. Since DSC
+	 * HW block programming is independent from link and stream encoder operations, it
+	 * has moved to hwss and should be called when enabling/disabling OTG.
+	 */
+	if (stream->timing.flags.DSC && pipe_ctx->stream_res.dsc) {
+		if (dc->hwss.configure_dsc)
+			dc->hwss.configure_dsc(pipe_ctx, true);
+	}
+
 	/* VTG is  within DCHUB command block. DCFCLK is always on */
 	if (false == pipe_ctx->stream_res.tg->funcs->enable_crtc(pipe_ctx->stream_res.tg)) {
 		BREAK_TO_DEBUGGER();
@@ -2116,6 +2125,15 @@ void dcn401_reset_back_end_for_pipe(
 
 			pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
+			/* Legacy code path will enable DSC during DPMS on sequence. Since DSC
+			 * HW block programming is independent from backend operations, it
+			 * has moved to hwss and should be called when enabling/disabling OTG.
+			 */
+			if (pipe_ctx->stream_res.dsc) {
+				if (dc->hwss.configure_dsc)
+					dc->hwss.configure_dsc(pipe_ctx, false);
+			}
+
 			pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
 		}
 		if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index e2dddbc170f8..c5fab430b7f7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -125,6 +125,7 @@ bool dcn60_configure_dsc(struct pipe_ctx *pipe_ctx, bool enable)
 			enum optc_dsc_mode mode = dsc_optc_cfg.is_pixel_format_444 ?
 					OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
 
+			DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
 			pipe_ctx->stream_res.tg->funcs->set_dsc_config(
 					pipe_ctx->stream_res.tg, mode,
 					dsc_optc_cfg.bytes_per_pixel, dsc_optc_cfg.slice_width);
@@ -132,6 +133,7 @@ bool dcn60_configure_dsc(struct pipe_ctx *pipe_ctx, bool enable)
 		return true;
 	}
 
+	DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
 	pipe_ctx->stream_res.tg->funcs->set_dsc_config(
 			pipe_ctx->stream_res.tg, OPTC_DSC_DISABLED, 0, 0);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index ef577e0e5215..42a47d12d1f3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -914,6 +914,7 @@ static bool configure_dsc_hw_block(struct pipe_ctx *pipe_ctx, bool enable,
  */
 void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dsc_config dsc_cfg = {0};
 	struct dsc_optc_config dsc_optc_cfg = {0};
 
@@ -922,12 +923,20 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		return;
 	}
 
-	if (enable) {
-		if (configure_dsc_hw_block(pipe_ctx, true, &dsc_cfg, &dsc_optc_cfg))
-			set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, true);
-	} else {
+	if (dc->hwss.configure_dsc) {
+		/* If the hwss configure_dsc function is supported, then DSC will be programmed
+		 * in the same sequence of OTG enable/disable. Thus, we don't need to configure
+		 * the DSC hw block here.
+		 */
 		set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, false);
-		configure_dsc_hw_block(pipe_ctx, false, &dsc_cfg, &dsc_optc_cfg);
+	} else {
+		if (enable) {
+			if (configure_dsc_hw_block(pipe_ctx, true, &dsc_cfg, &dsc_optc_cfg))
+				set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, true);
+		} else {
+			set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, false);
+			configure_dsc_hw_block(pipe_ctx, false, &dsc_cfg, &dsc_optc_cfg);
+		}
 	}
 }
 
-- 
2.43.0

