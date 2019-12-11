Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A161C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D158F2077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QUGNWVln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D158F2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74F2F6EB89;
	Wed, 11 Dec 2019 15:34:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586886EB89
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp9NHlliOHYjALDTYOAqI402YW7p6ib63+vZtZhcI3w3ozyr0fe0Pexn467zm3p4Ifq92hjmYQXLWBRCgZevlSRX9mZdgJ4RgUfGaJZBPlHP4zliSbDxzwH2D9i4uhp9WlWTNTssOIBfyHpDnDddaDpt6p5A6NPXWbOYNCWaqFi03zRTf9/0uPikbtM32qivnZ/KoPNXejdV0Cvod7+Zxk8pCBS8vjdwDwzqJEJSASDP+gmt4eDl9wTNHNFX1JUzfqIjpxLNULSgisdJRfsxFyUMDdAy7KvUE6bskHgu2B/Cm77MJbD0vcpbm7XLejH6Y1YopsjYk2kNChhWkgR8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6E44/jIEuz2II28TlRdVlYwO++kZMkrrSwLp2RZPIo=;
 b=i9SztPobQbO0IpJIPboVLRNg57b9lgGZSuTfFHKrLwQXfpPA2QURWpvO5nQQwaK6GJgY1pYNCPzSpmKRKT+tPVx4XGlR5TBdT/L+nix/ZAjBwAm0Cq4689Hr4x7TQ6Qf9lJfFmbRm1K2TXls+VF6i3mzEde9Xtxm7Mw77YVnJrewRv9ce9oXx5zvQDOhj9byV0SxxqAnyJxMUKO4Y5Rrc7ucgW+jS9q7PoQa4CucJt0uzweE5CAeewBKIFNoCIAhuEesaReaaXkRaRBrlLtJvs2bRGzfcjCErNuiM3lw0RR8wBPWIb5MmTVCEbQa0lO50uSVndPCG3HtyP8f4k1+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6E44/jIEuz2II28TlRdVlYwO++kZMkrrSwLp2RZPIo=;
 b=QUGNWVlnjQN5CbX8NDwEiaxsnU3/1UBCJXH5I67hpRiPVLVilvCObRqunR7Hpv88tv25vqPM+2BPkeBNQ3lMWfH6Ed7rWxHTlyJWO/VL9AfTW5YD7QKcONDzRaEs/CENrqIzcmNSTsZWqqavgU4V93WSIFHROZgyilURVZItH8E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:34:16 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:34:16 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/39] drm/amd/display: Lower DPP DTO only when safe
Date: Wed, 11 Dec 2019 10:32:49 -0500
Message-Id: <20191211153253.2291112-36-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58e0bc54-9a8b-4a1c-8030-08d77e4f83dc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491976798968908394219E5985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(6666004)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2ftCTWCu9c7NeVfuGlOtBVryJFF3Y/TXoKb/9SE7y7zUSz9Yit3BrSWyV7JA0cpaiv9GYwGjHGJFv16W0xnAuT435HurjVZegCX6x3CPaibUjb3XikT2HQ3aXsBity31pmtRrY0geJgDO0K+AmjB8wWKCA2NBmgjpu18igoao/PqXTUbxiu6VXcRufZawHtw5g7buCdOmOcvFcJ6vcXQ5yPGaYsfKZaLKRTfPYKfaNFbswQnWWf/13uL2BzaGW53V1zMQoy2rUd86NbFVcYXziQ/V1+U9m0ZB2iTtGv4d8Wsq0Pmbzdk1Aj8kya4NLigbBg9JdodcVQtH1b7zQq8exwCoPm+9DfaoGgBGvdpv83rF72Ld6MH692ndiWe4Kh2yY9Wu4apxWPfFzobImYH1o/WER4juAM3UXUY+vh1QJcWTpKA2DxoHwvwfmA7n7W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e0bc54-9a8b-4a1c-8030-08d77e4f83dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:47.7935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mo2aR8Cm4s455i3kTCQfvQOSWdGuCszCBxXTedIysOPY9BEc4lEAZS14gf3tX9ETMuBmLRc9Y7/X+A0e3Vuv9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sung Lee <sung.lee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]
A corner case currently exists where DPP DTO is lowered before
pipes are updated to a higher viewport. This causes underflow
as the DPPCLK is too low for the current viewport.

[How]
Only lower DPP DTO when it is safe to lower, or if
the newer clocks are higher than the current ones.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 16 ++++++++++------
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h |  2 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c    |  8 ++++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 3ae1d23f7342..495f01e9f2ca 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -101,13 +101,13 @@ uint32_t dentist_get_did_from_divider(int divider)
 }
 
 void dcn20_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
-		struct dc_state *context)
+		struct dc_state *context, bool safe_to_lower)
 {
 	int i;
 
 	clk_mgr->dccg->ref_dppclk = clk_mgr->base.clks.dppclk_khz;
 	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
-		int dpp_inst, dppclk_khz;
+		int dpp_inst, dppclk_khz, prev_dppclk_khz;
 
 		/* Loop index will match dpp->inst if resource exists,
 		 * and we want to avoid dependency on dpp object
@@ -115,8 +115,12 @@ void dcn20_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		dpp_inst = i;
 		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
 
-		clk_mgr->dccg->funcs->update_dpp_dto(
-				clk_mgr->dccg, dpp_inst, dppclk_khz);
+		prev_dppclk_khz = clk_mgr->base.ctx->dc->current_state->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
+
+		if (safe_to_lower || prev_dppclk_khz < dppclk_khz) {
+			clk_mgr->dccg->funcs->update_dpp_dto(
+							clk_mgr->dccg, dpp_inst, dppclk_khz);
+		}
 	}
 }
 
@@ -244,7 +248,7 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
 		if (dpp_clock_lowered) {
 			// if clock is being lowered, increase DTO before lowering refclk
-			dcn20_update_clocks_update_dpp_dto(clk_mgr, context);
+			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 			dcn20_update_clocks_update_dentist(clk_mgr);
 		} else {
 			// if clock is being raised, increase refclk before lowering DTO
@@ -252,7 +256,7 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 				dcn20_update_clocks_update_dentist(clk_mgr);
 			// always update dtos unless clock is lowered and not safe to lower
 			if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
-				dcn20_update_clocks_update_dpp_dto(clk_mgr, context);
+				dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h
index b64a4e9d71d7..0b9c045b0c8e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h
@@ -34,7 +34,7 @@ void dcn2_update_clocks_fpga(struct clk_mgr *clk_mgr,
 			struct dc_state *context,
 			bool safe_to_lower);
 void dcn20_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
-		struct dc_state *context);
+		struct dc_state *context, bool safe_to_lower);
 
 void dcn2_init_clocks(struct clk_mgr *clk_mgr);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index de51ef12e33a..b02b4dc554a4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -164,16 +164,16 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (dpp_clock_lowered) {
-		// if clock is being lowered, increase DTO before lowering refclk
-		dcn20_update_clocks_update_dpp_dto(clk_mgr, context);
+		// increase per DPP DTO before lowering global dppclk
+		dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 		rn_vbios_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 	} else {
-		// if clock is being raised, increase refclk before lowering DTO
+		// increase global DPPCLK before lowering per DPP DTO
 		if (update_dppclk || update_dispclk)
 			rn_vbios_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 		// always update dtos unless clock is lowered and not safe to lower
 		if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
-			dcn20_update_clocks_update_dpp_dto(clk_mgr, context);
+			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 	}
 
 	if (update_dispclk &&
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
