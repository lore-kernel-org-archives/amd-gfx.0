Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37EBC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7F8611CA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7F8611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630856EE04;
	Fri, 14 May 2021 04:51:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2270E6EE04
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff2DvJmKxF2RNMzXrsoirXEwCDQUV5fVxOVLhf354uMOq6mFwMZZzjTwgSRT15Tpa8PmglcJHwTANRO5u2r6vOaAB0WeUiSab8BvX+tTffjixL9XbQkhYqjjn/cztWK4dFuF8asTB/6fNpsY8nXcqtZGvbdqDMec3FSrdaGVkJPf0hYLeFcXRyKSStMeV+c9tWQk/kxsql0eDepWgdTdLnDtsxdDYcKGoLB/VUr0mI6X9NIyzalYDy33HMcJqar+iPero+vheuAWomt/Kby9JvfdGGFb7LkJ9mUxg+jq4s76FvmoVf5sd0W7dIflDa2CczSOUpeRJRAOlURT4M/tDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdSIyTPSMVl/QAphtyy5MvtcEdNxPeZNvnlIZmfy5nc=;
 b=Vb5IzHOCQ9tPtowE1QWXPlH7EObE/X3bb4gf4uyJzoXEF6jCV0zP9HiRhv8mrybCHzeldG4ljKU+2fSfGf0pdzlL6FAaE51k4mihORnU7E0lU+J1b1h3AgBPYBOzWE2gceVNv+L03RvNxTyxgVCrIl5mjpaAuSgtJaOLX5yFMILgUa1cYjz0hYkJeTzE2HC+Z29K9j0Pjx03kF2jZZHE1SNkF2o7s1D7TQ13qIFYcJkKWqb3YMoNo7f6R1YYzSF/jhhTTokOQvOJUCVlBtNCdjyhoDWYcg1QMEuOxqOyR1pJNgel8TVKjEpwsson7zuzNh9xUYOOFgRQf4tx+QOlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdSIyTPSMVl/QAphtyy5MvtcEdNxPeZNvnlIZmfy5nc=;
 b=cmtdHEp0oQeIwMWPqqXbTJWkL26II9kDSLGs3ixFBMlwrmR6fa4Ckzc5KYl6jvlLutoruXwxVr+VHmb3YGmE9V+t5ZKKnz5FB6inwmjxlHZKYtR3EuHcXJlBfoqxXLwdPx70smPue5J7QWd60QTJ63R9d+Nma5fg6chQDHAbu5o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:51:31 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:31 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/20] drm/amd/display: Refactor and add visual confirm for HW
 Flip Queue
