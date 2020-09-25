Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C7FC4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11E22068E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NaQF4+Wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11E22068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC176ED0E;
	Fri, 25 Sep 2020 14:55:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6693B6ED0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9gEbAdpeHcIfgG7ZnqqemsX6drPIA93Ee+MCn0S95t1VsRbY2CgRGQDOHMtdTG7r0JhSsgJ7+xeM+NliJRMwT75IeKfEKy3gy6zyUceR/gCPZDtoL3Kd4AxoiDNyVxJy4Ufmz0KjNCd0o478LSbNnLvLzOZhDp/y5kfbP/V8TrMZiy4EBumICFzOp4IM4wpvtneqMJ2ZPk2qrsKce4qYFTnEIjM2qdogRqDOFD6nZ3kdiNH9KhrrI6UfFXz8vrRa7yWXb5QMbVH48bDZYB0I/9k+9IKhX6hVdrx2GkkHHXClIHKrVsaOkgHOZ1nNHxpwkRg+DxeHbkelENnvlrZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA3RaM695GVH7n+GfXpzWSFnQPzXH/m1ux/E3Apuvys=;
 b=POrxocb/AjSswxJ4ktsUCGYmm7WguOu01irzY9aXdHOYvhRHXXhA9bDgT6FUk8fuQ8wX9rNFdW0wHguGxiA0x7haCpBDhSeEPRqE2LuHBk4Z0UJTR7MsLBZLJEjC2X7BFrRHqIf+KXuA4KgeyymhkcJQyj64QYjajP1oa+cTDLQWQmrEjqs47bk7LyqyMPIwBOJAFZLa2mZoZR4Yk20kGPeceRI42Fwe5HjkAP8hYQ9DyMP+TvbjtLGWjSPiLcxPBC+W6BLQNwSS9T+ikU7cgXyTnq4WFStLA83JgGyzJdfD4UINT4CkAePN0Va2NsrcLIjTwrnvn9N9ZW9CHnC7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA3RaM695GVH7n+GfXpzWSFnQPzXH/m1ux/E3Apuvys=;
 b=NaQF4+WmyHk0p+tT21xK8qiug43oMn+rLg9cpP4galBU5hGOI8EGC8hD7dkUXStTc41oaYJCg8IsLWiYCSjyBkwCAI8tPunfKL/hE4wHxTqVif62OS6Chp5WABmHja1hjLwtqF606aQnUKq1Ofrvew2rsZARkIbE8gQ1mQgBkpY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:55:12 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:55:12 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/9] drm/amd/display: disable stream if pixel clock changed
 with link active
Date: Fri, 25 Sep 2020 10:54:50 -0400
Message-Id: <20200925145455.2398170-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
References: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::980e) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:55:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13a3cd26-d91f-426f-03d3-08d861630115
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4219A7E08311D02E1A97E97998360@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxEedMH8QZTidcGhmZdESUEPW13RFBxZSjHpo0XFf2UOTglC0NDprb+RElteFqFl0KoMnL+I0m+5n2mteHfpWSNx6XYLVFJyg4XIREJc/8mMZAOSnIs+WSK9h67gyExifS05bgIOrm+3jYyfy5uHeUNUQjria9FFxaDYK2fbgUUR8B0h2KQd0T1Zkg8DgmSd6HiWSGdQNV9DGkwfLfG8cBKox33A+bj5fYiCrk8YAwM7A9BKlaP1RUo8UFce3Mzm26V6L6MhCVZKL5fBHMKwsiQR6Sdl9o5XQbPEKdZL18r55s8Z0tX1DsctfiCJhhusR+uvSQCFvbmi5UGoJUA95g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(6666004)(36756003)(16526019)(4326008)(6506007)(52116002)(2906002)(86362001)(2616005)(478600001)(6512007)(66556008)(186003)(66476007)(6916009)(1076003)(5660300002)(54906003)(316002)(8936002)(83380400001)(6486002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: U5Czg5jeo3AbEund0rQT5vcx2sgCaiPeTgmw6GH78fUCkMSkkFtiHbWH6b0Z1OFVMMZUgrXYJXXwvQ/cvsiuzXZmEQ9fuKVfPpjWMsinQRm1hZXt7sfBACe1AipKCgDrjhW0O2eq+VcutMIctz6eTnHPLcoINGjbD3DI459oXbcBuKJrUvlgWdRi7CcHCBnkhNRA14N8fDv3XKeaTT1U3firKAdtoW5jwK1cqeV1CFcVRLQd8yTSlQL0EyxU8aNCRqNU+0HyGz96HMMNW8J0Syd9WQ500zzmCDQLG+wZH7Qko07VFFEiqtRYu+j7Kwapj/TtI/5VYttliONXlqa31hY2LyaupXoys90vBVyx7eGsMTT0MB54dGZQeUTZaxICMSPCFYipRzTpy9X3002fA1v4HFWnTO4gX8PVxADCCNT+FKKh/VS+1zJ46jH9/kzT+jXGjSc6hwY/jIPyLu6nHUwsm1J0fTCkcD21tHOqQQ68sNI4zGN2bcZ/Ent4NWHOHrY+ibsgM1GzjBLU73SR6DYEKK70yA+lOylJYcOD8RavMQ87iv/E6V0QjO20p74T9fi9HLHW9vwBSUEAy1vIMj4qyCq0J8gKsGkFdceG2D4lX0OST6nOMt1tFwd0V0k/0ElSsxc4LUMDRH7KfpuL/uDypF2ywQKS6Aa2601gFeyg4Jv7zEcTagCrRJGzAxn+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a3cd26-d91f-426f-03d3-08d861630115
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:55:12.2757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pQ1KgLe+5xWvWOtAbwi06RaiEYMbUqkdET5DjTsBxgq/ro4CqozgDjWXwWCmJ2KlgF1JNUgPnHX51hzdK3VwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Chiawen Huang <chiawen.huang@amd.com>, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chiawen Huang <chiawen.huang@amd.com>

[Why]
Vbios uses preferred timing to turn on edp but OS could use other
timing. If change pixel clock when link active, there is unexpected
garbage on monitor.

[How]
Once pixel clock changed, the driver needs to disable stream.

Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 62 ++++++++++++++++++-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  2 +-
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7e74ddc1c708..9fabe264cdea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -842,6 +842,61 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 	dc_release_state(current_ctx);
 }
 
