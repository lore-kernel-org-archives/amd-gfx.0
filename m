Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C8FC433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F1F61400
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F1F61400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C376EE42;
	Fri,  7 May 2021 14:59:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B10336EE42
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMvp5K+BuV22pKu5lqcTdv2BoXLeqk1BUX+ETMt/TaNiEImc7hA302SqhMWKW6IsNgggMP7kpfGpbQoAysq0KAeSJHGosm+/j2D06gZ4QMmMQ7xsFXxckHhrnJCpQxX5T/fOrFmVhwfyI8ZcZo02mYeeP4Yih8h+Abq0bWXy4vKlwaZqSuKXboR69DIxEl5Phv5x0SsE9Gnb3fdkBeCrzgSSaGAktftCN72wr9i9/CE0DJ5Z2XWUIXj1Otwjw+yqi67A7NwY1IBc+E9NbRtGkCd+L1tiM1znSHfqMhIXUKg8tlV2VKzNOLiT4dUaPR1zKPnWp37JdUGyXZwtQgpn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx3zQEVCl/CUMKkFyGK9+435vYgp3IE0l5gzv0ud62o=;
 b=nXFsbu9j1nNkQ9VPpufJUgUzFxNrDCGT57lGkkW8Fv79ynhXDJe4OrViJzjfbwugJr80HGZruYTakmT1QUvAELL1q9r1Nj5XFsZw5+RPtAJbvTYzSCRfim7/cUgJaGrlStMb74lGJJX1V8j65LL+vkLZFrEPcaYaqNiCaVKaTE2oyy919OyVSIZZHobCeEOsqTCI1y55wU/jLvYs4mX4wOBy14ECB70sLQ6FWy1nXOEA7FWHqfqYH+xcWzYP4WqcrxXFpQ4zxOxd8yeCh5my00S40lxc+ouZUW0cFbNW5OKo0kYc4ftUEaLMuwhGG2bq2oKTxPZe5tpzLuSYuCkoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx3zQEVCl/CUMKkFyGK9+435vYgp3IE0l5gzv0ud62o=;
 b=y1zf9olRjkw+Ipb4UHBXt4DjP/U11GBHk8+txtCqtpJSZbi0kP19xdy0QCdgr2fItSH0k27LWgWbyK+RdFHU820ycvqR+OBQT5LxkTIB4XI8CtQct9j0uoxg08gpbg780lvZ9K4pOQPygPIpuouMja2dN2JIFODrWiZGIYkC4As=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24; Fri, 7 May 2021 14:59:14 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 14:59:13 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/14] drm/amd/display: Add fallback and abort paths for DP
 link training.
