Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A0C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7688023A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7688023A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C456E8F2;
	Fri,  8 Jan 2021 21:50:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88ADA6E8F3
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaWOrSjs/n/Hd0gBc1OnsDQDobHIvZIHnRUflyFHGQLftv7Vx/JR3Q7DU3c1A1wjBllYJFlXh0W0bkNWTdFUSwEOfUrndenlQ8nhTydSDrsmoFemmeWUTLs2OQmFO/89yT7VrPnuZesJ5gMI0BopCcklK2K+niSQD36Qn6VwS2kZpvGy5xFOjCfl3aNBNw0DcySYh93vm24k59aZeKiGpJDKCDWD1T6OmELPO/Z9aDSAH9o2MdC9VIeWW+/wRVviNf9w+jIwhStlT8eo1IAvwmOplS23/D15d99wq/OPZ3DwF4/jzZtQhwJ8+Kp6c1s9EK96o/dxQdGQ43AtgkN8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccpVtB5TIoLWzJjuaLFVqkaDic7sBfNuE9cD8yUWbiE=;
 b=lIR8bFSxmfgcPl1Gcy2zIMdib6JH0g9X5yBXqOOc9V4TzCNFtZkPp1qWALpLDqnNS7fLmzqGqkBhEjfdoBkAxwmHoNdTygpDNPfwXdMdBEHBVkkM8ByjoZqgqCcsIPFcJnX7iH7gWbZMrXr8YibA3M455bYkiRH6iBGgtRnGfpSFJImmS146kQAi0l5iyoRpsRacxvi6ntcl/XQSjqEB5JcgAa6rxei+2Y0EJHzQI/A4Yhv+vXcDB/kwtfz8Itty6dSpBcBQasoo0cEl6GWcAfOAoh2Rflv0auBNb8QDp2duODWsK5gNz7gUHc1fH6yQkAgTYU4dMpF7pzjklUk27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccpVtB5TIoLWzJjuaLFVqkaDic7sBfNuE9cD8yUWbiE=;
 b=E10Zn+Ep67u644NRaj5LzN32HVkmT9r6ZHdoCcTdn3IIBYhXJ61tWiR2Eh521x36XD5Gf7PzmNUYS3L6ANaXKjLTr8gZYTx/CgwzHgzLyz9uGD4vL2Qd4Bltq/F5sK+MzhtXlVjuZyZEYCxNWoUj7ZIKFKuve8WU7dkx/Dg3HKc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:51 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/21] drm/amd/display: New sequence for HUBP blank
Date: Fri,  8 Jan 2021 16:50:01 -0500
Message-Id: <20210108215007.851249-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a3e7ac7-1641-4ac6-7a3f-08d8b41f7783
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18822AB7EDD0415F33F9526E98AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptGB8EeP0UI4HEi8gq2iqmpAXvp4PNoXeNpIsYjyqDqMEq3GTuYjYRHv98Z2HgQ9YZ0lx/rAAAmH8fKY1KbZuHj531JTgvmqaRhMeKdOGDBdCTuaY1eecoAiS/LkJ2Yb6OCD+Sm6iInFtLi+fmuJrS0BQESjDsCmH6Y/JQwTfit6osQ592RbYWmPwDtpl+DYOsczpmysmZWFy8YeObI6SlhQm3unG4WpGOnUe0Eh4vTRB83rey1Ryzp18xPu5WDzdrwSF0978C9Iu2rqWfAd/+qoy3EntLmKBDB90+gEcVwEWalMxPoyQeouxKUk5HCK/Eyq7XKZZKnUw+bRV6jyD0Lo7cQlkz9QUkw2qMkSjCP/tJsTnajWCxK18iiGVrN7+IYZHP2wnMdNFW1UWLu4CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(30864003)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MO63PSvNIPxe5Z4lQ1l/5CWNiJ5sEuvZFW+vYTBjs6mBe8ekteSHcDoufqu6?=
 =?us-ascii?Q?mEjGlzO6gz4gdKDlOLjJ3Yk70sx8ym2pLF5EoYEBQXLb5AH64ZoAS2CKBIHp?=
 =?us-ascii?Q?sni72BM0C3M2Y9cIaaoY0AkqUNmCEP9ECh6CRNq7/c/cYufG1UKOZLVcCs7Q?=
 =?us-ascii?Q?cBro7IEWLL3VgRUMMIADR2vk9mMNrUiCHgqpFgcWWnSC+4ZdES8hwPCCwV1f?=
 =?us-ascii?Q?vSSQaTuccKSLsgZYVHbNWR9/TeC8O1FnEqjXoyJncE6NQdXSW4yFZBS2+ChA?=
 =?us-ascii?Q?KrydaMKU715HKOhQQUekorvUpL8KsmADpGI7ByaoGF/tzbuSz4oTzL9eIgw4?=
 =?us-ascii?Q?2bcF18uxr2sL0eiZGkSiyKtDVmUhmbJHKMvh1JpvuZwQi381LU8VGxm1n9pF?=
 =?us-ascii?Q?Up5hKlWNirciPA0Brq6DA4MjqG9cApIqPTvWrMUCLu9cCoydFGlyYJ1yNe+j?=
 =?us-ascii?Q?BJ6xod4hUI+Ps8H+qsVrW+TjCQreyIP7s8o6buCLgXX1MRwdh8sd95pr39TJ?=
 =?us-ascii?Q?BYAaJ9Ex53VZx2XietdNxXaHEgs9JLTHAHIsySscJ6RxnusbjbUS6MP+wqSb?=
 =?us-ascii?Q?pB8B9njM9yJDikT7sk75V4exP4LZaEVYM0q7sV0IPzrP5cZ2tzTPQateeHBl?=
 =?us-ascii?Q?95Ur+PIVxQk9oBkYYgV6InGxx4CEdMh/XvFpwDGLHQbzOXDUFypMKJ91qNI0?=
 =?us-ascii?Q?ZYSNKoRgPzDDnx9qaWWF7KciuTX/BRQw51B48o1YbCnrSNGVipEeRIO+vJ90?=
 =?us-ascii?Q?q4RzxXPIEYWIn/UjeoBL2RUps9p+Zry+rNxnbsWCO2/6xZzbZ6x4FILZpJiY?=
 =?us-ascii?Q?fU3oZbtj5vsbrkA7i0s719jVkNoyQ3KUEUjRfI6AkaNm4Smlv/tL/MLjIyy0?=
 =?us-ascii?Q?i0c6RrPHaMobDh4+c3UIJ7VDjwh0sxR92G1KE9ttaA5S0/7P7XWdEPjkHcR2?=
 =?us-ascii?Q?IxvHj2z3WhC8FPal3noQSTXaNVqpD71s7R4hhTQX7z218oHxNc6DAhOG+Jzm?=
 =?us-ascii?Q?gMFT+rBPtcBC41GUe5UMPYFeZRhVaiy2/oc34l75xO6DuPI2o2IvELfTfmiT?=
 =?us-ascii?Q?to44bEng?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:51.3686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3e7ac7-1641-4ac6-7a3f-08d8b41f7783
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyO42YhB2AeOL4S97WXsM9oupEuLUbHC9VdBg11bj37YFYklgGr0EssVhFiQbPwRW1VgM+O58lsfEx+lgzKl+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
DCN30 has a bug where blanking HUBP blocks pstate allow unless
HUBP_DISABLE is toggled afterwards.

