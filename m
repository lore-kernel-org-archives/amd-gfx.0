Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFB0CEE343
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36D210E7EC;
	Wed,  9 Oct 2024 19:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V4ytWFDE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B60010E7E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jU3vAAADphW2XPJ72f1hBsgTqOzcSkCChkHNBIeyM0cFSOgA6FiQERNrNMXe5l1RU0yK3OWPaDV7NxVuDT6e+j25sU/kPUDfrEp7uPV2pMozTVEYpgsXC68RWf86bgJB9dl/ZfU1Qc+Cad96MBU9BgAtDiGI86dHDcS1MFbRZ8uu4ZFVWt++zO00gvrudSUC/agfSO/Rd+mevw+lhrCGvjn5D0Sqc40JvJQZ8nayFYtrblS8/+wwL0xgPlz1Gm4sznFuuh0OwJLhOOtfc5Y7CpoQ1kLSTEENOgdQX6T11S/CKhktYlm10Nv7GtzAuYupdqrlpOzy+8VXs2refk4JZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sptrSvZZ3TD9+NK3rJkTDp9kI9XikIQ8dHTybLdyISo=;
 b=T+StWhSdneQpF8XrZT/5aiEFW4D7Clvxs1IEPKERXY/6Nte6y9BQs/o9QI3w4eTt7Zj4g0ZxquCrR7H/Kof3ZgFXSLON66QXZHcTvMWRy0xNjqTc3S1ghrC3scGYrzFB1wt29QRiG4kEhoNAgK0atmoVRNjdJojT4sK9d82f/CX85tE24DRxqmXv5fEnEfHXtRCy6qa2YDTYBsSU6/pCRDLC/ZUkiciuAaznoov+HUTGDEFL187OigFbm9/E738ivdRMO+LhWHPHOFc4/ymrzG5pMC6vEk0SYUhyCQAKDQwXmq+RbtqJhJ8orKEwqYeuhcamG4lsVRYl3G1PM5BsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sptrSvZZ3TD9+NK3rJkTDp9kI9XikIQ8dHTybLdyISo=;
 b=V4ytWFDEdypmDCMKICDmyC4H1sSM4GjfV7BtDETcXJipBONSJaFKI83d7/oSZinL+3K99kG8pY10+aaqGRKDWY0T8sgrS9xmSfcvJSgZQZy/JKIrHjgR6SZNH2TziuSm7TSXRud+z0O5IJh7M4HqEohtHSU8/8hacZedumGjaOY=
