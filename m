Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBD8C4727D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D336206CA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="slQhamoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D336206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324256ED18;
	Fri, 25 Sep 2020 14:55:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44DA6ED0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIpC/EQ+1UkBTGb0lgIy3lJKYIsy2yEgIg64lMvpxGfwt3IBRti2eDTi74gb+WK+HU7UXcBRW+zUN3soBmrPp3i/1sENsPOsKNCoER06iMwybB6aY2ne3uyZv4weeJ2et+7h1HqkT5/VOQirzFqmHjGYmGuUWdEFQAt1YLoR/z6yY37m5Vq/hVP4+bIh686X70qisiZNY+gkoqfZQg8UfKagrJuB21ZPNe3RW6Oam+Vr+QFSOQ7SUea4Qf26i/9RdPgd52UPDSp9ZIatdOLRGEv74tZSiLmR+3K0+Qi74WInGj1CA1G1rUv3uFnbysS46JPLU04nrivKRO/NYmThDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBdNe6v4SE9KD2mHlepf4DtAG3SLwRfrtRM/7iJvV7Y=;
 b=amKgRjhJidvYUfhC0rSeS1ZjDZgHBRTsuTRBTLftVhCDLURhvzcjFPXixfqH8q0f+au12giuGTnMjtrMyDHWmBUnTb6nvlBCFSroumX61UkfMHXawZAmNdAKtdmKI+bRrvhXnLAt20QGTy2F86+cVD4NpWfXXAWfBfIRkQACcJt0Lp+9Fsr3x/l1ZGFIVwXKqBpLEAZvcGo9B6h2Hi1HqJ4/z7Z+AMv0yeiNs4eWqmlDmCe30rZaMMb+L5Bma6pndl2mrzcmWRrXpNc12tzY2MQ8MJzj7+KPxbG3BeuIvtRF4sEMqMH4wdmYr+4Z1pEQPZH/pYSz5BNky+VKkgNIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBdNe6v4SE9KD2mHlepf4DtAG3SLwRfrtRM/7iJvV7Y=;
 b=slQhamoSZroiLXqeEHy0AAKRF9u83oaTvZ4o8xo7wvLKXoH2hLawunO349a0OP3awqJjowcqzMdj7DBYzzaxEVGGefOSEy2r+ESrDmzsAMH5+xxH8gmFsq+hbQkZXmauFbrXjGJPeZLjc2O3Igu2leM69hMYWfmNznP/oOb+fpU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:55:14 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:55:14 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/9] drm/amd/display: Revert check for flip pending before
 locking pipes