Date: Fri, 14 May 2021 12:50:01 +0800
Message-Id: <20210514045003.3069681-19-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:51:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91c34873-9d2b-466f-8ed8-08d91693f0f0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31293AE67E2D5D273387426DFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z48RbRPqE0gbfgggtF//Y66Lg2bWk2M4ozg11V0nNQByOAc6L4sszOdTL8l4JCevZCZFuePpDztMQ+3a6otXmhxxxOdA+P6w1zlBF2tmdIIkbWJ8nT3zULVNI9DJlhRbQperrZecvXGkoQ6xl3XnsM6N7qvh7G6o5JEg3vY77SdsuUaUIqbZGHsnmWvWJU+3JVfwdc7yS9vy4LBJ9cmJWiLLHlC6wEmIKvaaDuMSBFhArrEepTuXVffvlRDyuKfpYLSu+9LzDlz+dn20oZ8EsNTXtgbYBc5b9Tqogi813augoEQvorlLRWgw6IvpqQczSBRcjtIE4Wn/2tJNU7piEYHX1/hrrc3MGXAXN4JV1Kkit8hvUSHGQm44MaBGGLYal06+BwxBdLAQ51HyQwJobHOaoowBM5vi+IfiIel2k3O3U6gg2Pn7arMu+PvLwRdyKbhWuzTHpqCOWe8ghyhZatb+q6T2q6tnDqYhlWh3BZv80gRGAmH7drsy1Rm+ExzXD720nIfYpf3LJSoEUfKVvtI4UYF3GIMRtPXnWf1UzOOc28tQ3Oaj/z54pvu2d/gisDjG4TUqX7VUiJ17JArp9Wr90fx/zQ9MPeIUodRs3u7xwOxutU9jH8LoKrk13KzN6cQKyo9qGrIu/szoxgDUGZY4y7sUmZDbyPHFIdHUIaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(30864003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7xM47LygDH9D8RBJtBhFLKqXu25BgAw4GVDVWqkAGQAjBum1DxGba2uisqUm?=
 =?us-ascii?Q?HBkmWckw0wa6+DP1b+6Z+0AWckigo0zwEcHxX67HtpGYXn7CZ0dG6MPoX2hF?=
 =?us-ascii?Q?SkU6YX397FsxtTV/+a4v8SA1X2ZmiNwFEYGlu6nrb60dSQTJM3EzCTj56HJo?=
 =?us-ascii?Q?upatVho3pY+j9uv57Xmp0gdf3Tm/olF4EuIjAbxL1keYC7sGmDkUuHUxtj6U?=
 =?us-ascii?Q?+73Hky5d42F+e4JlEDlt4WJtvklB8NbM6GYeq6rfXrt4wflUruYua5mkds1S?=
 =?us-ascii?Q?d+yJSC5kCWq6F/Ih7hEAzuzuVaMWJvILOLTclPqwZAfpdTKIUySDV76wstbI?=
 =?us-ascii?Q?2DxuvqLVHWMXb9GJWrUP8LNs2hKwcFfz/dIPh1rahN0HWq4OzNURu+VkpMpA?=
 =?us-ascii?Q?cLFdrCSqLE/9w+nskrgk9VCtqBUNLEyI6LFdLJu12esFi7YD7SXNv+UpsyPT?=
 =?us-ascii?Q?U9DjCdncmK6ImdMZyDeXLGfttcZ9KjX5wsWRnzI9D/80wYEBjJ7w3c6W6AxM?=
 =?us-ascii?Q?7wtKzWamBK2+Oh58E82XUPdc5CnAayhk8h5N+XE4ADExXJ4Tc18axnSm5oIc?=
 =?us-ascii?Q?VEASRBLZum8QjkMLOxQAKyqVd8PIcJ15TUykv1kHmj0eq0X9ad7xW+Dvj8LS?=
 =?us-ascii?Q?G4M6low5+PPH4JCn6yE/Pzp4PBzLmO6GzNFbwFjL/X6uImTI7H+Rtj00wraS?=
 =?us-ascii?Q?MZ4tIp3SivgsImVQ2fHSvzkd2qreBcV3x8LfHNFqRuCAAdMUsWrbwqptH73z?=
 =?us-ascii?Q?5t+95iymlOg4TrsGpekO9hcSO8xmF/5QSwwadsnuPeGavJXbnpKPGzUJ6b/Q?=
 =?us-ascii?Q?Rpuvnx3Km2AmlHFCcv2czkeXeLIxQVcm16R5Tx83YVqGsTyCw8uNV7xaUxj5?=
 =?us-ascii?Q?+m6zDHNU2srOTOXphIsCgGYRijy0hDfZ+Uv+ToiDjA2CDN6aMHjBfpiVljZ0?=
 =?us-ascii?Q?ykQIlZ8pFARGFwZnYs1ERsb/JcokHity7r0lVtBedxk8GzhU6gVVTSRtYVgK?=
 =?us-ascii?Q?6KtgN2b1oAUh/MDBi/ZYvkFh0muJ2/bmzRPvINYYUlxq6OFgUNqW7Hhea6ya?=
 =?us-ascii?Q?obtNAVtmQbPIP1j+QeyjU8SSPDqnhq4B0cSWkzHRSCDVcj22QVJ+A1H6EMMS?=
 =?us-ascii?Q?1qh+bKFWP6DxLSvK0NIM7Qtz1AJu0nLSXaXnv9xCMfmYOY98D12q0F1Tcucq?=
 =?us-ascii?Q?TCMn5Juk8Xfb1AVdN+aSRxTiCwWFAmu7TCkIoaLQ0tvDi+/1CJ6CPHePaQhN?=
 =?us-ascii?Q?LvHF+3wO9Z678IfcLZCWnts2P4tfFa+dnm23dYA6Dz9OfhlL3K6UX38ZFvuY?=
 =?us-ascii?Q?g9zOEjVswKZudCkbShjVxvXckVFncfK4uA5E+TBI214ZQw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c34873-9d2b-466f-8ed8-08d91693f0f0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:31.0265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ch/8uDGNVvdmuUKrZ6v7/9bkCBWRv4qV6/gZzgJ5qmNxl51k16ElTMK8CuMwEYxAYttfCGSgb9xmT6mKs2UPiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Visual confirm will indicate if driver is programming
