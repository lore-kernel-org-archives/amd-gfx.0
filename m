Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0EB606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OWOKv4MF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E92F10F95D;
	Wed, 21 Oct 2026 06:27:26 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FC510F95A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhu0eUQ99wNRPFLfLBZPaDnrwMY6vKy6rOo5MmixrOi7K0vWIBAOjVLF4swYMYtKA5XGVoWs7Zr88SunNVVEuYtUcanbIaB1JEL/6qTnMXU5dN1sBhS3CmOnpxcTNvEXwCjYrILuSL8Q0uHLNDmeS1JTSck1iV5PaQTjOYGKIOHC8Yhsq5INX/5UAEW/0GsIjS3cCyDk9uQgbrf7pjeUO2v2V+Qreud/mKd1/0HEKofvwhr7wVPkpq2LpZ9Ogk4xw0I1GWJYgRkkjw2mZroUyjBIFRMJpaXzIRxVpkcNxtyZPCjE0VfEd5GXrxhvxBN94Q1jkonYKxrw5DxX6ORvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY79zhAsanNMaEhZdKzVq0P0/c7+21BxKXpzyZ3vPRc=;
 b=aNLfHgWUVnjPIKojR/aiQ2FVGwvT+uv8Tl6sFeRC5mkmvz8OIVI7HM3Gj+6CQnKmZMcBsQvkT0moROzm4ohBNJX5s1U1+u2eAfE4F61n2tzD9wgSXdcpEKpc5SHSXnNCagmstuul6E2p5xXGnC/Ap0CvVzkRiWE7Ek3VhFNuswNYmvD8j1wNvebuIZSeeNXqNj0O0qazz0iEvYXG4jlkOXevuU1TI7vlxQfFKQGgsyDUV1bhyCRk8rYRqhxXWe1olKqeGVAZ9LjuDQvQ+5PBmLQDV1iF42P8BhTYM56wiWdB+HYr8Zl27/3rHKuzlTTtqWnSoXdkzMQUm/E1ojh8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY79zhAsanNMaEhZdKzVq0P0/c7+21BxKXpzyZ3vPRc=;
 b=OWOKv4MFCdTZouT65cdtNZgszbmH+9/eNuZgcKHaso7Ioa1QnoWeKQEHYnMdsG0PMjJK92StZJD8QINzVI3jWJbU7RtRv4yRTsj6EV60r7YOYCJ/IouAlzcoR+IJkKGCK94CcBWtn/H0NJBmZu5uLA4ie84Cn3SmtjZnV6BYNMY=
Received: from BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:27:15 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::2a) by BY3PR05CA0033.outlook.office365.com
 (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 06:27:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:14 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:10 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Samson Tam <Samson.Tam@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 30/49] drm/amd/display: Revert "Program DSC prior to OTG
 enable starting DCN60"
Date: Wed, 21 Oct 2026 14:22:36 +0800
Message-ID: <20261021062519.674697-31-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eceefdd-5e90-4cac-e2b7-08df2f3c591b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1qbUNn6sDyTfCTtwPc7vuP6fkO/rFKRsISp0j5WerzG/S7VwRIcfkIFpO2ASOw1pghFeJSmVeg/yu7qzghr8J1m2spft/PoYe1QHxPpgxB/P/RKS7laz63rKZyOKOSuipVdxQKPzW0EtAxPidu3Pox5D3fdHvFW9LXxTF/Tbr1xqOp8ZafFEcP59n8WzSK0wV7x1fnl3mgG5ppRV1/GmUo4+1I1Lx3pw78rp5z8zsqDRAzVsv1deBfSqVygSY/KtZDXzbOkFZgUYfslx8fIaNhf/hKWPbvi0Y1USCzb4zoZ3gljBK3LxDILm/hFKEuTxekajdU69yLXsTT77M4YRYjMvUeVx6PnGjChAAMoUbDrfR/ChCyGSPLUpxBcWa0ldKkEUedQ2U4bE34oJC+cntNsMGSc/ly0b82rM/ALxEE7L/Ex7tRVXvqSTg36BIg+VFtLL5l+wwU91ulaKPiJnhX+AvZ/7K+r9gguOVeyDUOc1dXQjfV8LtVo+kB7VokwzGdNuzHABy2WCb/a42ZRUm3fo8ioMYW/MBW+X5QEP3zJPBqTMJfVph1w1nsajC8D07ZQNXr/PW6MQZx2uhtU1/qIho3RMRRRW7/lUcOM2zk1eauFzFjwbq4Ecw3hNB6qAiVxGXT7NnrnxRnsinqdZuHJZtk18HbPJr8cY9Qq8EQps8koLwJmUU5//rMAEEkJBvBjzJJDA1XAlXIKq77tNDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GHmdYnNsXHCje6nS8GDe47fX4OiHl5OuTDrqL3xPR5LbmvW/tkoqMrH1CCHIiQbDm7X+CihJPDkCwt4ps94wgVO/T+zBVeg11pGVTR9WKEw2xZWq6FvA28YVvNfWa3tMvvV6NRG3+OcdcfG5Bt0BXXNUVm6Rxmt9iT4pfZYZwJZgBOHAuUdOnVBQLFo1GY6hEhxjUZZKbS/xMMyegHw5CtlmvAGeiEh2yh8YOfQ55BCb8kSieOIIVMrGLVjSCSs2WX2i18YTklo9MWaH/WMQZB3giNcUJcDx1A8OwXCzGeoCwiw9K7UfivA03YZBf7QZcnMxDjrVYjwJDA5oWTd2+o0nCAWMRWk9dPRxhvlQGyPlY7kFA1KP/d8H5YMbLAN2LtKL+UqbGl3XnPUXfNyZ3kShzEzNl0UUgS5PTzqczv3PsJ9qWYplHf8KxIPLeA43
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:14.8781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eceefdd-5e90-4cac-e2b7-08df2f3c591b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Samson Tam <Samson.Tam@amd.com>

