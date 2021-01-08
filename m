Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C23C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A906323A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A906323A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1076E8F3;
	Fri,  8 Jan 2021 21:50:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89AE56E8F4
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McQKaCXYqTNpdsKn6ZfRdyDj8abf2PPS4LAVB1oJMiF41btpzk8MlP8+x+hb6alIWqZHyOMC6xvsLRWMO9aQ8+ctUWBSFPlq/J5zm9rflht9rmvkHx856U2GD4Yt6fJGxTgXV51o2YMQhBAl2TG+qMkMJm44Kju7qH/QYnnGl3b/XrHlAX1J9NGx689x816+G+20WkTeNmUx6hT86pzw5E14Rkk8VD1uG60DnGKiklFKnBtizjDNuLOQ2vPoqLnMClECkWtlV/0JjO2ukwnOAHNibKcmgVfRgpnVWIzd1+EDoYBR+2mICom7Sw+58jc8HO2cpu8x/Jc/NqsMeRPJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDriSmDaYXixrnYf5dXwlyJ0zmZjyBirNnJDZJT+IlE=;
 b=ktcBQMoqh5JrImC78d6WjYUWndLmVfK20hdhAm3+Y5YPN1sCIyO7RgGV9pdxMRy6tro6FGrOVlfqhBYP5NTmW5yK/cxGA0vbp8ICt7cYUwsMhZuxqL14n7BIW1EqXCIySpTrWn5PMGCBB3zPJ3AFbQ1Xk4N6MXefSBN2Zg2BQxwwbA/YQFoJsNfqXvFsnurXfL9hkw1GIx7PyaSEpUUog7H5tMnQw9gfNDNo2VmYYmmF0ho2kErX63wU0hnvqLRE996Jy47fW9QuFTAA/x/3z9PUGBTqXJSOmCBYiE2w9iG6D+lk1W2FZs8nQY8oLurJV9yYYCaI6hHHPigEwgCaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDriSmDaYXixrnYf5dXwlyJ0zmZjyBirNnJDZJT+IlE=;
 b=WIvoutRqvBnQf1NOhB2Z4RoeVmhcdVzTe8C2GYJpVwiFVt4REmpVGOfTEADGN6BqzeG+wljU/Za5lBaXubcLbITNO3UcvMtpQhwqiXnRCElIbFtQMUEkO7JPvKjPk0UxouRp96V4Wlk8syLkjCAAuJOzrxotdJFv0voeeoWLEok=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:52 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/21] drm/amd/display: enable HUBP blank behaviour
