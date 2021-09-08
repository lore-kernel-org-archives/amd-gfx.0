Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B5C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D3B60724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5D3B60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBC16E1EC;
	Wed,  8 Sep 2021 14:55:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E1D26E1E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO14Dpy/kbrVUDmZo8yeOAsw5xAqcdhUXX31eLrXlxTODfSMPop9HgUIVMm6AlWPjf2FCamynWQGEpW/TkgztBhWuGeWz2gVzc0jfBdL54AotBMZfBda8Bvg9FZ2NAVvmS3sH5IOV4Ppi+UmxK3nt4G+6oDVRkrmwO/1wXpdDkJtq5BCmIi5x/MFlxUQWvBSfkqwEA4QUD1ehWlAuVzb12F0faG4+T4WZ42vZhDh97A2drOyD4K76amTlD5VnwKs9K0qqB6xv+8hrR9pzK7AJGRqnCexpFptlK9zKTvjaloxRXfV10qHMoT1UvCeSY8pzot2y04hQ8xm/wup85e80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=uaPnNgDDqFYJ9G3GBXZJvwVfmhNQVO2rzrGWAnojFeE=;
 b=M4hIOsym65girwJhPTTSl2pKXF+6bqKo/1waCQpXp14RCMx4UR/V1Q9K4cviPPFHFbkpunp+R9D5hSJYCAJ2inHVn70wxPc28vr/CbvwDzzV550AaMEwr3tp61zflZG9TNbOab3zEGyZEvFNKVMnokQNhPScKh49ga3uNDpOtgv/lqq9NWad/gFi7AtHKQcX1VkYFtYXCGMuvhCc89irdZ7AG61JE3rCjaoSB4P1X6Co1y1FA2+wYByFwsSlIs35TCA6AXOP7Rmg36F2QYRKUkUNAijBNND2Ybzs+WTm7kRNDx+LOkYZs1WsPN7H8I0aHxhJLz8/2lgTB2RrtQm5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaPnNgDDqFYJ9G3GBXZJvwVfmhNQVO2rzrGWAnojFeE=;
 b=lkBx5RMFnIUSKZseHDFEjI1B1B5MXNttqhG46m5e9IewzGQ1upx6BXTbN1yW54L5rQ5GRk0aB2S1UhOfALlx+HKELqXRDHPLr7oRltCuHEYtP1nYI28DhuEqkNesISMOqe+fWUN9Je3tvywVCaKHnl++djVw8f2yOBs5h4wfx24=
Received: from DS7PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:2a::13) by
 DM6PR12MB2748.namprd12.prod.outlook.com (2603:10b6:5:43::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 8 Sep 2021 14:55:00 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::b) by DS7PR06CA0013.outlook.office365.com
 (2603:10b6:8:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:00 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:58 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 20/33] drm/amd/display: Optimize bandwidth on following fast
 update
Date: Wed, 8 Sep 2021 10:54:11 -0400
Message-ID: <20210908145424.3311-21-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfdb0798-678d-4c61-75c1-08d972d8a1d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2748:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2748DA94BDFF59946EA5D98DE4D49@DM6PR12MB2748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrOh39vJ4HJ5fCYksaeAR/o6F0HgHFiJ/o72PCZ0u3S9QpQjKCapsHJHnbIKBNT/s2tDCUKrw4jh4mD0aSU4cem3/PshaoVrnjgioLbt4gjcTBR2Bmd9bcSVgSWXs/0MS3K7YxWwdzM8HZMzzuZ1iMVVfPewrJ9IgaXfcnllrPwx2bl0WC+y3e4oVFPYoSr6zGdXU5WxRw2awSdVfcAccozid05i7SYMCXyLd8Fdsgw/AHzBdDi6lfsXKOYZ1VtQvYTbgikHPBALeBMCC3tBESYE3aw0aBCVM94Iu/pcfhxs57ClKpk8XxqjxpDVI0Hh+AJLoUcYcRf5tuL4UrVHeA916w3vunS7dyTx+IegJpI+TgurGe1opOfEAkSGYLJ/REH+9jnCPo2lSxI3Vs5EG6PTbyNbD4GXAkhXwpf3W4SwnqGDGLB0kNF0ioB4h0lAha9A2CvFU1pb0/Xwrnnw7D1oTiI8zneNmLzybi4PEdhYkCZR8lZ+QKbEW1ujagp2uCP+nD6T6r44JYhnKjMKIhrDWrjStOtmHsS+KU8tJXfznldJjAbLyKiqaVF/Mpw6wM0hGj3JwzJWXrDLiBFETtAw9tfHQUw/Sa//rAc3qfLS74G/wHpG0Q+j1snjv86FnLMVC1Czgo4jxGarvuDnQfMcDLLzjXTaoe4j9PdA8wJjMepIdiS8VGDC7vK4xTSOhZU+YV1S2grm8Ekel0FSyTFTGeJJRbdw5EMLK1Gr5EM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(8676002)(6916009)(1076003)(15650500001)(2906002)(5660300002)(36860700001)(8936002)(83380400001)(356005)(478600001)(316002)(426003)(70586007)(6666004)(70206006)(54906003)(2616005)(82310400003)(81166007)(186003)(82740400003)(336012)(86362001)(44832011)(16526019)(47076005)(26005)(36756003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:00.1942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdb0798-678d-4c61-75c1-08d972d8a1d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The current call to optimize_bandwidth never occurs because flip is
always pending from the FULL and FAST updates.

[How]
Optimize on the following flip when it's a FAST update and we know we
aren't going to be modifying the clocks again.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f58d3956f3e2..822239b59a78 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1801,6 +1801,11 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 
 	post_surface_trace(dc);
 
+	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
+		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
+	else
+		TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
+
 	if (is_flip_pending_in_pipes(dc, context))
 		return;
 
@@ -2986,6 +2991,9 @@ void dc_commit_updates_for_stream(struct dc *dc,
 			if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
 				new_pipe->plane_state->force_full_update = true;
 		}
+	} else if (update_type == UPDATE_TYPE_FAST) {
+		/* Previous frame finished and HW is ready for optimization. */
+		dc_post_update_surfaces_to_stream(dc);
 	}
 
 
@@ -3042,15 +3050,6 @@ void dc_commit_updates_for_stream(struct dc *dc,
 				pipe_ctx->plane_state->force_full_update = false;
 		}
 	}
-	/*let's use current_state to update watermark etc*/
-	if (update_type >= UPDATE_TYPE_FULL) {
-		dc_post_update_surfaces_to_stream(dc);
-
-		if (dc_ctx->dce_version >= DCE_VERSION_MAX)
-			TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
-		else
-			TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
-	}
 
 	return;
 
-- 
2.25.1

