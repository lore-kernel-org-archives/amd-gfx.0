Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9231CC74A5B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F2E10E454;
	Sat, 18 Mar 2023 07:57:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F04210E454
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EviK3d1YhvJXrPJgGAJsRbaPMKFYTkG1QMPfoAdCqhl2jD1zIn3cO+F0MxNSGuzEoI7gL0FR3eJf3sqtLdFDdsVXh7lXupmXoYGFPhrKRQqUY2oRXajlKsdCv3nfw0vAvCQy1ZsBXwKwA3rnEn9gmIiZSy569bQ3DGO+1naB4AiuuqZsxk0n1md3vVz0hoAfgFl3HFAefeqWYqvLkdGykX/Mu3DUG8yfrY7mVHZ4EgKKV+rXPnd9agCdvs9pn0Jz+vme9yZ3mxihkvhnNNXR2LayazmDVHZjeC8MLvjPl1xEWu/zMi/aRrrqwTaLl9k89EcBMtxHmnhbHwhf4BWDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf9TPWPaiwBKzFxBbasfLFdY7DVScODkj5+iGd4/zyM=;
 b=PbPqGLWgEA1Qb8OxasDxe7ScjVrVTJKxD2MVE2G0TLtrtTLFOy1Vn0nunCoifvzrez78jcn8JV4qGu5x41J01bZ5lx9i6O5lWjgf5rdff01WshXzLajAnSsV/wp/4npFCQJeFFF5ZQB4300F6FWiKUKO09BnsEmUvZrGVPyIux2bgB0L60+98o5EqFxHguHmAdpReMT4cxtIfPeKcP400GUUdmm4qChPXXIa8K0I5Tq4yjxi/RL5R0n4CF6LreZ447JehXGXqbX1log09E8vwTPL8rnA2+T37oVFtzPuO/e8xdb53hwLExXvVNrYxhNj9rLgDl9qMr0bfNLE7ABMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf9TPWPaiwBKzFxBbasfLFdY7DVScODkj5+iGd4/zyM=;
 b=b7tZdzQQgylUbNEOJuwBLHNztvgmOhnprlAhFldMruc9p5145nrQteoCCWJMJq7j7qUY9U9LCHWNI4eqR8uxJ2JZk6tdnGhTYMhnlVkcSrieP8+48nkGJWm9r7bNc/7mkp+bHIzYg6BHuWhrN9VZcfQUfhjpztq5NUXWRcjm45I=
Received: from BN9PR03CA0149.namprd03.prod.outlook.com (2603:10b6:408:fe::34)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 07:57:49 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::1a) by BN9PR03CA0149.outlook.office365.com
 (2603:10b6:408:fe::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.20 via Frontend Transport; Sat, 18 Mar 2023 07:57:48 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:44 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/19] drm/amd/display: align commit_planes_for_stream to
 latest dc code
Date: Sat, 18 Mar 2023 03:56:11 -0400
Message-ID: <20230318075615.2630-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e89ac5-49b0-40c8-24c7-08db27867768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLDMat+5lRF+IllKR2GrxeXS+f8tgPG9q7JJpK77Ohi6sznOZ9PW36s4Y5kybXaa+0YlhPGeGyPpkLaW5au7wrgE64mvVUYoNJv1E5Pln0mJg5/uxjOCqvUNY4FPtyzc0d0HRR1TA43W8O8J/87FUia7yCC4HZusHWNg43cLVtP4obuhL9WWc3JQWlHtsUJIZQb3mauRZKan97ICyj/g23K65Lte5B0oepfTSPVWzgWbm7xDwRBStYo/sZkgPexxbWDHBSUTnYZkwcxdTc1DA9SSJH6+ZPIO/qjQXIYpDi5l2ZLZGbgR66Un1BdjSjtZRl+O/BhKpB7lD9Gq5/dSr5glOfQPYLInEWLVU7ODQllZYpiSfSTCHSWgzmA7Cy1RfIwMFrje7RpYTyaMX1ZkG+CU00HwK3aaS+yi1DI3vFJiuRyNEdZ1CTjB45cMeR0bI1mb1SntIrFOYQn9bQZs3PdAt+1ynn6Msxq2ZZz1oEZuQHSkgxuzC7hPo0cX7TAbcwyv9XXgh2t9FWJJtsl6HutXEcnsXwHFm5GHHjyxTkAOL65YrrQSm8fLjpVwM4znw8ZDX2Mdk/muGgTgZdLR/rs5PsGAWC2c2ArjbDkq7IT39WZVHm/p4RGgL8EWDI1px6uq48xPvVjnAAYoIlHFfSoo5RfV38AyMXtlskyRvRZpyyP/3wFQdcXE0bW3IyP51wKI8SO2r/FZFhOXss21jPkUDYlwqCqIfGL2xdMz3Uk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(86362001)(356005)(40460700003)(36756003)(8936002)(41300700001)(44832011)(2906002)(5660300002)(4326008)(6916009)(54906003)(478600001)(8676002)(70206006)(70586007)(316002)(82310400005)(36860700001)(83380400001)(40480700001)(81166007)(6666004)(82740400003)(26005)(1076003)(336012)(47076005)(16526019)(186003)(2616005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:48.5003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e89ac5-49b0-40c8-24c7-08db27867768
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why & How]
Due to historic issues, commit_planes_for_stream() has grown differently
compared to latest dc code. Apply missed changes to make it aligned.

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 26 +++---------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dc67256f565d..40f2e174c524 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3493,22 +3493,6 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	dc_dmub_update_dirty_rect(dc, surface_count, stream, srf_updates, context);
 
-	if (update_type != UPDATE_TYPE_FAST) {
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
-
-			if ((new_pipe->stream && new_pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) ||
-					subvp_prev_use) {
-				// If old context or new context has phantom pipes, apply
-				// the phantom timings now. We can't change the phantom
-				// pipe configuration safely without driver acquiring
-				// the DMCUB lock first.
-				dc->hwss.apply_ctx_to_hw(dc, context);
-				break;
-			}
-		}
-	}
-
 	// Stream updates
 	if (stream_update)
 		commit_planes_do_stream_update(dc, stream, stream_update, update_type, context);
@@ -3724,6 +3708,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
+	if (update_type != UPDATE_TYPE_FAST)
+		dc->hwss.post_unlock_program_front_end(dc, context);
+
 	if (subvp_prev_use && !subvp_curr_use) {
 		/* If disabling subvp, disable phantom streams after front end
 		 * programming has completed (we turn on phantom OTG in order
@@ -3732,16 +3719,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		dc->hwss.apply_ctx_to_hw(dc, context);
 	}
 
-	if (update_type != UPDATE_TYPE_FAST)
-		dc->hwss.post_unlock_program_front_end(dc, context);
 	if (update_type != UPDATE_TYPE_FAST)
 		if (dc->hwss.commit_subvp_config)
 			dc->hwss.commit_subvp_config(dc, context);
-
-	if (update_type != UPDATE_TYPE_FAST)
-		if (dc->hwss.commit_subvp_config)
-			dc->hwss.commit_subvp_config(dc, context);
-
 	/* Since phantom pipe programming is moved to post_unlock_program_front_end,
 	 * move the SubVP lock to after the phantom pipes have been setup
 	 */
-- 
2.34.1