Date: Fri,  7 May 2021 22:58:11 +0800
Message-Id: <20210507145822.248029-4-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:59:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1e5ea30-1478-4ada-9be7-08d91168ad8d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3852FE500D707FE51520137DFF579@DM6PR12MB3852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1Yb7WcwQT8XhTneDZ2neb54KLYCaX91P76yvH95MoKHb5fziBmv17wee1J0uEl8/GU+Gvgo63WewHnhZNzQlCHiYGU/pVPOMrkCwvIEdpPrd0xQedf3dE31lYwBGc2czmZVMpYu2Xm8fKQyKC5eta9M5fHbrxoHxRplRVb+nAxZvBVbtm/29+NJWgExaFFMB4XUkxsIkUArSFWqjolEGhMC+IsK6oW/FbPxHjcp9cTsp5oduF+zJ4ZOzExf/fSxn71F3DogQ/QLMFzAioa1WzajXEph5MntX1jqjqHDB/1qSlfynRP3s0oESCXHVQpYStcEVPQk2ALPTfLAdMJgplONbkO7euc4uDjTd/ODociXPKMPyzXBbsecLcvXpLTK/ucRTluclpQ955l4HYw6vNNrL5I0Xc2uO9razEAvkSYXNSYX3r5IDdVjCtT8jEeYSrxxA2GrCROT0IgPX+9IH+YrndLayrRWx8lRkYK58NMA9tlEpuY5yZvKwoRhZNPYJNkMojp8w9WeZl57q4hvUX34DZeTM0SPzBDN8tldWK1vcowSIpefdnuP9gzZqAmHwCsn7VMMIJ4J2uatokL6IXwdZ1gfkeE40aK0ES9lTJa8bXT01G2k+fyvTD5tkgxIFuIzbRnorLqRBcId2P2MOYQ9kkoUIBwuOQnAp3Wwd3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(316002)(86362001)(38350700002)(38100700002)(4326008)(8676002)(478600001)(44832011)(66946007)(66476007)(2906002)(26005)(52116002)(54906003)(7696005)(36756003)(8936002)(66556008)(83380400001)(6486002)(2616005)(956004)(1076003)(5660300002)(6916009)(16526019)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NzDVBvIQbOsAwQ95Z+xCH9cfspP4Mvn8tPM3lNYR9Fn72k7Dz1xANOFiB9wD?=
 =?us-ascii?Q?72ndvTVInYRUG67jActUWhOKdrgbSAJJNxoLjVjCQ0l9AnrKzOG1Rjvosixe?=
 =?us-ascii?Q?Wptz4fjpfL/7ZD0PSBKOYDlEBTYQlxWr6YJvv8wHVvnFAGkqIk587hitTMnM?=
 =?us-ascii?Q?sEy4bIuprzKmIB2jGerVk4IApWY50gfh3EFVyztr8f/eGQykzL2mOZURTeI+?=
 =?us-ascii?Q?6TUOqSwEn0tUCD9Y5crBWlkqgh4RhjFoTmegWbDP4Kq38RJGJZe+qbfQmV6l?=
 =?us-ascii?Q?HJFXRFgecWN+8sx107lZ01ZxxGyE7SaW/YrnfJm/ewkJqy80ABrr8N9ulhcd?=
 =?us-ascii?Q?qU9lPCfR3RIGKgHTwh2jZUozHdgU1ljAWfXg1vIlLQQeuJDbqi07mgaODI1s?=
 =?us-ascii?Q?gKHsW9j72dwiCcgpCVirZ8gXnXAc7aupUoYyMLoQ5nfSaff8iffGkxCYEyp7?=
 =?us-ascii?Q?kwtd5B3gJrYfsnR/pj2Y5fbEvY7hIsMuZecSGRBF3LcAqx1+cepg671VnwIv?=
 =?us-ascii?Q?6z04mWrhrBta3m19MIM8+2L+/n4xsTR8+T3g8y1/s+qPN7ISj6xO116wGY+p?=
 =?us-ascii?Q?h5XBQW9nNcYzc7BC/vr89YmH92BcQ8rxI5PZ7LE/p4zqV3UrNY2r84FUrLlz?=
 =?us-ascii?Q?cOqe0IoCV9NyNXEaciomyFjZxcD4Qu5juaFETuC87cZClrJiZFvCUq6gJtrp?=
 =?us-ascii?Q?6MwhLJT6J9Q8QnG7kGGmWNVcAR9pWfoQgKh3STtGEzRhDuXkz/7j7XZSSdeX?=
 =?us-ascii?Q?PMaLKd62A2q4m5ymwlDQp1qa6/T8gypr+RtfgeUrRpCjI2PfbqzwlPGWhJiu?=
 =?us-ascii?Q?Hcqoj5dr54pvDzI5p5uK0dJLtg1fG1LxLPzra401oHosl3wouC5HEtvT3G+U?=
 =?us-ascii?Q?KZ1ndDl1iVvuJODrgTS5UJXEO8xGdq+zsotaGjszjK0h1yANAncbb+VINi1c?=
 =?us-ascii?Q?wk56OHsIYW85ZVBlj/l/P0l7Sj1zbaTk4oP7ftpvnYPLvJP64tqupBCyBhrb?=
 =?us-ascii?Q?cFGSqMJJTwRmNQ5FqtP4P7Mda3r7lgUpLAcKQzBMhEBifBnWGl6Hdh4WqTwX?=
 =?us-ascii?Q?3dx+JkwaJGJ/sgRKLIREESaZqTUkDmHaqmsK02Fjd7OO6DfR/7fWdkl/L1o5?=
 =?us-ascii?Q?zfgRsEZeDh5OS22ZteE0cT7AHovJ/sNZYO8a3Br9yJROQanbPXYpELFn/2/y?=
 =?us-ascii?Q?/cZ8ZcDrZPLOIPp8MgQwxVCuAluJh7xlYSEzZEOeoe4L8lWpCvJPYlpPsarx?=
 =?us-ascii?Q?y4WitOlb9dmoxucDGV/Li5hrUQvM3DfnSYOonK8DJZiVtuDl4Hcfcn03p7zN?=
 =?us-ascii?Q?bUMk53EMJtOTuLkjv2cYUyez?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e5ea30-1478-4ada-9be7-08d91168ad8d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:59:13.7494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJzAbIB8YK0H9JiNuHhXZOJktoXS/cfVLUiLiqOiKnPd6+r5UJfSzMCmcG6LGGwP8AlD7JoevJ7kKDBQTwqj+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
When enabling a DisplayPort stream:
- Optionally reducing link bandwidth between failed link training
attempts should progressively relax training requirements.
- Abandoning link training altogether if a sink is unplugged should
avoid unnecessary training attempts.

[How]
- Add fallback parameter to DP link training function and reduce link
bandwidth between failed training attempts as long as stream bandwidth
requirements are met.
- Add training status for sink unplug and abort training when this
status is reported.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  5 ++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 40 +++++++++++++++----
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  3 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  3 +-
 .../amd/display/include/link_service_types.h  |  2 +
 5 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index d040d235c2db..c4405eba724c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1750,6 +1750,8 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	bool apply_seamless_boot_optimization = false;
 	uint32_t bl_oled_enable_delay = 50; // in ms
 	const uint32_t post_oui_delay = 30; // 30ms
