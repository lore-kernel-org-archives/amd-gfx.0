Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6310FC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7F320657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="atQlPHeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7F320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69466ED20;
	Fri, 15 May 2020 18:13:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 598466ED20
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfGQfP6GcRdSwuZIt1+JFUic6Y9f22sQ1cTcacR048airh3oS6uQTH6TH8twVMM+hoRMhPadSOdR41ozLXNfD+4lkU4BG9lX/yxb1nJfYsLaTdTCBdr6O+7pMdVB3tZJ1Q54GGufmgTVn24KB8joWo0tLfjr2zkTcwBqXYWRAH1nHbH3X0w5ZvIWuT7WU5VIBs8IrMkBsl03mqGJcCF8H9kK/niIVCcz/Ua6XfnpLlO1tJuIkrYoWg1Zu279QUiMO/L83FGWclB0GDTIl5Oxk/G4BDXmFyOSWP1KDWug55e8+S1t0tu7xgrSz6gqR3qaZDkWSTkAeJ9BtGpMMR40xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2QG27tCjT3FQlFaDmtWz8VKBwyYKL5N+b9IWCys/Pg=;
 b=O5iaChQzHjagsNg0GLElo9W5zxmim7nsvVtkkeyr8+TIriSjHTbCBUgJkUc0GWXgzmVqwZp71bunF3C5ye0htt5sl76eIu6YL8RRWL3UhtPIfG113hrYJKZWuQ+urMnYUXqXWnpldIXu0ZwQvrhekcm+6/NsGvg/kZ6BIfTeyWpGVBXoCLyFJopiHO3i6M9Fqii/GYdPyO8g8MriztkK1ly0sc67CYtjY6A7dY3GkfTCM6DAE+D3RmOFDqKwN4UdNy6Ts+jQlDks4gsXyJLe1vGfu2lLRxDVxF9vB9uumLUSCvxaH6WdXbPAFTBkxZCCYqKo456qiZw/n7u0a3lUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2QG27tCjT3FQlFaDmtWz8VKBwyYKL5N+b9IWCys/Pg=;
 b=atQlPHeTMrpW8Q+Z6NMy+4u+470KnyzVdenSZu6v95jo+ErkZsd/7iSfR1uaOvj7INIxthzi0eurRJjGnF+Q7spfHyyNyJdsfPauWVS3QapN5xVFepv5+niFuaQkvrDlR7gwFJZdfU9e2sf+2j8XHxFQZnQqTuzKnyGB7c5IgGo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 18:13:55 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/27] drm/amd/display: Defer cursor lock until after VUPDATE