Received: from BN9PR03CA0743.namprd03.prod.outlook.com (2603:10b6:408:110::28)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 19:26:07 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::b5) by BN9PR03CA0743.outlook.office365.com
 (2603:10b6:408:110::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 19:26:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:06 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:06 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, "Alvin
 Lee" <alvin.lee2@amd.com>
Subject: [PATCH 13/16] drm/amd/display: Clear pipe pointers on pipe reset
Date: Wed, 9 Oct 2024 15:23:41 -0400
Message-ID: <20241009192344.650118-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc81141-0cbc-4161-91fe-08dce8983941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xCvMdRWw6ZSTcmzX2d9YCoaSLW3AayB3thwYYk4vr7dvBc5vklOHvoMY46ys?=
 =?us-ascii?Q?wM0bxQzdFtC9iPNNPxHBfgnDzLlf7PVbOS/k/B/dLQIxdPPjNvY7Qd2J57YT?=
 =?us-ascii?Q?ROw57CgsYua2/rQTOFvz7wIHwgL3yaxzmhLwcV0hrgA6bKVjA52ruDoQtLig?=
 =?us-ascii?Q?grIUYWGjXo5LM9/mB+3JYTbnQY8wyT05etHd4rQG+RrfC+1qE6eenos108o1?=
 =?us-ascii?Q?11pM5LlM4Shb1QqiuW7mMiQVn/tkv4NzRph0oPnQk/brA4d9yTAk3+bEPL2q?=
 =?us-ascii?Q?J6OLDJp1yAlQo6spmWDAPiQmbblmD/s2N5Q8xx4aj7HLnL0z64NiAJa8z92s?=
 =?us-ascii?Q?Y1Kq3F4rfD60b0UlJFEiaGIgs9s+jO2ckhiUWnsnTq+lcV9r71pj73mTvPnk?=
 =?us-ascii?Q?xlVZJQVt5ZDxJBGBKsQso3p5eJU3tnIsXKT/b7RPH/iYKzSTjCyEWAO9lSiF?=
 =?us-ascii?Q?ovO9bezH4SuAY5XzMxQvABbr02tK3eyV/tCXCS2NcJ3rmbObOgB44viDflLy?=
 =?us-ascii?Q?hqoEykwdYsl9vg6DFQrQgzmISzExJ2I0t6hylezSTcicoYqBWkHtt1UbfsQz?=
 =?us-ascii?Q?ll/uslHZisWO0OeSx2l1lU+NmSwbm4Qo+99R+ASR7I+IIUrpS2pwwD9gyINs?=
 =?us-ascii?Q?MOd+QeiBdrmWQZyyljETxGwS2yeJaz6RZ49H0gt10VD1FZb/q1u1xa6vN5tA?=
 =?us-ascii?Q?psL/AfXMFSQZhyoGb0Ce3j84JunOjvCyRwIOvQtqbvDfXNKsI2kXnhXRxQP6?=
 =?us-ascii?Q?LVw4kBK7hdSjgbxMgFMMheLqoaeip+QfkHqnWLnHJs/+TvrwvzsRCNlU600E?=
 =?us-ascii?Q?+axI+CXUPP8MFTZdyHOwyNOqKvK44XM5UUVviefhjnppB/pSL+RMwwUEfByk?=
 =?us-ascii?Q?OEEiv6+bt1Rijt3EJKbIJN1OTgeBkBacEMfHQ3E/YZcZM83JtZjfmAmU5mWF?=
 =?us-ascii?Q?ddzmOvaNOoQJSTZOs4XtOm4u6ZVUhp3j0RtV3ViC2JjzMVwrVipoUWp6WU7l?=
 =?us-ascii?Q?2TvqQMvznViKnoO16IjLANt+5Qk1vErnWIg3SK3K8UXFN6Fiog9fJ2G7KXM2?=
 =?us-ascii?Q?hK0aengnBNOjAfSMYx0BR9MhNCMMQj7g0mOcNDoVcekLA/3ox2hFBl2/wGh5?=
 =?us-ascii?Q?JxpWgwfffVUzKekr1Q+Ef1mVWY/ASCPoVrTYC/441RdT80df5F3UA4NAmf9D?=
 =?us-ascii?Q?fUzoHdBqZUkGpONXRTUQMqO7rcZ49elfEhNOWrGWPjRZLmAF80ZWm6R6yu6P?=
 =?us-ascii?Q?rSrhQpjUFXwiOB2fFG0mV6Tp2h0+9sDcl0X5i5Jy/gK9OeeRR5naJbc7q1d6?=
 =?us-ascii?Q?oXu4Uo1who6jOQb9HC+kmKZcv9ftkamuZwCzt5dQuxFMQIK1MQRCVb0Uw/3r?=
 =?us-ascii?Q?DkbbXE1xJ6OMVWuOZYqZo7dJxCTJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:07.2414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc81141-0cbc-4161-91fe-08dce8983941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
We want to clean up unnecessary asserts, one of which is an assert in
resource_is_pipe_type that fires if a pipe has no stream and still has
pointers to other pipes ("dangling state"). This gets hit because pipes
are not properly cleaned up in reset_back_end_for_pipe. When resetting a
pipe, the existing MPCC / ODM combine pointers are no longer valid,
especially when we put ODM in bypass.

[How]
 - reset pipe pointers in reset_back_end_for_pipe
 - remove useless code to avoid confusion
     (a long time ago it had a reason to be there, not anymore)

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c  | 12 ++++--------
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c    | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 9da5b50bea8a..05424a9af58b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2766,7 +2766,6 @@ void dcn20_reset_back_end_for_pipe(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context)
 {
-	int i;
 	struct dc_link *link = pipe_ctx->stream->link;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 
@@ -2833,19 +2832,16 @@ void dcn20_reset_back_end_for_pipe(
 		}
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (&dc->current_state->res_ctx.pipe_ctx[i] == pipe_ctx)
-			break;
-
-	if (i == dc->res_pool->pipe_count)
-		return;
-
 /*
  * In case of a dangling plane, setting this to NULL unconditionally
  * causes failures during reset hw ctx where, if stream is NULL,
  * it is expected that the pipe_ctx pointers to pipes and plane are NULL.
  */
 	pipe_ctx->stream = NULL;
+	pipe_ctx->top_pipe = NULL;
+	pipe_ctx->bottom_pipe = NULL;
+	pipe_ctx->next_odm_pipe = NULL;
+	pipe_ctx->prev_odm_pipe = NULL;
 	DC_LOG_DEBUG("Reset back end for pipe %d, tg:%d\n",
 					pipe_ctx->pipe_idx, pipe_ctx->stream_res.tg->inst);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 413dcbf4decf..3c70f40bf047 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1883,7 +1883,6 @@ void dcn401_reset_back_end_for_pipe(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context)
 {
-	int i;
 	struct dc_link *link = pipe_ctx->stream->link;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 
@@ -1954,19 +1953,16 @@ void dcn401_reset_back_end_for_pipe(
 			dc->res_pool->dccg->funcs->set_dtbclk_p_src(dc->res_pool->dccg, REFCLK, pipe_ctx->stream_res.tg->inst);
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (&dc->current_state->res_ctx.pipe_ctx[i] == pipe_ctx)
-			break;
-
-	if (i == dc->res_pool->pipe_count)
-		return;
-
 /*
  * In case of a dangling plane, setting this to NULL unconditionally
  * causes failures during reset hw ctx where, if stream is NULL,
  * it is expected that the pipe_ctx pointers to pipes and plane are NULL.
  */
 	pipe_ctx->stream = NULL;
+	pipe_ctx->top_pipe = NULL;
+	pipe_ctx->bottom_pipe = NULL;
+	pipe_ctx->next_odm_pipe = NULL;
+	pipe_ctx->prev_odm_pipe = NULL;
 	DC_LOG_DEBUG("Reset back end for pipe %d, tg:%d\n",
 					pipe_ctx->pipe_idx, pipe_ctx->stream_res.tg->inst);
 }
-- 
2.34.1

