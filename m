Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BD1C43381
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFB523A9D
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFB523A9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7373C6E8EC;
	Fri,  8 Jan 2021 21:50:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41E96E8D7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtwCERJQSAHtkILv4cTXEDUSRyu+3o7Yo/pFkS7W4JgRfRrFlMhIaog7mTSw3Klr5ARK6Mf/TbXsDblQ1yEJWfxucNBuWD3r+YsNJ71ERKqkxfyIzf2sBRlfkvp6AOxOXjbE6cz/vaB7aiP/cPApXaRyuRFyNii8KYZ7PzetrnQfMChHgreciappplA61QSx6am4fmRMiXGiXT/obBZJZk58L4EE6UIFRIsjcUmy3IJhnGVsFsczXloLVW1Rh6rKBsi+N3c9sQWx9cU2ebT1qTK3Iu3R+KHF7AhW+CF/mp8sAxAu/7GkFitL0Bg/JPgAFQyYxAvZVVoZzPHD6TnVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QCvorJUuw6gXulX4I/ScIbze9bF5YYaH72KAo8wfTw=;
 b=meto1s96xElG5WVg5fPwtj7O2+fF8ZD7qNWeBVZulHslTiKEDFEMzT6SPWZRFgINWxsUqA0T8VJakBYC53RGEX6ZX9hAmaPJpHaWC06WgFFoCUseZtn4/zzbSSHF9vH0kwofk5b66Gb6DLrbTEA2I0ZAz2uq68uevkx+e+ywo5+uwB44eu+8IqsFwzmTg1Wf8jU52DZ5R9tL75w/vIkinR0kUTOK0UYyrtpHKH4FaGZJhb/RamfL5PF/By+0d28YmpdE2eQ+BZDgwRlwhgyDa6YGCGXuvZ0UWokHvJ27g13dsSbHnIqW5OVNEJNbAsmr9QK9emblFRrqOeReXv5gKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QCvorJUuw6gXulX4I/ScIbze9bF5YYaH72KAo8wfTw=;
 b=msSFQbitfQfZf1/0AaMWJkEZLCexbyP7vFNlmNm+lLde6o3kOj3PwhFwD9q5rzdGHTVXTLae5SiIO/lWwmrUQOJw1M0PODC8jxbf3J6sEvZUSUkzbVW5TSBiThcb7FPauVbFGd3W/Mm+Q53O1vuIE0NHMfQOTHkxVZQMUJ2O6hM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:39 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/21] drm/amd/display: Unblank hubp based on plane visibility