This reverts commit 408c920be21f ("drm/amd/display: Program DSC prior
to OTG enable starting DCN60").

Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 18 ------------------
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  2 --
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 19 +++++--------------
 3 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index e1f391dbf15c..09692fc817f9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -814,15 +814,6 @@ enum dc_status dcn401_enable_stream_timing(
 
 	hws->funcs.blank_pixel_data(dc, pipe_ctx, true);
 
-	/* Legacy code path will enable DSC during DPMS on sequence. Since DSC
-	 * HW block programming is independent from link and stream encoder operations, it
-	 * has moved to hwss and should be called when enabling/disabling OTG.
-	 */
-	if (stream->timing.flags.DSC && pipe_ctx->stream_res.dsc) {
-		if (dc->hwss.configure_dsc)
-			dc->hwss.configure_dsc(pipe_ctx, true);
-	}
-
 	/* VTG is  within DCHUB command block. DCFCLK is always on */
 	if (false == pipe_ctx->stream_res.tg->funcs->enable_crtc(pipe_ctx->stream_res.tg)) {
 		BREAK_TO_DEBUGGER();
@@ -2137,15 +2128,6 @@ void dcn401_reset_back_end_for_pipe(
 
 			pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
-			/* Legacy code path will enable DSC during DPMS on sequence. Since DSC
-			 * HW block programming is independent from backend operations, it
-			 * has moved to hwss and should be called when enabling/disabling OTG.
-			 */
-			if (pipe_ctx->stream_res.dsc) {
-				if (dc->hwss.configure_dsc)
-					dc->hwss.configure_dsc(pipe_ctx, false);
-			}
-
 			pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
 		}
 		if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index c5fab430b7f7..e2dddbc170f8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -125,7 +125,6 @@ bool dcn60_configure_dsc(struct pipe_ctx *pipe_ctx, bool enable)
 			enum optc_dsc_mode mode = dsc_optc_cfg.is_pixel_format_444 ?
 					OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
 
-			DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
 			pipe_ctx->stream_res.tg->funcs->set_dsc_config(
 					pipe_ctx->stream_res.tg, mode,
 					dsc_optc_cfg.bytes_per_pixel, dsc_optc_cfg.slice_width);
@@ -133,7 +132,6 @@ bool dcn60_configure_dsc(struct pipe_ctx *pipe_ctx, bool enable)
 		return true;
 	}
 
-	DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
 	pipe_ctx->stream_res.tg->funcs->set_dsc_config(
 			pipe_ctx->stream_res.tg, OPTC_DSC_DISABLED, 0, 0);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 36700df2d607..78ad92fe4ea2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -914,7 +914,6 @@ static bool configure_dsc_hw_block(struct pipe_ctx *pipe_ctx, bool enable,
  */
 void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dsc_config dsc_cfg = {0};
 	struct dsc_optc_config dsc_optc_cfg = {0};
 
@@ -923,20 +922,12 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		return;
 	}
 
-	if (dc->hwss.configure_dsc) {
-		/* If the hwss configure_dsc function is supported, then DSC will be programmed
-		 * in the same sequence of OTG enable/disable. Thus, we don't need to configure
-		 * the DSC hw block here.
-		 */
-		set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, false);
+	if (enable) {
+		if (configure_dsc_hw_block(pipe_ctx, true, &dsc_cfg, &dsc_optc_cfg))
+			set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, true);
 	} else {
-		if (enable) {
-			if (configure_dsc_hw_block(pipe_ctx, true, &dsc_cfg, &dsc_optc_cfg))
-				set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, true);
-		} else {
-			set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, false);
-			configure_dsc_hw_block(pipe_ctx, false, &dsc_cfg, &dsc_optc_cfg);
-		}
+		set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, false);
+		configure_dsc_hw_block(pipe_ctx, false, &dsc_cfg, &dsc_optc_cfg);
 	}
 }
 
-- 
2.43.0