Date: Fri, 15 May 2020 14:13:04 -0400
Message-Id: <20200515181315.1237251-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:54 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 476432b2-068b-4726-a484-08d7f8fbba8c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848A0D105FA5A41C48A17CE98BD0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aU9G7vGa/I1lIaI1R9py5d0G40iImEa4Ikhv0FUi7Fj4116+IaEfNJrGPn6I+Bbj45YbPSQINC51uNLD6aAWYQGrQXiZsCFQwEZbO0+AjhDcu7SW7EREIlfuxjSClRjkNAD0bmN3dGBU411ZkHjyv/ev2ZZPyBk96ipp37r9xCZUlatkhfz4pPTwrddY0p1y+vz+kmjScRb5b7Sp4h6BfEgxNblAOEs9EwF657/+tzRD6GiNYmhNBoNaEyb1O9wmUxsA48eDTmWlgyPcEz6EQg8KU9M0dxbh5NZogYopYV/zlTGR3GnoYSdMBGcB1v2vWsOqGDc6VYtqXLgmpHkczbRRQpBBo5gXd4q/3e6R0CRDtkIWO7ikKPYDWeJRtscNxTbJ3aPfgAAde0JIO/2xubQmfHGEXWJ5aMrncUhD4NAnW8q2yKq2zFZiR7po30F4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(86362001)(2906002)(186003)(8936002)(52116002)(6506007)(6512007)(8676002)(36756003)(316002)(5660300002)(16526019)(4326008)(6916009)(66556008)(478600001)(1076003)(66946007)(6486002)(66476007)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: A1QR0jrJLDP51gYtmI+lQIwbMYWZm9IJfU9Gp4G3ZNNYiqryr7NLO52D08uNwZtA4bvZ31bTBA77dQWf5SVdSoxFN8SzJ6QKO0Fz1Tp496XkJr6NKrMwKTZEzdy4vSKgVqdHyBnWNrmbCLgbO0lQm3qhc1WdeZ0b0A+R0r2OOKpgo5ddwW7GhTuswauNzLt3K1N71s1yHAOnwPdN6e9NT5MWUr8c3W+iJ2ajTcob1xKvM5e7DH9OEeQUyKm3Vq2WDyhGvkrgV2gCDCRUt8/DoP6AtxwHvpOnhBrQ9zFR6XK8j5ErLI30IVctg080Mse3kaudL15/gOncxJ9CLYve7Uvqdc2ILvQGNbGLtlOOPO9r7rrPO+K4+WYGKJGcrqlAljOOEUQYPwON1QdbPD9l+JgolJBUF7LG3Gu38R7HpUBZi762WqIo0qeWA4AWdKfjddA4SJXNZp0JTf8GhbH1KM5rR8EBewkrzsd8DutapOPqFt3BHLhCDk6+7YOKtzy7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476432b2-068b-4726-a484-08d7f8fbba8c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:54.8649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etl2R+4/yeedXieZJaCHL0tVf0o6vHRPCzfNRXz6u5PBXZdamgAayRLI4ymJkMVHC8PoGNxan73M1TZrfJ4e1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We dropped the delay after changed the cursor functions locking the
entire pipe to locking just the CURSOR registers to fix page flip
stuttering - this introduced cursor stuttering instead, and an underflow
issue.

The cursor update can be delayed indefinitely if the cursor update
repeatedly happens right around VUPDATE.

The underflow issue can happen if we do a viewport update on a pipe
on the same frame where a cursor update happens around VUPDATE - the
old cursor registers are retained which can be in an invalid position.

This can cause a pipe hang and indefinite underflow.

[How]
The complex, ideal solution to the problem would be a software
triple buffering mechanism from the DM layer to program only one cursor
update per frame just before VUPDATE.

The simple workaround until we have that infrastructure in place is
this change - bring back the delay until VUPDATE before locking, but
with some corrections to the calculations.

This didn't work for all timings before because the calculation for
VUPDATE was wrong - it was using the offset from VSTARTUP instead and
didn't correctly handle the case where VUPDATE could be in the back
porch.

Add a new hardware sequencer function to use the existing helper to
calculate the real VUPDATE start and VUPDATE end - VUPDATE can last
multiple lines after all.

Change the udelay to incorporate the width of VUPDATE as well.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 69 ++++++++++++++++++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  5 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  5 ++
 6 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 27cae98936ea..0512a60c43b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1682,12 +1682,79 @@ void dcn10_pipe_control_lock(
 		hws->funcs.verify_allow_pstate_change_high(dc);
 }
 