Date: Fri,  8 Jan 2021 16:49:53 -0500
Message-Id: <20210108215007.851249-8-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 8 Jan 2021 21:50:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d4bf499-c10d-4883-b1fa-08d8b41f708c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882A7ABDDDB86709A43DAF098AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIG5RNiRoFX29W4LbolQdLlUwOqWrl/ETdlEpJUrMwd8sW6HpK3ArtLrjD5muZJYaywYG14UR9UeQWOxsV9ELM+MqcVpMdFM2Cg+8qO9U+We6JdRfkxKfgeBIayAtzlegsxUDiyzHfWwTf2GjsqXWqaum9vDxQ4dzVTnUmrxHDluNDaXg6kq7i3qQzQjnycOkibA+l4CUW5ABGLxxl5OWp7eVC5VBm1HFY+vyzeWMcp2sPOHmOIC/mkjZQLs0dUPk8Hf6T+OqGJ60TmQsf++8aOUz2uXxgU9Guc41t98N71woX6qkTQDccWH6+RFdAgBQqYzfV/rXYA5+1HGqkhU3p5Id7yrkan5waYJnTqakkewCZ3/uNaxsifTL2V8of2RJ/pgXJYr2SxLjUrpnCvx9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S00MxNBYIT3j4k7rDBETPIil5fDzjwwMTdYf9qfBbtDmwl79eL+NyEobHse1?=
 =?us-ascii?Q?hEPeGncaNk5i05Zk6SxIl1M+OOWYHgid89DRItjyme0iRCOvQirKEyHyyxl/?=
 =?us-ascii?Q?xETfY76qoVUH13zELxTnbxIzKxIuEi4VOztFaVoZ4ie2QGkOSP8cZxuiObA6?=
 =?us-ascii?Q?/20nJ7+Ouf52ibka1zpa8ZD9rvQ70L0IN2B4f/+MKEfRh7+JUctyfG7OEpFz?=
 =?us-ascii?Q?eyf/wgCdOGhwUQpPIx1T332ufEB92khgOTUASRqnEh2OaZlKixxkVPqIxpPL?=
 =?us-ascii?Q?ZTJPwbyH+YX/dTajsswAODEYl5KE8WYBuKCiieYiL0OQwy++20l6O0qlXlDg?=
 =?us-ascii?Q?EdOhCxsMqKLnbvl6cZXw+yZS89DBxb/oXvB8AI/4Jbj4QZhMxUgQmTz+Fre6?=
 =?us-ascii?Q?B4HlYdP3yfII9HmMHfRhf07KLEs29B9biMvkAsPhx4P8zcQDcVacmazWd2ES?=
 =?us-ascii?Q?lgovlufjlB4Iu5uy62xR4mOC98Ky/uY/LvcPojjPpVaUnfswrBkRhbets5zR?=
 =?us-ascii?Q?kptflwM7dePKxtzffc9jPq84rA9IO/Te6AiyxPVTBrIjT8/iIfpwjy5Ux5z+?=
 =?us-ascii?Q?//bnugymdFHUSsS/ipMwInCoqj5cHHT05avyJessqFpfQZlghDHVl6WomdnU?=
 =?us-ascii?Q?vyyRuj1G47sz1fo5hBEhFqvn7vZnt9BPpF8j7HS842l2fVa8o2x+73BHqWiR?=
 =?us-ascii?Q?YnFEwqOcrbCqpeG7E08wAJ3lcqJJXPk65wm2ZeRyjJ0vFYTaTmoe3okKH3W5?=
 =?us-ascii?Q?BcyOQarfjbXrySVIroMqnxpww2tr2HIS6ZsaxtMalrTZkUXHYS4lxHx0HRYP?=
 =?us-ascii?Q?nhcVoCR5FGakDFLLAmzbcK/SXXR25B1yscCi43E3PKmwTYwSgaycMHoiRv79?=
 =?us-ascii?Q?yTwTgEeDV1B6E9bWUbAz2KSuzZ1RoO20duMLVa2niXmdGCdLlme4LL/KXao7?=
 =?us-ascii?Q?TtOUS5BMo+Gl2b2EFYqcg0Y3avhKsyRr0Moiv2gdDwTOYD1PBZUTm9Io42Qd?=
 =?us-ascii?Q?TqT5aWjUhZYYRkvluIbuVmV0smtXw+or+xGvsLAok6PXTdzdrGmWS36Ee5c+?=
 =?us-ascii?Q?Kow1L0/Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:39.6650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4bf499-c10d-4883-b1fa-08d8b41f708c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIsG2ERT4Gl/seiQCCXDkBv0plec3+l7YQv90X+why815YdemcGWHHxAdN8uyqSOYKnb2/vwGOnLTGlnV1PRMQ==
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
DCN10 uses plane visibility to determine when to unblank HUBP; there is
no reason DCN20+ should not do the same.

[HOW]
In addition to changing the check in HWSEQ, we must change
is_pipe_tree_visible so that it checks ODM pipe topologies as well as
MPC. Since we're now checking both ODM and MPC topologies, the helper
function names have been changed to reference "parent" and "child"
instead of "top" and "bottom".

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/basics/dc_common.c | 20 +++++++++++++------
 .../gpu/drm/amd/display/dc/basics/dc_common.h |  4 ++--
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  2 +-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/dc_common.c b/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
index b2fc4f8e6482..ad04ef98e652 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dc_common.c
@@ -49,20 +49,24 @@ bool is_rgb_cspace(enum dc_color_space output_color_space)
 	}
 }
 