Date: Fri, 25 Sep 2020 10:54:53 -0400
Message-Id: <20200925145455.2398170-8-Rodrigo.Siqueira@amd.com>
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
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:55:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 314ad80c-78a6-478b-2b43-08d86163025d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4219BAE3C75CE5CF1A8C0A4F98360@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5HquilM8oNfsV3VOwF7JsuZMN2tIb/vRcw31HS0lu8o+x0QBgtUz5JpPg2Ajp55P6TAu1MIRZOrqVhJgssxPjHlBpgn7YdQe2/L0soJpb9G2z7xr0MVLrZGEoQwmUlls2CgTeFqm9fahWFe4SHgjZb0YALC9yg2tmfF9pWmZdBcVAX8YlrQs/R5Oshn35S9Q0m/vbb/giHtsg+5MivWXQjXKtPXiIrAmO18z6flyehKLmWeiveFq7RP7Y02mCuUXEQoesxp4xdNXU0zJEKBKaf4ICChzaYKWgNE+e24YI2tCMjFsjClh13M2mmVGlulEZgl0CxPQla00cxjlDdpBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(6666004)(36756003)(16526019)(4326008)(6506007)(52116002)(2906002)(86362001)(2616005)(478600001)(6512007)(66556008)(186003)(66476007)(6916009)(1076003)(5660300002)(54906003)(316002)(8936002)(83380400001)(6486002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ozfj5qnegynTtZ3gsBHggdFtCFS0TBObJdNGfGDXVgiC9LPSc6enSGlNr2WZQjKhwvQk/7oGX2HuqJbPjjNgmnA+rNS+CXftD2gfJS6oLj9l/n8Uaq9FL+dDaFZRDSlEOD9Iv6KJ6Ewdzc/4JDr4D50TccfUSP+UMblMtf+YjXTcHxSwDOP5vwvETOOrgoAHThe4A90i0/7XioOHJ3LDFfdZFMG9tyaYFzanSlGqe6B8dkYJywvFUGCEeU9nxAp+cCyM+MB44eZGOwNmXsTtRLxGWY3Nu8aCA1Mg7f4oIfmJ9pjlVUC2C9+9bGerM+r/cM+Q92CzTDK5GNgqFvf2XcgZIc9zKCm7vJW+fWlVWr5aabkB4MY+GI0mxJm3StMr93QEv80vnNy5s6qe9aI200Z2Mn6D4Z4us8oaOMWW2mM/MvxD+KsoQ/MmPLUr+v6qf4Zsbc2CO2hOEif0o+4c46Hv3oIdsOJ83PFy/qdbI8sQcTvKEu6N7uOj9f0kd/qeJyRPgrDY1aJLd4TZ4sVT5UFwT6hkl65bS8XxGnkPAp+lRqcyd0VmqUf7TH8+90kYS1lyUbui/+8IMMDCx6JamRRceUeKB9ugha7aV/CqhmsuLaU7B1H9jm6swZ837mdK0oN7xeFC0+OXSWWxqT4j++QNulXv55utJIP0hCCV7oDrR+9/8vrryVIeN82zQisO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314ad80c-78a6-478b-2b43-08d86163025d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:55:14.4103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di8o4X96Khi1HQknbLcZj5XxkMHeQalaG/CFB+DSAVZKIuDPy+IYevSybIk9eHYoXyptUN/Xm0l1S7VG/ASJeQ==
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This reverts commit e82d8eae9e81af243256f70bec593baed50b0bdb.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c             | 11 +++++++++--
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    | 12 ++----------
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h    |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h    |  2 +-
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dc90d26e2663..76946a7d47ca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2384,6 +2384,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
+	bool mpcc_disconnected = false;
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
@@ -2414,8 +2415,14 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
-	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock && dc->hwss.wait_for_pending_cleared)
-		dc->hwss.disconnect_pipes(dc, context);
+	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock &&
+		dc->hwss.disconnect_pipes && dc->hwss.wait_for_pending_cleared){
+		dc->hwss.interdependent_update_lock(dc, context, true);
+		mpcc_disconnected = dc->hwss.disconnect_pipes(dc, context);
+		dc->hwss.interdependent_update_lock(dc, context, false);
+		if (mpcc_disconnected)
+			dc->hwss.wait_for_pending_cleared(dc, context);
+	}
 
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 79fe9571cf5d..d0f3bf953d02 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2761,7 +2761,7 @@ static struct pipe_ctx *dcn10_find_top_pipe_for_stream(
 	return NULL;
 }
 
-void dcn10_disconnect_pipes(
+bool dcn10_disconnect_pipes(
 		struct dc *dc,
 		struct dc_state *context)
 {
@@ -2772,10 +2772,6 @@ void dcn10_disconnect_pipes(
 		bool mpcc_disconnected = false;
 		struct pipe_ctx *old_pipe;
 		struct pipe_ctx *new_pipe;
-
-		dc->hwss.wait_for_pending_cleared(dc, context);
-		dc->hwss.interdependent_update_lock(dc, context, true);
-
 		DC_LOGGER_INIT(dc->ctx->logger);
 
 		/* Set pipe update flags and lock pipes */
@@ -2878,11 +2874,7 @@ void dcn10_disconnect_pipes(
 				}
 			}
 		}
-
-		dc->hwss.interdependent_update_lock(dc, context, false);
-
-		if (mpcc_disconnected)
-			dc->hwss.wait_for_pending_cleared(dc, context);
+	return mpcc_disconnected;
 }
 
 void dcn10_wait_for_pending_cleared(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 9a0f7a8a85cd..e5691e499023 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -194,7 +194,7 @@ void dcn10_get_surface_visual_confirm_color(
 void dcn10_get_hdr_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
-void dcn10_disconnect_pipes(
+bool dcn10_disconnect_pipes(
 		struct dc *dc,
 		struct dc_state *context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index f48ee24d42f9..64c1be818b0e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -67,7 +67,7 @@ struct hw_sequencer_funcs {
 			int num_planes, struct dc_state *context);
 	void (*program_front_end_for_ctx)(struct dc *dc,
 			struct dc_state *context);
-	void (*disconnect_pipes)(struct dc *dc,
+	bool (*disconnect_pipes)(struct dc *dc,
 			struct dc_state *context);
 	void (*wait_for_pending_cleared)(struct dc *dc,
 			struct dc_state *context);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
