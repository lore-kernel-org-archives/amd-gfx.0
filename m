Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91981C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3260522AEC
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 13:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3260522AEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E226E113;
	Mon, 25 Jan 2021 13:44:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44E089FD4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jan 2021 13:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmeUCwupf2Q6ABtGXseC4Z278fK3TvpngClVs4rDXdpilekpVWrrG537D3rrPgv+0PrFboS7NyiXifVzux2ttqsR0K2CQjmWJgp4a1fxcsfuk1MS6ZNX11JZx1TEWIkNaaSuj3ju4CLpZ7j6/sq3FLrl/9ubJYqAZeT1uy3hjUt4BUdYutO+9KoN/G2LdvSf0T94MmYhLLrqIOv6dIP3+H+Tdfw/e34hgQWtUv5ttvxfFfSHLdXRSOvNuzpN3kJq3GuH0opkc6mglnVmbSogvNLJd7EFx+oiv0XjQeS/C/ljgP0Y5R2+S8EHBIvIaiBhLyTtwXrvCkN4cG5NDFdEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHQbIRKXIY36C6Ohu9bLpKTVYiuKr1DnkhYT081/oM8=;
 b=TWY9tqZ+XLKZ6Mdz9TMry74Uh4V5j1Cmhtdrs5qQChCm1+I1Vu8Acr5Vhp6lpBwWC5uT0F0ZC+Xvg1ThJ1PgcOccPOtHw3SetG5ymaNrlzcjzUpKhYeV+cTNPk2wAXhrcXd2utcmT8xIVS5zv3oddroCZA8f+W5Tl3Dd4CRp+LNtooq0T7go/2sqzoLxqPY8RevGczBlAALY0JfAW9C4iJLg3O1Xc/1eS581XiMD/Bpr79t84zmH+xFIyLwnMSsbc9Z5pd921xpvltR55VKi6SG4o+UCQTUEpjl4RY+R4Xm7RkV6jINdGvWLLtMEfXTgZbEyfA1M+FRbjdCRj3GSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHQbIRKXIY36C6Ohu9bLpKTVYiuKr1DnkhYT081/oM8=;
 b=KKKrNtaMSLM/DGBo86FjSzWeU8v0wAE/rPjfertqT46qoNYTldHFItlQt1GprpFY/XKXXeSjB04+lhwx/IGfyeCvXNx0Rli4GHk79dxJ3TvuOXZs0dYDBmdEDkndfsQ5dglbVZOuCJ7kL4x481IJ5/sHH/QileXeMtJSMmeM2NU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.13; Mon, 25 Jan 2021 13:44:19 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 13:44:19 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC 5/7] drm/amd/display: Move patch bounding box to FPU folder