-bool is_lower_pipe_tree_visible(struct pipe_ctx *pipe_ctx)
+bool is_child_pipe_tree_visible(struct pipe_ctx *pipe_ctx)
 {
 	if (pipe_ctx->plane_state && pipe_ctx->plane_state->visible)
 		return true;
-	if (pipe_ctx->bottom_pipe && is_lower_pipe_tree_visible(pipe_ctx->bottom_pipe))
+	if (pipe_ctx->bottom_pipe && is_child_pipe_tree_visible(pipe_ctx->bottom_pipe))
+		return true;
+	if (pipe_ctx->next_odm_pipe && is_child_pipe_tree_visible(pipe_ctx->next_odm_pipe))
 		return true;
 	return false;
 }
 
-bool is_upper_pipe_tree_visible(struct pipe_ctx *pipe_ctx)
+bool is_parent_pipe_tree_visible(struct pipe_ctx *pipe_ctx)
 {
 	if (pipe_ctx->plane_state && pipe_ctx->plane_state->visible)
 		return true;
-	if (pipe_ctx->top_pipe && is_upper_pipe_tree_visible(pipe_ctx->top_pipe))
+	if (pipe_ctx->top_pipe && is_parent_pipe_tree_visible(pipe_ctx->top_pipe))
+		return true;
+	if (pipe_ctx->prev_odm_pipe && is_parent_pipe_tree_visible(pipe_ctx->prev_odm_pipe))
 		return true;
 	return false;
 }
@@ -71,9 +75,13 @@ bool is_pipe_tree_visible(struct pipe_ctx *pipe_ctx)
 {
 	if (pipe_ctx->plane_state && pipe_ctx->plane_state->visible)
 		return true;
-	if (pipe_ctx->top_pipe && is_upper_pipe_tree_visible(pipe_ctx->top_pipe))
+	if (pipe_ctx->top_pipe && is_parent_pipe_tree_visible(pipe_ctx->top_pipe))
+		return true;
+	if (pipe_ctx->bottom_pipe && is_child_pipe_tree_visible(pipe_ctx->bottom_pipe))
+		return true;
+	if (pipe_ctx->prev_odm_pipe && is_parent_pipe_tree_visible(pipe_ctx->prev_odm_pipe))
 		return true;
-	if (pipe_ctx->bottom_pipe && is_lower_pipe_tree_visible(pipe_ctx->bottom_pipe))
+	if (pipe_ctx->next_odm_pipe && is_child_pipe_tree_visible(pipe_ctx->next_odm_pipe))
 		return true;
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/basics/dc_common.h b/drivers/gpu/drm/amd/display/dc/basics/dc_common.h
index 7c0cbf47e8ce..b061497480b8 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dc_common.h
+++ b/drivers/gpu/drm/amd/display/dc/basics/dc_common.h
@@ -30,9 +30,9 @@
 
 bool is_rgb_cspace(enum dc_color_space output_color_space);
 
-bool is_lower_pipe_tree_visible(struct pipe_ctx *pipe_ctx);
+bool is_child_pipe_tree_visible(struct pipe_ctx *pipe_ctx);
 
-bool is_upper_pipe_tree_visible(struct pipe_ctx *pipe_ctx);
+bool is_parent_pipe_tree_visible(struct pipe_ctx *pipe_ctx);
 
 bool is_pipe_tree_visible(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index cb822df21b7c..6470f5c7dfea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1570,7 +1570,7 @@ static void dcn20_update_dchubp_dpp(
 
 
 
-	if (pipe_ctx->update_flags.bits.enable)
+	if (is_pipe_tree_visible(pipe_ctx))
 		hubp->funcs->set_blank(hubp, false);
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
