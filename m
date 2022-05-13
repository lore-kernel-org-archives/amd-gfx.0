Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E184C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A1210E4B2;
	Fri, 13 May 2022 21:17:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6A810E4B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbfD3dDYIMvluXZDfqnnuzYTk3ha3TlnWWH60iQxY8hxp96iGsyam/hjpgd759rPxjsf6RTeL0Wz7VR23kUjivxlW+yQ6l5b1VpnFjpMDUBiND3XrcorBvtdOjIfOMPHHG4j23yJhjArCG8i4bYIpHbu1SjJjINLA2KU+Qo0+VhnE62OFKaA7R5Z231tcQmMSx21b2qqbOoWW2ApoE0typVvcPmYKglWerlHQj2YPLMEjmcSmfV/di4MwFZizsxol/J89y7iJLgM3xVwq5ydoOFDaBwM3TJqJ9l5cak/5lCKe3uAJea0C1QrQW/r0rBo5aO0sxqs3SjYXmu2jGO/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rv01nESGvnop+CXY02YaGq/lYhwns1pxUdMe/49ZDkE=;
 b=GbQJXzDgH/3XZZMGRUoPHSpNGCREAmjOp7ajn0t8Lf4P1/IuAou44NzDAshp8OzK9Xod++oiDejC7v/QVkXCtJu4SXOc651VpWWisiDmkJbaDEnmBtwmFUp3XpBzzJ5ZFCD9fJE8m55oA/gp2IZ01dFNQjfKsdPCfc9FPYaIQR/jjk/qr2qIgdXIf61QxAshVd67dBsHuJ58BRzfHWWvEfhbjaxVMg2XAkccmEtnRpC0mhXSgO+zg/Wv6347xWWmnhhfMA3sG9C0zALI4ILnk2BDwWbOi9djLqiUcXz8fyK5gpSkjoLVmtK7ZyHRUxuE0dRjhkPhp1XrYNnKnenAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv01nESGvnop+CXY02YaGq/lYhwns1pxUdMe/49ZDkE=;
 b=dc/30jq4KwRElLggc0CG72FPD+HK9I9J4Tg/VhCP6ltlQZhCDVxWAF74DF4TH/QrWefJdq0TtdFRYsmKQTfaHwrPnI8MM2jzN58m68BxUyZFzwBYc9gCPxhKGWBOEkSqkbOB7St8KytTym67gi4iGVH1/PEIDIqo+J+XCU+ElVQ=
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 21:17:20 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::79) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Fri, 13 May 2022 21:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:20 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:18 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 03/11] drm/amd/display: Clean up code in dc
Date: Fri, 13 May 2022 17:16:43 -0400
Message-ID: <20220513211651.1312846-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 776b9386-db52-4864-e814-08da3525f768
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB251140A7A0DDBEBA5F03A291FBCA9@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csqGSOOkqDzORNOK8DU6jjGC1yy1daNkQGptXgqrKvS15IbHq6GjTUuYrTC4dXaxTJyIyb1rSob0t9yZ2B1f3Ukod8Fj09nXdUgicoegp8E393n1ojqbVS9TXckaGUv4B6wlFEimzb8eDygHFi81xHZFr5l1ybEqQFX2Xk+f5szjLPJCN4/tfKfQCYb8Sb8ocZTFB2qn29sQciN+MkEXjlKpzKLWW9kTg6+UzQCw+kwHacv9HWz2VfdogaHhVN2cdIruNFPAN2CImo9XIJ6rHbvVnBjOGJLhlsheVtVncKPOqGIA4mFh4Pqb6CMAIqqIJc0YE7QcgBgOw2GyMMx17sEhPlbPgVyqgPGeaD8Cin4FTD8CAN+vDxZ4ptAuI7+aUedlWvhxEVDV82IedmHBY3XhOdHEqaczpbgEaQpwyfL4JPhm9U5OS0Btqet+XuOaxVq+WruTGx0GXjU37m2g+zTN9EaFYAy6/LtGpe9UoY1tXmTk1rgWGlhCiMQKsXBO8Rd3qtOS86iiUnOtauZjdFOyhxOJO3qGSd2DcvcynzXcZG14EIu7HZ2IpypQ6t/aOSwfE9umWAzrV9zmwSR511ieAWzUhWtm9HyHUqfeTBZUIhj65olYcESutEVqEHiw+IWQx3S++Pt1ALJW+C+s2XzZuIb7gxaCXj6P/dk66BrNHL0p293weaQOQwAquJnW6X+sb5YLnenbnb2pHwlwag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(2906002)(6666004)(36756003)(4326008)(86362001)(83380400001)(336012)(8676002)(5660300002)(70206006)(70586007)(40460700003)(186003)(316002)(8936002)(426003)(81166007)(36860700001)(44832011)(54906003)(16526019)(6916009)(26005)(2616005)(508600001)(356005)(82310400005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:20.4912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776b9386-db52-4864-e814-08da3525f768
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
Code clean up in dc.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 15 +++++++++------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  1 -
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e41a48f596a3..f14449401188 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2901,14 +2901,15 @@ static void commit_planes_for_stream(struct dc *dc,
 						top_pipe_to_program->stream_res.tg);
 		}
 
-	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
+	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		dc->hwss.interdependent_update_lock(dc, context, true);
-	else
+	} else {
 		/* Lock the top pipe while updating plane addrs, since freesync requires
 		 *  plane addr update event triggers to be synchronized.
 		 *  top_pipe_to_program is expected to never be NULL
 		 */
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
+	}
 
 	// Stream updates
 	if (stream_update)
@@ -2924,10 +2925,11 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (dc->hwss.program_front_end_for_ctx)
 			dc->hwss.program_front_end_for_ctx(dc, context);
 
-		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
+		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 			dc->hwss.interdependent_update_lock(dc, context, false);
-		else
+		} else {
 			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+		}
 		dc->hwss.post_unlock_program_front_end(dc, context);
 		return;
 	}
@@ -3052,10 +3054,11 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	}
 
-	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
+	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		dc->hwss.interdependent_update_lock(dc, context, false);
-	else
+	} else {
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+	}
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e1f87bd72e4a..0da024912dbe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1773,7 +1773,6 @@ void dcn20_post_unlock_program_front_end(
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
 		if (pipe->plane_state && !pipe->top_pipe && pipe->update_flags.bits.enable) {
 			struct hubp *hubp = pipe->plane_res.hubp;
 			int j = 0;
-- 
2.25.1