Date: Mon, 25 Jan 2021 08:43:11 -0500
Message-Id: <20210125134313.305184-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
References: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:7f86:f3af:1efb:628a]
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:7f86:f3af:1efb:628a)
 by YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Mon, 25 Jan 2021 13:44:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a428c5b-07cc-4bc1-ea9f-08d8c13750d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43408E283BAEED90791B13B598BD9@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:43;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pA7YMOQ2mLMMrl+WV1oyuKtlQguQE3RuBo5O21wl4brwtXn/efvZT/HYENzor38R1fkgTxXPIR67PjFpzCeDpCNZmaxk22BIUDfaibPl5Pq1JncOb2T8OQeZMuc8PMtC3mc9tgRq0viKotDxI7++BQ1opPkzL38kFmEU1PJcnUYeiqqgcEOgS5MMRJC/UlD0K+LuAsolzNrCU0mXPeYrgxBl21/1366e68M+HQDIjZLka0iKB/9CIx09NwrJngCIgioEYVVNejN3UFNcZKH62wxYxgvlpStz/662NNXHz+F0gb+XQxhEyQW6dhm/bihPIyd0NlPLzmpl5kWkLwxbGtiXaOA6DHi3C3QC5X26xfrq5PzFDoedDL/HdMKZfL9TnK62ckzvWthUb15xu1AIXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(52116002)(54906003)(6512007)(16526019)(6506007)(5660300002)(4326008)(8936002)(316002)(83380400001)(186003)(2906002)(66556008)(66946007)(66476007)(478600001)(6486002)(86362001)(2616005)(8676002)(6666004)(6916009)(1076003)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ia4/RfOApdEaqYMxMw+57iviiqFanWAoNamwL6g5KoQHE+FyyyQE2jJ3lX2D?=
 =?us-ascii?Q?kneTxYnz3PLoSVrSkD/ThKV3YES9bbDjt8Jvv1woGrURkGPYSTTG0sDdlsCI?=
 =?us-ascii?Q?rAgYEDOjj8VCEbScDVEMxfsmJ46YtfXvS8vq8yxS9deNm+I89FoovmVAxeaQ?=
 =?us-ascii?Q?JSmAv3Pj3otw6OMPvSBxr0dnyPrK6s5/rcSD0bjEa5S/oI0mzUz3qedZdX7j?=
 =?us-ascii?Q?Eudqm6sgEmlsN4teYZUXr6GfMQBWpEWenwmKyTt+jcm29jpHYggfO5m96cIB?=
 =?us-ascii?Q?CVUiWswAog8mJErjjf0O8kYjNnfKv6eESMnWOmUlDnqVnl02gcC3aoXJcS3S?=
 =?us-ascii?Q?qn/KIQfasFwmAAxkj5kMpGHLwneTzuTFtSRqmXjkop4QCt2ls6mZzrHNRSiU?=
 =?us-ascii?Q?PFvTq4udUEdqbHZE4FAX3apsHDNg93QNn2O6p5gXfrZ8ZHm6vT9q9dWGjICm?=
 =?us-ascii?Q?j2i7TZbz/BD//bpy5GxOf752USC+ms/RsuL150sqUommlOrb2BCo1GT6w3G1?=
 =?us-ascii?Q?4hdqBf28qIRJi5he+3hERN4VADuXHJG9/T31jDuQ+GpRbhgzJSvUA/obdeNn?=
 =?us-ascii?Q?Y9BMd3NIo6ZrckfmO/LN3oZzTgDK/hPfKsemMGtctJW2ra9SLZcv7VB7higo?=
 =?us-ascii?Q?QXmbJBzh45gy815uiKN3sj9b8OkDXitWL12FvVEM9hIEcy/BXmMeCuqhOVzp?=
 =?us-ascii?Q?GAX2F/pBTP9kX2ixsvNMd8Bf0aUYCaR47Bz8wy8hOsIzivmqiJRuNISWvWEG?=
 =?us-ascii?Q?7dwiSdYCis/SXV1Cgryj9hTq2KqdoBnp2Pb7lO3q6DkYZ2fQ5so38+Imp6OI?=
 =?us-ascii?Q?RaP1AKV/38ex1Gpq79I4cOLv+B1cvvX5wf7C/rnB6zkGMbpGNBVuKvrbZ6an?=
 =?us-ascii?Q?0AgcNlI+ZVNtHVm74RHGIxFfSJsygdOSVBouPdX5I9Yr/64pNAX8aSXnS8mG?=
 =?us-ascii?Q?InXQ7NibGLksSTaa79tUFRUvkoN1tuDWCo+mCIP6slynIy/69hVnfQm1lzll?=
 =?us-ascii?Q?MQVUkr9OhXhvyOlRm2/laetOmf9SyEAVsBq7a+buY3sBp3V1iChSgmni3F4z?=
 =?us-ascii?Q?CjXYQVQemIt0u2shDM6rkk70XrC7TK4VgOoc7ggPXihIkMnGNykNCl3/v1us?=
 =?us-ascii?Q?znFM2NNOlxZ1yrSucrI1ZdexpkJqoTErQg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a428c5b-07cc-4bc1-ea9f-08d8c13750d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 13:44:19.7485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PruZh6z6B1QKqmecA9ZVl/47PXSwS4wrecg/2zU7kMlHyVATO/pdW9THfV0JNXb1u+wPIqwMFQO+TPBJnvQ/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function dcn20_patch_bounding_box is shared from DCN2 to DCN3 and
