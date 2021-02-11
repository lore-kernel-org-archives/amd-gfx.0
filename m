Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CECC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0644E64DA1
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0644E64DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07BA66EB5A;
	Thu, 11 Feb 2021 21:45:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B451D6E428
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msuekxuPtgHCFUMh656H+Gpgjkv25Tdqwnvmcb2uZglrgi9Owm56bn7DiVJE8JIueFQ479HtbxpCFixDbDQ9+lRy2JKCGT6ZkxtNN9sP6TQpXRzvvQzbULIa8adgexovfDUvgsVEXuGEJ8oaRBr+Uq2KWL1B8vsXV5ZO3Cch9LFKYwxSod7PKEAAYj4hPFytQhSnx+7n/4/XB/+KmO4jvA7F41hdZVDqLDKziMatw2Ilbktv8i1+FZDvAAZdmXfQVH9Zb5h1n7DFUTvhuR7jCbkEUDGb4PdR0RPUJofpGAABxmhWoZDJ3f27iZyokSWDKLt09+h51f0hOclBmYJhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwSpYasvm55kjg4Whq5QyWUnINu/Ahujc/0yGCeU5io=;
 b=GGmMyyjDSQKrLDxSTtQkIfhhDwhxK6Pfr/6p+1Bx9y+lHq5giq3pKbblIM3rNA3/I1+N5zCqh+rzjwIF5zGUQPodsRSsRdUT3Yoi6zsCyrZS/tiwY2ShppLhX/RLDvJRcV0PrDblmp7WJ+ZG/Fs4e6tY8sN9njmj448xGrWY6k4IPYONZMolgRP3cmSflezmXzGIVYVQ3SHlhdJsjL/ztIq3+3X3XwOdCwO6LG+XllZcy+jA81mNEyHSG1zquvmtz64jXi0H61dEzMp6Uk3rlvtXCgqKTFS7LmqKUUpaWc7pzxzCGrqqwgxpFFDWPT/PSRWI92I4sYR9npkVNP/m9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwSpYasvm55kjg4Whq5QyWUnINu/Ahujc/0yGCeU5io=;
 b=U2Mc2Iu++KRHMlITyxPGb0qkhgDoq+isbFgXVGE1UsqweiutAx2Q6RtPFx+1wM7hOBrtvAIJo0WSlS68riD7sfHQI4CFaC7cUDbuCSBSuNOeEP2gtHQuLCXDOhtxljV+73wnEZ3HpRpi3Hv1XV5MYqSVGxPPadi/0vlDBeVUvs4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:44:58 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:44:58 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/14] drm/amd/display: remove global optimize seamless boot
 stream count
