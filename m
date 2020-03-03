Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B96C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A45220716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cIOIllLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A45220716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEA46E980;
	Tue,  3 Mar 2020 23:27:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361CB6E980
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fABL7Z8HTVEGpXPUtIm6kcsqALxgAuXSArxns5EAzFDbfjjvsJN8CPEzTWfkOQTMLlITXbOGd1vnyd6yA8gD4KtJbrjV7/C3/AoZ6sxk9n/2S5NrxnYYSwvfD3COLFkTZU/m15X9RngsjG2dDuWQuVcWHqO5bo1bt1KcVJp3gpasLtz1TCrTp7q6vg2eIrLTF5AKIDnBDASDp/Ce5mR2pao6faNcHxIDudpWzh67709z4/c3BAR5ApI/c77o6riU0cvp9BQwT+VO+rVojfuHGP2D6f8jK6eThZCNWG5tNCyDZlOnYeMhU0REecKdEhvr68uwUEmw9HbHnMkdE2NqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IiqW0ES3P6N7AUlXP5f7asZ8qsFXxSdbaoNV8ex4qw=;
 b=VifIUslDhlRj9kVFS+Wpi2B0B+Z9nNH35Q2QgA/IhhSyQttuveOnBv3zWmDQIAmltUML9rkZI03WFx0BExTKnoxb//VQCrHoyWEnm3Jfvd4UywSoGdzkWO1fIFhjurjp9qpNgJvbqsBPWJ4UyTwuoXfc2DSYK1FGXPYEAhQRPjoT0UXX2p3tf4gda1gZ5QoiuOqTgCC7b2AaxtCP0XmhhH28eveM36tfhOHkoYoKJSKl2yUM88x9UumKSOdP7HSnXebT56Wj1uxku0p/iuO4JcyDTh+NW2YiN0sWzmVYzIK35zPWkFL4GVUezBBJG1gdDKlwlyfr6UTT9iQdHU0KRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IiqW0ES3P6N7AUlXP5f7asZ8qsFXxSdbaoNV8ex4qw=;
 b=cIOIllLMQx1Olfz5bkk/qf4FXiNGiSgHiCDubYcf5yVc7U0afMmKIAOAXxP0+JsflRJxTAiqOnCLxsjUAzaMWqnXXlGOUBnZjCGHjxsbnLMESV+KNH0PIU4xZQwDLr7W/nB/MaAcodW4Ug1v6m7p5abb5h3+5ceeBjSMvuca1AY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 23:27:38 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:38 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/12] drm/amd/display: Not check wm and clk change flag in
 optimized bandwidth.
Date: Tue,  3 Mar 2020 18:27:11 -0500
Message-Id: <20200303232718.351364-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:37 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85a1deff-b6c5-4bcf-0572-08d7bfca7611
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2441430AA9EC392416CECD3E98E40@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(36756003)(6486002)(8936002)(54906003)(52116002)(7696005)(81166006)(81156014)(316002)(4326008)(6916009)(5660300002)(186003)(66476007)(956004)(66946007)(1076003)(478600001)(86362001)(2616005)(8676002)(6666004)(66556008)(26005)(16526019)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2441;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GovgqK2SJA7BeC00YS3Odeu/+mSxXRC40FJ7CT3rCGyAlAUQN2Q7HtL/msqEurdhYrDJJpiATL0QxcNq80BhnZ1D31GLvosIAG9bNWKmEubpDbxyGOFOx/KUQoMjRw/5Lk/3eunbgvPNJDHEEl9rhpD5dvI/kDxYYPrEKOdcHfv6zrmFf+kgsXd9Vb/2gzbbqc2Ma7Whu/D5Elr1QaQD0fe6vhlEVan1EII2kIG41YAIeJMvDzWgJTquiEjmPPvghHKV5CcyZigs+/0dxLwT6Xosiqa5/5wm7yu38CiSMa62Kecyxp24mUKRyslY5IFy+O/0CjkaEonG7XjY8Z1LFpp6+GmHOpeaNPxHxNnILLBSxv9jvjJRuMdeBnqhCGJVJd6bzpjTuuYMk3pC25EAekUhLD07HOFQ8r3dXYPNAmYDnmJJa8D/wEYpzR5H9QWW
X-MS-Exchange-AntiSpam-MessageData: USbN4MnWwBznqge1tVXS3ytTQ0vIvrrxQn7y/5STyj/PidL4TzZp0NzdWTcsEtO/Py8sAAmC8AMXNSLuwNJjMZEjxe6qvkIwwd2UUL5nTKLyty/0cvk7PMVi5aAKwHu5iXyU2/rRgfqrfWzvHSaVvw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a1deff-b6c5-4bcf-0572-08d7bfca7611
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:38.3659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cKG1KtnFkrGUJ7jrXmkeZLUU+QIxJxu1rPrCqwvI8pLESJHcIUIaupn85LN2PFE9d5w5hWE+bt53CTRNY0gvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Rodrigo.Siqueira@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
System isn't able to enter S0i3 due to not send display count 0 to smu.
When dpms off, clk changed flag is cleared alreay, and it is checked
when doing optimized bandwidth, and update clocks is bypassed due to the
flag is unset.