Date: Fri,  8 Jan 2021 16:50:02 -0500
Message-Id: <20210108215007.851249-17-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 8 Jan 2021 21:50:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eadc81e3-702f-4a32-e68e-08d8b41f785b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18823732725D08D17DF584D598AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZATARXQ8vrD6jxLP8OnyO3248LS5kcO14rPABZ3QL128ukECRh/HeP6aE/8AAhb3ivwPaHESrZ4mlDIooe6eMYoARk7IAcYoBTkeyrckEo6LaCDx7XLgA7IW54x9boe2oOjFGrVaSif20JrPOTnv85/lgFZIxDMAAR1VTX9ZggoPWdwE1Rrn/TE0PYrUqHuI4m6dtpdSpCxq2GjqJyk+yCcyQxYz4Tgxi5t5eH84jnHZifya20iul1x0XAghuuCCTGPTYDVnD7jPJzjNaO03R0ItNOUljlaE6lux3EgK2ggcZm5KVqxF7Q68VGNSrl0FRyxBYJmEluh4Bm65CM58XZ+08L6X+lZk16p9oehh1y6Mf9Id1D89yOWSVHW7x9uKc7C7vZX5YqQi/1hze/Ufg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Tt03i+/yOqB+a74Jo277IYPXkE2NG8a60TLbhA97oj0uAinYr8zaXULRLZqg?=
 =?us-ascii?Q?oO2U70iyhJSahp0uuNws/mScTPUY7VqCL91nu5VKAIsninPPBhjHxKIPYML+?=
 =?us-ascii?Q?BTAFB3F8vP2CMLM0mmQVoIQb01RaUCAoDs8YxzoAwURSyPAArwg/oql/SX26?=
 =?us-ascii?Q?xxw+oTEJy0J6dlE04Ah+WCqR6Pyz6M/avEYcTWWAE8YmmgXs5NDtVHqCq79j?=
 =?us-ascii?Q?g9PfK0aFaxb1038muZrvrvmEHMpx+YPcRnd6N8Y/R85MeVY0+upCzM4GqAkf?=
 =?us-ascii?Q?Te8sW5O4FXEh1eQLnj9v2HbhE61R0Ws8ZHZoQeammZUBam4oZ0NIT5VbKmxt?=
 =?us-ascii?Q?bzYbWf3B8WpFWtIGLqTUEthljvkqQGZrfZXrxSRREzfJCEJjOpKJUaMHC80v?=
 =?us-ascii?Q?8OLMMXoa3W1SjdI1fOcJ3Q+Vb5rD2pMc3RbOD2F9s9FMo4UWKaulxlFx85wD?=
 =?us-ascii?Q?Opq45auLXZyJC6vp3lSHtY54Qjmc+YyUxr+uLzC+yP97AKEqJG4FljY531+Q?=
 =?us-ascii?Q?5b8xDVSHvZjN6NBfMoTujsR59BD1PKOjkM4aNu/KX1r7b2kBFSWJ5/MvW4At?=
 =?us-ascii?Q?rsp51eaxIYDp4XJ9rw0PiCfBqd+gj0F9LPpU3uAMtjpjQWnzdpQQtJ4r69fp?=
 =?us-ascii?Q?TF4J5xF8nKLniJciVOMA+ZUKnEV8EODt6nAH2oN6GTwDSYhVi807SXkDXH5j?=
 =?us-ascii?Q?eRxSXzM8jFsKYWoopQ41udUHefo49zfSeAmlTZw0sgxf55/2UUR8I1cDcRk5?=
 =?us-ascii?Q?AXgzmRDm4QbUfKboE2t6Q67OavVrjVorR1Jo/xpD/Td9QAgtEOF5YuMfH6u4?=
 =?us-ascii?Q?4APuRkK/Mxi6J/74Y0A+IL5vG9cwa/ovqjznbgB8H8ZWXETco+zAONlpibwB?=
 =?us-ascii?Q?5hazuqMkJWFOfanlxxQrF/ke/NrWIDCGNoGm1oZ2CuuaQnNEqOLsNGWZMFjf?=
 =?us-ascii?Q?4z39Svex4tI8Lk9THpFVTrWTx5d1VGk7SMGUjKIUMGzVTFqFzn5f3Ac7AHmn?=
 =?us-ascii?Q?dXE+ZAR9Vzg/GaBtSMnvcWoo/gAgiKFbREr6GHrfzVdsqWj1K5wI2zuXohQy?=
 =?us-ascii?Q?gRjxAT33?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:52.7050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: eadc81e3-702f-4a32-e68e-08d8b41f785b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umj3tg7YUosJVTC4L8dBi03Ojk8TxpM31GTvBKMnvZlGqmCoFSqbp5jBzmI+f1epZ+vV+67f01b96cW/4lo+Gw==
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

- Reverts "drm/amd/display: Revert HUBP blank behaviour for now"
- Hubp blank will fail if the pipe is locked (this is the case on
linux), so add a check to make sure pipe isn't locked, if it is then
defer the blank to post_unlock.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 11 +++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  8 +++++++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 23 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
 8 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index f033397a84e9..6138f4887de7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -659,6 +659,16 @@ void optc1_unlock(struct timing_generator *optc)
 			OTG_MASTER_UPDATE_LOCK, 0);
 }
 
