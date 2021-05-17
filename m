Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF17C43460
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BCF610A1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BCF610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5636EA44;
	Mon, 17 May 2021 19:08:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C35896E0D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 19:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0PGoMyC/eke3YyV9f3Ds/PnriwPjXilGO5hVoJUgfZ2BTM8WGZxwrPNRjhhP0Imztq8jM18NzA02UuM7fRHdFF+XhRj32AohQxZcqGVWAcj84GN9jhkRo3Aq0Rqbo3ECUEDy8UZwmVFRXkfpGPB1lWfK5uva8BXhfoE5y4RFLlUDU9ufm52RSQY+sxNkA0DwrWjSUPi5MHxytRJ5BvpVlB9yr6KVMFEIaIqsw8rDf1Cno7NeNNeRFqDrs1rYhQy7AjiAFrQnOxDRiLM3nCV5tmJ9YHwj6Z+4WUtbJkOO+Y7QQJ4LWsdt/PwwncDXcq5BX39E7Q+y9aAPDUja722xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMUyKLjMI0RP2dvwZuu0Zeh1WZKN9RDOGZofWrJIhaU=;
 b=nZ7P8ahPjYLPa84n2rFfR7UTacvxrZnxIQ7ui67qn7qXA7aFb/T6lVO9c8SA7Fx2Rzf2bfLn5V62lHTxwUdwCp8jLsxh7YCc1tFYC390/0nBsQ2HchyWrxiNvZSHM3jpR/8FjiB/Xb1YVGzaTb4odAYo/14HZD9G4FWcqM70rT2Sx3dNl8Nhtk+LFmsUHIDYFngEutQzwjkkCY6py6J6cBEQ7TAnlxGN9uondZ6nL+jx/WAPHpZyoeX+V7ZOlFhcZ5+waA5X7UxlWogzXkx7gNpHXNphkN5YLIvWtGJfc7qHr9IbFH0VWUvq8bavlX/r6dha/kZ595PkD76ajfrmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMUyKLjMI0RP2dvwZuu0Zeh1WZKN9RDOGZofWrJIhaU=;
 b=kTSl9qURDdZV+aKTZsw6s1d+9KuBcf+jqAj7sBsYhMaDd3l93/PZmvTD4sg09TcFEI6C9NSwLx3iWruFyPdfNL0dl6KlyYPMH7C7H6M/z/1p3yy3Ingt9sqsPFWDwJIgbHCDRQctEgUQADTjgDMiW456z1+2eEDyBtWbPL6gQjc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3805.namprd12.prod.outlook.com (2603:10b6:208:15a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 19:08:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 19:08:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/display: revert random whitespace changes
Date: Mon, 17 May 2021 15:08:08 -0400
Message-Id: <20210517190809.1943517-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0338.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::13) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0338.namprd13.prod.outlook.com (2603:10b6:208:2c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Mon, 17 May 2021 19:08:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8743204-133f-4c05-b60f-08d91967284e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38050A32A581EE789FE14101F72D9@MN2PR12MB3805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTfDs73hJlGZvGRTAFCS1tOSEgyHZcmWmNEMGGUBbst3kjvHojEyORfROAHLhWWffiLFlZ7xAhzu8SjYfCujZwYUW5AKJW1hkxcmBvAMVNb4PvghqwKs/QF5riycoMhlR91JCxNOs0u/iVUz+mU23LYn7CCu/cDZduOLOxEzCogdb+W4rb2bFZdTsz0Je0K1cbanohaMCWHZ+RQbP0Qzwd0DL1hUBG3/lk70uvi2t2EabSAHeVsLOBT8bJ0MU/jc/WIvwkVeunhbzX5vo2PIYXzmvDlcI4XS1a1ymreX3YBgCO6sfylaeA49CBPWHJNVSVn2i+ni2Uy5DjczlQecXcWDqjnmqYuSoOsWSzWdiquhkovK6cFiCuxEwwO3zUQ6WgUniPTcuwo1HSe/a+D7WGGSOHkI6uBQqCNk4Bq2Ovb0hOVAUR/sV97Q3N+PaQe3tmB3Nlkdiynh8wzFS+a5UFNcHlaIKsPdhXrR0UASQpMgMeH1KHuOTaK9UktHDZSyEKii3OVqS+8Q1EVF5N52Y+Y+ycFlHhY1HQEDCZIuN2qjUwkPHxl1ZJanMxspdGrnAPUJ6h8eP1AOwBEAonH5ZcZCgGixBpaQUeh9pOaI+lsEDugGDE4O+78R9pi2Rp4NX9J24ONKVTAgmPS4zXN0f5oM+RxBGNJZ0UKfAC1G0WM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(316002)(54906003)(38350700002)(38100700002)(4326008)(5660300002)(7696005)(66556008)(478600001)(66946007)(8676002)(16526019)(956004)(86362001)(52116002)(186003)(8936002)(6666004)(36756003)(1076003)(2616005)(2906002)(83380400001)(6916009)(26005)(66476007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7S7mW7vp6GjsbHAxpoa6oS2/6jrJBOX2Fu/zRLMuTAoIF2do+2AOY35OV0BK?=
 =?us-ascii?Q?5mSd7jx8Ukgutv7wuG2J3UYmeoZzFWQgvqAS5OPdDJ8GaTacSFtLQpvvmhBj?=
 =?us-ascii?Q?l3f4+6T/gSnPzmGZQsSB1+vaeA3E3qRFAv9owViIwqSo7B2ib0fpdOn4qay6?=
 =?us-ascii?Q?P8N6n8Lh0TKDPKOOexkfKn/z9ioFC8cozyvdCj5blOYlzZJJU1RfffiWnTSW?=
 =?us-ascii?Q?4A8dvoPbHJ6d0IBLPU4usAyGyFZ89Di3RHQ20/kbRj60QGXFoHQFPLHuznpQ?=
 =?us-ascii?Q?XsJlhnpRxjk1SN23yYSbf9e12T6tmCmnUFRRyfsk626cVYeFvhW7O+GoZ0Id?=
 =?us-ascii?Q?yaq9Ea2EDyvppeWMS7NMYfvPOmUoPYzwx8I7k2Buspz5hDF3ZkovKO/7cMyJ?=
 =?us-ascii?Q?dqMgvI2uWARWVgJoBn4ZMv+GgQekzMxYHwWFFe5JwKEWGsft2XWIudjNGdf5?=
 =?us-ascii?Q?esC0c8cScdj3eXcwPMy5zwWBEUOo4GgBrUnj95SIw13cT8MlOqANduzjlglo?=
 =?us-ascii?Q?sOdFqCyVawjqP+V5dCo9eTcCwTGG00oawp8Iz5WsKrcmxaji/9csW0T9VHdJ?=
 =?us-ascii?Q?piicH+snzObhkvEFp8PEoqEh66hKYKsSB2GabpLJK8nZKdp0dJifFfDKMb51?=
 =?us-ascii?Q?XgTsSx6sS4lknHUVtaZIvOOdSfj4gz8YlwLnm5SbocIpeVYdlwnXfpf5Ke3/?=
 =?us-ascii?Q?qFEfs5dH2uP7pc+9npoHM22pRk+C5Gk6nVcAxGJpDOwJFO8sjBS0aOrNaJOt?=
 =?us-ascii?Q?57Voit0dOEbDZ/oQNOa3o3xR+xvrqw9DndbGYc7PIE4de/bq4tcxHA5Gkkjh?=
 =?us-ascii?Q?Roi43xO/LEp47rjXQtdUNIDbOIzullDG+VAx1aHxsOQxLWm9eALMD5IjcE+J?=
 =?us-ascii?Q?qv5xMj3o3CzcECACmcHbwrkF2Hb/Tkx9f7j+1l+GXl5h96520jYZ9w35lbmj?=
 =?us-ascii?Q?R3oYeUjvx8POUsTeYz2kVsgrRJ0VmUaGb8c8vx10I7m/lCfG0h2D0sm/dJkx?=
 =?us-ascii?Q?MOntHgdAYoNcT/r832KzIeaeNAkX7nLzVVB0h7BVFNwFpgK/Z46f8JRYP/hV?=
 =?us-ascii?Q?AgKPtNAynZIDa9uR7MIrLAMv1w/3asB2R6SZqwzgwCrxv2oqId21Vm5//XmS?=
 =?us-ascii?Q?MamWOOpzxgMXhXdWXWCQI78VSGb87OxrrvZe6aza+IE1/uS90sSdrmYsTcxW?=
 =?us-ascii?Q?CucwLg2sW7eeKq7j+DV0XIAVpqHNdMe3noAZ2oKj+Iqf7W6Zne02MDwCozs9?=
 =?us-ascii?Q?wCXf0wyfRhAXmHHSWjCtecDMF8bZITFbcAC130o3BQw5lXg/VfijEt+oS4eL?=
 =?us-ascii?Q?h6fTvKKCPNXkdqAt8rJhXasP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8743204-133f-4c05-b60f-08d91967284e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 19:08:30.0737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCHZk1hzW4CA3Ec5sQarC4prtejmy20Zhu/nXnLmunxnuD9HtpuZI+TKF2P7IINO6E2jRIdi9IKtTJItOhmZLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3805
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Wyatt Wood <wyatt.wood@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit 458ef68e972878 ("drm/amd/display: Add get_current_time interface to dmub_srv")
introduced a bunch of random whitespace changes which lead
to compiler warnings.  Revert those changes to fix the warning
and keep the code readable.  No intended functional change.

Fixes: 458ef68e972878 ("drm/amd/display: Add get_current_time interface to dmub_srv")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Wyatt Wood <wyatt.wood@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 36 +++++++++----------
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |  8 ++---
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  1 +
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b4aa20250301..ef157b83bacd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2636,14 +2636,14 @@ static void commit_planes_for_stream(struct dc *dc,
 						top_pipe_to_program->stream_res.tg);
 		}
 
-		if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
-			dc->hwss.interdependent_update_lock(dc, context, true);
-		else
-			/* Lock the top pipe while updating plane addrs, since freesync requires
-			 *  plane addr update event triggers to be synchronized.
-			 *  top_pipe_to_program is expected to never be NULL
-			 */
-			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
+	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+		dc->hwss.interdependent_update_lock(dc, context, true);
+	else
+		/* Lock the top pipe while updating plane addrs, since freesync requires
+		 *  plane addr update event triggers to be synchronized.
+		 *  top_pipe_to_program is expected to never be NULL
+		 */
+		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
 
 	// Stream updates
 	if (stream_update)
@@ -2659,10 +2659,10 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (dc->hwss.program_front_end_for_ctx)
 			dc->hwss.program_front_end_for_ctx(dc, context);
 
-			if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
-				dc->hwss.interdependent_update_lock(dc, context, false);
-			else
-				dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+		if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+			dc->hwss.interdependent_update_lock(dc, context, false);
+		else
+			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 		dc->hwss.post_unlock_program_front_end(dc, context);
 		return;
 	}