[HOW]
Create a HW sequence for blanking HUBP.
1. Wait for enter VBLANK
2. Set HUBP_BLANK
3. Make sure HUBP_IN_BLANK = 1
4. Toggle HUBP_DISABLE on and off to perform soft reset

All existing calls to hubp->funcs->set_blank should be replaced with
this new sequence.
In wait_for_mpcc_disconnect, only blank the pipe being disconnected, and
leave all other pipes unmodified.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 +++++++++++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  3 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 47 +++++++++++++++++++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  4 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 +
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 ++
 11 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index cfc130e2d6fd..add86d4086e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2624,7 +2624,7 @@ static void dcn10_update_dchubp_dpp(
 	hws->funcs.update_plane_addr(dc, pipe_ctx);
 
 	if (is_pipe_tree_visible(pipe_ctx))
-		hubp->funcs->set_blank(hubp, false);
+		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
 }
 
 void dcn10_blank_pixel_data(
@@ -3135,13 +3135,16 @@ void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
 	return;
 }
 
-static struct hubp *get_hubp_by_inst(struct resource_pool *res_pool, int mpcc_inst)
+static struct pipe_ctx *get_pipe_ctx_by_hubp_inst(struct dc_state *context, int mpcc_inst)
 {
 	int i;
 
-	for (i = 0; i < res_pool->pipe_count; i++) {
-		if (res_pool->hubps[i]->inst == mpcc_inst)
-			return res_pool->hubps[i];
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (context->res_ctx.pipe_ctx[i].plane_res.hubp
+				&& context->res_ctx.pipe_ctx[i].plane_res.hubp->inst == mpcc_inst) {
+			return &context->res_ctx.pipe_ctx[i];
+		}
+
 	}
 	ASSERT(false);
 	return NULL;
@@ -3164,11 +3167,23 @@ void dcn10_wait_for_mpcc_disconnect(
 
 	for (mpcc_inst = 0; mpcc_inst < MAX_PIPES; mpcc_inst++) {
 		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
-			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
+			struct pipe_ctx *restore_bottom_pipe;
+			struct pipe_ctx *restore_top_pipe;
+			struct pipe_ctx *inst_pipe_ctx = get_pipe_ctx_by_hubp_inst(dc->current_state, mpcc_inst);
 
+			ASSERT(inst_pipe_ctx);
 			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
 			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
-			hubp->funcs->set_blank(hubp, true);
+			/*
+			 * Set top and bottom pipes NULL, as we don't want
+			 * to blank those pipes when disconnecting from MPCC
+			 */
+			restore_bottom_pipe = inst_pipe_ctx->bottom_pipe;
+			restore_top_pipe = inst_pipe_ctx->top_pipe;
+			inst_pipe_ctx->top_pipe = inst_pipe_ctx->bottom_pipe = NULL;
+			dc->hwss.set_hubp_blank(dc, inst_pipe_ctx, true);
+			inst_pipe_ctx->top_pipe = restore_top_pipe;
+			inst_pipe_ctx->bottom_pipe = restore_bottom_pipe;
 		}
 	}
 
@@ -3721,3 +3736,10 @@ void dcn10_get_clock(struct dc *dc,
 				dc->clk_mgr->funcs->get_clock(dc->clk_mgr, context, clock_type, clock_cfg);
 
 }
+
+void dcn10_set_hubp_blank(const struct dc *dc,
+				struct pipe_ctx *pipe_ctx,
+				bool blank_enable)
+{
+	pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, blank_enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index dee8ad1ebaa4..89e6dfb63da0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -204,5 +204,8 @@ void dcn10_wait_for_pending_cleared(struct dc *dc,
 		struct dc_state *context);
 void dcn10_set_hdr_multiplier(struct pipe_ctx *pipe_ctx);
 void dcn10_verify_allow_pstate_change_high(struct dc *dc);
+void dcn10_set_hubp_blank(const struct dc *dc,
+				struct pipe_ctx *pipe_ctx,
+				bool blank_enable);
 
 #endif /* __DC_HWSS_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 254300b06b43..2f1b802e66a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -79,6 +79,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
+	.set_hubp_blank = dcn10_set_hubp_blank,
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 6470f5c7dfea..b74f79575cdf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1571,7 +1571,7 @@ static void dcn20_update_dchubp_dpp(
 
 
 	if (is_pipe_tree_visible(pipe_ctx))
-		hubp->funcs->set_blank(hubp, false);
+		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index de9dcbeea150..51a4166e9750 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -94,6 +94,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
 #endif
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
+	.set_hubp_blank = dcn10_set_hubp_blank,
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 074e2713257f..0597391b2171 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -99,6 +99,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 #endif
 	.is_abm_supported = dcn21_is_abm_supported,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
+	.set_hubp_blank = dcn10_set_hubp_blank,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index b83c13d3d8b7..7f26c9444933 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -836,6 +836,53 @@ void dcn30_hardware_release(struct dc *dc)
 				dc->res_pool->hubbub, true, true);
 }
 
+void dcn30_set_hubp_blank(const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool blank_enable)
+{
+	struct pipe_ctx *mpcc_pipe;
+	struct pipe_ctx *odm_pipe;
+
+	if (blank_enable) {
+		struct plane_resource *plane_res = &pipe_ctx->plane_res;
+		struct stream_resource *stream_res = &pipe_ctx->stream_res;
+
+		/* Wait for enter vblank */
+		stream_res->tg->funcs->wait_for_state(stream_res->tg, CRTC_STATE_VBLANK);
+
+		/* Blank HUBP to allow p-state during blank on all timings */
+		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, true);
+		/* Confirm hubp in blank */
+		ASSERT(plane_res->hubp->funcs->hubp_in_blank(plane_res->hubp));
+		/* Toggle HUBP_DISABLE */
+		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, true);
+		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, false);
+		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe) {
+			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
+			/* Confirm hubp in blank */
+			ASSERT(mpcc_pipe->plane_res.hubp->funcs->hubp_in_blank(mpcc_pipe->plane_res.hubp));
+			/* Toggle HUBP_DISABLE */
+			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plane_res.hubp, true);
+			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plane_res.hubp, false);
+
+		}
+		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, true);
+			/* Confirm hubp in blank */
+			ASSERT(odm_pipe->plane_res.hubp->funcs->hubp_in_blank(odm_pipe->plane_res.hubp));
+			/* Toggle HUBP_DISABLE */
+			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_res.hubp, true);
+			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_res.hubp, false);
+		}
+	} else {
+		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
+		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
+			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
+		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, false);
+	}
+}
+
 void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		enum controller_dp_test_pattern test_pattern,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index bfc97e2ece61..1103f6356e90 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -79,4 +79,8 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset);
 
+void dcn30_set_hubp_blank(const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool blank_enable);
+
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index c4c14e9c1309..204444fead97 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -98,6 +98,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.hardware_release = dcn30_hardware_release,
 	.set_pipe = dcn21_set_pipe,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
+	.set_hubp_blank = dcn30_set_hubp_blank,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index bdad72140cbc..b8bf6d61005b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -98,6 +98,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
+	.set_hubp_blank = dcn30_set_hubp_blank,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 7a19ff5d4214..48378beb71c0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -230,6 +230,10 @@ struct hw_sequencer_funcs {
 			enum dc_color_depth color_depth,
 			const struct tg_color *solid_color,
 			int width, int height, int offset);
+
+	void (*set_hubp_blank)(const struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			bool blank_enable);
 };
 
 void color_space_to_black_color(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