the surface address.
Refactor is required because much of the visual confirm
logic is buried deep in the mpcc files.
In addition, visual confirm is not updated during fast updates.

[How]
In order to have visual confirm for driver flips, visual confirm
needs to be updated on every frame, including fast updates.
Add a new hw sequencer interface update_visual_confirm_color,
and a new mpc function pointer set_bg_color.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 31 ++++++++++++-------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  6 ++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |  5 +++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 28 +++++++++++------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  5 +++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  2 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  3 ++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 +++
 14 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 8f11e2b58cd7..85a947015945 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2502,6 +2502,23 @@ static void dcn10_update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state
 		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
 }
 
+void dcn10_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx, struct tg_color *color, int mpcc_id)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	struct mpc *mpc = dc->res_pool->mpc;
+
+	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR)
+		hws->funcs.get_hdr_visual_confirm_color(pipe_ctx, color);
+	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
+		hws->funcs.get_surface_visual_confirm_color(pipe_ctx, color);
+	else
+		color_space_to_black_color(
+				dc, pipe_ctx->stream->output_color_space, color);
+
+	if (mpc->funcs->set_bg_color)
+		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
+}
+
 void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct dce_hwseq *hws = dc->hwseq;
@@ -2513,18 +2530,6 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	struct mpc *mpc = dc->res_pool->mpc;
 	struct mpc_tree *mpc_tree_params = &(pipe_ctx->stream_res.opp->mpc_tree_params);
 
-	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR) {
-		hws->funcs.get_hdr_visual_confirm_color(
-				pipe_ctx, &blnd_cfg.black_color);
-	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE) {
-		hws->funcs.get_surface_visual_confirm_color(
-				pipe_ctx, &blnd_cfg.black_color);
-	} else {
-		color_space_to_black_color(
-				dc, pipe_ctx->stream->output_color_space,
-				&blnd_cfg.black_color);
-	}
-
 	if (per_pixel_alpha)
 		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
 	else
@@ -2556,6 +2561,8 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	 */
 	mpcc_id = hubp->inst;
 
+	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
+
 	/* If there is no full update, don't need to touch MPC tree*/
 	if (!pipe_ctx->plane_state->update_flags.bits.full_update) {
 		mpc->funcs->update_blending(mpc, &blnd_cfg, mpcc_id);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index c9bdffe5989b..478180b96d8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -206,4 +206,10 @@ void dcn10_verify_allow_pstate_change_high(struct dc *dc);
 
 void dcn10_get_dcc_en_bits(struct dc *dc, int *dcc_en_bits);
 
+void dcn10_update_visual_confirm_color(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color,
+		int mpcc_id);
+
 #endif /* __DC_HWSS_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 680ca53455a2..4ff3ebc25438 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -82,6 +82,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index b096011acb49..da74269feb75 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -64,6 +64,8 @@ void mpc1_set_bg_color(struct mpc *mpc,
 			MPCC_BG_G_Y, bg_g_y);
 	REG_SET(MPCC_BG_B_CB[bottommost_mpcc->mpcc_id], 0,
 			MPCC_BG_B_CB, bg_b_cb);
+
+	bottommost_mpcc->blnd_cfg.black_color = *bg_color;
 }
 
 static void mpc1_update_blending(
@@ -246,6 +248,8 @@ struct mpcc *mpc1_insert_plane(
 		}
 	}
 
+	mpc->funcs->set_bg_color(mpc, &blnd_cfg->black_color, mpcc_id);
+
 	/* update the blending configuration */
 	mpc->funcs->update_blending(mpc, blnd_cfg, mpcc_id);
 