@@ -2789,10 +2789,10 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	}
 
-		if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
-			dc->hwss.interdependent_update_lock(dc, context, false);
-		else
-			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+		dc->hwss.interdependent_update_lock(dc, context, false);
+	else
+		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
@@ -2838,8 +2838,8 @@ static void commit_planes_for_stream(struct dc *dc,
 				pipe_ctx->plane_state->skip_manual_trigger)
 			continue;
 
-			if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
-				pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
+		if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
+			pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index e7c56df8f762..b0c9180b808f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -795,10 +795,10 @@ bool hubp21_program_surface_flip_and_addr(
 	flip_regs.tmz_surface = address->tmz_surface;
 	flip_regs.immediate = flip_immediate;
 
-		if (hubp->ctx->dc->debug.enable_dmcub_surface_flip && address->type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
-			dmcub_PLAT_54186_wa(hubp, &flip_regs);
-		else
-			program_surface_flip_and_addr(hubp, &flip_regs);
+	if (hubp->ctx->dc->debug.enable_dmcub_surface_flip && address->type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
+		dmcub_PLAT_54186_wa(hubp, &flip_regs);
+	else
+		program_surface_flip_and_addr(hubp, &flip_regs);
 
 	hubp->request_address = *address;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index 7a3beaecd19d..9a3f2a44f882 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -264,6 +264,7 @@ static inline unsigned long long dm_get_timestamp(struct dc_context *ctx)
 unsigned long long dm_get_elapse_time_in_ns(struct dc_context *ctx,
 		unsigned long long current_time_stamp,
 		unsigned long long last_time_stamp);
+
 /*
  * performance tracing
  */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