+static void disable_vbios_mode_if_required(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	unsigned int i;
+
+	/* check if timing_changed, disable stream*/
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct dc_stream_state *stream = NULL;
+		struct dc_link *link = NULL;
+		struct pipe_ctx *pipe = NULL;
+
+		pipe = &context->res_ctx.pipe_ctx[i];
+		stream = pipe->stream;
+		if (stream == NULL)
+			continue;
+
+		if (stream->link->local_sink &&
+			stream->link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
+			link = stream->link;
+			break;
+		}
+
+		if (link != NULL) {
+			unsigned int enc_inst, tg_inst = 0;
+			unsigned int pix_clk_100hz;
+
+			enc_inst = link->link_enc->funcs->get_dig_frontend(link->link_enc);
+			if (enc_inst != ENGINE_ID_UNKNOWN) {
+				for (i = 0; i < dc->res_pool->stream_enc_count; i++) {
+					if (dc->res_pool->stream_enc[i]->id == enc_inst) {
+						tg_inst = dc->res_pool->stream_enc[i]->funcs->dig_source_otg(
+							dc->res_pool->stream_enc[i]);
+						break;
+					}
+				}
+
+				dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
+					dc->res_pool->dp_clock_source,
+					tg_inst, &pix_clk_100hz);
+
+				if (link->link_status.link_active) {
+					uint32_t requested_pix_clk_100hz =
+						pipe->stream_res.pix_clk_params.requested_pix_clk_100hz;
+
+					if (pix_clk_100hz != requested_pix_clk_100hz) {
+						core_link_disable_stream(pipe);
+						pipe->stream->dpms_off = false;
+					}
+				}
+			}
+		}
+	}
+}
+
 static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 {
 	int i;
@@ -1278,13 +1333,14 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	for (i = 0; i < context->stream_count; i++)
 		dc_streams[i] =  context->streams[i];
 
-	if (!dcb->funcs->is_accelerated_mode(dcb))
+	if (!dcb->funcs->is_accelerated_mode(dcb)) {
+		disable_vbios_mode_if_required(dc, context);
 		dc->hwss.enable_accelerated_mode(dc, context);
+	}
 
-	for (i = 0; i < context->stream_count; i++) {
+	for (i = 0; i < context->stream_count; i++)
 		if (context->streams[i]->apply_seamless_boot_optimization)
 			dc->optimize_seamless_boot_streams++;
-	}
 
 	if (context->stream_count > dc->optimize_seamless_boot_streams ||
 		context->stream_count == 0)
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 27a1262a20f6..c73768ed250e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1654,7 +1654,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 		// enable fastboot if backend is enabled on eDP
 		if (edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc)) {
 			/* Set optimization flag on eDP stream*/
-			if (edp_stream) {
+			if (edp_stream && edp_link->link_status.link_active) {
 				edp_stream->apply_edp_fast_boot_optimization = true;
 				can_apply_edp_fast_boot = true;
 			}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