@@ -495,6 +499,7 @@ static const struct mpc_funcs dcn10_mpc_funcs = {
 	.set_output_csc = NULL,
 	.set_output_gamma = NULL,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
+	.set_bg_color = mpc1_set_bg_color,
 };
 
 void dcn10_mpc_construct(struct dcn10_mpc *mpc10,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 484a30592987..558821e5ed2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2267,6 +2267,23 @@ void dcn20_get_mpctree_visual_confirm_color(
 	*color = pipe_colors[top_pipe->pipe_idx];
 }
 
+void dcn20_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx, struct tg_color *color, int mpcc_id)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	struct mpc *mpc = dc->res_pool->mpc;
+
+	/* input to MPCC is always RGB, by default leave black_color at 0 */
+	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR)
+		hws->funcs.get_hdr_visual_confirm_color(pipe_ctx, color);
+	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
+		hws->funcs.get_surface_visual_confirm_color(pipe_ctx, color);
+	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE)
+		dcn20_get_mpctree_visual_confirm_color(pipe_ctx, color);
+
+	if (mpc->funcs->set_bg_color)
+		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
+}
+
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct dce_hwseq *hws = dc->hwseq;
@@ -2278,15 +2295,6 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	struct mpc *mpc = dc->res_pool->mpc;
 	struct mpc_tree *mpc_tree_params = &(pipe_ctx->stream_res.opp->mpc_tree_params);
 
-	// input to MPCC is always RGB, by default leave black_color at 0
-	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR) {
-		hws->funcs.get_hdr_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
-	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE) {
-		hws->funcs.get_surface_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
-	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE) {
-		dcn20_get_mpctree_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
-	}
-
 	if (per_pixel_alpha)
 		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
 	else
@@ -2320,6 +2328,8 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	 */
 	mpcc_id = hubp->inst;
 
+	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
+
 	/* If there is no full update, don't need to touch MPC tree*/
 	if (!pipe_ctx->plane_state->update_flags.bits.full_update &&
 		!pipe_ctx->update_flags.bits.mpcc) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index c69f766a40ce..6bba191cd33e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -146,5 +146,10 @@ void dcn20_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset);
 
+void dcn20_update_visual_confirm_color(struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color,
+		int mpcc_id);
+
 #endif /* __DC_HWSS_DCN20_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index b5bb613eed4d..2f59f10e5f09 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -96,6 +96,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 #endif
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
+	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 6a99fdd55e8c..947eb0df3f12 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -67,7 +67,6 @@ void mpc2_update_blending(
 	REG_SET(MPCC_BOT_GAIN_INSIDE[mpcc_id], 0, MPCC_BOT_GAIN_INSIDE, blnd_cfg->bottom_inside_gain);
 	REG_SET(MPCC_BOT_GAIN_OUTSIDE[mpcc_id], 0, MPCC_BOT_GAIN_OUTSIDE, blnd_cfg->bottom_outside_gain);
 
-	mpc1_set_bg_color(mpc, &blnd_cfg->black_color, mpcc_id);
 	mpcc->blnd_cfg = *blnd_cfg;
 }
 
@@ -557,6 +556,7 @@ const struct mpc_funcs dcn20_mpc_funcs = {
 	.set_output_gamma = mpc2_set_output_gamma,
 	.power_on_mpc_mem_pwr = mpc20_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
+	.set_bg_color = mpc1_set_bg_color,
 };
 
 void dcn20_mpc_construct(struct dcn20_mpc *mpc20,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 4f20a85ff396..523e25f7e410 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -100,6 +100,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.is_abm_supported = dcn21_is_abm_supported,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
+	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index bf7fa98b39eb..a978d848d370 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -99,6 +99,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_pipe = dcn21_set_pipe,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
+	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index 950c9bfd53de..a82319f4d081 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -1431,7 +1431,7 @@ const struct mpc_funcs dcn30_mpc_funcs = {
 	.release_rmu = mpcc3_release_rmu,
 	.power_on_mpc_mem_pwr = mpc3_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
-
+	.set_bg_color = mpc1_set_bg_color,
 };
 
 void dcn30_mpc_construct(struct dcn30_mpc *mpc30,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index 70b053d9ba40..181f2175ac95 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -101,6 +101,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
+	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 75c77ad9cbfe..640bb432bd6a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -363,6 +363,9 @@ struct mpc_funcs {
 			struct mpc *mpc,
 			int opp_id);
 
+	void (*set_bg_color)(struct mpc *mpc,
+			struct tg_color *bg_color,
+			int mpcc_id);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 1d5853c95448..43284d410687 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -235,6 +235,10 @@ struct hw_sequencer_funcs {
 			enum dc_color_depth color_depth,
 			const struct tg_color *solid_color,
 			int width, int height, int offset);
+	void (*update_visual_confirm_color)(struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			struct tg_color *color,
+			int mpcc_id);
 };
 
 void color_space_to_black_color(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
