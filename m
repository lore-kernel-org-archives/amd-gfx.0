Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0C7C56202
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E560D21D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qBPU48ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E560D21D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA586EC53;
	Tue, 27 Oct 2020 20:53:04 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700069.outbound.protection.outlook.com [40.107.70.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE896EC54
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iplA0M9KHQwIH97JZuNnxsnFyh2rXyBlZqX4EJqXDR1z+5LCMZr6zmUfaSmFzMxbY8h16/aqOOSgJrvqIcb5W6TKleqqgxVfhVYs25fAzBovU6CRAiS4OygeVTWvBEgmD0ioRUH+yd5iJmCM+PYi1g8mGVOrnY+KRoskjAoBWZhRhSpACzAldsHSkEPn0D4gCGC0N+fwuux2cCJ4b+r1y8wc0SGQ0a/GOltgHHu+pXCNRMneIrKjwXtL0n8zdWw7wkmiFLRjFSuxgVsnVjcZlDCRml55Gdo1Gd6QDH7RubJ+NeLjNyMHCXJr6rZc+r3dZNHMCnKQSkmrkmj0zk5b/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTruIe7xydY2qx3RRpUsAEnaFKMyWb19wkmZSRIGeDk=;
 b=fogqxR1hVHnogWxWofa2f5XEhyCMXclK1WVpdJLiyZgoJK3wqvGqqyooXiuux27/t46tBmEAAdim0sVMtJq55or7+OcV7daMHs7oUjjZKkUn+qUmLSAmeMEHasO+SFHQ+HirI5TVw2Rz8UXy2rRE1hqyZ0G3xcNPjw1NkEtyaYdpMpOy5/PjMJZNLQ87GuQilOgtDDed2XwoYdk8YwIrhAnVCJSGeWUtzzw+S9d+uZtJ8DZIkVy64+A6hvrkJx9+xyUtSsAFHIxaLiwpp9UinTluzl7e0qpurpvNZMfMGV/yUNOhjEvrsCBhxov9QvZ1GAPy38/QVRdBYLPokrGcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTruIe7xydY2qx3RRpUsAEnaFKMyWb19wkmZSRIGeDk=;
 b=qBPU48ymPqONTKIWwa8AdBxwCJRg7M8TO/UFPRsq18U0dsqEynrhkr1cZPBDvEmAVnVtOsbGcVES8GG8KofKtiffK+bsZuwxWd3bKO3q0NCMD7uTlXYxWzHF/Z9Cu2JUva9HhggW6EE8uKTANeVvRQsJI8cxvMUJyBgclvdWFhk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:55 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:55 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/25] drm/amd/display: Keep GSL for full updates with planes
 that flip VSYNC
