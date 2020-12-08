Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4525C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926F423B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926F423B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A262D6E9C2;
	Tue,  8 Dec 2020 19:29:07 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4D16E9BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArdVjz2VSJmvRKN56287j2ulf0QxmR71I4VDm0qL09mSW2vClUN+SaVizpeVTp4cwhWiDMvfYUpdeBLGKzwF9BtF5KzMe7+wJoIkRyP9EzbWgLM8JFAjxmu3sxBs6r2h0WLEQJG2E4AhxgFyrbt2mEP0+AlXzX5WKfAj4sJsmU7w71qkBX+oBIUiVx7wyPoMNj4C/NK77viBUMOy7ZPe2ouuLTcVGfN+ZHp4X5yDXEHAeBMabEbYPtoQDpSw8H8aLdB/FtTNliEsixFnzxG5ikjYL+2vtI00N1ea9m2HKVoJbfSQgYiWOQQqppS2Zo4X+g/EuqTFoz5eUxg5sWrceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYsk9NwzFdIyeydOqt1eAWT9gMLLpZtqMZhrereASi4=;
 b=e1UGFMqoC7ltw2uzkvubpLMKGbJXBgq62Xc0ZCdWnjj2Ejr7cJaa22PByWt4xpit8my+/G8PuJfHfmForP2aQeaDcSUlq5FTCoNb28k885b7cahFzj+KBbc2P2qhb38+SgL4lV4dJlUdKV60zLdw8OsfOVD+qEPNRECCPKXr7xJduZoOKuWjRR1KNFxalxioikBlCfKREoVsh5a69+5S63errmZ4e2UOxiQOVPiRYr+UNaue2J6L+2C+4a8t8j1EYUudgwMi4EUX6RhQvJrI1WxzilQJIG02NIVDM2DTYK4+BQxmSpcSafQQ6VJPoEM03qOa8yWS7Kxzx5mqcqDhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYsk9NwzFdIyeydOqt1eAWT9gMLLpZtqMZhrereASi4=;
 b=lI489mGcc79kEDcYk8w3b44qPBSzhj3ihcvBNwNxeJJeZkn0KEVbp7U/xhfcqUomEXKTKf6Ovo90ws6wukoz2NYUlOZfjl8iweXy/yeNkuMB0u2Jh7AWWkar2B7UwbKpzLPEGx0HR+88DjkI3GDT0NKkN5LdhV6JXBiVoyLPh9s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:29:02 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:29:02 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/13] drm/amd/display: Only update FP2 for full updates
