Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80CC433E8
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F4520768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A36rqX1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F4520768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430B56E255;
	Thu, 13 Aug 2020 21:35:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B850D6E25D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPgvTsdge+PB3gGfn6VHKG5xVDmluY/4/FMS4gjRsZz5tQxbswK0626ExJkTuZ7+l8GuxUTeKZPGz5d0/Yw8FJ66/DnN+hoXYDPqwyFr07exbKm/p1ClniZWjRdiHGOenmLP9quOgN8d+MjGO7x98WAThBqyhl4RaSy6WFp8g7t/Q+dx2mTL+gNJoygXe8tBOXScB3sU6kdMAyE/lQeslPY7Bxs5Og/O4Zf7CC7t5vZkRVz+zUX7PcZ8DRmSFSnSFytiAipgIpnbhE6mc1/q5WaTm7pxWHgIc4CSH85oKxvAknIs88LpRUDUMTvyV7uvqcMwlXur7W3wq9bOG/D5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30LcNrfvgAgJWllqwJMQmTve3HuhGZwm3On0Cpymdyk=;
 b=B5E58Ue8/R6O3b9buHCTWjgA3W9tUMKeRza4XuGe5Zj9fVw/PRvi+ENbkflaXx1Rs1Dps6bpsCIbh3QRfuuvt5H63IsQ1PsBotsbMOmHc1vtP/2TuLGmnPZPAAW1IiBl8ZJVHIQD9rFJYWeNPx8ryUQZa9Wo1ZsJXv/FxIGugsW8+kpntg4VttqSzpYmzjOYiRfEVH78TgBwOvGGVhMMnb8WJjss6nf1nsl/4Ww58uWC0wy8o8YwPkbYCBtWE0NQboN1PAsS7zaDfabLUXKQZHvctjMpp/Yh2+hLToCplOEqm59bJlYqr8rZ8+4Kf4LYvnjYZntOPKvdPIoMxEFvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30LcNrfvgAgJWllqwJMQmTve3HuhGZwm3On0Cpymdyk=;
 b=A36rqX1cXNtObOnKOfaaD2T56I8axnWRupwmYcH6qa40OPfU9BGoivC4hsaRF/SkjL1jEy0JBHPVS1/1Fh79fcwQRL/TGEr8BnDqRnNgI4jkGiun1VgujjZymcW/gh8dPoO/Awu4yAOcn4zq1VSY9u6troREukbWP9nLmuy0G6c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:31 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:31 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/17] drm/amd/display: Screen corruption on dual displays
 (DP+USB-C)
Date: Thu, 13 Aug 2020 17:33:49 -0400
Message-Id: <20200813213356.1606886-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:31 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23237019-d7e5-4739-171e-08d83fd0ce0b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135546FED458B70FAEAF395A98430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKZohkXTvwsg5ojwjg1CwVKAHOel6rEwKNjMbALuSlHaYNfAO6BhhiQClecW1ySxdrjXdtvwA+U4dEpBX21rrxUYzPsbVtN4gR+yqfoBvdzlPC5a+l8TBTndvTsYHrRNprtMIF5ulJOuSc4/sHkoZQG0Peo3nOd+1SbN7GfvXfyTxaXsB+M5Jto6Oz6IqnPaAgB+0o++sCbscr+1MbgSJqHxkRPMzODPkgf142DQtAC1B+nu5i5gL9ej8Ior7gklfaxX8cqyZ3l4vq9aF3vZhwWoAimxj+vNXY1qumaOiezq5WcBlEVeijoYKKC/8tLmwRlXTGrPwCdxW1MqDnepQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +Y87CDzTgni78JyYPbUQRpSnGHg8bir7q/Z2kDA+5ORMIaV2w8S9E9vAnWll0mRT162rX6YOMd1ucDwH6cQmPSAI4C+5OBjud6je6BOHX+adLkrt0NLPczJlgNP9dbslJ3dMFaHANbdrm6OMnAFG4OCp80SZtdD0NFB1z/48SVA9NDljYocRmA2Ly7XI7DRLHaeDdeOkaofTVUz2sb1JSj2mY06R1NGjStG6H/ApFr65BGNTTH3zX9Qt/oBFs6tg0oqv/v9cuwhWybUns/2GN+yuKddG8qY3BH7sXTy//DsBeTXPYA6UfWYqqmnmzsY7q2FI8KQkOzWCGVIHiZv13JQDrvfMjIyrDqdgSHA9f4EWIQp3R4B7JnxlQKCIhRjO9i1rIaYPVkyqU92VBf+7BQEimX1G/yGH+sYVFdFicEJn2hVC2+zhjFEbkpSEKg3q5DJrCW4J9zcuJ0eBZz3K3FoNL6NWkrlo8oRhywwzDoWFlv/97H76Pedt1BklvtrybmDUlWM36le5uRLxgTwYXVeLK5fxV7yiN5/Z5kZGBwB9TMnN1dBOej/teaCTz1zmXqhWytZ7JYVYUI3W0cwUxPyiwU03wSwWiZyjOLxzvSKiWFDc1n0y89rTWQthbJ5i/NlRJK/jsYIWm07p3OG9g/vpTjd230Bn026yb+j37Wxe8wiCYqoJksH9HkdHnrG/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23237019-d7e5-4739-171e-08d83fd0ce0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:31.7268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prkXltVsTvh9+9B9J2kLiQO+nJ6Rbyv6gCjSWzLtanjhs5cdCKkAGrC2CcC1nGRTysqfBUuu5aFMM77YwFH9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[why]
Current pipe merge and split logic only supports cases where new
dc_state is allocated and relies on dc->current_state to gather
information from previous dc_state.

Calls to validate_bandwidth on UPDATE_TYPE_MED would cause an issue
because there is no new dc_state allocated, and data in
dc->current_state would be overwritten during pipe merge.

[how]
Only allow validate_bandwidth when new dc_state space is created.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c              | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a2084f279e7b..dc463d99ef50 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2636,7 +2636,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
 
-	if (update_type > UPDATE_TYPE_FAST) {
+	if (update_type >= UPDATE_TYPE_FULL) {
 		if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
 			DC_ERROR("Mode validation failed for stream update!\n");
 			dc_release_state(context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index c31d1f30e505..1b9874445134 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3209,6 +3209,9 @@ static noinline bool dcn20_validate_bandwidth_fp(struct dc *dc,
 	context->bw_ctx.dml.soc.allow_dram_clock_one_display_vactive =
 		dc->debug.enable_dram_clock_change_one_display_vactive;
 
+	/*Unsafe due to current pipe merge and split logic*/
+	ASSERT(context != dc->current_state);
+
 	if (fast_validate) {
 		return dcn20_validate_bandwidth_internal(dc, context, true);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index a828696668bf..78743ae37851 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1184,6 +1184,9 @@ bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
 
 	BW_VAL_TRACE_COUNT();
 
+	/*Unsafe due to current pipe merge and split logic*/
+	ASSERT(context != dc->current_state);
+
 	out = dcn20_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel);
 
 	if (pipe_cnt == 0)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
