Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0306C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFD123B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFD123B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEDD06E9BD;
	Tue,  8 Dec 2020 19:29:03 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760043.outbound.protection.outlook.com [40.107.76.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B7D26E9BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/w+0iMQY3lVIZ2iILkQaPZM2WjuCeR/k8afeT2unNu6L6Avh54EOKBT7VaMStdbe6VW6d6a9hRx932iyykngJDGj+k8ZFyISt1MbZcR8CnDgse0X4Tpk89KDqjZiV0tfwjw23ZmdL/h9WSLRXa23iT5IEFZbJUzgXR7t8RhUQ9UQCFpZIfaxTLP+I24GgpAhtibL9qhOjRNMWDJWBX5D8W031OXBHRLqAUCQ2bjzeNlYsKpekN2wDnUubR5UxkxDnzX/566ukIfbffJOrRNPMBTCAUlE6yDXMx7yEFUhzOS+03sXNk0SJQ4nW2TtQ/Kza5mCnM+JdLdY7yU9ESYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIkA7bbcjObRN4YLm3ePKuUmVDJtDojSoq0Ff6r5i6M=;
 b=gJygznZSA2u9wJLktNlcU8TXiMKkqoJfMhfe6AkVvZ088O8GCmH1Pl8AI4LtPSK4aKSLEtF6C0s9lXZRUn6KUAnV1Dnmf0M0EBT6hAy19ixQJNsZ6OS1xy8J4A58DqCRUq0IcCURwzcz7Pn8aYTvuZufLWvGJTg/Ns+3p/+vroXaN6KId75Zw43N2Rx0Q0cTp8F7Dono3RJ7ihVUmCqLqdXw44lc4S1YOTYOMA2jeKK0xe0ZYEMJ/c472JMZA7mM+aHBSt2CPjqNrXJ4f8R//M/qigmMlJaWNlKW0UuxUZCm/9/GlTr/7USzCy2ydzsOgGWJQ6EdQuZMhqr4C7HuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIkA7bbcjObRN4YLm3ePKuUmVDJtDojSoq0Ff6r5i6M=;
 b=y7hQmg7XBHpBgOm9QOktjNE+Dya4pt5+ze5CPlXuEd7r4bvUJC15SnFIhURAJSdLyk2jK7yvfYj/tNIM28WDglwfUfqgIPRGKNitXnLJWFoPS5XkcbWDjKLQXKUE1Q/pivY+NpjbHQH/cjSErlU+tiIWBpBE+hZKr9syXyGG25M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:29:01 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:29:01 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/13] drm/amd/display: delay fp2 programming until vactive
 before lock