[How]
Remove check flag incide the function since watermark values and clocks
values are checked during update to determine whether to perform it, no
need to check it again outside the function.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 28 ++++++-------------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 26 +++++++----------
 3 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6dece1ee30bf..df285f57fe92 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1378,6 +1378,10 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 		}
 
 	dc->hwss.optimize_bandwidth(dc, context);
+
+	dc->clk_optimized_required = false;
+	dc->wm_optimized_required = false;
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 385250e1e3fd..21c7c1b010ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2717,30 +2717,20 @@ void dcn10_optimize_bandwidth(
 		hws->funcs.verify_allow_pstate_change_high(dc);
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		if (context->stream_count == 0) {
+		if (context->stream_count == 0)
 			context->bw_ctx.bw.dcn.clk.phyclk_khz = 0;
 
-			dc->clk_mgr->funcs->update_clocks(
-					dc->clk_mgr,
-					context,
-					true);
-		} else if (dc->clk_optimized_required || IS_DIAG_DC(dc->ctx->dce_environment)) {
-			dc->clk_mgr->funcs->update_clocks(
-								dc->clk_mgr,
-								context,
-								true);
-		}
-	}
-
-	if (dc->wm_optimized_required || IS_DIAG_DC(dc->ctx->dce_environment)) {
-		hubbub->funcs->program_watermarks(hubbub,
-				&context->bw_ctx.bw.dcn.watermarks,
-				dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
+		dc->clk_mgr->funcs->update_clocks(
+				dc->clk_mgr,
+				context,
 				true);
 	}
 
-	dc->clk_optimized_required = false;
-	dc->wm_optimized_required = false;
+	hubbub->funcs->program_watermarks(hubbub,
+			&context->bw_ctx.bw.dcn.watermarks,
+			dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
+			true);
+
 	dcn10_stereo_hw_frame_pack_wa(dc, context);
 
 	if (dc->debug.pplib_wm_report_mode == WM_REPORT_OVERRIDE)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 045ba08c85b4..b0f61bd7c208 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1660,22 +1660,16 @@ void dcn20_optimize_bandwidth(
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 
-	if (dc->wm_optimized_required || IS_DIAG_DC(dc->ctx->dce_environment)) {
-		/* program dchubbub watermarks */
-		hubbub->funcs->program_watermarks(hubbub,
-						&context->bw_ctx.bw.dcn.watermarks,
-						dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
-						true);
-		dc->wm_optimized_required = false;
-	}
-
-	if (dc->clk_optimized_required || IS_DIAG_DC(dc->ctx->dce_environment)) {
-		dc->clk_mgr->funcs->update_clocks(
-				dc->clk_mgr,
-				context,
-				true);
-		dc->clk_optimized_required = false;
-	}
+	/* program dchubbub watermarks */
+	hubbub->funcs->program_watermarks(hubbub,
+					&context->bw_ctx.bw.dcn.watermarks,
+					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
+					true);
+
+	dc->clk_mgr->funcs->update_clocks(
+			dc->clk_mgr,
+			context,
+			true);
 }
 
 bool dcn20_update_bandwidth(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
