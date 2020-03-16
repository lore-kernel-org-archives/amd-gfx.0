Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB53C3F2CE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60FA20663
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pzCfWSrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60FA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C7FE6E479;
	Mon, 16 Mar 2020 13:50:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F07D6E479
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7vPltmLj7ypa7ZL8BEwEaBBltAFn1umgOi9Cd/OZQoY595JfyZ90oZiAEI2qVqB2aFcLBocmGeSOQz2wAf+2rEsISXrzjpOVp6pgJWgs1gIIPkk2efYJYtWR+8JqeJlHHNnUDGF1l+1g3P4hfJUauOwPnzy9JJx9csPd3/79qEivqLM8FLvUynducjFW/fseerOg9y/yAYS2MuCn8uY/L5quJXC/2PySJEFo+3x1RsDBNC6D13C8C25GicoOeeBudaKSnLPX9GSNN4BX45D/vWyJfjuxJr5BXMPNL3/ggqNYJ578VCFzodsWG+V/hWibR+gTPyZTyWUmg11hL4ZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pxdG8b4isjj1nprkixLdDCLcYZ8ORBQ5P+bvwABL4M=;
 b=jxyl/leofNBBdJTjAq5y5uCciKWAYHtZZ2iSaOiFByZ3wUdFEPfeSjiU4/dco7sLDCu1hFIt2ItVmqDIDNzxsfv8Ip7xjXobgDu5gZXjrX1P6J8++ScRpaKy+6mOfT2KUgM9TuOErD4FG8VUnlKh0hLVQSYTe0W+xxXhVCdUAv5ERoutUAiD0Y7co5aJSiKSnsDXsgD6ClH0Br69nXmcwokDdzAvD+jz3aP/TrNk4k9TeEh9HEfWOq1YFVtnGD87jyupFBYGQXWm1/1YIoHiP2Yx6pv5//evmcZ4XfscpDrTFjwmSHMKLS4yDdPmoX1MyX+rxerGh58CnaitkzUtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pxdG8b4isjj1nprkixLdDCLcYZ8ORBQ5P+bvwABL4M=;
 b=pzCfWSrElWR0uhLJRDdyrdVXUv8yPZf6bbwy6c9GKS2/q5xtUGTXX3NFN28cwgH6VZiH7fTed3RD818neV6DfQtBiVmDHvbR+N/PRUxWCwaqdxm4O0W+ogPcgUQPTAnNPazpef4tbGRX++uIHnMUz4EJ3aoim1LJbA9bVFOvDeo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:09 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:09 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/19] drm/amd/display: combine watermark change and clock
 change for update clocks.
Date: Mon, 16 Mar 2020 09:49:16 -0400
Message-Id: <20200316134920.2526155-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:08 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af45bcee-9b0c-408a-2e10-08d7c9b0f0b1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23961F021E628EAEAD16846F98F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:182;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(15650500001)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNvNqkORTtCISGljK42RuYJHw5A43iA4eStnBtk9S3qCT3m4HLzuJkOInM8yCLcsfxqmH3caCSJb87XaxXBzDy9E3Mh8NeAf2Ko3Y+wnrA4D9IuoC5EDK/fraWGl0brYsEjhWWECW7u04T+/ftGf1aG6kSafBZ9boDbSUDNIQKnrNs1XkitPnLbCY8Yz6gUT9YA+oC5NHJGWBxFB9QXbWWuv9UHzYI0T2t8DPeIHId3BVt29yQNRibELYWz4CCHSqyMmmO2fSafDM8yqnnO4xz1pZzj5GfqVgVDuJzNQ7mcI2BIS5/HNvNUMNLdf/OPBZkNejB6EsiHphyBP0RZx3D5iyboZWI//95xhYRPNhooC2pcO0pNp5p69SptvumFTjIdO1HucKRVM7BqPh4CDJ4goumlZV4P6kEhrpWyJ3GydkAz22BoqOAbPzr1eDCEF
X-MS-Exchange-AntiSpam-MessageData: JT31h1I22x+xL6+pPpWwumlICZHDKqN8t1/3Xy5YDtK7/3z6RSsuU3RT4tACgtzk0jgjcLnP1LzLo/+V+hyNBrCb+skkFaxEyaDi6tcSLdgLxxzjWZ8OZ8QWpnoytea3tyjcvESZp3WJMsujj0XLRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af45bcee-9b0c-408a-2e10-08d7c9b0f0b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:08.8833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xsyO3Cx9ItQ3BEE7B/gmQ00sp2YX9/Z/jFdX23SYhGAE43BuPM6not0VBPWmeCxV3Rg++SqM4A4kfZxSy7uDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Eric Yang <eric.yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
underflow happened when playing video on 1366x768 + 4K clone mode due to
incorrect handle watermark change flag and lower down clocks to early.