+	/* Reduce link bandwidth between failed link training attempts. */
+	bool do_fallback = false;
 
 	// check for seamless boot
 	for (i = 0; i < state->stream_count; i++) {
@@ -1788,7 +1790,8 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 					       skip_video_pattern,
 					       LINK_TRAINING_ATTEMPTS,
 					       pipe_ctx,
-					       pipe_ctx->stream->signal)) {
+					       pipe_ctx->stream->signal,
+					       do_fallback)) {
 		link->cur_link_settings = link_settings;
 		status = DC_OK;
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 8565281e6179..b6ed57ba7a48 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1701,18 +1701,31 @@ bool perform_link_training_with_retries(
 	bool skip_video_pattern,
 	int attempts,
 	struct pipe_ctx *pipe_ctx,
-	enum signal_type signal)
+	enum signal_type signal,
+	bool do_fallback)
 {
 	uint8_t j;
 	uint8_t delay_between_attempts = LINK_TRAINING_RETRY_DELAY;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
 	enum dp_panel_mode panel_mode;
+	struct link_encoder *link_enc;
+	enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
+	struct dc_link_settings currnet_setting = *link_setting;
+
+	/* Dynamically assigned link encoders associated with stream rather than
+	 * link.
+	 */
+	if (link->dc->res_pool->funcs->link_encs_assign)
+		link_enc = stream->link_enc;
+	else
+		link_enc = link->link_enc;
+	ASSERT(link_enc);
 
 	/* We need to do this before the link training to ensure the idle pattern in SST
 	 * mode will be sent right after the link training
 	 */
-	link->link_enc->funcs->connect_dig_be_to_fe(link->link_enc,
+	link_enc->funcs->connect_dig_be_to_fe(link_enc,
 							pipe_ctx->stream_res.stream_enc->id, true);
 
 	for (j = 0; j < attempts; ++j) {
@@ -1724,7 +1737,7 @@ bool perform_link_training_with_retries(
 			link,
 			signal,
 			pipe_ctx->clock_source->id,
-			link_setting);
+			&currnet_setting);
 
 		if (stream->sink_patches.dppowerup_delay > 0) {
 			int delay_dp_power_up_in_ms = stream->sink_patches.dppowerup_delay;
@@ -1739,14 +1752,12 @@ bool perform_link_training_with_retries(
 			 panel_mode != DP_PANEL_MODE_DEFAULT);
 
 		if (link->aux_access_disabled) {
-			dc_link_dp_perform_link_training_skip_aux(link, link_setting);
+			dc_link_dp_perform_link_training_skip_aux(link, &currnet_setting);
 			return true;
 		} else {
-			enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
-
 				status = dc_link_dp_perform_link_training(
 										link,
-										link_setting,
+										&currnet_setting,
 										skip_video_pattern);
 			if (status == LINK_TRAINING_SUCCESS)
 				return true;
@@ -1754,7 +1765,7 @@ bool perform_link_training_with_retries(
 
 		/* latest link training still fail, skip delay and keep PHY on
 		 */
-		if (j == (attempts - 1))
+		if (j == (attempts - 1) && link->ep_type == DISPLAY_ENDPOINT_PHY)
 			break;
 
 		DC_LOG_WARNING("%s: Link training attempt %u of %d failed\n",
@@ -1762,6 +1773,19 @@ bool perform_link_training_with_retries(
 
 		dp_disable_link_phy(link, signal);
 
+		/* Abort link training if failure due to sink being unplugged. */
+		if (status == LINK_TRAINING_ABORT)
+			break;
+		else if (do_fallback) {
+			decide_fallback_link_setting(*link_setting, &currnet_setting, status);
+			/* Fail link training if reduced link bandwidth no longer meets
+			 * stream requirements.
+			 */
+			if (dc_bandwidth_in_kbps_from_timing(&stream->timing) <
+					dc_link_bandwidth_kbps(link, &currnet_setting))
+				break;
+		}
+
 		msleep(delay_between_attempts);
 
 		delay_between_attempts += LINK_TRAINING_RETRY_DELAY;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index b426f878fb99..13c5c4a34a58 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -384,7 +384,8 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 					skip_video_pattern,
 					LINK_TRAINING_ATTEMPTS,
 					&pipes[i],
-					SIGNAL_TYPE_DISPLAY_PORT);
+					SIGNAL_TYPE_DISPLAY_PORT,
+					false);
 
 			link->dc->hwss.enable_stream(&pipes[i]);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 699de64a7e44..38e6fbf1e26d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -65,7 +65,8 @@ bool perform_link_training_with_retries(
 	bool skip_video_pattern,
 	int attempts,
 	struct pipe_ctx *pipe_ctx,
-	enum signal_type signal);
+	enum signal_type signal,
+	bool do_fallback);
 
 bool is_mst_supported(struct dc_link *link);
 
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 7392a89e771f..5a250f41004f 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -68,6 +68,8 @@ enum link_training_result {
 	LINK_TRAINING_LQA_FAIL,
 	/* one of the CR,EQ or symbol lock is dropped */
 	LINK_TRAINING_LINK_LOSS,
+	/* Abort link training (because sink unplugged) */
+	LINK_TRAINING_ABORT,
 };
 
 struct link_training_settings {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