Date: Tue, 27 Oct 2020 16:52:14 -0400
Message-Id: <20201027205234.8239-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25814af5-c7ca-47a7-a592-08d87aba433c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35952816FD5EE7A5C833F657FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TrDJWaiaRu6yhCNbEoW/wVxjzmbPngwSH9T4HhLR3b/qOMS9HduID5Bl1vivbI25O8zjKi4zc5SDnizdtCLfnwmPq2w2Fk6Z0KkM14d3FqINyXWfOXR74ydlCkCynBy28nu+VyZmzY1fyVL3bq2OJPl1nNEsCpLK5fojw5jcCwa7J19wdg8TxYRHF3sVD+YzXgoxrVXoMkQ31OjdGxeyQ414g356iE4DWqesisyFTBO179KbzzMMYf/mAoBMMMOLXi/8U4LZdAaqMADtlJkeMBJCn5r1jynif2LsIwWwQ1iKUpPcTOeubyMk20Kcf+Pdpf8bcFxTBt9xcTNPmsOVi2mLXx7OgwPzpgc7D6HBpzD8/Xw/RXogXBsd073a9LC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(15650500001)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mbY35ekSUBnNldtUzg07bCGBqc5mykamZczH/0OCchvR/iH2jwsDbzADJ7tzf42qirvG8/2LYNquL/IvZH4p0eGiGKsDLz4aW/tSoSDbqlw6tQtCOA18y98pBYk8BITzReVbJqhphXdJrc6RqDvIXnEj/Xwgv3Tcoa3PC0YUm3QKvPZvwDYHJu9L9VbZV3PZJQgeqQvDZrSEuqgSHMfCNHrQKX9xmPTcMbZBg8NiMtszrQjDBOuFZNRJCGpBwj1DQloAlBPoFw1Gsvr6pagcwX0AlCy1nIaPP/N8DqCAcbPV8ZlZ6bR2O4LRPm7tz5nemqb9bkABcqMHj84Ly/11TYAHMG3t46aK3kzQnZP5c2Bfkqvi3rEEPEiPSaaI7A2R+EZJgL0vO7YipKOIkMne1+xkDD1vGqqYTEcMAUCnBmvZdGoQ+InIxGN8U66VtT8nPjIWE6tl1HW1kBNnmwda76A+/aqk0rnVjROL28ves/QviU9WlIo5vOj3hl3jkJKppG3EsmsqVUv/y27nP8GMcBRzk+rX94teCI+Bw91jZzdmgcrBXfKzOaYWgzHL0Jp6Rbhaa3FIiKC2h87erMSATqGRlWhJBD8d0fRKQ06qiVFpS8OxoHajciz/T+URNe6UcIjLjJcvtHX/4DPa6GReyA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25814af5-c7ca-47a7-a592-08d87aba433c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:48.5578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xN3hMCf74QlhNM9sheA2Y77MbvtdF68B0I67+8t2RN/CJ9b0GjtyUsYV9mm5Vfq7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
When enabling PIP in Heaven, the PIP planes are VSYNC
flip and is also the top-most pipe. In this case GSL
will be disabled because we only check immediate flip
for the top pipe. However, the desktop planes are still
flip immediate so we should at least keep GSL on until
the full update.

[How]
Check each pipe in the tree to see if any planes
are flip immediate. Maintain the GSL lock if yes,
and take it down after when unlocking if any planes
are flipping VSYNC. Keeping GSL on with VSYNC +
flip immediate planes causes corruption.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 71499c131947..3b26396cbc5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1158,6 +1158,7 @@ void dcn20_pipe_control_lock(
 	struct pipe_ctx *pipe,
 	bool lock)
 {
+	struct pipe_ctx *temp_pipe;
 	bool flip_immediate = false;
 
 	/* use TG master update lock to lock everything on the TG
@@ -1169,6 +1170,13 @@ void dcn20_pipe_control_lock(
 	if (pipe->plane_state != NULL)
 		flip_immediate = pipe->plane_state->flip_immediate;
 
+	temp_pipe = pipe->bottom_pipe;
+	while (!flip_immediate && temp_pipe) {
+	    if (temp_pipe->plane_state != NULL)
+		flip_immediate = temp_pipe->plane_state->flip_immediate;
+	    temp_pipe = temp_pipe->bottom_pipe;
+	}
+
 	if (flip_immediate && lock) {
 		const int TIMEOUT_FOR_FLIP_PENDING = 100000;
 		int i;
@@ -1196,6 +1204,17 @@ void dcn20_pipe_control_lock(
 		    (!flip_immediate && pipe->stream_res.gsl_group > 0))
 			dcn20_setup_gsl_group_as_lock(dc, pipe, flip_immediate);
 
+	temp_pipe = pipe->bottom_pipe;
+	while (flip_immediate && temp_pipe) {
+	    if (temp_pipe->plane_state != NULL)
+		flip_immediate = temp_pipe->plane_state->flip_immediate;
+	    temp_pipe = temp_pipe->bottom_pipe;
+	}
+
+	if (!lock && pipe->stream_res.gsl_group > 0 && pipe->plane_state &&
+		!flip_immediate)
+	    dcn20_setup_gsl_group_as_lock(dc, pipe, false);
+
 	if (pipe->stream && should_use_dmub_lock(pipe->stream->link)) {
 		union dmub_hw_lock_flags hw_locks = { 0 };
 		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