+bool optc1_is_locked(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t locked;
+
+	REG_GET(OTG_MASTER_UPDATE_LOCK, UPDATE_LOCK_STATUS, &locked);
+
+	return (locked == 1);
+}
+
 void optc1_get_position(struct timing_generator *optc,
 		struct crtc_position *position)
 {
@@ -1513,6 +1523,7 @@ static const struct timing_generator_funcs dcn10_tg_funcs = {
 		.enable_crtc_reset = optc1_enable_crtc_reset,
 		.disable_reset_trigger = optc1_disable_reset_trigger,
 		.lock = optc1_lock,
+		.is_locked = optc1_is_locked,
 		.unlock = optc1_unlock,
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_drr = optc1_set_drr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index b12bd9aae52f..b222c67973d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -638,6 +638,7 @@ void optc1_set_blank(struct timing_generator *optc,
 		bool enable_blanking);
 
 bool optc1_is_blanked(struct timing_generator *optc);
+bool optc1_is_locked(struct timing_generator *optc);
 
 void optc1_program_blank_color(
 		struct timing_generator *optc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b74f79575cdf..18653c423c96 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1765,6 +1765,14 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->vtp_locked) {
+			dc->hwss.set_hubp_blank(dc, pipe, true);
+			pipe->vtp_locked = false;
+		}
+	}
 	/* WA to apply WM setting*/
 	if (hwseq->wa.DEGVIDCN21)
 		dc->res_pool->hubbub->funcs->apply_DEDCN21_147_wa(dc->res_pool->hubbub);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 7f26c9444933..e5cc8f8c363f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -891,6 +891,25 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset)
 {
-	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
-			color_space, color_depth, solid_color, width, height, offset);
+	struct stream_resource *stream_res = &pipe_ctx->stream_res;
+
+	if (test_pattern != CONTROLLER_DP_TEST_PATTERN_VIDEOMODE) {
+		pipe_ctx->vtp_locked = false;
+		/* turning on DPG */
+		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
+				color_depth, solid_color, width, height, offset);
+
+		/* Defer hubp blank if tg is locked */
+		if (stream_res->tg->funcs->is_tg_enabled(stream_res->tg)) {
+			if (stream_res->tg->funcs->is_locked(stream_res->tg))
+				pipe_ctx->vtp_locked = true;
+			else
+				dc->hwss.set_hubp_blank(dc, pipe_ctx, true);
+		}
+	} else {
+		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
+		/* turning off DPG */
+		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
+				color_depth, solid_color, width, height, offset);
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 3ba3991ee612..8980c90b2277 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -309,6 +309,7 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.enable_crtc_reset = optc1_enable_crtc_reset,
 		.disable_reset_trigger = optc1_disable_reset_trigger,
 		.lock = optc3_lock,
+		.is_locked = optc1_is_locked,
 		.unlock = optc1_unlock,
 		.lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
 		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 319dec59bcd1..1fe3fb14afd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5558,7 +5558,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		}
 	}
 
-	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0 && PrefetchMode == 0) {
+	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vactive;
 	} else if (((mode_lib->vba.SynchronizedVBlank == true || mode_lib->vba.TotalNumberOfActiveOTG == 1 || SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank > 0) && PrefetchMode == 0)) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vblank;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 2d77eac66cb0..8efa1b80546d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -333,6 +333,7 @@ struct pipe_ctx {
 	union pipe_update_flags update_flags;
 	struct dwbc *dwbc;
 	struct mcif_wb *mcif_wb;
+	bool vtp_locked;
 };
 
 struct resource_context {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index f7632fe25976..754832d216fd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -190,6 +190,7 @@ struct timing_generator_funcs {
 	void (*set_blank)(struct timing_generator *tg,
 					bool enable_blanking);
 	bool (*is_blanked)(struct timing_generator *tg);
+	bool (*is_locked)(struct timing_generator *tg);
 	void (*set_overscan_blank_color) (struct timing_generator *tg, const struct tg_color *color);
 	void (*set_blank_color)(struct timing_generator *tg, const struct tg_color *color);
 	void (*set_colors)(struct timing_generator *tg,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