uses FPU operations. For this reason, this commit moves this function to
the fpu_commons file.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 36 +---------------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |  3 --
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  3 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |  3 +-
 .../display/dc/fpu_operation/fpu_commons.c    | 43 +++++++++++++++++++
 .../display/dc/fpu_operation/fpu_commons.h    |  3 ++
 7 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d5bf740b408c..e9257999148e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3472,40 +3472,6 @@ void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
 	bb->clock_limits[num_calculated_states].state = bb->num_states;
 }
 
-void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb)
-{
-	if ((int)(bb->sr_exit_time_us * 1000) != dc->bb_overrides.sr_exit_time_ns
-			&& dc->bb_overrides.sr_exit_time_ns) {
-		bb->sr_exit_time_us = dc->bb_overrides.sr_exit_time_ns / 1000.0;
-	}
-
-	if ((int)(bb->sr_enter_plus_exit_time_us * 1000)
-				!= dc->bb_overrides.sr_enter_plus_exit_time_ns
-			&& dc->bb_overrides.sr_enter_plus_exit_time_ns) {
-		bb->sr_enter_plus_exit_time_us =
-				dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
-	}
-
-	if ((int)(bb->urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
-			&& dc->bb_overrides.urgent_latency_ns) {
-		bb->urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
-	}
-
-	if ((int)(bb->dram_clock_change_latency_us * 1000)
-				!= dc->bb_overrides.dram_clock_change_latency_ns
-			&& dc->bb_overrides.dram_clock_change_latency_ns) {
-		bb->dram_clock_change_latency_us =
-				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
-	}
-
-	if ((int)(bb->dummy_pstate_latency_us * 1000)
-				!= dc->bb_overrides.dummy_clock_change_latency_ns
-			&& dc->bb_overrides.dummy_clock_change_latency_ns) {
-		bb->dummy_pstate_latency_us =
-				dc->bb_overrides.dummy_clock_change_latency_ns / 1000.0;
-	}
-}
-
 static struct _vcs_dpi_soc_bounding_box_st *get_asic_rev_soc_bb(
 	uint32_t hw_internal_rev)
 {
@@ -3580,7 +3546,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 
 	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
 	loaded_ip->max_num_dpp = pool->base.pipe_count;
-	dcn20_patch_bounding_box(dc, loaded_bb);
+	dcn_patch_bounding_box(dc, loaded_bb);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index 11ec655a18e3..4e6fda59ec29 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -167,9 +167,6 @@ enum dc_status dcn20_add_dsc_to_stream_resource(struct dc *dc, struct dc_state *
 enum dc_status dcn20_remove_stream_from_ctx(struct dc *dc, struct dc_state *new_ctx, struct dc_stream_state *dc_stream);
 enum dc_status dcn20_patch_unknown_plane_state(struct dc_plane_state *plane_state);
 
-void dcn20_patch_bounding_box(
-		struct dc *dc,
-		struct _vcs_dpi_soc_bounding_box_st *bb);
 void dcn20_cap_soc_clocks(
 		struct _vcs_dpi_soc_bounding_box_st *bb,
 		struct pp_smu_nv_clock_table max_clocks);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 4edebee00095..98acc8be698f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1563,7 +1563,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
 	loaded_ip->max_num_dpp = pool->base.pipe_count;
 	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
-	dcn20_patch_bounding_box(dc, loaded_bb);
+	dcn_patch_bounding_box(dc, loaded_bb);
 
 	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
 		struct bp_soc_bb_info bb_info = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 934df194db38..e56925a89e4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -36,6 +36,7 @@
 
 #include "dcn20/dcn20_resource.h"
 #include "fpu_operation/dcn3x_commons.h"
+#include "fpu_operation/fpu_commons.h"
 
 #include "dcn10/dcn10_ipp.h"
 #include "dcn301/dcn301_hubbub.h"
@@ -1502,7 +1503,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 
 	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
 	loaded_ip->max_num_dpp = pool->base.pipe_count;
-	dcn20_patch_bounding_box(dc, loaded_bb);
+	dcn_patch_bounding_box(dc, loaded_bb);
 
 	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
 		struct bp_soc_bb_info bb_info = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 539757ec3348..8a62ff16347a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -43,6 +43,7 @@
 #include "dcn20/dcn20_dsc.h"
 #include "dcn20/dcn20_resource.h"
 #include "fpu_operation/dcn3x_commons.h"
+#include "fpu_operation/fpu_commons.h"
 
 #include "dcn10/dcn10_resource.h"
 
@@ -1098,7 +1099,7 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 	loaded_ip->max_num_otg = pool->pipe_count;
 	loaded_ip->max_num_dpp = pool->pipe_count;
 	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
-	dcn20_patch_bounding_box(dc, loaded_bb);
+	dcn_patch_bounding_box(dc, loaded_bb);
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.c b/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.c
index d2089a1dc630..5ffab6715085 100644
--- a/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.c
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.c
@@ -93,6 +93,41 @@ static void _dcn20_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 	}
 }
 
+static void _dcn_patch_bounding_box(struct dc *dc,
+				     struct _vcs_dpi_soc_bounding_box_st *bb)
+{
+	if ((int)(bb->sr_exit_time_us * 1000) != dc->bb_overrides.sr_exit_time_ns
+			&& dc->bb_overrides.sr_exit_time_ns) {
+		bb->sr_exit_time_us = dc->bb_overrides.sr_exit_time_ns / 1000.0;
+	}
+
+	if ((int)(bb->sr_enter_plus_exit_time_us * 1000)
+				!= dc->bb_overrides.sr_enter_plus_exit_time_ns
+			&& dc->bb_overrides.sr_enter_plus_exit_time_ns) {
+		bb->sr_enter_plus_exit_time_us =
+				dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
+	}
+
+	if ((int)(bb->urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
+			&& dc->bb_overrides.urgent_latency_ns) {
+		bb->urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
+	}
+
+	if ((int)(bb->dram_clock_change_latency_us * 1000)
+				!= dc->bb_overrides.dram_clock_change_latency_ns
+			&& dc->bb_overrides.dram_clock_change_latency_ns) {
+		bb->dram_clock_change_latency_us =
+				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
+	}
+
+	if ((int)(bb->dummy_pstate_latency_us * 1000)
+				!= dc->bb_overrides.dummy_clock_change_latency_ns
+			&& dc->bb_overrides.dummy_clock_change_latency_ns) {
+		bb->dummy_pstate_latency_us =
+				dc->bb_overrides.dummy_clock_change_latency_ns / 1000.0;
+	}
+}
+
 void dcn20_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes, int pipe_cnt, int vlevel)
 {
@@ -100,3 +135,11 @@ void dcn20_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 	_dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 	DC_FP_END();
 }
+
+void dcn_patch_bounding_box(struct dc *dc,
+			      struct _vcs_dpi_soc_bounding_box_st *bb)
+{
+	DC_FP_START();
+	_dcn_patch_bounding_box(dc, bb);
+	DC_FP_END();
+}
diff --git a/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.h b/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.h
index 8d23fa8e87ee..1eda6a4399a4 100644
--- a/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.h
+++ b/drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.h
@@ -31,4 +31,7 @@ void dcn20_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 		int pipe_cnt,
 		int vlevel);
 
+void dcn_patch_bounding_box(struct dc *dc,
+			    struct _vcs_dpi_soc_bounding_box_st *bb);
+
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
