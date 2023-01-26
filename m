Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6762BC27C76
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F358F10E8C9;
	Thu, 26 Jan 2023 00:36:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D95210E8C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:36:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VojSfQgHbrHm/CVrd4ReaOTi8XSrmn2j+30I7CwqJscVuj7wF9GAzuAQNDvmS/M/xwv5BQliJybPDBeczEGopvqgNhkZezo8a5fCYS+wgOgHQr26Hsjb0sVGzQ3yC0i4N1dSUDBI1EgCq4+X0zc1SZq9pq36FeRq38Gl7s+MyPMabg550frcxLf/04WLxMefcKAeu9jtEI48xEIdLEOVSUr9UgJ2TWajQUpa3U9GmvzZWrzKDFmtBm5kQyi/GIm1vqXzNGl0YW7WjdC3ZkVHZuz3X+8It0T+5oodX/RYe776O9cMmETKfY9YcQH3neVGjWEWCOEr+xcda9nnxRc20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loe5OTgv5naWr4dUdUBsU63Jytl684yb5dkwS05Fpdk=;
 b=bMNjUAyP7W/pW+0kCwxw9wO8TNIvZS7hK/4+Pja9DsmOiN4Ds+ZEvBZVng5sViK0x/Fpe/S7k91amsIOVd7SjPv5Bc4m6igzPRXN3zTD7Wg2GA9M7QAmdvwbWzoLfIpLSOCBhNdmMFQ9lAakxwdM334iV18mx3JvcU3dxAextvt/MUy4cWJUxce5BNebSuMg8HOQWHKl8N07ltYEO0TzG++1Jw0N3sgSw+p+y27jb7oQIw08jGpTMtwfnDdJPTt56zr9i1yIMKutIS0WyStv46Rr12Mz/XkaKqFMAujhI9R1I+3+JJaqdiOdQrgCLU7x8q5RJlDy8KFXSjy9mZ2caQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loe5OTgv5naWr4dUdUBsU63Jytl684yb5dkwS05Fpdk=;
 b=zKYAtK4mTtWLDuBCVZGA6wJDF1wnDf/5X8Dz4ZOTfod8Cw1Xw9tjqMjtLv7vFqpqNY3NNpkhRkr8dHD0Z7hYX2No7ei3sqs3xHXiDrP06h142EpDzj0ND3d3/L6lNU8Z/bxMUGyAnseelcrxA3jV73iqlh4AdpR4X42lsf4vb8U=
Received: from DS7PR05CA0012.namprd05.prod.outlook.com (2603:10b6:5:3b9::17)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:35:59 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::68) by DS7PR05CA0012.outlook.office365.com
 (2603:10b6:5:3b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20 via Frontend
 Transport; Thu, 26 Jan 2023 00:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 26 Jan 2023 00:35:59 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:35:56 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Revert "avoid disable otg when dig was
 disabled"
Date: Wed, 25 Jan 2023 17:32:25 -0700
Message-ID: <20230126003230.4178466-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: a488af1c-0dfa-4aac-5506-08daff354b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZM3d+x04FyCPhYQzMw17dHiAdJCtJ4h4byhRrZ1ssjVbpkPCKQ3Z4xsJ8y46lG+MKALQOCC3jZWwsdRhrmjZ7L2l7RFGS2HCAQU4QcczvPErCcbi5DoFuk2/yY/VdqCDIgc529djd0gpFGGB+zYFvUg7cFId7I/TQgFRx+GQfe5Vo3j8pNrt4QKe/RM+lHyGMrDVP9MmvjLcXCJI5mOwXTlUO3A+XjH5W/t4Uf1qQ+5JG8Eb3NacoNHeMazgnX/P+QjWUsKRZMzRDJCqO/VTpZ5EfC9JpM4Wv0SoV0uaU4742SVxE9EoVqc7eJVIEpRhatfk2nNWafMyfoFjMMTZKOaDkZDN+rKDqfgjfHHUloeM1EFifdoHF2f2lvGDWpNjoNFpZpIlHWU5Hq+pEZhc3DjTT6HRYWDKbC4CUrFs69fq3zSSVrwOkbg7EurBk2vmsmX6qDXb/FJ3aWzZXZbz/+XUjWebRVCIWkQ0kMr8UDdDv3gcrjZ0GUxJBit2NrpOxxfqb1jHfEU+YekKpwjCafdDldhcbz2/e2PvEx1R5KC5JnvkOJXpT3ZxNts+/g1BPRC9fX7HsxAj8IGb/+WQsO9YivlFU3+r5Cyt7VxzI4ocsO2GqOQgGpwWVtaGR5e/wyUsfrenoVM5OjgO1cx6eZ2+7h8VBaD1YYsf4cIBRFHKPIPeGTkhDJGzo5q6oMGTQ2eonfwH0XsP3gPHhl8y9WQBz1B8rNsBXOumyGEjoc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(426003)(86362001)(316002)(478600001)(54906003)(40460700003)(36756003)(7696005)(336012)(40480700001)(81166007)(82740400003)(83380400001)(356005)(47076005)(82310400005)(1076003)(186003)(70586007)(5660300002)(26005)(70206006)(44832011)(36860700001)(2906002)(4326008)(6666004)(16526019)(2616005)(6916009)(41300700001)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:35:59.0813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a488af1c-0dfa-4aac-5506-08daff354b83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This reverts commit 82dca8576d14f3dcb775b3be5f1bbb5df9a682ac.

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 26 +++++--------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 8c368bcc8e7e..43d1f38b94ce 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -87,16 +87,6 @@ static int dcn315_get_active_display_cnt_wa(
 	return display_count;
 }
 
-bool should_disable_otg(struct pipe_ctx *pipe)
-{
-	bool ret = true;
-
-	if (pipe->stream->link->link_enc && pipe->stream->link->link_enc->funcs->is_dig_enabled &&
-			pipe->stream->link->link_enc->funcs->is_dig_enabled(pipe->stream->link->link_enc))
-		ret = false;
-	return ret;
-}
-
 static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
@@ -108,16 +98,12 @@ static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
-					dc_is_virtual_signal(pipe->stream->signal))) {
-
-			/* This w/a should not trigger when we have a dig active */
-			if (should_disable_otg(pipe)) {
-				if (disable) {
-					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
-					reset_sync_context_for_pipe(dc, context, i);
-				} else
-					pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
-			}
+				     dc_is_virtual_signal(pipe->stream->signal))) {
+			if (disable) {
+				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+				reset_sync_context_for_pipe(dc, context, i);
+			} else
+				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
 		}
 	}
 }
-- 
2.39.1