Date: Thu, 11 Feb 2021 16:44:32 -0500
Message-Id: <20210211214444.8348-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:44:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 342b57c1-8a10-4a64-fb46-08d8ced64721
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4235B665070250AE31D43DA6FB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIhinNwgNjI9jMVtYrfMhjMY0NokOxRGR7BxlWpW4mbf1UhS70oBkyF3rCnHVS+tSFkGzbV/E/kmZ7jMtpResrS857F07um8cUNsFeA26WB9Dj9EsCfaLwGX59QvzrpRf2P40FkKBjq3BFuGqtoTRBBB3PzuUQZsmbG836Ico29Sg06xdPcRTnT3ih+f03L/OPDHG2Yy9lDC4KERXtVIemsOBv2KjdSwshqZLHnQN6zvCJCB9/ezw/wNrZU3lydjRzIupmCIbzjGHSo9VlXisSFX+imE00LqfM/alYblshkUPDPYSktzjDsOnqS0TQtZV+I3+Jc8AOWyau5s0CrbeMqO5iVwBjNGjL5bLlyaqhLsvCF+M4czz9uiXo/Hucs29HSxP8nEeUxvElLI0HshwJcouU5kaKQ6RF4dFRJ3KOFHMb84MzQCRSdGi9Uog7mVZygOxlXtLt626L3e3jxReORyEWzbb1kHrJ0Y3i6TW2SkC7F4+3OYwPKWejKsd0a0bor6TBpNZghPYoL9hoB2IK3IYvplfreGXgfsh/+okR+7GB2+9c4Le6QvX3GYcbtFSD3FfdMdG3RX3yAVK6SrDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+kHEH00CLA7yBHMtQe1dnpmK/nlvJgA5vBtLhUhGXCNZQSobupvFfadUxI4t?=
 =?us-ascii?Q?F9UUIr5jt53JvhwDvhhR7QYPuN/EORmoiTuJQMmf8+O0P3mVzE3ILn9zWcL5?=
 =?us-ascii?Q?AxqZJXFAAVm+M+cfzPqh62JMSVj1qzt6FzQliGjPTpZzQJJQxeVAd9fdrVwH?=
 =?us-ascii?Q?Do7ZxfX66MjvTgU5mZ32uOCWF7GivPTajgGMObbu4BNWeOsAI+MbUV8nvOlE?=
 =?us-ascii?Q?L3JCiOn15kwH0bpR1gsBat0euX+Dye59hl/BNdQpQO/fOVFTbHmKmPOU7pLx?=
 =?us-ascii?Q?xB8iD2uJJucxX2d2JrCVJkNPMWib/GH/u6r/9h1I9BYu3mf+xtQpXsatahpa?=
 =?us-ascii?Q?+nTxEhq9/Q+pClKFyk374jDi0K5N1iJKRs7D83RQmOqh5bPfWMk2GQUr8OhW?=
 =?us-ascii?Q?+wCNUoGUJI7Y/vCkwn4iFjp59s3m3tN4JiXz7eCltGLpsj6RZ7ntu//oA+30?=
 =?us-ascii?Q?7oJWYV00A81gf3VTbh0ppWhy7DySYwfRAy7jdmFBKAjOVQ/0c5QDSrp8/X36?=
 =?us-ascii?Q?d8GYbSKR8CtxGnuT6X7ds465l1tl7YZLZlRoBCd19foBtPEaflpt3arEHQv6?=
 =?us-ascii?Q?bXKx4x14LIDnnDhPuKkwxB16W51Uo0WvB3Qr/uLJdiE582hfUk1b/ZCFrAIR?=
 =?us-ascii?Q?eVq9FmwrkWv4+Naqnc7848gKGqg4rgqtEzgwZqYT09JrdXjfuHvjFXBJ4BNO?=
 =?us-ascii?Q?HZcSdwZMK+eNrY3rnx+j6OuWUtKd7PEI45f3mjt7KSMBvvOdhoUyrXIk9ezK?=
 =?us-ascii?Q?6Qb2STcGsNz7G59nDwEtN56iEgTHL8RyFsAfgW1eyyXgoZtCx+q6T5kTKJBA?=
 =?us-ascii?Q?MsHsLMISwOOFctqq3vdEmdZc9EnDzXnWhzf/V4ixIVJj5WYXD6IGsTCFEJht?=
 =?us-ascii?Q?7zvzI1PF6l8/74PqMThAXHnnFvi5gTz1tA2hY3B/1sP/PKXoMNggseivVd78?=
 =?us-ascii?Q?jm0gJyMvoJ+loGI7uJ+kd6c9Rr8I5UrFcjF9lvAhFgT7oIs5/Pmz/ZoQvaFR?=
 =?us-ascii?Q?IADXtPqzKs66JbWmXZ01Zw7u2oMwQD74F6biPRStWaxpImVmBwMTF0VbcHM7?=
 =?us-ascii?Q?RG0u3PV68HIVRFSrh8YABEXrJlzEWSx+179NE9Ww72hLbDqMVoH0AOo+ZUyO?=
 =?us-ascii?Q?2bguzhG6Ksgsg7L5EYU53X+rofFgp+eT3YKTCVwPuOwMTrFKrz6FSedI6cXw?=
 =?us-ascii?Q?x0GpCbn+pDEmyk8bYquc2FedwwKE/gqzo7/ObOYCvCMv5zdhFQruV/Ez04Qh?=
 =?us-ascii?Q?NrYflbk0TPXKW6G5Z7oXh4VK/Y34zn2NQBh0h37gDxfoL36GoS65XP2A4nZn?=
 =?us-ascii?Q?iVY7fRkIhMHGi9siJhAHYhT1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342b57c1-8a10-4a64-fb46-08d8ced64721
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:44:58.8395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAgKdX4FSX8uDt30yvb2ynz4xhtboNBXv4v9JJw7OEdN09jVTEPRvUH+/qfK4DTI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
In following sequence driver will add counter twice on
same edp stream.
1. Boot into OS.
2. Set timing with edp only.
3. Set timing with edp and external monitor.
4. Set visibility on for edp.

