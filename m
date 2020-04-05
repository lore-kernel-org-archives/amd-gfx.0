Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E9AC2BA80
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A6B20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DDiMSqQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A6B20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E50189FED;
	Sun,  5 Apr 2020 20:41:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDBF89FED
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOpwFxbkV/XsPEeZdKP4hyGXKlv++nLwLdFSsCBHlBXroX+d1EvwHMBdKPt8/DUROhpxTahZK9u4XkXblXMQVgjZ8+07Ieclg+/apiVgQPV+Iqv0M9XTmV1RT0Spf0IquA7+fa//6S8o089SzgaC7g/ami+BQ4hJho+4tJXrovXnGaAXO5BqXxCXunJMjd8XK7pdUTt3l9zsJEQDbP8rG3+BTEinmDBAPq/GLaTbTY6XV9sviJq6OJEab/asZOU+MTFZIhzjrU0X7hoNX5qP5J19sP8kf/8g1nfmPqgZYKN0xdbLaYi0nnMTc1fbbQnxglCFaq1LsEuP5PYfovau4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBruFr9EQB8alZQ1Tlj/Bk7rFDlPk0PUZU2SBw5q8LY=;
 b=UhMme8KwYmvDVfhp/fVsBXlN6IjposkoWC4ARFnNve9HbtC+IAAir9hywYNx0rcJjJNF1N50rPIxhADdtNhfrEhh0MTHjcI7pFDXO2QDX6PInQCyjkupz9onfVGVWhHgB+uUZf728VJkV3hS4u1JXJrZ0Cu9E1rJQ6PEFS5ATGBofe+FZARuk4X0ZkHMthtj3lrafKNTCAuMlqBwAxwPgEY85749t0vK17DP+HKeAkiubq58dD31uIaYUSE1m7jjp2Y/fYKmKGQq/tSb8UY8sDPDr8dmPk8K+aDlCB/R1MkEvc8P1H9R4IbQyXakaTM//5g0no9gxzPyTW+uwhoxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBruFr9EQB8alZQ1Tlj/Bk7rFDlPk0PUZU2SBw5q8LY=;
 b=DDiMSqQPTpImo1PIPO3tWZ/blf3eazA3nxHuqBODgKtSUvgBLXmlIT45FU6lyY2hIuijgK6exeAKWTW8b+6fGGtt7y4yS2uYqA+j7uS5vPpaZFf1R2jWZ717h1Cb7omhBx1rtkTRMRiyEMfZwfsCe9LKF4DmlN1r+U/pCUctKx8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:57 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/36] drm/amd/display: Calculate scaling ratios on every
 medium/full update
Date: Sun,  5 Apr 2020 16:40:57 -0400
Message-Id: <20200405204115.683559-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:56 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf2d3a44-67ab-4567-90a6-08d7d9a1c81c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25550943DBD27CFBB58FB96B98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(15650500001)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P73JzMzdBOVKdjVP8r/DAtMdyGqWOceBgKDd4SdlwLcTRxNIjdpGhPG5eN7Z36br7BJgebk07PYDe0WnyzCKulC364LnQXZo7RdOjjEDs0xSqU4Nuqqg1y/Uj4qISbFwTjhWweFh5uShPVXyHA6z4bYfAPon5KLmZ4R0ZBv0z68aaXtt5aZdOrI95inS+1tc0QVnqHs/TBvE9tEv+bmwy8q7QXoJId91VMXCsNIgSdFEk9TxdhFsa0n8L4vIcD8dmVcOp54vPoilGd7Z2N5P72n9HnWbn4QQRb8yOFQK8qgg+CIb1wCMWchzXKbY6BALCyxLhXrJvTeSnRQn3qsuEoDs0qZ5Pdye4A9+uPY2OKW4nq/SPE0ZU8zwDiZLxEiaZUSnBlmcswm13B4ixjajcyoIXp8Tq96WksAaaLjKHypOAnG4GupI+t3pIyioZfrH
X-MS-Exchange-AntiSpam-MessageData: yT8SCPvND8iw9zBrW8+N9KFVRagKR2gBLx9rfVUJ8w5/AIZSp/tOZa2fvk50+654MO/noF7YYJfY96rjlplUtd71/Y3SEf0RcBTD+8A5rno3gBhvQeQCbRtpGTmvfjeBstLYImoizU6o0VUGJ4ryKX8Jio4cdY6dmHaslap8oEA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2d3a44-67ab-4567-90a6-08d7d9a1c81c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:56.8360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6SK0GFWgnv1oA9wVkdPAloowZ2EeLjYP2gz2oY93ltu7Y9RkS51NbriAOe2G2PTvwXIEBDlXpS5jUWmgiA6RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If a plane isn't being actively enabled or disabled then DC won't
always recalculate scaling rects and ratios for the primary plane.

This results in only a partial or corrupted rect being displayed on
the screen instead of scaling to fit the screen.

[How]
Add back the logic to recalculate the scaling rects into
dc_commit_updates_for_stream since this is the expected place to
do it in DC.

This was previously removed a few years ago to fix an underscan issue
but underscan is still functional now with this change - and it should
be, since this is only updating to the latest plane state getting passed
in.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f21bbb295ad3..6379cf71d9d5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2462,7 +2462,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	enum surface_update_type update_type;
 	struct dc_state *context;
 	struct dc_context *dc_ctx = dc->ctx;
-	int i;
+	int i, j;
 
 	stream_status = dc_stream_get_status(stream);
 	context = dc->current_state;
@@ -2500,6 +2500,17 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 		copy_surface_update_to_plane(surface, &srf_updates[i]);
 
+		if (update_type >= UPDATE_TYPE_MED) {
+			for (j = 0; j < dc->res_pool->pipe_count; j++) {
+				struct pipe_ctx *pipe_ctx =
+					&context->res_ctx.pipe_ctx[j];
+
+				if (pipe_ctx->plane_state != surface)
+					continue;
+
+				resource_build_scaling_params(pipe_ctx);
+			}
+		}
 	}
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