Date: Tue,  8 Dec 2020 14:28:38 -0500
Message-Id: <20201208192844.23580-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:29:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c00ec06-b18d-401a-809d-08d89baf848d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4388C71C2837AEC1D1976174FBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utZTsQgJKqO30M2I27pcAsAwxa2vqRI6ptUb8n6BQZ+Pv7oxZ8m+SNgFRBeHRnecBCE+HkcebM68xLLrLYslIck+EzQx8hVGc52DLSBnrbonVIqPCLEP81H4YLjDQj/rkRomqN407RqwIH/3ccY9WmWKNnaMtZne9EFdFdmGpuV8U+WA6d59wNEDrPzCkofq8v1FOFYYRDb0e3gvqb28H01PSG/3N6h5wG41DFmsnmxkvQKnhISOzG6Y9cYRKsFHFuWO8/E9g7mikiKj+aSLn7qVTQMFoB2N8UfhfRKjTB2WdQjQU6pyfkPM1iXO5VsaU/RtHmlMQ0Xo/v8pTkzspmjfOmeCvxQ7WT4ChCWWcvGbWP7BAwpi8VGaAzyBTxxsOgLojXiZ0Ou4fWxyfFn5TbkHwycyUM1iCLa/WV9ljuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Xw1YCHB6ly5O1gofJTJI1gUksK3hKvQ8ngOztEuo2PW0yK+zZE1pZ93qB8e8?=
 =?us-ascii?Q?h2CBmLammVGWkzXF77VjSqCBSsz6eVEQOHktlhoeVZJftwCQpZMIm/6tUxD6?=
 =?us-ascii?Q?Y+26A9xAjfiEGGur6LjkPTAehvGXGefOhlF4CaaufNcLvowE4JvUuENq4TFv?=
 =?us-ascii?Q?VaO9MvnUJoz76QTN/1w1zTZqjOtOCZTkouDF6Yi7cDGxIzgE1Ij2BibCp2xi?=
 =?us-ascii?Q?B2od90gjrdF0kw1LQJa4uTni7LyAgK9PK6H0g0kWuH8U62/2bdEC7i40+Rw7?=
 =?us-ascii?Q?+G/CpSxh1zxilpdjEY5alJSYN3d7viCkltyddWWe1rWGsNUIHg0gy79KzE9d?=
 =?us-ascii?Q?+74RdXbDPZtCpLcTb5cR4c/i1AazUH5rf4khNRS3uDPaKuIEkV4ptIgAVtkX?=
 =?us-ascii?Q?fO4gD+CgOr29AnGEalsvglJCwvUctwNTUtatbfCILTCnKPJUr1u1Rgg9L/p9?=
 =?us-ascii?Q?wnLFxvi3HgovIP83yxrKyWNmeOHqGE0SdrtFVKo2AWNph0EGalFhXwApO2wv?=
 =?us-ascii?Q?ovCoMdNS7zmoLd90eFzyCVcCi20o6HDOOlfLrLFIZkXE86P/tj4NZwgD5v9q?=
 =?us-ascii?Q?X8HWG2El5b2gJcAPf/i7LWX3MhqVAENVimSjw4gH3vqJq6mEW8aUQOcj42M2?=
 =?us-ascii?Q?etelKoxCqa6Hb5Cr7LqtG6NfenEpHXJXsxFH7lBZEgRvR8F8EyUEDDg9k694?=
 =?us-ascii?Q?71zINPaKIoWEisOJNtez9IeEP8PxSj9dnku+ysGxlweqzRIvfIBGqUaLCH7k?=
 =?us-ascii?Q?hXaXcG3IENxrag3iHrOQPqh8HENhk2Ko9/gfA/+dlA0FKDowhedB73UzDXGU?=
 =?us-ascii?Q?MAnZ5lH9bGA4nQW/+CtHDKLIUlkpdLmzNR47uVXk3RdTDJEfKFwNoNRTXLY0?=
 =?us-ascii?Q?4c8XNWUp4hAAtihmAEZPYUwdXCe2mT4c38SXJnOn/k30XLj0Fw8kAsoExwTs?=
 =?us-ascii?Q?rQRb3zgVEl5KcKg0h9IUd0seEtPmb7H9V6KYr6Wmyxmcg/GLWC9EnaBvq+Xy?=
 =?us-ascii?Q?ZoeT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:29:00.9748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c00ec06-b18d-401a-809d-08d89baf848d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1UZOoNxJuoXfxpm2Y9V6VxBxEcOVitCUS2F1BHA6w60+QMLx5lFVJSXURj291t5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Martin Leung <martin.leung@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[Why]
race condition of programming FP2 wrt pipe locking
and vactive state can cause underflow/black screen

[How]
Enforce the FP2 is only programmed during vactive,
and unlock pipe soon afterwards.

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 13 +++++++----
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 23 +++++++++++--------
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 +-
 5 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9f7d6b087553..cfc130e2d6fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2736,7 +2736,7 @@ static void dcn10_program_all_pipe_in_tree(
 				pipe_ctx->pipe_dlg_param.vupdate_width);
 
 		pipe_ctx->stream_res.tg->funcs->set_vtg_params(
-				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
+				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, true);
 
 		if (hws->funcs.setup_vupdate_interrupt)
 			hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 48ccdcc17ede..f033397a84e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -272,7 +272,7 @@ void optc1_program_timing(
 			vupdate_offset,
 			vupdate_width);
 