Date: Tue,  8 Dec 2020 14:28:40 -0500
Message-Id: <20201208192844.23580-10-qingqing.zhuo@amd.com>
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
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:29:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2cd96c06-27ee-4a6f-de3c-08d89baf851a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43883E3DDCC0CFD394FB146AFBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWJ3jyhEELtPwt+YGFhTjERkO2cmax31Q95TfEiIlBLHDzQlrdQASFXxAJkPUUmK73wy0l+ZF7LfosHcHHgUyn21Umay7rJAx1nUjvEpmBZRQ7+S8QcLXh6e85AJbyi86OyP577sT/y0nLWZTnZOXHW9yMWuvTK9mRe2b/pkjRukD9iYyrcOv2vRtXtJ8D64H9YFoM2aVQNzRPp/46m+D76kmARocYORpgUKZluKFKpOLT9QpuEqOyr2x9LpOFDSPJXxAFTev4RCcvlLYTdH+SU68fuBbIMzeS/N/mePkzIMpdhMG9e98ag+gIboDrv61sxiQ/Mev7+67MJ2eMMUrzKK6g+EZM6mY3icRPM+n+voY55xqYHFJao0m8vufiNH9VGG2Xyez4CBJWywaSl7X2kjetBcqn6jWOiftNWe5Ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(15650500001)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Q7C2CrDCudo6Z2K9Ef0SyVA+9YowIKBleTvZhsepJehtAVpvDhDqtePZEmeH?=
 =?us-ascii?Q?DWRlnEKtgRFPVcUjqkR0a8KYE0+2vM6zqBdIGIFVoYR/QGVTBhCZIcFuUhyY?=
 =?us-ascii?Q?JvuLS0ky2G9wlgljUZn7f7iQEibxjpEqm5vngfj97OczVpGlW4DIIdaKul8c?=
 =?us-ascii?Q?hzryU7/abOR5dUchFfqsEoQhqSXTCBld1ZkCck21th8CjUYt6w2nmOiLc1fg?=
 =?us-ascii?Q?/nNYVrXr8dUdws+T7dqTtc8XHVPrRncq1sBSAVonj9FlCs8+QU/nymzlVUE2?=
 =?us-ascii?Q?0h7meJbxv5T1HO5/9vzmEhFGJm75owFaevGKBooUGYzo/eRtP5PyE2jkMBoB?=
 =?us-ascii?Q?NFxkDZa5ZxIauevQnK109oRJWqPAELvDVJXTKQySupsrFgTSYLb6q+d8Iujh?=
 =?us-ascii?Q?fKYVi6N3ER5JVnjNSOgnnaI7mCU1xt51jKj5MW5+AMn1hqtWFwD8QFOn0fmC?=
 =?us-ascii?Q?RByHMOS+HG8aA8H8O/H+0Q3OcPHX3sG1v7CTo6o1JZ96F1S6L/KI6YN0qAGc?=
 =?us-ascii?Q?0SUU3qGoR8aiaantOiYrnLo2xQtOhJlpejkRbj/F8J3BNJEDGi5+ZwYB+Gyk?=
 =?us-ascii?Q?+xXumupCLvROPOwpePHofk86pH6UjlsPACHH577tp2ze8PO4DzoDcMBH+Gzv?=
 =?us-ascii?Q?q/BSF2xigfbQDiCYukCEij2RjFzr6wdBAtOzowGJtSpm9ZbNQ/0gF1nopULQ?=
 =?us-ascii?Q?wOkrMzvOAFEekFkkKb/vr5Q+5lmK+qXZrekEBRY49TZ+k7YovCSBbBWXh/2+?=
 =?us-ascii?Q?mlUDSx27HFMEbAcrfTa0RuTdg6fz1MOi6Cc41VAd7t19+PpIOM6Ut95+k4SR?=
 =?us-ascii?Q?bMQDy0jNA8kHpe2T6+MdDLov/OfhGXhzvRE9LIFgiTky85hPwejgQ2DV1acq?=
 =?us-ascii?Q?bOdRLzbq/VEHfwJDkesjiupQtpugZ3NrfCmVUHzVmoKHmKYAKc4EDAH5QsJq?=
 =?us-ascii?Q?WRBPepDIaO2MOgQFNPJVIF7gunMhCZt4kJNyfZe7LGnuC2j+i1W2d3Nr+wae?=
 =?us-ascii?Q?WKku?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:29:02.4209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd96c06-27ee-4a6f-de3c-08d89baf851a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMd4NvwvVPVwVFz68q8ggURlAJ1jsZ/DteKDJkTcpM59L3rHzJhmnoAj094X+o5o
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
FP2 is not double buffered and must wait for VACTIVE
before programming.

[How]
Only update when there is a full update we should
change FP2 to avoid delay every flip.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 +++++++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 11 ----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 58eb0d69873a..7339d9855ec8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2625,6 +2625,26 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
+	if (update_type != UPDATE_TYPE_FAST) {
+		// If changing VTG FP2: wait until back in vactive to program FP2
+		// Need to ensure that pipe unlock happens soon after to minimize race condition
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe_ctx->top_pipe || pipe_ctx->stream != stream)
+				continue;
+
+			if (!pipe_ctx->update_flags.bits.global_sync)
+				continue;
+
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+
+			pipe_ctx->stream_res.tg->funcs->set_vtg_params(
+					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, true);
+		}
+	}
+
 	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
 		dc->hwss.interdependent_update_lock(dc, context, false);
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 52bdbf2d50f5..cba3c8cd12a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1214,17 +1214,6 @@ void dcn20_pipe_control_lock(
 		!flip_immediate)
 	    dcn20_setup_gsl_group_as_lock(dc, pipe, false);
 
-
-	// If changing VTG FP2: wait until back in vactive to program FP2
-	// Need to ensure that pipe unlock happens soon after to minimize race condition
-	if (!lock && pipe->update_flags.bits.global_sync) {
-		pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg, CRTC_STATE_VBLANK);
-		pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg, CRTC_STATE_VACTIVE);
-
-		pipe->stream_res.tg->funcs->set_vtg_params(
-				pipe->stream_res.tg, &pipe->stream->timing, true);
-	}
-
 	if (pipe->stream && should_use_dmub_lock(pipe->stream->link)) {
 		union dmub_hw_lock_flags hw_locks = { 0 };
 		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