+/**
+ * delay_cursor_until_vupdate() - Delay cursor update if too close to VUPDATE.
+ *
+ * Software keepout workaround to prevent cursor update locking from stalling
+ * out cursor updates indefinitely or from old values from being retained in
+ * the case where the viewport changes in the same frame as the cursor.
+ *
+ * The idea is to calculate the remaining time from VPOS to VUPDATE. If it's
+ * too close to VUPDATE, then stall out until VUPDATE finishes.
+ *
+ * TODO: Optimize cursor programming to be once per frame before VUPDATE
+ *       to avoid the need for this workaround.
+ */
+static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct crtc_position position;
+	uint32_t vupdate_start, vupdate_end;
+	unsigned int lines_to_vupdate, us_to_vupdate, vpos;
+	unsigned int us_per_line, us_vupdate;
+
+	if (!dc->hwss.calc_vupdate_position || !dc->hwss.get_position)
+		return;
+
+	if (!pipe_ctx->stream_res.stream_enc || !pipe_ctx->stream_res.tg)
+		return;
+
+	dc->hwss.calc_vupdate_position(dc, pipe_ctx, &vupdate_start,
+				       &vupdate_end);
+
+	dc->hwss.get_position(&pipe_ctx, 1, &position);
+	vpos = position.vertical_count;
+
+	/* Avoid wraparound calculation issues */
+	vupdate_start += stream->timing.v_total;
+	vupdate_end += stream->timing.v_total;
+	vpos += stream->timing.v_total;
+
+	if (vpos <= vupdate_start) {
+		/* VPOS is in VACTIVE or back porch. */
+		lines_to_vupdate = vupdate_start - vpos;
+	} else if (vpos > vupdate_end) {
+		/* VPOS is in the front porch. */
+		return;
+	} else {
+		/* VPOS is in VUPDATE. */
+		lines_to_vupdate = 0;
+	}
+
+	/* Calculate time until VUPDATE in microseconds. */
+	us_per_line =
+		stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz;
+	us_to_vupdate = lines_to_vupdate * us_per_line;
+
+	/* 70 us is a conservative estimate of cursor update time*/
+	if (us_to_vupdate > 70)
+		return;
+
+	/* Stall out until the cursor update completes. */
+	us_vupdate = (vupdate_end - vupdate_start + 1) * us_per_line;
+	udelay(us_to_vupdate + us_vupdate);
+}
+
 void dcn10_cursor_lock(struct dc *dc, struct pipe_ctx *pipe, bool lock)
 {
 	/* cursor lock is per MPCC tree, so only need to lock one pipe per stream */
 	if (!pipe || pipe->top_pipe)
 		return;
 
+	/* Prevent cursor lock from stalling out cursor updates. */
+	if (lock)
+		delay_cursor_until_vupdate(dc, pipe);
+
 	dc->res_pool->mpc->funcs->cursor_lock(dc->res_pool->mpc,
 			pipe->stream_res.opp->inst, lock);
 }
@@ -3300,7 +3367,7 @@ int dcn10_get_vupdate_offset_from_vsync(struct pipe_ctx *pipe_ctx)
 	return vertical_line_start;
 }
 
-static void dcn10_calc_vupdate_position(
+void dcn10_calc_vupdate_position(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		uint32_t *start_line,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index af51424315d5..42b6e016d71e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -34,6 +34,11 @@ struct dc;
 void dcn10_hw_sequencer_construct(struct dc *dc);
 
 int dcn10_get_vupdate_offset_from_vsync(struct pipe_ctx *pipe_ctx);
+void dcn10_calc_vupdate_position(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		uint32_t *start_line,
+		uint32_t *end_line);
 void dcn10_setup_vupdate_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx);
 enum dc_status dcn10_enable_stream_timing(
 		struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 9f8c89b6a763..f6a790c49321 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -72,6 +72,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.set_clock = dcn10_set_clock,
 	.get_clock = dcn10_get_clock,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
+	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index e20760fa11ff..bb9e9bec2f28 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -83,6 +83,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.init_vm_ctx = dcn20_init_vm_ctx,
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
+	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 9a2d1f755839..8575de1a8ad2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -86,6 +86,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
+	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 2e8f3fecc6a3..4f9216c96e59 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -96,6 +96,11 @@ struct hw_sequencer_funcs {
 	void (*get_position)(struct pipe_ctx **pipe_ctx, int num_pipes,
 			struct crtc_position *position);
 	int (*get_vupdate_offset_from_vsync)(struct pipe_ctx *pipe_ctx);
+	void (*calc_vupdate_position)(
+			struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			uint32_t *start_line,
+			uint32_t *end_line);
 	void (*enable_per_frame_crtc_position_reset)(struct dc *dc,
 			int group_size, struct pipe_ctx *grouped_pipes[]);
 	void (*enable_timing_synchronization)(struct dc *dc,
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