-	optc->funcs->set_vtg_params(optc, dc_crtc_timing);
+	optc->funcs->set_vtg_params(optc, dc_crtc_timing, true);
 
 	/* TODO
 	 * patched_crtc_timing.flags.HORZ_COUNT_BY_TWO == 1
@@ -312,7 +312,7 @@ void optc1_program_timing(
 }
 
 void optc1_set_vtg_params(struct timing_generator *optc,
-		const struct dc_crtc_timing *dc_crtc_timing)
+		const struct dc_crtc_timing *dc_crtc_timing, bool program_fp2)
 {
 	struct dc_crtc_timing patched_crtc_timing;
 	uint32_t asic_blank_end;
@@ -348,9 +348,12 @@ void optc1_set_vtg_params(struct timing_generator *optc,
 		}
 	}
 
-	REG_UPDATE_2(CONTROL,
-			VTG0_FP2, v_fp2,
-			VTG0_VCOUNT_INIT, v_init);
+	if (program_fp2)
+		REG_UPDATE_2(CONTROL,
+				VTG0_FP2, v_fp2,
+				VTG0_VCOUNT_INIT, v_init);
+	else
+		REG_UPDATE(CONTROL, VTG0_VCOUNT_INIT, v_init);
 }
 
 void optc1_set_blank_data_double_buffer(struct timing_generator *optc, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 344eb487219e..b12bd9aae52f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -700,6 +700,6 @@ bool optc1_get_crc(struct timing_generator *optc,
 bool optc1_is_two_pixels_per_containter(const struct dc_crtc_timing *timing);
 
 void optc1_set_vtg_params(struct timing_generator *optc,
-		const struct dc_crtc_timing *dc_crtc_timing);
+		const struct dc_crtc_timing *dc_crtc_timing, bool program_fp2);
 
 #endif /* __DC_TIMING_GENERATOR_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index abcb06044e6e..52bdbf2d50f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1214,6 +1214,17 @@ void dcn20_pipe_control_lock(
 		!flip_immediate)
 	    dcn20_setup_gsl_group_as_lock(dc, pipe, false);
 
+
+	// If changing VTG FP2: wait until back in vactive to program FP2
+	// Need to ensure that pipe unlock happens soon after to minimize race condition
+	if (!lock && pipe->update_flags.bits.global_sync) {
+		pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg, CRTC_STATE_VBLANK);
+		pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg, CRTC_STATE_VACTIVE);
+
+		pipe->stream_res.tg->funcs->set_vtg_params(
+				pipe->stream_res.tg, &pipe->stream->timing, true);
+	}
+
 	if (pipe->stream && should_use_dmub_lock(pipe->stream->link)) {
 		union dmub_hw_lock_flags hw_locks = { 0 };
 		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
@@ -1595,7 +1606,7 @@ static void dcn20_program_pipe(
 				pipe_ctx->pipe_dlg_param.vupdate_width);
 
 		pipe_ctx->stream_res.tg->funcs->set_vtg_params(
-				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
+				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, false);
 
 		if (hws->funcs.setup_vupdate_interrupt)
 			hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
@@ -1695,14 +1706,6 @@ void dcn20_program_front_end_for_ctx(
 				&& context->res_ctx.pipe_ctx[i].stream)
 			hws->funcs.blank_pixel_data(dc, &context->res_ctx.pipe_ctx[i], true);
 
-	/* wait for outstanding pending changes before adding or removing planes */
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable ||
-				context->res_ctx.pipe_ctx[i].update_flags.bits.enable) {
-			dc->hwss.wait_for_pending_cleared(dc, context);
-			break;
-		}
-	}
 
 	/* Disconnect mpcc */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
@@ -1856,7 +1859,7 @@ bool dcn20_update_bandwidth(
 					pipe_ctx->pipe_dlg_param.vupdate_width);
 
 			pipe_ctx->stream_res.tg->funcs->set_vtg_params(
-					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
+					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, false);
 
 			if (pipe_ctx->prev_odm_pipe == NULL)
 				hws->funcs.blank_pixel_data(dc, pipe_ctx, blank);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 12d5718caea8..f7632fe25976 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -271,7 +271,7 @@ struct timing_generator_funcs {
 			struct dc_crtc_timing *hw_crtc_timing);
 
 	void (*set_vtg_params)(struct timing_generator *optc,
-			const struct dc_crtc_timing *dc_crtc_timing);
+			const struct dc_crtc_timing *dc_crtc_timing, bool program_fp2);
 
 	void (*set_dsc_config)(struct timing_generator *optc,
 			       enum optc_dsc_mode dsc_mode,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