[How]
Check watermark change flag when decide doing optimized, and check
optimized required flag to do clock update.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c            | 13 +++++++------
 drivers/gpu/drm/amd/display/dc/dc.h                 |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c   |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 137180ad6a25..2ffb22177df9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1365,7 +1365,7 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 	int i;
 	struct dc_state *context = dc->current_state;
 
-	if ((!dc->clk_optimized_required && !dc->wm_optimized_required) || dc->optimize_seamless_boot_streams > 0)
+	if ((!dc->optimized_required) || dc->optimize_seamless_boot_streams > 0)
 		return true;
 
 	post_surface_trace(dc);
@@ -1379,7 +1379,7 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 
 	dc->hwss.optimize_bandwidth(dc, context);
 
-	dc->clk_optimized_required = false;
+	dc->optimized_required = false;
 	dc->wm_optimized_required = false;
 
 	return true;
@@ -1828,11 +1828,12 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 		// If there's an available clock comparator, we use that.
 		if (dc->clk_mgr->funcs->are_clock_states_equal) {
 			if (!dc->clk_mgr->funcs->are_clock_states_equal(&dc->clk_mgr->clks, &dc->current_state->bw_ctx.bw.dcn.clk))
-				dc->clk_optimized_required = true;
+				dc->optimized_required = true;
 		// Else we fallback to mem compare.
 		} else if (memcmp(&dc->current_state->bw_ctx.bw.dcn.clk, &dc->clk_mgr->clks, offsetof(struct dc_clocks, prev_p_state_change_support)) != 0) {
-			dc->clk_optimized_required = true;
-		}
+			dc->optimized_required = true;
+		} else if (dc->wm_optimized_required)
+			dc->optimized_required = true;
 	}
 
 	return type;
@@ -2204,7 +2205,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			dc->optimize_seamless_boot_streams--;
 
 			if (dc->optimize_seamless_boot_streams == 0)
-				dc->clk_optimized_required = true;
+				dc->optimized_required = true;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6cfb534e56bc..d3ceb39e428e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -521,7 +521,7 @@ struct dc {
 	struct dce_hwseq *hwseq;
 
 	/* Require to optimize clocks and bandwidth for added/removed planes */
-	bool clk_optimized_required;
+	bool optimized_required;
 	bool wm_optimized_required;
 
 	/* Require to maintain clocks and bandwidth for UEFI enabled HW */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index dad732bb34d5..9cc3314966bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1048,7 +1048,7 @@ void dcn10_plane_atomic_disconnect(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	if (opp != NULL)
 		opp->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_inst] = true;
 
-	dc->clk_optimized_required = true;
+	dc->optimized_required = true;
 
 	if (hubp->funcs->hubp_disconnect)
 		hubp->funcs->hubp_disconnect(hubp);
@@ -1099,7 +1099,7 @@ void dcn10_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 				false);
 
 	hubp->power_gated = true;
-	dc->clk_optimized_required = false; /* We're powering off, no need to optimize */
+	dc->optimized_required = false; /* We're powering off, no need to optimize */
 
 	hws->funcs.plane_atomic_power_down(dc,
 			pipe_ctx->plane_res.dpp,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