Step 2 and 3 will add seamless boot counter twice and
subtract it once in step 4.

[How]
Remove global counter and calculate it is used.

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 32 ++++++++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h      |  1 -
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c9aede2f783d..2d8c6e63166f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -163,6 +163,18 @@ static uint32_t get_num_of_internal_disp(struct dc_link **links, uint32_t num_li
 	return count;
 }
 
+static int get_seamless_boot_stream_count(struct dc_state *ctx)
+{
+	uint8_t i;
+	uint8_t seamless_boot_stream_count = 0;
+
+	for (i = 0; i < ctx->stream_count; i++)
+		if (ctx->streams[i]->apply_seamless_boot_optimization)
+			seamless_boot_stream_count++;
+
+	return seamless_boot_stream_count;
+}
+
 static bool create_links(
 		struct dc *dc,
 		uint32_t num_virtual_links)
@@ -970,7 +982,6 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 				full_pipe_count,
 				dc->res_pool->stream_enc_count);
 
-		dc->optimize_seamless_boot_streams = 0;
 		dc->caps.max_links = dc->link_count;
 		dc->caps.max_audios = dc->res_pool->audio_count;
 		dc->caps.linear_pitch_alignment = 64;
@@ -1377,11 +1388,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.enable_accelerated_mode(dc, context);
 	}
 
-	for (i = 0; i < context->stream_count; i++)
-		if (context->streams[i]->apply_seamless_boot_optimization)
-			dc->optimize_seamless_boot_streams++;
-
-	if (context->stream_count > dc->optimize_seamless_boot_streams ||
+	if (context->stream_count > get_seamless_boot_stream_count(context) ||
 		context->stream_count == 0)
 		dc->hwss.prepare_bandwidth(dc, context);
 
@@ -1464,7 +1471,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 
 	dc_enable_stereo(dc, context, dc_streams, context->stream_count);
 
-	if (context->stream_count > dc->optimize_seamless_boot_streams ||
+	if (context->stream_count > get_seamless_boot_stream_count(context) ||
 		context->stream_count == 0) {
 		/* Must wait for no flips to be pending before doing optimize bw */
 		wait_for_no_pipes_pending(dc, context);
@@ -1578,7 +1585,7 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 	int i;
 	struct dc_state *context = dc->current_state;
 
-	if ((!dc->optimized_required) || dc->optimize_seamless_boot_streams > 0)
+	if ((!dc->optimized_required) || get_seamless_boot_stream_count(context) > 0)
 		return;
 
 	post_surface_trace(dc);
@@ -2400,7 +2407,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 					dc->hwss.optimize_bandwidth(dc, dc->current_state);
 				} else {
-					if (dc->optimize_seamless_boot_streams == 0)
+					if (get_seamless_boot_stream_count(context) == 0)
 						dc->hwss.prepare_bandwidth(dc, dc->current_state);
 
 					core_link_enable_stream(dc->current_state, pipe_ctx);
@@ -2439,7 +2446,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
-	if (dc->optimize_seamless_boot_streams > 0 && surface_count > 0) {
+	if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
 		/* Optimize seamless boot flag keeps clocks and watermarks high until
 		 * first flip. After first flip, optimization is required to lower
 		 * bandwidth. Important to note that it is expected UEFI will
@@ -2448,9 +2455,8 @@ static void commit_planes_for_stream(struct dc *dc,
 		 */
 		if (stream->apply_seamless_boot_optimization) {
 			stream->apply_seamless_boot_optimization = false;
-			dc->optimize_seamless_boot_streams--;
 
-			if (dc->optimize_seamless_boot_streams == 0)
+			if (get_seamless_boot_stream_count(context) == 0)
 				dc->optimized_required = true;
 		}
 	}
@@ -2460,7 +2466,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		dc_allow_idle_optimizations(dc, false);
 
 #endif
-		if (dc->optimize_seamless_boot_streams == 0)
+		if (get_seamless_boot_stream_count(context) == 0)
 			dc->hwss.prepare_bandwidth(dc, context);
 
 		context_clock_trace(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4eee3a55fa30..ef5d8fd0fa1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -628,7 +628,6 @@ struct dc {
 #endif
 
 	/* Require to maintain clocks and bandwidth for UEFI enabled HW */
-	int optimize_seamless_boot_streams;
 
 	/* FBC compressor */
 	struct compressor *fbc_compressor;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
